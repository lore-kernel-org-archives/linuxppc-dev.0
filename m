Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id A1F90DE259
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2009 01:54:03 +1100 (EST)
In-Reply-To: <200901130149.43588.yur@emcraft.com>
References: <200901130149.43588.yur@emcraft.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f341f40f2bfa0818be32a86da62ada9b@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH][v4] powerpc 44x: support for 256KB PAGE_SIZE
Date: Fri, 16 Jan 2009 09:00:33 -0600
To: Yuri Tikhonov <yur@emcraft.com>
Cc: wd@denx.de, dzu@denx.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	hugh@veritas.com, akpm@linux-foundation.org, prodyuth@gmail.com,
	yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jan 12, 2009, at 4:49 PM, Yuri Tikhonov wrote:

> This patch adds support for 256KB pages on ppc44x-based boards.

Another day, another comment.  The motivation for reply was the second 
comment below.

>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 84b8613..18f33ef 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -443,6 +443,19 @@ config PPC_64K_PAGES
>  	bool "64k page size" if 44x || PPC_STD_MMU_64
>  	select PPC_HAS_HASH_64K if PPC_STD_MMU_64
>
> +config PPC_256K_PAGES
> +	bool "256k page size" if 44x
> +	depends on !STDBINUTILS && !SHMEM

depends on !STDBINUTILS && (!SHMEM || BROKEN)

to identify that it is not fundamentally incompatable just not a chance 
of working without other changes.

> +	help
> +	  Make the page size 256k.
> +
> +	  As the ELF standard only requires alignment to support page
> +	  sizes up to 64k, you will need to compile all of your user
> +	  space applications with a non-standard binutils settings
> +	  (see the STDBINUTILS description for details).
> +
> +	  Say N unless you know what you are doing.
> +
>  endchoice
>
>  config FORCE_MAX_ZONEORDER


> diff --git a/arch/powerpc/platforms/44x/Kconfig 
> b/arch/powerpc/platforms/44x/Kconfig
> index 3496bc0..d02e8c8 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -214,6 +214,18 @@ config 440SPe
>  	bool
>  	select IBM_NEW_EMAC_EMAC4
>
> +config STDBINUTILS
> +	bool "Using standard binutils settings"
> +	depends on 44x
> +	default y


I think this should be

config STDBINUTILS
	bool "Using standard binutils settings" if 44x
	default y

that way we imply that all powerpc users are using the standard 
binutils instead of only those using a 44x platform.  We still get the 
intended effect of asking the user only on 44x.

I haven't looked at the resulting question or config order to see if it 
makes sense to leave it here or put it closer to the page size.


> +	help
> +	  Turning this option off allows you to select 256KB PAGE_SIZE on 
> 44x.
> +	  Note, that kernel will be able to run only those applications,
> +	  which had been compiled using binutils later than 2.17.50.0.3 with
> +	  '-zmax-page-size' set to 256K (the default is 64K). Or, if using
> +	  the older binutils, you can patch them with a trivial patch, which
> +	  changes the ELF_MAXPAGESIZE definition from 0x10000 to 0x40000.
> +
>  config 460EX
>  	bool
>  	select PPC_FPU
> -- 
> 1.6.0.6

milton
