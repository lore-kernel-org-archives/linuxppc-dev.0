Message-ID: <38FC225D.F11A802E@lightning.ch>
Date: Tue, 18 Apr 2000 10:52:45 +0200
From: Daniel Marmier <daniel.marmier@lightning.ch>
Reply-To: daniel.marmier@lightning.ch
MIME-Version: 1.0
To: Dan Malek <dmalek@jlc.net>,
        Linux PowerPC development mailing list
 <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH 2.3.99-pre5-dm2] cache line size cleanup
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Dan,

This patch addresses the following issues :
   - removed various definitions of PPC cache stuff (now everything is
     in include/asm-pcc/cache.h
   - removed unused L1_CACHE_PAGES in include/asm-ppc/cache.h
   - fixed file arch/ppc/lib/string.S, function __copy_tofrom_user for
     16-byte cache lines
   - fixed PAGE_SIZE for assembly (gcc understands UL, gas does not)

I am not sure about the cache line size of the 4xx processors :
if needed, please modify include/asm-ppc/cache.h accordingly.


				Daniel Marmier



diff -urN linux-2.3.99-pre5/arch/ppc/kernel/misc.S linux-2.3.99-pre5-dm/arch/ppc/kernel/misc.S
--- linux-2.3.99-pre5/arch/ppc/kernel/misc.S	Mon Mar  6 16:52:14 2000
+++ linux-2.3.99-pre5-dm/arch/ppc/kernel/misc.S	Tue Apr 18 09:03:46 2000
@@ -14,19 +14,14 @@

 #include <linux/config.h>
 #include <linux/sys.h>
+#include <asm/cache.h>
 #include <asm/unistd.h>
 #include <asm/errno.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 #include "ppc_asm.h"

-#if defined(CONFIG_4xx) || defined(CONFIG_8xx)
-CACHE_LINE_SIZE = 16
-LG_CACHE_LINE_SIZE = 4
-#else
-CACHE_LINE_SIZE = 32
-LG_CACHE_LINE_SIZE = 5
-#endif /* CONFIG_4xx || CONFIG_8xx */
+#define CACHELINES_PER_PAGE (PAGE_SIZE/L1_CACHE_BYTES)

 	.text

@@ -188,21 +183,21 @@
 	rlwinm	r5,r5,16,16,31
 	cmpi	0,r5,1
 	beqlr				/* for 601, do nothing */
-	li	r5,CACHE_LINE_SIZE-1
+	li	r5,L1_CACHE_MASK
 	andc	r3,r3,r5
 	subf	r4,r3,r4
 	add	r4,r4,r5
-	srwi.	r4,r4,LG_CACHE_LINE_SIZE
+	srwi.	r4,r4,L1_CACHE_SHIFT
 	beqlr
 	mtctr	r4
 	mr	r6,r3
 1:	dcbst	0,r3
-	addi	r3,r3,CACHE_LINE_SIZE
+	addi	r3,r3,L1_CACHE_BYTES
 	bdnz	1b
 	sync				/* wait for dcbst's to get to ram */
 	mtctr	r4
 2:	icbi	0,r6
-	addi	r6,r6,CACHE_LINE_SIZE
+	addi	r6,r6,L1_CACHE_BYTES
 	bdnz	2b
 	sync
 	isync
@@ -214,16 +209,16 @@
  * flush_dcache_range(unsigned long start, unsigned long stop)
  */
 _GLOBAL(flush_dcache_range)
-       li      r5,CACHE_LINE_SIZE-1
+       li      r5,L1_CACHE_MASK
        andc    r3,r3,r5
        subf    r4,r3,r4
        add     r4,r4,r5
-       srwi.   r4,r4,LG_CACHE_LINE_SIZE
+       srwi.   r4,r4,L1_CACHE_SHIFT
        beqlr
        mtctr   r4

 1:     dcbst   0,r3
-       addi    r3,r3,CACHE_LINE_SIZE
+       addi    r3,r3,L1_CACHE_BYTES
        bdnz    1b
        sync                            /* wait for dcbst's to get to ram */
        blr
@@ -243,16 +238,16 @@
 	beqlr				/* for 601, do nothing */
 	li	r4,0x0FFF
 	andc	r3,r3,r4		/* Get page base address */
-	li	r4,4096/CACHE_LINE_SIZE	/* Number of lines in a page */
+	li	r4,CACHELINES_PER_PAGE	/* Number of lines in a page */
 	mtctr	r4
 	mr	r6,r3
 0:	dcbst	0,r3			/* Write line to ram */
-	addi	r3,r3,CACHE_LINE_SIZE
+	addi	r3,r3,L1_CACHE_BYTES
 	bdnz	0b
 	sync
 	mtctr	r4
 1:	icbi	0,r6
-	addi	r6,r6,CACHE_LINE_SIZE
+	addi	r6,r6,L1_CACHE_BYTES
 	bdnz	1b
 	sync
 	isync
@@ -271,10 +266,10 @@
 	rlwinm	r5,r5,16,16,31
 	cmpi	0,r5,1
 	beqlr				/* for 601, do nothing */
-	li	r4,4096/CACHE_LINE_SIZE	/* Number of lines in a page */
+	li	r4,CACHELINES_PER_PAGE	/* Number of lines in a page */
 	mtctr	r4
 1:	icbi	0,r3
-	addi	r3,r3,CACHE_LINE_SIZE
+	addi	r3,r3,L1_CACHE_BYTES
 	bdnz	1b
 	sync
 	isync
@@ -286,10 +281,10 @@
  * displaced).  This only works on cacheable memory.
  */
 _GLOBAL(clear_page)
-	li	r0,4096/CACHE_LINE_SIZE
+	li	r0,CACHELINES_PER_PAGE
 	mtctr	r0
 1:	dcbz	0,r3
-	addi	r3,r3,CACHE_LINE_SIZE
+	addi	r3,r3,L1_CACHE_BYTES
 	bdnz	1b
 	blr

@@ -300,7 +295,7 @@
  * is cacheable.
  */
 _GLOBAL(copy_page)
-	li	r0,4096/CACHE_LINE_SIZE
+	li	r0,CACHELINES_PER_PAGE
 	mtctr	r0
 	addi	r3,r3,-4
 	addi	r4,r4,-4
@@ -314,6 +309,7 @@
 	stw	r7,8(r3)
 	stw	r8,12(r3)
 	stwu	r9,16(r3)
+#if (L1_CACHE_BYTES == 32)
 	lwz	r6,4(r4)
 	lwz	r7,8(r4)
 	lwz	r8,12(r4)
@@ -322,6 +318,7 @@
 	stw	r7,8(r3)
 	stw	r8,12(r3)
 	stwu	r9,16(r3)
+#endif
 	bdnz	1b
 	blr

diff -urN linux-2.3.99-pre5/arch/ppc/lib/string.S linux-2.3.99-pre5-dm/arch/ppc/lib/string.S
--- linux-2.3.99-pre5/arch/ppc/lib/string.S	Mon Mar  6 09:18:54 2000
+++ linux-2.3.99-pre5-dm/arch/ppc/lib/string.S	Tue Apr 18 09:04:35 2000
@@ -9,14 +9,10 @@
  * 2 of the License, or (at your option) any later version.
  */
 #include "../kernel/ppc_asm.tmpl"
+#include <asm/cache.h>
 #include <asm/processor.h>
 #include <asm/errno.h>

-CACHELINE_BYTES = 32
-LG_CACHELINE_BYTES = 5
-CACHELINE_MASK = 0x1f
-CACHELINE_WORDS = 8
-
 	.globl	strcpy
 strcpy:
 	addi	r5,r3,-1
@@ -92,12 +88,12 @@
 	andi.	r0,r6,3
 	add	r5,r0,r5
 	subf	r6,r0,r6
-	clrlwi	r7,r6,32-LG_CACHELINE_BYTES
+	clrlwi	r7,r6,32-L1_CACHE_SHIFT
 	add	r8,r7,r5
-	srwi	r9,r8,LG_CACHELINE_BYTES
+	srwi	r9,r8,L1_CACHE_SHIFT
 	addic.	r9,r9,-1	/* total number of complete cachelines */
 	ble	2f
-	xori	r0,r7,CACHELINE_MASK & ~3
+	xori	r0,r7,L1_CACHE_MASK & ~3
 	srwi.	r0,r0,2
 	beq	3f
 	mtctr	r0
@@ -106,9 +102,9 @@
 3:	mtctr	r9
 	li	r7,4
 10:	dcbz	r7,r6
-	addi	r6,r6,CACHELINE_BYTES
+	addi	r6,r6,L1_CACHE_BYTES
 	bdnz	10b
-	clrlwi	r5,r8,32-LG_CACHELINE_BYTES
+	clrlwi	r5,r8,32-L1_CACHE_SHIFT
 	addi	r5,r5,4
 2:	srwi	r0,r5,2
 	mtctr	r0
@@ -176,7 +172,7 @@
 	addi	r4,r4,-4
 	addi	r6,r3,-4
 	neg	r0,r3
-	andi.	r0,r0,CACHELINE_MASK	/* # bytes to start of cache line */
+	andi.	r0,r0,L1_CACHE_MASK	/* # bytes to start of cache line */
 	beq	58f

 	cmplw	0,r5,r0			/* is this more than total to do? */
@@ -197,8 +193,8 @@
 	stwu	r9,4(r6)
 	bdnz	72b

-58:	srwi.	r0,r5,LG_CACHELINE_BYTES /* # complete cachelines */
-	clrlwi	r5,r5,32-LG_CACHELINE_BYTES
+58:	srwi.	r0,r5,L1_CACHE_SHIFT /* # complete cachelines */
+	clrlwi	r5,r5,32-L1_CACHE_SHIFT
 	li	r11,4
 	mtctr	r0
 	beq	63f
@@ -211,6 +207,7 @@
 	stw	r8,8(r6)
 	stw	r9,12(r6)
 	stwu	r10,16(r6)
+#if (L1_CACHE_BYTES == 32)
 	lwz	r7,4(r4)
 	lwz	r8,8(r4)
 	lwz	r9,12(r4)
@@ -219,6 +216,7 @@
 	stw	r8,8(r6)
 	stw	r9,12(r6)
 	stwu	r10,16(r6)
+#endif
 	bdnz	53b

 63:	srwi.	r0,r5,2
@@ -356,7 +354,7 @@
 	addi	r4,r4,-4
 	addi	r6,r3,-4
 	neg	r0,r3
-	andi.	r0,r0,CACHELINE_MASK	/* # bytes to start of cache line */
+	andi.	r0,r0,L1_CACHE_MASK	/* # bytes to start of cache line */
 	beq	58f

 	cmplw	0,r5,r0			/* is this more than total to do? */
@@ -377,12 +375,15 @@
 73:	stwu	r9,4(r6)
 	bdnz	72b

-58:	srwi.	r0,r5,LG_CACHELINE_BYTES /* # complete cachelines */
-	clrlwi	r5,r5,32-LG_CACHELINE_BYTES
+58:	srwi.	r0,r5,L1_CACHE_SHIFT /* # complete cachelines */
+	clrlwi	r5,r5,32-L1_CACHE_SHIFT
 	li	r11,4
 	mtctr	r0
 	beq	63f
-53:	dcbz	r11,r6
+53:
+#if !defined(CONFIG_8xx)
+	dcbz	r11,r6
+#endif
 10:	lwz	r7,4(r4)
 11:	lwz	r8,8(r4)
 12:	lwz	r9,12(r4)
@@ -391,6 +392,7 @@
 15:	stw	r8,8(r6)
 16:	stw	r9,12(r6)
 17:	stwu	r10,16(r6)
+#if (L1_CACHE_BYTES == 32)
 20:	lwz	r7,4(r4)
 21:	lwz	r8,8(r4)
 22:	lwz	r9,12(r4)
@@ -399,6 +401,7 @@
 25:	stw	r8,8(r6)
 26:	stw	r9,12(r6)
 27:	stwu	r10,16(r6)
+#endif
 	bdnz	53b

 63:	srwi.	r0,r5,2
@@ -434,17 +437,21 @@
 103:	li	r4,1
 91:	li	r3,2
 	b	99f
+#if (L1_CACHE_BYTES == 32)
 /* read fault in 2nd half of cacheline loop */
 106:	addi	r5,r5,-16
+#endif
 /* read fault in 1st half of cacheline loop */
 104:	li	r4,0
 	b	92f
+#if (L1_CACHE_BYTES == 32)
 /* write fault in 2nd half of cacheline loop */
 107:	addi	r5,r5,-16
+#endif
 /* fault on dcbz (effectively a write fault) */
 /* or write fault in 1st half of cacheline loop */
 105:	li	r4,1
-92:	li	r3,LG_CACHELINE_BYTES
+92:	li	r3,L1_CACHE_SHIFT
 	b	99f
 /* read fault in final word loop */
 108:	li	r4,0
@@ -500,6 +507,7 @@
 	.long	15b,105b
 	.long	16b,105b
 	.long	17b,105b
+#if (L1_CACHE_BYTES == 32)
 	.long	20b,106b
 	.long	21b,106b
 	.long	22b,106b
@@ -508,6 +516,7 @@
 	.long	25b,107b
 	.long	26b,107b
 	.long	27b,107b
+#endif
 	.long	30b,108b
 	.long	31b,109b
 	.long	40b,110b
diff -urN linux-2.3.99-pre5/include/asm-ppc/cache.h linux-2.3.99-pre5-dm/include/asm-ppc/cache.h
--- linux-2.3.99-pre5/include/asm-ppc/cache.h	Tue Dec 21 10:51:04 1999
+++ linux-2.3.99-pre5-dm/include/asm-ppc/cache.h	Tue Apr 18 10:27:55 2000
@@ -5,12 +5,16 @@
 #define __ARCH_PPC_CACHE_H

 #include <linux/config.h>
-#include <asm/processor.h>

 /* bytes per L1 cache line */
-#define        L1_CACHE_BYTES  32
+#if defined(CONFIG_4xx) || defined(CONFIG_8xx)
+#define        L1_CACHE_SHIFT  4
+#else
+#define        L1_CACHE_SHIFT  5
+#endif
+#define	       L1_CACHE_BYTES  (1<<L1_CACHE_SHIFT)
+#define	       L1_CACHE_MASK   (L1_CACHE_BYTES-1)
 #define        L1_CACHE_ALIGN(x)       (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
-#define L1_CACHE_PAGES		8

 #define        SMP_CACHE_BYTES L1_CACHE_BYTES

diff -urN linux-2.3.99-pre5/include/asm-ppc/page.h linux-2.3.99-pre5-dm/include/asm-ppc/page.h
--- linux-2.3.99-pre5/include/asm-ppc/page.h	Thu Apr  6 10:00:54 2000
+++ linux-2.3.99-pre5-dm/include/asm-ppc/page.h	Tue Apr 18 10:02:11 2000
@@ -5,7 +5,11 @@

 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
+#ifndef __ASSEMBLY__
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
+#else
+#define PAGE_SIZE	(1 << PAGE_SHIFT)
+#endif
 #define PAGE_MASK	(~(PAGE_SIZE-1))

 #define PAGE_OFFSET	0xc0000000

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
