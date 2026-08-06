Return-Path: <linuxppc-dev+bounces-25517-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D77CC56205
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 18:37:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGGGY5VmYz3brM;
	Fri, 07 Aug 2026 04:37:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786041429;
	cv=none; b=J0fvEtm2/zdj1xpUS45cO1VJZ10EgUw7at0aQgwpl26IAcbDbVCPy10e/er/ZPyQ13xURJTSEdoQk6ulIEduJLNpUjQFTnlzSojTPLh0iRNJAmYihPBOayC+R5xNO5yRCKm7Z0piNU1DwZOpG/LcYklEVplenSIHScHg/mu1MR3UPK9UzWcpX68hHy01+occN3JF0cWoEhVcnDeIiqmuhHervGc6ZCgHxT00NDrOhPv+vJiNwu+V+oOV2OKYAUkGT+KXySjeUv05pN8ybv2/r3KW3MFdinSCvntIZ7l6gjsIgQlEv2ujCUeHUuScyCOTXHW+3ocfH9alVU4+aGEAng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786041429; c=relaxed/relaxed;
	bh=Kw0bAgHUZzpkjFP8Xw4GTrzIO4gOGMMUN0JzOov3mas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rho4zgW3sVvuiEmKWpaUmDW2a3rTXnN5JMxXtzbSYNrJzKNtZVX7IS6kkujHqQcbKFORtzttqi3+t+7H4wt8frM/Ji6fUffdzgA4ixYBl5inzf6EYh9YgEXvMGlmp57tf7DKixxivdMQOO6Pff3UsSBC2QgwI4FZETy+BPtJJw1JPLpjKqsAS4qed6LMvCdi3dB2R3YDqcJer9HwwuopRD1YdCnLiSyK9xlKRRYoLNtRNFL+N9f+CEbbLn/sz3LK1n0/ks9HsBrhXzt03FVLVDAvPwo9nazu0hyFjoaZLn0tq2l3Nr9SK8WcYP1cAErYVtsrzgyqfwOrdMj6QFPBPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQGcO8bu; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQGcO8bu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGGGW11BQz3bx0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 04:37:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 34E214390F;
	Thu,  6 Aug 2026 18:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E991F00A3A;
	Thu,  6 Aug 2026 18:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041421;
	bh=Kw0bAgHUZzpkjFP8Xw4GTrzIO4gOGMMUN0JzOov3mas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TQGcO8buNiiU7P9QXyP0XZKtJ4m6pEXJWFTVLkxziKjhmLrM11ZDDYrV8bK6ZTRap
	 i5BBCbu1ehL1CEwsIOelSa6kpMLfBEhrB3xnAVpAURAov/im7Iv0fjv4YV4HtHBU+x
	 wPD6fzo04ZKW5FzvNtXhDSPaqsg9Ytt9s7BO1QDDO8/g3sA+yV6WLRSPXGWYHnNSLr
	 S9uFfqUdmuOca5/JvpfAooX+Qrj0nNXjwxu+hnKot/fT6+uBZ+yvR0yyUurlbEwOE4
	 3i3YUtv8sX3fKoZ0ncZDHA0qVcR/vFgG0PKI/EwYMFat7r/5tChKwx6LefwzA3cQo0
	 T+1HJm6PCG/Hg==
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
Subject: Re: [PATCH net-next v4 02/14] ibmveth: Prepare MQ RX adapter data structures
Date: Thu,  6 Aug 2026 11:36:59 -0700
Message-ID: <20260806183659.3175041-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <5aceac43fd2da5d06bee7aba36e2983e1a7bc007.1785457143.git.mmc@linux.ibm.com>
References: <5aceac43fd2da5d06bee7aba36e2983e1a7bc007.1785457143.git.mmc@linux.ibm.com>
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

This converts the single-instance RX state in struct ibmveth_adapter
(napi, rx_queue, buffer_list_addr/dma, rx_buff_pool) into queue-indexed
arrays sized by the new IBMVETH_MAX_RX_QUEUES, adds multi_queue and
num_rx_queues, and mechanically rewrites all existing references to
index 0.  IBMVETH_MAX_RX_QUEUES stays at 1 in this patch.

A couple of observations below, neither of which changes runtime
behaviour today.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 73e051d26b9d8..8e758362cb263 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -482,42 +486,44 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
>  	mb();
>  
> -	atomic_dec(&(adapter->rx_buff_pool[pool].available));
> +	atomic_dec(&adapter->rx_buff_pool[0][pool].available);
>  
>  	return 0;
>  }
>  
>  /* get the current buffer on the rx queue */
> -static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter)
> +static inline struct sk_buff *
> +ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter)

[Severity: Low]
This isn't a bug, but the patch carries a few edits that are not part of
the stated mechanical index-0 conversion:

  - dropping the redundant parentheses in the atomic_dec() call in
    ibmveth_remove_buffer_from_pool()
  - reflowing the ibmveth_rxq_get_buffer() prototype
  - rewriting the kernel-doc of ibmveth_get_desired_dma() from
    "Return value:" to "Return:"
  - inserting a blank line in struct ibmveth_adapter after
    rx_large_packets

The commit message says:

    This patch keeps behavior unchanged by mechanically switching existing
    references to index 0

Could these cosmetic edits move to a separate cleanup patch, or be
mentioned in the changelog?  As it stands each hunk has to first be
classified as conversion or cleanup before the "behavior unchanged" claim
can be confirmed.

[ ... ]

> @@ -1693,8 +1704,7 @@ static void ibmveth_poll_controller(struct net_device *dev)
>   *
>   * @vdev: struct vio_dev for the device whose desired IO mem is to be returned
>   *
> - * Return value:
> - *	Number of bytes of IO data the driver will need to perform well.
> + * Return: Number of bytes of IO data the driver will need to perform well.
>   */
>  static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
>  {

[ ... ]

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

[ ... ]

> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
> index c88dbeb7cd967..8eaa3942fc40b 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.h
> +++ b/drivers/net/ethernet/ibm/ibmveth.h

[ ... ]

> @@ -294,18 +296,23 @@ struct ibmveth_rx_q {
> -	struct ibmveth_buff_pool rx_buff_pool[IBMVETH_NUM_BUFF_POOLS];
> -	struct ibmveth_rx_q rx_queue;
> +	struct ibmveth_buff_pool
> +		rx_buff_pool[IBMVETH_MAX_RX_QUEUES][IBMVETH_NUM_BUFF_POOLS];
> +	struct ibmveth_rx_q rx_queue[IBMVETH_MAX_RX_QUEUES];

[Severity: Low]
Is replicating the whole struct ibmveth_buff_pool per queue the layout you
want here?

struct ibmveth_buff_pool embeds a struct kobject, which is the per-pool
sysfs tuning object.  Only row 0's kobjects are ever initialized and
registered, in ibmveth_probe():

	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
		...
		error = kobject_init_and_add(kobj, &ktype_veth_pool,
					     &dev->dev.kobj, "pool%d", i);

and only row 0's are dropped, in ibmveth_remove():

	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
		kobject_put(&adapter->rx_buff_pool[0][i].kobj);

So every row above 0 carries a kobject that is never initialized and never
used.

Later in the series IBMVETH_MAX_RX_QUEUES is raised to 16U, at which point
the netdev private area unconditionally holds 16 x 5 pool structs
regardless of num_rx_queues, of which 75 embedded kobjects are dead
weight.

The follow-on code also shows that only part of the struct is really
per-queue: ibmveth_alloc_single_rx_queue() copies size, index, buff_size,
threshold and active from row 0 into each new row, so the pool
configuration is shared while free_map/dma_addr/skbuff/producer_index/
consumer_index/available are the genuinely per-queue state.

Would it be cleaner to split the struct into one shared, sysfs-visible
configuration object plus a small per-queue state array, given this patch
is the one that fixes the layout for the rest of the series?

Is it also intentional that the per-pool sysfs tuning interface now
implicitly means "queue 0 configures all queues"?  If so, could that be
stated in the changelog?

> @@ -325,6 +332,7 @@ struct ibmveth_adapter {
>  	u64 tx_send_failed;
>  	u64 tx_large_packets;
>  	u64 rx_large_packets;
> +
>  	/* Ethtool settings */
>  	u8 duplex;
>  	u32 speed;

