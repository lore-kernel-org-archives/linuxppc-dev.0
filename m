Return-Path: <SRS0=LhWK=TL=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id E4BEFDDE1B
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 19:32:58 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] AMCC Kilauea (405EX): Disable EMAC loopback mode
Date: Fri, 22 Feb 2008 09:32:12 +0100
Message-Id: <1203669132-9385-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

405EX(r) has SDR0_MFR[E0CS/E1CS] set after reset. This selects
the internal loopback mode. Clear these bits so that both EMACs
don't use loopback mode as default.

Signed-off-by: Stefan Roese <sr@denx.de>
---
I'm not sure if this should be done here in the board platform code,
or in the newemac driver or perhaps in some code common for 405EX.

Any thoughts on this welcome.

Thanks.

 arch/powerpc/platforms/40x/kilauea.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/40x/kilauea.c b/arch/powerpc/platforms/40x/kilauea.c
index f9206a7..b5456cc 100644
--- a/arch/powerpc/platforms/40x/kilauea.c
+++ b/arch/powerpc/platforms/40x/kilauea.c
@@ -1,7 +1,7 @@
 /*
  * Kilauea board specific routines
  *
- * Copyright 2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ * Copyright 2007-2008 DENX Software Engineering, Stefan Roese <sr@denx.de>
  *
  * Based on the Walnut code by
  * Josh Boyer <jwboyer@linux.vnet.ibm.com>
@@ -20,6 +20,8 @@
 #include <asm/time.h>
 #include <asm/uic.h>
 #include <asm/pci-bridge.h>
+#include <asm/dcr.h>
+#include <asm/dcr-regs.h>
 
 static __initdata struct of_device_id kilauea_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
@@ -45,6 +47,13 @@ static int __init kilauea_probe(void)
 
 	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
 
+	/*
+	 * 405EX(r) has SDR0_MFR[E0CS/E1CS] set after reset. This selects
+	 * the internal loopback mode. Clear these bits so that both EMACs
+	 * don't use loopback mode as deafult.
+	 */
+	mtdcri(SDR0, SDR0_MFR, mfdcri(SDR0, SDR0_MFR) & ~0x0c000000);
+
 	return 1;
 }
 
-- 
1.5.4.2
