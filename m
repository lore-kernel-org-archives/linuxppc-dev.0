Return-Path: <linuxppc-dev+bounces-25931-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA605C5DF74
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 01:49:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPCJH4FFyz2xyl;
	Tue, 18 Aug 2026 11:47:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787017663;
	cv=none; b=mAQ+fosjrl8QmBbHWVIyeesJtVP8dRFV2JVnvSSBQ+w3cak1SjTn8ugGRqBaHGZBDVfjR/ABNCEYMtMd1dKVGEsqYxshdIIb/s8T9+cl5mTfgomdytecPpZ9ewbmkJYfxLXM2EXMwvl7wRRuRuBJ/DP7P0QOIX/rtNUruYJemmAunMXOhLMr8u/edTbxUoP2lX24soF5l96ASpkXVIywylemvDrm/0KISwGqBFwYMxoaYFb1/hvOy7knHq0Do3UzmTcHFDj7OZAwsnWYOxI7P/BhyepEtuBG0xYrwfxqRiA9smgC9LORzFBXcxY9Y+iOimPoJiEVAB56jjlQdE3LKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787017663; c=relaxed/relaxed;
	bh=2TcJIwcM/dfZgZ8Yuadj1tdJmeQIg7Ed2656O04qxUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKQuPbxSAdrt7oMVQA/P3SdSZOPIHHC3dKPPSNuWqlcojUGeE9iE5uTd2GJNwTn9pVGGRdvZiLB3Csk+eka1haT5yZiv0Jr4aJQNUUC2Fg92RPqDzq0GMV1fmdapH0w4Cyn6KgRHgqvIBPzyXJk+nlXeaeY7SNRNv6Ux7q8sq074BMvx51y1WwKBBhVhw8SchrJKXPapT5yNUNxkf/toR6rtaEmPdv9wMzidEodmPGbkZbnSiHkN+GSD1o9EgrrrtneFNNc3uV19zQoFnwL4Ty7zdfq819+iCYNz+FuYGKmA2prexuh7JtyYfBMthbB74f0uy30t3fpFTHb3N4ssNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIXVAwCZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIXVAwCZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPCJG0cK5z301X
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:47:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D14744023A;
	Tue, 18 Aug 2026 01:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4164B1F000E9;
	Tue, 18 Aug 2026 01:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017659;
	bh=2TcJIwcM/dfZgZ8Yuadj1tdJmeQIg7Ed2656O04qxUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AIXVAwCZYEsOLtoRgmzo7COlqPOd7horEza78STU9af1B9MkzgMAVyU6FRjsrAHBL
	 UO9Q5vp8lVD2TCORklPjPicXqoHCzUNAOVBZ8o6Wi8Lz9tV8KyY76eb6HEyd3va0TN
	 fsutajjU9wuNn7FAGUmn2pwVXtwo6qWxp/1xZ9p2XUCUySleA10xmHfQmLgJqNn8LB
	 MaAXC3HQ/TwQTpw8VQwcEaBl586cyM/l0l9kyk8am1UL6Zr08G2nndXB2SDkXOncBV
	 fPEE9Ce03sN4Z9ugy5rt99m4PkzQMtxYNHDxxLN50yy3Xl1Y0+lDOhFZi6j7WxTVe1
	 r5VxrDSs9Y90Q==
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
Subject: Re: [PATCH net-next v5 14/15] ibmveth: Implement incremental MQ RX queue resize
Date: Mon, 17 Aug 2026 18:47:37 -0700
Message-ID: <20260818014738.3854470-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-15-mmc@linux.ibm.com>
References: <20260814073642.24630-15-mmc@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ibmveth: Implement incremental MQ RX queue resize

This adds incremental RX queue scale-up/scale-down helpers so that
ethtool -L no longer needs a full adapter teardown, wires CMO
entitlement updates and rollback paths into the resize, and factors the
desired-DMA math into ibmveth_desired_dma_for_rxqs(). It also adds
ibmveth_resize_rx_channels() and calls it from ibmveth_set_channels().

A few questions on the changelog and on the new resize paths below.

[Severity: Medium]

Some of the work credited to this commit does not appear in its diff:

> Strengthen correlator liveness (active pool + non-NULL backing arrays)
> and clear freed pool metadata so torn-down pools no longer look
> in-range. Restore schedule_work escalation for truly impossible
> correlators.

> Also implement incremental scale-up/down helpers, WRITE_ONCE
> num_rx_queues publication, rollback/CMO updates, and related resize
> error paths.

git blame at this revision attributes those pieces to earlier commits in
the series:

  - ibmveth_rxq_correlator_valid(), including the
    "!bpool->skbuff || !bpool->free_map" liveness test, comes from
    6246916e4cdd ("ibmveth: Add queue-aware RX buffer submit helper for
    MQ")
  - the schedule_work() escalation in
    ibmveth_poll_skip_bad_correlator() comes from d613a86a7fa2
    ("ibmveth: Harden RX poll path with helpers")
  - ibmveth_publish_num_rx_queues() with smp_wmb() + WRITE_ONCE() comes
    from 4fbd8c64be1f ("ibmveth: Enable multi-queue RX receive path")

ibmveth_free_buffer_pool() is not touched here at all, and it explicitly
keeps active/size/buff_size/threshold, which reads as the opposite of
"clear freed pool metadata".

The changelog also describes a hang root cause being fixed, but the
parent commit has no live RX resize path in ibmveth_set_channels() -
this patch is what introduces it. Could the changelog be trimmed to the
contents of this diff?

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 1b58a3c6ce77a..84f4a0deb0c55 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1380,6 +1432,141 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)

[ ... ]

> +/**
> + * ibmveth_free_single_rx_queue - Free resources for a single RX queue
> + * @adapter: ibmveth adapter structure
> + * @queue_idx: Queue index to free
> + *
> + * Frees buffer list, RX queue, and per-queue buffer pools for one queue.
> + * Used during incremental scale-down without affecting remaining queues.
> + */
> +static void
> +ibmveth_free_single_rx_queue(struct ibmveth_adapter *adapter, int queue_idx)
> +{
> +	struct device *dev = &adapter->vdev->dev;
> +
> +	ibmveth_free_queue_buffer_pools(adapter, queue_idx);
> +
> +	if (adapter->buffer_list_dma[queue_idx]) {
> +		dma_unmap_single(dev, adapter->buffer_list_dma[queue_idx],
> +				 4096, DMA_BIDIRECTIONAL);
> +		adapter->buffer_list_dma[queue_idx] = 0;
> +	}
> +
> +	if (adapter->rx_queue[queue_idx].queue_addr) {
> +		dma_free_coherent(dev, adapter->rx_queue[queue_idx].queue_len,
> +				  adapter->rx_queue[queue_idx].queue_addr,
> +				  adapter->rx_queue[queue_idx].queue_dma);
> +		adapter->rx_queue[queue_idx].queue_addr = NULL;
> +	}
> +
> +	if (adapter->buffer_list_addr[queue_idx]) {
> +		free_page((unsigned long)adapter->buffer_list_addr[queue_idx]);
> +		adapter->buffer_list_addr[queue_idx] = NULL;
> +	}
> +
> +	netdev_dbg(adapter->netdev, "Freed queue %d resources\n", queue_idx);
> +}

[ ... ]

> @@ -1797,6 +2034,356 @@ ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
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
> +	adapter->hcall_stats.free_lan_queue++;
> +
> +	if (lpar_rc != H_SUCCESS) {
> +		netdev_err(adapter->netdev,
> +			   "h_free_logical_lan_queue failed for queue %d: rc=0x%lx\n",
> +			   queue_idx, lpar_rc);
> +	}
> +
> +	adapter->queue_handle[queue_idx] = 0;
> +
> +	netdev_dbg(adapter->netdev, "Deregistered queue %d\n", queue_idx);
> +}

[Severity: Medium]

What happens if h_free_logical_lan_queue() returns a non-busy error such
as H_PARAMETER or H_HARDWARE here?  The retry loop only covers
H_BUSY/H_IS_LONG_BUSY; other failures are logged, the handle is zeroed
and the function returns void, so the caller cannot tell.

ibmveth_destroy_subordinate_rx_queue() then goes on to release
everything PHYP may still own for that queue:

	ibmveth_deregister_single_rx_queue(adapter, queue_idx);
	ibmveth_cleanup_single_rx_interrupt(adapter, queue_idx);
	ibmveth_free_single_rx_queue(adapter, queue_idx);

ibmveth_free_single_rx_queue() unmaps and frees the posted RX buffers via
ibmveth_free_queue_buffer_pools(), then dma_unmap_single() +
free_page() on buffer_list_addr[queue_idx] and dma_free_coherent() on
rx_queue[queue_idx].queue_addr.

If the hypervisor still owns the ring and the posted buffers, can this
let PHYP DMA into pages already returned to the allocator?  With
queue_handle[queue_idx] cleared there is also no handle left to retry
the free with later.  Should the deregister helper return an error and
the destroy path skip the unmap/free (or force a reset) in that case?

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

> +			/*
> +			 * Fully ready before PHYP delivery, matching open():
> +			 * publish -> replenish -> napi_enable -> enable_irq.
> +			 * That way ibmveth_interrupt() cannot run on an
> +			 * unpublished, empty, or NAPI-disabled queue.
> +			 */
> +			ibmveth_publish_num_rx_queues(adapter, i + 1);

[Severity: Medium]

Is the publication protocol complete on the reader side?

ibmveth_publish_num_rx_queues() pairs a write barrier with the store:

	/* Per-queue state must be visible before readers observe num. */
	smp_wmb();
	WRITE_ONCE(adapter->num_rx_queues, num);

but the consumer has no matching barrier:

	static inline unsigned int
	ibmveth_get_num_rx_queues(const struct ibmveth_adapter *adapter)
	{
		return READ_ONCE(adapter->num_rx_queues);
	}

Readers (ibmveth_interrupt(), ibmveth_poll(), ibmveth_poll_controller(),
ibmveth_replenish_task()) index per-queue state under only a control
dependency on that count, which powerpc does not order for loads.  Can a
reader observe the bumped count while still seeing stale
queue_handle[i], queue_irq[i] or NULL rx_buff_pool[i][x] pointers for the
queue just added?  ibmveth_drain_rx_queue() added by this patch does have
an explicit smp_rmb(); should ibmveth_get_num_rx_queues() carry the
acquire side instead?

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
> +				 */
> +				ibmveth_publish_num_rx_queues(adapter, i);
> +				napi_disable(&adapter->napi[i]);

[Severity: Medium]

Is the ordering here intentional?  This path publishes the live count
down to i before napi_disable(&adapter->napi[i]), while the scale-down
loop and cleanup_new_queues below do napi_disable() first and publish
afterwards.

Queue i has already been published and napi_enable()d at this point, so a
poll can be scheduled for it (netpoll via ibmveth_poll_controller(), or a
PHYP interrupt if the unmask actually took effect and the hcall still
reported an error).  ibmveth_poll() starts with:

	if (WARN_ON(queue_index < 0 ||
		    queue_index >= ibmveth_get_num_rx_queues(adapter))) {

so can a poll scheduled for queue i now hit that WARN_ON?

> +				ibmveth_drain_rx_queue(adapter, i);
> +				synchronize_net();
> +				ibmveth_destroy_subordinate_rx_queue(adapter,
> +								     i);
> +				/* enable_irq returns errno; keep -EIO. */
> +				rc = -EIO;
> +				goto cleanup_new_queues;
> +			}
> +			ibmveth_kick_rx_queue_if_pending(adapter, i);

[Severity: Medium]

Can this leave a newly added queue permanently dead if replenishment
posted nothing?

ibmveth_replenish_task() is void and swallows both total SKB allocation
failure and ordinary post failures (IBMVETH_REPLENISH_HCALL_FAIL only
produces a rate-limited warning).  The kick afterwards is conditional:

	if (ibmveth_rxq_pending_buffer(adapter, queue_index))
		ibmveth_schedule_rx_queue(adapter, queue_index);

With zero posted buffers PHYP has nothing to complete, so
ibmveth_rxq_pending_buffer() is false, no interrupt arrives, and poll
never runs to retry the replenish.  There is no timer or delayed work in
ibmveth.c that would retry either.  The queue is still counted in
real_num_rx_queues, so flows hashed to it are dropped until the admin
runs ethtool again or does ifdown/ifup.

The open path uses ibmveth_restart_rx_queue(), which always schedules one
poll and therefore gets a retry.  Would the same be appropriate here, and
in the scale-down rollback below which repeats this sequence after
draining?

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

[ ... ]

> +		for (i = new_count; i < old_count; i++)
> +			ibmveth_drain_rx_queue(adapter, i);
> +
> +		synchronize_net();
> +
> +		ibmveth_publish_num_rx_queues(adapter, new_count);
> +
> +		rc = netif_set_real_num_rx_queues(netdev, new_count);

[Severity: High]

Is the ordering of synchronize_net() and the count publish inverted here?

The grace period runs before ibmveth_publish_num_rx_queues(adapter,
new_count), and the destroy loop that follows the publish has no further
grace period and takes no lock - in particular not the per-queue
rx_queue[i].replenish_lock that readers hold.

ibmveth_poll_controller() (ndo_poll_controller, so netpoll/netconsole,
outside RTNL and outside the NAPI state machine) samples the count once
and then walks it:

	unsigned int num = ibmveth_get_num_rx_queues(adapter);

	for (i = 0; i < num; i++)
		ibmveth_replenish_task(adapter, i);

	for (i = 0; i < num; i++)
		ibmveth_schedule_rx_queue(adapter, i);

and ibmveth_replenish_task() re-checks the count before it takes the lock
and dereferences the pool arrays:

	if (queue_index >= ibmveth_get_num_rx_queues(adapter)) { ... return; }
	...
	spin_lock_irqsave(&rxq->replenish_lock, flags);
	... if (pool->active && pool->free_map && ...)

which looks like a pure time-of-check/time-of-use test against the
teardown path.  Meanwhile ibmveth_free_buffer_pool() frees exactly those
pointers with no lock held:

	kfree(pool->free_map);
	pool->free_map = NULL;
	... kfree(pool->dma_addr); ... kfree(pool->skbuff);

Can a reader that already passed the count check be inside
ibmveth_replenish_task() on queue i while free_map/skbuff/dma_addr are
kfree()d, buffer_list_addr[i] is free_page()d and rx_queue[i].queue_addr
is dma_free_coherent()d?  The changelog says dropping the live count
means netpoll cannot walk dying queues, but with the grace period taken
before the publish that does not seem to hold.  The same pattern appears
in cleanup_new_queues below (synchronize_net(), then publish, then
destroy).

> +		if (rc) {
> +			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
> +				   new_count, rc);
> +			ibmveth_publish_num_rx_queues(adapter, old_count);
> +			for (i = new_count; i < old_count; i++) {
> +				int irq_rc;
> +
> +				ibmveth_replenish_task(adapter, i);
> +				/* START: NAPI before PHYP unmask. */
> +				napi_enable(&adapter->napi[i]);
> +				irq_rc = ibmveth_enable_irq(adapter, i);
> +				if (irq_rc) {
> +					netdev_err(netdev,
> +						   "Failed to re-enable IRQ for queue %d during scale-down rollback (rc=%d), scheduling reset\n",
> +						   i, irq_rc);
> +					schedule_work(&adapter->work);
> +					continue;
> +				}
> +				ibmveth_kick_rx_queue_if_pending(adapter, i);
> +			}
> +			return rc;
> +		}
> +
> +		for (i = new_count; i < old_count; i++)
> +			ibmveth_destroy_subordinate_rx_queue(adapter, i);
> +
> +		/* Q0 (and any still-live queues) were not in the teardown
> +		 * loop. Scale-down can leave Q0 masked with NAPI idle — kick
> +		 * so ARP/RX does not die until rmmod (lab: -L rx 1).
> +		 */
> +		for (i = 0; i < new_count; i++)
> +			ibmveth_restart_rx_queue(adapter, i);

[Severity: Medium]

Is it safe to call ibmveth_restart_rx_queue() on queues that were never
quiesced by this function and are actively receiving?

ibmveth_restart_rx_queue() falls back to an unmask when the NAPI schedule
attempt fails:

	ibmveth_replenish_task(adapter, qindex);
	if (ibmveth_schedule_rx_queue(adapter, qindex))
		return;

	rc = ibmveth_enable_irq(adapter, qindex);
	WARN_ON(rc);

napi_schedule_prep() failing is precisely the state "a poll is already in
flight and has masked PHYP", so the fallback unmasks PHYP behind that
running poll.  The poll's own tail then calls ibmveth_enable_irq() on an
already-enabled subordinate queue, and ibmveth_toggle_irq() folds
H_PARAMETER to success only on disable:

	if (h_rc == H_PARAMETER && !enable) { ... return 0; }
	...
	if (h_rc) { ... return -EIO; }

so the poll gets -EIO and escalates to schedule_work(&adapter->work),
i.e. a full close+open of the adapter.  In the reverse interleaving the
resize-side enable is the one that returns -EIO and trips the WARN_ON.

With new_count >= 2 and traffic running on a surviving subordinate queue,
can ethtool -L rx <smaller> trigger a spurious adapter reset or that WARN
splat?  Should the restart loop be limited to queue 0, or use a path that
does not unmask when a poll owns the queue?

> +	}
> +
> +	netdev_info(netdev, "Successfully resized to %d RX queues (incremental)\n",
> +		    ibmveth_get_num_rx_queues(adapter));

[ ... ]

> +cleanup_new_queues:

[ ... ]

> +	synchronize_net();
> +
> +	/* Drop the live count before freeing the half-added queues. */
> +	ibmveth_publish_num_rx_queues(adapter, old_count);
> +
> +	for (i = old_count; i < failed_queue; i++)
> +		ibmveth_destroy_subordinate_rx_queue(adapter, i);

[ ... ]

> @@ -2535,6 +3122,55 @@ static void ibmveth_get_channels(struct net_device *netdev,

[ ... ]

> +static int ibmveth_resize_rx_channels(struct ibmveth_adapter *adapter,
> +				      unsigned int goal_rx)
> +{

[ ... ]

> +	if (goal_rx == old_rx)
> +		return 0;
> +
> +	/* Down / failed-open: caller stashes. Do not allocate here. */
> +	if (!adapter->opened)
> +		return 0;

[Severity: Low]

The kernel-doc and this comment say the caller stashes the desired count
when RX resources are not live, but at this commit the only caller does:

	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
	if (rc)
		return rc;

	if (!adapter->opened)
		return netif_set_real_num_tx_queues(netdev, goal);

There is no adapter->num_rx_queues update, no
netif_set_real_num_rx_queues() and no CMO refresh on that path, so
ethtool -L ethX rx N on a down interface returns success while
ibmveth_get_channels() keeps reporting the old count.

The following patch in the series, "ibmveth: Wire ethtool set_channels to
MQ RX queue resize", does add the stash/publish/CMO block, so the final
state of the series matches the documentation - only this intermediate
commit does not.

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
> @@ -2543,10 +3179,15 @@ static int ibmveth_set_channels(struct net_device *netdev,
>  		     goal = channels->tx_count;
>  	int rc, i;
>  
> -	/* If ndo_open has not been called yet then don't allocate, just set
> -	 * desired netdev_queue's and return
> +	/* Validate RX (and resize when opened) before the down-path early
> +	 * return so MQ/range errors are not deferred to the wiring patch.
> +	 * RX stash + CMO while down still lands with that patch.
>  	 */
> -	if (!(netdev->flags & IFF_UP))
> +	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
> +	if (rc)
> +		return rc;

[Severity: Low]

The live RX resize is committed here, ahead of all TX work, and at this
commit nothing unwinds it if the TX portion later fails - the tail of
ibmveth_set_channels() just returns rc after
netif_set_real_num_tx_queues() fails.  So ethtool -L ethX rx N tx M can
return an error to userspace with the hypervisor-visible queue set,
adapter->num_rx_queues, netdev->real_num_rx_queues and the CMO
entitlement already changed.

The next patch in the series adds the rx_changed rollback that calls
ibmveth_resize_rx_queues_incremental(adapter, old_rx, rxq_entries) on TX
failure, so the series head does handle it; only this commit is missing
the unwind.

> +
> +	if (!adapter->opened)
>  		return netif_set_real_num_tx_queues(netdev, goal);

[ ... ]

[Severity: Medium]

Not a problem introduced by this patch, but the in-tree KUnit cases in
ibmveth.c look broken as of this series and are still broken at the
series head.

ibmveth_rxq_correlator_valid() requires free_map to be non-NULL:

	if (!bpool->active || !bpool->skbuff || !bpool->free_map)
		return false;

Both fixtures only allocate pool->skbuff with kunit_kcalloc() after
ibmveth_init_buffer_pool(), which never sets free_map.  So in
ibmveth_remove_buffer_from_pool_test() this case:

	correlator = (u64)0 | 0;
	pool->skbuff[0] = NULL;
	KUNIT_EXPECT_EQ(test, -EFAULT,
			ibmveth_remove_buffer_from_pool(adapter, correlator, 0, false));

gets -EINVAL from the correlator check instead of -EFAULT, and in
ibmveth_rxq_get_buffer_test():

	pool->skbuff[0] = skb;
	adapter->rx_queue[0].queue_addr[0].correlator = (u64)0 << 32 | 0;
	KUNIT_EXPECT_PTR_EQ(test, skb, ibmveth_rxq_get_buffer(adapter, 0));

gets NULL.  The liveness check came in with 6246916e4cdd ("ibmveth: Add
queue-aware RX buffer submit helper for MQ").  Should the fixtures also
allocate pool->free_map so CONFIG_IBMVETH_KUNIT_TEST builds pass?

