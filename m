Return-Path: <benh@kernel.crashing.org>
Subject: Re: [POWERPC] 32-bit early_init() should zero from __bss_start to
	__bss_stop only
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20061025233649.GB17461@mag.az.mvista.com>
References: <20061025233649.GB17461@mag.az.mvista.com>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 10:06:16 +1000
Message-Id: <1161821177.22582.149.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-10-25 at 16:36 -0700, Mark A. Greer wrote:
> Currently, early_init() in setup_32.c zeroes from '_bss_start' to '_end'.
> It should only zero from '__bss_start' to '__bss_stop'.  This patch does that.
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> 
>  setup_32.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> ---
> 
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index a4c2964..c682e9a 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -95,7 +95,8 @@ unsigned long __init early_init(unsigned
>  
>  	/* First zero the BSS -- use memset_io, some platforms don't have
>  	 * caches on yet */
> -	memset_io((void __iomem *)PTRRELOC(&__bss_start), 0, _end - __bss_start);
> +	memset_io((void __iomem *)PTRRELOC(&__bss_start), 0,
> +			__bss_stop - __bss_start);
>  
>  	/*
>  	 * Identify the CPU type and fix up code sections
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
