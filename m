Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12AA4DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 17:46:05 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0O6k14q002357
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 00:46:01 -0600
Date: Thu, 24 Jan 2008 00:43:38 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 85xx: Port STX GP3 board over from arch/ppc
Message-ID: <Pine.LNX.4.64.0801240041530.22238@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---

The defconfig has been removed from the patch to protect the innocent.

Let's see what sfr finds wrong with this patch :)

- k

 arch/powerpc/boot/dts/stx_gp3_8560.dts |  216 ++++++
 arch/powerpc/configs/stx_gp3_defconfig | 1183 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig    |   12 +-
 arch/powerpc/platforms/85xx/Makefile   |    1 +
 arch/powerpc/platforms/85xx/stx_gp3.c  |  256 +++++++
 5 files changed, 1666 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/stx_gp3_8560.dts
 create mode 100644 arch/powerpc/configs/stx_gp3_defconfig
 create mode 100644 arch/powerpc/platforms/85xx/stx_gp3.c

diff --git a/arch/powerpc/boot/dts/stx_gp3_8560.dts b/arch/powerpc/boot/dts/stx_gp3_8560.dts
new file mode 100644
index 0000000..b32d3c5
--- /dev/null
+++ b/arch/powerpc/boot/dts/stx_gp3_8560.dts
@@ -0,0 +1,216 @@
+/*
+ * STX GP3 - 8560 ADS Device Tree Source
+ *
+ * Copyright 2008 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "stx,gp3";
+	compatible = "stx,gp3-8560", "stx,gp3";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		pci0 = &pci0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8560@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;	// L1, 32K
+			i-cache-size = <0x8000>;	// L1, 32K
+			timebase-frequency = <0x4ead9a0>;
+			bus-frequency = <0x13ab6680>;
+			clock-frequency = <0x312c8040>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	soc8560@fdf00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0 0xfdf00000 0x100000>;
+		reg = <0xfdf00000 0x1000>;
+		bus-frequency = <0x13ab6680>;
+
+		memory-controller@2000 {
+			compatible = "fsl,8540-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8540-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;
+			cache-size = <0x40000>;	// L2, 256K
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x24520 0x20>;
+
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&mpic>;
+				interrupts = <5 4>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy4: ethernet-phy@4 {
+				interrupt-parent = <&mpic>;
+				interrupts = <5 4>;
+				reg = <4>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		enet0: ethernet@24000 {
+			cell-index = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy2>;
+		};
+
+		enet1: ethernet@25000 {
+			cell-index = <1>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy4>;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			device_type = "open-pic";
+		};
+
+		cpm@919c0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8560-cpm", "fsl,cpm2";
+			reg = <0x919c0 0x30>;
+			ranges;
+
+			muram@80000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x80000 0x10000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 0x4000 0x9000 0x2000>;
+				};
+			};
+
+			brg@919f0 {
+				compatible = "fsl,mpc8560-brg",
+				             "fsl,cpm2-brg",
+				             "fsl,cpm-brg";
+				reg = <0x919f0 0x10 0x915f0 0x10>;
+				clock-frequency = <133000000>;
+			};
+
+			cpmpic: pic@90c00 {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				interrupts = <46 2>;
+				interrupt-parent = <&mpic>;
+				reg = <0x90c00 0x80>;
+				compatible = "fsl,mpc8560-cpm-pic", "fsl,cpm2-pic";
+			};
+
+			serial0: serial@91a20 {
+				device_type = "serial";
+				compatible = "fsl,mpc8560-scc-uart",
+				             "fsl,cpm2-scc-uart";
+				reg = <0x91a20 0x20 0x88100 0x100>;
+				fsl,cpm-brg = <2>;
+				fsl,cpm-command = <0x4a00000>;
+				interrupts = <41 8>;
+				interrupt-parent = <&cpmpic>;
+			};
+		};
+	};
+
+	pci0: pci@fdf08000 {
+		cell-index = <0>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+
+			/* IDSEL 0x0c */
+			0x6000 0 0 1 &mpic 1 1
+			0x6000 0 0 2 &mpic 2 1
+			0x6000 0 0 3 &mpic 3 1
+			0x6000 0 0 4 &mpic 4 1
+
+			/* IDSEL 0x0d */
+			0x6800 0 0 1 &mpic 4 1
+			0x6800 0 0 2 &mpic 1 1
+			0x6800 0 0 3 &mpic 2 1
+			0x6800 0 0 4 &mpic 3 1
+
+			/* IDSEL 0x0e */
+			0x7000 0 0 1 &mpic 3 1
+			0x7000 0 0 2 &mpic 4 1
+			0x7000 0 0 3 &mpic 1 1
+			0x7000 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x0f */
+			0x7800 0 0 1 &mpic 2 1
+			0x7800 0 0 2 &mpic 3 1
+			0x7800 0 0 3 &mpic 4 1
+			0x7800 0 0 4 &mpic 1 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <24 2>;
+		bus-range = <0 0>;
+		ranges = <0x02000000 0 0x80000000 0x80000000 0 0x20000000
+			  0x01000000 0 0x00000000 0xe2000000 0 0x00100000>;
+		clock-frequency = <0x3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xfdf08000 0x1000>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+	};
+};
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 7748a3a..26f9cd5 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -38,6 +38,14 @@ config MPC85xx_DS
 	help
 	  This option enables support for the MPC85xx DS (MPC8544 DS) board

+config STX_GP3
+	bool "Silicon Turnkey Express GP3"
+	help
+	  This option enables support for the Silicon Turnkey Express GP3
+	  board.
+	select DEFAULT_UIMAGE
+	select PPC_CPM_NEW_BINDING
+
 endchoice

 config MPC8540
@@ -49,7 +57,7 @@ config MPC8540
 config MPC8560
 	bool
 	select CPM2
-	default y if MPC8560_ADS
+	default y if MPC8560_ADS || STX_GP3

 config MPC85xx
 	bool
@@ -59,4 +67,4 @@ config MPC85xx
 	select FSL_PCI if PCI
 	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
 	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS \
-		|| MPC85xx_MDS || MPC85xx_DS
+		|| MPC85xx_MDS || MPC85xx_DS || STX_GP3
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 5eca920..bf7d2e1 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
 obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
+obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
new file mode 100644
index 0000000..a3aa9f1
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -0,0 +1,256 @@
+/*
+ * Based on MPC8560 ADS and arch/ppc stx_gp3 ports
+ *
+ * Maintained by Kumar Gala (see MAINTAINERS for contact information)
+ *
+ * Copyright 2008 Freescale Semiconductor Inc.
+ *
+ * Dan Malek <dan@embeddededge.com>
+ * Copyright 2004 Embedded Edge, LLC
+ *
+ * Copied from mpc8560_ads.c
+ * Copyright 2002, 2003 Motorola Inc.
+ *
+ * Ported to 2.6, Matt Porter <mporter@kernel.crashing.org>
+ * Copyright 2004-2005 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpic.h>
+#include <mm/mmu_decl.h>
+#include <asm/udbg.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+
+#ifdef CONFIG_CPM2
+#include <asm/cpm2.h>
+#include <sysdev/cpm2_pic.h>
+#endif
+
+#ifdef CONFIG_CPM2
+static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	int cascade_irq;
+
+	while ((cascade_irq = cpm2_get_irq()) >= 0)
+		generic_handle_irq(cascade_irq);
+
+	desc->chip->eoi(irq);
+}
+
+#endif /* CONFIG_CPM2 */
+
+static void __init stx_gp3_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np = NULL;
+#ifdef CONFIG_CPM2
+	int irq;
+#endif
+
+	np = of_find_node_by_type(np, "open-pic");
+	if (!np) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Could not map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	mpic = mpic_alloc(np, r.start,
+			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			0, 256, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+	of_node_put(np);
+
+	mpic_init(mpic);
+
+#ifdef CONFIG_CPM2
+	/* Setup CPM2 PIC */
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pic");
+	if (np == NULL) {
+		printk(KERN_ERR "PIC init: can not find fsl,cpm2-pic node\n");
+		return;
+	}
+	irq = irq_of_parse_and_map(np, 0);
+
+	cpm2_pic_init(np);
+	of_node_put(np);
+	set_irq_chained_handler(irq, cpm2_cascade);
+#endif
+}
+
+/*
+ * Setup the architecture
+ */
+#ifdef CONFIG_CPM2
+struct cpm_pin {
+	int port, pin, flags;
+};
+
+static const struct cpm_pin mpc8560_ads_pins[] = {
+	/* SCC1 */
+	{3, 29, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* SCC2 */
+	{3, 26, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 27, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* FCC2 */
+	{1, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 20, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 21, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 22, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 25, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 26, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 27, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 29, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{1, 30, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 31, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{2, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* CLK14 */
+	{2, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* CLK13 */
+
+	/* FCC3 */
+	{1, 4, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 5, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 6, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 7, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 8, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 9, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 10, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 11, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 12, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 13, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 14, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 15, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 16, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* CLK16 */
+	{2, 17, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* CLK15 */
+};
+
+static void __init init_ioports(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mpc8560_ads_pins); i++) {
+		const struct cpm_pin *pin = &mpc8560_ads_pins[i];
+		cpm2_set_pin(pin->port, pin->pin, pin->flags);
+	}
+
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_SCC2, CPM_BRG2, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC2, CPM_BRG2, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK13, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK14, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC3, CPM_CLK15, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC3, CPM_CLK16, CPM_CLK_TX);
+}
+#endif
+
+static void __init stx_gp3_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("stx_gp3_setup_arch()", 0);
+
+#ifdef CONFIG_CPM2
+	cpm2_reset();
+	init_ioports();
+#endif
+
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
+		fsl_add_bridge(np, 1);
+#endif
+}
+
+static void stx_gp3_show_cpuinfo(struct seq_file *m)
+{
+	uint pvid, svid, phid1;
+	uint memsize = total_memory;
+
+	pvid = mfspr(SPRN_PVR);
+	svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: RPC Electronics STx \n");
+	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+
+	/* Display cpu Pll setting */
+	phid1 = mfspr(SPRN_HID1);
+	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
+
+	/* Display the amount of memory */
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+}
+
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .type = "soc", },
+	{ .name = "cpm", },
+	{ .name = "localbus", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(stx_gp3, declare_of_platform_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init stx_gp3_probe(void)
+{
+        unsigned long root = of_get_flat_dt_root();
+
+        return of_flat_dt_is_compatible(root, "stx,gp3-8560");
+}
+
+define_machine(stx_gp3) {
+	.name			= "STX GP3",
+	.probe			= stx_gp3_probe,
+	.setup_arch		= stx_gp3_setup_arch,
+	.init_IRQ		= stx_gp3_pic_init,
+	.show_cpuinfo		= stx_gp3_show_cpuinfo,
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.5.3.7
