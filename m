Return-Path: <amarquez@edgeaccess.net>
Received: from [209.168.173.179] (unknown [209.168.173.179])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "firewall.edgeaccess.net",
	Issuer "firewall.edgeaccess.net" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8897FB7C8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Jan 2010 01:49:33 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by firewall.edgeaccess.net (Postfix) with ESMTP id 37AC727405B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jan 2010 09:49:30 -0500 (EST)
Received: from mail.edgeaccess.net (unknown [192.168.10.99])
	by firewall.edgeaccess.net (Postfix) with ESMTP id C4C2427405A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jan 2010 09:49:23 -0500 (EST)
Date: Fri, 15 Jan 2010 09:30:40 -0500
From: Andres F Marquez <amarquez@edgeaccess.net>
To: Scott Wood <scottwood@freescale.com>
Message-ID: <1263565840.13514.2.camel@localhost.localdomain>
In-Reply-To: <4B4F9059.9050705@freescale.com>
References: <1263501641.12055.9.camel@localhost.localdomain>
References: <4B4F9059.9050705@freescale.com>
Subject: Re: Problem dtb file booting Kernel 2.6.32
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=-5ZZaMzA1oFqA3AakvOMN"
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: Andres Marquez <amarquez@edgeaccess.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-5ZZaMzA1oFqA3AakvOMN
Content-Type: text/plain
Content-Disposition: inline

Hello,

I was able to boot Kernel 2.6.26.8 (using our old dts file from 
Kernel 2.6.25). However, I need to upgrade to a newer Kernel because
I am having serious problems with the ethernet interface under heavy
load. I am not sure if it could be a scheduling problem or the network
driver. CPU usage is low but load average is high (more than 4).

The main difference that I could find is that for newer Kernels the 
/arch/ppc was removed. I also read online that dts version changed 
from 0 to 1 somewhere around Kernel 2.6.27 or so.

Following your instruction, I executed in the LTIB command shell:

LTIB> dtc -I dtb -O dts ../mpc8272ads.dtb

I executed that command passing as argument the old working dtb file.
I got a dts file which I placed in the new Kernel and compiled.
Unfortunately, I am still getting the same error.

Attached you can find both dts files.

Thank you.


-- 
Andres F Marquez
EdgeAccess
Development
amarquez@edgeaccess.net



On Thu, 2010-01-14 at 15:44 -0600, Scott Wood wrote:
> Andres F Marquez wrote:
> > Hello,
> > 
> > I am working on a MPC8265 board which I have successfully ported Linux
> > Kernel 2.6.25 to. I am trying to upgrade the Kernel but have not got
> > good results (I am able to compile the Kernel for my powerpc, but not to
> > boot it). The problem appears to be something related to the interaction
> > between the dtb and the Kernel. I am not sure if the syntax for the dts
> > file may have changed from Kernel 2.6.25 to newer versions (I have tried
> > 2.6.27.43 - 2.6.32.2 and 2.6.31.11 getting very similar results).
> 
> Can you bisect between 2.6.25 and 2.6.27 to see which commit may have 
> broken it?
> 
> What sort of changes did you make to get 2.6.25 to work?
> 
> > When I build the dtb file from the /arch/powerpc/boot/dts/MPC8272ADS.dts
> > file that comes with the new Kernel, the booting process gets stuck
> > after trying to load the device tree:
> > 
> > 	## Booting image at ff810000 ...
> >    		Image Name:   Linux-2.6.27.43
> >    		Image Type:   PowerPC Linux Kernel Image (gzip  
> > 			compressed)
> > 		Data Size:    1365263 Bytes =  1.3 MB
> >    		Load Address: 00000000
> >    		Entry Point:  00000000
> >    		Verifying Checksum ... OK
> >    		Uncompressing Kernel Image ... OK
> >    		Booting using the fdt at 0xff802000
> >    		Loading Device Tree to 007fc000, end 007fefff ... OK
> > 
> > 
> >    However, when I boot the new Kernel with the old compiled dtb file
> > (the one that works with the Kernel 2.6.25) the process moves forward
> > but stops at a time when displaying information about IRQ 40 line
> > (related to the Programmable Interrup Controller (PIC)):
> 
> Decompile that device tree blob using dtc -I dtb -O dts, and look for 
> differences.
> 
> -Scott


--=-5ZZaMzA1oFqA3AakvOMN
Content-Type: text/plain;
	charset="US-ASCII";
	name="mpc8272ads-Kernel-2.6.25.dts"
Content-Disposition: attachment;
	filename="mpc8272ads-Kernel-2.6.25.dts"

/*
 * Device Tree for the PQ2FADS-ZU board with an MPC8280 chip.
 *
 * Copyright 2007 Freescale Semiconductor Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

/ {
	model = "pq2fads";
	compatible = "fsl,pq2fads";
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		cpu@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <d#32>;
			i-cache-line-size = <d#32>;
			d-cache-size = <d#16384>;
			i-cache-size = <d#16384>;
			timebase-frequency = <0>;
			clock-frequency = <0>;
		};
	};

	memory {
		device_type = "memory";
		reg = <00000000 02000000>;
	};

	localbus@f0010100 {
		compatible = "fsl,mpc8280-localbus",
		             "fsl,pq2-localbus";
		#address-cells = <2>;
		#size-cells = <1>;
		reg = <f0010100 60>;

		ranges = <0 0 fe000000 00800000
		          1 0 f4500000 00008000
		          8 0 f8200000 00008000>;

		flash@0,0 {
			compatible = "jedec-flash";
			reg = <0 0 800000>;
			bank-width = <4>;
			device-width = <1>;
		};

		bcsr@1,0 {
			reg = <1 0 20>;
			compatible = "fsl,pq2fads-bcsr";
		};

		PCI_PIC: pic@8,0 {
			#interrupt-cells = <1>;
			interrupt-controller;
			reg = <8 0 8>;
			compatible = "fsl,pq2ads-pci-pic";
			interrupt-parent = <&PIC>;
			interrupts = <18 8>;
		};
	};

	pci@f0010800 {
		device_type = "pci";
		reg = <f0010800 10c f00101ac 8 f00101c4 8>;
		compatible = "fsl,mpc8280-pci", "fsl,pq2-pci";
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		clock-frequency = <d#66000000>;
		interrupt-map-mask = <f800 0 0 7>;
		interrupt-map = <
		                /* IDSEL 0x16 */
		                 b000 0 0 1 &PCI_PIC 0
		                 b000 0 0 2 &PCI_PIC 1
		                 b000 0 0 3 &PCI_PIC 2
		                 b000 0 0 4 &PCI_PIC 3

		                /* IDSEL 0x17 */
		                 b800 0 0 1 &PCI_PIC 4
		                 b800 0 0 2 &PCI_PIC 5
		                 b800 0 0 3 &PCI_PIC 6
		                 b800 0 0 4 &PCI_PIC 7

		                /* IDSEL 0x18 */
		                 c000 0 0 1 &PCI_PIC 8
		                 c000 0 0 2 &PCI_PIC 9
		                 c000 0 0 3 &PCI_PIC a
		                 c000 0 0 4 &PCI_PIC b>;

		interrupt-parent = <&PIC>;
		interrupts = <12 8>;
		ranges = <42000000 0 80000000 80000000 0 20000000
		          02000000 0 a0000000 a0000000 0 20000000
		          01000000 0 00000000 f6000000 0 02000000>;
	};

	soc@f0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		device_type = "soc";
		compatible = "fsl,mpc8280", "fsl,pq2-soc";
		ranges = <00000000 f0000000 00053000>;

		// Temporary -- will go away once kernel uses ranges for get_immrbase().
		reg = <f0000000 00053000>;

		cpm@119c0 {
			#address-cells = <1>;
			#size-cells = <1>;
			#interrupt-cells = <2>;
			compatible = "fsl,mpc8280-cpm", "fsl,cpm2";
			reg = <119c0 30>;
			ranges;

			muram@0 {
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0 0 10000>;

				data@0 {
					compatible = "fsl,cpm-muram-data";
					reg = <0 2000 9800 800>;
				};
			};

			brg@119f0 {
				compatible = "fsl,mpc8280-brg",
				             "fsl,cpm2-brg",
				             "fsl,cpm-brg";
				reg = <119f0 10 115f0 10>;
			};

			serial@11a00 {
				device_type = "serial";
				compatible = "fsl,mpc8280-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <11a00 20 8000 100>;
				interrupts = <28 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <1>;
				fsl,cpm-command = <00800000>;
			};

			serial@11a20 {
				device_type = "serial";
				compatible = "fsl,mpc8280-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <11a20 20 8100 100>;
				interrupts = <29 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <2>;
				fsl,cpm-command = <04a00000>;
			};

			ethernet@11320 {
				device_type = "network";
				compatible = "fsl,mpc8280-fcc-enet",
				             "fsl,cpm2-fcc-enet";
				reg = <11320 20 8500 100 113b0 1>;
				interrupts = <21 8>;
				interrupt-parent = <&PIC>;
				phy-handle = <&PHY0>;
				linux,network-index = <0>;
				fsl,cpm-command = <16200300>;
				local-mac-address = [00 e0 0a 0b 79 01];
			};

			ethernet@11340 {
				device_type = "network";
				compatible = "fsl,mpc8280-fcc-enet",
				             "fsl,cpm2-fcc-enet";
				reg = <11340 20 8600 100 113d0 1>;
				interrupts = <22 8>;
				interrupt-parent = <&PIC>;
				phy-handle = <&PHY1>;
				linux,network-index = <1>;
				fsl,cpm-command = <1a400300>;
				local-mac-address = [00 e0 0c 00 79 01];
			};

			mdio@10d40 {
				device_type = "mdio";
				compatible = "fsl,pq2fads-mdio-bitbang",
				             "fsl,mpc8280-mdio-bitbang",
				             "fsl,cpm2-mdio-bitbang";
				#address-cells = <1>;
				#size-cells = <0>;
				reg = <10d40 14>;
				fsl,mdio-pin = <9>;
				fsl,mdc-pin = <a>;

				PHY0: ethernet-phy@0 {
					interrupt-parent = <&PIC>;
					interrupts = <19 2>;
					reg = <0>;
					device_type = "ethernet-phy";
				};

				PHY1: ethernet-phy@1 {
					interrupt-parent = <&PIC>;
					interrupts = <19 2>;
					reg = <3>;
					device_type = "ethernet-phy";
				};
			};

			usb@11b60 {
				#address-cells = <1>;
				#size-cells = <0>;
				compatible = "fsl,mpc8280-usb",
				             "fsl,cpm2-usb";
				reg = <11b60 18 8b00 100>;
				interrupt-parent = <&PIC>;
				interrupts = <b 8>;
				fsl,cpm-command = <2e600000>;
			};
		};

		PIC: interrupt-controller@10c00 {
			#interrupt-cells = <2>;
			interrupt-controller;
			reg = <10c00 80>;
			compatible = "fsl,mpc8280-pic", "fsl,cpm2-pic";
		};

	};

	chosen {
		linux,stdout-path = "/soc/cpm/serial@11a00";
	};
};

--=-5ZZaMzA1oFqA3AakvOMN
Content-Type: text/plain;
	charset="US-ASCII";
	name="mpc8272ads-Kernel-2.6.32.2.dts"
Content-Disposition: attachment;
	filename="mpc8272ads-Kernel-2.6.32.2.dts"

/*
 * Device Tree for the PQ2FADS-ZU board with an MPC8280 chip.
 *
 * Copyright 2007 Freescale Semiconductor Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

/ {
	model = "pq2fads";
	compatible = "fsl,pq2fads";
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		cpu@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <32>;
			i-cache-line-size = <32>;
			d-cache-size = <16384>;
			i-cache-size = <16384>;
			timebase-frequency = <0>;
			clock-frequency = <0>;
		};
	};

	memory {
		device_type = "memory";
		reg = <00000000 02000000>;
	};

	soc@f0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		device_type = "soc";
		compatible = "fsl,mpc8280", "fsl,pq2-soc";
		ranges = <00000000 f0000000 00053000>;

		// Temporary -- will go away once kernel uses ranges for get_immrbase().
		reg = <f0000000 00053000>;

		cpm@119c0 {
			#address-cells = <1>;
			#size-cells = <1>;
			#interrupt-cells = <2>;
			compatible = "fsl,mpc8280-cpm", "fsl,cpm2";
			reg = <119c0 30>;
			ranges;

			muram@0 {
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0 0 10000>;

				data@0 {
					compatible = "fsl,cpm-muram-data";
					reg = <0 2000 9800 800>;
				};
			};

			brg@119f0 {
				compatible = "fsl,mpc8280-brg",
				             "fsl,cpm2-brg",
				             "fsl,cpm-brg";
				reg = <119f0 10 115f0 10>;
			};

			serial@11a00 {
				device_type = "serial";
				compatible = "fsl,mpc8280-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <11a00 20 8000 100>;
				interrupts = <40 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <1>;
				fsl,cpm-command = <00800000>;
			};

			serial@11a20 {
				device_type = "serial";
				compatible = "fsl,mpc8280-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <11a20 20 8100 100>;
				interrupts = <41 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <2>;
				fsl,cpm-command = <04a00000>;
			};

			ethernet@11320 {
				device_type = "network";
				compatible = "fsl,mpc8280-fcc-enet",
				             "fsl,cpm2-fcc-enet";
				reg = <11320 20 8500 100 113b0 1>;
				interrupts = <33 8>;
				interrupt-parent = <&PIC>;
				phy-handle = <&PHY0>;
				linux,network-index = <0>;
				fsl,cpm-command = <16200300>;
				local-mac-address = [00 e0 0a 0b 79 01];
			};

			ethernet@11340 {
				device_type = "network";
				compatible = "fsl,mpc8280-fcc-enet",
				             "fsl,cpm2-fcc-enet";
				reg = <11340 20 8600 100 113d0 1>;
				interrupts = <34 8>;
				interrupt-parent = <&PIC>;
				phy-handle = <&PHY1>;
				linux,network-index = <1>;
				fsl,cpm-command = <1a400300>;
				local-mac-address = [00 e0 0c 00 79 01];
			};

			mdio@10d40 {
				device_type = "mdio";
				compatible = "fsl,pq2fads-mdio-bitbang",
				             "fsl,mpc8280-mdio-bitbang",
				             "fsl,cpm2-mdio-bitbang";
				#address-cells = <1>;
				#size-cells = <0>;
				reg = <10d40 14>;
				fsl,mdio-pin = <9>;
				fsl,mdc-pin = <a>;

				PHY0: ethernet-phy@0 {
					interrupt-parent = <&PIC>;
					interrupts = <25 2>;
					reg = <0>;
					device_type = "ethernet-phy";
				};

				PHY1: ethernet-phy@1 {
					interrupt-parent = <&PIC>;
					interrupts = <25 2>;
					reg = <3>;
					device_type = "ethernet-phy";
				};
			};
	
		};

		PIC: interrupt-controller@10c00 {
			#interrupt-cells = <2>;
			interrupt-controller;
			reg = <10c00 80>;
			compatible = "fsl,mpc8280-pic", "fsl,cpm2-pic";
		};

	};

	chosen {
		linux,stdout-path = "/soc/cpm/serial@11a00";
	};
};

--=-5ZZaMzA1oFqA3AakvOMN--
