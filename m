Return-Path: <linuxppc-dev+bounces-18723-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345DAF54AD7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:43:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgG7P68wcz2yng;
	Wed, 25 Mar 2026 03:43:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774370593;
	cv=none; b=BM3Yjeyy5Dbm4RMgnPN8MB0yLxNsaOFaCCD/4Qb0PPZJP01gIIqu1T5mP28QY1EH/aBB7lymF2KPOmL2GHUX5fnLSsXf8EJBlc6DCRNz24ZIFAGPcMFzP90ksQXwCdvQc5vl+7VvhB0rfEWSysliP3T8yagG6sWskOWkuoyyrBwvHWNlh5OABxLy3K5LusgCXSV00j2+eqqsU+/VuvMRh+Reun3hn9mh7TDzzt7+qk59EiZ5aR/6sSS6d4hUau6HqKwoQ4nG5p1Z/P3CdhCRK4TY1fOBvgzugnwMcP4I1iRZlttQD+BwOxEjQELRlSKEk+NYa47zogknJOaVYmQlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774370593; c=relaxed/relaxed;
	bh=aKvN6h2oo9YqBz43mMw+ltAM0WTNIFGDdwWayw6xrJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/MEctO0qQbwGhU5Zbx/Z7azt2r/m2MrWlgIxwUwga/Uwk8s0ooDwc5jahrcN+7cwdl6HhWzQKT37Q4ASIKWrUc2FZTazg1j8h39WWqgXga+9QqovnJe4In+EhrmkZVv4YLuoT31Ew1QUlgkLhrcE+ObiXt1FCRrAOe2EMf8ipEKgVIs90lu8atUpWUsPTB6sepREMtqcYgjZ9CmaOcttKJ6sTPzysgrYkj1MLTGcCJEYER7NHg0+5FgGBph9BCN1+tXf+RQkRar8BLe7ZPr/hKtet3XRC0yv5gNk/L3POYnaeXulvlbOXX2kBchLClxEeRGru8b1fzQqDvefPVGtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dWKloWIu; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dWKloWIu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgG7N6QZCz2ynP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 03:43:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 073EC600AC;
	Tue, 24 Mar 2026 16:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D95C19424;
	Tue, 24 Mar 2026 16:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774370589;
	bh=rPwXPqpxqGjwXWV5oKmXOPdHJyLJEDqfkcEG9hr97Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWKloWIuyD2kQEflYjJHa+EVqWpu+DbR2qbrsnsRPeEsjLjwZ/dNK1v6Ct0YZ85z8
	 gXJiBzemJGHs4JP3u1R6Dn4JC6IisnUDUZmy1Tv8uqCT+ETnUkGza1ePayOi+P2mVr
	 zHbLHeVd/7LOpalcqEQt6jts/9elteBCEXCzvCehGbeR2ZNub4i9LEeClfygW/udeO
	 OuN/YmbWObxyv8jHvvGxoBQuThG4tpiZ+EdIlA6MAJ49ToCp/yQJeZgP1ICWQABKRB
	 ep0Rw/qBYFptH6rM1fUBTmOX8XS6oVLff4ICSg0LRO7+r/L24GO8J/SBWS3+YXDde/
	 ysOFzBMR2mllg==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	xiaoning.wang@nxp.com,
	netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	andrew@lunn.ch,
	conor+dt@kernel.org,
	edumazet@google.com,
	linux-arm-kernel@lists.infradead.org,
	frank.li@nxp.com,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	claudiu.manoil@nxp.com,
	f.fainelli@gmail.com,
	vladimir.oltean@nxp.com,
	linuxppc-dev@lists.ozlabs.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 13/14] net: dsa: netc: initialize buffer bool table and implement flow-control
Date: Tue, 24 Mar 2026 16:42:30 +0000
Message-ID: <20260324164234.238201-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323060752.1157031-14-wei.fang@nxp.com>
References: <20260323060752.1157031-14-wei.fang@nxp.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: netc: initialize buffer bool table and implement flow-control

The buffer pool is a quantity of memory available for buffering a group
of flows (e.g. frames having the same priority, frames received from the
same port), while waiting to be transmitted on a port. The buffer pool
tracks internal memory consumption with upper bound limits and optionally
a non-shared portion when associated with a shared buffer pool. Currently
the shared buffer pool is not supported, it will be added in the future.

For i.MX94, the switch has 4 ports and 8 buffer pools, so each port is
allocated two buffer pools. For frames with priorities of 0 to 3, they
will be mapped to the first buffer pool; For frames with priorities of
4 to 7, they will be mapped to the second buffer pool. Each buffer pool
has a flow control on threshold and a flow control off threshold. By
setting these threshold, add the flow control support to each port.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 4b331971dd8c..2a7ad39f8bed 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -617,6 +628,80 @@ static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *priv)
>  				       bcast, NETC_STANDALONE_PVID);
>  }
>
> +static u32 netc_get_buffer_pool_num(struct netc_switch *priv)
> +{
> +	return netc_base_rd(&priv->regs, NETC_BPCAPR) & BPCAPR_NUM_BP;
> +}
> +
> +static void netc_port_set_pbpmcr(struct netc_port *np, u64 mapping)
> +{
> +	u32 pbpmcr0 = lower_32_bits(mapping);
> +	u32 pbpmcr1 = upper_32_bits(mapping);
> +
> +	netc_port_wr(np, NETC_PBPMCR0, pbpmcr0);
> +	netc_port_wr(np, NETC_PBPMCR1, pbpmcr1);
> +}
> +
> +static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
> +{
> +	int num_port_bp = priv->num_bp / priv->info->num_ports;
> +	int q = NETC_IPV_NUM / num_port_bp;
>                ^^^^

Can this cause a division by zero?  If netc_get_buffer_pool_num() reads
the hardware register NETC_BPCAPR and returns 0, then num_port_bp would be
0 and this division would crash the kernel.

The call chain is:

netc_setup()
  netc_switch_bpt_default_config()
    priv->num_bp = netc_get_buffer_pool_num()
    netc_ipv_to_buffer_pool_mapping()
      num_port_bp = priv->num_bp / priv->info->num_ports;
      q = NETC_IPV_NUM / num_port_bp;  <- division by zero

Should netc_switch_bpt_default_config() validate that priv->num_bp is
non-zero before proceeding?

> +	int r = NETC_IPV_NUM % num_port_bp;
> +	int num = q + r;
> +
> +	/* IPV-to–buffer-pool mapping per port:

[ ... ]

> +static int netc_switch_bpt_default_config(struct netc_switch *priv)
> +{
> +	priv->num_bp = netc_get_buffer_pool_num(priv);
> +	priv->bpt_list = devm_kcalloc(priv->dev, priv->num_bp,
> +				      sizeof(struct bpt_cfge_data),
> +				      GFP_KERNEL);
> +	if (!priv->bpt_list)
> +		return -ENOMEM;
> +
> +	/* Initialize the maximum threshold of each buffer pool entry */
> +	for (int i = 0; i < priv->num_bp; i++) {
> +		struct bpt_cfge_data *cfge = &priv->bpt_list[i];
> +		int err;
> +
> +		cfge->max_thresh = cpu_to_le16(NETC_BP_THRESH);
> +		err = ntmp_bpt_update_entry(&priv->ntmp, i, cfge);
> +		if (err)
> +			return err;
> +	}
> +
> +	netc_ipv_to_buffer_pool_mapping(priv);
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -1224,6 +1313,40 @@ static void netc_port_set_hd_flow_control(struct netc_port *np, bool en)
>  			  en ? PM_CMD_CFG_HD_FCEN : 0);
>  }
>
> +static void netc_port_set_tx_pause(struct netc_port *np, bool tx_pause)
> +{
> +	struct netc_switch *priv = np->switch_priv;
> +	int port = np->dp->index;
> +	int i, j, num_bp;
> +
> +	num_bp = priv->num_bp / priv->info->num_ports;
> +	for (i = 0, j = port * num_bp; i < num_bp; i++, j++) {
> +		struct bpt_cfge_data *cfge;
> +
> +		cfge = &priv->bpt_list[j];
> +		if (tx_pause) {
> +			cfge->fc_on_thresh = cpu_to_le16(NETC_FC_THRESH_ON);
> +			cfge->fc_off_thresh = cpu_to_le16(NETC_FC_THRESH_OFF);
> +			cfge->fccfg_sbpen = FIELD_PREP(BPT_FC_CFG,
> +						       BPT_FC_CFG_EN_BPFC);
> +			cfge->fc_ports = cpu_to_le32(BIT(port));
> +		} else {
> +			cfge->fc_on_thresh = cpu_to_le16(0);
> +			cfge->fc_off_thresh = cpu_to_le16(0);
> +			cfge->fccfg_sbpen = 0;
> +			cfge->fc_ports = cpu_to_le32(0);
> +		}
> +
> +		ntmp_bpt_update_entry(&priv->ntmp, j, cfge);
>                 ^^^^

Should the return value of ntmp_bpt_update_entry() be checked here?

Simon Horman noted in v1 review that other NTMP table operations in the
driver propagate errors from the update functions. While this was fixed
in netc_switch_bpt_default_config() in v2, the same issue remains here.

If the hardware update fails (for example, DMA allocation failure or
hardware timeout), the driver's bpt_list will have flow control values that
do not match the actual hardware state, potentially causing incorrect flow
control behavior.

https://lore.kernel.org/netdev/20260318145452.1898637-2-horms@kernel.org/

> +	}
> +}
> +

[ ... ]

