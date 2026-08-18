Return-Path: <linuxppc-dev+bounces-25924-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71736C5DF74
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 01:48:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPCJ23ZFSz2ynn;
	Tue, 18 Aug 2026 11:47:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787017650;
	cv=none; b=IDMoY9bIDZzvwNw9nH5L0/L9IwWghK+etQ6eecWIu7Qbgl/0Isq9WPqoZsrPdPGRcMsEk6zqZ0rTSLe1f9aadoV9atVERVYh8Mb81o4CNpYrFt+gdzhPs+QZvjB9ohpGxIM3QmfY4pImQb+ubBCfduKwo3JU4v6FSJS/oxt9IBpMhhbnETBfnjvgojdarpmUjU0R690RzMlNP2RcsMdxTnkX9lN4DiBrjgFWmsZvaBfog2fIzBQ+gEFJnjILUxBNlqrdFafjR77XwD171xqNC0/1zLWsF2oE/hK5ijD3W+X9HeptjnZNsD9v68f7AJY2SfhpZZW30Lv3AGkn/nkY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787017650; c=relaxed/relaxed;
	bh=Lsf30mOo84cdXgOHKh7nYn9M/4udwgEQLgF9Z6NvAJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw7643WTSKouURBff+Hw5G2liJ54iT8PQeljKf/TqPa64uhPGP5Scb1luDmO+l/DstMczBXFRlRL/uUfL/JX8puP7lvfIfsk1p582Q6Qu/u8Lr/37dokDzl0LSmTuZ08lv57Wtn2LGmmfQmzhOCl7UfTI/5fsKQcKKdn1s1YmxRxKOC27thxswToFbdZU1ZE/krdhq7mYmruXEpiurbqlHb8UrdaEQC2zD8WCqGwuXBpGl6ldCAo1txlulXAJ9kwkjYsB9NA/ydtgPfEWBh5c8Fc3MXoVZ3HuZ9PehoV6jUQooQUSVCehh79NCiXmg/MOsubbOn1S8liw74lt8zKVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DspvFB1n; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DspvFB1n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPCJ126Txz2ySg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:47:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 545AB403CA;
	Tue, 18 Aug 2026 01:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADBF1F00A3A;
	Tue, 18 Aug 2026 01:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017647;
	bh=Lsf30mOo84cdXgOHKh7nYn9M/4udwgEQLgF9Z6NvAJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DspvFB1niodURxSORrZagOcPg5MjRdYQehJAGLkxpme/skJAby0BUcHI89kJ/mb1G
	 EEI0wcJqpj34GhQLPfRqaZu32wDOHfjK2z+zmAZW7QmrtrXPVY7/iFGvOxgJFTkF+Z
	 WmZ3ep/zVBJExwEic1q8OhcLo+U0W2l6rTG5HFlAFYayHI4X2dVqge+wo2XzX3uCvk
	 ZdjihKCThUJu4MhUgPp+TH8xpc+yyabrlFZSLpv9+87bofKirLOfZPzlGfgYWMPvD7
	 iJldNrrJ/y7l1ub5WrZilL1YurjlKiMzdH97ckWbuNoZsEnw+bgQAz9Ef4YhDcQmAb
	 0GXCDHSfpv0fw==
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
Subject: Re: [PATCH net-next v5 07/15] ibmveth: Add RX queue register helpers for MQ
Date: Mon, 17 Aug 2026 18:47:26 -0700
Message-ID: <20260818014726.3854123-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-8-mmc@linux.ibm.com>
References: <20260814073642.24630-8-mmc@linux.ibm.com>
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
ibmveth: Add RX queue register helpers for MQ

This extracts the queue-0 control-plane registration and teardown out of
ibmveth_open()/ibmveth_close() into ibmveth_register_rx_queues() and
ibmveth_free_all_queues(), and adds adapter->hcall_stats for register/free
path accounting. Runtime behaviour stays single-queue since multi_queue is
still false.

A few questions on the teardown error handling and on the changelog text.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index b39e8c53cbfd1..8519cad503225 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1270,13 +1275,27 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
>  	 * try again, but only once.
>  	 */
>  retry:
> -	rc = h_register_logical_lan(adapter->vdev->unit_address,
> -				    adapter->buffer_list_dma[0], rxq_desc.desc,
> -				    adapter->filter_list_dma, mac_address);
> +	/* In multi-queue mode, obtain a queue handle for queue 0 so all RX
> +	 * queues can use the same per-queue buffer hypercalls.
> +	 */
> +	if (adapter->multi_queue) {
> +		rc = h_register_logical_lan_with_handle(ua, buf_dma,
> +							rxq_desc.desc,
> +							filter_dma,
> +							mac_address,
> +							&qh0);
> +		if (rc == H_SUCCESS)
> +			adapter->queue_handle[0] = qh0;
> +	} else {
> +		rc = h_register_logical_lan(ua, buf_dma, rxq_desc.desc,
> +					    filter_dma, mac_address);
> +	}
> +	adapter->hcall_stats.reg_lan++;
>  
>  	if (rc != H_SUCCESS && try_again) {
>  		do {
>  			rc = h_free_logical_lan(adapter->vdev->unit_address);
> +			adapter->hcall_stats.free_lan++;
>  		} while (H_IS_LONG_BUSY(rc) || (rc == H_BUSY));
>  
>  		try_again = 0;

[ ... ]

> +static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
> +{
> +	unsigned long lpar_rc;
> +	int i;
> +
> +	netdev_dbg(adapter->netdev, "freeing all RX queues at once\n");
> +
> +	do {
> +		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> +		adapter->hcall_stats.free_lan++;
> +	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> +
> +	if (lpar_rc != H_SUCCESS) {
> +		netdev_err(adapter->netdev,
> +			   "h_free_logical_lan failed: %ld\n", lpar_rc);
> +	}
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++)
> +		adapter->queue_handle[i] = 0;
> +}

[Severity: High]
This isn't a bug introduced by this patch - the baseline ibmveth_close()
already had the same log-and-continue loop ("h_free_logical_lan failed with
%lx, continuing") followed by ibmveth_free_buffer_pools() - but the new
helper makes it harder to fix later, so a question about it.

The retry loop here only retries H_BUSY and H_IS_LONG_BUSY. Any other
status (H_PARAMETER, H_STATE, H_HARDWARE) leaves the loop, is logged, and
then the helper returns void, so neither ibmveth_close() nor the
ibmveth_open() unwind can see that the logical LAN may still be registered.

Right after the netdev_err(), queue_handle[] is cleared unconditionally:

	for (i = 0; i < adapter->num_rx_queues; i++)
		adapter->queue_handle[i] = 0;

Should that clearing be conditional on H_SUCCESS? Once multi_queue is
enabled later in the series, ibmveth_deregister_single_rx_queue() bails out
on "if (!qh)", so zeroing the handles after a failed free removes the only
reference a per-queue H_FREE_LOGICAL_LAN_QUEUE retry would need.

Would it make sense for this helper to return the hypercall status so the
callers can decide, rather than returning void?

[ ... ]

> @@ -1309,37 +1407,23 @@ static int ibmveth_open(struct net_device *netdev)
>  	if (rc)
>  		goto out_free_filter_list;
>  
> -	mac_address = ether_addr_to_u64(netdev->dev_addr);
> -
> -	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
> -					adapter->rx_queue[0].queue_len;
> -	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
> -
> -	adapter->queue_irq[0] = netdev->irq;
> -	ibmveth_disable_irq(adapter, 0);
> -
> -	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
> -
> -	if (lpar_rc != H_SUCCESS) {
> -		netdev_err(netdev, "h_register_logical_lan failed with %ld\n",
> -			   lpar_rc);
> -		netdev_err(netdev, "buffer TCE:0x%llx filter TCE:0x%llx rxq "
> -			   "desc:0x%llx MAC:0x%llx\n",
> -				     adapter->buffer_list_dma[0],
> -				     adapter->filter_list_dma,
> -				     rxq_desc.desc,
> -				     mac_address);
> -		rc = -ENONET;
> +	rc = ibmveth_alloc_buffer_pools(adapter);
> +	if (rc)
>  		goto out_free_queue_mem;
> -	}
>  
> -	rc = ibmveth_alloc_buffer_pools(adapter);
> +	rc = ibmveth_register_rx_queues(adapter, mac_address);
>  	if (rc)
> -		goto out_unregister_lan;
> +		goto out_free_buffer_pools;
> +
> +	rc = netif_set_real_num_rx_queues(netdev, adapter->num_rx_queues);
> +	if (rc) {
> +		netdev_err(netdev, "failed to set number of rx queues\n");
> +		goto out_unregister_queues;
> +	}
>  
>  	rc = ibmveth_setup_rx_interrupts(adapter);
>  	if (rc)
> -		goto out_unregister_lan;
> +		goto out_free_all_queues; /* setup already disposed IRQs */

[Severity: Low]
The changelog says:

  "failures after successful LAN registration enter
   out_unregister_queues, then fall through to out_free_buffer_pools"

Is that the label graph the code actually has? Only the
netif_set_real_num_rx_queues() failure jumps to out_unregister_queues. The
ibmveth_setup_rx_interrupts() failure goes straight to
out_free_all_queues, and the ibmveth_alloc_tx_resources() failure goes to
out_cleanup_rx_interrupts which then does "goto out_free_all_queues".

All three do reach ibmveth_free_all_queues() and
ibmveth_free_buffer_pools(), so the "RX pools are not leaked" part still
holds; only the description of which label the paths enter looks off.
Could the changelog be adjusted to match?

>  
>  	netdev_dbg(netdev, "initial replenish cycle\n");
>  	ibmveth_schedule_rx_queue(adapter, 0);
> @@ -1357,10 +1441,12 @@ static int ibmveth_open(struct net_device *netdev)
>  
>  out_cleanup_rx_interrupts:
>  	ibmveth_cleanup_rx_interrupts(adapter);
> -out_unregister_lan:
> -	do {
> -		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> -	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> +	goto out_free_all_queues; /* cleanup already disposed IRQs */
> +out_unregister_queues:
> +	ibmveth_dispose_subordinate_irq_mappings(adapter);
> +out_free_all_queues:
> +	ibmveth_free_all_queues(adapter);
> +out_free_buffer_pools:
>  	ibmveth_free_buffer_pools(adapter);
>  out_free_queue_mem:
>  	ibmveth_cleanup_rx_resources(adapter);

[Severity: High]
Same pre-existing concern as above, now on the open-failure unwind: since
ibmveth_free_all_queues() cannot report failure, this path unconditionally
continues into ibmveth_free_buffer_pools() (dma_unmap_single() plus
dev_kfree_skb_any() of every posted RX buffer) and
ibmveth_cleanup_rx_resources() (dma_unmap of the buffer-list page,
free_page(), dma_free_coherent() of the RX ring).

If H_FREE_LOGICAL_LAN returned something other than H_SUCCESS and the LAN
is still registered, can PHYP keep writing received frames and the
rx_no_buffer counter into those unmapped or freed pages?

> @@ -1395,15 +1480,7 @@ static int ibmveth_close(struct net_device *netdev)
>  	synchronize_net();
>  
>  	ibmveth_update_rx_no_buffer(adapter);
> -	/* Full LAN teardown (subordinates arrive with register helpers). */
> -	do {
> -		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> -	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> -	if (lpar_rc != H_SUCCESS) {
> -		netdev_err(adapter->netdev,
> -			   "h_free_logical_lan failed with %lx, continuing\n",
> -			   lpar_rc);
> -	}
> +	ibmveth_free_all_queues(adapter);

[Severity: High]
This is the pre-existing log-and-continue behaviour moved into the helper,
so the same question applies on the close path: after
ibmveth_free_all_queues() the function proceeds to
ibmveth_free_tx_resources(), ibmveth_free_buffer_pools() and
ibmveth_cleanup_rx_resources() regardless of the hypercall result.

The changelog states:

  "free_all_queues() runs before free_buffer_pools() on open failure
   and close, so PHYP cannot retain a registered LAN while its
   DMA-backed RX pools are released."

Does that hold when the hypercall does not succeed? The ordering only
gives that guarantee on H_SUCCESS; on a non-busy failure the LAN may still
be registered when the pools go away. Could the changelog note that, or
could the helper propagate the status so close() can keep the DMA
mappings?

I also checked the end of the series (1f83fd44d867) and
ibmveth_free_all_queues() is unchanged there, so this is not addressed by
a later patch in the series.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
> index bf5dd5703773d..fae3473cc4985 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.h
> +++ b/drivers/net/ethernet/ibm/ibmveth.h
> @@ -268,6 +268,17 @@ static int pool_active[] = { 1, 1, 0, 0, 1};
>  
>  #define IBM_VETH_INVALID_MAP ((u16)0xffff)
>  
> +struct ibmveth_hcall_stats {
> +	u64 reg_lan_queue;	/* H_REG_LOGICAL_LAN_QUEUE */
> +	u64 reg_lan;		/* H_REGISTER_LOGICAL_LAN */
> +	u64 add_bufs_queue;	/* H_ADD_LOGICAL_LAN_BUFFERS_QUEUE */
> +	u64 add_bufs;		/* H_ADD_LOGICAL_LAN_BUFFERS */
> +	u64 add_buf;		/* H_ADD_LOGICAL_LAN_BUFFER */
> +	u64 free_lan_queue;	/* H_FREE_LOGICAL_LAN_QUEUE */
> +	u64 free_lan;		/* H_FREE_LOGICAL_LAN */
> +	u64 send_lan;		/* H_SEND_LOGICAL_LAN */
> +};

[Severity: Low]
This isn't a bug, just a note on what was checked. At this commit only
reg_lan and free_lan have writers and none of the eight counters has a
reader, even though h_add_logical_lan_buffer(),
h_add_logical_lan_buffers() and h_send_logical_lan() already exist in the
driver.

Looking at the end of the series (1f83fd44d867), all eight counters get
both producers and a consumer through ethtool -S ("hcall_reg_lan_queue",
"hcall_reg_lan", "hcall_add_bufs_queue", "hcall_add_bufs", "hcall_add_buf",
"hcall_free_lan_queue", "hcall_free_lan", "hcall_send_lan"), so this
resolves within the series and needs no action.

For completeness: reg_lan is incremented even when registration fails, and
free_lan is incremented once per H_BUSY retry. Given the field comments
name the hypercalls and the struct is described as hypercall statistics,
invocation counts look like the intent, so no change is requested here
either.

