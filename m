Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0EAD9DDFAD
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 12:05:28 +1100 (EST)
Subject: [PATCH] powerpc: Fix demotion of segments to 4K pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 29 Oct 2007 12:05:18 +1100
Message-Id: <1193619918.9928.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When demoting a process to use 4K HW pages (instead of 64K), which happens
under various circumstances such as doing cache inhibited mappings on 
machines that do not support 64K CI pages, the assembly hash code calls
back into the C function flush_hash_page(). This function prototype was
recently changed to accomodate for 1T segments but the assembly call site
was not updated, causing applications that do demotion to hang. In addition,
when updating the per-CPU PACA for the new sizes, we didn't properly
update the slice "map", thus causing the SLB miss code to re-insert
segments for the wrong size.

This fixes both and adds a warning comment next to the C implementation to
try to avoid it next time someone changes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note that the PACA update bug is also present in 2.6.23, I'll do a patch
for -stable separately, once this one is upstream.

Index: linux-work/arch/powerpc/mm/hash_low_64.S
===================================================================
--- linux-work.orig/arch/powerpc/mm/hash_low_64.S	2007-10-29 10:15:48.000000000 +1100
+++ linux-work/arch/powerpc/mm/hash_low_64.S	2007-10-29 10:22:10.000000000 +1100
@@ -331,7 +331,7 @@ htab_pte_insert_failure:
  *****************************************************************************/
 
 /* _hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
- *		 pte_t *ptep, unsigned long trap, int local)
+ *		 pte_t *ptep, unsigned long trap, int local, int ssize)
  */
 
 /*
@@ -557,7 +557,8 @@ htab_inval_old_hpte:
 	mr	r4,r31			/* PTE.pte */
 	li	r5,0			/* PTE.hidx */
 	li	r6,MMU_PAGE_64K		/* psize */
-	ld	r7,STK_PARM(r8)(r1)	/* local */
+	ld	r7,STK_PARM(r9)(r1)	/* ssize */
+	ld	r8,STK_PARM(r8)(r1)	/* local */
 	bl	.flush_hash_page
 	b	htab_insert_pte
 	
Index: linux-work/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/hash_utils_64.c	2007-10-29 10:21:55.000000000 +1100
+++ linux-work/arch/powerpc/mm/hash_utils_64.c	2007-10-29 11:57:06.000000000 +1100
@@ -793,8 +793,7 @@ int hash_page(unsigned long ea, unsigned
 	}
 	if (user_region) {
 		if (psize != get_paca()->context.user_psize) {
-			get_paca()->context.user_psize =
-				mm->context.user_psize;
+			get_paca()->context = mm->context;
 			slb_flush_and_rebolt();
 		}
 	} else if (get_paca()->vmalloc_sllp !=
@@ -887,6 +886,9 @@ void hash_preload(struct mm_struct *mm, 
 	local_irq_restore(flags);
 }
 
+/* WARNING: This is called from hash_low_64.S, if you change this prototype,
+ *          do not forget to update the assembly call site !
+ */
 void flush_hash_page(unsigned long va, real_pte_t pte, int psize, int ssize,
 		     int local)
 {
