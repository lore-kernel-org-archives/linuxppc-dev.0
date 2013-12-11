Return-Path: <kernelfans@gmail.com>
Received: from mail-ob0-x232.google.com (mail-ob0-x232.google.com
 [IPv6:2607:f8b0:4003:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E85A2C0355
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 19:47:13 +1100 (EST)
Received: by mail-ob0-f178.google.com with SMTP id uz6so6695647obc.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 00:47:10 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 3/4] powernv: kvm: extend input param for lookup_linux_pte
Date: Wed, 11 Dec 2013 16:47:53 +0800
Message-Id: <1386751674-14136-4-git-send-email-pingfank@linux.vnet.ibm.com>
In-Reply-To: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It will be helpful for next patch

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
Can it be merged with the next patch?
---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index af8602d..ae46052 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -135,7 +135,8 @@ static void remove_revmap_chain(struct kvm *kvm, long pte_index,
 }
 
 static pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
-			      int writing, unsigned long *pte_sizep)
+			      int writing, unsigned long *pte_sizep,
+			      pte_t **ptepp)
 {
 	pte_t *ptep;
 	unsigned long ps = *pte_sizep;
@@ -144,6 +145,8 @@ static pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
 	ptep = find_linux_pte_or_hugepte(pgdir, hva, &hugepage_shift);
 	if (!ptep)
 		return __pte(0);
+	if (ptepp != NULL)
+		*ptepp = ptep;
 	if (hugepage_shift)
 		*pte_sizep = 1ul << hugepage_shift;
 	else
@@ -231,7 +234,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 		/* Look up the Linux PTE for the backing page */
 		pte_size = psize;
-		pte = lookup_linux_pte(pgdir, hva, writing, &pte_size);
+		pte = lookup_linux_pte(pgdir, hva, writing, &pte_size, NULL);
 		if (pte_present(pte) && !pte_numa(pte)) {
 			if (writing && !pte_write(pte))
 				/* make the actual HPTE be read-only */
@@ -671,7 +674,8 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 			memslot = __gfn_to_memslot(kvm_memslots(kvm), gfn);
 			if (memslot) {
 				hva = __gfn_to_hva_memslot(memslot, gfn);
-				pte = lookup_linux_pte(pgdir, hva, 1, &psize);
+				pte = lookup_linux_pte(pgdir, hva, 1, &psize,
+							NULL);
 				if (pte_present(pte) && !pte_write(pte))
 					r = hpte_make_readonly(r);
 			}
-- 
1.8.1.4
