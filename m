Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <C08678384BE7D311B4D70004ACA371050B76351E@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Jerry Van Baren'" <vanbaren_gerald@si.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'laitingwai@yahoo.com'" <laitingwai@yahoo.com>
Subject: RE: Can I run linux without a file system?
Date: Fri, 21 Jun 2002 14:17:29 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


My filesystem is 5.7 MB uncompressed.  And, for me
(sorry Wolfgang!) I think that *is* minimal.  Well,
not "minimal" in the sense of "as small as humanly
possible", but at least "miniature" -- compared to
more than 1000 MB for my desktop Linux host.  Our board
isn't big: it has 16 MB of flash & 64 MB of RAM,
can serve up telnet sessions & web pages, etc., and
I'm nowhere close to filling up either the flash
or the RAM.  & if I did want to cut space, I'd use
a small libc (now, I use glibc which is over a meg).

<><><><><><><><><><><><><><><><><><><><><><><><><><>

Anyway, here are some notes about the mkramdisk script,
and then the script follows.

My host has a directory called /usr/local/xdev/export
(pointed to by $xroot).  When my PPC board uses NFS root
(i.e.  nfsroot=1.2.3.4:/usr/local/xdev/export on the kernel
command line), it mounts /usr/local/xdev/export.  When the
board is not uisng NFS root, I take that same directory and
essentially pack it into a RAM-disk image.  The script
below just does that packing.

This simple picture is complicated by a few details:

*	One doesn't just make a zip or .tgz file; rather,
	one must must make a filesystem structure per se,
	that Linux on the PPC board can mount.

*	I could bulk-copy (cp -R) from $xroot to the
	filesystem image, *but* you can't cp around the
	files in /dev.  The script below is hackish
	in that I list out all the subdirectories in
	$xroot except /dev and copy them, then populate
	/dev using the mkdevs script (included after
	mkramdisk).  (It would be more elegant to use find
	with grep -v /dev.)

Note that the script below doesn't selectively choose what
to put into the RAM disk; it just copies everything in
$xroot into the RAM disk image.  What do I put in $xroot?
Things I manually create there (e.g. using a text editor on
my desktop host); cross-compiled executables; library files
taken from my cross-tools directory.

Here is the script; it takes no arguments.  It is run in
arch/ppc/mebboot (or wherever appropriate for your kernel
rev) & writes ramdisk.image.gz right where the kernel
makefile expects to find it.  (It must be run as root; note
that nothing else in my build process needs to run as
root.) So, whenever I modify $xroot, I cd to
arch/ppc/mebboot, su, sh mkramdisk, exit, cd to kernel
source base (../../..), make zImage.initrd, TFTP that up to
the board.


================================================================

#!/bin/sh
# mkramdisk
# See the file Documentation/initrd.txt.
# John Kerl
# john.kerl@avnet.com
# Avnet Design Services
# 2002-04-22

if [ -z "$xroot" ]; then
	echo "Must set \$xroot first." 1>&2
	exit 1
fi
src=$xroot
scratch=/ramdisktmp
dst=ramdisk.image

block_size=1024
num_blocks=8192

# ================================================================
if [ -f $scratch ]; then
	echo "$scratch already exists.  Exiting." 1>&2
	exit 1
fi

mkdir $scratch
if [ $? -ne 0 ]; then
	echo "Could not make directory $scratch.  Exiting." 1>&2
	exit 1
fi

echo ">>> Making zero-filled image file $dst ... "
dd if=/dev/zero of=$dst bs=$block_size count=$num_blocks
echo ">>> done."
echo ""

# Make 8MB filesystem in RAM:
#mke2fs -b $block_size $dst $num_blocks
echo ">>> Making empty filesystem in image file ... "
mke2fs -F -m0 $dst
echo ">>> done."
echo ""

echo ">>> Mounting $dst's filesystem to $scratch ... "
mount -t ext2 -o loop $dst $scratch
echo ">>> done."
echo ""

# ================================================================
# Everything other than board's dev can be copied from $xroot.

echo ">>> Copying $src/bin to $scratch/bin ... "
cp -R $src/bin $scratch
echo ">>> done."
echo ""

echo ">>> Copying $src/etc to $scratch/etc ... "
cp -R $src/etc $scratch
echo ">>> done."
echo ""

echo ">>> Copying $src/lib to $scratch/lib ... "
cp -R $src/lib $scratch
echo ">>> done."
echo ""

echo ">>> Making directory $scratch/tmp ... "
mkdir $scratch/tmp
echo ">>> done."
echo ""

echo ">>> Copying $src/var to $scratch/var ... "
cp -R $src/var $scratch
echo ">>> done."
echo ""

echo ">>> Copying $src/\*.txt to $scratch ... "
cp -R $src/*.txt $scratch
echo ">>> done."
echo ""

echo ">>> Copying $src plain files to $scratch ... "
for x in $src/*
do
	if [ -f $x ];then
		echo "      Copying $x to $scratch."
		cp $x $scratch
	fi
done
echo ">>> done."
echo ""

echo ">>> Making empty directories $scratch/dev and $scratch/proc ... "
mkdir $scratch/dev
mkdir $scratch/proc # This will be the mount point for the procfs.
echo ">>> done."
echo ""

# ================================================================
# Create board's /dev.

echo ">>> Populating $scratch/dev with device nodes ... "

sh mkdevs $scratch/dev

echo ">>> done."
echo ""

# ================================================================
umount $scratch
rmdir  $scratch

echo ">>> Compressing $dst to $dst.gz ... "
gzip -f -9 $dst
echo ">>> done."
echo ""

echo ""
echo ">>> RAM disk complete."
echo ""



================================================================
And here is the mkdevs script.
================================================================

#! /bin/sh
# mkdevs
# John Kerl
# john.kerl@avnet.com
# Avnet Design Services
# 2002-04-22

# ----------------------------------------------------------------
usage() {
	echo "Usage: $0 {directory name} {num ttys}" 1>&2
	exit 1
}

# ----------------------------------------------------------------
if [ $# -ne 1 ]; then
	usage
fi
if [ ! -d $1 ]; then
	echo "$0:  $1 is not a directory." 1>&2
	exit 1
fi

devdir=$1

# Maximum number of simultaneous telnet sessions:
num_ttys=32

# ----------------------------------------------------------------
mknod $devdir/console c  5  1

mknod $devdir/tty     c  5  0
mknod $devdir/ttyS0   c  4 64

i=0
while [ $i -lt $num_ttys ]
do
	mknod $devdir/ptyp$i   c  2 $i
	mknod $devdir/ttyp$i   c  3 $i
	i=`expr $i + 1`
done

mknod $devdir/led0    c 42  0
mknod $devdir/led1    c 42  1
mknod $devdir/led2    c 42  2
mknod $devdir/led3    c 42  3
mknod $devdir/led4    c 42  4
mknod $devdir/led5    c 42  5
mknod $devdir/led6    c 42  6
mknod $devdir/led7    c 42  7

mknod $devdir/mem     c  1  1
mknod $devdir/null    c  1  3
mknod $devdir/zero    c  1  5

mknod $devdir/ram0    b  1  0
mknod $devdir/ram1    b  1  1
ln -s $devdir/ram1 $devdir/ram


-----Original Message-----
From: Kerl, John
Sent: Friday, June 21, 2002 1:42 PM
To: 'Jerry Van Baren'; linuxppc-embedded@lists.linuxppc.org
Subject: RE: Can I run linux without a file system?


It's not *that* bad, is it? ;)

I have to admit I stumbled around for a while before
I got it right, but I do have a shell script for making
a RAM disk image, and I use it all the time.  Is anyone
interested in a copy?

-----Original Message-----
From: Jerry Van Baren [mailto:vanbaren_gerald@si.com]
Sent: Friday, June 21, 2002 1:12 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can I run linux without a file system?



You need at least a RAM file system for "/" and a bunch of subdirectories
such as /dev, /lib, etc.  The common way to do this on a minimalistic
system is to create a file system image in ROM (often compressed) and copy
it to RAM on start up.  Given the questions you are asking, I am very
confident creating a minimal RAM disk image will challenge you sufficiently
:-).  I'm not being snide, lots of people with lots of linux knowledge have
tried and failed.  Most people use someone else's pre-configured minimal
file systems and add/subtract (mostly add :-) programs to it.  This is
because it is very, very hard to create a minimal file system (that works,
that is).

Pointers to development systems with example RAM disk images:
   http://www.denx.de/solutions-en.html
     ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/
   http://www.mvista.com/
   (there are others, I'm just too lazy to do the google search for you)

Trying to run linux without a file system of any sort would require you to
rewrite of pretty much everything and the three or four things you didn't
rewrite, you would have to rebuild (static link, no shared
libraries).  There are a lot of software engineers and hackers that would
turn down the opportunity to do this at any price.  On the other hand, a
lot of naivety and a even more coffee sometimes generates remarkable
results :-).

You really want to look at eCOS or one of the other light weight tasking
OSs.
   http://www.redhat.com/embedded/technologies/ecos/

gvb


At 12:42 PM 6/21/2002 -0700, Tim Lai wrote:

>I am interested in both input/output operation
>on the console. If I just set CONFIG_SERIAL_CONSOLE,
>will I be able read input from the console?
>The main application will be started from init(),
>and the application will need to read and write
>to the console. Are there are method to communicate
>to the serial port other than open("/dev/ttyS0")?
>
>
> >
> > You don't need a filesystem to get output on the
> > serial console
> > you just need to enable the console with
> > CONFIG_SERIAL_CONSOLE=y
> > in your kernel configuration (atleast for mpc860
> > that all)
> > but you will have a hard time producing much more
> > than a blinking
> > cursor if you boot a Linux kernel and have no
> > application that
> > it then can run on the root-filesystem - what would
> > be the point
> > of such a setup - 1MB kernel code for a blinking
> > cursor on a
> > serial port seems expensive.
> >
> > hofrat
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
