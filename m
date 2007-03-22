Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 57B75DDF81
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 01:25:31 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2MEPPQ6027635
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 07:25:26 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2MEPOLj029763
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 09:25:25 -0500 (CDT)
Subject: [Fwd: [PATCH Resend 01/02] Add Linux ASMP support for MPC8641D]
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1174573524.6595.509.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 22 Mar 2007 09:25:24 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar,

As I indicated on IRC to you a few days ago, here is a copy
of the Asymmetric Multi-Processor support patch for 8641 HPCN.
For completeness and reference, the corresponding U-Boot patch
will be posted to the U-Boot list as well.

This patch is directly split in two due to apparently mailer
issues with the full patch.  Apologies if you have received
this patch twice.

This is the first half of the patch, everything but the defconfig.

Thanks,
jdl





From: Haiying Wang <Haiying.Wang@freescale.com>
Subject: [PATCH] Add Linux ASMP support for MPC8641D
Date: Mon, 26 Feb 2007 15:51:29 -0500

1. Both cores can use the same kernel image but use individual dts file.
2. mpc8641d_asmp_defconfig is the default config file for ASMP support
3. TSEC1/2, Uart0, PCIe are assigned to core0, TSEC3/4, Uart1 are assigned to core1.

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
---
 arch/powerpc/boot/dts/mpc8641_core0.dts      |  287 +++++++
 arch/powerpc/boot/dts/mpc8641_core1.dts      |  125 +++
 arch/powerpc/configs/mpc8641d_asmp_defconfig | 1152 ++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/Kconfig          |    4 +
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c   |    4 +
 arch/powerpc/sysdev/mpic.c                   |   41 +-
 drivers/net/gianfar.c                        |   24 +
 7 files changed, 1635 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_core0.dts b/arch/powerpc/boot/dts/mpc8641_core0.dts
new file mode 100644
index 0000000..5511799
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8641_core0.dts
@@ -0,0 +1,287 @@
+/*
+ * MPC8641 HPCN Core0 Device Tree Source
+ *
+ * Copyright 2006-2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/ {
+	model = "MPC8641HPCN";
+	compatible = "mpc86xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8641@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;	// 33 MHz, from uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+			32-bit;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 10000000>;	// 256M at 0x0
+	};
+
+	soc8641@f8000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <1>;
+		device_type = "soc";
+		ranges = <0 f8000000 00100000>;
+		reg = <f8000000 00100000>;	// CCSRBAR 1M
+		bus-frequency = <0>;
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <2b 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		i2c@3100 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3100 100>;
+			interrupts = <2b 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&mpic>;
+				interrupts = <4a 1>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			phy1: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <4a 1>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			mac-address = [ 00 E0 0C 00 73 00 ];
+			interrupts = <1d 2 1e 2 22 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy0>;
+		};
+
+		ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			mac-address = [ 00 E0 0C 00 73 01 ];
+			interrupts = <23 2 24 2 28 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+		};
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>;
+			clock-frequency = <0>;
+			interrupts = <2a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		pci@8000 {
+			compatible = "86xx";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <8000 1000>;
+			bus-range = <0 fe>;
+			ranges = <02000000 0 80000000 80000000 0 20000000
+				  01000000 0 00000000 e2000000 0 00100000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x11 */
+				8800 0 0 1 &i8259 3 2
+				8800 0 0 2 &i8259 4 2
+				8800 0 0 3 &i8259 5 2
+				8800 0 0 4 &i8259 6 2
+
+				/* IDSEL 0x12 */
+				9000 0 0 1 &i8259 4 2
+				9000 0 0 2 &i8259 5 2
+				9000 0 0 3 &i8259 6 2
+				9000 0 0 4 &i8259 3 2
+
+				/* IDSEL 0x13 */
+				9800 0 0 1 &i8259 0 0
+				9800 0 0 2 &i8259 0 0
+				9800 0 0 3 &i8259 0 0
+				9800 0 0 4 &i8259 0 0
+
+				/* IDSEL 0x14 */
+				a000 0 0 1 &i8259 0 0
+				a000 0 0 2 &i8259 0 0
+				a000 0 0 3 &i8259 0 0
+				a000 0 0 4 &i8259 0 0
+
+				/* IDSEL 0x15 */
+				a800 0 0 1 &i8259 0 0
+				a800 0 0 2 &i8259 0 0
+				a800 0 0 3 &i8259 0 0
+				a800 0 0 4 &i8259 0 0
+
+				/* IDSEL 0x16 */
+				b000 0 0 1 &i8259 0 0
+				b000 0 0 2 &i8259 0 0
+				b000 0 0 3 &i8259 0 0
+				b000 0 0 4 &i8259 0 0
+
+				/* IDSEL 0x17 */
+				b800 0 0 1 &i8259 0 0
+				b800 0 0 2 &i8259 0 0
+				b800 0 0 3 &i8259 0 0
+				b800 0 0 4 &i8259 0 0
+
+				/* IDSEL 0x18 */
+				c000 0 0 1 &i8259 0 0
+				c000 0 0 2 &i8259 0 0
+				c000 0 0 3 &i8259 0 0
+				c000 0 0 4 &i8259 0 0
+
+				/* IDSEL 0x19 */
+				c800 0 0 1 &i8259 0 0
+				c800 0 0 2 &i8259 0 0
+				c800 0 0 3 &i8259 0 0
+				c800 0 0 4 &i8259 0 0
+
+				/* IDSEL 0x1a */
+				d000 0 0 1 &i8259 6 2
+				d000 0 0 2 &i8259 3 2
+				d000 0 0 3 &i8259 4 2
+				d000 0 0 4 &i8259 5 2
+
+
+				/* IDSEL 0x1b */
+				d800 0 0 1 &i8259 5 2
+				d800 0 0 2 &i8259 0 0
+				d800 0 0 3 &i8259 0 0
+				d800 0 0 4 &i8259 0 0
+
+				/* IDSEL 0x1c */
+				e000 0 0 1 &i8259 9 2
+				e000 0 0 2 &i8259 a 2
+				e000 0 0 3 &i8259 c 2
+				e000 0 0 4 &i8259 7 2
+
+				/* IDSEL 0x1d */
+				e800 0 0 1 &i8259 9 2
+				e800 0 0 2 &i8259 a 2
+				e800 0 0 3 &i8259 b 2
+				e800 0 0 4 &i8259 0 0
+
+				/* IDSEL 0x1e */
+				f000 0 0 1 &i8259 c 2
+				f000 0 0 2 &i8259 0 0
+				f000 0 0 3 &i8259 0 0
+				f000 0 0 4 &i8259 0 0
+
+				/* IDSEL 0x1f */
+				f800 0 0 1 &i8259 6 2
+				f800 0 0 2 &i8259 0 0
+				f800 0 0 3 &i8259 0 0
+				f800 0 0 4 &i8259 0 0
+				>;
+			i8259: i8259@4d0 {
+				clock-frequency = <0>;
+				interrupt-controller;
+				device_type = "interrupt-controller";
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				built-in;
+				compatible = "chrp,iic";
+                	        big-endian;
+				interrupts = <49 2>;
+				interrupt-parent = <&mpic>;
+			};
+
+		};
+
+		pci@9000 {
+			compatible = "86xx";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <9000 1000>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 a0000000 a0000000 0 20000000
+				  01000000 0 00000000 e3000000 0 00100000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <19 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 44 1
+				0000 0 0 2 &mpic 45 1
+				0000 0 0 3 &mpic 46 1
+				0000 0 0 4 &mpic 47 1
+				>;
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+			big-endian;
+			interrupts = <
+			18 2 49 2 19 2
+			2a 2 2b 2 4a 1
+			1d 2 1e 2 22 2
+			23 2 24 2 28 2
+			>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8641_core1.dts b/arch/powerpc/boot/dts/mpc8641_core1.dts
new file mode 100644
index 0000000..44598ce
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8641_core1.dts
@@ -0,0 +1,125 @@
+/*
+ * MPC8641 HPCN Core1 Device Tree Source
+ *
+ * Copyright 2006-2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/ {
+	model = "MPC8641HPCN";
+	compatible = "mpc86xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8641@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;	// 33 MHz, from uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+			32-bit;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 10000000>;	// 256M at 0x0
+	};
+
+	soc8641@f8000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <1>;
+		device_type = "soc";
+		ranges = <0 f8000000 00100000>;
+		reg = <f8000000 00100000>;	// CCSRBAR 1M
+		bus-frequency = <0>;
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&mpic>;
+				interrupts = <4a 1>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupt-parent = <&mpic>;
+				interrupts = <4a 1>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <26000 1000>;
+			mac-address = [ 00 E0 0C 00 02 FD ];
+			interrupts = <1F 2 20 2 21 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy2>;
+		};
+
+		ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <27000 1000>;
+			mac-address = [ 00 E0 0C 00 03 FD ];
+			interrupts = <25 2 26 2 27 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy3>;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;
+			clock-frequency = <0>;
+			interrupts = <1c 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+			big-endian;
+			interrupts = <
+			1c 2
+			1f 2 20 2 21 2
+			25 2 26 2 27 2
+			>;
+
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 0c70944..292cb1e 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -30,4 +30,8 @@ config PPC_INDIRECT_PCI_BE
 	depends on PPC_86xx
 	default y
 
+config ASMP
+	bool "Asynchronous SMP support"
+	depends on PPC_86xx
+	default n
 endmenu
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 5ef6d61..70034ad 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -80,7 +80,11 @@ mpc86xx_hpcn_init_irq(void)
 
 	/* Alloc mpic structure and per isu has 16 INT entries. */
 	mpic1 = mpic_alloc(np, res.start,
+#ifdef CONFIG_ASMP
+			MPIC_PRIMARY | MPIC_BIG_ENDIAN,
+#else
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+#endif
 			16, NR_IRQS - 10,
 			" MPIC     ");
 	BUG_ON(mpic1 == NULL);
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index bcfb900..739d8bf 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -707,9 +707,15 @@ static void mpic_set_affinity(unsigned int irq, cpumask_t cpumask)
 	cpumask_t tmp;
 
 	cpus_and(tmp, cpumask, cpu_online_map);
-
+#ifdef CONFIG_ASMP
+	unsigned int pir;
+	pir = mfspr(SPRN_PIR);
+	mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION),
+			1 << pir);
+#else
 	mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION),
-		       mpic_physmask(cpus_addr(tmp)[0]));	
+		       mpic_physmask(cpus_addr(tmp)[0]));
+#endif
 }
 
 static unsigned int mpic_type_to_vecpri(struct mpic *mpic, unsigned int type)
@@ -1038,11 +1044,18 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 				     >> MPIC_GREG_FEATURE_LAST_SRC_SHIFT) + 1;
 
 	/* Map the per-CPU registers */
+#ifdef CONFIG_ASMP
+	unsigned int pir;
+	pir = mfspr(SPRN_PIR);
+	mpic_map(mpic, paddr, &mpic->cpuregs[0], MPIC_INFO(CPU_BASE) +
+		pir * MPIC_INFO(CPU_STRIDE), 0x1000);
+#else
 	for (i = 0; i < mpic->num_cpus; i++) {
 		mpic_map(mpic, paddr, &mpic->cpuregs[i],
 			 MPIC_INFO(CPU_BASE) + i * MPIC_INFO(CPU_STRIDE),
 			 0x1000);
 	}
+#endif
 
 	/* Initialize main ISU if none provided */
 	if (mpic->isu_size == 0) {
@@ -1145,6 +1158,29 @@ void __init mpic_init(struct mpic *mpic)
 	if ((mpic->flags & MPIC_BROKEN_U3) && (mpic->flags & MPIC_PRIMARY))
  		mpic_scan_ht_pics(mpic);
 
+#ifdef CONFIG_ASMP
+	u32 pir, rirq, intsize, intlen, vecpri;
+	struct device_node *np;
+	const u32 *intspec, *tmp;
+
+	/* get current core id */
+	pir = mfspr(SPRN_PIR);
+
+	/* get interrupts which are  assigned to this core */
+	np = of_find_node_by_type(NULL, "open-pic");
+	intspec = get_property(np, "interrupts", &intlen);
+	intlen /= sizeof(u32);
+	tmp = get_property(np, "#interrupt-cells", NULL);
+	intsize = *tmp;
+	for (i = 0; i < (intlen / 2); i++) {
+		rirq = intspec[i * intsize];
+		vecpri = MPIC_VECPRI_MASK | rirq |
+			(8 << MPIC_VECPRI_PRIORITY_SHIFT);
+		mpic_irq_write(rirq, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
+		mpic_irq_write(rirq, MPIC_INFO(IRQ_DESTINATION),
+			1 << pir);
+	}
+#else
 	for (i = 0; i < mpic->num_sources; i++) {
 		/* start with vector = source number, and masked */
 		u32 vecpri = MPIC_VECPRI_MASK | i |
@@ -1155,6 +1191,7 @@ void __init mpic_init(struct mpic *mpic)
 		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
 			       1 << hard_smp_processor_id());
 	}
+#endif
 	
 	/* Init spurious vector */
 	mpic_write(mpic->gregs, MPIC_INFO(GREG_SPURIOUS), mpic->spurious_vec);
diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 1f83988..7ec67d9 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -692,11 +692,21 @@ int startup_gfar(struct net_device *dev)
 
 	priv->tx_bd_base = (struct txbd8 *) vaddr;
 
+#ifdef CONFIG_ASMP
+	unsigned int pir;
+	pir = mfspr(SPRN_PIR);
+	/* enet DMA only understands physical addresses */
+	gfar_write(&regs->tbase0, ((unsigned int)addr + 0x10000000 * pir));
+
+	/* Start the rx descriptor ring where the tx ring leaves off */
+	addr = addr + sizeof (struct txbd8) * priv->tx_ring_size + 0x10000000 * pir;
+#else
 	/* enet DMA only understands physical addresses */
 	gfar_write(&regs->tbase0, addr);
 
 	/* Start the rx descriptor ring where the tx ring leaves off */
 	addr = addr + sizeof (struct txbd8) * priv->tx_ring_size;
+#endif
 	vaddr = vaddr + sizeof (struct txbd8) * priv->tx_ring_size;
 	priv->rx_bd_base = (struct rxbd8 *) vaddr;
 	gfar_write(&regs->rbase0, addr);
@@ -1006,8 +1016,15 @@ static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* Set buffer length and pointer */
 	txbdp->length = skb->len;
+#ifdef CONFIG_ASMP
+	unsigned int pir;
+	pir = mfspr(SPRN_PIR);
+	txbdp->bufPtr = dma_map_single(NULL, skb->data,
+			skb->len, DMA_TO_DEVICE) + 0x10000000 * pir;
+#else
 	txbdp->bufPtr = dma_map_single(NULL, skb->data,
 			skb->len, DMA_TO_DEVICE);
+#endif
 
 	/* Save the skb pointer so we can free it later */
 	priv->tx_skbuff[priv->skb_curtx] = skb;
@@ -1298,8 +1315,15 @@ struct sk_buff * gfar_new_skb(struct net_device *dev, struct rxbd8 *bdp)
 
 	skb->dev = dev;
 
+#ifdef CONFIG_ASMP
+	unsigned int pir;
+	pir = mfspr(SPRN_PIR);
+	bdp->bufPtr = dma_map_single(NULL, skb->data,
+			priv->rx_buffer_size, DMA_FROM_DEVICE) + 0x10000000 * pir;
+#else
 	bdp->bufPtr = dma_map_single(NULL, skb->data,
 			priv->rx_buffer_size, DMA_FROM_DEVICE);
+#endif
 
 	bdp->length = 0;
