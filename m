Return-Path: <linuxppc-dev+bounces-25920-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8373C5B572
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 01:47:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPCHx0yHpz2yHT;
	Tue, 18 Aug 2026 11:47:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787017645;
	cv=none; b=Th9o0h12i/OUURIYQ0daimqvSNStchvIQj8nVSDZsO+lVee/MLsFe08uR4ADyFqaRoTdNu9lpyIsfJAvTGrysJtJAjCp5TxduQrjD3VKBtrY3jFq7T2bDF2e7J5ywqgNOMhUt4sBCsW8GIJsuDRmDkVvKIMUCUS7/7xOC+5t7T6iUoZnKU1BvelaEE6TmKM5wqWt7e5Fi3OPpWLBOoy4ANOwaxHPX/zkdH89Uf++ZjkP8gnME/ybPiiF2Bg7RTDhro65oW24hkdL+pjUetE7jB+27LEYT9NJ4uq/5P1bATAilJfvCunAMfsc+iEdxu7ad7YNdL/WFhZ9J3EunKPtzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787017645; c=relaxed/relaxed;
	bh=fW4isBkgs4nl/dIbFcJoW9SIR0q3+n7RWUhoVGArZjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKZzjZfTaij8CO0rlEyoJImxf290pQ7VetrCyHV5E2PAsFiZpyPkUQ8ZR1/HGdkBqbKzfsoGl7W+zwnxR2JJ3jMOiT76O7lM+S1avDC+I02JKUw3Oxk2IY0CKfghmZJ/2WkCq2QPQw7PiVdNIsctl/vuOn5awNZhaf8PISulpt/fcrGtRkyKtRC85znosvAXecMpefOvtZ1oSEVa1cFfBDJjbmGt0xnjfevgGAZaZ3mA/CrxL+/rf8hqOfFnfgMP2CA5xCRv23K4HtmENYefBWDIp/6PlcKrFZKuEFiWbAmjwKyv/+xZ+34sjsmicqlT4SjLmJacUEdqyPI21VlGQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCYXMJ1s; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCYXMJ1s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPCHv4SgVz2xxr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:47:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 56A10601DE;
	Tue, 18 Aug 2026 01:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84221F000E9;
	Tue, 18 Aug 2026 01:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017641;
	bh=fW4isBkgs4nl/dIbFcJoW9SIR0q3+n7RWUhoVGArZjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JCYXMJ1se9oNszoc11G44ZONh3l7xxRSx53YK0rPYz0ZV0S44an0iFJuONzlMzmmM
	 tcRqB+CUuZVKbUpAxYUloZndxhgsFYZryYVKzqrXX5dsL5orP3chR13DM02j3ShO0c
	 /95+pUE38ewjRyQoSoDTmkmxMMHDMk4HoF3zqbrzSpp9CSul8kgviR4JGaLI6cAXuL
	 GqMQh9zrI3ADEXrNcTF9Q+XGU9F1xPWFKrDZr7Sn+wSKttoKzsF2RyYVb6A7ZfT5Vu
	 zXK8RCbloiUVhtryXkk043wAKjTzaD0XuENQRzjojq+/c7Cq+L9J5kY0sNc8MgENKx
	 LDcl24LGZfABA==
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
Subject: Re: [PATCH net-next v5 03/15] ibmveth: Refactor RX resource allocation for MQ RX bring-up
Date: Mon, 17 Aug 2026 18:47:19 -0700
Message-ID: <20260818014719.3853980-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-4-mmc@linux.ibm.com>
References: <20260814073642.24630-4-mmc@linux.ibm.com>
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
ibmveth: Refactor RX resource allocation for MQ RX bring-up

This moves the filter list and per-queue RX buffer list / RX ring
allocation out of ibmveth_open() into four new helpers, and wires them
into both the open failure unwind and ibmveth_close(). Runtime behaviour
is meant to stay single-queue, and rc = -ENOMEM is now set before the TX
LTB loop.

A few questions below about the new release helpers and the remaining
inline unwind in ibmveth_open().

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 7cb828b476c1b..168940bfa1094 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -151,6 +151,186 @@ static unsigned int ibmveth_real_max_tx_queues(void)
>  	return min(n_cpu, IBMVETH_MAX_QUEUES);
>  }
>  
> +/**
> + * ibmveth_alloc_filter_list - Allocate and map filter list
> + * @adapter: ibmveth adapter structure
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int
> +ibmveth_alloc_filter_list(struct ibmveth_adapter *adapter)
> +{
> +	struct device *dev = &adapter->vdev->dev;
> +	struct net_device *netdev = adapter->netdev;
> +
> +	adapter->filter_list_addr = (void *)get_zeroed_page(GFP_KERNEL);
> +	if (!adapter->filter_list_addr) {
> +		netdev_err(netdev, "unable to allocate filter pages\n");
> +		return -ENOMEM;
> +	}
> +
> +	adapter->filter_list_dma = dma_map_single(dev,
> +						  adapter->filter_list_addr,
> +						  4096, DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(dev, adapter->filter_list_dma)) {
> +		netdev_err(netdev, "unable to map filter list pages\n");
> +		free_page((unsigned long)adapter->filter_list_addr);
> +		adapter->filter_list_addr = NULL;
> +		/* Do not leave DMA_MAPPING_ERROR for free_filter_list(). */
> +		adapter->filter_list_dma = 0;
> +		return -ENOMEM;
> +	}
> +
> +	netdev_dbg(netdev, "filter list @ 0x%p (DMA: 0x%llx)\n",
> +		   adapter->filter_list_addr,
> +		   (unsigned long long)adapter->filter_list_dma);
> +
> +	return 0;
> +}
> +
> +/**
> + * ibmveth_free_filter_list - Free filter list resources
> + * @adapter: ibmveth adapter structure
> + */
> +static void
> +ibmveth_free_filter_list(struct ibmveth_adapter *adapter)
> +{
> +	struct device *dev = &adapter->vdev->dev;
> +
> +	if (adapter->filter_list_dma) {
> +		dma_unmap_single(dev, adapter->filter_list_dma, 4096,
> +				 DMA_BIDIRECTIONAL);
> +		adapter->filter_list_dma = 0;
> +	}
> +
> +	if (adapter->filter_list_addr) {
> +		free_page((unsigned long)adapter->filter_list_addr);
> +		adapter->filter_list_addr = NULL;
> +	}
> +}

[Severity: Medium]
Is this patch doing more than a refactor?  The new pointer and DMA handle
guards in ibmveth_free_filter_list(), plus the same guards in
ibmveth_cleanup_rx_resources(), look like they also fix a double free that
exists before this patch.

In the baseline, the ibmveth_open() unwind released the pages without
clearing anything:

out_free_filter_list:
	free_page((unsigned long)adapter->filter_list_addr);
out_free_buffer_list:
	free_page((unsigned long)adapter->buffer_list_addr[0]);

and ibmveth_close() then repeated the same work unconditionally:

	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
			 DMA_BIDIRECTIONAL);
	free_page((unsigned long)adapter->buffer_list_addr[0]);

	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
			 DMA_BIDIRECTIONAL);
	free_page((unsigned long)adapter->filter_list_addr);

ibmveth_set_csum_offload(), ibmveth_set_tso(), ibmveth_change_mtu() and
veth_pool_store() all propagate an ibmveth_open() failure while leaving the
interface running, so the following ndo_stop re-ran those frees on pages
that were already returned, together with a dma_unmap of an already
unmapped address.

The applied commit message describes this as a pure refactor ("Runtime
behavior stays single-queue"), and the reasoning for the guards only
appears in the v5 changelog below the --- line, which is stripped when the
patch is applied.  Could the commit message state that the double
free_page() and stale dma_unmap are fixed here, and could a Fixes: tag be
added so stable trees can pick it up?

Note the sibling release helper ibmveth_free_tx_ltb() is still not
idempotent at this point in the series; that is only addressed by the later
"ibmveth: Refactor TX resource allocation in open/close paths" patch.

[ ... ]

> +	netdev_dbg(netdev, "allocated %d RX queue(s) with %d entries each\n",
> +		   adapter->num_rx_queues, rxq_entries);

[ ... ]

> +static void
> +ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
> +{
> +	struct device *dev = &adapter->vdev->dev;
> +	int i;
> +
> +	netdev_dbg(adapter->netdev, "cleaning up %d RX queue(s)\n",
> +		   adapter->num_rx_queues);

[Severity: Low]
This isn't a bug, but adapter->num_rx_queues is declared as unsigned int in
struct ibmveth_adapter in ibmveth.h, so should these two new debug messages
in ibmveth_alloc_rx_queues() and ibmveth_cleanup_rx_resources() use %u
rather than %d?  The same mismatch is still there at the end of the series
where the value comes from ibmveth_get_num_rx_queues(), which also returns
unsigned int.

> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		if (adapter->buffer_list_dma[i]) {
> +			dma_unmap_single(dev, adapter->buffer_list_dma[i],
> +					 4096, DMA_BIDIRECTIONAL);
> +			adapter->buffer_list_dma[i] = 0;
> +		}
> +
> +		if (adapter->rx_queue[i].queue_addr) {
> +			dma_free_coherent(dev, adapter->rx_queue[i].queue_len,
> +					  adapter->rx_queue[i].queue_addr,
> +					  adapter->rx_queue[i].queue_dma);
> +			adapter->rx_queue[i].queue_addr = NULL;
> +		}
> +
> +		if (adapter->buffer_list_addr[i]) {
> +			free_page((unsigned long)adapter->buffer_list_addr[i]);
> +			adapter->buffer_list_addr[i] = NULL;
> +		}
> +	}
> +}
> +
>  /* setup the initial settings for a buffer pool */
>  static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
>  				     u32 pool_index, u32 pool_size,

[ ... ]

> @@ -752,26 +890,12 @@ static int ibmveth_open(struct net_device *netdev)
>  			ibmveth_free_buffer_pool(adapter,
>  						 &adapter->rx_buff_pool[0][i]);
>  	}
> -out_unmap_filter_list:
> -	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
> -			 DMA_BIDIRECTIONAL);
> -
>  out_free_tx_ltb:
> -	while (--i >= 0) {
> +	while (--i >= 0)
>  		ibmveth_free_tx_ltb(adapter, i);
> -	}

[Severity: Medium]
This isn't a bug introduced by this patch, but does the fall-through from
out_free_buffer_pools into out_free_tx_ltb leak the TX long term buffers?

Both labels share the loop counter i.  On the buffer pool failure and the
request_irq() failure paths, out_free_buffer_pools already runs
while (--i >= 0) down to i == -1, so out_free_tx_ltb then evaluates
--i == -2 and runs zero iterations:

out_free_buffer_pools:
	while (--i >= 0) {
		...
	}
out_free_tx_ltb:
	while (--i >= 0)
		ibmveth_free_tx_ltb(adapter, i);

Every tx_ltb_ptr[] allocation plus its dma_map_single(DMA_TO_DEVICE) made
by the earlier loop over real_num_tx_queues then stays around, and a later
successful open overwrites the pointers and handles.

The shared counter disappears at the end of the series, where TX LTB
allocation moves into ibmveth_alloc_tx_resources() with its own err_free_ltbs
unwind, so this only matters for this commit and its predecessors.

> -
> -out_unmap_buffer_list:
> -	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
> -			 DMA_BIDIRECTIONAL);
> -out_free_queue_mem:
> -	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
> -			  adapter->rx_queue[0].queue_addr,
> -			  adapter->rx_queue[0].queue_dma);
> +	ibmveth_cleanup_rx_resources(adapter);
>  out_free_filter_list:
> -	free_page((unsigned long)adapter->filter_list_addr);
> -out_free_buffer_list:
> -	free_page((unsigned long)adapter->buffer_list_addr[0]);
> +	ibmveth_free_filter_list(adapter);
>  out:
>  	napi_disable(&adapter->napi[0]);
>  	return rc;

[Severity: High]
This is a pre-existing issue, but can the hypervisor still be writing into
these pages here?

On the buffer pool allocation failure path in ibmveth_open():

		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
			netdev_err(netdev, "unable to alloc pool\n");
			adapter->rx_buff_pool[0][i].active = 0;
			rc = -ENOMEM;
			goto out_free_buffer_pools;
		}

there is no h_free_logical_lan() loop, unlike the request_irq() failure
path just below it, so PHYP is still registered against the buffer list
page, the RX ring and the filter list when control reaches
ibmveth_cleanup_rx_resources() and ibmveth_free_filter_list(), which
dma_unmap and free them.

The consolidated helpers make that sequence easier to read but do not
change it.  At the end of the series ibmveth_open() allocates the buffer
pools before ibmveth_register_rx_queues() and every post-registration exit
goes through ibmveth_free_all_queues() first, so is the ordering here worth
fixing earlier, or is it intentionally left to the later "ibmveth: Add RX
queue register helpers for MQ" patch?

> @@ -805,17 +928,8 @@ static int ibmveth_close(struct net_device *netdev)
>  
>  	ibmveth_update_rx_no_buffer(adapter);
>  
> -	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
> -			 DMA_BIDIRECTIONAL);
> -	free_page((unsigned long)adapter->buffer_list_addr[0]);
> -
> -	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
> -			 DMA_BIDIRECTIONAL);
> -	free_page((unsigned long)adapter->filter_list_addr);
> -
> -	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
> -			  adapter->rx_queue[0].queue_addr,
> -			  adapter->rx_queue[0].queue_dma);
> +	ibmveth_cleanup_rx_resources(adapter);
> +	ibmveth_free_filter_list(adapter);

[Severity: High]
Can ibmveth_close() dereference a NULL buffer_list_addr[0] now?

ibmveth_cleanup_rx_resources() clears the pointer after freeing it:

			free_page((unsigned long)adapter->buffer_list_addr[i]);
			adapter->buffer_list_addr[i] = NULL;

while ibmveth_update_rx_no_buffer(), called just above, dereferences it
unconditionally:

	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;

	adapter->rx_no_buffer = be64_to_cpup(p);

The baseline inline code in ibmveth_close() left the pointer stale, so the
read did not fault.  With the helper clearing it, a failed re-open leaves
the field NULL while the interface is still up:

ibmveth_set_csum_offload() / ibmveth_set_tso() / ibmveth_change_mtu() /
veth_pool_store()
    ibmveth_close()
    ibmveth_open()          <- fails, out_free_tx_ltb path runs
        ibmveth_cleanup_rx_resources()   buffer_list_addr[0] = NULL

and the next ndo_stop, or the queued ibmveth_reset() work reaching
dev_close(), enters ibmveth_close() and reads through NULL + 4096 - 8.

Later patches in the series appear to close this: ibmveth_close() becomes
gated on adapter->opened, and ibmveth_update_rx_no_buffer() takes a queue
index and returns early when buffer_list_addr[queue_index] is NULL.  Would
it make sense to add that NULL check in this patch, since this is the commit
that starts clearing the pointer?

