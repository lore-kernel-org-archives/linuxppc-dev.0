Return-Path: <linuxppc-dev+bounces-25518-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552F6C5AC67
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 18:37:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGGGc41Mwz3bx0;
	Fri, 07 Aug 2026 04:37:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786041432;
	cv=none; b=GhgGC5Bk+5NTfguDTjIhTT98pe3ZipyuNzH1b6M7tUFqCKNWB3ZSICpHWS8zjJMQKUDSo1GMFXb7Vf+hLaMC+g43AmYhL8SoScRdBP5tzVqZ7mYUG82HoeupUcXJBVqAZYmN/UdpX3j0GSOS97Wh1qVKw/C4SvnWSsEhI6UplS36eqXj3Ws36murqMGPn7oQ3J+j50mVeTyih/8BiS+Qssfexo9H2tJ6WQzHMMiSkB3x6y3UmpNe8hwpSKt5t4Nchf5l6djbI4z1/kfJKqqCgt1u/a9AiIIo/HamI4vlzuSKDG+KEYs2K5BkM4zCRxJBDY9psBj9D5uIG+rRngtJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786041432; c=relaxed/relaxed;
	bh=95cN4lzTAczWJkREkqD6+UVv867WIgYTfpkjFcU67nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgIH/Yt40u8yuYROcYqG4r4nkEbxTSv0B15DxWsaQCSAdeVEsl4Sf+pMzUU92dF0Voqh2L8B7Q2yPGRR1DweAzOwHAHM+IcbYk6vapk7XpdyFS8jERvtZAB557eDbl69stJHG4cyL1UAXGSpIp81aJUr9YmWQyY3sCrLrpjE1v2MLoaQIyr/9z1QNCKuNlG2X0aAlnd/wn7lnPU30erqy7uU8IM/rj8hJj5ucTdNxdXOAHvJQNRPx04wLL5NDq4HQXU9o7CPsCIWPJz6ofFCZYcsw4uB5YaJbosE/n2srNMIvWlFOa9j7eKiOXK3zL6x+igWpasXwyl+L2O4Es7ZVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EpJifcHP; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EpJifcHP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGGGX5fwNz3byP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 04:37:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5EA33600AF;
	Thu,  6 Aug 2026 18:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C431F00A3F;
	Thu,  6 Aug 2026 18:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041426;
	bh=95cN4lzTAczWJkREkqD6+UVv867WIgYTfpkjFcU67nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EpJifcHPXkvekr9Va2mGjT22r9seMbAPoE0p8MdlFYwCXQE9vkuLSiU2nu199w7o3
	 fu3u63dvRfSHzdOGmyJYfzeM+0Ls4lhJuy2jIDQRzDgqlgSQRifO/2vzf+5e4Wuz3+
	 MOynoyfmUGTEaPX0i/vmfASfcVxxjKnMuvmikEZEXv5xWD6sa7H7T8v2GSqknBni8z
	 PcJCmWDaxPlIEX62gR6F7gOZJb2dF+Oc558RWrrGE7EC5kyH1MU7CaX9ftGQqvEOXR
	 ah/tKCRormQsOlE/Ur0HEbd/ojOJVecX3quYAeopGyt62tiPE2J811HOxSENsk6LvC
	 zgNX6pCuMuurQ==
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
Subject: Re: [PATCH net-next v4 06/14] ibmveth: Refactor TX resource allocation in open/close paths
Date: Thu,  6 Aug 2026 11:37:05 -0700
Message-ID: <20260806183705.3175367-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <f6e2721c3c664f789a72594d64c7b586ef1ce108.1785457143.git.mmc@linux.ibm.com>
References: <f6e2721c3c664f789a72594d64c7b586ef1ce108.1785457143.git.mmc@linux.ibm.com>
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
ibmveth_open() and ibmveth_close() into ibmveth_alloc_tx_resources() and
ibmveth_free_tx_resources(), relocates the TX allocation to the end of
open(), and reworks the open() error unwind labels.

A few questions on the changelog and on the new ordering below.

[Severity: Medium]
The changelog says:

    That also retires a mid-open TX leak where the old index-based
    while (--i) free could skip successfully allocated LTBs.

Is that leak real?  In the parent commit the TX loop re-initializes the
shared index before allocating anything:

	rc = -ENOMEM;
	for (i = 0; i < netdev->real_num_tx_queues; i++) {
		if (ibmveth_allocate_tx_ltb(adapter, i))
			goto out_free_tx_ltb;
	}

and nothing between that loop and the later gotos (mac_address/rxq_desc
setup, ibmveth_register_logical_lan(), ibmveth_alloc_buffer_pools(),
ibmveth_setup_rx_interrupts()) reassigns i.  On every path that reaches
out_free_tx_ltb, i is either the failing index or real_num_tx_queues, so
while (--i >= 0) frees exactly what was allocated.  Paths taken before the
TX loop jump to out_free_filter_list, which is below the TX label.

The new helper also uses the same index-based unwind that the changelog
calls broken:

err_free_ltbs:
	while (--i >= 0)
		ibmveth_free_tx_ltb(adapter, i);

Could this paragraph be dropped or reworded to describe the actual
motivation (removing the dependence on a shared loop index and matching
the RX helpers)?  As written it reads like a leak fix that a stable
maintainer might want to backport, and there is no Fixes: tag.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 664169c4d27a4..131c1a61d9e7e 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1077,8 +1077,14 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>  
>  static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>  {
> -	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
> -			 adapter->tx_ltb_size, DMA_TO_DEVICE);
> +	if (!adapter->tx_ltb_ptr[idx])
> +		return;
> +
> +	if (adapter->tx_ltb_dma[idx]) {
> +		dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
> +				 adapter->tx_ltb_size, DMA_TO_DEVICE);
> +		adapter->tx_ltb_dma[idx] = 0;
> +	}

[Severity: Low]
Is the inner test on tx_ltb_dma[idx] wanted here?  It treats DMA address 0
as a "not mapped" sentinel, and the only architecturally valid check for a
bad handle is dma_mapping_error() at map time.  If a mapping ever
legitimately returned IOVA 0, the TCE entry would leak while kfree() below
still released the buffer.

On pseries this cannot happen today, since
arch/powerpc/kernel/iommu.c:iommu_table_reserve_pages() reserves entry 0:

	if (tbl->it_offset == 0)
		set_bit(0, tbl->it_map);

The test also looks redundant: ibmveth_allocate_tx_ltb() already kfree()s
the buffer and clears tx_ltb_ptr[idx] on dma_mapping_error(), so
tx_ltb_ptr[idx] != NULL already implies a valid mapping and the new early
return covers the stated "safe on an unallocated slot" goal.  Would
dropping the zero test and relying on the pointer check be simpler?

>  	kfree(adapter->tx_ltb_ptr[idx]);
>  	adapter->tx_ltb_ptr[idx] = NULL;
>  }

[ ... ]

> @@ -1184,35 +1226,38 @@ static int ibmveth_open(struct net_device *netdev)
>  				     rxq_desc.desc,
>  				     mac_address);
>  		rc = -ENONET;
> -		goto out_free_tx_ltb;
> +		goto out_free_queue_mem;
>  	}
>  
>  	rc = ibmveth_alloc_buffer_pools(adapter);
>  	if (rc)
> -		goto out_free_tx_ltb;
> +		goto out_unregister_lan;

[Severity: Low]
This changes hypervisor-visible behaviour on an RX error path, which the
changelog does not mention while stating "there is no MQ RX behaviour
change here".

In the parent commit an ibmveth_alloc_buffer_pools() failure went to
out_free_tx_ltb and then to ibmveth_cleanup_rx_resources(), leaving the
logical LAN registered with PHYP while the RX ring was freed and the
buffer list unmapped.  With the new label the h_free_logical_lan() loop
runs first, which is the safer order.

Is this an intentional fix folded into a TX-only refactor?  If so, could
it be split out with its own changelog text (the next patch in the series
reorders open() so this path disappears entirely, so the fix becomes hard
to find later).

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
>  
>  	netdev_dbg(netdev, "initial replenish cycle\n");
>  	ibmveth_schedule_rx_queue(adapter, 0);
>  
> +	rc = ibmveth_alloc_tx_resources(adapter);
> +	if (rc)
> +		goto out_cleanup_rx_interrupts;
> +
>  	netif_tx_start_all_queues(netdev);

[ ... ]

> @@ -1224,13 +1269,13 @@ static int ibmveth_close(struct net_device *netdev)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>  	long lpar_rc;
> -	int i;
>  
>  	netdev_dbg(netdev, "close starting\n");
>  
>  	netif_tx_stop_all_queues(netdev);
>  
>  	/* PHYP mask + napi_disable + free_irq live in cleanup_rx_interrupts */
> +	ibmveth_free_tx_resources(adapter);
>  	ibmveth_cleanup_rx_interrupts(adapter);

[Severity: High]
Can a transmit already in flight write into the TX LTB after it has been
unmapped and freed here?

netif_tx_stop_all_queues() only sets __QUEUE_STATE_DRV_XOFF.  It does not
take __netif_tx_lock and does not wait for an ndo_start_xmit that is
already running on another CPU (netif_tx_disable() would).  ibmveth_close()
is also called directly, bypassing dev_close() -> dev_deactivate_many()
and its synchronize_net() / some_qdisc_is_busy() wait, from:

	ibmveth_set_csum_offload()
	ibmveth_set_tso()
	ibmveth_change_mtu()
	veth_pool_store()

all of which do:

	if (netif_running(dev)) {
		restart = 1;
		ibmveth_close(dev);
	}

So a transmitter that already passed netif_xmit_stopped() can be inside
ibmveth_start_xmit(), which copies into the LTB with no NULL check and no
lock:

	memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));
	...
		memcpy(adapter->tx_ltb_ptr[queue_num] + total_bytes,
		       skb_frag_address_safe(frag), skb_frag_size(frag));
	...
	desc.fields.address = adapter->tx_ltb_dma[queue_num];

while ibmveth_free_tx_ltb() concurrently does:

	dma_unmap_single(...);
	adapter->tx_ltb_dma[idx] = 0;
	kfree(adapter->tx_ltb_ptr[idx]);
	adapter->tx_ltb_ptr[idx] = NULL;

That looks like either a write of up to tx_ltb_size bytes into freed heap
memory, or a NULL dereference on the cleared pointer.

A second question on the same move: the DMA unmap now happens before the
h_free_logical_lan() loop below, so a racing ibmveth_send() can hand PHYP
a descriptor whose address is 0 or an already unmapped TCE while the
logical LAN is still registered.  Previously the TX LTBs were freed at the
very end of close(), after h_free_logical_lan(), free_irq()/napi_disable()
and the buffer pool teardown, which incidentally left a large gap between
the XOFF and the free.  Was the inversion intended?

Would keeping ibmveth_free_tx_resources() after the h_free_logical_lan()
loop, switching to netif_tx_disable(), and/or adding an

	if (unlikely(!adapter->tx_ltb_ptr[queue_num]))

bail-out in ibmveth_start_xmit() be preferable?  The last one would also
cover the mirror window that the new open() ordering creates, where the
LAN is registered and RX interrupts/NAPI are live while tx_ltb_ptr[] is
still NULL during the sleeping GFP_KERNEL allocation in
ibmveth_alloc_tx_resources():

	ibmveth_schedule_rx_queue(adapter, 0);

	rc = ibmveth_alloc_tx_resources(adapter);

[Severity: Low]
The comment about PHYP mask, napi_disable and free_irq now sits above
ibmveth_free_tx_resources() instead of above the
ibmveth_cleanup_rx_interrupts() call it describes, so it reads as
documentation of the TX free.  Could it move below the TX free?

>  
>  	do {

[ ... ]

> -	for (i = 0; i < netdev->real_num_tx_queues; i++)
> -		ibmveth_free_tx_ltb(adapter, i);
> -
>  	netdev_dbg(netdev, "close complete\n");
>  
>  	return 0;

