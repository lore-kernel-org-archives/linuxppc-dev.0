Message-Id: <200004121138.HAA05150@hoover.gilbarco.com>
From: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
To: "'Peter Allworth'" <linsol@zeta.org.au>
Cc: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Low Memory / Software Emulation Exception / Performance
Date: Wed, 12 Apr 2000 07:38:29 -0400
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01BFA473.9FF19B0E"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01BFA473.9FF19B0E
Content-Type: text/plain;
	charset="iso-8859-1"

Peter,

Attached is the patch file you requested, this should bring the head.S
distributed in mpc8xx-2.2.13 up-to-date with the dirty page fix.

Thanks,
Jason


------_=_NextPart_000_01BFA473.9FF19B0E
Content-Type: application/octet-stream;
	name="mpc8xx-2.2.13-page-patch"
Content-Disposition: attachment;
	filename="mpc8xx-2.2.13-page-patch"

--- head.S.orig	Mon Apr 10 10:33:28 2000
+++ head.S	Tue Apr 11 14:59:54 2000
@@ -1,7 +1,7 @@
 /*
  *  arch/ppc/kernel/head.S
  *
- *  $Id: head.S,v 1.1.1.1 2000/01/03 15:56:48 jason Exp $
+ *  $Id: head.S,v 1.4 2000/04/11 18:59:54 jason Exp $
  *
  *  PowerPC version
  *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
@@ -901,8 +901,16 @@
 	ori	r21,r21,1		/* Set valid bit */
 	mtspr	MI_TWC, r21	/* Set page attributes */
 	mtspr	MD_TWC, r21	/* Load pte table base address */
-	mfspr	r21, MD_TWC	/* ....and get the pte address */
-	lwz	r21, 0(r21)	/* Get the pte */
+	/* mfspr	r21, MD_TWC	*/ /* ....and get the pte address */
+	/* lwz	r21, 0(r21)	*/ /* Get the pte */
+	mfspr	r20, MD_TWC		/* ....and get the pte address */
+	lwz	r21, 0(r20)			/* Get the pte */
+	andi.	r21, r21, _PAGE_PRESENT		/* Set cr0 if it's invalid */
+	lwz	r21, 0(r20)			/* Get the pte again */
+	beq	3f				/* Skip update if invalid */
+	ori	r21, r21, _PAGE_ACCESSED	/* Set the accessed flag */
+	stw	r21, 0(r20)			/* Update the pte */
+3:

 	/* Set four subpage valid bits (24, 25, 26, and 27).
 	 * Since we currently run MI_CTR.PPCS = 0, the manual says,
@@ -1024,6 +1032,18 @@
 	ori	r21, r21, 1	/* Set valid bit in physical L2 page */
 	mtspr	MD_TWC, r21	/* Load pte table base address */
 	mfspr	r21, MD_TWC	/* ....and get the pte address */
+	lwz	r20, 0(r21)			/* Get the pte */
+	andi.	r20, r20, _PAGE_PRESENT		/* Set cr0 if it's invalid */
+	beq	4f				/* Skip update if invalid */
+	mfspr	r20, DSISR			/* Check for store op */
+	andis.	r20, r20, 0x0200		/* If set, indicates store */
+	lwz	r20, 0(r21)			/* Get the pte again */
+	beq	3f
+	ori	r20, r20, _PAGE_DIRTY|_PAGE_HWWRITE /* Set the dirty flags */
+3:
+	ori	r20, r20, _PAGE_ACCESSED	/* Set the accessed flag */
+	stw	r20, 0(r21)			/* Update the pte */
+4:
 	lwz	r21, 0(r21)	/* Get the pte */

 	/* Set four subpage valid bits (24, 25, 26, and 27).
@@ -1113,7 +1133,8 @@
 	andi.	r20, r21, _PAGE_RW	/* Is it writeable? */
 	beq	2f			/* Bail out if not */

-	ori	r21, r21, _PAGE_DIRTY	/* Update changed bit */
+	/* ori	r21, r21, _PAGE_DIRTY */	/* Update changed bit */
+	ori	r21, r21, _PAGE_DIRTY|_PAGE_HWWRITE|_PAGE_ACCESSED
 	mfspr	r20, MD_TWC		/* Get pte address again */
 	stw	r21, 0(r20)		/* and update pte in table */


------_=_NextPart_000_01BFA473.9FF19B0E--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
