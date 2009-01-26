Return-Path: <l.fu@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 13A77DE0D3
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 02:23:42 +1100 (EST)
Message-ID: <497DD577.9040209@pengutronix.de>
Date: Mon, 26 Jan 2009 16:23:35 +0100
From: Luotao Fu <l.fu@pengutronix.de>
MIME-Version: 1.0
To: Matteo Fortini <matteo.fortini@mta.it>
Subject: Re: Booting uncompressed kernel image
References: <497D9EF1.4030403@mta.it>
In-Reply-To: <497D9EF1.4030403@mta.it>
Content-Type: multipart/mixed; boundary="------------000201070701010002040704"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000201070701010002040704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Matteo Fortini wrote:
> Hi all,
> I built an uncompressed uImage using mkimage --no-gzip -C none in the
> wrapper scripts.
> Only, u-boot recognizes it as uncompressed and launches the kernel
> properly (it's around 4MB), but in the end linux just prints
> OK and stops.
Powerpc make compress the bin image with gzip first, before it generates
the image header.  If the u-boot reads the image header properly doesn't
mean that the kernel is really unpacked.
>
> Has anyone done the same?
me ;-) I did it with a mpc5200b board and linux 2.6.23. You can try the
patch attached to this mail. It worked for me[TM]. ;-)

Cheers
Luotao Fu

-- 
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


--------------000201070701010002040704
Content-Type: text/plain;
 name="make_uncompressed_image.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="make_uncompressed_image.diff"

Subject: Create an uncomrpessed uImage
From: Luotao Fu <l.fu@pengutronix.de>

This one adds a make target to create an uncomrpessed uImage format for powerpc,
which is usable by uboot. We call the target nuImage for now. We need this to
verify if we can boost up the boot speed.

Signed-off-by: Luotao Fu <l.fu@pengutrnoix.de>

---
 arch/powerpc/Makefile      |    2 +-
 arch/powerpc/boot/Makefile |    3 +++
 arch/powerpc/boot/wrapper  |   15 ++++++++++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

Index: arch/powerpc/boot/wrapper
===================================================================
--- arch/powerpc/boot/wrapper.orig
+++ arch/powerpc/boot/wrapper
@@ -133,7 +133,7 @@ coff)
     platformo=$object/of.o
     lds=$object/zImage.coff.lds
     ;;
-miboot|uboot)
+miboot|uboot|decuboot)
     # miboot and U-boot want just the bare bits, not an ELF binary
     ext=bin
     objflags="-O binary"
@@ -190,6 +190,19 @@ uboot)
     fi
     exit 0
     ;;
+decuboot)
+    rm -f "$ofile"
+    vmz_uncomp=`basename $vmz $gzip`
+    gunzip -c $vmz > $vmz_uncomp
+    mkimage -A ppc -O linux -T kernel -C none -a 00000000 -e 00000000 \
+	$uboot_version -d "$vmz_uncomp" "$ofile"
+    rm $vmz_uncomp
+    vmz="$vmz$gzip"
+    if [ -z "$cacheit" ]; then
+	rm -f "$vmz"
+    fi
+    exit 0
+    ;;
 esac
 
 addsec() {
Index: arch/powerpc/boot/Makefile
===================================================================
--- arch/powerpc/boot/Makefile.orig
+++ arch/powerpc/boot/Makefile
@@ -195,6 +195,9 @@ $(obj)/zImage.initrd.ps3: vmlinux  $(wra
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
+$(obj)/nuImage: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,decuboot)
+
 $(obj)/cuImage.%: vmlinux $(dts) $(wrapperbits)
 	$(call if_changed,wrap,cuboot-$*,$(dts))
 
Index: arch/powerpc/Makefile
===================================================================
--- arch/powerpc/Makefile.orig
+++ arch/powerpc/Makefile
@@ -148,7 +148,7 @@ all: $(KBUILD_IMAGE)
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd uImage
+BOOT_TARGETS = zImage zImage.initrd uImage nuImage
 
 PHONY += $(BOOT_TARGETS)
 

--------------000201070701010002040704--
