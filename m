Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id E691CDDDF0
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 04:22:37 +1100 (EST)
Date: Thu, 21 Feb 2008 18:22:30 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Grant Likely <grant.likely@secretlab.ca>
Subject: make zImage.initrd failure (was: Re: [PATCH v4] [POWERPC] bootwrapper:
	build multiple cuImages)
In-Reply-To: <20080206181833.13239.70510.stgit@trillian.secretlab.ca>
Message-ID: <Pine.LNX.4.64.0802211801410.6128@vixen.sonytel.be>
References: <20080206181833.13239.70510.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1948398456-1203613302=:6128"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Hiroaki Fuse <Hiroaki_Fuse@hq.scei.sony.co.jp>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1948398456-1203613302=:6128
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0802211803411.6128@vixen.sonytel.be>

	Hi Grant,

On Wed, 6 Feb 2008, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Currently, the kernel uses CONFIG_DEVICE_TREE to wrap a kernel image
> with a fdt blob which means for any given configuration only one dts
> file can be selected and so support for only one board can be built
> 
> This patch moves the selection of the default .dts file out of the kernel
> config and into the bootwrapper makefile.  The makefile chooses which
> images to build based on the kernel config and the dts source file
> name is taken directly from the image name.  For example "cuImage.ebony"
> will use "ebony.dts" as the device tree source file.
> 
> In addition, this patch allows a specific image to be requested from the
> command line by adding "cuImage.%" and "treeImage.%" targets to the list
> of valid built targets in arch/powerpc/Makefile.  This allows the default
> dts selection to be overridden.
> 
> Another advantage to this change is it allows a single defconfig to be
> supplied for all boards using the same chip family and only differing in
> the device tree.
> 
> Important note: This patch adds two new zImage targets; zImage.dtb.% and
> zImage.dtb.initrd.% for zImages with embedded dtb files.  Currently
> there are 5 platforms which require this: ps3, ep405, mpc885ads, ep88xc,
> adder875-redboot and ep8248e.  This patch *changes the zImage filenames*
> for those platforms.  ie. 'zImage.ps3' is now 'zImage.dtb.ps3'.
> 
> This new zImage.dtb targets were added so that the .dts file could be
> part of the dependancies list for building them.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> 
> ---
> v4: removed mpc837x_mds and mpc8313erdb cuimages and changed mpc885ads to
> a cuImage
> 
> v3: I think this patch is complete.  Renamed zImage.dtb.% targets to
> zImage-dtb.% to avoid make choosing the wrong rule if the dts file is missing.
> 
> v2: This version fixes some bugs and adds new zImage.dtb and
> zImage.initrd.dtb targets.
> 
> v1: Please review and comment.  I have not exhaustively tested this patch
> and I'm sure to have missed some boards.  However, I think the concept
> is sound and will be a good change.

Fuse-san discovered we can no longer do `make zImage.initrd' when building for
PS3:

|   WRAP    arch/powerpc/boot/zImage.initrd-dtb.ps3
| ppu-ld: arch/powerpc/boot/initrd-dtb.ps3.o: No such file: No such file or directory
| make[3]: *** [arch/powerpc/boot/zImage.initrd-dtb.ps3] Error 1
| make[2]: *** [zImage.initrd] Error 2
| make[1]: *** [sub-make] Error 2
| make: *** [all] Error 2

It can easily be reproduced using `make ps3_defconfig; make zImage.initrd'.

There seem to be two problems:

 1. Before this patch, the generated build target was `zImage.initrd.ps3'.
    After this patch, the generated build target is `zImage.initrd-dtb.ps3'.
    Now `initrd-dtb.ps3' is passed to the boot wrapper as the `platform'
    parameter, which of course no longer matches the `ps3' test case in the
    boot wrapper script.
    The patch below works around this problem, but I don't think it's the
    proper fix.

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index c317815..aec4414 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -182,7 +182,7 @@ cuboot*)
         ;;
     esac
     ;;
-ps3)
+*ps3)
     platformo="$object/ps3-head.o $object/ps3-hvcall.o $object/ps3.o"
     lds=$object/zImage.ps3.lds
     gzip=

>  # Don't put the ramdisk on the pattern rule; when its missing make will try
>  # the pattern rule with less dependencies that also matches (even with the
>  # hard dependency listed).
> -$(obj)/zImage.initrd.%: vmlinux $(wrapperbits) $(dts)
> -	$(call if_changed,wrap,$*,$(dts),,$(obj)/ramdisk.image.gz)
> +$(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
> +	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
>  
> -$(obj)/zImage.%: vmlinux $(wrapperbits) $(dts)
> -	$(call if_changed,wrap,$*,$(dts))
> +$(obj)/zImage.%: vmlinux $(wrapperbits)
> +	$(call if_changed,wrap,$*)

  2. The generated build target `zImage.initrd-dtb.ps3' matches both rules,
     and of course the wrong one (the second one) is chosen by make, causing
     the ramdisk image not to be included.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

Sony Network and Software Technology Center Europe
A division of Sony Service Centre (Europe) N.V.
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium
VAT BE 0413.825.160 · RPR Brussels
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584349381-1948398456-1203613302=:6128--
