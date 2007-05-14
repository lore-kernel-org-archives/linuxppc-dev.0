Return-Path: <dgibson@ozlabs.org>
Date: Mon, 14 May 2007 10:22:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] U-boot passes the initrd as start/end, not start/size.
Message-ID: <20070514002205.GC6517@localhost.localdomain>
References: <20070511175202.GA14644@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070511175202.GA14644@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 11, 2007 at 12:52:03PM -0500, Scott Wood wrote:

Patch description would be good.

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/boot/cuboot-83xx.c |    2 +-
>  arch/powerpc/boot/cuboot-85xx.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/cuboot-83xx.c b/arch/powerpc/boot/cuboot-83xx.c
> index 6cbc20a..9af554e 100644
> --- a/arch/powerpc/boot/cuboot-83xx.c
> +++ b/arch/powerpc/boot/cuboot-83xx.c
> @@ -57,7 +57,7 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
>  
>  	memcpy(&bd, (bd_t *)r3, sizeof(bd));
>  	loader_info.initrd_addr = r4;
> -	loader_info.initrd_size = r4 ? r5 : 0;
> +	loader_info.initrd_size = r4 ? r5 - r4 : 0;
>  	loader_info.cmdline = (char *)r6;
>  	loader_info.cmdline_len = r7 - r6;
>  
> diff --git a/arch/powerpc/boot/cuboot-85xx.c b/arch/powerpc/boot/cuboot-85xx.c
> index f88ba00..e256031 100644
> --- a/arch/powerpc/boot/cuboot-85xx.c
> +++ b/arch/powerpc/boot/cuboot-85xx.c
> @@ -58,7 +58,7 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
>  
>  	memcpy(&bd, (bd_t *)r3, sizeof(bd));
>  	loader_info.initrd_addr = r4;
> -	loader_info.initrd_size = r4 ? r5 : 0;
> +	loader_info.initrd_size = r4 ? r5 - r4 : 0;
>  	loader_info.cmdline = (char *)r6;
>  	loader_info.cmdline_len = r7 - r6;

Now that cuboot-ebony.c is merged, that should be fixed as well.

We should really think about some macro magic or something to avoid
this duplication of identical-save-for-bd_t's-definition cuboot
handling code.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
