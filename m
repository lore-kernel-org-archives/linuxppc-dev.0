Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A92606A321
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfRNVklo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYc7G688Bz2y2b;
	Tue, 24 Nov 2026 19:54:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795510458;
	cv=none; b=cCxXuv5FvRRSJr7vfMg2rSRGsnhrUHyfq/+bIm/aSI5FiyU+W20qO5Ltnzq7JOUUhze+klpR7QbeY8AMpAfJNVg62oueOAIGFqmlNK10OoS93MdL0h/hlzvwXmVUXQnIps85DKTkmKF9DBPEBF7G4MOuKo0dgDgvgmcQbWKgZTpeJ/VTYceUDDhgrbV+/9ryYQH2QgKYlWQbp5GioZwQfKrMbedI7ULCW5RGf7yG2vIgtKa1xy1+iBlwTWVzVrQwa8Jzgnk1k22sLRzb66tprcHxdaAdWOWclU2pAUp1KnNb19HAd6wYSN+jU7qXQ0igIdXRPv37TytflINTX2jDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795510458; c=relaxed/relaxed;
	bh=QUDG01uMlxGs3ZoZiYFkDjI4/YMZ+OvwNTGHmN+I410=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gl5qmb5bN+Vv7H151dbLvs6wAAjiC4WVRHt/A7Pbf0lEfPSVKkX8ywkL1efmeA+2iYdJ1ssGaZF76hhW5Owhs2LUfzuFSpS4ynLlnWCZjNfNaBBZI56kJRpAxawjAJwInNehCXGnfR651H9RD9HL7GYlw6ssZ3noykbsB5NXu5gNrHS9uENmuh0iqDgb6cr3+VxxId0vARc7a7AKpN2x1okLvks7tVKD06dMQpjKhOCIU0iJyYScnKRE8MlZXdH3sQupYpr2lAIMTSoLhsfYnWJ76DOeuohkd1NDWK5bS1dYqyka84yKb1bKgUv/jyC9/PvKWA+6VLOlp5mJ+9OpoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfRNVklo; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfRNVklo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYc7F3gtZz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 19:54:17 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AC7F962234;
	Tue, 24 Nov 2026 08:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D404E1F000C4;
	Tue, 24 Nov 2026 08:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795510454;
	bh=QUDG01uMlxGs3ZoZiYFkDjI4/YMZ+OvwNTGHmN+I410=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TfRNVkloSLo0i8Z+98n7kJzxtT3DU4Mr/yjjHMNjjq+9oqP/HL+pPpfyqsJIQHQ6Z
	 ZMTlpENxKVbaUwWzBm7UdU9KPEOdEOFpCdy64MKOEL63R+PB1v8LKpOl20RTSbsttg
	 LapyGllfn6YDe/HZqcUKOULGz1qvgKEQgWStvxAw3n8LD989m9vgCs8acIfjPD2JGk
	 /DSXpniTbRZgom+1Op7aeACQFjr0Hc4U6bIlHBNZNfoMdY/AZZpGlu4qG12lJxrXsj
	 keD1Q9MOR2NdtcSBd3vEIlPCpH2QnydEsAus1x0RLFoEg47BYt1eCvgQKPqc9okB56
	 DjuyUBxS1j0KQ==
Subject: Re: [PATCH net-next v2 3/8] ibmveth: Refactor buffer pool management
 for per-queue MQ RX
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, horms@kernel.org, davemarq@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Tue, 24 Nov 2026 08:54:12 +0000
Message-ID: <179551045236.3135.13521842784287344413@kernel.org>
In-Reply-To: <20261123075136.3278-4-mmc@linux.ibm.com>
References: <20261123075136.3278-4-mmc@linux.ibm.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ibmveth: persistent pool deactivation in
  ibmveth_alloc_queue_buffer_pools()

--

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -660,6 +660,100 @@ static void ibmveth_rxq_no_skb(struct ibmveth_adapter *adapter,
>  	schedule_work(&adapter->work);
>  }
>  
> +/**
> + * ibmveth_free_queue_buffer_pools - Free buffer pools for a single queue
> + * @adapter: ibmveth adapter structure
> + * @queue: queue index
> + *
> + * Frees every pool on @queue regardless of the active flag;
> + * ibmveth_free_buffer_pool() skips what was never allocated.
> + */
> +static void ibmveth_free_queue_buffer_pools(struct ibmveth_adapter *adapter,
> +					    int queue)
> +{
> +	int i;
> +
> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
> +		ibmveth_free_buffer_pool(adapter,
> +					 &adapter->rx_buff_pool[queue][i]);
> +}
> +
> +/**
> + * ibmveth_alloc_queue_buffer_pools - Allocate buffer pools for a single queue
> + * @adapter: ibmveth adapter structure
> + * @queue: queue index
> + *
> + * Allocates backing storage for each active pool on @queue.
> + *
> + * Return: 0 on success, -ENOMEM on failure
> + */
> +static int ibmveth_alloc_queue_buffer_pools(struct ibmveth_adapter *adapter,
> +					    int queue)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	int i;
> +
> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> +		struct ibmveth_buff_pool *bpool =
> +			&adapter->rx_buff_pool[queue][i];
> +
> +		if (!bpool->active)
> +			continue;
> +
> +		if (ibmveth_alloc_buffer_pool(bpool)) {
> +			netdev_err(netdev,
> +				   "queue %d pool %d alloc failed (size=%u count=%u)\n",
> +				   queue, i,
> +				   bpool->buff_size,
> +				   bpool->size);
> +			bpool->active = 0;
> +			/* Undo the pools this queue already allocated; the
> +			 * failed one freed its own partial allocation.
> +			 */
> +			ibmveth_free_queue_buffer_pools(adapter, queue);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ibmveth_alloc_buffer_pools - Allocate buffer pools for all queues
> + * @adapter: ibmveth adapter structure
> + *
> + * Return: 0 on success, -ENOMEM on failure
> + */
> +static int
> +ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
> +{
> +	int q, rc;
> +
> +	for (q = 0; q < adapter->num_rx_queues; q++) {
> +		rc = ibmveth_alloc_queue_buffer_pools(adapter, q);
> +		if (rc) {
> +			while (--q >= 0)
> +				ibmveth_free_queue_buffer_pools(adapter, q);
> +			return rc;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ibmveth_free_buffer_pools - Free buffer pools for all queues
> + * @adapter: ibmveth adapter structure
> + */
> +static void
> +ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
> +{
> +	int q;
> +
> +	for (q = 0; q < adapter->num_rx_queues; q++)
> +		ibmveth_free_queue_buffer_pools(adapter, q);
> +}
> +
>  /**
>   * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
>   * @adapter: adapter instance

[Severity: Medium]
Now that ibmveth_free_queue_buffer_pools() frees every pool on the
queue regardless of the active flag, is there still a reason to clear
bpool->active here?

The active flag is the pool's persistent configuration. It comes from
pool_active[] at probe, is turned on by ibmveth_change_mtu() for large
MTUs and toggled through veth_pool_store(), and ibmveth_close() leaves
it alone so the same pools come back on the next open. Clearing it on
a transient ibmveth_alloc_buffer_pool() failure has two effects. A
later ibmveth_open() quietly skips that pool, and it can succeed
without a pool large enough for mtu + IBMVETH_BUFF_OH.

None of the callers of ibmveth_open() put the flag back.
veth_pool_store() only restores oldactive for the pool it is editing.
The ndo_open path, ibmveth_change_mtu(), ibmveth_set_csum_offload(),
ibmveth_set_tso() and ibmveth_reset() do not touch it at all.

The old single-queue loop did the same thing. With per-queue pools,
though, a failure on one queue also leaves rx_buff_pool[q][i].active
different between queues for the same pool index.

Can this line simply be dropped, since the unwind no longer depends on
it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123075136.3278-1-mmc%40linux.ibm.com

