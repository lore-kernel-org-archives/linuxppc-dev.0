Return-Path: <kernelfans@gmail.com>
Received: from mail-pd0-x233.google.com (mail-pd0-x233.google.com
 [IPv6:2607:f8b0:400e:c02::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2312D2C0385
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 19:47:18 +1100 (EST)
Received: by mail-pd0-f179.google.com with SMTP id r10so9068124pdi.24
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 00:47:15 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 4/4] powernv: kvm: make the handling of _PAGE_NUMA faster for
 guest
Date: Wed, 11 Dec 2013 16:47:54 +0800
Message-Id: <1386751674-14136-5-git-send-email-pingfank@linux.vnet.ibm.com>
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

The period check of _PAGE_NUMA can probably happen on the correctly
placed page. For this case, when guest try to setup hpte in real mode,
we try to resolve the numa fault in real mode, since the switch between
guest context and host context costs too much.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index ae46052..a06b199 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -179,6 +179,11 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	unsigned int writing;
 	unsigned long mmu_seq;
 	unsigned long rcbits;
+	struct mm_struct *mm = kvm->mm;
+	struct vm_area_struct *vma;
+	int page_nid, target_nid;
+	struct page *test_page;
+	pte_t *ptep;
 
 	psize = hpte_page_size(pteh, ptel);
 	if (!psize)
@@ -234,8 +239,26 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 		/* Look up the Linux PTE for the backing page */
 		pte_size = psize;
-		pte = lookup_linux_pte(pgdir, hva, writing, &pte_size, NULL);
-		if (pte_present(pte) && !pte_numa(pte)) {
+		pte = lookup_linux_pte(pgdir, hva, writing, &pte_size, &ptep);
+		if (pte_present(pte)) {
+			if (pte_numa(pte)) {
+				/* If fail, let gup handle it */
+				if (unlikely(!down_read_trylock(&mm->mmap_sem)))
+					goto pte_check;
+
+				vma = find_vma(mm, hva);
+				up_read(&mm->mmap_sem);
+				test_page = pte_page(pte);
+				page_nid = page_to_nid(test_page);
+				target_nid = numa_migrate_prep(test_page, vma,
+							 hva, page_nid);
+				put_page(test_page);
+				if (unlikely(target_nid != -1)) {
+					/* If fail, let gup handle it */
+					goto pte_check;
+				}
+			}
+
 			if (writing && !pte_write(pte))
 				/* make the actual HPTE be read-only */
 				ptel = hpte_make_readonly(ptel);
@@ -244,6 +267,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		}
 	}
 
+pte_check:
 	if (pte_size < psize)
 		return H_PARAMETER;
 	if (pa && pte_size > psize)
@@ -339,6 +363,10 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 			pteh &= ~HPTE_V_VALID;
 			unlock_rmap(rmap);
 		} else {
+			if (pte_numa(pte) && pa) {
+				pte = pte_mknonnuma(pte);
+				*ptep = pte;
+			}
 			kvmppc_add_revmap_chain(kvm, rev, rmap, pte_index,
 						realmode);
 			/* Only set R/C in real HPTE if already set in *rmap */
-- 
1.8.1.4
