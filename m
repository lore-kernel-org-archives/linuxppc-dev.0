Return-Path: <linuxppc-dev+bounces-25526-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E022C56205
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 18:38:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGGGp6lCgz3cG0;
	Fri, 07 Aug 2026 04:37:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786041442;
	cv=none; b=RfII9eNbrjdrM7gxMUSIUdEJxY0HKUOsFhtCLo8+L5q1fgjwqJMLivQIOrr8SKrF6PjbCwnHhOugqkhrHEuvb145bboDgVYBic+6ePb9wSMU2QiXnX042Qr8yl0mpOZ2708eQNmRC/75JgNzTmn22+oICBo2ttOmwRhsmMand0n68UjrMyS+BCw6ZiM+X76dc7Wmwf8ko9Q1vLpF7q4Y2BWRFCrwKnSnGN+t5LPj7Bti7y7+xCBPJSFSLrkNHq6ZLdw9aDOUYooQW5nAZooMMhSVUW441AyaheikhsuS+s//RF31m5Sn+bPt8g99gs3GVNFWJ/oFJHETrKzXDDkFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786041442; c=relaxed/relaxed;
	bh=CcfGVUdCTlU178dtUa1uXlDvnR7tT80EsHLccxBq3S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPiDCfRofcfSGPZV7k1ujs25EpcJJzblXTJbMXc8romtDWq7FvIOKGHN+Baa8Z+pfJOshkwcQ2udqdz4A2RcLPR4XxukkxoB5fbPikGJrvCtDr1/2rNyuPrZTZJZRBFcaeiNhbbm0HPCTINdd/EGrAeObZ1rGD9t/wGL0dnzy9YCm7UlB+PdxmbcXRvQWYLimz4m1j5Q/RJOWGnrrG9XrJAC51525gXXm3iY2MVXlHqE4rbReAU2I8uI2IREfwEazAHs031+oEEd9vDJ+f8dpQl+NLg+rq24j2SquLwv81izq2oCBRjTMdW4xwmcS1pUpCRWTqa/81cFx+hiOX+0tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLTXSg2q; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLTXSg2q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGGGk0Kqlz3c7S
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 04:37:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5AD2342E9E;
	Thu,  6 Aug 2026 18:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92CD1F00A3A;
	Thu,  6 Aug 2026 18:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041435;
	bh=CcfGVUdCTlU178dtUa1uXlDvnR7tT80EsHLccxBq3S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hLTXSg2qZAbWhIlCQc+RUIAYB7nvoQ+TgA/1briRLdxfjSwndau/q7iyQY+it2NMl
	 QIk39Iytwxte4SxkWjq05rpN9IUSAkpeD7ajjuIbi0CafFoOVl3mrs0iNLfIqntLsm
	 4O0VdNQV4x1EJmQZjriSb7uO4iBuYlWjFtNVJFl5PuL1Okyf6Xc90LImVNUXvhJ2Fg
	 5J0yKnjrqVTPgtmOFFDYpL2kExD543uAZe1qYYqhLSOc8R+4euodfy2v7xVCqlZ1jZ
	 nzXszENKp4UrdxvI0xRshGMQLYkeQpiIaC+CViq3SPcbF4k4G0W6YrJfuchnPdszT2
	 nUVSmCbKpmjJg==
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
Subject: Re: [PATCH net-next v4 14/14] ibmveth: Fix MQ RX poll and shutdown hangs after queue resize
Date: Thu,  6 Aug 2026 11:37:14 -0700
Message-ID: <20260806183714.3176012-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6c687fce21930e4ded39610717ac05862b67e7aa.1785457143.git.mmc@linux.ibm.com>
References: <6c687fce21930e4ded39610717ac05862b67e7aa.1785457143.git.mmc@linux.ibm.com>
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
ibmveth: Fix MQ RX poll and shutdown hangs after queue resize

This changes ibmveth_poll() to skip RX slots whose correlator cannot be
mapped to a buffer pool instead of retrying them forever, completes NAPI
when the interface is going down, and adds a descriptor length check
before skb_put().  The WARN_ON plus adapter reset escalation in the
correlator validation paths is replaced by a rate-limited message.

No Link: tags present in the commit header.

A few questions below.

[Severity: Low]
Would it make sense to split this into separate patches with individual
Fixes: tags?  There appear to be four independent changes here:

  - skipping bad RX correlators and dropping the WARN_ON/reset escalation
  - completing NAPI when the interface is down or napi_disable is pending
  - validating the descriptor length against skb tailroom before skb_put()
  - changing the return value on the budget-exhausted shutdown path

There is no Fixes: tag, so stable maintainers cannot pick up the hang fix
without also picking up the policy change that removes the reset based
recovery, and the skb_put() hardening is not visible as a fix on its own.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index c99d8e8be7b37..09e06d86701a5 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1376,6 +1376,24 @@ ibmveth_free_single_rx_queue(struct ibmveth_adapter *adapter, int queue_idx)
>  	netdev_dbg(adapter->netdev, "Freed queue %d resources\n", queue_idx);
>  }
>  
> +static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
> +					 int queue_index, u64 correlator)
> +{
> +	unsigned int pool = correlator >> 32;
> +	unsigned int index = correlator & 0xffffffffUL;
> +
> +	return pool < IBMVETH_NUM_BUFF_POOLS &&
> +	       index < adapter->rx_buff_pool[queue_index][pool].size;
> +}

[Severity: High]
This isn't a bug introduced by this patch, since the pre-existing WARN_ON
checks were also bounds-only, but can a correlator naming an inactive or
already freed pool still pass ibmveth_rxq_correlator_valid() and then
dereference a NULL array?

ibmveth_init_buffer_pool() sets pool->size for all pools regardless of
active state, while ibmveth_alloc_queue_buffer_pools() skips inactive
pools, and ibmveth_free_buffer_pool() clears the arrays without clearing
size or active:

	kfree(pool->free_map);
	pool->free_map = NULL;
	...
	if (pool->skbuff) {
		kfree(pool->skbuff);
		pool->skbuff = NULL;
	}

With the defaults in ibmveth.h:

	static int pool_count[] = { 256, 512, 256, 256, 256 };
	static int pool_active[] = { 1, 1, 0, 0, 0};

a correlator of pool=2, index=0 satisfies both conditions of the new
helper, and both users then index a NULL pointer before the !skb test can
help:

	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];

and

	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];

Should the helper also require pool->active and non-NULL skbuff/dma_addr/
free_map, or should ibmveth_free_buffer_pool() clear pool->size?  The same
window seems to apply to pools torn down by ethtool -L scale-down, an MTU
change, or sysfs deactivation.

[Severity: Low]
This is a pre-existing weakness rather than something new here, but the
helper only bounds-checks, so a stale correlator that happens to land in
range after an ethtool -L resize is treated as a live frame.  With
reuse=false the buffer can be handed to the stack while the hypervisor may
still own it, and with reuse=true the index is pushed onto free_map a
second time.  Is there any generation counter or per-queue tag available in
the correlator that could distinguish a stale descriptor from a current
one?

> +
> +static void ibmveth_rxq_advance(struct ibmveth_rx_q *rxq)
> +{
> +	if (++rxq->index == rxq->num_slots) {
> +		rxq->index = 0;
> +		rxq->toggle = !rxq->toggle;
> +	}
> +}
> +
>  /**
>   * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
>   * @adapter: adapter instance
> @@ -1397,17 +1415,12 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
>  	unsigned int free_index;
>  	struct sk_buff *skb;
>  
> -	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
> -	    WARN_ON(index >= adapter->rx_buff_pool[queue_index][pool].size)) {
> -		schedule_work(&adapter->work);
> +	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
>  		return -EINVAL;
> -	}
>  
>  	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
> -	if (WARN_ON(!skb)) {
> -		schedule_work(&adapter->work);
> +	if (!skb)
>  		return -EFAULT;
> -	}

[Severity: Medium]
The schedule_work(&adapter->work) escalation is dropped here and in
ibmveth_rxq_get_buffer(), so nothing bounds the condition any more.  The
commit message describes the new skip policy but does not mention that all
recovery escalation is gone.

The previous reset performed a close/open cycle, which issued
h_free_logical_lan and re-registered the logical LAN, flushing every buffer
registration the hypervisor still held.  If the bad correlator exists
because PHYP still holds buffers from a pool that
ibmveth_free_buffer_pool() already unmapped and freed during an
ethtool -L resize:

	dma_unmap_single(&adapter->vdev->dev, pool->dma_addr[i],
			 pool->buff_size, DMA_FROM_DEVICE);
	dev_kfree_skb_any(skb);

can the hypervisor keep writing into those freed pages indefinitely now
that the driver only logs and advances?

Separately, this also folds together two different classes: -EINVAL for an
out-of-range correlator, and -EFAULT where pool and index are in range but
skbuff[index] is NULL, which indicates driver/hypervisor state desync.  Is
silently skipping the -EFAULT case intended?

And if the descriptor's correlator belongs to a different queue's pool, the
skip never reclaims that queue's slot, so that pool's available count stays
inflated and ibmveth_replenish_task() stops replenishing it:

	if (pool->active && pool->free_map &&
	    (atomic_read(&pool->available) < pool->threshold))

>  
>  	/* if we are going to reuse the buffer then keep the pointers around
>  	 * but mark index as available. replenish will see the skb pointer and
> @@ -1452,11 +1465,8 @@ ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
>  	unsigned int pool = correlator >> 32;
>  	unsigned int index = correlator & 0xffffffffUL;
>  
> -	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
> -	    WARN_ON(index >= adapter->rx_buff_pool[queue_index][pool].size)) {
> -		schedule_work(&adapter->work);
> +	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
>  		return NULL;
> -	}
>  
>  	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];
>  }
> @@ -1483,14 +1493,15 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>  
>  	cor = rxq->queue_addr[rxq->index].correlator;
>  	rc = ibmveth_remove_buffer_from_pool(adapter, cor, queue_index, reuse);
> -	if (unlikely(rc))
> +	if (unlikely(rc)) {
> +		if (rc == -EINVAL || rc == -EFAULT)
> +			goto advance;
>  		return rc;
> -
> -	if (++rxq->index == rxq->num_slots) {
> -		rxq->index = 0;
> -		rxq->toggle = !rxq->toggle;
>  	}
>  
> +advance:
> +	ibmveth_rxq_advance(rxq);
> +
>  	return 0;
>  }

[Severity: Low]
Can ibmveth_rxq_harvest_buffer() still return non-zero after this change?
ibmveth_remove_buffer_from_pool() has exactly three returns: -EINVAL,
-EFAULT and 0, and both error codes now go to the advance label, so
"return rc;" looks unreachable.

That would make all five "if (unlikely(rc)) break;" checks in
ibmveth_poll(), including the two added by this patch, dead code, along
with the harvest failure path in ibmveth_drain_rx_queue():

	rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
	if (rc) {
		netdev_err(netdev,
			   "Failed to harvest buffer from queue %d during drain: %d\n",
			   queue_index, rc);
		break;
	}
	drained++;

Should unmappable slots encountered during drain still be counted as
drained++ with no diagnostic?  The kernel-doc above harvest still documents
"other - non-zero return from ibmveth_remove_buffer_from_pool", which no
longer matches the implementation.

>  
> @@ -3092,11 +3103,19 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  	if (WARN_ON(queue_index < 0 || queue_index >= adapter->num_rx_queues))
>  		return 0;
>  
> +	if (!netif_running(netdev) || napi_disable_pending(napi)) {
> +		napi_complete_done(napi, 0);
> +		return 0;
> +	}
> +
>  	if (adapter->rx_qstats)
>  		adapter->rx_qstats[queue_index].polls++;
>  
>  restart_poll:
>  	while (frames_processed < budget) {
> +		if (!netif_running(netdev) || napi_disable_pending(napi))
> +			break;
> +
>  		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
>  			break;
>  

[ ... ]

> @@ -3126,8 +3145,45 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  			__sum16 iph_check = 0;
>  
>  			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
> -			if (unlikely(!skb))
> -				break;
> +			if (unlikely(!skb)) {
> +				if (net_ratelimit())
> +					netdev_err(netdev,
> +						   "bad correlator on queue %d, skipping slot\n",
> +						   queue_index);

[ ... ]

> +
> +			if (unlikely((unsigned int)offset +
> +				     (unsigned int)length >
> +				     skb_tailroom(skb))) {

[Severity: High]
This is not a regression from this patch, since there was no length check
at all before, but can this check be bypassed by 32-bit wraparound?

Both operands are cast to unsigned int, so the sum is modulo 2^32.  Unlike
offset, length is not masked; ibmveth_rxq_frame_length() returns the whole
descriptor field:

	return be32_to_cpu(rxq->queue_addr[rxq->index].length);

and in ibmveth.h that field is a full __be32 written by the hypervisor,
while only offset gets IBMVETH_RXQ_OFF_MASK (0x0000FFFF).

For a corrupted length like 0xFFFFFFF0 with a small offset, the addition
wraps to a small value and the guard does not fire.  The copybreak test
compares against "static unsigned int rx_copybreak", so 0xFFFFFFF0 is not
less than rx_copybreak and no copy skb is allocated, and execution reaches:

	skb_put(skb, length);

which trips skb_over_panic() -> BUG().  Would an overflow-safe form work
better here, for example:

	if (offset > tailroom || length > tailroom - offset)

or validating length against pool->buff_size?

[ ... ]

> @@ -3206,8 +3262,14 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  
>  	ibmveth_replenish_task(adapter, queue_index);
>  
> -	if (frames_processed == budget)
> +	if (frames_processed == budget) {
> +		if (!netif_running(netdev) || napi_disable_pending(napi)) {
> +			napi_complete_done(napi, frames_processed);
> +			/* After complete_done, must not return full budget. */
> +			return frames_processed ? frames_processed - 1 : 0;
> +		}
>  		goto out;
> +	}
>  
>  	if (!napi_complete_done(napi, frames_processed))
>  		goto out;
> @@ -3225,6 +3287,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  	}
>  
>  	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
> +	    netif_running(netdev) &&
> +	    !napi_disable_pending(napi) &&
>  	    napi_schedule(napi)) {
>  		lpar_rc = ibmveth_disable_irq(adapter, queue_index);
>  		WARN_ON(lpar_rc != H_SUCCESS);

[Severity: High]
This isn't a bug introduced by this patch, as the
napi_complete_done() -> ibmveth_enable_irq() -> ibmveth_rxq_pending_buffer()
sequence is unchanged, but do the new guards actually close the shutdown
window the commit message describes?

The new mid-loop break also lands here with frames_processed < budget, so
the quiesce case still reaches:

	if (!napi_complete_done(napi, frames_processed))
		goto out;

Clearing NAPI_STATE_SCHED there is what napi_disable() waits for, so
ibmveth_close() can proceed past ibmveth_cleanup_rx_interrupts() into
ibmveth_cleanup_rx_resources():

	if (adapter->rx_queue[i].queue_addr) {
		dma_free_coherent(dev, adapter->rx_queue[i].queue_len,
				  adapter->rx_queue[i].queue_addr,
				  adapter->rx_queue[i].queue_dma);
		adapter->rx_queue[i].queue_addr = NULL;

while the still running poll executes:

	lpar_rc = ibmveth_enable_irq(adapter, queue_index);

re-arming the PHYP interrupt that close just masked, and then evaluates
ibmveth_rxq_pending_buffer(), which reads
rxq->queue_addr[rxq->index].flags_off - a NULL dereference or a read of
freed coherent memory.  ibmveth_close() has no synchronize_net() between
napi_disable()/free_irq() and the frees, unlike the scale-down path.

Note the new netif_running()/napi_disable_pending() terms are evaluated
after ibmveth_rxq_pending_buffer() in the same condition, so they cannot
prevent that access; they only suppress the following
ibmveth_disable_irq().

Related question on that suppression: in the window where
__LINK_STATE_START is already cleared by __dev_close_many() but
NAPI_STATE_DISABLE is not yet set, the pre-patch code re-masked PHYP via
the napi_schedule() branch.  With the new guards, poll now returns leaving
delivery unmasked into the napi_disable()/free_irq() window, and the
interrupt handler does not mask either when napi_schedule_prep() fails:

	if (napi_schedule_prep(napi)) {
		lpar_rc = ibmveth_disable_irq(adapter, qindex);
		WARN_ON(lpar_rc != H_SUCCESS);
		__napi_schedule(napi);
	}

Can that leave the queue interrupt storming until free_irq()?

[ ... ]

