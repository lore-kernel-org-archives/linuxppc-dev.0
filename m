Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3DA72B7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 23:35:07 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id C95D8DDDA1
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 23:35:06 +1000 (EST)
Date: Tue, 14 Jul 2009 17:35:05 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: Fix ethernet link detection on
	MPC8569E-MDS boards
Message-ID: <20090714133505.GB28970@oksana.dev.rtsoft.ru>
References: <20090624163028.GA18825@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090624163028.GA18825@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 24, 2009 at 08:30:28PM +0400, Anton Vorontsov wrote:
> Linux isn't able to detect link changes on ethernet ports that were
> used by U-Boot. This is because U-Boot wrongly clears interrupt
> polarity bit (INTPOL, 0x400) in the extended status register (EXT_SR,
> 0x1b) of Marvell PHYs.
> 
> There is no easy way for PHY drivers to know IRQ line polarity (we
> could extract it from the device tree and pass it to phydevs, but
> that'll be quite a lot of work), so for now just reset the PHYs to
> their default states.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

I think this should be safe for 2.6.31...

Thanks,

>  arch/powerpc/platforms/85xx/mpc85xx_mds.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> index 3268c95..34664c0 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> @@ -223,6 +223,19 @@ static void __init mpc85xx_mds_setup_arch(void)
>  			/* Turn UCC1 & UCC2 on */
>  			setbits8(&bcsr_regs[8], BCSR_UCC1_GETH_EN);
>  			setbits8(&bcsr_regs[9], BCSR_UCC2_GETH_EN);
> +		} else if (machine_is(mpc8569_mds)) {
> +#define BCSR7_UCC12_GETHnRST	(0x1 << 2)
> +#define BCSR8_UEM_MARVELL_RST	(0x1 << 1)
> +			/*
> +			 * U-Boot mangles interrupt polarity for Marvell PHYs,
> +			 * so reset built-in and UEM Marvell PHYs, this puts
> +			 * the PHYs into their normal state.
> +			 */
> +			clrbits8(&bcsr_regs[7], BCSR7_UCC12_GETHnRST);
> +			setbits8(&bcsr_regs[8], BCSR8_UEM_MARVELL_RST);
> +
> +			setbits8(&bcsr_regs[7], BCSR7_UCC12_GETHnRST);
> +			clrbits8(&bcsr_regs[8], BCSR8_UEM_MARVELL_RST);
>  		}
>  		iounmap(bcsr_regs);
>  	}
> -- 
> 1.6.3.1
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
