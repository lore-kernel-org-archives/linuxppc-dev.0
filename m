Return-Path: <linuxppc-dev+bounces-26510-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBBEC79F82
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 23:40:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbbgG05wyz2yr9;
	Fri, 04 Sep 2026 09:40:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788459046;
	cv=none; b=BCmjfCrzv6RbxQFSrSu7MH6ZRWc7Iurl/1r1lLfjKbRWnEBlYIte7lEpN7PZAsBmPdqlxl/ML2Y09FoAmBOhfGUmUvyhNzV/567Hn6KmWgBKBO647ju08dMzM5AOmVuL2P+h9C4Lhkxhr9xU/xizsh7rcjHoI4VcML6N1fyV/xnW/8AokgKaEo/2ObNQPb2zG5HRQqOsQIYKd2bGJLKDK3hA1Ht/TLKzoRQcOAV4M0SYfIFDkNguOtDqKP1EAlkEBMrajd/ROJgUCHyPKwDl/UyhTIRaaoRr/QxLPi4ydIRlwXnoIVdjkcsjQ8CevL7sJhtrhFNFLOuC1RYG9tFOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788459046; c=relaxed/relaxed;
	bh=+fj/3c7JYugKRnm63g6HPmBGIPAGmoUlvbhzBQimk+k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ASEez67gnrgfd4oBvgtkmYhBdZT/sot91e8OeTy4I1cY3kLU/TJXOlyhvYu0QgPSIrVvwm8FYk7nafqAWhIzyHiNMasEs/dGBmZp5ez7zB7fkiiTwkAZInA8qbj4fUgy5I1x1jep/H/7SIYOBt4oj6hgkX5Wpk/rUPVsIr7aE8d0lY3MpUS5uYR11rF4xYidusIkRJD+WqgiJZhLo8HiHqofToH/KYSoiQmq2Vq3yKapUlXs6Tx7GRS2eBFVtE/vKqdW31+vhCYkZkvodpDGm74VYxR+5grpXb/86ED40wZzmE0WfGlevrHH53hAmfC3/lUUamcq7slz8GXzLXMKdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbIUwu2k; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbIUwu2k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbSM94scCz2y2R
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 04:10:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BDCE46024D;
	Thu,  3 Sep 2026 18:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682711F00A3E;
	Thu,  3 Sep 2026 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459043;
	bh=+fj/3c7JYugKRnm63g6HPmBGIPAGmoUlvbhzBQimk+k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IbIUwu2kNtqj9XHPHMKvEyE3UysdpegyaVOQmH/PE9gGMS/UG5TzBpSS+cDEkjaVI
	 HQ1P3BGJwIe4weSdkMGfEr+ULdQhHy/tJNYdR/KDcFrSR/24olIGvqchxsefuAHmfz
	 OY6+jFZxHDPw/79DNIqpNHafH7NXN0koRX3UQkymlG6Vuh+48iPrQmon29GGiwJidA
	 SPTSYut7i7rON+Zn3H1mY6TqZOzrPkEyMWat7ve77+e3w/yLYUmQaWqPWGmoc+kE7S
	 t36BTBlwDqb6ZXxNVTVPNs6KZUPf/PJWffUeN/AOeaFYEX3b0RIuz+BYDhZN7IMTjH
	 MiLuc/JSj4mVw==
Subject: Re: [net-next,v6,11/15] ibmveth: Add per-queue RX and TX statistics
 collection
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Thu, 03 Sep 2026 18:10:41 +0000
Message-ID: <178845904193.3394541.17982476800730465689@kernel.org>
In-Reply-To:
 <f78c04298729fa6cb6cd26e19da792b48ff1cef6.1788102125.git.mmc@linux.ibm.com>
References:
 <f78c04298729fa6cb6cd26e19da792b48ff1cef6.1788102125.git.mmc@linux.ibm.com>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 6 · Low: 0

- [Medium] The patch bundles an independently applicable use-after-free
  fix for the reset worker into a statistics feature patch and…
- [Medium] The new ibmveth_get_stats64() populates rx_packets/rx_bytes
  and tx_packets/tx_bytes/tx_dropped but never sets rx_missed_errors or…
- [Medium] ibmveth_get_queue_stats_tx() (and the retired-queue part of
  ibmveth_get_base_stats()) exports the driver's software TX drop…
- [Medium] The new per-queue ethtool -S key tables add driver-private
  strings for counters that already have standard uAPI fields, while the…
- [Medium] ibmveth_update_rx_no_buffer() detects a buffer-list page
  replacement only by the heuristic `if (drops <…
- [Medium] ibmveth_close() calls ibmveth_update_rx_no_buffer() for every
  live queue without holding that queue's replenish_lock, while netpoll…

--

Below is an automated review report for this commit.

ibmveth: Add per-queue RX and TX statistics collection

This moves the ibmveth RX and TX counters out of struct ibmveth_adapter
into per-queue arrays allocated at probe and freed at remove, adds
netdev_stat_ops and ndo_get_stats64, and makes the ethtool -S block
variable length with new per-queue keys.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 2e8896ea5af2e..f4fddfa56571d 100644
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
> +};
> +
> +static const struct ibmveth_qstat ibmveth_tx_qstat_keys[] = {
> +	{ "tx%d_large_packets", IBMVETH_TXQ_OFF(large_packets) },
> +	{ "tx%d_send_failures", IBMVETH_TXQ_OFF(send_failures) },
> +	{ "tx%d_checksum_offload", IBMVETH_TXQ_OFF(checksum_offload) },
> +};

[Severity: Medium]
Do some of these new ethtool -S keys duplicate counters that already have
a standard netlink representation?

The comment above the tables says only counters with no home in the
standard interfaces belong here, and the changelog says ethtool -S keeps
"only the driver-specific keys that have no standard equivalent". Looking
at Documentation/netlink/specs/netdev.yaml:

  tx-hw-gso-packets: Number of packets that necessitated segmentation
                     into smaller packets by the device
  tx-needs-csum:     Number of packets that required the device to
                     calculate the checksum
  rx-hw-drop-overruns: Number of packets dropped due to transient lack of
                     resources, such as buffer space, host descriptors etc.

tx%d_large_packets is the large-send/GSO packet count, tx%d_checksum_offload
is incremented exactly where the driver asks the device to compute the
checksum, and rx%d_no_buffer_drops is a buffer-exhaustion drop count.

Meanwhile the new callbacks added in this same patch fill only packets,
bytes, hw_drops and alloc_fail, leaving hw_gso_packets, needs_csum and
hw_drop_overruns unset. Could those standard fields be filled in
ibmveth_get_queue_stats_rx()/ibmveth_get_queue_stats_tx() instead of
adding private strings, so the values are not exported through two
different interfaces?

rx%d_invalid_buffers is also summed into hw_drops by
ibmveth_get_queue_stats_rx(), so it appears in both places as well.

[ ... ]

> @@ -1017,6 +1143,7 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>  static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
>  					int queue_index)
>  {
> +	struct ibmveth_rx_queue_stats *qstats;
>  	__be64 *p;
>  	u64 drops;
>  
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
Can the retired page's count be lost when the new page is already ahead
of the old value at the first sample?

The only signal that the buffer-list page was replaced is the numeric
decrease. ibmveth_close() samples the counter and leaves it in
no_buffer_drops:

	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
		ibmveth_update_rx_no_buffer(adapter, i);
	ibmveth_free_all_queues(adapter);

and the next ibmveth_open() gets a fresh zeroed page from
ibmveth_alloc_rx_queues():

		adapter->buffer_list_addr[i] =
			(void *)get_zeroed_page(GFP_KERNEL);

Between ibmveth_register_rx_queues() and the first per-queue
ibmveth_replenish_task() in ibmveth_open() the LAN is live with no buffers
posted, so PHYP can push the new page's counter up before the driver reads
it. If the previous session ended at 50 and the new page reads 500 on the
first sample, the "drops < qstats->no_buffer_drops" test is false and those
50 drops disappear from the adapter-wide rx_no_buffer key, from per-queue
rx-hw-drops and from ibmveth_get_base_stats().

Would recording the retirement at the point the page is actually released
(close and queue reuse) be more reliable than inferring it from a decrease?

[Severity: Medium]
This turns a single idempotent store into a two-field accumulating
read-modify-write. Is every caller holding that queue's replenish_lock?

ibmveth_close() calls it without the lock:

	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
		ibmveth_update_rx_no_buffer(adapter, i);

while netpoll can run the same update concurrently under the lock:

  netpoll_poll_dev() -> ndo_poll_controller
    ibmveth_poll_controller()
      ibmveth_replenish_task(adapter, i)
        spin_lock_irqsave(&rxq->replenish_lock, flags)
        ...
        ibmveth_update_rx_no_buffer(adapter, queue_index)

ibmveth_close() is also called directly from ibmveth_set_csum_offload(),
ibmveth_set_tso(), ibmveth_change_mtu() and veth_pool_store() while
netif_running() is still true, so netpoll_poll_disable() has not run.
netpoll_poll_dev() only bails on a missing netpoll info, a held dev_lock,
!netif_running() or local xmit activity, and ndo_poll_controller is not
gated by NAPI state.

With the old single store the worst case was a stale snapshot; with the
new "no_buffer_retired += no_buffer_drops; no_buffer_drops = drops"
sequence an interleaving can double the carry or lose it permanently.

The RX shrink path later in the series wraps the identical call:

	spin_lock_irqsave(&rxq->replenish_lock, flags);
	ibmveth_update_rx_no_buffer(adapter, i);
	spin_unlock_irqrestore(&rxq->replenish_lock, flags);

with the comment that netpoll still reaches these queues. Should the close
path take the same lock?

[ ... ]

> @@ -2038,6 +2176,10 @@ static void ibmveth_reset(struct work_struct *w)
>  	netdev_dbg(netdev, "reset starting\n");
>  
>  	rtnl_lock();
> +	if (netdev->reg_state != NETREG_REGISTERED) {
> +		rtnl_unlock();
> +		return;
> +	}
>  
>  	dev_close(adapter->netdev);
>  	dev_open(adapter->netdev, NULL);

[Severity: Medium]
Could this reg_state gate, together with the ibmveth_remove() reorder
further down, be split out as its own patch with a Fixes: tag?

The changelog acknowledges it: "That reorder is a use-after-free fix in
its own right; it is carried here because this patch depends on it. No
Fixes: tag".

At the baseline the ordering defect is real. ibmveth_remove() has:

	cancel_work_sync(&adapter->work);

	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
		kobject_put(&adapter->rx_buff_pool[i].kobj);

	unregister_netdev(netdev);

and the RX path can re-arm the work after that cancel:

  ibmveth_poll_skip_bad_correlator() -> schedule_work(&adapter->work)
  ibmveth_replenish_task()           -> schedule_work(&adapter->work)

so the worker can run after free_netdev(). Both halves of that fix are
here inside a roughly 500 line feature commit with no Fixes: tag, which
makes the fix hard to identify or backport on its own.

[ ... ]

> @@ -3132,6 +3372,124 @@ static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
>  	return vlan_features_check(skb, features);
>  }
>  
> +/**
> + * ibmveth_get_stats64 - Return aggregated per-queue statistics
> + * @dev: network device
> + * @stats: rtnl link statistics storage
> + *
> + * Sums per-queue rx_qstats and tx_qstats into the rtnl counters.
> + * Walk the full allocated arrays (not the live queue count) so shrinking
> + * channels cannot make the totals go backwards.
> + * Callers use ndo_get_stats64(); avoid updating netdev->stats on the
> + * xmit/poll paths to keep per-queue counters off the hot cache line.
> + */
> +static void ibmveth_get_stats64(struct net_device *dev,
> +				struct rtnl_link_stats64 *stats)
> +{
> +	struct ibmveth_adapter *adapter = netdev_priv(dev);
> +	int i;
> +
> +	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++) {
> +		stats->rx_packets += adapter->rx_qstats[i].packets;
> +		stats->rx_bytes += adapter->rx_qstats[i].bytes;
> +	}
> +
> +	for (i = 0; i < IBMVETH_MAX_QUEUES; i++) {
> +		stats->tx_packets += adapter->tx_qstats[i].packets;
> +		stats->tx_bytes += adapter->tx_qstats[i].bytes;
> +		stats->tx_dropped += adapter->tx_qstats[i].dropped_packets;
> +	}
> +}

[Severity: Medium]
Should this also fill rx_missed_errors or rx_dropped?

The RX loop reports only packets and bytes, while the TX loop does report
tx_dropped, so the RX drops the driver already tracks are not visible in
rtnl_link_stats64 at all.

include/uapi/linux/if_link.h describes the matching field:

 * @rx_missed_errors: Count of packets missed by the host.
 *   Counts number of packets dropped by the device due to lack
 *   of buffer space.

which is exactly what PHYP's buffer-list page counter records and what
ibmveth_get_queue_stats_rx() below exports as rx-hw-drops.

Documentation/networking/statistics.rst says:

  Drivers should report all statistics which have a matching member in
  struct rtnl_link_stats64 exclusively via `.ndo_get_stats64`.

dev_get_stats() does not derive rtnl stats from netdev_stat_ops, so
"ip -s -s link" shows zero RX drops on a device whose qstats and
ethtool -S rx_no_buffer key are both climbing. Is that divergence
intended?

> +
> +static void ibmveth_get_queue_stats_rx(struct net_device *dev, int idx,
> +				       struct netdev_queue_stats_rx *stats)
> +{

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
Does dropped_packets match what tx-hw-drops is specified to count?

Documentation/netlink/specs/netdev.yaml:

        name: tx-hw-drops
        doc: |
          Number of packets that arrived at the device but never left it,

In ibmveth_start_xmit() the counter is bumped for several conditions that
happen entirely in the driver, before ibmveth_send() issues any hypercall:

	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {
		adapter->tx_qstats[queue_num].dropped_packets++;
		goto out;
	}

plus the ibmveth_is_packet_unsupported() loopback rejection, the
skb_checksum_help() failure, skb->len > adapter->tx_ltb_size, and
total_bytes != skb->len. None of those packets reached the device.

The loopback case is reachable by any local sender addressing the
device's own MAC. Would rtnl_link_stats64::tx_dropped alone (which this
patch already populates) be the right home for these, keeping hw_drops
for the ibmveth_send() failure only?

The same mapping is used for the retired queues in
ibmveth_get_base_stats():

	tx->hw_drops += adapter->tx_qstats[i].dropped_packets;

[ ... ]

> @@ -3380,12 +3755,20 @@ static void ibmveth_remove(struct vio_dev *dev)
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>  	int i;
>  
> -	cancel_work_sync(&adapter->work);
> -
>  	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
>  		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
>  
> +	/*
> +	 * Unregister first so NAPI/xmit cannot re-arm reset work after we
> +	 * cancel it. cancel_work_sync() before unregister left a window
> +	 * where poll could schedule_work() and the worker ran after
> +	 * free_netdev().
> +	 */
>  	unregister_netdev(netdev);
> +	cancel_work_sync(&adapter->work);
> +
> +	ibmveth_free_tx_qstats(adapter);
> +	ibmveth_free_rx_qstats(adapter);
>  
>  	free_netdev(netdev);
>  	dev_set_drvdata(&dev->dev, NULL);

This is the second half of the reordering discussed above at
ibmveth_reset(); the same question about lifting it into its own
Fixes:-tagged patch applies here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788102125.git.mmc%40linux.ibm.com

