Return-Path: <linuxppc-dev+bounces-18726-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748AFF54ADC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:58:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgGTG1C0fz2yng;
	Wed, 25 Mar 2026 03:58:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774371522;
	cv=none; b=AdXSn5C+mXIwUmHWmBn9lIMrTiSs+n6+E9iQS02wB1fXh1BjStyYVf7KGFuHMAphuYjsCV4L/GkkzV55cMZZwWCLjTcQYaD48CxLyB/jCcfiO7AJBSYN99piwP3nmhZCCu71yikfxEZVRt30WGLNk+Db3cBtdUrpvFKEtckxWfKstTmogwmYY2TdOciJ/sO2Deb+eO6ByPTU/Nb0p1GjOFU+mQNln92pBaPU2omPsZ+4B7XtmTvHVAgS9Xjz3G860ScqAqPViFIWGLpHOfpcqnursRwisrBoC8rIHuSzok83krB50ZUSpFWe0G82c4f51ED73qdNdNcfJWkrCaIiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774371522; c=relaxed/relaxed;
	bh=pcUAX0q1yGtUD3vTJWJKedAHMDPJIsOcQZyGNEBEUBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvkAXIwEo29y3Vd7jJeQP8Js5mfsQjQLYzjSsV0iEsU4o/H2idYi556juCAT5x8XF1+moLAO0E+0fBeuXCy57i9J5gAyUyZYy6iZmuUR6v4f87d5j0S2PB/PPk9Rqyck9pxIEttc+AT3CiaLzZZLy3jjbQ9VFaFl+zerrX67dLIRTZIIOBpx4QUd5TDvJORUUFv1bUEhSL6ZbBghqJIWm+EPnKaj7kj+Rw9rmxXxfd7QjRqxNszN8QFLogHY7mp+2HJcBh0fm0BPxl5apYwFUJ+w6yfEw6H7AOHog57mLPDt76+c9rQ3NjyAfb9I0C5cL1a2Me1mLyLgUKebInYMmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RKc66ACI; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RKc66ACI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgGTF2mKBz2ynP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 03:58:41 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F3B843E35;
	Tue, 24 Mar 2026 16:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F19EC19424;
	Tue, 24 Mar 2026 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774371519;
	bh=XTX3RY7lgLXPIuC8OIWPU6uF7FH2kNY+iILh8Aykr9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RKc66ACIVg0DMObY7mYeEgbbYlwLWvGU2c2JLYflggsoa+sRKJ/wwQUy1JGBXocBC
	 AD4JqBTcSW0NwMq8szw8olUqMB43x3FpezZASqKUmSyDmHtBBCQ2iVpP6P/mVFzfdU
	 CTxAS3J+MYl7n3Ka7tbXRN/ehxVUjANMaGV/pVh3v0D7LhBIfxyF55ywOdI+0Q5NFm
	 Mc4fkj3s+oM3rMvggMKHFtHMZWB+KE6al6bh8Z1Ws3DDXAVBSm7pa2zJBs5uihcyaK
	 dxO83w/ddPbDzgZIGtZsarGjGDJQTX2mdDEY+aBAZIvBrXD6MIwcZ7+4OHMfa4DNmG
	 gVVOCNQ4PBv9A==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	frank.li@nxp.com,
	devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	kuba@kernel.org,
	claudiu.manoil@nxp.com,
	andrew@lunn.ch,
	krzk+dt@kernel.org,
	linux@armlinux.org.uk,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	f.fainelli@gmail.com,
	imx@lists.linux.dev,
	chleroy@kernel.org,
	netdev@vger.kernel.org,
	robh@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	xiaoning.wang@nxp.com,
	davem@davemloft.net
Subject: Re: [PATCH v2 net-next 08/14] net: enetc: add multiple command BD rings support
Date: Tue, 24 Mar 2026 16:58:04 +0000
Message-ID: <20260324165804.245011-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323060752.1157031-9-wei.fang@nxp.com>
References: <20260323060752.1157031-9-wei.fang@nxp.com>
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

This patch adds support for multiple command BD rings to the NTMP driver.
The switch has two command BD rings, and netc_select_cbdr() is added to
select an appropriate ring when the current one is busy.

> diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
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

Frank Li raised a concern about the use of spin_is_locked() here. Is this
lockless check reliable across all architectures? spin_is_locked() behavior
varies across configurations - it can return false negatives on UP builds and
may not provide the ordering guarantees needed for lockless checks.

Would spin_trylock() be more appropriate here? Or if this racy check is
intentional and acceptable, should it be documented why the potential race is
safe in this context?

> +
> +	/* If all the command BDRs are busy now, we select
> +	 * one of them, but need to wait for a while to use.
> +	 */
> +	cpu = raw_smp_processor_id();
> +
> +	return &user->ring[cpu % user->cbdr_num];
> +}
> +
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

This isn't a bug, but Frank Li suggested that the special case for
cbdr_num == 1 might be redundant. Since netc_select_cbdr() would handle the
single ring case correctly (the loop would find the only ring on the first
iteration), would it be simpler to just unconditionally call:

    cbdr = netc_select_cbdr(user);

>
>  	spin_lock_bh(&cbdr->ring_lock);
>

