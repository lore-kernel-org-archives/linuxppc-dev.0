Return-Path: <linuxppc-dev+bounces-26508-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008F9C624D6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 23:39:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbbft4zThz2yv8;
	Fri, 04 Sep 2026 09:39:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788459042;
	cv=none; b=SQRVXNoIDNTaJ2AJ0RecwqFjJyKIeRevOs2AzNzMmiorXgFMPFSim63uuRn6hhwJoa/UZk6saF5lizh9j09Rzqk+tWO32Q9itH0H/DD7QBreSyUAhITgSqBwfyMVDnlTL/4IUAaYqihqNJjeBB+umlYtGAgKndhuguraprjnPZY76uIn7punRwj5c0N4hL4getKgoUIDKu+4AH52g1W3jESOX42k5BPzESQfI6OWG6bvSMgHRGxlip2nhT8Dfo0Ehf1ZioJSevzfJAf8qfEVdhkGlqlyep5sUn1Nus84Vx3bhiQ3defQis/gJDrTZPRs2/tnWEuOhWBttGCjxdGEew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788459042; c=relaxed/relaxed;
	bh=5mQqAgeWoM1C+njl1UNlw27QlPhD+nIGXS/CUAt0YRM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g+TLloaVqMTv+Y8BJ0XRnb/P1gwa+7/qrY+a61tPGtZSFl3Rtz4vWFJpKoD2IyKPGzyJCl+w4wK959r6dQs5OL19mxVKudKvh6zX8v2oImIVvaQ82Z5XYB5RLPkpbSZfungLBsbPsEckxc5rHtuWDvFvjbF0l6KX8wVtvJXrG+Q+LN3eBxIBvBa9NXpZttVpbJTkn7Y53di6Nz6IoY+nHJzE7W+G/jIi1q9jxi7X6MHGsjcYVLk+I4/NSfNL4sDQqTgwtJTuyQYIRVyeAxrU9lAp6Y7umyNddHuW7jhOylkhUUj13fwPpNV+/Pw7mQ8lGfcrj8FIMI/4fPqdVvBiLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FXTI5uDW; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FXTI5uDW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbSM56XSYz2yqx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 04:10:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4995944079;
	Thu,  3 Sep 2026 18:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478D61F00A3D;
	Thu,  3 Sep 2026 18:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459040;
	bh=5mQqAgeWoM1C+njl1UNlw27QlPhD+nIGXS/CUAt0YRM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FXTI5uDWBChezNOYhHr7ncUxY9wmqwwJlXPnNUw4gFSWsKYzKZSSov3KpOKbrW2gL
	 XirBqrs8YTj2Jze9MOJFUFs1mkDCZ7s4hUeTEqhBzVYFNZWW5brehcznlrQJNhp91V
	 6fhGn+arBekabFSOvWZBYoRJb2RJGtrER1IY6ePT5rcAQ4o4lpCT9iAwAAn9qU5UwS
	 MTgjBng0ZSZ8VXP/Rl+6HLnwyfvJezl9Jx62dFSi/VQqctkMRo5Shb9k9fPDzRNnAO
	 gXXUl7aDJYY82tHnJsHK68RjrsgFry/m5iUu5eU+OVqQBrFAKZxK3YIQytYefLBNel
	 XSH1T+bwHBOAw==
Subject: Re: [net-next,v6,09/15] ibmveth: Harden RX poll path with helpers
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Thu, 03 Sep 2026 18:10:38 +0000
Message-ID: <178845903884.3394541.9429373266253586035@kernel.org>
In-Reply-To:
 <2c0302ff17e945a742d0f0b79265ee556e3bf66a.1788102125.git.mmc@linux.ibm.com>
References:
 <2c0302ff17e945a742d0f0b79265ee556e3bf66a.1788102125.git.mmc@linux.ibm.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 2 (1) · Medium: 2 · Low: 0

- [High] The new ibmveth_poll_stopping() check placed between
  napi_complete_done() and ibmveth_enable_irq() cannot prevent a…
- [High] The new oversize guard in ibmveth_poll_deliver_frame() bounds
  the PHYP-reported offset+length against skb_tailroom(skb) instead of…
- [Medium] A real, user-visible sk_buff leak fix is buried inside a
  199-line helper-extraction patch with no Fixes: tag and no Cc: stable.
- [Medium] All 'skip the slot' outcomes (invalid descriptor, bad
  correlator, oversize offset+length) neither increment frames_processed…

Pre-existing issues:
- [High] ibmveth_remove() calls cancel_work_sync(&adapter->work) while
  the netdev is still registered and RX NAPI/IRQ paths are live, then…

--

ibmveth: Harden RX poll path with helpers

This splits the RX slot handling in ibmveth_poll() into a set of small
helpers (poll_stopping, harvest_slot, recycle_invalid, skip_bad_correlator,
drop_oversize, deliver_frame, bump_invalid) so the NAPI callback becomes a
thin budget loop.  Along with the motion it adds an offset+length bounds
check before skb_put(), frees the copybreak skb on a harvest error, and
adds stopping checks so close/napi_disable does not re-arm PHYP delivery.

A few questions below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 46f68f5b52e70..f726d1e3f0b11 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -2382,125 +2380,236 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
>  	}
>  }
>  

[ ... ]

> +static bool ibmveth_poll_harvest_slot(struct ibmveth_adapter *adapter,
> +				      int queue_index, bool reuse)
> +{
> +	int rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, reuse);
> +
> +	return !rc || rc == -EINVAL || rc == -EFAULT;
> +}

[Severity: Medium]
Can this helper ever return false?  ibmveth_rxq_harvest_buffer() documents
and returns only 0, -EINVAL or -EFAULT:

	rc = ibmveth_remove_buffer_from_pool(adapter, cor, queue_index, reuse);
	if (unlikely(rc)) {
		/* Skip a corrupt slot without claiming pool ownership. */
		if (rc == -EINVAL || rc == -EFAULT)
			ibmveth_rxq_advance(rxq);
		return rc;
	}

so every "break" in ibmveth_poll_recycle_invalid(),
ibmveth_poll_skip_bad_correlator() and ibmveth_poll_drop_oversize() looks
unreachable.

Combined with the budget accounting in the loop below, is there anything
left that bounds one ibmveth_poll() invocation?  A skipped slot returns 0
from ibmveth_poll_deliver_frame(), so neither the break nor
frames_processed++ runs:

		rc = ibmveth_poll_deliver_frame(napi, adapter, netdev,
						queue_index);
		if (rc < 0)
			break;
		if (rc > 0)
			frames_processed++;

and each skip recycles the slot with reuse=true, after which
ibmveth_replenish_task() re-posts it.  The tail of ibmveth_poll() then does:

	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
	    napi_schedule(napi)) {
		ibmveth_disable_irq(adapter, queue_index);
		goto restart_poll;
	}

which re-enters the loop in the same invocation with frames_processed
unchanged.  If PHYP keeps publishing skippable slots (stale ring contents,
malformed completions), does the frames_processed == budget exit ever
become reachable, and does this poll ever return?

The reset escalation in ibmveth_poll_skip_bad_correlator() uses
schedule_work(), which queues on the current CPU via system_percpu_wq, so
would the worker be able to run while that CPU is stuck in the poll?  The
ibmveth_poll_drop_oversize() path escalates nothing at all.

The commit message states:

    Skipped and dropped slots do not count against the NAPI budget; only
    a delivered frame does.

Is that intentional given it removes the only bound on the loop?

> +
> +static bool ibmveth_poll_recycle_invalid(struct net_device *netdev,
> +					 struct ibmveth_adapter *adapter,
> +					 int queue_index)
> +{
> +	netdev_dbg(netdev, "recycling invalid buffer\n");
> +	ibmveth_poll_bump_invalid(adapter, queue_index);
> +	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
> +}
> +
> +static bool ibmveth_poll_skip_bad_correlator(struct net_device *netdev,
> +					     struct ibmveth_adapter *adapter,
> +					     int queue_index)
> +{
> +	if (net_ratelimit())
> +		netdev_err(netdev,
> +			   "bad correlator on queue %d, skipping slot\n",
> +			   queue_index);
> +	/* Residual stale slot after resize: recover via reset rather
> +	 * than spinning forever. Always escalate; only the log is
> +	 * rate-limited.
> +	 */
> +	schedule_work(&adapter->work);

[Severity: High]
This isn't a bug introduced by this patch, but this adds another NAPI-side
producer of adapter->work while ibmveth_remove() still cancels that work
before the device is quiesced:

	cancel_work_sync(&adapter->work);

	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
		kobject_put(&adapter->rx_buff_pool[0][i].kobj);

	unregister_netdev(netdev);

	free_netdev(netdev);

Can a poll running on another CPU call schedule_work(&adapter->work) from
here (or from the ibmveth_enable_irq() failure path in ibmveth_poll())
after cancel_work_sync() has returned?  Nothing cancels or flushes it
again, and adapter is netdev_priv(netdev), so the queued work_struct and
everything ibmveth_reset() touches would be freed by free_netdev().

For the record, the ordering appears to be repaired later in this series:
at the series tip ibmveth_remove() moves the cancellation after
unregister_netdev(), with a comment that cancel_work_sync() before
unregister left a window where poll could schedule_work() and the worker
ran after free_netdev().

> +	ibmveth_poll_bump_invalid(adapter, queue_index);
> +	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
> +}
> +

[ ... ]

> +static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
> +				      struct ibmveth_adapter *adapter,
> +				      struct net_device *netdev,
> +				      int queue_index)
> +{

[ ... ]

> +	room = skb_tailroom(skb);
> +	off = offset;
> +	len = length;
> +	if (unlikely(off >= room || len > room - off)) {
> +		if (!ibmveth_poll_drop_oversize(netdev, adapter, queue_index,
> +						off, len, room))
> +			return -1;
> +		return 0;
> +	}

[Severity: High]
Should the bound here be pool->buff_size rather than skb_tailroom(skb)?

ibmveth_replenish_buffer_pool() allocates, maps and advertises exactly
pool->buff_size to the hypervisor:

	skb = netdev_alloc_skb(adapter->netdev, pool->buff_size);
	...
	dma_addr = dma_map_single_attrs(dev, skb->data, pool->buff_size,
					DMA_FROM_DEVICE, DMA_ATTR_NO_WARN);
	...
	descs[filled].fields.flags_len = IBMVETH_BUF_VALID | pool->buff_size;

netdev_alloc_skb() rounds up to an allocator bucket, so skb_tailroom() on
an untouched pool buffer is larger than buff_size (a 16 KiB pool buffer
lands in a 32 KiB allocation).  Does a PHYP-reported off+len in the
(buff_size, tailroom] gap pass this check and then get committed and
delivered?

	skb_put(skb, length);
	skb->protocol = eth_type_trans(skb, netdev);
	...
	napi_gro_receive(napi, skb);

That would hand uninitialised slab bytes outside the DMA mapping to the
stack, and on the copybreak path skb_copy_to_linear_data() plus
ibmveth_flush_buffer(skb->data, length + offset) would touch addresses
past the mapped window.  The commit message says deliver "rejects a PHYP
offset+length that would skb_put() past the buffer" - is the buffer here
meant to be the hardware-visible one?  The correlator has already been
validated by ibmveth_rxq_correlator_valid(), so
adapter->rx_buff_pool[queue_index][correlator >> 32].buff_size is
available as the bound.

> +
> +	if (lrg_pkt) {
> +		__be64 *rxmss = (__be64 *)(skb->data + 8);
> +
> +		mss = (u16)be64_to_cpu(*rxmss);
> +	}
> +
> +	new_skb = NULL;
> +	if (length < rx_copybreak)
> +		new_skb = netdev_alloc_skb(netdev, length);
> +
> +	if (new_skb) {
> +		skb_copy_to_linear_data(new_skb, skb->data + offset, length);
> +		if (rx_flush)
> +			ibmveth_flush_buffer(skb->data, length + offset);
> +		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
> +		if (unlikely(rc)) {
> +			kfree_skb(new_skb);
> +			return -1;
> +		}

[Severity: Medium]
This kfree_skb(new_skb) is a real fix for an sk_buff leak that exists at
the baseline in ibmveth_poll():

	new_skb = netdev_alloc_skb(netdev, length);
	...
	skb_copy_to_linear_data(new_skb, skb->data + offset, length);
	...
	if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
		break;   /* new_skb is neither freed nor handed to the stack */

Could this be split into its own patch with a Fixes: tag (and Cc: stable)
so it can be routed to net and picked up by older trees?  Buried in a
199-insertion helper extraction it is not separable for backporting.  The
same applies to the new offset+length validation, which the commit message
describes as preventing an skb_put() past the buffer.

> +		skb = new_skb;
> +	} else {
> +		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, false);
> +		if (unlikely(rc))
> +			return -1;
> +		skb_reserve(skb, offset);
> +	}

[ ... ]

> +	return 1;
> +}
> +
>  static int ibmveth_poll(struct napi_struct *napi, int budget)
>  {

[ ... ]

>  	if (frames_processed == budget)
>  		goto out;
>  
>  	if (!napi_complete_done(napi, frames_processed))
>  		goto out;
>  
> -	/* We think we are done - reenable interrupts,
> -	 * then check once more to make sure we are done.
> +	/*
> +	 * napi_disable() sets DISABLE then waits for this poll. Without a
> +	 * second stopping check here, enable_irq() can re-arm PHYP after
> +	 * resize already masked the queue; late IRQs then hit the handler
> +	 * after num_rx_queues was published lower (lab WARN at interrupt).
>  	 */
> +	if (ibmveth_poll_stopping(netdev, napi))
> +		goto out;
> +
>  	rc = ibmveth_enable_irq(adapter, queue_index);

[Severity: High]
Does this check actually close the window it describes?  It is a
check-then-act pair, and both predicates in ibmveth_poll_stopping() go
false exactly when teardown is finishing:

	return !netif_running(netdev) || napi_disable_pending(napi);

napi_disable_locked() clears the DISABLE bit before returning:

	clear_bit(NAPI_STATE_DISABLE, &n->state);

so napi_disable_pending() is false once close is past its wait.  And
netif_running() stays true for the driver's internal close callers -
ibmveth_change_mtu(), ibmveth_set_mac_addr(), the features paths and
veth_pool_store() all do "if (netif_running(dev)) ibmveth_close(dev);".

Sequence:

CPU0 ibmveth_poll()
	napi_complete_done()		/* clears SCHED */
					/* delayed: hard IRQ, or vCPU
					   dispatch preemption on a
					   shared-processor LPAR */

CPU1 ibmveth_change_mtu() -> ibmveth_close() -> ibmveth_cleanup_rx_interrupts()
	napi_disable()			/* clears DISABLE on return */
	ibmveth_disable_irq(adapter, i);
	synchronize_irq(adapter->queue_irq[i]);
	free_irq(...)

CPU0 resumes:
	if (ibmveth_poll_stopping(netdev, napi))	/* false */
		goto out;
	rc = ibmveth_enable_irq(adapter, queue_index);	/* re-arms PHYP */

Can the queue end up unmasked after the final remask and after free_irq()
removed the handler?  That is the case the commit message claims to close:

    ibmveth_poll_stopping() ensures close/napi_disable does not re-arm PHYP.

Would moving the unmask before napi_complete_done(), or moving close's
final remask after synchronize_net(), be a more reliable ordering than
adding another check here?  This looks unchanged at the series tip.

>  	if (rc) {
>  		netdev_err(netdev,

Thanks for looking at these.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788102125.git.mmc%40linux.ibm.com

