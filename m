Return-Path: <dgibson@ozlabs.org>
Date: Wed, 18 Apr 2007 16:19:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Fix breakage caused by tlb flush batch changes
Message-ID: <20070418061948.GA29312@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

BenH's commit a741e67969577163a4cfc78d7fd2753219087ef1 in powerpc.git,
although (AFAICT) only intended to affect ppc64, also has side-effects
which break 44x.  I think 40x, 8xx and Freescale Book E are also
affected, though I haven't tested them.

The problem lies in unconditionally removing flush_tlb_pending() from
the versions of flush_tlb_mm(), flush_tlb_range() and
flush_tlb_kernel_range() used on ppc64 - which are also used the
embedded platforms mentioned above.

The patch below restores the necessary flushes and fixes the breakage
for 44x.  They should also fix any breakage for the other platforms,
but again I haven't tested those.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/include/asm-powerpc/tlbflush.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/tlbflush.h	2007-04-18 15:45:12.000000000 +1000
+++ working-2.6/include/asm-powerpc/tlbflush.h	2007-04-18 15:55:21.000000000 +1000
@@ -104,6 +104,9 @@ extern void update_mmu_cache(struct vm_a
 
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
+#ifndef CONFIG_PPC64
+	flush_tlb_pending();
+#endif
 }
 
 static inline void flush_tlb_page(struct vm_area_struct *vma,
@@ -125,11 +128,17 @@ static inline void flush_tlb_page_nohash
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end)
 {
+#ifndef CONFIG_PPC64
+	flush_tlb_pending();
+#endif
 }
 
 static inline void flush_tlb_kernel_range(unsigned long start,
 		unsigned long end)
 {
+#ifndef CONFIG_PPC64
+	flush_tlb_pending();
+#endif
 }
 
 #else	/* 6xx, 7xx, 7xxx cpus */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
