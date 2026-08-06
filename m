Return-Path: <linuxppc-dev+bounces-25524-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D58C56205
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 18:38:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGGGn28Tlz3c9j;
	Fri, 07 Aug 2026 04:37:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786041441;
	cv=none; b=fcBBcLOdgIJlVt9rQHzQhYnkHXaBXRKfw0UpJH7uqW9GCXksJIX6gUSWoEpxEFE+siqQc+UmsVjIClsU6i9gWZINCaaP9D/v7myt/VHsTM/zBPjVCNAWg5lPdEWj45H2U55i0dPt2CYq3KCHS1gq4gDfbdQlnGTW+1HJG+K9R7kZZiNaMExF0aM/bX9JghXh5DQ664BngYAGA/VQw96H8/o8ryw5DvbcRcTfAUHFhUae58wedH312ya42y7VslqzuXgaKyZuXvECanMnxSqlNbnRkt4yLnUGs3tHqI2cSj88JFVK8XTwrsjFkM2m4Haf7IojYedpMEiRkyKqJq9XMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786041441; c=relaxed/relaxed;
	bh=tl8zOLlVUrD6nGviVR6NMBqgbtmvRldCVft+ATVU0ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cF/XMS/jwzun4oTp5gXtEy6tP9/W3sVii8NSj0ZN/3dJCgDo87kxhUj3bwE1RBjkZbYtz3xP9ysNUfnDkuR6hNJS+zNzGLhe/vUNbcsjobHXzHdsW+1/ucugJ2OHADKcUzuMMtpKFVWd2dh7Evjzxmvc0UFjAAr2AE5Eghi1zADq/ZU2DpG2VZ5umm5huWNLwa8sIkfTyBDHFoCqpseUk6bA613AcSbenQVqp8U7J29uNYQQItRHfCKfLEtj9JwgTPCqX2b5wq0sWLEa6xsiUuLFDu4OSa28MbcS+gNyyLr56EBCiwfiAWPYuZZ6LzZ/4v6yyst8Wz7U2UPDrJF9OQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEsQ+QVr; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEsQ+QVr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGGGb64skz3c3g
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 04:37:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AD4AD44029;
	Thu,  6 Aug 2026 18:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125A71F00AC4;
	Thu,  6 Aug 2026 18:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041429;
	bh=tl8zOLlVUrD6nGviVR6NMBqgbtmvRldCVft+ATVU0ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LEsQ+QVr3g8Y5XB8iEOLuV000oLXaPcz6re86fdOD/eZp2TjIQvj+i0fNfdZwh7Ge
	 FMLmKLEsJUr5pRpkq+A68dVHd3fmdIIyyIr6WP5ZenkDacLWJjrV5F5EtImGfxRfYz
	 I/db8piGCt+mTQpV2lDfDdQ8AW9kF4wZFPSYqUN8KniwfPOfuY8znZPvMGLHIY44SJ
	 cN9VMCkuiPAj2J3NIM05PdsCMmrpVLzQDgjjQh+S2tQ9Lq8/Ldofg4rxBez/zzFiOO
	 XrvBHqeqEvLowGqm8TBdvqOWLfnvagoMu6JRRMEl7IrN2GFtx9p4FsNE+WkyGzneMk
	 rs1kOt1Q0QbDA==
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
Subject: Re: [PATCH net-next v4 09/14] ibmveth: Enable multi-queue RX receive path
Date: Thu,  6 Aug 2026 11:37:08 -0700
Message-ID: <20260806183708.3175604-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <f49057799577b7c3c1444910b56a6662a610a20a.1785457143.git.mmc@linux.ibm.com>
References: <f49057799577b7c3c1444910b56a6662a610a20a.1785457143.git.mmc@linux.ibm.com>
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
ibmveth: Enable multi-queue RX receive path

This patch turns on the multi-queue RX path: probe latches multi_queue and
num_rx_queues from the H_ILLAN_ATTRIBUTES MQ bit, subordinate queues are
registered with H_REG_LOGICAL_LAN_QUEUE, and open replenishes every queue
before setup_rx_interrupts() unmasks PHYP. A few questions below on the
new ordering, the CMO entitlement accounting and the probe unwind.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index cb93659fc0576..4ad7ced3c6083 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -97,7 +97,17 @@ static struct ibmveth_stat ibmveth_stats[] = {
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
Should hcall_send_lan be exported through ethtool -S?  It is incremented
once per successfully transmitted packet on the ibmveth_send() success
path:

drivers/net/ethernet/ibm/ibmveth.c:ibmveth_send() {
	...
	adapter->hcall_stats.send_lan++;
	return 0;
}

That makes it the same value as the standard rtnl_link_stats64 tx_packets
counter reported by ndo_get_stats64 / ip -s link, and
Documentation/networking/statistics.rst asks that counters with a standard
uAPI not be duplicated as driver-private ethtool -S strings.  These
strings become uAPI once merged.

The commit message subject is "Enable multi-queue RX receive path" and
does not mention that eight new statistics strings are being added.  Could
the stats additions be split out or at least described?

> @@ -429,12 +439,64 @@ ibmveth_enable_irq(struct ibmveth_adapter *adapter, int queue_index)
>  	return ibmveth_toggle_irq(adapter, queue_index, true);
>  }
>  
> +/**
> + * ibmveth_dispose_subordinate_irq_mapping - Drop one subordinate virq mapping
> + * @adapter: ibmveth adapter structure
> + * @queue_idx: RX queue index (1..N)
> + *
> + * Subordinate queues get mappings from irq_create_mapping() during PHYP
> + * registration. Queue 0 uses netdev->irq from device tree and is left alone.
> + *
> + * Bound against IBMVETH_MAX_RX_QUEUES, not num_rx_queues: scale-down and
> + * scale-up fail paths dispose queues that are no longer in the published
> + * live set but still own a virq in queue_irq[]. The bulk helper still
> + * iterates only 1..num_rx_queues-1 for close/open-fail cleanup.

[Severity: Low]
This isn't a bug, but do the "scale-down and scale-up fail paths" exist at
this commit?  ibmveth_resize_rx_queues_incremental() and
ibmveth_setup_single_rx_interrupt() arrive in a later patch, and the only
caller here is the bulk helper bounded by num_rx_queues.

The same applies to the comment added above ibmveth_get_strings() in this
patch:

	/*
	 * Sum per-queue counters for rare ethtool reads. Do not write adapter
	 * globals on the hot path (ibmvnic-style); with qstats allocated for the
	 * adapter lifetime, these sums remain meaningful across ifdown/up.
	 */

ibmveth_get_strings() only memcpy()s string tables here, and no
rx_qstats/tx_qstats members exist in struct ibmveth_adapter until the
following patch.  Could both comments move to the patches that add the
code they describe, so the intermediate commits read correctly?

> +	for (i = 0; i < num; i++)
> +		napi_enable(&adapter->napi[i]);
> +
> +	if (adapter->multi_queue && num > 1) {
> +		for (i = 0; i < num; i++) {
> +			rc = ibmveth_enable_irq(adapter, i);
> +			if (rc) {
> +				netdev_err(netdev,
> +					   "Failed to enable IRQ for queue %d, rc=%d\n",
> +					   i, rc);
> +				while (--i >= 0)
> +					ibmveth_disable_irq(adapter, i);
> +				rc = -EIO;
> +				goto err_disable_napi;
> +			}
> +		}
> +	}
> +
>  	return 0;
>  
> +err_disable_napi:
> +	/* PHYP unmask was rolled back above; disable NAPI before free_irq */
> +	for (i = 0; i < num; i++)
> +		napi_disable(&adapter->napi[i]);
> +	for (i = 0; i < num; i++) {
> +		if (adapter->queue_irq[i])
> +			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
> +	}
> +	goto err_dispose_mappings;

[Severity: Low]
Can the rollback loop above be undone by an in-flight poll?  Queues 0..i-1
were already unmasked, so a poll may be running when
ibmveth_enable_irq() fails for queue i:

ibmveth_poll() {
	...
	if (!napi_complete_done(napi, frames_processed))
		goto out;
	...
	lpar_rc = ibmveth_enable_irq(adapter, queue_index);
}

There is no synchronize_irq() between the while (--i >= 0)
ibmveth_disable_irq() loop and napi_disable(), so a poll that completes
after the mask re-enables PHYP delivery.  napi_disable() waits for the
poll but does not undo that re-enable, and the following free_irq() plus
ibmveth_dispose_subordinate_irq_mappings() then leave the hypervisor
source enabled for a hwirq whose Linux mapping is gone.

The scale-down path added later does disable_irq() followed by
synchronize_irq() for exactly this reason.  Should this path do the same?

[ ... ]

> @@ -834,9 +914,15 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>   */
>  static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>  {
> -	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
> +	int i;
>  
> -	adapter->rx_no_buffer = be64_to_cpup(p);
> +	adapter->rx_no_buffer = 0;
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
> +		u64 drops = be64_to_cpup(p);
> +
> +		adapter->rx_no_buffer += drops;
> +	}
>  }

[Severity: High]
Is this cross-queue aggregation safe against the RX queue resize path?
The only lock held here is the caller's own per-queue lock:

ibmveth_replenish_task(adapter, queue_index) {
	spin_lock_irqsave(&rxq->replenish_lock, flags);
	...
	ibmveth_update_rx_no_buffer(adapter);
	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
}

That lock does not cover other queues' buffer_list_addr[] entries, nor
num_rx_queues.  The ethtool -L scale-down path added later in the series
publishes the new count and then frees the pages:

	adapter->num_rx_queues = new_count;

	for (i = new_count; i < old_count; i++) {
		...
		ibmveth_free_single_rx_queue(adapter, i);   /* free_page() + NULL */
	}

If a surviving queue's poll already loaded the older, larger
num_rx_queues, can this loop dereference NULL + 4096 - 8, or read a page
that was just freed, from softirq context?  A READ_ONCE() of the count
plus a NULL check, or serializing the aggregation against the resize
path, would make this explicit.

Separately, two concurrent polls on different queues both execute
adapter->rx_no_buffer = 0 followed by += drops on the same field.  Can
that lose increments and expose a transient 0 through
rx_no_buffer / ethtool -S?

> @@ -847,8 +933,12 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>  	unsigned long flags;
>  	int i;
>  
> -	if (queue_index >= adapter->num_rx_queues)
> +	if (queue_index >= adapter->num_rx_queues) {
> +		netdev_dbg(adapter->netdev,
> +			   "Skipping replenish for freed queue %d (num_queues=%d)\n",
> +			   queue_index, adapter->num_rx_queues);
>  		return;
> +	}
>  
>  	adapter->replenish_task_cycles++;

[Severity: Low]
With several RX queues now polling concurrently, do the adapter-wide plain
u64 counters need serialization?  replenish_task_cycles is incremented
before the per-queue lock is taken, and replenish_no_mem,
replenish_add_buff_success/failure and the new hcall_stats fields are
touched under different per-queue locks, so the lockset intersection for
these adapter-global fields is empty.  hcall_stats.send_lan is also
incremented from ibmveth_start_xmit() on up to 16 TX queues in parallel.
The visible effect is lost increments in the ethtool -S values.

[ ... ]

> @@ -1284,6 +1374,137 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
> +	lpar_rc = h_reg_logical_lan_queue(adapter->vdev->unit_address,
> +					  adapter->buffer_list_dma[queue_index],
> +					  rxq_desc.desc, &handle, &hwirq);
> +	adapter->hcall_stats.reg_lan_queue++;

[Severity: Low]
Should this hcall retry on a busy return?  Every other long-running hcall
in the driver loops:

	do {
		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));

including h_free_logical_lan_queue() in the IRQ-mapping failure path a few
lines below this call, and h_send_logical_lan() in ibmveth_send().  As
written, a transient H_BUSY / H_LONG_BUSY_ORDER_* here becomes -EIO from
ibmveth_register_single_rx_queue() and a failed ifup.

> +	/*
> +	 * H_FUNCTION means firmware rejected this subordinate register
> +	 * (MQ unsupported). That is a hard open failure: do not clear
> +	 * multi_queue or claim single-queue fallback. Keep a specific
> +	 * log, then the generic failure lines below (no early return).
> +	 */
> +	if (lpar_rc == H_FUNCTION)
> +		netdev_err(adapter->netdev,
> +			   "h_reg_logical_lan_queue H_FUNCTION for queue %d (firmware MQ unsupported)\n",
> +			   queue_index);

[Severity: High]
Can the adapter recover if firmware stops honouring the MQ register after
probe?  multi_queue and num_rx_queues are latched once in ibmveth_probe()
from the H_ILLAN_ATTRIBUTES bit and are never re-read or reduced, so a
H_FUNCTION here fails ibmveth_open() and every subsequent open the same
way.

The reset work item only closes and reopens, it never re-reads the
attributes:

ibmveth_reset() {
	rtnl_lock();
	dev_close(adapter->netdev);
	dev_open(adapter->netdev, NULL);
	rtnl_unlock();
}

ethtool -L ethX rx 1 while down does not restore RX either: multi_queue
stays 1, so rx_buffers_per_hcall remains IBMVETH_MAX_RX_QUEUE and
ibmveth_add_logical_lan_buffers() keeps calling
h_add_logical_lan_buffers_queue(), whose H_FUNCTION path has no fallback
when multi_queue is set.

The driver already assumes PHYP capabilities can disappear across LPM:

	/*
	 * Live Partition Migration may drop multi-
	 * buffer support. Fall back to single-buffer
	 * on the next replenish; ...
	 */

Would clearing multi_queue and falling back to one queue on H_FUNCTION be
preferable to leaving the interface permanently unable to open?

> +static int
> +ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
> +				 int queue_idx, u64 mac_address)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	union ibmveth_buf_desc rxq_desc;
> +	long lpar_rc;
> +
> +	(void)mac_address;

[Severity: Low]
This isn't a bug, but is the mac_address parameter worth keeping?
H_REG_LOGICAL_LAN_QUEUE has no MAC operand and
ibmveth_register_logical_lan_queue() has no MAC parameter, so callers
compute ether_addr_to_u64(netdev->dev_addr) only to feed a parameter that
is voided here.  The (void)x; suppression cast is also not needed under
the kernel's warning set.

[ ... ]

> @@ -1356,9 +1579,31 @@ ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
> +	for (i = 1; i < adapter->num_rx_queues; i++) {
> +		rc = ibmveth_register_single_rx_queue(adapter, i, mac_address);
> +		if (rc)
> +			goto err_unregister;
> +	}
> +
>  	netdev_dbg(netdev,
> -		   "registered 1 RX queue with hypervisor (single-queue mode)\n");
> +		   "registered %d RX queues with hypervisor (multi-queue mode)\n",
> +		   adapter->num_rx_queues);
> +
>  	return 0;
> +
> +err_unregister:
> +	ibmveth_dispose_subordinate_irq_mappings(adapter);
> +	ibmveth_free_all_queues(adapter);
> +	return rc;
>  }

> @@ -1396,12 +1641,29 @@ static int ibmveth_open(struct net_device *netdev)
> +	/*
> +	 * MQ: post buffers before setup_rx_interrupts() unmasks PHYP
> +	 * (avoids drops if traffic arrives during open; PHYP allows
> +	 * either order). Single-queue keeps the classic kick: setup
> +	 * (no unmask) then schedule_rx_queue() so the first poll
> +	 * replenishes and enables.
> +	 */
> +	if (adapter->multi_queue && adapter->num_rx_queues > 1) {
> +		for (i = 0; i < adapter->num_rx_queues; i++) {
> +			netdev_dbg(netdev,
> +				   "initial replenish cycle for queue %d\n", i);
> +			ibmveth_replenish_task(adapter, i);
> +		}
> +	}
> +
>  	rc = ibmveth_setup_rx_interrupts(adapter);

[Severity: Medium]
Is PHYP delivery for subordinate queues guaranteed to be masked in this
window?  Queue 0 is explicitly masked before registration:

ibmveth_register_rx_queues() {
	adapter->queue_irq[0] = netdev->irq;
	rc = ibmveth_disable_irq(adapter, 0);
	...
}

but queues 1..N get no equivalent H_VIOCTL/H_DISABLE_VIO_INTERRUPT after
H_REG_LOGICAL_LAN_QUEUE plus irq_create_mapping().  Buffers are now
posted for every queue here, before any handler exists, and
ibmveth_setup_rx_interrupts() was also reordered so request_irq() for all
queues completes before any napi_enable():

	for (i = 0; i < num; i++) {
		...
		rc = request_irq(adapter->queue_irq[i], ibmveth_interrupt, ...);
	}

	for (i = 0; i < num; i++)
		napi_enable(&adapter->napi[i]);

If an interrupt arrives in that window, ibmveth_schedule_rx_queue() finds
NAPI still disabled:

	if (napi_schedule_prep(napi)) {
		lpar_rc = ibmveth_disable_irq(adapter, qindex);
		WARN_ON(lpar_rc != H_SUCCESS);
		__napi_schedule(napi);
	}

so the handler returns IRQ_HANDLED without masking the hypervisor source
and without scheduling a poll.  That is the same storm window described in
ibmveth_cleanup_rx_interrupts() ("Mask PHYP before napi_disable so
ibmveth_interrupt cannot return IRQ_HANDLED without masking").  The
err_free_irqs path has the same gap: it frees handlers and disposes
subordinate mappings without masking already-registered subordinate
queues.

The later scale-up path uses register -> request_irq -> publish ->
replenish -> napi_enable -> enable_irq and documents why.  Would enabling
NAPI before request_irq (as the baseline did), or explicitly masking each
subordinate queue right after registration, close this window?

[ ... ]

> @@ -2373,18 +2632,25 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
>  	/* add size of mapped tx buffers */
>  	ret += IOMMU_PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE, tbl);
>  
> -	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> -		/* add the size of the active receive buffers */
> -		if (adapter->rx_buff_pool[0][i].active)
> -			ret +=
> -			    adapter->rx_buff_pool[0][i].size *
> -			    IOMMU_PAGE_ALIGN(adapter->rx_buff_pool[0][i].
> -					     buff_size, tbl);
> -		rxqentries += adapter->rx_buff_pool[0][i].size;
> -	}
> -	/* add the size of the receive queue entries */
> -	ret += IOMMU_PAGE_ALIGN(
> -		rxqentries * sizeof(struct ibmveth_rx_q_entry), tbl);
> +	for (q = 0; q < adapter->num_rx_queues; q++) {
> +		int rxqentries = 1;

[Severity: Medium]
Does the buffer-list term still need scaling here?  The unchanged line
above this loop counts it once:

	ret = IBMVETH_BUFF_LIST_SIZE + IBMVETH_FILT_LIST_SIZE;

while multi-queue allocates and dma_map_single()s a distinct 4096-byte
buffer-list page per queue, which ibmveth_cleanup_rx_resources() unmaps
per index.  That leaves the desired value short by (num_rx_queues - 1)
buffer-list pages.

Also, is anything updating the CMO entitlement for the new default queue
count?  The VIO core samples it before the driver's probe runs:

arch/powerpc/platforms/pseries/vio.c:vio_cmo_bus_probe() {
	viodev->cmo.desired =
		IOMMU_PAGE_ALIGN(viodrv->get_desired_dma(viodev), tbl);
}

with dev_get_drvdata() still NULL, so the single-queue sized
IBMVETH_IO_ENTITLEMENT_DEFAULT is used for an adapter that will open with
up to 8 RX queues, and neither ibmveth_probe() nor ibmveth_open() calls
vio_cmo_set_dev_desired().  On a CMO partition, can this make
dma_map_single()/dma_alloc_coherent() fail during open on adapters that
worked in single-queue mode?

> +
> +		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> +			/* add the size of the active receive buffers */
> +			struct ibmveth_buff_pool *bpool =
> +				&adapter->rx_buff_pool[q][i];

[Severity: Medium]
Is rx_buff_pool[q][i] populated for q >= 1 when this runs?  Pool metadata
for queues 1..N is only filled in by ibmveth_alloc_buffer_pools(), which
runs from ndo_open; ibmveth_probe() initializes only rx_buff_pool[0][i],
and the private area is zeroed, so before the first open these entries
have size = active = buff_size = 0.

ibmveth_change_mtu() pushes the result straight into firmware accounting:

	vio_cmo_set_dev_desired(viodev, ibmveth_get_desired_dma(viodev));

Can an MTU change while the interface is down therefore lower the
entitlement to roughly the single-queue value, right before an open that
allocates buffers for up to 8 queues?

> @@ -2449,9 +2715,18 @@ static const struct net_device_ops ibmveth_netdev_ops = {
>  #endif
>  };
>  
> +static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
> +				   int pools_ready)
> +{
> +	int i;
> +
> +	for (i = 0; i < pools_ready; i++)
> +		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
> +}
> +

[ ... ]

> @@ -2531,16 +2810,27 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  		netdev->features |= NETIF_F_FRAGLIST;
>  	}
>  
> -	/* Initialize queue count - always 1 for now */
> -	adapter->multi_queue = 0;
> -	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
> +	if (ret == H_SUCCESS &&
> +	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT)) {
> +		adapter->multi_queue = 1;
> +		adapter->num_rx_queues = min(num_online_cpus(),
> +					     IBMVETH_DEFAULT_QUEUES);
> +		netdev_dbg(netdev, "RX multi queue mode enabled: %d queues\n",
> +			   adapter->num_rx_queues);
> +	} else {
> +		adapter->multi_queue = 0;
> +		adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
> +	}

[Severity: Medium]
Now that num_rx_queues can be greater than one here, does
ibmveth_resume() need updating too?  It still kicks queue 0 only:

ibmveth_resume() {
	...
	ibmveth_schedule_rx_queue(adapter, 0);
	return 0;
}

The kick exists because the poll routine is what replenishes buffers and
re-arms the PHYP interrupt via napi_complete_done() ->
ibmveth_enable_irq().  After a suspend/resume or partition migration,
queues 1..N-1 would then have no buffers posted and no interrupt
re-armed until an ifdown/ifup.

> @@ -2558,15 +2848,24 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  
>  	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>  		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
> -		int error;
>  
>  		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
>  					 pool_count[i], pool_size[i],
>  					 pool_active[i]);
> -		error = kobject_init_and_add(kobj, &ktype_veth_pool,
> -					     &dev->dev.kobj, "pool%d", i);
> -		if (!error)
> -			kobject_uevent(kobj, KOBJ_ADD);
> +		rc = kobject_init_and_add(kobj, &ktype_veth_pool,
> +					  &dev->dev.kobj, "pool%d", i);
> +		if (rc) {
> +			dev_err(&dev->dev,
> +				"failed to create pool%d kobject: %d\n", i, rc);
> +			/* init_and_add takes a ref even on failure */
> +			kobject_put(kobj);
> +			ibmveth_put_pool_kobjs(adapter, pools_ready);
> +			free_netdev(netdev);
> +			return rc;
> +		}
> +
> +		pools_ready++;
> +		kobject_uevent(kobj, KOBJ_ADD);
>  	}

[Severity: Medium]
Is it safe to free_netdev() immediately after ibmveth_put_pool_kobjs()?
The kobjects are embedded in netdev_priv(netdev), and ktype_veth_pool has
no release callback:

static struct kobj_type ktype_veth_pool = {
	.release        = NULL,
	...
};

With CONFIG_DEBUG_KOBJECT_RELEASE=y the final put defers cleanup using a
work item stored inside the kobject itself:

lib/kobject.c:kobject_release() {
#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
	unsigned long delay = HZ + HZ * get_random_u32_below(4);
	...
	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
	schedule_delayed_work(&kobj->release, delay);
#else
	kobject_cleanup(kobj);
#endif
}

free_netdev() then releases that memory with no window, so
kobject_delayed_cleanup() would read kobj->state_in_sysfs, kobj->parent
and kobj->name from freed storage.  The same shape applies to the two
other new put_pool_kobjs() call sites below.

> @@ -2574,6 +2873,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  	if (rc) {
>  		netdev_dbg(netdev, "failed to set number of tx queues rc=%d\n",
>  			   rc);
> +		ibmveth_put_pool_kobjs(adapter, pools_ready);
>  		free_netdev(netdev);
>  		return rc;
>  	}
> @@ -2590,6 +2890,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  
>  	if (rc) {
>  		netdev_dbg(netdev, "failed to register netdev rc=%d\n", rc);
> +		ibmveth_put_pool_kobjs(adapter, pools_ready);
>  		free_netdev(netdev);
>  		return rc;
>  	}

[ ... ]

