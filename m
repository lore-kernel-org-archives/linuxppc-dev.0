Return-Path: <richardcochran@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxBK3hgtzF11V
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 23:49:25 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id w17-v6so3917372pll.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2018 06:49:25 -0700 (PDT)
Date: Mon, 4 Jun 2018 06:49:20 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] dpaa_eth: add support for hardware timestamping
Message-ID: <20180604134920.ezhe6jz5ntpnqyzj@localhost>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
 <20180604070837.19265-10-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180604070837.19265-10-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 04, 2018 at 03:08:36PM +0800, Yangbo Lu wrote:

> +if FSL_DPAA_ETH
> +config FSL_DPAA_ETH_TS
> +	bool "DPAA hardware timestamping support"
> +	select PTP_1588_CLOCK_QORIQ
> +	default n
> +	help
> +	  Enable DPAA hardware timestamping support.
> +	  This option is useful for applications to get
> +	  hardware time stamps on the Ethernet packets
> +	  using the SO_TIMESTAMPING API.
> +endif

You should drop this #ifdef.  In general, if a MAC supports time
stamping and PHC, then the driver support should simply be compiled
in.

[ When time stamping incurs a large run time performance penalty to
  non-PTP users, then it might make sense to have a Kconfig option to
  disable it, but that doesn't appear to be the case here. ]

> @@ -1615,6 +1635,24 @@ static int dpaa_eth_refill_bpools(struct dpaa_priv *priv)
>  	skbh = (struct sk_buff **)phys_to_virt(addr);
>  	skb = *skbh;
>  
> +#ifdef CONFIG_FSL_DPAA_ETH_TS
> +	if (priv->tx_tstamp &&
> +	    skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {

This condition fits on one line easily.

> +		struct skb_shared_hwtstamps shhwtstamps;
> +		u64 ns;

Local variables belong at the top of the function.

> +		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
> +
> +		if (!dpaa_get_tstamp_ns(priv->net_dev, &ns,
> +					priv->mac_dev->port[TX],
> +					(void *)skbh)) {
> +			shhwtstamps.hwtstamp = ns_to_ktime(ns);
> +			skb_tstamp_tx(skb, &shhwtstamps);
> +		} else {
> +			dev_warn(dev, "dpaa_get_tstamp_ns failed!\n");
> +		}
> +	}
> +#endif
>  	if (unlikely(qm_fd_get_format(fd) == qm_fd_sg)) {
>  		nr_frags = skb_shinfo(skb)->nr_frags;
>  		dma_unmap_single(dev, addr, qm_fd_get_offset(fd) +
> @@ -2086,6 +2124,14 @@ static int dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
>  	if (unlikely(err < 0))
>  		goto skb_to_fd_failed;
>  
> +#ifdef CONFIG_FSL_DPAA_ETH_TS
> +	if (priv->tx_tstamp &&
> +	    skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {

One line please.

> +		fd.cmd |= FM_FD_CMD_UPD;
> +		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +	}
> +#endif
> +
>  	if (likely(dpaa_xmit(priv, percpu_stats, queue_mapping, &fd) == 0))
>  		return NETDEV_TX_OK;
>  

Thanks,
Richard
