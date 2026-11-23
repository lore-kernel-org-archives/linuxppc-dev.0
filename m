Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BB4606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvcaYkKC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXnng10wkz2xdb;
	Mon, 23 Nov 2026 12:06:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795395975;
	cv=none; b=losy9JLqqmwoJhlXm/uXF9ARuqGYY41pPbmPqQio82NmMsmzH6x4Z33Zfh9v0bwI9OnYcrsXkGktI4QGMQK8hT9y4OvduPqRc3eI8iUKe3PbowfqH7PW/sf9TYPOTte8VOC9ciFQbfTOfjg8sxo1W84bK+wMHnHxiSJLRGanmGfVjZAe54XLAUaCS2LQiTyjz+ye3oNSjoPwZ1L/AaKE1BDfk95EJBjDbMTv9WLPTXsXfYvtxeU4AehRFbmiX9RU+/e8Wf1qRWSq7wEfDxXPeUF4RHp/S/Aj1zZNG8eqpxkNX+RykYUbVb+KEOVoSGGgyaVWn9c9QFg+XX4mdyV/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795395975; c=relaxed/relaxed;
	bh=cJ7NUMGwLfTWrECF1miPTjZFFRtfLbQ3wKxWhov3nIo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bp+7U4WtJwBZnVw3YqKA6BRB+t0a0JfVtGspYerMlskuR37mnAK2QZCqIXkSxJYOAvG0inyLiS7+KzJlJp/r8vNplLJ/6xiCWV9D7aRqGD0pXnPcRbY0oSe54p0P0WJlXi3cK2Ptpbk8w3nX/P8ErQkFjUZQEq+0+dZ+bDI5rjOZ59oxhoO8DXc1fphO3XlpkSpHgdMfitqicnEyAyog/+Eo2U2DIPEw3ZlaKmqMQP4+HvaYO+f8bydy3BGp8AKMgwNjvDQ7CtWoKbLbtqh58Z+TjxMF3L9lbZiTLiA1qBtdd3Q7UmyOTAgBMMH37X694M7QdMv6mwVDpFLtnUfa8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvcaYkKC; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvcaYkKC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXnnd4LZwz2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 12:06:13 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 62A0861811;
	Mon, 23 Nov 2026 01:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D0F1F000C0;
	Mon, 23 Nov 2026 01:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795395971;
	bh=cJ7NUMGwLfTWrECF1miPTjZFFRtfLbQ3wKxWhov3nIo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QvcaYkKC4G2oQzlD44duBsrNEz6biI0Q4oN6LFVMO2j6yeyKNj4w7yjaJjJcGPH1x
	 qaLLQ6IdqspEnG+RYMvGOH0N6LikLfZPOsxZn8g+pGCrwDd2wxN4NLGNb44zBAQ4f5
	 1720udNgQory108y0R7qaR1PVfCxgGi5e8n82/GJGmtjq3uLSKhIZTupRuvwtOAnqj
	 PgJZ0bC6DhwPjEc+EArX0MV703hUkS2/WMFVvpi+78J0oiI9xi4/LQlQ2ANTCNECFq
	 dxHu8azi6/bGiEH9Qv8SAIEAt2S1LSueEM67x1hguJPVWoNpoYiJpMtXEiWwccDFPC
	 MYpmFrCF4sJ+Q==
Subject: Re: [PATCH net-next 5/8] ibmveth: Refactor TX resource allocation in
 open/close paths
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, horms@kernel.org, davemarq@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Mon, 23 Nov 2026 01:06:09 +0000
Message-ID: <179539596966.3135.308887197140765933@kernel.org>
In-Reply-To: <20261119000711.18093-6-mmc@linux.ibm.com>
References: <20261119000711.18093-6-mmc@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In ibmveth_open() (drivers/net/ethernet/ibm/ibmveth.c), this
  patch moves the TX long-term-buffer DMA mapping…
- [Low] The commit is titled and framed as a refactor ("Move TX LTB
  allocation and free ... into ibmveth_alloc_tx_resources() and…

--

ibmveth: Refactor TX resource allocation in open/close paths

This moves TX long-term buffer allocation and free into the new helpers
ibmveth_alloc_tx_resources() and ibmveth_free_tx_resources(). It also
moves the TX LTB allocation in ibmveth_open() to after RX and NAPI are
running. To cover that, it adds netif_tx_disable() at the start of open()
and starts the queues under netif_tx_lock_bh().

> open() now allocates the TX LTBs last, after RX is running. It stops
> TX with netif_tx_disable() first: on a first open the queues are not
> DRV_XOFF, so generic XDP_TX could transmit before the LTBs exist. It
> starts TX under netif_tx_lock_bh() once they do. A TX allocation
> failure unwinds RX the way close() does.

[Severity: Low]
This isn't a bug, but could the commit message say why the reorder is
needed?

The subject and first paragraph present this as a refactor into helpers.
The patch also changes the bring-up order of ibmveth_open(). Before this
patch, the TX LTBs were allocated right after ibmveth_alloc_rx_queues().
That was before h_register_logical_lan() and before NAPI was enabled.

Three of the changes are only needed because of the new order:

  - the new netif_tx_disable() at the top of open()
  - the netif_tx_lock_bh() around netif_tx_start_all_queues()
  - unwinding the whole RX bring-up when the TX allocation fails

The window that the netif_tx_disable() comment describes ("once NAPI is
up and before the LTBs exist") did not exist before this patch.

Would the ordering change fit better in its own patch with a stated
reason, separate from the helper refactor?

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index ab5df17940042..8f32f75f2d7fd 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1096,12 +1143,6 @@ static int ibmveth_open(struct net_device *netdev)
>  	if (rc)
>  		goto out_free_filter_list;
>  
> -	rc = -ENOMEM;
> -	for (i = 0; i < netdev->real_num_tx_queues; i++) {
> -		if (ibmveth_allocate_tx_ltb(adapter, i))
> -			goto out_free_tx_ltb;
> -	}
> -
>  	mac_address = ether_addr_to_u64(netdev->dev_addr);
>  
>  	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |

[ ... ]

> @@ -1136,26 +1177,35 @@ static int ibmveth_open(struct net_device *netdev)
>  	 */
>  	rc = ibmveth_setup_rx_interrupts(adapter);
>  	if (rc)
> -		goto out_free_buffer_pools;
> +		goto out_unregister_lan;
>  
>  	netdev_dbg(netdev, "initial replenish cycle\n");
>  	ibmveth_schedule_rx_queue(adapter, 0);
>  
> +	rc = ibmveth_alloc_tx_resources(adapter);
> +	if (rc)
> +		goto out_cleanup_rx_interrupts;

[Severity: Medium]
With the new order, can open() fail on CMO partitions where the old order
worked?

With FW_FEATURE_CMO, every VIO DMA mapping draws on the device's IO
entitlement through vio_dma_iommu_map_phys()->vio_cmo_alloc(). That call
returns -ENOMEM when the free reserve plus the excess pool is smaller than
the request.

By the time ibmveth_alloc_tx_resources() runs, NAPI is enabled and
ibmveth_schedule_rx_queue(adapter, 0) has scheduled the first replenish.
The replenish runs in NET_RX softirq, either in ksoftirqd or at the next
IRQ exit. It can map and post every RX pool buffer before or while the TX
LTBs are mapped:

ibmveth_open()
  ibmveth_setup_rx_interrupts()
  ibmveth_schedule_rx_queue()
    __napi_schedule()
      ibmveth_poll()
        ibmveth_replenish_task()
          dma_map_single()      <- per RX buffer, uses entitlement
  ibmveth_alloc_tx_resources()
    ibmveth_allocate_tx_ltb()
      dma_map_single()          <- can now return DMA_MAPPING_ERROR

The two failures are handled differently. An RX mapping failure in
ibmveth_replenish_buffer_pool() bumps replenish_add_buff_failure and
breaks out of the loop.

A TX LTB mapping failure makes ibmveth_alloc_tx_resources() return
-ENOMEM. open() then tears down the IRQs, the logical LAN registration and
the RX pools, and the interface does not come up.

The direct close()/open() pairs (change_mtu, pool sysfs, set_csum and
set_tso) are affected too. There, IFF_UP stays set but the adapter is not
open.

Before this patch, the TX LTBs were mapped before any RX buffer went to
PHYP, so TX always got entitlement first.

ibmveth_get_desired_dma() seems to make this more likely:

drivers/net/ethernet/ibm/ibmveth.c:ibmveth_get_desired_dma() {
    ...
	/* add size of mapped tx buffers */
	ret += IOMMU_PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE, tbl);
    ...
}

This counts one 64K TX buffer, but open() maps one LTB per real TX queue.
The default is min(num_online_cpus(), 8) queues, so up to 512K. Once RX
has taken its share, is there any entitlement left for TX?

The order is the same at the end of the series. In "ibmveth: Split RX
poll into per-slot helpers for MQ", ibmveth_alloc_tx_resources() still
comes after ibmveth_schedule_rx_queue().

> +
> +	/* Start under the xmit lock so a sender that tests DRV_XOFF
> +	 * there sees the LTBs this open just published.
> +	 */
> +	netif_tx_lock_bh(netdev);
>  	netif_tx_start_all_queues(netdev);
> +	netif_tx_unlock_bh(netdev);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119000711.18093-1-mmc%40linux.ibm.com

