Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 6FF9DDDF2D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jun 2008 00:30:51 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KAn4C-0007Rb-0h
	for linuxppc-embedded@ozlabs.org; Mon, 23 Jun 2008 07:30:48 -0700
Message-ID: <18070474.post@talk.nabble.com>
Date: Mon, 23 Jun 2008 07:30:47 -0700 (PDT)
From: zhanglei459 <zhanglei459@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: how to understand pci section in device tree source file
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,all.
    I have confused for pci section in dts file some days.And I have
searched open firmware or device tree in goole.But little found.So I send
this mail and want to know some details about device tree source file,such
as ethernet link or docments.
    Now I have a customed pci video card ,which is based on fujitsu mb86297
chip.I want to make it work on Windrver SBC8548E eval board.I have ported
u-boot and it works well.But when I run linux on eval board,linux can't
probe mb86297 chip.Below is pci section of dts file:
		pci@8000 {
			interrupt-map-mask = <f800 0 0 7>;
			interrupt-map = <

				/* IDSEL 0x11 AD17*/
				8800 0 0 1 &mpic 2 1
				8800 0 0 2 &mpic 3 1
				8800 0 0 3 &mpic 4 1
				8800 0 0 4 &mpic 5 1>;

			interrupt-parent = <&mpic>;
			interrupts = <19 2>;
			bus-range = <0 0>;
			ranges = <02000000 0 90000000 90000000 0 10000000
				  01000000 0 00000000 e2800000 0 00800000>;
			clock-frequency = <3f940aa>;
			#interrupt-cells = <1>;
			#size-cells = <2>;
			#address-cells = <3>;
			reg = <8000 1000>;
			compatible = "fsl,mpc8540-pci";
			device_type = "pci";
		};
I guess  which refer to host-pci bridge ATMU,is right?But how to descripe
added-on pci chip,whose BAR0 and BAR1 are IO spaces, BAR2 and BAR3  are MEM
spaces.
Below is fragment of linux boot info:
......
mpc85xx_cds_setup_arch()

CDS Version = 0xf8 in slot 4



Found FSL PCI host bridge at 0x00000000e0008000.Firmware bus number: 0->0

PCI: MEM[0] 0x80000000 -> 0x9fffffff

PCI: IO 0x0 -> 0x7fffff

arch: exit

Zone PFN ranges:

  DMA             0 ->    65536

  Normal      65536 ->    65536

Movable zone start PFN for each node

early_node_map[1] active PFN ranges

    0:        0 ->    65536

Built 1 zonelists in Zone order.  Total pages: 65024

Kernel command line: root=/dev/ram rw console=ttyS1,57600

mpic: Setting up MPIC " OpenPIC  " version 1.2 at e0040000, max 1 CPUs

mpic: ISU size: 80, shift: 7, mask: 7f

mpic: Initializing for 80 sources

PID hash table entries: 1024 (order: 10, 4096 bytes)

Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)

Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)

Memory: 250044k/262144k available (3364k kernel code, 11776k reserved, 124k
data, 119k bss, 164k init)

Mount-cache hash table entries: 512

NET: Registered protocol family 16

             

PCI: Probing PCI hardware

pci_busdev_to_OF_node(0,0x0)

 parent is /soc8548@e0000000/pci@8000

 result is <NULL>

PCI->OF bus map:

0 -> 0

PCI: bridge rsrc 0..7fffff (100), parent c034d33c

PCI: bridge rsrc 80000000..9fffffff (1200), parent c034d358
 
........

Hope advice,Thank you advance.
-- 
View this message in context: http://www.nabble.com/how-to-understand-pci-section-in-device-tree-source-file-tp18070474p18070474.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
