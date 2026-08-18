Return-Path: <linuxppc-dev+bounces-25923-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B021C5DF74
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 01:48:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPCJ12ddrz2yl1;
	Tue, 18 Aug 2026 11:47:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787017649;
	cv=none; b=e3eNx3heGr9GYby/uJU1qcVAnAkCcdcqnFUfLzmNWLfkict16pPwicEMPWRdY1FMviHpeNixhtkj6lyjOzX8G0JOEWybclqM7EvI7CDqXfu1EotRzY43YbnxTQMrrwSosrUGbPKJNJB+nL17j4QUz2tG1avakT2/XbUOVpelfgiTFnQT5Ich88GKYr/oC727eTP7lsJjKUFZbfb2WTdZFq6VJ2vfmHFaTEXrPoCEfczn37PD2/S53ozZxEAxziDJo8tp8WKpPdPKvwX0i8mljKGaMI7WvZtLiclbYlT3Ynt2EN1gVIeM/cfNi1/CO4TAz0S/N3X/COmwvhyaURxVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787017649; c=relaxed/relaxed;
	bh=XdRoyahfxngH+Wmqfv4fk5SrfAawGFTVSypyi858am4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B28Jo4AxCRSw86cqSv9mzNkh0ZA2KnO93j24250P2+3qCHP5nB3kHWq/6DZq4p1n949WGg5RR6IyCodpaWXmgk/ghhGS3Vhi9bfHCpxySDGh5doTyZ6SUfcHmELkQmsDjivP6p7kcN9u3P3gSg1mn+D32z8o8z+JKbtEfc7sQxywfIccYgJgIQegA93vXavyCjmykWkcfXERVBJku1YThlkePmUO4JFXjvRCjzRSXdcSxC36TavVLOg7hJAOQ8UVIK9LBPW89cNr6f3Vq0YZ7gdlAyp+uVQvoBujzkGCoX4HtOSTQA4WWgse6jN5B7kFRATazVYpITIM6t2jqBM/Iw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtSJLClb; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtSJLClb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPCJ01SCkz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:47:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3FFD8601E9;
	Tue, 18 Aug 2026 01:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA5A1F000E9;
	Tue, 18 Aug 2026 01:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017646;
	bh=XdRoyahfxngH+Wmqfv4fk5SrfAawGFTVSypyi858am4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dtSJLClbsVTXZ3X6NEjjlejLI7QbM2n7j4L5AtZGyJ1Vfz9EFkjo6I4kSAQUUNLT3
	 TN3ZQ/LgsFo4GzqH8+6+vmp0jWm3nc7Ai48Yg2637w4NTRvuuwjj5aQPfbQl3pRJ+o
	 yFOfnD6LR3p53dYz13yYavP7J0/0nAet7UZLKP88GE87xVr4Ht6BBY9e8L8FVb6qm2
	 1XZI56wXhlSLnhCqpqUC1yo/GGqxQVrHoFlmUBfTYKTnBVG5vOA8kh+NLa7cWX+ZS5
	 mLuslc3jAr2XOX3+Z8Ox4t3qwXZ/+hKZwbQVkLhFxA0iG/ay66sN29YpwJjK5e4p41
	 TGV0VKthOD61Q==
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
Subject: Re: [PATCH net-next v5 06/15] ibmveth: Refactor TX resource allocation in open/close paths
Date: Mon, 17 Aug 2026 18:47:24 -0700
Message-ID: <20260818014724.3854085-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-7-mmc@linux.ibm.com>
References: <20260814073642.24630-7-mmc@linux.ibm.com>
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
ibmveth: Refactor TX resource allocation in open/close paths

This moves the per-queue TX long term buffer alloc/free loops out of
ibmveth_open()/ibmveth_close() into ibmveth_alloc_tx_resources() and
ibmveth_free_tx_resources(), moves the TX allocation to the end of open()
after RX is live, and adds a tx_ltb_ptr[] presence check to
ibmveth_start_xmit().  No Link: tags are present in the commit header.

A few questions on the LTB lifetime rules the patch establishes.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 99eeb6ef51bf3..b39e8c53cbfd1 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1183,8 +1183,12 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>  
>  static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>  {
> +	if (!adapter->tx_ltb_ptr[idx])
> +		return;
> +
>  	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
>  			 adapter->tx_ltb_size, DMA_TO_DEVICE);
> +	adapter->tx_ltb_dma[idx] = 0;
>  	kfree(adapter->tx_ltb_ptr[idx]);
>  	adapter->tx_ltb_ptr[idx] = NULL;
>  }

[Severity: Medium]
tx_ltb_ptr[] now doubles as the guard for tx_ltb_dma[], but the retire
order here clears the guarded value first:

	dma_unmap_single(...);
	adapter->tx_ltb_dma[idx] = 0;
	kfree(adapter->tx_ltb_ptr[idx]);
	adapter->tx_ltb_ptr[idx] = NULL;

Can an ibmveth_start_xmit() that already passed the new check

	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {

then reach

	desc.fields.address = adapter->tx_ltb_dma[queue_num];

and hand a zeroed DMA address to H_SEND_LOGICAL_LAN?

The publish side has the mirror-image order: ibmveth_allocate_tx_ltb()
stores tx_ltb_ptr[idx] from kzalloc() before tx_ltb_dma[idx] is filled in
by dma_map_single(), with no release/acquire pairing.

Both the check in ibmveth_start_xmit() and its later uses (the memcpy into
tx_ltb_ptr[queue_num] and the descriptor address read) are plain loads with
no READ_ONCE and no common lock, so nothing prevents a reload of
tx_ltb_ptr[queue_num] after it was set to NULL.

Against ibmveth_close() this appears harmless, since ibmveth does not set
lltx and netif_tx_disable() therefore takes every __netif_tx_lock.  Against
ibmveth_set_channels() (more below) there is no such serialization.  Would a
real lock, or gating on adapter->opened, express this better than a pointer
used as a flag?

> @@ -1207,12 +1211,54 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>  			   "unable to DMA map tx long term buffer\n");
>  		kfree(adapter->tx_ltb_ptr[idx]);
>  		adapter->tx_ltb_ptr[idx] = NULL;
> +		adapter->tx_ltb_dma[idx] = 0;
>  		return -ENOMEM;
>  	}
>  
>  	return 0;
>  }
>  
> +/**
> + * ibmveth_alloc_tx_resources - Allocate TX resources for all queues
> + * @adapter: ibmveth adapter structure
> + *
> + * Allocates TX Long Term Buffers (LTBs) for all TX queues.
> + *
> + * Return: 0 on success, -ENOMEM on failure
> + */
> +static int ibmveth_alloc_tx_resources(struct ibmveth_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	int i;
> +
> +	for (i = 0; i < netdev->real_num_tx_queues; i++) {
> +		if (ibmveth_allocate_tx_ltb(adapter, i))
> +			goto err_free_ltbs;
> +	}

[Severity: Low]
This isn't a bug introduced by this patch, and it looks unreachable by the
end of the series, but noting it for traceability: ibmveth_allocate_tx_ltb()
assigns the kzalloc() and dma_map_single() results straight into
tx_ltb_ptr[i] / tx_ltb_dma[i] with no check for an already-populated slot,
unlike ibmveth_set_channels() which does

	if (adapter->tx_ltb_ptr[i])
		continue;

so a caller reaching this helper with a live mapping in the slot would
strand the old TCE mapping.  With the later set_channels rewrite in this
series the !adapter->opened branch allocates nothing and the opened branch
frees everything it allocated on failure, so no path leaves tx_ltb_ptr[]
populated while adapter->opened is false and open() cannot overwrite a live
mapping.  Would a defensive check (or a comment stating the invariant) be
worth it here?

> +
> +	return 0;
> +
> +err_free_ltbs:
> +	while (--i >= 0)
> +		ibmveth_free_tx_ltb(adapter, i);
> +	return -ENOMEM;
> +}
> +
> +/**
> + * ibmveth_free_tx_resources - Free TX resources for all queues
> + * @adapter: ibmveth adapter structure
> + *
> + * Frees TX Long Term Buffers (LTBs) for all TX queues.
> + */
> +static void ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	int i;
> +
> +	for (i = 0; i < netdev->real_num_tx_queues; i++)
> +		ibmveth_free_tx_ltb(adapter, i);
> +}

[Severity: Low]
Small wording mismatch: the kernel-doc says "Frees TX Long Term Buffers
(LTBs) for all TX queues", but the loop is bounded by real_num_tx_queues
while tx_ltb_ptr[] is IBMVETH_MAX_QUEUES wide.  Since ibmveth_free_tx_ltb()
is now NULL-safe, either iterating IBMVETH_MAX_QUEUES or saying
"real_num_tx_queues" in the comment would make the two agree.

> @@ -1263,12 +1309,6 @@ static int ibmveth_open(struct net_device *netdev)

[ ... ]

>  	rc = ibmveth_alloc_buffer_pools(adapter);
>  	if (rc)
> -		goto out_free_tx_ltb;
> +		goto out_unregister_lan;
>  
>  	rc = ibmveth_setup_rx_interrupts(adapter);
> -	if (rc) {
> -		do {
> -			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> -		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> -		goto out_free_buffer_pools;
> -	}
> +	if (rc)
> +		goto out_unregister_lan;

[ ... ]

> -out_free_buffer_pools:
> +out_cleanup_rx_interrupts:
> +	ibmveth_cleanup_rx_interrupts(adapter);
> +out_unregister_lan:
> +	do {
> +		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> +	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>  	ibmveth_free_buffer_pools(adapter);
> -out_free_tx_ltb:
> -	while (--i >= 0)
> -		ibmveth_free_tx_ltb(adapter, i);
> +out_free_queue_mem:
>  	ibmveth_cleanup_rx_resources(adapter);

[Severity: Medium]
This isn't a bug introduced by this patch, but is the changelog wording
accurate about what changed here?  The commit message says:

  "After LAN registration, open-fail teardown frees the logical LAN before
  tearing down RX pool DMA (intentional safer order than leaving the LAN
  registered while unmapping RX memory)."

At the parent commit, an ibmveth_alloc_buffer_pools() failure after a
successful ibmveth_register_logical_lan() went

	rc = ibmveth_alloc_buffer_pools(adapter);
	if (rc)
		goto out_free_tx_ltb;

and out_free_tx_ltb fell through to ibmveth_cleanup_rx_resources() and
ibmveth_free_filter_list() with no h_free_logical_lan() anywhere on that
path, so the RX queue and buffer/filter lists were unmapped and freed while
PHYP still had the LAN registered.  Post-patch that failure goes to
out_unregister_lan, which issues the deregistration hcall first.

So this looks less like a reordering and more like adding a hcall that was
never issued on that path.  Should this be split out as its own patch with a
Fixes: tag so it can be picked up for stable, rather than described as an
ordering preference inside a TX-only refactor?

> @@ -1343,7 +1385,10 @@ static int ibmveth_close(struct net_device *netdev)

[ ... ]

> -	netif_tx_stop_all_queues(netdev);
> +	/* Disable and wait for in-flight ndo_start_xmit (stop_all_queues
> +	 * alone does not). Direct close() callers bypass synchronize_net().
> +	 */
> +	netif_tx_disable(netdev);

[Severity: High]
This isn't a bug introduced by this patch, but the reasoning in this new
comment seems to apply equally to ibmveth_set_channels(), which still frees
the same LTBs after only netif_tx_stop_all_queues():

ibmveth_set_channels() {
	...
	netif_tx_stop_all_queues(netdev);
	...
	/* Free any that are no longer needed */
	for (i = old; i > goal; i--) {
		if (adapter->tx_ltb_ptr[i - 1])
			ibmveth_free_tx_ltb(adapter, i - 1);
	}

	netif_tx_wake_all_queues(netdev);
}

netif_tx_stop_all_queues() only sets __QUEUE_STATE_DRV_XOFF; it takes no
__netif_tx_lock, and netif_set_real_num_tx_queues() only touches the qdisc
root lock.  Since ibmveth does not declare lltx, an ndo_start_xmit already
running on another CPU holds the txq lock and keeps going:

CPU0 ibmveth_start_xmit()
	/* already passed !adapter->tx_ltb_ptr[queue_num] */
	memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));
	...
	desc.fields.address = adapter->tx_ltb_dma[queue_num];

CPU1 ibmveth_set_channels()
	ibmveth_free_tx_ltb(adapter, i - 1);
	  dma_unmap_single(...);
	  adapter->tx_ltb_dma[idx] = 0;
	  kfree(adapter->tx_ltb_ptr[idx]);

Can an ethtool -L shrink therefore memcpy into kfree()d memory and pass a
stale or zeroed DMA address to H_SEND_LOGICAL_LAN?  The new one-shot
tx_ltb_ptr[] check in ibmveth_start_xmit() does not close this window, and
this stop-then-free sequence is unchanged at the end of the series.  Should
ibmveth_set_channels() use netif_tx_disable() too?

> @@ -1359,13 +1404,14 @@ static int ibmveth_close(struct net_device *netdev)

[ ... ]

> @@ -1789,6 +1835,12 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
>  	int i, queue_num = skb_get_queue_mapping(skb);
>  	unsigned long mss = 0;
>  
> +	/* Close / failed reopen can free LTBs while IFF_UP is still set. */
> +	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +	}
> +

[Severity: Medium]
Should this drop bump netdev->stats.tx_dropped like every other drop in this
function does?

	if (unlikely(skb->len > adapter->tx_ltb_size)) {
		...
		netdev->stats.tx_dropped++;
		goto out;
	}

The other drop sites (ibmveth_is_packet_unsupported(), the checksum-help
failure, the oversize check, the total_bytes mismatch and the
ibmveth_send() failure) all increment tx_dropped, and returning
NETDEV_TX_OK tells the core the skb was consumed so the core cannot account
for it either.  In exactly the abnormal states this guard targets, traffic
is then discarded with nothing visible in ip -s link or in
/sys/class/net/<if>/statistics/tx_dropped.  Could this reuse the existing
out: label after the tx_dropped++ instead?

[Severity: Low]
This isn't a bug introduced by this patch, and it looks resolved later in
the series, but noting it for traceability against the claim in the commit
message that "close/failed-reopen with IFF_UP set cannot UAF".

The guard keys off tx_ltb_ptr[] rather than adapter->opened, while
ibmveth_set_channels() at this point in the series still selects its live
path from IFF_UP alone:

	if (!(netdev->flags & IFF_UP))
		return netif_set_real_num_tx_queues(netdev, goal);

In the state the driver documents in ibmveth_close() (IFF_UP set,
adapter->opened false after a failed reopen), ethtool -L would allocate LTBs
and finish with netif_tx_wake_all_queues() on an adapter whose logical LAN
was already released, so packets pass this pointer-only check and reach
ibmveth_send() with no registered LAN, and those LTBs are not freed by a
later close() because it early-returns on !adapter->opened.  The later patch
"ibmveth: Wire ethtool set_channels to MQ RX queue resize" replaces the
IFF_UP gating with an adapter->opened test whose !opened branch allocates
nothing and wakes no queues, which removes this window.

>  	if (ibmveth_is_packet_unsupported(skb, netdev))
>  		goto out;
>  	/* veth can't checksum offload UDP */

