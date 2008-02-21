Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0D90CDDED4
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 06:48:04 +1100 (EST)
Message-ID: <47BDD587.9060206@freescale.com>
Date: Thu, 21 Feb 2008 13:48:23 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [POWERPC] 8xx: timebase frequency should not depend on
	bus-frequency
References: <20080221194508.GA12896@localhost.localdomain>
In-Reply-To: <20080221194508.GA12896@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
> index 184f998..0d9f75c 100644
> --- a/arch/powerpc/platforms/8xx/m8xx_setup.c
> +++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
> @@ -111,17 +111,12 @@ void __init mpc8xx_calibrate_decr(void)
>  
>  	/* Processor frequency is MHz.
>  	 */
> -	ppc_tb_freq = 50000000;
> -	if (!get_freq("bus-frequency", &ppc_tb_freq)) {
> -		printk(KERN_ERR "WARNING: Estimating decrementer frequency "
> -		                "(not found)\n");
> -	}
> -	ppc_tb_freq /= 16;
>  	ppc_proc_freq = 50000000;
>  	if (!get_freq("clock-frequency", &ppc_proc_freq))
>  		printk(KERN_ERR "WARNING: Estimating processor frequency "
>  		                "(not found)\n");
>  
> +	ppc_tb_freq = ppc_proc_freq / 16;

Shouldn't we just use the timebase-frequency property?

-Scott
