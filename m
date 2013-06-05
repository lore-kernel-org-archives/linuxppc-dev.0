Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B1B72C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 01:28:53 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 20:52:03 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id CFC3A125804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 21:00:55 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r55FSfP440501272
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 20:58:41 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r55FSkwG006938
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Jun 2013 01:28:46 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V10 08/15] powerpc/THP: Add code to handle HPTE faults for
 hugepages
Date: Wed,  5 Jun 2013 20:58:32 +0530
Message-Id: <1370446119-8837-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

The deposted PTE page in the second half of the PMD table is used to
track the state on hash PTEs. After updating the HPTE, we mark the
coresponding slot in the deposted PTE page valid.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h |  13 +++
 arch/powerpc/mm/Makefile              |   1 +
 arch/powerpc/mm/hash_utils_64.c       |  21 +++-
 arch/powerpc/mm/hugepage-hash64.c     | 176 ++++++++++++++++++++++++++++++++++
 4 files changed, 207 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/mm/hugepage-hash64.c

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 2accc96..3d6fbb0 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -340,6 +340,19 @@ extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		     pte_t *ptep, unsigned long trap, int local, int ssize,
 		     unsigned int shift, unsigned int mmu_psize);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+extern int __hash_page_thp(unsigned long ea, unsigned long access,
+			   unsigned long vsid, pmd_t *pmdp, unsigned long trap,
+			   int local, int ssize, unsigned int psize);
+#else
+static inline int __hash_page_thp(unsigned long ea, unsigned long access,
+				  unsigned long vsid, pmd_t *pmdp,
+				  unsigned long trap, int local,
+				  int ssize, unsigned int psize)
+{
+	BUG();
+}
+#endif
 extern void hash_failure_debug(unsigned long ea, unsigned long access,
 			       unsigned long vsid, unsigned long trap,
 			       int ssize, int psize, int lpsize,
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index fde36e6..87671eb 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -33,6 +33,7 @@ ifeq ($(CONFIG_HUGETLB_PAGE),y)
 obj-$(CONFIG_PPC_STD_MMU_64)	+= hugetlbpage-hash64.o
 obj-$(CONFIG_PPC_BOOK3E_MMU)	+= hugetlbpage-book3e.o
 endif
+obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += hugepage-hash64.o
 obj-$(CONFIG_PPC_SUBPAGE_PROT)	+= subpage-prot.o
 obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 9f86a27c..c11fe6c 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1050,13 +1050,26 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 		goto bail;
 	}
 
-#ifdef CONFIG_HUGETLB_PAGE
 	if (hugeshift) {
-		rc = __hash_page_huge(ea, access, vsid, ptep, trap, local,
-					ssize, hugeshift, psize);
+		if (pmd_trans_huge(*(pmd_t *)ptep))
+			rc = __hash_page_thp(ea, access, vsid, (pmd_t *)ptep,
+					     trap, local, ssize, psize);
+#ifdef CONFIG_HUGETLB_PAGE
+		else
+			rc = __hash_page_huge(ea, access, vsid, ptep, trap,
+					      local, ssize, hugeshift, psize);
+#else
+		else {
+			/*
+			 * if we have hugeshift, and is not transhuge with
+			 * hugetlb disabled, something is really wrong.
+			 */
+			rc = 1;
+			WARN_ON(1);
+		}
+#endif
 		goto bail;
 	}
-#endif /* CONFIG_HUGETLB_PAGE */
 
 #ifndef CONFIG_PPC_64K_PAGES
 	DBG_LOW(" i-pte: %016lx\n", pte_val(*ptep));
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
new file mode 100644
index 0000000..90d0a08
--- /dev/null
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -0,0 +1,176 @@
+/*
+ * Copyright IBM Corporation, 2013
+ * Author Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+/*
+ * PPC64 THP Support for hash based MMUs
+ */
+#include <linux/mm.h>
+#include <asm/machdep.h>
+
+int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
+		    pmd_t *pmdp, unsigned long trap, int local, int ssize,
+		    unsigned int psize)
+{
+	unsigned int index, valid;
+	unsigned char *hpte_slot_array;
+	unsigned long rflags, pa, hidx;
+	unsigned long old_pmd, new_pmd;
+	int ret, lpsize = MMU_PAGE_16M;
+	unsigned long vpn, hash, shift, slot;
+
+	/*
+	 * atomically mark the linux large page PMD busy and dirty
+	 */
+	do {
+		old_pmd = pmd_val(*pmdp);
+		/* If PMD busy, retry the access */
+		if (unlikely(old_pmd & _PAGE_BUSY))
+			return 0;
+		/* If PMD permissions don't match, take page fault */
+		if (unlikely(access & ~old_pmd))
+			return 1;
+		/*
+		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
+		 * a write access
+		 */
+		new_pmd = old_pmd | _PAGE_BUSY | _PAGE_ACCESSED;
+		if (access & _PAGE_RW)
+			new_pmd |= _PAGE_DIRTY;
+	} while (old_pmd != __cmpxchg_u64((unsigned long *)pmdp,
+					  old_pmd, new_pmd));
+	/*
+	 * PP bits. _PAGE_USER is already PP bit 0x2, so we only
+	 * need to add in 0x1 if it's a read-only user page
+	 */
+	rflags = new_pmd & _PAGE_USER;
+	if ((new_pmd & _PAGE_USER) && !((new_pmd & _PAGE_RW) &&
+					   (new_pmd & _PAGE_DIRTY)))
+		rflags |= 0x1;
+	/*
+	 * _PAGE_EXEC -> HW_NO_EXEC since it's inverted
+	 */
+	rflags |= ((new_pmd & _PAGE_EXEC) ? 0 : HPTE_R_N);
+
+#if 0
+	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
+
+		/*
+		 * No CPU has hugepages but lacks no execute, so we
+		 * don't need to worry about that case
+		 */
+		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
+	}
+#endif
+	/*
+	 * Find the slot index details for this ea, using base page size.
+	 */
+	shift = mmu_psize_defs[psize].shift;
+	index = (ea & ~HPAGE_PMD_MASK) >> shift;
+	BUG_ON(index >= 4096);
+
+	vpn = hpt_vpn(ea, vsid, ssize);
+	hash = hpt_hash(vpn, shift, ssize);
+	/*
+	 * The hpte hindex are stored in the pgtable whose address is in the
+	 * second half of the PMD
+	 */
+	hpte_slot_array = *(char **)(pmdp + PTRS_PER_PMD);
+
+	valid = hpte_valid(hpte_slot_array, index);
+	if (valid) {
+		/* update the hpte bits */
+		hidx =  hpte_hash_index(hpte_slot_array, index);
+		if (hidx & _PTEIDX_SECONDARY)
+			hash = ~hash;
+		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+		slot += hidx & _PTEIDX_GROUP_IX;
+
+		ret = ppc_md.hpte_updatepp(slot, rflags, vpn,
+					   psize, lpsize, ssize, local);
+		/*
+		 * We failed to update, try to insert a new entry.
+		 */
+		if (ret == -1) {
+			/*
+			 * large pte is marked busy, so we can be sure
+			 * nobody is looking at hpte_slot_array. hence we can
+			 * safely update this here.
+			 */
+			valid = 0;
+			new_pmd &= ~_PAGE_HPTEFLAGS;
+			hpte_slot_array[index] = 0;
+		} else
+			/* clear the busy bits and set the hash pte bits */
+			new_pmd = (new_pmd & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
+	}
+
+	if (!valid) {
+		unsigned long hpte_group;
+
+		/* insert new entry */
+		pa = pmd_pfn(__pmd(old_pmd)) << PAGE_SHIFT;
+repeat:
+		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+
+		/* clear the busy bits and set the hash pte bits */
+		new_pmd = (new_pmd & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
+
+		/* Add in WIMG bits */
+		rflags |= (new_pmd & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
+				      _PAGE_COHERENT | _PAGE_GUARDED));
+
+		/* Insert into the hash table, primary slot */
+		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
+					  psize, lpsize, ssize);
+		/*
+		 * Primary is full, try the secondary
+		 */
+		if (unlikely(slot == -1)) {
+			hpte_group = ((~hash & htab_hash_mask) *
+				      HPTES_PER_GROUP) & ~0x7UL;
+			slot = ppc_md.hpte_insert(hpte_group, vpn, pa,
+						  rflags, HPTE_V_SECONDARY,
+						  psize, lpsize, ssize);
+			if (slot == -1) {
+				if (mftb() & 0x1)
+					hpte_group = ((hash & htab_hash_mask) *
+						      HPTES_PER_GROUP) & ~0x7UL;
+
+				ppc_md.hpte_remove(hpte_group);
+				goto repeat;
+			}
+		}
+		/*
+		 * Hypervisor failure. Restore old pmd and return -1
+		 * similar to __hash_page_*
+		 */
+		if (unlikely(slot == -2)) {
+			*pmdp = __pmd(old_pmd);
+			hash_failure_debug(ea, access, vsid, trap, ssize,
+					   psize, lpsize, old_pmd);
+			return -1;
+		}
+		/*
+		 * large pte is marked busy, so we can be sure
+		 * nobody is looking at hpte_slot_array. hence we can
+		 * safely update this here.
+		 */
+		mark_hpte_slot_valid(hpte_slot_array, index, slot);
+	}
+	/*
+	 * No need to use ldarx/stdcx here
+	 */
+	*pmdp = __pmd(new_pmd & ~_PAGE_BUSY);
+	return 0;
+}
-- 
1.8.1.2
