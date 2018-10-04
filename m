Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE6BC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:07:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1522084D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="jcW1m8J3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1522084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QtTs2PB9zF3KS
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 23:07:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="jcW1m8J3";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qrvj4pQ3zF3Jp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 21:56:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="jcW1m8J3"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Qrvj0pqTzB4N4; Thu,  4 Oct 2018 21:56:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Qrvg6vj9zB4Ml;
 Thu,  4 Oct 2018 21:56:31 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538654192; bh=yv3kRAyoaXozLnYQRUm/MzxirCxUmk2zVwIibjCxjJE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jcW1m8J3x0buWq6ix7uz/lIQu3VQ7q/qq0HkpASRimyUv2t+r5ZnvPBxLjEAbNAN6
 Ps+T+pRpUpuoUaAK8XHWOjEpZJcJqVqhAQIhoFIJA6t5VdZSOszy5sBfSG0dP9WZwx
 2r7Wl5SXzNd0qZgkudnaCoZno6Ib1NfNUHSou72yy8IkFeY7m/+0sgEYHTsYiQOqRU
 I4coV0Unb1+O01s2xr43WYnw56ThvVgILV+MiMaLYfR/eJWIaS+Jcz+lPX2UaiY8gt
 8kCFey8IO+v7gqtCc7DJOVRJldRNcuqlm0UE56YIagehZuuySgHTbtupxY84DngmkU
 gYdN6HJePkpqg==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v4 23/32] KVM: PPC: Book3S HV: Implement H_TLB_INVALIDATE hcall
Date: Thu,  4 Oct 2018 21:56:00 +1000
Message-Id: <1538654169-15602-24-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

When running a nested (L2) guest the guest (L1) hypervisor will use
the H_TLB_INVALIDATE hcall when it needs to change the partition
scoped page tables or the partition table which it manages.  It will
use this hcall in the situations where it would use a partition-scoped
tlbie instruction if it were running in hypervisor mode.

The H_TLB_INVALIDATE hcall can invalidate different scopes:

Invalidate TLB for a given target address:
- This invalidates a single L2 -> L1 pte
- We need to invalidate any L2 -> L0 shadow_pgtable ptes which map the L2
  address space which is being invalidated. This is because a single
  L2 -> L1 pte may have been mapped with more than one pte in the
  L2 -> L0 page tables.

Invalidate the entire TLB for a given LPID or for all LPIDs:
- Invalidate the entire shadow_pgtable for a given nested guest, or
  for all nested guests.

Invalidate the PWC (page walk cache) for a given LPID or for all LPIDs:
- We don't cache the PWC, so nothing to do.

Invalidate the entire TLB, PWC and partition table for a given/all LPIDs:
- Here we re-read the partition table entry and remove the nested state
  for any nested guest for which the first doubleword of the partition
  table entry is now zero.

The H_TLB_INVALIDATE hcall takes as parameters the tlbie instruction
word (of which only the RIC, PRS and R fields are used), the rS value
(giving the lpid, where required) and the rB value (giving the IS, AP
and EPN values).

[paulus@ozlabs.org - adapted to having the partition table in guest
memory, added the H_TLB_INVALIDATE implementation, removed tlbie
instruction emulation, reworded the commit message.]

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  12 ++
 arch/powerpc/include/asm/kvm_book3s.h         |   1 +
 arch/powerpc/include/asm/ppc-opcode.h         |   1 +
 arch/powerpc/kvm/book3s_emulate.c             |   1 -
 arch/powerpc/kvm/book3s_hv.c                  |   3 +
 arch/powerpc/kvm/book3s_hv_nested.c           | 196 +++++++++++++++++++++++++-
 6 files changed, 212 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index b3520b5..66db23e 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -203,6 +203,18 @@ static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
 	BUG();
 }
 
+static inline unsigned int ap_to_shift(unsigned long ap)
+{
+	int psize;
+
+	for (psize = 0; psize < MMU_PAGE_COUNT; psize++) {
+		if (mmu_psize_defs[psize].ap == ap)
+			return mmu_psize_defs[psize].shift;
+	}
+
+	return -1;
+}
+
 static inline unsigned long get_sllp_encoding(int psize)
 {
 	unsigned long sllp;
diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index d7aeb6f..09f8e9b 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -301,6 +301,7 @@ long kvmhv_set_partition_table(struct kvm_vcpu *vcpu);
 void kvmhv_set_ptbl_entry(unsigned int lpid, u64 dw0, u64 dw1);
 void kvmhv_release_all_nested(struct kvm *kvm);
 long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu);
+long kvmhv_do_nested_tlbie(struct kvm_vcpu *vcpu);
 int kvmhv_run_single_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu,
 			  u64 time_limit, unsigned long lpcr);
 void kvmhv_save_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr);
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 665af14..6093bc8 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -104,6 +104,7 @@
 #define OP_31_XOP_LHZUX     311
 #define OP_31_XOP_MSGSNDP   142
 #define OP_31_XOP_MSGCLRP   174
+#define OP_31_XOP_TLBIE     306
 #define OP_31_XOP_MFSPR     339
 #define OP_31_XOP_LWAX      341
 #define OP_31_XOP_LHAX      343
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 2654df2..8c7e933 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -36,7 +36,6 @@
 #define OP_31_XOP_MTSR		210
 #define OP_31_XOP_MTSRIN	242
 #define OP_31_XOP_TLBIEL	274
-#define OP_31_XOP_TLBIE		306
 /* Opcode is officially reserved, reuse it as sc 1 when sc 1 doesn't trap */
 #define OP_31_XOP_FAKE_SC1	308
 #define OP_31_XOP_SLBMTE	402
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 2d8209a..ba58883 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -974,6 +974,9 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		break;
 	case H_TLB_INVALIDATE:
 		ret = H_FUNCTION;
+		if (!vcpu->kvm->arch.nested_enable)
+			break;
+		ret = kvmhv_do_nested_tlbie(vcpu);
 		break;
 
 	default:
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 3947aa5..26151e8 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -475,7 +475,7 @@ void kvmhv_release_all_nested(struct kvm *kvm)
 }
 
 /* caller must hold gp->tlb_lock */
-void kvmhv_flush_nested(struct kvm_nested_guest *gp)
+static void kvmhv_flush_nested(struct kvm_nested_guest *gp)
 {
 	struct kvm *kvm = gp->l1_host;
 
@@ -683,6 +683,200 @@ static bool kvmhv_invalidate_shadow_pte(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+static inline int get_ric(unsigned int instr)
+{
+	return (instr >> 18) & 0x3;
+}
+
+static inline int get_prs(unsigned int instr)
+{
+	return (instr >> 17) & 0x1;
+}
+
+static inline int get_r(unsigned int instr)
+{
+	return (instr >> 16) & 0x1;
+}
+
+static inline int get_lpid(unsigned long r_val)
+{
+	return r_val & 0xffffffff;
+}
+
+static inline int get_is(unsigned long r_val)
+{
+	return (r_val >> 10) & 0x3;
+}
+
+static inline int get_ap(unsigned long r_val)
+{
+	return (r_val >> 5) & 0x7;
+}
+
+static inline long get_epn(unsigned long r_val)
+{
+	return r_val >> 12;
+}
+
+static int kvmhv_emulate_tlbie_tlb_addr(struct kvm_vcpu *vcpu, int lpid,
+					int ap, long epn)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_nested_guest *gp;
+	long npages;
+	int shift;
+	unsigned long addr;
+
+	shift = ap_to_shift(ap);
+	addr = epn << 12;
+	if (shift < 0)
+		/* Invalid ap encoding */
+		return -EINVAL;
+
+	addr &= ~((1UL << shift) - 1);
+	npages = 1UL << (shift - PAGE_SHIFT);
+
+	gp = kvmhv_get_nested(kvm, lpid, false);
+	if (!gp) /* No such guest -> nothing to do */
+		return 0;
+	mutex_lock(&gp->tlb_lock);
+
+	/* There may be more than one host page backing this single guest pte */
+	do {
+		kvmhv_invalidate_shadow_pte(vcpu, gp, addr, &shift);
+
+		npages -= 1UL << (shift - PAGE_SHIFT);
+		addr += 1UL << shift;
+	} while (npages > 0);
+
+	mutex_unlock(&gp->tlb_lock);
+	kvmhv_put_nested(gp);
+	return 0;
+}
+
+static void kvmhv_emulate_tlbie_lpid(struct kvm_vcpu *vcpu,
+				     struct kvm_nested_guest *gp, int ric)
+{
+	struct kvm *kvm = vcpu->kvm;
+
+	mutex_lock(&gp->tlb_lock);
+	switch (ric) {
+	case 0:
+		/* Invalidate TLB */
+		spin_lock(&kvm->mmu_lock);
+		kvmppc_free_pgtable_radix(kvm, gp->shadow_pgtable,
+					  gp->shadow_lpid);
+		radix__flush_tlb_lpid(gp->shadow_lpid);
+		spin_unlock(&kvm->mmu_lock);
+		break;
+	case 1:
+		/*
+		 * Invalidate PWC
+		 * We don't cache this -> nothing to do
+		 */
+		break;
+	case 2:
+		/* Invalidate TLB, PWC and caching of partition table entries */
+		kvmhv_flush_nested(gp);
+		break;
+	default:
+		break;
+	}
+	mutex_unlock(&gp->tlb_lock);
+}
+
+static void kvmhv_emulate_tlbie_all_lpid(struct kvm_vcpu *vcpu, int ric)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_nested_guest *gp;
+	int i;
+
+	spin_lock(&kvm->mmu_lock);
+	for (i = 0; i <= kvm->arch.max_nested_lpid; i++) {
+		gp = kvm->arch.nested_guests[i];
+		if (gp) {
+			spin_unlock(&kvm->mmu_lock);
+			kvmhv_emulate_tlbie_lpid(vcpu, gp, ric);
+			spin_lock(&kvm->mmu_lock);
+		}
+	}
+	spin_unlock(&kvm->mmu_lock);
+}
+
+static int kvmhv_emulate_priv_tlbie(struct kvm_vcpu *vcpu, unsigned int instr,
+				    unsigned long rsval, unsigned long rbval)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_nested_guest *gp;
+	int r, ric, prs, is, ap;
+	int lpid;
+	long epn;
+	int ret = 0;
+
+	ric = get_ric(instr);
+	prs = get_prs(instr);
+	r = get_r(instr);
+	lpid = get_lpid(rsval);
+	is = get_is(rbval);
+
+	/*
+	 * These cases are invalid and are not handled:
+	 * r   != 1 -> Only radix supported
+	 * prs == 1 -> Not HV privileged
+	 * ric == 3 -> No cluster bombs for radix
+	 * is  == 1 -> Partition scoped translations not associated with pid
+	 * (!is) && (ric == 1 || ric == 2) -> Not supported by ISA
+	 */
+	if ((!r) || (prs) || (ric == 3) || (is == 1) ||
+	    ((!is) && (ric == 1 || ric == 2)))
+		return -EINVAL;
+
+	switch (is) {
+	case 0:
+		/*
+		 * We know ric == 0
+		 * Invalidate TLB for a given target address
+		 */
+		epn = get_epn(rbval);
+		ap = get_ap(rbval);
+		ret = kvmhv_emulate_tlbie_tlb_addr(vcpu, lpid, ap, epn);
+		break;
+	case 2:
+		/* Invalidate matching LPID */
+		gp = kvmhv_get_nested(kvm, lpid, false);
+		if (gp) {
+			kvmhv_emulate_tlbie_lpid(vcpu, gp, ric);
+			kvmhv_put_nested(gp);
+		}
+		break;
+	case 3:
+		/* Invalidate ALL LPIDs */
+		kvmhv_emulate_tlbie_all_lpid(vcpu, ric);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * This handles the H_TLB_INVALIDATE hcall.
+ * Parameters are (r4) tlbie instruction code, (r5) rS contents,
+ * (r6) rB contents.
+ */
+long kvmhv_do_nested_tlbie(struct kvm_vcpu *vcpu)
+{
+	int ret;
+
+	ret = kvmhv_emulate_priv_tlbie(vcpu, kvmppc_get_gpr(vcpu, 4),
+			kvmppc_get_gpr(vcpu, 5), kvmppc_get_gpr(vcpu, 6));
+	if (ret)
+		return H_PARAMETER;
+	return H_SUCCESS;
+}
+
 /* Used to convert a nested guest real address to a L1 guest real address */
 static int kvmhv_translate_addr_nested(struct kvm_vcpu *vcpu,
 				       struct kvm_nested_guest *gp,
-- 
2.7.4

