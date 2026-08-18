Return-Path: <linuxppc-dev+bounces-25932-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06658C5DF74
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 01:49:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPCJK1WGdz308V;
	Tue, 18 Aug 2026 11:47:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787017665;
	cv=none; b=Ot47SxOIbtxqecqD24MYZpezrMvG6cizHePr2ncQ5cycAnxC9EkZRYyo1x2qpFhxHrity/aMqVgeRybg9YOwrD/EnXfKgIVgwdbH8j4OyTghlNu+YOG+DxMAnee/b8iHyLVfmTY8/YqQKZAKP+AZm+F9aLMudIyo3qqoEHwG0V5+w6gfiGgt/6Hw9ncKFyX5DFpivfAtG2X4KBeMhPLup1ZP83HTj6MJzo6G2D1vMIqjXqZSANEzo6EWKHIrkv0NsDqxVHdGQMZjK+3+G5oK6mr9JN/eY8I4YTWeP51UqaIpU4hf/nD57biUugOJKQRfOHoND2Qo+1okQrMNcBrgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787017665; c=relaxed/relaxed;
	bh=1BP+STRPvsHbhGrH3Vs4tHREX99f10LlijrC3FkXFhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arUwodlLYJT3mCMD+cOS9D+mAebz9gJevRmj4TmnImlutVYIuwZqBFL2meQYw0QUs1wAz7eUHk/YLxGaUX6MH8hCeSBuGm3z8jLUXMbZs80xN886E0pKXsGEQWSbpDCOLHbBbxdYaKzSwO/K0vpoRSprxRSVyVDF7jdqygOtcVMt7i8qNAgAcutl+kURL9yllTf7GLFHjwXfV6bRwwF+XZmsv/aA9w2s1A7rR/++mMDc5aNPrDixHpYYtb50bx/R/v/WhWETnt+ZF9ekcHLK046olE9f5qLzdAU5vloU00YaLbY3U4zevAVsg1JmmliWPW3AVJVJrJCBE3uIeUADVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuH+EH1D; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuH+EH1D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPCJH3NRZz2yxG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:47:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4F867404CB;
	Tue, 18 Aug 2026 01:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9103B1F00A3A;
	Tue, 18 Aug 2026 01:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017661;
	bh=1BP+STRPvsHbhGrH3Vs4tHREX99f10LlijrC3FkXFhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kuH+EH1D0RNgZzAGMlaERKUl3NrGFja7yL3SStrgsb7hm4oPWGZtMMGO7TsKtvSQB
	 BZ4VDwYTarwn+9RSN1kbjV6ANo7gFN7/4ev77OLnXjzS2lA4AbCkTSGaUjf0nOmLIL
	 gRFCqmZzWuz3JzOc2ftgcR83I3WToIdXipqx2OyAdsGaYbWtTwYl3BnGa5R+maDxVn
	 3AafiJJBMaZq36wc3jEvI3ZuKBLxhcFVRpq+nb3LBVyIpWmAR3OEAXe/hubT32Gex3
	 aIx4mRm6CemWc3B7u1xaOJuWaoJGgBF/U7aRC+ZDnMFOH8dSHOK0nfh9dVqlVXYAl+
	 VLAMe3vuW8GgQ==
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
Subject: Re: [PATCH net-next v5 15/15] ibmveth: Wire ethtool set_channels to MQ RX queue resize
Date: Mon, 17 Aug 2026 18:47:39 -0700
Message-ID: <20260818014739.3854502-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-16-mmc@linux.ibm.com>
References: <20260814073642.24630-16-mmc@linux.ibm.com>
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

This completes the RX side of ibmveth_set_channels(): while the device is
down the desired RX count is stashed, and while it is up RX is resized
first and the TX LTB stop/alloc/set_real_num_tx/free/wake path runs
afterwards.  It also adds up-front TX range validation and an RX rollback
when TX cannot reach the requested count.

A few questions on the new paths below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 84f4a0deb0c55..35cbd2553e867 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -3175,28 +3176,75 @@ static int ibmveth_set_channels(struct net_device *netdev,
>  				struct ethtool_channels *channels)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
> -	unsigned int old = netdev->real_num_tx_queues,
> -		     goal = channels->tx_count;
> +	unsigned int old_rx = ibmveth_get_num_rx_queues(adapter);
> +	unsigned int goal_rx = channels->rx_count;
> +	unsigned int old_tx = netdev->real_num_tx_queues;
> +	unsigned int goal_tx = channels->tx_count;
> +	unsigned int want_tx = goal_tx;
> +	int rxq_entries = adapter->rx_queue[0].num_slots;
> +	bool rx_changed = false;
>  	int rc, i;
>  
> -	/* Validate RX (and resize when opened) before the down-path early
> -	 * return so MQ/range errors are not deferred to the wiring patch.
> -	 * RX stash + CMO while down still lands with that patch.
> -	 */
> -	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
> +	if (goal_tx < 1 || goal_tx > ibmveth_real_max_tx_queues()) {
> +		netdev_err(netdev,
> +			   "Invalid TX queue count %u (must be 1-%u)\n",
> +			   goal_tx, ibmveth_real_max_tx_queues());
> +		return -EINVAL;
> +	}

[Severity: Medium]
This isn't a bug introduced by this patch, but the bound used here is
CPU-count dependent while the reported current value is not, so the two can
disagree.

ibmveth_get_channels() fills the reply from two different sources:

	channels->max_tx = ibmveth_real_max_tx_queues();
	channels->tx_count = netdev->real_num_tx_queues;

and ibmveth_real_max_tx_queues() is min(num_online_cpus(),
IBMVETH_MAX_QUEUES).  After configuring N TX queues and then offlining CPUs
so that num_online_cpus() < N, the reply advertises tx_count > max_tx.

Both ethtool entry points reject a request whose tx_count exceeds the
driver-advertised max_tx:

net/ethtool/ioctl.c:ethtool_set_channels() {
	...
	if (channels.rx_count > curr.max_rx ||
	    channels.tx_count > curr.max_tx || ...)
		return -EINVAL;
	...
}

so even an RX-only change (which resubmits the current tx_count) fails with
-EINVAL until the CPUs come back online.  Should max_tx be latched from the
configured count instead, or should the new range check be against
IBMVETH_MAX_QUEUES?

> +
> +	/* RX range / MQ checks live in ibmveth_resize_rx_channels(). */
> +	rc = ibmveth_resize_rx_channels(adapter, goal_rx);
>  	if (rc)
>  		return rc;
>  
> -	if (!adapter->opened)
> -		return netif_set_real_num_tx_queues(netdev, goal);
> +	/* If RX resources are not live (never opened, or close+open failed
> +	 * while IFF_UP stayed set), only stash desired queue counts.
> +	 */
> +	if (!adapter->opened) {
> +		/* Apply TX first so a failure leaves RX stash unchanged. */
> +		rc = netif_set_real_num_tx_queues(netdev, goal_tx);
> +		if (rc)
> +			return rc;
> +
> +		/* Stash desired RX count; open() publishes it via
> +		 * netif_set_real_num_rx_queues() after queue registration.
> +		 * Refresh CMO now so open() can map the larger footprint;
> +		 * open itself does not call vio_cmo_set_dev_desired.
> +		 */

[Severity: Low]
Is this comment describing what the code does?  The block right below
publishes immediately rather than deferring to open():
ibmveth_publish_num_rx_queues() updates adapter->num_rx_queues and
netif_set_real_num_rx_queues() updates netdev->real_num_rx_queues, which
creates or removes the /sys/class/net/*/queues/rx-N entries while the
interface is down.  ibmveth_open() only re-applies the same value later:

	rc = netif_set_real_num_rx_queues(netdev,
					  ibmveth_get_num_rx_queues(adapter));

The commit message says the same thing:

    - When down: set TX queues first, then stash the desired RX count
      in adapter->num_rx_queues for the next open() (open publishes via
      netif_set_real_num_rx_queues).

Could the comment and the changelog mention that real_num_rx_queues, the
rx-N sysfs entries and (below) the CMO entitlement all change immediately
on a down interface?

> +		if (goal_rx != ibmveth_get_num_rx_queues(adapter)) {
> +			ibmveth_publish_num_rx_queues(adapter, goal_rx);

[Severity: Medium]
Can publishing a count with no allocated queues behind it let a lockless
reader take an uninitialized spinlock?

adapter->num_rx_queues is the only validity bound the RX readers use, and
rx_queue[i].replenish_lock is only spin_lock_init()'ed for queues that are
actually allocated (ibmveth_alloc_rx_queues() and
ibmveth_alloc_single_rx_queue()).

ibmveth_replenish_task() checks nothing else before locking:

	if (queue_index >= ibmveth_get_num_rx_queues(adapter)) {
		...
		return;
	}
	...
	spin_lock_irqsave(&rxq->replenish_lock, flags);

and ibmveth_poll_controller() has no adapter->opened check:

	unsigned int num = ibmveth_get_num_rx_queues(adapter);

	for (i = 0; i < num; i++)
		ibmveth_replenish_task(adapter, i);

That is reachable in the state this branch targets: pool_store and
change_mtu call ibmveth_close()+ibmveth_open() directly, so IFF_UP can stay
set (netif_running() true, netpoll still attached) with adapter->opened
false.  An "ethtool -L ethX rx N" with N above any previously allocated
count then publishes N here, and the window stays open for as long as the
device is down.

ibmveth_publish_num_rx_queues() itself states the invariant:

	/* Per-queue state must be visible before readers observe num. */
	smp_wmb();
	WRITE_ONCE(adapter->num_rx_queues, num);

Does this call site break it, given the per-queue state does not exist yet?

> +			rc = netif_set_real_num_rx_queues(netdev, goal_rx);
> +			if (rc) {
> +				ibmveth_publish_num_rx_queues(adapter, old_rx);
> +				return rc;
> +			}

[Severity: Medium]
On this failure path, netdev->real_num_tx_queues was already moved to
goal_tx by the netif_set_real_num_tx_queues() call above, and only the RX
publish is undone.

netif_set_real_num_rx_queues() has a real failure path:

net/core/dev.c:netif_set_real_num_rx_queues() {
	...
	rc = net_rx_queue_update_kobjects(dev, dev->real_num_rx_queues, rxq);
	if (rc)
		return rc;
	...
}

so ethtool can report failure while the TX count has permanently changed.
Should netif_set_real_num_tx_queues(netdev, old_tx) run here before
returning rc, and does the current code match the commit message claim
"Make TX/RX updates fail atomically"?

> +			if (firmware_has_feature(FW_FEATURE_CMO)) {
> +				unsigned long dma;
> +
> +				dma = ibmveth_get_desired_dma(adapter->vdev);
> +				vio_cmo_set_dev_desired(adapter->vdev, dma);
> +			}

[Severity: Medium]
Is the entitlement raised here ever lowered again if the stashed count is
never realized?  The desired value is sized for goal_rx RX queues, but no
buffer lists, queue DMA or pools are mapped while down.

If the next open() fails for the larger count, or if it applies the MQ
fallback and drops the count back to 1, neither ibmveth_open(),
ibmveth_close() nor ibmveth_apply_mq_fallback() recomputes desired DMA, so
the partition keeps CMO entitlement reserved for RX resources that do not
exist until a later successful set_channels or change_mtu.

> +		}
> +		return 0;
> +	}

[Severity: Medium]
Can a request that returns 0 from this branch be silently discarded on the
next open()?

If firmware rejected MQ during a previous ibmveth_register_rx_queues(),
adapter->mq_fallback is latched while adapter->multi_queue is still
non-zero, so "ethtool -L ethX rx 8" passes the MQ check in
ibmveth_resize_rx_channels(), takes this !opened branch, publishes 8, sets
real_num_rx_queues = 8, raises CMO desired and returns success.

ibmveth_apply_mq_fallback() then runs first in ibmveth_open():

	adapter->multi_queue = 0;
	ibmveth_publish_num_rx_queues(adapter, 1);

with no error back to the user and no entitlement recompute, and
ibmveth_get_channels() afterwards reports:

	channels->rx_count = ibmveth_get_num_rx_queues(adapter);

which is 1, contradicting the request that returned 0.  Should the down
path reject (or at least warn about) goal_rx > 1 when mq_fallback is
latched?

> +
> +	if (goal_rx != old_rx)
> +		rx_changed = true;
>  
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
> +	/* Allocate any new TX LTBs. i starts at old_tx for the free walk
> +	 * below when this loop body never runs (goal_tx == old_tx already
> +	 * returned; goal_tx < old_tx is scale-down).
> +	 */
> +	i = old_tx;
> +	for (; i < goal_tx; i++) {

[Severity: Low]
The commit message says:

    Initialize the TX alloc loop bound so a scale-down path that never
    allocates still has defined cleanup if set_real_num_tx_queues() fails.

Was there anything undefined before?  The removed line is:

	for (i = old; i < goal; i++) {

whose initializer runs even when the body does not (old >= goal), so i was
already defined for the later "for (i = old; i > goal; i--)" free walk.
Could this be described as a readability change rather than a fix?

>  		if (adapter->tx_ltb_ptr[i])
>  			continue;
>  
> @@ -3205,28 +3253,43 @@ static int ibmveth_set_channels(struct net_device *netdev,

[ ... ]

>  	netif_tx_wake_all_queues(netdev);
>  
> -	return rc;
> +	if (netdev->real_num_tx_queues != want_tx) {
> +		if (rx_changed) {
> +			int rb;
> +
> +			rb = ibmveth_resize_rx_queues_incremental(adapter,
> +								  old_rx,
> +								  rxq_entries);
> +			if (rb)
> +				netdev_err(netdev,
> +					   "Failed to roll back RX queues to %u after TX failure: %d\n",
> +					   old_rx, rb);
> +		}
> +		return rc ? rc : -ENOMEM;
> +	}

[Severity: Medium]
This rollback is best effort only, so the same "fail atomically" question
applies to the up path.  For "ethtool -L ethX rx <smaller> tx <larger>",
the RX scale-down has already destroyed queues; if
ibmveth_allocate_tx_ltb() then fails, the rollback here is a scale-up whose
own steps can fail too:

	rc = ibmveth_alloc_single_rx_queue(adapter, i, rxq_entries);
	if (rc) { ... goto cleanup_new_queues; }

and the same for ibmveth_register_single_rx_queue(),
ibmveth_setup_single_rx_interrupt(), ibmveth_enable_irq() and
netif_set_real_num_rx_queues().  Its cleanup path leaves RX at the reduced
count, and here that is only logged before returning an error.

Is there a way to order this so the destructive RX change happens only
after the TX LTB allocations have succeeded, so no partial state can be
left behind when the call reports failure?

>  }
>  
>  static const struct ethtool_ops netdev_ethtool_ops = {

