Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FDCD1A023E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 00:52:19 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 16 Jul 2014 00:52:18 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 95BCC3578047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 00:52:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6FEZRsX60293138
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 00:35:27 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6FEqDJq027710
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 00:52:13 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/2] powerpc: thp: invalidate old 64K based hash page mapping
 before insert
Date: Tue, 15 Jul 2014 20:22:07 +0530
Message-Id: <1405435927-24027-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1405435927-24027-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1405435927-24027-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
table entries. We do that when inserting a new hash pte by checking the
_PAGE_COMBO flag. We missed to do that when inserting hash for a new 16MB
page. Add the same. This patch mark the 4k base page size 16MB hugepage
via _PAGE_COMBO.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugepage-hash64.c | 66 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 826893fcb3a7..28d1b8b93674 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -18,6 +18,56 @@
 #include <linux/mm.h>
 #include <asm/machdep.h>
 
+static void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
+				pmd_t *pmdp, unsigned int psize, int ssize)
+{
+	int i, max_hpte_count, valid;
+	unsigned long s_addr = addr;
+	unsigned char *hpte_slot_array;
+	unsigned long hidx, shift, vpn, hash, slot;
+
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
+		return ppc_md.hugepage_invalidate(vsid, addr, hpte_slot_array,
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
@@ -85,6 +135,15 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 	vpn = hpt_vpn(ea, vsid, ssize);
 	hash = hpt_hash(vpn, shift, ssize);
 	hpte_slot_array = get_hpte_slot_array(pmdp);
+	if (psize == MMU_PAGE_4K) {
+		/*
+		 * invalidate the old hpte entry if we have that mapped via 64K
+		 * base page size. This is because demote_segment won't flush
+		 * hash page table entries.
+		 */
+		if (!(old_pmd & _PAGE_COMBO))
+			flush_hash_hugepage(vsid, ea, pmdp, MMU_PAGE_64K, ssize);
+	}
 
 	valid = hpte_valid(hpte_slot_array, index);
 	if (valid) {
@@ -172,6 +231,13 @@ repeat:
 		mark_hpte_slot_valid(hpte_slot_array, index, slot);
 	}
 	/*
+	 * Mark the pte with _PAGE_COMBO, if we are trying to hash it with
+	 * base page size 4k.
+	 */
+	if (psize == MMU_PAGE_4K)
+		new_pmd |= _PAGE_COMBO;
+
+	/*
 	 * No need to use ldarx/stdcx here
 	 */
 	*pmdp = __pmd(new_pmd & ~_PAGE_BUSY);
-- 
1.9.1
