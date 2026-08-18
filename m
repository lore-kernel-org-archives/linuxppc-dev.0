Return-Path: <linuxppc-dev+bounces-25928-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E16C5DF74
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 01:48:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPCJB4ytWz2yvR;
	Tue, 18 Aug 2026 11:47:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787017658;
	cv=none; b=O4s+guDTje/9BEFV8E3jxIxSqIa7vlSMuEst5T573O0/EGGb5a3LkLZTiSbMZU6f1fP+JTDvcT/JKYiHDMPX9EA5q5hyiQO9lF2Fz6A596xE7wcpLT33MA+tfBdBwm5chyhBQyriTflULj4KHHS//Nox6QygPsC9kAIYB9C4fgK8ww+XAYX1/e7+RmhnvRVvLJVTKChBsoJ3wLQMPg3oyoD1+obO7KbUfVHVP3RVtSSs3eFHFLlmBWAiWfCvej6wi4R0Kj1ke6tq+hTFD4ZHAcjFZzPKRBMdPBHZJCA2KY9YRYKZpeopjohQLZt9cS5OsrIucyLkn/LuXtD1VKRzqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787017658; c=relaxed/relaxed;
	bh=WNIBfmSj45T4HLQYA1oVYIfSWkIvQMFiV6Pw22bdv0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouL8l5NVipmbgqTKyNkJqX83yldT2gykZqKiLRmpAOPc3A8QJhkUvw4Csp/bCwkYJt+EASuS1FyViMNK/xVyC24XWXIYjym45oJSFApUwZEjA17g3b48dsE9BmZ18y7nSMmyDuC2/M4djqNuFr/oNu9fZEi4U9oFGmjYIJx78PkDUa5rwVdgOusU9/DYQ17KuwfdL9BDONfHM4CfvJ66Jr81BFsoGpmuhlHzq1gFlyqcemVZjWYMT2ZuDm2xPWb6skNYmpn1FKVOccFBh+nIAck4qenUUFEVzRnZ0EJry463XBa0rKaZQXhG9VCEQOxHexZkgBHzwIoneYosV0Z+Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hrn4iIvE; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hrn4iIvE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPCJ83zVFz2yv8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:47:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DA5D043D9B;
	Tue, 18 Aug 2026 01:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9511F00A3A;
	Tue, 18 Aug 2026 01:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017654;
	bh=WNIBfmSj45T4HLQYA1oVYIfSWkIvQMFiV6Pw22bdv0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hrn4iIvEEoNJ9mjDgOgQFDKdBPnVJuCgR3vGbPgprvbDm5CY7kUU/6lb+GEQrQMZp
	 JGUsXD0c5Uq0uPX+2HeN3GJtPoI2TNSsfFs7sdkPI7LEWf0Z/bg/PznQgG6p42GuMi
	 WGOV+T64eOnwbeyH1A10sX4xvzkMbY9pk6cdkrkU8xBKz+Sk3ZVx5GnFItoU8uvjuK
	 Ym/jiKtOp6qvoqAmgFP58TA8tGLrB/uVNG5A1yL10TZ6KfHkZcG+yl6Dbg1EjApEo3
	 yL4k5+YeURVHgdKaKIoiq7toXzjs+/e7bAELesJEddNcuAbFNZhpPdzgnhd6jc+QUO
	 PIOj5Ysc79jnw==
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
Subject: Re: [PATCH net-next v5 11/15] ibmveth: Add per-queue RX and TX statistics collection
Date: Mon, 17 Aug 2026 18:47:33 -0700
Message-ID: <20260818014733.3854367-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-12-mmc@linux.ibm.com>
References: <20260814073642.24630-12-mmc@linux.ibm.com>
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

This adds per-queue RX and TX counter arrays that are allocated at probe
and freed at remove, updates them from the poll/IRQ/xmit paths, and
exposes the values through ethtool -S plus a new ndo_get_stats64
implementation. It also adds the hcall_* counters to the ethtool string
table and reworks the probe error paths and ibmveth_remove() teardown
order.

A few questions below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 36f0926711e60..3202b657c9b8f 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -98,7 +98,17 @@ static struct ibmveth_stat ibmveth_stats[] = {
>  	{ "fw_enabled_ipv6_csum", IBMVETH_STAT_OFF(fw_ipv6_csum_support) },
>  	{ "tx_large_packets", IBMVETH_STAT_OFF(tx_large_packets) },
>  	{ "rx_large_packets", IBMVETH_STAT_OFF(rx_large_packets) },
> -	{ "fw_enabled_large_send", IBMVETH_STAT_OFF(fw_large_send_support) }
> +	{ "fw_enabled_large_send", IBMVETH_STAT_OFF(fw_large_send_support) },
> +	{ "hcall_reg_lan_queue", IBMVETH_STAT_OFF(hcall_stats.reg_lan_queue) },
> +	{ "hcall_reg_lan", IBMVETH_STAT_OFF(hcall_stats.reg_lan) },
> +	{ "hcall_add_bufs_queue",
> +	  IBMVETH_STAT_OFF(hcall_stats.add_bufs_queue) },
> +	{ "hcall_add_bufs", IBMVETH_STAT_OFF(hcall_stats.add_bufs) },
> +	{ "hcall_add_buf", IBMVETH_STAT_OFF(hcall_stats.add_buf) },
> +	{ "hcall_free_lan_queue",
> +	  IBMVETH_STAT_OFF(hcall_stats.free_lan_queue) },
> +	{ "hcall_free_lan", IBMVETH_STAT_OFF(hcall_stats.free_lan) },
> +	{ "hcall_send_lan", IBMVETH_STAT_OFF(hcall_stats.send_lan) },
>  };

[Severity: Low]
Can these hcall_* values lose increments once they become user visible?

The fields in adapter->hcall_stats are plain u64 bumped with an
unserialized read-modify-write. ibmveth_replenish_task() takes only the
queue-local lock:

	spin_lock_irqsave(&rxq->replenish_lock, flags);

so two NAPI instances replenishing different RX queues both reach

	adapter->hcall_stats.add_bufs_queue++;

with no shared serialization, and separate TX queues both reach

	adapter->hcall_stats.send_lan++;

in ibmveth_send(). Two CPUs can read N and both store N+1.

Would per-queue counters summed on read (the same approach used for the
new rx_qstats/tx_qstats), or atomic64_t, be preferable here?

[ ... ]

> @@ -1011,7 +1075,23 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
>  	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
>  	drops = be64_to_cpup(p);
>  
> -	adapter->rx_no_buffer = drops;
> +	/*
> +	 * PHYP's buffer-list page counter is absolute for that page. A new
> +	 * page (reopen / queue reuse after -L) starts near zero; fold the
> +	 * previous absolute into retired so adapter-level sums stay
> +	 * monotonic.
> +	 */
> +	if (adapter->rx_qstats) {
> +		u64 *slot = &adapter->rx_qstats[queue_index].no_buffer_drops;
> +
> +		if (drops < *slot)
> +			adapter->rx_no_buffer_retired += *slot;
> +		*slot = drops;
> +	} else {
> +		if (drops < adapter->rx_no_buffer)
> +			adapter->rx_no_buffer_retired += adapter->rx_no_buffer;
> +		adapter->rx_no_buffer = drops;
> +	}
>  }

[Severity: Low]
Does the no_buffer_drops slot lose the final PHYP value when a queue is
retired by a channel shrink?

This makes rx_qstats[i].no_buffer_drops a mirror of the page-absolute
counter, and folding into rx_no_buffer_retired only happens when a later
read observes a decrease. ibmveth_update_rx_no_buffer() has only two call
sites, the replenish path and ibmveth_close(), and it early-returns for

	queue_index >= ibmveth_get_num_rx_queues(adapter)

Once the incremental resize patch later in this series lands, scale-down
does:

	ibmveth_publish_num_rx_queues(adapter, new_count);
	...
	for (i = new_count; i < old_count; i++)
		ibmveth_destroy_subordinate_rx_queue(adapter, i);

which reaches ibmveth_free_single_rx_queue() and dma_unmap_single() plus
free_page() on buffer_list_addr[i]. The live count is already lowered, so
a late harvest is rejected by the guard above, and everything PHYP
recorded in that page since the last replenish read is dropped from both
the per-queue slot and the adapter sum.

Would harvesting the absolute before lowering the published queue count
and freeing the page fix this?

> @@ -2239,22 +2319,158 @@ static int ibmveth_set_features(struct net_device *dev,

[ ... ]

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
> +	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
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
Should the per-queue packet, byte and drop counters go through the
standard per-queue statistics interface instead of private ethtool
strings?

rx%d_packets, rx%d_bytes, tx%d_packets, tx%d_bytes and
tx%d_dropped_packets map directly onto existing fields:

include/net/netdev_queues.h
	struct netdev_stat_ops {
		void (*get_queue_stats_rx)(struct net_device *dev, int idx,
					   struct netdev_queue_stats_rx *stats);
		...

The driver adds only .ndo_get_stats64 (device-wide) and never sets
netdev->stat_ops, so the newly collected per-queue values are reachable
only through the private ethtool blob, which cannot be removed once
shipped. The genuinely driver-specific counters (interrupts, polls,
invalid_buffers, no_buffer_drops, send_failures, checksum_offload) look
fine in ethtool -S.

Could the packets/bytes/dropped set be exposed via netdev_stat_ops
qstats instead?

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
> +		       ibmveth_get_num_rx_queues(adapter) *
> +		       IBMVETH_NUM_RX_QSTATS +
> +		       dev->real_num_tx_queues * IBMVETH_NUM_TX_QSTATS +
> +		       IBMVETH_NUM_BUFF_POOLS * 3;
>  	default:
>  		return -EOPNOTSUPP;
>  	}

> @@ -2263,11 +2479,44 @@ static int ibmveth_get_sset_count(struct net_device *dev, int sset)
>  static void ibmveth_get_ethtool_stats(struct net_device *dev,
>  				      struct ethtool_stats *stats, u64 *data)
>  {

[ ... ]

> +	for (j = 0; j < IBMVETH_NUM_BUFF_POOLS; j++) {
> +		data[i++] = adapter->rx_buff_pool[0][j].size;
> +		data[i++] = adapter->rx_buff_pool[0][j].active;
> +		data[i++] = atomic_read(&adapter->rx_buff_pool[0][j].available);
> +	}
>  }

[Severity: Medium]
This is a pre-existing issue rather than something this patch creates for
the lifetime part below, but the commit message describes only per-queue
RX/TX statistics and the hcall_* strings, while the patch also carries two
other changes.

First, three new ethtool -S entries per buffer pool are added:

	ethtool_sprintf(&p, "pool%d_size", i);
	ethtool_sprintf(&p, "pool%d_active", i);
	ethtool_sprintf(&p, "pool%d_available", i);

and counted as IBMVETH_NUM_BUFF_POOLS * 3 in ibmveth_get_sset_count().
The values are read only from adapter->rx_buff_pool[0][j], but
rx_buff_pool is declared as

	struct ibmveth_buff_pool
		rx_buff_pool[IBMVETH_MAX_RX_QUEUES][IBMVETH_NUM_BUFF_POOLS];

so in multi-queue mode queues 1..N-1 are not represented and the string
names carry no queue index. pool size and active are also already
available through the per-pool sysfs attributes (veth_size_attr,
veth_num_attr, veth_active_attr). Should these strings be dropped, or at
least given a queue index and mentioned in the commit message?

Second, ibmveth_remove() reorders unregister_netdev() ahead of
cancel_work_sync(), and the new ibmveth_probe_cleanup() clears vio
drvdata before free_netdev(). The in-code comments describe both as
fixing existing problems (a worker running after free_netdev(), and CMO
get_desired_dma() seeing a freed netdev on rebind), neither of which the
commit message body mentions and neither of which has a Fixes: tag.
Could these be split into their own patches?

[ ... ]

> @@ -3107,6 +3410,7 @@ static const struct net_device_ops ibmveth_netdev_ops = {
>  	.ndo_validate_addr	= eth_validate_addr,
>  	.ndo_set_mac_address    = ibmveth_set_mac_addr,
>  	.ndo_features_check	= ibmveth_features_check,
> +	.ndo_get_stats64	= ibmveth_get_stats64,
>  #ifdef CONFIG_NET_POLL_CONTROLLER
>  	.ndo_poll_controller	= ibmveth_poll_controller,
>  #endif

> @@ -3121,6 +3425,23 @@ static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
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
> +	/* Probe failure never reaches ibmveth_remove(); clear before free so
> +	 * CMO get_desired_dma() cannot see a freed netdev on rebind.
> +	 */
> +	dev_set_drvdata(&adapter->vdev->dev, NULL);
> +	free_netdev(netdev);
> +}
> +

[ ... ]

> @@ -3332,12 +3651,20 @@ static void ibmveth_remove(struct vio_dev *dev)
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

[Severity: High]
With cancel_work_sync() now running after unregister_netdev(), can the
reset worker re-open an already unregistered netdev?

adapter->work is queued from several error paths, for example
ibmveth_replenish_task() on an invalid free_map entry or on MQ H_FUNCTION
after LPM, and from ibmveth_poll_skip_bad_correlator():

	schedule_work(&adapter->work);

The handler has no registration or running check:

drivers/net/ethernet/ibm/ibmveth.c:ibmveth_reset() {
	rtnl_lock();

	dev_close(adapter->netdev);
	dev_open(adapter->netdev, NULL);

	rtnl_unlock();
}

A worker already queued (or already blocked in rtnl_lock() while
unregister_netdev() holds rtnl) proceeds once unregistration finishes.
dev_close() is then a no-op, and the re-open is not rejected:

net/core/dev.c:netif_open() {
	if (dev->flags & IFF_UP)
		return 0;

	ret = __dev_open(dev, extack);
}

net/core/dev.c:__dev_open() {
	ASSERT_RTNL();
	dev_addr_check(dev);

	if (!netif_device_present(dev)) {
	...
	if (!ret && ops->ndo_open)
		ret = ops->ndo_open(dev);
}

IFF_UP was cleared by unregister and __LINK_STATE_PRESENT is never
cleared (the driver does not call netif_device_detach()), so
ibmveth_open() runs again on the unregistered device: it re-requests the
RX IRQs with dev_id = &adapter->napi[i], re-registers the logical LAN
with PHYP, and re-arms DMA into freshly allocated buffer lists.

cancel_work_sync() then returns and remove() continues into
ibmveth_free_tx_qstats() / ibmveth_free_rx_qstats() and free_netdev(),
so the installed IRQ handler and the hypervisor are left pointing at
freed memory. The next RX interrupt would execute

	adapter->rx_qstats[qindex].interrupts++;

in ibmveth_interrupt() against a freed adapter and a freed qstat array.

Would a netif_running() or reg_state check inside ibmveth_reset(), or a
"removing" flag set before unregister_netdev(), close this?

