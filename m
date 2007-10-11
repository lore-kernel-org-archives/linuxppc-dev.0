Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 24051DE02E
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 06:09:45 +1000 (EST)
Date: Thu, 11 Oct 2007 15:09:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 3/9 v2] add Freescale SerDes PHY support
Message-ID: <20071011200938.GC4247@loki.buserror.net>
References: <1192096425-30192-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192096425-30192-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 11, 2007 at 05:53:45PM +0800, Li Yang wrote:
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index 19d4628..e89f803 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -291,4 +291,8 @@ config FSL_ULI1575
>  	  Freescale reference boards. The boards all use the ULI in pretty
>  	  much the same way.
>  
> +config FSL_SERDES
> +	bool
> +	default n

"default n" is the default -- no need to specify it explicitly.

> +		/* Configure SRDSCR1 */
> +		tmp = in_be32(regs + FSL_SRDSCR1_OFFS);
> +		tmp &= ~FSL_SRDSCR1_PLLBW;
> +		out_be32(regs + FSL_SRDSCR1_OFFS, tmp);

clrbits32?

> +		/* Configure SRDSCR2 */
> +		tmp = in_be32(regs + FSL_SRDSCR2_OFFS);
> +		tmp &= ~FSL_SRDSCR2_SEIC_MASK;
> +		tmp |= FSL_SRDSCR2_SEIC_SATA;
> +		out_be32(regs + FSL_SRDSCR2_OFFS, tmp);

clrsetbits_be32?

-Scott
