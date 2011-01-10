Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8862DB734F
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 08:38:16 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 05/13] 8xx: Update TLB asm so it behaves as linux mm expects.
Date: Mon, 10 Jan 2011 22:37:51 +0100
Message-Id: <1294695479-344-6-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the TLB asm to make proper use of _PAGE_DIRTY and _PAGE_ACCESSED.
Get rid of _PAGE_HWWRITE too.
Pros:
  - PRESENT is copied to ACCESSED, fixing accounting
  - DIRTY is mapped to 0x100, the changed bit, and is set directly
    when a page has been made dirty.
  - Proper RO/RW mapping of user space.
  - Free up 2 SW TLB bits in the linux pte(add back _PAGE_WRITETHRU ?)
  - kernel RO/user NA support. Not sure this is really needed, would save
    a few insn if not required.
Cons:
  - A few more instructions in the DTLB Miss routine.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |   53 ++++++++++++++++++++++++++-----------------
 include/asm-ppc/pgtable.h  |   15 +++++------
 2 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 5269e5b..9eb383b 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -361,25 +361,27 @@ InstructionTLBMiss:
 	 */
 	tophys(r21,r21)
 	ori	r21,r21,1		/* Set valid bit */
-	beq-	2f			/* If zero, don't try to find a pte */
 	DO_8xx_CPU6(0x2b80, r3)
 	mtspr	MI_TWC, r21	/* Set segment attributes */
+	beq-	2f		/* If zero, don't try to find a pte */
 	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r21	/* Load pte table base address */
 	mfspr	r21, MD_TWC	/* ....and get the pte address */
 	lwz	r20, 0(r21)	/* Get the pte */
 
-	ori	r20, r20, _PAGE_ACCESSED
-	stw	r20, 0(r21)
-
+#if 1
+	/* if !swap, you can delete this */
+	rlwimi	r20, r20, 5, _PAGE_PRESENT<<5	/* Copy PRESENT to ACCESSED */
+	stw	r20, 0(r21)	/* Update pte */
+#endif
 	/* The Linux PTE won't go exactly into the MMU TLB.
-	 * Software indicator bits 21, 22 and 28 must be clear.
+	 * Software indicator bits 21 and 28 must be clear.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
 2:	li	r21, 0x00f0
-	rlwimi	r20, r21, 0, 24, 28	/* Set 24-27, clear 28 */
+	rlwimi	r20, r21, 0, 0x07f8	/* Set 24-27, clear 21-23,28 */
 	DO_8xx_CPU6(0x2d80, r3)
 	mtspr	MI_RPN, r20	/* Update TLB entry */
 
@@ -436,12 +438,25 @@ DataStoreTLBMiss:
 	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r21
 
-	mfspr	r21, MD_TWC	/* get the pte address again */
-	ori	r20, r20, _PAGE_ACCESSED
-	stw	r20, 0(r21)
+#if 1
+	/* if !swap, you can delete this */
+	mfspr	r21, MD_TWC	/* get the pte address */
+	rlwimi	r20, r20, 5, _PAGE_PRESENT<<5	/* Copy PRESENT to ACCESSED */
+	stw	r20, 0(r21)	/* Update pte */
+#endif
+
+	/* Honour kernel RO, User NA */
+	/* 0x200 == Extended encoding, bit 22 */
+	/* r20 |=  (r20 & _PAGE_USER) >> 2 */
+	rlwimi	r20, r20, 32-2, 0x200
+	/* r21 =  (r20 & _PAGE_RW) >> 1 */
+	rlwinm	r21, r20, 32-1, 0x200
+	or	r20, r21, r20
+	/* invert RW and 0x200 bits */
+	xori	r20, r20, _PAGE_RW | 0x200
 
 	/* The Linux PTE won't go exactly into the MMU TLB.
-	 * Software indicator bits 21, 22 and 28 must be clear.
+	 * Software indicator bits 22 and 28 must be clear.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
@@ -488,11 +503,12 @@ DataTLBError:
 	stw	r20, 0(r0)
 	stw	r21, 4(r0)
 
-	/* First, make sure this was a store operation.
-	*/
 	mfspr	r20, DSISR
-	andis.	r21, r20, 0x0200	/* If set, indicates store op */
-	beq	2f
+	andis.	r21, r20, 0x4800	/* !translation or protection */
+	bne-	2f
+	/* Only Change bit left now, do it here as it is faster
+	 * than trapping to the C fault handler.
+ 	 */
 
 	/* The EA of a data TLB miss is automatically stored in the MD_EPN
 	 * register.  The EA of a data TLB error is automatically stored in
@@ -542,17 +558,12 @@ DataTLBError:
 	mfspr	r21, MD_TWC		/* ....and get the pte address */
 	lwz	r20, 0(r21)		/* Get the pte */
 
-	andi.	r21, r20, _PAGE_RW	/* Is it writeable? */
-	beq	2f			/* Bail out if not */
-
-	/* Update 'changed', among others.
-	*/
 	ori	r20, r20, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
-	mfspr	r21, MD_TWC		/* Get pte address again */
 	stw	r20, 0(r21)		/* and update pte in table */
+	xori	r20, r20, _PAGE_RW	/* RW bit is inverted */
 
 	/* The Linux PTE won't go exactly into the MMU TLB.
-	 * Software indicator bits 21, 22 and 28 must be clear.
+	 * Software indicator bits 22 and 28 must be clear.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
diff --git a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
index 71b2165..2ba37d3 100644
--- a/include/asm-ppc/pgtable.h
+++ b/include/asm-ppc/pgtable.h
@@ -298,21 +298,20 @@ extern unsigned long vmalloc_start;
 #define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
 #define _PAGE_SHARED	0x0004	/* No ASID (context) compare */
 
-/* These five software bits must be masked out when the entry is loaded
- * into the TLB.
+/* These three software bits must be masked out when the entry is loaded
+ * into the TLB, 2 SW bits free.
  */
 #define _PAGE_EXEC	0x0008	/* software: i-cache coherency required */
 #define _PAGE_GUARDED	0x0010	/* software: guarded access */
-#define _PAGE_DIRTY	0x0020	/* software: page changed */
-#define _PAGE_RW	0x0040	/* software: user write access allowed */
-#define _PAGE_ACCESSED	0x0080	/* software: page referenced */
+#define _PAGE_ACCESSED	0x0020	/* software: page referenced */
 
 /* Setting any bits in the nibble with the follow two controls will
  * require a TLB exception handler change.  It is assumed unused bits
- * are always zero.
+ * are always zero, encoding(bit 22).
  */
-#define _PAGE_HWWRITE	0x0100	/* h/w write enable: never set in Linux PTE */
-#define _PAGE_USER	0x0800	/* One of the PP bits, the other is USER&~RW */
+#define _PAGE_DIRTY	0x0100	/* Changed: page changed */
+#define _PAGE_RW	0x0400	/* PP lsb(bit 21), user write access allowed */
+#define _PAGE_USER	0x0800	/* PP msb(bit 20), user access allowed */
 
 #define _PMD_PRESENT	PAGE_MASK
 #define _PMD_PAGE_MASK	0x000c
-- 
1.7.3.4
