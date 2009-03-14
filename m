Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 0ED0FDDE07
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Mar 2009 08:54:41 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Sat, 14 Mar 2009 22:54:39 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20090312103219.228100@gmx.net>
Message-ID: <20090314215439.8080@gmx.net>
MIME-Version: 1.0
References: <20090312103219.228100@gmx.net>
Subject: Re: DTS file PCI / i8259 for Xilinx ML510
To: "Roderick Colenbrander" <thunderbird2k@gmx.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Thu, 12 Mar 2009 11:32:19 +0100
> Von: "Roderick Colenbrander" <thunderbird2k@gmx.net>
> An: linuxppc-dev@ozlabs.org
> Betreff: DTS file PCI / i8259 for Xilinx ML510

> ...
> The freescale boards define the pci bus like below and connect ULI M1575
> peripherals to the i8259 controller. Regarding the entries in the pci
> interrupt-map what does the fourth column mean? According to source code
> it means 'interrupt specifier' but what does it mean? In a lot of cases
> it is 1.
IIRC the fourth column is the PCI interrupt line (INTA..D = 1..4). The
Freescale boards may have a number of onboard PCI devices, which are
usually connected to a single PCI interrupt line only (INTA). In this
case a PCI unit address (1. column) is specified only once within the
interrupt-map table and the corresponding interrupt specifier is set
to 1 for INTA.
On the other side PCI slots can have up to four entries (INTA..D) for a
specific PCI unit address.

Please take a look at this document here:
http://playground.sun.com/1275/practice/imap/imap0_9d.html

> Further I believe in this case the entries behind 'mpic' correspond to
> the inta/b/c/d lines, is that correct? On my board inta is connected to
> interrupt 5 (intb=4, intc=3, intd=2) of the xilinx intc, so I would need
> to use those numbers there for my board?
No, the last two columns specify the real interrupt (IRQ line, level or
edge triggered). They're values depend on the type of interrupt
controller and its #interrupt-cells property.

> 	pci0: pcie@f8008000
> 	{
> 		device_type = "pci";
> 		#interrupt-cells = <1>;
> 		#size-cells = <2>;
> 		#address-cells = <3>;
> 		..
> 		..
> 		interrupt-map-mask = <0xff00 0 0 7>;
> 		interrupt-map = <
> 			/* IDSEL 0x11 func 0 - PCI slot 1 */
> 			0x8800 0 0 1 &mpic 2 1
> 			0x8800 0 0 2 &mpic 3 1
> 			0x8800 0 0 3 &mpic 4 1
> 			0x8800 0 0 4 &mpic 1 1
> 			..
> 			..
> 			// IDSEL 0x1c  USB
> 			0xe000 0 0 1 &i8259 12 2
> 			0xe100 0 0 2 &i8259 9 2
> 		>;
> 
> At some point in the file they create some (dummy?) pcie section in
> which they define a uli1575, an isa bus and attached to that isa bus a
> i8259. Is this the correct way of doing things? The i8259 driver seems
> to use io ports 0x20-21/0xa0-0xa1/0x4d0-0x4d1 those are also defined
> below but how are those mapped to the south bridge? I have seen some
> code in kernel/isa-bridge, is that code indeed responsible for setting
> up these ports?
Yes, the pcie node is the PCI host bridge node and the uli1571 node acts
as PCI2ISA bridge node. AFAIK their ranges properties are parsed by
pci_process_bridge_OF_ranges().
IIRC the code in kernel/isa-bridge is used for 64bit PPC machines only
for now. The I/O addresses for the i8259 PIC are currently hardcoded and
setup (request_resource()) in sysdev/i8259.c.

> 		pcie@0 {
> 			reg = <0 0 0 0 0>;
> 			#size-cells = <2>;
> 			#address-cells = <3>;
> 			device_type = "pci";
> 			ranges = <0x02000000 0x0 0x80000000
> 				  0x02000000 0x0 0x80000000
> 				  0x0 0x20000000
> 
> 				  0x01000000 0x0 0x00000000
> 				  0x01000000 0x0 0x00000000
> 				  0x0 0x00100000>;
> 			uli1575@0 {
> 				reg = <0 0 0 0 0>;
> 				#size-cells = <2>;
> 				#address-cells = <3>;
> 				ranges = <0x02000000 0x0 0x80000000
> 					  0x02000000 0x0 0x80000000
> 					  0x0 0x20000000
> 					  0x01000000 0x0 0x00000000
> 					  0x01000000 0x0 0x00000000
> 					  0x0 0x00100000>;
> 				isa@1e {
> 					device_type = "isa";
> 					#interrupt-cells = <2>;
> 					#size-cells = <1>;
> 					#address-cells = <2>;
> 					reg = <0xf000 0 0 0 0>;
> 					ranges = <1 0 0x01000000 0 0
> 						  0x00001000>;
> 					interrupt-parent = <&i8259>;
> 
> 					i8259: interrupt-controller@20 {
> 						reg = <1 0x20 2
> 						       1 0xa0 2
> 						       1 0x4d0 2>;
> 						interrupt-controller;
> 						device_type = "interrupt-controller";
> 						#address-cells = <0>;
> 						#interrupt-cells = <2>;
> 						compatible = "chrp,iic";
> 						interrupts = <9 2>;
> 						interrupt-parent = <&mpic>;
> 					};
> 				};
> 			};
> 		};
> 
> Thanks,
> Roderick Colenbrander

best regards,

Gerhard
-- 
Nur bis 16.03.! DSL-Komplettanschluss inkl. WLAN-Modem für nur 
17,95 ¿/mtl. + 1 Monat gratis!* http://dsl.gmx.de/?ac=OM.AD.PD003K11308T4569a
