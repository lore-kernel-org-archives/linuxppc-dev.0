Return-Path: <amarquez@edgeaccess.net>
Received: from [209.168.173.179] (unknown [209.168.173.179])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "firewall.edgeaccess.net",
	Issuer "firewall.edgeaccess.net" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6D2ED1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jan 2010 08:28:36 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by firewall.edgeaccess.net (Postfix) with ESMTP id B276B27402D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jan 2010 15:59:24 -0500 (EST)
Received: from mail.edgeaccess.net (unknown [192.168.10.99])
	by firewall.edgeaccess.net (Postfix) with ESMTP id ACA79274028
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jan 2010 15:59:18 -0500 (EST)
Received: from mail.edgeaccess.net (localhost.localdomain [127.0.0.1])
	by mail.edgeaccess.net (8.13.8/8.13.8) with ESMTP id o0EKHkeH020473
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2010 15:17:46 -0500
Date: Thu, 14 Jan 2010 15:40:41 -0500
From: Andres F Marquez <amarquez@edgeaccess.net>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <1263501641.12055.9.camel@localhost.localdomain>
Subject: Problem dtb file booting Kernel 2.6.32
Mime-Version: 1.0
Content-Type: text/plain
Reply-To: Andres Marquez <amarquez@edgeaccess.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I am working on a MPC8265 board which I have successfully ported Linux
Kernel 2.6.25 to. I am trying to upgrade the Kernel but have not got
good results (I am able to compile the Kernel for my powerpc, but not to
boot it). The problem appears to be something related to the interaction
between the dtb and the Kernel. I am not sure if the syntax for the dts
file may have changed from Kernel 2.6.25 to newer versions (I have tried
2.6.27.43 - 2.6.32.2 and 2.6.31.11 getting very similar results).

When I build the dtb file from the /arch/powerpc/boot/dts/MPC8272ADS.dts
file that comes with the new Kernel, the booting process gets stuck
after trying to load the device tree:

	## Booting image at ff810000 ...
   		Image Name:   Linux-2.6.27.43
   		Image Type:   PowerPC Linux Kernel Image (gzip  
			compressed)
		Data Size:    1365263 Bytes =  1.3 MB
   		Load Address: 00000000
   		Entry Point:  00000000
   		Verifying Checksum ... OK
   		Uncompressing Kernel Image ... OK
   		Booting using the fdt at 0xff802000
   		Loading Device Tree to 007fc000, end 007fefff ... OK


   However, when I boot the new Kernel with the old compiled dtb file
(the one that works with the Kernel 2.6.25) the process moves forward
but stops at a time when displaying information about IRQ 40 line
(related to the Programmable Interrup Controller (PIC)):

	## Booting image at ff810000 ...
   	Image Name:   Linux-2.6.32.2
   	Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   	Data Size:    1431026 Bytes =  1.4 MB
   	Load Address: 00000000
   	Entry Point:  00000000
   	Verifying Checksum ... OK
   	Uncompressing Kernel Image ... OK
   	Booting using the fdt at 0xff802000
   	Loading Device Tree to 007fc000, end 007fefff ... OK
	id mach(): done
	MMU:enter
	MMU:hw init
	MMU:mapin
	MMU:setio
	MMU:exit
	Using Freescale PQ2FADS machine description
	Linux version 2.6.32.2 (nirmala@localhost.localdomain) (gcc 
	version 
	4.2.1 (Sourcery G++ Lite 4.2-82)) #11 Wed Jan 13 15:54:33 EST 
	2010
	bootconsole [udbg0] enabled
	setup_arch: bootmem
	pq2fads_setup_arch()
	No fsl,pq2fads-bcsr in device tree
	arch: exit
	Top of RAM: 0x2000000, Total RAM: 0x2000000
	Memory hole size: 0MB
	Zone PFN ranges:
  	DMA      0x00000000 -> 0x00002000
  	Normal   0x00002000 -> 0x00002000
	Movable zone start PFN for each node
	early_node_map[1] active PFN ranges
    	0: 0x00000000 -> 0x00002000
	On node 0 totalpages: 8192
	free_area_init_node: node 0, pgdat c02dfa18, node_mem_map 
	c0304000
  	DMA zone: 64 pages used for memmap
  	DMA zone: 0 pages reserved
  	DMA zone: 8128 pages, LIFO batch:0
	Built 1 zonelists in Zone order, mobility grouping on.  Total 
	pages: 8128
	Kernel command line: console=ttyCPM0,9600 panic=10 root=1f03 rw 
	rootfstype=jffs2 mtdparts=physmap-flash.0:8K(reserved),56K(
	fdt),1408K(uimab
	PID hash table entries: 128 (order: -3, 512 bytes)
	Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
	Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
	Memory: 29380k/32768k available (2824k kernel code, 3388k 
	reserved, 160k 
	data, 101k bss, 172k init)
	Kernel virtual memory layout:
	* 0xffffe000..0xfffff000  : fixmap
  	* 0xfe000000..0xfe000000  : early ioremap
  	* 0xc3000000..0xfe000000  : vmalloc & ioremap
	SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, 
	Nodes=1
	Hierarchical RCU implementation.
	NR_IRQS:512
	No pci pic node in device tree.
	time_init: decrementer frequency = 16.500000 MHz
	time_init: processor frequency   = 231.000000 MHz
	clocksource: timebase mult[f26c9b2] shift[22] registered
	clockevent: decrementer mult[4395810] shift[32] cpu[0]
	Console: colour dummy device 80x25
	irq: irq 40 on host /soc@f0000000/interrupt-controller@10c00 
	mapped to 
	virtual irq 40


I am attching below the MPC8272ADS.dts file that works for me for Kernel
2.6.25 (the dts file that I am trying to make work for newer Kernel):

/*
 * Device Tree for the PQ2FADS-ZU board with an MPC8280 chip.
 *
 * Copyright 2007 Freescale Semiconductor Inc.
 *
 * This program is free software; you can redistribute  it and/or modify
*it 
* under  the terms of  the GNU General  Public License as published by
*the * Free Software Foundation;  either version 2 of the  License, or *
(at your * option) any later version.
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
		reg = <0 0>;
	};

	soc@f0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		device_type = "soc";
		compatible = "fsl,mpc8280", "fsl,pq2-soc";
		ranges = <00000000 f0000000 00053000>;

		// Temporary -- will go away once kernel uses ranges 
		// for get_immrbase().
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
				local-mac-address = [00 e0 0a 03 79 01];
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


Any help would be greatly appreciated.

-- 
Andres F Marquez
EdgeAccess
Development
amarquez@edgeaccess.net
