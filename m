Return-Path: <linuxppc-dev+bounces-28524-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DD8CA5FA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:34:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvSyh3JvGz3bcj;
	Wed, 30 Sep 2026 05:33:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790710412;
	cv=none; b=PdZ00SYzvaj7E8OiJHW0DdZoQ5mY09inlQ+AYW/n+5/5QEUHsVnJbRBBO8OodzNeIgWdxbXveR49azAnYfknt3Doi5PwJxavD/vSY85fb8JHHi+VoIDg/GRb55OXSRkEytAiojY2NyP4Ue6dxh4mSgO197eL1athCIrZi/OblhxsVY9RJAB26r8wXRYdndgxS+NwfrSuBk/+Eg3yaoCfD/8oEKD2YUXRZ479I+vWBqAkiaRhbT8nVvfiDwVol41GVin86buCTw4PGmWKZoFWWEqaAc9gwKMUZJcIDXDGBpIxZtOhmAmdNrD6TZlg9rmxkKLy8xsD9f6vS3UHrQ0Keg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790710412; c=relaxed/relaxed;
	bh=+Wptv1o52idotsZjLG6oFQkbThTFVLdtCXaQ12BffWY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uj4VHERhTG2oiXH40JKBf1z0jc+UICEVhSZQNp8/031cETWfl/hMY6gml3qbFyhucSsgjN/ig70VoWnBJtF3E0g8GzzIlwwhHnLVG8aa8TM6UChJf8fHMvYU6rXb7iifUXFPx5Ab7i4R9VbEFy2jMMGQ46E4KUzPMPL2RIUotuOIlfod4FWUZfpzKgdJit/XVGraXnsTzSnX0ZlOSFqREgLVyhMz0W/5G1m04axHBOLbKosD7GUU2A5MiLd5h54r2LfAt8IKtawl/oiDW4sheDfgHEk/QbUv3b2JBeQNkbESSdTH8m008rf01TYBFB/Hk3PFfjftRHDrQIS3zN5ETw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhWX6jC4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhWX6jC4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvSyd46RCz3bfF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:33:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2798A4043E;
	Tue, 29 Sep 2026 19:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3695D1F000FF;
	Tue, 29 Sep 2026 19:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710407;
	bh=+Wptv1o52idotsZjLG6oFQkbThTFVLdtCXaQ12BffWY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UhWX6jC4uDKgikStvrRkP+/h68ddkbMpWjqD/Y9FEXpbyx07SZjH9ecT6zITn15a3
	 V3bxf6irkM26T4/sEgUzzQ3uYKz4Y8/so7CqoEb6dIp0sftf/KFKqGVrd/Vt2F7GXW
	 cAhvEZ3EC4hhAePXUJEFtv3UzqfIO1CMgIcbwChKg9dmViDuhjRM9bCTui/UIhcDG1
	 E/mRmZwc/19TYEBybZojYZxYDW8IEtY6RrvxrAIDN7ksboECxwLjb4K4sG9m5wqs5q
	 fVgusMeFq0Xk9P1zv4xmpmIq4RYOzlMsjuYoCLzB1NSbKqfV2FvEBFlUMzofAcgQSd
	 EZDJDs7kpAOeQ==
Subject: Re: [PATCH net-next v7 12/15] ibmveth: Report MQ-aware RX counts in
 ethtool get_channels
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Tue, 29 Sep 2026 19:33:25 +0000
Message-ID: <179071040580.434549.9696275612271032055@kernel.org>
In-Reply-To:
 <9560e3e3b0fa2e90312660d6f32dc54d1073f8a5.1790319558.git.mmc@linux.ibm.com>
References:
 <9560e3e3b0fa2e90312660d6f32dc54d1073f8a5.1790319558.git.mmc@linux.ibm.com>
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

- [Low] The commit message says "This patch only reports", and the
  subject covers only get_channels().
- [Low] This patch switches ibmveth_get_channels() to report rx_count
  from adapter->num_rx_queues (line 2558) instead of…
- [Low] At this commit, ibmveth_get_channels() computes max_rx only from
  adapter->multi_queue (line 2554-2557) and ignores adapter->mq_fallback.

Pre-existing issues:
- [Low] In ibmveth_set_channels() at this commit, when
  ibmveth_allocate_tx_ltb() fails in the grow loop (line 2593), the code…

--

ibmveth: Report MQ-aware RX counts in ethtool get_channels

This commit changes ibmveth_get_channels() to report max_rx as
IBMVETH_MAX_RX_QUEUES when multi_queue is set (otherwise 1). It also
reports rx_count from the driver's published num_rx_queues. A check is
added to ibmveth_set_channels() that rejects any request changing rx_count
with -EOPNOTSUPP.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 2575a7c11afba..cd2e5e4a81fea 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -2546,11 +2546,16 @@ static void ibmveth_get_ethtool_stats(struct net_device *dev,
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

[Severity: Low]
Should max_rx also check adapter->mq_fallback here?

Firmware can reject MQ in two places. One is a subordinate queue
registration in ibmveth_register_all_queues() returning -EOPNOTSUPP. The
other is ibmveth_replenish_task() seeing H_FUNCTION. In both cases only
mq_fallback is latched:

    if (rc == -EOPNOTSUPP)
        adapter->mq_fallback = true;

multi_queue and num_rx_queues are only updated when the next
ibmveth_open() calls ibmveth_apply_mq_fallback(). Until then, ethtool -l
keeps reporting max_rx = IBMVETH_MAX_RX_QUEUES and the pre-fallback
rx_count.

The commit message says a later patch in the series caps max_rx once
mq_fallback latches. The final version of ibmveth_get_channels() does
check !adapter->mq_fallback, so this is resolved by the end of the series.

> +	channels->rx_count = ibmveth_get_num_rx_queues(adapter);

[Severity: Low]
Can this rx_count disagree with netdev->real_num_rx_queues after a failed
open?

ibmveth_open() applies the fallback before it allocates anything:

ibmveth_open()
    ibmveth_apply_mq_fallback(adapter);
        adapter->multi_queue = false;
        ibmveth_publish_num_rx_queues(adapter, 1);
        /* real_num_rx_queues is set later in open after resources exist. */
    ...
    rc = ibmveth_alloc_filter_list(adapter);
    if (rc)
        goto out;
    ...
    rc = ibmveth_register_rx_queues(adapter, mac_address);
    if (rc)
        goto out_free_buffer_pools;

    rc = netif_set_real_num_rx_queues(netdev,
                      ibmveth_get_num_rx_queues(adapter));

If any allocation or registration step fails, open returns with
num_rx_queues = 1 and multi_queue = false. real_num_rx_queues keeps its
earlier MQ value (for example 8 from probe).

In that state ethtool -l reports rx_count = 1 and max_rx = 1. The sysfs
rx-* queues and the per-queue qstats iteration still show 8 RX queues.
This lasts until the next successful open.

The comment in ibmveth_probe() says the counts are synced "so down-state
readers agree with adapter->num_rx_queues / ethtool -l". This path does
not seem to keep that promise.

The qstats device totals stay exact, because ibmveth_get_base_stats() and
ibmveth_get_queue_stats_rx() both split on real_num_rx_queues. The root
cause is the error handling in ibmveth_open() from earlier in the series.
This patch is what makes the mismatch visible through ethtool -l.

>  }
>  
>  static int ibmveth_set_channels(struct net_device *netdev,
> @@ -2561,6 +2566,14 @@ static int ibmveth_set_channels(struct net_device *netdev,
>  		     goal = channels->tx_count;
>  	int rc, i;
>  
> +	/*
> +	 * RX channel resize is implemented in a later patch; reject any
> +	 * request that changes rx_count. Read-modify-write TX adjustments
> +	 * submit the current rx_count and proceed.
> +	 */
> +	if (channels->rx_count != ibmveth_get_num_rx_queues(adapter))
> +		return -EOPNOTSUPP;

[Severity: Low]
The commit message says:

    This patch only reports. set_channels() still only adjusts tx_count, so
    an RX channel request returns -EOPNOTSUPP if rx_count changes, while
    read-modify-write TX requests pass through with the live rx_count.

Is "This patch only reports" accurate? This check is new in this commit.
Before it, ibmveth_set_channels() did not look at rx_count at all.

On MQ firmware the old get_channels() reported max_rx as
real_num_rx_queues (for example 8). A request like "ethtool -L eth0 rx 4
tx 4" passed the core range check. The driver ignored rx, applied tx = 4
and returned 0.

With this patch the whole request fails with -EOPNOTSUPP, so the TX part
is not applied either.

Only the v7 changelog below the --- line says the check is new, and that
text is dropped when the patch is applied. A later patch replaces this
check with ibmveth_resize_rx_channels(). Still, bisect and blame will show
this commit's message.

Could the subject and body say that this patch also changes how
ibmveth_set_channels() handles rx_count?

> +
>  	/* If ndo_open has not been called yet then don't allocate, just set
>  	 * desired netdev_queue's and return
>  	 */

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. Further
down in ibmveth_set_channels(), is the error from a failed TX LTB
allocation lost?

    rc = ibmveth_allocate_tx_ltb(adapter, i);
    if (!rc)
        continue;
    ...
    goal = old;
    old = i;
    break;
}
rc = netif_set_real_num_tx_queues(netdev, goal);

At that point goal is back to the current count. So
netif_set_real_num_tx_queues() returns 0 and overwrites rc.

The LTBs allocated so far are freed. ethtool -L tx N then reports success
even though tx_count did not change.

These lines come from commit 10c2aba89cc053 (2022). Later in this series,
the final ibmveth_set_channels() returns rc ? rc : -ENOMEM when
real_num_tx_queues != want_tx, which fixes this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790319558.git.mmc%40linux.ibm.com

