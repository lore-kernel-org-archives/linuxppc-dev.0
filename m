Return-Path: <linuxppc-dev+bounces-25925-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EFBC5DF74
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 01:48:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPCJ46gn2z2ySg;
	Tue, 18 Aug 2026 11:47:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787017652;
	cv=none; b=gI/iekGBJWBCnfSAQbkxouPoEHW92iz4JHXysPOAqcvVv8XoJITMA1gjb+FhzcvkUvHJXbDY8vR8rrZRwmst448rrFxa15vy2/lUB7AfEQT6kjddmY9CW+2uvjSIu9e+EtAmwINEcA3TxUaCZgkpQ1BNq8huxeh27VxfU1TFjxu+KH4e10ABUfOadNI4jPgoGZXnh+1Vl0Sr3uXsUwlHgG1tFcWtHcOGQPK5iSmiiLFid/r7jSe0st1GTotXglsrbJhEJMgfvJo7Ncxfm2hSpWOuaW7e8DzA8mDNCWq2UMBrITdc9wZb4TZWaRCLTPgeRGFLhWiV3I5pqYZaSrSz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787017652; c=relaxed/relaxed;
	bh=F4YlEvaBl4f3zUW3LJ57Kt2whHfd2iLgx3fYdLDd8rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1XkErgYFk1/tfwYdWAoSB7cvc+mWF5mI7VLvS5YnB64a+GEGD4kD46VxZLsAODiZ1R2C2cQw2xQ0sRfa/SnKmIuBmvBPVAtkZhOX3KUXOHCQVtr6W2hpF/D2tQ0/u/+FV371J+UTPn6Gb2ycIu36AI51DzqQ4SjM9CI18LPrjTVay+RJbzP7N9CQlAk+YxnHqn/Z4YBKi3OjG2ju7a7y8CwLYydAumWMDSRID5ItKbvA9CA+bjAu3Q1/7FDSDuCS2JbZ9qyHYFAqiwYm2y2c7l8lI/MdIWxo2YFGG3W9lfO6g3yvENIuIxEuOWPt1nPPPGI76MbZJwHkabVZC4OoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/fVC6p6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/fVC6p6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPCJ336R6z2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:47:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7A630601FB;
	Tue, 18 Aug 2026 01:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D0B1F000E9;
	Tue, 18 Aug 2026 01:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017649;
	bh=F4YlEvaBl4f3zUW3LJ57Kt2whHfd2iLgx3fYdLDd8rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y/fVC6p6V7uAZ1UTlK/h+2+9CPYfGylNEPZf3sv0S5CfIL+8vIfb9AatpK45DA49m
	 +FC7DCnY3DzxhMgd7YqstIkTTW37x89klmBd3LRdjCYfhg1IJUPd6UT/lIlNj2lYVt
	 46EwtGCu1JemOP1XBExSnXcKfpRjlM99+qOq5KFWmGCVhseYddjfRnPKLiudKclc3O
	 lFF3bGYXgtbp2CJcIZ8HIlX+DFiWcu8Yn8GnQpD+zfSQGJOg2eI/DLixxeWQfgHYbo
	 jU4gMdmvqwU2vCPMvHNUrIJw7Acagz8JEjbS/ldukpRAWIPT6wYSLk2acNgqqenWzd
	 lTRilJDmv1+ng==
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
Subject: Re: [PATCH net-next v5 08/15] ibmveth: Add queue-aware RX buffer submit helper for MQ
Date: Mon, 17 Aug 2026 18:47:27 -0700
Message-ID: <20260818014727.3854161-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-9-mmc@linux.ibm.com>
References: <20260814073642.24630-9-mmc@linux.ibm.com>
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
ibmveth: Add queue-aware RX buffer submit helper for MQ

This adds ibmveth_add_logical_lan_buffers() to pick between the legacy
single/multi buffer hcalls and the new per-queue H_ADD_LOGICAL_LAN_BUFFERS_QUEUE
hcall, threads queue_index through the RX replenish/poll helpers, and
introduces a per-queue replenish_lock plus deferred (post-unlock) failure
logging and reset scheduling.

A few questions below about the new locking scope and about some of the
error paths that changed behaviour.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 8519cad503225..58a639a962a67 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -262,6 +272,7 @@ ibmveth_alloc_rx_queues(struct ibmveth_adapter *adapter, int rxq_entries)
>  		adapter->rx_queue[i].index = 0;
>  		adapter->rx_queue[i].num_slots = rxq_entries;
>  		adapter->rx_queue[i].toggle = 1;
> +		spin_lock_init(&adapter->rx_queue[i].replenish_lock);

[Severity: Medium]
Is it safe to re-initialize replenish_lock here, given that
ibmveth_alloc_rx_queues() runs on every ndo_open?

The driver restarts itself directly in several places, guarded only by
netif_running(), for example ibmveth_set_csum_offload():

	if (netif_running(dev)) {
		restart = 1;
		ibmveth_close(dev);
	}
	...
	if (restart)
		rc2 = ibmveth_open(dev);

veth_pool_store() and the MTU change path do the same. Because
__LINK_STATE_START is never cleared on these paths, netpoll_poll_disable()
is never called, and netpoll_poll_dev() only bails out on !npinfo or a held
dev_lock (dev_lock is taken solely by netpoll_poll_disable() from
__dev_open/__dev_close_many).

So can this sequence happen while netconsole is configured on this device?

CPU0 (printk -> netconsole)
  ibmveth_poll_controller()
    ibmveth_replenish_task(adapter, 0)
      spin_lock_irqsave(&rxq->replenish_lock, flags);

CPU1 (ethtool -K restart)
  ibmveth_open()
    ibmveth_alloc_rx_queues()
      spin_lock_init(&adapter->rx_queue[0].replenish_lock);

That resets a held spinlock to unlocked, and the later unlock on CPU0 runs
against re-initialized state.

[ ... ]

> -/* replenish the buffers for a pool.  note that we don't need to
> - * skb_reserve these since they are used for incoming...
> +/**
> + * ibmveth_add_logical_lan_buffers - Add receive buffers to hypervisor
> + * @adapter: ibmveth adapter structure
> + * @descs: array of buffer descriptors to add
> + * @filled: number of valid descriptors in the array
> + * @buff_size: size of each buffer (multi-queue mode only)
> + * @queue_index: RX queue index
> + *
> + * Return: hypervisor return code
>   */
> -static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
> -					  struct ibmveth_buff_pool *pool)
> +static long ibmveth_add_logical_lan_buffers(struct ibmveth_adapter *adapter,
> +					    union ibmveth_buf_desc *descs,
> +					    int filled,
> +					    unsigned long buff_size,
> +					    int queue_index)
> +{
> +	struct vio_dev *vdev = adapter->vdev;
> +	unsigned long rc;
> +
> +	if (adapter->multi_queue) {
> +		unsigned long buffersznum = (buff_size << 32) | filled;
> +		unsigned long ioba[IBMVETH_MAX_RX_PER_HCALL / 2] = {0};
> +		unsigned long handle = adapter->queue_handle[queue_index];
> +		int i;

[Severity: Low]
This call site passes adapter->queue_handle[queue_index], which includes
queue 0, but the kernel-doc of h_add_logical_lan_buffers_queue() in
ibmveth.h describes it as "Add buffers to subordinate queue" with
"@queue_handle: Queue handle from h_register_logical_lan_queue()", and its
Return section lists only H_SUCCESS/H_PARAMETER/H_HARDWARE.

The queue 0 handle comes from h_register_logical_lan_with_handle(), whose
own doc says the handle is "needed in multi-queue mode to use
h_add_logical_lan_buffers_queue() for all queues including queue 0", and
ibmveth_replenish_buffer_pool() has dedicated recovery for H_FUNCTION from
this hcall.

Could the h_add_logical_lan_buffers_queue() kernel-doc be updated to cover
the primary queue handle and H_FUNCTION?

[ ... ]

> +		rc = h_add_logical_lan_buffers_queue(vdev->unit_address,
> +						     handle,
> +						     buffersznum,
> +						     ioba[0], ioba[1], ioba[2],
> +						     ioba[3], ioba[4], ioba[5]);
> +		adapter->hcall_stats.add_bufs_queue++;
> +	} else if (filled == 1) {
> +		rc = h_add_logical_lan_buffer(vdev->unit_address,
> +					      descs[0].desc);
> +		adapter->hcall_stats.add_buf++;
> +	} else {
> +		rc = h_add_logical_lan_buffers(vdev->unit_address,
> +					       descs[0].desc, descs[1].desc,
> +					       descs[2].desc, descs[3].desc,
> +					       descs[4].desc, descs[5].desc,
> +					       descs[6].desc, descs[7].desc);
> +		adapter->hcall_stats.add_bufs++;
> +	}

[Severity: Low]
IBMVETH_MAX_RX_PER_HCALL changes from 8 to 12 in this patch, which resizes
descs[] and correlators[] in ibmveth_replenish_buffer_pool() to 12, but this
legacy branch still hands only descs[0..7] to the 8-descriptor
h_add_logical_lan_buffers(), and the caller then accounts all "filled"
descriptors as posted (consumer_index advanced, pool->available
incremented).

The combination needed to hit that (multi_queue == 0 with
rx_buffers_per_hcall > 8) does not appear reachable, since probe now sets
IBMVETH_MAX_RX_REGULAR (8) or 1, and later in the series
ibmveth_apply_mq_fallback() clamps to IBMVETH_MAX_RX_REGULAR.

Would a clamp on filled here, or a BUILD_BUG_ON tying the legacy branch to
IBMVETH_MAX_RX_REGULAR, be worth adding so the arity contract is enforced
rather than implied?

Also, the 12-address MQ packing (ioba[4], ioba[5]) cannot be exercised at
this commit, since probe caps the batch at 8:

> -		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_PER_HCALL;
> +		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_REGULAR;

[ ... ]

> +/* Replenish the buffers for a pool.
> + * Caller must hold the per-queue replenish_lock. Do not printk here —
> + * netconsole on the same device can re-enter replenish_task.
> + */
> +static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
> +					 struct ibmveth_buff_pool *pool,
> +					 int queue_index,
> +					 struct ibmveth_replenish_fail *fail)
>  {

[Severity: High]
The "do not printk here" invariant is documented for this function, but can
code called from inside the critical section still printk indirectly?

dma_map_single() in the fill loop goes through iommu_map_page() on pseries,
and the driver passes attrs = 0:

arch/powerpc/kernel/iommu.c:iommu_map_page() {
	...
		if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())  {
			dev_info(dev, "iommu_alloc failed, tbl %p vaddr %p npages %d\n", ...);
	...
}

That is exactly the condition replenish hits (TCE table or CMO entitlement
exhausted under pressure). With netconsole on this device, the printk
recurses:

	printk -> write_msg -> netpoll_send_udp -> __netpoll_send_skb
	  -> netpoll_poll_dev -> ibmveth_poll_controller
	    -> ibmveth_replenish_task -> spin_lock_irqsave(&rxq->replenish_lock)

Since the lock is already held on this CPU with interrupts disabled, does
this self-deadlock? The same re-entry also reaches
ibmveth_rxq_harvest_buffer() -> ibmveth_remove_buffer_from_pool(), which now
takes the same lock.

[ ... ]

> @@ -883,21 +971,85 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>  }
>  
>  /* replenish routine */
> -static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
> +static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
> +				   int queue_index)
>  {
> -	int i;
> +	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
> +	struct ibmveth_replenish_fail fail = {};
> +	unsigned long flags;
> +	int i, rc;
> +	int need_reset = 0;
> +	int batch_fallback = 0;
> +	int hcall_fail = 0;
> +
> +	if (queue_index >= adapter->num_rx_queues) {
> +		netdev_dbg(adapter->netdev,
> +			   "Skipping replenish for freed queue %d (num_queues=%d)\n",
> +			   queue_index, adapter->num_rx_queues);
> +		return;
> +	}
>  
>  	adapter->replenish_task_cycles++;

[Severity: Medium]
Several adapter-global fields are updated while holding only a per-queue
lock, or none at all. replenish_task_cycles++ here is outside the lock, and
inside ibmveth_replenish_buffer_pool() / ibmveth_add_logical_lan_buffers()
the following are adapter-wide:

	batch = adapter->rx_buffers_per_hcall;
	...
	adapter->rx_buffers_per_hcall = 1;
	adapter->hcall_stats.add_buf/add_bufs/add_bufs_queue++;
	adapter->replenish_add_buff_success/failure, replenish_no_mem

Two queues replenishing on different CPUs hold different replenish_lock
instances, so the intersection of locks protecting these is empty. Can this
lose or tear the ethtool-visible hcall_stats and replenish_* counters? Today
it is already racy between ibmveth_poll_controller() and NAPI for
replenish_task_cycles++, which is incremented before the lock is taken.

>  
> -	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
> -		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
> +	spin_lock_irqsave(&rxq->replenish_lock, flags);
>  
> -		if (pool->active &&
> -		    (atomic_read(&pool->available) < pool->threshold))
> -			ibmveth_replenish_buffer_pool(adapter, pool);
> +	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
> +		struct ibmveth_buff_pool *pool =
> +			&adapter->rx_buff_pool[queue_index][i];
> +
> +		if (pool->active && pool->free_map &&
> +		    (atomic_read(&pool->available) < pool->threshold)) {
> +			rc = ibmveth_replenish_buffer_pool(adapter, pool,
> +							   queue_index, &fail);

[Severity: High]
How long can interrupts stay disabled here?

The lock is taken with spin_lock_irqsave() around the whole five-pool walk,
and ibmveth_replenish_buffer_pool() loops "while (remaining > 0)" doing
netdev_alloc_skb() plus dma_map_single() per buffer, then a hypercall per
batch. With pool_active { 1, 1, 0, 0, 1 } and pool_count { 256, 512, 256,
256, 256 }, a cold start posts roughly 1024 buffers, including 256 of
buff_size 64 KB.

ibmveth_open() hits this deterministically:

	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
		ibmveth_replenish_task(adapter, i);

So every ifup does on the order of a thousand GFP_ATOMIC allocations
(some high order), a thousand IOMMU mappings and ~128 hypercalls with local
interrupts off. Previously this ran with interrupts enabled and no lock.

Can that trip the hard lockup watchdog or produce RCU stalls, and does
disabling BH/IRQ progress here also make the GFP_ATOMIC allocations more
likely to fail exactly when memory is tight? Since
ibmveth_remove_buffer_from_pool() now takes the same lock per received
packet, the NAPI consumer is also blocked for the whole region.

The changelog notes "Defer adapter-global counter atomics and irqsave
critical-section shorten to cover follow-up" - would it be better to shorten
the region in this patch, since as merged the region exists?

[ ... ]

> +out_unlock:
>  	ibmveth_update_rx_no_buffer(adapter);

[Severity: Low]
This helper is now called per queue, but ibmveth_update_rx_no_buffer() still
reads queue 0's buffer-list page:

	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;

Each RX queue has its own buffer-list page whose last 8 bytes hold that
queue's no-buffer drop count, so rx_no_buffer would under-report queues
1..N. This is addressed later in the series, where the helper takes
queue_index and uses buffer_list_addr[queue_index], and MQ is only turned on
by a later patch, so no wrong-page read looks reachable at this commit.
Would it be cleaner to make the helper queue-aware in the same patch that
makes its caller queue-aware?

> +
> +	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
> +
> +	/* Log and schedule reset only after dropping replenish_lock. */
> +	if (need_reset == IBMVETH_REPLENISH_RESET_MAP) {
> +		netdev_info(adapter->netdev,
> +			    "Invalid RX free_map entry on queue %d, reset\n",
> +			    queue_index);
> +		schedule_work(&adapter->work);

[Severity: Low]
This isn't a bug introduced by this patch, but the new schedule_work() sites
add more ways to arm adapter->work from NAPI context, and ibmveth_remove()
still cancels before it stops the device:

	cancel_work_sync(&adapter->work);
	...
	unregister_netdev(netdev);
	free_netdev(netdev);

RX activity between cancel_work_sync() and the ndo_close() done by
unregister_netdev() can re-queue the work, which may then run after
free_netdev(). The ordering is swapped later in this series
(unregister_netdev() first, then cancel_work_sync()), with a comment
describing exactly this window.

> +	} else if (need_reset == IBMVETH_REPLENISH_RESET_MQ) {
> +		dev_err_ratelimited(&adapter->netdev->dev,
> +				    "MQ buffer add H_FUNCTION (q=%d, batch=%u), reset\n",
> +				    queue_index, fail.batch);
> +		schedule_work(&adapter->work);
> +	}
> +
> +	if (batch_fallback)
> +		dev_warn_ratelimited(&adapter->netdev->dev,
> +				     "Legacy batch add H_FUNCTION (batch=%u), fallback\n",
> +				     fail.batch);
> +
> +	if (hcall_fail)
> +		dev_warn_ratelimited(&adapter->netdev->dev,
> +				     "RX %s failed: filled=%u, rc=%lu, batch=%u\n",
> +				     adapter->multi_queue ?
> +				     "h_add_logical_lan_buffers_queue" :
> +				     (fail.batch == 1 ?
> +				      "h_add_logical_lan_buffer" :
> +				      "h_add_logical_lan_buffers"),
> +				     fail.filled, fail.lpar_rc, fail.batch);
>  }

[Severity: Low]
Does this pick the wrong hcall name? The dispatch in
ibmveth_add_logical_lan_buffers() selects on filled, not batch:

	} else if (filled == 1) {
		rc = h_add_logical_lan_buffer(vdev->unit_address, descs[0].desc);

If batch is 8 and the fill loop breaks early after one buffer
(netdev_alloc_skb() or dma_mapping_error() failure), the failing call was
h_add_logical_lan_buffer(), but this prints h_add_logical_lan_buffers.
Should the selector be fail.filled == 1?

Separately, one "struct ibmveth_replenish_fail fail" and the
batch_fallback/hcall_fail flags are shared by all five pool iterations, so a
later pool's failure overwrites an earlier pool's rc/filled/batch, and one
log line can mix values from two pools.

>  
>  /* empty and free ana buffer pool - also used to do cleanup in error paths */
> @@ -932,6 +1084,14 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
>  		kfree(pool->skbuff);
>  		pool->skbuff = NULL;
>  	}
> +
> +	/*
> +	 * Keep probe/sysfs geometry (active, size, buff_size, threshold).
> +	 * Clearing active here was a v3 ifdown/up regression: open skips
> +	 * !active pools, so reopen posted no RX buffers (TX OK, ARP/RX
> +	 * dead) at any queue count, including RX=8 with no -L.
> +	 */
> +	atomic_set(&pool->available, 0);
>  }

[Severity: Low]
This comment describes a regression that does not exist in the tree: no
version of ibmveth_free_buffer_pool() ever cleared pool->active, and this
hunk is additive only. The same applies to the new comment in
ibmveth_rxq_correlator_valid() ("free_buffer_pool() clears skbuff but used
to leave size/active set").

References to "v3" and to lab options like "RX=8 with no -L" aren't
meaningful to a reader of mainline. Could the comments be rewritten in terms
of the code as it stands, and could the functional change here
(atomic_set(&pool->available, 0)) be mentioned in the commit message? Since
ibmveth_alloc_buffer_pool() already zeroes available on reallocation, it is
hard to tell from the patch whether this is a fix or a no-op.

[Severity: High]
This is a pre-existing race, but the new locking makes it look handled while
leaving it open. ibmveth_free_buffer_pool() kfrees pool->free_map,
pool->skbuff and pool->dma_addr without taking the per-queue
replenish_lock, while ibmveth_replenish_task() checks and uses those arrays
under that lock:

		if (pool->active && pool->free_map &&
		    (atomic_read(&pool->available) < pool->threshold)) {

So the check is a TOCTOU: replenish touches the pool arrays with
{rxq->replenish_lock} held, the free path touches and frees them with no
lock, giving an empty lock intersection.

Reachable through a direct close, which does not run
netpoll_poll_disable():

CPU0 (printk -> netconsole)
  ibmveth_poll_controller() -> ibmveth_replenish_task(adapter, 0)
    passes "pool->free_map != NULL", then dereferences
    pool->free_map / pool->skbuff / pool->dma_addr

CPU1 (ethtool -K / veth_pool_store / MTU change)
  ibmveth_close() -> ibmveth_free_buffer_pools()
    -> kfree(pool->free_map)

Can that produce a use-after-free of those arrays, and post freed buffers to
the hypervisor? Should ibmveth_free_buffer_pool() take replenish_lock (or
should the pool teardown otherwise be serialized against replenish)?

[ ... ]

> +static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
> +					 int queue_index, u64 correlator)
> +{
> +	unsigned int pool = correlator >> 32;
> +	unsigned int index = correlator & 0xffffffffUL;
> +	struct ibmveth_buff_pool *bpool;
> +
> +	if (pool >= IBMVETH_NUM_BUFF_POOLS)
> +		return false;
> +
> +	bpool = &adapter->rx_buff_pool[queue_index][pool];
> +
> +	/* init_buffer_pool() sets size for inactive pools; free_buffer_pool()
> +	 * clears skbuff but used to leave size/active set. Require a live
> +	 * pool with allocated arrays before indexing.
> +	 */
> +	if (!bpool->active || !bpool->skbuff || !bpool->free_map)
> +		return false;
> +
> +	return index < bpool->size;
> +}

[Severity: Medium]
Do the in-tree KUnit cases still pass with the added
"!bpool->free_map" precondition? Neither
ibmveth_remove_buffer_from_pool_test() nor ibmveth_rxq_get_buffer_test()
allocates free_map - both only kunit_kcalloc() pool->skbuff.

That makes validation fail before the skbuff[index] NULL check, so the two
-EFAULT expectations should now receive -EINVAL:

	correlator = (u64)0 | 0;
	pool->skbuff[0] = NULL;
	KUNIT_EXPECT_EQ(test, -EFAULT,
			ibmveth_remove_buffer_from_pool(adapter,
							correlator, 0, false));

and the positive expectation in ibmveth_rxq_get_buffer_test() should receive
NULL:

	pool->skbuff[0] = skb;
	adapter->rx_queue[0].queue_addr[0].correlator = (u64)0 << 32 | 0;
	KUNIT_EXPECT_PTR_EQ(test, skb, ibmveth_rxq_get_buffer(adapter, 0));

The index-out-of-range expectations also pass vacuously now, so the bound
check they were written for is no longer covered. The patch updates the
kernel-doc of both tests but not the fixtures - should the fixtures also
allocate free_map?

[ ... ]

>   * Return:
>   * * %0       - success
>   * * %-EINVAL - correlator maps to pool or index out of range
>   * * %-EFAULT - pool and index map to null skb
>   */
>  static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
> -					   u64 correlator, bool reuse)
> +					   u64 correlator, int queue_index,
> +					   bool reuse)
>  {

[Severity: Low]
The documented meaning of -EINVAL is now incomplete: via
ibmveth_rxq_correlator_valid() this function also returns -EINVAL for an
inactive pool and for a pool whose skbuff/free_map arrays are not
allocated, which is a different condition from "out of range". The new
ibmveth_rxq_harvest_buffer() kernel-doc reinforces the narrow reading by
telling callers that -EINVAL/-EFAULT mean a "corrupt slot" safe to skip.
Could the return-code documentation be extended to cover the not-live-pool
case?

> +	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
>  	unsigned int pool  = correlator >> 32;
>  	unsigned int index = correlator & 0xffffffffUL;
>  	unsigned int free_index;
>  	struct sk_buff *skb;
> +	unsigned long flags;
> +	int rc = 0;
>  
> -	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
> -	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
> -		schedule_work(&adapter->work);
> -		return -EINVAL;
> +	spin_lock_irqsave(&rxq->replenish_lock, flags);
> +
> +	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
> +		rc = -EINVAL;
> +		goto out_unlock;
>  	}
>  
> -	skb = adapter->rx_buff_pool[0][pool].skbuff[index];
> -	if (WARN_ON(!skb)) {
> -		schedule_work(&adapter->work);
> -		return -EFAULT;
> +	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
> +	if (!skb) {
> +		rc = -EFAULT;
> +		goto out_unlock;
>  	}

[ ... ]

>  static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
> -				      bool reuse)
> +				      int queue_index, bool reuse)
>  {
> +	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
>  	u64 cor;
>  	int rc;
>  
> -	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
> -
>  	cor = rxq->queue_addr[rxq->index].correlator;
> -	rc = ibmveth_remove_buffer_from_pool(adapter, cor, reuse);
> -	if (unlikely(rc))
> +	rc = ibmveth_remove_buffer_from_pool(adapter, cor, queue_index, reuse);
> +	if (unlikely(rc)) {
> +		/* Skip a corrupt slot without claiming pool ownership. */
> +		if (rc == -EINVAL || rc == -EFAULT)
> +			ibmveth_rxq_advance(rxq);
>  		return rc;
> -
> -	if (++adapter->rx_queue[0].index == adapter->rx_queue[0].num_slots) {
> -		adapter->rx_queue[0].index = 0;
> -		adapter->rx_queue[0].toggle = !adapter->rx_queue[0].toggle;
>  	}

[Severity: Medium]
The reset that previously repaired this state is gone -
ibmveth_remove_buffer_from_pool() no longer calls
schedule_work(&adapter->work) for -EINVAL/-EFAULT, and here the ring is just
advanced. Does that permanently retire the buffer the hypervisor already
consumed?

On this path free_map does not regain the index, the
atomic_dec(&pool->available) is skipped, and pool->skbuff[index] plus its
DMA mapping stay owned by nobody.

Since replenish is gated on available < threshold (size * 7 / 8):

		if (pool->active && pool->free_map &&
		    (atomic_read(&pool->available) < pool->threshold)) {

after roughly size/8 such events, does replenish stop for that pool
permanently, with the link still up and no recovery short of ifdown/up?

The poll "recycling invalid buffer" path and ibmveth_drain_rx_queue() both
swallow these errors without escalating:

	/* -EINVAL/-EFAULT already advanced past the slot. */
	if (rc == -EINVAL || rc == -EFAULT) {
		drained++;
		continue;
	}

At the end of the series only the get_buffer path escalates via
ibmveth_poll_skip_bad_correlator(), and that code's own comment ("Residual
stale slot after resize") suggests stale correlators do occur. Should the
recycle and drain paths also reconcile available or schedule a reset?

[ ... ]

> @@ -2127,34 +2340,41 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
> -			skb = ibmveth_rxq_get_buffer(adapter);
> +			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
>  			if (unlikely(!skb))
>  				break;

[Severity: Low]
This isn't a bug introduced by this patch, but breaking out here leaves
rxq->index and rxq->toggle untouched, so the descriptor stays pending. The
tail of ibmveth_poll() then completes NAPI, re-enables the IRQ, and:

	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
	    napi_schedule(napi)) {
		rc = ibmveth_disable_irq(adapter, queue_index);
		WARN_ON(rc);
		goto restart_poll;
	}

Can that spin on the same slot in softirq context when a VALID descriptor
has a correlator that fails validation, or whose pool->skbuff[index] is
NULL? The changelog says this lands with the poll harden patch ("Bad
queue_index poll path: napi_complete before return lands with poll
harden"), and later in the series
ibmveth_poll_skip_bad_correlator() schedules a reset and advances the ring.

[ ... ]

> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
> index fae3473cc4985..d02444d5b3b89 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.h
> +++ b/drivers/net/ethernet/ibm/ibmveth.h
> @@ -259,7 +261,8 @@ static inline long h_illan_attributes(unsigned long unit_address,
>  #define IBMVETH_DEFAULT_QUEUES 8U
>  #define IBMVETH_MAX_RX_QUEUES 1U
>  #define IBMVETH_DEFAULT_RX_QUEUES 1U
> -#define IBMVETH_MAX_RX_PER_HCALL 8U
> +#define IBMVETH_MAX_RX_REGULAR 8U
> +#define IBMVETH_MAX_RX_PER_HCALL 12U

The change of IBMVETH_MAX_RX_PER_HCALL from 8 to 12 is described in the
commit message only as "up to 12 buffers" for the MQ hcall - could the
commit message also state that the existing constant is being redefined, so
that the descs[]/correlators[] resize in ibmveth_replenish_buffer_pool() and
the new IBMVETH_MAX_RX_REGULAR use in probe are easy to follow?

> @@ -301,6 +304,7 @@ struct ibmveth_rx_q {
>      dma_addr_t queue_dma;
>      u32        queue_len;
>      struct ibmveth_rx_q_entry *queue_addr;
> +	spinlock_t	replenish_lock;	/* per-queue buffer replenish */
>  };

This isn't a bug, but the new member uses tabs while the surrounding members
in this struct use the older space-based alignment - was the mixed style
intentional?

