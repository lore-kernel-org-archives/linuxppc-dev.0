Return-Path: <mzyngier@freesurf.fr>
Received: from young-lust.wild-wind.fr.eu.org (lopsy-lu.misterjones.org
	[62.4.18.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12D966861A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2005 04:02:28 +1000 (EST)
Received: from hina.wild-wind.fr.eu.org ([192.168.70.139] helo=hina)
	by young-lust.wild-wind.fr.eu.org with esmtpsa
	(TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1ESeb8-0007lX-Uy
	for linuxppc-dev@ozlabs.org; Thu, 20 Oct 2005 19:53:03 +0200
Received: from maz by hina with local (Exim 4.52) id 1ESeb8-0002Bb-34
	for linuxppc-dev@ozlabs.org; Thu, 20 Oct 2005 19:53:02 +0200
From: Marc Zyngier <maz@misterjones.org>
To: linuxppc-dev@ozlabs.org
Date: Thu, 20 Oct 2005 19:53:02 +0200
Message-ID: <wrpll0of535.fsf@wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Subject: v2.6.13.4 : Bad page state at prep_new_page when booting with quik
Reply-To: maz@misterjones.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-=-=

List,

I finally managed to bring back to life an old Apus 3000/200 (PowerMac
6400 clone, 603e@200, no L2 cache, 144MB RAM). Kernel is vanilla
2.6.13.4, userland is Debian Sarge.

The strange thing is : while the machine boots perfectly with BootX,
it fills the console with messages like this when booted from quik :

Bad page state at prep_new_page (in process 'S70nviboot', page c04301e0)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c00493cc] do_wp_page+0xdc/0x3cc
 [c004a6dc] __handle_mm_fault+0x154/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed

And no, rebooting doesn't help...

The system more or less manages to painfuly boot, still screaming on
the console. But the result is far from being usable.

Again, the very same kernel works perfectly when booted from BootX,
but I'd rather have the machine to stay headless, with serial console
hanging off the terminal server...

Does anyone have a clue, or at least a direction from where to start?

Thanks,

	M.


--=-=-=
Content-Disposition: inline; filename=log


Second-stage QUIK loader
Welcome to quik. mate is good.
\chosen/bootargs = 
boot: ` 
Enter the kernel image name as [device:][partno]/path, where partno is a
number from 0 to 16.  Instead of /path you can type [mm-nn] to specify a
range of disk blocks (512B)
boot: v2.6.13.4
|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/initrd imagename = `, mem_size: 3267524
initrd_start: 

Inode error #2133571404 while loading file `.
initrd image not found....
Starting at 510000, , 9101312
no active packageopening display /valkyrie@F1000000... ok
copying OF device tree...done
Initializing fake screen: valkyrie
Calling quiesce ...
returning 0x00510000 from prom_init
Linux version 2.6.13.4 (maz@strange-fruit) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #2 Sun Oct 16 20:36:15 CEST 2005
Found a OHare mac-io controller, rev: 1, mapped at 0xfdf00000
PowerMac motherboard: Alchemy
Cache coherency enabled for bandit/PSX
Found Bandit PCI host bridge at 0xf2000000. Firmware bus number: 0->0
nvram: OF partition at 0x1800
nvram: XP partition at 0x1300
nvram: NR partition at 0x1400
Built 1 zonelists
Kernel command line: root=/dev/hda6 ro root=/dev/hda6 console=ttyS0 console=tty0 
System has 32 possible interrupts
PID hash table entries: 1024 (order: 10, 16384 bytes)
GMT Delta read from XPRAM: 120 minutes, DST: on
via_calibrate_decr: ticks per jiffy = 10000 (600010 ticks)
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 142848k available (2056k kernel code, 1012k data, 140k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
SCSI subsystem initialized
Monitor sense value = 0x603
using video mode 6 and color mode 0.
Console: switching to colour frame buffer device 80x30
fb0: valkyrie frame buffer device
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
ttyS0 at MMIO 0xf3013020 (irq = 15) is a Z85c30 ESCC - Serial port
ttyS1 at MMIO 0xf3013000 (irq = 16) is a Z85c30 ESCC - Serial port
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
fd0: SWIM3 floppy controller 
loop: loaded (max 8 devices)
PCI: Enabling device 0000:00:0f.0 (0014 -> 0017)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0f.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x400. Vers LK1.1.19
MacIO PCI driver attached to OHare chipset
Can't request resource 0 for MacIO device 0.f3000000:ohare
input: Macintosh mouse button emulation
Macintosh CUDA driver v0.5 for Unified ADB.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
adb: starting probe task...
ide0: no intrs for device /bandit@F2000000/ohare@10/ATA@20000, using 13
ide0: Found Apple OHare ATA controller, bus ID 0, irq 13
ADB keyboard at 2, handler set to 3
Detected ADB keyboard, type ISO, swapping keys.
input: ADB keyboard on adb2:2.05/input
ADB mouse at 3, handler set to 2
input: ADB mouse on adb3:3.01/input
adb: finished probe task...
hda: SAMSUNG WINNER-3 WN32163A (2.1GB), ATA DISK drive
hda: Enabling MultiWord DMA 2
ide0 at 0xca10a000-0xca10a007,0xca10a160 on irq 13
hda: max request size: 128KiB
hda: 4219488 sectors (2160 MB) w/109KiB Cache, CHS=4186/16/63, DMA
hda: cache flushes not supported
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9
mesh: configured for synchronous 5 MB/s
mesh: performing initial bus reset...
scsi0 : MESH
mesh: target 3 synchronous at 5.0 MB/s
  Vendor: MATSHITA  Model: CD-ROM CR-506     Rev: 8S05
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
Attached scsi generic sg0 at scsi0, channel 0, id 3, lun 0,  type 5
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k init 4k chrp 8k prep
Adding 131064k swap on /dev/hda7.  Priority:-1 extents:1
EXT3 FS on hda6, internal journal
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
Bad page state at prep_new_page (in process 'S70nviboot', page c04301e0)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c00493cc] do_wp_page+0xdc/0x3cc
 [c004a6dc] __handle_mm_fault+0x154/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S70nviboot', page c0430200)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c00493cc] do_wp_page+0xdc/0x3cc
 [c004a6dc] __handle_mm_fault+0x154/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S70nviboot', page c0430220)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0049fe0] do_anonymous_page+0x74/0x1b8
 [c004a190] do_no_page+0x6c/0x380
 [c004a668] __handle_mm_fault+0xe0/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S70nviboot', page c0430240)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0049fe0] do_anonymous_page+0x74/0x1b8
 [c004a190] do_no_page+0x6c/0x380
 [c004a668] __handle_mm_fault+0xe0/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S70nviboot', page c0430260)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0039480] find_or_create_page+0xf4/0x108
 [c005c4d8] grow_dev_page+0x30/0x184
 [c005c6c8] __getblk_slow+0x9c/0x15c
 [c005cbd0] __getblk+0x54/0x5c
 [c009cffc] ext3_getblk+0xc0/0x27c
 [c009d1d0] ext3_bread+0x18/0xc0
 [c0099e60] ext3_readdir+0xe8/0x4d4
 [c006ec14] vfs_readdir+0xc8/0xf0
 [c006f1d8] sys_getdents64+0x78/0xe0
 [c00042a0] ret_from_syscall+0x0/0x44
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S70nviboot', page c0430280)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c00493cc] do_wp_page+0xdc/0x3cc
 [c004a6dc] __handle_mm_fault+0x154/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S70nviboot', page c04301c0)
flags:0x00000000 mapping:00000000 mapcount:1 count:0
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c00493cc] do_wp_page+0xdc/0x3cc
 [c004a6dc] __handle_mm_fault+0x154/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S10sysklogd', page c04302a0)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c004a3bc] do_no_page+0x298/0x380
 [c004a668] __handle_mm_fault+0xe0/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S10sysklogd', page c04302c0)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c004a3bc] do_no_page+0x298/0x380
 [c004a668] __handle_mm_fault+0xe0/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S10sysklogd', page c04302e0)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0049fe0] do_anonymous_page+0x74/0x1b8
 [c004a190] do_no_page+0x6c/0x380
 [c004a668] __handle_mm_fault+0xe0/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S10sysklogd', page c0430300)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0049fe0] do_anonymous_page+0x74/0x1b8
 [c004a190] do_no_page+0x6c/0x380
 [c004a668] __handle_mm_fault+0xe0/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S10sysklogd', page c0430320)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c004a3bc] do_no_page+0x298/0x380
 [c004a668] __handle_mm_fault+0xe0/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S10sysklogd', page c0430340)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c004a3bc] do_no_page+0x298/0x380
 [c004a668] __handle_mm_fault+0xe0/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S10sysklogd', page c0430360)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0049fe0] do_anonymous_page+0x74/0x1b8
 [c004a190] do_no_page+0x6c/0x380
 [c004a668] __handle_mm_fault+0xe0/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S10sysklogd', page c0430380)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0049fe0] do_anonymous_page+0x74/0x1b8
 [c004a190] do_no_page+0x6c/0x380
 [c004a668] __handle_mm_fault+0xe0/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S10sysklogd', page c04303a0)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0049600] do_wp_page+0x310/0x3cc
 [c004a6dc] __handle_mm_fault+0x154/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S10sysklogd', page c04303c0)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0049fe0] do_anonymous_page+0x74/0x1b8
 [c004a190] do_no_page+0x6c/0x380
 [c004a668] __handle_mm_fault+0xe0/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'kjournald', page c04303e0)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0039480] find_or_create_page+0xf4/0x108
 [c005c4d8] grow_dev_page+0x30/0x184
 [c005c6c8] __getblk_slow+0x9c/0x15c
 [c005cbd0] __getblk+0x54/0x5c
 [c00b2ea0] journal_get_descriptor_buffer+0x3c/0xa8
 [c00b005c] journal_commit_transaction+0xb88/0xea8
 [c00b2608] kjournald+0xc8/0x1bc
 [c0006cc4] kernel_thread+0x44/0x60
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S10sysklogd', page c0430400)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0049fe0] do_anonymous_page+0x74/0x1b8
 [c004a190] do_no_page+0x6c/0x380
 [c004a668] __handle_mm_fault+0xe0/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'kjournald', page c0430420)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0039480] find_or_create_page+0xf4/0x108
 [c005c4d8] grow_dev_page+0x30/0x184
 [c005c6c8] __getblk_slow+0x9c/0x15c
 [c005cbd0] __getblk+0x54/0x5c
 [c00b2ea0] journal_get_descriptor_buffer+0x3c/0xa8
 [c00af38c] journal_write_commit_record+0x48/0x190
 [c00af9dc] journal_commit_transaction+0x508/0xea8
 [c00b2608] kjournald+0xc8/0x1bc
 [c0006cc4] kernel_thread+0x44/0x60
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S10sysklogd', page c0430440)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0049fe0] do_anonymous_page+0x74/0x1b8
 [c004a190] do_no_page+0x6c/0x380
 [c004a668] __handle_mm_fault+0xe0/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S10sysklogd', page c0430460)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0049fe0] do_anonymous_page+0x74/0x1b8
 [c004a190] do_no_page+0x6c/0x380
 [c004a668] __handle_mm_fault+0xe0/0x160
 [c000e4b8] do_page_fault+0x140/0x39c
 [c0004780] handle_page_fault+0xc/0x80
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'S10sysklogd', page c0430480)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c000ef48] pte_alloc_one+0x24/0x64
 [c00480b0] pte_alloc_map+0x58/0xb0
 [c00481d4] copy_pte_range+0x44/0x230
 [c004847c] copy_page_range+0xbc/0x118
 [c001590c] copy_mm+0x264/0x388
 [c0016258] copy_process+0x3c4/0xb8c
 [c0016b3c] do_fork+0x6c/0x1cc
 [c0007350] sys_fork+0x4c/0x68
 [c00042a0] ret_from_syscall+0x0/0x44
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'start-stop-daem', page c0430620)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0040c44] __do_page_cache_readahead+0x130/0x168
 [c0040e20] blockable_page_cache_readahead+0x64/0xdc
 [c00410b0] page_cache_readahead+0x140/0x1a4
 [c0039c88] do_generic_mapping_read+0x574/0x57c
 [c0039f84] __generic_file_aio_read+0x1ec/0x220
 [c0039ff4] generic_file_aio_read+0x3c/0x5c
 [c005978c] do_sync_read+0xb8/0x10c
 [c00598a8] vfs_read+0xc8/0x1a0
 [c0065bec] kernel_read+0x40/0x58
 [c0066b1c] do_execve+0xe4/0x220
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'start-stop-daem', page c0430640)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0040c44] __do_page_cache_readahead+0x130/0x168
 [c0040e20] blockable_page_cache_readahead+0x64/0xdc
 [c00410b0] page_cache_readahead+0x140/0x1a4
 [c0039c88] do_generic_mapping_read+0x574/0x57c
 [c0039f84] __generic_file_aio_read+0x1ec/0x220
 [c0039ff4] generic_file_aio_read+0x3c/0x5c
 [c005978c] do_sync_read+0xb8/0x10c
 [c00598a8] vfs_read+0xc8/0x1a0
 [c0065bec] kernel_read+0x40/0x58
 [c0066b1c] do_execve+0xe4/0x220
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'start-stop-daem', page c0430660)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0040c44] __do_page_cache_readahead+0x130/0x168
 [c0040e20] blockable_page_cache_readahead+0x64/0xdc
 [c00410b0] page_cache_readahead+0x140/0x1a4
 [c0039c88] do_generic_mapping_read+0x574/0x57c
 [c0039f84] __generic_file_aio_read+0x1ec/0x220
 [c0039ff4] generic_file_aio_read+0x3c/0x5c
 [c005978c] do_sync_read+0xb8/0x10c
 [c00598a8] vfs_read+0xc8/0x1a0
 [c0065bec] kernel_read+0x40/0x58
 [c0066b1c] do_execve+0xe4/0x220
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'start-stop-daem', page c0430680)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0040c44] __do_page_cache_readahead+0x130/0x168
 [c0040e20] <7>eth0: no IPv6 routers present
blockable_page_cache_readahead+0x64/0xdc
 [c00410b0] page_cache_readahead+0x140/0x1a4
 [c0039c88] do_generic_mapping_read+0x574/0x57c
 [c0039f84] __generic_file_aio_read+0x1ec/0x220
 [c0039ff4] generic_file_aio_read+0x3c/0x5c
 [c005978c] do_sync_read+0xb8/0x10c
 [c00598a8] vfs_read+0xc8/0x1a0
 [c0065bec] kernel_read+0x40/0x58
 [c0066b1c] do_execve+0xe4/0x220
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'start-stop-daem', page c04306a0)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc
 [c003d91c] prep_new_page+0x54/0xa0
 [c003dd90] buffered_rmqueue+0xfc/0x1bc
 [c003e318] __alloc_pages+0x408/0x42c
 [c0040c44] __do_page_cache_readahead+0x130/0x168
 [c0040e20] blockable_page_cache_readahead+0x64/0xdc
 [c00410b0] page_cache_readahead+0x140/0x1a4
 [c0039c88] do_generic_mapping_read+0x574/0x57c
 [c0039f84] __generic_file_aio_read+0x1ec/0x220
 [c0039ff4] generic_file_aio_read+0x3c/0x5c
 [c005978c] do_sync_read+0xb8/0x10c
 [c00598a8] vfs_read+0xc8/0x1a0
 [c0065bec] kernel_read+0x40/0x58
 [c0066b1c] do_execve+0xe4/0x220
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'start-stop-daem', page c04306c0)
flags:0x00000000 mapping:00000000 mapcount:1 count:1
Backtrace:
Call trace:
 [c0007494] dump_stack+0x18/0x28
 [c003d53c] bad_page+0x64/0xbc

--=-=-=


-- 
And if you don't know where you're going, any road will take you there...

--=-=-=--
