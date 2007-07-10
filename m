Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 0D9CFDDE05
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 18:26:46 +1000 (EST)
Message-ID: <46934496.40805@ru.mvista.com>
Date: Tue, 10 Jul 2007 12:34:30 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] xilinxfb: Parameterize xilinxfb platform device
	registration
References: <20070709235105.4826.79342.stgit@trillian>
In-Reply-To: <20070709235105.4826.79342.stgit@trillian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> This patch allows multiple xilinxfb devices to be registered and used
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> cc: Andrei Konovalov <akonovalov@ru.mvista.com>
> ---

Looks OK for me.

Thanks,
Andrei

>  arch/ppc/syslib/virtex_devices.c |   38 +++++++++++++++++++++++++-------------
>  1 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
> index 83f978f..9b473cf 100644
> --- a/arch/ppc/syslib/virtex_devices.c
> +++ b/arch/ppc/syslib/virtex_devices.c
> @@ -152,6 +152,21 @@
>  	}, \
>  }
>  
> +/*
> + * ML300/ML403 Video Device: shortcut macro for single instance
> + */
> +#define XPAR_TFT(num) { \
> +	.name = "xilinxfb", \
> +	.id = num, \
> +	.num_resources = 1, \
> +	.resource = (struct resource[]) { \
> +		{ \
> +			.start = XPAR_TFT_##num##_BASEADDR, \
> +			.end = XPAR_TFT_##num##_BASEADDR+7, \
> +			.flags = IORESOURCE_IO, \
> +		}, \
> +	}, \
> +}
>  
>  /* UART 8250 driver platform data table */
>  struct plat_serial8250_port virtex_serial_platform_data[] = {
> @@ -274,20 +289,17 @@ struct platform_device virtex_platform_devices[] = {
>  #endif
>  #endif
>  
> -	/* ML300/403 reference design framebuffer */
>  #if defined(XPAR_TFT_0_BASEADDR)
> -	{
> -		.name		= "xilinxfb",
> -		.id		= 0,
> -		.num_resources	= 1,
> -		.resource = (struct resource[]) {
> -			{
> -				.start	= XPAR_TFT_0_BASEADDR,
> -				.end	= XPAR_TFT_0_BASEADDR+7,
> -				.flags	= IORESOURCE_IO,
> -			},
> -		},
> -	},
> +	XPAR_TFT(0),
> +#endif
> +#if defined(XPAR_TFT_1_BASEADDR)
> +	XPAR_TFT(1),
> +#endif
> +#if defined(XPAR_TFT_2_BASEADDR)
> +	XPAR_TFT(2),
> +#endif
> +#if defined(XPAR_TFT_3_BASEADDR)
> +	XPAR_TFT(3),
>  #endif
>  };
>  
