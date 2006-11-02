Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 14E0D67CCA
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 00:37:36 +1100 (EST)
Message-Id: <20061102125629.771962000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
Date: Thu, 02 Nov 2006 13:56:09 +0100
From: s.hauer@pengutronix.de
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 14/16] powerpc: make initialization of OF hooks dependent
	on PPC_OF
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make initialization of OF hooks dependent on PPC_OF, not on MULTIPLATFORM

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: arch/powerpc/kernel/head_32.S
===================================================================
--- a/arch/powerpc/kernel/head_32.S.orig
+++ b/arch/powerpc/kernel/head_32.S
@@ -119,7 +119,7 @@ __start:
  * because OF may have I/O devices mapped into that area
  * (particularly on CHRP).
  */
-#ifdef CONFIG_PPC_MULTIPLATFORM
+#ifdef CONFIG_PPC_OF
 	cmpwi	0,r5,0
 	beq	1f
 	bl	prom_init

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
