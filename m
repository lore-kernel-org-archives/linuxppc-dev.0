Return-Path: <linuxppc-dev+bounces-25919-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D958DC5DF74
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 01:47:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPCHw0GPgz2y71;
	Tue, 18 Aug 2026 11:47:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787017643;
	cv=none; b=ErfrFOi6H68+ynMsJRGNl1DxyRrcQZu09ZTuz6FZWMXkzyLMxUpgk6ov4zXzN5rrXxneCSGwSVxD5Yi86qE3hw0TapV7osIvTdHk3FJjFik1EwwmTx7VJe6H1ju8JI01SQ5qyxoseYg0xfT8OQueZVFyQiKFN9qhLhU3MO7G/VKMkt18hABP/pp3kNwqcPQHMoibhTomaOjeXGZbO99cl0yZzmPJaKbewNP9FWHL0q1Z4FCA/9uBFhYpCAWmxd6AQ4fXcbG4DlipO8EGyOs6umMmPeK9g8ReOOUuv/y6Z2vuyM5942zwsm0GjsIkUEcdacwIgiH8k2piJ+bbkKOL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787017643; c=relaxed/relaxed;
	bh=vBl4BR2i70MzIRt+YA2cPqlMbq5OaTO/K6e/n4feFVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfMYHQmkwu/BRHt3Lt6lWQwyyQiNRPpSwnFrlbUGbepf6jjr70CrHK5w1Rxt1MD0YvEagP5cOrfCyv1AoKtjFFiyewnqms1lbmcrP965Ow/oPf5yzMLlpHIYkdDispCEHxTkgcMWjlwAe1zBo+Yblaaf8sw06zr6ApTnRqyMsNMLXWG9tQMPq1o99K+akkGXXQ2Cs0sKU5N3HlNj9uACBe0wPIYSavX6g/w+KxaShGC0wvt1S6tGo0X2HTPLXoaljpBFG7k6QozryuHV34kkeML0/gnHb7LHKtSrXr4P1lPxUD3OpAHZpzIRPiS0fRaXS+iQXmr1t9mHR/UxEtxvCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6wPuGQP; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6wPuGQP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPCHt6JcTz2xb9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:47:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 731B3600C8;
	Tue, 18 Aug 2026 01:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDE11F00A3A;
	Tue, 18 Aug 2026 01:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017639;
	bh=vBl4BR2i70MzIRt+YA2cPqlMbq5OaTO/K6e/n4feFVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l6wPuGQP+k49kEZgBoWnHIdY+lhRl6QgCMm6Xqv33rwviGrYkPN4OuI2ktpteZSbX
	 U73f1xAqAlmBk/DdbtPh2TkzHuioO1gPgyv1HpjS9xC623sDhjr6J+t29RW/fEpWND
	 go4JPdIsxeTPoG5ogDlYNcppfr//JP9+E1U2asIbThmXbExRMU1W3YMVqI0ibWlSYb
	 gIN/tLZoIeJ7drD238AmK0nuGyuhcG77MCmy5496qrcD1b9KHgM7zyU7fHACv6Di9Q
	 3B+miha5oFU/5i0RHYZzGh/kDlbfeKkSiQC1Q45GP5NRXP6cL5ekEI2Rc709mOl/CU
	 bdN0ZIFzghZWg==
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
Subject: Re: [PATCH net-next v5 02/15] ibmveth: Prepare MQ RX adapter data structures
Date: Mon, 17 Aug 2026 18:47:17 -0700
Message-ID: <20260818014717.3853945-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-3-mmc@linux.ibm.com>
References: <20260814073642.24630-3-mmc@linux.ibm.com>
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
ibmveth: Prepare MQ RX adapter data structures

This converts the single-instance RX state in struct ibmveth_adapter (napi,
buffer_list_addr/dma, rx_queue, rx_buff_pool) into queue-indexed arrays sized
by a new IBMVETH_MAX_RX_QUEUES, and adds queue_handle[]/queue_irq[] plus
multi_queue/num_rx_queues bookkeeping. All existing references are
mechanically retargeted to index 0, and IBMVETH_MAX_RX_QUEUES is kept at 1 so
behaviour is unchanged.

No Link: tags are present in the commit header.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 73e051d26b9d8..7cb828b476c1b 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -482,24 +486,24 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
>  
>  	mb();
>  
> -	atomic_dec(&(adapter->rx_buff_pool[pool].available));
> +	atomic_dec(&adapter->rx_buff_pool[0][pool].available);
>  
>  	return 0;
>  }

[Severity: Low]
This isn't a bug, but the v5 change notes below the --- separator say the
"extra atomic_dec parentheses" nit from v4 was dropped, and that "this tip
patch keeps only the mechanical [0] retargeting".

The atomic_dec() in ibmveth_remove_buffer_from_pool() still drops the
redundant inner parentheses that the baseline had:

	-	atomic_dec(&(adapter->rx_buff_pool[pool].available));
	+	atomic_dec(&adapter->rx_buff_pool[0][pool].available);

Should the changelog be adjusted, or the parentheses kept as-is so the hunk
really is index-only?

[ ... ]

> @@ -1876,6 +1886,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  		netdev->features |= NETIF_F_FRAGLIST;
>  	}
>  
> +	/* Initialize queue count - always 1 for now */
> +	adapter->multi_queue = 0;
> +	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
> +

[Severity: Low]
At this commit these two assignments in ibmveth_probe() are the only accesses
to multi_queue and num_rx_queues, and queue_handle[]/queue_irq[] have neither
a reader nor a writer anywhere in the driver.

Combined with IBMVETH_MAX_RX_QUEUES being 1U, every array conversion in this
patch is a pure layout change with no behavioural effect.

Is it worth mentioning in the commit message which later patch first consumes
each of these fields? Reading the rest of the series, queue_irq[] and
queue_handle[] get their first users in ibmveth_toggle_irq() and
ibmveth_register_logical_lan_queue(), num_rx_queues is read through
ibmveth_get_num_rx_queues(), and IBMVETH_MAX_RX_QUEUES becomes 16U in
"ibmveth: Enable multi-queue RX receive path", so nothing is broken here.

>  	if (ret == H_SUCCESS &&
>  	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT)) {
>  		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_PER_HCALL;
> @@ -1898,10 +1912,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  		memcpy(pool_count, pool_count_cmo, sizeof(pool_count));
>  
>  	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> -		struct kobject *kobj = &adapter->rx_buff_pool[i].kobj;
> +		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
>  		int error;
>  
> -		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
> +		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
>  					 pool_count[i], pool_size[i],
>  					 pool_active[i]);
>  		error = kobject_init_and_add(kobj, &ktype_veth_pool,

[Severity: Low]
This is a pre-existing issue and is not introduced by this patch, which only
rewrites rx_buff_pool[i] to rx_buff_pool[0][i] on these lines.

The kobjects registered here live inside netdev_priv() memory, and the probe
failure paths after this loop call free_netdev() without a matching
kobject_del()/kobject_put():

	rc = register_netdev(netdev);
	if (rc) {
		free_netdev(netdev);
		return rc;
	}

The only teardown loop is in ibmveth_remove():

	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
		kobject_put(&adapter->rx_buff_pool[0][i].kobj);

which a failed probe never reaches, so a netif_set_real_num_tx_queues() or
register_netdev() failure leaves live .../poolN sysfs directories backed by
freed storage.

Worth noting this is addressed later in the same series: "ibmveth: Enable
multi-queue RX receive path" adds ibmveth_probe_cleanup(), which calls
ibmveth_put_pool_kobjs() before free_netdev() on both probe failure paths.

[ ... ]

> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
> index c0ef03cad9b9a..fc6a01e810c6e 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.h
> +++ b/drivers/net/ethernet/ibm/ibmveth.h
> @@ -257,6 +257,8 @@ static inline long h_illan_attributes(unsigned long unit_address,
>  #define IBMVETH_MAX_TX_BUF_SIZE (1024 * 64)
>  #define IBMVETH_MAX_QUEUES 16U
>  #define IBMVETH_DEFAULT_QUEUES 8U
> +#define IBMVETH_MAX_RX_QUEUES 1U
> +#define IBMVETH_DEFAULT_RX_QUEUES 1U
>  #define IBMVETH_MAX_RX_PER_HCALL 8U

[ ... ]

> +	struct ibmveth_rx_q rx_queue[IBMVETH_MAX_RX_QUEUES];
> +	u64 queue_handle[IBMVETH_MAX_RX_QUEUES];
> +	unsigned int queue_irq[IBMVETH_MAX_RX_QUEUES];
> +	int multi_queue;
> +	unsigned int num_rx_queues;

[ ... ]

