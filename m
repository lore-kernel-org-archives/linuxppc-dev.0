Message-ID: <3B610FAB.DBD87F1C@xilinx.com>
Date: Thu, 26 Jul 2001 23:52:27 -0700
From: "Peter Ryser" <Peter.Ryser@xilinx.com>
MIME-Version: 1.0
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root=/dev/ram0
References: <3B607757.6D4BFE4A@seranoa.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Andy,

configure your kernel with
- ramdisk support
- ramdisk support as boot device
- extended fs 2 support


make a minimal ramdisk consisting of the files/directories
/linuxrc
/dev/console
where
/linuxrc is a copy of sash
/dev/console is created with: mknod /dev/console c 5 1

compress the ramdisk and move it to
linux/arch/ppc/boot/tree/ramdisk.image.gz

There are two different ways to set the kernel command line (eventually in
linux/arch/ppc/boot/tree/main.c)
- leave it empty (do it this way for a start)
- set it to: root=/dev/ram0 init=/linuxrc rw

Build the kernel: make zImage.initrd

Download the image and boot.

I hope this helps

- Peter

Andrew Dixon wrote:

> Hi All,
> I'm trying to mount a compressed ramdisk image on /dev/ram0 and run my
> root filesystem from there.  My problem is that when I try to boot I get
> the following error:
>
>     VFS: Cannot open root device "ram0" or 01:00
>     Please append a correct "root=" boot option
>
> earlier in the boot process the ram disks are recognized:
>
>     RAMDISK driver initialized: 16 RAM disks of 4096K size 1024
> blocksize
>
> I'm using kernel 2.4.5-pre3 from Ben H's source.
>
> Anyone know why the kernel isn't able to open /dev/ram0?
>
> Thanks,
> Andy
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
