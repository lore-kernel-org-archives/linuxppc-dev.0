Return-Path: <linuxppc-dev+bounces-26509-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49744C624D6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 23:40:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbbg21frvz2yv6;
	Fri, 04 Sep 2026 09:39:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788459045;
	cv=none; b=PbUIXnnbP0Jo0cmWIVc5pVMsw/HgK5v90liUyXeX62iVVMdMxOcmSw0SADbyRvzjbp3kTgrmNvgjLUdTPHwflEeb7rM1424/w2333gEp957aIgjnqMcsehZiFoOiXgk2MjRxt2hCWRdbQc65Zsqb+sscPiJFSVEpV75hXAAn0u2mBZterWFNZktUjmTAZUzqbEMmROuFrOKlc7bocOP9q4Kfz4GdeKVPZqvrD9/VwTsgVooGwVYfqn4gojgfgPe1IgKZk6V/U52h+O0xfxr5crq5UfxbmgpkHZVTO6eE399ZJ69OAGnPIj8vFoHT27N0Z4oTil//WkenaM8G+z0jEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788459045; c=relaxed/relaxed;
	bh=YHo548pd5tlX3x6ri13gtc7G23N7Zizy7+JtykOv9/8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UJH68VrAys9Vm82cSSIY5a99Tmn5LW5qT66DfJrMooalP7Cw2EBJFW0+hSKvdUsKPmyPjvT93EXNU6v3+egX33NpjsT5zhVCYT2aKYLW0iUb8ApywsaN5y06FssagZFC81eC4PIdTliMUKS9cKRpgrIKSsEqgxH2MejaIZZ9XMG1/PTq0dgn33eX8pTkCWsl78lyjH8l8eNf2pYkVFxsS++VjHfg4YtW5lrSSPwXguFkH+D5ZtUVPtosYAAqM4cTX5FxReBQOxgJPmWnuY1RBvwm5T6HukF45drPHqUal7HkEafVIztOz4mZshaIYr/Jzlrznuw/PrX0jhEhO9Zt1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HUU+riSq; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HUU+riSq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbSM80Lmbz2y2R
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 04:10:44 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D62B0402DF;
	Thu,  3 Sep 2026 18:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59C31F000E9;
	Thu,  3 Sep 2026 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459041;
	bh=YHo548pd5tlX3x6ri13gtc7G23N7Zizy7+JtykOv9/8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HUU+riSqV441QUIHOv2GzVe1wZda7XaKg9zOZjj8Cc5ubBQ9vzKTc8r6no22AyXyJ
	 OA/CJsNusn8u51JpebX72KA513p8Bzmxhs3pvfStF+BVkvGCB8jR3gjvS1/CWiLeah
	 gzaiKxg9ZhzMgwREmKnKWvWp01XMNN35HpBkelhwWmYw52hMnIOgfE8K1PnvAzCQc0
	 pxjeIMYnbPVV0uANhnIsmgMBubcnr6YZldwl/wYpBf04qbMjgziiAIX5xaXTnu+i03
	 sj5DCqNFXNyMEzr1EMU7pP+HWFxIdEvt0bOXAUNZ1WCfRgIWR8UT170HXSq2uuQZ97
	 m5n0k6VPyWRew==
Subject: Re: [net-next,v6,10/15] ibmveth: Enable multi-queue RX receive path
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Thu, 03 Sep 2026 18:10:40 +0000
Message-ID: <178845904035.3394541.12032685320275695105@kernel.org>
In-Reply-To:
 <7b633af89ff450338246520b40737c5819319234.1788102125.git.mmc@linux.ibm.com>
References:
 <7b633af89ff450338246520b40737c5819319234.1788102125.git.mmc@linux.ibm.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider:

Critical: 0 · High: 1 (2) · Medium: 4 · Low: 6

- [High] In multi-queue mode ibmveth_setup_rx_interrupts() already
  unmasks the PHYP interrupt for every live RX queue, and ibmveth_open()…
- [Medium] Adapter-wide RX counters are not converted to per-queue
  storage while this commit enables up to min(nr_cpus,8) live RX queues:…
- [Medium] ibmveth_apply_mq_fallback() publishes adapter->num_rx_queues =
  1 at the top of ibmveth_open() but deliberately leaves…
- [Medium] ibmveth_open() now runs ibmveth_replenish_task() for every
  queue, and that function can queue reset work…
- [Medium] The new probe error paths call kobject_put() on the pool
  kobjects, which are embedded in struct ibmveth_adapter inside…
- [Low] ibmveth_get_channels() begins advertising max_rx/rx_count > 1 (up
  to min(num_online_cpus(), IBMVETH_DEFAULT_QUEUES)) while its peer…
- [Low] Probe enables min(num_online_cpus(), IBMVETH_DEFAULT_QUEUES) RX
  queues whenever the firmware MQ bit is present; each queue clones…
- [Low] The commit message itself states that this commit ships known-
  wrong statistics and new schedule_work() producers whose remove-path…
- [Low] The pool sysfs kobject creation loop in ibmveth_probe() changes
  from 'ignore kobject_init_and_add() failure and continue probing' to…
- [Low] The ibmveth_setup_rx_interrupts() kernel-doc still describes the
  pre-MQ open sequence: "Single-queue open leaves PHYP masked here and…
- [Low] ibmveth_register_single_rx_queue() logs a signed `long lpar_rc`
  with the unsigned conversion "rc=0x%lx".

Pre-existing issues:
- [High] This commit makes the MQ reset producer live
  (adapter->multi_queue was hardcoded 0 before) and adds a new…
- [High] ibmveth_poll_controller() now replenishes and schedules every
  published RX queue instead of only queue 0, multiplying the exposure…

--

ibmveth: Enable multi-queue RX receive path

This turns on the multi-queue RX path when firmware advertises
IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT, raises IBMVETH_MAX_RX_QUEUES from 1
to 16, and wires subordinate queue registration, IRQ setup and per-queue
replenish into open()/close().  Probe now selects min(num_online_cpus(),
IBMVETH_DEFAULT_QUEUES) RX queues and refreshes the VIO CMO entitlement.

A few questions on the commit message first.

[Severity: Low]
The changelog says:

    Two things are knowingly left for patch 11. RX counters are racy:
    adapter->rx_no_buffer is assigned rather than summed from one queue's
    buffer-list page, so it reports whichever queue replenished last and
    can go backwards, while rx_packets, rx_bytes, rx_invalid_buffer and
    rx_large_packets are plain read-modify-writes now reached from several
    NAPI instances at once, so they can lose counts

and:

    This commit also adds schedule_work() producers, and the remove-path
    unregister / cancel_work_sync reorder and reset reg_state gate that
    make them safe land there too.

Would it be preferable to reorder so the counter conversion and the
remove-path fix precede the commit that makes the MQ path live, rather
than shipping an intermediate commit that is documented as incorrect in
those two respects?

The same paragraph documents a third, unrelated change:

    On probe failure after pool kobjects were created, put them before
    free_netdev(). The leak is pre-existing and unrelated to multi-queue,
    so a standalone version also goes to net; the probe_cleanup helper
    lands in patch 11.

Since this is described as unrelated and is being posted separately, could
it be dropped from this patch instead of open-coded on four error paths
here and then replaced by a helper later in the series?

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index f726d1e3f0b11..2e8896ea5af2e 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -992,11 +1014,21 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
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
>  
> -	adapter->rx_no_buffer = be64_to_cpup(p);
> +	if (queue_index < 0 ||
> +	    queue_index >= ibmveth_get_num_rx_queues(adapter) ||
> +	    !adapter->buffer_list_addr[queue_index])
> +		return;
> +
> +	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
> +	drops = be64_to_cpup(p);
> +
> +	adapter->rx_no_buffer = drops;
>  }

[Severity: Medium]
ibmveth_update_rx_no_buffer() now takes a queue index but still ends in a
plain assignment to the single adapter-wide field:

	adapter->rx_no_buffer = drops;

With more than one live queue, does each call simply overwrite the value
harvested for the previous queue?  In ibmveth_close() the new loop calls it
for every live queue back to back:

	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
		ibmveth_update_rx_no_buffer(adapter, i);

so the reported counter ends up being whichever queue was visited last, and
can move backwards between reads.

Similarly, ibmveth_poll_deliver_frame() does unlocked read-modify-writes:

	netdev->stats.rx_packets++;
	netdev->stats.rx_bytes += length;

and the replenish counters (replenish_task_cycles, replenish_add_buff_success
/ _failure, replenish_no_mem) are serialized only by the per-queue
rx_queue[i].replenish_lock, which does not serialize different queues against
each other.  Can these lose counts once several NAPI instances run
concurrently?

The changelog notes that the following patch moves these counters to
per-queue storage summed on read, which does resolve it; the question is
whether this intermediate state is worth carrying.

> @@ -1062,6 +1094,7 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>  		dev_err_ratelimited(&adapter->netdev->dev,
>  				    "MQ buffer add H_FUNCTION (q=%d, batch=%u), reset\n",
>  				    queue_index, fail.batch);
> +		adapter->mq_fallback = true;
>  		schedule_work(&adapter->work);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but this commit makes the reset
producer reachable for the first time (adapter->multi_queue was hardcoded to
0 before) and adds a second schedule_work() site here.

At this commit ibmveth_reset() has no registration-state check:

	rtnl_lock();
	dev_close(adapter->netdev);
	dev_open(adapter->netdev, NULL);
	rtnl_unlock();

and ibmveth_remove() still runs cancel_work_sync(&adapter->work) before
unregister_netdev().  If a live queue hits MQ buffer-add H_FUNCTION after
the cancel, can the requeued work then run dev_close()/dev_open() against a
netdev that unregister_netdev()/free_netdev() is tearing down?

Both halves are fixed later in this series (ibmveth_remove() is reordered to
unregister_netdev() before cancel_work_sync(), and ibmveth_reset() gains the
netdev->reg_state != NETREG_REGISTERED gate), so the exposure is limited to
this intermediate commit.

> @@ -1081,6 +1114,27 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
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
> +	ibmveth_replenish_task(adapter, qindex);
> +	if (ibmveth_schedule_rx_queue(adapter, qindex))
> +		return;
> +
> +	ibmveth_enable_irq(adapter, qindex);
> +}

[Severity: High]
Is the unconditional ibmveth_enable_irq() here safe in multi-queue mode?

ibmveth_schedule_rx_queue() returns false in two different situations:

	if (napi_schedule_prep(napi)) {
		ibmveth_disable_irq(adapter, qindex);
		__napi_schedule(napi);
		return true;
	}
	return false;

The second case is "NAPI already claimed", which is exactly what the IRQ
handler does after it has masked PHYP.  In MQ mode
ibmveth_setup_rx_interrupts() has already unmasked every queue:

	if (adapter->multi_queue && num > 1) {
		for (i = 0; i < num; i++) {
			rc = ibmveth_enable_irq(adapter, i);

so by the time open() runs its restart loop an interrupt may already have
claimed NAPI and masked the queue.  restart then re-unmasks it under the
in-flight poll, and when that poll finishes ibmveth_poll() calls
ibmveth_enable_irq() again on an already-enabled subordinate interrupt.

ibmveth_toggle_irq() folds H_PARAMETER only on the disable side:

		if (h_rc == H_PARAMETER && !enable) {
			dev_warn_ratelimited(...);
			return 0;
		}

so the redundant enable returns -EIO, and ibmveth_poll() escalates that to
schedule_work(&adapter->work), i.e. a full dev_close()/dev_open() of an
otherwise healthy adapter.

Since the PHYP mask/unmask hcalls are not reference counted, should restart
skip the enable when schedule_rx_queue() failed because NAPI was already
scheduled, rather than when prep failed for lack of a pending descriptor?
The same enable-then-restart sequence appears later in the ethtool -L
scale-up path of ibmveth_resize_rx_queues_incremental():

	rc = ibmveth_enable_irq(adapter, i);
	...
	ibmveth_restart_rx_queue(adapter, i);

[ ... ]

> +static int
> +ibmveth_register_single_rx_queue(struct ibmveth_adapter *adapter,
> +				 int queue_idx)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	union ibmveth_buf_desc rxq_desc;
> +	long lpar_rc;
> +
> +	if (WARN_ON(queue_idx < 1 || queue_idx >= IBMVETH_MAX_RX_QUEUES))
> +		return -EINVAL;
> +
> +	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
> +				    adapter->rx_queue[queue_idx].queue_len;
> +	rxq_desc.fields.address = adapter->rx_queue[queue_idx].queue_dma;
> +
> +	lpar_rc = ibmveth_register_logical_lan_queue(adapter, rxq_desc,
> +						     queue_idx);
> +	if (lpar_rc != H_SUCCESS) {
> +		netdev_err(netdev, "Failed to register queue %d: rc=0x%lx\n",
> +			   queue_idx, lpar_rc);

[Severity: Low]
lpar_rc is a signed long here, and ibmveth_register_logical_lan_queue()
returns -EINVAL when irq_create_mapping() fails, so that case prints as
rc=0xffffffffffffffea.  Would %ld (or splitting the errno and hypervisor
cases) read better?  Note this will not produce a build warning, since the
signed/unsigned format mismatch is only diagnosed under
-Wformat-signedness, which the kernel does not enable.

[ ... ]

> +static void ibmveth_apply_mq_fallback(struct ibmveth_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +
> +	if (!adapter->mq_fallback)
> +		return;
> +
> +	adapter->mq_fallback = false;
> +
> +	if (!adapter->multi_queue && ibmveth_get_num_rx_queues(adapter) == 1)
> +		return;
> +
> +	netdev_warn(netdev,
> +		    "Falling back to single RX queue (firmware MQ unavailable)\n");
> +	adapter->multi_queue = false;
> +	ibmveth_publish_num_rx_queues(adapter, 1);
> +	/* real_num_rx_queues is set later in open after resources exist. */

[Severity: Medium]
Can the two counts be left permanently out of sync here?

ibmveth_apply_mq_fallback() runs at the very top of ibmveth_open() and
publishes adapter->num_rx_queues = 1, but netdev->real_num_rx_queues is only
updated further down.  Four failure exits sit in between:

	ibmveth_alloc_filter_list()
	ibmveth_alloc_rx_queues()
	ibmveth_alloc_buffer_pools()
	ibmveth_register_rx_queues()
	...
	netif_set_real_num_rx_queues(netdev, ibmveth_get_num_rx_queues(adapter))

If the fallback open fails at any of those (for example -ENOMEM from pool
allocation, or -ENONET from queue-0 registration), the device stays down with
adapter->num_rx_queues == 1 while netdev->real_num_rx_queues is still the old
multi-queue value, so /sys/class/net/ethX/queues/rx-1..7 remain present for
queues the driver will never drive.

That contradicts the invariant the probe path documents for exactly this
case:

	 * alloc_etherdev_mqs() sized real_num_rx_queues to MAX. Match the
	 * advertised default (or SQ 1) before register_netdev so down-state
	 * readers agree with adapter->num_rx_queues / ethtool -l.

Would it be better to lower real_num_rx_queues in the fallback path itself,
or to restore the published count on the open failure paths?

> @@ -1651,6 +1900,8 @@ static int ibmveth_open(struct net_device *netdev)
>  
>  	netdev_dbg(netdev, "open starting\n");
>  
> +	ibmveth_apply_mq_fallback(adapter);
> +
>  	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
>  		rxq_entries += adapter->rx_buff_pool[0][i].size;
>  
> @@ -1670,18 +1921,34 @@ static int ibmveth_open(struct net_device *netdev)
>  	if (rc)
>  		goto out_free_buffer_pools;
>  
> -	rc = netif_set_real_num_rx_queues(netdev, adapter->num_rx_queues);
> +	rc = netif_set_real_num_rx_queues(netdev,
> +					  ibmveth_get_num_rx_queues(adapter));
> +
>  	if (rc) {
>  		netdev_err(netdev, "failed to set number of rx queues\n");
>  		goto out_unregister_queues;
>  	}
>  
> +	/*
> +	 * Post buffers before setup_rx_interrupts(). MQ setup then unmasks
> +	 * PHYP; SQ setup leaves PHYP masked. Scheduling NAPI only when a
> +	 * descriptor is already pending is not enough: after ifdown/up
> +	 * (RX=8, no -L) NAPI can be idle with nothing pending and the
> +	 * queue stays dead (TX OK, ARP/RX fail).
> +	 * restart_rx_queue() replenishes, schedules NAPI, and unmasks if
> +	 * prep fails.
> +	 */
> +	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
> +		netdev_dbg(netdev, "initial replenish cycle for queue %d\n", i);
> +		ibmveth_replenish_task(adapter, i);
> +	}
> +
>  	rc = ibmveth_setup_rx_interrupts(adapter);
>  	if (rc)
>  		goto out_free_all_queues; /* setup already disposed IRQs */
>  
> -	netdev_dbg(netdev, "initial replenish cycle\n");
> -	ibmveth_schedule_rx_queue(adapter, 0);
> +	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
> +		ibmveth_restart_rx_queue(adapter, i);

[Severity: Medium]
This replenish loop can queue reset work, and ibmveth_replenish_task()
returns void, so open() cannot see it:

	} else if (need_reset == IBMVETH_REPLENISH_RESET_MQ) {
		...
		adapter->mq_fallback = true;
		schedule_work(&adapter->work);
	}

If a buffer-add hcall returns H_FUNCTION here and the open then fails at
ibmveth_setup_rx_interrupts() or ibmveth_alloc_tx_resources(), userspace gets
an error back from ndo_open and the device is left down, but the pending
ibmveth_reset() only checks registration state:

	rtnl_lock();
	if (netdev->reg_state != NETREG_REGISTERED) {
		rtnl_unlock();
		return;
	}

	dev_close(adapter->netdev);
	dev_open(adapter->netdev, NULL);

so it brings the interface up anyway a moment later.  Should the reset worker
also check that the device was successfully opened before reopening it?

[Severity: Low]
This isn't a bug, but the kernel-doc on ibmveth_setup_rx_interrupts() still
describes the pre-MQ ordering:

 * Single-queue open leaves PHYP masked
 * here and kicks NAPI afterward (classic path: first poll posts then
 * enables).

After this change open() posts buffers for every live queue (queue 0
included, in single-queue mode) before calling setup_rx_interrupts(), and
ibmveth_restart_rx_queue() posts again, so the "first poll posts" behaviour no
longer applies to either mode.  Could that comment be refreshed?

> @@ -1714,6 +1981,7 @@ static int ibmveth_open(struct net_device *netdev)
>  static int ibmveth_close(struct net_device *netdev)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
> +	int i;
>  
>  	/* Gate on opened, not IFF_UP: pool_store/change_mtu close+open can
>  	 * leave IFF_UP set after a failed reopen.
> @@ -1734,7 +2002,8 @@ static int ibmveth_close(struct net_device *netdev)
>  	/* Wait for softirq/poll that already passed shutdown checks. */
>  	synchronize_net();
>  
> -	ibmveth_update_rx_no_buffer(adapter);
> +	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++)
> +		ibmveth_update_rx_no_buffer(adapter, i);
>  	ibmveth_free_all_queues(adapter);

[ ... ]

> @@ -2527,6 +2796,7 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
>  		ibmveth_rx_csum_helper(skb, adapter);
>  	}
>  
> +	skb_record_rx_queue(skb, queue_index);
>  	napi_gro_receive(napi, skb);
>  
>  	netdev->stats.rx_packets++;

[ ... ]

> @@ -2750,9 +3021,14 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
>  static void ibmveth_poll_controller(struct net_device *dev)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(dev);
> +	unsigned int num = ibmveth_get_num_rx_queues(adapter);
> +	int i;
>  
> -	ibmveth_replenish_task(adapter, 0);
> -	ibmveth_schedule_rx_queue(adapter, 0);
> +	for (i = 0; i < num; i++)
> +		ibmveth_replenish_task(adapter, i);
> +
> +	for (i = 0; i < num; i++)
> +		ibmveth_schedule_rx_queue(adapter, i);
>  }
>  #endif

[Severity: High]
This is a pre-existing race, not one introduced here, but walking every
published queue widens it considerably.

The in-driver callers of ibmveth_close() (veth_pool_store(),
ibmveth_set_csum_offload(), ibmveth_set_tso(), ibmveth_change_mtu()) call
ndo_stop directly rather than through dev_close(), so
netpoll_poll_disable() is never called and netif_running() stays true.
netpoll_poll_dev() can therefore call ndo_poll_controller() while close is
freeing the pools.

The replenish side samples the pool and then dereferences it:

		if (pool->active && pool->free_map &&
		    (atomic_read(&pool->available) < pool->threshold)) {
			rc = ibmveth_replenish_buffer_pool(adapter, pool,
							   queue_index, &fail);

while the freeing side takes no replenish_lock at all:

	kfree(pool->free_map);
	pool->free_map = NULL;

Can this access freed free_map[]/skbuff[]/dma_addr[] arrays, and the freed
buffer-list page in ibmveth_update_rx_no_buffer()?

A later patch in the series adds an "if (!adapter->opened) return;" check to
ibmveth_poll_controller(), but ibmveth_close() clears opened before it frees
anything and does not wait for an in-flight poll_controller, so the window
appears to remain.

> @@ -2781,23 +3056,35 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
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
>  
> +	for (q = 0; q < ibmveth_get_num_rx_queues(adapter); q++) {
> +		int rxqentries = 1;
> +
> +		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> +			struct ibmveth_buff_pool *bpool =
> +				&adapter->rx_buff_pool[0][i];
> +
> +			if (bpool->active)
> +				ret += bpool->size *
> +					IOMMU_PAGE_ALIGN(bpool->buff_size, tbl);
> +			rxqentries += bpool->size;
> +		}

[ ... ]

> @@ -2954,16 +3253,30 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  		netdev->features |= NETIF_F_FRAGLIST;
>  	}
>  
> -	/* Initialize queue count - always 1 for now */
> -	adapter->multi_queue = 0;
> -	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
> +	if (ret == H_SUCCESS &&
> +	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT)) {
> +		adapter->multi_queue = true;
> +		ibmveth_publish_num_rx_queues(adapter,
> +					      min(num_online_cpus(),
> +						  IBMVETH_DEFAULT_QUEUES));

[ ... ]

> @@ -2981,25 +3294,62 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
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

[Severity: Medium]
Can this free the memory the kobjects live in before their cleanup runs?

The pool kobjects are embedded in struct ibmveth_adapter, which is
netdev_priv(netdev), and ktype_veth_pool has .release = NULL.  With
CONFIG_DEBUG_KOBJECT_RELEASE=y the last kobject_put() goes to
kobject_release(), which defers the cleanup:

lib/kobject.c:kobject_release() {
	...
#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
	schedule_delayed_work(&kobj->release, delay);
	...
}

The delayed_work lives inside the kobject, i.e. inside the storage that
free_netdev() releases immediately on this path (reg_state is
NETREG_UNINITIALIZED), and the pool%d directories stay published against it
until the work fires a few seconds later.

The same put-then-free sequence is repeated on the
netif_set_real_num_tx_queues(), netif_set_real_num_rx_queues() and
register_netdev() failure paths below, and survives into the later
ibmveth_probe_cleanup() helper.  The changelog lists "pool kobj vs
DEBUG_KOBJECT_RELEASE" as a leftover - would adding a real release() with a
container that outlives the kobjects, or creating them only after the last
failure point, be the fix?

[Severity: Low]
This isn't a bug, but the policy here changes from "ignore
kobject_init_and_add() failure and keep probing" to "fail the probe", so a
kernfs name collision or -ENOMEM now leaves the interface unavailable
instead of merely missing the pool%d tuning knobs.  Checking the return
value is the right thing to do; could the changelog mention the behaviour
change, since it currently only describes adding cleanup?

> +	/*
> +	 * VIO CMO entitlement was set before probe (netdev NULL, so default).
> +	 * Recompute now that num_rx_queues and pool 0 metadata are known.
> +	 */
> +	if (firmware_has_feature(FW_FEATURE_CMO))
> +		vio_cmo_set_dev_desired(dev, ibmveth_get_desired_dma(dev));
> +

[Severity: Low]
This isn't a bug, but probe unconditionally selects min(num_online_cpus(),
IBMVETH_DEFAULT_QUEUES) RX queues whenever the firmware bit is set, and each
queue clones queue 0's full pool geometry plus its own buffer-list page and
RX ring.  ibmveth_get_desired_dma() therefore multiplies the desired DMA
entitlement by num_rx_queues, and vio_cmo_set_dev_desired() returns void, so
an entitlement request that cannot be granted is not visible here.

On a CMO partition with many CPUs, is defaulting to eight RX queues the
behaviour you want out of the box, or would defaulting to one and letting
ethtool -L opt in be safer?  The series does add the runtime opt-out in a
later patch.

>  	rc = netif_set_real_num_tx_queues(netdev, min(num_online_cpus(),
>  						      IBMVETH_DEFAULT_QUEUES));
>  	if (rc) {
>  		netdev_dbg(netdev, "failed to set number of tx queues rc=%d\n",
>  			   rc);
> +		ibmveth_put_pool_kobjs(adapter, pools_ready);
> +		dev_set_drvdata(&dev->dev, NULL);
> +		free_netdev(netdev);
> +		return rc;
> +	}
> +
> +	/*
> +	 * alloc_etherdev_mqs() sized real_num_rx_queues to MAX. Match the
> +	 * advertised default (or SQ 1) before register_netdev so down-state
> +	 * readers agree with adapter->num_rx_queues / ethtool -l.
> +	 */
> +	rc = netif_set_real_num_rx_queues(netdev,
> +					  ibmveth_get_num_rx_queues(adapter));

[Severity: Low]
With real_num_rx_queues now published as up to eight before
register_netdev(), ibmveth_get_channels() starts reporting max_rx and
rx_count greater than one:

	channels->max_rx = netdev->real_num_rx_queues;
	channels->rx_count = netdev->real_num_rx_queues;

but ibmveth_set_channels() at this commit only reads channels->tx_count.
Does "ethtool -L ethX rx 4" then pass the core's max_rx check, get silently
discarded by the driver and report success?

The changelog acknowledges this ("This commit does not implement
set_channels / rx_count") and patch 14 wires rx_count up, so the question is
whether the advertisement should wait for the implementation.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788102125.git.mmc%40linux.ibm.com

