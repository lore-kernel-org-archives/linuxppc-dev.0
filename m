Return-Path: <linuxppc-dev+bounces-24218-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9416C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 13:06:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h001f4Nzbz2yY1;
	Tue, 14 Jul 2026 23:06:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784034390;
	cv=none; b=I66YEGNZDgiVtfY3cdybFmwWNuW2oYPgCaaMcajHbunCNd47zzw6wclB4OPBSUn1gSSUkUcu3K4ygSxKlRDMz4nOW8U9GVcJ3Y2usri5k00+o+ho6k8Xrr+j/76yGuqkhw88lU6N1MOoZK47qTEAZCYyx1NefOKEAk1YT3Q5MWnLG0LzKxZSzG4L5wrRWYUGdhzrTwv5itHaH8GMKBgXcEoZ3vx+vWy05Yf9jlhdntgkp7PFztcpdA4UuwiYsQcepTgIvN7LsIAky7kTr8Vbcb9Al3VBPi78Z/q0ky2xZLJb5+Oqm4KT4NTTwVdhtufnQgQYm8cJF9A5EpRQ+hF7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784034390; c=relaxed/relaxed;
	bh=n5uZic2yQEf6J+MPzYVAL97zNM1jCY/8xBbV5VkLom0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0v3X+AOKcVQMeSEdKiU01MnUCKbNOmdWTdDbMZqKbgvJ5fmRVUPYdj1WHlazk9opUcB+QwFVJZzoQ7eVMfJuXBGbHlce60GtoZNZorq83lt4qzN/Xx4BN9F/6AUA9wCu3Ua8XqEXpvLTLD9qzrm6SqKWrThuhU4eNLvBhyDVfWLLwjKsRBvLc/WytCp7QsGayljW5Wnk3tPWmwHmiUUGtnVhNbn88qpJkvcWPWxwYAjCZmf8MUNajpG/ubhF9Prmka5ooT5h0+Uz/dTEuYadbhjRhiznmJsj8WxD/4sVG1Up+ivXdJY6pVVUXgt8CeNzZMQhKNOz28JT+pkj8a5zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwyYkiEo; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwyYkiEo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h001d5SBgz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 23:06:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B02A96136C;
	Tue, 14 Jul 2026 13:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C10D1F00AC4;
	Tue, 14 Jul 2026 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784034387;
	bh=n5uZic2yQEf6J+MPzYVAL97zNM1jCY/8xBbV5VkLom0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XwyYkiEoqtwMmiD4xVL+MBmHsJCedGnMjYjtF7ZQ2NLepWSeWorhUpxLfvE/DFku0
	 +u3EAX8QG/xj9D79OwLnv8xgPquStq1bk0cMgkhwzpV/AlRtLyaHxTZETFvRpDOm+4
	 O88eKBCgFzRf4rwO4X6bT9pTudZEI9WDJOXd3ZaZeoZbsCpCH9R3aUGTjqvdtSExIm
	 zv8FOfz7QH8Q91sBi96FI/BCUFv9qYnkcKbQ+yhrTwwZ3+kKLjnKmwDsQ8CxYIILRH
	 iPx6zwiqznikPOtZohxKfLMaPiNMDSI5Mc7Syj0ixv5XpCr4vZJOI+E9u9HK5tXd2C
	 9hqISmIpo4bLg==
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
Subject: Re: [PATCH net-next v3 13/15] ibmveth: Implement incremental MQ RX queue resize
Date: Tue, 14 Jul 2026 14:03:46 +0100
Message-ID: <20260714130344.1841551-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-14-mmc@linux.ibm.com>
References: <20260706193603.8039-14-mmc@linux.ibm.com>
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
Date:   Mon Jul 6 19:36:01 2026 +0000

ibmveth: Implement incremental MQ RX queue resize
    
Add helpers to register/deregister individual RX queues and scale
queue count up or down while the netdev stays up. Surviving queues
keep PHYP handles, buffer pools, and IRQ state across resize.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index ecc472ee8f71f..ac4d89a66a8db 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1080,6 +1132,138 @@ static void ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
> +static int
> +ibmveth_alloc_single_rx_queue(struct ibmveth_adapter *adapter, int queue_idx,
> +			      int rxq_entries)
> +{

[ ... ]

> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> +		adapter->rx_buff_pool[queue_idx][i].size =
> +			adapter->rx_buff_pool[0][i].size;
> +		adapter->rx_buff_pool[queue_idx][i].buff_size =
> +			adapter->rx_buff_pool[0][i].buff_size;
> +		adapter->rx_buff_pool[queue_idx][i].threshold =
> +			adapter->rx_buff_pool[0][i].threshold;
> +		adapter->rx_buff_pool[queue_idx][i].active =
> +			adapter->rx_buff_pool[0][i].active;
> +	}

[Severity: Critical]
Does this loop miss initializing pool->index?

If pool->index remains 0 for all buffer pools on the new queue, when
replenishing, 0 is shifted into the correlator.

Then when receiving, ibmveth_remove_buffer_from_pool() will extract pool=0,
which fetches from the wrong pool and could corrupt the free map of pool 0,
leading to a use-after-free or leak.

[ ... ]

> @@ -1192,6 +1376,49 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
> +static int
> +ibmveth_drain_rx_queue(struct ibmveth_adapter *adapter, int queue_index)
> +{

[ ... ]

> +	while (drained < limit &&
> +	       ibmveth_rxq_pending_buffer(adapter, queue_index)) {
> +		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);

Simon says: I think we can consider the issue below in the context of
            possible follow-up, because I believe the use of this pattern
	    predates this patch.

[Severity: High]
Is a read memory barrier needed between reading the toggle bit in
ibmveth_rxq_pending_buffer() and reading the correlator in
ibmveth_rxq_harvest_buffer()?

Since the hypervisor could be actively writing new descriptors while this is
called, could a weakly-ordered CPU reorder the correlator load before the
toggle bit load, causing us to recycle the wrong buffer?

[ ... ]

> @@ -1491,6 +1718,175 @@ ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
> +static int
> +ibmveth_resize_rx_queues_incremental(struct ibmveth_adapter *adapter,
> +				     int new_count, int rxq_entries)
> +{

[ ... ]

> +			rc = ibmveth_enable_irq(adapter, i);
> +			if (rc) {
> +				netdev_err(netdev,
> +					   "Failed to enable IRQ for queue %d: %d\n",
> +					   i, rc);
> +				ibmveth_cleanup_single_rx_interrupt(adapter, i);
> +				ibmveth_deregister_single_rx_queue(adapter, i);
> +				ibmveth_free_single_rx_queue(adapter, i);
> +				goto cleanup_new_queues;
> +			}
> +
> +			napi_enable(&adapter->napi[i]);
> +		}
> +
> +		adapter->num_rx_queues = new_count;

[Severity: High]
What happens if an interrupt fires on the newly added queue before
adapter->num_rx_queues is updated?

If an interrupt fires between ibmveth_enable_irq() and the update of
adapter->num_rx_queues, ibmveth_interrupt() might evaluate:
    WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues)
to true and return IRQ_NONE without masking the interrupt.

Could this lead to an unhandled interrupt storm?

[ ... ]

> +	} else {
> +		netdev_dbg(netdev, "Scale-down: removing queues %d-%d\n",
> +			   new_count, old_count - 1);
> +
> +		for (i = new_count; i < old_count; i++)
> +			napi_disable(&adapter->napi[i]);
> +
> +		for (i = new_count; i < old_count; i++)
> +			ibmveth_drain_rx_queue(adapter, i);
> +
> +		synchronize_net();

[Severity: High]
Can disabling NAPI before disabling the hardware interrupts create an
interrupt storm window?

If the hypervisor asserts an interrupt during synchronize_net(), the hardware
IRQ handler runs. Since NAPI is disabled, it returns IRQ_HANDLED without
masking the interrupt source at the hypervisor, leading immediately to an
IRQ storm and CPU lockup.

> +
> +		rc = netif_set_real_num_rx_queues(netdev, new_count);
> +		if (rc) {
> +			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
> +				   new_count, rc);
> +			for (i = new_count; i < old_count; i++)
> +				napi_enable(&adapter->napi[i]);
> +			return rc;
> +		}

[Severity: High]
Is it possible for this error path to permanently stall the RX queues?

It calls napi_enable() but doesn't call ibmveth_replenish_task(). Since the
queues were completely drained of their buffers by ibmveth_drain_rx_queue(),
will the hypervisor have any buffers to place incoming packets?

Without buffers, no interrupts will fire for these queues, and NAPI will
never run again.

