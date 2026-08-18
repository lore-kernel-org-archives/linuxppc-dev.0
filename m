Return-Path: <linuxppc-dev+bounces-25929-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD4AC5B572
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 01:48:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPCJD0MBwz2yv8;
	Tue, 18 Aug 2026 11:47:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787017660;
	cv=none; b=FbJGmpUuTUVmRXQsCkHyB0Wc+n5jJEQt3TIV/EPqLSICrXUBrI59vaK/Qv8V65HLP4LiCtOeIcn4GIgIt0CHKRvKbKNj7Amc8PFbXyLiyfr0vXgNFPJ4zMBukgCQGSuq+MYLQPUYBKQ86Ce2Onm0fiLPkWB2Gkt6aftLqLXNDAyfeCqcoHW/tW+XyM7xKLfuHa2Qmdc2ZSThLh0UnHCoajSwcmmvIQ2NB63BtlHOGUfmQ63OSoX92iyTAGX2FuH0FJy55SMEsHYiUQT4P1cnalyJNuV3aNHAmi6uG/VND6kr6JbEef4nBxU42+PfK3sXQ12z1iXunMvk7wJP+lWijg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787017660; c=relaxed/relaxed;
	bh=0SYERTz8iYE+Oh4oGG4FMtYhnJ7wnKY5HCJr3RGnVQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6Ncsm7YZCpc/IDMCjUelp0IjKHWzxOGGmAKmA0OWojojylZ2aT5HqWVnk5qNMr/mzxqj/fzISkYtPipzXGwl+tbt7Oih6qgjmQw4iHx1HpHH34zpo2rUtEjLR1MB6YKK79I12zMbvuN6aKW8hEpZHC5lYPlUeP+aFeNgPZPoThnMs06QJxsJ59+4UeN070yiOz2C7DnZKH10FrctPCBDGbSinuGX96F0pCrYPQGMCNSStV2A/iPbWAx1ClS1mqSYedn0pqH6fjy6wtT3olgzAcSkP1ru7d/VeRMH/ncMBzPVs1wH8mtjxtskl+zRVO0AgzKfTPShuzxOi+CBOsAZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKDHNPMH; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKDHNPMH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPCJB6wWnz2yvY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:47:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B9F4C601E9;
	Tue, 18 Aug 2026 01:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FAF1F000E9;
	Tue, 18 Aug 2026 01:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017656;
	bh=0SYERTz8iYE+Oh4oGG4FMtYhnJ7wnKY5HCJr3RGnVQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bKDHNPMHMSP483uPYPi9CW0uA3MwDqoHdEshFDVD7nsldA8QdVTJcuWo5LY6kUIev
	 yxUi24/cE2NuLs5JbcKowny+xfDzbLjaWTmR0u8zt5lcU9F+AtlDAhejj1JbGZ/C2C
	 11Z1WBGa4Q8Wwh4h0fizGQdIf7D8IjNoYL+xmjvVtIkxmaupzXayg0RT84SJ4kQ/Tt
	 yPcImSCG4iAJhNIzMi8qFUnbbIOZbcHXxs0ybxONo0kX+HtoOCXIL+X3EtAAFUdaLi
	 GqGlHxemSZ4tcYZmrmV+K/a0R8SHbvEdPtdxWFQMWK/tcG2JlY1xO2IgkYqCKAAZGD
	 ws1mZ/i2vzZ4Q==
From: Jakub Kicinski <kuba@kernel.org>
To: mmc@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	nnac123@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	davemarq@linux.ibm.com,
	bjking1@linux.ibm.com,
	shaik.abdulla1@ibm.com
Subject: Re: [PATCH net-next v5 12/15] ibmveth: Report MQ-aware RX counts in ethtool get_channels
Date: Mon, 17 Aug 2026 18:47:34 -0700
Message-ID: <20260818014735.3854400-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-13-mmc@linux.ibm.com>
References: <20260814073642.24630-13-mmc@linux.ibm.com>
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
ibmveth: Report MQ-aware RX counts in ethtool get_channels

The patch changes ibmveth_get_channels() to report max_rx as
IBMVETH_MAX_RX_QUEUES when the adapter has multi-queue firmware support
(else 1), and to report rx_count from the driver's published
num_rx_queues instead of netdev->real_num_rx_queues.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 3202b657c9b8f..5d4ca4b3d3d07 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -2522,11 +2522,16 @@ static void ibmveth_get_ethtool_stats(struct net_device *dev,
>  static void ibmveth_get_channels(struct net_device *netdev,
>  				 struct ethtool_channels *channels)
>  {
> +	struct ibmveth_adapter *adapter = netdev_priv(netdev);
> +
>  	channels->max_tx = ibmveth_real_max_tx_queues();
>  	channels->tx_count = netdev->real_num_tx_queues;
>  
> -	channels->max_rx = netdev->real_num_rx_queues;
> -	channels->rx_count = netdev->real_num_rx_queues;
> +	if (adapter->multi_queue)
> +		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
> +	else
> +		channels->max_rx = 1;
> +	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
>  }

[Severity: Medium]
At this point in the series, does raising max_rx here make RX channel
requests silently succeed without changing anything?

ibmveth_set_channels() only derives its work from tx_count:

	unsigned int old = netdev->real_num_tx_queues,
		     goal = channels->tx_count;
	...
	if (!(netdev->flags & IFF_UP))
		return netif_set_real_num_tx_queues(netdev, goal);

channels->rx_count is never read there.  The core validation in
ethtool_set_channels() only bounds the request by the driver-reported
maximum:

	if (channels.rx_count > curr.max_rx ||
	    channels.tx_count > curr.max_tx ||

so with max_rx now 16, "ethtool -L ethX rx N" for any N in 1..16 that
differs from the current RX count passes validation, enters
ibmveth_set_channels() with tx_count unchanged, runs no LTB loop
iterations, and returns 0.  The netlink path in ethnl_set_channels()
applies the same max_rx-only ceiling and maps the 0 return to success.

Before this change max_rx equalled real_num_rx_queues, so an increase was
rejected with -EINVAL by the core; afterwards it is accepted and ignored,
and "ethtool -l" still shows the old rx_count.

For the record, this appears to be resolved later in the same series: the
final patch "ibmveth: Wire ethtool set_channels to MQ RX queue resize"
makes ibmveth_set_channels() read channels->rx_count and apply it via
ibmveth_resize_rx_channels() with range validation of
1..IBMVETH_MAX_RX_QUEUES, so the get/set pair agrees at the end of the
series.  Would it be worth ordering that patch before this one, or
mentioning the intermediate state in the changelog?

[Severity: Low]
A second, smaller point about the same lines: max_rx is derived only from
adapter->multi_queue and does not consult adapter->mq_fallback.  After
firmware refuses multi-queue, ibmveth_apply_mq_fallback() defers the
downgrade to the next open:

	if (!adapter->mq_fallback)
		return;

	adapter->mq_fallback = false;
	...
	adapter->multi_queue = 0;
	ibmveth_publish_num_rx_queues(adapter, 1);

so between the firmware rejection and the next open, "ethtool -l" keeps
reporting max_rx = 16 and rx_count = 8 while the adapter is going to run
single-queue.  Should get_channels() also take mq_fallback into account?

Also, at this patch the reported maximum of IBMVETH_MAX_RX_QUEUES (16) is
above anything the driver publishes, since ibmveth_probe() caps the RX
queue count:

		adapter->multi_queue = 1;
		ibmveth_publish_num_rx_queues(adapter,
					      min(num_online_cpus(),
						  IBMVETH_DEFAULT_QUEUES));

The end-of-series patch "ibmveth: Wire ethtool set_channels to MQ RX
queue resize" does make 1..IBMVETH_MAX_RX_QUEUES genuinely settable via
ibmveth_resize_rx_channels(), so this is only about the intermediate
state and the stale reporting while mq_fallback is latched.

