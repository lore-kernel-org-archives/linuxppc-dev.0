Return-Path: <linuxppc-dev+bounces-25927-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E11C5DF74
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 01:48:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPCJ94FnRz2xtt;
	Tue, 18 Aug 2026 11:47:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787017657;
	cv=none; b=Q+9hglpne8p61CfGmfAdJCVo5iUzTlff/QL5D5tfGEsKPqUDhQTkJFR+onD+0Ade8q8UwRH7P1Iup/Qdj7XaSUqBToCw+uXcWZ9vHQlU2mQHiiTb6r5q83W5nwHJ3jvzk97oOfSKSF9DRhkwQCuNsh0HjsaEMlqgmgMqgJgRjZP40ICe6lqwvVqv+77lkQlKWz42In3zM8RV8ZgYDe0SJn+jxpaqkvNK/yDzf2xYCP3k2qSzM08SSInFyiwUN0AIIvf+8xgX7qmMS1kGrHj5FOOSG79XND7wAABx57bgVkafGKlAU67OnML0FSCMKJmWN0r2knoRSveWgixBVPfu9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787017657; c=relaxed/relaxed;
	bh=qnYRR0b4LckMsKjcyZaahsdnbNpeDEHYB0W1hc9bWFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRaLLlpU06IgIOY17isFctARK2VBfs0g9tqR5GANeak/oNRUxfa7nDzBZIPyLlHK5Pc1kB+/mgeWS8Z9/3mYZUXZ+lL4nLjfaBmZVYsVb2H/NuUHm/dD8JhoQS4CWaHR2xh8LwMYefo6KNObvZdI4Dc/sj8ig/vn+UeTF+UZvBGK0LbapDM7mJW9sqmkIWMZC1R2X9MVmqKNRQ9ipwYjGAnr14S/FTgEbQEO3h73hwUsB6JpeqN4V7esp/xjaUvkPB5jAeBvYCjFbK+K3/J5p0kJloneHR1UJ5XjAKypv7fZ5y9coPDOzZxSCLn1dEY/Hg98gRgxRzyP2txH3rsWmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nez3SToH; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nez3SToH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPCJ75d0Rz2yrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:47:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9B8B84023A;
	Tue, 18 Aug 2026 01:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A821E1F00A3D;
	Tue, 18 Aug 2026 01:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017653;
	bh=qnYRR0b4LckMsKjcyZaahsdnbNpeDEHYB0W1hc9bWFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nez3SToHNbwfyv8Fn3eXVC9CyFIWM3kR1kbdatBmQrYR3rt1DNa1Qr/o/zHEIksvQ
	 R17BSXUAb8Yorupg8ehxe1LraL2p1tk4xWRA3Zwdh1V7I6UTobyKCKO7od5k5QkF2R
	 lNnt5W9plvBXJjqp0zek7fzeowOvotFZcLqV0ZEnPL2LAcz6n96cIHjvMpQiiJV88D
	 /Og0z4VT5VZ3qn5rTkoU1J8y8HbhfqGTqLzsDEODGpQzum5cDYSM7bcgt/6XYfpyIA
	 ciM8T0dEqByc/ayT2whElUtBFXOFLcj5ar/MoVETRmJboq6xg8t+yYEkaakWtDNAxm
	 pmriDWbjzxFiQ==
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
Subject: Re: [PATCH net-next v5 10/15] ibmveth: Enable multi-queue RX receive path
Date: Mon, 17 Aug 2026 18:47:31 -0700
Message-ID: <20260818014731.3854329-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-11-mmc@linux.ibm.com>
References: <20260814073642.24630-11-mmc@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ibmveth: Enable multi-queue RX receive path

This turns on the multi-queue RX path when firmware reports
IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT, registering subordinate queues via
H_REG_LOGICAL_LAN_QUEUE and wiring per-queue IRQs and NAPI instances. It
also reworks open()/close() to walk every live RX queue, adds an
mq_fallback latch, and refreshes the VIO CMO entitlement at probe.

A few questions below.

Regarding this part of the changelog:

  Up to IBMVETH_MAX_RX_QUEUES (16) remains available via ethtool -L.

[Severity: Low]
Is that true at this commit?  ibmveth_get_channels() still does:

	channels->max_rx = netdev->real_num_rx_queues;
	channels->rx_count = netdev->real_num_rx_queues;

and ibmveth_set_channels() never reads channels->rx_count, so an
"ethtool -L <dev> rx N" returns success without changing anything, and 16
RX queues cannot be requested until the later get_channels/set_channels
patches land.  Could this sentence move to the patch that actually wires
rx_count up?

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 86299c62d4ecf..36f0926711e60 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -503,7 +519,7 @@ static int
>  ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
>  {
>  	struct net_device *netdev = adapter->netdev;
> -	int i, rc, num = adapter->num_rx_queues;
> +	int i, rc, num = ibmveth_get_num_rx_queues(adapter);
>  
>  	for (i = 0; i < num; i++) {
>  		if (!adapter->queue_irq[i]) {

[Severity: Low]
Now that this function can enable PHYP delivery on several queues, can the
err_disable_napi rollback leave a queue armed with no handler?

The rollback masks the already-enabled queues and calls synchronize_irq(),
but synchronize_irq() does not wait for NAPI.  A poll already running for
one of those queues reaches:

	if (ibmveth_poll_stopping(netdev, napi))
		goto out;

	rc = ibmveth_enable_irq(adapter, queue_index);

ibmveth_poll_stopping() is "!netif_running(netdev) || napi_disable_pending()",
and __dev_open() sets __LINK_STATE_START before calling ndo_open, so it is
false here and the poll re-arms PHYP.  err_disable_napi then does:

	for (i = 0; i < num; i++)
		napi_disable(&adapter->napi[i]);
	for (i = 0; i < num; i++) {
		if (adapter->queue_irq[i])
			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
	}

with no second mask pass, whereas ibmveth_cleanup_rx_interrupts()
deliberately masks again after napi_disable().  Should the rollback follow
the cleanup pattern and remask after napi_disable()?

> @@ -649,6 +665,24 @@ static bool ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
>  	return false;
>  }
>  
> +/**
> + * ibmveth_kick_rx_queue_if_pending - Schedule NAPI if PHYP posted while masked
> + * @adapter: ibmveth adapter
> + * @queue_index: RX queue index just unmasked
> + *
> + * After enable_irq() / MQ open unmask, descriptors may already be pending
> + * (buffers were posted while PHYP was masked). Use schedule_rx_queue() so
> + * PHYP is masked before NAPI runs — napi_schedule() then disable_irq() from
> + * process context can race a completing poll and leave the queue masked
> + * with NAPI idle.
> + */
> +static void
> +ibmveth_kick_rx_queue_if_pending(struct ibmveth_adapter *adapter,
> +				 int queue_index)
> +{
> +	if (ibmveth_rxq_pending_buffer(adapter, queue_index))
> +		ibmveth_schedule_rx_queue(adapter, queue_index);
> +}

[Severity: Low]
Does this commit build on its own?  ibmveth_kick_rx_queue_if_pending() is a
non-inline static function with no caller anywhere in the tree at this
commit (open() uses ibmveth_restart_rx_queue() instead), so gcc/clang emit
"defined but not used", which is fatal with the default CONFIG_WERROR=y.

The first callers appear only in the later incremental resize patch.  Could
the helper be introduced there instead, to keep this commit bisectable?

Also, the blank line before the following comment block was dropped:

	+		ibmveth_schedule_rx_queue(adapter, queue_index);
	+}
	 /* setup the initial settings for a buffer pool */

> @@ -963,11 +997,21 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>   * because there was not a buffer in the buffer list capable of holding
>   * the frame.
>   */
> -static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
> +static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
> +					int queue_index)
>  {
> -	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
> +	__be64 *p;
> +	u64 drops;
> +
> +	if (queue_index < 0 ||
> +	    queue_index >= ibmveth_get_num_rx_queues(adapter) ||
> +	    !adapter->buffer_list_addr[queue_index])
> +		return;
> +
> +	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
> +	drops = be64_to_cpup(p);
>  
> -	adapter->rx_no_buffer = be64_to_cpup(p);
> +	adapter->rx_no_buffer = drops;
>  }

[Severity: Low]
The function became queue-aware, but the store target is still the single
adapter-wide field exported by ethtool -S.  With several RX queues, does
rx_no_buffer end up being "whichever queue ran last", and can it decrease?

Each queue reads its own absolute PHYP page counter and overwrites the same
scalar, from per-queue replenish paths that hold different replenish_locks,
plus the lock-free loop added in ibmveth_close():

	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
		ibmveth_update_rx_no_buffer(adapter, i);

The next patch in the series ("ibmveth: Add per-queue RX and TX statistics
collection") moves this to adapter->rx_qstats[queue_index] with a summing
helper, so only this intermediate commit reports the wrong value.  Could
the per-queue slot land together with the queue_index argument?

> @@ -1033,6 +1077,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>  		dev_err_ratelimited(&adapter->netdev->dev,
>  				    "MQ buffer add H_FUNCTION (q=%d, batch=%u), reset\n",
>  				    queue_index, fail.batch);
> +		adapter->mq_fallback = true;
>  		schedule_work(&adapter->work);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but it adds another producer of
adapter->work while ibmveth_remove() still cancels the work before the
interface is unregistered:

	cancel_work_sync(&adapter->work);
	...
	unregister_netdev(netdev);
	free_netdev(netdev);

Can this sequence use freed memory?

CPU0 (rmmod / DLPAR remove)
  ibmveth_remove()
    cancel_work_sync(&adapter->work);   /* returns */

CPU1 (NAPI poll)
  ibmveth_replenish_task()
    adapter->mq_fallback = true;
    schedule_work(&adapter->work);      /* re-queued */

CPU0
    unregister_netdev(netdev);          /* holds RTNL */
    free_netdev(netdev);                /* frees adapter + work_struct */

The queued ibmveth_reset() blocks in rtnl_lock() while unregister_netdev()
runs, then derives adapter via container_of() on the freed work_struct and
touches adapter->netdev.  Would unregistering/quiescing first and calling
cancel_work_sync() after be safer?

> @@ -1052,6 +1097,30 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>  				     fail.filled, fail.lpar_rc, fail.batch);
>  }
>  
> +/**
> + * ibmveth_restart_rx_queue - Post buffers and ensure Q can take RX
> + * @adapter: ibmveth adapter
> + * @qindex: RX queue index
> + *
> + * SQ open leaves PHYP masked until the first poll. If schedule_prep fails,
> + * NAPI never runs and the queue stays masked (TX OK, RX/ARP dead) until
> + * reload. Replenish first so an enable_irq fallback can actually deliver.
> + * Also used after every open (SQ and MQ) and after scale-down so a
> + * queue is not left idle+masked.
> + */
> +static void ibmveth_restart_rx_queue(struct ibmveth_adapter *adapter,
> +				     int qindex)
> +{
> +	int rc;
> +
> +	ibmveth_replenish_task(adapter, qindex);
> +	if (ibmveth_schedule_rx_queue(adapter, qindex))
> +		return;
> +
> +	rc = ibmveth_enable_irq(adapter, qindex);
> +	WARN_ON(rc);
> +}

[Severity: Medium]
The enable_irq() fallback here is reached exactly when
napi_schedule_prep() failed, i.e. when a poll for that queue is already
scheduled or running.  In MQ mode ibmveth_setup_rx_interrupts() has already
unmasked PHYP before open() calls this helper, so a frame can arrive first:

  ibmveth_interrupt(q)
    ibmveth_schedule_rx_queue(q)   /* masks PHYP, schedules NAPI */

  ibmveth_open()
    ibmveth_restart_rx_queue(adapter, q)
      napi_schedule_prep() == false
      ibmveth_enable_irq(adapter, q);   /* re-arms PHYP mid-poll */

Since ibmveth_schedule_rx_queue() masks PHYP only inside the successful
prep branch:

	if (napi_schedule_prep(napi)) {
		rc = ibmveth_disable_irq(adapter, qindex);
		WARN_ON(rc);
		__napi_schedule(napi);
		return true;
	}
	return false;

can the handler still quiesce the source afterwards?  Each subsequent
interrupt returns IRQ_HANDLED without masking and sets NAPI_STATE_MISSED,
so napi_complete_done() keeps returning false and the queue stays unmasked
while traffic flows, giving an interrupt per frame on that queue.

Related: this WARN_ON(rc) treats a failed unmask hcall as advisory, while
ibmveth_poll() treats the same failure as a hardware-state problem:

	rc = ibmveth_enable_irq(adapter, queue_index);
	if (rc) {
		netdev_err(...);
		schedule_work(&adapter->work);
		goto out;
	}

Should the two paths handle the failure the same way?

Also, the comment says the helper is used "after scale-down", but no
scale-down caller exists at this commit; that path arrives with the later
resize patch.

[ ... ]

> @@ -1556,10 +1757,12 @@ static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
>   * @adapter: ibmveth adapter structure
>   * @mac_address: MAC address for device registration
>   *
> - * Registers queue 0 via ibmveth_register_logical_lan(). Subordinate queue
> - * registration is added when multi-queue RX is enabled.
> + * Registers queue 0 via ibmveth_register_logical_lan(), then subordinate
> + * queues 1..N when multi-queue mode is enabled.
>   *
> - * Return: 0 on success, -ENONET if queue 0 registration fails
> + * Return: 0 on success, -ENONET if queue 0 registration fails,
> + *         -EOPNOTSUPP if firmware rejects a subordinate queue (H_FUNCTION;
> + *         caller latches mq_fallback), -EIO on other subordinate failures

[Severity: Low]
The kernel-doc says the caller latches mq_fallback, but the function body
does it itself and ibmveth_open() only propagates rc.  Could the wording be
changed to say this function latches adapter->mq_fallback, so a future
change does not add a second latch or remove this one?

> @@ -1592,9 +1796,67 @@ ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
>  		return -ENONET;
>  	}
>  
> +	num = ibmveth_get_num_rx_queues(adapter);
> +	if (num == 1 || !adapter->multi_queue) {
> +		netdev_dbg(netdev,
> +			   "registered 1 RX queue with hypervisor (single-queue mode)\n");
> +		return 0;
> +	}
> +
> +	netdev_dbg(netdev, "Registering %d subordinate queues (1-%d)\n",
> +		   num - 1, num - 1);
> +
> +	for (i = 1; i < num; i++) {
> +		rc = ibmveth_register_single_rx_queue(adapter, i);
> +		if (rc) {
> +			/* Firmware MQ gone: fall back to SQ on next open. */
> +			if (rc == -EOPNOTSUPP)
> +				adapter->mq_fallback = true;
> +			goto err_unregister;
> +		}
> +	}

[Severity: High]
Who performs the "next open" that consumes the latched mq_fallback?

The only automatic recovery path is the reset work:

  ibmveth_reset()
    rtnl_lock();
    dev_close(adapter->netdev);
    dev_open(adapter->netdev, NULL);   /* return value discarded */
    rtnl_unlock();

If firmware stops honouring H_REG_LOGICAL_LAN_QUEUE (the LPM case the code
comment describes), that dev_open() fails with -EOPNOTSUPP, mq_fallback is
set, nothing looks at the error, and no further open is attempted.  Does
the interface then stay administratively up but dead until an administrator
runs ifdown/ifup, even though the driver already knows the single-queue
retry would succeed?

Would retrying single-queue inside open(), or re-arming the reset work when
dev_open() fails, match the intent stated in the changelog?

[ ... ]

> @@ -2732,23 +3019,35 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
>  
>  	adapter = netdev_priv(netdev);
>  
> -	ret = IBMVETH_BUFF_LIST_SIZE + IBMVETH_FILT_LIST_SIZE;
> +	/* One buffer list page per RX queue; filter list is shared. */
> +	ret = IBMVETH_BUFF_LIST_SIZE * ibmveth_get_num_rx_queues(adapter) +
> +	      IBMVETH_FILT_LIST_SIZE;
>  	ret += IOMMU_PAGE_ALIGN(netdev->mtu, tbl);
>  	/* add size of mapped tx buffers */
>  	ret += IOMMU_PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE, tbl);

[Severity: Medium]
This is a pre-existing shortfall rather than something this patch created,
but since the function is being rewritten and its result now becomes the
probe-time CMO request, should the TX term scale with the TX queue count?

ibmveth_alloc_tx_resources() maps one long-term buffer per TX queue:

	for (i = 0; i < netdev->real_num_tx_queues; i++) {
		if (ibmveth_allocate_tx_ltb(adapter, i))
			goto err_free_ltbs;
	}

with real_num_tx_queues defaulting to min(nr_cpus, 8), while the accounting
above adds exactly one IBMVETH_MAX_TX_BUF_SIZE.  Can the requested
entitlement be short by up to 7 x 64KB, so that dma_map_single() in
ibmveth_allocate_tx_ltb() fails at open on an entitlement-constrained
partition?  vio_cmo_set_dev_desired() returns void, so the shortfall is
silent.

[ ... ]

> @@ -2895,16 +3206,29 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  		netdev->features |= NETIF_F_FRAGLIST;
>  	}
>  
> -	/* Initialize queue count - always 1 for now */
> -	adapter->multi_queue = 0;
> -	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
> +	if (ret == H_SUCCESS &&
> +	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT)) {
> +		adapter->multi_queue = 1;
> +		ibmveth_publish_num_rx_queues(adapter,
> +					      min(num_online_cpus(),
> +						  IBMVETH_DEFAULT_QUEUES));
> +		netdev_dbg(netdev, "RX multi queue mode enabled: %d queues\n",
> +			   ibmveth_get_num_rx_queues(adapter));
> +	} else {
> +		adapter->multi_queue = 0;
> +		ibmveth_publish_num_rx_queues(adapter,
> +					      IBMVETH_DEFAULT_RX_QUEUES);
> +	}

[Severity: Medium]
Activating several RX NAPI instances makes a number of adapter-wide
counters multi-writer.  Can these lose increments?

ibmveth_replenish_task() bumps a shared counter outside any lock:

	adapter->replenish_task_cycles++;

	spin_lock_irqsave(&rxq->replenish_lock, flags);

and ibmveth_replenish_buffer_pool() updates shared counters under only the
queue-local lock:

	adapter->replenish_add_buff_success += filled;

Per-queue replenish_locks give no mutual exclusion between different
queues, so plain read-modify-write on replenish_task_cycles,
replenish_add_buff_success/failure, replenish_no_mem and
hcall_stats.add_bufs_queue races.  At this commit rx_invalid_buffer,
rx_large_packets and netdev->stats.rx_packets/rx_bytes are in the same
situation; the following qstats patch moves those to per-queue storage, but
the replenish counters remain shared through the end of the series.  Should
they get per-queue slots as well?

> @@ -2922,25 +3246,62 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  
>  	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>  		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
> -		int error;
>  
>  		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
>  					 pool_count[i], pool_size[i],
>  					 pool_active[i]);
> -		error = kobject_init_and_add(kobj, &ktype_veth_pool,
> -					     &dev->dev.kobj, "pool%d", i);
> -		if (!error)
> -			kobject_uevent(kobj, KOBJ_ADD);
> +		rc = kobject_init_and_add(kobj, &ktype_veth_pool,
> +					  &dev->dev.kobj, "pool%d", i);
> +		if (rc) {
> +			dev_err(&dev->dev,
> +				"failed to create pool%d kobject: %d\n", i, rc);
> +			/* init_and_add takes a ref even on failure */
> +			kobject_put(kobj);
> +			ibmveth_put_pool_kobjs(adapter, pools_ready);
> +			dev_set_drvdata(&dev->dev, NULL);
> +			free_netdev(netdev);
> +			return rc;
> +		}
> +
> +		pools_ready++;
> +		kobject_uevent(kobj, KOBJ_ADD);
>  	}

[Severity: Low]
This is a pre-existing problem being repaired rather than a new one, but
propagating kobject_init_and_add() failure and putting already-created pool
kobjects before free_netdev() is a standalone fix for probe error handling
that predates the MQ work.  Could it be split into its own patch with a
Fixes: tag so it can be backported independently of this feature?

[Severity: Medium]
This isn't a bug introduced by this patch either (ibmveth_remove() already
does kobject_put() followed by free_netdev()), but the pattern is now
replicated in four new probe error paths.  Can these free memory that a
deferred kobject release still uses?

ktype_veth_pool has no release callback:

	static const struct kobj_type ktype_veth_pool = {
		.release        = NULL,
		.sysfs_ops      = &veth_pool_ops,
		.default_groups = veth_pool_groups,
	};

and the kobjects live inside netdev_priv().  With
CONFIG_DEBUG_KOBJECT_RELEASE=y, kobject_release() in lib/kobject.c does not
clean up synchronously:

	unsigned long delay = HZ + HZ * get_random_u32_below(4);
	...
	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);

	schedule_delayed_work(&kobj->release, delay);

The delayed_work lives inside the kobject, so free_netdev() right after
kobject_put() leaves a queued work item in freed memory and
kobject_delayed_cleanup() dereferences a freed kobj 1-5 seconds later.
Would a no-op .release for ktype_veth_pool, or deferring free_netdev()
until the kobjects are really gone, avoid that?

> +	/*
> +	 * VIO CMO entitlement was set before probe (netdev NULL → default).
> +	 * Recompute now that num_rx_queues and pool 0 metadata are known.
> +	 */
> +	if (firmware_has_feature(FW_FEATURE_CMO))
> +		vio_cmo_set_dev_desired(dev, ibmveth_get_desired_dma(dev));
> +
>  	rc = netif_set_real_num_tx_queues(netdev, min(num_online_cpus(),
>  						      IBMVETH_DEFAULT_QUEUES));
>  	if (rc) {
>  		netdev_dbg(netdev, "failed to set number of tx queues rc=%d\n",
>  			   rc);
> +		ibmveth_put_pool_kobjs(adapter, pools_ready);
> +		dev_set_drvdata(&dev->dev, NULL);
>  		free_netdev(netdev);
>  		return rc;
>  	}

[ ... ]

Cross-instance finding from sashiko-gemini (91dce8e1ae8c5dfd96a2db94571e030c1951674452013e31a94e2df21bfc801b):
[Severity: Medium]
Missing `smp_rmb()` in `ibmveth_get_num_rx_queues` allows out-of-order reads of uninitialized queue data.

