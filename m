Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6128FC00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:33:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21A920841
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="tFWf3g3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21A920841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T9Xy51lgzF38l
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 17:33:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="tFWf3g3y";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T8B36LGSzF37b
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:31:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="tFWf3g3y"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T8B33j08zB2xk; Mon,  8 Oct 2018 16:31:55 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T8B22xZvzB4NZ;
 Mon,  8 Oct 2018 16:31:54 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976714; bh=Wju6y7rYqwlm+v4U4NGJj1EOVTW29vBqIaLXB2Vxj9g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tFWf3g3yb51TMPiYDQKlNrbttTeZbfjQ68VdMOpKRO8ylRjgrlFRNPo2gpSeish3Y
 xggxaCnGdjH7Jk4yaf/ZY9LYSuO23/pr6WlqUCbruVIBmt7h8giX4fYizxY5PjLO8P
 3Y/d7wtVBXABBjC2p5rhITuyAiQBt/zYGgg16h7m293VZZ2k+GzSB/GIVnlhzigrGt
 +RFDMiKkHZuOndSEkiXR7H5/YzyKe2nHtWMO6fiGOfY7I5KQcODhlf8COG0KeB6iwJ
 l8UN9iQRDd04JA1QdcxENeZ0btiBx0X//v5zE0bXkNwr7AJUJYD0EpBLUyVYSMkfBi
 uLRotdVfg0M8w==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 24/33] KVM: PPC: Book3S HV: Use hypercalls for TLB
 invalidation when nested
Date: Mon,  8 Oct 2018 16:31:10 +1100
Message-Id: <1538976679-1363-25-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
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

This adds code to call the H_TLB_INVALIDATE hypercall when running as
a guest, in the cases where we need to invalidate TLBs (or other MMU
caches) as part of managing the mappings for a nested guest.  Calling
H_TLB_INVALIDATE lets the nested hypervisor inform the parent
hypervisor about changes to partition-scoped page tables or the
partition table without needing to do hypervisor-privileged tlbie
instructions.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |  5 +++++
 arch/powerpc/kvm/book3s_64_mmu_radix.c   | 30 ++++++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv_nested.c      | 30 ++++++++++++++++++++++++------
 3 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index c2a9146..719b31723 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -24,6 +24,7 @@
 #include <asm/bitops.h>
 #include <asm/book3s/64/mmu-hash.h>
 #include <asm/cpu_has_feature.h>
+#include <asm/ppc-opcode.h>
 
 #ifdef CONFIG_PPC_PSERIES
 static inline bool kvmhv_on_pseries(void)
@@ -117,6 +118,10 @@ struct kvm_nested_guest *kvmhv_get_nested(struct kvm *kvm, int l1_lpid,
 					  bool create);
 void kvmhv_put_nested(struct kvm_nested_guest *gp);
 
+/* Encoding of first parameter for H_TLB_INVALIDATE */
+#define H_TLBIE_P1_ENC(ric, prs, r)	(___PPC_RIC(ric) | ___PPC_PRS(prs) | \
+					 ___PPC_R(r))
+
 /* Power architecture requires HPT is at least 256kiB, at most 64TiB */
 #define PPC_MIN_HPT_ORDER	18
 #define PPC_MAX_HPT_ORDER	46
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 4c1eccb..ae0e3ed 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -201,17 +201,43 @@ static void kvmppc_radix_tlbie_page(struct kvm *kvm, unsigned long addr,
 				    unsigned int pshift, unsigned int lpid)
 {
 	unsigned long psize = PAGE_SIZE;
+	int psi;
+	long rc;
+	unsigned long rb;
 
 	if (pshift)
 		psize = 1UL << pshift;
+	else
+		pshift = PAGE_SHIFT;
 
 	addr &= ~(psize - 1);
-	radix__flush_tlb_lpid_page(lpid, addr, psize);
+
+	if (!kvmhv_on_pseries()) {
+		radix__flush_tlb_lpid_page(lpid, addr, psize);
+		return;
+	}
+
+	psi = shift_to_mmu_psize(pshift);
+	rb = addr | (mmu_get_ap(psi) << PPC_BITLSHIFT(58));
+	rc = plpar_hcall_norets(H_TLB_INVALIDATE, H_TLBIE_P1_ENC(0, 0, 1),
+				lpid, rb);
+	if (rc)
+		pr_err("KVM: TLB page invalidation hcall failed, rc=%ld\n", rc);
 }
 
 static void kvmppc_radix_flush_pwc(struct kvm *kvm, unsigned int lpid)
 {
-	radix__flush_pwc_lpid(lpid);
+	long rc;
+
+	if (!kvmhv_on_pseries()) {
+		radix__flush_pwc_lpid(lpid);
+		return;
+	}
+
+	rc = plpar_hcall_norets(H_TLB_INVALIDATE, H_TLBIE_P1_ENC(1, 0, 1),
+				lpid, TLBIEL_INVAL_SET_LPID);
+	if (rc)
+		pr_err("KVM: TLB PWC invalidation hcall failed, rc=%ld\n", rc);
 }
 
 static unsigned long kvmppc_radix_update_pte(struct kvm *kvm, pte_t *ptep,
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index c83c13d..486d900 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -299,14 +299,32 @@ void kvmhv_nested_exit(void)
 	}
 }
 
+static void kvmhv_flush_lpid(unsigned int lpid)
+{
+	long rc;
+
+	if (!kvmhv_on_pseries()) {
+		radix__flush_tlb_lpid(lpid);
+		return;
+	}
+
+	rc = plpar_hcall_norets(H_TLB_INVALIDATE, H_TLBIE_P1_ENC(2, 0, 1),
+				lpid, TLBIEL_INVAL_SET_LPID);
+	if (rc)
+		pr_err("KVM: TLB LPID invalidation hcall failed, rc=%ld\n", rc);
+}
+
 void kvmhv_set_ptbl_entry(unsigned int lpid, u64 dw0, u64 dw1)
 {
-	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+	if (!kvmhv_on_pseries()) {
 		mmu_partition_table_set_entry(lpid, dw0, dw1);
-	} else {
-		pseries_partition_tb[lpid].patb0 = cpu_to_be64(dw0);
-		pseries_partition_tb[lpid].patb1 = cpu_to_be64(dw1);
+		return;
 	}
+
+	pseries_partition_tb[lpid].patb0 = cpu_to_be64(dw0);
+	pseries_partition_tb[lpid].patb1 = cpu_to_be64(dw1);
+	/* L0 will do the necessary barriers */
+	kvmhv_flush_lpid(lpid);
 }
 
 static void kvmhv_set_nested_ptbl(struct kvm_nested_guest *gp)
@@ -493,7 +511,7 @@ static void kvmhv_flush_nested(struct kvm_nested_guest *gp)
 	spin_lock(&kvm->mmu_lock);
 	kvmppc_free_pgtable_radix(kvm, gp->shadow_pgtable, gp->shadow_lpid);
 	spin_unlock(&kvm->mmu_lock);
-	radix__flush_tlb_lpid(gp->shadow_lpid);
+	kvmhv_flush_lpid(gp->shadow_lpid);
 	kvmhv_update_ptbl_cache(gp);
 	if (gp->l1_gr_to_hr == 0)
 		kvmhv_remove_nested(gp);
@@ -777,7 +795,7 @@ static void kvmhv_emulate_tlbie_lpid(struct kvm_vcpu *vcpu,
 		spin_lock(&kvm->mmu_lock);
 		kvmppc_free_pgtable_radix(kvm, gp->shadow_pgtable,
 					  gp->shadow_lpid);
-		radix__flush_tlb_lpid(gp->shadow_lpid);
+		kvmhv_flush_lpid(gp->shadow_lpid);
 		spin_unlock(&kvm->mmu_lock);
 		break;
 	case 1:
-- 
2.7.4

