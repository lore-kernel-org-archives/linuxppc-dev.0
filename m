Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfX6c4PvSzF0gl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 02:00:40 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1BEwgd8071856
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 10:00:38 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g2exvkrkc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 10:00:37 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 11 Feb 2018 08:00:37 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 3/4] powerpc/mm/hash64: Store the slot information at the
 right offset.
Date: Sun, 11 Feb 2018 20:30:08 +0530
In-Reply-To: <20180211150009.21297-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180211150009.21297-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180211150009.21297-3-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hugetlb pte entries are at the PMD and PUD level. Use the right offset
for them to get the second half of the table.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  3 ++-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  9 +++++----
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  2 +-
 arch/powerpc/mm/hash64_4k.c                   |  4 ++--
 arch/powerpc/mm/hash64_64k.c                  |  8 ++++----
 arch/powerpc/mm/hugetlbpage-hash64.c          | 10 +++++++---
 arch/powerpc/mm/tlb_hash64.c                  |  9 +++++++--
 7 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 949d691094a4..67c5475311ee 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -63,7 +63,8 @@ static inline int hash__hugepd_ok(hugepd_t hpd)
  * keeping the prototype consistent across the two formats.
  */
 static inline unsigned long pte_set_hidx(pte_t *ptep, real_pte_t rpte,
-			unsigned int subpg_index, unsigned long hidx)
+					 unsigned int subpg_index, unsigned long hidx,
+					 int offset)
 {
 	return (hidx << H_PAGE_F_GIX_SHIFT) &
 		(H_PAGE_F_SECOND | H_PAGE_F_GIX);
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index ee440fb3d240..3bcf269f8f55 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -45,7 +45,7 @@
  * generic accessors and iterators here
  */
 #define __real_pte __real_pte
-static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
+static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep, int offset)
 {
 	real_pte_t rpte;
 	unsigned long *hidxp;
@@ -59,7 +59,7 @@ static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
 	 */
 	smp_rmb();
 
-	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
+	hidxp = (unsigned long *)(ptep + offset);
 	rpte.hidx = *hidxp;
 	return rpte;
 }
@@ -86,9 +86,10 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
  * expected to modify the PTE bits accordingly and commit the PTE to memory.
  */
 static inline unsigned long pte_set_hidx(pte_t *ptep, real_pte_t rpte,
-		unsigned int subpg_index, unsigned long hidx)
+					 unsigned int subpg_index,
+					 unsigned long hidx, int offset)
 {
-	unsigned long *hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
+	unsigned long *hidxp = (unsigned long *)(ptep + offset);
 
 	rpte.hidx &= ~HIDX_BITS(0xfUL, subpg_index);
 	*hidxp = rpte.hidx  | HIDX_BITS(HIDX_SHIFT_BY_ONE(hidx), subpg_index);
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 1c8c88e90553..a6b9f1d74600 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -350,7 +350,7 @@ extern unsigned long pci_io_base;
  */
 #ifndef __real_pte
 
-#define __real_pte(e,p)		((real_pte_t){(e)})
+#define __real_pte(e, p, o)		((real_pte_t){(e)})
 #define __rpte_to_pte(r)	((r).pte)
 #define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> H_PAGE_F_GIX_SHIFT)
 
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 5a69b51d08a3..d573d7d07f25 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -55,7 +55,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 * need to add in 0x1 if it's a read-only user page
 	 */
 	rflags = htab_convert_pte_flags(new_pte);
-	rpte = __real_pte(__pte(old_pte), ptep);
+	rpte = __real_pte(__pte(old_pte), ptep, PTRS_PER_PTE);
 
 	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
 	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
@@ -117,7 +117,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 			return -1;
 		}
 		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
-		new_pte |= pte_set_hidx(ptep, rpte, 0, slot);
+		new_pte |= pte_set_hidx(ptep, rpte, 0, slot, PTRS_PER_PTE);
 	}
 	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 2253bbc6a599..e601d95c3b20 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -86,7 +86,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 
 	subpg_index = (ea & (PAGE_SIZE - 1)) >> shift;
 	vpn  = hpt_vpn(ea, vsid, ssize);
-	rpte = __real_pte(__pte(old_pte), ptep);
+	rpte = __real_pte(__pte(old_pte), ptep, PTRS_PER_PTE);
 	/*
 	 *None of the sub 4k page is hashed
 	 */
@@ -214,7 +214,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		return -1;
 	}
 
-	new_pte |= pte_set_hidx(ptep, rpte, subpg_index, slot);
+	new_pte |= pte_set_hidx(ptep, rpte, subpg_index, slot, PTRS_PER_PTE);
 	new_pte |= H_PAGE_HASHPTE;
 
 	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
@@ -262,7 +262,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
 
 	rflags = htab_convert_pte_flags(new_pte);
-	rpte = __real_pte(__pte(old_pte), ptep);
+	rpte = __real_pte(__pte(old_pte), ptep, PTRS_PER_PTE);
 
 	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
 	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
@@ -327,7 +327,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		}
 
 		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
-		new_pte |= pte_set_hidx(ptep, rpte, 0, slot);
+		new_pte |= pte_set_hidx(ptep, rpte, 0, slot, PTRS_PER_PTE);
 	}
 	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 12511f5a015f..b320f5097a06 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -27,7 +27,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	unsigned long vpn;
 	unsigned long old_pte, new_pte;
 	unsigned long rflags, pa, sz;
-	long slot;
+	long slot, offset;
 
 	BUG_ON(shift != mmu_psize_defs[mmu_psize].shift);
 
@@ -63,7 +63,11 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	} while(!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
 
 	rflags = htab_convert_pte_flags(new_pte);
-	rpte = __real_pte(__pte(old_pte), ptep);
+	if (unlikely(mmu_psize == MMU_PAGE_16G))
+		offset = PTRS_PER_PUD;
+	else
+		offset = PTRS_PER_PMD;
+	rpte = __real_pte(__pte(old_pte), ptep, offset);
 
 	sz = ((1UL) << shift);
 	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
@@ -104,7 +108,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 			return -1;
 		}
 
-		new_pte |= pte_set_hidx(ptep, rpte, 0, slot);
+		new_pte |= pte_set_hidx(ptep, rpte, 0, slot, offset);
 	}
 
 	/*
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 881ebd53ffc2..9b23f12e863c 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -51,7 +51,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	unsigned int psize;
 	int ssize;
 	real_pte_t rpte;
-	int i;
+	int i, offset;
 
 	i = batch->index;
 
@@ -67,6 +67,10 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 		psize = get_slice_psize(mm, addr);
 		/* Mask the address for the correct page size */
 		addr &= ~((1UL << mmu_psize_defs[psize].shift) - 1);
+		if (unlikely(psize == MMU_PAGE_16G))
+			offset = PTRS_PER_PUD;
+		else
+			offset = PTRS_PER_PMD;
 #else
 		BUG();
 		psize = pte_pagesize_index(mm, addr, pte); /* shutup gcc */
@@ -78,6 +82,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 		 * support 64k pages, this might be different from the
 		 * hardware page size encoded in the slice table. */
 		addr &= PAGE_MASK;
+		offset = PTRS_PER_PTE;
 	}
 
 
@@ -91,7 +96,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	}
 	WARN_ON(vsid == 0);
 	vpn = hpt_vpn(addr, vsid, ssize);
-	rpte = __real_pte(__pte(pte), ptep);
+	rpte = __real_pte(__pte(pte), ptep, offset);
 
 	/*
 	 * Check if we have an active batch on this CPU. If not, just
-- 
2.14.3
