Return-Path: <linuxppc-dev+bounces-24215-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C77C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 12:58:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzzrq4ynRz2yMn;
	Tue, 14 Jul 2026 22:58:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784033931;
	cv=none; b=asVzDeoZxjP+8Uc8YJCBO/XqGRWrN9j9DanG75cAT1YCA8xTdQvz/7PxbX1ZlM8KoMk77ZMpPV8J/USImH+QkQKjVHSFgTqfvYmwiTxGtMcc8S93n0sIBqQ21iGo0IevoGAiNiVbThDlTVyd5NoRrfAALPe7udNRZv/JgGy3SzEVS2FWrIUr/GRilMcmwNgTgcE5gZcNK8eNOPT7e7JmCkrxnlZ9W49h0hOouL65CITcdz7oDnTs/C9On4M+HKsycUoDsknmGkTneXYP/n7Et4ZJAwcHwQ3O+F04EAmMpnMsbkyO/ke8XP9ALCZhipBDSayM/ehBqSKmcufoVQHQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784033931; c=relaxed/relaxed;
	bh=3C5Zz7z6jaqU/key9OpG6xocIqZ2SWzEt8FlkruHztk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlYjJiS7WgC+Gi3quHLMYvVO9csyzuFKk/Dr46gMXGTI9uyjUjY63TRjucSe+n3NGKu6FWUuBfQTEXK4eSMvPK/BiJkdluSFwDsftljAz1adVcRKpLycNan23mwVyw/qF7H4pLiicQbJJ+Sgg3XfwLiay8Ho/qs6NguXLBX6J4LfvOvkJ74uRRPaWyETE0YyIjJ25VHTrMNDPzl9GQeDvgHzzHe3wa8GL2CJ7WQL35QBxAeYHlb3QpHSUyOKuBh9+rw3XlCG9rH7SOAp/5lEAVBQYQLpXuulp7wPNzVuFBSE52c3Dzk8sboDFxRb6qaPVoKCT7Y4YrkZeyvGHE1QWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJiEyHuF; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJiEyHuF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzzrp3TT4z2yH5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 22:58:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 527E3400DF;
	Tue, 14 Jul 2026 12:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95AD1F00A3E;
	Tue, 14 Jul 2026 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784033926;
	bh=3C5Zz7z6jaqU/key9OpG6xocIqZ2SWzEt8FlkruHztk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YJiEyHuFX3ayB9X9FZKk2paX7L3Ticm5iy1rh3VbMN1251z2WYeT1FcFGnZgeZNzt
	 tsdf4+PoD5JBVeZ1ZdbJ8ZdhcZoVA+vJRN9qpnoohp6EodNi3013X1LK2jwUVfuqyL
	 /NIzYj/V8wSidurQ44WPSWNNgq84cgfZVab8oW0Fu/fazw6TzpLSkPnxAZg30fPEQk
	 KnWBDILKLWeeh4VvS3DOo2YbjDJfnUfEwWbCTWLjD5CSmZS76idtcjRVr6WxRl0Uve
	 DCFpHDm9PjcvEHrFEFfCAlqlZq5LTRY2lDvfibd1iP4ecRvgmYmUkYfTgtySDmSgBE
	 h98D+Xr1dataA==
From: Simon Horman <horms@kernel.org>
To: mmc@linux.ibm.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v3 10/15] ibmveth: Enable multi-queue RX receive path
Date: Tue, 14 Jul 2026 13:55:58 +0100
Message-ID: <20260714125557.1837451-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-11-mmc@linux.ibm.com>
References: <20260706193603.8039-11-mmc@linux.ibm.com>
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
Full review at: https://sashiko.dev
---
ibmveth: Enable multi-queue RX receive path

This is the first patch that sets multi_queue from H_ILLAN_ATTRIBUTES
and switches registration, buffer posting, and receive to the MQ
hcall path. It also raises num_rx_queues and enables per-queue NAPI.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index b3b3886c3eedb..863e5c68b42c7 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -826,15 +841,23 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>   */
>  static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>  {
> -	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
> +	int i;
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
> +		u64 drops = be64_to_cpup(p);
>  
> -	adapter->rx_no_buffer = be64_to_cpup(p);
> +		if (i == 0)
> +			adapter->rx_no_buffer = drops;
> +	}
>  }

[Severity: Medium]
Will this logic silently discard the hardware drop counts for all queues
other than queue 0?

Since ethtool -S reports the global adapter->rx_no_buffer statistic, shouldn't
this loop accumulate the drops across all queues instead of only recording
them when evaluating the first queue?

[ ... ]

> @@ -842,6 +865,8 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>  				   int queue_index)
>  {
> +	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
> +	unsigned long flags;
>  	int i;
>  
>  	if (queue_index >= adapter->num_rx_queues)
> @@ -842,6 +865,8 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>  
>  	adapter->replenish_task_cycles++;
>  
> +	spin_lock_irqsave(&rxq->replenish_lock, flags);
> +

[Severity: Medium]
With multi-queue RX enabled, can multiple NAPI threads execute this task
concurrently for different queues?

If so, does this non-atomic increment of the global replenish_task_cycles
stat risk data corruption, torn reads on 32-bit platforms, or lost updates?

Similarly, in ibmveth_replenish_buffer_pool():

drivers/net/ethernet/ibm/ibmveth.c:ibmveth_replenish_buffer_pool() {
    ...
    buffers_added += filled;
    adapter->replenish_add_buff_success += filled;
    remaining -= filled;
    ...
}

Even though the caller acquires the per-queue rxq->replenish_lock,
replenish_add_buff_success is a global adapter statistic. Does this update
also race with other CPUs holding the locks for their respective queues?

[ ... ]

> @@ -2268,34 +2299,40 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
>  
>  static int ibmveth_poll(struct napi_struct *napi, int budget)
>  {
[ ... ]
>  		} else {
>  			struct sk_buff *skb, *new_skb;
> -			int length = ibmveth_rxq_frame_length(adapter);
> -			int offset = ibmveth_rxq_frame_offset(adapter);
> -			int csum_good = ibmveth_rxq_csum_good(adapter);
> -			int lrg_pkt = ibmveth_rxq_large_packet(adapter);
> +			int length = ibmveth_rxq_frame_length(adapter, queue_index);
> +			int offset = ibmveth_rxq_frame_offset(adapter, queue_index);
> +			int csum_good = ibmveth_rxq_csum_good(adapter, queue_index);
> +			int lrg_pkt = ibmveth_rxq_large_packet(adapter, queue_index);

[Severity: High]
This isn't a bug introduced by this patch, but does this code validate the
length and offset provided by the hardware descriptor before modifying the
SKB bounds?

Later in ibmveth_poll(), these values are used directly:

drivers/net/ethernet/ibm/ibmveth.c:ibmveth_poll() {
    ...
    skb_reserve(skb, offset);
    skb_put(skb, length);
    ...
}

If the hypervisor provides an untrusted or artificially large length, could
the call to skb_put() trigger an skb_over_panic() and crash the guest
kernel?

[ ... ]

Also, I noticed a potential memory leak in the error unwinding path of
ibmveth_open():

drivers/net/ethernet/ibm/ibmveth.c:ibmveth_open() {
    ...
    if (rc) {
        netdev_err(netdev, "failed to set number of rx queues\n");
        goto out_unregister_queues;
    }
    ...
out_free_buffer_pools:
    ibmveth_free_buffer_pools(adapter);
out_unregister_queues:
    ibmveth_dispose_subordinate_irq_mappings(adapter);
    ibmveth_free_all_queues(adapter);
}

[Severity: Medium]
This is a pre-existing issue, but if netif_set_real_num_rx_queues() fails,
the code jumps to the out_unregister_queues label.

Does this bypass out_free_buffer_pools, leaving the RX buffer pools unfreed
and causing a memory leak when cleaning up after a failure?

