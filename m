Return-Path: <jwboyer@gmail.com>
Received: from mail-qy0-f119.google.com (mail-qy0-f119.google.com
	[209.85.221.119]) by ozlabs.org (Postfix) with ESMTP id 246E8DDF0C
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 05:47:37 +1100 (EST)
Received: by qyk17 with SMTP id 17so331847qyk.17
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 10:47:34 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Fri, 6 Mar 2009 13:40:39 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Eddie Dawydiuk <eddie@embeddedarm.com>
Subject: Re: [PATCH, RFC]
Message-ID: <20090306184038.GA20537@zod.rchland.ibm.com>
References: <49B1605C.7090709@embeddedarm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49B1605C.7090709@embeddedarm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 06, 2009 at 10:41:48AM -0700, Eddie Dawydiuk wrote:
> Hello,
>
> The patch below resolves the following issues. The build system for the  
> AMCC Yosemite eval board is not including the proper fixups(e.g. RAM  
> initialization, timer initialization). In addition the wrapper script  
> was not using the fixed-head.S source(e.g. add branch instruction so one  
> can jump into the image at offset 0).
>
> Any feedback appreciated..

Your patch is word-wrapped.  It also lacks the Signed-off-by tag, which
is required.

The changelog sounds as if there are bugs being fixed here, but really
you're adding support for something entirely new.  The yosemite board
comes with U-Boot, which uses uImages.  You seem to be adding support
for using simpleboot on the Yosemite board.  Is that correct?

See below for further comments.

> diff -urN linux-2.6.28.orig/arch/powerpc/boot/Makefile  
> linux-2.6.28/arch/powerpc/boot/Makefile
> --- linux-2.6.28.orig/arch/powerpc/boot/Makefile        2008-12-24  
> 16:26:37.000000000 -0700
> +++ linux-2.6.28/arch/powerpc/boot/Makefile     2009-03-05  
> 17:35:53.000000000 -0700
> @@ -70,7 +70,7 @@
>                 cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
>                 cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c  
> simpleboot.c \
>                 virtex405-head.S virtex.c redboot-83xx.c  
> cuboot-sam440ep.c \
> -               cuboot-acadia.c
> +               cuboot-acadia.c simpleboot-yosemite.c
>  src-boot := $(src-wlib) $(src-plat) empty.c
>
>  src-boot := $(addprefix $(obj)/, $(src-boot))
> @@ -224,7 +224,7 @@
>  image-$(CONFIG_TAISHAN)                        += cuImage.taishan
>  image-$(CONFIG_KATMAI)                 += cuImage.katmai
>  image-$(CONFIG_WARP)                   += cuImage.warp
> -image-$(CONFIG_YOSEMITE)               += cuImage.yosemite
> +image-$(CONFIG_YOSEMITE)               += cuImage.yosemite  
> simpleImage.yosemite
>
>  # Board ports in arch/powerpc/platform/8xx/Kconfig
>  image-$(CONFIG_MPC86XADS)              += cuImage.mpc866ads
>
> diff -urN linux-2.6.28.orig/arch/powerpc/boot/wrapper  
> linux-2.6.28/arch/powerpc/boot/wrapper
> --- linux-2.6.28.orig/arch/powerpc/boot/wrapper 2008-12-24  
> 16:26:37.000000000 -0700
> +++ linux-2.6.28/arch/powerpc/boot/wrapper      2009-03-05  
> 17:36:10.000000000 -0700
> @@ -214,8 +214,12 @@
>      platformo="$object/simpleboot.o $object/virtex.o"
>      binary=y
>      ;;
> +simpleboot-yosemite)
> +    platformo="$object/fixed-head.o $object/simpleboot.o  
> $object/simpleboot-yosemite.o"
> +    binary=y
> +    ;;
>  simpleboot-*)
> -    platformo="$object/simpleboot.o"
> +    platformo="$object/fixed-head.o $object/simpleboot.o"

Does this break other boards, or should it have always been there?

>      binary=y
>      ;;
>  asp834x-redboot)
>
> diff -urN linux-2.6.28.orig/arch/powerpc/boot/simpleboot-yosemite.c  
> linux-2.6.28/arch/powerpc/boot/simpleboot-yosemite.c
> --- linux-2.6.28.orig/arch/powerpc/boot/simpleboot-yosemite.c 1969-12-31 
> 17:00:00.000000000 -0700
> +++ linux-2.6.28/arch/powerpc/boot/simpleboot-yosemite.c 2009-03-06 
> 10:48:19.000000000 -0700
> @@ -0,0 +1,27 @@
> +#include "ops.h"
> +#include "stdio.h"
> +#include "4xx.h"
> +#include "44x.h"
> +
> +#define TARGET_4xx
> +#define TARGET_44x
> +#include "ppcboot.h"
> +
> +static unsigned char eth0adr[] = { 0x0, 0xd0, 0x69, 0x41, 0x12, 0x34 };
> +static unsigned char eth1adr[] = { 0x0, 0xd0, 0x69, 0x41, 0x12, 0x56 };

You can't do this.  If you hard code the MAC address of whatever board
you are using in the kernel, everyone will have to edit it.  You need
to specify this in your board DTS file or via some other configurable
mechansim.

> +
> +static void yosemite_fixups(void)
> +{
> +       unsigned long sysclk = 50000000;
> +
> +       ibm440ep_fixup_clocks(sysclk, 11059200, 400000000);
> +       ibm4xx_sdram_fixup_memsize();
> +       dt_fixup_mac_address_by_alias("ethernet0", eth0adr);
> +       dt_fixup_mac_address_by_alias("ethernet1", eth1adr);
> +}
> +
> +void platform_specific_init(void)
> +{
> +       platform_ops.fixups = yosemite_fixups;
> +       platform_ops.exit = ibm44x_dbcr_reset;
> +}

josh
