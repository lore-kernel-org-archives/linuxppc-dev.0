Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B9F7C2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 09:11:07 +1000 (EST)
Message-ID: <1375830655.5600.24.camel@snotra.buserror.net>
Subject: Re: [PATCH] net/fsl_pq_mdio: fix handling of TBIPA register
From: Scott Wood <scottwood@freescale.com>
To: Lutz Jaenicke <ljaenicke@innominate.com>
Date: Tue, 6 Aug 2013 18:10:55 -0500
In-Reply-To: <1375379355-18594-1-git-send-email-ljaenicke@innominate.com>
References: <1375379355-18594-1-git-send-email-ljaenicke@innominate.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-01 at 19:49 +0200, Lutz Jaenicke wrote:
> The TBIPA register is part of gianfar's full register set. When starting
> from the MII registers, the start address of struct gfar needs to
> be determined via container_of().
> Experienced with mpc8313 and "fsl,gianfar-mdio" device tree entries.
> 
> Signed-off-by: Lutz Jaenicke <ljaenicke@innominate.com>
> ---
>  drivers/net/ethernet/freescale/fsl_pq_mdio.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
> index c93a056..9485fdb 100644
> --- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
> +++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
> @@ -193,7 +193,8 @@ static int fsl_pq_mdio_reset(struct mii_bus *bus)
>   */
>  static uint32_t __iomem *get_gfar_tbipa(void __iomem *p)
>  {
> -	struct gfar __iomem *enet_regs = p;
> +	struct gfar __iomem *enet_regs = 
> +		container_of(p, struct gfar, gfar_mii_regs);
>  
>  	return &enet_regs->tbipa;
>  }

Please send this to the netdev list/maintainer.

-Scott
