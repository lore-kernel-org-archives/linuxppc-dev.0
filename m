Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 83D3CDDF45
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 08:26:50 +1000 (EST)
Date: Wed, 9 Apr 2008 17:37:28 -0500
From: Olof Johansson <olof@lixom.net>
To: Philippe De Muyter <phdm@macqel.be>
Subject: Re: [PATCH] fsl_soc : add support for m41t81 rtc chip
Message-ID: <20080409223728.GA8365@lixom.net>
References: <20080409222252.GA1006@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080409222252.GA1006@frolo.macqel>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Thu, Apr 10, 2008 at 12:22:52AM +0200, Philippe De Muyter wrote:
> Hello everybody,
> 
> Here is small patch allowing to use a m41t81 rtc chip on a FSL_SOC based
> board.
> 
> Signed-off-by: Philippe De Muyter <phdm@macqel.be>
> 
> --- a/arch/powerpc/sysdev/fsl_soc.c	2008-03-21 14:53:41.000000000 +0000
> +++ b/arch/powerpc/sysdev/fsl_soc.c	2008-03-26 12:08:25.000000000 +0000
> @@ -405,7 +405,10 @@
>  	{"dallas,ds1339",  "rtc-ds1307",  "ds1339",},
>  	{"dallas,ds1340",  "rtc-ds1307",  "ds1340",},
>  	{"stm,m41t00",     "rtc-ds1307",  "m41t00"},
> +#ifdef CONFIG_RTC_DRV_M41T80
> +	{"stm,m41t81",     "rtc-m41t80",  "m41t81"},
> +#endif

Don't add ifdef here. It doesn't hurt to have it in the table even if
the driver is not enabled.


-Olof
