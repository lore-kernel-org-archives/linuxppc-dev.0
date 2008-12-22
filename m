Return-Path: <spamreceptor@yahoo.com>
Received: from web30103.mail.mud.yahoo.com (web30103.mail.mud.yahoo.com
	[209.191.69.35]) by ozlabs.org (Postfix) with SMTP id 1C15EDDD1B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Dec 2008 09:44:57 +1100 (EST)
Date: Mon, 22 Dec 2008 14:44:56 -0800 (PST)
From: Joe Shmo <spamreceptor@yahoo.com>
Subject: uboot 1.3.0 compatible with linux 2.6.21?
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <193482.90130.qm@web30103.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm using a board that is a derivative of the 8313ERDB
board.  The freescale BSP for that board included a
patched uboot 1.1.6 that works with the 2.6.21 kernel.
 

On my board, I could not get the 1.1.6 uboot to boot
so I tried the 1.3.0 version.  This boots just fine
and is able to do TFTP with our different PHYs, RAM,
and flash.  However, the kernel cannot load the
filesystem over NFS.  Our current filesystem is too
large for hardware and we need to be able to do this
for development anyway.  We know the kernel is not
trying since there is no activity out of the board
once the kernel starts as confirmed by logic analyzer.

I've changed the DTS file describing our hardware and
recompiled it, but no luck.  I'm wondering if the
different versions of uboot manipulate the DTS file in
different ways and there may not be a way for these
two versions to run together.  That's the main
question here.

I've included my DTS changes.  I changed the PHY
addresses and took out the interrupt info for those
PHYs (as recommended by a freescale person).  Note
that our PHY driver under the kernel appears to be
working as the LED is blinking away as it should and
using the generic PHY driver does not fix it.  

Thanks for your consideration.

/*
 * MPC8313E RDB Device Tree Source
 *
 * Copyright 2005, 2006, 2007 Freescale Semiconductor
Inc.
 *
 * This program is free software; you can redistribute
 it and/or modify it
 * under  the terms of  the GNU General  Public
License as published by the
 * Free Software Foundation;  either version 2 of the 
License, or (at your
 * option) any later version.
 */

/ {
	model = "MPC8313ERDB";
	compatible = "MPC8313ERDB", "MPC831xRDB",
"MPC83xxRDB";
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#cpus = <1>;
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,8313@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <20>;	// 32 bytes
			i-cache-line-size = <20>;	// 32 bytes
			d-cache-size = <4000>;		// L1, 16K
			i-cache-size = <4000>;		// L1, 16K
			timebase-frequency = <0>;	// from bootloader
			bus-frequency = <0>;		// from bootloader
			clock-frequency = <0>;		// from bootloader
			32-bit;
		};
	};

	memory {
		device_type = "memory";
		reg = <00000000 08000000>;	// 128MB at 0
	};

	nand0 {
		device_type = "nand";
		compatible = "fsl-nand";
		reg = <e2800000 2000>;
		/*partitions =
"nand0:1m(u-boot)ro,3m(kernel),-(jffs2)";*/
	};

	soc8313@e0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		#interrupt-cells = <2>;
		device_type = "soc";
		ranges = <0 e0000000 00100000>;
		reg = <e0000000 00000200>;
		bus-frequency = <0>;

		wdt@200 {
			device_type = "watchdog";
			compatible = "mpc83xx_wdt";
			reg = <200 100>;
		};

		pit@400 {
			device_type = "pit";
			compatible = "mpc_pit";
			reg = <400 100>;
			interrupts = <41 8>;
			interrupt-parent = < &ipic >;
		};

		i2c@3000 {
			device_type = "i2c";
			compatible = "fsl-i2c";
			reg = <3000 100>;
			interrupts = <e 8>;
			interrupt-parent = < &ipic >;
			dfsrr;
		};

		i2c@3100 {
			device_type = "i2c";
			compatible = "fsl-i2c";
			reg = <3100 100>;
			interrupts = <f 8>;
			interrupt-parent = < &ipic >;
			dfsrr;
		};

		spi@7000 {
			device_type = "spi";
			compatible = "mpc83xx_spi";
			reg = <7000 1000>;
			interrupts = <10 8>;
			interrupt-parent = < &ipic >;
			mode = <0>;
		};

		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
		usb@23000 {
			device_type = "usb";
			compatible = "fsl-usb2-dr";
			reg = <23000 1000>;
			#address-cells = <1>;
			#size-cells = <0>;
			interrupt-parent = < &ipic >;
			interrupts = <26 8>;
			phy_type = "utmi_wide";
		};

		mdio@24520 {
			device_type = "mdio";
			compatible = "gianfar";
			reg = <24520 20>;
			#address-cells = <1>;
			#size-cells = <0>;
			phy3: ethernet-phy@3 {
				reg = <3>;
				device_type = "ethernet-phy";
			};
			phy1: ethernet-phy@1 {
				reg = <1>;
				device_type = "ethernet-phy";
			};
		};

		ethernet@24000 {
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <24000 1000>;
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <25 8 24 8 23 8>;
			interrupt-parent = < &ipic >;
			phy-handle = < &phy3 >;
		};

		ethernet@25000 {
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <25000 1000>;
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <22 8 21 8 20 8>;
			interrupt-parent = < &ipic >;
			phy-handle = < &phy1 >;
		};

		serial@4500 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4500 100>;
			clock-frequency = <0>;
			interrupts = <9 8>;
			interrupt-parent = < &ipic >;
		};

		serial@4600 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4600 100>;
			clock-frequency = <0>;
			interrupts = <a 8>;
			interrupt-parent = < &ipic >;
		};

		pci@8500 {
			interrupt-map-mask = <f800 0 0 7>;
			interrupt-map = <

					/* IDSEL 0x0E -mini PCI */
					 7000 0 0 1 &ipic 12 8
					 7000 0 0 2 &ipic 12 8
					 7000 0 0 3 &ipic 12 8
					 7000 0 0 4 &ipic 12 8

					/* IDSEL 0x0F - PCI slot */
					 7800 0 0 1 &ipic 11 8
					 7800 0 0 2 &ipic 12 8
					 7800 0 0 3 &ipic 11 8
					 7800 0 0 4 &ipic 12 8>;
			interrupt-parent = < &ipic >;
			interrupts = <42 8>;
			bus-range = <0 0>;
			ranges = <02000000 0 90000000 90000000 0 10000000
			          42000000 0 80000000 80000000 0 10000000
			          01000000 0 00000000 e2000000 0 00100000>;
			clock-frequency = <3f940aa>;
			#interrupt-cells = <1>;
			#size-cells = <2>;
			#address-cells = <3>;
			reg = <8500 100>;
			compatible = "83xx";
			device_type = "pci";
		};

		crypto@30000 {
			device_type = "crypto";
			model = "SEC2";
			compatible = "talitos";
			reg = <30000 7000>;
			interrupts = <b 8>;
			interrupt-parent = < &ipic >;
			/* Rev. 2.2 */
			num-channels = <1>;
			channel-fifo-len = <18>;
			exec-units-mask = <0000004c>;
			descriptor-types-mask = <0122003f>;
		};

		/* IPIC
		 * interrupts cell = <intr #, sense>
		 * sense values match linux IORESOURCE_IRQ_*
defines:
		 * sense == 8: Level, low assertion
		 * sense == 2: Edge, high-to-low change
		 */
		ipic: pic@700 {
			interrupt-controller;
			#address-cells = <0>;
			#interrupt-cells = <2>;
			reg = <700 100>;
			built-in;
			device_type = "ipic";
		};

		elbc@5000 {
			device_type = "elbc";
			compatible = "fsl-elbc";
			reg = <5000 1000>;
			interrupts = <4d 8>;
			interrupt-parent = < &ipic >;
			allow-direct-device-sleep;
		};
	};
};



      
