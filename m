Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0225967D0E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 09:05:12 +1100 (EST)
In-Reply-To: <20061207173541.GG22989@ld0162-tx32.am.freescale.net>
References: <20061207173541.GG22989@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DC219401-9766-4BFD-BA94-7BA1997D9530@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc: Call of_register_i2c_devices() for fsl-i2c.
Date: Thu, 7 Dec 2006 16:05:11 -0600
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 7, 2006, at 11:35 AM, Scott Wood wrote:

> Call of_register_i2c_devices() to register I2C devices on
> the device tree under an fsl-i2c node.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> This patch depends on David Brownell's patchset at
> http://lists.lm-sensors.org/pipermail/i2c/2006-November/000516.html
>
>  arch/powerpc/sysdev/fsl_soc.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/ 
> fsl_soc.c
> index ad31e56..a4d3c46 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -345,6 +345,8 @@ static int __init fsl_i2c_of_init(void)
>  						    fsl_i2c_platform_data));
>  		if (ret)
>  			goto unreg;
> +
> +		of_register_i2c_devices(np, i);
>  	}

You are assuming the bus number is the same as our index. This may  
not be true.

>  	return 0;
> -- 
> 1.4.2.3
>
>
>
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
