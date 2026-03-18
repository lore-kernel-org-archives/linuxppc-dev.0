Return-Path: <linuxppc-dev+bounces-18358-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44FD103E18F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 14:33:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbWXH3VX7z2yjV;
	Thu, 19 Mar 2026 01:33:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773844399;
	cv=none; b=edc2a2dto3eqsEub0HA1cq45cjcGMEdoZD7v+SX2BU12qZz4g2SlLbyDQTXPSIEpKPKJ1patrb9U7lHpgg9JhtLFer/b3FyVv1nwheSxkRpC8+ChOwT10j6C4MCDyBmX3onLdg0U/dgqV7PJJvfYXqzL+Mqedpa4nvPUMN5xMr1Uhn+at09PeA+9dE8ZutC/Hvb0Hw5C4PJ4uQfgDo+KSzwraYdihRz3n28pKrjJQ6VVai2DaSwOQUpQKD4Ouqss5qVhoLaMXGHqVQ9G+lE0fVv8WqyOsXckNDf1/Yr4dPOL98TeOuaFXeYX9XZwEqXErMHTye6E2xx80G2uhkHrEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773844399; c=relaxed/relaxed;
	bh=+ZvCPsvWxw2YXvIRzu6Qkl+xZl0UJJHZvO4VYJ9+3K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8hEy9TJ8Cga6TR6KGvgKcvk5xzJe5PC4zF6Lz6feAZYJUyNIPyx4iptLYmxDyUOP0zU/8aSmZoLlkZUFNK4se0dSCAMPFmHx0vGjiYCxHUVjowRgk37ItnghoNKm4boH7uUMbEOipiFSVhrgQgThAN5g6V8QpMwLgj/9gLX9zw8WJYVs/rm+NjPK3W2eDJyHpN5ewOgKDYG8KAcFHEdU2IAtuoEK9DnfnOZe+q7hK7cT+WjBswLfwUMMUoojuxtoWLXA4oT2nTf4/2BK9TriZls1XsJU4SLkGWwr9h4sxc39+BfJJ8N0+cmmNvbP42mqap73TW52dOcssI4Y2lxOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lM08xmyS; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lM08xmyS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbWXG2nLvz2ygd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 01:33:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1268B60054;
	Wed, 18 Mar 2026 14:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8659C19421;
	Wed, 18 Mar 2026 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844395;
	bh=zo3ppbbm5CmklykDDi884bR6RTstjwQ6rqH+FoHduP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lM08xmySH7oe0eBpsBAOY5KZgan8agd14IQH9AEUXTTlIjc++KVnE27u4klJ7exp6
	 iSxgw0UgKZFjmuzvnq8pGmMnU7sYrV22yPxVZqvBP/3eOiQ06RkiiJZyTUVym12D/b
	 qwjnXVnEFP+UlccWeJHv6dkR0KHBEXOdBPF7bQkprBv4s90mV8byr4pK0FePE6/xct
	 ACvVieZuJk9YngFGZy29Ai+Rs6KXeQ24KjtsY9vxRSmhDTte1IrFeMyVgEZ6Ne8spX
	 DjMbphLvIZ5D8ccyW3UVFHq2BbcezXkg8bmVUrKe273ekwz08eS7h33zQwnKgq/Jej
	 ZMeh6QQOxhnFA==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	edumazet@google.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	imx@lists.linux.dev,
	f.fainelli@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux@armlinux.org.uk,
	linuxppc-dev@lists.ozlabs.org,
	xiaoning.wang@nxp.com,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	robh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzk+dt@kernel.org,
	kuba@kernel.org
Subject: Re: [net-next,08/14] net: enetc: add multiple command BD rings support
Date: Wed, 18 Mar 2026 14:32:01 +0000
Message-ID: <20260318143201.1888252-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316094152.1558671-9-wei.fang@nxp.com>
References: <20260316094152.1558671-9-wei.fang@nxp.com>
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
net: enetc: add multiple command BD rings support

This commit adds support for multiple command BD rings in the NTMP
driver. When the NETC switch has multiple command BD rings and one is
busy, the driver can select an alternate ring to execute commands.

> diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
> index 9fc3422137fc..e23a32946762 100644
> --- a/drivers/net/ethernet/freescale/enetc/ntmp.c
> +++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
> @@ -117,6 +117,25 @@ static void ntmp_clean_cbdr(struct netc_cbdr *cbdr)
>  	cbdr->next_to_clean = i;
>  }
>
> +static struct netc_cbdr *netc_select_cbdr(struct ntmp_user *user)
> +{
> +	int cpu, i;
> +
> +	for (i = 0; i < user->cbdr_num; i++) {
> +		if (spin_is_locked(&user->ring[i].ring_lock))
> +			continue;
> +
> +		return &user->ring[i];
> +	}
> +
> +	/* If all the command BDRs are busy now, we select
> +	 * one of them, but need to wait for a while to use.
> +	 */
> +	cpu = smp_processor_id();
> +
> +	return &user->ring[cpu % user->cbdr_num];
> +}
> +

Can this trigger a preemption warning? netc_select_cbdr() is called from
netc_xmit_ntmp_cmd() before spin_lock_bh() is acquired, and the callers
(ntmp_maft_add_entry, ntmp_fdbt_add_entry, etc.) run in process context
with preemption enabled.

Using smp_processor_id() in preemptible code triggers a
"BUG: using smp_processor_id() in preemptible code" warning under
CONFIG_DEBUG_PREEMPT.

Since the CPU value here is only used as a hint for ring selection and not
for correctness, would raw_smp_processor_id() be more appropriate?

>  static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
>  {
>  	union netc_cbd *cur_cbd;
> @@ -125,10 +144,10 @@ static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
>  	u16 status;
>  	u32 val;
>
> -	/* Currently only i.MX95 ENETC is supported, and it only has one
> -	 * command BD ring
> -	 */
> -	cbdr = &user->ring[0];
> +	if (user->cbdr_num == 1)
> +		cbdr = &user->ring[0];
> +	else
> +		cbdr = netc_select_cbdr(user);
>
>  	spin_lock_bh(&cbdr->ring_lock);

