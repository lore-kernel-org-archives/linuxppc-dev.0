Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 955CCB6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 00:43:51 +1100 (EST)
Received: by wgbdt14 with SMTP id dt14so2583044wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 05:43:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1329466058-15969-1-git-send-email-dhdang@apm.com>
References: <1329466058-15969-1-git-send-email-dhdang@apm.com>
Date: Wed, 29 Feb 2012 08:43:46 -0500
Message-ID: <CA+5PVA5hciQSvfkodX-oP_kUZueiTp=0+t8X_0iHQ+ehU0ecOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/44x: Add more changes for APM821XX EMAC driver
From: Josh Boyer <jwboyer@gmail.com>
To: Duc Dang <dhdang@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev <netdev@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 17, 2012 at 3:07 AM, Duc Dang <dhdang@apm.com> wrote:
> This patch includes:
>
> =A0Configure EMAC PHY clock source (clock from PHY or internal clock).
>
> =A0Do not advertise PHY half duplex capability as APM821XX EMAC does not
> support half duplex mode.
>
> =A0Add changes to support configuring jumbo frame for APM821XX EMAC.
>
> Signed-off-by: Duc Dang <dhdang@apm.com>

This should have been sent to netdev.  CC'ing them now.

Ben and David, I can take this change through the 4xx tree if it looks OK t=
o
both of you.  The pre-requisite DTS patch will go through my tree, so it mi=
ght
make sense to keep them together.

josh

> ---
>  drivers/net/ethernet/ibm/emac/core.c |   26 +++++++++++++++++++++++++-
>  drivers/net/ethernet/ibm/emac/core.h |   13 +++++++++++--
>  drivers/net/ethernet/ibm/emac/emac.h |    5 ++++-
>  3 files changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/=
ibm/emac/core.c
> index ed79b2d..de620f1 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -434,6 +434,11 @@ static inline u32 emac_iff2rmr(struct net_device *nd=
ev)
>  	else if (!netdev_mc_empty(ndev))
>  		r |=3D EMAC_RMR_MAE;
>
> +	if (emac_has_feature(dev, EMAC_APM821XX_REQ_JUMBO_FRAME_SIZE)) {
> +		r &=3D ~EMAC4_RMR_MJS_MASK;
> +		r |=3D EMAC4_RMR_MJS(ndev->mtu);
> +	}
> +
>  	return r;
>  }
>
> @@ -965,6 +970,7 @@ static int emac_resize_rx_ring(struct emac_instance *=
dev, int new_mtu)
>  	int rx_sync_size =3D emac_rx_sync_size(new_mtu);
>  	int rx_skb_size =3D emac_rx_skb_size(new_mtu);
>  	int i, ret =3D 0;
> +	int mr1_jumbo_bit_change =3D 0;
>
>  	mutex_lock(&dev->link_lock);
>  	emac_netif_stop(dev);
> @@ -1013,7 +1019,14 @@ static int emac_resize_rx_ring(struct emac_instanc=
e *dev, int new_mtu)
>  	}
>   skip:
>  	/* Check if we need to change "Jumbo" bit in MR1 */
> -	if ((new_mtu > ETH_DATA_LEN) ^ (dev->ndev->mtu > ETH_DATA_LEN)) {
> +	if (emac_has_feature(dev, EMAC_APM821XX_REQ_JUMBO_FRAME_SIZE))
> +		mr1_jumbo_bit_change =3D (new_mtu > ETH_DATA_LEN) ||
> +				(dev->ndev->mtu > ETH_DATA_LEN);
> +	else
> +		mr1_jumbo_bit_change =3D (new_mtu > ETH_DATA_LEN) ^
> +				(dev->ndev->mtu > ETH_DATA_LEN);
> +
> +	if (mr1_jumbo_bit_change) {
>  		/* This is to prevent starting RX channel in emac_rx_enable() */
>  		set_bit(MAL_COMMAC_RX_STOPPED, &dev->commac.flags);
>
> @@ -2471,6 +2484,7 @@ static int __devinit emac_init_phy(struct emac_inst=
ance *dev)
>
>  	/* Disable any PHY features not supported by the platform */
>  	dev->phy.def->features &=3D ~dev->phy_feat_exc;
> +	dev->phy.features &=3D ~dev->phy_feat_exc;
>
>  	/* Setup initial link parameters */
>  	if (dev->phy.features & SUPPORTED_Autoneg) {
> @@ -2568,6 +2582,10 @@ static int __devinit emac_init_config(struct emac_=
instance *dev)
>  		if (of_device_is_compatible(np, "ibm,emac-405ex") ||
>  		    of_device_is_compatible(np, "ibm,emac-405exr"))
>  			dev->features |=3D EMAC_FTR_440EP_PHY_CLK_FIX;
> +		if (of_device_is_compatible(np, "ibm,emac-apm821xx"))
> +			dev->features |=3D (EMAC_APM821XX_REQ_JUMBO_FRAME_SIZE
> +					| EMAC_FTR_APM821XX_NO_HALF_DUPLEX
> +					| EMAC_FTR_460EX_PHY_CLK_FIX);
>  	} else if (of_device_is_compatible(np, "ibm,emac4")) {
>  		dev->features |=3D EMAC_FTR_EMAC4;
>  		if (of_device_is_compatible(np, "ibm,emac-440gx"))
> @@ -2818,6 +2836,12 @@ static int __devinit emac_probe(struct platform_de=
vice *ofdev)
>  	dev->stop_timeout =3D STOP_TIMEOUT_100;
>  	INIT_DELAYED_WORK(&dev->link_work, emac_link_timer);
>
> +	/* Some SoCs like APM821xx does not support Half Duplex mode. */
> +	if (emac_has_feature(dev, EMAC_FTR_APM821XX_NO_HALF_DUPLEX))
> +		dev->phy_feat_exc =3D (SUPPORTED_1000baseT_Half
> +					| SUPPORTED_100baseT_Half
> +					| SUPPORTED_10baseT_Half);
> +
>  	/* Find PHY if any */
>  	err =3D emac_init_phy(dev);
>  	if (err !=3D 0)
> diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/ethernet/=
ibm/emac/core.h
> index fa3ec57..9dea85a 100644
> --- a/drivers/net/ethernet/ibm/emac/core.h
> +++ b/drivers/net/ethernet/ibm/emac/core.h
> @@ -325,7 +325,14 @@ struct emac_instance {
>   * Set if we need phy clock workaround for 460ex or 460gt
>   */
>  #define EMAC_FTR_460EX_PHY_CLK_FIX	0x00000400
> -
> +/*
> + * APM821xx requires Jumbo frame size set explicitly
> + */
> +#define EMAC_APM821XX_REQ_JUMBO_FRAME_SIZE	0x00000800
> +/*
> + * APM821xx does not support Half Duplex mode
> + */
> +#define EMAC_FTR_APM821XX_NO_HALF_DUPLEX	0x00001000
>
>  /* Right now, we don't quite handle the always/possible masks on the
>   * most optimal way as we don't have a way to say something like
> @@ -353,7 +360,9 @@ enum {
>  	    EMAC_FTR_NO_FLOW_CONTROL_40x |
>  #endif
>  	EMAC_FTR_460EX_PHY_CLK_FIX |
> -	EMAC_FTR_440EP_PHY_CLK_FIX,
> +	EMAC_FTR_440EP_PHY_CLK_FIX |
> +	EMAC_APM821XX_REQ_JUMBO_FRAME_SIZE |
> +	EMAC_FTR_APM821XX_NO_HALF_DUPLEX,
>  };
>
>  static inline int emac_has_feature(struct emac_instance *dev,
> diff --git a/drivers/net/ethernet/ibm/emac/emac.h b/drivers/net/ethernet/=
ibm/emac/emac.h
> index 1568278..36bcd69 100644
> --- a/drivers/net/ethernet/ibm/emac/emac.h
> +++ b/drivers/net/ethernet/ibm/emac/emac.h
> @@ -212,7 +212,10 @@ struct emac_regs {
>  #define EMAC4_RMR_RFAF_64_1024		0x00000006
>  #define EMAC4_RMR_RFAF_128_2048		0x00000007
>  #define EMAC4_RMR_BASE			EMAC4_RMR_RFAF_128_2048
> -
> +#if defined(CONFIG_APM821xx)
> +#define EMAC4_RMR_MJS_MASK              0x0001fff8
> +#define EMAC4_RMR_MJS(s)                (((s) << 3) & EMAC4_RMR_MJS_MASK=
)
> +#endif
>  /* EMACx_ISR & EMACx_ISER */
>  #define EMAC4_ISR_TXPE			0x20000000
>  #define EMAC4_ISR_RXPE			0x10000000
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
