Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EB075DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 08:39:03 +1100 (EST)
Message-ID: <45D0DE6C.1040207@am.sony.com>
Date: Mon, 12 Feb 2007 13:38:52 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 19/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
References: <20070212205438.GB17285@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070212205438.GB17285@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index aeb5309..f6e9b5e 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> +config CUIMAGE_DTS
> +	string "Device tree source file"
> +	depends on COMPAT_UIMAGE
> +	help
> +	  This specifies the device tree source (.dts) file to
> +	  be compiled and included in the kernel image.  If
> +	  a relative filename is given, then it will be relative
> +	  to arch/powerpc/boot/dts.
> +


There is nothing CUIMAGE specific with this, so why make it so?  Other
platforms may like to use it.


> +++ b/arch/powerpc/boot/Makefile
> @@ -35,6 +35,8 @@ endif
>  
>  BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
>  
> +cuboot-plats := 83xx 85xx 86xx
> +
>  zlib       := inffast.c inflate.c inftrees.c
>  zlibheader := inffast.h inffixed.h inflate.h inftrees.h infutil.h
>  zliblinuxheader := zlib.h zconf.h zutil.h
> @@ -45,7 +47,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
>  src-wlib := string.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
>  		ns16550.c serial.c simple_alloc.c div64.S util.S $(zlib) \
>  		devtree.c
> -src-plat := of.c
> +src-plat := of.c $(cuboot-plats:%=cuboot-%.c)


It may be better to do it like this, as there will be more platforms that
need to hook in specific files.

src-plat-$(CONFIG_COMPAT_UIMAGE) += $(cuboot-plats:%=cuboot-%.c)
src-plat-$(CONFIG_XXX) += ...
src-plat-$(CONFIG_YYY) += ...
...
src-plat := of.c $(src-plat-y)


> +ifeq ($(CONFIG_COMPAT_UIMAGE),y)
> +cuboot-plat-$(CONFIG_83xx) += 83xx
> +cuboot-plat-$(CONFIG_85xx) += 85xx
> +cuboot-plat-$(CONFIG_86xx) += 86xx
> +cuboot-plat-y += unknown-platform
> +
> +$(obj)/uImage: vmlinux $(wrapperbits)
> +	$(call cmd,wrap_dt,cuboot-$(word 1,$(cuboot-plat-y)))
> +else
>  $(obj)/uImage: vmlinux $(wrapperbits)
>  	$(call cmd,wrap,uboot)
> +endif


It would be nice if you could make the logic such that you don't need this ifeq.


-Geoff
