Return-Path: <linuxppc-dev+bounces-26504-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27057C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 23:39:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbbf12tZMz2yhD;
	Fri, 04 Sep 2026 09:39:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788459037;
	cv=none; b=PIWdCJ7oHNlBqnRvSXwecm/IfkcSsrpCmtIQhdhrVlno3nC97cQcxz2SHahQ6pyLgcIX8bUjax0dwdHSz0rwvmm2JbdSPxXgWotpy1Ct1A4d3snnYb3R7DsTGMOd7EcK9rhAMmapTgi1jPUHHfGXZbQf/2WO83xokMhhuPxFoHRF5oZ1nqSjDj/MiMWNaiFG/zl6i23WRT0/g03sv3akz3UFUKNbNPkUmTexnhPWFcuRWlnnz8mM/HWNutNT9ZN/9R1U4jrTEn1s8PAgesFpWueI5qu9OXPyvVoBuQ+OIYu03N5ppvBd6gsnmh4q+O8gI80oNescfWXZXitY1zs+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788459037; c=relaxed/relaxed;
	bh=EZlP/Imn7aAf0lQOYpQmpu8L+jMozGbihEKqDIIpemk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RkxcHwvP8Q5lyzAgfEIRZtvOwUq0CLaBMGkJ20/SM+H+Uuwj0vhGQ//VHJQZQQ92vQf/u+VLu7UXB3HnmmYELmkwG3xb5m1To0n1Z0Jy/u4s75/D0ykvW1yJ3ShFJqpbwj2jSl+/EJeYHEpxEdtmARx7jE9xHNOhuNBQU79PdD7cRhnW8ZTy+NDZX6wLxaIzNBLLumenkgAk0Lh8/xBvxSQXTAgKSGPtRYvP/zzFNuq6OgBL4wLCaaJlCqu7XNofWmnYSzsuYosBzLooAYlbzQkiuC8AzCkqJ78fpcThIu6dzYjIMuXkeNf1l/8qAxS+V0gyR1SBPlS3ygQDGKnDfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5MfGesI; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5MfGesI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbSM03M7jz2y2R
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 04:10:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1E68643F05;
	Thu,  3 Sep 2026 18:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282D01F00A3D;
	Thu,  3 Sep 2026 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459034;
	bh=EZlP/Imn7aAf0lQOYpQmpu8L+jMozGbihEKqDIIpemk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=a5MfGesI4R8EcNIuAafDoLHJxn3pvDoZ59as0GGSHBPWRhziXfIKsYpSrpaQx7JSZ
	 GxLTJ69NPy+cFZwD9YCLntjgytNI4ST0jAWoyNxNRXKKc9srBY2giKKpp0y4a2kSR+
	 TLcZuWcZUZXr5pVFf9+w4v48amyMFI6jAPDlEilSO2tJBS+BGDOmG7vD7rmajx0pAA
	 VQeHe3ueVE42Ay/Tvac6Gc3YnGRuovV0HxsN40Z/8AfMy7rIlYscKHaXXazdoXIa+c
	 6ZPp7G0Tu3xaB/lRpg+D7q4Na3JUt3DoLFeTMdlLtf6f9RpeG9yPg628hBwmhKMylS
	 /3r25cvTclY1A==
Subject: Re: [net-next,v6,04/15] ibmveth: Refactor buffer pool management for
 per-queue MQ RX
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Thu, 03 Sep 2026 18:10:32 +0000
Message-ID: <178845903273.3394541.7371277620792902309@kernel.org>
In-Reply-To:
 <8cec120af540e5e355dd6a1d3a6498dc0a7a98e4.1788102125.git.mmc@linux.ibm.com>
References:
 <8cec120af540e5e355dd6a1d3a6498dc0a7a98e4.1788102125.git.mmc@linux.ibm.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 0 · Low: 2

- [Low] The refactor silently repairs a pre-existing DMA-coherent memory
  leak in ibmveth_open() without a Fixes: tag.
- [Low] The err_cleanup comment in ibmveth_alloc_rx_queues()
  (drivers/net/ethernet/ibm/ibmveth.c:280-285) asserts an invariant the…

Pre-existing issues:
- [High] In ibmveth_open() at this commit, the new failure branch for
  ibmveth_alloc_buffer_pools() (`goto out_free_tx_ltb`,…

--

ibmveth: Refactor buffer pool management for per-queue MQ RX

This moves the five RX buffer pools from adapter scope to
rx_buff_pool[queue][pool] and adds ibmveth_alloc_buffer_pools() /
ibmveth_free_buffer_pools() plus per-queue helpers, wiring them into
open() and close(). Queue 0 stays the template for pool geometry and
activation; runtime is still single-queue.

A few questions below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index d2dad9e6068e0..37a6d13e603ea 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... helper additions snipped ... ]

> @@ -858,16 +996,9 @@ static int ibmveth_open(struct net_device *netdev)
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

[Severity: High]

This isn't a bug introduced by this patch, but the rewritten jump lands on
an unwind that frees memory PHYP was just told about, without any
deregistration hypercall.

At this point ibmveth_register_logical_lan() has already returned
H_SUCCESS. The chosen label then does:

out_free_tx_ltb:
	while (--i >= 0)
		ibmveth_free_tx_ltb(adapter, i);
	ibmveth_cleanup_rx_resources(adapter);
out_free_filter_list:
	ibmveth_free_filter_list(adapter);

and ibmveth_cleanup_rx_resources() dma_unmap_single()s buffer_list_dma[0],
free_page()s buffer_list_addr[0] and dma_free_coherent()s
rx_queue[0].queue_addr, while ibmveth_free_filter_list() releases the
filter page. Those are exactly the three regions handed to the hypervisor
by the registration.

The neighbouring request_irq() failure path does the opposite order:

		do {
			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));

		goto out_free_buffer_pools;

Can PHYP write into the buffer-list page after it has gone back to the page
allocator on the pool-failure path? It stays an independent writer of that
page for the per-page no-buffer drop count that
ibmveth_update_rx_no_buffer() reads back.

The same ordering exists in the parent commit, and the rest of this series
does address it: the later patch that refactors TX resource allocation
issues h_free_logical_lan() before the RX DMA teardown, and the patch
adding the RX queue register helpers moves ibmveth_alloc_buffer_pools()
ahead of registration so this window disappears. Would it be worth
ordering the pool allocation before registration here instead, so the
intermediate commits in the series do not carry the window?

>  
>  	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
>  	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
>  			 netdev);
> @@ -892,11 +1023,7 @@ static int ibmveth_open(struct net_device *netdev)
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

[Severity: Low]

The commit message describes the repair this hunk performs and then
declines a tag:

    Pulling the pool loop out has one side effect worth naming: it no
    longer consumes open()'s loop index, so a pool failure reaches
    out_free_tx_ltb with i still at real_num_tx_queues and the TX LTBs
    actually get freed. The shared index that swallowed them was
    pre-existing, so there is no standalone Fixes: tag;

Should this carry a Fixes: tag for the commit that added out_free_tx_ltb
and its second walk over the same index?

Before this patch the old loop at out_free_buffer_pools drove i down to -1,
so the following while (--i >= 0) at out_free_tx_ltb evaluated -2 and freed
nothing. Every failed ndo_open after a successful TX LTB allocation
therefore leaked real_num_tx_queues buffers, one dma_alloc_coherent() of
adapter->tx_ltb_size each, reachable both from an
ibmveth_alloc_buffer_pool() failure and from a request_irq() failure.

Without a tag, stable trees keep the leak and the repair is only reachable
by picking up this refactor.

One further note on code this patch does not touch, but which the
immediately preceding patch in the series added:

[Severity: Low]

Does the err_cleanup comment in ibmveth_alloc_rx_queues() state an
invariant the function actually holds?

	/*
	 * Every failure path above releases what it had already allocated
	 * for queue i, so each index here is either fully constructed or
	 * fully empty. Do not unmap buffer_list_dma[] without the matching
	 * buffer_list_addr[] check: the two are only ever set together.
	 */

The buffer-list mapping failure path leaves rx_queue[i].queue_addr
allocated:

		if (dma_mapping_error(dev, adapter->buffer_list_dma[i])) {
			...
			free_page((unsigned long)adapter->buffer_list_addr[i]);
			adapter->buffer_list_addr[i] = NULL;
			adapter->buffer_list_dma[i] = 0;
			goto err_cleanup;
		}

so index i arrives at err_cleanup partially constructed, and it is the
per-pointer if (adapter->rx_queue[i].queue_addr) check that frees the ring.
Nothing leaks today, but the first half of the comment contradicts the
second half. Could the wording be changed to say the cleanup loop frees by
pointer presence rather than claiming each index is all-or-nothing?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788102125.git.mmc%40linux.ibm.com

