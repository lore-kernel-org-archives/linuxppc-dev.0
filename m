Return-Path: <linuxppc-dev+bounces-25515-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F296C56205
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 18:37:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGGGV4jXhz3bwf;
	Fri, 07 Aug 2026 04:37:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786041426;
	cv=none; b=VVguLHWQBiR/dCUQ+iX/rMuyVmrATr99UNLm6yhoo6bGyV9c9Mb9Vz7GnJVKu5tuxcQy/6Fp07J1yG22G7c3m3AlYb/Wfc1/Hc88qAv46FqlSQ6sIh3/YZLWK58zsF6iaZrF/nCtnN6oj4YrcdUtWtV8f5/vie1EZssgppgv1gr+WCTfJKXAZ4NnOoTBNtMbmiHqyWmX+S/tbp4lU97VZM8ghdDbTKs23l+Qlmy3eJuVtQo7xDx6DIdhJKYtvowrgMIdQCFbs1oWZq2nYctOKtSCdmUKJtbFvh9TpUWLfVjJ2RoLn9sPNHVmApY+s8NmoD1JPZc7ugnHQw9l3B9RxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786041426; c=relaxed/relaxed;
	bh=5D+kt9Ji/YpIEH/DJsU9gAW+siSqFCe9WpV0JXtz8gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pvloz0XdrBquuuYFyTubXM6VUL9zUEHDil0e4NZgmrzOMx+xXBottAy6nLoX0GausR6/2RhmtuSW4tWGOKMViGqW3Dv3JXIoPnOGRBQlDZiv40TouE/qTTyxq4kPFKLBaOlvKrFKkD5k/ekl4Pt4e3/krBbGHcNznjUe+yBh724P8KScfUe4B1xnBL7yqgMwpPQUtqu1jkdRZQtwO5YR5AG1P8xs8o4zz23bO/8B2rnEXKMXnBTKtNr8gK0SDNkrekMrwC0wybyHwoIM1WlVfVZF3+cnuQbuVpdusJ79mRIPuhljzewy1xuTSZVaubPRDwxierDzrA6UGbBrdjS3bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxWirj8v; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxWirj8v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGGGT07cmz3brM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 04:37:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A73F16004E;
	Thu,  6 Aug 2026 18:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4911F00A3D;
	Thu,  6 Aug 2026 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041422;
	bh=5D+kt9Ji/YpIEH/DJsU9gAW+siSqFCe9WpV0JXtz8gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IxWirj8veGuW3/yidWhisUR53I3S5aTzCtKSXD2gxWlfFRMPb29SX78U6uoaZu3w3
	 zIVThS5O2AIsa9Bk3F/JKwfkB8H6EARnstKRjLDlgkpZSgun05dJuC4urHMwXY/loq
	 KlM5mhNgm8UBdUecCVQY9CQEGaib+hDLYV+j7uCy86ejL6GJgjBm+5TJcRcGK5VkQL
	 CX2R+XrASGuKwVxdNLQTJ4qYC12FhrspB/TcpxtBkIEDYnACylYC7IrQrHtp0TLDZt
	 EDB/nyPR3es/7WkPyrnxgath9VgiIZ96cCEawq800oz7FmQUSSyxwdXA5f7+uTy7B1
	 qX91gTep5cB6A==
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
Subject: Re: [PATCH net-next v4 03/14] ibmveth: Refactor RX resource allocation for MQ RX bring-up
Date: Thu,  6 Aug 2026 11:37:01 -0700
Message-ID: <20260806183701.3175123-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <984697bdc91a3c37f5f24750d7f24fc2d97031fa.1785457143.git.mmc@linux.ibm.com>
References: <984697bdc91a3c37f5f24750d7f24fc2d97031fa.1785457143.git.mmc@linux.ibm.com>
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

This moves the filter list and per-queue RX ring allocation out of
ibmveth_open() into four new helpers, and wires them into both the
open error unwind and ibmveth_close().  Runtime behaviour is meant to
stay single-queue since num_rx_queues is still 1.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 8e758362cb263..1007dd95cde02 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -151,6 +151,184 @@ static unsigned int ibmveth_real_max_tx_queues(void)
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
> +		return -ENOMEM;
> +	}

[Severity: Medium]

Should this error path also clear adapter->filter_list_dma?  On failure
dma_map_single() has stored DMA_MAPPING_ERROR, which is ~(dma_addr_t)0 and
therefore non-zero, and only filter_list_addr is reset here.

The sibling helper added in the same patch does zero the cookie in the
same situation:

	if (dma_mapping_error(dev, adapter->buffer_list_dma[i])) {
		...
		adapter->buffer_list_dma[i] = 0;
		goto err_cleanup;
	}

so the two new helpers appear to disagree on the convention.

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

[Severity: Medium]

Can this unmap the DMA_MAPPING_ERROR sentinel?  ibmveth_free_filter_list()
treats any non-zero filter_list_dma as a live mapping, and the mapping-error
branch of ibmveth_alloc_filter_list() leaves the sentinel behind.

The state looks reachable without dev_close().  ibmveth_set_csum_offload(),
ibmveth_set_tso(), ibmveth_change_mtu() and veth_pool_store() all call
ibmveth_close() and then ibmveth_open() directly while netif_running() is
still true:

	if (netif_running(dev)) {
		restart = 1;
		ibmveth_close(dev);
	}
	...
	if (restart)
		rc2 = ibmveth_open(dev);

If that re-open fails at the dma_mapping_error() check in
ibmveth_alloc_filter_list(), open() returns through the out: label without
calling ibmveth_free_filter_list(), so the adapter is left with
filter_list_addr == NULL and filter_list_dma == DMA_MAPPING_ERROR while the
netdev is still marked running.  A later "ip link set dev ethX down" then
reaches ndo_stop == ibmveth_close() -> ibmveth_free_filter_list() and unmaps
that invalid address.

On pseries the dma_iommu path catches this in iommu_free_check(), which emits
a ratelimited "iommu_free: invalid entry" message and a WARN_ON(1) (a panic
with panic_on_warn set), so no TCE state is changed, but the backtrace is
still user triggerable with CAP_NET_ADMIN plus a mapping failure.

Setting adapter->filter_list_dma = 0 in that error branch, matching
ibmveth_alloc_rx_queues(), would make the guard here reliable.

This is still present unchanged at the end of the series (a3781f4ae789), so
a later patch does not appear to address it.

> +
> +	if (adapter->filter_list_addr) {
> +		free_page((unsigned long)adapter->filter_list_addr);
> +		adapter->filter_list_addr = NULL;
> +	}
> +}
> +

[ ... ]

> +		adapter->buffer_list_dma[i] =
> +			dma_map_single(dev, adapter->buffer_list_addr[i],
> +				       4096, DMA_BIDIRECTIONAL);
> +		if (dma_mapping_error(dev, adapter->buffer_list_dma[i])) {
> +			netdev_err(netdev,
> +				   "unable to map buffer list for queue %d\n",
> +				   i);
> +			adapter->buffer_list_dma[i] = 0;
> +			goto err_cleanup;
> +		}
> +

[ ... ]

> @@ -627,74 +805,34 @@ static int ibmveth_open(struct net_device *netdev)
>  
> -	rc = -ENOMEM;
> -	adapter->buffer_list_addr[0] = (void *)get_zeroed_page(GFP_KERNEL);
> -	if (!adapter->buffer_list_addr[0]) {
> -		netdev_err(netdev, "unable to allocate list pages\n");
> +	rc = ibmveth_alloc_filter_list(adapter);
> +	if (rc)
>  		goto out;
> -	}

[ ... ]

> @@ -753,26 +889,12 @@ static int ibmveth_open(struct net_device *netdev)
> +	ibmveth_cleanup_rx_resources(adapter);
>  out_free_filter_list:
> -	free_page((unsigned long)adapter->filter_list_addr);
> -out_free_buffer_list:
> -	free_page((unsigned long)adapter->buffer_list_addr[0]);
> +	ibmveth_free_filter_list(adapter);
>  out:
>  	napi_disable(&adapter->napi[0]);
>  	return rc;

[ ... ]

