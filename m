Return-Path: <linuxppc-dev+bounces-25523-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E84EC5AC67
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 18:38:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGGGm4Kmvz3c98;
	Fri, 07 Aug 2026 04:37:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786041440;
	cv=none; b=bn88ULBTVr6kELdczwxtxZDDKE0mQ662Pvm8Yqo9C9GkURu5A6QwqrSTWhQLEBK6H9phNGYYE+PIXWM2lmyk7bPGE0PdVg0RW5iv/9Jei9L0nXj8aMcqOv4cB2nX8COSMjQ3TXSFbuXmOkPUoSPqouHTBaWX4EMXN5rofhRO9mvhgUsqH9X9r00B0QAIfd6H2Q1iHKM9mVhf3RZpFyBnM/jNoE1IKbA+W7ym+JvWH1uASjaRfzlLlEnR/l3iVBIOC/CMLO/kHHKg6LDvT/J4rfGVq6DW8XwFP9op+WVUFJ6cLV81rcDq35i80fYoJWFkjdkiUzD3/Ag5xJ+BrSiJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786041440; c=relaxed/relaxed;
	bh=6sG5OE0dlvjF0m+mWFCFsWLJZmSAfA4w0ThpfmTuFyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An5z876O/pv91pOkaEAJopEZhuVrJ9+VOGf38JSebUgldRoRBwoVnQ/ua4e3sddREj/r1Fkx4vCw/rU+Qzl9qevqS8Kd2xrGsVgpiE7MF1K+4n6VzzU1O9e7A3eyytVxDOI1KH3um3YknxyA3nNrn2iwtqa0qAAGMwWvTclzfjXJd47KfJTLLa1WGEmQKh5Praarl46fyfyWPqH7+xSh4pND8ij6JvlnjY179yfcYxT7lfVfqAPO6uwmRddgmffC80GVtwkWahD8S047bjuS9iCEyTIHhZLRH3YP762USJq9pYBcTSlXsJhfTBYGL7jErt5vnUpMDb+90+1Uf7jDvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXIb63WV; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXIb63WV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGGGd3WyWz3c4P
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 04:37:13 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F27BF60103;
	Thu,  6 Aug 2026 18:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA721F000E9;
	Thu,  6 Aug 2026 18:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041430;
	bh=6sG5OE0dlvjF0m+mWFCFsWLJZmSAfA4w0ThpfmTuFyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DXIb63WVgt8lSHqy7benQUdBKHGs29ESR++2WY47JcNSPe6TLmKpuv/6cyPKxsMtx
	 GWhldSBUYuUIHPb126rooDkbs6IlsYwSQpJfTNpmrFBUf/sF/X1HAA9L0kOfl5Go1Y
	 ase/x8NT+I6FfcQ6GYu/XY0ij/0bywXOmOgL/Pw//TzC8bpho2XCCjFcayfFnw0nrk
	 ry+m4gdRykIoYVG40zvbC8hzoS0KDIlQRXFH5Yg1a+BHY0LF9ocFBKnuERAbQRC55g
	 8MWcUEbcV/d6pYJhY75k0O8WVsWcJTmp4+SJfh/g/kYqE8lxqruYjLYBW6a9gyAu3D
	 8RJrQtaKrrSOw==
From: Jakub Kicinski <kuba@kernel.org>
To: mmc@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	horms@kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	simon.horman@corigine.com,
	shaik.abdulla1@ibm.com,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v4 10/14] ibmveth: Add per-queue RX and TX statistics collection
Date: Thu,  6 Aug 2026 11:37:09 -0700
Message-ID: <20260806183709.3175682-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <69368babf33c52163881c33d3929ab17b61d0629.1785457143.git.mmc@linux.ibm.com>
References: <69368babf33c52163881c33d3929ab17b61d0629.1785457143.git.mmc@linux.ibm.com>
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
ibmveth: Add per-queue RX and TX statistics collection

This patch adds per-queue RX and TX counter arrays that live for the
adapter lifetime, exports them through ethtool -S, and adds an
ndo_get_stats64 implementation that sums them. It also changes what
ibmveth_get_channels() reports for max_rx and rx_count.

A few questions below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 4ad7ced3c6083..dbb47a42b4cb5 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -921,6 +975,8 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>  		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
>  		u64 drops = be64_to_cpup(p);
>  
> +		if (adapter->rx_qstats)
> +			adapter->rx_qstats[i].no_buffer_drops = drops;
>  		adapter->rx_no_buffer += drops;
>  	}
>  }

[Severity: Medium]

Can concurrent polls on different queues corrupt these counters?

ibmveth_update_rx_no_buffer() writes rx_qstats[i] for every queue, but
its caller ibmveth_replenish_task(adapter, queue_index) holds only that
one queue's lock:

	spin_lock_irqsave(&rxq->replenish_lock, flags);
	...
	ibmveth_update_rx_no_buffer(adapter);
	spin_unlock_irqrestore(&rxq->replenish_lock, flags);

So two NAPI polls on different queues run the same all-queue loop under
disjoint locks (replenish_lock[0] vs replenish_lock[1]):

CPU A: reads queue 1 hypervisor value 100
CPU B: reads queue 1 hypervisor value 105, stores 105
CPU A: stores 100

Does that make rxN_no_buffer_drops move backwards as seen by ethtool?
The adapter->rx_no_buffer = 0 / += drops sequence around it is also an
unsynchronized read-modify-write visible to a concurrent ethtool reader.

This also seems to work against the ____cacheline_aligned_in_smp
annotation added to struct ibmveth_rx_queue_stats, since every replenish
cycle now dirties every queue's stats cache line from a foreign CPU.

Would passing queue_index into the helper and touching only
rx_qstats[queue_index] and buffer_list_addr[queue_index] work, deriving
the adapter-level rx_no_buffer by summing on read the way the patch
already does for rx_large_packets and rx_invalid_buffer?

Related: at the end of the series the RX scale-down path in
ibmveth_resize_rx_queues_incremental() lowers adapter->num_rx_queues and
then frees a queue's buffer_list page while polls on surviving queues keep
running. Can a poll that already loaded the old bound dereference
buffer_list_addr[i] for a freed page here?

[Severity: Medium]

Should no_buffer_drops be accumulated rather than assigned?

The value PHYP writes into the last 8 bytes of the buffer-list page is an
absolute count for the life of that page, and the page is re-obtained with
get_zeroed_page(GFP_KERNEL) by ibmveth_alloc_rx_queues() on every
ibmveth_open() and released by ibmveth_cleanup_rx_resources() on every
ibmveth_close(), including the close/open pairs done by the reset work,
ibmveth_set_csum_offload() and ibmveth_set_tso().

Since rx_qstats[i].no_buffer_drops is assigned with "= drops", does
rxN_no_buffer_drops (and the recomputed adapter->rx_no_buffer) jump
backwards after an ifdown/ifup, a driver reset, or an ethtool -K tso
change?

That appears to contradict the comment this patch adds above the sum
helpers:

	 * globals on the hot path (ibmvnic-style); with qstats allocated for the
	 * adapter lifetime, these sums remain meaningful across ifdown/up.

> @@ -1972,22 +2028,131 @@ static int ibmveth_set_features(struct net_device *dev,
>   * globals on the hot path (ibmvnic-style); with qstats allocated for the
>   * adapter lifetime, these sums remain meaningful across ifdown/up.
>   */
> +static u64 ibmveth_sum_rx_invalid_buffers(struct ibmveth_adapter *adapter)
> +{
> +	u64 total = 0;
> +	int i;
> +
> +	if (!adapter->rx_qstats)
> +		return adapter->rx_invalid_buffer;
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++)
> +		total += adapter->rx_qstats[i].invalid_buffers;
> +
> +	return total;
> +}

[ ... ]

> +static u64 ibmveth_sum_tx_send_failed(struct ibmveth_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	u64 total = 0;
> +	int i;
> +
> +	if (!adapter->tx_qstats)
> +		return adapter->tx_send_failed;
> +
> +	for (i = 0; i < netdev->real_num_tx_queues; i++)
> +		total += adapter->tx_qstats[i].send_failures;
> +
> +	return total;
> +}

[Severity: Medium]

Do these sums go backwards when the queue count is reduced?

The qstats arrays persist for the adapter lifetime, but the sums are
bounded by the currently configured queue count. ibmveth_set_channels()
lowers netdev->real_num_tx_queues:

	rc = netif_set_real_num_tx_queues(netdev, goal);

Nothing folds or clears the counters of the queues that disappear, so
after "ethtool -L ethX tx N" with a smaller N, do the adapter-level
ethtool strings tx_large_packets and tx_send_failed, plus the
rtnl_link_stats64 tx_packets/tx_bytes/tx_dropped summed in
ibmveth_get_stats64(), all drop by the traffic accounted to the removed
queues, and then jump forward again when the count is raised?

Since this patch removes the hot-path netdev->stats accounting,
ibmveth_get_stats64() is now the only source for the rtnl counters, so a
decrease is directly user visible; tools computing deltas (ip -s link,
ifstat) will read it as a counter wrap. The same applies on the RX side
with adapter->num_rx_queues once the incremental RX resize commit later in
this series changes it at runtime.

> +static u64 ibmveth_ethtool_adapter_stat(struct ibmveth_adapter *adapter,
> +					int index)
> +{
> +	unsigned long offset = ibmveth_stats[index].offset;
> +
> +	if (offset == IBMVETH_STAT_OFF(rx_invalid_buffer))
> +		return ibmveth_sum_rx_invalid_buffers(adapter);
> +	if (offset == IBMVETH_STAT_OFF(rx_large_packets))
> +		return ibmveth_sum_rx_large_packets(adapter);
> +	if (offset == IBMVETH_STAT_OFF(tx_large_packets))
> +		return ibmveth_sum_tx_large_packets(adapter);
> +	if (offset == IBMVETH_STAT_OFF(tx_send_failed))
> +		return ibmveth_sum_tx_send_failed(adapter);
> +
> +	return IBMVETH_GET_STAT(adapter, offset);
> +}
> +
>  static void ibmveth_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  {
> +	struct ibmveth_adapter *adapter = netdev_priv(dev);
> +	u8 *p = data;
>  	int i;
>  
>  	if (stringset != ETH_SS_STATS)
>  		return;
>  
> -	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++, data += ETH_GSTRING_LEN)
> -		memcpy(data, ibmveth_stats[i].name, ETH_GSTRING_LEN);
> +	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++) {
> +		memcpy(p, ibmveth_stats[i].name, ETH_GSTRING_LEN);
> +		p += ETH_GSTRING_LEN;
> +	}
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		ethtool_sprintf(&p, "rx%d_packets", i);
> +		ethtool_sprintf(&p, "rx%d_bytes", i);
> +		ethtool_sprintf(&p, "rx%d_interrupts", i);
> +		ethtool_sprintf(&p, "rx%d_polls", i);
> +		ethtool_sprintf(&p, "rx%d_large_packets", i);
> +		ethtool_sprintf(&p, "rx%d_invalid_buffers", i);
> +		ethtool_sprintf(&p, "rx%d_no_buffer_drops", i);
> +	}
> +
> +	for (i = 0; i < dev->real_num_tx_queues; i++) {
> +		ethtool_sprintf(&p, "tx%d_packets", i);
> +		ethtool_sprintf(&p, "tx%d_bytes", i);
> +		ethtool_sprintf(&p, "tx%d_large_packets", i);
> +		ethtool_sprintf(&p, "tx%d_dropped_packets", i);
> +		ethtool_sprintf(&p, "tx%d_send_failures", i);
> +		ethtool_sprintf(&p, "tx%d_checksum_offload", i);
> +	}

[Severity: Medium]

Should the per-queue packet and byte counters use the standard per-queue
statistics interface instead of driver-private ethtool strings?

rx%d_packets, rx%d_bytes, tx%d_packets and tx%d_bytes map one to one onto
struct netdev_queue_stats_rx and struct netdev_queue_stats_tx, which are
exported through netlink via struct netdev_stat_ops. No netdev_stat_ops
is added here, so generic tooling (ynl) cannot consume these values, and
Documentation/networking/statistics.rst asks that counters with a standard
uAPI not be duplicated in ethtool -S.

Also, the new ibmveth_get_stats64() populates only rx/tx packets, bytes
and tx_dropped:

	stats->tx_errors = dev->stats.tx_errors;

After this patch, is there any remaining writer of dev->stats in this
driver? The only match in the file is this read, so tx_errors appears to
be permanently 0. The loss counters this patch does collect
(no_buffer_drops from the hypervisor, invalid_buffers) are not mapped
into rx_dropped / rx_missed_errors / rx_errors either, so ip -s link
reports zero RX drops while ethtool -S shows a non-zero rx_no_buffer.

> +
> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> +		ethtool_sprintf(&p, "pool%d_size", i);
> +		ethtool_sprintf(&p, "pool%d_active", i);
> +		ethtool_sprintf(&p, "pool%d_available", i);
> +	}
>  }
>  
>  static int ibmveth_get_sset_count(struct net_device *dev, int sset)
>  {
> +	struct ibmveth_adapter *adapter = netdev_priv(dev);
> +
>  	switch (sset) {
>  	case ETH_SS_STATS:
> -		return ARRAY_SIZE(ibmveth_stats);
> +		return ARRAY_SIZE(ibmveth_stats) +
> +		       adapter->num_rx_queues * IBMVETH_NUM_RX_QSTATS +
> +		       dev->real_num_tx_queues * IBMVETH_NUM_TX_QSTATS +
> +		       IBMVETH_NUM_BUFF_POOLS * 3;
>  	default:
>  		return -EOPNOTSUPP;
>  	}

[ ... ]

> @@ -1996,21 +2161,59 @@ static int ibmveth_get_sset_count(struct net_device *dev, int sset)
>  static void ibmveth_get_ethtool_stats(struct net_device *dev,
>  				      struct ethtool_stats *stats, u64 *data)
>  {
> -	int i;
>  	struct ibmveth_adapter *adapter = netdev_priv(dev);
> +	int i, j;
>  
>  	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++)
> -		data[i] = IBMVETH_GET_STAT(adapter, ibmveth_stats[i].offset);
> +		data[i] = ibmveth_ethtool_adapter_stat(adapter, i);
> +
> +	for (j = 0; j < adapter->num_rx_queues; j++) {
> +		if (adapter->rx_qstats) {
> +			data[i++] = adapter->rx_qstats[j].packets;
> +			data[i++] = adapter->rx_qstats[j].bytes;
> +			data[i++] = adapter->rx_qstats[j].interrupts;
> +			data[i++] = adapter->rx_qstats[j].polls;
> +			data[i++] = adapter->rx_qstats[j].large_packets;
> +			data[i++] = adapter->rx_qstats[j].invalid_buffers;
> +			data[i++] = adapter->rx_qstats[j].no_buffer_drops;
> +		} else {
> +			i += IBMVETH_NUM_RX_QSTATS;
> +		}
> +	}

[Severity: Low]

Can adapter->rx_qstats or adapter->tx_qstats ever be NULL here?

The allocations happen in ibmveth_probe() before register_netdev(), and a
failure aborts probe with ibmveth_probe_cleanup() + return -ENOMEM.
ibmveth_remove() frees them only after unregister_netdev(). So on a
registered netdev the NULL case seems unreachable, which would make these
else arms, the else arms in ibmveth_poll(), and the
"if (!adapter->*_qstats) return adapter-><legacy>;" early returns in the
four sum helpers dead code.

The two styles also disagree: ibmveth_is_packet_unsupported() guards with
"if (adapter->tx_qstats)" while ibmveth_start_xmit() dereferences
adapter->tx_qstats[queue_num] unconditionally at six new sites on the same
call chain. Which of the two is intended?

A side effect is that adapter->rx_invalid_buffer, rx_large_packets,
tx_large_packets and tx_send_failed are never incremented again while
still being listed in ibmveth_stats[].

Separately, ibmveth_ethtool_adapter_stat() dispatches by comparing
ibmveth_stats[index].offset against IBMVETH_STAT_OFF() values. Would
adding or reordering a field in struct ibmveth_adapter silently redirect a
statistic to the wrong source here?

> +
> +	for (j = 0; j < dev->real_num_tx_queues; j++) {
> +		if (adapter->tx_qstats) {
> +			data[i++] = adapter->tx_qstats[j].packets;
> +			data[i++] = adapter->tx_qstats[j].bytes;
> +			data[i++] = adapter->tx_qstats[j].large_packets;
> +			data[i++] = adapter->tx_qstats[j].dropped_packets;
> +			data[i++] = adapter->tx_qstats[j].send_failures;
> +			data[i++] = adapter->tx_qstats[j].checksum_offload;
> +		} else {
> +			i += IBMVETH_NUM_TX_QSTATS;
> +		}
> +	}
> +
> +	for (j = 0; j < IBMVETH_NUM_BUFF_POOLS; j++) {
> +		data[i++] = adapter->rx_buff_pool[0][j].size;
> +		data[i++] = adapter->rx_buff_pool[0][j].active;
> +		data[i++] = atomic_read(&adapter->rx_buff_pool[0][j].available);
> +	}
>  }

[Severity: Medium]

Should the pool%d_* strings be queue-indexed?

The driver now keeps an independent pool set per RX queue
(rx_buff_pool[queue][pool], populated for all q < adapter->num_rx_queues
by ibmveth_alloc_buffer_pools() and updated per queue by
ibmveth_replenish_task()), but these three entries read only
rx_buff_pool[0][j] under queue-agnostic names, so the state of queues
1..N-1 is not visible. Is that intended for someone debugging drops on a
non-zero queue?

Also, size and active are configuration values already exposed through the
per-pool sysfs kobjects rather than statistics, and this new permanent
ethtool string set is not mentioned in the commit message.

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
> +	channels->rx_count = adapter->num_rx_queues;
>  }

[Severity: Low]

This isn't a bug, but would this ABI-visible get_channels() reporting
change be easier to review as its own patch? It is independent of the
statistics work, and if it is a fix it would want its own Fixes: tag.

There is also a mismatch it introduces: the new RX loops in
ibmveth_get_strings() / ibmveth_get_sset_count() / ibmveth_get_stats64()
use adapter->num_rx_queues while the TX loops use
dev->real_num_tx_queues. netdev->real_num_rx_queues is only synced to
adapter->num_rx_queues in ibmveth_open(), so on a never-opened interface
ethtool -l reports a count the stack does not have yet.

[ ... ]

> @@ -2150,6 +2355,7 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
>  	    skb_checksum_help(skb)) {
>  
>  		netdev_err(netdev, "tx: failed to checksum packet\n");
> +		adapter->tx_qstats[queue_num].dropped_packets++;
>  		goto out;
>  	}

[ ... ]

> @@ -2211,7 +2423,11 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
>  	dma_wmb();
>  
>  	if (ibmveth_send(adapter, desc.desc, mss)) {
> +		adapter->tx_qstats[queue_num].send_failures++;
> +		adapter->tx_qstats[queue_num].dropped_packets++;
>  	} else {
> +		adapter->tx_qstats[queue_num].packets++;
> +		adapter->tx_qstats[queue_num].bytes += skb->len;
>  	}

[Severity: Medium]

These empty if/else bodies in the pre-image show that the previous commit
in the series ("ibmveth: Enable multi-queue RX receive path") deleted the
hot-path netdev->stats accounting, and the replacement only arrives here.
ibmveth_poll() likewise increments no packet or byte counter at that
commit, and no ndo_get_stats64 exists yet.

Does that leave the tree at the parent commit reporting zero
rx_packets/rx_bytes/tx_packets/tx_bytes/tx_dropped through ip -s link,
where the pre-series baseline reported them? Would squashing the removal
into this patch, or deferring the removal until this replacement lands,
keep every commit in the series bisectable for counter-related issues?

[ ... ]

> @@ -2698,6 +2933,40 @@ static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
>  	return vlan_features_check(skb, features);
>  }
>  

[ ... ]

>  static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
> -				   int pools_ready)
> +				  int pools_ready)
>  {
>  	int i;

[Severity: Low]

This isn't a bug, but this whitespace-only reflow breaks the previously
correct open-parenthesis alignment of the second parameter (checkpatch:
"Alignment should match open parenthesis") in a function this patch does
not otherwise change. Could it be dropped?

> @@ -2724,6 +2994,19 @@ static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
>  		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
>  }
>  
> +static void ibmveth_probe_cleanup(struct ibmveth_adapter *adapter,
> +				  int pools_ready)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +
> +	cancel_work_sync(&adapter->work);
> +	ibmveth_put_pool_kobjs(adapter, pools_ready);
> +
> +	ibmveth_free_tx_qstats(adapter);
> +	ibmveth_free_rx_qstats(adapter);
> +	free_netdev(netdev);
> +}
> +

[Severity: High]

This isn't a problem introduced by this patch, since the old open-coded
error paths had the same omission, but the new helper is now the single
place four probe failure paths funnel through, so it looks like the
natural spot to fix it.

ibmveth_probe() stores the netdev in the VIO drvdata right after
alloc_etherdev_mqs():

	dev_set_drvdata(&dev->dev, netdev);

ibmveth_probe_cleanup() ends with free_netdev(netdev) but never clears it,
and ibmveth_remove() (the only caller of dev_set_drvdata(&dev->dev, NULL))
does not run when probe fails. So after any probe failure the vio_dev
keeps a pointer to freed memory.

On FW_FEATURE_CMO systems the stale pointer is consumed on the next bind
attempt, before the driver probe re-initializes it:

vio_bus_probe()
  vio_cmo_bus_probe()
    viodev->cmo.desired = IOMMU_PAGE_ALIGN(viodrv->get_desired_dma(viodev), tbl);
      ibmveth_get_desired_dma()

ibmveth_get_desired_dma() only checks for NULL:

	netdev = dev_get_drvdata(&vdev->dev);
	if (netdev == NULL)
		return ...;

and then dereferences netdev->mtu and adapter->num_rx_queues, using the
latter as the loop bound over adapter->rx_buff_pool[q][i]. Since that
bound is read from freed memory, can this read past the end of the freed
allocation as well? Would adding dev_set_drvdata(&dev->dev, NULL) to
ibmveth_probe_cleanup() close this?

>  static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  {
>  	int rc, i, mac_len, pools_ready = 0;
> @@ -2779,6 +3062,11 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  		netif_napi_add_weight(netdev, &adapter->napi[i],
>  				      ibmveth_poll, 16);
>  
> +	if (ibmveth_alloc_rx_qstats(adapter) ||
> +	    ibmveth_alloc_tx_qstats(adapter)) {
> +		ibmveth_probe_cleanup(adapter, 0);
> +		return -ENOMEM;
> +	}
>  
>  	netdev->irq = dev->irq;
>  	netdev->netdev_ops = &ibmveth_netdev_ops;

[ ... ]

> @@ -2913,6 +3198,9 @@ static void ibmveth_remove(struct vio_dev *dev)
>  
>  	unregister_netdev(netdev);
>  
> +	ibmveth_free_tx_qstats(adapter);
> +	ibmveth_free_rx_qstats(adapter);
> +
>  	free_netdev(netdev);
>  	dev_set_drvdata(&dev->dev, NULL);
>  }

[Severity: High]

This is a pre-existing issue, since the cancel_work_sync() placement in
ibmveth_remove() predates this patch, but the patch adds two new frees
into exactly that window.

ibmveth_remove() calls cancel_work_sync(&adapter->work) at the top,
before unregister_netdev(), so the device is still open when the cancel
returns and softirq context can re-arm the work:

ibmveth_poll()                     /* on ibmveth_enable_irq() failure */
  schedule_work(&adapter->work);

ibmveth_replenish_buffer_pool()    /* on an invalid free_map index */
  schedule_work(&adapter->work);

Timeline:

CPU A: cancel_work_sync() returns, queue empty
CPU B: ibmveth_poll() -> schedule_work(&adapter->work)
CPU A: unregister_netdev()
CPU A: ibmveth_free_tx_qstats() / ibmveth_free_rx_qstats()
CPU A: free_netdev(netdev)
CPU B: ibmveth_reset() runs container_of(w, struct ibmveth_adapter, work)

Can the worker then dereference the freed adapter and netdev in
rtnl_lock(); dev_close(adapter->netdev); dev_open(...)?

If it reaches dev_open() -> netif_tx_start_all_queues(), TX restarts with
tx_qstats == NULL, and the unguarded adapter->tx_qstats[queue_num]
dereferences added to ibmveth_start_xmit() by this patch would then be a
NULL dereference. The new "if (adapter->rx_qstats)" hot-path guards do not
help, since the adapter holding the pointer is itself inside the freed
netdev.

Would moving the cancel (or disable_work_sync()) to after
unregister_netdev() address this?

