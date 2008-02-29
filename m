Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.244])
	by ozlabs.org (Postfix) with ESMTP id 1A62DDDE98
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 01:33:41 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id x43so3170959hsb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 06:33:39 -0800 (PST)
Message-ID: <fa686aa40802290633i2918cfbdtecb614065895f82a@mail.gmail.com>
Date: Fri, 29 Feb 2008 07:33:39 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [POWERPC] Fix zImage-dtb.initrd build error
In-Reply-To: <20080221185651.6893.78700.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080221185651.6893.78700.stgit@trillian.secretlab.ca>
Cc: miltonm@bga.com, paulus@samba.org, Hiroaki_Fuse@hq.scei.sony.co.jp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Any comments on this patch?  It needs to go in for .25, but I haven't
gotten any Acks on it.

Cheers,
g.

On Thu, Feb 21, 2008 at 11:57 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
>  The pattern substitution rules were failing when used with zImage-dtb
>  targets.  if zImage-dtb.initrd was selected, the pattern substitution
>  would generate "zImage.initrd-dtb" instead of "zImage-dtb.initrd" which
>  caused the build to fail.
>
>  This patch renames zImage-dtb to dtbImage to avoid the problem entirely.
>  By not using the zImage prefix then is no potential for namespace
>  collisions.
>
>  Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
>  ---
>  Note to reviewers.  Please consider this change carefully.  I saw two
>  options for fixing this bug;
>  1) rework the pattern substitution to handle zImage-dtb correctly
>  2) avoid using the zImage prefix
>
>  I chose option 2 because it avoids increasing the complexity of the
>  pattern substitution code for generating initrd names.  However, doing
>  so will have an impact on distributors because it changes the name of
>  the generated image.  If this is a problem for anyone, or if you have
>  a better name suggestion than "dtbImage", then please speak up.
>
>  Cheers,
>  g.
>  ---
>
>   arch/powerpc/Makefile      |    2 +-
>   arch/powerpc/boot/Makefile |   18 ++++++++++--------
>   2 files changed, 11 insertions(+), 9 deletions(-)
>
>  diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>  index 1c6ce35..ab5cfe8 100644
>  --- a/arch/powerpc/Makefile
>  +++ b/arch/powerpc/Makefile
>  @@ -155,7 +155,7 @@ all: zImage
>
>   CPPFLAGS_vmlinux.lds   := -Upowerpc
>
>  -BOOT_TARGETS = zImage zImage.initrd uImage treeImage.% cuImage.%
>  +BOOT_TARGETS = zImage zImage.initrd uImage zImage% dtbImage% treeImage.% cuImage.%
>
>   PHONY += $(BOOT_TARGETS)
>
>  diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
>  index 63d07cc..d57a67d 100644
>  --- a/arch/powerpc/boot/Makefile
>  +++ b/arch/powerpc/boot/Makefile
>  @@ -186,7 +186,7 @@ quiet_cmd_wrap      = WRAP    $@
>   image-$(CONFIG_PPC_PSERIES)            += zImage.pseries
>   image-$(CONFIG_PPC_MAPLE)              += zImage.pseries
>   image-$(CONFIG_PPC_IBM_CELL_BLADE)     += zImage.pseries
>  -image-$(CONFIG_PPC_PS3)                        += zImage-dtb.ps3
>  +image-$(CONFIG_PPC_PS3)                        += dtbImage.ps3
>   image-$(CONFIG_PPC_CELLEB)             += zImage.pseries
>   image-$(CONFIG_PPC_CHRP)               += zImage.chrp
>   image-$(CONFIG_PPC_EFIKA)              += zImage.chrp
>  @@ -205,7 +205,7 @@ image-$(CONFIG_DEFAULT_UIMAGE)              += uImage
>   #
>
>   # Board ports in arch/powerpc/platform/40x/Kconfig
>  -image-$(CONFIG_EP405)                  += zImage-dtb.ep405
>  +image-$(CONFIG_EP405)                  += dtbImage.ep405
>   image-$(CONFIG_WALNUT)                 += treeImage.walnut
>
>   # Board ports in arch/powerpc/platform/44x/Kconfig
>  @@ -220,9 +220,9 @@ image-$(CONFIG_WARP)                        += cuImage.warp
>   # Board ports in arch/powerpc/platform/8xx/Kconfig
>   image-$(CONFIG_PPC_MPC86XADS)          += cuImage.mpc866ads
>   image-$(CONFIG_PPC_MPC885ADS)          += cuImage.mpc885ads
>  -image-$(CONFIG_PPC_EP88XC)             += zImage-dtb.ep88xc
>  +image-$(CONFIG_PPC_EP88XC)             += dtbImage.ep88xc
>   image-$(CONFIG_PPC_ADDER875)           += cuImage.adder875-uboot \
>  -                                          zImage-dtb.adder875-redboot
>  +                                          dtbImage.adder875-redboot
>
>   # Board ports in arch/powerpc/platform/52xx/Kconfig
>   image-$(CONFIG_PPC_LITE5200)           += cuImage.lite5200 cuImage.lite5200b
>  @@ -230,7 +230,7 @@ image-$(CONFIG_PPC_LITE5200)                += cuImage.lite5200 cuImage.lite5200b
>   # Board ports in arch/powerpc/platform/82xx/Kconfig
>   image-$(CONFIG_MPC8272_ADS)            += cuImage.mpc8272ads
>   image-$(CONFIG_PQ2FADS)                        += cuImage.pq2fads
>  -image-$(CONFIG_EP8248E)                        += zImage-dtb.ep8248e
>  +image-$(CONFIG_EP8248E)                        += dtbImage.ep8248e
>
>   # Board ports in arch/powerpc/platform/83xx/Kconfig
>   image-$(CONFIG_MPC832x_MDS)            += cuImage.mpc832x_mds
>  @@ -268,7 +268,8 @@ endif
>
>   initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-n) $(image-))
>   initrd-y := $(patsubst zImage%, zImage.initrd%, \
>  -               $(patsubst treeImage%, treeImage.initrd%, $(image-y)))
>  +               $(patsubst dtbImage%, dtbImage.initrd%, \
>  +               $(patsubst treeImage%, treeImage.initrd%, $(image-y))))
>   initrd-y := $(filter-out $(image-y), $(initrd-y))
>   targets        += $(image-y) $(initrd-y)
>
>  @@ -283,10 +284,11 @@ $(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
>   $(obj)/zImage.%: vmlinux $(wrapperbits)
>         $(call if_changed,wrap,$*)
>
>  -$(obj)/zImage-dtb.initrd.%: vmlinux $(wrapperbits) $(dtstree)/%.dts
>  +# dtbImage% - a dtbImage is a zImage with an embedded device tree blob
>  +$(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(dtstree)/%.dts
>         $(call if_changed,wrap,$*,$(dtstree)/$*.dts,,$(obj)/ramdisk.image.gz)
>
>  -$(obj)/zImage-dtb.%: vmlinux $(wrapperbits) $(dtstree)/%.dts
>  +$(obj)/dtbImage.%: vmlinux $(wrapperbits) $(dtstree)/%.dts
>         $(call if_changed,wrap,$*,$(dtstree)/$*.dts)
>
>   # This cannot be in the root of $(src) as the zImage rule always adds a $(obj)
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
