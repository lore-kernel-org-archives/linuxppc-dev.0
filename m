Return-Path: <miltonm@bga.com>
Received: from kcout01.prserv.net (kcout01.prserv.net [12.154.55.31])
	by ozlabs.org (Postfix) with ESMTP id DB073DDEFA
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 00:16:31 +1000 (EST)
In-Reply-To: <20070907092143.GB32102@lixom.net>
References: <20070905024417.GE27139@lixom.net>
	<20070907092143.GB32102@lixom.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <326829233f0e99b0e0404241f5faaa7a@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH v2] powerpc: Add workaround for MPICs with broken register
	reads
Date: Fri, 7 Sep 2007 09:11:52 -0500
To: Olof Johansson <olof@lixom.net>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 7, 2007, at 4:21 AM, Olof Johansson wrote:

> Some versions of PWRficient 1682M have an interrupt controller in which
> the first register in each pair for interrupt sources doesn't always
> read with the right polarity/sense values.
>
> To work around this, keep a software copy of the register instead. 
> Since
> it's not modified from the mpic itself, it's a feasible solution. 
> Still,
> keep it under a config option to avoid wasting memory on other 
> platforms.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
>
>
> diff --git a/arch/powerpc/platforms/Kconfig 
> b/arch/powerpc/platforms/Kconfig
> index 041df77..f2e7049 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -137,6 +137,18 @@ config MPIC_U3_HT_IRQS
>  	depends on PPC_MAPLE
>  	default y
>
> +config MPIC_BROKEN_REGREAD
> +	bool "MPIC workaround for broken register reads"
> +	depends on MPIC
> +	help
> +	  Say Y here to enable a MPIC driver workaround for some chips that
> +	  have a bug that causes some interrupt source information to not
> +	  read back properly. It is safe to use on other chips as well, but
> +	  enabling it uses about 8KB of memory to keep copies of the register
> +	  contents in software.
> +
> +	  Say N if you are unsure.
> +
>

I'm sorry, I didn't mean to imply it should be asked / selectable, just 
that the help should be provided.   I won't object to leaving it except 
that it asks the average user unnecessary questions.   In other words, 
drop the question after bool.

milton
