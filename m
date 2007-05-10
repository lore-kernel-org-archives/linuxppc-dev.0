Return-Path: <dgibson@ozlabs.org>
Date: Fri, 11 May 2007 09:29:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/13] powerpc: Add Makefile rules to wrap dts file in
	zImage
Message-ID: <20070510232945.GB27188@localhost.localdomain>
References: <20070510200237.GA19756@mag.az.mvista.com>
	<20070510200445.GB19756@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070510200445.GB19756@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 10, 2007 at 01:04:45PM -0700, Mark A. Greer wrote:
> 
> Add 'zImage.dts' and 'zImage.dts_initrd' build rules that automatically
> compile and wrap a dts file from arch/powerpc/boot/dts into the zImage file.
> The resulting zImage will be arch/powerpc/boot/zImage.dts.<platform> and
> arch/powerpc/boot/zImage.dts_initrd.<platform>, respectively.
> 
> Having separate rules allows the user to choose whether to include a device
> tree--and which device tree--at build time.  This is useful when one Makefile
> target builds a zImage that runs on several platforms except for differing
> device trees.  By just setting CONFIG_DEVICE_TREE and running "make zImage.dts"
> the exact zImage you want is built without Makefile bloat or manually running
> the wrapper script.
> 
> The dts file is expected to be arch/powerpc/boot/dts/$(CONFIG_DEVICE_TREE)
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> ---
>  arch/powerpc/Makefile      |    2 +-
>  arch/powerpc/boot/Makefile |   24 +++++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> Index: powerpc/arch/powerpc/boot/Makefile
> ===================================================================
> --- powerpc.orig/arch/powerpc/boot/Makefile
> +++ powerpc/arch/powerpc/boot/Makefile
> @@ -154,9 +154,27 @@ targets	+= $(image-y) $(initrd-y)
>  
>  $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
>  
> +dts-  := $(patsubst zImage%, zImage.dts%, $(image-n) $(image-))
> +dts-y := $(patsubst zImage%, zImage.dts%, $(image-y))
> +dts-y := $(filter-out $(image-y), $(dts-y))
> +targets	+= $(image-y) $(dts-y)
> +
> +dts_initrd-  := $(patsubst zImage%, zImage.dts_initrd%, $(image-n) $(image-))
> +dts_initrd-y := $(patsubst zImage%, zImage.dts_initrd%, $(image-y))
> +dts_initrd-y := $(filter-out $(image-y), $(dts_initrd-y))
> +targets	+= $(image-y) $(dts_initrd-y)
> +
> +$(addprefix $(obj)/, $(dts_initrd-y)): $(obj)/ramdisk.image.gz
> +
>  # Don't put the ramdisk on the pattern rule; when its missing make will try
>  # the pattern rule with less dependencies that also matches (even with the
>  # hard dependency listed).
> +$(obj)/zImage.dts_initrd.%: vmlinux $(wrapperbits)
> +	$(call if_changed,wrap,$*,$(dts),,$(obj)/ramdisk.image.gz)
> +
> +$(obj)/zImage.dts.%: vmlinux $(wrapperbits)
> +	$(call if_changed,wrap,$*,$(dts))
> +
>  $(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
>  	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
>  
> @@ -195,13 +213,17 @@ $(obj)/zImage:		$(addprefix $(obj)/, $(i
>  	@rm -f $@; ln $< $@
>  $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
>  	@rm -f $@; ln $< $@
> +$(obj)/zImage.dts:	$(addprefix $(obj)/, $(dts-y))
> +	@rm -f $@; ln $< $@
> +$(obj)/zImage.dts_initrd:	$(addprefix $(obj)/, $(dts_initrd-y))
> +	@rm -f $@; ln $< $@

I don't think there a lot of point to this part of the patch.  Just
have image-y directly specify the appropriate zImage.dts.% form (or
forms).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
