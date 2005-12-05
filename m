Return-Path: <jaap.dejong@nedap.com>
Received: from smtp2.nedap.com (smtp2.nedap.com [213.160.213.92])
	by ozlabs.org (Postfix) with ESMTP id 57BF968863
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Dec 2005 18:35:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 5 Dec 2005 08:35:42 +0100
Message-ID: <6915D0AE8B9047438F320B466AE30FDD324CD6@nvs0003.nedap.local>
From: "Jaap de Jong" <jaap.dejong@nedap.com>
To: "T Ziomek" <ctz001@email.mot.com>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: RE: Xilinx_uartlite
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Tom,

> Well, I never see that exact text, plus it's hard to tell much from
such a short snippet. =20
> Could you provide a more complete transcript of your console output?

This is the output:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~
loaded at:     00400000 004C91E0
board data at: 004C6138 004C6150
relocated to:  004052D4 004052EC
zimage at:     004057F4 00453621
initrd at:     00454000 004C5747
avail ram:     004CA000 02000000

Linux/PPC load: root=3D/dev/ram
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.20_mvl31-ml300 (jdj@jdj) (gcc version 3.3.3 (DENX ELDK
3.1.1 3
.3.3-10)) #25 Fri Dec 2 16:04:56 UTC 2005
Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc.
(source@mvista.com)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/ram
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
Calibrating delay loop... 299.00 BogoMIPS
Memory: 31112k available (556k kernel code, 216k data, 36k init, 0k
highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
LSP Revision 22
ikconfig 0.5 with /proc/ikconfig
Starting kswapd
Disabling the Out Of Memory Killer
pty: 256 Unix98 ptys configured
xgpio #0 at 0x40000000 mapped to 0xC3000000
xgpio #1 at 0x40020000 mapped to 0xC3011000
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 453k freed
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 36k init
Warning: unable to open an initial
console.~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~

And there it stops.=20
I'm affraid it is related to something else though.
Sometimes it ends in:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~
EXT2-fs error (device ramdisk(1,0)): ext2_check_page: bad entry in
directory #12
: rec_len is smaller than minimal - offset=3D1024, inode=3D0, =
rec_len=3D0,
name_len=3D0
Kernel panic: No init found.  Try passing init=3D option to kernel.
 <0>Rebooting in 180 seconds..
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~

After a rebuild without any changes to my rootfilesystem!
How I make my image:

    dd if=3D/dev/zero of=3Dramdisk.image bs=3D1k count=3D4096
    mkfs.ext2 -F ramdisk.image
    mount -o loop ramdisk.image mnt

    sync; sync; sync; sync; sync; sync
    umount mnt
    fsck.ext2 -p ramdisk.image
    gzip -9 ramdisk.image

    make zImage.initrd


Somtimes it starts up till here:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~
init started:  BusyBox v0.60.5 (2005.12.01-00:25+0000) multi-call binary

Please press Enter to activate this console.


BusyBox v0.60.5 (2005.12.01-00:25+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

sh: can't access tty; job control turned off
# ls -l
Please press Enter to activate this
console.~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~

But even then things are not good...

So you can think of corruption of the rootfs but everytime i have
checked it
on my linux system and nothing is wrong.=20
So perhaps my memory is corrupt? Memory test do not reveal this.
If you have any hints or ideas, please share them!!

Best regards,
	Jaap.




-----Oorspronkelijk bericht-----
Van: T Ziomek [mailto:ctz001@email.mot.com]=20
Verzonden: zaterdag 3 december 2005 02:03
Aan: Jaap de Jong
CC: linuxppc-embedded
Onderwerp: RE: Xilinx_uartlite

On Thu, 1 Dec 2005, Jaap de Jong wrote:
>
> Thanks for your reply, but then I only get:
> 	Now booting the kernel

Well, I never see that exact text, plus it's hard to tell much from such
a short snippet.  Could you provide a more complete transcript of your
con- sole output?

--=20
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
