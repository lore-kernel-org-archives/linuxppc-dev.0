Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3C63CB7D0B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Apr 2010 02:21:18 +1000 (EST)
Date: Wed, 7 Apr 2010 11:21:09 -0500
From: Scott Wood <scottwood@freescale.com>
To: Manfred Rudigier <Manfred.Rudigier@omicron.at>
Subject: Re: [RFC PATCH net-next 2/4] gianfar: Added timer feature for eTSEC
Message-ID: <20100407162109.GA9220@loki.buserror.net>
References: <95DC1AA8EC908B48939B72CF375AA5E311A9F4E0@alice.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <95DC1AA8EC908B48939B72CF375AA5E311A9F4E0@alice.at.omicron.at>
Cc: "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
	"'sandeep.kumar@freescale.com'" <sandeep.kumar@freescale.com>,
	"'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 07, 2010 at 11:46:24AM +0200, Manfred Rudigier wrote:
>  	switch (config.tx_type) {
>  	case HWTSTAMP_TX_OFF:
> +		priv->hwts_tx_en = 0;
>  		break;
>  	case HWTSTAMP_TX_ON:
> +		if (!(priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER))
> +			return -ERANGE;
> +		priv->hwts_tx_en = 1;
>  		return -ERANGE;
>  	default:
>  		return -ERANGE;
> @@ -796,8 +802,12 @@ static int gfar_hwtstamp_ioctl(struct net_device *netdev,
>  
>  	switch (config.rx_filter) {
>  	case HWTSTAMP_FILTER_NONE:
> +		priv->hwts_rx_en = 0;
>  		break;
>  	default:
> +		if (!(priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER))
> +			return -ERANGE;
> +		priv->hwts_rx_en = 1;
>  		return -ERANGE;
>  	}

You need to acquire bflock (or avoid using bitfields for this), or you could
race with the setting of wol_en or rx_csum_enable.

-Scott
