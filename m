Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2684467B6C
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 14:34:24 +1000 (EST)
In-Reply-To: <20060926174651.032a474e.kim.phillips@freescale.com>
References: <20060926174651.032a474e.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B35FD5A1-2C71-41E2-A014-A2C8D37F10C2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] enable generic rtc hook for the MPC8349 mITX
Date: Tue, 26 Sep 2006 23:34:43 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 26, 2006, at 5:46 PM, Kim Phillips wrote:

> enable generic rtc hook for the MPC8349 mITX.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
>
> ---
>  arch/powerpc/platforms/83xx/mpc834x_itx.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/ 
> powerpc/platforms/83xx/mpc834x_itx.c
> index 969fbb6..8c676d7 100644
> --- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
> +++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> @@ -109,6 +109,10 @@ static int __init mpc834x_itx_probe(void
>  	return 1;
>  }
>
> +#ifdef CONFIG_RTC_CLASS
> +late_initcall(rtc_class_hookup);
> +#endif

Any reason we can't just do this in setup_arch?

- k

> +
>  define_machine(mpc834x_itx) {
>  	.name			= "MPC834x ITX",
>  	.probe			= mpc834x_itx_probe,
> -- 
> 1.4.2.1
