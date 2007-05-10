Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 40ACDDDE4A
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 17:48:44 +1000 (EST)
Date: Thu, 10 May 2007 09:48:42 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Split initrd logic out of early_init_dt_scan_chosen()
	to fix warning
In-Reply-To: <20070510070645.15973DDEFE@ozlabs.org>
Message-ID: <Pine.LNX.4.62.0705100947460.32241@pademelon.sonytel.be>
References: <20070510070645.15973DDEFE@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 May 2007, Michael Ellerman wrote:
> If CONFIG_BLK_DEV_INITRD is not defined the prop variable in
> early_init_dt_scan_chosen() is unused, causing a compiler warning.
> 
> So split the initrd logic into a separate function, allowing us to
> declare prop only when we need it.
> 
> Built for both cases and booted with an initrd.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> 
>  arch/powerpc/kernel/prom.c |   48 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
> 
> Index: powerpc/arch/powerpc/kernel/prom.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/kernel/prom.c
> +++ powerpc/arch/powerpc/kernel/prom.c
> @@ -716,11 +716,41 @@ static int __init early_init_dt_scan_cpu
>  	return 0;
>  }
>  
> +#ifdef CONFIG_BLK_DEV_INITRD

> +#else
> +static inline void early_init_dt_check_for_initrd(unsigned long node)
> +{
> +	return;
> +}
> +#endif /* CONFIG_BLK_DEV_INITRD */

There's no need to use `return' in functions returning void.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
