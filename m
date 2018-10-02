Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B8CC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:38:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448B8204FD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="mRAaecpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448B8204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Pdwn0dXDzDrhR
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 22:38:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="mRAaecpz";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSW3B1mzF39x
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:32:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="mRAaecpz"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSW0hZMz9t2D; Tue,  2 Oct 2018 21:32:11 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcSV56bwz9t1Q;
 Tue,  2 Oct 2018 21:32:10 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479930; bh=nV5eVywvCEZNa6T4Aym+zJLeIB7d7EL5oRrgDQyKP6w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mRAaecpzXkQSnaKaMRyDwrIaq1OLJeLQu9Hnk1HtjeeIMIDVEPokU7WtP1AoHwXWl
 unDpqZUSUSU6EY9zyn5ChThKhGclu82nscF92ajE+FPAsJQiBXQ6LuxnspiO9YLG+3
 H/uqT8n/KOUAv6G+hhpy4ulUwWYZeX55WOx3L60UgAMCBqUoKRVCvzk6LExRZjErBt
 KIq/X/FILvjje6mRUUTDCwnaBKl84m+862ouX0azQ84IZGpEYAc0kQCgyFdq516Ajz
 Aw1Ywrt31DebANhwlj7X8VDi93PpyGXHgp/k6OB5TeKEQbvITNi4+CueG2r5GLWP2s
 XgxLcZGMM9ClQ==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 24/33] KVM: PPC: Book3S HV: Emulate Privileged TLBIE for
 guest hypervisors
Date: Tue,  2 Oct 2018 21:31:23 +1000
Message-Id: <1538479892-14835-25-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
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
hypervisor privileged tlb invalidation instructions (to manage the
partition scoped page tables) which will result in hypervisor
emulation assistance interrupts. We emulate these instructions on behalf
of the L1 guest.

The tlbie instruction can invalidate different scopes:

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
- We don't cache the PWC, so nothing to do

Invalidate the entire TLB, PWC and partition table for a given/all LPIDs:
- Here we re-read the partition table entry and remove the nested state
  for any nested guest for which the first doubleword of the partition
  table entry is now zero.

This also implements the H_TLB_INVALIDATE hcall.  It takes as parameters
the tlbie instruction word (of which the RIC, PRS and R fields are used),
the rS value (giving the lpid, where required) and the rB value (giving
the IS, AP and EPN values).

[paulus@ozlabs.org - adapted to having the partition table in guest
memory, added the H_TLB_INVALIDATE implementation.]

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  12 ++
 arch/powerpc/include/asm/kvm_book3s.h         |   1 +
 arch/powerpc/include/asm/ppc-opcode.h         |   1 +
 arch/powerpc/kvm/book3s_emulate.c             |   1 -
 arch/powerpc/kvm/book3s_hv.c                  |   3 +
 arch/powerpc/kvm/book3s_hv_nested.c           | 210 +++++++++++++++++++++++++-
 6 files changed, 225 insertions(+), 3 deletions(-)

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
index 1d2286d..210e550 100644
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
index 6629df4..3aa5d11e 100644
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
index 4efa1f7..7abcc2b 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -465,7 +465,7 @@ void kvmhv_release_all_nested(struct kvm *kvm)
 }
 
 /* caller must hold gp->tlb_lock */
-void kvmhv_flush_nested(struct kvm_nested_guest *gp)
+static void kvmhv_flush_nested(struct kvm_nested_guest *gp)
 {
 	struct kvm *kvm = gp->l1_host;
 
@@ -685,10 +685,216 @@ static int kvmhv_emulate_priv_mfspr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return EMULATE_FAIL;
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
+				    int rs, int rb)
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
+	lpid = get_lpid(kvmppc_get_gpr(vcpu, rs));
+	is = get_is(kvmppc_get_gpr(vcpu, rb));
+
+	/*
+	 * These cases are invalid and __should__ have caused a machine check
+	 * r   != 1 -> Only radix supported
+	 * prs == 1 -> Not HV privileged
+	 * ric == 3 -> No clusted bombs for radix
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
+		epn = get_epn(kvmppc_get_gpr(vcpu, rb));
+		ap = get_ap(kvmppc_get_gpr(vcpu, rb));
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
 static int kvmhv_emulate_priv_op_31(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				    unsigned int instr)
 {
-	return EMULATE_FAIL;
+	int ret;
+
+	switch (get_xop(instr)) {
+	case OP_31_XOP_TLBIE:
+		ret = kvmhv_emulate_priv_tlbie(vcpu, instr, get_rs(instr),
+					       get_rb(instr));
+		if (ret) {
+			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
+			return EMULATE_AGAIN;
+		}
+		return EMULATE_DONE;
+	default:
+		return EMULATE_FAIL;
+	}
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
+	ret = kvmhv_emulate_priv_tlbie(vcpu, kvmppc_get_gpr(vcpu, 4), 5, 6);
+	if (ret)
+		return H_PARAMETER;
+	return H_SUCCESS;
 }
 
 static int kvmhv_emulate_priv_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
-- 
2.7.4

