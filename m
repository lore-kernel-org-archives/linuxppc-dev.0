Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 149A268A1E
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jan 2006 19:38:31 +1100 (EST)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id DE086E63E
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jan 2006 09:38:26 +0100 (CET)
Date: Sun, 22 Jan 2006 09:38:26 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: spinlockup detection on POWER3
Message-ID: <20060122083826.GA5292@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Does the CONFIG_DEBUG_SPINLOCK code  somehow depend on the cpu type?
It triggers alot on a p270 POWER3 box, even during early boot. I dont 
see it on POWE4/5.

This is with 2.6.15+

...
PCI: Probing PCI hardware
Failed to request PCI IO region on PCI domain 0000
IOMMU table initialized, virtual merging enabled
ISA bridge at 0000:00:0b.0
mapping IO f8000000 -> d000080000000000, size: 1000000
mapping IO f9000000 -> d000080001000000, size: 1000000
PCI: Probing PCI hardware done
usbcore: registered new driver usbfs
usbcore: registered new driver hub
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
IBM eBus Device Driver
RTAS daemon started
audit: initializing netlink socket (disabled)
audit(1137918797.139:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Using unsupported 1024x768 display at c0000000, depth=8, pitch=1024
Console: switching to colour frame buffer device 128x48
fb0: Open Firmware frame buffer device on /pci@fef00000/display@f
HVSI: registered 0 devices
Generic RTC Driver v1.07
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
BUG: spinlock lockup on CPU#3, hotplug/1384, c000000000456900
Call Trace:
[C00000003FD37900] [C00000000000ED88] .show_stack+0x68/0x1b0 (unreliable)
[C00000003FD379A0] [C0000000001C9780] ._raw_spin_lock+0x110/0x150
[C00000003FD37A20] [C000000000369960] .lock_kernel+0x3c/0x64
[C00000003FD37AA0] [C0000000000CF8D8] .chrdev_open+0x1b4/0x268
[C00000003FD37B50] [C0000000000C0538] .__dentry_open+0x160/0x300
[C00000003FD37C00] [C0000000000C084C] .do_filp_open+0x50/0x70
[C00000003FD37D00] [C0000000000C08E0] .do_sys_open+0x74/0x12c
[C00000003FD37DB0] [C0000000000FCB24] .compat_sys_open+0x24/0x38
[C00000003FD37E30] [C0000000000086F8] syscall_exit+0x0/0x40
serial8250.0: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250.0: ttyS2 at I/O 0x898 (irq = 15) is a 16550A
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
RAMDISK driver initialized: 16 RAM disks of 123456K size 1024 blocksize
loop: loaded (max 8 devices)
input: Macintosh mouse button emulation as /class/input/input0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Raw Set 2 keyboard as /class/input/input1
...

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
