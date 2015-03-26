Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C8FFF1A0671
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 00:13:52 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 18:43:50 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 136C7394005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 18:43:48 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2QDDiKf22741060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 18:43:44 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2QD5OuX025839
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 18:35:25 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH V4 1/4] KVM: PPC: Use READ_ONCE when dereferencing pte_t
 pointer
Date: Thu, 26 Mar 2015 18:43:39 +0530
Message-Id: <1427375622-3708-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pte can get updated from other CPUs as part of multiple activities
like THP split, huge page collapse, unmap. We need to make sure we
don't reload the pte value again and again for different checks.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |  5 ++++-
 arch/powerpc/kvm/e500_mmu_host.c         | 20 ++++++++++++--------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index cc073a7ac2b7..f06820c67175 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -290,7 +290,10 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing,
 	pte_t old_pte, new_pte = __pte(0);
 
 	while (1) {
-		old_pte = *ptep;
+		/*
+		 * Make sure we don't reload from ptep
+		 */
+		old_pte = READ_ONCE(*ptep);
 		/*
 		 * wait until _PAGE_BUSY is clear then set it atomically
 		 */
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index cc536d4a75ef..5840d546aa03 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -469,14 +469,18 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 
 	pgdir = vcpu_e500->vcpu.arch.pgdir;
 	ptep = lookup_linux_ptep(pgdir, hva, &tsize_pages);
-	if (pte_present(*ptep))
-		wimg = (*ptep >> PTE_WIMGE_SHIFT) & MAS2_WIMGE_MASK;
-	else {
-		if (printk_ratelimit())
-			pr_err("%s: pte not present: gfn %lx, pfn %lx\n",
-				__func__, (long)gfn, pfn);
-		ret = -EINVAL;
-		goto out;
+	if (ptep) {
+		pte_t pte = READ_ONCE(*ptep);
+
+		if (pte_present(pte))
+			wimg = (pte_val(pte) >> PTE_WIMGE_SHIFT) &
+				MAS2_WIMGE_MASK;
+		else {
+			pr_err_ratelimited("%s: pte not present: gfn %lx,pfn %lx\n",
+					   __func__, (long)gfn, pfn);
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
 
-- 
2.1.0
