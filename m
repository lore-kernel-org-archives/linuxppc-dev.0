Return-Path: <linuxppc-dev+bounces-25926-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0B4C5DF74
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 01:48:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPCJ64mTKz2xpv;
	Tue, 18 Aug 2026 11:47:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787017654;
	cv=none; b=IO8qidaE4ChEFhjrPHEhKEzwxP4uZ+roHC/1YLibEXX+I+09gb7Hg0X/RTq2Y1AuQyGT9HursdFJUpjzcxWPS8xzFRyIv27bKaAGAwEbwhgbLAtc4qW4gX8cdVwAkx6vt4lTfM358/ZISPIXJTdxRIVEXvFEZYYVW9mIV9qbrpULOi3ClkWfuu5nf7GVsWhxHPoWUUZhpSqb+UWSVAGUntD2syXbe+xsc3RPb9CIPxtEgelYsmqTkSKDIvzwjClI9z4soJdfqxQeONdTPYUgi+yXuueYP2rkrSj+bE0+BKGii9z5mKTV0Av05L+FHN2Cljnz5iF6kjDKsVh7OcHqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787017654; c=relaxed/relaxed;
	bh=xTLpdR/l1UtqG1I9jxTCZVFbbK9cYjOCvGHOP9qAKbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qr6IpgkM8P975CjZTRjehrerygc9zLqXeAKOYGd1aTfvJz9Rma1VXh4ZtzRly+ALuz/m1bzPm64VZmLH0emZRgIOkJ+bSaFJmaz8zm9qlC++9VhpzuqDaFlIk5SAi9XLZkg/h6QL7nlNx0BQj4xDyay52Z7Miy/3QnL70f1yvl9kwMEmFJFp2zwZjZb6IBX+EBT2cxruLF+LVlKPAXI+oQU3HQChkfxFsxaZDNU+HX/hyXUnqIptDlBFHZA+M3qfGkhh53gbnFYq0roqcsTdtqrKGxevu8cOC1MQXwBTCPZBlNdIQtWVbPntNdlvbXfp6t5xSmVaahjPB/K4jHi9DA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YyDkIp5n; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YyDkIp5n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPCJ53Mkdz2yrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:47:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 89484600C8;
	Tue, 18 Aug 2026 01:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4461F00A3A;
	Tue, 18 Aug 2026 01:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017651;
	bh=xTLpdR/l1UtqG1I9jxTCZVFbbK9cYjOCvGHOP9qAKbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YyDkIp5nym7wQs0DK2BLX29uVHOvaSCKF8I0sjmczBQH+rFm1E1sw+nlspsKeh2oj
	 HkY/5xgrgzyGUQFvXhiEH0oj7s0/iIZCfAA61kGidj54OjZ6PWaHpOAZeTIo3KNOqs
	 8SVqiDJulhu2k8H5MtvqNxAysC1GeEkkuPPPWdKciTs4UTEVZ+S+zDqfC6NOSXrzWr
	 8K4LjQn1aYaS0Sbrw55CQ72FhNqnc/i30FBp5ZJP1Fp16sdd6bqG26uGDdtJgkCLYT
	 QIx+7/s/8GpLy8mFCYRJ72glFZbk8nZlFHsec2//4/FeSAfeVOkVn6ZrTAxT5IYo3w
	 tz051yV+NBPpg==
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
Subject: Re: [PATCH net-next v5 09/15] ibmveth: Harden RX poll path with helpers
Date: Mon, 17 Aug 2026 18:47:29 -0700
Message-ID: <20260818014729.3854228-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-10-mmc@linux.ibm.com>
References: <20260814073642.24630-10-mmc@linux.ibm.com>
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
ibmveth: Harden RX poll path with helpers

This splits the inline RX slot handling in ibmveth_poll() into a set of
small helpers (stopping / harvest_slot / recycle_invalid /
skip_bad_correlator / drop_oversize / deliver_frame / bump_invalid) so the
NAPI callback stays a budget loop.  It also moves the reset escalation out
of ibmveth_rxq_get_buffer() into ibmveth_poll_skip_bad_correlator() and
adds stopping checks so close/napi_disable does not re-arm PHYP.

A few questions below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 58a639a962a67..86299c62d4ecf 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1346,10 +1346,8 @@ ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
>  	unsigned int pool = correlator >> 32;
>  	unsigned int index = correlator & 0xffffffffUL;
>  
> -	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
> -		schedule_work(&adapter->work);
> +	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator))
>  		return NULL;
> -	}
>  
>  	return adapter->rx_buff_pool[queue_index][pool].skbuff[index];
>  }
> @@ -2338,125 +2336,230 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
>  	}
>  }
>  
> +static void ibmveth_poll_bump_invalid(struct ibmveth_adapter *adapter,
> +				      int queue_index)
> +{
> +	adapter->rx_invalid_buffer++;
> +}
> +
> +static bool ibmveth_poll_stopping(struct net_device *netdev,
> +				  struct napi_struct *napi)
> +{
> +	return !netif_running(netdev) || napi_disable_pending(napi);
> +}
> +
> +static bool ibmveth_poll_harvest_slot(struct ibmveth_adapter *adapter,
> +				      int queue_index, bool reuse)
> +{
> +	int rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, reuse);
> +
> +	return !rc || rc == -EINVAL || rc == -EFAULT;
> +}
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
> +	ibmveth_poll_bump_invalid(adapter, queue_index);
> +	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
> +}
> +
> +static bool ibmveth_poll_drop_oversize(struct net_device *netdev,
> +				       struct ibmveth_adapter *adapter,
> +				     int queue_index, unsigned int off,
> +				     unsigned int len, unsigned int room)
> +{
> +	if (net_ratelimit())
> +		netdev_err(netdev,
> +			   "RX frame %u+%u exceeds buffer %u on queue %d, dropping\n",
> +			   off, len, room, queue_index);
> +	ibmveth_poll_bump_invalid(adapter, queue_index);
> +	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
> +}

[Severity: Medium]
The changelog describes this as splitting a nested switchyard into helpers,
but a few behaviour changes appear to ride along.  Could they be called out
in the changelog, or split out?

First, ibmveth_poll_bump_invalid() is now called from both
ibmveth_poll_drop_oversize() and ibmveth_poll_skip_bad_correlator(), so the
exported rx_invalid_buffer counter also counts oversize frames and skipped
slots.  Is that intended, and should it be mentioned?

Second, before this patch schedule_work() ran only when
ibmveth_rxq_correlator_valid() failed, and the poll loop simply broke out.
Now ibmveth_poll_skip_bad_correlator() escalates unconditionally, so it also
covers the valid-correlator-with-NULL-skbuff case, which returns -EFAULT
from ibmveth_remove_buffer_from_pool().  ibmveth_reset() does:

	rtnl_lock();

	dev_close(adapter->netdev);
	dev_open(adapter->netdev, NULL);

so does this turn a condition that previously cost one aborted poll into a
full close/open link flap?  The changelog says "skip_bad_correlator owns
reset escalation", which reads as parity, but the escalation scope looks
strictly larger.

Third, the new off/len test in ibmveth_poll_deliver_frame() below appears to
be the first bound check applied to the PHYP-supplied offset and length
before skb_reserve()/skb_put().  Should that carry a Fixes: tag?  As it
stands it is mixed into roughly 190 lines of code motion, which makes it
hard to pick up on its own.

> +
> +/**
> + * ibmveth_poll_deliver_frame - Build SKB from one valid RX slot and GRO it
> + * @napi: NAPI context for this RX queue
> + * @adapter: ibmveth adapter
> + * @netdev: net_device for @adapter
> + * @queue_index: RX queue index
> + *
> + * Return: 1 frame delivered, 0 if the slot was skipped cleanly, -1 on error.
> + */
> +static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
> +				      struct ibmveth_adapter *adapter,
> +				      struct net_device *netdev,
> +				      int queue_index)
> +{
> +	struct sk_buff *skb, *new_skb;
> +	unsigned int room, off, len;
> +	int length, offset, csum_good, lrg_pkt;
> +	__sum16 iph_check = 0;
> +	u16 mss = 0;
> +	int rc;
> +
> +	length = ibmveth_rxq_frame_length(adapter, queue_index);
> +	offset = ibmveth_rxq_frame_offset(adapter, queue_index);
> +	csum_good = ibmveth_rxq_csum_good(adapter, queue_index);
> +	lrg_pkt = ibmveth_rxq_large_packet(adapter, queue_index);
> +
> +	skb = ibmveth_rxq_get_buffer(adapter, queue_index);
> +	if (unlikely(!skb)) {
> +		if (!ibmveth_poll_skip_bad_correlator(netdev, adapter,
> +						      queue_index))
> +			return -1;
> +		return 0;
> +	}
> +
> +	room = skb_tailroom(skb);
> +	off = offset;
> +	len = length;
> +	if (unlikely(off >= room || len > room - off)) {
> +		if (!ibmveth_poll_drop_oversize(netdev, adapter, queue_index,
> +						off, len, room))
> +			return -1;
> +		return 0;
> +	}

[ ... ]

> +	skb_put(skb, length);
> +	skb->protocol = eth_type_trans(skb, netdev);
> +
> +	if (skb->protocol == cpu_to_be16(ETH_P_IP))
> +		iph_check = ip_hdr(skb)->check;
> +
> +	if ((length > netdev->mtu + ETH_HLEN) || lrg_pkt ||
> +	    iph_check == 0xffff) {
> +		ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
> +		adapter->rx_large_packets++;
> +	}

[Severity: High]
Is skb->network_header set for this skb at this point?  The old code read
the checksum through skb->data:

			if (skb->protocol == cpu_to_be16(ETH_P_IP)) {
				struct iphdr *iph = (struct iphdr *)skb->data;

				iph_check = iph->check;
			}

ip_hdr(skb) resolves to skb_network_header(skb), which is
skb->head + skb->network_header, and there is no was-it-set validation.

eth_type_trans() only does skb_reset_mac_header() plus eth_skb_pull_mac(),
and the driver's single skb_reset_network_header() call sits inside
ibmveth_rx_csum_helper(), which runs after this read.  For skbs from
netdev_alloc_skb(), __finalize_skb_around() poisons mac_header and
transport_header to ~0U but leaves network_header at 0.

If that reading is right, ip_hdr(skb) points at skb->head and iph_check
comes out of the uninitialized headroom rather than the received IP header.
Two effects follow:

A PHYP-without-PLSO large-send frame whose IP checksum is 0xffff, whose
length is within mtu + ETH_HLEN, and whose large packet bit is clear is no
longer recognised, so gso_size and gso_segs are never set.

When the stale headroom bytes happen to be 0xffff, ibmveth_rx_mss_helper()
runs on an ordinary frame with lrg_pkt == 0 and takes the offset branch:

	} else if (offset) {
		skb_shinfo(skb)->gso_size = ntohs(tcph->check);
		tcph->check = 0;
	}

which zeroes the real TCP checksum and marks the frame as GSO with a
gso_size taken from that checksum, before napi_gro_receive().

Would keeping (struct iphdr *)skb->data here be better, matching what
ibmveth_rx_mss_helper() and ibmveth_rx_csum_helper() do for the same skb at
the same stage?  This same line is still present in the later patches of the
series.

> +
> +	if (csum_good) {
> +		skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		ibmveth_rx_csum_helper(skb, adapter);
> +	}
> +
> +	napi_gro_receive(napi, skb);
> +
> +	netdev->stats.rx_packets++;
> +	netdev->stats.rx_bytes += length;
> +
> +	return 1;
> +}
> +
>  static int ibmveth_poll(struct napi_struct *napi, int budget)
>  {
>  	struct net_device *netdev = napi->dev;
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>  	int frames_processed = 0;
>  	int queue_index, rc;
> -	u16 mss = 0;
>  
>  	queue_index = napi - adapter->napi;
>  
> +	if (WARN_ON(queue_index < 0 ||
> +		    queue_index >= adapter->num_rx_queues)) {
> +		napi_complete_done(napi, 0);
> +		return 0;
> +	}
> +
> +	if (ibmveth_poll_stopping(netdev, napi)) {
> +		napi_complete_done(napi, 0);
> +		return 0;
> +	}
> +
>  restart_poll:
>  	while (frames_processed < budget) {
> +		if (ibmveth_poll_stopping(netdev, napi))
> +			break;
> +
>  		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
>  			break;
>  
>  		smp_rmb();
>  		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
>  			wmb(); /* suggested by larson1 */
> -			adapter->rx_invalid_buffer++;
> -			netdev_dbg(netdev, "recycling invalid buffer\n");
> -			rc = ibmveth_rxq_harvest_buffer(adapter,
> -							queue_index, true);
> -			if (unlikely(rc))
> +			if (!ibmveth_poll_recycle_invalid(netdev, adapter,
> +							  queue_index))
>  				break;
>  		} else {

[ ... ]

> -			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
> -			if (unlikely(!skb))
> +			rc = ibmveth_poll_deliver_frame(napi, adapter, netdev,
> +							queue_index);
> +			if (rc < 0)
>  				break;

[ ... ]

> -			netdev->stats.rx_packets++;
> -			netdev->stats.rx_bytes += length;
> -			frames_processed++;
> +			if (rc > 0)
> +				frames_processed++;
>  		}
>  	}

[Severity: Medium]
Since skipped slots return 0 and only rc > 0 bumps frames_processed, does
while (frames_processed < budget) still bound the work done in one poll
call?

Where the pre-patch code did:

			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
			if (unlikely(!skb))
				break;

a run of stale or oversize descriptors now walks every pending slot in the
ring while reporting zero work.  rxq_entries is 1 plus the sum of all pool
sizes, so that is on the order of a thousand slots per invocation, with
schedule_work(&adapter->work) called once per skipped slot from
ibmveth_poll_skip_bad_correlator().

The recycle-invalid branch already had this shape before the patch, but this
extends it to the bad-correlator and oversize outcomes and adds the per-slot
schedule_work().

>  
>  	ibmveth_replenish_task(adapter, queue_index);
>  
> +	if (ibmveth_poll_stopping(netdev, napi)) {
> +		napi_complete_done(napi, frames_processed);
> +		/* After complete, must not return budget (NAPI resched). */
> +		if (frames_processed < budget)
> +			return frames_processed;
> +		return budget - 1;
> +	}

[Severity: Medium]
This branch hands frames_processed to napi_complete_done() but returns a
different value to the core.  With budget == 0, frames_processed is 0, so
0 < budget is false and the callback returns -1.

budget == 0 is a real caller value, and ibmveth registers
.ndo_poll_controller:

net/core/netpoll.c:poll_one_napi() {
	work = napi->poll(napi, 0);
	WARN_ONCE(work, "%pS exceeded budget in poll\n", napi->poll);
	trace_napi_poll(napi, work, 0);
}

so a -1 return would trip that WARN_ONCE and record work = -1 in the
tracepoint.

Documentation/networking/napi.rst also states:

   If the ``budget`` is 0 napi_complete_done() should never be called.

which this branch and the two new entry-time paths above (the WARN_ON
queue_index path and the first ibmveth_poll_stopping() path, both calling
napi_complete_done(napi, 0)) do without checking budget.  Would the
documented form fit better here:

	if (budget && napi_complete_done(napi, work_done))
		return min(work_done, budget - 1);

Reaching the -1 case needs ibmveth_poll_stopping() to be false at the entry
check and true after the loop.  netpoll_poll_dev() requires
netif_running(dev), so the flip would come from napi_disable_pending(), which
ibmveth_change_mtu() and veth_pool_store() produce via ibmveth_close() ->
ibmveth_cleanup_rx_interrupts() -> napi_disable() while IFF_UP is still set.

Separately, returning budget - 1 on a full-budget stopping exit under-counts
the work by one frame.  The return budget - 1 is still present in the later
patches of the series.

>  
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
> +	 * resize already masked the queue — late IRQs then hit the handler
> +	 * after num_rx_queues was published lower (lab WARN at interrupt).
>  	 */
> +	if (ibmveth_poll_stopping(netdev, napi))
> +		goto out;
> +
>  	rc = ibmveth_enable_irq(adapter, queue_index);

[Severity: Medium]
This is a pre-existing pattern and not introduced by this patch, since the
baseline calls ibmveth_enable_irq() and ibmveth_rxq_pending_buffer() after
napi_complete_done() with no check at all.  Still, the new check is a
check-then-act on NAPI_STATE_DISABLE and __LINK_STATE_START: once
napi_complete_done() has cleared NAPI_STATE_SCHED, napi_disable() can return
and the close path can proceed while this poll instance is still executing
its tail.

Looking at ibmveth_close(), the synchronize_net() that sits after
ibmveth_cleanup_rx_interrupts() and before ibmveth_free_all_queues():

	ibmveth_cleanup_rx_interrupts(adapter);
	/* Wait for softirq/poll that already passed shutdown checks. */
	synchronize_net();

	ibmveth_update_rx_no_buffer(adapter);
	ibmveth_free_all_queues(adapter);

appears to order the freeing after the in-flight poll, since NAPI polls run
with BH disabled and a BH-disabled region blocks a grace period.  On that
reading the residual effect is a PHYP re-arm on a queue about to be
released, whose interrupt is then discarded by napi_schedule_prep() or
free_irq(), rather than a use-after-free.

Does the comment's claim about the late-IRQ WARN hold as written, or does
the check only narrow the window?

