Return-Path: <linuxppc-dev+bounces-19254-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B85CD6AB1A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 01:18:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn16x67M9z2yrS;
	Fri, 03 Apr 2026 12:17:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775179065;
	cv=none; b=UG+owOCgxeh/iTYJ9PwMwP29uWqilx8J7aCEYWt60+7icKxBXvgQQaaChQIS27AkT7wE7FA+6nBvPtBmjT2x42XiGUOCJHAna4R47vJMrDWK8PjwEpq2/3EU/WPhOR5xScOhfir5kxu8Yhhcyoq0aWixFbO+Tp13GJELuMQeuSNKcqlsICuzNe1JFKaERQ8P9S+YmCm72RzhQkdDLIi70+A4PurxEFMhTpFgqo9kQMxe62io56x7P+cFVkc5Tg+Ptpu1vDyzTaMNkMe5fci6uFsw8zEYTfEeB+hnqIs49ViwVvtMU81kBo7E8EQng7tQsfX4MkL32KJZ45zuHth1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775179065; c=relaxed/relaxed;
	bh=Bx9BF2y+dARkPvDf985BWqkLvXp6kAeT3vj1k6dELXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEYWHP1Oh62drHrM7r/t37E78kQ9xrLz5TVkXuV+8B5n1Wgcxnk3fvHQqi3jg7oBrTDX/V0RGxW9SRHP3cAeHk75TCDzfmbCpGlbxOAZuMZzVEMPGvhjfajSkuo5GuMzg6/aoI7YsRnzKysF3k7/Pb7aGAmJWryOEXY3PCr/+bSzZuqDzTBPVDevb5Xw32UcxwXuvlQZDTP/Nnv7OtPyUV9RD/Iiw4g9Mv6i0/nJnwc6GLbFHUrB8ygeh0NgWoZ4yCOQSEDWnjMvueRl+45twEvKmFNS0UateDgsbMthIY99E4K/HRtGotENLEvAt5fMTJKu1IafxTLfxjjsfzcX+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OhBBdA+E; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OhBBdA+E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn16x0f4mz2yhV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 12:17:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2EA7060126;
	Fri,  3 Apr 2026 01:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC292C2BCB2;
	Fri,  3 Apr 2026 01:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179062;
	bh=EFAVMQZdeYp3p63+e+4293CsTLGyJdiSV230CSFVXgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhBBdA+EJaT7h1MeQGXuyT3xlz3LIwg2zub97gRs8+YKaNLTv9i3rQJ6KpghcbHBC
	 bSg9iIQ2UYl/BkWpegwYnRNu9yg/bqXeQHBU1j1XL/LBJtrQL2OinJ9KooKqP5APzT
	 mSMO9yiM8d5S4EEnHiHcmnxiw6ufdRrtxI8MpsplXg/m1C6DGWFSf5Eq2P8XcE8eAv
	 +6Prlu8zJJKuZnwhBJTP51sZZLpvHpSlP8iSlCifsp2LEt5tzZOUEA1I6B+UUZlx4D
	 8ua3RGw2eDYd/hEgp8w8qRloHWD29H+5oB+SzhbqzuSC1mWSJBHDFc9f9KXHm13Qe0
	 iGvMa0Nb+Zbhg==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 net-next 11/14] net: dsa: netc: add phylink MAC operations
Date: Thu,  2 Apr 2026 18:17:40 -0700
Message-ID: <20260403011740.1795694-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-12-wei.fang@nxp.com>
References: <20260331113025.1566878-12-wei.fang@nxp.com>
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
---
net: dsa: netc: add phylink MAC operations

Different versions of NETC switches have different numbers of ports and
MAC capabilities, so add .phylink_get_caps() to struct netc_switch_info.
In addition, related interfaces of struct phylink_mac_ops are added.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 5828fd3e342e..f11f5d0f6a6d 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c
[ ... ]
> +static void netc_port_set_mac_mode(struct netc_port *np,
> +				   unsigned int mode,
> +				   phy_interface_t phy_mode)
> +{
> +	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII;
> +	u32 val = 0;
> +
> +	switch (phy_mode) {
> +	case PHY_INTERFACE_MODE_RGMII:
[ ... ]
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

In imx94_switch_phylink_get_caps(), PHY_INTERFACE_MODE_1000BASEX is
advertised as supported for ports 0 and 1. Does it need to be handled
in this switch statement? As written, it appears it will fall through
to the default case and clear the IFMODE bits, leaving the MAC in an
undefined mode.

[ ... ]
> +static void netc_port_mac_rx_enable(struct netc_port *np)
> +{
> +	netc_port_rmw(np, NETC_POR, PCR_RXDIS, 0);
> +	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN,
> +			  PM_CMD_CFG_RX_EN);
> +}

Pseudo ports (like the CPU port) bypass PMAC register accesses during
graceful stop via is_netc_pseudo_port(). Should there be a similar check
here, and in netc_port_set_mac_mode(), to prevent accessing physical MAC
registers on pseudo ports?

Additionally, when np->caps.pmac is true, netc_port_mac_rx_graceful_stop()
disables the preemption MAC via NETC_PM_CMD_CFG(1). Should this function
re-enable it when bringing the link back up?

> +static void netc_port_wait_rx_empty(struct netc_port *np, int mac)
> +{
> +	u32 val;
> +
> +	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_RX_EMPTY,
> +			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
> +		dev_warn(np->switch_priv->dev,
> +			 "MAC %d of swp%d RX is not empty\n", mac,
> +			 np->dp->index);
> +}

Is NETC_PM_IEVENT a sticky write-1-to-clear register? If the RX FIFO had
previously emptied during normal operation, could this bit already be set,
causing read_poll_timeout() to return immediately without waiting?

> +static void netc_port_mac_rx_graceful_stop(struct netc_port *np)
> +{
> +	u32 val;
> +
> +	if (is_netc_pseudo_port(np))
> +		goto check_rx_busy;
> +
> +	if (np->caps.pmac) {
> +		netc_port_rmw(np, NETC_PM_CMD_CFG(1), PM_CMD_CFG_RX_EN, 0);
> +		netc_port_wait_rx_empty(np, 1);
> +	}
> +
> +	netc_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN, 0);
> +	netc_port_wait_rx_empty(np, 0);
> +
> +check_rx_busy:
> +	if (read_poll_timeout(netc_port_rd, val, !(val & PSR_RX_BUSY),
> +			      100, 10000, false, np, NETC_PSR))
> +		dev_warn(np->switch_priv->dev, "swp%d RX is busy\n",
> +			 np->dp->index);
> +
> +	netc_port_rmw(np, NETC_POR, PCR_RXDIS, PCR_RXDIS);
> +}

For pseudo ports, the code jumps directly to check_rx_busy and polls for
PSR_RX_BUSY to clear. Since PCR_RXDIS is only set after the polling
completes, will the RX pipeline continue accepting traffic and cause this
poll to always timeout on an active link?

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
> +	netc_port_mac_rx_enable(np);
> +}

The callback imx94_switch_phylink_get_caps() advertises MAC_ASYM_PAUSE and
MAC_SYM_PAUSE capabilities. Is it expected that tx_pause and rx_pause are
ignored here? If flow control is implemented in a subsequent patch, should
the advertisement be deferred until then?

> +static void netc_mac_link_down(struct phylink_config *config,
> +			       unsigned int mode,
> +			       phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +
> +	netc_port_mac_rx_graceful_stop(NETC_PORT(dp->ds, dp->index));
> +}

This correctly stops the RX pipeline, but should the TX path
(PM_CMD_CFG_TX_EN or PCR_TXDIS) also be disabled when the link goes down?

