Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id AE056DDE26
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 07:37:13 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: paulus@samba.org,
	linuxppc-dev@ozlabs.org,
	tnt@246tnt.com
Subject: [PATCH] [POWERPC] Fixup mp5200 drivers to match device tree changes
Date: Mon, 12 Feb 2007 13:36:55 -0700
Message-Id: <11713126213274-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1171312615567-git-send-email-grant.likely@secretlab.ca>
References: <1171312615567-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/52xx/lite5200.c       |   29 +++++++++++++------------
 arch/powerpc/platforms/52xx/mpc52xx_common.c |    4 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c    |   10 ++++----
 drivers/ata/pata_mpc52xx.c                   |    6 +---
 drivers/serial/mpc52xx_uart.c                |    5 +--
 5 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index cdb16bf..cc3b40d 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -51,13 +51,13 @@ #include <asm/mpc52xx.h>
  */
 
 static void __init
-lite52xx_setup_cpu(void)
+lite5200_setup_cpu(void)
 {
 	struct mpc52xx_gpio __iomem *gpio;
 	u32 port_config;
 
 	/* Map zones */
-	gpio = mpc52xx_find_and_map("mpc52xx-gpio");
+	gpio = mpc52xx_find_and_map("mpc5200-gpio");
 	if (!gpio) {
 		printk(KERN_ERR __FILE__ ": "
 			"Error while mapping GPIO register for port config. "
@@ -85,12 +85,12 @@ error:
 	iounmap(gpio);
 }
 
-static void __init lite52xx_setup_arch(void)
+static void __init lite5200_setup_arch(void)
 {
 	struct device_node *np;
 
 	if (ppc_md.progress)
-		ppc_md.progress("lite52xx_setup_arch()", 0);
+		ppc_md.progress("lite5200_setup_arch()", 0);
 
 	np = of_find_node_by_type(NULL, "cpu");
 	if (np) {
@@ -105,7 +105,7 @@ static void __init lite52xx_setup_arch(v
 
 	/* CPU & Port mux setup */
 	mpc52xx_setup_cpu();	/* Generic */
-	lite52xx_setup_cpu();	/* Platorm specific */
+	lite5200_setup_cpu();	/* Platorm specific */
 
 #ifdef CONFIG_PCI
 	np = of_find_node_by_type(np, "pci");
@@ -126,7 +126,7 @@ #endif
 
 }
 
-void lite52xx_show_cpuinfo(struct seq_file *m)
+void lite5200_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node* np = of_find_all_nodes(NULL);
 	const char *model = NULL;
@@ -143,25 +143,26 @@ void lite52xx_show_cpuinfo(struct seq_fi
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
-static int __init lite52xx_probe(void)
+static int __init lite5200_probe(void)
 {
 	unsigned long node = of_get_flat_dt_root();
 	const char *model = of_get_flat_dt_prop(node, "model", NULL);
 
-	if (!of_flat_dt_is_compatible(node, "lite52xx"))
+	if (!of_flat_dt_is_compatible(node, "fsl,lite5200") &&
+	    !of_flat_dt_is_compatible(node, "fsl,lite5200b"))
 		return 0;
-	pr_debug("%s board w/ mpc52xx found\n", model ? model : "unknown");
+	pr_debug("%s board found\n", model ? model : "unknown");
 
 	return 1;
 }
 
-define_machine(lite52xx) {
-	.name 		= "lite52xx",
-	.probe 		= lite52xx_probe,
-	.setup_arch 	= lite52xx_setup_arch,
+define_machine(lite5200) {
+	.name 		= "lite5200",
+	.probe 		= lite5200_probe,
+	.setup_arch 	= lite5200_setup_arch,
 	.init		= mpc52xx_declare_of_platform_devices,
 	.init_IRQ 	= mpc52xx_init_irq,
 	.get_irq 	= mpc52xx_get_irq,
-	.show_cpuinfo	= lite52xx_show_cpuinfo,
+	.show_cpuinfo	= lite5200_show_cpuinfo,
 	.calibrate_decr	= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index cc40889..ed0cb69 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -83,8 +83,8 @@ mpc52xx_setup_cpu(void)
 	struct mpc52xx_xlb  __iomem *xlb;
 
 	/* Map zones */
-	cdm = mpc52xx_find_and_map("mpc52xx-cdm");
-	xlb = mpc52xx_find_and_map("mpc52xx-xlb");
+	cdm = mpc52xx_find_and_map("mpc5200-cdm");
+	xlb = mpc52xx_find_and_map("mpc5200-xlb");
 
 	if (!cdm || !xlb) {
 		printk(KERN_ERR __FILE__ ": "
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index cd91a6c..c751925 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -383,16 +383,16 @@ void __init mpc52xx_init_irq(void)
 	struct device_node *picnode;
 
 	/* Remap the necessary zones */
-	picnode = of_find_compatible_node(NULL, NULL, "mpc52xx-pic");
+	picnode = of_find_compatible_node(NULL, NULL, "mpc5200-pic");
 
-	intr = mpc52xx_find_and_map("mpc52xx-pic");
+	intr = mpc52xx_find_and_map("mpc5200-pic");
 	if (!intr)
-		panic(__FILE__	": find_and_map failed on 'mpc52xx-pic'. "
+		panic(__FILE__	": find_and_map failed on 'mpc5200-pic'. "
 				"Check node !");
 
-	sdma = mpc52xx_find_and_map("mpc52xx-bestcomm");
+	sdma = mpc52xx_find_and_map("mpc5200-bestcomm");
 	if (!sdma)
-		panic(__FILE__	": find_and_map failed on 'mpc52xx-bestcomm'. "
+		panic(__FILE__	": find_and_map failed on 'mpc5200-bestcomm'. "
 				"Check node !");
 
 	/* Disable all interrupt sources. */
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index d7378df..29e1809 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -484,10 +484,8 @@ #endif
 
 static struct of_device_id mpc52xx_ata_of_match[] = {
 	{
-		.compatible = "mpc5200-ata",
-	},
-	{
-		.compatible = "mpc52xx-ata",
+		.type		= "ata",
+		.compatible	= "mpc5200-ata",
 	},
 	{},
 };
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 3c4b6c2..955bbd6 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -127,8 +127,7 @@ #endif
 
 #if defined(CONFIG_PPC_MERGE)
 static struct of_device_id mpc52xx_uart_of_match[] = {
-	{ .type = "serial", .compatible = "mpc52xx-psc-uart", },
-	{ .type = "serial", .compatible = "mpc5200-psc", }, /* Efika only! */
+	{ .type = "serial", .compatible = "mpc5200-psc-uart", },
 	{},
 };
 #endif
@@ -1068,7 +1067,7 @@ mpc52xx_uart_of_enumerate(void)
 			continue;
 
 		/* Is a particular device number requested? */
-		devno = get_property(np, "device_no", NULL);
+		devno = get_property(np, "port-number", NULL);
 		mpc52xx_uart_of_assign(of_node_get(np), devno ? *devno : -1);
 	}
 
-- 
1.4.3.rc2.g0503
