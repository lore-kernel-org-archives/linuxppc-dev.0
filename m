Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [213.68.230.225])
	by ozlabs.org (Postfix) with ESMTP id D04A367A8E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 02:03:11 +1100 (EST)
Received: from tq-mailsrv-1.tq-net.de (tq-mailsrv-1 [172.20.1.1])
	by mail.tqs.de (Postfix) with ESMTP id 7BD723C66
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 16:03:09 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 23 Feb 2005 16:03:09 +0100
Message-ID: <DE2CC66C40EAB74EA6D66AC71BF98E1E03055B9F@TQ-MAILSRV-1>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: "Caruso, Nick" <ncaruso@irobot.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: AW: mpc5200: "len bad" messages from tftp (u-boot 1.1.1)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Caruso

linuxppc-embedded-bounces@ozlabs.org wrote on Mittwoch, 23. Februar
2005 15:12:=20
> We are seeing repeated errors during downloads using the tftp client
> built into u-boot version 1.1.1.

This is not the correct mailing list for U-Boot related questions.
Please use the u-boot users list (u-boot-users@lists.sourceforge.net)
next time.

Attached is a patch for the mpc5xxx FEC driver, which fixes a variable-
not-defined-as-volatile bug. I had similar Problems with the tftp =
command
and this patch helps. The patch ist against top of cvs. Wolfgang Denk=20
sends it to me last week, so I am a bit surprised, that it didn't find=20
its way into cvs, yet.

Regards,
Martin

Index: cpu/mpc5xxx/fec.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/u-boot/u-boot/cpu/mpc5xxx/fec.c,v
retrieving revision 1.18
diff -u -r1.18 fec.c
--- cpu/mpc5xxx/fec.c	16 Dec 2004 15:52:41 -0000	1.18
+++ cpu/mpc5xxx/fec.c	16 Feb 2005 09:16:55 -0000
@@ -115,7 +115,7 @@
 }
=20
 /********************************************************************/
-static void mpc5xxx_fec_rbd_clean(mpc5xxx_fec_priv *fec, FEC_RBD * =
pRbd)
+static void mpc5xxx_fec_rbd_clean(mpc5xxx_fec_priv *fec, volatile =
FEC_RBD * pRbd)
 {
 	/*
 	 * Reset buffer descriptor as empty
@@ -141,7 +141,7 @@
 /********************************************************************/
 static void mpc5xxx_fec_tbd_scrub(mpc5xxx_fec_priv *fec)
 {
-	FEC_TBD *pUsedTbd;
+	volatile FEC_TBD *pUsedTbd;
=20
 #if (DEBUG & 0x1)
 	printf ("tbd_scrub: fec->cleanTbdNum =3D %d, fec->usedTbdIndex =3D =
%d\n",
@@ -354,10 +354,10 @@
 	/*
 	 * Initialize SmartDMA parameters stored in SRAM
 	 */
-	*(int *)FEC_TBD_BASE =3D (int)fec->tbdBase;
-	*(int *)FEC_RBD_BASE =3D (int)fec->rbdBase;
-	*(int *)FEC_TBD_NEXT =3D (int)fec->tbdBase;
-	*(int *)FEC_RBD_NEXT =3D (int)fec->rbdBase;
+	*(volatile int *)FEC_TBD_BASE =3D (int)fec->tbdBase;
+	*(volatile int *)FEC_RBD_BASE =3D (int)fec->rbdBase;
+	*(volatile int *)FEC_TBD_NEXT =3D (int)fec->tbdBase;
+	*(volatile int *)FEC_RBD_NEXT =3D (int)fec->rbdBase;
=20
 	/*
 	 * Enable FEC-Lite controller
@@ -688,7 +688,7 @@
 	 * 6-byte Ethernet addresses.
 	 */
 	mpc5xxx_fec_priv *fec =3D (mpc5xxx_fec_priv *)dev->priv;
-	FEC_TBD *pTbd;
+	volatile FEC_TBD *pTbd;
=20
 #if (DEBUG & 0x20)
 	printf("tbd status: 0x%04x\n", fec->tbdBase[0].status);
@@ -779,7 +779,7 @@
 	 * This command pulls one frame from the card
 	 */
 	mpc5xxx_fec_priv *fec =3D (mpc5xxx_fec_priv *)dev->priv;
-	FEC_RBD *pRbd =3D &fec->rbdBase[fec->rbdIndex];
+	volatile FEC_RBD *pRbd =3D &fec->rbdBase[fec->rbdIndex];
 	unsigned long ievent;
 	int frame_length, len =3D 0;
 	NBUF *frame;
