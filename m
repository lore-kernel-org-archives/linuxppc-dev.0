Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 39004DDE22
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 04:54:26 +1100 (EST)
Date: Mon, 12 Feb 2007 20:55:00 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: hs@denx.de
Subject: Re: [PATCH] CPM_UART: Fixed SMC handling for CPM2 processors
Message-ID: <20070212205500.1b7135fe@vitb.ru.mvista.com>
In-Reply-To: <1171276422.14090.54.camel@Apollo>
References: <1171276422.14090.54.camel@Apollo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 12 Feb 2007 11:33:42 +0100
Heiko Schocher <hs@denx.de> wrote:

> Hello Vitaly,
> 
> I tried the Patch from Kalle Pokki
> http://ozlabs.org/pipermail/linuxppc-embedded/2006-November/025108.html
> 
> but my SMC didnt work, without this patch, it works fine. I think that
> the pram_base must be set the follwing way:
> 
Thanks for the patch, but I guess it requires a bit of investigation first since 
we cannot just drop ioremapped offset and get back to raw one that has been returned by 
platform_get_....

We require ioremap stuff for powerpc approach, and I think we'd have to figure out why 
ioremapped address did not satisfy smc (and I'll try on my 8xx).

Guessing we are speaking about arch/ppc/ domain upper...

> diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c
> b/drivers/serial/cpm_uart/cpm_uart_core.c
> index ea85f6a..76ab6e5 100644
> --- a/drivers/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_core.c
> @@ -1025,6 +1025,7 @@ int cpm_uart_drv_get_platform_data(struct
> platform_device *pdev, int is_con)
>  	struct uart_cpm_port *pinfo;
>  	int line;
>  	u32 mem, pram, pram_base;
> +	int	base;
>  
>  	idx = pdata->fs_no = fs_uart_get_id(pdata);
>  
> @@ -1050,11 +1051,12 @@ int cpm_uart_drv_get_platform_data(struct
> platform_device *pdev, int is_con)
>  	if (!(r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram")))
>  		return -EINVAL;
>  	pram = (u32)ioremap(r->start, r->end - r->start + 1);
> -
> +	base = r->start;
> +	
>  	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram_base");
>  	if (r) {
>  		pram_base = r->start;
> -		out_be16((u16 *)pram_base, pram & 0xffff);
> +		out_be16((u16 *)pram_base, base & 0xffff);
>  	}
>  
>  	if(idx > fsid_smc2_uart) {
> 
> 
> with this patch it works fine :-)
> 
> Best regards
> Heiko
> 
> -- 
> DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
> Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
> 


-- 
Sincerely, 
Vitaly
