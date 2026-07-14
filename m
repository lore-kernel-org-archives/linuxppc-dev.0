Return-Path: <linuxppc-dev+bounces-24219-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23865C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 13:08:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h003S4zY8z2yMn;
	Tue, 14 Jul 2026 23:08:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784034484;
	cv=none; b=a+W5S+EJ9bJ17M3buwWvbT4eQeL3RGwyVw9PgNmFdwwq4j8uON/7vWkNECGe6kei+1wNhP+njR9olfV2jFZKJyIp2+2Z/Wp9m1lXE9PQB4L3lXDdZFY3IGAVUYMM2/NKni7Mr+/7PVbv5e2x2u4KlRqSpo6dQMADtW9641nf+9FwYUxs+r8qpMkwI1t5hBsHauK1yLBjgdb+N/hmBhv1ahCrsp5E06ZYr4jXO9PakRIuIHm85YcuZZYWcZyZEAAp1iBHb202DqfGyZv8T7U/C3lqKuzlBEv5D0XQ5oZe1gDR0AzERkfbBeIpQxR4A/jE+Sdu6juq2dYFQaDVQWfLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784034484; c=relaxed/relaxed;
	bh=OR+TALXUbrDqxIOAyEwXOdpwUaeeSd6LxkFLp/LQ0xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZ2o9Grs/5d2OPtsKQ4YMY1zd9PsNfJRDD5GCKOVqtZLBuxDCatTCnM5N45DP+mtj7Pr7TOhXrvAVF8z+P4xS0/Lry5BSKxsPmj+dpL7WCvFpfk2SHJIE7L/PVfMRl0atKV0C/UGcpUL5o58tRk2FPO7oipDlUuUn1UKd74Wb0tcFdt9Guuriragk2xI3kTT+3roaPt5Qiqy8dy0F8q2KtK7rzViwbCy++vKcLHCduCLE1j7zbJ0tFElKuGKkkS+aV1W5ASLrPMoGf/Cu1sorSfptEJrZL9ZPfYfUBNJGVQDxILmJ2XfK1vjUtXei6Pawb3nThbCrrYzE4vV/Rm20Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfSX1rbs; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfSX1rbs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h003R5n1hz2yH5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 23:08:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2C41440986;
	Tue, 14 Jul 2026 13:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16021F000E9;
	Tue, 14 Jul 2026 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784034482;
	bh=OR+TALXUbrDqxIOAyEwXOdpwUaeeSd6LxkFLp/LQ0xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RfSX1rbszvo/lzps5iz4Gm8FU0W6pSskBwPU8lPBHXly0vlOL/70m/UOWKYGzhlrr
	 2/EZo2jDlOpmSwU6j/Hv2vHvmIctbhJ/5HwmRGTW1NtkFkXyylt7Gjl4DNfmsv59g9
	 8muh0afsUEHpFHcqptKt3spGlSQ4mcFLjV9VwEQjp1ZrOINtMREMYwU06DL3Z5clK3
	 P5vK5nVmH+BQu7wP58z1ldhse0HYqQ7Dv1pPgm8wQudq9jvZvyJAAEdjnjjjOYlohP
	 WN9qhgJK8EoBMbtgRedIKczJd8fT3SPn8LOiLmqMJmmzHvjuYgDzX4a8cD+Z6bVvv7
	 eBK+sB+LqioiA==
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
Subject: Re: [PATCH net-next v3 14/15] ibmveth: Wire ethtool set_channels to MQ RX queue resize
Date: Tue, 14 Jul 2026 14:07:52 +0100
Message-ID: <20260714130752.1844153-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-15-mmc@linux.ibm.com>
References: <20260706193603.8039-15-mmc@linux.ibm.com>
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
ibmveth: Wire ethtool set_channels to MQ RX queue resize

Expose incremental RX resize through ethtool channel control.
get_channels() reports rx_count from adapter->num_rx_queues and max_rx
as IBMVETH_MAX_RX_QUEUES when MQ firmware is enabled, else 1.
set_channels() validates rx_count is within 1..IBMVETH_MAX_RX_QUEUES.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index ac4d89a66a8db..50a332ab83fd3 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -2534,19 +2534,69 @@ static int ibmveth_set_channels(struct net_device *netdev,
>  				struct ethtool_channels *channels)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
[ ... ]
> -	if (!(netdev->flags & IFF_UP))
> +	if (!(netdev->flags & IFF_UP)) {
> +		if (goal_rx > 1 && !adapter->multi_queue) {
[ ... ]
> +		/* Stash desired RX count; open() publishes it via
> +		 * netif_set_real_num_rx_queues() after queue registration.
> +		 */
> +		if (goal_rx != adapter->num_rx_queues)
> +			adapter->num_rx_queues = goal_rx;
> +
>  		return netif_set_real_num_tx_queues(netdev, goal);

[Severity: Medium]
If netif_set_real_num_tx_queues() fails and returns an error, the TX
configuration command will fail, but the RX queue count has already been
permanently modified in adapter->num_rx_queues. Will this leave the device in
an inconsistent state where the new RX count is applied on the next open
despite the command failing?

> +	}
[ ... ]
> +	if (goal_rx != old_rx) {
> +		rc = ibmveth_resize_rx_queues_incremental(adapter, goal_rx,
> +							  rxq_entries);

[Severity: High]
Does this new ethtool scale-down path expose an interrupt storm?

Looking at ibmveth_resize_rx_queues_incremental(), when scaling down queues it
disables NAPI before disabling the hardware interrupt:

drivers/net/ethernet/ibm/ibmveth.c:ibmveth_resize_rx_queues_incremental() {
    ...
		for (i = new_count; i < old_count; i++)
			napi_disable(&adapter->napi[i]);

		for (i = new_count; i < old_count; i++)
			ibmveth_drain_rx_queue(adapter, i);

		synchronize_net();
    ...
		/* Disable hypervisor interrupts and wait for handlers to complete
		 * before updating num_rx_queues.
		 */
		for (i = new_count; i < old_count; i++) {
			ibmveth_disable_irq(adapter, i);
    ...
}

If the hypervisor delivers a packet during this window, ibmveth_interrupt()
will execute. Since NAPI is disabled, napi_schedule_prep() fails, causing the
handler to return IRQ_HANDLED without disabling the hardware interrupt. Will
this leave the virtual interrupt asserted and force an infinite interrupt loop?

> +		if (rc) {
> +			netdev_err(netdev, "Failed to resize RX queues: %d\n", rc);
> +			return rc;
> +		}
> +	}
>  
>  	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
>  	 * but we may need to alloc/free the ltb's.
>  	 */

[Severity: High]
This is a pre-existing issue, but does this function use an uninitialized
variable in the error path?

When decreasing the number of TX queues (goal < old), the allocation loop for
(i = old; i < goal; i++) is skipped, leaving 'i' uninitialized. If
netif_set_real_num_tx_queues() then fails, the error path assigns old = i;. 

The cleanup loop then uses this garbage value:
	for (i = old; i > goal; i--) {
		if (adapter->tx_ltb_ptr[i - 1])

Will this access adapter->tx_ltb_ptr out of bounds and pass arbitrary pointers
to ibmveth_free_tx_ltb()?

> @@ -2580,7 +2630,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
>  
>  	netif_tx_wake_all_queues(netdev);
>  
> -	return rc;
> +	return 0;

[Severity: High]
Does this unconditional return of 0 mask TX queue configuration failures?

If applying the new TX queue count via netif_set_real_num_tx_queues() fails,
the code handles it locally, but the function exits with 0 regardless. Will
this mislead userspace into believing the TX channel count was successfully
modified?

>  }

