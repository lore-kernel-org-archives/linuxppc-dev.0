Return-Path: <linuxppc-dev+bounces-28517-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A22ECA5FA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:33:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvSyT6QXdz2yD3;
	Wed, 30 Sep 2026 05:33:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790710401;
	cv=none; b=Rup0Mr71B+zWUwayIbDBhVKiqQN/1gEuIonaoLB9MYBMYpSCnWlaGRUQtoFQ1O8oIYVquaiHwhX4zJiFsURZUiayiMXH13DBhIomgpuFh3Aft5p7x3aR5BSc8KNlrbSiFC9d++N0+Mhbc8d1CWYIaOt8YY8VfYT9b+i+lqcFqHz2Fgs8xjHqqQDkGrCd9OmaPLzeQljA3WOnuiHnPNJOVxBs47uBK0TWqC6U0hHo67D1oEr4+RYRZti2ziM+bWYUyZxZ0NgLeODFOW/6e1fPwhLE6tCccvLQhf7AMHhoZzbimw6q3GMXsPYjLyDplytO3pUuawtr81w8lekLkS+Mew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790710401; c=relaxed/relaxed;
	bh=uuTiuxp2mvND32WnJrw5yJBDRTO/GoFqn57Of633a0w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ap9iZpP3w3xmZY7+M6s507jz4sIFWVwoHVYaXlAWeE4X3RTSCHrtUsiKVZoq382m5FuMVvCp0aJCfIA2CF35hkWFyhXXLmI8Bo7ndmKo76DZJwg8KNnzhGd1FSAwKNM9foljAqDQhpn9D2seEmYH3f6bA3Lfa0KHhGONZFqMJXcYP3lo/crvEaWLMVIIGs+0BBTl1d1I0hoQt7ov/u9BqjWPJclU98q/XuZsHqniQIjolMigz/XCUd3pqUdwaPjfo6TBFm57Z6opLVo5sFVwLYgdq2VfMlW8iL5T29QynW1aI5HPecWvuA1TfSohfS/E3OnyvE9/oULOk/u0K1CLyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3/2YrxX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3/2YrxX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvSyS5xPWz2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:33:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 51A776022B;
	Tue, 29 Sep 2026 19:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345FF1F000FF;
	Tue, 29 Sep 2026 19:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710397;
	bh=uuTiuxp2mvND32WnJrw5yJBDRTO/GoFqn57Of633a0w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B3/2YrxX8QQ+zme40Ix0XobIn+t2O6N/LRvDefdoe4rdLviIRBVckTYDWeg0PF2vv
	 ObX5B0CMtIZuRTEBYGGY2PObg0LqPSyLfh4pXqlfg+efWPnUfvKOe/+ghpyCJe5DKv
	 z2Yhn7vnPgEYa3cM8uYTRVQrKtTYVNKc8i+jNKWEROBbIo326C9w+tcAP/tC9ql2rQ
	 aRMV+VR5+Wdty50bEgit7BJobeEy3W0WH3uelGlFyHVDwRjL90c5dH7apMeoiL7h0m
	 eScmaEt2uT6FLnsMQ/ndQn7RJg7Z0XfFnvbnJ34+ZrjyyeaTs0hCHMItQoO6SgMjSg
	 ehVt4iOVdvfpg==
Subject: Re: [PATCH net-next v7 03/15] ibmveth: Refactor RX resource
 allocation for MQ RX bring-up
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Tue, 29 Sep 2026 19:33:15 +0000
Message-ID: <179071039577.434549.807910519500023697@kernel.org>
In-Reply-To:
 <2320895ef517f70b063eca84766723ff20019748.1790319558.git.mmc@linux.ibm.com>
References:
 <2320895ef517f70b063eca84766723ff20019748.1790319558.git.mmc@linux.ibm.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch silently fixes an existing DMA mapping leak in
  ibmveth_open().

Pre-existing issues:
- [High] If ibmveth_alloc_buffer_pool() fails after
  ibmveth_register_logical_lan() has succeeded, ibmveth_open() jumps to…
- [Medium] In ibmveth_open(), the buffer-pool unwind and the TX LTB
  unwind share the loop variable `i`.
- [Medium] ibmveth_update_rx_no_buffer() checks
  adapter->buffer_list_addr[0] and then loads it again, with no lock and…

--

ibmveth: Refactor RX resource allocation for MQ RX bring-up

This patch moves the filter list and per-queue RX buffer list and RX ring
allocation out of ibmveth_open() into new helpers, and makes both the
open() error path and close() free them through the same cleanup helpers.
It also NULL-checks buffer_list_addr[0] in ibmveth_update_rx_no_buffer()
and sets rc = -ENOMEM before the TX LTB allocation loop.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 7cb828b476c1b..01efd318baabb 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -390,8 +578,12 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>   */
>  static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>  {
> -	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
> +	__be64 *p;
>  
> +	if (!adapter->buffer_list_addr[0])
> +		return;
> +
> +	p = adapter->buffer_list_addr[0] + 4096 - 8;
>  	adapter->rx_no_buffer = be64_to_cpup(p);
>  }

[Severity: Medium]
This is a pre-existing race and was not introduced by this patch, but the
new check makes it a little more visible.

set_csum, set_tso, change_mtu and pool_store all do a driver-internal
close/open. netif_running() stays true during that, and netpoll is not
disabled. That means this path:

  ibmveth_poll_controller()->ibmveth_replenish_task()
    ->ibmveth_update_rx_no_buffer()

can run at the same time as:

  ibmveth_close()->ibmveth_cleanup_rx_resources()
      free_page((unsigned long)adapter->buffer_list_addr[i]);
      adapter->buffer_list_addr[i] = NULL;

The NULL check and the pointer load are two separate plain reads of
buffer_list_addr[0], with no lock and no READ_ONCE().

Could the reader pass the check, then reload NULL and fault at offset
0xff8? Could it also read the page after free_page() has run, as the
baseline code already could?

As far as I can tell this is dealt with later in the series.
ibmveth_close() clears adapter->opened first, calls synchronize_net(), and
reads the no-buffer count under replenish_lock before freeing anything.
ibmveth_poll_controller() returns early when !opened.

[ ... ]

> @@ -752,26 +902,12 @@ static int ibmveth_open(struct net_device *netdev)
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

[Severity: Medium]
This isn't a bug introduced by this patch, but the buffer pool unwind and
the TX LTB unwind share the loop variable i.

If ibmveth_alloc_buffer_pool() or request_irq() fails, out_free_buffer_pools
runs its own while (--i >= 0) loop, which leaves i == -1. Execution then
falls through to this loop.

Doesn't this loop then run zero times and leak every tx_ltb_ptr[] buffer
and its DMA mapping?

This looks like it gets fixed later in the series.
"ibmveth: Refactor buffer pool management for per-queue MQ RX" moves the
pool loop into a helper, and "ibmveth: Refactor TX resource allocation in
open/close paths" moves the TX allocation into ibmveth_alloc_tx_resources()
at the end of open(). After those patches the two unwinds no longer share
an index.

> -	}
> -
> -out_unmap_buffer_list:
> -	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
> -			 DMA_BIDIRECTIONAL);
> -out_free_queue_mem:
> -	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
> -			  adapter->rx_queue[0].queue_addr,
> -			  adapter->rx_queue[0].queue_dma);
> +	ibmveth_cleanup_rx_resources(adapter);

[Severity: High]
This is a pre-existing issue, but it is on the unwind path this patch
rewires.

The buffer pool failure branch in ibmveth_open() runs after
ibmveth_register_logical_lan() has already succeeded:

	if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
		netdev_err(netdev, "unable to alloc pool\n");
		adapter->rx_buff_pool[0][i].active = 0;
		rc = -ENOMEM;
		goto out_free_buffer_pools;
	}

The request_irq() failure path calls h_free_logical_lan() before its goto.
This branch does not.

Execution then reaches ibmveth_cleanup_rx_resources() and
ibmveth_free_filter_list(). Those call dma_free_coherent() on the RX queue
and unmap and free the buffer list and filter list pages, while PHYP still
has all of them registered.

Can the hypervisor then write RX descriptors or the no-buffer counter into
freed memory?

The later patches in the series seem to address this.
"ibmveth: Refactor TX resource allocation in open/close paths" adds
h_free_logical_lan() on this path. "ibmveth: Add RX queue register helpers
for MQ" allocates the buffer pools before registration.

>  out_free_filter_list:
> -	free_page((unsigned long)adapter->filter_list_addr);
> -out_free_buffer_list:
> -	free_page((unsigned long)adapter->buffer_list_addr[0]);
> +	ibmveth_free_filter_list(adapter);

[Severity: Low]
Does this change behavior on the TX LTB failure path in a way the commit
message doesn't mention?

In the baseline, the filter list was mapped before the TX LTB loop, and a
failed ibmveth_allocate_tx_ltb() jumped to out_free_tx_ltb. That label sits
below out_unmap_filter_list, so the unmap was skipped. The page was then
freed by free_page() in out_free_filter_list while its DMA/TCE mapping was
still live.

After this patch the same failure reaches ibmveth_free_filter_list(), which
unmaps before freeing.

The commit message describes this as a helper extraction:

  "Runtime behavior stays single-queue (num_rx_queues is still 1)."

Should the commit message mention this fix? Should it also be split out
with a Fixes: tag, so that stable trees pick up the filter list unmap fix?

>  out:
>  	napi_disable(&adapter->napi[0]);
>  	return rc;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790319558.git.mmc%40linux.ibm.com

