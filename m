Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CB880DDE35
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 16:37:11 +1000 (EST)
In-Reply-To: <20070905192924.GI32462@ld0162-tx32.am.freescale.net>
References: <20070905192924.GI32462@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9BC5B02A-4E9D-42DD-90C3-F8C3382F2A96@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 10/10] mpc82xx: Add pq2fads board support.
Date: Thu, 13 Sep 2007 01:39:58 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> diff --git a/arch/powerpc/boot/dts/pq2fads.dts b/arch/powerpc/boot/ 
> dts/pq2fads.dts
> new file mode 100644
> index 0000000..ad736f8
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/pq2fads.dts
> @@ -0,0 +1,236 @@
> +/*
> + * Device Tree for the PQ2FADS-ZU board with an MPC8280 chip.
> + *
> + * Copyright 2007 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +/ {
> +	model = "pq2fads";
> +	compatible = "fsl,pq2fads";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <d#32>;
> +			i-cache-line-size = <d#32>;
> +			d-cache-size = <d#16384>;
> +			i-cache-size = <d#16384>;
> +			timebase-frequency = <0>;
> +			clock-frequency = <0>;
> +		};
> +	};
> +
> +	CS: chipselect {

We need to document this in booting-without-of.

> +		compatible = "fsl,pq2fads-chipselect",
> +		             "fsl,mpc8280-chipselect",
> +		             "fsl,pq2-chipselect";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		fsl,ctrl = <&CSCTRL>;
> +
> +		ranges = <0 0 fe000000 00800000
> +		          1 0 f4500000 00008000
> +		          8 0 f8200000 00008000>;
> +
> +		flash@0,0 {
> +			device_type = "rom";
> +			compatible = "direct-mapped";
> +			reg = <0 0 800000>;
> +			probe-type = "JEDEC";
> +			bank-width = <4>;
> +		};
> +
> +		bcsr@1,0 {
> +			reg = <1 0 20>;
> +			compatible = "fsl,pq2fads-bcsr";
> +		};
> +
> +		PCI_PIC: pic@8,0 {
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +			reg = <8 0 8>;
> +			compatible = "fsl,pq2ads-pci-pic";
> +			interrupt-parent = <&PIC>;
> +			interrupts = <18 8>;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0>;
> +	};
> +
> +	soc@f0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		compatible = "fsl,mpc8280", "fsl,pq2-soc";
> +		ranges = <00000000 f0000000 00053000
> +		          80000000 80000000 40000000
> +		          f6000000 f6000000 02000000>;
> +
> +		CSCTRL: chipselect {
> +			compatible = "fsl,mpc8280-chipselect-ctrl",
> +			             "fsl,pq2-chipselect-ctrl";
> +			reg = <10100 60>;
> +			fsl,bus = <&CS>;
> +		};
> +
> +		cpm@119c0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			#interrupt-cells = <2>;
> +			compatible = "fsl,mpc8280-cpm", "fsl,cpm2";
> +			reg = <119c0 30 0 2000>;
> +			ranges;
> +
> +			brg@119f0 {
> +				compatible = "fsl,mpc8280-brg",
> +				             "fsl,cpm2-brg",
> +				             "fsl,cpm-brg";
> +				reg = <119f0 10 115f0 10>;
> +			};
> +
> +			serial@11a00 {
> +				device_type = "serial";
> +				compatible = "fsl,mpc8280-scc-uart",
> +				             "fsl,cpm2-scc-uart";
> +				reg = <11a00 20 8000 100>;
> +				interrupts = <28 8>;
> +				interrupt-parent = <&PIC>;
> +				fsl,cpm-brg = <1>;
> +				fsl,cpm-command = <00800000>;
> +			};
> +
> +			serial@11a20 {
> +				device_type = "serial";
> +				compatible = "fsl,mpc8280-scc-uart",
> +				             "fsl,cpm2-scc-uart";
> +				reg = <11a20 20 8100 100>;
> +				interrupts = <29 8>;
> +				interrupt-parent = <&PIC>;
> +				fsl,cpm-brg = <2>;
> +				fsl,cpm-command = <04a00000>;
> +			};
> +
> +			ethernet@11320 {
> +				device_type = "network";
> +				compatible = "fsl,mpc8280-fcc-enet",
> +				             "fsl,cpm2-fcc-enet";
> +				reg = <11320 20 8500 100 113b0 1>;
> +				interrupts = <21 8>;
> +				interrupt-parent = <&PIC>;
> +				phy-handle = <&PHY0>;
> +				linux,network-index = <0>;
> +				fsl,cpm-command = <16200300>;
> +			};
> +
> +			ethernet@11340 {
> +				device_type = "network";
> +				compatible = "fsl,mpc8280-fcc-enet",
> +				             "fsl,cpm2-fcc-enet";
> +				reg = <11340 20 8600 100 113d0 1>;
> +				interrupts = <22 8>;
> +				interrupt-parent = <&PIC>;
> +				phy-handle = <&PHY1>;
> +				linux,network-index = <1>;
> +				fsl,cpm-command = <1a400300>;
> +				local-mac-address = [00 e0 0c 00 79 01];
> +			};
> +
> +			mdio@10d40 {
> +				device_type = "mdio";
> +				compatible = "fsl,pq2fads-mdio-bitbang",
> +				             "fsl,mpc8280-mdio-bitbang",
> +				             "fsl,cpm2-mdio-bitbang";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <10d40 14>;
> +				fsl,mdio-pin = <9>;
> +				fsl,mdc-pin = <a>;
> +
> +				PHY0: ethernet-phy@0 {
> +					interrupt-parent = <&PIC>;
> +					interrupts = <19 2>;
> +					reg = <0>;
> +					device_type = "ethernet-phy";
> +				};
> +
> +				PHY1: ethernet-phy@1 {
> +					interrupt-parent = <&PIC>;
> +					interrupts = <19 2>;
> +					reg = <3>;
> +					device_type = "ethernet-phy";
> +				};
> +			};
> +
> +			usb@11b60 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,mpc8280-usb",
> +				             "fsl,cpm2-usb";
> +				reg = <11b60 18 8b00 100>;
> +				interrupt-parent = <&PIC>;
> +				interrupts = <b 8>;
> +				fsl,cpm-command = <2e600000>;
> +			};
> +		};
> +
> +		PIC: interrupt-controller@10c00 {
> +			#interrupt-cells = <2>;
> +			interrupt-controller;
> +			reg = <10c00 80>;
> +			compatible = "fsl,mpc8280-pic", "fsl,pq2-pic";

this should also have a "fsl,cpm2-pic" or something of that form.   
(exact same pic exists on 8560, 85xx+CPM)

> +		};
> +
> +		pci@10800 {
> +			device_type = "pci";
> +			reg = <10800 10c 101ac 8 101c4 8>;
> +			compatible = "fsl,mpc8280-pci", "fsl,pq2-pci";
> +			#interrupt-cells = <1>;
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			clock-frequency = <d#66000000>;
> +			interrupt-map-mask = <f800 0 0 7>;
> +			interrupt-map = <
> +			                /* IDSEL 0x16 */
> +			                 b000 0 0 1 &PCI_PIC 0
> +			                 b000 0 0 2 &PCI_PIC 1
> +			                 b000 0 0 3 &PCI_PIC 2
> +			                 b000 0 0 4 &PCI_PIC 3
> +
> +			                /* IDSEL 0x17 */
> +			                 b800 0 0 1 &PCI_PIC 4
> +			                 b800 0 0 2 &PCI_PIC 5
> +			                 b800 0 0 3 &PCI_PIC 6
> +			                 b800 0 0 4 &PCI_PIC 7
> +
> +			                /* IDSEL 0x18 */
> +			                 c000 0 0 1 &PCI_PIC 8
> +			                 c000 0 0 2 &PCI_PIC 9
> +			                 c000 0 0 3 &PCI_PIC a
> +			                 c000 0 0 4 &PCI_PIC b>;
> +
> +			interrupt-parent = <&PIC>;
> +			interrupts = <12 8>;
> +			ranges = <42000000 0 80000000 80000000 0 20000000
> +			          02000000 0 a0000000 a0000000 0 20000000
> +			          01000000 0 00000000 f6000000 0 02000000>;
> +		};
> +	};
> +
> +	chosen {
> +		linux,stdout-path = "/soc/cpm/serial@11a00";
> +	};
> +};

- k
