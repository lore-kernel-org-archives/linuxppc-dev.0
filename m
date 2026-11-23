Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA92606A32D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqNUZAhO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXnnd26MZz2yCP;
	Mon, 23 Nov 2026 12:06:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795395973;
	cv=none; b=P2RKYUWyjeJSjW45p8wfeUqujYbwc/GmdSNhqEdXlSCshhtdTmZ/6L/Ohrro/MLLnglSDOz6TMNyF37Ww6SHxdMU0fU2JAt4OpOb0jlaD6742UOlOMOFqhpUfbAGxf10sPg34oECF+c7PA0H78WVz2c7Rlah4nL4ebyliw/E3NnSYEjVQCVaTxZ7SigjC1K9AyqM/sTDB7KZAr9e57gW0z/dOAF0hrKvXJ2VILZJrqNmFQEnHldIuli5KpyC1OIMXl9WIYOQX+o7wYwBj29pj+ei4nzZkTGZZ09y+/Uw7vqdPuOBhQvFLCzQ1Pm02XkT1uu7mahVEsXLRW76/UZiOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795395973; c=relaxed/relaxed;
	bh=bek1vXvOamnajq4jzHjrKGYyiWI4N7auK9ZUrTn9TgE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WYg/WKn+iwteDoZEAXO0kNG5beHBXzUZ64brtKCQ1qABmbT8yt9jg00691KsmjpHRe+yPnW+PnU5Skt4YFOKy3gXZg4m4ZpJAfBbrkPWybmqoIDX4KvLsK0QPEpgtbg7+htTGWv5YUAClHwLUQduydVwtqmbl/afhTFVetnfHvwPJbB7Sqh8B33g4A3ASDwXsqtiiK2AgEYCuhi91SfJyEt1QkVWS9YFd8l9AoSGTli9Cta+kuX1kt0wyUTClFQiodGLDCcnoECgrrGmmXoNbl/rjt/5hpDxXR0ZLzujgIFaA6GIdESou5B1+5yWnWfj11E2DelSM+qkTiXkgWYw2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqNUZAhO; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqNUZAhO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXnnc0gZCz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 12:06:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C25046060E;
	Mon, 23 Nov 2026 01:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772791F000C0;
	Mon, 23 Nov 2026 01:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795395969;
	bh=bek1vXvOamnajq4jzHjrKGYyiWI4N7auK9ZUrTn9TgE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FqNUZAhOyVEYfW/fOkWC4/9NG+ff+FMq/0CIKv249nnampRP6S+B91CMNlZXtGwAl
	 MOfzMMuWqDbLTeEkDWhQcJzEHXuAqxI75Q98ye6qPzBha/ZHynSVWHO/bWZqSGXgBs
	 94ZyQZE2yjWNH/g4G45y9qBXalfylwjRr3Np/3YBXXU2Zi1jNBYxb348H59+QsO2aJ
	 Te0wiwkJolfFE0yf5BIA0QYaelKyNgILqoviIHIn+S7yKhsfPF6NskBwLocHhrZ4/j
	 5IwniLqXB68htMty5nPvIA7/9Cq5uYNuLGzSBClEq7HnVkOVskOTntzIwcxIVW2J5j
	 NCwqEG7CtRGTw==
Subject: Re: [PATCH net-next 4/8] ibmveth: Refactor RX interrupt control for
 MQ RX queues
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, horms@kernel.org, davemarq@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Mon, 23 Nov 2026 01:06:08 +0000
Message-ID: <179539596806.3135.11806601454673648074@kernel.org>
In-Reply-To: <20261119000711.18093-5-mmc@linux.ibm.com>
References: <20261119000711.18093-5-mmc@linux.ibm.com>
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

- [Low] The kernel-doc for the new IRQ helpers promises a per-queue mask,
  but the code always masks the whole adapter.
- [Low] The kernel-doc of ibmveth_setup_rx_interrupts() says it "Leaves
  the queues masked in PHYP; the caller kicks NAPI, and the first poll…
- [Low] The comment added in ibmveth_poll() says "Mask before queueing,
  as schedule_rx_queue() does", but no function by that name exists.

--

ibmveth: Refactor RX interrupt control for MQ RX queues

This moves ibmveth RX IRQ and NAPI setup, teardown and PHYP masking into
helpers that take a queue index, and uses the queue's NAPI as the IRQ
cookie. It adds queue_irq[] and moves napi_enable() after request_irq().
In close(), the IRQ is now freed before H_FREE_LOGICAL_LAN.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 20273240d8fea..ab5df17940042 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -330,6 +330,150 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
>  	}
>  }
>  
> +/**
> + * ibmveth_toggle_irq - Mask or unmask one RX queue's interrupt in PHYP
> + * @adapter: ibmveth adapter structure
> + * @queue_index: RX queue index
> + * @enable: true to unmask, false to mask
> + *
> + * Return: 0 on success, -EIO on failure
> + */
> +static int
> +ibmveth_toggle_irq(struct ibmveth_adapter *adapter, int queue_index,
> +		   bool enable)
> +{
> +	const char *action = enable ? "enable" : "disable";
> +	unsigned long h_rc;
> +
> +	h_rc = h_vio_signal(adapter->vdev->unit_address,
> +			    enable ? VIO_IRQ_ENABLE : VIO_IRQ_DISABLE);

[Severity: Low]
The kernel-doc says this masks "one RX queue's interrupt". The
ibmveth_disable_irq() and ibmveth_enable_irq() wrappers and
ibmveth_schedule_rx_queue() also describe a per-queue mask. Is that
accurate?

h_vio_signal() takes only the unit address and a mode:

arch/powerpc/include/asm/vio.h:
#define h_vio_signal(ua, mode) \
  plpar_hcall_norets(H_VIO_SIGNAL, ua, mode)

So queue_index only reaches the dev_err_ratelimited() message, and every
call masks or unmasks the whole adapter.

With num_rx_queues > 1, the per-queue loops in
ibmveth_cleanup_rx_interrupts() would send the same adapter-wide hcall
once per queue. The unmask in ibmveth_poll() after napi_complete_done():

	rc = ibmveth_enable_irq(adapter, 0);

would also re-arm the interrupt for queues whose NAPI is still scheduled.

Also, only queue_irq[0] gets set (in ibmveth_open()), but
ibmveth_setup_rx_interrupts() and ibmveth_cleanup_rx_interrupts() loop
over num_rx_queues.

IBMVETH_MAX_RX_QUEUES and IBMVETH_DEFAULT_RX_QUEUES are still 1U here and
at the end of the series, so nothing changes at runtime today.

Could the kernel-doc say the mask is adapter-wide? Or would real
multi-queue masking need a different firmware mechanism, such as the
per sub-CRQ H_VIOCTL control that ibmvnic uses?

> +	if (h_rc) {
> +		dev_err_ratelimited(&adapter->netdev->dev,
> +				    "Failed to %s IRQ for queue %d, rc=0x%lx\n",
> +				    action, queue_index, h_rc);
> +		return -EIO;
> +	}
> +	return 0;
> +}

[ ... ]

> +/**
> + * ibmveth_setup_rx_interrupts - Register IRQs and enable NAPI
> + * @adapter: ibmveth adapter structure
> + *
> + * Leaves the queues masked in PHYP; the caller kicks NAPI, and the first
> + * poll unmasks.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int
> +ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	int i, rc, num = adapter->num_rx_queues;
> +
> +	for (i = 0; i < num; i++) {
> +		rc = request_irq(adapter->queue_irq[i], ibmveth_interrupt,
> +				 0, netdev->name, &adapter->napi[i]);
> +		if (rc) {

[ ... ]

> +	}
> +
> +	for (i = 0; i < num; i++)
> +		napi_enable(&adapter->napi[i]);

[Severity: Low]
Both this kernel-doc and the commit message ("napi_enable() moves to after
request_irq(), with PHYP still masked") say the queues are left masked.
The function itself only calls request_irq() and napi_enable(). Does it
depend on a precondition that the caller has to provide but that is not
documented?

The only mask is the earlier one in ibmveth_open(). Its return value is
ignored, and H_REGISTER_LOGICAL_LAN runs after it. On the kexec retry
path, H_FREE_LOGICAL_LAN and a second register also run:

ibmveth_open() {
    ...
	adapter->queue_irq[0] = netdev->irq;
	ibmveth_disable_irq(adapter, 0);

	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
    ...
}

Suppose that hcall failed, or PHYP is unmasked again by the time
request_irq() runs. An interrupt arriving before napi_enable() would go
through:

ibmveth_interrupt()
  ibmveth_schedule_rx_queue()
    napi_schedule_prep() fails because NAPI is still disabled

and return IRQ_HANDLED without masking. The queue would stay unmasked
until the later ibmveth_schedule_rx_queue(adapter, 0) kick in
ibmveth_open().

In the old order, napi_enable() ran before request_irq(), so the first
interrupt masked PHYP itself. I couldn't tell from the code whether PHYP
can reset the interrupt mode during register/free, so this may only be a
documentation issue.

Should the precondition be documented? Alternatively, could
ibmveth_setup_rx_interrupts() do the mask itself and check the result?

[ ... ]

> @@ -1902,18 +2025,17 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  	/* We think we are done - reenable interrupts,
>  	 * then check once more to make sure we are done.
>  	 */
> -	lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
> -	if (WARN_ON(lpar_rc != H_SUCCESS)) {
> +	rc = ibmveth_enable_irq(adapter, 0);
> +	if (rc) {
>  		schedule_work(&adapter->work);
>  		goto out;
>  	}
>  
> -	/* Mask before queueing, as ibmveth_interrupt() does: a threaded
> +	/* Mask before queueing, as schedule_rx_queue() does: a threaded
>  	 * NAPI can start polling, and unmask, as soon as it is queued.
>  	 */

[Severity: Low]
This isn't a bug, but the comment names schedule_rx_queue(), and there is
no function with that name. Should it be ibmveth_schedule_rx_queue()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119000711.18093-1-mmc%40linux.ibm.com

