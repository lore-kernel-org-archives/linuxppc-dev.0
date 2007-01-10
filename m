Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 0C2AFDDDF8
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 14:33:49 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0A3XmWk010792
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 20:33:48 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0A3XkTq008470
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 21:33:47 -0600 (CST)
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32 bits
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1168399012.22458.328.camel@localhost.localdomain>
References: <1165806548.7260.0.camel@localhost.localdomain>
	<1168398002.571.3.camel@localhost.localdomain>
	<1168399012.22458.328.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1168400086.700.12.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 10 Jan 2007 11:34:46 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-10 at 11:16, Benjamin Herrenschmidt wrote:
> On Wed, 2007-01-10 at 11:00 +0800, Zang Roy-r61911 wrote:
> > Ben,
> >       After apply your patch, my 8548CDS board blocked when booting
> up.
> >       Should I adjust my flat device tree or bug introduced by this
> patch?
> >       Thanks.
> > Roy
> 
> Well, it would be useful to track down what's wrong... I suspect it
> might be triggering a problem with your device-tree 

I suppose so!
> but it's difficult
> to say at this point.
> 
I open the "DEBUG" option for pci_32.c, mpic.c and prom.c. The flowing
is the log:
======================================================================
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.20-rc1-g4c2a3b24-dirty
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1375935 Bytes =  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using flat device tree at 0x400000
 -> early_init_devtree()
search "chosen", depth: 0, uname:
search "chosen", depth: 1, uname: cpus
search "chosen", depth: 2, uname: PowerPC,8548@0
search "chosen", depth: 1, uname: memory
search "chosen", depth: 1, uname: soc8548@e0000000
search "chosen", depth: 2, uname: i2c@3000
search "chosen", depth: 2, uname: mdio@24520
search "chosen", depth: 3, uname: ethernet-phy@0
search "chosen", depth: 3, uname: ethernet-phy@1
search "chosen", depth: 3, uname: ethernet-phy@2
search "chosen", depth: 3, uname: ethernet-phy@3
search "chosen", depth: 2, uname: ethernet@24000
search "chosen", depth: 2, uname: ethernet@25000
search "chosen", depth: 2, uname: ethernet@26000
search "chosen", depth: 2, uname: serial@4500
search "chosen", depth: 2, uname: serial@4600
search "chosen", depth: 2, uname: pci@8000
search "chosen", depth: 3, uname: i8259@19000
search "chosen", depth: 2, uname: pci@9000
search "chosen", depth: 2, uname: pic@40000
search "chosen", depth: 1, uname: chosen
Command line is: root=/dev/nfs nfsroot=10.193.20.105:/tftpboot/10.193.20.118 ip=
10.193.20.118:10.193.20.105:127.0.0.1:255.255.255.0:mpc8548:eth0:off console=tty
S1,115200
dt_root_size_cells = 1
dt_root_addr_cells = 1
memory scan node memory, reg size 8, data: 0 10000000 2 1,
 - 0 ,  10000000
Phys. mem: 10000000
-> move_device_tree
<- move_device_tree
Scanning CPUs ...
boot cpu: logical 0 physical 0
 <- early_init_devtree()
Using MPC85xx CDS machine description
Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.20-rc1-g4c2a3b24-dirty (roy@bus) (gcc version 3.4.3) #16 Wed J
an 10 11:28:38 CST 2007
 -> unflatten_device_tree()
  size is 1370, allocating...
  unflattening cfffec8c...
fixed up name for  ->
fixed up name for cpus -> cpus
fixed up name for PowerPC,8548@0 -> PowerPC,8548
fixed up name for memory -> memory
fixed up name for soc8548@e0000000 -> soc8548
fixed up name for i2c@3000 -> i2c
fixed up name for mdio@24520 -> mdio
fixed up name for ethernet-phy@0 -> ethernet-phy
fixed up name for ethernet-phy@1 -> ethernet-phy
fixed up name for ethernet-phy@2 -> ethernet-phy
fixed up name for ethernet-phy@3 -> ethernet-phy
fixed up name for ethernet@24000 -> ethernet
fixed up name for ethernet@25000 -> ethernet
fixed up name for ethernet@26000 -> ethernet
fixed up name for serial@4500 -> serial
fixed up name for serial@4600 -> serial
fixed up name for pci@8000 -> pci
fixed up name for i8259@19000 -> i8259
fixed up name for pci@9000 -> pci
fixed up name for pic@40000 -> pic
 <- unflatten_device_tree()
setup_arch: bootmem
mpc85xx_cds_setup_arch()
CDS Version = 0x13 in slot 1

Found MPC85xx PCI host bridge at 0x00000000e0008000. Firmware bus number: 0->2
PCI: MEM[0] 0x80000000 -> 0x9fffffff
PCI: IO 0x0 -> 0xfffff
Found MPC85xx PCI host bridge at 0x00000000e0009000. Firmware bus number: 0->0
PCI: MEM[0] 0xa0000000 -> 0xbfffffff
PCI: IO 0x0 -> 0xfffff
arch: exit
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
early_node_map[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists.  Total pages: 65024
Kernel command line: root=/dev/nfs nfsroot=10.193.20.105:/tftpboot/10.193.20.118
 ip=10.193.20.118:10.193.20.105:127.0.0.1:255.255.255.0:mpc8548:eth0:off console
=ttyS1,115200
mpic: Setting up MPIC " OpenPIC  " version 1.2 at e0040000, max 1 CPUs
mpic: ISU size: 4, shift: 2, mask: 3
mpic: Initializing for 60 sources
MPIC flags: 13
PID hash table entries: 1024 (order: 10, 4096 bytes)

============================================================================
Stop here.
I just use the device tree with the git source code. You can find it at
arch/powerpc/boot/dts/mpc8548cds.dts
Any comment?
Thanks a lot!
Roy
