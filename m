Return-Path: <linuxppc-dev+bounces-26507-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC180C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 23:39:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbbfm2Ng8z2xfP;
	Fri, 04 Sep 2026 09:39:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788459042;
	cv=none; b=LYkFN2O44A9DWjV3W1LgtCHTh/bmr8FOQz3P/ym0UcskVTDarrtB2XbZIp8yVAE3pVuLkLB7OlPLzQnoPWnbSoN8ONpvAmSrX3OtYeUo+ew6fj2aXnWJ2cV3Ijjur1fpLDtqzevzaZP9JkdvgCEenFuFCuPa8xm41oFqwSmtDqUXv3cnGghST2VxGe9x3cgx/y0eTTyh0ZWS2PlpSmYvozG85zG5sSuEUgu1zqlVtMwtSDqjXV/UHCo1xr+Lj2rLbQYV7Fly1BZOUL16M8D5neulkXHwi9RonaFzsVFmUV8aDq5Q5rsNxj02DZc3K3DzCHksVWPKabsR8cxmK7nA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788459042; c=relaxed/relaxed;
	bh=Ho2GaUYZW7F1ZlLG9J8DaiLoLiz6rBxcIfn/E06cPYE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BJGr2XJgXhMGhZUo+YKa0rEw8zjeaS4VhhfjKQ4cpnKU8IdDQcNZhwRauMjdU/AnyuQ0IETRhuuLxuQjZfDisJdsKF5qODvFCyi1FaqcXMdQF4gE1m2f0SDW3radl758OES51WzBC9Tw0/+2Ngq+rhKiz/izLdlHZXP36rvDEnjBSahDiZr8wj/DBRUvHOFR4HxlegdurVYXILA0WcIpOeDxFWePbiUsVbumjn3CRS3MbT3A8LMyVArpd4wpfFLmG+hlzywvM1pbKlsQ7aoPpwKCrjpyi+R20/BmMtcf3Cl2Ug+FkNp+sOAL4fyQMZkkk6sKX2Jp6aSDKRThFWE3VQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqifVEUX; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqifVEUX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbSM21hzPz2y2R
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 04:10:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D388F6020A;
	Thu,  3 Sep 2026 18:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959341F00A3E;
	Thu,  3 Sep 2026 18:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459035;
	bh=Ho2GaUYZW7F1ZlLG9J8DaiLoLiz6rBxcIfn/E06cPYE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WqifVEUXbBEdoG/zT3ZudI+igvwAFkWpilWX8KcnwECoA5i4PhmEK7KuMO07akxSW
	 0amsaldsZOQsdT+oGuOhsDHPGsu7CoWvS/KGn6fyJUOpqDxY+Opr8q0Bs1fBZ8/M3G
	 Yz7r7kxsGpzFTVgS6fseAkRXU5aZxLH2Slz+tNmJmIk79euNTanSVOwP3yZjSbFsbZ
	 Sq4MHg+eoVTSv5z1quv0bsLN2LckOPDQlXmSFUuu6mQOm5dNzfLe9NEydG60D76oyf
	 KZmpr9gxn1X95ZeqAxag3yLeWetnC2tfiDtV/QaD65K00qDhd5O7r0mVl4OMRT3JC8
	 rhbWM3oKkxGHg==
Subject: Re: [net-next,v6,05/15] ibmveth: Refactor RX interrupt control for MQ
 RX queues
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Thu, 03 Sep 2026 18:10:34 +0000
Message-ID: <178845903415.3394541.17814919508760286151@kernel.org>
In-Reply-To:
 <8f989bb564874f041ac9648d871c6ff3e3014bb9.1788102125.git.mmc@linux.ibm.com>
References:
 <8f989bb564874f041ac9648d871c6ff3e3014bb9.1788102125.git.mmc@linux.ibm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 3 · Low: 2

- [Medium] A user-triggerable rtnl hang fix is bundled into a 400-line
  refactor with an incorrect justification for omitting a Fixes: tag.
- [Medium] ibmveth_poll() re-arms the PHYP interrupt
  (ibmveth_enable_irq(), ibmveth.c:2123) only *after*…
- [Medium] Teardown frees Linux IRQ handlers (and, on the MQ paths,
  disposes subordinate virq mappings) without ensuring PHYP delivery was…
- [Low] Two permanent behavioural changes to ibmveth_close() are absent
  from the commit message: (a) ibmveth_update_rx_no_buffer() is moved…
- [Low] Claimed: ibmveth_schedule_rx_queue()'s kernel-doc documents an
  out-of-range index as an ordinary `return false`, while the body…

Pre-existing issues:
- [High] Claimed: on the ibmveth_alloc_buffer_pools() failure path,
  ibmveth_open() jumps to out_free_tx_ltb without h_free_logical_lan(),…

--

ibmveth: Refactor RX interrupt control for MQ RX queues

This patch introduces queue-indexed RX interrupt helpers (toggle/enable/
disable, setup/cleanup, schedule) and wires them into open(), close(),
poll(), the IRQ handler and the process-context RX kick sites. It also adds
two new adapter flags, opened and rx_irq_setup, that gate close/cleanup
work. Runtime behaviour stays single-queue.

A few questions below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 37a6d13e603ea..335712faaa42a 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -338,6 +340,320 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
>  	}
>  }
>  
> +/**
> + * ibmveth_toggle_irq - Common helper to enable/disable queue interrupts

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
> +	}
> +
> +	if (h_rc) {
> +		dev_err_ratelimited(&adapter->netdev->dev,
> +				    "Failed to %s IRQ for queue %d, rc=0x%lx\n",
> +				    action, queue_index, h_rc);
> +		return -EIO;
> +	}
> +	return 0;
> +}

[ ... ]

> +static int
> +ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
> +{

[ ... ]

> +	if (adapter->multi_queue && num > 1) {
> +		for (i = 0; i < num; i++) {
> +			rc = ibmveth_enable_irq(adapter, i);
> +			if (rc) {
> +				netdev_err(netdev,
> +					   "Failed to enable IRQ for queue %d, rc=%d\n",
> +					   i, rc);
> +				for (; i >= 0; i--) {
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
> +	/* STOP: remask after napi_disable; an in-flight poll can re-arm. */
> +	for (i = 0; i < num; i++)
> +		napi_disable(&adapter->napi[i]);
> +	for (i = 0; i < num; i++) {
> +		if (!adapter->queue_irq[i])
> +			continue;
> +		ibmveth_disable_irq(adapter, i);
> +		synchronize_irq(adapter->queue_irq[i]);
> +	}
> +	for (i = 0; i < num; i++) {
> +		if (adapter->queue_irq[i])
> +			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
> +	}
> +	goto err_dispose_mappings;

[ ... ]

> +static void
> +ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
> +{
> +	int i;
> +
> +	if (!adapter->rx_irq_setup)
> +		return;
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		if (!adapter->queue_irq[i])
> +			continue;
> +		ibmveth_disable_irq(adapter, i);
> +		synchronize_irq(adapter->queue_irq[i]);
> +	}
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++)
> +		napi_disable(&adapter->napi[i]);
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		if (!adapter->queue_irq[i])
> +			continue;
> +		ibmveth_disable_irq(adapter, i);
> +		synchronize_irq(adapter->queue_irq[i]);
> +	}
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		if (adapter->queue_irq[i])
> +			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
> +	}

[Severity: Medium]
The commit message says cleanup "remasks and synchronizes again after it
because an in-flight poll can re-arm". Does the second remask really close
that window?

ibmveth_poll() re-arms only after NAPI ownership has already been dropped:

	if (!napi_complete_done(napi, frames_processed))
		goto out;
	...
	rc = ibmveth_enable_irq(adapter, 0);

napi_disable() waits for NAPIF_STATE_SCHED / NAPIF_STATE_NPSVC to clear, not
for the poll function to return, so this interleaving looks possible:

CPU1 (softirq)                    CPU0 (ibmveth_close)
ibmveth_poll()
  napi_complete_done()
    /* SCHED cleared */
  <delayed>
                                  ibmveth_cleanup_rx_interrupts()
                                    disable_irq + synchronize_irq
                                    napi_disable()  /* returns at once */
                                    disable_irq + synchronize_irq
                                    free_irq()
  ibmveth_enable_irq(adapter, 0)

That leaves PHYP delivery unmasked on a queue with no handler installed
until h_free_logical_lan() runs. The synchronize_net() added in close()
runs after free_irq(), so it cannot cover this either, and the
err_disable_napi path above has the same shape.

The ordering is unchanged at the end of the series; the poll_stopping()
check added later is passed by CPU1 before CPU0 sets the teardown state.
Would arming the interrupt before napi_complete_done(), or gating the arm
on a teardown flag ordered with the mask, work better here?

[Severity: Medium]
Both ibmveth_disable_irq() calls in this function discard their return
value, and free_irq() below then runs unconditionally. In close(),
h_free_logical_lan() now runs after free_irq(), where the baseline freed
the LAN first and only then removed the handler.

If the mask hcall did not take effect, can PHYP deliver an interrupt in the
interval between free_irq() and h_free_logical_lan(), with no handler
installed? synchronize_irq() only drains a handler that is already running;
it does not stop the hypervisor source.

Related: ibmveth_toggle_irq() folds H_PARAMETER into success on the disable
path, while its own comment says H_PARAMETER may mean bad arguments rather
than "already in requested state", so teardown can treat a rejected mask as
a completed one. The MQ rollback loop in ibmveth_setup_rx_interrupts() has
the same unchecked-remask-then-free_irq pattern. I could not demonstrate
these hcalls failing in practice, so this one may be theoretical.

> +
> +	ibmveth_dispose_subordinate_irq_mappings(adapter);
> +
> +	/* Queue 0 uses netdev->irq; leave queue_irq[0] for next open. */
> +	adapter->rx_irq_setup = false;
> +}
> +
> +/**
> + * ibmveth_schedule_rx_queue - Mask PHYP IRQ and schedule NAPI for one RX queue
> + * @adapter: ibmveth adapter structure
> + * @qindex: RX queue index
> + *
> + * Shared by the IRQ handler and process-context kick sites (open, resume,
> + * pool sysfs, poll_controller).
> + *
> + * Return: true if napi_schedule_prep() succeeded and NAPI was scheduled.
> + * Mask is attempted in that case; a failed disable_irq() is logged by the
> + * helper and does not change the return (queue may still be unmasked).
> + * false if the index is out of range or prep failed (including NAPI
> + * already scheduled).
> + */
> +static bool ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
> +				      int qindex)
> +{
> +	struct napi_struct *napi = &adapter->napi[qindex];
> +
> +	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
> +		return false;

[Severity: Low]
This isn't a bug, but the kdoc and the body disagree. The kdoc describes an
out-of-range index as an ordinary return:

	 * false if the index is out of range or prep failed (including NAPI
	 * already scheduled).

while the body splats on it. ibmveth_interrupt() documents the opposite for
the same condition:

	/*
	 * Quiet on out-of-range: teardown can leave a residual IRQ after the
	 * live count drops. Do not WARN-storm; return IRQ_NONE until free_irq.
	 */

A later patch in the series changes this helper to WARN only on qindex < 0
and to return false quietly when qindex is past the live queue count. Could
that form be used from the start?

The napi pointer is also formed from qindex before the range check; it is
never dereferenced before the check, but computing it afterwards would read
more clearly.

> +
> +	/*
> +	 * Only mask PHYP when NAPI will run. Masking on prep failure can
> +	 * race a completing poll that already re-enabled the queue, leaving
> +	 * NAPI idle with the IRQ masked (TX works, RX stalls) until reload.
> +	 * Storm prevention on teardown remains in cleanup/disable paths.
> +	 */
> +	if (napi_schedule_prep(napi)) {
> +		/* Failure is already logged with the hcall rc by the helper. */
> +		ibmveth_disable_irq(adapter, qindex);
> +		__napi_schedule(napi);
> +		return true;
> +	}
> +	return false;
> +}
> +

[ ... ]

> @@ -1000,24 +1315,20 @@ static int ibmveth_open(struct net_device *netdev)
>  	if (rc)
>  		goto out_free_tx_ltb;
>  

[Severity: High]
This isn't a bug introduced by this patch, but the buffer-pool allocation
failure just above (ibmveth_alloc_buffer_pools() -> goto out_free_tx_ltb)
still skips h_free_logical_lan(), unlike the setup_rx_interrupts() failure
right below it.

The out_free_tx_ltb path continues into ibmveth_cleanup_rx_resources(),
which unmaps and frees the buffer list, the filter list and the RX ring
while the logical LAN registration is still live, so PHYP keeps DMA
addresses for freed pages.

Does the new opened gate in ibmveth_close() also remove the last site that
could have deregistered that residue? A later ndo_stop now returns 0
without calling h_free_logical_lan().

Two later patches in this series rework this ladder, first routing the pool
failure through a path that loops on h_free_logical_lan() and then moving
pool allocation ahead of registration, so the window does not survive the
series. Would it be worth ordering those ahead of this one so this commit
does not carry it?

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
>  
>  	netdev_dbg(netdev, "initial replenish cycle\n");
> -	ibmveth_interrupt(netdev->irq, netdev);
> +	ibmveth_schedule_rx_queue(adapter, 0);
>  
>  	netif_tx_start_all_queues(netdev);
>  
> +	adapter->opened = true;
>  	netdev_dbg(netdev, "open complete\n");
>  
>  	return 0;

[ ... ]

> @@ -1041,27 +1351,32 @@ static int ibmveth_close(struct net_device *netdev)
>  	long lpar_rc;
>  	int i;
>  
> -	netdev_dbg(netdev, "close starting\n");
> +	/* Gate on opened, not IFF_UP: pool_store/change_mtu close+open can
> +	 * leave IFF_UP set after a failed reopen.
> +	 */
> +	if (!adapter->opened)
> +		return 0;

[Severity: Medium]
The commit message says:

  "Opened / rx_irq_setup also closes a pre-existing hang: after a
   failed reopen, a later ndo_stop used to napi_disable and free_irq
   a second time (rtnl spin + already-free IRQ). That depends on the
   helpers in this patch, so there is no standalone Fixes: tag."

Is that dependency real? This gate reads only adapter->opened, and the
matching "adapter->opened = true" at the end of ibmveth_open() does not
reference ibmveth_toggle_irq(), ibmveth_setup_rx_interrupts() or
ibmveth_cleanup_rx_interrupts() either.

The hang itself is reachable in the baseline: ibmveth_open() calls
napi_enable() on entry and napi_disable() on its out: path, and
ibmveth_close() starts with napi_disable(). veth_pool_store(),
ibmveth_change_mtu(), ibmveth_set_csum_offload() and ibmveth_set_tso() call
ibmveth_close() then ibmveth_open() directly and do not clear IFF_UP when
the reopen fails, so a later "ip link set dev X down" enters
ibmveth_close() and the second napi_disable() spin-waits forever with rtnl
held.

Could the opened flag and this gate be split into their own patch with a
Fixes: tag, so the fix can be backported without the refactor?

>  
> -	napi_disable(&adapter->napi[0]);
> +	adapter->opened = false;
> +
> +	netdev_dbg(netdev, "close starting\n");
>  
>  	netif_tx_stop_all_queues(netdev);
>  
> -	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
> +	ibmveth_cleanup_rx_interrupts(adapter);
> +	/* Wait for softirq/poll that already passed shutdown checks. */
> +	synchronize_net();
>  
> +	ibmveth_update_rx_no_buffer(adapter);
> +	/* Full LAN teardown (subordinates arrive with register helpers). */
>  	do {
>  		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>  	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));

[Severity: Low]
Two permanent changes to ibmveth_close() are not described in the commit
message.

ibmveth_update_rx_no_buffer() moves from after h_free_logical_lan() and
free_irq() to before h_free_logical_lan(). It reads the absolute counter
that the hypervisor writes at the end of the buffer list page, and the
hypervisor still owns that page until h_free_logical_lan() returns, so the
final rx_no_buffer / rx_errors value can now miss drops recorded after the
read. Was the reordering intentional?

The new synchronize_net() in the ndo_stop path is mentioned only in the v5
changelog below the --- separator, which does not land in git history.
Could it be described in the commit message as well?

> -
>  	if (lpar_rc != H_SUCCESS) {
> -		netdev_err(netdev, "h_free_logical_lan failed with %lx, "
> -			   "continuing with close\n", lpar_rc);
> +		netdev_err(adapter->netdev,
> +			   "h_free_logical_lan failed with %lx, continuing\n",
> +			   lpar_rc);
>  	}
> -
> -	free_irq(netdev->irq, netdev);
> -
> -	ibmveth_update_rx_no_buffer(adapter);
> -
>  	ibmveth_free_buffer_pools(adapter);
>  	ibmveth_cleanup_rx_resources(adapter);
>  	ibmveth_free_filter_list(adapter);

[ ... ]

> @@ -1805,15 +2120,14 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788102125.git.mmc%40linux.ibm.com

