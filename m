Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 0DAD3DDED5
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 05:17:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Device Tree & PCI
Date: Fri, 11 Jan 2008 12:17:41 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03D9A381@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.
We're trying to port 2.6.24-rc7 to a board.=20
Right now wr're battling with the device tree and PCI.

Our board is somewhat loosely based on a 8266ADS/pq2fads board
We have a PCI interrupt mux in a fpga.
We have a disk controller and a pci bridge on the primary side, and four
TI dsp's on the secondary side.
All the interrupts are hardwired to the int mux in our FPGA.

THe PCI code does not seem happy:

Mount-cache hash table entries: 512
net_namespace: 64 bytes
NET: Registered protocol family 16
PCI: Probing PCI hardware
irq_create_mapping called for NULL host, hwirq=3D0
------------[ cut here ]------------
Badness at arch/powerpc/kernel/irq.c:661
NIP: c0006048 LR: c0006048 CTR: 00000000
REGS: ef821d40 TRAP: 0700   Not tainted  (2.6.24-rc7-gdcbd768b-dirty)
MSR: 00029032 <EE,ME,IR,DR>  CR: 24022022  XER: 00000000
TASK =3D ef812000[1] 'swapper' THREAD: ef820000
GPR00: c0006048 ef821df0 ef812000 00000034 00000001 00000001 00000000
c0306c30
GPR08: 00000000 00000000 00000000 c02f0000 24022082 10019684 0ffce000
0040092c
GPR16: 00000001 ffffffff ef821f60 c02d0000 c02d0000 c02d0000 0071f3a0
00000001
GPR24: 00000000 00000000 c030e000 ef818100 00000001 00000000 ef818114
00000000
NIP [c0006048] irq_create_mapping+0xa8/0x100
LR [c0006048] irq_create_mapping+0xa8/0x100
Call Trace:
[ef821df0] [c0006048] irq_create_mapping+0xa8/0x100 (unreliable)
[ef821e10] [c001225c] pci_read_irq_line+0x84/0xfc
[ef821e60] [c00117c8] pcibios_fixup_bus+0xe8/0x24c
[ef821e90] [c013b784] pci_scan_child_bus+0x78/0x118
[ef821eb0] [c013bb24] pci_scan_bridge+0x300/0x42c
[ef821ef0] [c013b7d4] pci_scan_child_bus+0xc8/0x118
[ef821f10] [c013beb4] pci_scan_bus_parented+0x20/0x3c
[ef821f20] [c02ba754] pcibios_init+0x68/0x250
[ef821f50] [c02b68ac] kernel_init+0x108/0x2e0
[ef821ff0] [c00100d8] kernel_thread+0x44/0x60


here is our device tree:
/*
 * Device Tree for the ApMax board with an MPC8280 chip.
 *
 * Copyright 2007 Freescale Semiconductor Inc.
 * Copyright 2008 Innovative Systems, LLC
 *
 * This program is free software; you can redistribute  it and/or modify
it
 * under  the terms of  the GNU General  Public License as published by
the
 * Free Software Foundation;  either version 2 of the  License, or (at
your
 * option) any later version.
 */

/ {
	model =3D "pq2fads";
	compatible =3D "fsl,pq2fads";
	#address-cells =3D <1>;
	#size-cells =3D <1>;

	cpus {
		#address-cells =3D <1>;
		#size-cells =3D <0>;

		cpu@0 {
			device_type =3D "cpu";
			reg =3D <0>;
			d-cache-line-size =3D <d#32>;
			i-cache-line-size =3D <d#32>;
			d-cache-size =3D <d#16384>;
			i-cache-size =3D <d#16384>;
			timebase-frequency =3D <0>;
			clock-frequency =3D <0>;
		};
	};

	memory {
		device_type =3D "memory";
		reg =3D <0 0>;
	};

	localbus@f0010100 {
		compatible =3D "fsl,mpc8280-localbus",
		             "fsl,pq2-localbus";                //
Change to our own apmax-localbus
		#address-cells =3D <2>;
		#size-cells =3D <1>;
		reg =3D <f0010100 60>;

			  // <CS 0 BaseAddress length>
<<---- look
		ranges =3D <0 0 ff800000 00800000                 // CPU1
8MB Flash
		          5 0 f8100000 00008000                 // FPGA
registers
				  6 0 f8800000 00200000
// ARM FIFO in FPGA
				  8 0 f9000000 00800000
// CPU2 8MB Flash
				  9 0 f8400000 00020000>;
// CPU1 128K SRAM

		flash@0,0 {
			compatible =3D "jedec-flash";
			reg =3D <0 0 800000>;
			bank-width =3D <2>;
			device-width =3D <2>;
		};

		PCI_INT: pic@5,10 {
			#interrupt-cells =3D <1>;
			interrupt-controller;
			reg =3D <5 10 4>;                             //
Chip select, offset, length
			compatible =3D "apmax-pciintmux";
			interrupt-parent =3D <&PIC>;
			interrupts =3D <19 8>;                        //
IRQ7, interrupt#25
		};
	};

	pci@f0010800 {
		device_type =3D "pci";
		reg =3D <f0010800 10c f00101ac 8 f00101c4 8>;
		compatible =3D "fsl,mpc8280-pci", "fsl,pq2-pci";
		#interrupt-cells =3D <1>;
		#size-cells =3D <2>;
		#address-cells =3D <3>;
		clock-frequency =3D <d#49766400>;               // For our
board.
		interrupt-map-mask =3D <f800 0 0 7>;            // Anded
with the interrupt-map values
		interrupt-map =3D <
		                /* IDSEL 0x11 */
		                00008800 0 0 1 &PCI_INT 5>;   // 3 first
numbers pci device specifier are: (buss << 16 | id_sel << 11) 0 0
		                                              //    buss
=3D 0, id_sel =3D 11
		                                              // Next
number is interrupt 1-4 mapped A-D (interrupt A for us)
		                                              // Last
two numbers are host interrupt specifier (external interrupt 5)

		interrupt-parent =3D <&PIC>;
		interrupts =3D <12 8>;
               // Mem type 0 Bus Add  Loc. Add 0 Length      <<---
Remember the mem type is little endian
		ranges =3D <42000000 0 90000000 90000000 0 08000000    //
Pre-fetch memory
		          02000000 0 80000000 80000000 0 10000000    //
Normal Memory
		          01000000 0 98000000 98000000 0 00010000>;  //
I/O
		         =20
        pci_bridge@12 {
    		interrupt-map-mask =3D <0f800 0 0 7>;
    		interrupt-map =3D <
    		                /* IDSEL 0x10 */
    		                00008000 0 0 1 &PCI_INT 1

    		                /* IDSEL 0x11 */
    		                00008800 0 0 1 &PCI_INT 2
    		               =20
    		                /* IDSEL 0x12 */
    		                00009000 0 0 1 &PCI_INT 3
    		               =20
    		                /* IDSEL 0x13 */
    		                00009800 0 0 1 &PCI_INT 4>;
        };
	};

	soc@f0000000 {
		#address-cells =3D <1>;
		#size-cells =3D <1>;
		device_type =3D "soc";
		compatible =3D "fsl,mpc8280", "fsl,pq2-soc";
		ranges =3D <00000000 f0000000 00053000>;

		// Temporary -- will go away once kernel uses ranges for
get_immrbase().
		reg =3D <f0000000 00053000>;

		cpm@119c0 {
			#address-cells =3D <1>;
			#size-cells =3D <1>;
			#interrupt-cells =3D <2>;
			compatible =3D "fsl,mpc8280-cpm", "fsl,cpm2";
			reg =3D <119c0 30>;
			ranges;

			muram@0 {
				#address-cells =3D <1>;
				#size-cells =3D <1>;
				ranges =3D <0 0 10000>;

				data@0 {
					compatible =3D
"fsl,cpm-muram-data";
					reg =3D <80 1f80 9800 800>;
				};
			};

			brg@119f0 {
				compatible =3D "fsl,mpc8280-brg",
				             "fsl,cpm2-brg",
				             "fsl,cpm-brg";
				reg =3D <119f0 10 115f0 10>;
			};

			serial@11a80 {
				device_type =3D "serial";
				compatible =3D "fsl,mpc8280-smc-uart",
				             "fsl,cpm2-smc-uart";
				reg =3D <11a80 10 0 40>;            //
<base_address length parameter_ram_address length>
				interrupts =3D <4 8>;                 //
Interrupt from table 4.3 of mpc8280rm, interrupt is level or edge
				interrupt-parent =3D <&PIC>;
				fsl,cpm-brg =3D <7>;
				fsl,cpm-command =3D <1d000000>;       //
Page and Sub-block code of the CPCR
			};

			ethernet@11320 {
				device_type =3D "network";
				compatible =3D "fsl,mpc8280-fcc-enet",
				             "fsl,cpm2-fcc-enet";
				reg =3D <11320 20 8500 100 113b0 1>;
				interrupts =3D <21 8>;
				interrupt-parent =3D <&PIC>;
				phy-handle =3D <&PHY0>;
				linux,network-index =3D <0>;
				fsl,cpm-command =3D <16200300>;
			};

			ethernet@11340 {
				device_type =3D "network";
				compatible =3D "fsl,mpc8280-fcc-enet",
				             "fsl,cpm2-fcc-enet";
				reg =3D <11340 20 8600 100 113d0 1>;
				interrupts =3D <22 8>;
				interrupt-parent =3D <&PIC>;
				phy-handle =3D <&PHY1>;
				linux,network-index =3D <1>;
				fsl,cpm-command =3D <1a400300>;
				local-mac-address =3D [00 e0 0c 00 79 01];
			};

			mdio@10d40 {
				device_type =3D "mdio";
				compatible =3D "fsl,pq2fads-mdio-bitbang",
				             "fsl,mpc8280-mdio-bitbang",
				             "fsl,cpm2-mdio-bitbang";
				#address-cells =3D <1>;
				#size-cells =3D <0>;
				reg =3D <10d40 14>;
				fsl,mdio-pin =3D <9>;
				fsl,mdc-pin =3D <a>;

				PHY0: ethernet-phy@0 {
					interrupt-parent =3D <&PIC>;
					interrupts =3D <19 2>;
					reg =3D <0>;
					device_type =3D "ethernet-phy";
				};

				PHY1: ethernet-phy@1 {
					interrupt-parent =3D <&PIC>;
					interrupts =3D <19 2>;
					reg =3D <3>;
					device_type =3D "ethernet-phy";
				};
			};
		};

		PIC: interrupt-controller@10c00 {
			#interrupt-cells =3D <2>;
			interrupt-controller;
			reg =3D <10c00 80>;
			compatible =3D "fsl,mpc8280-pic", "fsl,cpm2-pic";
		};

	};

	chosen {
		linux,stdout-path =3D "/soc/cpm/serial@11a80";
	};
};
