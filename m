Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA3BBDDDF3
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 17:08:40 +1100 (EST)
In-Reply-To: <20070202045508.643066000@lixom.net>>
References: <20070202045448.145851000@lixom.net>>
	<20070202045508.643066000@lixom.net>>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9C45758A-F748-43B2-97F6-E27FE0AC0530@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [5/9] pasemi: Implement restart
Date: Fri, 2 Feb 2007 00:07:42 -0600
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 1, 2007, at 10:54 PM, Olof Johansson wrote:

> Implement reset on platforms/pasemi. Default is just to reset the
> cpu using the SDC registers.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
>
>
> Index: merge/arch/powerpc/platforms/pasemi/setup.c
> ===================================================================
> --- merge.orig/arch/powerpc/platforms/pasemi/setup.c
> +++ merge/arch/powerpc/platforms/pasemi/setup.c
> @@ -42,19 +42,13 @@
>
>  static void pas_restart(char *cmd)
>  {
> -	printk("restart unimplemented, looping...\n");
> -	for (;;) ;
> -}
> -
> -static void pas_power_off(void)
> -{
> -	printk("power off unimplemented, looping...\n");
> -	for (;;) ;
> -}
> -
> -static void pas_halt(void)
> -{
> -	pas_power_off();
> +	void __iomem *sdcreg;
> +	printk("Restarting...\n");
> +	/* XXXOJN This should maybe come out of the device tree */
> +	sdcreg = ioremap(0xfc101100, 4);

You can't do the ioremap here,  restart may get call an oops from  
interrupt context.

> +	while (1)
> +		out_le32(sdcreg, 0x6000000);
> +	/* No need to iounmap; never coming back */
>  }
>
>  #ifdef CONFIG_SMP
> @@ -220,8 +214,6 @@ define_machine(pas) {
>  	.init_IRQ		= pas_init_IRQ,
>  	.get_irq		= mpic_get_irq,
>  	.restart		= pas_restart,
> -	.power_off		= pas_power_off,
> -	.halt			= pas_halt,
>  	.get_boot_time		= pas_get_boot_time,
>  	.calibrate_decr		= generic_calibrate_decr,
>  	.check_legacy_ioport    = pas_check_legacy_ioport,
>
> --
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
