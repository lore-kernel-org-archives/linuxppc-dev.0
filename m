Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB2A71A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:01:47 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 17:01:47 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9DEFF2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:01:44 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H71adO6422818
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:01:44 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H71C8a009894
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:01:12 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [RFC 1/2] powerpc/mm: Add trace points for various types of hash
 faults
Date: Wed, 17 Feb 2016 12:30:32 +0530
Message-Id: <1455692433-10975-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds trace point definitions and invocations for all types
of hash faults like THP, HugeTLB, 64K, 4K mappings. These are
intended to be used in user space for performance and functional
evaluation of various memory management paths.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/trace.h     | 82 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/hash64_64k.c         |  3 ++
 arch/powerpc/mm/hugepage-hash64.c    |  2 +
 arch/powerpc/mm/hugetlbpage-hash64.c |  3 ++
 4 files changed, 90 insertions(+)

diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
index 8e86b48..4f0a829 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -164,6 +164,88 @@ TRACE_EVENT(hash_fault,
 		      __entry->addr, __entry->access, __entry->trap)
 );
 
+TRACE_EVENT(hash_fault_hugetlb,
+
+	    TP_PROTO(unsigned long addr, unsigned long access, unsigned long trap),
+	    TP_ARGS(addr, access, trap),
+	    TP_STRUCT__entry(
+		    __field(unsigned long, addr)
+		    __field(unsigned long, access)
+		    __field(unsigned long, trap)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->addr = addr;
+		    __entry->access = access;
+		    __entry->trap = trap;
+		    ),
+
+	    TP_printk("HugeTLB hash fault with addr 0x%lx and access = 0x%lx trap = 0x%lx",
+		      __entry->addr, __entry->access, __entry->trap)
+);
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+TRACE_EVENT(hash_fault_thp,
+
+	    TP_PROTO(unsigned long addr, unsigned long access, unsigned long trap),
+	    TP_ARGS(addr, access, trap),
+	    TP_STRUCT__entry(
+		    __field(unsigned long, addr)
+		    __field(unsigned long, access)
+		    __field(unsigned long, trap)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->addr = addr;
+		    __entry->access = access;
+		    __entry->trap = trap;
+		    ),
+
+	    TP_printk("THP hash fault with addr 0x%lx and access = 0x%lx trap = 0x%lx",
+		      __entry->addr, __entry->access, __entry->trap)
+);
+#endif
+
+TRACE_EVENT(hash_fault_64K,
+
+	    TP_PROTO(unsigned long addr, unsigned long access, unsigned long trap),
+	    TP_ARGS(addr, access, trap),
+	    TP_STRUCT__entry(
+		    __field(unsigned long, addr)
+		    __field(unsigned long, access)
+		    __field(unsigned long, trap)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->addr = addr;
+		    __entry->access = access;
+		    __entry->trap = trap;
+		    ),
+
+	    TP_printk("64K hash fault with addr 0x%lx and access = 0x%lx trap = 0x%lx",
+		      __entry->addr, __entry->access, __entry->trap)
+);
+
+TRACE_EVENT(hash_fault_4K,
+
+	    TP_PROTO(unsigned long addr, unsigned long access, unsigned long trap),
+	    TP_ARGS(addr, access, trap),
+	    TP_STRUCT__entry(
+		    __field(unsigned long, addr)
+		    __field(unsigned long, access)
+		    __field(unsigned long, trap)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->addr = addr;
+		    __entry->access = access;
+		    __entry->trap = trap;
+		    ),
+
+	    TP_printk("4K hash fault with addr 0x%lx and access = 0x%lx trap = 0x%lx",
+		      __entry->addr, __entry->access, __entry->trap)
+);
+
 #endif /* _TRACE_POWERPC_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 0762c1e..7966fee 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <asm/machdep.h>
 #include <asm/mmu.h>
+#include <asm/trace.h>
 /*
  * index from 0 - 15
  */
@@ -58,6 +59,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	unsigned long vpn, hash, slot;
 	unsigned long shift = mmu_psize_defs[MMU_PAGE_4K].shift;
 
+	trace_hash_fault_4K(ea, access, trap);
 	/*
 	 * atomically mark the linux large page PTE busy and dirty
 	 */
@@ -221,6 +223,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 	unsigned long vpn, hash, slot;
 	unsigned long shift = mmu_psize_defs[MMU_PAGE_64K].shift;
 
+	trace_hash_fault_64K(ea, access, trap);
 	/*
 	 * atomically mark the linux large page PTE busy and dirty
 	 */
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 49b152b..daa588c 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -17,6 +17,7 @@
  */
 #include <linux/mm.h>
 #include <asm/machdep.h>
+#include <asm/trace.h>
 
 int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		    pmd_t *pmdp, unsigned long trap, unsigned long flags,
@@ -29,6 +30,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 	int ret, lpsize = MMU_PAGE_16M;
 	unsigned long vpn, hash, shift, slot;
 
+	trace_hash_fault_thp(ea, access, trap);
 	/*
 	 * atomically mark the linux large page PMD busy and dirty
 	 */
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index e2138c7..250c0a1 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -13,6 +13,7 @@
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/machdep.h>
+#include <asm/trace.h>
 
 extern long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
 				  unsigned long pa, unsigned long rlags,
@@ -29,6 +30,8 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 
 	BUG_ON(shift != mmu_psize_defs[mmu_psize].shift);
 
+	trace_hash_fault_hugetlb(ea, access, trap);
+
 	/* Search the Linux page table for a match with va */
 	vpn = hpt_vpn(ea, vsid, ssize);
 
-- 
2.1.0
