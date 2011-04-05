Return-Path: <carlos.moratelli@digitel.com.br>
Received: from atena.digitel.com.br (ares.digitel.com.br [200.198.105.40])
	by ozlabs.org (Postfix) with ESMTP id 9DFBEB6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Apr 2011 05:19:02 +1000 (EST)
Subject: Re: sdhc/mpc8536 - SDCard always detected like read-only
From: Carlos Roberto Moratelli <carlos.moratelli@digitel.com.br>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20110405190204.GB12723@pengutronix.de>
References: <1302028796.10112.59.camel@moratelli-host.digitel.com.br>
	<20110405190204.GB12723@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Apr 2011 16:19:31 -0300
Message-ID: <1302031171.10112.66.camel@moratelli-host.digitel.com.br>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Ter, 2011-04-05 às 21:02 +0200, Wolfram Sang escreveu:
> > Every idea or tip is apreciated.
> 
> Please post your dts.
> 

/*
 * MPC8536 DS Device Tree Source
 *
 * Copyright 2008-2009 Freescale Semiconductor, Inc.
 *
 * This program is free software; you can redistribute  it and/or modify
it
 * under  the terms of  the GNU General  Public License as published by
the
 * Free Software Foundation;  either version 2 of the  License, or (at
your
 * option) any later version.
 */

/dts-v1/;

/ {
	model = "fsl,mpc8536ds";
	compatible = "fsl,mpc8536ds";
	#address-cells = <2>;
	#size-cells = <2>;

	aliases {
		ethernet0 = &enet0;
		serial0 = &serial0;
		serial1 = &serial1;
		pci1 = &pci1;
	};

	cpus {
		#cpus = <1>;
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,8536@0 {
			device_type = "cpu";
			reg = <0>;
			next-level-cache = <&L2>;
		};
	};

	memory {
		device_type = "memory";
		reg = <0 0 0 0>;	// Filled by U-Boot
	};

	soc@fffe00000 {
		#address-cells = <1>;
		#size-cells = <1>;
		device_type = "soc";
		compatible = "simple-bus";
		ranges = <0x0 0xf 0xffe00000 0x100000>;
		bus-frequency = <0>;		// Filled out by uboot.

		ecm-law@0 {
			compatible = "fsl,ecm-law";
			reg = <0x0 0x1000>;
			fsl,num-laws = <12>;
		};

		ecm@1000 {
			compatible = "fsl,mpc8536-ecm", "fsl,ecm";
			reg = <0x1000 0x1000>;
			interrupts = <17 2>;
			interrupt-parent = <&mpic>;
		};

		memory-controller@2000 {
			compatible = "fsl,mpc8536-memory-controller";
			reg = <0x2000 0x1000>;
			interrupt-parent = <&mpic>;
			interrupts = <18 0x2>;
		};

		L2: l2-cache-controller@20000 {
			compatible = "fsl,mpc8536-l2-cache-controller";
			reg = <0x20000 0x1000>;
			interrupt-parent = <&mpic>;
			interrupts = <16 0x2>;
		};

		i2c@3000 {
			#address-cells = <1>;
			#size-cells = <0>;
			cell-index = <0>;
			compatible = "fsl-i2c";
			reg = <0x3000 0x100>;
			interrupts = <43 0x2>;
			interrupt-parent = <&mpic>;
			dfsrr;

			hwmon@48 {
				compatible = "national,lm73";
				reg = <0x49>;
			};

			rtc@68 {
				compatible = "rtc-m41t80,m41t82";
				reg = <0x68>;
			};

			lm90@4C {
				compatible = "lm90,adt7461";
				reg = <0x4C>;
			};
			
			
		};

		i2c@3100 {
			#address-cells = <1>;
			#size-cells = <0>;
			cell-index = <1>;
			compatible = "fsl-i2c";
			reg = <0x3100 0x100>;
			interrupts = <43 0x2>;
			interrupt-parent = <&mpic>;
			dfsrr;

			sfp@50 {
				compatible = "sfp_teste,sfp_teste";
				reg = <0x50>;
			};

			bcm56334@44{
				compatible = "bcm56334,bcm56334";
				reg = <0x44>;
			};

		};

		spi@7000 {
			cell-index = <0>;
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "fsl,mpc8536-espi";
			reg = <0x7000 0x1000>;
			interrupts = <59 0x2>;
			interrupt-parent = <&mpic>;
			fsl,espi-num-chipselects = <4>;
			mode = "cpu";

		};

		dma@21300 {
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "fsl,mpc8536-dma", "fsl,eloplus-dma";
			reg = <0x21300 4>;
			ranges = <0 0x21100 0x200>;
			cell-index = <0>;
			dma-channel@0 {
				compatible = "fsl,mpc8536-dma-channel",
					     "fsl,eloplus-dma-channel";
				reg = <0x0 0x80>;
				cell-index = <0>;
				interrupt-parent = <&mpic>;
				interrupts = <20 2>;
			};
			dma-channel@80 {
				compatible = "fsl,mpc8536-dma-channel",
					     "fsl,eloplus-dma-channel";
				reg = <0x80 0x80>;
				cell-index = <1>;
				interrupt-parent = <&mpic>;
				interrupts = <21 2>;
			};
			dma-channel@100 {
				compatible = "fsl,mpc8536-dma-channel",
					     "fsl,eloplus-dma-channel";
				reg = <0x100 0x80>;
				cell-index = <2>;
				interrupt-parent = <&mpic>;
				interrupts = <22 2>;
			};
			dma-channel@180 {
				compatible = "fsl,mpc8536-dma-channel",
					     "fsl,eloplus-dma-channel";
				reg = <0x180 0x80>;
				cell-index = <3>;
				interrupt-parent = <&mpic>;
				interrupts = <23 2>;
			};
		};

		usb@22000 {
			compatible = "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
			reg = <0x22000 0x1000>;
			#address-cells = <1>;
			#size-cells = <0>;
			interrupt-parent = <&mpic>;
			interrupts = <28 0x2>;
			phy_type = "ulpi";
		};

		usb@23000 {
			compatible = "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
			reg = <0x23000 0x1000>;
			#address-cells = <1>;
			#size-cells = <0>;
			interrupt-parent = <&mpic>;
			interrupts = <46 0x2>;
			phy_type = "ulpi";
		};

		enet0: ethernet@24000 {
			#address-cells = <1>;
			#size-cells = <1>;
			cell-index = <0>;
			device_type = "network";
			model = "eTSEC";
			compatible = "gianfar";
			reg = <0x24000 0x1000>;
			ranges = <0x0 0x24000 0x1000>;
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <29 2 30 2 34 2>;
			interrupt-parent = <&mpic>;
			tbi-handle = <&tbi0>;
			phy-handle = <&phy1>;
			phy-connection-type = "rgmii-id";

			mdio@520 {
				#address-cells = <1>;
				#size-cells = <0>;
				compatible = "fsl,gianfar-mdio";
				reg = <0x520 0x20>;

				phy0: ethernet-phy@0 {
					interrupt-parent = <&mpic>;
					interrupts = <10 0x1>;
					reg = <0>;
					device_type = "ethernet-phy";
				};
				phy1: ethernet-phy@1 {
					interrupt-parent = <&mpic>;
					interrupts = <10 0x1>;
					reg = <1>;
					device_type = "ethernet-phy";
				};
				tbi0: tbi-phy@11 {
					reg = <0x11>;
					device_type = "tbi-phy";
				};
			};
		};

		usb@2b000 {
			compatible = "fsl,mpc8536-usb2-dr", "fsl-usb2-dr";
			reg = <0x2b000 0x1000>;
			#address-cells = <1>;
			#size-cells = <0>;
			interrupt-parent = <&mpic>;
			interrupts = <60 0x2>;
			dr_mode = "peripheral";
			phy_type = "ulpi";
		};

		sdhci@2e000 {
			compatible = "fsl,mpc8536-esdhc", "fsl,esdhc";
			reg = <0x2e000 0x1000>;
			interrupts = <72 0x2>;
			interrupt-parent = <&mpic>;
			/* Filled in by U-Boot */
			clock-frequency = <0>;
		};
		
		serial0: serial@4500 {
			cell-index = <0>;
			device_type = "serial";
			compatible = "ns16550";
			reg = <0x4500 0x100>;
			clock-frequency = <0>;
			interrupts = <42 0x2>;
			interrupt-parent = <&mpic>;
		};

		serial1: serial@4600 {
			cell-index = <1>;
			device_type = "serial";
			compatible = "ns16550";
			reg = <0x4600 0x100>;
			clock-frequency = <0>;
			interrupts = <42 0x2>;
			interrupt-parent = <&mpic>;
		};

		crypto@30000 {
			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
				     "fsl,sec2.1", "fsl,sec2.0";
			reg = <0x30000 0x10000>;
			interrupts = <45 2 58 2>;
			interrupt-parent = <&mpic>;
			fsl,num-channels = <4>;
			fsl,channel-fifo-len = <24>;
			fsl,exec-units-mask = <0x9fe>;
			fsl,descriptor-types-mask = <0x3ab0ebf>;
		};

		sata@18000 {
			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
			reg = <0x18000 0x1000>;
			cell-index = <1>;
			interrupts = <74 0x2>;
			interrupt-parent = <&mpic>;
		};

		sata@19000 {
			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
			reg = <0x19000 0x1000>;
			cell-index = <2>;
			interrupts = <41 0x2>;
			interrupt-parent = <&mpic>;
		};

		global-utilities@e0000 {	//global utilities block
			compatible = "fsl,mpc8548-guts";
			reg = <0xe0000 0x1000>;
			fsl,has-rstcr;
		};

		mpic: pic@40000 {
			clock-frequency = <0>;
			interrupt-controller;
			#address-cells = <0>;
			#interrupt-cells = <2>;
			reg = <0x40000 0x40000>;
			compatible = "chrp,open-pic";
			device_type = "open-pic";
			big-endian;
		};

		msi@41600 {
			compatible = "fsl,mpc8536-msi", "fsl,mpic-msi";
			reg = <0x41600 0x80>;
			msi-available-ranges = <0 0x100>;
			interrupts = <
				0xe0 0
				0xe1 0
				0xe2 0
				0xe3 0
				0xe4 0
				0xe5 0
				0xe6 0
				0xe7 0>;
			interrupt-parent = <&mpic>;
		};
	};

	pci1: pcie@fffe0a000 {
		compatible = "fsl,mpc8548-pcie";
		device_type = "pci";
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <0xf 0xffe0a000 0 0x1000>;
		bus-range = <0 0xff>;
		ranges = <0x02000000 0 0xf8000000 0xc 0x10000000 0 0x08000000
			  0x01000000 0 0x00000000 0xf 0xffc10000 0 0x0010000>;
		clock-frequency = <66666666>;
		interrupt-parent = <&mpic>;
		interrupts = <26 0x2>;
		interrupt-map-mask = <0xf800 0 0 7>;
		interrupt-map = <
			/* IDSEL 0x0 */
			0000 0 0 1 &mpic 0 1
			0000 0 0 2 &mpic 1 1
			0000 0 0 3 &mpic 2 1
			0000 0 0 4 &mpic 3 1
			>;
		pcie@0 {
			reg = <0 0 0 0 0>;
			#size-cells = <2>;
			#address-cells = <3>;
			device_type = "pci";
			ranges = <0x02000000 0 0xf8000000
				  0x02000000 0 0xf8000000
				  0 0x08000000

				  0x01000000 0 0x00000000
				  0x01000000 0 0x00000000
				  0 0x00010000>;
		};
	};

};
