Return-Path: <Ofer.Eyal@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id F12E767A7B
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Jan 2005 19:53:27 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	j0U5ouGH005848 for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jan 2005 22:50:56 -0700 (MST)
Received: from zil05exm01.ea.freescale.net (zil05exm01.ea.freescale.net
	[216.3.95.200])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id j0U5p0aB000449
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jan 2005 23:51:02 -0600 (CST)
Message-ID: <D39C8B3D64A0D511A61E00D0B7828EEA12056408@zil05exm01.ea.freescale.net>
From: Eyal Ofer-R55413 <Ofer.Eyal@freescale.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Sun, 30 Jan 2005 07:50:33 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: ppc 8260 ethernet driver fails to put port into promiscuous or mu
	lticast modes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hello,

1. the function in the ppc 8260 ethernet driver that's suppose to put the interface into promiscuous or multicast modes contains a 'return' statement immediately at the beginning. this prevents running an 8260-based system as a bridge for example. the 'return' statement is not indented, and there's no comment to explain it. it is unclear if it was forgotten there by the writer or whether it serves some functional role (improve performance for other modes of operations, cover up for untested code later, etc.). removing it does not seem to hurt the operation of the system though. unless there's a known use for this 'return', i would like to suggest the following patch (demonstrated here for 2.4.22):


--- fcc_enet.c.orig	Thu Jan 27 07:56:35 2005
+++ fcc_enet.c	Thu Jan 27 07:57:00 2005
@@ -1080,7 +1080,6 @@
 
 	cep = (struct fcc_enet_private *)dev->priv;
 
-return;
 	/* Get pointer to FCC area in parameter RAM.
 	*/
 	ep = (fcc_enet_t *)dev->base_addr;



problem persists ever since the driver's introduction into the 2.4.0-test9-pre2 kernel and up to it's latest version in 2.6.10

path to problem:
early 2.4.x and all 2.6.x:
	arch/ppc/8260_io/fcc_enet.c
later 2.4.2x (at least 2.4.26 and on):
	arc/ppc/cpm_io/fcc_enet.c

problem in function: set_multicast_list()


2. please CC me personally on answer as i'm not a subscriber on the lkml.


best regards,
ofer eyal
Metrowerks - Freescale Semiconductor Israel
Tel +972-9-952-2504  Fax +972-9-952-2890
freescale semiconductor general business use
