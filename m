Date: Wed, 9 Jun 2004 14:12:30 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: "Kernel panic: No init found", 8xx board with linuxppc-2.5
Message-ID: <Pine.LNX.4.58.0406091404520.13339@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  in my ongoing quest to see how far i get in booting on my 8xx board with
the latest 2.5 tree, i was having trouble getting past the line:

  Serial: CPM driver $Revision: 0.01 $.

since all i really needed was my serial port as a console, i configured
the kernel, and deselected all of:

  Device drivers ->
    Character drivers ->
      Serial drivers ->
	NO 8250 stuff
	NO CPM2 stuff

and all i selected under "MPC8xx CPM options" was

  [*] Use UART

(not being a real hardware whiz, i may have selected a totally meaningless
set of options.  i'm quite willing to be chastised for being clueless
here.)

  after i built my new kernel and incorporated my long-time root
filesystem, i got:

Linux/PPC load: console=ttyS0,9600 rw root=/dev/ram0 init=/sbin/minit
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.7-rc3 (rpjday@localhost.localdomain) (gcc version 3.2.2
200304
On node 0 totalpages: 8192
  DMA zone: 8192 pages, LIFO batch:2
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: console=ttyS0,9600 rw root=/dev/ram0 init=/sbin/minit
PID hash table entries: 256 (order 8: 2048 bytes)
Decrementer Frequency = 187500000/60
Memory: 29840k available (744k kernel code, 204k data, 52k init, 0k
highmem)
Calibrating delay loop... 46.97 BogoMIPS
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 1563k freed
Linux NoNET1.0 for Linux 2.6
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Generic RTC Driver v1.07
RAMDISK driver initialized: 16 RAM disks of 6144K size 1024 blocksize
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 52k init
Kernel panic: No init found.  Try passing init= option to kernel.
 <0>Rebooting in 180 seconds..


  now this is puzzling since, once upon a time, i *did* get either init or
minit to at least start, but as we know, as soon as i hit user space,
things hung.

  so it's curious that the kernel can't even find minit (or init, or
/bin/sh, i tried all three).  i've checked the root filesystem that's
bundled with the ramdisk, and it seems fine.

  did my particular selection of kernel config options make a mess of
things?  as i said, once before, the kernel never had a problem finding
the init program.

rday


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
