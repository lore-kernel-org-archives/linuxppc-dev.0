Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B82F8DDE05
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 01:15:23 +1000 (EST)
Message-ID: <46F3DFCA.1040700@ru.mvista.com>
Date: Fri, 21 Sep 2007 19:14:18 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Andrew Liu <shengping.liu@windriver.com>
Subject: Re: AMCC yosemite 440ep PCI slot doesn't work.
References: <46F3A2C4.7000202@windriver.com>
In-Reply-To: <46F3A2C4.7000202@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Liu wrote:
> Hello All,
> 
> when insert a  RealTek RTL8139 network card into PCI slot,
> After system boot up,
> 
> root@localhost:/root> ifconfig eth2 192.168.17.12
> irq 25: nobody cared (try booting with the "irqpoll" option)
> Call Trace:
> [cf135af0] [c0008820] show_stack+0x48/0x190 (unreliable)
> [cf135b20] [c003c414] __report_bad_irq+0x34/0xac
> [cf135b40] [c003c714] note_interrupt+0x288/0x2c8
> [cf135b70] [c003b818] __do_IRQ+0x104/0x110
> [cf135b90] [c0006900] do_IRQ+0xbc/0xc0
> [cf135ba0] [c00020c0] ret_from_except+0x0/0x18
> [cf135c60] [00000019] 0x19
> [cf135c90] [c000668c] do_softirq+0x54/0x58
> [cf135ca0] [c001df40] irq_exit+0x48/0x58
> [cf135cb0] [c00068b4] do_IRQ+0x70/0xc0
> [cf135cc0] [c00020c0] ret_from_except+0x0/0x18
> [cf135d80] [c003c2b4] setup_irq+0x1ac/0x200
> [cf135da0] [c003c3cc] request_irq+0xc4/0xd8
> [cf135dd0] [c0122328] rtl8139_open+0x38/0x210
> [cf135df0] [c0187500] dev_open+0x7c/0xcc
> [cf135e10] [c0187420] dev_change_flags+0x16c/0x1d0
> [cf135e30] [c01cbff0] devinet_ioctl+0x604/0x720
> [cf135ea0] [c01cc1f8] inet_ioctl+0x98/0xbc
> [cf135eb0] [c0179328] sock_ioctl+0x60/0x260
> [cf135ed0] [c006c360] do_ioctl+0x38/0x84
> [cf135ee0] [c006c438] vfs_ioctl+0x8c/0x40c
> [cf135f10] [c006c7f8] sys_ioctl+0x40/0x74
> [cf135f40] [c0001a84] ret_from_syscall+0x0/0x3c
> handlers:
> [<c0122bd4>] (rtl8139_interrupt+0x0/0x52c)
> Disabling IRQ #25
> root@localhost:/root>
> Message from syslogd@localhost at Thu Jan  1 00:02:13 1970 ...
> localhost kernel: Disabling IRQ #25
> 
> root@localhost:/root>
> 
> 
>  The system boot up information as follows:
> root@localhost:/root> dmesg
> Linux version 2.6.23-rc6-gea60adb5 (sliu@localhost.localdomain) (gcc
> version 4.0.0 (DENX ELDK 4.1 4.0.0)) #3 Fri Sep 21 18:37:59 CST 2007
> AMCC PowerPC 440EP Yosemite Platform
> Entering add_active_range(0, 0, 65536) 0 entries of 256 used
> Zone PFN ranges:
>   DMA             0 ->    65536
>   Normal      65536 ->    65536
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0:        0 ->    65536
> On node 0 totalpages: 65536
>   DMA zone: 512 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 65024 pages, LIFO batch:15
>   Normal zone: 0 pages used for memmap
>   Movable zone: 0 pages used for memmap
> Built 1 zonelists in Zone order.  Total pages: 65024
> Kernel command line: root=/dev/nfs rw
> nfsroot=128.224.149.6:/tftpboot/sliu/rootfs
> ip=128.224.149.11::128.224.149.1:255.255.255.0:yosemite:eth0:off
> console=ttyS0,9600
> PID hash table entries: 1024 (order: 10, 4096 bytes)
> console [ttyS0] enabled
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 256896k available (2052k kernel code, 716k data, 152k init, 0k
> highmem)
> Calibrating delay loop... 798.72 BogoMIPS (lpj=1597440)
> Mount-cache hash table entries: 512
> NET: Registered protocol family 16
> PCI: Probing PCI hardware
> PCI: Scanning bus 0000:00
> PCI: Found 0000:00:0c.0 [10ec/8139] 000200 00
> PCI: Calling quirk c000444c for 0000:00:0c.0
> PCI: Fixups for bus 0000:00
> PCI: Bus scan for 0000:00 returning with max=00
> PCI: fixup irq: (0000:00:0c.0) got 25
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> NET: Registered protocol family 2
> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP reno registered
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> PCI: Calling quirk c00fbab4 for 0000:00:0c.0
> PCI: Calling quirk c02ae3b8 for 0000:00:0c.0
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> serial8250: ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
> serial8250: ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> PPC 4xx OCP EMAC driver, version 3.54
> mal0: initialized, 4 TX channels, 2 RX channels
> zmii0: bridge in RMII mode
> eth0: emac0, MAC 00:10:ec:00:87:42
> eth0: found Generic MII PHY (0x01)
> eth1: emac1, MAC 00:00:00:00:00:00
> eth1: found Generic MII PHY (0x03)
> 8139too Fast Ethernet driver 0.9.28
> eth2: RealTek RTL8139 at 0xd1012f00, 00:0e:2e:7e:f5:e6, IRQ 25
> eth2:  Identified 8139 chip type 'RTL-8100B/8139D'
> pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB Ethernet driver
> usbcore: registered new interface driver pegasus
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> usbmon: debugfs is not available
> ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
> ppc-soc-ohci ppc-soc-ohci.0: USB Host Controller
> ppc-soc-ohci ppc-soc-ohci.0: new USB bus registered, assigned bus number 1
> ppc-soc-ohci ppc-soc-ohci.0: irq 40, io mem 0xef601000
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> Initializing USB Mass Storage driver...
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> ether gadget: using random self ethernet address
> ether gadget: using random host ethernet address
> usb0: Ethernet Gadget, version: May Day 2005
> usb0: using musbhsfc_udc, OUT ep2 IN ep1 STATUS ep3
> usb0: MAC 66:91:74:ab:fb:61
> usb0: HOST MAC 1a:b5:87:5d:8f:00
> usb0: RNDIS ready
> musbhsfc_udc: registered gadget driver 'ether'
> TCP cubic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> usb 1-1: new full speed USB device using ppc-soc-ohci and address 2
> usb 1-1: configuration #1 chosen from 1 choice
> eth0: link is up, 100 FDX, pause enabled
> scsi0 : SCSI emulation for USB Mass Storage devices
> usb-storage: device found at 2
> usb-storage: waiting for device to settle before scanning
> IP-Config: Complete:
>       device=eth0, addr=128.224.149.11, mask=255.255.255.0,
> gw=128.224.149.1,
>      host=yosemite, domain=, nis-domain=(none),
>      bootserver=255.255.255.255, rootserver=128.224.149.6, rootpath=
> Looking up port of RPC 100003/2 on 128.224.149.6
> Looking up port of RPC 100005/1 on 128.224.149.6
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 152k init
> scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 2.0 6.16 PQ: 0
> ANSI: 0 CCS
> sd 0:0:0:0: [sda] 244735 512-byte hardware sectors (125 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 45 00 00 08
> sd 0:0:0:0: [sda] Assuming drive cache: write through
> sd 0:0:0:0: [sda] 244735 512-byte hardware sectors (125 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 45 00 00 08
> sd 0:0:0:0: [sda] Assuming drive cache: write through
>  sda: sda1
> sd 0:0:0:0: [sda] Attached SCSI removable disk
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> usb-storage: device scan complete
> irq 25: nobody cared (try booting with the "irqpoll" option)
> Call Trace:
> [cf135af0] [c0008820] show_stack+0x48/0x190 (unreliable)
> [cf135b20] [c003c414] __report_bad_irq+0x34/0xac
> [cf135b40] [c003c714] note_interrupt+0x288/0x2c8
> [cf135b70] [c003b818] __do_IRQ+0x104/0x110
> [cf135b90] [c0006900] do_IRQ+0xbc/0xc0
> [cf135ba0] [c00020c0] ret_from_except+0x0/0x18
> [cf135c60] [00000019] 0x19
> [cf135c90] [c000668c] do_softirq+0x54/0x58
> [cf135ca0] [c001df40] irq_exit+0x48/0x58
> [cf135cb0] [c00068b4] do_IRQ+0x70/0xc0
> [cf135cc0] [c00020c0] ret_from_except+0x0/0x18
> [cf135d80] [c003c2b4] setup_irq+0x1ac/0x200
> [cf135da0] [c003c3cc] request_irq+0xc4/0xd8
> [cf135dd0] [c0122328] rtl8139_open+0x38/0x210
> [cf135df0] [c0187500] dev_open+0x7c/0xcc
> [cf135e10] [c0187420] dev_change_flags+0x16c/0x1d0
> [cf135e30] [c01cbff0] devinet_ioctl+0x604/0x720
> [cf135ea0] [c01cc1f8] inet_ioctl+0x98/0xbc
> [cf135eb0] [c0179328] sock_ioctl+0x60/0x260
> [cf135ed0] [c006c360] do_ioctl+0x38/0x84
> [cf135ee0] [c006c438] vfs_ioctl+0x8c/0x40c
> [cf135f10] [c006c7f8] sys_ioctl+0x40/0x74
> [cf135f40] [c0001a84] ret_from_syscall+0x0/0x3c
> handlers:
> [<c0122bd4>] (rtl8139_interrupt+0x0/0x52c)
> Disabling IRQ #25
> eth2: link up, 100Mbps, full-duplex, lpa 0x45E1
> 
> 
> Who can give some advice?
> 
> Thanks.
> BRs,
> Andrew.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

Looks like wrong external interrupt settings (trigger/level) for PCI 
interrupt.
