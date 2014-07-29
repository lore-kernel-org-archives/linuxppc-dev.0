Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C62821A040E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:12 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 29 Jul 2014 19:38:01 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 27C193578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:07 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6T9F7pe52822154
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:15:07 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6T9c6wT008165
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:06 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 3/8] powerpc: thp: invalidate old 64K based hash page mapping
 before insert of 4k pte
Date: Tue, 29 Jul 2014 15:07:44 +0530
Message-Id: <1406626669-31154-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1406626669-31154-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1406626669-31154-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

If we changed base page size of the segment, either via sub_page_protect
or via remap_4k_pfn, we do a demote_segment which doesn't flush the hash
table entries. We do a lazy hash page table flush for all mapped pages
in the demoted segment. This happens when we handle hash page fault
for these pages.

We use _PAGE_COMBO bit along with _PAGE_HASHPTE to indicate whether a
pte is backed by 4K hash pte. If we find _PAGE_COMBO not set on the pte,
that implies that we could possibly have older 64K hash pte entries in
the hash page table and we need to invalidate those entries.

Handle this correctly for 16M pages

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugepage-hash64.c | 79 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 11f9a37ca2c6..1fb609dcc49b 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -18,6 +18,57 @@
 #include <linux/mm.h>
 #include <asm/machdep.h>
 
+static void invalidate_old_hpte(unsigned long vsid, unsigned long addr,
+				pmd_t *pmdp, unsigned int psize, int ssize)
+{
+	int i, max_hpte_count, valid;
+	unsigned long s_addr;
+	unsigned char *hpte_slot_array;
+	unsigned long hidx, shift, vpn, hash, slot;
+
+	s_addr = addr & HPAGE_PMD_MASK;
+	hpte_slot_array = get_hpte_slot_array(pmdp);
+	/*
+	 * IF we try to do a HUGE PTE update after a withdraw is done.
+	 * we will find the below NULL. This happens when we do
+	 * split_huge_page_pmd
+	 */
+	if (!hpte_slot_array)
+		return;
+
+	if (ppc_md.hugepage_invalidate)
+		return ppc_md.hugepage_invalidate(vsid, s_addr, hpte_slot_array,
+						  psize, ssize);
+	/*
+	 * No bluk hpte removal support, invalidate each entry
+	 */
+	shift = mmu_psize_defs[psize].shift;
+	max_hpte_count = HPAGE_PMD_SIZE >> shift;
+	for (i = 0; i < max_hpte_count; i++) {
+		/*
+		 * 8 bits per each hpte entries
+		 * 000| [ secondary group (one bit) | hidx (3 bits) | valid bit]
+		 */
+		valid = hpte_valid(hpte_slot_array, i);
+		if (!valid)
+			continue;
+		hidx =  hpte_hash_index(hpte_slot_array, i);
+
+		/* get the vpn */
+		addr = s_addr + (i * (1ul << shift));
+		vpn = hpt_vpn(addr, vsid, ssize);
+		hash = hpt_hash(vpn, shift, ssize);
+		if (hidx & _PTEIDX_SECONDARY)
+			hash = ~hash;
+
+		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+		slot += hidx & _PTEIDX_GROUP_IX;
+		ppc_md.hpte_invalidate(slot, vpn, psize,
+				       MMU_PAGE_16M, ssize, 0);
+	}
+}
+
+
 int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		    pmd_t *pmdp, unsigned long trap, int local, int ssize,
 		    unsigned int psize)
@@ -85,6 +136,15 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 	vpn = hpt_vpn(ea, vsid, ssize);
 	hash = hpt_hash(vpn, shift, ssize);
 	hpte_slot_array = get_hpte_slot_array(pmdp);
+	if (psize == MMU_PAGE_4K) {
+		/*
+		 * invalidate the old hpte entry if we have that mapped via 64K
+		 * base page size. This is because demote_segment won't flush
+		 * hash page table entries.
+		 */
+		if ((old_pmd & _PAGE_HASHPTE) && !(old_pmd & _PAGE_COMBO))
+			invalidate_old_hpte(vsid, ea, pmdp, MMU_PAGE_64K, ssize);
+	}
 
 	valid = hpte_valid(hpte_slot_array, index);
 	if (valid) {
@@ -107,11 +167,8 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 			 * safely update this here.
 			 */
 			valid = 0;
-			new_pmd &= ~_PAGE_HPTEFLAGS;
 			hpte_slot_array[index] = 0;
-		} else
-			/* clear the busy bits and set the hash pte bits */
-			new_pmd = (new_pmd & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
+		}
 	}
 
 	if (!valid) {
@@ -119,11 +176,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 
 		/* insert new entry */
 		pa = pmd_pfn(__pmd(old_pmd)) << PAGE_SHIFT;
-repeat:
-		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
-
-		/* clear the busy bits and set the hash pte bits */
-		new_pmd = (new_pmd & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
+		new_pmd |= _PAGE_HASHPTE;
 
 		/* Add in WIMG bits */
 		rflags |= (new_pmd & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
@@ -132,6 +185,8 @@ repeat:
 		 * enable the memory coherence always
 		 */
 		rflags |= HPTE_R_M;
+repeat:
+		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
 
 		/* Insert into the hash table, primary slot */
 		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
@@ -172,6 +227,12 @@ repeat:
 		mark_hpte_slot_valid(hpte_slot_array, index, slot);
 	}
 	/*
+	 * Mark the pte with _PAGE_COMBO, if we are trying to hash it with
+	 * base page size 4k.
+	 */
+	if (psize == MMU_PAGE_4K)
+		new_pmd |= _PAGE_COMBO;
+	/*
 	 * The hpte valid is stored in the pgtable whose address is in the
 	 * second half of the PMD. Order this against clearing of the busy bit in
 	 * huge pmd.
-- 
1.9.1
