Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0103.outbound.protection.outlook.com [157.56.111.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C56CF1A0F20
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 02:51:27 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v2 03/10] powerpc/mpc85xx: Add platform support for the
 Freescale DPAA BMan
Date: Mon, 16 Feb 2015 09:46:14 -0600
Message-ID: <1424101581-22109-4-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1424101581-22109-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1424101581-22109-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Geoff Thorpe <Geoff.Thorpe@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Geoff Thorpe <Geoff.Thorpe@freescale.com>

Change-Id: I59de17c040cdd304f86306336fcf89f130f7db2d
Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
---
 arch/powerpc/Kconfig                          |  5 +++++
 arch/powerpc/configs/mpc85xx_defconfig        |  1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig    |  1 +
 arch/powerpc/platforms/85xx/Kconfig           |  1 +
 arch/powerpc/platforms/85xx/corenet_generic.c | 16 ++++++++++++++++
 arch/powerpc/platforms/85xx/p1023_rdb.c       | 14 ++++++++++++++
 6 files changed, 38 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7258b468..6ab5ad5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -779,6 +779,11 @@ config FSL_GTM
 	help
 	  Freescale General-purpose Timers support
 
+config HAS_FSL_QBMAN
+	bool "Datapath Acceleration Queue and Buffer management"
+	help
+	  Datapath Acceleration Queue and Buffer management
+
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 config MCA
 	bool
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 8496389..aa7e41f 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -49,6 +49,7 @@ CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
 CONFIG_FORCE_MAX_ZONEORDER=12
+CONFIG_HAS_FSL_QBMAN=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 # CONFIG_PCIEASPM is not set
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index bf88caf..82feda1 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -50,6 +50,7 @@ CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
 CONFIG_FORCE_MAX_ZONEORDER=12
+CONFIG_HAS_FSL_QBMAN=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_RAPIDIO=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index dbdd5fa..51e9a7b 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -276,6 +276,7 @@ config CORENET_GENERIC
 	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
+	select HAS_FSL_QBMAN
 	help
 	  This option enables support for the FSL CoreNet based boards.
 	  For 32bit kernel, the following boards are supported:
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 63bef30..74faab7 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -197,6 +197,21 @@ static int __init corenet_generic_probe(void)
 	return 0;
 }
 
+/* Early setup is required for large chunks of contiguous (and coarsely-aligned)
+ * memory. The following shoe-horns Bman "init_early" calls into the
+ * platform setup to let them parse their CCSR nodes early on.
+ */
+#ifdef CONFIG_FSL_BMAN_CONFIG
+void __init bman_init_early(void);
+#endif
+
+__init void corenet_ds_init_early(void)
+{
+#ifdef CONFIG_FSL_BMAN_CONFIG
+	bman_init_early();
+#endif
+}
+
 define_machine(corenet_generic) {
 	.name			= "CoreNet Generic",
 	.probe			= corenet_generic_probe,
@@ -215,6 +230,7 @@ define_machine(corenet_generic) {
 #else
 	.power_save		= e500_idle,
 #endif
+	.init_early		= corenet_ds_init_early,
 };
 
 machine_arch_initcall(corenet_generic, corenet_gen_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/p1023_rdb.c b/arch/powerpc/platforms/85xx/p1023_rdb.c
index d5b7509..624d3d6 100644
--- a/arch/powerpc/platforms/85xx/p1023_rdb.c
+++ b/arch/powerpc/platforms/85xx/p1023_rdb.c
@@ -103,7 +103,20 @@ static int __init p1023_rdb_probe(void)
 	unsigned long root = of_get_flat_dt_root();
 
 	return of_flat_dt_is_compatible(root, "fsl,P1023RDB");
+}
+
+/* Early setup is required for large chunks of contiguous (and coarsely-aligned)
+ * memory. The following shoe-horns Bman "init_early" calls into the
+ * platform setup to let them parse their CCSR nodes early on. */
+#ifdef CONFIG_FSL_BMAN_CONFIG
+void __init bman_init_early(void);
+#endif
 
+static __init void p1023_rdb_init_early(void)
+{
+#ifdef CONFIG_FSL_BMAN_CONFIG
+	bman_init_early();
+#endif
 }
 
 define_machine(p1023_rdb) {
@@ -119,4 +132,5 @@ define_machine(p1023_rdb) {
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 	.pcibios_fixup_phb	= fsl_pcibios_fixup_phb,
 #endif
+	.init_early		= p1023_rdb_init_early,
 };
-- 
2.3.0
