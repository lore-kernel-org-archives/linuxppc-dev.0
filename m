Message-ID: <38ED9676.A2FDA745@lanl.gov>
Date: Fri, 07 Apr 2000 02:04:06 -0600
From: Ben Sapp <bsapp@lanl.gov>
Reply-To: bsapp@lanl.gov
MIME-Version: 1.0
To: Kwansuk Kim <kskim@neowave.co.kr>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Is the ramdisk mounted?
References: <NEBBKFENMLEDKDHMEHPJIEOGCAAA.kskim@neowave.co.kr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have seen these errors before on an MVME2301.   My problem was caused
by not having the proper devices in /dev.  I had to add /dev/console and
/dev/ttyS0.  Output from my (working) machine:

 sh-2.03# ls -l /dev/console /dev/ttyS0
crw--w--w-   1 root     root       5,   1 Jul  8 07:19 /dev/console
crw--w--w-   1 root     root       4,  64 Apr 13 08:39 /dev/ttyS0

I also have to give the command boot option:

console=/dev/ttyS0

Now it works.   Good Luck.

Kwansuk Kim wrote:
>
> I just mounted the ramdisk with a warning.
>
> Is there any problem with unchecked fs? But I copied the image to host 'dd if=ramdisk.image of=/dev/ram' and I worked well. (It was given 2.2.13 kernel on linuxppc.org)
>
> Anyway, actual problem appeared at calling at init process. I saw the source and it seems if there is no init then the kernel calls /bin/sh.
>
> Of coarse, the shell is in the image, but the kernel couldn't find it.
>
> ---------------------------
>
> Now booting the kernel
> ttyS00 at 0x0380 is a SMC
> ttyS01 at 0x0100 is a SCC
> ttyS02 at 0x0200 is a SCC
> pty: 256 Unix98 ptys configured
> RAM disk driver initialized:  16 RAM disks of 4096K size
> eth0: CPM ENET Version 0.2, 00:01:c4:00:00:b1
> RAMDISK: Compressed image found at block 0
> EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 28k init
> Warning: unable to open an initial console.
> Kernel panic: No init found.  Try passing init= option to kernel.
> Rebooting in 180 seconds..
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
