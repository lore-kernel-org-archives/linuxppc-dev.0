Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id B924467C52
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 06:53:50 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k8SMDkWl017073
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 16:13:46 -0600 (MDT)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8SKrltn009877
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 15:53:47 -0500 (CDT)
Message-ID: <451C365B.8090300@freescale.com>
Date: Thu, 28 Sep 2006 15:53:47 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: no map ! Using irq line 0 from PCI config
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm having a problem with a SATA PCI device on an 8349E board.  The SATA driver is timing out when trying to query the drive.  I believe this is happening because interrupts aren't being routed correctly.

My assumption is that there's something wrong with my DTS file.  Unfortunately, despite pouring over document and code all week, I really don't understand how the interrupt-type stuff in the DTS file is supposed to work.  Is there anyone on this list who can help me?

When I boot my kernel with the debug messages, I get this output:

Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus number: 0->0
  ->Hose at 0xc02e8000, cfg_addr=0xfdffd300,cfg_data=0xfdffd304
PCI: MEM[0] 0x800000008fffffff -> 0xc029ed2c
PCI: MEM[1] 0x900000009fffffff -> 0xc02a8a74c02b0000
PCI: IO 0xffffffc02ecffc -> 0x1e2fff5a9
Adding PCI host bridge /soc8349@e0000000/pci@8600
Found MPC83xx PCI host bridge at 0x00000000e0008600. Firmware bus number: 1->1
  ->Hose at 0xc02ed000, cfg_addr=0xfcffc380,cfg_data=0xfcffc384
PCI: MEM[0] 0xa0000000afffffff -> 0xc029ed2c
PCI: MEM[1] 0xb0000000bfffffff -> 0xc02a8a74c02b0000
PCI: IO 0xffffffc02f1ffc -> 0x1e3fff5a9
Built 1 zonelists.  Total pages: 65536
Kernel command line: root=/dev/nfs rw nfsroot=10.82.48.106:/nfsroot0/u/timur/itx-ltib/rootfs ip=10.82.19.159:10.82.48.106:10.82.19.254:255.255.252.0:timur-dev:eth0:off console=ttyS0,115200
IPIC (128 IRQ sources) at fbffb700
PID hash table entries: 2048 (order: 11, 8192 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256640k/262144k available (2700k kernel code, 5280k reserved, 120k data, 92k bss, 140k init)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
Try to map irq for 0000:00:10.0...
  -> no map ! Using irq line 0 from PCI config

The SATA controller (SIL 3114) is the only device on PCI 1.

Here's my DTS file.  I think the problem is in the interrupt-map section of pci@8500"

/ {
	model = "MPC8349EMITX";
	compatible = "MPC834xMITX";
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#cpus = <1>;
		#address-cells = <1>;
		#size-cells = <0>;
		linux,phandle = <200>;

		PowerPC,8349@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <20>;
			i-cache-line-size = <20>;
			d-cache-size = <8000>;
			i-cache-size = <8000>;
			timebase-frequency = <3ef1480>;
			bus-frequency = <fbc5200>;
			clock-frequency = <1f78a400>;
			32-bit;
		};
	};

	memory {
		device_type = "memory";
		reg = <00000000 10000000>;
	};

	soc8349@e0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		#interrupt-cells = <2>;
		device_type = "soc";
		ranges = <0 e0000000 00100000>;
		reg = <e0000000 00000200>;
		bus-frequency = <fbc5200>;

		wdt@200 {
			device_type = "watchdog";
			compatible = "mpc83xx_wdt";
			reg = <200 100>;
		};

		i2c@3000 {
			device_type = "i2c";
			compatible = "fsl-i2c";
			reg = <3000 100>;
			interrupts = <e 8>;
			interrupt-parent = <700>;
			dfsrr;
		};

		i2c@3100 {
			device_type = "i2c";
			compatible = "fsl-i2c";
			reg = <3100 100>;
			interrupts = <f 8>;
			interrupt-parent = <700>;
			dfsrr;
		};

		spi@7000 {
			device_type = "spi";
			compatible = "mpc83xx_spi";
			reg = <7000 1000>;
			interrupts = <10 8>;
			interrupt-parent = <700>;
			mode = <0>;
		};

		usb@22000 {
			device_type = "usb";
			compatible = "fsl-usb2-mph";
			reg = <22000 1000>;
			#address-cells = <1>;
			#size-cells = <0>;
			interrupt-parent = <700>;
			interrupts = <27 2>;
			phy_type = "ulpi";
			port1;
		};
		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
/*
		usb@23000 {
			device_type = "usb";
			compatible = "fsl-usb2-dr";
			reg = <23000 1000>;
			#address-cells = <1>;
			#size-cells = <0>;
			interrupt-parent = <700>;
			interrupts = <26 2>;
			phy_type = "ulpi";
		};
*/
		mdio@24520 {
			device_type = "mdio";
			compatible = "gianfar";
			reg = <24520 20>;
			#address-cells = <1>;
			#size-cells = <0>;
			linux,phandle = <24520>;
			/* Vitesse 8201 */
			ethernet-phy@1c {
				linux,phandle = <245201c>;
				interrupt-parent = <700>;
				interrupts = <12 2>;
				reg = <1c>;
				device_type = "ethernet-phy";
			};
			ethernet-phy@1f {
				linux,phandle = <245201f>;
				interrupt-parent = <700>;
				interrupts = <12 2>;
				reg = <1f>;
				device_type = "ethernet-phy";
			};
		};

		ethernet@24000 {
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <24000 1000>;
			address = [ 00 E0 0C 00 8C 01 ];
/*			address = [ 00 00 00 00 00 00 ];
			local-mac-address = [ 00 00 00 00 00 00 ];*/
			interrupts = <20 8 21 8 22 8>;
			interrupt-parent = <700>;
			phy-handle = <245201c>;
		};

		ethernet@25000 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <25000 1000>;
			address = [ 00 E0 0C 00 8C 01 ];
/*			address = [ 00 00 00 00 00 00 ];
			local-mac-address = [ 00 00 00 00 00 00 ];*/
			interrupts = <23 8 24 8 25 8>;
			interrupt-parent = <700>;
			phy-handle = <245201f>;
		};

		serial@4500 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4500 100>;
			clock-frequency = <fbc5200>;
			interrupts = <9 8>;
			interrupt-parent = <700>;
		};

		serial@4600 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4600 100>;
			clock-frequency = <fbc5200>;
			interrupts = <a 8>;
			interrupt-parent = <700>;
		};

		pci@8500 {
			interrupt-map-mask = <f800 0 0 7>;
			interrupt-map = <

					/* IDSEL 0x11 */
					8800 0 0 1 700 14 8
					8800 0 0 2 700 15 8
					8800 0 0 3 700 16 8
					8800 0 0 4 700 17 8
					
					/* IDSEL 0x12 */
					9000 0 0 1 700 16 8
					9000 0 0 2 700 17 8
					9000 0 0 3 700 14 8
					9000 0 0 4 700 15 8
					
					/* IDSEL 0x13 */
					9800 0 0 1 700 17 8
					9800 0 0 2 700 14 8
					9800 0 0 3 700 15 8
					9800 0 0 4 700 16 8
					
					/* IDSEL 0x15 */
					a800 0 0 1 700 14 8
					a800 0 0 2 700 15 8
					a800 0 0 3 700 16 8
					a800 0 0 4 700 17 8
					
					/* IDSEL 0x16 */
					b000 0 0 1 700 17 8
					b000 0 0 2 700 14 8
					b000 0 0 3 700 15 8
					b000 0 0 4 700 16 8
					
					/* IDSEL 0x17 */
					/*
					b800 0 0 1 700 16 8
					b800 0 0 2 700 17 8
					b800 0 0 3 700 14 8
					b800 0 0 4 700 15 8
					*/
					
					/* IDSEL 0x18 */
					/*
					c000 0 0 1 700 15 8
					c000 0 0 2 700 16 8
					c000 0 0 3 700 17 8
					c000 0 0 4 700 14 8
					*/
					>;
			interrupt-parent = <700>;
			interrupts = <42 8>;
			bus-range = <0 0>;
			ranges = <42000000 0 80000000 80000000 0 10000000
				  02000000 0 90000000 90000000 0 10000000
				  01000000 0 00000000 e2000000 0 01000000>;
			clock-frequency = <3f940aa>;
			#interrupt-cells = <1>;
			#size-cells = <2>;
			#address-cells = <3>;
			reg = <8500 100>;
			compatible = "83xx";
			device_type = "pci";
		};

		pci@8600 {
			interrupt-map-mask = <f800 0 0 7>;
			interrupt-map = <

					/* IDSEL 0x11 */
					 8800 0 0 1 700 14 8
					 8800 0 0 2 700 15 8
					 8800 0 0 3 700 16 8
					 8800 0 0 4 700 17 8

					/* IDSEL 0x12 */
					 9000 0 0 1 700 16 8
					 9000 0 0 2 700 17 8
					 9000 0 0 3 700 14 8
					 9000 0 0 4 700 15 8

					/* IDSEL 0x13 */
					 9800 0 0 1 700 17 8
					 9800 0 0 2 700 14 8
					 9800 0 0 3 700 15 8
					 9800 0 0 4 700 16 8

					/* IDSEL 0x15 */
					 a800 0 0 1 700 14 8
					 a800 0 0 2 700 15 8
					 a800 0 0 3 700 16 8
					 a800 0 0 4 700 17 8

					/* IDSEL 0x16 */
					 b000 0 0 1 700 17 8
					 b000 0 0 2 700 14 8
					 b000 0 0 3 700 15 8
					 b000 0 0 4 700 16 8

					/* IDSEL 0x17 */
					 b800 0 0 1 700 16 8
					 b800 0 0 2 700 17 8
					 b800 0 0 3 700 14 8
					 b800 0 0 4 700 15 8

					/* IDSEL 0x18 */
					 c000 0 0 1 700 15 8
					 c000 0 0 2 700 16 8
					 c000 0 0 3 700 17 8
					 c000 0 0 4 700 14 8>;
			interrupt-parent = <700>;
			interrupts = <43 8>;
			bus-range = <1 1>;
			ranges = <42000000 0 a0000000 a0000000 0 10000000
				  02000000 0 b0000000 b0000000 0 10000000
				  01000000 0 00000000 e3000000 0 01000000>;
			clock-frequency = <3f940aa>;
			#interrupt-cells = <1>;
			#size-cells = <2>;
			#address-cells = <3>;
			reg = <8600 100>;
			compatible = "83xx";
			device_type = "pci";
		};

		crypto@30000 {
			device_type = "crypto";
			model = "SEC2";
			compatible = "talitos";
			reg = <30000 10000>;
			interrupts = <b 8>;
			interrupt-parent = <700>;
			num-channels = <4>;
			channel-fifo-len = <18>;
			exec-units-mask = <0000007e>;
			descriptor-types-mask = <01010ebf>;
		};

		pic@700 {
			linux,phandle = <700>;
			interrupt-controller;
			#address-cells = <0>;
			#interrupt-cells = <2>;
			reg = <700 100>;
			built-in;
			device_type = "ipic";
		};
	};

	chosen {
		interrupt-controller = <700>;
		name = "chosen";
		bootargs = "root=/dev/nfs rw nfsroot=10.82.48.106:/nfsroot0/u/timur/itx-ltib/rootfs ip=10.82.19.159:10.82.48.106:10.82.19.254:255.255.252.0:timur-dev:eth0:off console=ttyS0,115200";
		linux,platform = <600>;
		linux,stdout-path = "/soc8349@e0000000/serial@4500";
	};
};


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
