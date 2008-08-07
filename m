Return-Path: <jrigby@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB741DE194
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 03:37:57 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m77HaUUu020053
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Aug 2008 10:36:31 -0700 (MST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5121 pci 2/3] powerpc: 5121: Add PCI support.
Date: Thu,  7 Aug 2008 11:36:26 -0600
Message-Id: <1218130587-31176-2-git-send-email-jrigby@freescale.com>
In-Reply-To: <1218130587-31176-1-git-send-email-jrigby@freescale.com>
References: <1218130587-31176-1-git-send-email-jrigby@freescale.com>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Uses mpc83xx_add_bridge in fsl_pci.c

Adds second register tuple to pci node register property
as previously done for 83xx device trees in a previous patch.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/boot/dts/mpc5121ads.dts      |    4 +++-
 arch/powerpc/platforms/512x/Kconfig       |    2 ++
 arch/powerpc/platforms/512x/mpc5121_ads.c |   10 ++++++++++
 arch/powerpc/sysdev/fsl_pci.c             |    4 ++--
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
index 1f9036c..b5444f7 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -403,8 +403,10 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0x80008500 0x100>;
+		reg = <0x80008500 0x100		/* internal registers */
+		       0x80008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc5121-pci";
 		device_type = "pci";
+		primary;
 	};
 };
diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index c62f893..326852c 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -3,6 +3,8 @@ config PPC_MPC512x
 	select FSL_SOC
 	select IPIC
 	select PPC_CLOCK
+	select PPC_PCI_CHOICE
+	select FSL_PCI if PCI
 
 config PPC_MPC5121
 	bool
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index 5ebf693..441abc4 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -22,16 +22,26 @@
 #include <asm/prom.h>
 #include <asm/time.h>
 
+#include <sysdev/fsl_pci.h>
+
 #include "mpc512x.h"
 #include "mpc5121_ads.h"
 
 static void __init mpc5121_ads_setup_arch(void)
 {
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
 	printk(KERN_INFO "MPC5121 ADS board from Freescale Semiconductor\n");
 	/*
 	 * cpld regs are needed early
 	 */
 	mpc5121_ads_cpld_map();
+
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,mpc5121-pci")
+		mpc83xx_add_bridge(np);
+#endif
 }
 
 static void __init mpc5121_ads_init_IRQ(void)
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index c4bdfc2..0acdd1e 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -251,7 +251,7 @@ DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641D, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8610, quirk_fsl_pcie_header);
 #endif /* CONFIG_PPC_85xx || CONFIG_PPC_86xx */
 
-#if defined(CONFIG_PPC_83xx)
+#if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
 int __init mpc83xx_add_bridge(struct device_node *dev)
 {
 	int len;
@@ -313,7 +313,7 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 
 	setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 4, 0);
 
-	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%016llx. "
+	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
 	       "Firmware bus number: %d->%d\n",
 	       (unsigned long long)rsrc_reg.start, hose->first_busno,
 	       hose->last_busno);
-- 
