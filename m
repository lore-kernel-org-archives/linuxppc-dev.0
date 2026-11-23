Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDAE606A31D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeFkUDgo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXnng5Q3Jz30C6;
	Mon, 23 Nov 2026 12:06:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795395975;
	cv=none; b=B6AOEmpRtQi7L96lIiXpBqeMeenpVY8KKmIn4xqpCbBwMUZZJmAyrO1wUeGSRasHLQnukfOykmx+9rAJQukiPkbNRt004U7N35vQcaHOv4rrgCnjA8vgrKgaJ+PJgcWG2yTe7dz1lIdWnHSrjxBiirLnXUow48SHaNWfFtimCv9LRhYHf5FZ5945zgdBs1IwMH4UbEoZ4lQq0eVwZ99r5VWY8HNUw1gaSOyF5dZup41GiZt1S42DeWrlas+WFbOK+Z8oFzL2l0qTH66NrYmvftfMc6oG6wbupJgSBeB6/ezLXKdmHnHi9ctqzYGAPdXsKcN+GCdAnw3FX81btCNJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795395975; c=relaxed/relaxed;
	bh=c52FecD9pTkops3xpRxdHkp10wpl7jH4KiBhrJdHiV8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Semm4dOeBwvtTy3cMbWNAV0FPcYmeHu94N9GPdpQN7BXz+bqigQdyPoFdmNiVbDA3w4dxZdw20G0tL/T+qfDYsibNlbpk013tmfQLqFBKMEtlpcXaNR7sebUduWNcKT72M/HgmOdkICQqJ+r64k/RXDLYh/YxUvQA+8mmFG9OfJki72spVeIw/FVe57UbvSCZ1tu66pM1ECuxrOakAoNB0Xk7m4OD221sAyzBlyP5v/kC4A7+izP+/wwCpx4Wt11oG9/r23pPnAd/gXlNmX/Cxpe33hhqQETQbNYOWOLUBP2LtwtJ7E+9HiQmBLC/c5iDg8BcvlqoMyJD7mltK0bnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeFkUDgo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeFkUDgo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXnnf3Q7Xz2ySV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 12:06:14 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CB7FD44EF4;
	Mon, 23 Nov 2026 01:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCBC1F000C0;
	Mon, 23 Nov 2026 01:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795395972;
	bh=c52FecD9pTkops3xpRxdHkp10wpl7jH4KiBhrJdHiV8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EeFkUDgoy5serfTBSaWlvaWB1q5o1vlkGKCIQYjY/jRtCikthOhCRk807KEGGAVUE
	 ekxpILLtzThkigPYEEaIVgFt5D9qKXY9akVLNYV0ATryUDUe/4LrSwiM55fOH9Vsp/
	 g87pFxGCVR7ek1XSV89hA5+1/UYz0sPR1JWeYjIIJdIqkESRRCSRMgd42WOImGzUVa
	 k+bzmUlVnrHvCDV8W4zZ3knkAI3E43rOiSxFoP5YJM+8KDI9ULGt/iqeYN+YM0t5WJ
	 P/wirFprIvH/ywXCXiKuLCx7niq5gFnV9UB0w89YVdIZvrpGH1Y/kG3VcIf5D67ZUZ
	 jM43kUiY+Cjww==
Subject:
 Re: [PATCH net-next 6/8] ibmveth: Add RX queue register helpers for MQ
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, horms@kernel.org, davemarq@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Mon, 23 Nov 2026 01:06:11 +0000
Message-ID: <179539597127.3135.40344499616504179@kernel.org>
In-Reply-To: <20261119000711.18093-7-mmc@linux.ibm.com>
References: <20261119000711.18093-7-mmc@linux.ibm.com>
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

- [Low] The commit message presents this patch as moving existing code
  into helpers and changing the order of open().

--

ibmveth: Add RX queue register helpers for MQ

This moves logical LAN registration and teardown out of ibmveth_open() and
ibmveth_close() into the new helpers ibmveth_register_rx_queues() and
ibmveth_free_all_queues(). The H_FREE_LOGICAL_LAN busy loops now share
ibmveth_free_logical_lan(). open() also allocates the buffer pools before
registering the LAN.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 8f32f75f2d7fd..ab8c5f6a265b4 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> +static long ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
> +					 union ibmveth_buf_desc rxq_desc,
> +					 u64 mac_address)
> +{
> +	long rc;
> +	int try_again = 1;
> +	unsigned long ua = adapter->vdev->unit_address;
> +	unsigned long buf_dma = adapter->buffer_list_dma[0];
> +	unsigned long filter_dma = adapter->filter_list_dma;

[ ... ]

> +static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
> +{
> +	long lpar_rc;
> +
> +	lpar_rc = ibmveth_free_logical_lan(adapter);
> +	if (lpar_rc != H_SUCCESS)
> +		netdev_err(adapter->netdev,
> +			   "h_free_logical_lan failed: %ld\n", lpar_rc);
> +}

[ ... ]

> +	rc = ibmveth_disable_irq(adapter, 0);
> +	if (rc)
> +		netdev_dbg(netdev,
> +			   "Failed to disable IRQ for queue 0 before registration, rc=%d\n",
> +			   rc);

[Severity: Low]
This isn't a bug, but the commit message describes the patch as moving code
into helpers and reordering open(). The patch also changes some logging that
the message doesn't mention.

In ibmveth_close(), the old message was:

    "h_free_logical_lan failed with %lx, continuing\n"

ibmveth_free_all_queues() now prints it in decimal with new wording:

    "h_free_logical_lan failed: %ld\n"

Anything that greps logs for the old string will no longer match.

The open() error path after a successful registration (a failure in
ibmveth_setup_rx_interrupts() or ibmveth_alloc_tx_resources()) used to free
the LAN without logging anything. It now goes through
ibmveth_free_all_queues(), so it calls netdev_err() if H_FREE_LOGICAL_LAN
fails.

The new netdev_dbg() above also seems to repeat a message that
ibmveth_toggle_irq() already prints before it returns -EIO:

    dev_err_ratelimited(&adapter->netdev->dev,
                        "Failed to %s IRQ for queue %d, rc=0x%lx\n",
                        action, queue_index, h_rc);

The old code ignored the return value of ibmveth_disable_irq(). Is the extra
debug message needed?

Two other changes are unrelated to the move: ibmveth_register_logical_lan()
now returns long instead of int, and the adapter fields are copied into
local variables.

Could these changes either go in a separate patch or be mentioned in the
commit message?

> +
> +	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);

[ ... ]

> @@ -1232,14 +1295,7 @@ static int ibmveth_close(struct net_device *netdev)
>  
>  	ibmveth_cleanup_rx_interrupts(adapter);
>  
> -	do {
> -		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> -	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> -	if (lpar_rc != H_SUCCESS) {
> -		netdev_err(adapter->netdev,
> -			   "h_free_logical_lan failed with %lx, continuing\n",
> -			   lpar_rc);
> -	}
> +	ibmveth_free_all_queues(adapter);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119000711.18093-1-mmc%40linux.ibm.com

