Return-Path: <linuxppc-dev+bounces-28525-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB1FCA5FAD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:34:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvSyh59yvz3blB;
	Wed, 30 Sep 2026 05:33:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790710412;
	cv=none; b=YUA8hwzuZxtiohUlUK9Qs4I1p50VaziiGkpbupZC655GLnwoqDZjuagkNoAB/AatGy3JEaBWry92pa0/o9USBwHFjEStlRZOQU5ksvCWXJ4BnbFn1ONKhsgiale5yyeJvwd0QhdbeJbE4uyW6SrLoFaO84MJIIU5aPzhcKHHM7qPsx94sjmRsIpnjgD3ytynljlUtj9RXt1XHmZQ3nT2ir8LNBZh7PyylZI3G29FAH4QvJ66w5ceVh1XOynaMAkfHLK0T6Ix8UpIlby38/5bgTr64wk+ezZGFm+6XNosNEdkag3j1HNFIREkbjvVhYWSKzvzq0r5V2PmZALqzshANg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790710412; c=relaxed/relaxed;
	bh=JcGP5PqyF3su430kMKIr7qo6gmZhlV7ZBz99vO56IJY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZ9TMAKhoxsKeIWTGVYmfeTH9ZKIaph6A0MBtNT4oW1d3EtcHjRLpLsD+dGxS9CDIT4Y+J4Cim6N7E5YyaYHvcqjCOqKrNyUlGXt2hMKgInb/icL4Qr/vA95eM4YYXZePA46DsQOoM1jEDIgdKIS/HSlKvooVrZfvR8rVoplkAvZ6X4/m0QNTTxLxCjbMBCLaNT8g6l+RJFMHCimz7Utes0SeN+AL6SLLKoqsSmJ9vsL6C6ErHv9Ch5iRlDM5ORINS8pWhiucKSsnBM9SPq/GNwjnRyFd+WrpJ/XHnhq1JXHSPyuzGdbgA664IvJ1jORuU8iBn7SP5FYoUmBE5TKWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMepHFsG; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMepHFsG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvSyd2KY3z3bf3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:33:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D11646022B;
	Tue, 29 Sep 2026 19:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A290D1F00893;
	Tue, 29 Sep 2026 19:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710408;
	bh=JcGP5PqyF3su430kMKIr7qo6gmZhlV7ZBz99vO56IJY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CMepHFsGKP84yI7nZy6HBBh7IYqgzxETmLYADCHeYxVA2J/O2WwBicCqBc4lG+245
	 OLswZ6CjrPRxDYm9uPUZhoK0SmjoQxrRtxblRbNW3jlBecq8wtK2OuCZCot9yoglmP
	 OE0DJrOpSo4f937z3a1PHA9F2KUHi/SjH2xBK6FH25zbp3NqAi4NB/5ywrLet5LUJg
	 06tnbnAJPLR3dFC1zHg8y7lN1h5MhCjXGRhJ22zQb0WBfi22zyiRN3ZKabeaEHyUJR
	 Jo+ypPmyKsMlj2AgVh8I6ZI44t6bS2EjrA7DFY6hXnXbfLZvUtTXIJDZMPHBEuOf5y
	 A4NgrmgaDrIvA==
Subject: Re: [PATCH net-next v7 14/15] ibmveth: Implement incremental MQ RX
 queue resize
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Tue, 29 Sep 2026 19:33:27 +0000
Message-ID: <179071040721.434549.16670777556064239489@kernel.org>
In-Reply-To:
 <cecd8fef057ec0d42eff6fc023c36c0702921b6b.1790319558.git.mmc@linux.ibm.com>
References:
 <cecd8fef057ec0d42eff6fc023c36c0702921b6b.1790319558.git.mmc@linux.ibm.com>
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

Critical: 0 · High: 0 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Resolved later in this series; not a finding at the end of the
  series.
- [Medium] Two rollback paths bring queues back into service even when
  widening real_num_rx_queues back up fails.
- [Medium] Four new resize paths call ibmveth_enable_irq(adapter, i) to
  unmask the subordinate queue with H_VIOCTL H_ENABLE_VIO_INTERRUPT,…
- [Low] Three comments added or edited by this patch do not match the
  code.
- [Low] A subordinate RX queue stranded above the live count can leak.

--

ibmveth: Implement incremental MQ RX queue resize

This patch adds ibmveth_resize_rx_queues_incremental() and
ibmveth_resize_rx_channels(), so ethtool -L can change the live RX queue
count without tearing down the device. Scale-up allocates, registers and
unmasks the new subordinate queues. Scale-down quiesces, drains and
deregisters the retiring ones, and both directions roll back on failure.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 0ac0359bb71e6..1b1dd89dadf79 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -785,15 +837,25 @@ ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)

[ ... ]

>  static bool ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
>  				      int qindex)
>  {
>  	struct napi_struct *napi = &adapter->napi[qindex];
>  
> -	if (WARN_ON(qindex < 0 || qindex >= ibmveth_get_num_rx_queues(adapter)))
> +	if (WARN_ON(qindex < 0))
> +		return false;
> +
> +	/*
> +	 * A live shrink can publish a lower count while netpoll walks a
> +	 * snapshot of the old one, so an index past the end is expected
> +	 * here and must not splat. ibmveth_replenish_task() skips the
> +	 * same way; callers already treat false as "queue is gone".
> +	 */
> +	if (qindex >= ibmveth_get_num_rx_queues(adapter))
>  		return false;

[ ... ]

> @@ -1261,8 +1323,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>   * SQ open leaves PHYP masked until the first poll. If schedule_prep fails,
>   * NAPI never runs and the queue stays masked (TX OK, RX/ARP dead) until
>   * reload. Replenish first so an enable_irq fallback can actually deliver.
> - * Also used after every open (SQ and MQ) and after scale-down so a
> - * queue is not left idle+masked.
> + * Also used after every open (SQ and MQ) and after scale-down rollback.
>   */
>  static void ibmveth_restart_rx_queue(struct ibmveth_adapter *adapter,
>  				     int qindex)

[Severity: Low]

This isn't a bug, but three of the new comments don't match the code.

The updated ibmveth_restart_rx_queue() comment lists open and scale-down
rollback as its callers. ibmveth_scale_up_rx_queues() also calls it in
three places: after each successful queue bring-up, on the keep path after
a failed destroy, and on the cleanup_new_queues keep path.

The new ibmveth_schedule_rx_queue() comment says callers treat false as
"queue is gone". ibmveth_restart_rx_queue() does the opposite on false:

	if (ibmveth_schedule_rx_queue(adapter, qindex))
		return;

	ibmveth_enable_irq(adapter, qindex);

A caller that follows the comment would unmask PHYP on a retired queue.

The ibmveth_cleanup_single_rx_interrupt() kdoc says "Used during
incremental scale-down". It also runs on the scale-up failure paths via
ibmveth_destroy_subordinate_rx_queue().

Could these comments be updated?

[ ... ]

> +static int
> +ibmveth_scale_up_rx_queues(struct ibmveth_adapter *adapter, int old_count,
> +			   int new_count, int rxq_entries)
> +{

[ ... ]

> +	for (i = old_count; i < new_count; i++) {
> +		if (adapter->queue_handle[i]) {
> +			/* Left by a failed H_FREE; close frees it. */
> +			netdev_err(netdev,
> +				   "RX queue %d still held by PHYP, reset pending\n",
> +				   i);
> +			rc = -EBUSY;
> +			goto cleanup_new_queues;
> +		}
> +		rc = ibmveth_alloc_single_rx_queue(adapter, i,
> +						   rxq_entries);
> +		if (rc) {
> +			netdev_err(netdev, "Failed to allocate queue %d: %d\n",
> +				   i, rc);
> +			goto cleanup_new_queues;
> +		}
> +
> +		rc = ibmveth_register_single_rx_queue(adapter, i);
> +		if (rc) {
> +			netdev_err(netdev, "Failed to register queue %d: %d\n",
> +				   i, rc);
> +			if (rc == -EOPNOTSUPP)
> +				adapter->mq_fallback = true;
> +			if (!ibmveth_deregister_single_rx_queue(adapter,
> +								i))
> +				ibmveth_free_single_rx_queue(adapter,
> +							     i);
> +			else
> +				schedule_work(&adapter->work);
> +			goto cleanup_new_queues;
> +		}

[Severity: Low]

If ibmveth_deregister_single_rx_queue() fails here, queue i keeps its
buffer list page, the dma_map_single() of that page, the
dma_alloc_coherent() RX ring and its pool arrays. queue_handle[i] also
stays set above the live count. The IRQ setup failure branch below does
the same.

Only ibmveth_free_stranded_rx_queues() frees such a queue, and it runs
only from ibmveth_close() when H_FREE_LOGICAL_LAN succeeds:

	if (!ibmveth_free_all_queues(adapter))
		ibmveth_free_stranded_rx_queues(adapter);

If H_FREE_LOGICAL_LAN fails in close, does this leak the stranded queue's
page, RX ring and DMA mapping? The out_free_all_queues unwind in
ibmveth_open() and ibmveth_remove() also don't seem to release queues
above the live count.

After a failed close, queue_handle[i] also stays set. Every later scale-up
that reaches index i then returns -EBUSY with the "reset pending" message,
but that path doesn't schedule a reset.

In the same failed-close case, the live queues' memory is freed anyway.
Keeping only the stranded queue's memory looks inconsistent.

[ ... ]

> +		ibmveth_publish_num_rx_queues(adapter, i + 1);
> +		ibmveth_replenish_task(adapter, i);
> +		napi_enable(&adapter->napi[i]);
> +
> +		rc = ibmveth_enable_irq(adapter, i);
> +		if (rc) {

[ ... ]

> +		if (rc) {
> +			/* enable_irq errno; keep -EIO. */
> +			rc = -EIO;
> +			goto cleanup_new_queues;
> +		}
> +		ibmveth_restart_rx_queue(adapter, i);
> +	}

[Severity: Medium]

Can this unmask PHYP behind a live poll?

Once ibmveth_enable_irq() unmasks queue i, an interrupt on another CPU can
run ibmveth_interrupt(), win napi_schedule_prep(), mask PHYP and schedule
NAPI. ibmveth_restart_rx_queue() then sees its own prep fail and falls
back to:

	ibmveth_enable_irq(adapter, qindex);

That unmasks PHYP while the poll owns the queue. When the poll completes,
it calls ibmveth_enable_irq() again on a source that is already enabled.
ibmveth_toggle_irq() folds H_PARAMETER to success only on disable:

	if (h_rc == H_PARAMETER && !enable) {

So on enable it returns -EIO, and ibmveth_poll() schedules a reset.

The v6 changelog gives this case as the reason the survivor restart loop
was dropped: "enable_irq() on prep-fail unmasks behind a live poll
(subordinate H_PARAMETER on enable is -EIO and reset)".

The same enable-then-restart sequence appears in four places:

- here
- the keep branch after a failed destroy
- the cleanup_new_queues keep loop
- both rollback loops in ibmveth_scale_down_rx_queues()

On a busy link, would an ethtool -L that otherwise succeeded end in an
adapter reset?

[ ... ]

> +	/* Drop the live count before freeing the half-added queues. */
> +	ibmveth_publish_num_rx_queues(adapter, old_count);
> +	if (netif_set_real_num_rx_queues(netdev, old_count))
> +		schedule_work(&adapter->work);
> +	synchronize_net();
> +
> +	for (i = failed_queue - 1; i >= old_count; i--) {
> +		int keep;
> +
> +		if (!ibmveth_destroy_subordinate_rx_queue(adapter, i))
> +			continue;
> +
> +		keep = i + 1;
> +		ibmveth_publish_num_rx_queues(adapter, keep);
> +		if (netif_set_real_num_rx_queues(netdev, keep))
> +			schedule_work(&adapter->work);
> +		for (i = old_count; i < keep; i++) {
> +			int irq_rc;
> +
> +			ibmveth_replenish_task(adapter, i);
> +			/* START: NAPI before PHYP unmask. */
> +			napi_enable(&adapter->napi[i]);
> +			irq_rc = ibmveth_enable_irq(adapter, i);

[Severity: Medium]

At this point real_num_rx_queues has already been lowered to old_count,
and keep is above old_count. Growing the count goes through
net_rx_queue_update_kobjects(), which can fail (for example with -ENOMEM).
netif_set_real_num_rx_queues() then leaves dev->real_num_rx_queues
unchanged.

If that happens, is it safe to still replenish, napi_enable() and unmask
queues old_count..keep-1? Packets on those queues would carry
skb_record_rx_queue() indexes at or above real_num_rx_queues. That hits
the WARN_ONCE in get_rps_cpu() and the bypass in netif_get_rxqueue(),
which is what widening real_num up front in this function is meant to
avoid.

The destroy failure path in ibmveth_scale_down_rx_queues() has the same
pattern, after real_num has been lowered to new_count:

		if (netif_set_real_num_rx_queues(netdev, keep))
			schedule_work(&adapter->work);
		for (i = new_count; i < keep; i++) {

[ ... ]

> @@ -2567,18 +3486,15 @@ static int ibmveth_set_channels(struct net_device *netdev,
>  		     goal = channels->tx_count;
>  	int rc, i;
>  
> -	/*
> -	 * RX channel resize is implemented in a later patch; reject any
> -	 * request that changes rx_count. Read-modify-write TX adjustments
> -	 * submit the current rx_count and proceed.
> +	/* Validate RX (and resize when opened) before the down-path
> +	 * early return so MQ/range errors are reported here. Publishing
> +	 * the desired RX count and CMO while down is the next patch.
>  	 */
> -	if (channels->rx_count != ibmveth_get_num_rx_queues(adapter))
> -		return -EOPNOTSUPP;
> +	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
> +	if (rc)
> +		return rc;

[Severity: Medium]

The RX resize is committed here, before any TX work. If a TX LTB
allocation later fails in ibmveth_set_channels(), the code does:

		goal = old;
		old = i;
		break;
	}
	rc = netif_set_real_num_tx_queues(netdev, goal);

This overwrites the allocation error with the result of reverting to the
old TX count, which is normally 0.

For a combined ethtool -L rx N tx M on an opened MQ adapter, would this
change RX, leave TX unchanged and still report success? Nothing at this
commit rolls RX back.

The last patch in the series, "ibmveth: Complete set_channels down-path
and mq_fallback max_rx cap", adds rx_changed tracking, a rollback through
ibmveth_resize_rx_queues_incremental(adapter, old_rx, ...), and a return
of rc ? rc : -ENOMEM when real_num_tx_queues doesn't match the request.
That fixes it by the end of the series, but the behavior above is still
present at this commit.

> -	/* If ndo_open has not been called yet then don't allocate, just set
> -	 * desired netdev_queue's and return
> -	 */
> -	if (!(netdev->flags & IFF_UP))
> +	if (!adapter->opened)
>  		return netif_set_real_num_tx_queues(netdev, goal);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790319558.git.mmc%40linux.ibm.com

