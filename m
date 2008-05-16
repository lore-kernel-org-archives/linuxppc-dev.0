Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 987E0DE194
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 10:25:37 +1000 (EST)
Subject: [PATCH 5/5] powerpc: add C2K to configuration
From: Remi Machet <rmachet@slac.stanford.edu>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 15 May 2008 17:26:02 -0700
Message-Id: <1210897562.13992.20.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Support for the C2K cPCI Single Board Computer from GEFanuc
(PowerPC MPC7448 with a Marvell MV64460 chipset)
All features of the board are not supported yet, but the board
boots, flash works, all Ethernet ports are working and PCI 
devices are all found (USB and SATA on PCI1 do not work yet).

Part 5 of 5: add the configuration tool entry for the C2K board.

Signed-off-by: Remi Machet <rmachet@slac.stanford.edu>
---
 Kconfig |   10 ++++++++++
 1 files changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 4290889..4f9f818 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -59,6 +59,16 @@ config PPC_PRPMC2800
 	help
 	  This option enables support for the Motorola PrPMC2800 board
 
+config PPC_C2K
+	bool "SBS/GEFanuc C2K board"
+	depends on EMBEDDED6xx
+	select MV64X60
+	select NOT_COHERENT_CACHE
+	select MTD_CFI_I4
+	help
+	  This option enables support for the GE Fanuc C2K board (formerly
+	  an SBS board).
+
 config TSI108_BRIDGE
 	bool
 	select PCI
