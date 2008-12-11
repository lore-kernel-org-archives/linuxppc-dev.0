Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-157.bluehost.com (outbound-mail-157.bluehost.com
	[67.222.39.37]) by ozlabs.org (Postfix) with SMTP id 26D47DE03A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Dec 2008 10:52:14 +1100 (EST)
Message-ID: <4941A7AB.1010806@dlasys.net>
Date: Thu, 11 Dec 2008 18:52:11 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Is anyone using the C67x00 USB Host ?
References: <49394978.10905@dlasys.net>
	<493D2B22.4000601@seznam.cz>	<493ED4B6.7010605@dlasys.net>
	<493F89F2.60702@seznam.cz>	<87iqpsme9j.fsf@macbook.be.48ers.dk>
	<493FD3EC.3060305@seznam.cz> <87wse8m6p0.fsf@macbook.be.48ers.dk>
	<493FEFA7.9050703@seznam.cz>
In-Reply-To: <493FEFA7.9050703@seznam.cz>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Michal;
    I tried the address swap you mentioned. That made things much worse.
    I have also tried changing hpi_regstep from 4 to 1 & 2 with zero
change in behavior - which does not make sense to me.
    The logs below are using a Toshiba 2G thumb drive moved between host
1 and host 2.
    I have also tried a 3com KAWETH based USB NIC. In all instances with
the IRQ disabled and a timer in its place,
    I can detect anything that I have drivers for on host 1 but not on
host 2.
    in all cases enabling the IRQ causes either register dumps or sprays
the console with messages about unhandled IRQ's or both.

I have some logs below


First - this is the log of a boot with the IRQ enabled.

Linux version 2.6.26-rc4-dirty (root@hp-dhlii.dlasys.lcl) (gcc version
4.2.4) #9 Thu Dec 11 18:03:34 EST 2008
Pico Virtex-4 port
Port by DLA Systems (info@dlasys.net)
Zone PFN ranges:
  DMA             0 ->    65535
  Normal      65535 ->    65535
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    65535
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65023
Kernel command line:   root=/dev/ram IP=172.16.0.154
Xilinx INTC #0 at 0x41200000 mapped to 0xF5FFB000
PID hash table entries: 1024 (order: 10, 4096 bytes)
console [ttyUL0] enabled
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 253952k available (1788k kernel code, 812k data, 3036k init, 0k
highmem)
Mount-cache hash table entries: 512
net_namespace: 192 bytes
NET: Registered protocol family 16
           
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
io scheduler noop registered (default)
Serial: Pico Xilinx uartlite driver $Revision: 0.10 $ 1 ports
ttyUL0 at MMIO 0x40600000 (irq = 15) is a uartlite
brd: module loaded
xilinx_lltemac.c:v0.10a Dec 11 2008  Yoshio Kashiwagi
 : temac addr d0000000 base 81c00000 len 128
 : sdma  addr d0002100 base 84600100 len 128
 : temac IRQ tx 0 rx 1 phy 2 fifo 255
 : xilinx_lltemac.c:v Dec 11 2008 Yoshio Kashiwagi
 : temac_set_mac_address(00:50:C2:44:28:14)
eth0: Dropping NETIF_F_SG since no checksum feature.
eth0: ll_temac at d0000000,0 IRQ 1 MAC:00:50:C2:44:28:14
usbcore: registered new interface driver kaweth
pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB Ethernet driver
usbcore: registered new interface driver pegasus
Driver 'sd' needs updating - please use bus_type methods
usbmon: debugfs is not available
irq 14: nobody cared (try booting with the "irqpoll" option)
Call Trace:
[cf81fb40] [c00091bc] show_stack+0x44/0x1ac (unreliable)
[cf81fb80] [c0044718] __report_bad_irq+0x34/0xb8
[cf81fba0] [c0044a14] note_interrupt+0x278/0x2cc
[cf81fbd0] [c0043ca4] __do_IRQ+0x100/0x118
[cf81fbf0] [c00075d8] do_IRQ+0xbc/0xc0
[cf81fc00] [c0002f54] ret_from_except+0x0/0x14
[cf81fcc0] [00000000] 0x0
[cf81fce0] [c000735c] do_softirq+0x58/0x5c
[cf81fcf0] [c00253bc] irq_exit+0x48/0x58
[cf81fd00] [c0007588] do_IRQ+0x6c/0xc0
[cf81fd10] [c0002f54] ret_from_except+0x0/0x14
[cf81fdd0] [c00443fc] setup_irq+0x1c4/0x23c
[cf81fdf0] [c0044538] request_irq+0xc4/0xd8
[cf81fe20] [c01bbac8] c67x00_drv_probe+0x118/0x3e4
[cf81fe50] [c00fdc20] platform_drv_probe+0x20/0x30
[cf81fe60] [c00fcc9c] driver_probe_device+0xbc/0x1f4
[cf81fe80] [c00fce58] __driver_attach+0x84/0x88
[cf81fea0] [c00fc1a4] bus_for_each_dev+0x5c/0x98
[cf81fed0] [c00fcaa0] driver_attach+0x24/0x34
[cf81fee0] [c00fc6d8] bus_add_driver+0xb4/0x248
[cf81ff10] [c00fd068] driver_register+0x5c/0x158
[cf81ff30] [c00fdfcc] platform_driver_register+0x9c/0xac
[cf81ff40] [c024c188] c67x00_init+0x18/0x28
[cf81ff50] [c023b1a0] kernel_init+0x98/0x27c
[cf81fff0] [c0004b18] kernel_thread+0x44/0x60
handlers:
[<c013f28c>] (c67x00_irq+0x0/0x128)
Disabling IRQ #14
------------[ cut here ]------------
Badness at c013fd58 [verbose debug info unavailable]
NIP: c013fd58 LR: c013fd4c CTR: c0019a6c
REGS: cf81fd50 TRAP: 0700   Not tainted  (2.6.26-rc4-dirty)
MSR: 00008030 <EE,IR,DR>  CR: 35000033  XER: e0000000
TASK = cf814c00[1] 'swapper' THREAD: cf81e000
GPR00: 00000001 cf81fe00 cf814c00 00000000 c0222520 cf814028 000001f4
00000001
GPR08: 00000008 00200200 cf8496f8 cf8496f8 35000033 ffffb6b4 c01eab48
c01eab00
GPR16: c01eab70 c01eab30 cf81ff98 c0253124 c0250000 00000000 07010000
c0250000
GPR24: cf81ff58 00000000 c0223888 c0223758 cf8496e8 00000000 c0223558
cf8496e0
NIP [c013fd58] c67x00_ll_reset+0x48/0x88
LR [c013fd4c] c67x00_ll_reset+0x3c/0x88
Call Trace:
[cf81fe00] [c013fd4c] c67x00_ll_reset+0x3c/0x88 (unreliable)
[cf81fe20] [c01bbb4c] c67x00_drv_probe+0x19c/0x3e4
[cf81fe50] [c00fdc20] platform_drv_probe+0x20/0x30
[cf81fe60] [c00fcc9c] driver_probe_device+0xbc/0x1f4
[cf81fe80] [c00fce58] __driver_attach+0x84/0x88
[cf81fea0] [c00fc1a4] bus_for_each_dev+0x5c/0x98
[cf81fed0] [c00fcaa0] driver_attach+0x24/0x34
[cf81fee0] [c00fc6d8] bus_add_driver+0xb4/0x248
[cf81ff10] [c00fd068] driver_register+0x5c/0x158
[cf81ff30] [c00fdfcc] platform_driver_register+0x9c/0xac
[cf81ff40] [c024c188] c67x00_init+0x18/0x28
[cf81ff50] [c023b1a0] kernel_init+0x98/0x27c
[cf81fff0] [c0004b18] kernel_thread+0x44/0x60
Instruction dump:
90010024 4807cdb5 38800000 7fa3eb78 6084fa50 4bfff7bd 387d0014 388004e2
4807c491 707dffff 7c000026 54001ffe <0f000000> 3c00ffff 7fbd00d0 60000005
c67x00 c67x00.0: Device reset failed
c67x00: probe of c67x00.0 failed with error 65531
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.

-------------------------------------------------------------------------------------------------------------------------------------

If I install a trimer that polls the IRQ handler rather than calling
request_irq()
I get this:

Linux version 2.6.26-rc4-dirty (root@hp-dhlii.dlasys.lcl) (gcc version
4.2.4) #10 Thu Dec 11 18:13:00 EST 2008
Pico Virtex-4 port
Port by DLA Systems (info@dlasys.net)
Zone PFN ranges:
  DMA             0 ->    65535
  Normal      65535 ->    65535
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    65535
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65023
Kernel command line:   root=/dev/ram IP=172.16.0.154
Xilinx INTC #0 at 0x41200000 mapped to 0xF5FFB000
PID hash table entries: 1024 (order: 10, 4096 bytes)
console [ttyUL0] enabled
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 253952k available (1788k kernel code, 812k data, 3036k init, 0k
highmem)
Mount-cache hash table entries: 512
net_namespace: 192 bytes
NET: Registered protocol family 16
          
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
io scheduler noop registered (default)
Serial: Pico Xilinx uartlite driver $Revision: 0.10 $ 1 ports
ttyUL0 at MMIO 0x40600000 (irq = 15) is a uartlite
brd: module loaded
xilinx_lltemac.c:v0.10a Dec 11 2008  Yoshio Kashiwagi
 : temac addr d0000000 base 81c00000 len 128
 : sdma  addr d0002100 base 84600100 len 128
 : temac IRQ tx 0 rx 1 phy 2 fifo 255
 : xilinx_lltemac.c:v Dec 11 2008 Yoshio Kashiwagi
 : temac_set_mac_address(00:50:C2:44:28:14)
eth0: Dropping NETIF_F_SG since no checksum feature.
eth0: ll_temac at d0000000,0 IRQ 1 MAC:00:50:C2:44:28:14
usbcore: registered new interface driver kaweth
pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB Ethernet driver
usbcore: registered new interface driver pegasus
Driver 'sd' needs updating - please use bus_type methods
usbmon: debugfs is not available
c67x00 c67x00.0: Cypress C67X00 Host Controller
c67x00 c67x00.0: new USB bus registered, assigned bus number 1
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Cypress C67X00 Host Controller
usb usb1: Manufacturer: Linux 2.6.26-rc4-dirty c67x00-hcd
usb usb1: SerialNumber: c67x00_sie
c67x00 c67x00.0: Cypress C67X00 Host Controller
c67x00 c67x00.0: new USB bus registered, assigned bus number 2
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: Cypress C67X00 Host Controller
usb usb2: Manufacturer: Linux 2.6.26-rc4-dirty c67x00-hcd
usb usb2: SerialNumber: c67x00_sie
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Freeing unused kernel memory: 3036k init
init started: BusyBox v1.12.0.svn (2008-07-30 00:35:26 EDT)
starting pid 124, tty '': '/etc/init.d/rcS'
Mounting FileSystems in fstabmount: mounting none on /config failed: No
such device
.
 * Starting mdev .
Running hostname to set hostname.
Starting: klogd.
Starting: udhcpcnet eth0: temac_set_mac_address(00:50:C2:44:28:14)
.
Starting Dropbear SSH server: [183] Jan 01 00:00:08 Running in
backgrounddropbear.
Starting: httpd
.
Running rdate to synchronize clockrdate: bad address '0.us.pool.ntp.org'
Starting: telnetd.
starting pid 207, tty '': '/bin/sh'
/bin/sh: can't access tty; job control turned off
/ # [222] Jan 01 00:00:49 Child connection from 172.16.0.1:49453
sd 0:0:0:0: [sda] Assuming drive cache: write through
[222] Jan 01 00:00:55 password auth succeeded for 'root' from
172.16.0.1:49453
sd 0:0:0:0: [sda] Assuming drive cache: write through

And the following from dmesg


usbmon: debugfs is not available
c67x00 c67x00.0: Cypress C67X00 Host Controller
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
c67x00 c67x00.0: new USB bus registered, assigned bus number 1
usb usb1: default language 0x0409
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 100ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Cypress C67X00 Host Controller
usb usb1: Manufacturer: Linux 2.6.26-rc4-dirty c67x00-hcd
usb usb1: SerialNumber: c67x00_sie
c67x00 c67x00.0: Cypress C67X00 Host Controller
drivers/usb/core/inode.c: creating file '002'
c67x00 c67x00.0: new USB bus registered, assigned bus number 2
usb usb2: default language 0x0409
usb usb2: uevent
usb usb2: usb_probe_device
usb usb2: configuration #1 chosen from 1 choice
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: uevent
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: ganged power switching
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 100ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: Cypress C67X00 Host Controller
usb usb2: Manufacturer: Linux 2.6.26-rc4-dirty c67x00-hcd
usb usb2: SerialNumber: c67x00_sie
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Freeing unused kernel memory: 3036k init
net eth0: eth0: Xilinx Embedded Tri-Mode Ethernet MAC Dec 11 2008 17:56:55
net eth0: temac d0000000 sdma d0002100
net eth0: xilinx_lltemacEthernet connected at 1000Mbps Full-Duplex
net eth0: temac_set_mac_address(00:50:C2:44:28:14)
net eth0: eth0: Promiscuous mode disabled.
net eth0: eth0: Promiscuous mode disabled.
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0002
hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
c67x00 c67x00.0: ClearPortFeature (0): C_RESET
usb 1-1: new full speed USB device using c67x00 and address 2
c67x00 c67x00.0: ClearPortFeature (0): C_RESET
usb 1-1: default language 0x0409
usb 1-1: uevent
usb 1-1: usb_probe_device
usb 1-1: configuration #1 chosen from 1 choice
usb 1-1: adding 1-1:1.0 (config #1, interface 0)
usb 1-1:1.0: uevent
usb-storage 1-1:1.0: usb_probe_interface
usb-storage 1-1:1.0: usb_probe_interface - got id
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
drivers/usb/core/inode.c: creating file '002'
usb 1-1: New USB device found, idVendor=0930, idProduct=6545
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: TransMemory
usb 1-1: Manufacturer: TOSHIBA
usb 1-1: SerialNumber: 06D0AB60F18358C7
scsi 0:0:0:0: Direct-Access     TOSHIBA  TransMemory      5.00 PQ: 0
ANSI: 0 CCS
sd 0:0:0:0: [sda] 4028416 512-byte hardware sectors (2063 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 23 00 00 00
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] 4028416 512-byte hardware sectors (2063 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 23 00 00 00
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI removable disk
usb-storage: device scan complete

-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
