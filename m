Return-Path: <linuxppc-dev+bounces-26512-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79090C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 23:40:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbbgX73jhz2yvT;
	Fri, 04 Sep 2026 09:40:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788459049;
	cv=none; b=DRAUSzpaE6bPw6yvKCM00Wf+Y0451gWnmBaUTEgIFkZK3xIjWBIloGLWJ7vtDHARmdxyU0Hpe1T8hHuSXyKZ1nZLLrXvYpP7lRiFQglWwNvopt6VJ6WLNSxl0RD4QnOpJcB6VZTlMQ7BowmrQUAu06ZZOhQGYB08mArkEYSIVfwozAnIcYZ3b2lOaiSvjWeP6hcucjK+SOKpFboscNX9GsZN5ngwtOWiPxfxQjV65Q1yFZbTXXam56wlv8W/HSBdCbAFozYG3Pv2eT8K95Uoy521sdRuy+t8HeaiWPB+BtIG97uxBSn2GB1e2ExKl+y5yzQ1VJAWl30skUv0pXLb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788459049; c=relaxed/relaxed;
	bh=U/ZPw3n7HcBa6XzW7HDi+50RfdQmY0+P3G5stN3Jnng=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KHWZxcoQ50lDOwlLCBPOEFk5+/y09VSRorM8/7EFres3Lv9zUmWsvKhqf8VzkqQ8MP+vg7lH/nKJLFVu4THwy9HgnyNNxXpWaAe1bgMg2LA9k/v5TV0+ysRYhx1tLsBJGVlEAMsBkGthEzJBFB7ALbC8l05XQRGkIhCy5g/f/5hSC5FsPjbevd/o4BnQUeSCBWtIq4xzZNhJIC/Sws0n7v3DAAE/SqllkeNg4LGqdJgSku0iv6C5xP9iioXbvbcfgddQTP6tW9h0eB13NpEdo4TLF1cD85L9Q0P4pz56UxpXTzismXHGabVA1GWc7mfzxdgMzFXx166ew5fEpGRDVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EpfUvNuW; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EpfUvNuW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbSMD0z8pz2y2R
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 04:10:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D24543CC6;
	Thu,  3 Sep 2026 18:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A791F00A3E;
	Thu,  3 Sep 2026 18:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459046;
	bh=U/ZPw3n7HcBa6XzW7HDi+50RfdQmY0+P3G5stN3Jnng=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EpfUvNuWp8+hSbmRRxx3hrTDs3Eh67Tff3D2rCqwAwgJKCu9J5WfkbyPJ2ho+PwWP
	 e0vYyrlpIcAN7s5V5mjuPu4AIaxsSvDkzxhSwwXl31U2PtZYI2YtyTeqdJdM6Xp0nL
	 Rpebc5Ak4MMZT83nWCMUnf+pAO0nG+GspW8wUGUe0nyZAJmLSaMxwS1i4/UxplGK0S
	 LHjdYI30e0qKjNs8Bk6Vc9yeWWAVRCEYNzZ/di5kpa58upBxWe3X5l/mvPv3pVT26R
	 1Ek7ajphx/I0taUYjvx/q5CCAyQRuqoBbYZ8+qePgD8llyUSIhctKZsR5v0EB/A7TZ
	 aswhFP0iHIEQA==
Subject:
 Re: [net-next,v6,14/15] ibmveth: Implement incremental MQ RX queue resize
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Thu, 03 Sep 2026 18:10:45 +0000
Message-ID: <178845904516.3394541.1465539152870824625@kernel.org>
In-Reply-To:
 <78b7ee90a73d9849e2bf119d6c5f576e29b20159.1788102125.git.mmc@linux.ibm.com>
References:
 <78b7ee90a73d9849e2bf119d6c5f576e29b20159.1788102125.git.mmc@linux.ibm.com>
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

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 5 · Low: 4

- [Medium] On scale-up, ibmveth_resize_rx_queues_incremental() publishes,
  replenishes, NAPI-enables, unmasks PHYP and restarts each new queue…
- [Medium] The new scale-up call site of
  ibmveth_register_single_rx_queue() in…
- [Medium] ibmveth_deregister_single_rx_queue() ignores a failing
  H_FREE_LOGICAL_LAN_QUEUE: the retry loop covers only…
- [Medium] The scale-down and cleanup_new_queues quiesce sequences assume
  napi_disable() plus a second ibmveth_disable_irq() + synchronize_irq()…
- [Medium] RX queue teardown proceeds without confirming that PHYP
  interrupt delivery is actually masked.
- [Low] ibmveth_set_channels() commits the RX resize before any TX work
  and, in this patch, has no RX rollback if the TX side then fails, so a…
- [Low] When the interface is not opened, ibmveth_resize_rx_channels()
  validates the requested RX count and returns 0 without publishing it,…
- [Low] The advertised ethtool channel range and the set path disagree
  once adapter->mq_fallback is latched: ibmveth_get_channels() reports…
- [Low] ibmveth_drain_rx_queue()'s kernel-doc says it "Recycles all
  pending buffers back to the per-queue buffer pools" and "Return:…

--

ibmveth: Implement incremental MQ RX queue resize

This adds ibmveth_resize_rx_queues_incremental() so the live RX channel
count can change without a full device tear-down, plus
ibmveth_resize_rx_channels() as the entry point set_channels() uses. CMO
entitlement math is factored into ibmveth_desired_dma_for_rxqs() so a
prospective queue count can be sized before the driver commits to it.

A few questions about the new resize paths below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 954846c9ec7b3..5aef8a1f2c23d 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1613,6 +1808,56 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
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
> +			/* -EINVAL/-EFAULT already advanced past the slot. */
> +			if (rc == -EINVAL || rc == -EFAULT) {
> +				drained++;
> +				continue;
> +			}

[Severity: Low]

This isn't a bug, but does the documented return value of
ibmveth_drain_rx_queue() match what is counted here?

The kernel-doc says "Recycles all pending buffers back to the per-queue
buffer pools" and "Return: Number of buffers drained", yet this branch
bumps drained for entries where nothing was recycled.
ibmveth_rxq_harvest_buffer() only advances the ring for -EINVAL/-EFAULT:

	if (unlikely(rc)) {
		/* Skip a corrupt slot without claiming pool ownership. */
		if (rc == -EINVAL || rc == -EFAULT)
			ibmveth_rxq_advance(rxq);
		return rc;
	}

So the value returned is the number of ring slots consumed, not buffers
recycled. Would wording the kernel-doc as "slots processed" be more
accurate, given the value only feeds netdev_dbg()?

> +			netdev_err(netdev,
> +				   "Failed to harvest buffer from queue %d during drain: %d\n",
> +				   queue_index, rc);
> +			break;
> +		}
> +		drained++;
> +	}

[ ... ]

> @@ -1881,6 +2126,378 @@ ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
>  	return 0;
>  }
>  
> +/**
> + * ibmveth_deregister_single_rx_queue - Deregister one subordinate RX queue
> + * @adapter: ibmveth adapter structure
> + * @queue_idx: Queue index to deregister (1..N)
> + *
> + * Deregisters a single queue via H_FREE_LOGICAL_LAN_QUEUE. Linux IRQ handler
> + * teardown and subordinate virq mapping disposal are owned by interrupt
> + * cleanup helpers; queue 0 is freed only through ibmveth_free_all_queues()
> + * (H_FREE_LOGICAL_LAN).
> + */
> +static void
> +ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
> +				   int queue_idx)
> +{
> +	unsigned long lpar_rc;
> +	unsigned long ua = adapter->vdev->unit_address;
> +	unsigned long qh = adapter->queue_handle[queue_idx];
> +
> +	if (!qh)
> +		return;
> +
> +	do {
> +		lpar_rc = h_free_logical_lan_queue(ua, qh);
> +	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> +
> +	if (lpar_rc != H_SUCCESS) {
> +		netdev_err(adapter->netdev,
> +			   "h_free_logical_lan_queue failed for queue %d: rc=0x%lx\n",
> +			   queue_idx, lpar_rc);
> +	}
> +
> +	adapter->queue_handle[queue_idx] = 0;

[Severity: Medium]

Can a failing H_FREE_LOGICAL_LAN_QUEUE here lead to PHYP writing into
memory that has already been released?

The retry loop only covers H_BUSY/H_LONG_BUSY. Any other status is
logged, queue_handle[queue_idx] is cleared anyway, and the function
returns void, so no caller can observe or retry it.
ibmveth_destroy_subordinate_rx_queue() then continues unconditionally:

	ibmveth_deregister_single_rx_queue(adapter, queue_idx);
	ibmveth_cleanup_single_rx_interrupt(adapter, queue_idx);
	ibmveth_free_single_rx_queue(adapter, queue_idx);

ibmveth_free_single_rx_queue() dma_unmap_single()s the buffer-list page,
dma_free_coherent()s the RX ring and releases every RX skb of that queue,
all on a live adapter, while ibmveth_resize_rx_queues_incremental()
reports success to ethtool.

The kernel-doc for ibmveth_destroy_subordinate_rx_queue() states the
ordering rationale as "Deregister with PHYP before unmapping buffer pools
so hypervisor buffer ownership is released while queue metadata is still
valid", which relies on the hcall having succeeded.

The driver already treats this class of hcall failure as unrecoverable
elsewhere, for example the scale-down rollback and ibmveth_poll() both do
schedule_work(&adapter->work). Should this helper return the status so
the caller can keep the queue and schedule a reset instead of freeing?

> +
> +	netdev_dbg(adapter->netdev, "Deregistered queue %d\n", queue_idx);
> +}
> +
> +/**
> + * ibmveth_destroy_subordinate_rx_queue - Tear down one subordinate RX queue
> + * @adapter: ibmveth adapter structure
> + * @queue_idx: Queue index to destroy (1..N)
> + *
> + * Deregister with PHYP before unmapping buffer pools so hypervisor buffer
> + * ownership is released while queue metadata is still valid.
> + */
> +static void
> +ibmveth_destroy_subordinate_rx_queue(struct ibmveth_adapter *adapter,
> +				     int queue_idx)
> +{
> +	ibmveth_deregister_single_rx_queue(adapter, queue_idx);
> +	ibmveth_cleanup_single_rx_interrupt(adapter, queue_idx);
> +	ibmveth_free_single_rx_queue(adapter, queue_idx);
> +}

[ ... ]

> +static int
> +ibmveth_resize_rx_queues_incremental(struct ibmveth_adapter *adapter,
> +				     int new_count, int rxq_entries)
> +{

[ ... ]

> +		for (i = old_count; i < new_count; i++) {
> +			rc = ibmveth_alloc_single_rx_queue(adapter, i,
> +							   rxq_entries);
> +			if (rc) {
> +				netdev_err(netdev, "Failed to allocate queue %d: %d\n",
> +					   i, rc);
> +				goto cleanup_new_queues;
> +			}
> +
> +			rc = ibmveth_register_single_rx_queue(adapter, i);
> +			if (rc) {
> +				netdev_err(netdev, "Failed to register queue %d: %d\n",
> +					   i, rc);
> +				ibmveth_free_single_rx_queue(adapter, i);
> +				goto cleanup_new_queues;
> +			}

[Severity: Medium]

Should this call site latch adapter->mq_fallback when
ibmveth_register_single_rx_queue() returns -EOPNOTSUPP?

The helper maps a firmware H_FUNCTION to -EOPNOTSUPP, and the other
caller, ibmveth_register_rx_queues(), does:

	/* Firmware MQ gone: fall back to SQ on next open. */
	if (rc == -EOPNOTSUPP)
		adapter->mq_fallback = true;
	goto err_unregister;

ibmveth_register_logical_lan_queue() documents the same obligation:
"Caller fails this open and latches mq_fallback so the next open applies
SQ".

Here the errno is only logged and propagated, so after a firmware-refused
scale-up the driver still believes MQ is available: get_channels() keeps
advertising growth, ibmveth_resize_rx_channels() keeps accepting rx > 1,
and the next ndo_open() re-attempts subordinate registration, fails the
whole open and only then sets the flag. Does that turn into an avoidable
failed "ip link set up" before the device comes back single-queue?

> +
> +			rc = ibmveth_setup_single_rx_interrupt(adapter, i);
> +			if (rc) {
> +				netdev_err(netdev,
> +					   "Failed to setup IRQ for queue %d: %d\n",
> +					   i, rc);
> +				/* request_irq failed: mapped but no handler */
> +				ibmveth_dispose_subordinate_irq_mapping(adapter,
> +									i);
> +				ibmveth_deregister_single_rx_queue(adapter, i);
> +				ibmveth_free_single_rx_queue(adapter, i);
> +				goto cleanup_new_queues;
> +			}
> +
> +			/*
> +			 * Fully ready before PHYP delivery, matching open():
> +			 * publish -> replenish -> napi_enable -> enable_irq.
> +			 * That way ibmveth_interrupt() cannot run on an
> +			 * unpublished, empty, or NAPI-disabled queue.
> +			 */
> +			ibmveth_publish_num_rx_queues(adapter, i + 1);
> +			ibmveth_replenish_task(adapter, i);
> +			napi_enable(&adapter->napi[i]);
> +
> +			rc = ibmveth_enable_irq(adapter, i);
> +			if (rc) {
> +				netdev_err(netdev,
> +					   "Failed to enable IRQ for queue %d: %d\n",
> +					   i, rc);
> +				/*
> +				 * Published, replenished, and NAPI-enabled,
> +				 * but PHYP never unmasked. Match scale-down /
> +				 * shared cleanup: drain posted buffers, then
> +				 * deregister before unmap via
> +				 * destroy_subordinate.

[Severity: Medium]

Is the comment's "but PHYP never unmasked" guaranteed on this path?

ibmveth_toggle_irq() documents the enable side as ambiguous:

	/*
	 * H_PARAMETER is ambiguous (already in requested state vs bad
	 * args). Fold only on disable as an idempotent mask. On enable
	 * keep it an error so a stuck-masked queue stays visible to
	 * poll/resize recovery.
	 */

So an enable returning -EIO can also mean the interrupt was already
enabled. The queue has been replenished and NAPI-enabled at this point,
so PHYP can deliver, yet this branch goes straight to napi_disable(),
publish-down, drain and destroy with no ibmveth_disable_irq() +
synchronize_irq() for queue i.

The scale-down and cleanup_new_queues paths do issue the mask, but
discard its -EIO result and drain/destroy regardless, and
synchronize_irq() only waits for handlers already running rather than
masking the PHYP source. With the index at or above the published count
ibmveth_interrupt() also just returns IRQ_NONE without masking:

	if (qindex < 0 || qindex >= ibmveth_get_num_rx_queues(adapter))
		return IRQ_NONE;

Should a failed mask be treated the way ibmveth_poll() and the
scale-down rollback treat a failed enable, with
schedule_work(&adapter->work) instead of proceeding?

> +				 *
> +				 * napi_disable() must come BEFORE the count
> +				 * is lowered, matching scale-down and
> +				 * cleanup_new_queues. Lowering it first does
> +				 * not hide queue i from netpoll: after
> +				 * ndo_poll_controller, netpoll_poll_dev()
> +				 * calls poll_napi(), which walks dev->napi_list
> +				 * unbounded by the queue count and skips a NAPI
> +				 * only once NAPI_STATE_NPSVC is set. Queue i is
> +				 * enabled here, so ibmveth_poll() would run and
> +				 * trip its queue_index >= num_rx_queues
> +				 * WARN_ON. napi_disable() sets NPSVC, so
> +				 * poll_napi() skips the queue instead.
> +				 */
> +				napi_disable(&adapter->napi[i]);
> +				ibmveth_publish_num_rx_queues(adapter, i);
> +				ibmveth_drain_rx_queue(adapter, i);
> +				synchronize_net();
> +				ibmveth_destroy_subordinate_rx_queue(adapter,
> +								     i);
> +				/* enable_irq returns errno; keep -EIO. */
> +				rc = -EIO;
> +				goto cleanup_new_queues;
> +			}
> +			ibmveth_restart_rx_queue(adapter, i);
> +		}
> +
> +		rc = netif_set_real_num_rx_queues(netdev, new_count);

[Severity: Medium]

Can this ordering be inverted so the WARN window does not exist at all?

Every new queue is published, replenished, NAPI-enabled, unmasked at PHYP
and restarted inside the loop above, and real_num_rx_queues is only
widened after the loop finishes. A frame arriving on a new queue in that
window is tagged by ibmveth_poll_deliver_frame():

	skb_record_rx_queue(skb, queue_index);
	napi_gro_receive(napi, skb);

and net/core/dev.c get_rps_cpu() then does:

	if (unlikely(index >= dev->real_num_rx_queues)) {
		WARN_ONCE(dev->real_num_rx_queues > 1,
			  "%s received packet on queue %u, but number "
			  "of RX queues is %u\n", ...);
		goto done;
	}

netif_get_rxqueue() has the same WARN_ONCE for the generic XDP path, so a
device that already had more than one RX queue splats when RPS/RFS or
generic XDP is configured, and panic_on_warn systems go down.

netif_set_real_num_rx_queues() only needs dev->num_rx_queues, which is
sized at probe, so could it be called before PHYP delivery is unmasked
and narrowed again on the cleanup path? The commit message describes the
splat as expected:

    "RPS then skips steering and takes the default path, tripping the
    WARN_ONCE in get_rps_cpu() if the device already had more than one
    queue. Transient, and delivery is unaffected."

Is leaving a userspace-reachable WARN in place preferable to widening the
count first?

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
> +		 * Mask PHYP before napi_disable so the handler cannot miss
> +		 * a mask while NAPI is already dead. An in-flight poll can
> +		 * still re-arm PHYP while napi_disable() waits, so remask
> +		 * and sync again after NAPI is stopped. Then drain, harvest
> +		 * final no_buffer stats, publish the surviving count, and
> +		 * synchronize_net() before destroy so netpoll cannot walk
> +		 * dying queues (handler may still be registered until destroy).
> +		 */
> +		for (i = new_count; i < old_count; i++) {
> +			if (!adapter->queue_irq[i])
> +				continue;
> +			ibmveth_disable_irq(adapter, i);
> +			synchronize_irq(adapter->queue_irq[i]);
> +		}
> +
> +		for (i = new_count; i < old_count; i++)
> +			napi_disable(&adapter->napi[i]);
> +
> +		for (i = new_count; i < old_count; i++) {
> +			if (!adapter->queue_irq[i])
> +				continue;
> +			ibmveth_disable_irq(adapter, i);
> +			synchronize_irq(adapter->queue_irq[i]);
> +		}

[Severity: Medium]

Does this second mask pass really close the re-arm window, or can the
poll tail unmask PHYP after it?

napi_disable_locked() in net/core/dev.c returns once SCHED/NPSVC are
observed clear and clears the DISABLE bit before returning:

	clear_bit(NAPI_STATE_DISABLE, &n->state);

Meanwhile ibmveth_poll() is still running its tail:

	if (!napi_complete_done(napi, frames_processed))
		goto out;
	...
	if (ibmveth_poll_stopping(netdev, napi))
		goto out;

	rc = ibmveth_enable_irq(adapter, queue_index);

napi_complete_done() is what let napi_disable() finish, and
ibmveth_poll_stopping() is !netif_running(netdev) ||
napi_disable_pending(napi). netif_running() is still true during a live
ethtool resize and DISABLE has already been cleared, so the guard passes
and the enable hcall can land after the mask + synchronize_irq() above.
synchronize_irq() waits for hard-IRQ handlers, not for a softirq poll
function.

The retiring queue would then stay unmasked at PHYP for the whole drain,
stat-harvest, publish, synchronize_net() and
netif_set_real_num_rx_queues() window: before the publish
ibmveth_schedule_rx_queue() fails napi_schedule_prep() and deliberately
does not mask, and after the publish ibmveth_interrupt() returns
IRQ_NONE, so the interrupts are swallowed without remasking.

The same idiom is repeated in cleanup_new_queues for queues whose NAPI
may already have been scheduled. Would a per-queue flag checked by the
poll tail, or masking after the poll can no longer run, be needed here?

The commit message says:

    "Scale-down masks PHYP on the retiring queues first, then disables
    NAPI, then masks and synchronises again, because an in-flight poll
    can re-arm PHYP while napi_disable() is waiting."

Is that accurate if the re-arm can also happen after napi_disable() has
returned?

> +
> +		for (i = new_count; i < old_count; i++)
> +			ibmveth_drain_rx_queue(adapter, i);

[ ... ]

> +		ibmveth_publish_num_rx_queues(adapter, new_count);
> +		synchronize_net();
> +
> +		rc = netif_set_real_num_rx_queues(netdev, new_count);

[ ... ]

> +		for (i = new_count; i < old_count; i++)
> +			ibmveth_destroy_subordinate_rx_queue(adapter, i);
> +	}

[ ... ]

> @@ -2550,6 +3167,68 @@ static void ibmveth_get_channels(struct net_device *netdev,
>  	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
>  }
>  
> +/**
> + * ibmveth_resize_rx_channels - Validate and apply a new RX queue count
> + * @adapter: ibmveth adapter
> + * @goal_rx: requested RX queue count
> + *
> + * Rejects rx > 1 without MQ firmware (-EOPNOTSUPP) and rx outside
> + * 1..IBMVETH_MAX_RX_QUEUES (-EINVAL). When RX resources are not live
> + * (!opened), only validate; do not allocate. When up, apply via
> + * ibmveth_resize_rx_queues_incremental().
> + *
> + * Return: 0 or negative errno
> + */
> +static int ibmveth_resize_rx_channels(struct ibmveth_adapter *adapter,
> +				      unsigned int goal_rx)
> +{

[ ... ]

> +	/*
> +	 * Refuse any rx > 1, not just growth: once mq_fallback is set the
> +	 * next open comes up single-queue, so an intermediate count could
> +	 * not be honoured either, and accepting it would only repeat the
> +	 * silent clamp at open. max_rx stays at the live count so that
> +	 * read-modify-write TX-only requests still clear the core.
> +	 */
> +	if (goal_rx > 1 && (!adapter->multi_queue || adapter->mq_fallback)) {
> +		netdev_err(netdev,
> +			   "Cannot resize to %u RX queues: multi-queue mode not supported by firmware\n",
> +			   goal_rx);
> +		return -EOPNOTSUPP;
> +	}

[Severity: Low]

Does the advertised channel range still match what this gate accepts once
adapter->mq_fallback is latched?

ibmveth_replenish_task() can set the flag at runtime while several RX
queues are still live and published:

	adapter->mq_fallback = true;
	schedule_work(&adapter->work);

and ibmveth_apply_mq_fallback() only consumes it at the start of the next
open. In that window ibmveth_get_channels() reports max_rx as
IBMVETH_MAX_RX_QUEUES (the live count with the follow-up patch, still
greater than 1), so the core forwards rx_count = 2 on a four-queue
device, and this gate refuses it with -EOPNOTSUPP.

A pure shrink needs no firmware MQ capability, it only deregisters
subordinate queues with H_FREE_LOGICAL_LAN_QUEUE, which the scale-down
path does unconditionally. Should shrinks be allowed here, or should
max_rx be reported as 1 while mq_fallback is set so the range and the set
path agree? The errno message "multi-queue mode not supported by
firmware" is also somewhat misleading for a request to reduce queues.

> +
> +	/* Down / failed-open: do not allocate. */
> +	if (!adapter->opened)
> +		return 0;

[Severity: Low]

Should a changed RX count be silently discarded here while success is
reported?

With the interface down, "ethtool -L ethX rx N" validates and returns 0,
nothing is published, and ibmveth_get_channels() keeps reporting the old
live count:

	channels->rx_count = ibmveth_get_num_rx_queues(adapter);

so userspace has no way to see that the request was ignored.

This is closed later in the same series: the patch "ibmveth: Complete
set_channels down-path and mq_fallback max_rx cap" adds a full down path
in ibmveth_set_channels() which calls
ibmveth_publish_num_rx_queues(adapter, goal_rx),
netif_set_real_num_rx_queues() and refreshes CMO. Would it read better to
fold that handling in here rather than leaving an intermediate commit
that accepts and drops the request?

> +
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
> @@ -2558,10 +3237,15 @@ static int ibmveth_set_channels(struct net_device *netdev,
>  		     goal = channels->tx_count;
>  	int rc, i;
>  
> -	/* If ndo_open has not been called yet then don't allocate, just set
> -	 * desired netdev_queue's and return
> +	/* Validate RX (and resize when opened) before the down-path
> +	 * early return so MQ/range errors are reported here. Publishing
> +	 * the desired RX count and CMO while down is the next patch.
>  	 */
> -	if (!(netdev->flags & IFF_UP))
> +	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
> +	if (rc)
> +		return rc;

[Severity: Low]

Can a failed ethtool -L leave the RX side already resized?

The RX resize is committed here, ahead of the TX LTB allocation and
netif_set_real_num_tx_queues() error paths further down, and this patch
has no RX rollback, so those paths return an error with the RX queue
count already changed.

The rollback arrives later in the series, in "ibmveth: Complete
set_channels down-path and mq_fallback max_rx cap", which records
want_tx/rx_changed and at the tail does:

	if (netdev->real_num_tx_queues != want_tx) {
		if (rx_changed) {
			...
			rb = ibmveth_resize_rx_queues_incremental(adapter,
								  old_rx,
								  rxq_entries);
			...
		}
		return rc ? rc : -ENOMEM;
	}

Would it be cleaner to introduce the RX resize and its rollback in one
patch, so no commit in the series leaves a half-applied ethtool -L?

> +
> +	if (!adapter->opened)
>  		return netif_set_real_num_tx_queues(netdev, goal);
>  
>  	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788102125.git.mmc%40linux.ibm.com

