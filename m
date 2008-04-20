Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 29FEBDDFDE
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 06:35:35 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id m3KKZSvm266338
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 20:35:28 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m3KKZRsB4337888
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 22:35:27 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m3KKZRsG014243
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 22:35:27 +0200
Message-ID: <480BA937.7050603@linux.vnet.ibm.com>
Date: Sun, 20 Apr 2008 22:36:07 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, Johan Borkhuis <j.borkhuis@dutchspace.nl>
Subject: Re: pci issue - wrong detection of pci ressources
References: <48088F02.2060806@linux.vnet.ibm.com>
	<1208566122.6958.425.camel@pasglop>
In-Reply-To: <1208566122.6958.425.camel@pasglop>
Content-Type: multipart/mixed; boundary="------------040307060903000502000804"
Cc: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040307060903000502000804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Johan Borkhuis wrote:
> Hello Christian,
> 
> Christian Ehrhardt wrote:
>> Hi,
>> I tried to use a radeon r200 based graphic card on a sequoia ppc 
>> (440epx) board. I wondered about the initialization of radeonfb that 
>> failed with
>>     __ioremap(): phys addr 0x0 is RAM lr c029cf80
>>     radeonfb (0000:00:0a.0): cannot map MMIO
>>     radeonfb: probe of 0000:00:0a.0 failed with error -5
>>
[...]
> 
> I came across a similar problem, which (ultimately) was caused by a lack 
> of memory reserved for PCI. I moved from 2.6.14(ppc) to 2.6.20(powerpc), 
> and suddenly some cards stopped working: the BAR registers were not 
> initialized, so it was not possible to access the cards.
> Have a look at the boot-time messages, especially the early messages, as 
> the PCI subsystem is started very early in the boot process. You could 
> also try switching on PCI-debugging, and have a look at the debug 
> messages, or add some extra debugging info to the pci-initialization code.

Yes you're right. Early at the pci initialization are errors of the allocation for pi ressources.
And that are exactly the ressources failing later, so that pci initialization seem to be the reason for my problem.
Was there any simple solution (e.g. just somehow increase memory reserved for pci) when you came across that issue Johan ?

With DEBUG in pci-common.c enabled (bad kernel) and a extension showing which functions alloc fails (put a %s for __func__):
PCI host bridge /plb/pci@1ec000000 (primary) ranges:
 MEM 0x0000000180000000..0x000000018fffffff -> 0x0000000080000000
  IO 0x00000001e8000000..0x00000001e80fffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCI: Probing PCI hardware
PCI: Hiding 4xx host bridge resources 0000:00:00.0
Try to map irq for 0000:00:00.0...
 -> got one, spec 2 cells (0x00000003 0x00000008...) on /interrupt-controller2
 -> mapped to linux irq 16
Try to map irq for 0000:00:0a.0...
 -> got one, spec 2 cells (0x00000003 0x00000008...) on /interrupt-controller2
 -> mapped to linux irq 16
Try to map irq for 0000:00:0a.1...
PCI: PHB (bus 0) bridge rsrc 0: 0000000000000000-00000000000fffff [0x100], parent c0363060 (PCI IO)
PCI: PHB (bus 0) bridge rsrc 1: 0000000180000000-000000018fffffff [0x200], parent c0363038 (PCI mem)
PCI: Assigning unassigned resouces...
PCI: pci_assign_resource - Failed to allocate mem resource #6:20000@190000000 for 0000:00:0a.0
PCI: pci_assign_resource - Failed to allocate mem resource #2:10000@190000000 for 0000:00:0a.0
PCI: pci_assign_resource - Failed to allocate mem resource #1:10000@190000000 for 0000:00:0a.1

-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization


########


To be complete for the case we might need it I answer all the other questions:

Benjamin Herrenschmidt wrote:
> On Fri, 2008-04-18 at 14:07 +0200, Christian Ehrhardt wrote:
>> => Region 2 is not detected with our kernel, this later break things
>> like radeonfb initialization.
> 
> I'll need some information here:
> 
> - Your device-tree (is that the base sequoia one ?)

DTS File is the normal sequoia.dts file in arch/powerpc/boot/dts with the latest change being:
user:        Stefan Roese <sr@denx.de>
date:        Fri Feb 15 21:35:30 2008 -0600
summary:     [POWERPC] 4xx: Remove "i2c" and "xxmii-interface" device_types from dts

> - Enable DEBUG in arch/powerpc/kernel/pci-common.c and pci_32.c
> - Send me the resulting dmesg log

done - full dmesg attached

> - Also include the output of /proc/iomem

/proc/iomem - bad kernel
root@sequoia:~# cat /proc/iomem
e0000300-e000038f : ehci_hcd
180000000-18fffffff : /plb/pci@1ec000000
  180000000-187ffffff : 0000:00:0a.0
  188000000-18fffffff : 0000:00:0a.1
1ef600300-1ef600307 : serial
1ef600400-1ef600407 : serial
1ef600500-1ef600507 : serial
1ef600600-1ef600607 : serial
1fc000000-1ffffffff : 1fc000000.nor_flash

/proc/iomem - good kernel
root@sequoia:~# cat /proc/iomem
80000000-8fffffff : PCI host bridge
  80000000-8000ffff : 0000:00:0a.1
  80020000-8003ffff : 0000:00:0a.0
  87ff0000-87ffffff : 0000:00:0a.0
    87ff0000-87ffffff : radeonfb mmio
  88000000-8fffffff : 0000:00:0a.0
    88000000-8fffffff : radeonfb framebuffer
d0000000-d0001fff : ndfc-nand.0
e0000100-e000017f : musbhsfc_udc.0
  e0000100-e000017f : musbhsfc_udc
e0000300-e00003ff : ppc-soc-ehci.0
e0000400-e00004ff : ppc-soc-ohci.0
fc000000-ffffffff : physmap-flash.0
  fc000000-ffffffff : physmap-flash.0
 

> Actually, there's a bug in radeonfb:
> 
> In radeonfb.h, try changing
> 
> 	unsigned long		mmio_base_phys;
> 	unsigned long		fb_base_phys;
> 
> To
> 
> 	resource_size_t		mmio_base_phys;
> 	resource_size_t		fb_base_phys;

This did not fix the issue, as we have seen that it is caused earlier in pci initialization.
But that fix corrects the code if it is useful in my case or not ;-)

########

Sergei Shtylyov wrote:
> Christian Ehrhardt wrote:
> 
[...]
>> Bad kernel:
>> 00:0a.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 
>> 9200 PRO] (rev 01) (prog-if 00 [VGA])
>>        Subsystem: PC Partner Limited Unknown device 0250
>>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B-
>>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>>        Latency: 128 (2000ns min)
>>        Interrupt: pin A routed to IRQ 16
>>        Region 0: Memory at 180000000 (32-bit, prefetchable) [size=128M]
> 
>    That's beyond 4 GB, seems correct. That should be the address 
> assigned by bootloader? BTW, what's your bootloader, U-Boot?

Yes a modified u-boot

> 
>>        Region 1: I/O ports at 1000 [size=256]
>>        Region 2: Memory at <ignored> (32-bit, non-prefetchable)
> 
>    Hm... what could this mean? Could you post the result of 'lspci -x'?

lspci -xvvv (bad kernel)
00:0a.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (rev 01) (prog-if 00 [VGA])
        Subsystem: PC Partner Limited Unknown device 0250
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (2000ns min)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at 180000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 1000 [size=256]
        Region 2: Memory at <ignored> (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 60 59 07 00 90 02 01 00 00 03 00 80 80 00
10: 08 00 00 80 01 10 00 00 00 00 00 88 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 50 02
30: 00 00 00 00 50 00 00 00 00 00 00 00 43 01 08 00


--------------040307060903000502000804
Content-Type: text/plain;
 name="pci_resource_alocation_fails.dmesg.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="pci_resource_alocation_fails.dmesg.txt"

Using Sequoia machine description
Linux version 2.6.25-rc9-dirty (paelzer@HeliosPrime.boeblingen.de.ibm.com) (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #7 Sun Apr 20 21:14:50 CEST 2008
Found legacy serial port 0 for /plb/opb/serial@ef600300
  mem=1ef600300, taddr=1ef600300, irq=0, clk=11059200, speed=115200
Found legacy serial port 1 for /plb/opb/serial@ef600400
  mem=1ef600400, taddr=1ef600400, irq=0, clk=11059200, speed=0
Found legacy serial port 2 for /plb/opb/serial@ef600500
  mem=1ef600500, taddr=1ef600500, irq=0, clk=4385964, speed=0
Found legacy serial port 3 for /plb/opb/serial@ef600600
  mem=1ef600600, taddr=1ef600600, irq=0, clk=4385964, speed=0
console [udbg0] enabled
Entering add_active_range(0, 0, 65536) 0 entries of 256 used
Top of RAM: 0x10000000, Total RAM: 0x10000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    65536
On node 0 totalpages: 65536
  DMA zone: 512 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 65024 pages, LIFO batch:15
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttyS0,115200 ip=dhcp nfsroot=192.168.1.2:/home/paelzer/ubuntu_ppc root=/dev/nfs rw
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
UIC2 (32 IRQ sources) at DCR 0xe0
PID hash table entries: 1024 (order: 10, 4096 bytes)
time_init: decrementer frequency = 666.666660 MHz
time_init: processor frequency   = 666.666660 MHz
clocksource: timebase mult[600000] shift[22] registered
clockevent: decrementer mult[aaaa] shift[16] cpu[0]
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 255744k/262144k available (3448k kernel code, 6052k reserved, 152k data, 153k bss, 156k init)
Calibrating delay loop... 1331.20 BogoMIPS (lpj=2662400)
Mount-cache hash table entries: 512
net_namespace: 440 bytes
NET: Registered protocol family 16
PCI host bridge /plb/pci@1ec000000 (primary) ranges:
 MEM 0x0000000180000000..0x000000018fffffff -> 0x0000000080000000 
  IO 0x00000001e8000000..0x00000001e80fffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCI: Probing PCI hardware
PCI: Hiding 4xx host bridge resources 0000:00:00.0
Try to map irq for 0000:00:00.0...
 -> got one, spec 2 cells (0x00000003 0x00000008...) on /interrupt-controller2
 -> mapped to linux irq 16
Try to map irq for 0000:00:0a.0...
 -> got one, spec 2 cells (0x00000003 0x00000008...) on /interrupt-controller2
 -> mapped to linux irq 16
Try to map irq for 0000:00:0a.1...
PCI: PHB (bus 0) bridge rsrc 0: 0000000000000000-00000000000fffff [0x100], parent c0363060 (PCI IO)
PCI: PHB (bus 0) bridge rsrc 1: 0000000180000000-000000018fffffff [0x200], parent c0363038 (PCI mem)
PCI: Assigning unassigned resouces...
PCI: pci_assign_resource - Failed to allocate mem resource #6:20000@190000000 for 0000:00:0a.0
PCI: pci_assign_resource - Failed to allocate mem resource #2:10000@190000000 for 0000:00:0a.0
PCI: pci_assign_resource - Failed to allocate mem resource #1:10000@190000000 for 0000:00:0a.1
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
Switched to high resolution mode on CPU 0
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
JFFS2 version 2.2. (NAND) Â© 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
radeonfb_pci_register BEGIN
radeonfb_pci_register - resource0 0x1 - 0x80000000
radeonfb_pci_register - resource1 0x0 - 0x1000
radeonfb_pci_register - resource2 0x0 - 0x0
radeonfb_pci_register - got pci ressources fb_base_phys 0x1 mmio_base_phys 0x80000000
radeonfb_pci_register - call ioremap for base 0 and size 0
__ioremap(): phys addr 0x0 is RAM lr c029cf88 - mem_init_done 1 highmem@10000000
radeonfb (0000:00:0a.0): cannot map MMIO
radeonfb: probe of 0000:00:0a.0 failed with error -5
Linux agpgart interface v0.103
[drm] Initialized drm 1.1.0 20060810
[drm] Initialized radeon 1.28.0 20060524 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x1ef600300 (irq = 17) is a 16550A
console handover: boot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0x1ef600400 (irq = 18) is a 16550A
serial8250.0: ttyS2 at MMIO 0x1ef600500 (irq = 19) is a 16550A
serial8250.0: ttyS3 at MMIO 0x1ef600600 (irq = 20) is a 16550A
1ef600300.serial: ttyS0 at MMIO 0x1ef600300 (irq = 17) is a 16550A
1ef600400.serial: ttyS1 at MMIO 0x1ef600400 (irq = 18) is a 16550A
1ef600500.serial: ttyS2 at MMIO 0x1ef600500 (irq = 19) is a 16550A
1ef600600.serial: ttyS3 at MMIO 0x1ef600600 (irq = 20) is a 16550A
brd: module loaded
PPC 4xx OCP EMAC driver, version 3.54
MAL v2 /plb/mcmal, 2 TX channels, 2 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
RGMII /plb/opb/emac-rgmii@ef601000 initialized with MDIO support
/plb/opb/emac-rgmii@ef601000: input 0 in RGMII mode
eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:10:ec:00:e2:3e
eth0: found Marvell 88E1111 Ethernet PHY (0x00)
/plb/opb/emac-rgmii@ef601000: input 1 in RGMII mode
eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:10:ec:80:e2:3e
eth1: found Marvell 88E1111 Ethernet PHY (0x01)
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Driver 'sd' needs updating - please use bus_type methods
1fc000000.nor_flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
1fc000000.nor_flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
of-flash: probe of 1fc000000.nor_flash failed with error -22
ppc-of-ehci e0000300.ehci: OF EHCI
ppc-of-ehci e0000300.ehci: new USB bus registered, assigned bus number 1
ppc-of-ehci e0000300.ehci: irq 32, io mem 0xe0000300
ppc-of-ehci e0000300.ehci: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OF EHCI
usb usb1: Manufacturer: Linux 2.6.25-rc9-dirty ehci_hcd
usb usb1: SerialNumber: PPC-OF USB
USB Universal Host Controller Interface driver v3.0
Initializing USB Mass Storage driver...
usb 1-1: new high speed USB device using ppc-of-ehci and address 2
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-1: New USB device found, idVendor=05e3, idProduct=0608
usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 1-1: Product: USB2.0 Hub
usb 1-1.1: new low speed USB device using ppc-of-ehci and address 3
usb 1-1.1: configuration #1 chosen from 1 choice
usb 1-1.1: New USB device found, idVendor=04b3, idProduct=310c
usb 1-1.1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
usb 1-1.1: Product: USB Optical Mouse
usb 1-1.2: new full speed USB device using ppc-of-ehci and address 4
usb 1-1.2: configuration #1 chosen from 1 choice
hub 1-1.2:1.0: USB hub found
hub 1-1.2:1.0: 2 ports detected
usb 1-1.2: New USB device found, idVendor=04b3, idProduct=3022
usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1.2: Product: IBM Preferred Pro USB Fingerprint Keyboard
usb 1-1.2: Manufacturer: Chicony
usb 1-1.2.1: new full speed USB device using ppc-of-ehci and address 5
usb 1-1.2.1: configuration #1 chosen from 1 choice
usb 1-1.2.1: New USB device found, idVendor=04b3, idProduct=3021
usb 1-1.2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1.2.1: Product: IBM Preferred Pro USB Fingerprint Keyboard
usb 1-1.2.1: Manufacturer: Chicony
usb 1-1.2.2: new full speed USB device using ppc-of-ehci and address 6
usb 1-1.2.2: configuration #1 chosen from 1 choice
usb 1-1.2.2: New USB device found, idVendor=0483, idProduct=2016
usb 1-1.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1.2.2: Product: Biometric Coprocessor
usb 1-1.2.2: Manufacturer: STMicroelectronics
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver libusual
mice: PS/2 mouse device common for all mice
input: USB Optical Mouse as /class/input/input0
input: USB HID v1.11 Mouse [USB Optical Mouse] on usb-PPC-OF USB-1.1
input: Chicony IBM Preferred Pro USB Fingerprint Keyboard as /class/input/input1
input: USB HID v1.10 Keyboard [Chicony IBM Preferred Pro USB Fingerprint Keyboard] on usb-PPC-OF USB-1.2.1
HID device claimed by neither input, hiddev nor hidraw
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
oprofile: using timer interrupt.
Netfilter messages via NETLINK v0.30.
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Bridge firewalling registered
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
eth0: link is up, 100 FDX, pause enabled
eth1: link is up, 100 FDX, pause enabled
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.1.2, my address is 192.168.1.3
IP-Config: Complete:
     device=eth0, addr=192.168.1.3, mask=255.255.255.0, gw=192.168.1.2,
     host=192.168.1.3, domain=local-devnet, nis-domain=(none),
     bootserver=192.168.1.2, rootserver=192.168.1.2, rootpath=
Looking up port of RPC 100003/2 on 192.168.1.2
Looking up port of RPC 100005/1 on 192.168.1.2
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 156k init
eth1: link is up, 100 FDX, pause enabled
swapon: swapfile has holes
warning: `avahi-daemon' uses 32-bit capabilities (legacy support in use)
Machine check in kernel mode.
Data Read PLB Error
Machine check in kernel mode.
Data Read PLB Error
Machine check in kernel mode.
Data Read PLB Error
rpcbind: server localhost not responding, timed out
RPC: failed to contact local rpcbind server (errno 5).
rpcbind: server localhost not responding, timed out
RPC: failed to contact local rpcbind server (errno 5).
lockd_up: makesock failed, error=-5
rpcbind: server localhost not responding, timed out
RPC: failed to contact local rpcbind server (errno 5).

--------------040307060903000502000804--
