Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id AA993B710C
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:20 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 22/35] KVM: PPC: Implement correct SID mapping on Book3s_32
Date: Tue, 31 Aug 2010 04:32:03 +0200
Message-Id: <1283221937-21006-23-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Up until now we were doing segment mappings wrong on Book3s_32. For Book3s_64
we were using a trick where we know that a single mmu_context gives us 16 bits
of context ids.

The mm system on Book3s_32 instead uses a clever algorithm to distribute VSIDs
across the available range, so a context id really only gives us 16 available
VSIDs.

To keep at least a few guest processes in the SID shadow, let's map a number of
contexts that we can use as VSID pool. This makes the code be actually correct
and shouldn't hurt performance too much.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_book3s.h |   15 +++++++-
 arch/powerpc/kvm/book3s_32_mmu_host.c |   57 ++++++++++++++++++---------------
 arch/powerpc/kvm/book3s_64_mmu_host.c |    8 ++--
 3 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index be8aac2..d62e703 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -60,6 +60,13 @@ struct kvmppc_sid_map {
 #define SID_MAP_NUM     (1 << SID_MAP_BITS)
 #define SID_MAP_MASK    (SID_MAP_NUM - 1)
 
+#ifdef CONFIG_PPC_BOOK3S_64
+#define SID_CONTEXTS	1
+#else
+#define SID_CONTEXTS	128
+#define VSID_POOL_SIZE	(SID_CONTEXTS * 16)
+#endif
+
 struct kvmppc_vcpu_book3s {
 	struct kvm_vcpu vcpu;
 	struct kvmppc_book3s_shadow_vcpu *shadow_vcpu;
@@ -78,10 +85,14 @@ struct kvmppc_vcpu_book3s {
 	u64 sdr1;
 	u64 hior;
 	u64 msr_mask;
-	u64 vsid_first;
 	u64 vsid_next;
+#ifdef CONFIG_PPC_BOOK3S_32
+	u32 vsid_pool[VSID_POOL_SIZE];
+#else
+	u64 vsid_first;
 	u64 vsid_max;
-	int context_id;
+#endif
+	int context_id[SID_CONTEXTS];
 	ulong prog_flags; /* flags to inject when giving a 700 trap */
 };
 
diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
index 57dddeb..9fecbfb 100644
--- a/arch/powerpc/kvm/book3s_32_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
@@ -275,18 +275,15 @@ static struct kvmppc_sid_map *create_sid_map(struct kvm_vcpu *vcpu, u64 gvsid)
 	backwards_map = !backwards_map;
 
 	/* Uh-oh ... out of mappings. Let's flush! */
-	if (vcpu_book3s->vsid_next >= vcpu_book3s->vsid_max) {
-		vcpu_book3s->vsid_next = vcpu_book3s->vsid_first;
+	if (vcpu_book3s->vsid_next >= VSID_POOL_SIZE) {
+		vcpu_book3s->vsid_next = 0;
 		memset(vcpu_book3s->sid_map, 0,
 		       sizeof(struct kvmppc_sid_map) * SID_MAP_NUM);
 		kvmppc_mmu_pte_flush(vcpu, 0, 0);
 		kvmppc_mmu_flush_segments(vcpu);
 	}
-	map->host_vsid = vcpu_book3s->vsid_next;
-
-	/* Would have to be 111 to be completely aligned with the rest of
-	   Linux, but that is just way too little space! */
-	vcpu_book3s->vsid_next+=1;
+	map->host_vsid = vcpu_book3s->vsid_pool[vcpu_book3s->vsid_next];
+	vcpu_book3s->vsid_next++;
 
 	map->guest_vsid = gvsid;
 	map->valid = true;
@@ -333,40 +330,38 @@ void kvmppc_mmu_flush_segments(struct kvm_vcpu *vcpu)
 
 void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
 {
+	int i;
+
 	kvmppc_mmu_hpte_destroy(vcpu);
 	preempt_disable();
-	__destroy_context(to_book3s(vcpu)->context_id);
+	for (i = 0; i < SID_CONTEXTS; i++)
+		__destroy_context(to_book3s(vcpu)->context_id[i]);
 	preempt_enable();
 }
 
 /* From mm/mmu_context_hash32.c */
-#define CTX_TO_VSID(ctx) (((ctx) * (897 * 16)) & 0xffffff)
+#define CTX_TO_VSID(c, id)	((((c) * (897 * 16)) + (id * 0x111)) & 0xffffff)
 
 int kvmppc_mmu_init(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
 	int err;
 	ulong sdr1;
+	int i;
+	int j;
 
-	err = __init_new_context();
-	if (err < 0)
-		return -1;
-	vcpu3s->context_id = err;
-
-	vcpu3s->vsid_max = CTX_TO_VSID(vcpu3s->context_id + 1) - 1;
-	vcpu3s->vsid_first = CTX_TO_VSID(vcpu3s->context_id);
-
-#if 0 /* XXX still doesn't guarantee uniqueness */
-	/* We could collide with the Linux vsid space because the vsid
-	 * wraps around at 24 bits. We're safe if we do our own space
-	 * though, so let's always set the highest bit. */
+	for (i = 0; i < SID_CONTEXTS; i++) {
+		err = __init_new_context();
+		if (err < 0)
+			goto init_fail;
+		vcpu3s->context_id[i] = err;
 
-	vcpu3s->vsid_max |= 0x00800000;
-	vcpu3s->vsid_first |= 0x00800000;
-#endif
-	BUG_ON(vcpu3s->vsid_max < vcpu3s->vsid_first);
+		/* Remember context id for this combination */
+		for (j = 0; j < 16; j++)
+			vcpu3s->vsid_pool[(i * 16) + j] = CTX_TO_VSID(err, j);
+	}
 
-	vcpu3s->vsid_next = vcpu3s->vsid_first;
+	vcpu3s->vsid_next = 0;
 
 	/* Remember where the HTAB is */
 	asm ( "mfsdr1 %0" : "=r"(sdr1) );
@@ -376,4 +371,14 @@ int kvmppc_mmu_init(struct kvm_vcpu *vcpu)
 	kvmppc_mmu_hpte_init(vcpu);
 
 	return 0;
+
+init_fail:
+	for (j = 0; j < i; j++) {
+		if (!vcpu3s->context_id[j])
+			continue;
+
+		__destroy_context(to_book3s(vcpu)->context_id[j]);
+	}
+
+	return -1;
 }
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 4040c8d..fa2f084 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -286,7 +286,7 @@ void kvmppc_mmu_flush_segments(struct kvm_vcpu *vcpu)
 void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
 {
 	kvmppc_mmu_hpte_destroy(vcpu);
-	__destroy_context(to_book3s(vcpu)->context_id);
+	__destroy_context(to_book3s(vcpu)->context_id[0]);
 }
 
 int kvmppc_mmu_init(struct kvm_vcpu *vcpu)
@@ -297,10 +297,10 @@ int kvmppc_mmu_init(struct kvm_vcpu *vcpu)
 	err = __init_new_context();
 	if (err < 0)
 		return -1;
-	vcpu3s->context_id = err;
+	vcpu3s->context_id[0] = err;
 
-	vcpu3s->vsid_max = ((vcpu3s->context_id + 1) << USER_ESID_BITS) - 1;
-	vcpu3s->vsid_first = vcpu3s->context_id << USER_ESID_BITS;
+	vcpu3s->vsid_max = ((vcpu3s->context_id[0] + 1) << USER_ESID_BITS) - 1;
+	vcpu3s->vsid_first = vcpu3s->context_id[0] << USER_ESID_BITS;
 	vcpu3s->vsid_next = vcpu3s->vsid_first;
 
 	kvmppc_mmu_hpte_init(vcpu);
-- 
1.6.0.2
