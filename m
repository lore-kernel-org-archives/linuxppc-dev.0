Return-Path: <linuxppc-dev+bounces-19256-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987B7D6AAFA
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 01:18:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn1720nH8z2yhZ;
	Fri, 03 Apr 2026 12:17:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775179070;
	cv=none; b=P502C4LRF1s85ts98KOaI6cz/+P5/+6EWWv1mW6pPDS1qiAjxc36ZwgIN2KQYLT8WWqZcF6EfX1aCcw86ab1rVjmBZE1oC3rvQw59BqfSqcPLR8qIql11Scm4MhYHz6k0ZDjHatro1wtmbtUCDV+jYGi/jRcrKDpS4oHYcYRI3KC9Gyd1dens34CAw1BpsctObPvInhcnq7/pO3koVdE42dWwyTOt8HlBXRSRxGjWiNvZ87/YlabgAM5hJzZJckeohaEeeQf2QWCFoAKkPpZfvRLfoyQu1+Ano6NY+OmT4MC6FJyS2Xf9AjX4AfacCgEDU5bgWlIXtVVkPdwvgQ8uA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775179070; c=relaxed/relaxed;
	bh=LHN35TomyIfPRPkIHCYjF92GnIolLjpfIctUwiX3YtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgd89TEbSq+cDgsf+oB3R02B5UZdbNp/mKbq92tNl4ypupVBZ+DzJXAMXjoSc6f9kxUo6rgKccM+cwoFMrQlhVJXULW0vGdShjaGm/aWSvAsY6TvTIPLI0ipbJ/EkqcN+iwNgDKrdiFbAHvggyQSddiflHseGdRuVIKrETO65Py6a3kUBcEaIz+N0wDDoeGI1EDyrMSFzecr83fL4Ji2e1tAvo0rtxLfLp+WDK76l3DmcbnvfbBLNesBSRlKxO0VHAwnQKheMHs9JWK0RRTaJJnNSSqAi1WQi2S2+69uV9WCRFSz7FKhxPpQvGpDOmnO0XFoatubMmD8XiIITEKCNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NBRbUbgk; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NBRbUbgk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn1712Vncz2yhV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 12:17:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CCCBE44017;
	Fri,  3 Apr 2026 01:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7FAC2BCB0;
	Fri,  3 Apr 2026 01:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179067;
	bh=Rg13dO41JuHb3wyGXv+CMSlZCAw+nSPFyVhUygIx8Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBRbUbgk+bgMpenm2PErPtlkiQ/rZme/dpiQyoIhg3+DqVf0+OSNzpbAxKMpXCC3p
	 ZrxFUhlyAI22ZzXD8J8+n1t8F6Yq8ePqyxvLAqCn9ZangWFa4SWSiaBnPZqDyT/xJr
	 NhiwEFrprH+XoPogoimKWIoo1LmRXzS/fu8x/bwhO5F99a7XKsYWsyf+CIbF5wa8sF
	 Hylqd+NfeB0bEMnAmxTXmOlAvWbAWyoKvR4XA4Y2CoO3CrY8Ym38vHHYzVVw0nyJ8N
	 0GVmzGLC5p458zzb7GGrHVUANijvaFvFuXjUqqTqgZmlIFsk0u+lUUveqv+OMXpRuT
	 3Ji4GDB7LngOg==
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
Subject: Re: [PATCH v4 net-next 13/14] net: dsa: netc: initialize buffer bool table and implement flow-control
Date: Thu,  2 Apr 2026 18:17:45 -0700
Message-ID: <20260403011745.1795759-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-14-wei.fang@nxp.com>
References: <20260331113025.1566878-14-wei.fang@nxp.com>
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
net: dsa: netc: initialize buffer bool table and implement flow-control

This commit adds buffer pool initialization and flow control support for the
NXP netc switch. It maps frame priorities to specific buffer pools and
configures transmission pause thresholds.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 3609d83ac363..688dceb486c2 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c
[ ... ]
> @@ -386,6 +388,15 @@ static void netc_port_fixed_config(struct netc_port *np)
>  	/* Enable L2 and L3 DOS */
>  	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
>  		      PCR_L2DOSE | PCR_L3DOSE);
> +
> +	/* Set the quanta value of TX PAUSE frame */
> +	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), pqnt);
> +
> +	/* When a quanta timer counts down and reaches this value,
> +	 * the MAC sends a refresh PAUSE frame with the programmed
> +	 * full quanta value if a pause condition still exists.
> +	 */
> +	netc_mac_port_wr(np, NETC_PM_PAUSE_TRHESH(0), qth);

This isn't a bug, but there's a typo in the macro name (TRHESH instead of
THRESH).

[ ... ]
> +static u32 netc_get_buffer_pool_num(struct netc_switch *priv)
> +{
> +	/* The BPCAPR register is a read only register, the hardware
> +	 * guarantees that the BPCAPR_NUM_BP field will not be 0.
> +	 */
> +	return netc_base_rd(&priv->regs, NETC_BPCAPR) & BPCAPR_NUM_BP;
> +}
[ ... ]
> +static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
> +{
> +	int bp_per_port = priv->num_bp / priv->info->num_ports;
> +	int q = NETC_IPV_NUM / bp_per_port;
> +	int r = NETC_IPV_NUM % bp_per_port;

If the hardware register read in netc_get_buffer_pool_num() returns a value
smaller than priv->info->num_ports (for instance, during a bus error or
reset state), bp_per_port will evaluate to 0.

Can this lead to a division by zero panic here?

Should priv->num_bp be validated against the number of ports before
performing this calculation to ensure the driver fails gracefully if the
hardware returns an unexpected value?

[ ... ]
> diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
> index c6a0c0a8ff8a..1e1c0d279a21 100644
> --- a/drivers/net/dsa/netc/netc_switch_hw.h
> +++ b/drivers/net/dsa/netc/netc_switch_hw.h
[ ... ]
> @@ -145,6 +152,12 @@ enum netc_stg_stage {
>  #define NETC_PM_IEVENT(a)		(0x1040 + (a) * 0x400)
>  #define  PM_IEVENT_RX_EMPTY		BIT(6)
>  
> +#define NETC_PM_PAUSE_QUANTA(a)		(0x1054 + (a) * 0x400)
> +#define  PAUSE_QUANTA_PQNT		GENMASK(15, 0)
> +
> +#define NETC_PM_PAUSE_TRHESH(a)		(0x1064 + (a) * 0x400)
> +#define  PAUSE_TRHESH_QTH		GENMASK(15, 0)

This isn't a bug, but there's a typo in the macro names here as well
(TRHESH instead of THRESH).

