Subject: Re: MBX experiences
To: digbyt@acm.org
Date: Thu, 27 Jan 2000 11:08:29 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <200001261853.SAA07221@cthulhu.dircon.co.uk> from "Digby Tarvin" at Jan 26, 2000 06:53:08 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000127000830.099CDD4@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Digby Tarvin writes:
> I am new to this list, and am trying to get Linux going on a
> Motorola MBX821, and am hoping someone can give me an update on the
> state of the art in this area to save me doing too much re-invention.
>
> The following is a summary of where I have gotten so far, in case it is
> of any help/interest to anyone. I would welcome any suggestions from
> those that have gotten further or can see things that I am doing
> wrong.

Sounds like you've actually got quite a long way. In the hope that it helps,
I've included a copy of a HOWTO I've been putting together which you might
find helpful. I'd be interested in any feedback you had on it.

[ questions I can't answer snipped ]

> However I am still curious to know where the crt1.o, crti.o libc.o and crtn.o
> that were missing after my build from source of the compiler come from,
> so that I can have a cross compiler built completely from source....

They come from your C library, such as glibc. If you really want to rebuild
the ones from libc-1.99-8xx.tar.gz, I believe the sources are at
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/glibc-0.961212-1r.src.rpm

Regards,
Graham



Linux for PowerPC Embedded Systems HOWTO/FAQ
Graham Stoney
greyham@research.canon.com.au
Last updated: 25 January 1999.


Introduction

This document is an attempt to tell you what you need to know to use Linux on
an embedded PowerPC-based system, and is a distillation of the collective
wisdom from the linuxppc-embedded mailing list. Comments, feedback and
corrections to this document are most welcome; please send them to the address
above.

Much of the information here is in the form of references to the mailing list
archives. Follow the threads in the archive to get more information.

The most relevant net resources are:

The home page at: http://www.ppc.kernel.org/embedded.html
Introductory stuff.

The ftp site: ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/
Contains almost everything you'll need in terms of sources. Check it often.

The mailing list archives: http://lists.linuxppc.org/lists/linuxppc-embedded
Indespensible wisdom answering most questions already. Browse it!
You are encouraged to subscribe by following the [List Info] link at the bottom
of the page. However, please search the archives before asking questions.

General information about Linux for PowerPC: http://www.ppc.kernel.org/


CPU

Your first step is to pick the processor which most closely matches your I/O
requirements. Then see if you can find an off-the-shelf board which also most
closely matches what you need.

Motorola 7xx/8xx devices are all covered in the code on the ftp site.
For 4xx devices, see: http://www.lcse.umn.edu/~grant/Linux/
For 603e, see: ftp://vlab1.iram.es/pub/linux-2.2/


Target Hardware

There are many options including systems from Motorola and other parties. If
you're planning on building your own custom hardware, consider using one of
the off-the-shelf Single Board Computer systems listed below instead. You may
get by with just a custom daughter card, or may not need to do any hardware of
your own at all.

If you do end up with a full custom design, pick a board from one of the
following sources with the closest feature match to yours to kick start your
software development:

Embedded Planet: http://www.embeddedplanet.com/
For CLLF users, grab the kernel at:
ftp://mail.netx4.com/pub/cllf-2.2.13.tgz
Also, see:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199910/msg00055.html
CLLF-860T users should see:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/200001/msg00143.html

Bright Star Engineering: http://www.brightstareng.com/
Has an onboard FPGA for configuring hardware.
If using a 2.2.x kernel, see:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199912/msg00088.html

Motorola Computer Group:
http://www.mcg.mot.com/cfm/templates/product.cfm?PageID=217&ProductID=51&PageTypeID=1

TQComponents: http://www.tqs.de/HTM_Files/TQM8xx_Serie.htm
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199910/msg00088.html

Motorola Semiconductor Family Application Development System:
(Anyone have a URL for the Motorola FADS?)
Before you choose this one, see:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199909/msg00007.html
Nevertheless, it is possible. Do a search for 'FADS' in the archive for more.

Motorola PowerPlus SBC:
http://members.home.net/mmporter/linux/

MVME2600:
ftp://vlab1.iram.es/pub/linux-2.2/

Mention to the vendor that you want to run Linux on the board, and encourage
them to support it, perhaps by contracting one of the developers on the net to
do a port for integration into the main kernel development tree.


Host Development System

Embedded Linux's compelling advantage over other Embedded OS's is that your
development host and target are the same. While you could theoretically develop
your embedded Linux target system software on any host OS, Linux is the only
sensible choice. Even Cygwin/UWIN is likely to waste more of your time.

Using a PowerPC based development development host platform makes life easier,
since the same binaries will run on your host and target. However, if your
choice of host platform is restricted to non-PowerPC, cross compiling adds
some minor inconvenience, primarily in finding or building your own toolset.


Compiler Tools

Use the latest gcc (2.95.2) and binutils (2.9.1.0.25), unless you're on a
PowerPC based host and already have a working native toolset you can use.

For cross development, there is a crossgcc mailing list and FAQ to help you
out: http://www.objsw.com/CrossGCC/

Binaries are available for several host platforms at:
http://members.home.net/mmporter/linux/cross/

For pre-packaged scripts to build a PPC Cross Development Kit for MPC8xx, see:
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/CDK.tar.gz

For a guide to building the PowerPC/Linux cross compiler on a Sun host, see:
http://www.lcse.umn.edu/~grant/Linux/cross.html

If you're using gcc-2.95.2 with binutils-2.9.1.0.25, you'll need a minor change
to the gcc specs file regarding the linker emulation. Alternatively, use a
later binutils snapshot.

You may get a kickstart by purchasing Bright Star's SDK; comments:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199912/msg00075.html


Debugging

For help with decoding kernel panic messages, see:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199912/msg00090.html


BDM

BDM is way cool, especially if you are bringing up a custom board and don't
want to invest in an In Circuit Emulator. You should definitely include a BDM
connector on any custom hardware, and all off-the-shelf boards have it.
Unfortunately, it's not fully useful once the kernel is running though:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199909/msg00021.html

Fortunately, once the kernel is running you can run gdb native on the target
hardware provided you have enough RAM. It's worth providing extra RAM on some
of your development boards to allow this.

There are many sources of BDM tools:

Macraigor Systems: http://www.macraigor.com/
Currently only support Windoze platform, but say Linux support should be
available sometime in Q1 2000. Beware that the 1999 version of OCD Commander
silently truncates S-records longer than 20 bytes during download.

Build your own: http://cyclone.parad.ru/ppcdbm/

EST Corporation: http://www.estc.com/

(Anyone else used a BDM vendor's system with Embedded Linux?)


Runtime Library

The current release of glibc is very large for a traditional embedded system.
If your application requires only one or two user programs, you can statically
link them to avoid requiring the entire dynamic library. Another option is to
hand-strip the dynamic library to a bare minimum.

Building glibc:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199909/msg00000.html

After applying these mods, glibc-2.1.2 can be configured for cross-compiling
with:

    #!/bin/sh
    export PATH=/path/to/local/i686-pc-linux-gnu/bin:$PATH
    export CFLAGS="-msoft-float -O2 -DNDEBUG=1"
    export CC=powerpc-linux-gcc
    export AR=powerpc-linux-ar
    export RANLIB=powerpc-linux-ranlib
    configure --host=powerpc-linux --prefix=/path/to/local/powerpc-linux \
    --with-headers=/path/to/linux-2.2.13/include --enable-add-ons=linuxthreads \
    --with-gnu-as --with-gnu-ld --disable-sanity-checks --without-fp

There is also an attempt to produce a small glibc suitable for embedded
systems at:
http://lists.varesearch.com/lists/listinfo/sglibc

To cut down some of the bloat in glibc, apply the patches at:
http://lists.varesearch.com/archives/sglibc/1999-September/000007.html
ftp://ftp.valinux.com/pub/support/hjl/glibc/glibc-old_version.tar.gz

Older Linux libc's are often quite small. There is one on the ftp site.

newlib may be another option, although it does not currently run under Linux.


Threads

If you need multithreading, using POSIX threads will give your application
portability, even to non-Linux embedded systems. For example, they're
supported by EL/IX, eCos, RTEMs and virtually all desktop systems.

POSIX threads support is supplied with glibc2 as an add-on, enabled by
configuring with '--enable-add-ons=linuxthreads'.

It is also possible to build older (i.e. smaller) libc5 with LinuxThreads. See:
http://pauillac.inria.fr/~xleroy/linuxthreads/faq.html

LinuxThread support has yet to be integrated into the official gdb release,
which makes debugging difficult. The gdb in mbxroot.full.tgz does not support
threads directly, although you can 'attach' to the thread processes
individually.

The courageous can also call clone() directly.


Kernel

You have essentially two options here:
stable: ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/mpc8xx-2.2.13.tgz
development: ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/linux-2.3.18.tgz

You are probably best off using the stable version, unless you want to actively
participate in future development of Linux itself.


Root File System

Minimal and complete root file system images are available on the ftp site at:
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/mbxroot.min.tgz and
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/mbxroot.full.tgz

During development, the embedded system can NFS-mount its root file system
from your file sever to provide a complete diskless Linux system. The file
server need not be the same architecture as the embedded client. Answer "Y"
to the kernel configuration questions regarding NFS client and root filesystem
via NFS, and "make zImage". The embedded system will attempt to mount its
root file system from the server as "/tftpboot/<ipaddress>", where <ipaddress>
is it's IP address. Extract one of the 'mbxroot' images in this directory as
root on the server, and export the directory tree with an entry in
/etc/exports on the server, like:
    /tftpboot	(rw,no_root_squash)

If your system has a hard disk, you can start by using NFS then build a root
file system on the disk and boot from that.

If your system has no ethernet, you may want to start developing on a board
that does.


Initial Ramdisk: initrd

To get initial ramdisk to work in 2.2.x, you may require the kernel patch in:
    http://lists.linuxppc.org/listarcs/linuxppc-embedded/200001/msg00064.html

Initial ramdisk support is currently broken in the Linux 2.3 development tree.

To make a diskless system standalone, you need an initial ramdisk image
containing an ext2 filesystem to put in arch/ppc/mbxboot/ramdisk.image.gz.
Then, build with "make zImage.initrd" and the ramdisk image will be mounted as
the root filesystem at startup. An example ramdisk.image.gz is already
included in the 2.2.13 kernel source tarball at:
    ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/mpc8xx-2.2.13.tgz

You can also create your own on your development machine in a filesystem on
/dev/ram. Another approach is to use the loop device on your Linux development
host to mount the ramdisk image as a local filesystem, and then copy the files
you require into it. To allow users to mount the ramdisk.image on /mnt/loop
with "mount /mnt/loop", add this entry to your /etc/fstab:

/path/to/ramdisk.image	/mnt/loop	auto    user,noauto,rw,loop     0 0

Note that the minix file system code in Linux is not endian-independant, so
you can't build a minix file system image on an x86 machine and expect to read
it on a PowerPC machine. ext2 does not suffer from this problem.

For more info on building a root filesystem, see:
http://linuxdoc.org/HOWTO/Bootdisk-HOWTO-4.html


ROM Monitor

If you're using custom hardware, you may want a ROM monitor to help bring it
up. There are several available on the net:

8xxROM, derived from FADSROM; see:
http://www.s4l.de/powerpc.html

FADSROM:
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/fadsrom.tgz

DINK32:
http://www.mot.com/SPS/PowerPC/teksupport/tools/DINK32/VERSION12/dinkindex.htm


Boot Loading

If you're using custom hardware, or want to replace the ROM monitor on your
board, you'll need a boot loader. Some of this is board specific, but you can
assemble the bits from what's already available on the net:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199911/msg00034.html

The 'fadsrom' code on the ftp site also includes initialisation and loading:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199912/msg00045.html

For PreP and PowerPlus SBC's, see:
http://members.home.net/mmporter/linux/
http://members.home.net/mmporter/linux/linuxppc/preploader.tgz
http://members.home.net/mmporter/linux/linuxppc/bugboot-0.3.tar.gz


Floating Point

Most of the embedded PowerPC processors lack a floating point unit. If your
application has very intensive floating point requirements, you may need to
switch to fixed point or change tack on your target processor choice.

Floating point can be performed either by instruction emulation in the kernel,
or by compiling everything (including the runtime library) with -msoft-float.

See:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199911/msg00056.html

To add kernel math emulation to the 2.2.13 kernel, see:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199912/msg00017.html


Real Time Response

If your application requires a hard real time response with guaranteed low
latency, you may need to encapsulate the real time aspects in a device driver.
However, for many applications a soft real time user space thread is adequate,
particularly if you minimise kernel latency with the patches at:
http://www.redhat.com/~mingo/lowlatency-2.2.13-A1
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199912/msg00006.html


Flash Drivers

http://www.linux-mtd.infradead.org/doc2000.html


Watchdog

Using the on-chip watchdog to provide the basic "write kicked" /dev/watchdog
interface described in Documentation/watchdog.txt is problematic, because the
SYPCR register controlling it can only be written once after reset to both set
the timeout and enable the watchdog. Once enabled, the boot loader and kernel
must keep it from expiring up until the point where the user application opens
/dev/watchdog. Littering the generic kernel decompress and startup code with
watchdog kicks to do this isn't acceptable to other Linux users. Hence,
hardware watchdog support hasn't been implemented yet.

The general plan to solve this problem is described in:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199910/msg00026.html

You can probably use Linux's software watchdog in the mean time.


Other Useful Resources:

One man's in-depth porting report:
http://www.datessa.se/~leif/linux_860_report.doc

Matt Porter's Linux page:
http://members.home.net/mmporter/linux/

Solutions4Linux ADS/FADS 8xx:
http://www.solutions4linux.de/powerpc.htlm

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
