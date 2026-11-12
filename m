Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D37C606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 23:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VoC3cO/8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQckc0krSz3bf4;
	Fri, 13 Nov 2026 10:57:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794527832;
	cv=none; b=KJaKbp1t2BC2CKjlT6gNLAr099wWEjOngLysrimaFG0m20rOVL3SzaphIdEF+ZjjSidRGy7EvqZEQkdDF+cvdn54geBnzf/FHkGG0JOGJaWdKFSA0KcS+3qpIfuaPMFZ2eE9fmhhUNfR26z4VPtFHbneD69koYvinYp6xFxGKyOQwWDICPoXg71f17PxiPcTQeV7qmKosIP7RYCUjvPKPFaVy8ABPkZoR5wwOtUFdv6x4rQ/LRtpXg5GiecUTqyv2SlP9LUzullVAdHgZpgJUAi+RP9y1UMxBt2Bht6RefdLiNUMqxbPV6lBQDVH/tTWzuw++zKH5bwcdgGthVa9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794527832; c=relaxed/relaxed;
	bh=0NS2CJ7BkC75vko+7B/WkqWP1lQ3iTvoy9WpBl3NUPY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bnqm1626uf160X1Zeor12y1dtKWJCm7pqWmWMuRjfS17F+FHkYlTjmRFJdTXLi7vrY9q3Z5IDEAwa9te592fD+B95fsEdzicEu4iqoZ9uBU4a80Xo6Q+RsAVZiJiCF1pcaF3wUMF3ABHvClc+S9jkYXsLY5d1Oc+r9713InCswG5d9muAz/GGzrRN39NbUvo1mqZp3miaoQQZkku2+qG+yOmEDNzIn+iyxOPKqcMkVKgTf0FzAbI5C3KyV1rLBOS+FYGJ/636Ogf/VlH1oM0QOfxOYfZkQ1m/RP97/G+a2XlusrYDGounVzY36PvQqeMr69chDVTyR6ea6KsmjYakA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VoC3cO/8; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VoC3cO/8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQckb0N5Lz3bjc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 10:57:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 78720434A8;
	Thu, 12 Nov 2026 23:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565351F000C5;
	Thu, 12 Nov 2026 23:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527829;
	bh=0NS2CJ7BkC75vko+7B/WkqWP1lQ3iTvoy9WpBl3NUPY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VoC3cO/8ii0AJO8CxU68emtq4y71XBqBMTZW7hNkSsAkm8q8dd6oOIfD1VkaXaakb
	 iaSwl6o/9OpwfOHjW3W2Od/UiZ4wMhxpqHC1qd4e5O7SORoA8fCoflyqbfIkurRGmo
	 7AOCIAqdLQSrckibsGZeAtLVG3VoPkHdu8gOIVmaiO6OWy6bUSEIeCo2QXiU+1cb17
	 kdJYLvqPOZeDk0ISf2EbaD36Htix0Iaawpw7VwGrO4Z47orZFwlJigp7AmEaDDs70Z
	 Nl32c7NDEF/+QUbmWN6ZlH6r9UZ9Sy7LFb2v6099T90uiDc56+vvUyf1838wsz8PTR
	 Uuna5espby2qQ==
Subject: Re: [PATCH net-next v8 09/15] ibmveth: Split RX poll into per-slot
 helpers for MQ
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Date: Thu, 12 Nov 2026 23:57:07 +0000
Message-ID: <179452782793.2199510.9499516372041344011@kernel.org>
In-Reply-To: <20261109235556.60604-10-mmc@linux.ibm.com>
References: <20261109235556.60604-10-mmc@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch moves the RX frame-bound drop into a new helper,
  ibmveth_poll_drop_oversize(), and changes its log text.

--

ibmveth: Split RX poll into per-slot helpers for MQ

This commit splits the ibmveth_poll() loop body into per-slot helpers
(stopping, recycle_invalid, skip_bad_correlator, drop_oversize,
deliver_frame, bump_invalid), so the NAPI callback becomes a thin budget
loop. It also adds checks that stop polling once the device is down or a
napi_disable() is pending, and a WARN for a NAPI index past the queue
count, in preparation for multi-queue RX.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index a1f286b37effa..b12bfa1e485eb 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> +static void ibmveth_poll_drop_oversize(struct net_device *netdev,
> +				       struct ibmveth_adapter *adapter,
> +				       int queue_index, unsigned int off,
> +				       unsigned int len, unsigned int room,
> +				       u64 correlator)
> +{
> +	if (net_ratelimit())
> +		netdev_err(netdev,
> +			   "RX frame %u+%u exceeds buffer %u on queue %d, dropping\n",
> +			   off, len, room, queue_index);
> +	netdev->stats.rx_dropped++;
> +	ibmveth_rxq_harvest_correlator(adapter, queue_index, true, correlator);
> +}

[ ... ]

> +	pool = correlator >> 32;
> +	bpool = &adapter->rx_buff_pool[queue_index][pool];
> +	room = min_t(unsigned int, skb_tailroom(skb),
> +		     bpool->buff_size);
> +	off = offset;
> +	len = length;
> +	if (unlikely(len < ETH_HLEN || off >= room ||
> +		     len > room - off)) {
> +		ibmveth_poll_drop_oversize(netdev, adapter, queue_index,
> +					   off, len, room, correlator);
> +		return 0;
> +	}

[Severity: Low]
Does the new message in ibmveth_poll_drop_oversize() describe the runt
case correctly?

The guard in ibmveth_poll_deliver_frame() sends all three conditions to
the same helper, including len < ETH_HLEN. A 10-byte frame at offset 0
in a 2048-byte buffer would be logged as:

  RX frame 0+10 exceeds buffer 2048 on queue 0, dropping

That frame was too short, not too large.

The old text this replaces was neutral and matched every condition:

-						   "bad RX frame offset %u length %u (buffer %u), dropping\n",

This is the only log line on this path, so it is what someone looking
into PHYP descriptor problems from dmesg would see.

The commit message calls this moving existing checks into helpers, and
only says "a PHYP offset+length beyond min(skb_tailroom,
pool->buff_size) is dropped". It doesn't mention that the message
changed or that runt frames now go through the oversize helper. The
wording is the same at the end of the series.

Could the neutral wording be kept, the log say which check failed, or
the len < ETH_HLEN case be handled on its own?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235556.60604-1-mmc%40linux.ibm.com

