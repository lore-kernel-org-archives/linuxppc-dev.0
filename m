Return-Path: <linuxppc-dev+bounces-19252-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A41ED6AAFA
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 01:18:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn16r38sFz2yv1;
	Fri, 03 Apr 2026 12:17:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775179060;
	cv=none; b=RVFZSrtM64aYiAJXSnAedtEgLBuOA+T1Mc23DmFkwx90x3nIAevYpSP6+pZdbJxykCwin+PmEb96BkWG0vkxlStuaFb8VJHwv35y5oSwDuPLuur0XRZKuUtuTWdAj6swOqvO1lzfliwec/1rEWucbAa7YZqdae+j2rpCnYtUvcgdw1uQuqlofYSFxJc1t7zLDLnG9QI8QXMmm5VFQ/N+PNT9WdJxA48XKgwwiPwusfzKjyv8mMTkqgfsElTled3RJwTd/qbrxevfHkA5x7jXdZ+OKKAhG7cFtigHECMESehoS9+9FI4trlE6AhyXCtEVqxvbksvT5wqOQzH51u1w1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775179060; c=relaxed/relaxed;
	bh=H18sWm5P1ofuMNfKYGONKMvaLqkli/O/1ZdyJduFCEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D30UWh4jGCjnPTaMPir3cOIx9CVV/TIKvMyCj3R2QsdgvCHim2RZVmAqgxDyogpuf8MjtuMq8cS/fxG883RADLsEYHJgwB0bAqqPytaRw0Qs3F8X5qOfStY6XnzbldTs54hGiCgbjnBDP1sRWN+wJZz4fbkW6jCRrUpoO8qDDGStKb6cGxUfjG5pvfBr/R3ddU+VmYLCCKqqfz8NUEOhbjSDsVjuD1SGecQuYTCbYELinkuROktp4bQHwSEG72wfh5RbbhFp5kL2ZgYVbH4RtZ0LoroB0B/QiKBBVVIeFswTtsHjtQFj9jas/ItNcVQJRL3GqWnVfJ4+jMrBgGI26g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EpOM3hIz; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EpOM3hIz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn16q5SVnz2yrS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 12:17:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 39D8342DC2;
	Fri,  3 Apr 2026 01:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB46C2BCB1;
	Fri,  3 Apr 2026 01:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179058;
	bh=kf7UcGQnEKNIFCT4+nJ9PJ/iFdOs9gmUphhDLwEs43I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EpOM3hIzOgHfn6BQXuMgZDbLHnn+GT4ShSxODfekzqn5lthwCbFfoafksregEhLy4
	 cCeTkVP8+P2uUqAlLBtV0nQ4ibPJZhB+4gbXEorFRyBI1jKWj7XzfsbPd+Pj9IeuAM
	 sf4dcNEpyFJQ6mYLe+2XAEV3+b1oBeByK0k/DKWPJexgN0GhJmF7JXi7EOc9TvO5ql
	 dfaDKDEZ8c5TDEzZQiqZAVhN1YZbqhogFhp/vbRRIvZBk23bZBJYv6cQEwGldeFhH4
	 1j+y31+Kf55F59Vv2VrNs5IDW01YKEAmS3uVQd59pQhiWiazc1QsboJ6QNFljy9F7R
	 uTy2lZeSSyX4A==
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
Subject: Re: [PATCH v4 net-next 09/14] net: dsa: add NETC switch tag support
Date: Thu,  2 Apr 2026 18:17:36 -0700
Message-ID: <20260403011736.1795610-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-10-wei.fang@nxp.com>
References: <20260331113025.1566878-10-wei.fang@nxp.com>
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
net: dsa: add NETC switch tag support

Adds support for the proprietary NXP NETC switch tag used in NXP NETC
switches version 4.3 or later. The tag has 3 types (Forward, To_Port,
To_Host) and supports a varying length between 6 and 14 bytes.

> diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
> new file mode 100644
> index 000000000000..addd41f7f1b6
> --- /dev/null
> +++ b/net/dsa/tag_netc.c
[ ... ]
> +static void *netc_fill_common_tp_tag(struct sk_buff *skb,
> +				     struct net_device *ndev,
> +				     u8 subtype, int tag_len)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(ndev);
> +	u16 queue = skb_get_queue_mapping(skb);
> +	u8 ipv = netdev_txq_to_tc(ndev, queue);

What happens here if the interface doesn't have traffic classes configured?

By default, netdev_txq_to_tc() returns -1. Because ipv is an unsigned 8-bit
integer, this casts to 255.

When this is later passed to FIELD_PREP(NETC_TAG_IPV, ipv) in
netc_fill_common_tag(), the macro blindly masks the variable, silently
forcing the IPV field to 7 (the maximum priority) for all default,
unconfigured traffic. Valid TC values greater than 7 would also be silently
truncated.

Does this code bypass the intended QoS mechanisms?

> +	void *tag;
> +
> +	skb_push(skb, tag_len);
> +	dsa_alloc_etype_header(skb, tag_len);
> +
> +	tag = dsa_etype_header_pos_tx(skb);
> +	memset(tag + NETC_TAG_CMN_LEN, 0, tag_len - NETC_TAG_CMN_LEN);
> +	netc_fill_common_tag(tag, NETC_TAG_TO_PORT, subtype,
> +			     dp->ds->index, dp->index, ipv);

Will this break communication for standard single-switch setups?

The driver passes dp->ds->index as the hardware switch ID here, which
defaults to 0 for the first switch in a DSA tree. However, on the receive
path, frames stamped with switch ID 0 are rejected.

If the physical switch hardware uses an ID greater than 0, frames will fail
the lookup in dsa_conduit_find_user() on receive because the software index
is 0.

> +
> +	return tag;
> +}
[ ... ]
> +static struct sk_buff *netc_rcv(struct sk_buff *skb,
> +				struct net_device *ndev)
> +{
> +	struct netc_tag_cmn *tag_cmn;
> +	int tag_len, sw_id, port;
[ ... ]
> +	if (tag_cmn->qos & NETC_TAG_QV)
> +		skb->priority = FIELD_GET(NETC_TAG_IPV, tag_cmn->qos);
> +
> +	sw_id = NETC_TAG_SWITCH & tag_cmn->switch_port;

This isn't a bug, but is there a reason to use a raw bitwise AND for sw_id
instead of using FIELD_GET(NETC_TAG_SWITCH, ...) to match how the port
field is extracted just below this?

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
[ ... ]

