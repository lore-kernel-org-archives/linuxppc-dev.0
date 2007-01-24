Return-Path: <dgibson@ozlabs.org>
Date: Thu, 25 Jan 2007 10:51:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 01/18] Include autoconf.h from the bootwrapper.
Message-ID: <20070124235150.GA26212@localhost.localdomain>
References: <20070124210654.GA10527@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070124210654.GA10527@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 24, 2007 at 03:06:54PM -0600, Scott Wood wrote:
> This will be required by the u-boot compatibility code to obtain a
> compatible bd_t layout, to determine how to calculate the timebase, and
> to know what soc fields need to be modified.

Erm.. I believe the omission of *all* kernel header files from the
boot wrapper code, including the config, is a deliberate decision.
The idea is that the wrapping can, if necessary, be done independent
of the kernel build.

> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/boot/Makefile |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 98392fb..906b166 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -31,7 +31,8 @@ ifeq ($(call cc-option-yn, -fstack-prote
>  BOOTCFLAGS	+= -fno-stack-protector
>  endif
>  
> -BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
> +BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj) \
> +                   -include $(srctree)/include/linux/autoconf.h
>  
>  zlib       := inffast.c inflate.c inftrees.c
>  zlibheader := inffast.h inffixed.h inflate.h inftrees.h infutil.h

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
