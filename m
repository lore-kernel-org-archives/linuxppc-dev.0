Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17681.53490.705075.155580@cargo.ozlabs.ibm.com>
Date: Thu, 21 Sep 2006 09:38:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: First cut of "wrapper" program
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a prototype of a "wrapper" program which will take a kernel,
and optionally an initrd image and/or a device tree blob, and create a
bootable zImage.  My idea is that the Makefile in arch/powerpc/boot
will construct the files that this needs, then run it one or more
times to create whatever images are needed.

The type of zImage that is created is selected with the -p flag.  This
also specifies an extra object file to be linked in that will contain
the platform_init() function.  So for the xyzzy platform, we would
arrange for an xyzzy.o to be made in arch/powerpc/boot, and for the
wrapper to be invoked with "-p xyzzy".

Currently the wrapper uses the strip, objcopy and ld programs, which
need to be the powerpc cross-utilities if you are cross-building.  You
can use the -C flag to specify a prefix for these programs if
necessary.

It also uses several files which it gets from a data directory, which
is by default ./arch/powerpc/boot, but which can be changed with the
-D flag.  The files it needs from there are:

	a platform-specific object file (of.o for OF-based platforms)
	crt0.o
	empty.o
	wrapper.a
	zImage.lds
	zImage.coff.lds
	addnote
	hack-coff

Although this will start out in arch/powerpc/boot, my idea is that it
is a stand-alone thing that could be pulled out and built and used
quite independently of the kernel source tree.  For this reason I
really want to avoid using CONFIG_* symbols in the code.

Comments?

Paul.

#!/bin/sh

# Copyright (C) 2006 Paul Mackerras, IBM Corporation <paulus@samba.org>
# This program may be used under the terms of version 2 of the GNU
# General Public License.

# This script takes a kernel binary and optionally an initrd image
# and/or a device-tree blob, and creates a bootable zImage for a
# given platform.

# Options:
# -o zImage	specify output file
# -p platform	specify platform (links in $platform.o)
# -i initrd	specify initrd file
# -d devtree	specify device-tree blob
# -s tree.dts	specify device-tree source file (needs dts installed)
# -c		cache $kernel.strip.gz (use if present & newer, else make)
# -C prefix	specify command prefix for cross-building tools
#		(strip, objcopy, ld)
# -D dir	specify directory containing data files used by script
#		(default ./arch/powerpc/boot)
# -W dir	specify working directory for temporary files (default .)

# defaults
kernel=
ofile=zImage
platform=of
initrd=
dtb=
dts=
cacheit=

# cross-compilation prefix
CROSS=

# directory for object and other files used by this script
object=arch/powerpc/boot

# directory for working files
tmpdir=.

usage() {
    echo 'Usage: wrapper [-o output] [-p platform] [-i initrd]' >&2
    echo '       [-d devtree] [-s tree.dts] [-c] [-C cross-prefix]' >&2
    echo '       [-D datadir] [-W workingdir] [vmlinux]' >&2
    exit 1
}

while [ "$#" -gt 0 ]; do
    case "$1" in
    -o)
	shift
	[ "$#" -gt 0 ] || usage
	ofile="$1"
	;;
    -p)
	shift
	[ "$#" -gt 0 ] || usage
	platform="$1"
	;;
    -i)
	shift
	[ "$#" -gt 0 ] || usage
	initrd="$1"
	;;
    -d)
	shift
	[ "$#" -gt 0 ] || usage
	dtb="$1"
	;;
    -s)
	shift
	[ "$#" -gt 0 ] || usage
	dts="$1"
	;;
    -c)
	cacheit=y
	;;
    -C)
	shift
	[ "$#" -gt 0 ] || usage
	CROSS="$1"
	;;
    -D)
	shift
	[ "$#" -gt 0 ] || usage
	object="$1"
	;;
    -W)
	shift
	[ "$#" -gt 0 ] || usage
	tmpdir="$1"
	;;
    -?)
	usage
	;;
    *)
	[ -z "$kernel" ] || usage
	kernel="$1"
	;;
    esac
    shift
done

if [ -n "$dts" ]; then
    if [ -z "$dtb" ]; then
	dtb="$platform.dtb"
    fi
    dtc -O dtb -o "$dtb" -b 0 -V 16 "$dts" || exit 1
fi

if [ -z "$kernel" ]; then
    kernel=vmlinux
fi

platformo=$object/"$platform".o
lds=$object/zImage.lds

case "$platform" in
pmac|pseries)
    platformo=$object/of.o
    ;;
pmaccoff)
    platformo=$object/of.o
    lds=$object/zImage.coff.lds
    ;;
miboot)
    # this is quite different...
    tmpvm=$tmpdir/vmlinux.bin.$$
    ${CROSS}objcopy -O binary "$kernel" $tmpvm
    gzip -f -9 $tmpvm
    tmpir=
    if [ -n "$initrd" ]; then
	tmpir=--add-section=initrd="$initrd"
    fi
    ${CROSS}objcopy -O aixcoff-rs6000 -R .stab -R .stabstr -R .comment \
	--add-section=image=$tmpvm.gz $tmpir \
	$object/empty.o "$ofile"
    rm $tmpvm.gz
    exit 0
esac
	
tmp=$tmpdir/zImage.$$.o
cp $object/empty.o $tmp

addsec() {
    ${CROSS}objcopy $1 \
	--add-section=.kernel:$3="$2" \
	--set-section-flags=.kernel:$3=contents,alloc,load,readonly,data
}

if [ -n "$cacheit" ]; then
    vmz="$tmpdir/`basename \"$kernel\"`.strip"
    if [ ! -f "$vmz.gz" -o "$vmz.gz" -ot "$kernel" ]; then
	cp "$kernel" "$vmz"
	${CROSS}strip "$vmz"
	gzip -f -9 "$vmz"
    fi
    addsec $tmp "$vmz.gz" vmlinux.strip
else
    tmpvmz=$tmpdir/vmlinux.$$
    cp "$kernel" $tmpvmz
    ${CROSS}strip $tmpvmz
    gzip -f -9 $tmpvmz
    addsec $tmp $tmpvmz.gz vmlinux.strip
    rm $tmpvmz.gz
fi

if [ -n "$initrd" ]; then
    addsec $tmp "$initrd" initrd
fi

if [ -n "$dtb" ]; then
    addsec $tmp "$dtb" dtb
fi

${CROSS}ld -m elf32ppc -T $lds -o "$ofile" \
	$object/crt0.o $platformo $tmp $object/wrapper.a

rm $tmp

# post-processing needed for some platforms
case "$platform" in
pseries)
    $object/addnote "$ofile"
    ;;
pmaccoff)
    ${CROSS}objcopy -O aixcoff-rs6000 --set-start 0x500000 "$ofile"
    $object/hack-coff "$ofile"
    ;;
esac
