Return-Path: <linuxppc-dev+bounces-26511-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36612C79F81
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 23:40:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbbgP4H97z2yhD;
	Fri, 04 Sep 2026 09:40:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788459047;
	cv=none; b=FKjotWNN/RU1s4cHlKN/U2yldCqflF+5AlS6OgKIWCiGVhunX1nmnJG7xHJ8B8NQ9ipWK8EHLrdLTidLsH0Oi+Udo5aLBoWHiKWhek92bM3oNUEljKnTlMlkuzABp+3X6ZbXCfPDCCIt4LdHzr3kjxqQezK4e4JyLygTbjFgJCe7xS9tIUUCQHE/5nd1qV2q0pVkx2Bwgx7roCzqGbCCBinCzSEFzFbJr/SCt36usqNmmA1wvLgbOeRX1b2vsyxzz1ZB7lDCSbVVi5axOjIL1req6nsSSRiwBW4v+gDGVFftkZT59wvLc91hKlReR6NazGQRIkL98fwNr5NYhAYhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788459047; c=relaxed/relaxed;
	bh=uISuuiwZrdtenbDaRm1b/C1kKz5oR7is3ldGyyd+Anc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kFF8+RWE5shipsi43Psq8iJKMeKIu9dFGEdzhWW0TFZ5WXqPsKTk5qCzHGJksLV1Ata5smZU4+vbUXZHnz/dnRW/PpqL/zs3L8GktrKk7JMrFbySM/I+Z6EqHC2/UcR16w1EwY37L8tN8E1s4ahUnxgQkxBH7S7Lqa2IrM73hS7UqM+cviN9zV/8x775ycYDto64TkZzsnL1yodmFmjz4vfky9+geMduCL2mwcgk28uLTVs05YKcv8Um+gThx//VF9Le7n0aCkZLcSxk+jh+39CAiXnEdd1opff8DtmuZUBdFyGMrkajcXRU0q04QF+waBOWTiCcyj4NuIz9ylw2iw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMXxebPl; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMXxebPl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbSMB4NlVz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 04:10:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1CD08447B4;
	Thu,  3 Sep 2026 18:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195981F00A3D;
	Thu,  3 Sep 2026 18:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459045;
	bh=uISuuiwZrdtenbDaRm1b/C1kKz5oR7is3ldGyyd+Anc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OMXxebPlOlTvTPS3QDgXiaa1p7O3zUQCpzu6VZ0eoaURtk2xPl2GKcH7HxCBVry/k
	 YbWpjsl43vrSBQGHNkZjDxc3obgm+2i1gGNim0JpiaXlWJAwSRNgAy+3U9vaMdllIw
	 3LSGX76Jc2y4hDMriU5lGsw84+oNv9zpKexLDUH0dXOUrQTK9vOsgZ93UVPCZnPgub
	 UJFIAWvHvu/bbks8cLkVMQZ5Mbu6m9nRyhB9AeTiZ/Pgkqh3NMYEenGVauMIHjbYmR
	 rWJXAqRQf21kKBSlPqGWFrhaCApiuYGvhHWCcVSJpYA561XsM+NF8fXTk8HQnW+En6
	 vwtUrRyAIo7Fg==
Subject: Re: [net-next,v6,12/15] ibmveth: Report MQ-aware RX counts in ethtool
 get_channels
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Thu, 03 Sep 2026 18:10:43 +0000
Message-ID: <178845904365.3394541.4016627609428622506@kernel.org>
In-Reply-To:
 <cfd6de05a68cd8a4f61a1f1e9e1c45a7d9ee2687.1788102125.git.mmc@linux.ibm.com>
References:
 <cfd6de05a68cd8a4f61a1f1e9e1c45a7d9ee2687.1788102125.git.mmc@linux.ibm.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] Intermediate-state ethtool channel ABI mismatch:
  ibmveth_get_channels() (drivers/net/ethernet/ibm/ibmveth.c:2537-2549)…
- [Low] Advertised RX maximum not derived from any driver-side capability
  check: ibmveth_get_channels() (ibmveth.c:2545-2548) reports a flat…
- [Low] ibmveth_get_channels()
  (drivers/net/ethernet/ibm/ibmveth.c:2540-2549) now sources…

--

ibmveth: Report MQ-aware RX counts in ethtool get_channels

get_channels() now reports max_rx as IBMVETH_MAX_RX_QUEUES when MQ firmware
is enabled (1 otherwise) and reports rx_count from the driver's published
num_rx_queues instead of netdev->real_num_rx_queues.  The paired
set_channels() is left unchanged in this patch.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index f4fddfa56571d..4f2d956b4c89e 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -2537,11 +2537,16 @@ static void ibmveth_get_ethtool_stats(struct net_device *dev,
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

[Severity: Medium]
Does raising max_rx here make the kernel admit RX channel requests that the
driver then silently drops on the floor?

The core only bounds an RX request against the value this callback returns,
in ethtool_set_channels():

	if (channels.rx_count > curr.max_rx ||
	    channels.tx_count > curr.max_tx ||

and ethnl_set_channels() does the same check on the netlink path.
ibmveth_set_channels() at this commit only consumes tx_count:

	unsigned int old = netdev->real_num_tx_queues,
		     goal = channels->tx_count;

channels->rx_count is neither read nor rejected.  Since ethtool -L is a
read-modify-write, tx_count arrives unchanged and the TX grow/shrink loops
do not run, so "ethtool -L ethN rx 4" on an MQ adapter returns 0, generates
an ETHTOOL_MSG_CHANNELS_NTF, and changes nothing; a following "ethtool -l"
still shows the old rx_count.

Before this patch max_rx equalled the live count, so the same request was
rejected with -EINVAL by the core, which is why this reads as a behaviour
change rather than a pre-existing gap.

The commit message does acknowledge this:

  "This patch only reports. set_channels() still reads only tx_count, so
  an RX channel request returns success without changing anything;
  raising max_rx widens the range of requests that behave that way from
  the live count to IBMVETH_MAX_RX_QUEUES."

and the later patches do close it: by the end of the series
ibmveth_set_channels() reads channels->rx_count and calls
ibmveth_resize_rx_channels(), which validates the range:

	if (goal_rx < 1 || goal_rx > IBMVETH_MAX_RX_QUEUES) {
		...
		return -EINVAL;
	}

Would it be possible to order the widening of max_rx after the setter
learns to consume rx_count, so no bisect point reports success for a
request it ignores?

[Severity: Low]
Should this ceiling be derived from a capability check rather than being a
flat 16?

The TX side bounds its advertised maximum by the CPU count:

	static unsigned int ibmveth_real_max_tx_queues(void)
	{
		unsigned int n_cpu = num_online_cpus();

		return min(n_cpu, IBMVETH_MAX_QUEUES);
	}

while the RX side reports IBMVETH_MAX_RX_QUEUES (16) purely on
adapter->multi_queue, even though the driver's own MQ default is
min(num_online_cpus(), IBMVETH_DEFAULT_QUEUES), which is at most 8.

The test also ignores adapter->mq_fallback.  After firmware rejects MQ,
multi_queue stays true until the next open runs
ibmveth_apply_mq_fallback():

	adapter->multi_queue = false;
	ibmveth_publish_num_rx_queues(adapter, 1);
	/* real_num_rx_queues is set later in open after resources exist. */

so in that window ethtool -l advertises max_rx = 16 for a device the driver
has already decided will come up single-queue.

The mq_fallback half is handled later in the series, where get_channels()
becomes:

	if (adapter->multi_queue && !adapter->mq_fallback)
		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
	else
		channels->max_rx = rx_count;

The flat 16 does match the range the end-of-series setter accepts, so this
is mostly a question about whether the commit message should say why the RX
maximum intentionally skips the num_online_cpus() cap that TX applies.

> +	channels->rx_count = ibmveth_get_num_rx_queues(adapter);

[Severity: Low]
Can this disagree with the RX queue count the netdev core enumerates?

The queue-stats side of the same driver deliberately keys on the core's
count, in ibmveth_get_base_stats():

	for (i = dev->real_num_rx_queues; i < IBMVETH_MAX_RX_QUEUES; i++) {

with a comment saying the split is bound by real_num_*_queues so it lines up
with the core's iteration exactly.  After this patch, ethtool -l reports the
adapter's private count instead.

The two can drift.  ibmveth_apply_mq_fallback() publishes num_rx_queues = 1
at the very start of open, and netif_set_real_num_rx_queues() is only
reached much later:

	rc = ibmveth_register_rx_queues(adapter, mac_address);
	if (rc)
		goto out_free_buffer_pools;

	rc = netif_set_real_num_rx_queues(netdev,
					  ibmveth_get_num_rx_queues(adapter));

If ibmveth_alloc_filter_list(), ibmveth_alloc_rx_queues(),
ibmveth_alloc_buffer_pools() or ibmveth_register_rx_queues() fails, open
returns an error with adapter->num_rx_queues == 1 while
netdev->real_num_rx_queues still holds the previous value, and
ibmveth_close() never lowers it.

In that state ethtool -l reports rx_count = 1, the core still enumerates the
old number of RX queues for netlink per-queue stats, and the per-queue
ethtool -S strings (which use the adapter count) list only queue 0.

No out-of-bounds access results, since rx_qstats[] is sized
IBMVETH_MAX_RX_QUEUES and the live/retired split stays non-overlapping, and
the state self-heals on the next successful open.  This divergence is still
present at the end of the series, where get_channels() uses the adapter
count and get_base_stats() uses real_num_rx_queues.  Would keying both on
the same counter be preferable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788102125.git.mmc%40linux.ibm.com

