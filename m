Return-Path: <edfuchs@uni-kassel.de>
Received: from hrz-ws39.hrz.uni-kassel.de (smtp.hrz.uni-kassel.de
	[141.51.12.230]) by ozlabs.org (Postfix) with ESMTP id B9EBDDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 01:39:00 +1100 (EST)
Received: from ws-87.localnet (rs-pc1.rs.eecs.uni-kassel.de [141.51.112.154])
	by hrz-ws39.hrz.uni-kassel.de (8.14.0/8.14.0) with ESMTP id
	n2JEcueu021763
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 15:38:57 +0100
From: Eduard Fuchs <edfuchs@uni-kassel.de>
To: linuxppc-dev@ozlabs.org
Subject: PCI resource allocation in linux 2.6.27
Date: Thu, 19 Mar 2009 15:38:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200903191538.58485.edfuchs@uni-kassel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

i'm porting the linux 2.6.27 kernel to the custom board with PowerPC 7448 & 
Marvell 64560. In DTS file the PCI ranges are configured as follows:

	system-controller@fbe00000 { /* Marvell Discovery mv64560 (Discovery V)*/
		#address-cells = <1>;
		#size-cells = <1>;
		model = "mv64560";			/* Default */
		compatible = "marvell,mv64360", "marvell,mv64560";
		clock-frequency = <133333333>;
		reg = <0xfbe00000 0x100000>;
		virtual-reg = <0xfbe00000>;

		ranges =
				<0xd8000000 0xd8000000 0x00010000		/* PCI 0 I/O Space */
				 0x80000000 0x80000000 0x68000000		/* PCI 0 MEM Space */
				 0xd8080000 0xd8080000 0x00010000		/* PCI 1 I/O Space */
				 0x60000000 0x60000000 0x20000000		/* PCI 1 MEM Space */
				 0x00000000 0xfbe00000 0x00100000>;		/* Bridge's regs */

 .....

		PCI0: pci@30000 {
			#address-cells = <3>;
			#size-cells = <2>;
			#interrupt-cells = <1>;
			device_type = "pci";
			compatible = "marvell,mv64360-pci";
			reg = <0x30c78 12>;

			ranges =
				<0x01000000 0x0 0x00000000 0xd8000000 0x0 0x00010000
				 0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000>;

			bus-range = <0 255>;
			clock-frequency = <33000000>;
			interrupt-pci-iack = <0x30c34>;
			interrupt-parent = <&PIC>;

			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
			interrupt-map = <
				/* IDSEL 0x07 */
				0x3800 0 0 1 &PIC 74
				0x3800 0 0 2 &PIC 74
				0x3800 0 0 3 &PIC 74
				0x3800 0 0 4 &PIC 74

				/* IDSEL 0x09 */
				0x4800 0 0 1 &PIC 68
				0x4800 0 0 2 &PIC 68
				0x4800 0 0 3 &PIC 68
				0x4800 0 0 4 &PIC 68

				/* IDSEL 0x0A */
				0x5000 0 0 1 &PIC 69
				0x5000 0 0 2 &PIC 69
				0x5000 0 0 3 &PIC 69
				0x5000 0 0 4 &PIC 69
			>;
		};

when the kernel is booting, at the beginning the ranges are detected 
correctly:

PCI host bridge /system-controller@fbe00000/pci@30000 (primary) ranges:                            
  IO 0x00000000d8000000..0x00000000d800ffff -> 0x0000000000000000                                  
 MEM 0x0000000080000000..0x00000000bfffffff -> 0x0000000080000000                                  


nevertheless later the range for IO space is changed as follow:

PCI: Probing PCI hardware                                                                                  
....
PCI: PHB (bus 0) bridge rsrc 0: 0000000000011000-0000000000020fff [0x100],
PCI: PHB (bus 0) bridge rsrc 1: 0000000080000000-00000000bfffffff [0x200],

normally the IO space should be from 0x00000000-0x0000ffff. Can someone 
explain to me where the offset 0x11000 comes from.

Best regards

Eduard Fuchs
