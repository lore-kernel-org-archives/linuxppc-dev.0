Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E4AAB7B80
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 07:46:12 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>, Scott Wood <scottwood@freescale.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
Date: Wed, 7 Oct 2009 22:46:00 +0200
Message-Id: <1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the TLB asm to make proper use of _PAGE_DIRY and _PAGE_ACCESSED.
Pros:
 - I/D TLB Miss never needs to write to the linux pte.
 - _PAGE_ACCESSED is only set on TLB Error fixing accounting
 - _PAGE_DIRTY is mapped to 0x100, the changed bit, and is set directly
    when a page has been made dirty.
 - Proper RO/RW mapping of user space.
 - Free up 2 SW TLB bits in the linux pte(add back _PAGE_WRITETHRU ?)
Cons:
 - 1 more instructions in I/D TLB Miss, but the since the linux pte is
   not written anymore, it should still be a big win.
---
 arch/powerpc/include/asm/pte-8xx.h |   13 +++---
 arch/powerpc/kernel/head_8xx.S     |   82 ++++++++++++++++--------------------
 2 files changed, 43 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-8xx.h b/arch/powerpc/include/asm/pte-8xx.h
index 8c6e312..f23cd15 100644
--- a/arch/powerpc/include/asm/pte-8xx.h
+++ b/arch/powerpc/include/asm/pte-8xx.h
@@ -32,22 +32,21 @@
 #define _PAGE_FILE	0x0002	/* when !present: nonlinear file mapping */
 #define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
 #define _PAGE_SHARED	0x0004	/* No ASID (context) compare */
+#define _PAGE_DIRTY	0x0100	/* C: page changed */
 
-/* These five software bits must be masked out when the entry is loaded
- * into the TLB.
+/* These 3 software bits must be masked out when the entry is loaded
+ * into the TLB, 2 SW bits left.
  */
 #define _PAGE_EXEC	0x0008	/* software: i-cache coherency required */
 #define _PAGE_GUARDED	0x0010	/* software: guarded access */
-#define _PAGE_DIRTY	0x0020	/* software: page changed */
-#define _PAGE_RW	0x0040	/* software: user write access allowed */
-#define _PAGE_ACCESSED	0x0080	/* software: page referenced */
+#define _PAGE_ACCESSED	0x0020	/* software: page referenced */
 
 /* Setting any bits in the nibble with the follow two controls will
  * require a TLB exception handler change.  It is assumed unused bits
  * are always zero.
  */
-#define _PAGE_HWWRITE	0x0100	/* h/w write enable: never set in Linux PTE */
-#define _PAGE_USER	0x0800	/* One of the PP bits, the other is USER&~RW */
+#define _PAGE_RW	0x0400	/* lsb PP bits, inverted in HW */
+#define _PAGE_USER	0x0800	/* msb PP bits */
 
 #define _PMD_PRESENT	0x0001
 #define _PMD_BAD	0x0ff0
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 118bb05..3cf1289 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -333,26 +333,18 @@ InstructionTLBMiss:
 	mfspr	r11, SPRN_MD_TWC	/* ....and get the pte address */
 	lwz	r10, 0(r11)	/* Get the pte */
 
-#ifdef CONFIG_SWAP
-	/* do not set the _PAGE_ACCESSED bit of a non-present page */
-	andi.	r11, r10, _PAGE_PRESENT
-	beq	4f
-	ori	r10, r10, _PAGE_ACCESSED
-	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
-	stw	r10, 0(r11)
-4:
-#else
-	ori	r10, r10, _PAGE_ACCESSED
-	stw	r10, 0(r11)
-#endif
+	andi.	r11, r10, _PAGE_USER | _PAGE_ACCESSED
+	cmpwi	cr0, r11, _PAGE_USER | _PAGE_ACCESSED
+	bne-	cr0, 2f
+	/* Dont' bother with PP lsb, bit 21 for now */
 
 	/* The Linux PTE won't go exactly into the MMU TLB.
-	 * Software indicator bits 21, 22 and 28 must be clear.
+	 * Software indicator bits 22 and 28 must be clear.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
-2:	li	r11, 0x00f0
+	li	r11, 0x00f0
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x2d80, r3)
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
@@ -365,6 +357,19 @@ InstructionTLBMiss:
 	lwz	r3, 8(r0)
 #endif
 	rfi
+2:
+	mfspr	r11, SRR1
+	rlwinm	r11, r11, 0, 5, 3 /* clear guarded */
+	mtspr	SRR1, r11
+
+	mfspr	r10, SPRN_M_TW	/* Restore registers */
+	lwz	r11, 0(r0)
+	mtcr	r11
+	lwz	r11, 4(r0)
+#ifdef CONFIG_8xx_CPU6
+	lwz	r3, 8(r0)
+#endif
+	b	InstructionAccess
 
 	. = 0x1200
 DataStoreTLBMiss:
@@ -409,21 +414,14 @@ DataStoreTLBMiss:
 	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	SPRN_MD_TWC, r11
 
-#ifdef CONFIG_SWAP
-	/* do not set the _PAGE_ACCESSED bit of a non-present page */
-	andi.	r11, r10, _PAGE_PRESENT
-	beq	4f
-	ori	r10, r10, _PAGE_ACCESSED
-4:
-	/* and update pte in table */
-#else
-	ori	r10, r10, _PAGE_ACCESSED
-#endif
-	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
-	stw	r10, 0(r11)
+	andi.	r11, r10, _PAGE_ACCESSED
+	bne+	cr0, 5f	/* branch if access allowed */
+	rlwinm	r10, r10, 0, 21, 19 /* Clear _PAGE_USER */
+	ori	r10, r10, _PAGE_RW  /* Set RW bit for xor below to clear it */
+5:	xori	r10, r10, _PAGE_RW  /* invert RW bit */
 
 	/* The Linux PTE won't go exactly into the MMU TLB.
-	 * Software indicator bits 21, 22 and 28 must be clear.
+	 * Software indicator bits 22 and 28 must be clear.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
@@ -472,8 +470,8 @@ DataTLBError:
 	/* First, make sure this was a store operation.
 	*/
 	mfspr	r10, SPRN_DSISR
-	andis.	r11, r10, 0x4800 /* no translation, no permission. */
-	bne	2f	/* branch if either is set */
+	andis.	r11, r10, 0x4000 /* no translation */
+	bne	2f	/* branch if set */
 
 	/* The EA of a data TLB miss is automatically stored in the MD_EPN
 	 * register.  The EA of a data TLB error is automatically stored in
@@ -522,26 +520,20 @@ DataTLBError:
 	mfspr	r11, SPRN_MD_TWC		/* ....and get the pte address */
 	lwz	r10, 0(r11)		/* Get the pte */
 
-	andi.	r11, r10, _PAGE_RW	/* Is it writeable? */
-	beq	2f			/* Bail out if not */
-
-	/* Update 'changed', among others.
-	*/
-#ifdef CONFIG_SWAP
+	mfspr	r11, DSISR
+	andis.	r11, r11, 0x0200	/* store */
+	beq	5f
+	andi.	r11, r10, _PAGE_RW	/* writeable? */
+	beq	2f /* nope */
 	ori	r10, r10, _PAGE_DIRTY|_PAGE_HWWRITE
-	/* do not set the _PAGE_ACCESSED bit of a non-present page */
-	andi.	r11, r10, _PAGE_PRESENT
-	beq	4f
-	ori	r10, r10, _PAGE_ACCESSED
-4:
-#else
-	ori	r10, r10, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
-#endif
-	mfspr	r11, SPRN_MD_TWC		/* Get pte address again */
+5:	ori	r10, r10, _PAGE_ACCESSED
+	mfspr	r11, MD_TWC		/* Get pte address again */
 	stw	r10, 0(r11)		/* and update pte in table */
 
+	xori	r10, r10, _PAGE_RW	/* RW bit is inverted */
+
 	/* The Linux PTE won't go exactly into the MMU TLB.
-	 * Software indicator bits 21, 22 and 28 must be clear.
+	 * Software indicator bits 22 and 28 must be clear.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
-- 
1.6.4.4
