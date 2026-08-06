Return-Path: <linuxppc-dev+bounces-25525-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DB3C5AC67
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 18:38:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGGGn4hM8z3cB1;
	Fri, 07 Aug 2026 04:37:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786041441;
	cv=none; b=AfEJ8/O3rtgh/nYzT8bIyNop/egmWhmlaS17fSJJqDGjLKgbVe/vO4/hpHAemhFZNu3xh8DxUuV0UJqC5XZzYv9VEYYU2rMhO2gDIIlGa0UBMZjXb2shcnhr89IK4bqZNmMtzPukajxFQf1V83DyTNMe+/8zvuGKazuRX97HOpHCyEW8qxREoMYn9HGp7P8YDNNs/mxK5kJ/sXJAkpfd+2c7b0ZXDSC/ddHgZxXOI1XncMtCXaAFBSys0PFNntA0pGeLbJHBHTSbwrEFGeaU7fvdovrjiWDbpDao8IghOVQJf1ubM1Sr9ebn/rKv/6z1sBXrjLWGQEmCvcUI+gKLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786041441; c=relaxed/relaxed;
	bh=BSWZWF94oKTcajsgnqJJF7ObSHoQhXyStGS/dJ6+/a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFMsPBDVYxJD0NSLakIWrUjKcS3lfnexm5HAE/4vKAEe0/ak/CPp4tb6CgySBOQqWNwMAH13hzpU6H7cZ+4e4hHRcy45SdviOeNNAWQGIax36IGKNfkoSk29LuYEmJdJyaoRT06K62MnkmqhJ8alPFfHx9AxvY6rwq+I4A0kyUcRDJ8CvEZWWSomirsBUdNbu3WUWbOfWyjSoDuL5/Magyv3zJZzbP5tFZaTzp6ATTYJ7X191CcQZoUY5KHcrPRClU+hjT+rh1tNg3NLS9he1APV7pzOlUVUzDsiKzJIY+bnGyJ253jtptpAwhigMTo9iObSoVcbCx2ltv8/FknncA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDhpTBlM; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDhpTBlM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGGGg30MKz3c6f
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 04:37:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 37D56601D9;
	Thu,  6 Aug 2026 18:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C681F00A3E;
	Thu,  6 Aug 2026 18:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041432;
	bh=BSWZWF94oKTcajsgnqJJF7ObSHoQhXyStGS/dJ6+/a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bDhpTBlMONlvvARpeH1m0SxV+2wPr3JTeU656GLwbZMU96vDMWuBphBrgV5fNIfAV
	 /U4Le50V3YK9zikcQxa0iXZkDBE+8dY0inzLFR/xa+MB5xOXagNPPenKQIJQHQzFpS
	 bs8dKsBSRK296rBkvxIT5AxrxFltnECrUIbvefK7C/U6MF6jxhBmpB4hi+AuQ3VrhA
	 QiAfl+WOLi2drZ1uLGmSuEhdR3sOkpfKtZz2NQmr4LOgKiTKGh9Zs/civbizuTXn3y
	 QBM06Bn6uEYVMUkjG+Pz23tcb+cpOufRt1EJ3OE0CaX4DNizDo52JatM2rkJTSeMah
	 CMRz1E5dEAcQQ==
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
Subject: Re: [PATCH net-next v4 12/14] ibmveth: Implement incremental MQ RX queue resize
Date: Thu,  6 Aug 2026 11:37:11 -0700
Message-ID: <20260806183711.3175827-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <7d183a47b3649a98da8505eccbea3b0be3ef6eec.1785457143.git.mmc@linux.ibm.com>
References: <7d183a47b3649a98da8505eccbea3b0be3ef6eec.1785457143.git.mmc@linux.ibm.com>
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
ibmveth: Implement incremental MQ RX queue resize

Adds per-queue alloc/register/irq-setup/free helpers plus
ibmveth_resize_rx_queues_incremental() so the live RX queue count can grow
or shrink without tearing down surviving queues, and wires
ibmveth_resize_rx_channels() into set_channels() when the interface is up.

A few questions on the new resize paths below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index db13747466025..b57c7df92853f 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1307,6 +1494,51 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>  	return 0;
>  }
>  
> +/**
> + * ibmveth_drain_rx_queue - Drain pending buffers from an RX queue
> + * @adapter: ibmveth adapter structure
> + * @queue_index: Queue index to drain
> + *
> + * Recycles all pending buffers back to the per-queue buffer pools.
> + * Must be called with NAPI disabled for this queue.
> + *
> + * Return: Number of buffers drained
> + */
> +static int
> +ibmveth_drain_rx_queue(struct ibmveth_adapter *adapter, int queue_index)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	int drained = 0;
> +	int limit = adapter->rx_queue[queue_index].num_slots;
> +	int rc;
> +
> +	netdev_dbg(netdev, "Draining RX queue %d (limit: %d slots)\n",
> +		   queue_index, limit);
> +
> +	while (drained < limit &&
> +	       ibmveth_rxq_pending_buffer(adapter, queue_index)) {
> +		/* Match poll-side order before harvesting completion state. */
> +		smp_rmb();
> +		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
> +		if (rc) {
> +			netdev_err(netdev,
> +				   "Failed to harvest buffer from queue %d during drain: %d\n",
> +				   queue_index, rc);
> +			break;
> +		}

[Severity: Low]
Can this error arm ever run?  ibmveth_rxq_harvest_buffer() normalizes
every failure to a 0 return:

	rc = ibmveth_remove_buffer_from_pool(adapter, cor, queue_index, reuse);
	if (unlikely(rc)) {
		if (rc == -EINVAL || rc == -EFAULT)
			goto advance;
		return rc;
	}

advance:
	ibmveth_rxq_advance(rxq);

	return 0;

and ibmveth_remove_buffer_from_pool() only ever returns 0, -EINVAL or
-EFAULT, so both non-zero values take the goto advance path.  The
netdev_err()/break looks like dead code.

> +		drained++;
> +	}
> +
> +	if (drained > 0)
> +		netdev_dbg(netdev, "Drained %d buffer(s) from RX queue %d\n",
> +			   drained, queue_index);
> +	else
> +		netdev_dbg(netdev, "No buffers to drain from RX queue %d\n",
> +			   queue_index);
> +
> +	return drained;
> +}
> +

[ ... ]

> @@ -1562,6 +1794,227 @@ ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
>  	return 0;
>  }
>  

[ ... ]

> +static int
> +ibmveth_resize_rx_queues_incremental(struct ibmveth_adapter *adapter,
> +				     int new_count, int rxq_entries)
> +{

[ ... ]

> +		for (i = old_count; i < new_count; i++) {
> +			rc = ibmveth_alloc_single_rx_queue(adapter, i,
> +							   rxq_entries);

[ ... ]

> +			/*
> +			 * Fully ready before PHYP delivery, matching open():
> +			 * publish -> replenish -> napi_enable -> enable_irq.
> +			 * That way ibmveth_interrupt() cannot run on an
> +			 * unpublished, empty, or NAPI-disabled queue.
> +			 */
> +			adapter->num_rx_queues = i + 1;

[Severity: Medium]
Should this publish store be ordered?  adapter->num_rx_queues is the only
gate that makes rx_queue[i].queue_addr/num_slots/toggle/replenish_lock,
rx_buff_pool[i][*] and buffer_list_addr[i] visible to lockless readers,
and it is written with a plain store here while the queues added in
earlier iterations are already running NAPI with PHYP unmasked.

The consumers also use plain loads from hardirq and softirq context:

ibmveth_interrupt():
	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
		return IRQ_NONE;

ibmveth_poll():
	if (WARN_ON(queue_index < 0 || queue_index >= adapter->num_rx_queues))
		return 0;

and ibmveth_update_rx_no_buffer() dereferences buffer_list_addr[i] for
every i below the count.  On powerpc, can a reader see the incremented
count while still observing stale contents of that slot (for example a
buffer_list_addr[i] left NULL by an earlier scale-down), or the converse
stale count for the queue whose interrupt was just unmasked?  Would
WRITE_ONCE()/READ_ONCE() plus a release barrier before the publish be
appropriate here?

> +			ibmveth_replenish_task(adapter, i);
> +			napi_enable(&adapter->napi[i]);
> +
> +			rc = ibmveth_enable_irq(adapter, i);

[Severity: Medium]
After the unmask, should the queue be re-checked for descriptors that
PHYP enqueued while delivery was masked?  Buffers are posted by
ibmveth_replenish_task() before ibmveth_enable_irq(), so PHYP can write
descriptors during the masked window.  ibmveth_poll() does exactly this
compensation:

	lpar_rc = ibmveth_enable_irq(adapter, queue_index);
	...
	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
	    napi_schedule(napi)) {
		ibmveth_disable_irq(adapter, queue_index);
		goto restart_poll;
	}

Without an equivalent pending check plus napi_schedule() here (and in the
scale-down rollback loop further down, which is even more exposed since
PHYP may have enqueued during the disable/drain window), can the new
queue sit with unharvested descriptors until unrelated traffic raises the
next interrupt?

> +			if (rc) {
> +				netdev_err(netdev,
> +					   "Failed to enable IRQ for queue %d: %d\n",
> +					   i, rc);
> +				adapter->num_rx_queues = i;
> +				napi_disable(&adapter->napi[i]);
> +				ibmveth_cleanup_single_rx_interrupt(adapter, i);
> +				ibmveth_deregister_single_rx_queue(adapter, i);
> +				ibmveth_free_single_rx_queue(adapter, i);
> +				goto cleanup_new_queues;
> +			}

[Severity: Medium]
Is rc an errno at this point?  ibmveth_enable_irq() -> ibmveth_toggle_irq()
returns the raw plpar_hcall_norets() result and only normalizes
H_PARAMETER to 0, so rc can be H_HARDWARE (-1), H_FUNCTION (-2),
H_PRIVILEGE (-3) or the positive H_BUSY (1).  That value is returned
unchanged through ibmveth_resize_rx_channels() -> ibmveth_set_channels()
into the ethtool ioctl, so userspace sees EPERM/ENOENT/ESRCH, or for a
positive code a positive ioctl return that ethtool reads as success even
though the resize failed and unwound.

The pre-existing ibmveth_setup_rx_interrupts() converts the same failure
with rc = -EIO; should this path do the same?

> +		}
> +
> +		rc = netif_set_real_num_rx_queues(netdev, new_count);
> +		if (rc) {
> +			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
> +				   new_count, rc);
> +			goto cleanup_new_queues;
> +		}
> +	} else {
> +		netdev_dbg(netdev, "Scale-down: removing queues %d-%d\n",
> +			   new_count, old_count - 1);
> +
> +		/*
> +		 * Mask PHYP delivery before napi_disable/drain. Otherwise
> +		 * ibmveth_interrupt returns IRQ_HANDLED without masking when
> +		 * NAPI is disabled, and the HV can storm during drain.
> +		 */
> +		for (i = new_count; i < old_count; i++) {
> +			ibmveth_disable_irq(adapter, i);
> +			synchronize_irq(adapter->queue_irq[i]);
> +		}
> +
> +		for (i = new_count; i < old_count; i++)
> +			napi_disable(&adapter->napi[i]);

[Severity: Medium]
Does the mask actually hold across the drain?  synchronize_irq() waits
for the hardirq handler, not for an ibmveth_poll() already in flight on
another CPU, and that poll re-arms delivery unconditionally:

CPU0 (resize)
	ibmveth_disable_irq(adapter, i);
	synchronize_irq(adapter->queue_irq[i]);   /* handler idle, returns */
	napi_disable(&adapter->napi[i]);          /* returns after
						     napi_complete_done() */

CPU1 (ibmveth_poll for queue i, scheduled before the mask)
	if (!napi_complete_done(napi, frames_processed))
		goto out;

	lpar_rc = ibmveth_enable_irq(adapter, queue_index);  /* unmasked */

so the drain can run with PHYP delivery re-enabled.  With NAPI disabled,
ibmveth_schedule_rx_queue() fails napi_schedule_prep() and returns
without masking, and once adapter->num_rx_queues is lowered each further
delivery hits WARN_ON(qindex >= adapter->num_rx_queues) in
ibmveth_interrupt() and returns IRQ_NONE.  Is the storm rule stated in
the comment still guaranteed?  The same ordering is repeated in the
cleanup_new_queues label below.

> +
> +		for (i = new_count; i < old_count; i++)
> +			ibmveth_drain_rx_queue(adapter, i);
> +
> +		synchronize_net();
> +
> +		rc = netif_set_real_num_rx_queues(netdev, new_count);
> +		if (rc) {
> +			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
> +				   new_count, rc);
> +			for (i = new_count; i < old_count; i++) {
> +				ibmveth_replenish_task(adapter, i);
> +				napi_enable(&adapter->napi[i]);
> +				ibmveth_enable_irq(adapter, i);
> +			}
> +			return rc;
> +		}

[Severity: Medium]
Should the ibmveth_enable_irq() return code be checked in this rollback
loop?  This is the only new call site that discards it.

If the H_VIOCTL enable fails for one of these queues, the queue stays in
the live set (adapter->num_rx_queues is still old_count) with NAPI
enabled and buffers posted, but with PHYP delivery masked, so that RX
queue is silently stalled until a close/open or another resize.

Elsewhere the driver treats this as actionable, e.g. ibmveth_poll():

	lpar_rc = ibmveth_enable_irq(adapter, queue_index);
	if (lpar_rc != H_SUCCESS) {
		...
		schedule_work(&adapter->work);
	}

> +
> +		adapter->num_rx_queues = new_count;

[Severity: Medium]
Do the interface statistics go backwards here?  ibmveth_get_stats64(),
ibmveth_get_ethtool_stats(), ibmveth_sum_rx_invalid_buffers() and
ibmveth_sum_rx_large_packets() all sum rx_qstats[0..num_rx_queues-1]:

	if (adapter->rx_qstats) {
		for (i = 0; i < adapter->num_rx_queues; i++) {
			stats->rx_packets += adapter->rx_qstats[i].packets;

so lowering the count drops the packets/bytes already accumulated by the
removed queues from the reported totals.

In the other direction, ibmveth_alloc_single_rx_queue() resets
rx_queue[queue_idx].index/num_slots/toggle and copies the pool geometry
but never clears adapter->rx_qstats[queue_idx], so re-adding a previously
removed index resurrects its old counters and the totals jump up.

Should the retired queues' counts be folded into an accumulator and the
slot cleared on (re-)allocation, so rtnl_link_stats64 stays monotonic?

> +
> +		for (i = new_count; i < old_count; i++) {
> +			ibmveth_cleanup_single_rx_interrupt(adapter, i);
> +			ibmveth_deregister_single_rx_queue(adapter, i);
> +			ibmveth_free_single_rx_queue(adapter, i);
> +		}
> +	}
> +
> +	netdev_info(netdev, "Successfully resized to %d RX queues (incremental)\n",
> +		    adapter->num_rx_queues);
> +
> +	if (firmware_has_feature(FW_FEATURE_CMO))
> +		vio_cmo_set_dev_desired(adapter->vdev,
> +					ibmveth_get_desired_dma(adapter->vdev));

[Severity: Medium]
Is the entitlement raised too late on CMO LPARs?  All the CMO-charged DMA
work for the new queues has already happened by the time this runs:
dma_map_single() of the buffer-list page and dma_alloc_coherent() of the
descriptor ring in ibmveth_alloc_single_rx_queue(), plus every RX skb
mapping done by ibmveth_replenish_task().  Those run while the device's
desired entitlement still reflects the old, smaller queue count, and
vio_dma_iommu_alloc_coherent() refuses the allocation when
vio_cmo_alloc() cannot cover it.

It is also skipped on every failure and rollback return, so a resize that
fails leaves the entitlement untouched.

The driver's own convention is the opposite order, in
ibmveth_change_mtu():

	vio_cmo_set_dev_desired(viodev, ibmveth_get_desired_dma(viodev));
	...
	ibmveth_open(...)

Note that simply moving the call is not enough, since
ibmveth_get_desired_dma() itself loops over adapter->num_rx_queues, so
the target count has to be accounted before the allocations and rolled
back on failure.

> +
> +	return 0;
> +
> +cleanup_new_queues:
> +	failed_queue = i;
> +	netdev_err(netdev,
> +		   "Scale-up failed at queue %d, cleaning up queues %d-%d\n",
> +		   failed_queue, old_count, failed_queue - 1);

[Severity: Low]
When the first newly added queue is the one that fails, failed_queue ==
old_count, so this prints an inverted empty range such as "cleaning up
queues 4-3" while the three loops below correctly iterate zero times.

> +	for (i = old_count; i < failed_queue; i++) {
> +		ibmveth_disable_irq(adapter, i);
> +		synchronize_irq(adapter->queue_irq[i]);
> +	}
> +
> +	for (i = old_count; i < failed_queue; i++)
> +		napi_disable(&adapter->napi[i]);
> +
> +	for (i = old_count; i < failed_queue; i++)
> +		ibmveth_drain_rx_queue(adapter, i);
> +
> +	synchronize_net();
> +
> +	for (i = old_count; i < failed_queue; i++) {
> +		ibmveth_cleanup_single_rx_interrupt(adapter, i);
> +		ibmveth_deregister_single_rx_queue(adapter, i);
> +		ibmveth_free_single_rx_queue(adapter, i);
> +	}
> +	adapter->num_rx_queues = old_count;

[Severity: High]
Can a concurrent NAPI poll dereference the pages this loop just freed?
adapter->num_rx_queues is restored only after the free loop, so for the
duration of that loop the indices [old_count, failed_queue) are freed but
still inside the published live range.

ibmveth_free_single_rx_queue() unmaps buffer_list_dma[i], frees the
coherent ring and then does:

	free_page((unsigned long)adapter->buffer_list_addr[queue_idx]);
	adapter->buffer_list_addr[queue_idx] = NULL;

Meanwhile every surviving queue's poll reaches
ibmveth_replenish_task() -> ibmveth_update_rx_no_buffer(), which walks the
published range with no NULL or liveness check:

	for (i = 0; i < adapter->num_rx_queues; i++) {
		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
		u64 drops = be64_to_cpup(p);

So for a 2->4 scale-up where queue 2 came up and queue 3 fails, a poll on
queue 0 or 1 reads buffer_list_addr[2] either as a just-freed page or as
NULL + 0xff8, in softirq context.  ibmveth_poll_controller() reaches the
same range from netpoll without rtnl, and additionally posts buffers into
pools that are being freed.

The guard in ibmveth_replenish_task():

	if (queue_index >= adapter->num_rx_queues) {

does not help while the count is still the higher value.  The inline
enable_irq failure handler above and the successful scale-down path both
lower adapter->num_rx_queues before freeing; should this label do the
same, i.e. set adapter->num_rx_queues = old_count before the free loop?

> +	netdev_warn(netdev, "Keeping %d queues after scale-up failure\n",
> +		    old_count);
> +	return rc;
> +}
> +

[ ... ]

> @@ -2217,12 +2670,62 @@ static void ibmveth_get_channels(struct net_device *netdev,
>  	channels->rx_count = adapter->num_rx_queues;
>  }
>  

[ ... ]

> +static int ibmveth_resize_rx_channels(struct ibmveth_adapter *adapter,
> +				      unsigned int goal_rx)
> +{

[ ... ]

> +	if (goal_rx == old_rx)
> +		return 0;
> +
> +	if (!(netdev->flags & IFF_UP)) {
> +		adapter->num_rx_queues = goal_rx;
> +		return 0;
> +	}
> +

[Severity: Low]
This isn't a bug in the final series, but at this commit the stash branch
is unreachable: the only caller, ibmveth_set_channels(), already returns
early on the same !IFF_UP condition before reaching
ibmveth_resize_rx_channels(), so ethtool -L <dev> rx N on a down
interface returns 0 while the requested count is discarded.  The next
patch in the series ("ibmveth: Wire ethtool set_channels to MQ RX queue
resize") replaces that early return and makes this branch live, so this
only shows up at this bisect point.

> +	rxq_entries = adapter->rx_queue[0].num_slots;
> +	rc = ibmveth_resize_rx_queues_incremental(adapter, goal_rx,
> +						  rxq_entries);
> +	if (rc)
> +		netdev_err(netdev, "Failed to resize RX queues: %d\n", rc);
> +	return rc;
> +}
> +
>  static int ibmveth_set_channels(struct net_device *netdev,
>  				struct ethtool_channels *channels)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>  	unsigned int old = netdev->real_num_tx_queues,
>  		     goal = channels->tx_count;
> +	unsigned int goal_rx = channels->rx_count;
>  	int rc, i;
>  
>  	/* If ndo_open has not been called yet then don't allocate, just set
> @@ -2231,6 +2734,13 @@ static int ibmveth_set_channels(struct net_device *netdev,
>  	if (!(netdev->flags & IFF_UP))
>  		return netif_set_real_num_tx_queues(netdev, goal);
>  
> +	/* Resize RX first while UP so ibmveth_resize_rx_channels() is used
> +	 * in this patch. !IFF_UP RX stash ordering lands next.
> +	 */
> +	rc = ibmveth_resize_rx_channels(adapter, goal_rx);
> +	if (rc)
> +		return rc;
> +

[Severity: Medium]
Should the RX side be unwound when the TX phase below fails?  The RX
resize is committed here first, and then ibmveth_allocate_tx_ltb() can
return -ENOMEM or netif_set_real_num_tx_queues() can fail, in which case
the function ends with return rc and no compensating
ibmveth_resize_rx_channels(adapter, old_rx).

ETHTOOL_SCHANNELS then reports failure while half of the requested
configuration is in effect: on scale-down the excess RX queues have
already been deregistered from PHYP and freed, on scale-up new queues are
registered with IRQs installed and DMA memory pinned, and ethtool -l
afterwards reports the new rx_count.

>  	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
>  	 * but we may need to alloc/free the ltb's.
>  	 */

[ ... ]

