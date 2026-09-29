Return-Path: <linuxppc-dev+bounces-28518-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6955CA5FA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:33:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvSyV6LMNz30WT;
	Wed, 30 Sep 2026 05:33:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790710402;
	cv=none; b=CuorHGLj8PRrJoMrrnHSCHUQizOH008LbC06gyEncAcdLqrAL7OGWSxFWP1BmkznLtJHrUYP9vRWmnLlbEIfD5kUshOpf9Ulj1v4MW11KhLj6G/AB4hCKER64A7agvntJtatFVORDtI0b8siTf8tUhR4k/HSUBIZbKLtGxJkRe9BYmDjKPOBMl81NGvip4+JnlViMJzWnBRyNObH4Ph7L9L8kZy1ZtoCmfrD/Wn5uRWZxvrqvwAbKEusoRqAY4W1/RZ0A6qCgCv7iHqzvq+rsNdz1aX0GNaYQSaKJLPPjG+vQVtzLTx4JhQCB+MT20IapFzBRruWoCH1qXy1E7VWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790710402; c=relaxed/relaxed;
	bh=ua0bJeR826HVq0hbeIX+dlawvAn6N3WCRQR3RrlZ1Yo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c7287FsHPxLEpzJwnAw6RSF4cSZ9IlKJfxVraKK5wBenvVF5bQk0+SlI3XBJOLVM/KEKzvqqdk/2wS9xQQLvLwKoeBtjO+XjNAhY3bzREO4FLHl/QerhgCMGC1hdjc3/eRKqBtJIBnXtgFYZV7p4OLa2CQkP97m2sLUhCGpd5MhdwR47ucIm3SxreDyR44LKbNGsyGYyIiqjkznrBzI7s/i+qb5CZ+C+M+Tad7tWdJcCalQLXA6evQm1g+mm7FU9i+dc29x/1V8HG31BOpxESmb6cgs9nkSOjDq6Bsm81sa/Rx6Xcqk32dE0JsPekZpDG3n4P3Yrj8NFP6vF43OCGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rx/58iKA; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rx/58iKA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvSyT0cRwz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:33:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C0C4F6022F;
	Tue, 29 Sep 2026 19:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9633A1F00893;
	Tue, 29 Sep 2026 19:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710398;
	bh=ua0bJeR826HVq0hbeIX+dlawvAn6N3WCRQR3RrlZ1Yo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rx/58iKAyp0v7fTzRx/MZekcRZhn0V0UfyaTDdhtUWBTPPDWJK+2fpEqSdr9I76q0
	 AmHuYYiX/QGyo4DwI2r1SSWPjezurdOyIYSLmnbwhA0nmru51ZIEcen722mhGIn/6i
	 I3FjMnybZeakpVs7hdBWSx3CkPxQoIE58nEdahT86WrYRmiV39djsDGY2MeuP+5V93
	 JrNq9h/sYaHr7PxKpuCovIgsM6jXoGkSdKZ9rnZfJ1rUjIhMQd/yoS2rbHBa/9Y+Rv
	 /AdZsTXst7bdC8+iiZ0w8NzQ0hPZkhnDoIZmk5NEX9qHL4fufwXkoI86qvohl9wQrs
	 aBW0PVcFWnJUQ==
Subject: Re: [PATCH net-next v7 05/15] ibmveth: Refactor RX interrupt control
 for MQ RX queues
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Tue, 29 Sep 2026 19:33:17 +0000
Message-ID: <179071039720.434549.10036820786978386071@kernel.org>
In-Reply-To:
 <64b15e2b18808049772a187955af3affd8546c89.1790319558.git.mmc@linux.ibm.com>
References:
 <64b15e2b18808049772a187955af3affd8546c89.1790319558.git.mmc@linux.ibm.com>
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
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch fixes a hang that already exists in mainline, but
  the commit message's reason for leaving out Fixes:/Cc: stable is wrong.
- [Medium] ibmveth_cleanup_rx_interrupts() masks PHYP and calls
  synchronize_irq() (lines 593-598), calls napi_disable() (600-601),…
- [Medium] After a failed internal reopen, ibmveth_set_channels() (gated
  on IFF_UP) can allocate TX LTBs that the now-gated ibmveth_close()…
- [Low] ibmveth_close() now calls ibmveth_update_rx_no_buffer() (line
  1375) before h_free_logical_lan() (lines 1377-1379).
- [Low] The commit message argues for this commit's safety using code
  that does not exist at this commit.

Pre-existing issues:
- [High] If ibmveth_alloc_buffer_pools() fails after a successful
  ibmveth_register_logical_lan(), ibmveth_open() jumps to…
- [High] ibmveth_remove() calls cancel_work_sync(&adapter->work) before
  unregister_netdev().

--

ibmveth: Refactor RX interrupt control for MQ RX queues

This commit adds queue-indexed RX interrupt helpers to ibmveth and wires
them into open, close, poll, the IRQ handler and the process-context RX
kick sites. It also adds opened and rx_irq_setup flags so that a close
after a failed reopen doesn't repeat napi_disable() and free_irq().
Runtime stays single queue.

> Opened / rx_irq_setup also closes a pre-existing hang: after a
> failed reopen, a later ndo_stop used to napi_disable and free_irq
> a second time (rtnl spin + already-free IRQ). That depends on the
> helpers in this patch, so there is no standalone Fixes: tag.

[Severity: Medium]
Is the "depends on the helpers" part accurate? The hang fix appears to
be only the opened flag:

ibmveth_close()
	if (!adapter->opened)
		return 0;

ibmveth_open()
	adapter->opened = true;   /* success path only */

Neither of these uses the new IRQ helpers, and the same bool would
apply to the parent tree unchanged.

In the parent tree, every ibmveth_open() failure ends at the out: label
with napi_disable(), and ibmveth_close() also starts with napi_disable().
ibmveth_change_mtu(), ibmveth_set_csum_offload(), ibmveth_set_tso() and
veth_pool_store() call ibmveth_close()/ibmveth_open() directly. When the
reopen fails, IFF_UP stays set.

The next ndo_stop (ifdown, or unregister_netdev() from ibmveth_remove())
then calls napi_disable() on a NAPI that is already disabled. It spins
under RTNL, and would then free_irq() an IRQ that was already freed.

Could the opened gate go into a small standalone patch ahead of the
series, with something like:

Fixes: 88426f2acae0 ("ibmveth: Cleanup error handling inside ibmveth_open")
Cc: stable@vger.kernel.org

so stable kernels get the hang fix?

> cleanup_rx_interrupts() masks PHYP and synchronizes IRQs before
> napi_disable, remasks and synchronizes again after it. The second
> remask only catches a re-arm that lands before it; napi_disable
> does not wait for poll to return, so enable_irq can still run
> after free_irq. Close then proceeds to
> h_free_logical_lan(): free_irq before free_lan is intentional once
> PHYP delivery is masked.

[ ... ]

> On setup_rx enable-fail (MQ path), if enable_irq() fails for queue i,
> remask+sync queues 0..i, including the one that failed, before
> napi_disable/free_irq; the rollback loop used while (--i) and skipped
> it.

[ ... ]

> stalled until reload). Teardown storm control stays on STOP
> (disable_irq + synchronize_irq before napi_disable) and the
> poll_stopping() re-arm guard added in P09, not on the schedule helper
> failure path.

[Severity: Low]
These parts of the message describe code that isn't in this commit.

There is no poll_stopping() helper yet. At this commit, ibmveth_poll()
calls ibmveth_enable_irq(adapter, 0) unconditionally after
napi_complete_done(). The guard only arrives with the later "ibmveth:
Harden RX poll path with helpers".

The first paragraph says enable_irq can still run after free_irq. It
then says free_irq before free_lan is intentional once PHYP delivery is
masked. At this commit, don't those two statements contradict each
other?

The while (--i) rollback loop isn't in the parent tree. It looks like
it came from an earlier revision of this patch.

The MQ enable-fail rollback also can't run at this commit. Probe sets
multi_queue = 0 and num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES, and
IBMVETH_MAX_RX_QUEUES is 1U.

Series-relative labels such as P09 also lose their meaning once the
patch is applied.

Could the version history and series-relative notes move below the ---
line or into the cover letter? The body could then state plainly that
the re-arm window after free_irq stays open until "ibmveth: Harden RX
poll path with helpers".

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 5813352943fb1..a22a17e05ae1c 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -339,6 +341,320 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)

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
Is the second mask here actually ordered after the tail of an in-flight
ibmveth_poll()?

napi_disable() returns as soon as it can claim NAPI_STATE_SCHED. That
happens right after the poll's napi_complete_done(), not when the poll
returns. The poll then continues:

ibmveth_poll()
	if (!napi_complete_done(napi, frames_processed))
		goto out;
	...
	rc = ibmveth_enable_irq(adapter, 0);  /* H_VIO_SIGNAL enable */
	...
	napi_schedule(napi)                   /* fails, DISABLE is set */

At this commit there is no teardown check in that path. The re-arm can
land after the second ibmveth_disable_irq() above and after free_irq().
Queue 0 would then stay unmasked in PHYP with no Linux handler until
h_free_logical_lan().

The only wait for the poll tail is the synchronize_net() in
ibmveth_close(), and it runs after free_irq(). The parent tree called
h_free_logical_lan() before free_irq(), so it never had a window with
PHYP live and no handler installed.

The kernel-doc ("Remask after napi_disable() in case an in-flight poll
re-armed PHYP ... free_irq() runs only after that") assumes this
ordering. The err_disable_napi rollback in
ibmveth_setup_rx_interrupts() uses the same pattern.

Later in the series, "ibmveth: Harden RX poll path with helpers" adds an
ibmveth_poll_stopping() check after napi_complete_done(). That covers
dev_close(), where netif_running() is already false.

It doesn't cover the direct ibmveth_close() callers
(ibmveth_change_mtu(), veth_pool_store(), ibmveth_set_csum_offload(),
ibmveth_set_tso()), where netif_running() is still true.

Would it close the window to wait for the poll tail (for example with
synchronize_net()) before the second mask and synchronize_irq(), and
only then call free_irq()?

[ ... ]

> @@ -1005,24 +1320,20 @@ static int ibmveth_open(struct net_device *netdev)
>  	if (rc)
>  		goto out_free_tx_ltb;
>  

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. This
is the ibmveth_alloc_buffer_pools() failure path, which runs after a
successful ibmveth_register_logical_lan(). Does it leave the logical
LAN registered with PHYP?

out_free_tx_ltb never calls h_free_logical_lan():

out_free_tx_ltb:
	while (--i >= 0)
		ibmveth_free_tx_ltb(adapter, i);
	ibmveth_cleanup_rx_resources(adapter);

So the buffer list, RX queue and filter list are unmapped and freed
while PHYP may still hold the registration.

With the new opened gate, no later ndo_stop reaches h_free_logical_lan()
either. In the parent tree, the later close hung in the second
napi_disable() before getting that far.

This looks fixed later in the series by "ibmveth: Add RX queue register
helpers for MQ", which moves ibmveth_alloc_buffer_pools() ahead of
ibmveth_register_rx_queues().

[ ... ]

> @@ -1046,27 +1356,32 @@ static int ibmveth_close(struct net_device *netdev)
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
Can this early return leak TX LTBs allocated by ibmveth_set_channels()?

After a failed internal reopen, IFF_UP stays set but opened is false.
ibmveth_set_channels() only checks IFF_UP:

ibmveth_set_channels() {
	if (!(netdev->flags & IFF_UP))
		return netif_set_real_num_tx_queues(netdev, goal);
	...
	for (i = old; i < goal; i++) {
		if (adapter->tx_ltb_ptr[i])
			continue;

		rc = ibmveth_allocate_tx_ltb(adapter, i);
	...
}

So ethtool -L in that state allocates new LTBs. ibmveth_close() then
returns here and skips the ibmveth_free_tx_ltb() loop. The next
ibmveth_open() overwrites tx_ltb_ptr[]/tx_ltb_dma[], which leaks the
buffer and its DMA mapping.

Before this patch the same sequence hung in the second napi_disable(),
so the gate trades the hang for a leak.

Later in the series this goes away: ibmveth_set_channels() checks
!adapter->opened and then only calls netif_set_real_num_tx_queues(),
without allocating LTBs. Could that check go into this patch alongside
the gate?

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

[Severity: Low]
Does moving ibmveth_update_rx_no_buffer() ahead of h_free_logical_lan()
drop counts from rx_no_buffer?

While the logical LAN is still registered, PHYP keeps consuming posted
buffers. Once they run out, it keeps incrementing the no-buffer counter
in the last 8 bytes of buffer_list_addr[0]. NAPI is already disabled at
this point, so nothing replenishes the buffers.

Any increments between this read and H_FREE_LOGICAL_LAN never reach
adapter->rx_no_buffer, which is the value kept across close.

The commit message says "Close harvests the PHYP no-buffer count before
h_free so the read still hits a live buffer-list page". In either
order, though, buffer_list_addr[0] is only unmapped and freed later, in
ibmveth_cleanup_rx_resources().

Wouldn't reading after h_free_logical_lan(), as the old code did, be
just as safe and give the final value?

The same order is still there at the end of the series: the final
ibmveth_close() reads the counter under replenish_lock and then calls
ibmveth_free_all_queues().

[ ... ]

> @@ -1810,15 +2125,14 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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

[Severity: High]
This isn't a bug introduced by this patch, but can this schedule_work()
race with ibmveth_remove()?

ibmveth_remove() {
	...
	cancel_work_sync(&adapter->work);
	...
	unregister_netdev(netdev);

	free_netdev(netdev);
	...
}

NAPI poll stays live until unregister_netdev() closes the device. If
ibmveth_enable_irq() fails in that window, adapter->work can be queued
again after cancel_work_sync(). free_netdev() then frees the embedded
work_struct while it may still be queued.

The parent tree has the same order. "ibmveth: Enable multi-queue RX
receive path" later reorders ibmveth_remove() so that unregister_netdev()
runs before cancel_work_sync().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790319558.git.mmc%40linux.ibm.com

