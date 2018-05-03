Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cFlM0XbMzF2Vj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 23:06:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [PATCH NEXT 3/4] powerpc/pasemi: Add Nemo board device init code.
In-Reply-To: <4b3d20c0900.2ef0ae17@auth.smtp.1and1.co.uk>
References: <4b3d20c0900.2ef0ae17@auth.smtp.1and1.co.uk>
Date: Thu, 03 May 2018 23:06:22 +1000
Message-ID: <87in84anxt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Darren Stevens <darren@stevens-zone.net> writes:

> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
> index c583c17..8d3664f 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -73,6 +73,19 @@ static void __noreturn pas_restart(char *cmd)
>  		out_le32(reset_reg, 0x6000000);
>  }
>  
> +#ifdef CONFIG_PPC_PASEMI_NEMO
> +/* A flag to indicate we are running on Nemo */
> +static bool nemo_board = false;
> +
> +void pas_shutdown(void)
> +{
> +	/* Set the PLD bit that makes the SB600 think the power button is being pressed */
> +	void __iomem *pld_map = ioremap(0xf5000000,4096);

I guess that's not in the device tree anywhere?

> +	while (1)
> +		out_8(pld_map+7,0x01);
> +}
> +#endif
> +
>  #ifdef CONFIG_SMP
>  static arch_spinlock_t timebase_lock;
>  static unsigned long timebase;
> @@ -492,6 +505,20 @@ static inline void pasemi_pcmcia_init(void)
>  	{},
>  };
>  
> +#ifdef CONFIG_PPC_PASEMI_NEMO
> +static struct resource rtc_resource[] = {{
> +	.name = "rtc",
> +	.start = 0x70,
> +	.end = 0x71,
> +	.flags = IORESOURCE_IO,
> +}, {
> +	.name = "rtc",
> +	.start = 8,
> +	.end = 8,
> +	.flags = IORESOURCE_IRQ,
> +}};
> +#endif

Same question?

cheers
