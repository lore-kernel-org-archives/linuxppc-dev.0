Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C44A3DDED1
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 00:23:36 +1000 (EST)
In-Reply-To: <20070426171931.GA13647@ld0162-tx32.am.freescale.net>
References: <20070426171931.GA13647@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <22D52AA1-3719-4532-B1CD-D45BB6834843@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] bootwrapper: cuboot-83xx: Exclude upper 1MB from heap.
Date: Fri, 27 Apr 2007 09:22:38 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 26, 2007, at 12:19 PM, Scott Wood wrote:

> The uppermost part of memory is where u-boot puts the stack, so don't
> include that in the heap.  It's not currently causing problems, as the
> current code allocates from the bottom of the heap, but this will keep
> things from potentially breaking if a future implementation were to
> allocate from the top.

Why does it matter where u-boot puts it stack?  Once control is  
handed over I'd expect it not to matter.

- k

>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/boot/cuboot-83xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/boot/cuboot-83xx.c b/arch/powerpc/boot/ 
> cuboot-83xx.c
> index 8f11d1e..6cbc20a 100644
> --- a/arch/powerpc/boot/cuboot-83xx.c
> +++ b/arch/powerpc/boot/cuboot-83xx.c
> @@ -61,7 +61,7 @@ void platform_init(unsigned long r3, unsigned  
> long r4, unsigned long r5,
>  	loader_info.cmdline = (char *)r6;
>  	loader_info.cmdline_len = r7 - r6;
>
> -	simple_alloc_init(_end, avail_ram, 32, 64);
> +	simple_alloc_init(_end, avail_ram - 1024*1024, 32, 64);
>  	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
>  	serial_console_init();
>  	platform_ops.fixups = platform_fixups;
> -- 
> 1.5.0.3
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
