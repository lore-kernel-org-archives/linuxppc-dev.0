Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 7EAC0DDE02
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 20:11:00 +1100 (EST)
Date: Tue, 4 Mar 2008 10:10:59 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Message-ID: <20080304091059.GD18829@netgate.macqel>
References: <20080303144727.GA27949@ingate.macqel>
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>
	<20080303210532.GA20382@netgate.macqel>
	<47CC696C.4090103@freescale.com>
	<20080303212622.GB20382@netgate.macqel>
	<47CC73CE.4080801@freescale.com>
	<20080304080828.GA18829@netgate.macqel>
	<1204618939.21545.52.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
In-Reply-To: <1204618939.21545.52.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ben,

On Tue, Mar 04, 2008 at 07:22:19PM +1100, Benjamin Herrenschmidt wrote:
> 
> On Tue, 2008-03-04 at 09:08 +0100, Philippe De Muyter wrote:
> > With ARCH=ppc, all those interrupt's info's are hardcoded in the .c
> > files.
> > But I expected I could fill the dts file for ARCH=powerpc from info's
> > I
> > could collect in /proc on a running ARCH=ppc linux without dts file
> > for the same board.
> 
> Rather, look at the C file. Send it and we can help figuring things out.

Thanks in advance

Philippe

I also attach my current (not working) dts file attempt.  It is actually
a modified mpc8540ads.dts file.

I now thinks that the ide-cs (hda) discovery or not depends on the cold
or warm reboot.

Here are the patches for my config (MEIP_8540) relative to a vanilla
linux-2.6.24.  I hacked the MPC8540ADS config. The PCI4520 is the
multi-function chip from TI (dual-socket pc-card + iee1394 ohci and two-port
phy)

--- ./arch/ppc/platforms/85xx/mpc85xx_ads_common.cbk	2008-01-24 22:58:37.000000000 +0000
+++ ./arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2008-02-20 16:54:33.000000000 +0000
@@ -58,6 +58,29 @@
 /* Internal interrupts are all Level Sensitive, and Positive Polarity */
 static u_char mpc85xx_ads_openpic_initsenses[] __initdata = {
 	MPC85XX_INTERNAL_IRQ_SENSES,
+#ifdef CONFIG_MEIP_8540
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	// External 0 : nINTPFO
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	// External 1 : nINTRTC
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	// External 2 : nINTPLD
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	// External 3 : nINTSTX
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	// External 4 : nINTPHY
+#if defined(CONFIG_PCI)
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 5 : PCI4520 MFUNC 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 6 : PCI4520 MFUNC 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 7 : PCI4520 MFUNC 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 8 : PCI4520 MFUNC 3 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 9 : PCI4520 MFUNC 4 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 10 : PCI4520 MFUNC 5 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 11 : PCI4520 MFUNC 6 */
+#else
+	0x0,						/* External  6: */
+	0x0,						/* External  7: */
+	0x0,						/* External  8: */
+	0x0,						/* External  9: */
+	0x0,						/* External 10: */
+	0x0,						/* External 11: */
+#endif
+#else
 	0x0,						/* External  0: */
 #if defined(CONFIG_PCI)
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 1: PCI slot 0 */
@@ -77,6 +100,7 @@
 	0x0,				/* External  9: */
 	0x0,				/* External 10: */
 	0x0,				/* External 11: */
+#endif
 };
 
 /* ************************************************************************ */
--- ./arch/ppc/platforms/85xx/mpc85xx_ads_common.hbk	2008-01-24 22:58:37.000000000 +0000
+++ ./arch/ppc/platforms/85xx/mpc85xx_ads_common.h	2008-02-20 16:36:07.000000000 +0000
@@ -29,10 +29,17 @@
 extern void mpc85xx_ads_map_io(void) __init;
 
 /* PCI interrupt controller */
+#ifdef CONFIG_MEIP_8540
+#define PIRQA		MPC85xx_IRQ_EXT5
+#define PIRQB		MPC85xx_IRQ_EXT6
+#define PIRQC		MPC85xx_IRQ_EXT7
+#define PIRQD		MPC85xx_IRQ_EXT8
+#else
 #define PIRQA		MPC85xx_IRQ_EXT1
 #define PIRQB		MPC85xx_IRQ_EXT2
 #define PIRQC		MPC85xx_IRQ_EXT3
 #define PIRQD		MPC85xx_IRQ_EXT4
+#endif
 
 #define MPC85XX_PCI1_LOWER_IO	0x00000000
 #define MPC85XX_PCI1_UPPER_IO	0x00ffffff

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="meip-8540.dts"

/*
 * MEIP-8540 Device Tree Source
 *
 * Copyright 2008 Macq Electronique SA
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */


/ {
	model = "MEIP8540";
	compatible = "MEIP8540", "MPC85xxADS";
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,8540@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <20>;	// 32 bytes
			i-cache-line-size = <20>;	// 32 bytes
			d-cache-size = <8000>;		// L1, 32K
			i-cache-size = <8000>;		// L1, 32K
			timebase-frequency = <0>;	//  33 MHz, from uboot
			bus-frequency = <0>;	// 166 MHz
			clock-frequency = <0>;	// 825 MHz, from uboot
		};
	};

	memory {
		device_type = "memory";
		reg = <00000000 10000000>;	// 256M at 0x0
	};

	soc8540@e0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		device_type = "soc";
		ranges = <0 e0000000 00100000>;
		reg = <e0000000 00100000>;	// CCSRBAR 1M
		bus-frequency = <0>;

		memory-controller@2000 {
			compatible = "fsl,8540-memory-controller";
			reg = <2000 1000>;
			interrupt-parent = <&mpic>;
			interrupts = <12 2>;
		};

		l2-cache-controller@20000 {
			compatible = "fsl,8540-l2-cache-controller";
			reg = <20000 1000>;
			cache-line-size = <20>;	// 32 bytes
			cache-size = <40000>;	// L2, 256K
			interrupt-parent = <&mpic>;
			interrupts = <10 2>;
		};

		i2c@3000 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "i2c";
			compatible = "fsl-i2c";
			reg = <3000 100>;
			interrupts = <2b 2>;
			interrupt-parent = <&mpic>;
			dfsrr;

			rtc@68 {
				compatible = "stm,m41t81";
				reg = <68>;
			};
		};

		mdio@24520 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "mdio";
			compatible = "gianfar";
			reg = <24520 20>;
			phy0: ethernet-phy@0 {
				interrupt-parent = <&mpic>;
				interrupts = <5 1>;
				reg = <0>;
				device_type = "ethernet-phy";
			};
			phy1: ethernet-phy@1 {
				interrupt-parent = <&mpic>;
				interrupts = <5 1>;
				reg = <1>;
				device_type = "ethernet-phy";
			};
			phy3: ethernet-phy@3 {
				interrupt-parent = <&mpic>;
				interrupts = <7 1>;
				reg = <3>;
				device_type = "ethernet-phy";
			};
		};

		ethernet@24000 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <24000 1000>;
			/*
			 * address is deprecated and will be removed
			 * in 2.6.25.  Only recent versions of
			 * U-Boot support local-mac-address, however.
			 */
			address = [ 00 00 00 00 00 00 ];
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <1d 2 1e 2 22 2>;
			interrupt-parent = <&mpic>;
			phy-handle = <&phy0>;
		};

		ethernet@25000 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <25000 1000>;
			/*
			 * address is deprecated and will be removed
			 * in 2.6.25.  Only recent versions of
			 * U-Boot support local-mac-address, however.
			 */
			address = [ 00 00 00 00 00 00 ];
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <23 2 24 2 28 2>;
			interrupt-parent = <&mpic>;
			phy-handle = <&phy1>;
		};

		ethernet@26000 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "network";
			model = "FEC";
			compatible = "gianfar";
			reg = <26000 1000>;
			/*
			 * address is deprecated and will be removed
			 * in 2.6.25.  Only recent versions of
			 * U-Boot support local-mac-address, however.
			 */
			address = [ 00 00 00 00 00 00 ];
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <29 2>;
			interrupt-parent = <&mpic>;
			phy-handle = <&phy3>;
		};

		serial@4500 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4500 100>; 	// reg base, size
			clock-frequency = <0>; 	// should we fill in in uboot?
/*
			interrupts = <2a 2>;
*/
			interrupts = <1a 2>;
			interrupt-parent = <&mpic>;
		};

		serial@4600 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4600 100>;	// reg base, size
			clock-frequency = <0>; 	// should we fill in in uboot?
/*
			interrupts = <2a 2>;
*/
			interrupts = <1a 2>;
			interrupt-parent = <&mpic>;
		};
		mpic: pic@40000 {
			clock-frequency = <0>;
			interrupt-controller;
			#address-cells = <0>;
			#interrupt-cells = <2>;
			reg = <40000 40000>;
			compatible = "chrp,open-pic";
			device_type = "open-pic";
			big-endian;
		};
	};

	pci@e0008000 {
		interrupt-map-mask = <f800 0 0 7>;
		interrupt-map = <

			/* IDSEL 0x02 */
			1000 0 0 1 &mpic 1 1
			1000 0 0 2 &mpic 2 1
			1000 0 0 3 &mpic 3 1
			1000 0 0 4 &mpic 4 1

			/* IDSEL 0x03 */
			1800 0 0 1 &mpic 4 1
			1800 0 0 2 &mpic 1 1
			1800 0 0 3 &mpic 2 1
			1800 0 0 4 &mpic 3 1

			/* IDSEL 0x04 */
			2000 0 0 1 &mpic 3 1
			2000 0 0 2 &mpic 4 1
			2000 0 0 3 &mpic 1 1
			2000 0 0 4 &mpic 2 1

			/* IDSEL 0x05 */
			2800 0 0 1 &mpic 2 1
			2800 0 0 2 &mpic 3 1
			2800 0 0 3 &mpic 4 1
			2800 0 0 4 &mpic 1 1

			/* IDSEL 0x0c */
			6000 0 0 1 &mpic 1 1
			6000 0 0 2 &mpic 2 1
			6000 0 0 3 &mpic 3 1
			6000 0 0 4 &mpic 4 1

			/* IDSEL 0x0d */
			6800 0 0 1 &mpic 4 1
			6800 0 0 2 &mpic 1 1
			6800 0 0 3 &mpic 2 1
			6800 0 0 4 &mpic 3 1

			/* IDSEL 0x0e */
			7000 0 0 1 &mpic 3 1
			7000 0 0 2 &mpic 4 1
			7000 0 0 3 &mpic 1 1
			7000 0 0 4 &mpic 2 1

			/* IDSEL 0x0f */
			7800 0 0 1 &mpic 2 1
			7800 0 0 2 &mpic 3 1
			7800 0 0 3 &mpic 4 1
			7800 0 0 4 &mpic 1 1

			/* IDSEL 0x12 */
			9000 0 0 1 &mpic 1 1
			9000 0 0 2 &mpic 2 1
			9000 0 0 3 &mpic 3 1
			9000 0 0 4 &mpic 4 1

			/* IDSEL 0x13 */
			9800 0 0 1 &mpic 4 1
			9800 0 0 2 &mpic 1 1
			9800 0 0 3 &mpic 2 1
			9800 0 0 4 &mpic 3 1

			/* IDSEL 0x14 */
			a000 0 0 1 &mpic 3 1
			a000 0 0 2 &mpic 4 1
			a000 0 0 3 &mpic 1 1
			a000 0 0 4 &mpic 2 1

			/* IDSEL 0x15 */
			a800 0 0 1 &mpic 2 1
			a800 0 0 2 &mpic 3 1
			a800 0 0 3 &mpic 4 1
			a800 0 0 4 &mpic 1 1>;
		interrupt-parent = <&mpic>;
		/* interrupts number are coded in hexa ! */
/*
		interrupts = <18 2>;
		interrupts = <12 2 19 2 1a 2 1b 2 35 2 36 2 37 2>;
*/
		interrupts = <35 2 36 2 37 2>;
		bus-range = <0 0>;
		ranges = <02000000 0 80000000 80000000 0 20000000
			  01000000 0 00000000 e2000000 0 00100000>;
		clock-frequency = <3f940aa>;
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <e0008000 1000>;
		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
		device_type = "pci";
	};
};

--TB36FDmn/VVEgNH/--
