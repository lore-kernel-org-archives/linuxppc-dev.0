Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A6C3686AE
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 07:11:52 +1100 (EST)
Date: Mon, 7 Nov 2005 13:10:11 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20051107151011.GA17161@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: fix swapping on 8xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, 

The following is an attempt to fix swapping on 8xx by not touching
_PAGE_ACCESSED bit if the page is not present.

Dan, what do you think?


diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index de09787..4451828 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -41,6 +41,22 @@
 #else
 #define DO_8xx_CPU6(val, reg)
 #endif
+
+/* can't overwrite the _PAGE_ACCESSED bit of a non-present page (might
+   contain swap data). */
+#ifdef CONFIG_SWAP
+#define SET_PAGE_ACCESSED(reg, destreg, tmpreg)		\
+	andi.	tmpreg, reg, _PAGE_PRESENT;		\
+	beq	9f;					\
+	ori	reg, reg, _PAGE_ACCESSED;		\
+	stw	r10, 0(destreg);			\
+9:
+#else
+#define SET_PAGE_ACCESSED(reg, destreg, tmpreg)	\
+	ori	reg, reg, _PAGE_ACCESSED;	\
+	stw	reg, 0(destreg);
+#endif
+
 	.text
 	.globl	_stext
 _stext:
@@ -332,8 +348,7 @@ InstructionTLBMiss:
 	mfspr	r11, SPRN_MD_TWC	/* ....and get the pte address */
 	lwz	r10, 0(r11)	/* Get the pte */
 
-	ori	r10, r10, _PAGE_ACCESSED
-	stw	r10, 0(r11)
+	SET_PAGE_ACCESSED(r10, r11, r3)
 
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 21, 22 and 28 must be clear.
@@ -399,8 +414,7 @@ DataStoreTLBMiss:
 	mtspr	SPRN_MD_TWC, r11
 
 	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
-	ori	r10, r10, _PAGE_ACCESSED
-	stw	r10, 0(r11)
+	SET_PAGE_ACCESSED(r10, r11, r3)	/* and update pte in table */
 
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 21, 22 and 28 must be clear.
@@ -507,9 +521,9 @@ DataTLBError:
 
 	/* Update 'changed', among others.
 	*/
-	ori	r10, r10, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
+	ori	r10, r10, _PAGE_DIRTY|_PAGE_HWWRITE
 	mfspr	r11, SPRN_MD_TWC		/* Get pte address again */
-	stw	r10, 0(r11)		/* and update pte in table */
+	SET_PAGE_ACCESSED(r10, r11, r3)		/* and update pte in table */
 
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 21, 22 and 28 must be clear.
