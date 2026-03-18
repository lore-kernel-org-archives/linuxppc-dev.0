Return-Path: <linuxppc-dev+bounces-18362-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944C4103E183
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 14:47:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbWrL1cxkz2yjV;
	Thu, 19 Mar 2026 01:47:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773845234;
	cv=none; b=RNp1QmJQfM26ZzU9bDX5/2otSLkzv0BV7gXFIbQ3z89TBSPCnCTID4DHoLXQ8/NwGqjRnopaSzIIfQYovCZXmTCHQKvDNVovYeYyz/erF17hUVdAqpNcvE0aGa6mnKKLKZsl3Lg+ArJ9XDCLICKKAzIG6Ke3iyPzH3R2V4WbOz2BLuvbN09cPZVQUm2rbT/fTlm6vHfcSI/Cp+qBvFNAke3Eb9Ba+brfgBcpM+2hqpgSoRuPT3x6F/CKiZkWQPWO3oo2JGKCsrdPfeDDDPL4iAVCDrQN7MoQkrpmghSaf+Heu+LzxvMM/XncSqSDODfX8pkw+DhL1AkoNCDTzNO/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773845234; c=relaxed/relaxed;
	bh=OAUsju3w6+seco0DBwBvgWL+6NjPkS7WGoDZc8oY+gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRkAOHMi450butkeA/wyhW6zOy8OG2tH5wt7Qlo1H9qG5801flarD7T9d+FTw9Zk8xQHhnSPP8JY9kVP4ba4OKBsZgUhYFJ8JRpiNV76lLbo7o8YLbDa9UJaFg2lO9KgKdtxfEcvaz/cObC32/Qc1zGLLGpmnzPNE8kk3RtsIYgiW+p6K3lZ3rLAUa/Vh8jH1Vp5NPoswoVWOMgH/oZpZrW4bHNCrmWeB2DvtafJSFx/6q9m39TsJ9Htr7s6CmASwkLVaSXtUKQm/lNxADj8UoikgL8DMdVDkk/xNJ09kGUq+H8i8X+XNjRBavxM6KvZTjnCOPGd3odrxdfC3t9Mug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lNEXEXFH; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lNEXEXFH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbWrK1XKvz2ygd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 01:47:13 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1F82B42D8D;
	Wed, 18 Mar 2026 14:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CE2C19421;
	Wed, 18 Mar 2026 14:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773845231;
	bh=sOGhleK/nOFjGylRZPX91uK0mo+r2D9Kaglk5zGCV1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNEXEXFHtHqqr5+jSR8/WPIZ+t95wCNVVoFyFK6S3X5ngF1Z0hz/dGpE0/8EVWyzB
	 7mFxzM+0bUnUaAhTlEuc+9AknVBfSI9p5RHBxJWrrAvHGw/j+0E6tA3hZYfaqyW8OI
	 3qeaNgswbe4lvpsnrdMYYgKytxx1PEPv7MSrbOGaa3g8CmFStN9NXTdAjn8hQtLhjO
	 8VQ1bPGUgw/WxjL8g9punuvgQVYnky6+kVtBTz+q+WuZUomr0+eYyGnze5a5zLO7rs
	 Xul8ho2Ds77F5cnV2Odc+IaNBY2ZPyljYTpCY3FqWe/wRWhVHahuEr8FNWykrSONbu
	 lV9haUJJi9Hxg==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	f.fainelli@gmail.com,
	krzk+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux@armlinux.org.uk,
	pabeni@redhat.com,
	conor+dt@kernel.org,
	chleroy@kernel.org,
	edumazet@google.com,
	frank.li@nxp.com,
	kuba@kernel.org,
	vladimir.oltean@nxp.com,
	linuxppc-dev@lists.ozlabs.org,
	robh@kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch
Subject: Re: [net-next,11/14] net: dsa: netc: add phylink MAC operations
Date: Wed, 18 Mar 2026 14:46:51 +0000
Message-ID: <20260318144651.1891670-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316094152.1558671-12-wei.fang@nxp.com>
References: <20260316094152.1558671-12-wei.fang@nxp.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: netc: add phylink MAC operations

This commit adds phylink MAC operations to the NETC DSA switch driver,
including support for different PHY interface modes (RGMII, RMII, MII,
REVMII, SGMII, 2500BASE-X).

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index bc7d48b99610..884ee899fc89 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -595,10 +595,221 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
>  	priv->revision = val & IPBRR0_IP_REV;
>  }
>
> +static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
> +				  struct phylink_config *config)
> +{
> +	struct netc_switch *priv = ds->priv;
> +
> +	priv->info->phylink_get_caps(port, config);
> +}
> +
> +static void netc_port_set_mac_mode(struct netc_port *np,
> +				   unsigned int mode,
> +				   phy_interface_t phy_mode)
> +{
> +	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_ENA;
> +	u32 val = 0;
> +
> +	switch (phy_mode) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		val |= IFMODE_RGMII;
> +		/* Enable auto-negotiation for the MAC if its
> +		 * RGMII interface supports In-Band status.
> +		 */
> +		if (phylink_autoneg_inband(mode))
> +			val |= PM_IF_MODE_ENA;
> +		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		val |= IFMODE_RMII;
> +		break;
> +	case PHY_INTERFACE_MODE_REVMII:
> +		val |= PM_IF_MODE_REVMII;
> +		fallthrough;
> +	case PHY_INTERFACE_MODE_MII:
> +		val |= IFMODE_MII;
> +		break;

Does the mask need to include PM_IF_MODE_REVMII? Looking at
netc_port_set_mac_mode(), the mask is set to:

    u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_ENA;

which expands to GENMASK(2,0) | BIT(15) = 0x8007. When the REVMII
case sets val |= PM_IF_MODE_REVMII (BIT(3)), this makes val = 0x9.

In netc_mac_port_rmw(), there's a check:

    WARN_ON((mask | val) != mask)

This check would fire on every REVMII configuration since 0x800F != 0x8007.

Additionally, REVMII is reachable because imx94_switch_phylink_get_caps()
advertises PHY_INTERFACE_MODE_REVMII as supported for port 2. When
transitioning FROM REVMII to another mode, PM_IF_MODE_REVMII (BIT(3))
won't be cleared since it's not in the mask, leaving stale configuration.

Should the mask be:

    u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII | PM_IF_MODE_ENA;

> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		val |= IFMODE_SGMII;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
> +}

[ ... ]

> +static void netc_port_force_set_rgmii_mac(struct netc_port *np,
> +					  int speed, int duplex)
> +{
> +	u32 mask, val;
> +
> +	mask = PM_IF_MODE_ENA | PM_IF_MODE_SSP | PM_IF_MODE_HD |
> +	       PM_IF_MODE_M10 | PM_IF_MODE_REVMII;
> +
> +	switch (speed) {
> +	default:
> +	case SPEED_1000:
> +		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_1G);
> +		break;
> +	case SPEED_100:
> +		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_100M);
> +		break;
> +	case SPEED_10:
> +		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_10M);
> +		break;
> +	}
> +
> +	if (duplex != DUPLEX_FULL)
> +		val |= PM_IF_MODE_HD;
> +
> +	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
> +}
> +
> +static void net_port_set_rmii_mii_mac(struct netc_port *np,

This isn't a bug, but should this function be named
netc_port_set_rmii_mii_mac() instead of net_port_set_rmii_mii_mac()?
All other functions in this driver use the netc_ prefix
(netc_port_set_speed, netc_port_force_set_rgmii_mac,
netc_port_set_mac_mode, etc.).

> +				      int speed, int duplex)
> +{
> +	u32 mask, val = 0;
> +
> +	mask = PM_IF_MODE_ENA | PM_IF_MODE_SSP | PM_IF_MODE_HD |
> +	       PM_IF_MODE_M10;
> +
> +	if (speed == SPEED_10)
> +		val |= PM_IF_MODE_M10;
> +
> +	if (duplex != DUPLEX_FULL)
> +		val |= PM_IF_MODE_HD;
> +
> +	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
> +}

[ ... ]

> +static void netc_mac_link_up(struct phylink_config *config,
> +			     struct phy_device *phy, unsigned int mode,
> +			     phy_interface_t interface, int speed,
> +			     int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct netc_port *np;
> +
> +	np = NETC_PORT(dp->ds, dp->index);
> +	netc_port_set_speed(np, speed);
> +
> +	if (phy_interface_mode_is_rgmii(interface) &&
> +	    !phylink_autoneg_inband(mode)) {
> +		netc_port_force_set_rgmii_mac(np, speed, duplex);
> +	}
> +
> +	if (interface == PHY_INTERFACE_MODE_RMII ||
> +	    interface == PHY_INTERFACE_MODE_REVMII ||
> +	    interface == PHY_INTERFACE_MODE_MII) {
> +		net_port_set_rmii_mii_mac(np, speed, duplex);
> +	}
> +
> +	netc_port_set_hd_flow_control(np, duplex == DUPLEX_HALF);
> +	netc_port_mac_rx_enable(np);
> +}
> +
> +static void netc_mac_link_down(struct phylink_config *config,
> +			       unsigned int mode,
> +			       phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +
> +	netc_port_mac_rx_graceful_stop(NETC_PORT(dp->ds, dp->index));
> +}
> +
> +static const struct phylink_mac_ops netc_phylink_mac_ops = {
> +	.mac_config		= netc_mac_config,
> +	.mac_link_up		= netc_mac_link_up,
> +	.mac_link_down		= netc_mac_link_down,
> +};
> +
>  static const struct dsa_switch_ops netc_switch_ops = {
>  	.get_tag_protocol		= netc_get_tag_protocol,
>  	.setup				= netc_setup,
>  	.teardown			= netc_teardown,
> +	.phylink_get_caps		= netc_phylink_get_caps,
>  };
>
>  static int netc_switch_probe(struct pci_dev *pdev,
> @@ -639,6 +850,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
>  	ds->num_ports = priv->info->num_ports;
>  	ds->num_tx_queues = NETC_TC_NUM;
>  	ds->ops = &netc_switch_ops;
> +	ds->phylink_mac_ops = &netc_phylink_mac_ops;
>  	ds->priv = priv;
>
>  	priv->ds = ds;

[ ... ]

