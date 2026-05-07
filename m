Return-Path: <linuxppc-dev+bounces-20564-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1013CD343F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 12:53:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBBxx34SXz2xPb;
	Thu, 07 May 2026 22:53:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778158405;
	cv=none; b=EVrqt8nqJMyI0Cwvxm/NhtP2Lt9RGOTJJkuIZew3mvltFkh47/IjITykh2Zf4+PQKjEqqAG9v94GsxA4Hj/YjcX+qyDdIsCiIpDrKJO42DtUpEHg7z4nGheZCHoaxud82+LkTo+fq/q5pKN8AAqVe9rujhAO183um6AidssJT3PbxuHnnDw8jDan1sGZHqlIEegglCVsPQk3ADV0Sugw1IGpVjT1btyMuWdes9AmSu/RNybBt0v72TTE/HGFZSXxqiHgpSKth7ZzUV0JQEzycldbsXAoN/mPPA29Fr85bIC6ZhCMwIjFgfSppqaAv2kd2Pf8qyrrJ7riOa0bCP8OGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778158405; c=relaxed/relaxed;
	bh=rwIVVjmIEnqDiiPGwYTSnWAaq2tQIAapO4ksJdHV1KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jF9dfkf+MRkRtknfVqKZXk8swgTl6e/vy2HHGxK5PFSry12B7gpv9AqcwINa9tJtzaLL9heJwDrFBFqXruO5KuGS5CgpYo0qExijBaYEqDthwnaKNRIMerRwM59I4GflIIACbyiKQI/DMQg8jWvgNTTPjx3LPtBlvhXGT8OIVZUzWun6KAGT/bKIRNDPbDRfXpf4GzkmA2iDlbX0EaV/4pPcL9Mvkl0Ior02UTWbCmfusfKklXGnjhFWhApmMKVdPuK2Tn5B/Frs0dHxfFM1346dRVLjUyuAUeEJt+888D6fjsLpmIc5E5OTfWqpdr42p0ui2aIHYXSZhwwPZqKlsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FHUkH6Al; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=maxime.chevallier@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FHUkH6Al;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=maxime.chevallier@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 510 seconds by postgrey-1.37 at boromir; Thu, 07 May 2026 22:53:23 AEST
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBBxv19wqz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 22:53:21 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9D79F1A3556;
	Thu,  7 May 2026 12:44:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6829160495;
	Thu,  7 May 2026 12:44:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9109510819491;
	Thu,  7 May 2026 14:44:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778157885; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rwIVVjmIEnqDiiPGwYTSnWAaq2tQIAapO4ksJdHV1KA=;
	b=FHUkH6AlB5RFtdLF2lcGxWLZgfOI9EtcurYBu3XqwTTpEdVMSLQjgS+rK10L8XbULOb3Do
	4aFnlg0nHpiHjKvZzQJ0Bm3EoPlikdol42qr68oBNf8uB2zX7+l2FYK475GEFrK0efCbgF
	ZH/wa/ln0vaLISqeB7mS8BNMPuLHcjK4OpEu/lNYeQRw4wEOyIMKF6MOK8mFakNcTzwvUh
	I7C3C/VBIU66Vgog4dIWMMQ0ELmjR9NeciKj060OZYC3xAlgI05Ii2hwh8GbFgCKLoscrW
	J/Da+0HPYsswCYDYB7n26HOGY+49HJ9YLM8rl/U+9dGTVyz8qLH+BpBbgOHxOg==
Message-ID: <6397da3a-4643-4d9d-97e1-70f7a9b8d5d8@bootlin.com>
Date: Thu, 7 May 2026 14:44:34 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 11/15] net: dsa: netc: add phylink MAC
 operations
To: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 f.fainelli@gmail.com, frank.li@nxp.com, chleroy@kernel.org,
 horms@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-12-wei.fang@nxp.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260430024945.3413973-12-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 30/04/2026 04:49, Wei Fang wrote:
> Different versions of NETC switches have different numbers of ports and
> MAC capabilities. Add .phylink_get_caps() to struct netc_switch_info,
> allowing each NETC switch version to implement its own callback for
> obtaining MAC capabilities.
> 
> Implement the phylink_mac_ops callbacks: .mac_config(), .mac_link_up(),
> and .mac_link_down(). Note that flow-control configuration is not yet
> supported in .mac_link_up(), but will be implemented in a subsequent
> patch.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

The phylink part looks good to me,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/dsa/netc/netc_main.c      | 243 ++++++++++++++++++++++++++
>  drivers/net/dsa/netc/netc_platform.c  |  38 ++++
>  drivers/net/dsa/netc/netc_switch.h    |   4 +
>  drivers/net/dsa/netc/netc_switch_hw.h |  26 +++
>  4 files changed, 311 insertions(+)
> 
> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 90a2d8cfd3d2..edf50cb32cb6 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c
> @@ -44,6 +44,26 @@ static void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
>  		netc_port_wr(np, reg + NETC_PMAC_OFFSET, val);
>  }
>  
> +static void netc_mac_port_rmw(struct netc_port *np, u32 reg,
> +			      u32 mask, u32 val)
> +{
> +	u32 old, new;
> +
> +	if (is_netc_pseudo_port(np))
> +		return;
> +
> +	WARN_ON((mask | val) != mask);
> +
> +	old = netc_port_rd(np, reg);
> +	new = (old & ~mask) | val;
> +	if (new == old)
> +		return;
> +
> +	netc_port_wr(np, reg, new);
> +	if (np->caps.pmac)
> +		netc_port_wr(np, reg + NETC_PMAC_OFFSET, new);
> +}
> +
>  static void netc_port_get_capability(struct netc_port *np)
>  {
>  	u32 val;
> @@ -522,10 +542,232 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
>  	priv->revision = FIELD_GET(IPBRR0_IP_REV, val);
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
> +	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII;
> +	u32 val = 0;
> +
> +	switch (phy_mode) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		val |= IFMODE_RGMII;
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
> +
> +static void netc_mac_config(struct phylink_config *config, unsigned int mode,
> +			    const struct phylink_link_state *state)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +
> +	netc_port_set_mac_mode(NETC_PORT(dp->ds, dp->index), mode,
> +			       state->interface);
> +}
> +
> +static void netc_port_set_speed(struct netc_port *np, int speed)
> +{
> +	netc_port_rmw(np, NETC_PCR, PCR_PSPEED, PSPEED_SET_VAL(speed));
> +}
> +
> +static void netc_port_set_rgmii_mac(struct netc_port *np,
> +				    int speed, int duplex)
> +{
> +	u32 mask, val;
> +
> +	mask = PM_IF_MODE_SSP | PM_IF_MODE_HD | PM_IF_MODE_M10;
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
> +static void netc_port_set_rmii_mii_mac(struct netc_port *np,
> +				       int speed, int duplex)
> +{
> +	u32 mask, val = 0;
> +
> +	mask = PM_IF_MODE_SSP | PM_IF_MODE_HD | PM_IF_MODE_M10;
> +
> +	if (speed == SPEED_10)
> +		val |= PM_IF_MODE_M10;
> +
> +	if (duplex != DUPLEX_FULL)
> +		val |= PM_IF_MODE_HD;
> +
> +	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
> +}
> +
> +static void netc_port_mac_rx_enable(struct netc_port *np)
> +{
> +	netc_port_rmw(np, NETC_POR, POR_RXDIS, 0);
> +	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN,
> +			  PM_CMD_CFG_RX_EN);
> +}
> +
> +static void netc_port_wait_rx_empty(struct netc_port *np, int mac)
> +{
> +	u32 val;
> +
> +	/* PM_IEVENT_RX_EMPTY is a read-only bit, it is automatically set by
> +	 * hardware if RX FIFO is empty and no RX packet receive in process.
> +	 * And it is automatically cleared if RX FIFO is not empty or RX
> +	 * packet receive in process.
> +	 */
> +	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_RX_EMPTY,
> +			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
> +		dev_warn(np->switch_priv->dev,
> +			 "swp%d MAC%d: RX is not idle\n", np->dp->index, mac);
> +}
> +
> +static void netc_port_mac_rx_graceful_stop(struct netc_port *np)
> +{
> +	u32 val;
> +
> +	if (is_netc_pseudo_port(np))
> +		goto rx_disable;
> +
> +	if (np->caps.pmac) {
> +		netc_port_rmw(np, NETC_PM_CMD_CFG(1), PM_CMD_CFG_RX_EN, 0);
> +		netc_port_wait_rx_empty(np, 1);
> +	}
> +
> +	netc_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN, 0);
> +	netc_port_wait_rx_empty(np, 0);
> +
> +	if (read_poll_timeout(netc_port_rd, val, !(val & PSR_RX_BUSY),
> +			      100, 10000, false, np, NETC_PSR))
> +		dev_warn(np->switch_priv->dev, "swp%d RX is busy\n",
> +			 np->dp->index);
> +
> +rx_disable:
> +	netc_port_rmw(np, NETC_POR, POR_RXDIS, POR_RXDIS);
> +}
> +
> +static void netc_port_mac_tx_enable(struct netc_port *np)
> +{
> +	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_TX_EN,
> +			  PM_CMD_CFG_TX_EN);
> +	netc_port_rmw(np, NETC_POR, POR_TXDIS, 0);
> +}
> +
> +static void netc_port_wait_tx_empty(struct netc_port *np, int mac)
> +{
> +	u32 val;
> +
> +	/* PM_IEVENT_TX_EMPTY is a read-only bit, it is automatically set by
> +	 * hardware if TX FIFO is empty. And it is automatically cleared if
> +	 * TX FIFO is not empty.
> +	 */
> +	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_TX_EMPTY,
> +			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
> +		dev_warn(np->switch_priv->dev,
> +			 "swp%d MAC%d: TX FIFO is not empty\n",
> +			 np->dp->index, mac);
> +}
> +
> +static void netc_port_mac_tx_graceful_stop(struct netc_port *np)
> +{
> +	netc_port_rmw(np, NETC_POR, POR_TXDIS, POR_TXDIS);
> +
> +	if (is_netc_pseudo_port(np))
> +		return;
> +
> +	netc_port_wait_tx_empty(np, 0);
> +	if (np->caps.pmac)
> +		netc_port_wait_tx_empty(np, 1);
> +
> +	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_TX_EN, 0);
> +}
> +
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
> +	if (phy_interface_mode_is_rgmii(interface))
> +		netc_port_set_rgmii_mac(np, speed, duplex);
> +
> +	if (interface == PHY_INTERFACE_MODE_RMII ||
> +	    interface == PHY_INTERFACE_MODE_REVMII ||
> +	    interface == PHY_INTERFACE_MODE_MII)
> +		netc_port_set_rmii_mii_mac(np, speed, duplex);
> +
> +	netc_port_mac_tx_enable(np);
> +	netc_port_mac_rx_enable(np);
> +}
> +
> +static void netc_mac_link_down(struct phylink_config *config,
> +			       unsigned int mode,
> +			       phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct netc_port *np;
> +
> +	np = NETC_PORT(dp->ds, dp->index);
> +	netc_port_mac_rx_graceful_stop(np);
> +	netc_port_mac_tx_graceful_stop(np);
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
> @@ -564,6 +806,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
>  	ds->num_ports = priv->info->num_ports;
>  	ds->num_tx_queues = NETC_TC_NUM;
>  	ds->ops = &netc_switch_ops;
> +	ds->phylink_mac_ops = &netc_phylink_mac_ops;
>  	ds->priv = priv;
>  	priv->ds = ds;
>  
> diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
> index abd599ea9c8d..bb4f92d238cb 100644
> --- a/drivers/net/dsa/netc/netc_platform.c
> +++ b/drivers/net/dsa/netc/netc_platform.c
> @@ -11,8 +11,46 @@ struct netc_switch_platform {
>  	const struct netc_switch_info *info;
>  };
>  
> +static void imx94_switch_phylink_get_caps(int port,
> +					  struct phylink_config *config)
> +{
> +	config->mac_capabilities = MAC_1000FD;
> +
> +	switch (port) {
> +	case 0 ... 1:
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  config->supported_interfaces);
> +		config->mac_capabilities |= MAC_2500FD;
> +		fallthrough;
> +	case 2:
> +		config->mac_capabilities |= MAC_10 | MAC_100;
> +		__set_bit(PHY_INTERFACE_MODE_MII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_RMII,
> +			  config->supported_interfaces);
> +		/* Port 0 and 1 do not support REVMII */
> +		if (port == 2)
> +			__set_bit(PHY_INTERFACE_MODE_REVMII,
> +				  config->supported_interfaces);
> +
> +		phy_interface_set_rgmii(config->supported_interfaces);
> +		break;
> +	case 3: /* CPU port */
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +		config->mac_capabilities |= MAC_10FD | MAC_100FD |
> +					    MAC_2500FD;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static const struct netc_switch_info imx94_info = {
>  	.num_ports = 4,
> +	.phylink_get_caps = imx94_switch_phylink_get_caps,
>  };
>  
>  static const struct netc_switch_platform netc_platforms[] = {
> diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
> index dac19bfba02b..eb65c36ecead 100644
> --- a/drivers/net/dsa/netc/netc_switch.h
> +++ b/drivers/net/dsa/netc/netc_switch.h
> @@ -34,6 +34,7 @@ struct netc_switch;
>  
>  struct netc_switch_info {
>  	u32 num_ports;
> +	void (*phylink_get_caps)(int port, struct phylink_config *config);
>  };
>  
>  struct netc_port_caps {
> @@ -70,6 +71,9 @@ struct netc_switch {
>  	struct ntmp_user ntmp;
>  };
>  
> +#define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
> +#define NETC_PORT(ds, port_id)		(NETC_PRIV(ds)->ports[(port_id)])
> +
>  /* Write/Read Switch base registers */
>  #define netc_base_rd(r, o)		netc_read((r)->base + (o))
>  #define netc_base_wr(r, o, v)		netc_write((r)->base + (o), v)
> diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
> index 0419f7f9207e..7d9afb493053 100644
> --- a/drivers/net/dsa/netc/netc_switch_hw.h
> +++ b/drivers/net/dsa/netc/netc_switch_hw.h
> @@ -67,6 +67,14 @@
>  #define  PQOSMR_VQMP			GENMASK(19, 16)
>  #define  PQOSMR_QVMP			GENMASK(23, 20)
>  
> +#define NETC_POR			0x100
> +#define  POR_TXDIS			BIT(0)
> +#define  POR_RXDIS			BIT(1)
> +
> +#define NETC_PSR			0x104
> +#define  PSR_TX_BUSY			BIT(0)
> +#define  PSR_RX_BUSY			BIT(1)
> +
>  #define NETC_PTCTMSDUR(a)		(0x208 + (a) * 0x20)
>  #define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
>  #define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
> @@ -123,6 +131,24 @@ enum netc_mfo {
>  #define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
>  #define  PM_MAXFRAM			GENMASK(15, 0)
>  
> +#define NETC_PM_IEVENT(a)		(0x1040 + (a) * 0x400)
> +#define  PM_IEVENT_TX_EMPTY		BIT(5)
> +#define  PM_IEVENT_RX_EMPTY		BIT(6)
> +
> +#define NETC_PM_IF_MODE(a)		(0x1300 + (a) * 0x400)
> +#define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
> +#define   IFMODE_MII			1
> +#define   IFMODE_RMII			3
> +#define   IFMODE_RGMII			4
> +#define   IFMODE_SGMII			5
> +#define  PM_IF_MODE_REVMII		BIT(3)
> +#define  PM_IF_MODE_M10			BIT(4)
> +#define  PM_IF_MODE_HD			BIT(6)
> +#define  PM_IF_MODE_SSP			GENMASK(14, 13)
> +#define   SSP_100M			0
> +#define   SSP_10M			1
> +#define   SSP_1G			2
> +
>  #define NETC_PEMDIOCR			0x1c00
>  #define NETC_EMDIO_BASE			NETC_PEMDIOCR
>  


