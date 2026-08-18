Return-Path: <linuxppc-dev+bounces-25922-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADF1C5DF70
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 01:47:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPCHz4Yvsz2ygm;
	Tue, 18 Aug 2026 11:47:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787017647;
	cv=none; b=owdleQLe5RgRbwNvSfB/Qe/QVxUMoy2F9Gs16HWuCtExTSGInv2W8hiy+1i6Gj+w+71aoy1gSsv0xAobctmCqBlZWDdLIxzAJRas1OskkcD4zd5YQN7ic6TDNaL/V9K1WexfoxUa7+RSm+0Ah7ypalIasacZdjkeovJCQovXkJfb0rrLAYTIGl061Rk6LS7ufLundQFQk9b+LEX1PZrI0cGoHoxcSe+YIMU3D8GkEUq77NCBuL8m1dhNgPXDd9GbUCjjfytKBKEcYWBIVhtb3Pme/nRTUhc7l+WOoEVwESnWnKTHOug4WRppP/tQazUanIfI64fwHyDPvyJEBmTOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787017647; c=relaxed/relaxed;
	bh=83ZNN2Dir2gqtSP4d6Qmtf/8HOPgnaBtC8Y9j5M25hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAXJBVJvwp1ZBQlfTZhcOS42ELsYzCBY5TIJR8FC2d8xn/kdUpZ0MvsSTeJb45JalDd3PWKqaLy2bS4UiOR4uqzMgyWsevoPusPWt0SsAgR8i/Xnt4h5FEDD/QdLiJHIMI3ZSNAzixJRUh7NZA0JsyFaT51au7IcB8KlvH17C/xGuB+ZSb353oHlkYgUaPXOVPqMNo48PIO5M6GkTBT8vmvP0TFIFLG3120D8lAfCXGYx7HnpYtA9xe/ZyaNXvUO1h5XcMpb4SesOFUNqe7Ar4wWS2KAgYKuSIED4NvA7nQQ29HURRQzDKxo9i8yLQQD7EG+NAykRsS8mXMur0xlug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EdXN09iy; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EdXN09iy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPCHy0XBsz2ySg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:47:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1FF3060204;
	Tue, 18 Aug 2026 01:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C2C1F00A3D;
	Tue, 18 Aug 2026 01:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017643;
	bh=83ZNN2Dir2gqtSP4d6Qmtf/8HOPgnaBtC8Y9j5M25hY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EdXN09iyQRpCLJO5vBX1FuoEN6sp9iMwNJCWKIvv9dPNOhI6FU3lHd2C+GCcjocux
	 JFGdqCCn3HJhJPC6wTasbkM3fQ7LMwSadTdr7PJwjObqPLtJaFMixe4WOxpnYMw+Hw
	 3pgbDddrr8KgBUj/AebK0621WUrWidJvTyl3TbeLFKhVQIYEuvtgrfrCSRPqZ30P5L
	 Zk5vv4oMGMGLHM37RbIfAQOMWQKl8OKcHom4dozUGs17SJ0JNR2q04iB/BuENeMQyr
	 mHmbNGvGgNZz1m6L3Jp5mHh/ajmvhBXXu9i+RErZ0eH6b5YFSUP/rkLuZRI4Kdsxh7
	 5yB2d5vuJMT7w==
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
Subject: Re: [PATCH net-next v5 05/15] ibmveth: Refactor RX interrupt control for MQ RX queues
Date: Mon, 17 Aug 2026 18:47:22 -0700
Message-ID: <20260818014722.3854051-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-6-mmc@linux.ibm.com>
References: <20260814073642.24630-6-mmc@linux.ibm.com>
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
ibmveth: Refactor RX interrupt control for MQ RX queues

This patch introduces queue-indexed RX interrupt helpers (toggle/enable/
disable, setup/cleanup, schedule) and wires them into open(), close(),
poll() and the IRQ handler, with request_irq() now using &adapter->napi[i]
as the per-queue cookie. Runtime behaviour stays single-queue.

A few questions below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 1a428ee60d58c..99eeb6ef51bf3 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -331,6 +333,311 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)

[ ... ]

> +		/*
> +		 * H_PARAMETER is ambiguous (already in requested state vs bad
> +		 * args). Fold only on disable as an idempotent mask. On enable
> +		 * keep it an error so a stuck-masked queue stays visible to
> +		 * poll/resize recovery.
> +		 */
> +		if (h_rc == H_PARAMETER && !enable) {
> +			dev_warn_ratelimited(&adapter->netdev->dev,
> +					     "H_VIOCTL %s IRQ returned H_PARAMETER for queue %d (hwirq=%lu)\n",
> +					     action, queue_index, hwirq);
> +			return 0;
> +		}

[ ... ]

> +	if (adapter->multi_queue && num > 1) {
> +		for (i = 0; i < num; i++) {
> +			rc = ibmveth_enable_irq(adapter, i);
> +			if (rc) {
> +				netdev_err(netdev,
> +					   "Failed to enable IRQ for queue %d, rc=%d\n",
> +					   i, rc);
> +				while (--i >= 0) {
> +					ibmveth_disable_irq(adapter, i);
> +					synchronize_irq(adapter->queue_irq[i]);
> +				}
> +				rc = -EIO;
> +				goto err_disable_napi;
> +			}
> +		}
> +	}

[ ... ]

> +err_disable_napi:
> +	/* PHYP unmask was rolled back above; disable NAPI before free_irq */
> +	for (i = 0; i < num; i++)
> +		napi_disable(&adapter->napi[i]);
> +	for (i = 0; i < num; i++) {
> +		if (adapter->queue_irq[i])
> +			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
> +	}

[Severity: Medium]
In ibmveth_setup_rx_interrupts(), when ibmveth_enable_irq() fails for queue
i the rollback loop begins with --i, so queue i itself is never masked, yet
err_disable_napi then napi_disable()s and free_irq()s that same queue.

Is queue i guaranteed to be masked at that point?  ibmveth_toggle_irq()
folds H_PARAMETER to success only on disable, and its own comment says
H_PARAMETER may mean "already in requested state":

	if (h_rc == H_PARAMETER && !enable) {

so an enable can report an error for a queue PHYP has already unmasked.

While napi_disable() sleeps, an interrupt on that still-unmasked queue
reaches ibmveth_interrupt() -> ibmveth_schedule_rx_queue(), where
napi_schedule_prep() fails and the helper deliberately does not mask:

	if (napi_schedule_prep(napi)) {
		rc = ibmveth_disable_irq(adapter, qindex);
		WARN_ON(rc);
		__napi_schedule(napi);
		return true;
	}
	return false;

The handler still returns IRQ_HANDLED, so nothing quiets the source.  Can
this leave the PHYP interrupt asserted and re-entering the handler for the
duration of the napi_disable() wait, which is the opposite of the "mask
PHYP and synchronize_irq before napi_disable" rule stated in the changelog?

The multi_queue && num > 1 branch cannot run at this commit because
multi_queue is hardcoded to 0, but it becomes live later in the series and
the rollback loop is unchanged at the end of the series.

[ ... ]

> +/**
> + * ibmveth_schedule_rx_queue - Mask PHYP IRQ and schedule NAPI for one RX queue
> + * @adapter: ibmveth adapter structure
> + * @qindex: RX queue index
> + *
> + * Shared by the IRQ handler and process-context kick sites (open, resume,
> + * pool sysfs, poll_controller).
> + *
> + * Return: true if NAPI was scheduled (and PHYP masked), false if prep failed
> + */
> +static bool ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
> +				      int qindex)
> +{
> +	struct napi_struct *napi = &adapter->napi[qindex];
> +	int rc;
> +
> +	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
> +		return false;

[Severity: Low]
This isn't a bug, but the documented return contract does not match the
code in two ways.

The out-of-range WARN_ON branch also returns false, which is not a prep
failure, so callers cannot distinguish the two cases.

And "true ... (and PHYP masked)" is not established, since the return of
ibmveth_disable_irq() is only passed to WARN_ON() and then discarded:

	if (napi_schedule_prep(napi)) {
		rc = ibmveth_disable_irq(adapter, qindex);
		WARN_ON(rc);
		__napi_schedule(napi);
		return true;
	}

so when the mask hypercall fails the helper still reports true while the
queue remains unmasked.  Should the kernel-doc be reworded, or should the
mask failure be reflected in the return value for callers like open(),
resume(), veth_pool_store() and the later ibmveth_restart_rx_queue()?

[ ... ]

> @@ -991,24 +1297,20 @@ static int ibmveth_open(struct net_device *netdev)
>  	if (rc)
>  		goto out_free_tx_ltb;
>  
> -	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
> -	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
> -			 netdev);
> -	if (rc != 0) {
> -		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
> -			   netdev->irq, rc);
> +	rc = ibmveth_setup_rx_interrupts(adapter);
> +	if (rc) {
>  		do {
>  			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>  		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> -
>  		goto out_free_buffer_pools;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but the ordering here is worth a
question now that close() gains an early return.

ibmveth_open() registers the logical LAN before allocating buffer pools, and
the pool allocation failure branch takes goto out_free_tx_ltb, which runs:

out_free_tx_ltb:
	while (--i >= 0)
		ibmveth_free_tx_ltb(adapter, i);
	ibmveth_cleanup_rx_resources(adapter);
out_free_filter_list:
	ibmveth_free_filter_list(adapter);

That dma_unmaps buffer_list_dma[0], dma_free_coherent()s the RX ring and
frees the filter list page without ever calling h_free_logical_lan().  Does
this leave PHYP registered against the buffer list, filter list and RX
descriptor ring after those pages have been unmapped and returned to the
page allocator?

The same ordering exists in the baseline at 4f93b12cf7b2, so the root
problem predates this patch.  What changes here is that the new
"if (!adapter->opened) return 0;" gate in ibmveth_close() also removes the
accidental recovery a later ndo_stop used to provide by running the
h_free_logical_lan() loop.

For reference, this is resolved by the end of the series: open() there
allocates the buffer pools before ibmveth_register_rx_queues(), and every
post-registration error path funnels into ibmveth_free_all_queues(), which
issues h_free_logical_lan() in a retry loop.

> @@ -1032,27 +1333,32 @@ static int ibmveth_close(struct net_device *netdev)
>  	long lpar_rc;
>  	int i;
>  
> -	netdev_dbg(netdev, "close starting\n");
> +	/* Gate on opened, not IFF_UP: pool_store/change_mtu close+open can
> +	 * leave IFF_UP set after a failed reopen.
> +	 */
> +	if (!adapter->opened)
> +		return 0;
>  
> -	napi_disable(&adapter->napi[0]);
> +	adapter->opened = false;

[Severity: Low]
This is a pre-existing issue rather than something introduced here, but
should this gate carry a Fixes: tag and a note in the changelog?

In the baseline, ibmveth_close() unconditionally ran
napi_disable(&adapter->napi[0]) and free_irq(netdev->irq, netdev).  After a
failed reopen from veth_pool_store() or ibmveth_change_mtu() (both call
close() then open() directly and leave IFF_UP set when open fails), a
subsequent "ip link set down" re-entered ndo_stop with NAPI already
disabled and no IRQ registered.  napi_disable_locked() leaves
NAPIF_STATE_SCHED|NPSVC set, so the second napi_disable() spins in its
usleep_range() loop while holding rtnl, and free_irq() splats "Trying to
free already-free IRQ".

The changelog describes the mechanism ("opened / rx_irq_setup gate whether
cleanup walks IRQ/NAPI state") and the v5 notes below the --- describe the
scenario, but the commit message itself never says a hang is being fixed
and there is no Fixes: tag, so the fix is hard to identify for backports.
It also cannot be applied on its own since it depends on the new helpers,
flags and queue_irq[] array added here.

[Severity: Medium]
Separately, can this early return skip TX long-term-buffer teardown?  At
this commit ibmveth_set_channels() keys its allocation decision off IFF_UP:

	if (!(netdev->flags & IFF_UP))
		return netif_set_real_num_tx_queues(netdev, goal);

so after a failed reopen (IFF_UP still set, adapter->opened false),
"ethtool -L eth0 tx N" takes the allocating branch while the adapter is
closed.  The next ndo_stop then returns early and never reaches:

	for (i = 0; i < netdev->real_num_tx_queues; i++)
		ibmveth_free_tx_ltb(adapter, i);

and the next ibmveth_open() assigns tx_ltb_ptr[i]/tx_ltb_dma[i]
unconditionally.  Does that leak the bounce buffer and its DMA mapping per
TX queue?

By the end of the series ibmveth_set_channels() gates on
"if (!adapter->opened)" and only stashes queue counts, so no path allocates
TX LTBs while the adapter is closed, which removes this window.

[ ... ]

> @@ -1696,7 +2002,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  			container_of(napi, struct ibmveth_adapter, napi[0]);
>  	struct net_device *netdev = adapter->netdev;
>  	int frames_processed = 0;
> -	unsigned long lpar_rc;
> +	int rc;
>  	u16 mss = 0;
>  
>  restart_poll:

[ ... ]

> @@ -1796,15 +2102,15 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  	/* We think we are done - reenable interrupts,
>  	 * then check once more to make sure we are done.
>  	 */
> -	lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
> -	if (WARN_ON(lpar_rc != H_SUCCESS)) {
> +	rc = ibmveth_enable_irq(adapter, 0);
> +	if (WARN_ON(rc)) {
>  		schedule_work(&adapter->work);
>  		goto out;
>  	}
>  
>  	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
> -		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
> -				       VIO_IRQ_DISABLE);
> +		rc = ibmveth_disable_irq(adapter, 0);
> +		WARN_ON(rc);
>  		goto restart_poll;
>  	}

[Severity: Low]
This isn't a bug today, but the two halves of the new per-queue protocol
disagree.  ibmveth_interrupt() now resolves the queue that fired:

	qindex = napi - adapter->napi;
	...
	ibmveth_schedule_rx_queue(adapter, qindex);

while ibmveth_poll() still recovers the adapter through
container_of(napi, struct ibmveth_adapter, napi[0]) and hardcodes queue 0
in ibmveth_enable_irq(adapter, 0) / ibmveth_disable_irq(adapter, 0).  For a
napi index above 0 that container_of would compute a wrong adapter pointer
and the unmask would target queue 0 rather than the queue that fired.

Since IBMVETH_MAX_RX_QUEUES is 1 and multi_queue is 0 at this commit only
napi[0] can be registered, and later commits in the series ("ibmveth:
Harden RX poll path with helpers" / "ibmveth: Enable multi-queue RX receive
path") derive queue_index = napi - adapter->napi in poll() with a range
check.  Would it be clearer to convert poll() in the same patch that
introduces the queue-indexed handler, so the two sides never disagree?

