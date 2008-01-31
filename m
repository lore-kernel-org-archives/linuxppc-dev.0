Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BF95EDDDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 13:10:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] [POWERPC] bootwrapper: build multiple cuImages
Date: Wed, 30 Jan 2008 17:49:54 -0800
In-Reply-To: <20080131003347.5779.96112.stgit@trillian.secretlab.ca>
References: <20080131003347.5779.96112.stgit@trillian.secretlab.ca>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, <jwboyer@gmail.com>,
	<linuxppc-dev@ozlabs.org>, <scottwood@freescale.com>,
	<galak@kernel.crashing.org>
Message-Id: <20080131014952.83827290071@mail95-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I like the spirit...  It does seem like the compiled in device tree is
specified in the wrong place.
Comments inline.

> -----Original Message-----
> From: =
linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of =
Grant
Likely
> Sent: Wednesday, January 30, 2008 4:34 PM
> To: jwboyer@gmail.com; linuxppc-dev@ozlabs.org;
scottwood@freescale.com; galak@kernel.crashing.org
> Subject: [RFC] [POWERPC] bootwrapper: build multiple cuImages
>=20
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> Currently, the kernel uses CONFIG_DEVICE_TREE to wrap a kernel image
> with a fdt blob which means for any given configuration only one dts
> file can be selected and so support for only one board can be built
>=20
> This patch moves the selection of the default .dts file out of the
kernel
> config and into the bootwrapper makefile.  The makefile chooses which
> images to build based on the kernel config and the dts source file
> name is taken directly from the image name.  For example
"cuImage.ebony"
> will use "ebony.dts" as the device tree source file.
>=20
> In addition, this patch allows a specific image to be requested from
the
> command line by adding "cuImage.%" and "treeImage.%" targets to the
list
> of valid built targets in arch/powerpc/Makefile.  This allows the
default
> dts selection to be overridden.
>=20
> Another advantage to this change is it allows a single defconfig to be
> supplied for all boards using the same chip family and only differing
in
> the device tree.
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>=20
> ---
>=20
> Please review and comment.  I have not exhaustively tested this patch
> and I'm sure to have missed some boards.  However, I think the concept
> is sound and will be a good change.
> ---
>=20
>  arch/powerpc/Kconfig       |   19 -------
>  arch/powerpc/Makefile      |    9 +--
>  arch/powerpc/boot/Makefile |  123
++++++++++++++++++++++++++++++++------------
>  arch/powerpc/boot/wrapper  |   20 +++++++
>  4 files changed, 112 insertions(+), 59 deletions(-)
>=20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 5e10838..5c205c7 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -407,25 +407,6 @@ config WANT_DEVICE_TREE
>  	bool
>  	default n
>=20
> -config DEVICE_TREE
> -	string "Static device tree source file"
> -	depends on WANT_DEVICE_TREE
> -	help
> -	  This specifies the device tree source (.dts) file to be
> -	  compiled and included when building the bootwrapper.  If a
> -	  relative filename is given, then it will be relative to
> -	  arch/powerpc/boot/dts.  If you are not using the bootwrapper,
> -	  or do not need to build a dts into the bootwrapper, this
> -	  field is ignored.
> -
> -	  For example, this is required when building a cuImage target
> -	  for an older U-Boot, which cannot pass a device tree itself.
> -	  Such a kernel will not work with a newer U-Boot that tries to
> -	  pass a device tree (unless you tell it not to).  If your
U-Boot
> -	  does not mention a device tree in "help bootm", then use the
> -	  cuImage target and specify a device tree here.  Otherwise, use
> -	  the uImage target and leave this field blank.
> -
>  endmenu
>=20
>  config ISA_DMA_API
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index f70df9b..6845482 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -151,14 +151,11 @@ core-$(CONFIG_XMON)		+=3D
arch/powerpc/xmon/
>  drivers-$(CONFIG_OPROFILE)	+=3D arch/powerpc/oprofile/
>=20
>  # Default to zImage, override when needed
> -defaultimage-y			:=3D zImage
> -defaultimage-$(CONFIG_DEFAULT_UIMAGE) :=3D uImage
> -KBUILD_IMAGE :=3D $(defaultimage-y)
> -all: $(KBUILD_IMAGE)
> +all: zImage
>=20
>  CPPFLAGS_vmlinux.lds	:=3D -Upowerpc
>=20
> -BOOT_TARGETS =3D zImage zImage.initrd uImage
> +BOOT_TARGETS =3D zImage zImage.initrd uImage treeImage.% cuImage.%
>=20
>  PHONY +=3D $(BOOT_TARGETS)
>=20
> @@ -180,7 +177,7 @@ define archhelp
>  endef
>=20
>  install: vdso_install
> -	$(Q)$(MAKE) $(build)=3D$(boot) BOOTIMAGE=3D$(KBUILD_IMAGE) install
> +	$(Q)$(MAKE) $(build)=3D$(boot) install
>=20
>  vdso_install:
>  ifeq ($(CONFIG_PPC64),y)
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index b36f911..7173abe 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -123,6 +123,8 @@ targets		+=3D $(patsubst
$(obj)/%,%,$(obj-boot) wrapper.a)
>  extra-y		:=3D $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
>  		   $(obj)/zImage.lds $(obj)/zImage.coff.lds
$(obj)/zImage.ps3.lds
>=20
> +dtstree		:=3D $(srctree)/$(src)/dts
> +
>  wrapper		:=3D$(srctree)/$(src)/wrapper
>  wrapperbits	:=3D $(extra-y) $(addprefix $(obj)/,addnote hack-coff
mktree dtc) \
>  			$(wrapper) FORCE
> @@ -191,26 +193,67 @@ image-$(CONFIG_PPC_PRPMC2800)		+=3D
zImage.prpmc2800
>  image-$(CONFIG_PPC_ISERIES)		+=3D zImage.iseries
>  image-$(CONFIG_DEFAULT_UIMAGE)		+=3D uImage
>=20
> -ifneq ($(CONFIG_DEVICE_TREE),"")
> -image-$(CONFIG_PPC_8xx)			+=3D cuImage.8xx
> -image-$(CONFIG_PPC_EP88XC)		+=3D zImage.ep88xc
> +#
> +# Targets which embed a device tree blob
> +#
> +# Theses are default targets to build images which embed device tree
blobs.
> +# They are only required on boards which do not have FDT support in
firmware.
> +# Boards with newish u-boot firmare can use the uImage target above
> +#
> +
> +# Board ports in arch/powerpc/platform/40x/Kconfig
>  image-$(CONFIG_EP405)			+=3D zImage.ep405
> -image-$(CONFIG_8260)			+=3D cuImage.pq2
> -image-$(CONFIG_EP8248E)			+=3D zImage.ep8248e
> -image-$(CONFIG_PPC_MPC52xx)		+=3D cuImage.52xx
> -image-$(CONFIG_STORCENTER)		+=3D cuImage.824x
> -image-$(CONFIG_PPC_83xx)		+=3D cuImage.83xx
> -image-$(CONFIG_PPC_85xx)		+=3D cuImage.85xx
> -image-$(CONFIG_MPC7448HPC2)		+=3D cuImage.hpc2
> +image-$(CONFIG_WALNUT)			+=3D treeImage.walnut
> +
> +# Board ports in arch/powerpc/platform/44x/Kconfig
>  image-$(CONFIG_EBONY)			+=3D treeImage.ebony
cuImage.ebony
>  image-$(CONFIG_BAMBOO)			+=3D treeImage.bamboo
cuImage.bamboo
>  image-$(CONFIG_SEQUOIA)			+=3D cuImage.sequoia
>  image-$(CONFIG_RAINIER)			+=3D cuImage.rainier
> -image-$(CONFIG_WALNUT)			+=3D treeImage.walnut
>  image-$(CONFIG_TAISHAN)			+=3D cuImage.taishan
>  image-$(CONFIG_KATMAI)			+=3D cuImage.katmai
>  image-$(CONFIG_WARP)			+=3D cuImage.warp
> -endif
> +
> +# Board ports in arch/powerpc/platform/8xx/Kconfig
> +image-$(CONFIG_PPC_MPC86XADS)		+=3D zImage.mpc866ads
> +image-$(CONFIG_PPC_MPC885ADS)		+=3D zImage.mpc885ads
> +image-$(CONFIG_PPC_EP88XC)		+=3D zImage.ep88xc
> +image-$(CONFIG_PPC_ADDER875)		+=3D cuImage.adder875-uboot
> +
> +# Board ports in arch/powerpc/platform/52xx/Kconfig
> +image-$(CONFIG_PPC_LITE5200)		+=3D cuImage.lite5200
cuImage.lite5200b
> +
> +# Board ports in arch/powerpc/platform/82xx/Kconfig
> +image-$(CONFIG_MPC8272_ADS)		+=3D cuImage.mpc8272ads
> +image-$(CONFIG_PQ2FADS)			+=3D cuImage.pq2fads
> +image-$(CONFIG_EP8248E)			+=3D zImage.ep8248e
> +
> +# Board ports in arch/powerpc/platform/83xx/Kconfig
> +image-$(CONFIG_MPC8313_RDB)		+=3D cuImage.mpc8313erdb
> +image-$(CONFIG_MPC832x_MDS)		+=3D cuImage.mpc832x_mds
> +image-$(CONFIG_MPC832x_RDB)		+=3D cuImage.mpc832x_rdb
> +image-$(CONFIG_MPC834x_ITX)		+=3D cuImage.mpc8349emitx \
> +					   cuImage.mpc8349emitxgp
> +image-$(CONFIG_MPC834x_MDS)		+=3D cuImage.mpc834x_mds
> +image-$(CONFIG_MPC836x_MDS)		+=3D cuImage.mpc836x_mds
> +image-$(CONFIG_MPC837x_MDS)		+=3D cuImage.mpc8377_mds \
> +					   cuImage.mpc8378_mds \
> +					   cuImage.mpc8379_mds
> +
> +# Board ports in arch/powerpc/platform/83xx/Kconfig
> +image-$(CONFIG_MPC8540_ADS)		+=3D cuImage.mpc8540ads
> +image-$(CONFIG_MPC8560_ADS)		+=3D cuImage.mpc8560ads
> +image-$(CONFIG_MPC85xx_CDS)		+=3D cuImage.mpc8541cds \
> +					   cuImage.mpc8548cds \
> +					   cuImage.mpc8555cds
> +image-$(CONFIG_MPC85xx_MDS)		+=3D cuImage.mpc8568mds
> +image-$(CONFIG_MPC85xx_DS)		+=3D cuImage.mpc8544ds \
> +					   cuImage.mpc8572ds
> +
> +# Board ports in arch/powerpc/platform/embedded6xx/Kconfig
> +image-$(CONFIG_STORCENTER)		+=3D cuImage.storcenter
> +image-$(CONFIG_PPC_PRPMC2800)		+=3D cuImage.prpmc2800
> +image-$(CONFIG_MPC7448HPC2)		+=3D cuImage.mpc7448hpc2
>=20
>  ifneq ($(CONFIG_REDBOOT),"")
>  image-$(CONFIG_PPC_8xx)			+=3D zImage.redboot-8xx
> @@ -230,24 +273,14 @@ targets	+=3D $(image-y) $(initrd-y)
>=20
>  $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
>=20
> -# If CONFIG_WANT_DEVICE_TREE is set and CONFIG_DEVICE_TREE isn't an
> -# empty string, define 'dts' to be path to the dts
> -# CONFIG_DEVICE_TREE will have "" around it, make sure to strip them
> -ifeq ($(CONFIG_WANT_DEVICE_TREE),y)
> -ifneq ($(CONFIG_DEVICE_TREE),"")
> -dts =3D $(if $(shell echo $(CONFIG_DEVICE_TREE) | grep '^/'),\
> -	,$(srctree)/$(src)/dts/)$(CONFIG_DEVICE_TREE:"%"=3D%)
> -endif
> -endif
> -
>  # Don't put the ramdisk on the pattern rule; when its missing make
will try
>  # the pattern rule with less dependencies that also matches (even
with the
>  # hard dependency listed).
> -$(obj)/zImage.initrd.%: vmlinux $(wrapperbits) $(dts)
> -	$(call if_changed,wrap,$*,$(dts),,$(obj)/ramdisk.image.gz)
> +$(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
> +	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
>=20
> -$(obj)/zImage.%: vmlinux $(wrapperbits) $(dts)
> -	$(call if_changed,wrap,$*,$(dts))
> +$(obj)/zImage.%: vmlinux $(wrapperbits)
> +	$(call if_changed,wrap,$*)
>=20
>  # This cannot be in the root of $(src) as the zImage rule always adds
a $(obj)
>  # prefix
> @@ -259,22 +292,42 @@ $(obj)/zImage.iseries: vmlinux
>=20
>  $(obj)/zImage.ps3: vmlinux  $(wrapper) $(wrapperbits)
$(srctree)/$(src)/dts/ps3.dts
>  	$(STRIP) -s -R .comment $< -o vmlinux.strip
> -	$(call cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,)
> +	$(call cmd,wrap,ps3,$(dtstree)/ps3.dts,,)
>=20
>  $(obj)/zImage.initrd.ps3: vmlinux  $(wrapper) $(wrapperbits)
$(srctree)/$(src)/dts/ps3.dts
> $(obj)/ramdisk.image.gz
> -	$(call
cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,$(obj)/ramdisk.image.gz)
> +	$(call cmd,wrap,ps3,$(dtstree)/ps3.dts,,$(obj)/ramdisk.image.gz)
> +
> +zImage.ep405: vmlinux $(wrapperbits) $(dtstree)/ep405.dts
> +	$(call if_changed,wrap,$*,$(dtstree)/ep405.dts)
> +zImage.initrd.ep405: vmlinux $(wrapperbits) $(dtstree)/ep405.dts
> +	$(call
if_changed,wrap,$*,$(dtstree)/ep405.dts,,$(obj)/ramdisk.image.gz)
> +
> +zImage.mpc866ads: vmlinux $(wrapperbits) $(dtstree)/mpc866ads.dts
> +	$(call if_changed,wrap,$*,$(dtstree)/mpc866ads.dts)
> +zImage.initrd.mpc866ads: vmlinux $(wrapperbits)
$(dtstree)/mpc866ads.dts
> +	$(call
if_changed,wrap,$*,$(dtstree)/mpc866ads.dts,,$(obj)/ramdisk.image.gz)
> +
> +zImage.mpc885ads: vmlinux $(wrapperbits) $(dtstree)/mpc885ads.dts
> +	$(call if_changed,wrap,$*,$(dtstree)/mpc885ads.dts)
> +zImage.initrd.mpc885ads: vmlinux $(wrapperbits)
$(dtstree)/mpc885ads.dts
> +	$(call
if_changed,wrap,$*,$(dtstree)/mpc885ads.dts,,$(obj)/ramdisk.image.gz)
> +
> +zImage.ep88xc: vmlinux $(wrapperbits) $(dtstree)/ep88xc.dts
> +	$(call if_changed,wrap,$*,$(dtstree)/ep88xc.dts)
> +zImage.initrd.ep88xc: vmlinux $(wrapperbits) $(dtstree)/ep88xc.dts
> +	$(call
if_changed,wrap,$*,$(dtstree)/ep88xc.dts,,$(obj)/ramdisk.image.gz)

It seems like all you've done here is expand out the $(obj)/zImage.%
rule?, but now the $* has nothing to match to?  I don't think this
works.

How about just:
$(obj)/zImage.initrd.%: vmlinux $(wrapperbits) %.dts
	$(call if_changed,wrap,$*,$*.dts,,$(obj)/ramdisk.image.gz)

Which would handle the default case of platform code for each dts.

Then for cases where you have a multiplatform target, you'd have
something like
$(obj)/zImage.initrd.virtex.%: vmlinux $(wrapperbits) %.dts
	$(call if_changed,wrap,virtex,$*.dts,,$(obj)/ramdisk.image.gz)

>=20
>  $(obj)/uImage: vmlinux $(wrapperbits)
>  	$(call if_changed,wrap,uboot)
>=20
> -$(obj)/cuImage.%: vmlinux $(dts) $(wrapperbits)
> -	$(call if_changed,wrap,cuboot-$*,$(dts))
> +$(obj)/cuImage.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
> +	$(call if_changed,wrap,cuboot-$*,$(dtstree)/$*.dts)
>=20
> -$(obj)/treeImage.initrd.%: vmlinux $(dts) $(wrapperbits)
> -	$(call
if_changed,wrap,treeboot-$*,$(dts),,$(obj)/ramdisk.image.gz)
> +$(obj)/treeImage.initrd.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
> +	$(call
if_changed,wrap,treeboot-$*,$(dtstree)/$*.dts,,$(obj)/ramdisk.image.gz)
>=20
> -$(obj)/treeImage.%: vmlinux $(dts) $(wrapperbits)
> -	$(call if_changed,wrap,treeboot-$*,$(dts))
> +$(obj)/treeImage.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
> +	$(call if_changed,wrap,treeboot-$*,$(dtstree)/$*.dts)
>=20
>  # If there isn't a platform selected then just strip the vmlinux.
>  ifeq (,$(image-y))
> @@ -283,8 +336,10 @@ endif
>=20
>  $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
>  	@rm -f $@; ln $< $@
> +	@echo target images: $(image-y)
>  $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
>  	@rm -f $@; ln $< $@
> +	@echo target images: $(initrd-y)
>=20
>  install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
>  	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux
System.map "$(INSTALL_PATH)" $<
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 763a0c4..b70ec6a 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -158,6 +158,26 @@ miboot|uboot)
>  cuboot*)
>      binary=3Dy
>      gzip=3D
> +    case "$platform" in
> +    *-mpc885ads|*-adder875*|*-ep88xc)
> +        platformo=3D$object/cuboot-8xx.o
> +        ;;
> +    *5200*|*-motionpro)
> +        platformo=3D$object/cuboot-52xx.o
> +        ;;
> +    *-pq2fads|*-ep8248e|*-mpc8272*)
> +        platformo=3D$object/cuboot-pq2.o
> +        ;;
> +    *-mpc824*)
> +        platformo=3D$object/cuboot-824x.o
> +        ;;
> +    *-mpc83*)
> +        platformo=3D$object/cuboot-83xx.o
> +        ;;
> +    *-mpc85*)
> +        platformo=3D$object/cuboot-85xx.o
> +        ;;
> +    esac
>      ;;
>  ps3)
>      platformo=3D"$object/ps3-head.o $object/ps3-hvcall.o =
$object/ps3.o"

I'm not particularly fond of making the wrapper smarter...  It seems
like the wrapper should be stupid and the logic about what to include
done in the Makefile or in Kconfig.  Also, it seems like a strange place
to explicitly encode the dependency between the name of the dts file and
the platform code.

Steve


>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
