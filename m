Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02E7606A331
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 01:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZVPkEAb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXnnc2fgXz2xyj;
	Mon, 23 Nov 2026 12:06:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795395972;
	cv=none; b=jKHA4D3Vf6AmnQnHR313VUhmykfvs7xr2wV92s5WXwx55PQzgfJZ57UFdpiEdAsg47GYjZHk0harHVV9jcYcoCgCh+kBm1RJBQw34GzZCNEcT3MV/i48DTDw90ZoLPYGqPPD04D9JngjenA3XDZT/1dbBxck7HU+neAAgqJ0Nr850xb5/JXd5iDSMMwnUfH8r1CsHI79IawcreXW6Xz86NfUhHswtCDd2lqOpAetiy0NT8J/W+NgoT3VOynBOdb+eGPBrOnHLe60FyK6vSOuAUU+WX9O2zecLzJrKpD7gzlOntIQxbX/3/JJvwU58zt4TzqJV7U1z96OMRC4K9Uspg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795395972; c=relaxed/relaxed;
	bh=Pc0mbPEt0qUdPQBtJKfrlvydOvmXsdAhSeL1Yff4aoM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hnYbd9co/vN3SDPKqiwfrAKsqDHMtF4guDerVDebnL7fDMAJ0RYrDM0L/sqBwixw5g/DFdW/aEyUo2dMRf+q5H3A8rppNvxFU4cSODYBy4Wj/OXDa0IhPzOs/60ZVST3kLVCXtBazdFA17pKFZu2nSPJwKKyHMnMVYf5qcec4xIGOXdRQKRjdmEbTVYBc7NP5u/ZYIpH9laXhEnS2bPevmN2bfGPN4k835yyzlrpB/A0EyRbL3rlnUkU8UbMGj0prTZxhqXS1AJCezjpzn8z2r2zUaLgGAPEg8/giK0/jyoYPG3S+pwQZhkEkXXpgVB8CPuw/dViI6dHufwyU1FZ5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZVPkEAb; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZVPkEAb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXnnb1Hjjz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 12:06:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2BF026147B;
	Mon, 23 Nov 2026 01:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97691F000C0;
	Mon, 23 Nov 2026 01:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795395967;
	bh=Pc0mbPEt0qUdPQBtJKfrlvydOvmXsdAhSeL1Yff4aoM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BZVPkEAbcTojVg8JMq9AXiu3/+6RVnbR+VC+8EeuzlUt8+/jgMB+eMo2CgQIyd0JH
	 sw0LEDjpOO6jRRgEiAvAscgXh7sPQwhrysjSaqVnLvKaQ4nwZ5VXunKm4dKuD9UAtd
	 W8w3mXbynmYuJy0Cfo9VrG96OIyEwBzaGfeGxS93ySTlPS6H+RDMm7Xa/Ka30FjqsZ
	 C6MPKq1InnhNzmkctgEus+74d7H5wYnMG1NaTBl8GzNQXApzjc4q1rm2qsEAhrMVJa
	 RxIXKdoxjKT3rJg8JuFJdMAys8nPPAamrKiX5NCsJ+I22C6LcLEaVXCqnwK5im11Y3
	 5IKtIvtVHMAog==
Subject: Re: [PATCH net-next 2/8] ibmveth: Refactor RX resource allocation for
 MQ RX bring-up
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, horms@kernel.org, davemarq@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Mon, 23 Nov 2026 01:06:06 +0000
Message-ID: <179539596618.3135.16248027677119364858@kernel.org>
In-Reply-To: <20261119000711.18093-3-mmc@linux.ibm.com>
References: <20261119000711.18093-3-mmc@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The kernel-doc for ibmveth_cleanup_rx_resources() in
  drivers/net/ethernet/ibm/ibmveth.c says "Free all RX queue resources",…

--

ibmveth: Refactor RX resource allocation for MQ RX bring-up

This moves the filter list and per-queue RX ring and buffer list
allocation out of ibmveth_open() into helpers that loop over
num_rx_queues and undo their own partial failures. ibmveth_close() and
the open() error path now free through the same helpers.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index fc50036d5d265..559c4d2d957bb 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -159,6 +159,177 @@ static unsigned int ibmveth_real_max_tx_queues(void)

[ ... ]

> +/**
> + * ibmveth_cleanup_rx_resources - Free all RX queue resources
> + * @adapter: ibmveth adapter structure
> + */
> +static void
> +ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
> +{
> +	struct device *dev = &adapter->vdev->dev;
> +	int i;
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		if (adapter->buffer_list_addr[i]) {
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

[Severity: Low]
This isn't a bug, but is the kernel-doc for ibmveth_cleanup_rx_resources()
accurate? It says "Free all RX queue resources". The body only frees
buffer_list_addr[i] with its buffer_list_dma[i] mapping, plus the coherent
ring at rx_queue[i].queue_addr.

It doesn't free the per-queue buffer pools in adapter->rx_buff_pool[queue][*]
(the free_map, dma_addr and skbuff arrays and the DMA-mapped skbs). That is
why ibmveth_close() still frees them in a separate loop after calling this
helper:

	ibmveth_cleanup_rx_resources(adapter);
	ibmveth_free_filter_list(adapter);

	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
		if (adapter->rx_buff_pool[0][i].active)
			ibmveth_free_buffer_pool(adapter,
						 &adapter->rx_buff_pool[0][i]);

The ibmveth_open() error path also keeps its own out_free_buffer_pools
label for the same reason.

At the end of the series this doc line hasn't changed. There, close() and
the open() error path call ibmveth_free_buffer_pools() separately before
this helper. So the helper doesn't seem meant to free the pools.

Could the comment be narrowed to describe the buffer lists and RX rings it
actually frees? The name could also be changed to match its allocator,
ibmveth_alloc_rx_queues().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119000711.18093-1-mmc%40linux.ibm.com

