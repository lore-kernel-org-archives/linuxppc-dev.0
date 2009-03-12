Return-Path: <thunderbird2k@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 57C7DDDFB6
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 21:43:07 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 12 Mar 2009 11:43:04 +0100
From: "Roderick Colenbrander" <thunderbird2k@gmx.net>
Message-ID: <20090312104304.223970@gmx.net>
MIME-Version: 1.0
Subject: DTS file PCI / i8259 for Xilinx ML510
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm working on adding PCI support for the Xilinx ML510 FPGA board. The board contains a Virtex-5 FPGA (containing two PPC440 cores), a ALI M1533 pci south bridge, pci slots and more.

I have written code (inspired by the powermac pci code) which initializes the pci soft-core which is in my FPGA. Linux now sees all my pci devices in /proc/bus/pci/devices and the kernel assigned io memory / io port ranges for each device.

Right now I'm working on irq assignment. The FPGA contains a xilinx interrupt controller to which a uart, ethernet, pci slots (inta/b/c/d) and my ALI south bridge (it has its own irq input on the xilinx intc) are connected. The ALI south bridge itself contains a i8259 interrupt controller to which internal USB, IDE and other peripherals are connected.

The problems I'm having are with the DTS file. I'm not fully sure what to put in there and what the kernel is doing with the PCI info. As a start point I looked at mpc8641_hpcn.dts / mpc8572.dts and other freescale files as their boards also contain a i8259 south bridge but this time connected to a ULI M1575 south bridge (it is the successor to the ALI M1533).

The freescale boards define the pci bus like below and connect ULI M1575 peripherals to the i8259 controller. Regarding the entries in the pci interrupt-map what does the fourth column mean? According to source code it means 'interrupt specifier' but what does it mean? In a lot of cases it is 1. Further I believe in this case the entries behind 'mpic' correspond to the inta/b/c/d lines, is that correct? On my board inta is connected to interrupt 5 (intb=4, intc=3, intd=2) of the xilinx intc, so I would need to use those numbers there for my board?

	pci0: pcie@f8008000
	{
		device_type = "pci";
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		..
		..
		interrupt-map-mask = <0xff00 0 0 7>;
		interrupt-map = <
			/* IDSEL 0x11 func 0 - PCI slot 1 */
			0x8800 0 0 1 &mpic 2 1
			0x8800 0 0 2 &mpic 3 1
			0x8800 0 0 3 &mpic 4 1
			0x8800 0 0 4 &mpic 1 1
			..
			..
			// IDSEL 0x1c  USB
			0xe000 0 0 1 &i8259 12 2
			0xe100 0 0 2 &i8259 9 2
		>;

At some point in the file they create some (dummy?) pcie section in which they define a uli1575, an isa bus and attached to that isa bus a i8259. Is this the correct way of doing things? The i8259 driver seems to use io ports 0x20-21/0xa0-0xa1/0x4d0-0x4d1 those are also defined below but how are those mapped to the south bridge? I have seen some code in kernel/isa-bridge, is that code indeed responsible for setting up these ports?

		pcie@0 {
			reg = <0 0 0 0 0>;
			#size-cells = <2>;
			#address-cells = <3>;
			device_type = "pci";
			ranges = <0x02000000 0x0 0x80000000
				  0x02000000 0x0 0x80000000
				  0x0 0x20000000

				  0x01000000 0x0 0x00000000
				  0x01000000 0x0 0x00000000
				  0x0 0x00100000>;
			uli1575@0 {
				reg = <0 0 0 0 0>;
				#size-cells = <2>;
				#address-cells = <3>;
				ranges = <0x02000000 0x0 0x80000000
					  0x02000000 0x0 0x80000000
					  0x0 0x20000000
					  0x01000000 0x0 0x00000000
					  0x01000000 0x0 0x00000000
					  0x0 0x00100000>;
				isa@1e {
					device_type = "isa";
					#interrupt-cells = <2>;
					#size-cells = <1>;
					#address-cells = <2>;
					reg = <0xf000 0 0 0 0>;
					ranges = <1 0 0x01000000 0 0
						  0x00001000>;
					interrupt-parent = <&i8259>;

					i8259: interrupt-controller@20 {
						reg = <1 0x20 2
						       1 0xa0 2
						       1 0x4d0 2>;
						interrupt-controller;
						device_type = "interrupt-controller";
						#address-cells = <0>;
						#interrupt-cells = <2>;
						compatible = "chrp,iic";
						interrupts = <9 2>;
						interrupt-parent = <&mpic>;
					};
				};
			};
		};

Thanks,
Roderick Colenbrander


-- 
Nur bis 16.03.! DSL-Komplettanschluss inkl. WLAN-Modem für nur 
17,95 ¿/mtl. + 1 Monat gratis!* http://dsl.gmx.de/?ac=OM.AD.PD003K11308T4569a
