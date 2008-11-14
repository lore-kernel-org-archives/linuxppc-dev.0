Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.237])
	by ozlabs.org (Postfix) with ESMTP id DFDC0DDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 16:28:23 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1271362rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 21:28:21 -0800 (PST)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/mpc5200: fix bestcomm Kconfig dependencies
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 13 Nov 2008 22:28:19 -0700
Message-ID: <20081114052819.26119.37708.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Without this patch it is possible to select drivers which require
bestcomm support without bestcomm support being selected.  This
patch reworks the bestcomm dependencies to ensure the correct
bestcomm tasks are always enabled.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/sysdev/bestcomm/Kconfig |    9 +++------
 drivers/net/Kconfig                  |    3 ++-
 sound/soc/fsl/Kconfig                |    3 ++-
 3 files changed, 7 insertions(+), 8 deletions(-)


diff --git a/arch/powerpc/sysdev/bestcomm/Kconfig b/arch/powerpc/sysdev/bestcomm/Kconfig
index 57cc565..0b192a1 100644
--- a/arch/powerpc/sysdev/bestcomm/Kconfig
+++ b/arch/powerpc/sysdev/bestcomm/Kconfig
@@ -17,23 +17,20 @@ config PPC_BESTCOMM
 	  answer Y or M. Otherwise say N.
 
 config PPC_BESTCOMM_ATA
-	tristate "Bestcomm ATA task support"
+	tristate
 	depends on PPC_BESTCOMM
-	default n
 	help
 	  This option enables the support for the ATA task.
 
 config PPC_BESTCOMM_FEC
-	tristate "Bestcomm FEC tasks support"
+	tristate
 	depends on PPC_BESTCOMM
-	default n
 	help
 	  This option enables the support for the FEC tasks.
 
 config PPC_BESTCOMM_GEN_BD
-	tristate "Bestcomm GenBD tasks support"
+	tristate
 	depends on PPC_BESTCOMM
-	default n
 	help
 	  This option enables the support for the GenBD tasks.
 
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 11f143f..231eeaf 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1825,9 +1825,10 @@ config FEC2
 
 config FEC_MPC52xx
 	tristate "MPC52xx FEC driver"
-	depends on PPC_MPC52xx && PPC_BESTCOMM_FEC
+	depends on PPC_MPC52xx && PPC_BESTCOMM
 	select CRC32
 	select PHYLIB
+	select PPC_BESTCOMM_FEC
 	---help---
 	  This option enables support for the MPC5200's on-chip
 	  Fast Ethernet Controller
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index bba9546..8d73edc 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -20,7 +20,8 @@ config SND_SOC_MPC8610_HPCD
 
 config SND_SOC_MPC5200_I2S
 	tristate "Freescale MPC5200 PSC in I2S mode driver"
+	depends on SND_SOC && PPC_MPC52xx && PPC_BESTCOMM
 	select SND_SOC_OF_SIMPLE
-	depends on SND_SOC && PPC_MPC52xx
+	select PPC_BESTCOMM_GEN_BD
 	help
 	  Say Y here to support the MPC5200 PSCs in I2S mode.
