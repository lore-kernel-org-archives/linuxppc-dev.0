Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 7A73D1007D2
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Dec 2009 09:57:54 +1100 (EST)
Received: by yxe8 with SMTP id 8so13087452yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Dec 2009 14:57:52 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1261446643-21714-3-git-send-email-ptyser@xes-inc.com>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-3-git-send-email-ptyser@xes-inc.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 30 Dec 2009 15:57:32 -0700
Message-ID: <fa686aa40912301457l704c324bk511a207d07218525@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] powerpc: Add support for creating FIT uImages
To: Peter Tyser <ptyser@xes-inc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 21, 2009 at 6:50 PM, Peter Tyser <ptyser@xes-inc.com> wrote:
> Recent U-Boot versions support booting a Flattened Image Tree (FIT)
> image format. =A0The FIT uImage format uses a tree structure to describe =
a
> kernel image as well as supporting device tree blobs, ramdisks, etc.
> The 'mkimage' and 'dtc' utilities convert this tree description into a
> binary blob that bootloaders such as U-Boot can execute.
>
> This patch adds support for automatically creating a U-Boot FIT image
> using the "make uImage.fit.<boardname>" command where <boardname> is
> one of arch/powerpc/boot/dts/<boardname>.dts. =A0The resulting
> arch/powerpc/boot/uImage.fit.<boardname> file will contain a kernel
> image as well as a device tree blob. =A0U-Boot versions compiled with FIT
> support can directly boot this image using the "bootm" command.
>
> Additional information about the FIT format and its uses can be found in
> doc/uImage.FIT/howto.txt of U-Boot's source tree.
>
> Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
> ---
> Changes since v1:
> - Add 'dts-v1' header to scripts/mkits.sh output
> - Don't strip leading 0x from dts addresses
> - Default to using kernel dtc if the user doesn't have it in their path

I think I need to NAK this one.  As it is, the wrapper script is a
moderately complex thing, but it has to do a non-trivial job: create a
custom linked executable that sets up the environment that the kernel
expects.  zImage.* wrappers uncompress the kernel, dtbImage.* wrappers
also contain a .dtb image.  cuImage.* wrappers adapt to the old u-boot
interface, etc.

Unfortunately, the wrapper script is also being used to do things that
are completely unrelated to creating wrapper binaries.  FIT images
(and uImages) don't use any of the wrapper bits at all.  In fact, as
seen in this patch, generating them involves bailing out of the
wrapper script early to avoid linking the wrapper bits.  I think for
all types of uImages, the wrapper script is being misused and I don't
like the extra complexity that it adds.

Rather than adding new paths to arch/powerpc/boot/wrapper, I would
rather see a new script used for generating FIT image that isn't
complicated by all the current wrapper cruft.  Also, the Makefile rule
doesn't need to depend on $(wrapperbits) which means faster build
times when only building uImages.

Bonus points if you also convert the uImage target to use the new
script; but I'm not demanding that you do that yet.

Finally, you need to add documentation about the new target to
Documentation/powerpc/bootwrapper.txt.

g.

> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index bb2465b..e56ec21 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -310,6 +310,9 @@ $(obj)/zImage.iseries: vmlinux
> =A0$(obj)/uImage: vmlinux $(wrapperbits)
> =A0 =A0 =A0 =A0$(call if_changed,wrap,uboot)
>
> +$(obj)/uImage.fit.%: vmlinux $(obj)/%.dtb $(wrapperbits)
> + =A0 =A0 =A0 $(call if_changed,wrap,uboot.fit,,$(obj)/$*.dtb)
> +
> =A0$(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
> =A0 =A0 =A0 =A0$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb,$(obj)/ram=
disk.image.gz)
>
> @@ -349,7 +352,7 @@ install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y)=
)
>
> =A0# anything not in $(targets)
> =A0clean-files +=3D $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.*=
 \
> - =A0 =A0 =A0 zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
> + =A0 =A0 =A0 uImage.* zImage zImage.initrd zImage.chrp zImage.coff zImag=
e.holly \
> =A0 =A0 =A0 =A0zImage.iseries zImage.miboot zImage.pmac zImage.pseries \
> =A0 =A0 =A0 =A0simpleImage.* otheros.bld *.dtb
>
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index f4594ed..1f35b66 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -46,6 +46,9 @@ CROSS=3D
> =A0# mkimage wrapper script
> =A0MKIMAGE=3D$srctree/scripts/mkuboot.sh
>
> +# script to generate an .its file for uImage.fit.* images
> +MKITS=3D$srctree/scripts/mkits.sh
> +
> =A0# directory for object and other files used by this script
> =A0object=3Darch/powerpc/boot
> =A0objbin=3D$object
> @@ -157,7 +160,7 @@ coff)
> =A0 =A0 lds=3D$object/zImage.coff.lds
> =A0 =A0 link_address=3D'0x500000'
> =A0 =A0 ;;
> -miboot|uboot)
> +miboot|uboot|uboot.fit)
> =A0 =A0 # miboot and U-boot want just the bare bits, not an ELF binary
> =A0 =A0 ext=3Dbin
> =A0 =A0 objflags=3D"-O binary"
> @@ -277,6 +280,21 @@ uboot)
> =A0 =A0 fi
> =A0 =A0 exit 0
> =A0 =A0 ;;
> +uboot.fit)
> + =A0 =A0rm -f "$ofile"
> + =A0 =A0${MKITS} -A ppc -C gzip -a $membase -e $membase -v $version \
> + =A0 =A0 =A0 -d "$srctree/$dtb" -k "$srctree/$vmz" -o "$object/uImage.it=
s"
> +
> + =A0 =A0# mkimage calls dtc for FIT images so use kernel dtc if necessar=
y
> + =A0 =A0export PATH=3D$PATH:$srctree/scripts/dtc
> +
> + =A0 =A0${MKIMAGE} -f "$object/uImage.its" "$ofile"
> + =A0 =A0rm "$object/uImage.its"
> + =A0 =A0if [ -z "$cacheit" ]; then
> + =A0 =A0 =A0 rm -f "$vmz"
> + =A0 =A0fi
> + =A0 =A0exit 0
> + =A0 =A0;;
> =A0esac
>
> =A0addsec() {
> diff --git a/scripts/mkits.sh b/scripts/mkits.sh
> new file mode 100755
> index 0000000..fae43dd
> --- /dev/null
> +++ b/scripts/mkits.sh
> @@ -0,0 +1,111 @@
> +#!/bin/bash
> +#
> +# Licensed under the terms of the GNU GPL License version 2 or later.
> +#
> +# Author: Peter Tyser <ptyser@xes-inc.com>
> +#
> +# U-Boot firmware supports the booting of images in the Flattened Image
> +# Tree (FIT) format. =A0The FIT format uses a device tree structure to
> +# describe a kernel image, device tree blob, ramdisk, etc. =A0This scrip=
t
> +# creates an Image Tree Source (.its file) which can be passed to the
> +# 'mkimage' utility to generate an Image Tree Blob (.itb file). =A0The .=
itb
> +# file can then be booted by U-Boot (or other bootloaders which support
> +# FIT images). =A0See doc/uImage.FIT/howto.txt in U-Boot source code for
> +# additional information on FIT images.
> +#
> +
> +usage() {
> + =A0 =A0 =A0 echo "Usage: `basename $0` -A arch -C comp -a addr -e entry=
" \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "-v version -k kernel [-d dtb] -o its_file"
> + =A0 =A0 =A0 echo -e "\t-A =3D=3D> set architecture to 'arch'"
> + =A0 =A0 =A0 echo -e "\t-C =3D=3D> set compression type 'comp'"
> + =A0 =A0 =A0 echo -e "\t-a =3D=3D> set load address to 'addr' (hex)"
> + =A0 =A0 =A0 echo -e "\t-e =3D=3D> set entry point to 'entry' (hex)"
> + =A0 =A0 =A0 echo -e "\t-v =3D=3D> set kernel version to 'version'"
> + =A0 =A0 =A0 echo -e "\t-k =3D=3D> include kernel image 'kernel'"
> + =A0 =A0 =A0 echo -e "\t-d =3D=3D> include Device Tree Blob 'dtb'"
> + =A0 =A0 =A0 echo -e "\t-o =3D=3D> create output file 'its_file'"
> + =A0 =A0 =A0 exit 1
> +}
> +
> +while getopts ":A:C:a:d:e:k:o:v:" OPTION
> +do
> + =A0 =A0 =A0 case $OPTION in
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 A ) ARCH=3D$OPTARG;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 C ) COMPRESS=3D$OPTARG;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 a ) LOAD_ADDR=3D$OPTARG;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 d ) DTB=3D$OPTARG;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 e ) ENTRY_ADDR=3D$OPTARG;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 k ) KERNEL=3D$OPTARG;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 o ) OUTPUT=3D$OPTARG;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 v ) VERSION=3D$OPTARG;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 * ) echo "Invalid option passed to '$0' (op=
tions:$@)"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usage;;
> + =A0 =A0 =A0 esac
> +done
> +
> +# Make sure user entered all required parameters
> +if [ -z "${ARCH}" ] || [ -z "${COMPRESS}" ] || [ -z "${LOAD_ADDR}" ] || =
\
> + =A0 =A0 =A0 [ -z "${ENTRY_ADDR}" ] || [ -z "${VERSION}" ] || [ -z "${KE=
RNEL}" ] || \
> + =A0 =A0 =A0 [ -z "${OUTPUT}" ]; then
> + =A0 =A0 =A0 usage
> +fi
> +
> +# Create a default, fully populated DTS file
> +DATA=3D"/dts-v1/;
> +
> +/ {
> + =A0 =A0 =A0 description =3D \"Linux kernel ${VERSION}\";
> + =A0 =A0 =A0 #address-cells =3D <1>;
> +
> + =A0 =A0 =A0 images {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kernel@1 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 description =3D \"Linux Ker=
nel ${VERSION}\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D /incbin/(\"${KERNE=
L}\");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type =3D \"kernel\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 arch =3D \"${ARCH}\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 os =3D \"linux\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compression =3D \"${COMPRES=
S}\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 load =3D <${LOAD_ADDR}>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 entry =3D <${ENTRY_ADDR}>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hash@1 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 algo =3D \"=
crc32\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hash@2 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 algo =3D \"=
sha1\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdt@1 { /* start fdt */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 description =3D \"Flattened=
 Device Tree blob\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D /incbin/(\"${DTB}\=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type =3D \"flat_dt\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 arch =3D \"${ARCH}\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compression =3D \"none\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hash@1 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 algo =3D \"=
crc32\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hash@2 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 algo =3D \"=
sha1\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }; /* end fdt */
> +
> + =A0 =A0 =A0 configurations {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default =3D \"config@1\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 config@1 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 description =3D \"Default L=
inux kernel\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kernel =3D \"kernel@1\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdt =3D \"fdt@1\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ramdisk =3D \"ramdisk@1\";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +};"
> +
> +# Conditionally strip fdt information out of tree
> +if [ -z "${DTB}" ]; then
> + =A0 =A0 =A0 DATA=3D`echo "$DATA" | sed '/start fdt/,/end fdt/d'`
> + =A0 =A0 =A0 DATA=3D`echo "$DATA" | sed '/fdt/d'`
> +fi
> +
> +# Write .its file to disk
> +echo "$DATA" > ${OUTPUT}
> --
> 1.6.2.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
