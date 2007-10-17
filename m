Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 52DE7DDEB8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 05:55:47 +1000 (EST)
Date: Wed, 17 Oct 2007 21:55:42 +0200
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: loading NOR flash from DT
Message-ID: <20071017195542.GA5501@Chamillionaire.breakpoint.cc>
References: <20071017192651.GA5192@Chamillionaire.breakpoint.cc>
	<20071017144759.320209bd@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20071017144759.320209bd@weaponx.rchland.ibm.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

* Josh Boyer | 2007-10-17 14:47:59 [-0500]:

>On Wed, 17 Oct 2007 21:26:51 +0200
>Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc> wrote:
>
>> Hello,
>> 
>> I have here a MPC8544 DS board with NOR flash on it and Kumar's git
>> tree. I'm trying to detect this flash with the physmap_of module. I
>> added a nor_flash block (I used sequoia.dts as an example) into my
>> device tree on the same level as soc8544 or memory (or between them).
>> After modprobing physmap_of nothing happend. Then I tried to make a tree
>> with plb -> opb -> ebc and finally nor_flash but still nothing changed.
>> 
>> Is there a user space dependency or did I just edit my device tree the
>> wrong way? Any hints are welcome :)
>
>Post your device tree please.  I don't recall MPC8544 even having PLB,
>OPB, or EBC busses, so they likely aren't getting probed.


/*
 * MPC8544 DS Device Tree Source
 *
 * Copyright 2007 Freescale Semiconductor Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

/ {
	model = "MPC8544DS";
	compatible = "MPC8544DS", "MPC85xxDS";
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#cpus = <1>;
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,8544@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <20>;	// 32 bytes
			i-cache-line-size = <20>;	// 32 bytes
			d-cache-size = <8000>;		// L1, 32K
			i-cache-size = <8000>;		// L1, 32K
			timebase-frequency = <0>;
			bus-frequency = <0>;
			clock-frequency = <0>;
		};
	};

	memory {
		device_type = "memory";
		reg = <00000000 00000000>;	// Filled by U-Boot
	};
	

	flash@fc000000 {
			compatible = "amd,s29gl512n", "cfi-flash";
			reg = <fc000000 4000000>;
			bank-width = <2>;
			#address-cells = <1>;
			#size-cells = <1>;
			fs@0 {
					label = "fs";
					reg = <0 f80000>;
			};
			firmware@f80000 {
					label ="firmware";
					reg = <f80000 80000>;
					read-only;
			};

	soc8544@e0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		device_type = "soc";

		ranges = <00000000 e0000000 00100000>;
		reg = <e0000000 00001000>;	// CCSRBAR 1M
		bus-frequency = <0>;		// Filled out by uboot.

		memory-controller@2000 {
			compatible = "fsl,8544-memory-controller";
			reg = <2000 1000>;
			interrupt-parent = <&mpic>;
			interrupts = <12 2>;
		};

		l2-cache-controller@20000 {
			compatible = "fsl,8544-l2-cache-controller";
			reg = <20000 1000>;
			cache-line-size = <20>;	// 32 bytes
			cache-size = <40000>;	// L2, 256K
			interrupt-parent = <&mpic>;
			interrupts = <10 2>;
		};

		i2c@3000 {
			device_type = "i2c";
			compatible = "fsl-i2c";
			reg = <3000 100>;
			interrupts = <2b 2>;
			interrupt-parent = <&mpic>;
			dfsrr;
		};

		mdio@24520 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "mdio";
			compatible = "gianfar";
			reg = <24520 20>;
			phy0: ethernet-phy@0 {
				interrupt-parent = <&mpic>;
				interrupts = <a 1>;
				reg = <0>;
				device_type = "ethernet-phy";
			};
			phy1: ethernet-phy@1 {
				interrupt-parent = <&mpic>;
				interrupts = <a 1>;
				reg = <1>;
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
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <1d 2 1e 2 22 2>;
			interrupt-parent = <&mpic>;
			phy-handle = <&phy0>;
			phy-connection-type = "rgmii-id";
		};

		ethernet@26000 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <26000 1000>;
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <1f 2 20 2 21 2>;
			interrupt-parent = <&mpic>;
			phy-handle = <&phy1>;
			phy-connection-type = "rgmii-id";
		};

		serial@4500 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4500 100>;
			clock-frequency = <0>;
			interrupts = <2a 2>;
			interrupt-parent = <&mpic>;
		};

		serial@4600 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4600 100>;
			clock-frequency = <0>;
			interrupts = <2a 2>;
			interrupt-parent = <&mpic>;
		};

		global-utilities@e0000 {	//global utilities block
			compatible = "fsl,mpc8548-guts";
			reg = <e0000 1000>;
			fsl,has-rstcr;
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
		compatible = "fsl,mpc8540-pci";
		device_type = "pci";
		interrupt-map-mask = <f800 0 0 7>;
		interrupt-map = <

			/* IDSEL 0x11 J17 Slot 1 */
			8800 0 0 1 &mpic 2 1
			8800 0 0 2 &mpic 3 1
			8800 0 0 3 &mpic 4 1
			8800 0 0 4 &mpic 1 1

			/* IDSEL 0x12 J16 Slot 2 */

			9000 0 0 1 &mpic 3 1
			9000 0 0 2 &mpic 4 1
			9000 0 0 3 &mpic 2 1
			9000 0 0 4 &mpic 1 1>;

		interrupt-parent = <&mpic>;
		interrupts = <18 2>;
		bus-range = <0 ff>;
		ranges = <02000000 0 c0000000 c0000000 0 20000000
			  01000000 0 00000000 e1000000 0 00010000>;
		clock-frequency = <3f940aa>;
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <e0008000 1000>;
	};

	pcie@e0009000 {
		compatible = "fsl,mpc8548-pcie";
		device_type = "pci";
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <e0009000 1000>;
		bus-range = <0 ff>;
		ranges = <02000000 0 80000000 80000000 0 20000000
			  01000000 0 00000000 e1010000 0 00010000>;
		clock-frequency = <1fca055>;
		interrupt-parent = <&mpic>;
		interrupts = <1a 2>;
		interrupt-map-mask = <f800 0 0 7>;
		interrupt-map = <
			/* IDSEL 0x0 */
			0000 0 0 1 &mpic 4 1
			0000 0 0 2 &mpic 5 1
			0000 0 0 3 &mpic 6 1
			0000 0 0 4 &mpic 7 1
			>;
		pcie@0 {
			reg = <0 0 0 0 0>;
			#size-cells = <2>;
			#address-cells = <3>;
			device_type = "pci";
			ranges = <02000000 0 80000000
				  02000000 0 80000000
				  0 20000000

				  01000000 0 00000000
				  01000000 0 00000000
				  0 00010000>;
		};
	};

	pcie@e000a000 {
		compatible = "fsl,mpc8548-pcie";
		device_type = "pci";
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <e000a000 1000>;
		bus-range = <0 ff>;
		ranges = <02000000 0 a0000000 a0000000 0 10000000
			  01000000 0 00000000 e1020000 0 00010000>;
		clock-frequency = <1fca055>;
		interrupt-parent = <&mpic>;
		interrupts = <19 2>;
		interrupt-map-mask = <f800 0 0 7>;
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
			ranges = <02000000 0 a0000000
				  02000000 0 a0000000
				  0 10000000

				  01000000 0 00000000
				  01000000 0 00000000
				  0 00010000>;
		};
	};

	pcie@e000b000 {
		compatible = "fsl,mpc8548-pcie";
		device_type = "pci";
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <e000b000 1000>;
		bus-range = <0 ff>;
		ranges = <02000000 0 b0000000 b0000000 0 00100000
			  01000000 0 00000000 b0100000 0 00100000>;
		clock-frequency = <1fca055>;
		interrupt-parent = <&mpic>;
		interrupts = <1b 2>;
		interrupt-map-mask = <fb00 0 0 0>;
		interrupt-map = <
			// IDSEL 0x1c  USB
			e000 0 0 0 &i8259 c 2
			e100 0 0 0 &i8259 9 2
			e200 0 0 0 &i8259 a 2
			e300 0 0 0 &i8259 b 2

			// IDSEL 0x1d  Audio
			e800 0 0 0 &i8259 6 2

			// IDSEL 0x1e Legacy
			f000 0 0 0 &i8259 7 2
			f100 0 0 0 &i8259 7 2

			// IDSEL 0x1f IDE/SATA
			f800 0 0 0 &i8259 e 2
			f900 0 0 0 &i8259 5 2
		>;

		pcie@0 {
			reg = <0 0 0 0 0>;
			#size-cells = <2>;
			#address-cells = <3>;
			device_type = "pci";
			ranges = <02000000 0 b0000000
				  02000000 0 b0000000
				  0 00100000

				  01000000 0 00000000
				  01000000 0 00000000
				  0 00100000>;

			uli1575@0 {
				reg = <0 0 0 0 0>;
				#size-cells = <2>;
				#address-cells = <3>;
				ranges = <02000000 0 b0000000
					  02000000 0 b0000000
					  0 00100000

					  01000000 0 00000000
					  01000000 0 00000000
					  0 00100000>;
				isa@1e {
					device_type = "isa";
					#interrupt-cells = <2>;
					#size-cells = <1>;
					#address-cells = <2>;
					reg = <f000 0 0 0 0>;
					ranges = <1 0
						  01000000 0 0
						  00001000>;
					interrupt-parent = <&i8259>;

					i8259: interrupt-controller@20 {
						reg = <1 20 2
						       1 a0 2
						       1 4d0 2>;
						interrupt-controller;
						device_type = "interrupt-controller";
						#address-cells = <0>;
						#interrupt-cells = <2>;
						compatible = "chrp,iic";
						interrupts = <9 2>;
						interrupt-parent = <&mpic>;
					};

					i8042@60 {
						#size-cells = <0>;
						#address-cells = <1>;
						reg = <1 60 1 1 64 1>;
						interrupts = <1 3 c 3>;
						interrupt-parent = <&i8259>;

						keyboard@0 {
							reg = <0>;
							compatible = "pnpPNP,303";
						};

						mouse@1 {
							reg = <1>;
							compatible = "pnpPNP,f03";
						};
					};

					rtc@70 {
						compatible = "pnpPNP,b00";
						reg = <1 70 2>;
					};

					gpio@400 {
						reg = <1 400 80>;
					};
				};
			};
		};

	};
};

>
>josh

Sebastian
