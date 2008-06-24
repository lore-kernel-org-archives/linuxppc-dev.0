Return-Path: <jrigby@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8ADC3DE36E
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 07:24:44 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m5OLOdB7006138
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 14:24:39 -0700 (MST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/8][Version 2] MPC5121 Add PCI support
Date: Tue, 24 Jun 2008 15:24:31 -0600
Message-Id: <1214342672-23536-8-git-send-email-jrigby@freescale.com>
In-Reply-To: <1214342672-23536-7-git-send-email-jrigby@freescale.com>
References: <1214342672-23536-1-git-send-email-jrigby@freescale.com>
	<1214342672-23536-2-git-send-email-jrigby@freescale.com>
	<1214342672-23536-3-git-send-email-jrigby@freescale.com>
	<1214342672-23536-4-git-send-email-jrigby@freescale.com>
	<1214342672-23536-5-git-send-email-jrigby@freescale.com>
	<1214342672-23536-6-git-send-email-jrigby@freescale.com>
	<1214342672-23536-7-git-send-email-jrigby@freescale.com>
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

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/platforms/512x/Kconfig       |    2 ++
 arch/powerpc/platforms/512x/mpc5121_ads.c |   10 ++++++++++
 arch/powerpc/platforms/512x/mpc512x.h     |    1 +
 arch/powerpc/sysdev/fsl_pci.c             |    5 +++--
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index 0fd3b00..f53f49b 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -2,6 +2,8 @@ config PPC_MPC512x
 	bool
 	select FSL_SOC
 	select IPIC
+	select PPC_HAS_PCI
+	select FSL_PCI if PCI
 
 config PPC_MPC5121
 	bool
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index 36805fd..3306e29 100644
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
 
 static struct of_device_id __initdata of_bus_ids[] = {
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index 789b817..be30915 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -11,4 +11,5 @@
 #define __MPC512X_H__
 extern unsigned long mpc512x_find_ips_freq(struct device_node *node);
 extern void __init mpc512x_init_IRQ(void);
+extern int mpc512x_add_bridge(struct device_node *dev);
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 6e6688f..a40bb8e 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -249,7 +249,7 @@ DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641D, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8610, quirk_fsl_pcie_header);
 #endif /* CONFIG_PPC_85xx || CONFIG_PPC_86xx */
 
-#if defined(CONFIG_PPC_83xx)
+#if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
 int __init mpc83xx_add_bridge(struct device_node *dev)
 {
 	int len;
@@ -281,6 +281,7 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 
 	/* MPC83xx supports up to two host controllers one at 0x8500 from immrbar
 	 * the other at 0x8600, we consider the 0x8500 the primary controller
+	 * MPC512x supports one host controller at 0x8500.
 	 */
 	/* PCI 1 */
 	if ((rsrc.start & 0xfffff) == 0x8500) {
@@ -292,7 +293,7 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 		primary = 0;
 	}
 
-	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%016llx. "
+	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
 	       "Firmware bus number: %d->%d\n",
 	       (unsigned long long)rsrc.start, hose->first_busno,
 	       hose->last_busno);
-- 
1.5.6.rc0.46.gd2b3
