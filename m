Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1669DB6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Oct 2010 18:28:46 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[10.96.97.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 12D11D2FC6
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Oct 2010 09:22:00 +0200 (CEST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mpc5200: MPC5200 ATA driver requires BMDMA to be
	configured
MIME-Version: 1.0
Message-ID: <201010250921.59640.roman.fietze@telemotive.de>
Date: Mon, 25 Oct 2010 09:21:59 +0200
Content-Type: text/plain;
  charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello List Members,

I updated to v2.6.34 from torvalds/master.

While playing around with ATA settings (I have problems with MWDMA2 on
a Lite5200B compatible board, the problems are not related to this
patch here), I also turned off BMDMA, which caused compile errors on
pata_mpc52xx. So my question is, is the patch below correct? Should we
only offer the pata_mpc52xx if BMDMA is configured?


Subject: [PATCH] powerpc/mpc5200: MPC5200 ATA driver requires BMDMA to be 
configured

The driver uses e.g. bmdma_setup which is only available with
ATA_BMDMA beeing configured.

Move the configuration of the driver pata_mpc52xx down in Kconfig to
the section "PATA SFF controllers with BMDMA".

Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
---
 drivers/ata/Kconfig |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 11ec911..85756b8 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -128,16 +128,6 @@ config PDC_ADMA
 
 	  If unsure, say N.
 
-config PATA_MPC52xx
-	tristate "Freescale MPC52xx SoC internal IDE"
-	depends on PPC_MPC52xx && PPC_BESTCOMM
-	select PPC_BESTCOMM_ATA
-	help
-	  This option enables support for integrated IDE controller
-	  of the Freescale MPC52xx SoC.
-
-	  If unsure, say N.
-
 config PATA_OCTEON_CF
 	tristate "OCTEON Boot Bus Compact Flash support"
 	depends on CPU_CAVIUM_OCTEON
@@ -491,6 +481,16 @@ config PATA_MARVELL
 
 	  If unsure, say N.
 
+config PATA_MPC52xx
+	tristate "Freescale MPC52xx SoC internal IDE"
+	depends on PPC_MPC52xx && PPC_BESTCOMM
+	select PPC_BESTCOMM_ATA
+	help
+	  This option enables support for integrated IDE controller
+	  of the Freescale MPC52xx SoC.
+
+	  If unsure, say N.
+
 config PATA_NETCELL
 	tristate "NETCELL Revolution RAID support"
 	depends on PCI
-- 
1.7.3.1



Roman

-- 
Roman Fietze              Telemotive AG Buero Muehlhausen
Breitwiesen                             73347 Muehlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
