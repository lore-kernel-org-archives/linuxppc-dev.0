Return-Path: <linuxppc-dev+bounces-26513-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3768CC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 23:40:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbbgd5xLBz30dV;
	Fri, 04 Sep 2026 09:40:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788459050;
	cv=none; b=nG3ZHAMhKNx1l4tXWNN2Zmu57BSyXY18pVrchhRwIIGjEZ/BWOGYaW4OoDSFAHWCOnc/gFllP1nBlZ6rzButeohyerMk27kHZR7X0MZSAkvzZlwZL7bC30X/xMaFS8hVG4TAoQKhgVL3A53HO07AFJahzzm3QGc3QID9adyab3Zl8ktjdRmGbXm7bmzjFjFIW1U2lEt7JrVaSMcZ16m446PkTuQbPEJWNfSxPIWrLcmO8+XoCudHF4vZ89UpBTIRxUHPajiXtdTvn4bViOvpuSwu1xvYY6KLRJhebuVS07ls65I6h+mTsIr7M1Jn+Vurpa6QSZR9nOQVgtFlhYUezg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788459050; c=relaxed/relaxed;
	bh=ZIIgVuIi3mfbCrea3/dtFbIYbYeEriOKm3waXn9SSsQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vc80UxgBrx1R1l3GS2NVwZ4hRziQi29YcNyJ7z4gCXQg7fxNLQiPwf3JW747kQt3gqBU4vtVforQiM5VSykQAdViTgTCc+MuKNkL3fTN/GLpCFmxBh+bx7gMrCZv0XsAIX3AYvBeh738Rge2jc5Ja+mjZIydUjdw/hEbeRBoCnIKgeNp4rCMD3iOstcQVJ3AdKyYiDxvXqtfsfVuV1gXCVSBB3aBgy3grszt3p81nnuTUjZvkgfyTz3NoVglbIgSDPQ1KdIE75Bxzzl2xIkbpYyy4nZOXPRR98d4bqyoA3nCt1YPxPvc04oiJOptbn42g6tB+q1ioEnX6tUnnyVV0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtjECWv/; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtjECWv/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbSMF3tWZz2y2R
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 04:10:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0C596402DF;
	Thu,  3 Sep 2026 18:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB1B1F00A3D;
	Thu,  3 Sep 2026 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459047;
	bh=ZIIgVuIi3mfbCrea3/dtFbIYbYeEriOKm3waXn9SSsQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WtjECWv/EEnJzQfNq7ZJxBC5T9JAikizaqLHk6mASaCbh2+LLc7pn7FFRWpelajTP
	 mVd/Bzw/Nsg+UNIqUJA17TI2HXqC7R+En6NT7IrOZSzrfcZBjHUbLGcG61KuWrz/+B
	 2BwvqwsQIzrcgBPpCET3x/mEdX9RACiblRU/vyhN+7DfC96YmdBMtt4he3dWgC45TK
	 srRz8n03NL8MouVxkW/yp80XkU3T1kPy3Glrbvk4ZgdvHXz6NXynY+5w065i0yc6qk
	 rLb0B1/bZRkqyev34dUzCP18gGyZ/Wtrck9C8xHH9powb6Vabc5PPfst9/MaqUKrtU
	 jAtkhP+aNLXnQ==
Subject: Re: [net-next,v6,15/15] ibmveth: Complete set_channels down-path and
 mq_fallback max_rx cap
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Thu, 03 Sep 2026 18:10:46 +0000
Message-ID: <178845904669.3394541.24513769216494846@kernel.org>
In-Reply-To:
 <7096819367d53e08c1f4d317616c2624a2867b7a.1788102125.git.mmc@linux.ibm.com>
References:
 <7096819367d53e08c1f4d317616c2624a2867b7a.1788102125.git.mmc@linux.ibm.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 3

- [Medium] Advertised RX channel range does not match the enforced range
  once `mq_fallback` latches.
- [Low] In `ibmveth_set_channels()` the comment above the RX rollback
  describes code that no longer exists: it claims…
- [Low] The new up-path TX-failure rollback in `ibmveth_set_channels()`
  calls `ibmveth_resize_rx_queues_incremental(adapter, old_rx,…
- [Low] `adapter->mq_fallback` is written with a plain store from
  softirq/NAPI context — `ibmveth_replenish_task()` does…

--

ibmveth: Complete set_channels down-path and mq_fallback max_rx cap

This completes the ethtool -L path in ibmveth: the down-path publishes the
desired RX count without allocating, the up-path resizes RX then TX and
rolls RX back if TX cannot reach the requested count, and get_channels()
now caps max_rx at the live rx_count once mq_fallback is set.
ibmveth_poll_controller() also returns early when the adapter is closed.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 5aef8a1f2c23d..4cd00ff3d43e4 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -3156,15 +3156,24 @@ static void ibmveth_get_channels(struct net_device *netdev,
>  				 struct ethtool_channels *channels)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
> +	unsigned int rx_count = ibmveth_get_num_rx_queues(adapter);
>  
>  	channels->max_tx = ibmveth_real_max_tx_queues();
>  	channels->tx_count = netdev->real_num_tx_queues;
>  
> -	if (adapter->multi_queue)
> +	/*
> +	 * Always report the live RX count. ethtool -L is read-modify-
> +	 * write, so a TX-only request echoes rx_count back at us; an
> +	 * understated value would be applied as a silent RX shrink.
> +	 * mq_fallback instead caps max_rx at the live count, which
> +	 * blocks growth in the core without misreporting what is
> +	 * currently configured.
> +	 */
> +	channels->rx_count = rx_count;
> +	if (adapter->multi_queue && !adapter->mq_fallback)
>  		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
>  	else
> -		channels->max_rx = 1;
> -	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
> +		channels->max_rx = rx_count;
>  }

[Severity: Medium]
Once mq_fallback is set, does the advertised max_rx still match what the
driver will accept?

Here max_rx becomes the live rx_count, which can be 8 or 16.  The core only
bounds the request by that value, in ethtool_set_channels():

    if (channels.rx_count > curr.max_rx ||
        channels.tx_count > curr.max_tx ||

So every value in 1..rx_count reaches the driver.  But
ibmveth_resize_rx_channels() refuses any changed count above 1 in that
state, after the no-op shortcut:

    if (goal_rx == old_rx)
            return 0;
    ...
    if (goal_rx > 1 && (!adapter->multi_queue || adapter->mq_fallback)) {
            netdev_err(netdev,
                       "Cannot resize to %u RX queues: multi-queue mode not supported by firmware\n",
                       goal_rx);
            return -EOPNOTSUPP;
    }

With mq_fallback set and a live count of 8, ethtool -l reports max_rx 8 while
ethtool -L ethX rx 2 through rx 7 all fail with -EOPNOTSUPP; only 1 and the
current count are accepted.

This state looks persistent rather than transient, since
ibmveth_register_rx_queues() latches the flag and then fails the open:

    if (rc) {
            /* Firmware MQ gone: fall back to SQ on next open. */
            if (rc == -EOPNOTSUPP)
                    adapter->mq_fallback = true;
            goto err_unregister;
    }

adapter->opened stays false and num_rx_queues keeps its old value above 1
until the next successful open.

Would it be clearer to advertise max_rx = 1 in the fallback state and keep
the no-op shortcut for the read-modify-write case?  The kernel-doc for
ibmveth_resize_rx_channels() ("Rejects rx > 1 without MQ firmware
(-EOPNOTSUPP)") also does not mention that the no-op shortcut precedes the
gate.

[Severity: Low]
Is the read of adapter->mq_fallback here synchronized against its writer?

The flag is stored from softirq/NAPI context in ibmveth_replenish_task(),
after the replenish_lock has already been dropped:

    spin_unlock_irqrestore(&rxq->replenish_lock, flags);
    ...
            adapter->mq_fallback = true;
            schedule_work(&adapter->work);

The new reader added here, and the capability gate in
ibmveth_resize_rx_channels():

    if (goal_rx > 1 && (!adapter->multi_queue || adapter->mq_fallback)) {

run under RTNL / the netdev ops lock, which does not exclude the softirq
writer.  There is no lock, no READ_ONCE()/WRITE_ONCE() and no acquire/release
pairing on this field, while the sibling field num_rx_queues in the same
struct is deliberately published with:

    smp_store_release(&adapter->num_rx_queues, num);

A stale false read here would advertise max_rx = IBMVETH_MAX_RX_QUEUES right
after firmware refused MQ buffer adds, and a stale read in the gate would let
the driver allocate and replenish RX queues on that firmware, re-latching
mq_fallback and queueing another reset.  Would WRITE_ONCE()/READ_ONCE() on
mq_fallback, or folding it into the existing publish/consume helpers, be
appropriate?

> @@ -3233,28 +3242,83 @@ static int ibmveth_set_channels(struct net_device *netdev,
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
> +	bool rx_changed = false;
>  	int rc, i;
>  
> -	/* Validate RX (and resize when opened) before the down-path
> -	 * early return so MQ/range errors are reported here. Publishing
> -	 * the desired RX count and CMO while down is the next patch.
> -	 */
> -	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
> +	if (goal_tx < 1 || goal_tx > ibmveth_real_max_tx_queues()) {
> +		netdev_err(netdev,
> +			   "Invalid TX queue count %u (must be 1-%u)\n",
> +			   goal_tx, ibmveth_real_max_tx_queues());
> +		return -EINVAL;
> +	}
> +
> +	/* RX range / MQ checks live in ibmveth_resize_rx_channels(). */
> +	rc = ibmveth_resize_rx_channels(adapter, goal_rx);
>  	if (rc)
>  		return rc;

[ ... down-path publish/rollback block snipped ... ]

> -	return rc;
> +	if (netdev->real_num_tx_queues != want_tx) {
> +		if (rx_changed) {
> +			/*
> +			 * Only meaningful once RX is live. num_slots is
> +			 * embedded in the adapter and outlives the DMA ring,
> +			 * so reading it at function entry is safe but can
> +			 * return a stale geometry from before the resize.
> +			 */
> +			int rxq_entries = adapter->rx_queue[0].num_slots;

[Severity: Low]
This isn't a bug, but does this comment still describe the code below it?

It says num_slots is read "at function entry" and "can return a stale
geometry from before the resize", yet the read it annotates happens right
here, inside the if (rx_changed) block, after ibmveth_resize_rx_channels()
has already changed the RX geometry.  Function entry only reads
num_rx_queues, real_num_tx_queues, channels->rx_count and channels->tx_count.

The comment looks like a leftover from the v5 layout mentioned in the
changelog, and now warns about a hazard that would only exist if the read
were moved back to function entry.

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

[Severity: Low]
Can this rollback re-attempt a queue geometry that the forward path would
have refused?

The rollback calls ibmveth_resize_rx_queues_incremental() directly, so the
multi_queue / mq_fallback gate in ibmveth_resize_rx_channels() is not
consulted.  That gate only rejects goal_rx > 1:

    if (goal_rx > 1 && (!adapter->multi_queue || adapter->mq_fallback)) {
            ...
            return -EOPNOTSUPP;
    }

Consider adapter->opened true, mq_fallback already latched from softirq in
ibmveth_replenish_task():

    adapter->mq_fallback = true;
    schedule_work(&adapter->work);

and a live RX count of 8.  A request of rx 1 with a larger tx passes the gate
(goal_rx is 1), RX shrinks 8 -> 1 and rx_changed becomes true.  If the TX
step then fails in ibmveth_allocate_tx_ltb() or
netif_set_real_num_tx_queues(), the rollback runs the scale-up path back to
old_rx = 8 on firmware that has already refused MQ buffer adds, so
H_REG_LOGICAL_LAN_QUEUE / replenish hit the same H_FUNCTION, mq_fallback is
re-latched and another schedule_work(&adapter->work) reset is queued from an
ethtool error path.

Would it be better to route the rollback through
ibmveth_resize_rx_channels(), or to skip it when mq_fallback is set and leave
RX at 1?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788102125.git.mmc%40linux.ibm.com

