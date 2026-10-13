Return-Path: <linuxppc-dev+bounces-29341-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B26CA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 05:51:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3k3V3TBHz3br2;
	Tue, 13 Oct 2026 16:51:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791870678;
	cv=none; b=LhIWz6Bn8ffefisCxrsYaeCw3I+HWp49H/x2T7iFRlSSCmGjgNK9h+bPydAvKWr8bOA1J386pFNBovijTYJWdijZkB8u/EQMRjBBut2z+S7DSsS8hgNiILnhIzwF6T5g4q0427iRH3nysU4OwD9HGE5p/e7q8bjIdC97QaP4pMXPhS3HhUqe1RhEwRo6wIRRqFfslS3bo8Nisls3rsoQdr3dY2FOhSbAYlR6Est7+RyC0147OMQ/vsxt+M9AC4b0hMq6/jNsanC1s9Z98Olhe5SMtSSB53PH4aJz+nR/fHw2TnUnUx6yuTrG7bGXNRv5AVXIkcW9u1c4IRu3ghuK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791870678; c=relaxed/relaxed;
	bh=pfXpZTSz9pQuEWqJtKTk77hfqQ1QdEAuKZTUwRLZlFI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fH+cA7iyjmZR7iGA6zqNTcjwgOoQiR3+22+VOB4k6haKMqsv4SzECbqrqILfFoSwFv7pv0HC1J3ubASLdaa3BuboCdWj7HjcKhZaTbdMLgo1UPL/WDZ1OIzKQ67wyC/UQ4oReEsKFr50xGO5vGD5vgzADjasK4kcVDNXftxY5Ca6av66RL6CGrmQHPCdzSN0uiCMWkVEnv1ml65q1G5cdal7RawxYEjyCzu4IVRa2wgeuJTTRQ4jPoYBQoO6g3WAWmjTpbnRu+yo+f9unc1wSmTdRwU0ak3MsoinA9hl9OChEb3fBHXjVBbUiI/AdNRJ0qpJYoakg+Pi8IPp34cpSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TONUKNqN; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TONUKNqN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3k3T1SWqz3bqh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 16:51:17 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 64C6F41A5B;
	Tue, 13 Oct 2026 05:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E729C1F000FF;
	Tue, 13 Oct 2026 05:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791870673;
	bh=pfXpZTSz9pQuEWqJtKTk77hfqQ1QdEAuKZTUwRLZlFI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TONUKNqNJwXZaTc6VPaaPCN3Kw5wP8PItYXTZPa9g7ZQGgzITOiemw2TSAtZC8TqF
	 RjJpupctEzS3S4WjtnTdsnTHRC63iaJX1uwpQsGAEwvoZuJYVTjtkXyuTH3QO/tNd6
	 Bbcisms9KGOG/xtoqec8AhqSd/cJl+x2CdI5LSRwNiBL372dWrWB2DRhEwiZBs5yGE
	 NvhBh25nktUXeoLfnUctH4O50wdLhixIKO5jbutoW/pNV+JnY3pTxpI96gb7yQRWF5
	 KIMcT2tYp0FY5AHQF1qn5OXuThcvPpPXQc2F8YbLx2qvGa0fgD/lGbq/Q5rGKsX3uN
	 xy5vJNorvgIFA==
Subject: Re: [PATCH net-next v4 4/9] ibmveth: step past bad RX correlators
 instead of spinning or oopsing
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 davemarq@linux.ibm.com, bjking1@linux.ibm.com, brking@linux.vnet.ibm.com,
 tlfalcon@linux.vnet.ibm.com, jmaxwell37@gmail.com, zdai@us.ibm.com,
 marcelo.leitner@gmail.com, ksiva@linux.vnet.ibm.com
Date: Tue, 13 Oct 2026 05:51:11 +0000
Message-ID: <179187067143.434549.5132413235745240934@kernel.org>
In-Reply-To: <20261012050518.88858-5-mmc@linux.ibm.com>
References: <20261012050518.88858-5-mmc@linux.ibm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch adds a frame-bound check to ibmveth_poll()
  (drivers/net/ethernet/ibm/ibmveth.c, line 1555).

--

ibmveth: step past bad RX correlators instead of spinning or oopsing

This patch changes ibmveth_poll() to advance the RX ring past a bad
correlator, so it no longer spins on the same slot or dereferences the
NULL skbuff array of an inactive pool. It also drops frames whose
offset + length does not fit the pool buffer, or which are shorter than
an Ethernet header. Correlator validation moves into one helper that
logs a ratelimited netdev_err() and schedules a reset.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index cee0e9783b2ab..919b5831d875c 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1469,31 +1510,60 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)

[ ... ]

> +			pool = correlator >> 32;
> +			room = min_t(unsigned int, skb_tailroom(skb),
> +				     adapter->rx_buff_pool[pool].buff_size);
> +			off = offset;
> +			len = length;
> +			if (unlikely(len < ETH_HLEN || off >= room ||
> +				     len > room - off)) {
> +				if (net_ratelimit())
> +					netdev_err(netdev,
> +						   "bad RX frame offset %u length %u (buffer %u), dropping\n",
> +						   off, len, room);
> +				ibmveth_rxq_harvest_buffer(adapter, correlator,
> +							   true);
> +				netdev->stats.rx_dropped++;
                                ^^^^

[Severity: Low]
Should these frames be counted in rx_length_errors and rx_errors rather
than rx_dropped?

The struct rtnl_link_stats64 documentation in
include/uapi/linux/if_link.h describes rx_length_errors as:

    @rx_length_errors: Number of packets dropped due to invalid length.

and says rx_errors "must include events counted by @rx_length_errors".

rx_dropped is documented for packets "received but not processed, e.g.
due to lack of resources or unsupported protocol".

With this branch in ibmveth_poll(), a runt frame (len < ETH_HLEN) or a
frame whose offset/length overruns the pool buffer shows up in ip -s link
and /proc/net/dev as a drop, not as a length error. Each frame is still
counted once, just under a different counter.

The driver doesn't update rx_length_errors or rx_errors anywhere else in
the series either.

Would something like this work instead?

    netdev->stats.rx_length_errors++;
    netdev->stats.rx_errors++;

> +				frames_processed++;
> +				continue;
> +			}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012050518.88858-1-mmc%40linux.ibm.com

