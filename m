Return-Path: <krypton@ulrich-teichert.org>
Received: from arbas.nms.ulrich-teichert.org (i3ED64CEB.versanet.de
	[62.214.76.235]) by ozlabs.org (Postfix) with ESMTP id 5AF772BF10
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 06:42:42 +1100 (EST)
Message-Id: <200501031932.j03JWC4E013520@arbas.nms.ulrich-teichert.org>
To: leigh@solinno.co.uk (Leigh Brown)
Date: Mon, 3 Jan 2005 20:32:12 +0100 (MET)
In-Reply-To: <33304.82.10.231.190.1104771000.squirrel@82.10.231.190> from
	"Leigh Brown" at Jan 03, 2005 04:50:00 PM
From: Ulrich Teichert <krypton@ulrich-teichert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	mikemartin@linux.ca, debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

[del]
>> Linux/PPC load: console=ttyS0,9600 console=tty0
>
>*** This is the point you get 5 seconds to start editing the parameters.
>I guess if you specify root=/dev/ram0 or something then it will boot
>from the ramdisk, rather than trying to boot from /dev/sda3.

Right, now I can even boot over network:

0 > setenv load-base 1000000  ok
0 > setenv real-base c00000  ok
0 > boot net: 
LOAD: Waiting 60 seconds for Spanning Tree
BOOTP R = 1 BOOTP S = 1  
FILE: /tftpboot/wehrle/vmlinuz-prep.initrd
Load Addr=0x1000000 Max Size=0xf000000 
Packet Count = 100 [snipped the packet count lines]

loaded at:     01000400 01554FF4
relocated to:  00800000 00D54BF4
zimage at:     0080A94C 0093DC0A
initrd at:     0093E000 00D4AB7A
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/ram
Uncompressing Linux...done.
Now booting the kernel
Total memory = 256MB; using 512kB for hash table (at c0300000)
Linux version 2.6.8-powerpc (jens@yorick) (gcc version 3.3.4 (Debian 1:3.3.4-11)) #1 Sun Oct 3 13:22:21 CEST 2004
PReP architecture
IBM planar ID: 000000d5
MPIC at 0xfddc0000 (0x3ddc0000), length 0x00040000 mapped to 0xeffc0000
Built 1 zonelists
Kernel command line: console=ttyS0,9600 console=tty0 root=/dev/ram
OpenPIC Version 1.0 (4 CPUs and 16 IRQ sources) at effc0000
PID hash table entries: 2048 (order 11: 16384 bytes)
time_init: decrementer frequency = 16.618701 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 251648k available (1732k kernel code, 1060k data, 164k init, 0k highmem)
Calibrating delay loop... 397.31 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 4146k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
Setting PCI interrupts for a "IBM 43P-140 (Tiger1)"
PCI: Cannot allocate resource region 0 of device 0000:00:0b.0
PCI: Cannot allocate resource region 0 of device 0000:00:0c.0
PCI: Cannot allocate resource region 0 of device 0000:00:10.0
PCI: Cannot allocate resource region 0 of device 0000:00:12.0
Thermal assist unit not available
audit: initializing netlink socket (disabled)
audit(943920304.671:0): initialized
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
input: Macintosh mouse button emulation
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 164k init 60k pmac 4k chrp 8k openfirmware
NET: Registered protocol family 1

And that's it. Seems like the d-i doesn't know that it should use the
serial console. BTW, the instructions for booting PREP systems in the
debian installation manual aren't quite right, they are missing the
"net:" string. If the TFTP-server is setup right, the firmware can figure
out the rest, so giving the server IP, the name and the IP should not
be necessary and I would try `boot net:` first.

[del]
>It should never ask the console question again unless you change the
>config (plug in a mouse for example), unless your nvram battery is a
>bit flat of course!

This seems to be the case. But it really simplifies things, as I've never
been able to warm-boot anything ;-) Only a cold boot helps. Maybe Daniel
should remove the battery to reset things completely?

Anyway, without your site, Leigh, I would still have a big doorstop only,
thanks again,

CU,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Clé De Contact (Metal Urbain)
