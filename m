Return-Path: <linuxppc-dev+bounces-25527-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84289C5AC67
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 18:38:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGGGq2Vhsz3cKX;
	Fri, 07 Aug 2026 04:37:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786041443;
	cv=none; b=mKowO5ZpnvKK14vEFQW4FO140Wp3TGtlcXym8i6dwt8ckZoNqtNq/qsm3/74z0VSUPKPUblFC02/+/UwK+u/ynXadoEhuYnA47DWQwrgXy556CdW4KUuf6Vf+Tngq+YgXqugMySFULOTVNtMekTawOfy6g11C1m/IplMSQHD6yidgspKAERXtxY1LJwkrea0L3LfpZ5HgtjNJgpZ4YQdUXxsprWqcLiJLu6N64bEB/8jwsXF8bPhut/wDoYGiqN09P/KntNXdy8H/lfLD09Ce5OaKLLsSv+MDl8DAS1rL0A/Wc+ZA6nz8eDsSTHd3g1sEN25QRBi+iu+Hyh4e4+ClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786041443; c=relaxed/relaxed;
	bh=smMuZSDIJ0wT2ZIqbgfuuJTXpbe3gpE5hbVQdojJnpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XudczJQ+pqmMR3k8KlEI3Bq3NiTURGmLZ3lrrYQZ5WtKLLqYZOsldtWjzyucMPM1qqgUh2cNIDRrnjIvMjTPfHiLPLgD4ej16MDfFo53zr5KF5KhW11D1rWXi0y3/NfsrLEl6vYrNQS5ZOcCJMoBCkPDGeC6FH9r0IENjDSodBKqQhzKWiqf3XT7oj4tsvfWCvgaD4R10U2z/cO+6uNOY2rpklqWLuJAvjINk+Zi87LgmNgysC+b36UUUzWbq5ffQlEDgRQdqXRTUOD/pDdyZ1RWmLK9oFQ3J+KEqJ/uwJ8adQxz1FcYhmIIICgF7SMrguJF92tgKk97O4Iwk73F7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XaDQaU73; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XaDQaU73;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGGGk39vdz3c7n
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 04:37:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3DF3844034;
	Thu,  6 Aug 2026 18:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE0B1F00ACA;
	Thu,  6 Aug 2026 18:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041434;
	bh=smMuZSDIJ0wT2ZIqbgfuuJTXpbe3gpE5hbVQdojJnpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XaDQaU73FBWoBN3NaFBJZbXdmMbShnhJXrK01zh9oARAhA0A4+R4j2V1K1aR8SfzC
	 SY2IrcjDQXsyJXNdK0esB/T2lXDixJcfyEUlHxdBwCoT7FQmGl1KjyPgsCLX8GJjGi
	 WJqqQJOJEGTFXPeOy2UWCcTXrk3hcxFjfFkBdOe4ANrPuDO3xTsi3qtn+CmJP6oApU
	 5Qn8x8hyGIoRNPhQeq3PzydQ8rstY07F4sJDclMF5pQLiDT2Ymgd1olkv04AulSl7N
	 ezVtHlZS6itnHEWZKi2J+Gj5KQdV5UCL1DN0nDhHQPezml9H31MvjEAEv4LwQgOg3P
	 yLi7g4w7buXfw==
From: Jakub Kicinski <kuba@kernel.org>
To: mmc@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	horms@kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	simon.horman@corigine.com,
	shaik.abdulla1@ibm.com,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v4 13/14] ibmveth: Wire ethtool set_channels to MQ RX queue resize
Date: Thu,  6 Aug 2026 11:37:13 -0700
Message-ID: <20260806183713.3175936-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <135011a5c18abead73784a587ed20d1518168a2d.1785457143.git.mmc@linux.ibm.com>
References: <135011a5c18abead73784a587ed20d1518168a2d.1785457143.git.mmc@linux.ibm.com>
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
ibmveth: Wire ethtool set_channels to MQ RX queue resize

This completes the RX side of ibmveth_set_channels(): when the interface is
down the TX queue count is published and the desired RX count is stashed for
the next open(), and when it is up the RX resize runs through
ibmveth_resize_rx_channels() before the existing TX LTB alloc/free path. It
also renames the TX bookkeeping variables to old_tx/goal_tx and adds an early
return when the TX count is unchanged.

A few questions below.

>       - Non-MQ firmware returns -EOPNOTSUPP for rx > 1.
>       - Validate rx_count within 1..IBMVETH_MAX_RX_QUEUES.

[Severity: Low]
Do these two bullets describe changes that are actually in this patch?

Both checks live in ibmveth_resize_rx_channels() in
drivers/net/ethernet/ibm/ibmveth.c:

	if (goal_rx > 1 && !adapter->multi_queue) {
		...
		return -EOPNOTSUPP;
	}

	if (goal_rx < 1 || goal_rx > IBMVETH_MAX_RX_QUEUES) {
		...
		return -EINVAL;
	}

and they were added by the preceding patch "ibmveth: Implement incremental MQ
RX queue resize". This patch neither adds nor changes them.

Related to the split: the parent commit carried a comment in
ibmveth_set_channels() that referred to the patch series itself, which this
patch now deletes:

	/* Resize RX first while UP so ibmveth_resize_rx_channels() is used
	 * in this patch. !IFF_UP RX stash ordering lands next.
	 */

Could that comment be dropped from the parent instead, so no committed state
of the tree describes an unfinished series?

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index b57c7df92853f..c99d8e8be7b37 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -2723,20 +2723,28 @@ static int ibmveth_set_channels(struct net_device *netdev,
>  				struct ethtool_channels *channels)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
> -	unsigned int old = netdev->real_num_tx_queues,
> -		     goal = channels->tx_count;
>  	unsigned int goal_rx = channels->rx_count;
> +	unsigned int old_tx = netdev->real_num_tx_queues;
> +	unsigned int goal_tx = channels->tx_count;
>  	int rc, i;
>  
>  	/* If ndo_open has not been called yet then don't allocate, just set
>  	 * desired netdev_queue's and return
>  	 */
> -	if (!(netdev->flags & IFF_UP))
> -		return netif_set_real_num_tx_queues(netdev, goal);
> +	if (!(netdev->flags & IFF_UP)) {

[Severity: High]
Is netdev->flags & IFF_UP a reliable proxy here for "the driver holds RX
resources"?

ibmveth tears down and re-creates its resources internally while IFF_UP stays
set. veth_pool_store() does:

	ibmveth_close(netdev);
	...
	if (netif_running(netdev)) {
		rc = ibmveth_open(netdev);
		if (rc) {
			pool->active = oldactive;
			...
			goto unlock_err;

and ibmveth_change_mtu() does the same close/open dance. If the reopen fails,
for example a GFP_KERNEL failure in ibmveth_alloc_rx_queues() or
ibmveth_alloc_buffer_pools(), the error is returned without clearing
dev->flags, so IFF_UP remains set while ibmveth_close() ->
ibmveth_cleanup_rx_interrupts() has already run:

	for (i = 0; i < adapter->num_rx_queues; i++)
		napi_disable(&adapter->napi[i]);

and ibmveth_cleanup_rx_resources() has set buffer_list_addr[i] and
rx_queue[i].queue_addr to NULL, with adapter->num_rx_queues left unchanged.

A later "ethtool -L ethX rx <smaller>" then takes the UP branch and the
scale-down loop in ibmveth_resize_rx_queues_incremental() calls
napi_disable(&adapter->napi[i]) a second time on an already-disabled NAPI.
Does napi_disable_locked() ever return in that case?

net/core/dev.c:napi_disable_locked() {
	...
	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}
	...
}

That would be an unkillable spin with rtnl_lock held.

The scale-up direction on the same stale state reaches
ibmveth_replenish_task() -> ibmveth_update_rx_no_buffer(), which does:

	for (i = 0; i < adapter->num_rx_queues; i++) {
		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
		u64 drops = be64_to_cpup(p);

with buffer_list_addr[i] already NULL.

This dispatch on IFF_UP came from the preceding patch, but this patch
finalizes it as the user-visible interface. Would keying the decision on an
explicit "RX resources allocated" state in the adapter avoid this?

> +		if (goal_tx != old_tx) {
> +			rc = netif_set_real_num_tx_queues(netdev, goal_tx);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		/* Stash desired RX count only after TX succeeds (or was
> +		 * already correct); open() publishes it via
> +		 * netif_set_real_num_rx_queues().
> +		 */
> +		return ibmveth_resize_rx_channels(adapter, goal_rx);
> +	}

[Severity: Medium]
Does this path need to refresh the VIO CMO DMA entitlement?

The stash branch of ibmveth_resize_rx_channels() just does:

	if (!(netdev->flags & IFF_UP)) {
		adapter->num_rx_queues = goal_rx;
		return 0;
	}

and ibmveth_get_desired_dma() sizes the request per RX queue:

	for (q = 0; q < adapter->num_rx_queues; q++) {

The only two vio_cmo_set_dev_desired() call sites in the driver are the live
resize path in ibmveth_resize_rx_queues_incremental():

	if (firmware_has_feature(FW_FEATURE_CMO))
		vio_cmo_set_dev_desired(adapter->vdev,
					ibmveth_get_desired_dma(adapter->vdev));

and ibmveth_change_mtu(), which refreshes it even while the interface is
closed. ibmveth_open() does not call it.

So on a CMO LPAR, after

	ip link set dev ethX down
	ethtool -L ethX rx 16
	ip link set dev ethX up

the entitlement is still sized for the old, smaller RX count while open()
DMA-maps the larger footprint (per-queue buffer-list page, RX ring, buffer
pools). Can vio_dma_iommu_map_page() -> vio_cmo_alloc() then fail and make
the link fail to come up with -ENOMEM? Shrinking while down has the mirror
effect of leaving entitlement reserved until the next MTU change or live
resize.

[Severity: Low]
Should this branch also publish the RX count to the netdev?

TX is published immediately with netif_set_real_num_tx_queues(), but RX only
reaches the stash in ibmveth_resize_rx_channels(), so
netdev->real_num_rx_queues keeps its old value until the next
ibmveth_open(). Meanwhile ibmveth_get_channels() reports the private counter:

	channels->rx_count = adapter->num_rx_queues;

After "ip link set dev ethX down; ethtool -L ethX rx N", ethtool -l reports
N while /sys/class/net/ethX/queues/rx-*, the RPS/RFS maps and netdev-genl
queue enumeration still show the old count.

netif_set_real_num_rx_queues() only touches kobjects and RPS maps and
allocates no driver resources, and probe already sized the netdev with
alloc_etherdev_mqs(..., IBMVETH_MAX_QUEUES, IBMVETH_MAX_RX_QUEUES), so is
there a reason RX cannot be published here the way TX is?

>  
> -	/* Resize RX first while UP so ibmveth_resize_rx_channels() is used
> -	 * in this patch. !IFF_UP RX stash ordering lands next.
> -	 */
>  	rc = ibmveth_resize_rx_channels(adapter, goal_rx);
>  	if (rc)
>  		return rc;

[Severity: High]
Can this live resize race with a surviving queue's NAPI poll?

The scale-down branch of ibmveth_resize_rx_queues_incremental() takes its
grace period before lowering the count, and the frees come after the store:

	synchronize_net();

	rc = netif_set_real_num_rx_queues(netdev, new_count);
	...
	adapter->num_rx_queues = new_count;

	for (i = new_count; i < old_count; i++) {
		ibmveth_cleanup_single_rx_interrupt(adapter, i);
		ibmveth_deregister_single_rx_queue(adapter, i);
		ibmveth_free_single_rx_queue(adapter, i);
	}

ibmveth_free_single_rx_queue() then does:

	if (adapter->buffer_list_addr[queue_idx]) {
		free_page((unsigned long)adapter->buffer_list_addr[queue_idx]);
		adapter->buffer_list_addr[queue_idx] = NULL;
	}

A surviving queue's poll -> ibmveth_replenish_task() ->
ibmveth_update_rx_no_buffer() uses the count as a lockless bound and
dereferences the pointer without a NULL check:

	for (i = 0; i < adapter->num_rx_queues; i++) {
		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
		u64 drops = be64_to_cpup(p);

The reader holds only rx_queue[k].replenish_lock, the writer holds rtnl, so
the locksets do not intersect and disabling the removed queues' NAPIs does
not quiesce the surviving pollers. Can this read a freed page, or
dereference NULL + 4088 if the pointer load lands after the NULL store?

The scale-up side publishes the count with a plain store before the reader
can see the pointer stores:

	adapter->num_rx_queues = i + 1;
	ibmveth_replenish_task(adapter, i);

On PowerPC, can a reader observe the larger count with a stale NULL
buffer_list_addr[i]?

The resize helper and its UP-path caller came from the preceding patch
"ibmveth: Implement incremental MQ RX queue resize", so this is not
introduced here, but this patch completes the user-facing entry point that
drives it. The later patch "ibmveth: Fix MQ RX poll and shutdown hangs after
queue resize" only touches correlator validation and poll shutdown and leaves
ibmveth_update_rx_no_buffer() and this ordering unchanged.

[Severity: Medium]
Can the adapter-wide rx_no_buffer counter lose updates once more than one RX
queue is configured through this path?

ibmveth_update_rx_no_buffer() resets and re-accumulates a shared counter and
writes every queue's qstats entry:

	adapter->rx_no_buffer = 0;
	for (i = 0; i < adapter->num_rx_queues; i++) {
		...
		adapter->rx_no_buffer += drops;
	}

but it is called from ibmveth_replenish_task() while only that caller's
per-queue lock is held:

	spin_lock_irqsave(&rxq->replenish_lock, flags);
	...
	ibmveth_update_rx_no_buffer(adapter);

	spin_unlock_irqrestore(&rxq->replenish_lock, flags);

With polls for queue 0 and queue 1 running on different CPUs, the locksets
are disjoint, so the "= 0" and the "+=" from both CPUs interleave and
ethtool -S / ndo_get_stats64() can report a value near zero or well below
the real one. This came in with the earlier per-queue aggregation and MQ RX
patches rather than this one, and the later "ibmveth: Fix MQ RX poll and
shutdown hangs after queue resize" patch does not touch this function.

[Severity: Low]
Is a partially applied configuration possible here?

In the UP path the RX resize is committed first, including hypervisor
registration, IRQ setup/teardown, buffer alloc/free and the update of
adapter->num_rx_queues. If the later netif_set_real_num_tx_queues() fails,
for example -ENOMEM out of netdev_queue_update_kobjects(), set_channels()
returns that error with the RX count already changed, so the resulting
configuration matches neither the old nor the requested one and nothing
rolls RX back.

The !IFF_UP branch above has the mirror ordering: TX is committed with
netif_set_real_num_tx_queues() before any RX validation runs, since the
-EOPNOTSUPP and -EINVAL checks live inside ibmveth_resize_rx_channels(),
which is called last. A rejected RX value would leave the TX count changed
with no rollback. Today the ethtool core clamps rx_count against max_rx
before the driver op runs, so this half is latent, but should the RX
validation happen before TX is touched?

> @@ -2744,10 +2752,17 @@ static int ibmveth_set_channels(struct net_device *netdev,
>  	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
>  	 * but we may need to alloc/free the ltb's.
>  	 */
> +	if (goal_tx == old_tx)
> +		return 0;
> +
>  	netif_tx_stop_all_queues(netdev);
>  
> -	/* Allocate any queue that we need */
> -	for (i = old; i < goal; i++) {
> +	/* Allocate any queue that we need. Initialize i to old_tx so a
> +	 * scale-down path that never enters the loop still has defined
> +	 * bounds if set_real_num_tx_queues() fails.
> +	 */
> +	i = old_tx;
> +	for (; i < goal_tx; i++) {

[Severity: Low]
Is there a case where i was undefined before this change?

The previous form was:

	for (i = old; i < goal; i++) {

The init clause runs unconditionally before the first condition test, so i
was already assigned even when the body never executes. Splitting it into
"i = old_tx; for (; i < goal_tx; i++)" looks semantically identical, and the
new comment suggests the idiomatic form was unsafe. Could the comment be
dropped or reworded?

The changelog bullet "Always return rc from set_channels()" also looks like a
non-change, since the UP path already ended with "return rc;" and the down
path already returned the netif_set_real_num_tx_queues() value.

In the one case where an error is actually lost, the claim does not hold. On
ibmveth_allocate_tx_ltb() failure the rewind runs:

		goal_tx = old_tx;
		old_tx = i;
		break;
	}
	rc = netif_set_real_num_tx_queues(netdev, goal_tx);

so the -ENOMEM is overwritten by a call that cannot fail because goal_tx now
equals dev->real_num_tx_queues, and "ethtool -L ethX tx N" reports success
after an allocation failure. That clobber is identical at the baseline and is
not introduced here, it just means the hardening bullet does not describe it.

Separately, the genuinely new TX behaviour in this hunk, "if (goal_tx ==
old_tx) return 0;", which now skips netif_tx_stop_all_queues() and
netif_tx_wake_all_queues() when only RX is resized, is not mentioned in the
commit message. Could it be added there?

[ ... ]

