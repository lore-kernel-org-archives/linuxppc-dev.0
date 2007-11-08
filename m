Return-Path: <SRS0=zNDV=QB=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 70CF8DDDFE
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 19:46:43 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/6] ibm_newemac: Add ET1011c PHY support
Date: Thu, 8 Nov 2007 09:41:46 +0100
References: <20071108080729.E09F7DDDFB@ozlabs.org>
In-Reply-To: <20071108080729.E09F7DDDFB@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711080941.46894.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 08 November 2007, Benjamin Herrenschmidt wrote:
> This adds support for the ET1011c PHY as found on the taishan
> board.
>
> The code comes from the kernel distributed with the board by
> AMCC and developped by DENX.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> And don't ask me about using phylib, it's in plan :-)
>
>  drivers/net/ibm_newemac/phy.c |   37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> Index: linux-work/drivers/net/ibm_newemac/phy.c
> ===================================================================
> --- linux-work.orig/drivers/net/ibm_newemac/phy.c	2007-11-08
> 15:11:30.000000000 +1100 +++
> linux-work/drivers/net/ibm_newemac/phy.c	2007-11-08 15:11:54.000000000
> +1100 @@ -327,6 +327,42 @@ static int m88e1111_init(struct mii_phy
>  	return  0;
>  }
>
> +static int et1011c_init(struct mii_phy *phy)
> +{
> +        u16 reg_short;
> +
> +        reg_short = (u16)(phy_read(phy,0x16));
> +        reg_short &= ~(0x7);
> +        reg_short |= 0x6;       /* RGMII Trace Delay*/
> +        phy_write(phy, 0x16, reg_short);
> +
> +        reg_short = (u16)(phy_read(phy, 0x17));
> +        reg_short &= ~(0x40);
> +        phy_write(phy, 0x17, reg_short);
> +
> +        phy_write(phy,0x1c,0x74f0);
> +        return 0;
> +}
> +
> +static struct mii_phy_ops et1011c_phy_ops = {
> +        .init           = et1011c_init,
> +        .setup_aneg     = genmii_setup_aneg,
> +        .setup_forced   = genmii_setup_forced,
> +        .poll_link      = genmii_poll_link,
> +        .read_link      = genmii_read_link
> +};
> +
> +static struct mii_phy_def et1011c_phy_def = {
> +        .phy_id         = 0x0282f000,
> +        .phy_id_mask    = 0x0fffff00,
> +        .name           = "ET1011C Gigabit Ethernet",
> +        .ops            = &et1011c_phy_ops
> +};
> +
> +
> +
> +
> +

Nitpicking: Too many empty lines for my taste.

Other then that:

Acked-by: Stefan Roese <sr@denx.de>

Thanks.

Best regards,
Stefan
