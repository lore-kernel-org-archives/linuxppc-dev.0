Return-Path: <krypton@ulrich-teichert.org>
Received: from arbas.nms.ulrich-teichert.org (i3ED653C6.versanet.de
	[62.214.83.198]) by ozlabs.org (Postfix) with ESMTP id 1404E2BF07
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 02:54:42 +1100 (EST)
Message-Id: <200501031551.j03FpLAn009525@arbas.nms.ulrich-teichert.org>
To: mikemartin@linux.ca
Date: Mon, 3 Jan 2005 16:51:21 +0100 (MET)
In-Reply-To: <855e88d0050103053915c385ec@mail.gmail.com> from "Mike Martin" at
	Jan 03, 2005 08:39:43 AM
From: Ulrich Teichert <krypton@ulrich-teichert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org
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

>[snip]
>> There may be some problems with 2.6 kernels and pci irqs on prep. I will
>> investigate this shortly.
>
>There is definitely something strange happening. The image I used to
>do the (nearly) complete install will no longer configure the network.
>Very inconsistent. I will try it (same image) again later today and
>see if it "just works" next time - like it did last time.

Yes, I've seen inconsistencies as well, like booting the default kernel
from a sarge CD worked *once* and rebooting not. I found out why:
during the first cold boot, the firmware asks if it should make my
serial console the active console (which I acknowledged), but with a
warm boot, this question is not asked again.

This seems to result in a different setting and the kernel is not able
to figure out that it is running on a serial console. According to Leigh
Browns, it is not possible to give the kernel parameters on boot-up, unless
you are using his patches, so this may be another issue.

But this is how far the default kernel (which is all I can load from CD)
boots:

0 > setenv load-base 1000000  ok
0 > setenv real-base c00000  ok
0 > boot cdrom: 

loaded at:     01000400 01492FF4
relocated to:  00800000 00C92BF4
zimage at:     0080A94C 0093E3DC
initrd at:     0093F000 00C884AE
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 console=tty0
Uncompressing Linux...done.
Now booting the kernel
Total memory = 256MB; using 512kB for hash table (at c0300000)
Linux version 2.6.8-powerpc (sven@pegasos2) (version gcc 3.3.5 (Debian 1:3.3.5-2)) #1 Thu Dec 9 10:27:54 CET 2004
PReP architecture
IBM planar ID: 000000d5
MPIC at 0xfddc0000 (0x3ddc0000), length 0x00040000 mapped to 0xeffc0000
Built 1 zonelists
Kernel command line: console=ttyS0,9600 console=tty0
OpenPIC Version 1.0 (4 CPUs and 16 IRQ sources) at effc0000
PID hash table entries: 2048 (order 11: 16384 bytes)
time_init: decrementer frequency = 16.618715 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 252416k available (1732k kernel code, 1060k data, 164k init, 0k highmem)
Calibrating delay loop... 397.31 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 3365k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
Setting PCI interrupts for a "IBM 43P-140 (Tiger1)"
PCI: Cannot allocate resource region 0 of device 0000:00:0b.0
PCI: Cannot allocate resource region 0 of device 0000:00:0c.0
PCI: Cannot allocate resource region 0 of device 0000:00:10.0
PCI: Cannot allocate resource region 0 of device 0000:00:12.0
Thermal assist unit not available
audit: initializing netlink socket (disabled)
audit(943920606.514:0): initialized
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
VFS: Cannot open root device "<NULL>" or unknown-block(8,3)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(8,3)
 <0>Rebooting in 180 seconds..

[del]
>> Then i suppose that copying the kernel is just a matter of :
>> 
>>   dd if=/boot/vmlinuz-2.6.8-powerpc of=/dev/sdb1
>> 
>> but you have to have a small prep partition as /dev/sdb1, or the above will
>> erase whatever you have on /dev/sdb1.

This is not enough. You need to set the kernel arguments with Leigh's
preptool (which is a simple perl script), because of the problems mentioned
before.

>I' have the partition ready ...
>
>Unfortunately, until the network comes back up, I can't get far enough
>in the install to access the SCSI drives (is there another way? Load
>the modules by hand? Which ones?). Without this, I can't get at the
>image I need to boot in order to get it onto the right partition. I
>also can't get it to another machine to net boot it.

All this initrd thing is a mess when it gets complicated, if you ask me.
I really don't know why your floppy stops working after booting Leighs
kernel. But on the other hand, I don't know why I can't netboot my box
either - I can netboot anything else from DECstations to SGIs with the
same setup, but my 7043-44 refuses to load the kernel. It contacts the
server, figures out the name of the file, but does not request it.

For your network trouble, try to disconnect power from the box completely
for an hour or so. This was enough for my box to fall back to asking me
for the active console, maybe this works for your flaky network as well?

HTH,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Clé De Contact (Metal Urbain)
