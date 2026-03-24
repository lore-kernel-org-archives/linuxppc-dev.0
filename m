Return-Path: <linuxppc-dev+bounces-18724-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F66FF54ADA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:54:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgGNR0wR0z2yng;
	Wed, 25 Mar 2026 03:54:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774371271;
	cv=none; b=YgeGwyWgzNf9nGKKP9jpnGgjA4b3dBCFj70Tg9MYHhBzlld/KEM29Ub2KiAiR8nKsV8/+5BgFuU8+KgsQFhHacaEs4QAQfAXEDYfL0lr4w1tb52+ZU9wKkmvM7t6j/nZvpjJdjSgxGwB4rkNPQ6swh3hswfc4/83p+U5XnLWQP2BV/0DGA4FXuqRpBZLgMdyd7+M5m7A74lSQ71ZE9LJboMmh5fp/aLDjQ/m0omodtIAFNE47fNjJFXcyf1ZSdt7q2VZbEcCYPcqHZe39qB/oCen8RLOqFpKYJDMkeynW/DovuDJt4BV2yRCbLJWlhsiKFUKUO/CZDjoMtckth5rzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774371271; c=relaxed/relaxed;
	bh=+qZP+VgvzLamJo1dAJdHYYHUXDBPvcBzLScbznoiijc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbDktqRJn4j5T7Mea3KXz4TU2afV7EPwMMxyPEpHufKLLVZEEG1heJ0WpmGrAxlpqJH8RKUlSg/2CngPKCKBQDC53JlPKjFYbu1NXmY1ekDr9r4hodPxKvcqMCjEec8t5CWWm3Jwzzv3USrBvQvU4A01KUwVQx72ImlAg3+kswmYDlHNqGHSVayxaP0q9Kr05lZJQCalK2J/i9NqgSaXh5WBAiRceOnCcAHxHzoToVnQLRoP3sSSwNflzXf1IiGQhBIJkVHSUrzxGGMKxvbtQuH7RAejhujBnKz37kO1r/u0kG+nxyypmJg8ESJYEMd3rDl5OvDlw94NSY/zJ1NqwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aTiI3B0t; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aTiI3B0t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgGNQ0hR3z2ynP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 03:54:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 20CAD44265;
	Tue, 24 Mar 2026 16:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D065C19424;
	Tue, 24 Mar 2026 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774371268;
	bh=6XwTfsRWoS93cnxOuZ3FgxopYlNBweflJgztMgNywtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTiI3B0tekb0ODeo1RRtl5msPPkbfMkXmTJ3L5ORFH0Itzy3wlIM6tAAVk5QydB4B
	 KaEOgbhfEsTubYPztwrfV8TY2GzNK2kaGJhKFBK8P9ajQPv6TPESIT5cEiYhpX4vMs
	 xJSTkDI/eiuQOmX5b4SLYwqM2m2DXtgflsXglqPxTRwxXHmGiNDdeORax6MiiZBbvQ
	 QfwBicuahSCqk0hOc/D7Gzvq83/OgDVE9irHbTzKBnK/mW9buEG3HVRovKQC+Nzn+F
	 2pk4cJMey8KfztKJEuaqv8pziQvEaBid24S6q+oZU+7Rptxc7EbtGiaLNQ7t0sjOw3
	 PpfVdS4/xXupw==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	andrew@lunn.ch,
	vladimir.oltean@nxp.com,
	frank.li@nxp.com,
	pabeni@redhat.com,
	conor+dt@kernel.org,
	xiaoning.wang@nxp.com,
	davem@davemloft.net,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kuba@kernel.org,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	f.fainelli@gmail.com,
	claudiu.manoil@nxp.com,
	netdev@vger.kernel.org,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 net-next 09/14] net: dsa: add NETC switch tag support
Date: Tue, 24 Mar 2026 16:54:15 +0000
Message-ID: <20260324165415.243214-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323060752.1157031-10-wei.fang@nxp.com>
References: <20260323060752.1157031-10-wei.fang@nxp.com>
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
net: dsa: add NETC switch tag support

This commit introduces support for the NXP NETC switch tag protocol,
a proprietary header used by NETC switches. The tag supports three
types (Forward, To_Port, and To_Host) with variable length (6-14 bytes).

> diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
> new file mode 100644
> index 000000000000..fe964722e5b0
> --- /dev/null
> +++ b/include/linux/dsa/tag_netc.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright 2025-2026 NXP
> + */
> +
> +#ifndef __NET_DSA_TAG_NETC_H
> +#define __NET_DSA_TAG_NETC_H
> +
> +#include <linux/skbuff.h>
> +#include <net/dsa.h>
> +
> +#define NETC_TAG_MAX_LEN			14
> +
> +#endif

[ ... ]

> diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
> new file mode 100644
> index 000000000000..15b0dd5c5408
> --- /dev/null
> +++ b/net/dsa/tag_netc.c

[ ... ]

> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025-2026 NXP
> + */
> +
> +#include <linux/dsa/tag_netc.h>
> +
> +#include "tag.h"
> +
> +#define NETC_NAME			"nxp_netc"
> +
> +/* Forward NXP switch tag */
> +#define NETC_TAG_FORWARD		0
> +
> +/* To_Port NXP switch tag */
> +#define NETC_TAG_TO_PORT		1
> +/* SubType0: No request to perform timestamping */
> +#define NETC_TAG_TP_SUBTYPE0		0
> +
> +/* To_Host NXP switch tag */
> +#define NETC_TAG_TO_HOST		2
> +/* SubType0: frames redirected or copied to CPU port */
> +#define NETC_TAG_TH_SUBTYPE0		0
> +/* SubType1: frames redirected or copied to CPU port with timestamp */
> +#define NETC_TAG_TH_SUBTYPE1		1
> +/* SubType2: Transmit timestamp response (two-step timestamping) */
> +#define NETC_TAG_TH_SUBTYPE2		2
> +
> +/* NETC switch tag lengths */
> +#define NETC_TAG_FORWARD_LEN		6
> +#define NETC_TAG_TP_SUBTYPE0_LEN	6
> +#define NETC_TAG_TH_SUBTYPE0_LEN	6
> +#define NETC_TAG_TH_SUBTYPE1_LEN	14
> +#define NETC_TAG_TH_SUBTYPE2_LEN	14
> +#define NETC_TAG_CMN_LEN		5
> +
> +#define NETC_TAG_SUBTYPE		GENMASK(3, 0)
> +#define NETC_TAG_TYPE			GENMASK(7, 4)
> +#define NETC_TAG_QV			BIT(0)
> +#define NETC_TAG_IPV			GENMASK(4, 2)
> +#define NETC_TAG_SWITCH			GENMASK(2, 0)
> +#define NETC_TAG_PORT			GENMASK(7, 3)
> +
> +struct netc_tag_cmn {
> +	__be16 tpid;
> +	u8 type;
> +	u8 qos;
> +	u8 switch_port;
> +} __packed;

[ ... ]

> +static int netc_get_rx_tag_len(int rx_type)
> +{
> +	int type = FIELD_GET(NETC_TAG_TYPE, rx_type);
> +
> +	if (type == NETC_TAG_TO_HOST) {
> +		u8 subtype = rx_type & NETC_TAG_SUBTYPE;
> +
> +		if (subtype == NETC_TAG_TH_SUBTYPE1)
> +			return NETC_TAG_TH_SUBTYPE1_LEN;
> +		else if (subtype == NETC_TAG_TH_SUBTYPE2)
> +			return NETC_TAG_TH_SUBTYPE2_LEN;
> +		else
> +			return NETC_TAG_TH_SUBTYPE0_LEN;
> +	}
> +
> +	return NETC_TAG_FORWARD_LEN;
> +}
> +
> +static struct sk_buff *netc_rcv(struct sk_buff *skb,
> +				struct net_device *ndev)
> +{
> +	struct netc_tag_cmn *tag_cmn = dsa_etype_header_pos_rx(skb);
> +	int tag_len = netc_get_rx_tag_len(tag_cmn->type);
                                             ^^^^^^^^^^^^

Is the tag header guaranteed to be in the linear region of the skb?
Looking at other EtherType-based DSA tag drivers (tag_ar9331, tag_lan9303,
tag_dsa, tag_edsa, tag_a5psw, tag_brcm_legacy, tag_mxl-gsw1xx,
tag_gswip, and tag_mtk), they all call pskb_may_pull() before accessing
tag data to ensure the header is linearized.

For example, tag_ar9331.c:

static struct sk_buff *ar9331_tag_rcv(struct sk_buff *skb,
                                      struct net_device *ndev)
{
    if (unlikely(!pskb_may_pull(skb, AR9331_HDR_LEN)))
        return NULL;
    ...
}

Similarly, tag_lan9303.c:

static struct sk_buff *lan9303_rcv(struct sk_buff *skb,
                                   struct net_device *ndev)
{
    if (unlikely(!pskb_may_pull(skb, LAN9303_TAG_LEN)))
        return NULL;
    ...
}

Without this check, netc_rcv() accesses tag_cmn->type, tag_cmn->tpid,
tag_cmn->qos, and tag_cmn->switch_port before verifying these bytes are
linearized. The struct netc_tag_cmn is 5 bytes, with 3 bytes at
skb->data through skb->data+2 that may not be guaranteed to be in the
linear region.

Additionally, netc_get_rx_tag_len() can return up to 14 bytes
(NETC_TAG_TH_SUBTYPE1_LEN or NETC_TAG_TH_SUBTYPE2_LEN), and this value
is passed directly to skb_pull_rcsum():

> +	int tag_len = netc_get_rx_tag_len(tag_cmn->type);
> +	int sw_id, port;
> +
> +	if (ntohs(tag_cmn->tpid) != ETH_P_NXP_NETC) {
> +		dev_warn_ratelimited(&ndev->dev, "Unknown TPID 0x%04x\n",
> +				     ntohs(tag_cmn->tpid));
> +
> +		return NULL;
> +	}
> +
> +	if (tag_cmn->qos & NETC_TAG_QV)
> +		skb->priority = FIELD_GET(NETC_TAG_IPV, tag_cmn->qos);
> +
> +	sw_id = NETC_TAG_SWITCH & tag_cmn->switch_port;
> +	/* ENETC VEPA switch ID (0) is not supported yet */
> +	if (!sw_id) {
> +		dev_warn_ratelimited(&ndev->dev,
> +				     "VEPA switch ID is not supported yet\n");
> +
> +		return NULL;
> +	}
> +
> +	port = FIELD_GET(NETC_TAG_PORT, tag_cmn->switch_port);
> +	skb->dev = dsa_conduit_find_user(ndev, sw_id, port);
> +	if (!skb->dev)
> +		return NULL;
> +
> +	if (tag_cmn->type == NETC_TAG_FORWARD)
> +		dsa_default_offload_fwd_mark(skb);
> +
> +	/* Remove Switch tag from the frame */
> +	skb_pull_rcsum(skb, tag_len);
                     ^^^^^^^^^^^^^^^^^^

The skb_pull_rcsum() function contains BUG_ON(len > skb->len). If a
truncated or malformed packet arrives with fewer than tag_len bytes
remaining, the kernel will panic rather than gracefully handling the
error.

Should a check like this be added at the beginning of netc_rcv():

if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN - 2)))
    return NULL;

The -2 would account for the EtherType bytes already consumed by
eth_type_trans().

> +	dsa_strip_etype_header(skb, tag_len);
> +
> +	return skb;
> +}

[ ... ]

