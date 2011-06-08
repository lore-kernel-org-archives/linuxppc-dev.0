Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE008.bigfish.com (ch1ehsobe001.messaging.microsoft.com
	[216.32.181.181]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 426F6B6FD3
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jun 2011 06:02:06 +1000 (EST)
Received: from mail197-ch1 (localhost.localdomain [127.0.0.1])	by
	mail197-ch1-R.bigfish.com (Postfix) with ESMTP id EDA6F17B04EA	for
	<linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2011 20:02:02 +0000 (UTC)
Received: from CH1EHSMHS025.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.252])	by mail197-ch1.bigfish.com (Postfix) with ESMTP id
	C68B67804B
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2011 20:02:02 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: powerpc/p1022ds: add missing iounmap calls to platform file
Date: Wed, 8 Jun 2011 15:01:57 -0500
Message-ID: <1307563317-13009-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The platform file for the Freecale P1022DS reference board is not freeing
the ioremap() mapping of the PIXIS and global utilities nodes it creates.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/85xx/p1022_ds.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 7eb5c40..e083e1f 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -129,6 +129,7 @@ static void p1022ds_set_gamma_table(int monitor_port, char *gamma_table_base)
 static void p1022ds_set_monitor_port(int monitor_port)
 {
 	struct device_node *pixis_node;
+	void __iomem *pixis;
 	u8 __iomem *brdcfg1;
 
 	pixis_node = of_find_compatible_node(NULL, NULL, "fsl,p1022ds-pixis");
@@ -137,12 +138,12 @@ static void p1022ds_set_monitor_port(int monitor_port)
 		return;
 	}
 
-	brdcfg1 = of_iomap(pixis_node, 0);
-	if (!brdcfg1) {
+	pixis = of_iomap(pixis_node, 0);
+	if (!pixis) {
 		pr_err("p1022ds: could not map ngPIXIS registers\n");
 		return;
 	}
-	brdcfg1 += 9;	/* BRDCFG1 is at offset 9 in the ngPIXIS */
+	brdcfg1 = pixis + 9;	/* BRDCFG1 is at offset 9 in the ngPIXIS */
 
 	switch (monitor_port) {
 	case 0: /* DVI */
@@ -158,6 +159,8 @@ static void p1022ds_set_monitor_port(int monitor_port)
 	default:
 		pr_err("p1022ds: unsupported monitor port %i\n", monitor_port);
 	}
+
+	iounmap(pixis);
 }
 
 /**
@@ -201,6 +204,8 @@ void p1022ds_set_pixel_clock(unsigned int pixclock)
 
 	/* Enable the clock and set the pxclk */
 	setbits32(&guts->clkdvdr, CLKDVDR_PXCKEN | (pxclk << 16));
+
+	iounmap(guts);
 }
 
 /**
-- 
1.7.3.4
