Return-Path: <dgibson@ozlabs.org>
Date: Wed, 1 Aug 2007 12:15:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 5/6] PowerPC 440EPx: Sequoia board support
Message-ID: <20070801021541.GE31391@localhost.localdomain>
References: <20070730151628.GA5100@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070730151628.GA5100@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2007 at 07:16:28PM +0400, Valentine Barshak wrote:
> AMCC 440EPx Sequoia board support.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  arch/powerpc/kernel/cputable.c       |   36 +++++++++++++++++++
>  arch/powerpc/kernel/head_44x.S       |    2 -
>  arch/powerpc/platforms/44x/Kconfig   |   17 ++++++++-
>  arch/powerpc/platforms/44x/Makefile  |    1 
>  arch/powerpc/platforms/44x/sequoia.c |   66 +++++++++++++++++++++++++++++++++++
>  5 files changed, 120 insertions(+), 2 deletions(-)
> 
> diff -ruN linux.orig/arch/powerpc/kernel/cputable.c linux/arch/powerpc/kernel/cputable.c
> --- linux.orig/arch/powerpc/kernel/cputable.c	2007-07-27 20:37:10.000000000 +0400
> +++ linux/arch/powerpc/kernel/cputable.c	2007-07-27 20:44:26.000000000 +0400
> @@ -1132,6 +1132,42 @@
>  		.dcache_bsize		= 32,
>  		.platform		= "ppc440",
>  	},
> +	{ /* 440EPX  - with Security/Kasumi  */
> +		.pvr_mask		= 0xf0000fff,
> +		.pvr_value		= 0x200008D0,
> +		.cpu_name		= "440EPX - with Security/Kasumi",
> +		.cpu_features		= CPU_FTRS_44X,
> +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /* 440EPX has an FPU */
> +		.icache_bsize		= 32,
> +		.dcache_bsize		= 32,
> +	},
> +	{ /* 440EPX  - without Security/Kasumi  */
> +		.pvr_mask		= 0xf0000fff,
> +		.pvr_value		= 0x200008D4,
> +		.cpu_name		= "440EPX - no Security/Kasumi",
> +		.cpu_features		= CPU_FTRS_44X,
> +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /* 440EPX has an FPU */
> +		.icache_bsize		= 32,
> +		.dcache_bsize		= 32,
> +	},

Since the with/without Security/Kasumi versions have no differences in
their cputable entry other than the PVR, couldn't you just remove the
relevant PVR bit from the mask and use a single entry?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
