From: "maurie" <maurie@risc.sps.mot.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <maurie@risc.sps.mot.com>
Subject: Vga support with pci on sandpoint
Date: Tue, 7 Oct 2003 14:03:02 -0500
Message-ID: <000101c38d05$a234d470$9b7c520a@sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Linuxppc developers,

	I am attempting to get pci vga working on the sandpoint platform
using dink32 to start linux.  I have tried several S3 cards with no video
success.  The kernel has vga driver support for SIS and ATI support, but
these are classified as experimental and will not compile, undefined
externals for __floatsidf, __divdf3, __adddf3, __fixunsdfsi, __muldf3, and
__vmalloc.
	I have written dummy routies for these functions, compiled it
successfully,  and I can get linux to recognize it has an SIS 300 card, the
one I'm using, but it still does not work and in fact crashes if I use
XFree86, via startx.   My vmalloc code attempts to allocate space from an
array I have declared in the code space.  I have also attempted to allocate
code from video space at 0xb0000000, but this also crashes.
	Can anyone tell me what these functions do, and/or where I can get
the code for them?
	Has anyone succesfully used vga on a sandpoint, and if so, can I get
the code and and the model of the pci video card used?
	I'm also getting a timeout on the AT keyboard, however, it works
fine under dink32.
	I am using 2.4.21-rc1 kernel.
	these are  the messages I get.  The vmalloc and ivideo messages are
mine.

Oct  2 12:59:56 SPlinux syslogd 1.4.1: restart.
Oct  2 12:59:56 SPlinux syslog: syslogd startup succeeded
Oct  2 12:59:56 SPlinux syslog: klogd startup succeeded
Oct  2 12:59:56 SPlinux kernel: klogd 1.4.1, log source = /proc/kmsg
started. Oct  2 12:59:56 SPlinux kernel: Memory BAT mapping: BAT2=128Mb,
BAT3=0Mb,
residual: 0Mb
Oct  2 12:59:56 SPlinux kernel: Total memory = 128MB; using 256kB for hash
table (at c02c0000) Oct  2 12:59:56 SPlinux kernel: Linux version 2.4.21-rc1
(maurie@SPlinux.sps.mot.com) (gcc version 3.3) #112 Thu Oct 2 12:54:32 EDT
2003 Oct  2 12:59:56 SPlinux kernel: Motorola SPS Sandpoint Test Platform
Oct  2 12:59:56 SPlinux kernel: Port by MontaVista Software, Inc.
(source@mvista.com)
Oct  2 12:59:56 SPlinux kernel: On node 0 totalpages: 32768
Oct  2 12:59:56 SPlinux kernel: zone(0): 32768 pages.
Oct  2 12:59:56 SPlinux kernel: zone(1): 0 pages.
Oct  2 12:59:56 SPlinux kernel: zone(2): 0 pages.
Oct  2 12:59:56 SPlinux kernel: Kernel command line: root=/dev/hda3 Oct  2
12:59:57 SPlinux kernel: OpenPIC Version 1.2 (1 CPUs and 11 IRQ
sources) at fdfd0000
Oct  2 12:59:57 SPlinux kernel: OpenPIC timer frequency is 100.000000 MHz
Oct  2 12:59:57 SPlinux kernel: time_init: decrementer frequency = 24.359418
MHz Oct  2 12:59:57 SPlinux kernel: Console: colour dummy device 80x25 Oct
2 12:59:57 SPlinux kernel: Calibrating delay loop... 973.20 BogoMIPS Oct  2
12:59:57 SPlinux kernel: Memory: 126552k available (1816k kernel code, 784k
data, 108k init, 0k highmem) Oct  2 12:59:57 SPlinux kernel: Dentry cache
hash table entries: 16384
(order: 5, 131072 bytes)
Oct  2 12:59:57 SPlinux kernel: Inode cache hash table entries: 8192 (order:
4, 65536 bytes) Oct  2 12:59:57 SPlinux kernel: Mount cache hash table
entries: 512 (order: 0, 4096 bytes) Oct  2 12:59:57 SPlinux kernel:
Buffer-cache hash table entries: 8192
(order: 3, 32768 bytes)
Oct  2 12:59:57 SPlinux kernel: Page-cache hash table entries: 32768 (order:
5, 131072 bytes) Oct  2 12:59:57 SPlinux kernel: POSIX conformance testing
by UNIFIX Oct  2 12:59:57 SPlinux kernel: PCI: Probing PCI hardware Oct  2
12:59:57 SPlinux kernel: Linux NET4.0 for Linux 2.4 Oct  2 12:59:57 SPlinux
kernel: Based upon Swansea University Computer Society NET3.039 Oct  2
12:59:57 SPlinux kernel: Initializing RT netlink socket Oct  2 12:59:57
SPlinux kernel: Starting kswapd Oct  2 12:59:57 SPlinux portmap: portmap
startup succeeded Oct  2 12:59:57 SPlinux kernel: devfs: v1.12c (20020818)
Richard Gooch
(rgooch@atnf.csiro.au)
Oct  2 12:59:57 SPlinux kernel: devfs: boot_options: 0x0
Oct  2 12:59:57 SPlinux kernel: Installing knfsd (copyright (C) 1996
okir@monad.swb.de). Oct  2 12:59:57 SPlinux kernel: Calling vmalloc from
sishw_ext.pSR Oct  2 12:59:57 SPlinux kernel: In vmalloc,size = 10, counter
= 1 Oct  2 12:59:57 SPlinux kernel: In vmalloc,spacertn = c02976a4, spaceptr
= 0xc02976c8 Oct  2 12:59:57 SPlinux kernel: Calling vmalloc from
sishw_ext.pCR Oct  2 12:59:57 SPlinux kernel: In vmalloc,size = 10, counter
= 2 Oct  2 12:59:57 SPlinux kernel: In vmalloc,spacertn = c02976cc, spaceptr
= 0xc02976f0 Oct  2 12:59:57 SPlinux kernel: ivideo.video_base = 0xb0000000,
ivideo.video_size = 0x0 Oct  2 12:59:57 SPlinux kernel: sisfb: Fatal error:
Unable to reserve frame buffer memory Oct  2 12:59:57 SPlinux kernel: sisfb:
Is there another framebuffer driver active? Oct  2 12:59:57 SPlinux kernel:
Trying to vfree() bad address (c02976a4) Oct  2 12:59:57 SPlinux kernel:
Trying to vfree() bad address (c02976cc) Oct  2 12:59:57 SPlinux kernel:
vga16fb: mapped to 0xc9000000 Oct  2 12:59:57 SPlinux kernel: Console:
switching to colour frame buffer device 80x30 Oct  2 12:59:57 SPlinux
kernel: fb0: VGA16 VGA frame buffer device Oct  2 12:59:57 SPlinux kernel:
initialize_kbd: Keyboard reset failed, no ACK Oct  2 12:59:57 SPlinux
kernel: Detected PS/2 Mouse Port. Oct  2 12:59:57 SPlinux kernel: pty: 256
Unix98 ptys configured Oct  2 12:59:57 SPlinux kernel: Serial driver version
5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled Oct  2
12:59:57 SPlinux kernel: keyboard: Timeout - AT keyboard not
present?(ed)
Oct  2 12:59:57 SPlinux kernel: ttyS00 at 0xfe0003f8 (irq = 4) is a 16550A
Oct  2 12:59:57 SPlinux kernel: RAMDISK driver initialized: 16 RAM disks of
4096K size 1024 blocksize Oct  2 12:59:57 SPlinux kernel: loop: loaded (max
8 devices) [root@SPlinux log]#


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
