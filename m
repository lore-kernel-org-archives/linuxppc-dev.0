Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 43F21DDE06
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 14:19:01 +1100 (EST)
Date: Sun, 4 Nov 2007 21:28:02 -0600
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] pasemi: Broaden specific references to 1682M
Message-ID: <20071105032802.GA16613@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC] pasemi: Broaden specific references to 1682M
    
There will be more product numbers in the future than just PA6T-1682M,
but they will share much of the features. Remove some of the explicit
references and compatibility checks with 1682M, and replace most of them
with the more generic term "PWRficient".
    

Signed-off-by: Olof Johansson <olof@lixom.net>

---

This one touches drivers/char/hw_random and drivers/edac, but I'd prefer
to just merge it up through the powerpc merge path since the changes
are trivial.

(Michael, Doug, if you disagree let me know and I can submit separate
patches. This is 2.6.25 material anyway).


-Olof


diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platforms/pasemi/Kconfig
index 735e153..2f4dd6e 100644
--- a/arch/powerpc/platforms/pasemi/Kconfig
+++ b/arch/powerpc/platforms/pasemi/Kconfig
@@ -17,7 +17,7 @@ config PPC_PASEMI_IOMMU
 	bool "PA Semi IOMMU support"
 	depends on PPC_PASEMI
 	help
-	  IOMMU support for PA6T-1682M
+	  IOMMU support for PA Semi PWRficient
 
 config PPC_PASEMI_IOMMU_DMA_FORCE
 	bool "Force DMA engine to use IOMMU"
diff --git a/arch/powerpc/platforms/pasemi/cpufreq.c b/arch/powerpc/platforms/pasemi/cpufreq.c
index 1cfb8b0..8caa166 100644
--- a/arch/powerpc/platforms/pasemi/cpufreq.c
+++ b/arch/powerpc/platforms/pasemi/cpufreq.c
@@ -147,7 +147,10 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (!cpu)
 		goto out;
 
-	dn = of_find_compatible_node(NULL, "sdc", "1682m-sdc");
+	dn = of_find_compatible_node(NULL, NULL, "1682m-sdc");
+	if (!dn)
+		dn = of_find_compatible_node(NULL, NULL,
+					     "pasemi,pwrficient-sdc");
 	if (!dn)
 		goto out;
 	err = of_address_to_resource(dn, 0, &res);
@@ -160,7 +163,10 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto out;
 	}
 
-	dn = of_find_compatible_node(NULL, "gizmo", "1682m-gizmo");
+	dn = of_find_compatible_node(NULL, NULL, "1682m-gizmo");
+	if (!dn)
+		dn = of_find_compatible_node(NULL, NULL,
+					     "pasemi,pwrficient-gizmo");
 	if (!dn) {
 		err = -ENODEV;
 		goto out_unmap_sdcasr;
@@ -292,7 +298,8 @@ static struct cpufreq_driver pas_cpufreq_driver = {
 
 static int __init pas_cpufreq_init(void)
 {
-	if (!machine_is_compatible("PA6T-1682M"))
+	if (!machine_is_compatible("PA6T-1682M") &&
+	    !machine_is_compatible("pasemi,pwrficient"))
 		return -ENODEV;
 
 	return cpufreq_register_driver(&pas_cpufreq_driver);
diff --git a/arch/powerpc/platforms/pasemi/gpio_mdio.c b/arch/powerpc/platforms/pasemi/gpio_mdio.c
index 95d0c78..b029804 100644
--- a/arch/powerpc/platforms/pasemi/gpio_mdio.c
+++ b/arch/powerpc/platforms/pasemi/gpio_mdio.c
@@ -333,7 +333,10 @@ int gpio_mdio_init(void)
 {
 	struct device_node *np;
 
-	np = of_find_compatible_node(NULL, "gpio", "1682m-gpio");
+	np = of_find_compatible_node(NULL, NULL, "1682m-gpio");
+	if (!np)
+		np = of_find_compatible_node(NULL, NULL,
+					     "pasemi,pwrficient-gpio");
 	if (!np)
 		return -ENODEV;
 	gpio_regs = of_iomap(np, 0);
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 3a5d112..aeafe98 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -362,8 +362,11 @@ static inline void pasemi_pcmcia_init(void)
 
 
 static struct of_device_id pasemi_bus_ids[] = {
+	/* Unfortunately needed for legacy firmwares */
 	{ .type = "localbus", },
 	{ .type = "sdc", },
+	{ .compatible = "pasemi,localbus", },
+	{ .compatible = "pasemi,sdc", },
 	{},
 };
 
@@ -389,7 +392,8 @@ static int __init pas_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (!of_flat_dt_is_compatible(root, "PA6T-1682M"))
+	if (!of_flat_dt_is_compatible(root, "PA6T-1682M") &&
+	    !of_flat_dt_is_compatible(root, "pasemi,pwrficient"))
 		return 0;
 
 	hpte_init_native();
@@ -400,7 +404,7 @@ static int __init pas_probe(void)
 }
 
 define_machine(pasemi) {
-	.name			= "PA Semi PA6T-1682M",
+	.name			= "PA Semi PWRficient",
 	.probe			= pas_probe,
 	.setup_arch		= pas_setup_arch,
 	.init_early		= pas_init_early,
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 2d7cd48..6bbd4fa 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -98,7 +98,7 @@ config HW_RANDOM_PASEMI
 	default HW_RANDOM
 	---help---
 	  This driver provides kernel-side support for the Random Number
-	  Generator hardware found on PA6T-1682M processor.
+	  Generator hardware found on PA Semi PWRficient SoCs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called pasemi-rng.
diff --git a/drivers/char/hw_random/pasemi-rng.c b/drivers/char/hw_random/pasemi-rng.c
index fa6040b..24ae307 100644
--- a/drivers/char/hw_random/pasemi-rng.c
+++ b/drivers/char/hw_random/pasemi-rng.c
@@ -126,10 +126,9 @@ static int __devexit rng_remove(struct of_device *dev)
 }
 
 static struct of_device_id rng_match[] = {
-	{
-		.compatible      = "1682m-rng",
-	},
-	{},
+	{ .compatible      = "1682m-rng", },
+	{ .compatible      = "pasemi,pwrficient-rng", },
+	{ },
 };
 
 static struct of_platform_driver rng_driver = {
diff --git a/drivers/edac/pasemi_edac.c b/drivers/edac/pasemi_edac.c
index 9007d06..9032091 100644
--- a/drivers/edac/pasemi_edac.c
+++ b/drivers/edac/pasemi_edac.c
@@ -225,7 +225,7 @@ static int __devinit pasemi_edac_probe(struct pci_dev *pdev,
 		EDAC_FLAG_NONE;
 	mci->mod_name = MODULE_NAME;
 	mci->dev_name = pci_name(pdev);
-	mci->ctl_name = "pasemi,1682m-mc";
+	mci->ctl_name = "pasemi,pwrficient-mc";
 	mci->edac_check = pasemi_edac_check;
 	mci->ctl_page_to_phys = NULL;
 	pci_read_config_dword(pdev, MCCFG_SCRUB, &scrub);
@@ -297,4 +297,4 @@ module_exit(pasemi_edac_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Egor Martovetsky <egor@pasemi.com>");
-MODULE_DESCRIPTION("MC support for PA Semi PA6T-1682M memory controller");
+MODULE_DESCRIPTION("MC support for PA Semi PWRficient memory controller");
