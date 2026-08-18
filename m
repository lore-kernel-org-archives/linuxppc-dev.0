Return-Path: <linuxppc-dev+bounces-25921-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B010C5DF70
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 01:47:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPCHy2LxXz2yVF;
	Tue, 18 Aug 2026 11:47:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787017646;
	cv=none; b=KjYjvLR1bHUrY9OmbVUvagC3qcFSQXq1nIqRJRdO2TZtaz4A2ZsIFbDqmrM28orSa3HCFi2/P7Ws6B9/PAY1rjIFmNWWJtYiCrmVGc96osmZnOHofEnCu0yzgaUsAYS8Up+Gi4IieZ2Y1HnOgJUjQ4PDEQ1UU9r+z2m55RkxOLxeyrxObEjP932sYw0OHcYfijygdBDf/K8acMjj2liKleazkgxKBBgbZuY3Ck6LEPWD+92Rl8dJ5c5/R8stTUMpHJgGzE+6ouMg270HwTUarOV8swYRGLM+4Z7rTts7g3ELlxDr43/SEqwSfRWeqO4DlbBj2d5Em4NcQrdJZHnzgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787017646; c=relaxed/relaxed;
	bh=Z//6XvCnpw33U0V5zgEvxtKKwYyJ/oy/G42ztnrunFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQm6k0h1LrrN9H9yHPGRJepCJMaB+XGrv1293QlBAvTaUxirOf7pbuHbtbNKH7aRgmlbhqm8Zl3xYBE6Lptt8Libx/3WLnzcctAY9v3TKPNbUuYU6/SyaHzAcuGsHtVmiqNwdnQJM6DbbBCYdmqETnqCGLD4Z1sJJXQ+/AAf3/kNt2i2HEj4EKWUYyqKxu77dcL5Jl3mXQF7J9OsVF3mFZmv3xA201uG5PVGKBjG8xFV4RNnefOIwMf4AhgmS/YqZDeMkFPepM1mKK3Ud39A5ox588fNRbwQouKSkUhs2zQiND8FC9jwKZ+CXTnpWiNarZoZVfK8mDBN8Ro8371xGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2yIOoFD; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2yIOoFD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPCHw6cgpz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:47:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C6666601E0;
	Tue, 18 Aug 2026 01:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9571F00A3A;
	Tue, 18 Aug 2026 01:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017642;
	bh=Z//6XvCnpw33U0V5zgEvxtKKwYyJ/oy/G42ztnrunFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g2yIOoFDj3jXuRUB6lwQrnv6b3xFMIzimFN5Pitd4pEQvRIzZ92zKVYYw2ACXV25f
	 7u0+4hllNJfrAYeUcp2MdX/EHu0cqkayQ02y2W6WXPs4yNyLEdpSA5dt+mAJ4GMdL7
	 Ry15UclFgaplT6gIGT5vXqWDyERg6wktvEXT2dIoVVk/y0KUr/BIHPfndAgNAENMWp
	 fh2N/KybXWUZ8U502gZsiRMlELBykNx7zwNeRDCvdx/JYScnSUqY5yqUFvoGr3rou/
	 UvnL38Sm/T4YS7Tqg+lDtmSIGR/GG3ieNL7FUdrxnoCcLEemDZziENFrq5+4rJNwRY
	 1LPS49meOTbAQ==
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
Subject: Re: [PATCH net-next v5 04/15] ibmveth: Refactor buffer pool management for per-queue MQ RX
Date: Mon, 17 Aug 2026 18:47:21 -0700
Message-ID: <20260818014721.3854017-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-5-mmc@linux.ibm.com>
References: <20260814073642.24630-5-mmc@linux.ibm.com>
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
ibmveth: Refactor buffer pool management for per-queue MQ RX

This moves the five RX buffer pools to a per-queue array and introduces
ibmveth_alloc_buffer_pools() / ibmveth_free_buffer_pools() plus the
per-queue helpers, wiring them into open() and close(). Queue 0 stays the
template for pool geometry and activation, and runtime is still
single-queue.

A few questions below about the new unwind paths and about two of the
new comments.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 168940bfa1094..1a428ee60d58c 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -627,6 +627,142 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
>  	}
>  }
>  
> +/**
> + * ibmveth_free_queue_buffer_pools - Free buffer pools for a single queue

[ ... ]

> +/**
> + * ibmveth_alloc_queue_buffer_pools - Allocate buffer pools for a single queue
> + * @adapter: ibmveth adapter structure
> + * @queue: queue index
> + *
> + * Allocates backing storage for each active pool on @queue.
> + * Inactive pools (!active) are skipped. Pool metadata must be
> + * initialized before calling this function.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int ibmveth_alloc_queue_buffer_pools(struct ibmveth_adapter *adapter,
> +					    int queue)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	int i;
> +
> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> +		struct ibmveth_buff_pool *bpool =
> +			&adapter->rx_buff_pool[queue][i];
> +
> +		if (!bpool->active)
> +			continue;
> +
> +		if (ibmveth_alloc_buffer_pool(bpool)) {
> +			netdev_err(netdev,
> +				   "queue %d pool %d alloc failed (size=%u count=%u)\n",
> +				   queue, i,
> +				   bpool->buff_size,
> +				   bpool->size);
> +			bpool->active = 0;
> +			/* Free by allocation presence, not active — the
> +			 * failing pool cleared active first and would be
> +			 * skipped by an active-only unwind.
> +			 */

[Severity: Low]
Is the stated rationale in this comment accurate?  Freeing by allocation
presence is a fine policy for the later resize paths, but the specific
claim that an active-only unwind would skip the failing pool and leak it
does not seem to hold here, because ibmveth_alloc_buffer_pool() already
undoes its own partial allocations before returning -1:

drivers/net/ethernet/ibm/ibmveth.c:ibmveth_alloc_buffer_pool() {
	pool->dma_addr = kzalloc_objs(dma_addr_t, pool->size);
	if (!pool->dma_addr) {
		kfree(pool->free_map);
		pool->free_map = NULL;
		return -1;
	}

	pool->skbuff = kcalloc(pool->size, sizeof(void *), GFP_KERNEL);

	if (!pool->skbuff) {
		kfree(pool->dma_addr);
		pool->dma_addr = NULL;

		kfree(pool->free_map);
		pool->free_map = NULL;
		return -1;
	}
	...
}

By the time bpool->active = 0 runs, free_map/dma_addr/skbuff are all NULL
for the failing pool, so there is nothing for an active-only unwind to
miss.  The same claim appears in the changelog ("v4 fail path freed by
active and skipped the failing pool", "open-fail cannot leak partially
allocated pools").  Could the comment and changelog instead justify
free-by-presence purely in terms of the later resize paths?

> +			ibmveth_free_queue_buffer_pools(adapter, queue);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +

[ ... ]

> +	/* Allocate actual buffers for all queues */
> +	for (q = 0; q < adapter->num_rx_queues; q++) {
> +		rc = ibmveth_alloc_queue_buffer_pools(adapter, q);
> +		if (rc) {
> +			/* Free pools for all previous queues */
> +			while (--q >= 0)
> +				ibmveth_free_queue_buffer_pools(adapter, q);
> +			return rc;
> +		}
> +	}
> +
> +	netdev_dbg(netdev, "allocated buffer pools for %d queue(s)\n",
> +		   adapter->num_rx_queues);

[Severity: Low]
This isn't a bug, but adapter->num_rx_queues is declared as
"unsigned int num_rx_queues;" in drivers/net/ethernet/ibm/ibmveth.h, so
should these two new messages use %u rather than %d?  The same applies to
the netdev_dbg() in ibmveth_free_buffer_pools() below.

> +	return 0;
> +}
> +
> +/**
> + * ibmveth_free_buffer_pools - Free buffer pools for all queues
> + * @adapter: ibmveth adapter structure
> + *
> + * Frees buffer pools for all queues using the helper function.
> + */
> +static void
> +ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
> +{
> +	int q;
> +
> +	/* Free buffer pools for all queues */
> +	for (q = 0; q < adapter->num_rx_queues; q++)
> +		ibmveth_free_queue_buffer_pools(adapter, q);
> +
> +	netdev_dbg(adapter->netdev, "freed buffer pools for %d queue(s)\n",
> +		   adapter->num_rx_queues);
> +}
> +
>  /**
>   * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
>   * @adapter: adapter instance
> @@ -851,16 +987,9 @@ static int ibmveth_open(struct net_device *netdev)
>  		goto out_free_tx_ltb;
>  	}
>  
> -	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> -		if (!adapter->rx_buff_pool[0][i].active)
> -			continue;
> -		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
> -			netdev_err(netdev, "unable to alloc pool\n");
> -			adapter->rx_buff_pool[0][i].active = 0;
> -			rc = -ENOMEM;
> -			goto out_free_buffer_pools;
> -		}
> -	}
> +	rc = ibmveth_alloc_buffer_pools(adapter);
> +	if (rc)
> +		goto out_free_tx_ltb;

[Severity: Medium]
This isn't a gap introduced by this patch (the old inline pool loop fell
through to the same labels), but since the edge is being rewritten here:
this goto is taken after ibmveth_register_logical_lan() has already
succeeded, and the unwind it lands on never issues h_free_logical_lan():

out_free_tx_ltb:
	while (--i >= 0)
		ibmveth_free_tx_ltb(adapter, i);
	ibmveth_cleanup_rx_resources(adapter);
out_free_filter_list:
	ibmveth_free_filter_list(adapter);

ibmveth_cleanup_rx_resources() does the dma_unmap_single() of
buffer_list_dma[], the dma_free_coherent() of the RX completion queue and
the free_page() of the buffer-list page, and ibmveth_free_filter_list()
releases the filter list, all while PHYP still holds those addresses.  The
adjacent request_irq() failure path does perform the handshake the driver
otherwise considers mandatory:

		do {
			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));

Can PHYP write the rx_no_buffer counter into the freed buffer-list page, or
post a completion into the freed RX queue, after this path returns?  The
h_vio_signal(VIO_IRQ_DISABLE) issued just before registration also is not
rebalanced here.

Later patches in this series do repair this: "ibmveth: Refactor TX resource
allocation in open/close paths" retargets this edge to out_unregister_lan,
and by the end of the series ibmveth_open() allocates the pools before
ibmveth_register_rx_queues() and routes post-registration failures through
ibmveth_free_all_queues() -> h_free_logical_lan().  Would it be reasonable
to point this goto at a label that unregisters the logical LAN already in
this patch, so the intermediate commit is not bisect-visible?

>  
>  	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
>  	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
> @@ -885,11 +1014,7 @@ static int ibmveth_open(struct net_device *netdev)
>  	return 0;
>  
>  out_free_buffer_pools:
> -	while (--i >= 0) {
> -		if (adapter->rx_buff_pool[0][i].active)
> -			ibmveth_free_buffer_pool(adapter,
> -						 &adapter->rx_buff_pool[0][i]);
> -	}
> +	ibmveth_free_buffer_pools(adapter);
>  out_free_tx_ltb:
>  	while (--i >= 0)
>  		ibmveth_free_tx_ltb(adapter, i);

[Severity: Medium]
This is a pre-existing issue rather than one introduced here, but does this
hunk silently fix a TX long-term-buffer leak?

In the parent commit the pool unwind consumed i:

out_free_buffer_pools:
	while (--i >= 0) {
		if (adapter->rx_buff_pool[0][i].active)
			ibmveth_free_buffer_pool(adapter,
						 &adapter->rx_buff_pool[0][i]);
	}
out_free_tx_ltb:
	while (--i >= 0)
		ibmveth_free_tx_ltb(adapter, i);

so on reaching out_free_tx_ltb by fall-through, i was already -1 and the
first test of --i evaluated to -2, meaning no tx_ltb_ptr[]/tx_ltb_dma[]
buffer was released.  With the pool unwind now a helper call that does not
touch i, i still holds the TX queue count from the completed TX allocation
loop, so the TX LTBs are freed.

Every PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE) TX buffer plus its DMA mapping was
leaked on each failing open, and it repeats per attempt ("ip link set <dev>
up" under memory pressure, or the close+open pair inside veth_pool_store(),
ibmveth_change_mtu() and ibmveth_reset()).

Would it make sense to split this out as its own patch with a Fixes: tag so
stable trees pick it up, or at least describe it in the changelog?

>  
> @@ -928,14 +1053,10 @@ static int ibmveth_close(struct net_device *netdev)

[ ... ]

