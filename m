Return-Path: <monstr@seznam.cz>
Received: from smtp.seznam.cz (smtp.seznam.cz [77.75.72.43])
	by ozlabs.org (Postfix) with ESMTP id 4B2CADDF6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Dec 2008 20:21:01 +1100 (EST)
Message-ID: <493F89F2.60702@seznam.cz>
Date: Wed, 10 Dec 2008 10:20:50 +0100
From: Michal Simek <monstr@seznam.cz>
MIME-Version: 1.0
To: dhlii@dlasys.net
Subject: Re: Is anyone using the C67x00 USB Host ?
References: <49394978.10905@dlasys.net> <493D2B22.4000601@seznam.cz>
	<493ED4B6.7010605@dlasys.net>
In-Reply-To: <493ED4B6.7010605@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Reply-To: monstr@seznam.cz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David and Peter.

David:
Look to c67x00-ll-hpi.c and look at these values.

/* HPI registers */
#define HPI_DATA	0
#define HPI_MAILBOX	1
#define HPI_ADDR	2
#define HPI_STATUS	3

You should try to swap mailbox and addr address.

/* HPI registers */
#define HPI_DATA	0
#define HPI_MAILBOX	2
#define HPI_ADDR	1
#define HPI_STATUS	3

Peter:

What does it mean when I am getting TIMEOUT when kernel is trying to assign
address to device?

Here is the correspond log part. usb_control_msg 5 means address assigning. And
there is timeout description. Star means interrupt occur.

*usb_control_msg 5, -115
hub_set_address 4 ffffff8d
hub_set_address 8 ffffff8d
+-------------retval ffffff8d ---------------+
OK*... 0x14 ......*---c67x00_td_to_error---
*timeout
--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### TIMEOUT at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       1
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0008
*<6>c67x00 c67x00.0: pid_ep:         0xd0
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x01
*<6>c67x00 c67x00.0: status:         0x14
*<6>c67x00 c67x00.0: retry_cnt:      0x00
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 8 0x901b9e60
*<6>c67x00 c67x00.0: data:*
     *  0x00*  0x05*  0x05  0x00*  0x00  0x00*  0x00*  0x00


# cat /proc/bus/usb/devices

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.20-uc0 c67x00-hcd
S:  Product=Cypress C67X00 Host Controller
S:  SerialNumber=c67x00_sie
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
#


Don't you have your testing version for any kernel before 2.6.23? There were
some change in usb subsystem.


Best regards,
Michal

 Transferring control to Linux (at address 90000000), 0x90000000 ramdisk
0x00000000, FDT 0x00000000...
Found romfs @ 0x901be08c (0x000f1000)
#### klimit 901ef000 ####
Moving 0x000f1000 bytes from 0x901be08c to 0x901ee7d8
New klimit: 0x902e0000
Linux version 2.6.20-uc0 (monstr@monstr.eu) (gcc version 3.4.1 ( PetaLinux 0.20
Build -rc1 050607 )) #122 Wed Dec 10 10:09:48 CET 2008
setup_cpuinfo: initialising
setup_cpuinfo: Using full CPU PVR support
setup_memory: max_mapnr: 0x9ffff
setup_memory: min_low_pfn: 0x90000
setup_memory: max_low_pfn: 0x10000
On node 0 totalpages: 65536
  DMA zone: 512 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 65024 pages, LIFO batch:15
  Normal zone: 0 pages used for memmap
Built 1 zonelists.  Total pages: 65024
Kernel command line: mtdparts=$(mtdparts) macaddr=00:0a:35:00:22:01
console=ttyUL0,115200
OPB INTC #0 at 0x81800000
PID hash table entries: 1024 (order: 10, 4096 bytes)
TIMER at 0x83C00000
disabling early console
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256768k/262144k available
Calibrating delay loop... 49.56 BogoMIPS (lpj=247808)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
usbcore: registered new interface driver usbfs
usbfs_update_special ---------
usbfs_init ---------
usbcore: registered new interface driver hub
usbfs_update_special ---------
usbcore: registered new device driver usb
usbfs_update_special ---------
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
reg 0
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
uartlite.0: ttyUL0 at MMIO 0x84000000 (irq = 5) is a uartlite
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
xilinx_lltemac xilinx_lltemac.0: MAC address is now  0: a:35: 5: 5: 8
xilinx_lltemac xilinx_lltemac.0: XLlTemac: using DMA mode.
XLlTemac: Dma base address: phy: 0x84600080, virt: 0x84600080
XLlTemac: buffer descriptor size: 32768 (0x8000)
XLlTemac: Allocating DMA descriptors with kmalloc
XLlTemac: (buffer_descriptor_init) phy: 0x9ff90000, virt: 0x9ff90000, size: 0x8000
XTemac: PHY detected at address 7.
eth0: Dropping NETIF_F_SG since no checksum feature.
xilinx_lltemac xilinx_lltemac.0: eth0: Xilinx TEMAC at 0x81C00000 mapped to
0x81C00000, irq=4
uclinux[mtd]: RAM probe address=0x901ee7d8 size=0xf1000
Creating 1 MTD partitions on "RAM":
0x00000000-0x000f1000 : "ROMfs"
uclinux[mtd]: set ROMfs to be root filesystem index=0
c67x00_drv_probe
*c67x00_drv_probe before reset
*c67x00_drv_probe after reset
c67x00_probe_sie sie->mode 0x1 0
host mode sie->sie_num 0
c67x00_hcd_probe--1
2
3
4
5
*6
7
c67x00 c67x00.0: Cypress C67X00 Host Controller *******
usbfs_notify ---------
usbfs_add_bus ---------
create_special_files ---------
creating file 'devices'fs_create_by_name ---------devices
usbfs_create kkk
++++++++ 0
ok
ok2
ok4
creating file '001'fs_create_by_name ---------001
mkdir kkk
++++++++ 0
ok
ok2
ok3
usbfs_update_special ---------
c67x00 c67x00.0: new USB bus registered, assigned bus number 1
usb_control_msg 6, 18
usb_control_msg 6, 9
usb_control_msg 6, 25
usb_control_msg 6, 4
usb usb1: default language 0x0409
usb_control_msg 6, 63
usb_control_msg 6, 57
usb_control_msg 6, 23
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Cypress C67X00 Host Controller
usb usb1: Manufacturer: Linux 2.6.20-uc0 c67x00-hcd
usb usb1: SerialNumber: c67x00_sie
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb_control_msg 9, 0
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
usb_control_msg 6, 15
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 100ms
usb_control_msg 0, 2
usb_control_msg 0, 4
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
usb_control_msg 3, 0
usb_control_msg 3, 0
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
usbfs_notify ---------
usbfs_add_device ---------
creating file '001'fs_create_by_name ---------001
usbfs_create kkk
++++++++ 0
ok
ok2
ok3
ok4
usbfs_update_special ---------
8
9
c67x00_probe_sie sie->mode 0x0 1
c67x00 c67x00.0: Not using SIE 1 as requested
c67x00_drv_probe end
////////////////////cypress_init///////////////////
usb_control_msg 0, 4
usb_control_msg 0, 4
usbcore: registered new interface driver cypress_cy7c63
usbfs_update_special ---------
TCP cubic registered
NET: Registered protocol family 1
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 80k freed
Mounting proc:
Mounting var:
Populating /var:
Running local start scripts.
Mounting debugfs:
Mounting /etc/config:
Populating /etc/config:
flatfsd: Nonexistent or bad flatfs (-48), creating new one...
flatfsd: Failed to write flatfs (-48): No such device
flatfsd: Created 5 configuration files (185 bytes)
Mounting sysfs:
Mounting usbfs:
Setting hostname:
Setting up interface lo:
Setting up interface eth0:
eth0: XLlTemac: Options: 0x3fa
eth0: XLlTemac: allocating interrupt 1 for dma mode tx.
eth0: XLlTemac: allocating interrupt 2 for dma mode rx.
eth0: XLlTemac: Not able to set the speed to 1000 (status: 0x7949)
eth0: XLlTemac: We renegotiated the speed to: 100
eth0: XLlTemac: speed set to 100Mb/s
eth0: XLlTemac: Send Threshold = 24, Receive Threshold = 4
eth0: XLlTemac: Send Wait bound = 254, Receive Wait bound = 254
        Starting thttpd:

uclinux login: root
Password:
#

USB flash disk plug in

#
#
# hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0002
usb_control_msg 0, 4
usb_control_msg 1, 0
hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
usb_control_msg 0, 4
usb_control_msg 0, 4
usb_control_msg 0, 4
usb_control_msg 0, 4
usb_control_msg 0, 4
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
*usb_control_msg 3, 0
usb_control_msg 0, 4
usb_control_msg 1, 0
usb 1-1: new full speed USB device using c67x00 and address 2
OK*... 0x0 ......*--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### SUCCESSFUL at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       0
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0008
*<6>c67x00 c67x00.0: pid_ep:         0xd0
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x01
*<6>c67x00 c67x00.0: status:         0x00
*<6>c67x00 c67x00.0: retry_cnt:      0x01
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 8 0x901b9e60
*<6>c67x00 c67x00.0: data:*
     *  0x80*  0x06  0x00*  0x01*  0x00  0x00*  0x40  0x00*
OK**... 0x29 ......*--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### SUCCESSFUL at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       0
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0040
*<6>c67x00 c67x00.0: pid_ep:         0x90
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x41
*<6>c67x00 c67x00.0: status:         0x29
*<6>c67x00 c67x00.0: retry_cnt:      0x01
*<6>c67x00 c67x00.0: residue:        0x2e
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 64 0x9ff64598
*<6>c67x00 c67x00.0: data:*
       0x12*  0x01  0x00*  0x02*  0x00  0x00*  0x00*  0x40
     *  0x81*  0x07  0x06*  0x54  0x10*  0x00*  0x01  0x02*
     *  0x03  0x01*  0x73  0x72*  0x2f*  0x62  0x69*  0x6e*
       0x3a*  0x2f*  0x75  0x73*  0x72  0x2f*  0x73*  0x62
     *  0x69*  0x6e  0x00*  0xff  0xff*  0xff*  0xff  0xff*
     *  0xff  0xff*  0xff*  0xff  0xff*  0xff  0xff*  0xff*
       0xff*  0xff*  0xff  0xff*  0xff*  0xff  0xff*  0xff
     *  0xff*  0xff  0xff*  0xff*  0xff  0xff*  0xff  0xff*
OK**... 0x0 ......*--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### SUCCESSFUL at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       0
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0000
*<6>c67x00 c67x00.0: pid_ep:         0x10
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x41
*<6>c67x00 c67x00.0: status:         0x00
*<6>c67x00 c67x00.0: retry_cnt:      0x01
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 0 0x0
*<6>c67x00 c67x00.0: data:*
c67x00_giveback_urb ++++++++++++++++++++++++++++++
*usb_control_msg 6, -115
*usb_control_msg 3, 0
usb_control_msg 0, 4
usb_control_msg 1, 0
*OK*... 0x0 ......*--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### SUCCESSFUL at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       1
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0008
*<6>c67x00 c67x00.0: pid_ep:         0xd0
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x01
*<6>c67x00 c67x00.0: status:         0x00
*<6>c67x00 c67x00.0: retry_cnt:      0x01
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 8 0x901b9e60
*<6>c67x00 c67x00.0: data:*
     *  0x00*  0x05  0x02*  0x00*  0x00  0x00*  0x00*  0x00
OK**... 0x0 ......*--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### SUCCESSFUL at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       1
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0000
*<6>c67x00 c67x00.0: pid_ep:         0x90
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x41
*<6>c67x00 c67x00.0: status:         0x00
*<6>c67x00 c67x00.0: retry_cnt:      0x01
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 0 0x0
*<6>c67x00 c67x00.0: data:*
c67x00_giveback_urb ++++++++++++++++++++++++++++++
*usb_control_msg 5, -115
hub_set_address 4 ffffff8d
hub_set_address 8 ffffff8d
+-------------retval ffffff8d ---------------+
OK**... 0x14 ......*---c67x00_td_to_error---
*timeout
--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### TIMEOUT at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       1
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0008
*<6>c67x00 c67x00.0: pid_ep:         0xd0
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x01
*<6>c67x00 c67x00.0: status:         0x14
*<6>c67x00 c67x00.0: retry_cnt:      0x00
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 8 0x901b9e60
*<6>c67x00 c67x00.0: data:*
       0x00*  0x05  0x02*  0x00*  0x00  0x00*  0x00  0x00*
c67x00_giveback_urb ++++++++++++++++++++++++++++++
*usb_control_msg 5, -115
hub_set_address 4 ffffff8d
hub_set_address 8 ffffff8d
+-------------retval ffffff8d ---------------+
usb 1-1: device not accepting address 2, error -115
*usb_control_msg 1, 0
___c67x00_endpoint_disable____
___c67x00_endpoint_disable____
*usb_control_msg 3, 0
usb_control_msg 0, 4
usb_control_msg 1, 0
usb 1-1: new full speed USB device using c67x00 and address 3
OK**... 0x0 ......*--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### SUCCESSFUL at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       0
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0008
*<6>c67x00 c67x00.0: pid_ep:         0xd0
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x01
*<6>c67x00 c67x00.0: status:         0x00
*<6>c67x00 c67x00.0: retry_cnt:      0x01
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 8 0x901b9c40
*<6>c67x00 c67x00.0: data:*
     *  0x80*  0x06  0x00*  0x01*  0x00  0x00*  0x40*  0x00
OK**... 0x29 ......*--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### SUCCESSFUL at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       0
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0040
*<6>c67x00 c67x00.0: pid_ep:         0x90
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x41
*<6>c67x00 c67x00.0: status:         0x29
*<6>c67x00 c67x00.0: retry_cnt:      0x01
*<6>c67x00 c67x00.0: residue:        0x2e
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 64 0x9ff64598
*<6>c67x00 c67x00.0: data:*
       0x12*  0x01  0x00*  0x02*  0x00  0x00*  0x00*  0x40
     *  0x81*  0x07  0x06*  0x54  0x10*  0x00*  0x01  0x02*
     *  0x03  0x01*  0x45  0xa4*  0x05*  0x00  0x00*  0x00
     *  0x90*  0x1b  0x9e*  0x60*  0x00  0x00*  0x00*  0x00
     *  0x00  0x00*  0x00*  0x00  0x90*  0x1b*  0x9c  0x40*
     *  0x80  0x00*  0x00  0x00*  0x00*  0x00  0x00*  0x00*
       0x00*  0x00  0x00*  0x00*  0x00  0x00*  0x00*  0x00
     *  0x00  0x00*  0x00*  0x00  0x00*  0x00*  0x00  0x00*
OK*... 0x0 ......*--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### SUCCESSFUL at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       0
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0000
*<6>c67x00 c67x00.0: pid_ep:         0x10
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x41
*<6>c67x00 c67x00.0: status:         0x00
*<6>c67x00 c67x00.0: retry_cnt:      0x01
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 0 0x0
*<6>c67x00 c67x00.0: data:*
c67x00_giveback_urb ++++++++++++++++++++++++++++++
*usb_control_msg 6, -115
*usb_control_msg 3, 0
usb_control_msg 0, 4
usb_control_msg 1, 0
OK*... 0x0 ......*--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### SUCCESSFUL at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       1
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0008
*<6>c67x00 c67x00.0: pid_ep:         0xd0
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x01
*<6>c67x00 c67x00.0: status:         0x00
*<6>c67x00 c67x00.0: retry_cnt:      0x01
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 8 0x901b9c40
*<6>c67x00 c67x00.0: data:*
     *  0x00*  0x05  0x03*  0x00*  0x00  0x00*  0x00  0x00*
OK**... 0x0 ......*--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### SUCCESSFUL at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       1
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0000
*<6>c67x00 c67x00.0: pid_ep:         0x90
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x41
*<6>c67x00 c67x00.0: status:         0x00
*<6>c67x00 c67x00.0: retry_cnt:      0x01
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 0 0x0
*<6>c67x00 c67x00.0: data:*
c67x00_giveback_urb ++++++++++++++++++++++++++++++
*usb_control_msg 5, -115
hub_set_address 4 ffffff8d
hub_set_address 8 ffffff8d
+-------------retval ffffff8d ---------------+
OK*... 0x14 ......*---c67x00_td_to_error---
*timeout
--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### TIMEOUT at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       1
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0008
*<6>c67x00 c67x00.0: pid_ep:         0xd0
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x01
*<6>c67x00 c67x00.0: status:         0x14
*<6>c67x00 c67x00.0: retry_cnt:      0x00
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 8 0x901b9c40
*<6>c67x00 c67x00.0: data:**
       0x00*  0x05*  0x03  0x00*  0x00  0x00*  0x00*  0x00
c67x00_giveback_urb ++++++++++++++++++++++++++++++
*usb_control_msg 5, -115
hub_set_address 4 ffffff8d
hub_set_address 8 ffffff8d
+-------------retval ffffff8d ---------------+
usb 1-1: device not accepting address 3, error -115
*usb_control_msg 1, 0
___c67x00_endpoint_disable____
___c67x00_endpoint_disable____
*usb_control_msg 3, 0
usb_control_msg 0, 4
usb_control_msg 1, 0
usb 1-1: new full speed USB device using c67x00 and address 4
OK**... 0x0 ......*--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### SUCCESSFUL at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       1
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0008
*<6>c67x00 c67x00.0: pid_ep:         0xd0
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x01
*<6>c67x00 c67x00.0: status:         0x00
*<6>c67x00 c67x00.0: retry_cnt:      0x01
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 8 0x901b98e0
*<6>c67x00 c67x00.0: data:*
     *  0x00*  0x05  0x04*  0x00*  0x00  0x00*  0x00  0x00*
OK**... 0x0 ......*--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### SUCCESSFUL at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       1
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0000
*<6>c67x00 c67x00.0: pid_ep:         0x90
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x41
*<6>c67x00 c67x00.0: status:         0x00
*<6>c67x00 c67x00.0: retry_cnt:      0x01
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 0 0x0
*<6>c67x00 c67x00.0: data:*
c67x00_giveback_urb ++++++++++++++++++++++++++++++
*usb_control_msg 5, -115
hub_set_address 4 ffffff8d
hub_set_address 8 ffffff8d
+-------------retval ffffff8d ---------------+
OK*... 0x14 ......*---c67x00_td_to_error---
*timeout
--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### TIMEOUT at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       1
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0008
*<6>c67x00 c67x00.0: pid_ep:         0xd0
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x01
*<6>c67x00 c67x00.0: status:         0x14
*<6>c67x00 c67x00.0: retry_cnt:      0x00
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 8 0x901b98e0
*<6>c67x00 c67x00.0: data:*
     *  0x00*  0x05  0x04*  0x00*  0x00  0x00*  0x00*  0x00
c67x00_giveback_urb ++++++++++++++++++++++++++++++
*usb_control_msg 5, -115
hub_set_address 4 ffffff8d
hub_set_address 8 ffffff8d
+-------------retval ffffff8d ---------------+
usb 1-1: device not accepting address 4, error -115
*usb_control_msg 1, 0
___c67x00_endpoint_disable____
___c67x00_endpoint_disable____
*usb_control_msg 3, 0
usb_control_msg 0, 4
usb_control_msg 1, 0
usb 1-1: new full speed USB device using c67x00 and address 5
OK**... 0x0 ......*--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### SUCCESSFUL at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       1
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0008
*<6>c67x00 c67x00.0: pid_ep:         0xd0
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x01
*<6>c67x00 c67x00.0: status:         0x00
*<6>c67x00 c67x00.0: retry_cnt:      0x01
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
**<6>c67x00 c67x00.0: len: 8 0x901b9e60
*<6>c67x00 c67x00.0: data:*
       0x00*  0x05  0x05*  0x00*  0x00  0x00*  0x00*  0x00
OK**... 0x0 ......*--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### SUCCESSFUL at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       1
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0000
*<6>c67x00 c67x00.0: pid_ep:         0x90
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x41
*<6>c67x00 c67x00.0: status:         0x00
*<6>c67x00 c67x00.0: retry_cnt:      0x01
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 0 0x0
*<6>c67x00 c67x00.0: data:*
c67x00_giveback_urb ++++++++++++++++++++++++++++++
*usb_control_msg 5, -115
hub_set_address 4 ffffff8d
hub_set_address 8 ffffff8d
+-------------retval ffffff8d ---------------+
OK*... 0x14 ......*---c67x00_td_to_error---
*timeout
--------------------------------------1-----------
*<6>c67x00 c67x00.0: ### TIMEOUT at 0x0500
*<6>c67x00 c67x00.0: urb:      0x906823cc
*<6>c67x00 c67x00.0: urb->error_count, status:      0, -115
*<6>c67x00 c67x00.0: endpoint:      0
*<6>c67x00 c67x00.0: pipeout:       1
*<6>c67x00 c67x00.0: ly_base_addr: 0x0700
*<6>c67x00 c67x00.0: port_length:  0x0008
*<6>c67x00 c67x00.0: pid_ep:         0xd0
*<6>c67x00 c67x00.0: dev_addr:       0x00
*<6>c67x00 c67x00.0: ctrl_reg:       0x01
*<6>c67x00 c67x00.0: status:         0x14
*<6>c67x00 c67x00.0: retry_cnt:      0x00
*<6>c67x00 c67x00.0: residue:        0x00
*<6>c67x00 c67x00.0: next_td_addr: 0x0000
*<6>c67x00 c67x00.0: len: 8 0x901b9e60
*<6>c67x00 c67x00.0: data:*
     *  0x00*  0x05*  0x05  0x00*  0x00  0x00*  0x00*  0x00
c67x00_giveback_urb ++++++++++++++++++++++++++++++
*usb_control_msg 5, -115
hub_set_address 4 ffffff8d
hub_set_address 8 ffffff8d
+-------------retval ffffff8d ---------------+
usb 1-1: device not accepting address 5, error -115
*usb_control_msg 1, 0
___c67x00_endpoint_disable____
___c67x00_endpoint_disable____
*usb_control_msg 1, 0






USB-mon plug in flash disk

9ff853c4 250670102 C Ii:001:01 0 1 = 02
9ff853c4 250670798 S Ii:001:01 -115 2 <
90679970 250676322 S Ci:001:00 s a3 00 0000 0001 0004 4 <
90679970 250676407 C Ci:001:00 0 4 = 01010100
90679970 250678981 S Co:001:00 s 23 01 0010 0001 0000 0
90679970 250679050 C Co:001:00 0 0
90679970 250687913 S Ci:001:00 s a3 00 0000 0001 0004 4 <
90679970 250688001 C Ci:001:00 0 4 = 01010000
90679970 250730230 S Ci:001:00 s a3 00 0000 0001 0004 4 <
90679970 250730346 C Ci:001:00 0 4 = 01010000
90679970 250770209 S Ci:001:00 s a3 00 0000 0001 0004 4 <
90679970 250770321 C Ci:001:00 0 4 = 01010000
90679970 250810222 S Ci:001:00 s a3 00 0000 0001 0004 4 <
90679970 250810335 C Ci:001:00 0 4 = 01010000
90679970 250850223 S Ci:001:00 s a3 00 0000 0001 0004 4 <
90679970 250850336 C Ci:001:00 0 4 = 01010000
90679970 250860952 S Co:001:00 s 23 03 0004 0001 0000 0
90679970 250923848 C Co:001:00 0 0
90679970 251130223 S Ci:001:00 s a3 00 0000 0001 0004 4 <
90679970 251130335 C Ci:001:00 0 4 = 03010000
90679970 251190215 S Co:001:00 s 23 01 0014 0001 0000 0
90679970 251190308 C Co:001:00 0 0
90679970 251199878 S Ci:000:00 s 80 06 0100 0000 0040 64 <
90679970 251525090 C Ci:000:00 -115 18 = 12010002 00000040 81070654 10000102 0301
90679970 251528194 S Co:001:00 s 23 03 0004 0001 0000 0
90679970 251591102 C Co:001:00 0 0
90679970 251800208 S Ci:001:00 s a3 00 0000 0001 0004 4 <
90679970 251800322 C Ci:001:00 0 4 = 03010000
90679970 251860219 S Co:001:00 s 23 01 0014 0001 0000 0
90679970 251860312 C Co:001:00 0 0
90679970 251862897 S Co:000:00 s 00 05 000a 0000 0000 0
90679970 252047373 C Co:000:00 -115 0
90679970 252270220 S Co:000:00 s 00 05 000a 0000 0000 0
90679970 252372925 C Co:000:00 -115 0
90679970 252596167 S Co:001:00 s 23 01 0001 0001 0000 0
90679970 252659090 C Co:001:00 0 0
90679970 252669133 S Co:001:00 s 23 03 0004 0001 0000 0
90679970 252732038 C Co:001:00 0 0
90679970 252940214 S Ci:001:00 s a3 00 0000 0001 0004 4 <
90679970 252940327 C Ci:001:00 0 4 = 03010000
90679970 253000228 S Co:001:00 s 23 01 0014 0001 0000 0
90679970 253000318 C Co:001:00 0 0
90679970 253009882 S Ci:000:00 s 80 06 0100 0000 0040 64 <
90679970 253335736 C Ci:000:00 -115 18 = 12010002 00000040 81070654 10000102 0301
90679970 253338840 S Co:001:00 s 23 03 0004 0001 0000 0
90679970 253401740 C Co:001:00 0 0
90679970 253610223 S Ci:001:00 s a3 00 0000 0001 0004 4 <
90679970 253610334 C Ci:001:00 0 4 = 03010000
90679970 253670218 S Co:001:00 s 23 01 0014 0001 0000 0
90679970 253670311 C Co:001:00 0 0
90679970 253672901 S Co:000:00 s 00 05 000b 0000 0000 0
90679970 253856778 C Co:000:00 -115 0
90679970 254080219 S Co:000:00 s 00 05 000b 0000 0000 0
90679970 254182318 C Co:000:00 -115 0
90679970 254406171 S Co:001:00 s 23 01 0001 0001 0000 0
90679970 254469106 C Co:001:00 0 0
90679970 254479146 S Co:001:00 s 23 03 0004 0001 0000 0
90679970 254542042 C Co:001:00 0 0
90679970 254750225 S Ci:001:00 s a3 00 0000 0001 0004 4 <
90679970 254750337 C Ci:001:00 0 4 = 03010000
90679970 254810206 S Co:001:00 s 23 01 0014 0001 0000 0
90679970 254810300 C Co:001:00 0 0
90679970 254819873 S Co:000:00 s 00 05 000c 0000 0000 0
90679970 255004537 C Co:000:00 -115 0
90679970 255220222 S Co:000:00 s 00 05 000c 0000 0000 0
90679970 255322634 C Co:000:00 -115 0
90679970 255546177 S Co:001:00 s 23 01 0001 0001 0000 0
90679970 255609100 C Co:001:00 0 0
90679970 255619142 S Co:001:00 s 23 03 0004 0001 0000 0
90679970 255682051 C Co:001:00 0 0
90679970 255890210 S Ci:001:00 s a3 00 0000 0001 0004 4 <
90679970 255890324 C Ci:001:00 0 4 = 03010000
90679970 255950218 S Co:001:00 s 23 01 0014 0001 0000 0
90679970 255950313 C Co:001:00 0 0
90679970 255959879 S Co:000:00 s 00 05 000d 0000 0000 0
90679970 256144736 C Co:000:00 -115 0
90679970 256360220 S Co:000:00 s 00 05 000d 0000 0000 0
90679970 256462596 C Co:000:00 -115 0
90679970 256686172 S Co:001:00 s 23 01 0001 0001 0000 0
90679970 256749105 C Co:001:00 0 0
90679970 256758936 S Co:001:00 s 23 01 0001 0001 0000 0
90679970 256821834 C Co:001:00 0 0




Unglug flash disk





9ff853c4 278210107 C Ii:001:01 0 1 = 02
9ff853c4 278210799 S Ii:001:01 -115 2 <
9f9aadf4 278216322 S Ci:001:00 s a3 00 0000 0001 0004 4 <
9f9aadf4 278216406 C Ci:001:00 0 4 = 02010100
9f9aadf4 278218981 S Co:001:00 s 23 01 0010 0001 0000 0
9f9aadf4 278219051 C Co:001:00 0 0
9f9aadf4 278227913 S Ci:001:00 s a3 00 0000 0001 0004 4 <
9f9aadf4 278228000 C Ci:001:00 0 4 = 02010000
9f9aadf4 278270229 S Ci:001:00 s a3 00 0000 0001 0004 4 <
9f9aadf4 278270346 C Ci:001:00 0 4 = 02010000
9f9aadf4 278310223 S Ci:001:00 s a3 00 0000 0001 0004 4 <
9f9aadf4 278310336 C Ci:001:00 0 4 = 02010000
9f9aadf4 278350223 S Ci:001:00 s a3 00 0000 0001 0004 4 <
9f9aadf4 278350336 C Ci:001:00 0 4 = 02010000
9f9aadf4 278390224 S Ci:001:00 s a3 00 0000 0001 0004 4 <
9f9aadf4 278390337 C Ci:001:00 0 4 = 02010000
9f9aadf4 278400722 S Co:001:00 s 23 01 0001 0001 0000 0
9f9aadf4 278463633 C Co:001:00 0 0









> Michal Simek wrote:
>> Hi David,
>>
>> currently I am working on backport this driver to 2.6.20 to Microblaze but
>> a lot of things are the same.
>>
>> From HW site. Interrupt goes outside of IP directly to interrupt controller.
>> And you need to call platform_device_register with proper structure.
>>
>> Could you send your kernel log?
>>   
>     I can post a log, but:
>        Interrupts are occuring, and being trapped.
>     The following code in the driver just seems to always return
> IRQ_NONE when called from an interrupt.
>    
>         int_status = c67x00_ll_hpi_status(c67x00);
>         if (!int_status)
>             return IRQ_NONE;
> 
>     However, if I add a timer that just polls the interrupt handler, I
> have the driver working (on the first port) but slowly.
> 
> 
> 
> 
> 
>> Thanks,
>> Michal
>>
>>
>>
>>   
>>
> 
> 
