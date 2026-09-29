Return-Path: <linuxppc-dev+bounces-28523-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD4DCA5FAD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:34:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvSyf6TdZz3bgl;
	Wed, 30 Sep 2026 05:33:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790710410;
	cv=none; b=BxVvlCrYM6C+OFX6J3GRyK5oaQnm0srJTNsn2lfJzU1I1vKMyA/rhNVHwbBZQZ3oVhzNxgFQLaPrCpGRg9wkqby7ialI/XnRiYY2+3c89KASgXR2VjmM0zFyl9hvpLI7/kjXURtgXe517drJQkmBrKDbWDr1ZyK5EKjoTEOs/PAUGu9Ic3VRhSNNB7niFxRoDIwLMjHvyZqn6PIGKu09sXLIfB921X0f/oYkziYL/9Td2RCuoNc8YJtV7NXvMph2Tk0kC4xtRwwC659PT4TCVReLh6xUiu7M36s9SerLyt7sZYonuYpvWGmhXjz5zZKlD6M3v5ifx7Sk6m1/7boogw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790710410; c=relaxed/relaxed;
	bh=u9z8mTNCN4kE32jHaTJ50+ARXeU9aFNYeT2Nh96nVQs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m3L3OdDIofLB6jKfgUpj+F3nOfuXz2VP/r2WXuOmAHIyD9CRCP9vAQdn/dW4CNkDwo2PUYFsQ2epI3DQ7LguFFK4P39GYd+CCAILnkPrjkuQLX4Mvb+LpW9qrvTG+BFoAsMayhOvjW7dnaL67xlDOp5GAPHgT8Gtkg7HW4Sz2uFm8eTwhNUqLrFj07M7No5JsmJws1Wp9MqK+FNyif4VoP35syZ+Molx3R2E5idQuPtA/Z23/lgJQPG6JaJvTY8Lwk/k/45c19V2MY7FpRZuj4O9IIr4vT7JfbzM5Qe3mLizIqulw39dn5vKU1bVjmsZxfAJC6TSxIfj5EbDGQSJkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2mtvfnb; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2mtvfnb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvSyb516Dz3bcj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:33:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B96D841833;
	Tue, 29 Sep 2026 19:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0541F00898;
	Tue, 29 Sep 2026 19:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710405;
	bh=u9z8mTNCN4kE32jHaTJ50+ARXeU9aFNYeT2Nh96nVQs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F2mtvfnbGWAVIsre/OqBzEc+nU8tA8JOgTe2CMkG/QzpEGjtcmHaaXbUcDHANSL0X
	 HyCHZ6E6T+kDCX0vccR0sMg7pOtVrMVWIGhRfyGERgGy/jG80yTErpazO13HVyGmwB
	 DVp1DcXZiIdD0S6Kpg82JeXKqmdtCJUBHPKeLZxZv9wzPWwcWcl7bf77+SXL8fVJg9
	 NpBsqiUmLZCX/WIr1f1vgglKy4gfZySjy5BYWqeKBkSqUa6qFm74CsViakY/2xs3lf
	 E4oG4Cp3RC0GVqjGS0YLgq0GTwHp0YVISlwQWpAAN59vv5WcuM0amWIXMGMK8Xiz8X
	 5abzidWV6WXaQ==
Subject: Re: [PATCH net-next v7 11/15] ibmveth: Add per-queue RX and TX
 statistics collection
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Tue, 29 Sep 2026 19:33:24 +0000
Message-ID: <179071040441.434549.12197532910792934361@kernel.org>
In-Reply-To:
 <b839ded0f86ec9e064261a99135ae1ad8aa4ac58.1790319558.git.mmc@linux.ibm.com>
References:
 <b839ded0f86ec9e064261a99135ae1ad8aa4ac58.1790319558.git.mmc@linux.ibm.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Three of the new per-queue ethtool -S keys duplicate
  statistics that already have a standard uAPI, which the networking-…
- [Medium] The new no_buffer_retired carry in
  ibmveth_update_rx_no_buffer() only notices a page change when the…
- [Medium] ibmveth_get_queue_stats_tx() (line 3446) and
  ibmveth_get_base_stats() (line 3498) report…
- [Medium] net: stats: Torn reads of related drop counters cause massive
  spikes

--

ibmveth: Add per-queue RX and TX statistics collection

This patch moves the ibmveth RX and TX counters into per-queue structs
that are allocated at probe. Packets, bytes and drops are reported
through netdev_stat_ops and ndo_get_stats64(), and new per-queue
ethtool -S keys are added. A per-queue no_buffer_retired carry is also
added so the PHYP no-buffer drop count stays monotonic across reopen and
queue reuse.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 3f31793645a31..2575a7c11afba 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -75,32 +76,101 @@ module_param(old_large_send, bool, 0444);

[ ... ]

> +/*
> + * Only counters with no home in the standard interfaces belong here.
> + * packets, bytes and drops are reported through netdev_stat_ops.
> + */
> +static const struct ibmveth_qstat ibmveth_rx_qstat_keys[] = {
> +	{ "rx%d_interrupts", IBMVETH_RXQ_OFF(interrupts) },
> +	{ "rx%d_polls", IBMVETH_RXQ_OFF(polls) },
> +	{ "rx%d_large_packets", IBMVETH_RXQ_OFF(large_packets) },
> +	{ "rx%d_invalid_buffers", IBMVETH_RXQ_OFF(invalid_buffers) },
> +	{ "rx%d_no_buffer_drops", IBMVETH_RXQ_OFF(no_buffer_drops) },
>  };
>  
> +static const struct ibmveth_qstat ibmveth_tx_qstat_keys[] = {
> +	{ "tx%d_large_packets", IBMVETH_TXQ_OFF(large_packets) },
> +	{ "tx%d_send_failures", IBMVETH_TXQ_OFF(send_failures) },
> +	{ "tx%d_checksum_offload", IBMVETH_TXQ_OFF(checksum_offload) },
> +};

[Severity: Medium]
Do three of these new per-queue keys duplicate counters that already
have a standard qstats uAPI?

ibmveth_start_xmit() only bumps tx%d_checksum_offload for
CHECKSUM_PARTIAL skbs where the device is asked to fill in the checksum
(IBMVETH_BUF_NO_CSUM | IBMVETH_BUF_CSUM_GOOD). That looks like
tx-needs-csum (netdev_queue_stats_tx.needs_csum).

tx%d_large_packets counts GSO skbs handed to PHYP for large send. That
looks like tx-hw-gso-packets (hw_gso_packets).

rx%d_no_buffer_drops counts frames PHYP dropped because no receive
buffers were posted. That matches rx-hw-drop-overruns ("transient lack
of resources, such as buffer space").

ibmveth_get_queue_stats_rx(), ibmveth_get_queue_stats_tx() and
ibmveth_get_base_stats() only fill packets, bytes, hw_drops and
alloc_fail. So needs_csum, hw_gso_packets and hw_drop_overruns stay
unset, and the same data goes out as private strings instead.

Could these be reported through netdev_stat_ops instead? The comment
above ibmveth_stats[] says ethtool -S key names are ABI. This is still
the case at the end of the series.

The commit message also says:

    ethtool -S keeps only the driver-specific keys
    that have no standard equivalent: interrupts, polls, large_packets,
    invalid_buffers and no_buffer_drops per RX queue; large_packets,
    send_failures and checksum_offload per TX queue.

Is that accurate, given the mappings above?

[ ... ]

> @@ -1028,7 +1155,18 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
>  	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
>  	drops = be64_to_cpup(p);
>  
> -	adapter->rx_no_buffer = drops;
> +	/*
> +	 * PHYP's buffer-list page counter is absolute for that page. A new
> +	 * page (reopen / queue reuse after -L) starts near zero; fold the
> +	 * previous absolute into this queue's retired carry so sums stay
> +	 * monotonic. Both fields belong to the queue being updated, so this
> +	 * stays single-writer under the queue's replenish_lock.
> +	 */
> +	qstats = &adapter->rx_qstats[queue_index];
> +
> +	if (drops < qstats->no_buffer_drops)
> +		qstats->no_buffer_retired += qstats->no_buffer_drops;
> +	qstats->no_buffer_drops = drops;
>  }

[Severity: Medium]
Can a concurrent reader count the same drops twice here?

The rx_no_buffer case sums no_buffer_drops over every rx_qstats[] slot
in one pass. It then sums no_buffer_retired over every slot in a
second pass. ibmveth_update_rx_no_buffer() does the carry as two
separate stores: it adds the old absolute X to no_buffer_retired, and
then overwrites no_buffer_drops with the new, smaller reading.

Suppose that carry runs for a queue after the first pass has read that
queue's no_buffer_drops, but before the second pass reads its
no_buffer_retired. Then X lands in both sums, and rx_no_buffer jumps
by a whole page's worth of drops. The next ethtool -S read falls back
by the same amount. A tool computing a drop rate therefore sees a
burst followed by a negative rate.

Both passes walk all IBMVETH_MAX_RX_QUEUES slots. The window for each
queue is therefore a full walk of the array, not just two adjacent
loads.

The reader takes no replenish_lock, and no seqcount pairs the two
fields. The plain u64 argument in the commit message covers tearing of
a single field on PPC64. It does not cover consistency between two
fields that together form one counter.

ibmveth_get_queue_stats_rx() and ibmveth_get_base_stats() add the same
pair in one expression. That narrows the window without closing it,
and depending on load order the error can go either way.

Is the patch relying on rtnl to keep every carry away from these
readers? If so, could that be stated in the struct
ibmveth_rx_queue_stats comment? Replenish from ibmveth_poll() runs
without rtnl. If not, would it be simpler to read the pair together
under the queue's replenish_lock? Another option is to have the writer
maintain a single monotonic total that the readers load once.

[Severity: Medium]
Can the old page's drops be lost when the first reading on the new page
is not smaller than the old final value?

Each open gets a fresh get_zeroed_page() buffer list from
ibmveth_alloc_rx_queues(), so PHYP's counter in the last 8 bytes of the
new page starts at zero. On close, the harvest stores the old page's
final value X in no_buffer_drops but does not move it into
no_buffer_retired.

On the next open:

ibmveth_open()
  ibmveth_alloc_rx_queues()        /* new zeroed page */
  ibmveth_register_rx_queues()     /* PHYP owns it, no buffers posted */
  ibmveth_replenish_task()
    ibmveth_update_rx_no_buffer()  /* first read, Y */

Frames that arrive between registration and the first replenish count as
no-buffer drops on the new page. If Y >= X, the decrease test does not
fire and X is overwritten. rx_no_buffer and rx-hw-drops then report
R + Y instead of R + X + Y. When X is small, this seems likely on every
reopen.

A queue that ethtool -L removes and then adds back hits the same
problem. ibmveth_scale_down_rx_queues() (from "ibmveth: Implement
incremental MQ RX queue resize" in this series) harvests the queue the
same way, and the re-added queue gets a new zeroed page.

There also seems to be a second window. ibmveth_close() harvests before
the page is released:

	spin_lock_irqsave(&rxq->replenish_lock, flags);
	ibmveth_update_rx_no_buffer(adapter, i);
	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
	}
	ibmveth_free_all_queues(adapter);

Scale-down likewise harvests before h_free_logical_lan_queue(). PHYP
still owns the page at that point, so any drops it adds after the
harvest read are never seen.

The driver allocates and retires these pages itself. Could the carry be
applied explicitly at retirement, after deregistration (something like
retired += drops; drops = 0), instead of being inferred from a decrease?

This code is unchanged at the end of the series.

[ ... ]

> @@ -3145,6 +3387,124 @@ static netdev_features_t ibmveth_features_check(struct sk_buff *skb,

[ ... ]

> +static void ibmveth_get_queue_stats_tx(struct net_device *dev, int idx,
> +				       struct netdev_queue_stats_tx *stats)
> +{
> +	struct ibmveth_adapter *adapter = netdev_priv(dev);
> +
> +	stats->packets = adapter->tx_qstats[idx].packets;
> +	stats->bytes = adapter->tx_qstats[idx].bytes;
> +	stats->hw_drops = adapter->tx_qstats[idx].dropped_packets;
> +}

[Severity: Medium]
Is dropped_packets the right source for tx-hw-drops?

netdev.yaml defines tx-hw-drops as packets that "arrived at the device
but never left it". Most dropped_packets increments come from host-side
paths that never reach ibmveth_send():

  - missing TX LTB in ibmveth_start_xmit()
  - destination MAC equal to dev_addr in ibmveth_is_packet_unsupported()
  - skb_checksum_help() failure
  - skb->len > tx_ltb_size
  - short copy into the LTB

These look like they belong in rtnl tx_dropped, which
ibmveth_get_stats64() already fills from the same counter.
ibmveth_get_base_stats() uses the same mapping for retired queues:

	tx->hw_drops += adapter->tx_qstats[i].dropped_packets;

Separately, ibmveth_send() treats H_DROPPED as success:

	if (ret != H_SUCCESS && ret != H_DROPPED) {
		...
		return 1;
	}

	return 0;

As a result, ibmveth_start_xmit() adds frames that PHYP reports as
dropped to packets and bytes. If H_DROPPED means the hypervisor
discarded the frame, would the new tx-packets and tx-hw-drops pair
misattribute it?

The H_DROPPED handling is older than this patch. Exporting it through
these qstat fields is new.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790319558.git.mmc%40linux.ibm.com

