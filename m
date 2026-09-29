Return-Path: <linuxppc-dev+bounces-28520-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72D5CA5FA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:33:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvSyY45zJz3bX3;
	Wed, 30 Sep 2026 05:33:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790710405;
	cv=none; b=dIWSIJ0NOda1LKW1gJvQayI0f7rfgdwu7WGG10IYg7SNg0YqhiHLFJsJK06tl6tvvdOUdkj0yDrjTvE791kIOWhBxHudCzWGa80OfiVdm35XqDULiDwSLNIhvRl0IRFSN5yNUlY57trTzZrgclIyvtuJJQ6sK8TQOPJ51BRfBPMUfQRISi8whGO5bbkpumRNs/LGVwwWH4hAqvGVE0XzfqtyNa4sxGH2BpH9QXAKVxOx1yvJPkyvEbuFYXFLnyvObOGfAHhQZtHHD3tn8I7SekML8GDihF7LqaxzhBFrI7N+q8F+Tw8FLBdSKC0SK72pSNBhw+lm58Y1sCr7bTHbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790710405; c=relaxed/relaxed;
	bh=cfT/gCG9G2j6N3wGn2bGSTPo3Xb0xRkJy6X4Pwwli9w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hMTyUz6FEvsQi6q11XjLRLnYjLTDVAC6ujbEFTFx9rJUYfy70mWXWTvlBDrdcBbWo5AmvcUyfFgwfh115iu8+tvn0XZqAWNuNicYMM6/U7nIF0+QsZjISdZLvA5+WCiy0n+DIQzI/8VEho3F3DEej54wzaxhzihDVFmr5Whih3rOctUWRz2PrnDDDOhkORsM+M3RaMKZEgpzXEZvkNs+HkGCtxQT8pzujRWyiOnu0eBQBxCACIPLh/X1YlBGg3a5t5EG3bDZFeFYYxSt+y+X0gKNVw+u53BsRnad5UdbPNLDw2yIGTUtYTV2QzKVxWSPguPB1LeRuTbIljdZmmGKmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZjdoJYqd; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZjdoJYqd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvSyW6YpVz30hq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:33:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9D85360235;
	Tue, 29 Sep 2026 19:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BB71F00898;
	Tue, 29 Sep 2026 19:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710401;
	bh=cfT/gCG9G2j6N3wGn2bGSTPo3Xb0xRkJy6X4Pwwli9w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZjdoJYqd75/zjMaGwIGu+lhn7Chm4GbK6BXLJkmf568mC5VIobdMVpDAZVCCsu5tA
	 CevUBJFWZ9sRjSHK2YNswAbFdyEuEUVi5vG16Kr8INNeqKRZdZCMxvVCRUNtdUGsfd
	 IRRw21/qJYTc4VNfCuJb9tGN62vGwsDkLrroOeemXY6J+lEEReUiAQXpyt6WJPsBlY
	 /P49FadCwQyL3fcrj7OAMV/QiFD6wNWs/Hmz+KHykh/IdfqT6bNwMbn3iF6fV6sVfO
	 3eNdHB3Kp05Co8nRIZ8vBUzky5Z5fsl7i4vg8GU+HVCQ7fDBVdj0f/OxlqanxJFXs5
	 NgcqV8JFeJI/g==
Subject: Re: [PATCH net-next v7 08/15] ibmveth: Add queue-aware RX buffer
 submit helper for MQ
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Tue, 29 Sep 2026 19:33:20 +0000
Message-ID: <179071040006.434549.6643409390069247563@kernel.org>
In-Reply-To:
 <3647dfce84454c5e60269549172fd20f504bddad.1790319558.git.mmc@linux.ibm.com>
References:
 <3647dfce84454c5e60269549172fd20f504bddad.1790319558.git.mmc@linux.ibm.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 2 (3)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch fixes three real bugs that already exist in the
  tree, but it presents itself as a feature ('Add queue-aware RX buffer…
- [Medium] This patch removes schedule_work(&adapter->work) from the
  -EINVAL and -EFAULT exits of ibmveth_remove_buffer_from_pool().
- [Medium] ibmveth_replenish_task() now holds
  spin_lock_irqsave(&rxq->replenish_lock) across the whole walk of all…
- [Low] ibmveth_replenish_task() fills a single struct
  ibmveth_replenish_fail across every pool it walks.
- [Low] Reported concern: ibmveth_close() frees the buffer pools
  (free_map, skbuff, dma_addr, available) and the buffer-list pages…

Pre-existing issues:
- [Low] Reported concern: on the rx_copybreak path of ibmveth_poll(),
  new_skb is leaked when ibmveth_rxq_harvest_buffer() fails after the…
- [Low] Reported concern: adapter->replenish_task_cycles++ runs before
  replenish_lock is taken, so concurrent NAPI and netpoll replenish…
- [Low] Reported concern: the frame offset and length supplied by the
  hypervisor are not checked against the RX buffer size before…

--

ibmveth: Add queue-aware RX buffer submit helper for MQ

This patch adds ibmveth_add_logical_lan_buffers() so RX buffer pool
replenishment goes through H_ADD_LOGICAL_LAN_BUFFERS_QUEUE in multi-queue
mode, and gives the RX accessors a queue index. It also adds a per-queue
replenish_lock, moves replenish logging out of the critical section, and
replaces the correlator WARN_ON()s with ibmveth_rxq_correlator_valid().

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index cc01b03d0e4b0..ed75dea90a957 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -904,21 +1005,85 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>  }
>  
>  /* replenish routine */
> -static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
> +static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
> +				   int queue_index)
>  {

[ ... ]

>  	adapter->replenish_task_cycles++;

[Severity: Low]
This isn't a bug introduced by this patch, but
adapter->replenish_task_cycles++ still runs before replenish_lock is
taken. NAPI and ndo_poll_controller() can both call
ibmveth_replenish_task() on the same queue. Can increments of this
counter be lost when they do?

A later patch in the series ("ibmveth: Add per-queue RX and TX statistics
collection") moves the per-queue replenish_task_cycles increment under
the queue's replenish_lock. That means only the intermediate commits are
affected, and only the statistics.

>  
> -	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
> -		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
> +	spin_lock_irqsave(&rxq->replenish_lock, flags);

[Severity: Medium]
This lock is held with hard IRQs off for the whole walk over all
IBMVETH_NUM_BUFF_POOLS pools. For each pool, ibmveth_replenish_buffer_pool()
loops on while (remaining > 0) until the full deficit is filled. That
work includes netdev_alloc_skb(), dma_map_single_attrs(), optional dcbf
flushes, and one hcall per batch.

On the first replenish after open every pool is empty. With the default
active pools (256 + 512 + 256 buffers, batch 8) that comes to roughly
1024 allocations and mappings and about 128 hcalls with IRQs off. Larger
pools set through sysfs, or the fallback to single-buffer hcalls, make
this much longer.

ibmveth_remove_buffer_from_pool() takes the same lock with irqsave from
NAPI, so a concurrent harvest on the same queue would spin with IRQs off
for that whole time.

Before this patch the same work ran in NAPI softirq with IRQs enabled.
Is this IRQ-off latency acceptable, or could the lock be dropped between
batches? The v7 notes list the irqsave section as a leftover, and it
keeps this shape at the end of the series.

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

[Severity: Low]
Can this pool->free_map check race with ibmveth_close()?
ibmveth_close() calls ibmveth_free_buffer_pools() without taking
replenish_lock. Meanwhile ibmveth_poll_controller() ->
ibmveth_replenish_task() can run from netpoll. If that happens,
free_map, skbuff and dma_addr could be freed right after this check
passes.

The last patch in the series ("ibmveth: Complete set_channels down-path
and mq_fallback max_rx cap") closes this window. With it,
ibmveth_poll_controller() returns early when !adapter->opened, and
ibmveth_close() clears opened and calls synchronize_net() before freeing
the pools. Netpoll callers run with IRQs disabled, so that
synchronize_net() waits for them. That guard does not exist yet at this
commit.

> +			rc = ibmveth_replenish_buffer_pool(adapter, pool,
> +							   queue_index, &fail);
> +			switch (rc) {
> +			case IBMVETH_REPLENISH_RESET_MAP:
> +			case IBMVETH_REPLENISH_RESET_MQ:
> +				need_reset = rc;
> +				goto out_unlock;
> +			case IBMVETH_REPLENISH_BATCH_FALLBACK:
> +				batch_fallback = 1;
> +				break;
> +			case IBMVETH_REPLENISH_HCALL_FAIL:
> +				hcall_fail = 1;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
>  	}

[ ... ]

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
> +				     (fail.filled == 1 ?
> +				      "h_add_logical_lan_buffer" :
> +				      "h_add_logical_lan_buffers"),
> +				     fail.filled, fail.lpar_rc, fail.batch);
>  }

[Severity: Low]
Can these two messages print the wrong values? All pools in the loop
share one fail record. The BATCH_FALLBACK and HCALL_FAIL cases only break
out of the switch, so later pools still run. Each hcall failure makes
ibmveth_replenish_buffer_pool() overwrite fail->lpar_rc, fail->filled and
fail->batch.

Say one pool hits BATCH_FALLBACK with batch=8, which sets
rx_buffers_per_hcall to 1, and a later pool then has a hcall failure.
The "Legacy batch add H_FUNCTION (batch=%u), fallback" message would
print batch=1.

In the reverse order, the "RX %s failed" message would show the rc,
filled count and wrapper name of the H_FUNCTION fallback, not those of
the pool that actually failed.

The same structure is still there at the end of the series.

[ ... ]

> @@ -1093,35 +1264,75 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
>  		   adapter->num_rx_queues);
>  }
>  
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
> +	/* Require a live pool with allocated arrays before indexing.
> +	 * Inactive pools still have size from init; free clears skbuff.
> +	 */
> +	if (!bpool->active || !bpool->skbuff || !bpool->free_map)
> +		return false;
> +
> +	return index < bpool->size;
> +}

[Severity: Medium]
This helper, plus the removed WARN_ON()s and the ring advance on a NULL
buffer in ibmveth_poll(), fixes three bugs that exist in the current
tree:

- ibmveth_remove_buffer_from_pool() and ibmveth_rxq_get_buffer() call
  WARN_ON() on a hypervisor-supplied correlator. With panic_on_warn set,
  that takes the partition down.

- In ibmveth_poll(), a valid correlator whose skbuff[index] is NULL used
  to break without advancing the ring and without scheduling a reset.
  The poll tail then calls ibmveth_enable_irq(), sees
  ibmveth_rxq_pending_buffer() still true, calls napi_schedule() and
  jumps to restart_poll. It polls the same slot forever in softirq.

- A correlator that names an inactive pool (pool_active[] =
  {1,1,0,0,1}) passes the old size-only check. skbuff[index] is then
  read through a NULL skbuff array.

These fixes sit inside a patch titled as a multi-queue feature. Neither
this patch nor any later one in the series has a Fixes: tag. Could they
be split out into a separate patch with Fixes: tags, so stable can take
them without the MQ refactor?

[ ... ]

>  static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
> -					   u64 correlator, bool reuse)
> +					   u64 correlator, int queue_index,
> +					   bool reuse)
>  {

[ ... ]

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

[Severity: Medium]
Is dropping schedule_work() from both error exits intended? The commit
message says rxq_get_buffer() still schedules the reset. The
recycle-invalid branch of ibmveth_poll() never calls
ibmveth_rxq_get_buffer(), though:

ibmveth_poll()
  if (!ibmveth_rxq_buffer_valid(adapter, queue_index))
    ibmveth_rxq_harvest_buffer(adapter, queue_index, true)
      ibmveth_remove_buffer_from_pool() returns -EINVAL/-EFAULT
      ibmveth_rxq_advance(rxq)
    break;

So a descriptor without IBMVETH_RXQ_VALID that carries a malformed
correlator is now skipped and no reset is scheduled.

The buffer PHYP actually consumed keeps its skbuff[] entry and its
IBM_VETH_INVALID_MAP free_map slot, and pool->available still counts it.
ibmveth_replenish_task() only refills when available < threshold. Can
repeated events like this leave PHYP short of RX buffers, with nothing
to resync the pool until an unrelated reset or ifdown/up?

The problem is still there at the end of the series.
ibmveth_poll_recycle_invalid() -> ibmveth_poll_harvest_slot() treats
-EINVAL/-EFAULT as handled and does not escalate. Only
ibmveth_poll_skip_bad_correlator(), on the valid-descriptor path, calls
schedule_work().

[ ... ]

> @@ -2168,36 +2392,48 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,

[ ... ]

>  		} else {
>  			struct sk_buff *skb, *new_skb;
> -			int length = ibmveth_rxq_frame_length(adapter);
> -			int offset = ibmveth_rxq_frame_offset(adapter);
> -			int csum_good = ibmveth_rxq_csum_good(adapter);
> -			int lrg_pkt = ibmveth_rxq_large_packet(adapter);
> +			int length = ibmveth_rxq_frame_length(adapter,
> +							      queue_index);
> +			int offset = ibmveth_rxq_frame_offset(adapter,
> +							      queue_index);

[Severity: Low]
This isn't a bug introduced by this patch, but length and offset come
straight from the hypervisor descriptor. Nothing checks them against
the RX buffer size before skb_copy_to_linear_data(),
ibmveth_flush_buffer(), skb_reserve() and skb_put() later in
ibmveth_poll(). Could a bad descriptor cause an out-of-bounds read or
an skb_over_panic()?

A later patch in the series ("ibmveth: Harden RX poll path with
helpers") fixes this. It adds a check in ibmveth_poll_deliver_frame()
against min(skb_tailroom(skb), buff_size) that rejects
off >= room || len > room - off.

[ ... ]

> @@ -2220,12 +2456,18 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  							length);
>  				if (rx_flush)
>  					ibmveth_flush_buffer(skb->data,
> -						length + offset);
> -				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
> +							     length + offset);
> +				rc = ibmveth_rxq_harvest_buffer(adapter,
> +								queue_index,
> +								true);
> +				if (unlikely(rc))
>  					break;
>  				skb = new_skb;

[Severity: Low]
This isn't a bug introduced by this patch, but on this rx_copybreak
path new_skb has already been allocated and filled. If
ibmveth_rxq_harvest_buffer() fails, the break skips it. Does this leak
new_skb?

At this commit the harvest can only fail here if pool state changed
after ibmveth_rxq_get_buffer() succeeded, so the window is small. A
later patch in the series fixes it by calling kfree_skb(new_skb) on the
error path in ibmveth_poll_deliver_frame().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790319558.git.mmc%40linux.ibm.com

