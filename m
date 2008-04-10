Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id AA16BDDF86
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 19:00:47 +1000 (EST)
Message-ID: <47FDD73C.8020501@matrix-vision.de>
Date: Thu, 10 Apr 2008 11:00:44 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: MPC8343 - "unable to handle paging request @ 0"
References: <47F73625.9040903@matrix-vision.de>
	<20080407161036.GA2688@loki.buserror.net>
	<47FB7822.6090401@matrix-vision.de>
	<20080408164853.GH2552@loki.buserror.net>
	<47FCBC73.40703@matrix-vision.de> <47FD118F.8050407@freescale.com>
	<47FD1485.6070209@matrix-vision.de>
	<47FD15E2.2050907@freescale.com>
In-Reply-To: <47FD15E2.2050907@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood schrieb:
> Andre Schwarz wrote:
>> Scott Wood schrieb:
>>> Andre Schwarz wrote:
>>>>  -> find_legacy_serial_port()
>>>> stdout is /soc8343@e0000000/serial@4500
>>>
>>> It looks like you have some memory corruption between here...
>>>
>>>> clocksource: timebase mult[3c00001] shift[22] registered
>>>>
>>>> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
>>>>  -> check_legacy_serial_console()
>>>>  can't find stdout package /soc8343@e0000000/serial@4500 !
>>>> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
>>>
>>> ...and here.
>>>
>>> -Scott
>>
>> Scott,
>>
>> are you talking about a possible hardware problem or misbehaving code ?
>
> Either.  The same OF call is done in both places with the same 
> argument, but is getting different results.
>
>> Does it look like something gets overwritten during initrd 
>> extraction/movement ?
>
> Don't know.
>
>> The system has 512MB RAM which means that we need 2 BAT regs to map 
>> the memory. I've found comments in Freescale u-boot header files that 
>> currently a max of 256MB is supported. I never understood why ? Could 
>> this problem be related to this ?
>
> Kim's probably be the best one to answer u-boot questions.
>
> -Scott
>

Scott + Kim,

as mentioned before I have re-built u-boot with the following 
modifications :

- Reduce Memsize from 512 to 256MB
- Skipped 2nd BAT setup

dtb looks the same but memory size set to 256MB.

System boots fine - this is weird !


I'm not really familiar with the powerpc tree of the kernel and far out 
of sync with the current development.


Could you have a look at this ?

Any ideas right now ?


Thanks,
Andre





## Booting kernel from Legacy Image at ff810000 ...
   Image Name:   2.6.25 mvBL-M7 MPC8343 #12
   Image Type:   PowerPC Linux Kernel Image (uncompressed)
   Data Size:    2494236 Bytes =  2.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK
## Flattened Device Tree blob at 00000000
   Booting using the fdt blob at 0x600000
## Loading init Ramdisk from Legacy Image at 01000000 ...
   Image Name:   mvBC-1G uInitrd #1.1.03
   Image Type:   PowerPC Linux RAMDisk Image (uncompressed)
   Data Size:    2654208 Bytes =  2.5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0fcb7000, end 0ff3f000 ... OK
 -> early_init_devtree(c0600000)
search "chosen", depth: 0, uname:
search "chosen", depth: 1, uname: chosen
Looking for initrd properties... <3>initrd_start=0xcfcb7000  
initrd_end=0xcff3f000
Command line is: root=/dev/ram ro rootfstype=squashfs
dt_root_size_cells = 1
dt_root_addr_cells = 1
memory scan node memory, reg size 8, data: 0 10000000 2 1,
 - 0 ,  10000000
reserving: fcb7000 -> 288001
Phys. mem: 10000000
-> move_device_tree
<- move_device_tree
Scanning CPUs ...
boot cpu: logical 0 physical 0
 <- early_init_devtree()
Using mvBlueLYNX-M7 machine description
Linux version 2.6.25-rc8-01197-g1de15bb-dirty (root@nova) (gcc version 
4.0.0 (DENX ELDK 4.1 4.0.0)) #12 PREEMPT Wed Apr 9 14:40:48 CEST 2008
 -> unflatten_device_tree()
  size is 192c, allocating...
  unflattening cfffe6d0...
fixed up name for  ->
fixed up name for chosen -> chosen
fixed up name for wdt@200 -> wdt
fixed up name for ethernet-phy@0 -> ethernet-phy
fixed up name for ethernet-phy@1 -> ethernet-phy
fixed up name for ethernet@24000 -> ethernet
fixed up name for ethernet@25000 -> ethernet
fixed up name for serial@4500 -> serial
fixed up name for serial@4600 -> serial
fixed up name for pic@700 -> pic
fixed up name for ppcboot_env@0 -> ppcboot_env
fixed up name for ppcboot_env_red@0x2000 -> ppcboot_env_red
fixed up name for u-boot_autoscript@0x4000 -> u-boot_autoscript
fixed up name for u-boot_autoscript_red@0x4000 -> u-boot_autoscript_red
fixed up name for dtb@0x8000 -> dtb
fixed up name for dtb_red@0xa000 -> dtb_red
fixed up name for kernel@0x10000 -> kernel
fixed up name for rfs@0x400000 -> rfs
fixed up name for u-boot@0x700000 -> u-boot
fixed up name for fpga@0x780000 -> fpga
 <- unflatten_device_tree()
Found initrd at 0xcfcb7000:0xcff3f000
 -> find_legacy_serial_port()
stdout is /soc8343@e0000000/serial@4500
legacy_serial_console = 0
default console speed = 115740
 <- find_legacy_serial_port()
console [udbg0] enabled
setup_arch: bootmem
mvblm7_setup_arch()
Adding PCI host bridge /pci@e0008500
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus 
number: 0->0
 ->Hose at 0xc0281000, cfg_addr=0xfdffd300,cfg_data=0xfdffd304
PCI host bridge /pci@e0008500 (primary) ranges:
 MEM 0x0000000090000000..0x000000009fffffff -> 0x0000000090000000
 MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 Prefetch
  IO 0x00000000e2000000..0x00000000e20fffff -> 0x0000000000000000
arch: exit
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=/dev/ram ro rootfstype=squashfs
IPIC (128 IRQ sources) at fdefc700
PID hash table entries: 1024 (order: 10, 4096 bytes)
clocksource: timebase mult[3c00001] shift[22] registered
 -> check_legacy_serial_console()
stdout is /soc8343@e0000000/serial@4500
Found serial console at ttyS0
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 254396k/262144k available (2328k kernel code, 7428k reserved, 
88k data, 126k bss, 140k init)
SLUB: Genslabs=12, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Mount-cache hash table entries: 512
net_namespace: 152 bytes
NET: Registered protocol family 16

PCI: Probing PCI hardware
Try to map irq for 0000:00:00.0...
pci_busdev_to_OF_node(0,0x0)
 parent is /pci@e0008500
 result is <NULL>
Try to map irq for 0000:00:0b.0...
pci_busdev_to_OF_node(0,0x58)
 parent is /pci@e0008500
 result is <NULL>
 -> got one, spec 2 cells (0x00000030 0x00000008...) on 
/soc8343@e0000000/pic@700
 -> mapped to linux irq 48
PCI->OF bus map:
0 -> 0
PCI: PHB (bus 0) bridge rsrc 0: 0000000000000000-00000000000fffff 
[0x100], parent c024a074 (PCI IO)
PCI: PHB (bus 0) bridge rsrc 1: 0000000090000000-000000009fffffff 
[0x200], parent c024a058 (PCI mem)
PCI: PHB (bus 0) bridge rsrc 2: 0000000080000000-000000008fffffff 
[0x1200], parent c024a058 (PCI mem)
PCI: Allocating 0000:00:0b.0: Resource 0: 
0000000090000000..0000000090007fff [200]
PCI: Assigning unassigned resouces...
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
checking if image is initramfs...it isn't (bad gzip magic numbers); 
looks like an initrd
Freeing initrd memory: 2592k freed
Fixing serial ports interrupts and IO ports ...
fixup_port_irq(0)
fixup_port_mmio(0)
fixup_port_irq(1)
fixup_port_mmio(1)
Registering platform serial ports
squashfs: version 3.3 (2007/10/31) Phillip Lougher
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 18) is a 16550A
                                                             console 
handover: boot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 19) is a 16550A
brd: module loaded
loop: module loaded
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 39, io base 0xe0022000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new interface driver libusual
i2c /dev entries driver
24c01a EEPROM driver initialized
WDT driver for MPC83xx initialized. mode:reset timeout=65535 (16 seconds)
RAMDISK: squashfs filesystem found at block 0
RAMDISK: Loading 2591KiB [1 disk] into ram disk... done.
VFS: Mounted root (squashfs filesystem) readonly.
Freeing unused kernel memory: 140k init

Mounting /proc
Mounting /tmp
MATRIX VISION mvBlueCOUGAR-1G gcc 4.0.0 Version: 15.05.2007

*************************************************
         MATRIX VISION mvBlueCOUGAR-1G
*************************************************

executing /mnt/user/autostart ...
login[242]: root login on 'console'


BusyBox v1.4.2 (2007-05-15 09:04:24 CEST) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

-sh: can't access tty; job control turned off
mvBC-1G:~ $
mvBC-1G:~ $      


MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
