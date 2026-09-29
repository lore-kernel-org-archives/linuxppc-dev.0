Return-Path: <linuxppc-dev+bounces-28526-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B228CCA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:34:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvSyj5rnhz3bmM;
	Wed, 30 Sep 2026 05:33:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790710413;
	cv=none; b=W/H3FW6S8K3VuvttyEKGAI1mc7ISeQpL+t6ApdV5F1q+sXAhXbAgD6h1oM9Upc4hnqwmRsYQ3Qx4ayryL2RqB7L8j2kLJJ/At0g38oXNx67gMr3iKgDydWrEE7n4g+HvxVD2nbgB7GcPUSACnpAjKXpFIjXlWnwK5Rgk94NXK0cMSu5EFYHAHvl30HpM8pCVL9k2rUxJx0SWRewIpQyN38jCfIrom8KQ83Fwse8UgWOQ6bsDpmZSLVDRE07ssCES1UzmV3Hl0BNYVBdqLE6297e/V3Ao6PxpJbSgK+V0fBYK6qKBbmNMKi8Ksi+T7dYHHs8c0ay8rYrTjEH8EXvCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790710413; c=relaxed/relaxed;
	bh=7TcF8OYvio2OdQ3BeVyOuaJEH92AlMRSqt3tdA77Hak=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJf4QHlxy9qixi6hNyC9JGx9JpY8OKcmyG0/+pjr+BdZ31UdXbAmgAr7t/UYHds2eaoeoVKuYbWuRib3rCfmlzPfrFRoe2iWa8jgz0UXQ1gENAnwXCDaXUfr60wWNgz6Kl8EdrPlNwAwsfNLi/PTPO5XiCoWMk4E27b2h5tarMSRXXfSEn6rlYf24P3I7sydWBHQ69dX5b5eutivtGLiaudRyAl1Ir/z69bDPspKsgDRCsgmNmwjMsTG/HIIZZHZdY6KwuE9tsNa4Un3xItCoyyxQBlOeYq5r+XhBg6O8qxrgczFhHXGXUo1/80Jim4p10M5pmyTmZSlqfSV5L0vUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOY3UkUp; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOY3UkUp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvSyh1L5zz3bbY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:33:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3EABF60235;
	Tue, 29 Sep 2026 19:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2294D1F000FF;
	Tue, 29 Sep 2026 19:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710410;
	bh=7TcF8OYvio2OdQ3BeVyOuaJEH92AlMRSqt3tdA77Hak=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OOY3UkUpM9X6e+268hMjravwL+LlXkZaKxgF10Ef4LTUphuoDKyJUJp4G2sFLcG13
	 NlH0AodMXLNunfOPZJKldlFjHD7cKd/xW1+vQNnAP0moDb+JoAHCR5UsauUGzT4Bv/
	 lyGpLkhTk+RqzIuBEYcWr32BC0VHIIBv5y2zPIHW+fmgMSlv4QbcYnZmidOUUdKhXe
	 8KWT0oKwztHlICLDEDdAvPU/ZkHw9+ykFtsqL0CKANiqhvQL9PAVavh1Xuma0paQ3n
	 AffBTErPz/T3x2sef58JT0vw6EFSMUDopyshsNvTI9mjJDBhxoF2MdRii6cj01KB8A
	 UzMlG4SIesj6g==
Subject: Re: [PATCH net-next v7 15/15] ibmveth: Complete set_channels
 down-path and mq_fallback max_rx cap
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Tue, 29 Sep 2026 19:33:28 +0000
Message-ID: <179071040872.434549.12159663294832485086@kernel.org>
In-Reply-To:
 <de05d82d2d02c021de1e215656d1302d2cd41c46.1790319558.git.mmc@linux.ibm.com>
References:
 <de05d82d2d02c021de1e215656d1302d2cd41c46.1790319558.git.mmc@linux.ibm.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new !opened branch of ibmveth_set_channels() raises
  adapter->num_rx_queues with `ibmveth_publish_num_rx_queues(adapter,…
- [Low] The commit log refers to other patches by series position: "Patch
  14 wires live ethtool -L rx" and "replacing patch 14's temporary…
- [Low] When mq_fallback is set and the live RX count N is greater than
  1, ibmveth_get_channels() reports max_rx = rx_count = N.
- [Low] ibmveth_poll_controller() now reads adapter->opened as a plain
  bool from netpoll context, which runs without RTNL and concurrently…

--

ibmveth: Complete set_channels down-path and mq_fallback max_rx cap

This commit allows ethtool -L to change the RX count while the device is
down. The new count is published without allocating anything, and on the
live path RX is rolled back if TX fails. It also caps max_rx at the live
count under mq_fallback, raises the max_tx ceiling to at least the live
TX count, and guards ibmveth_poll_controller() with adapter->opened.

> Patch 14 wires live ethtool -L rx. This patch completes the down-path
> publish/rollback and get_channels() once mq_fallback is set, replacing
> patch 14's temporary -EOPNOTSUPP for an RX count change while down.

[Severity: Low]
This isn't a bug, but "Patch 14" and "patch 14's temporary -EOPNOTSUPP"
are series positions. They won't mean anything once this lands in git
history. Could they refer to the earlier commit by its subject instead?

The subject covers only the down path and the mq_fallback max_rx cap.
The patch also carries two further independent changes:

> max_tx is at least the live tx_count. After CPU offline,

[ ... ]

> Guard poll_controller() with adapter->opened so netpoll cannot walk
> unallocated queue state while closed.

After CPU offline, the max_tx change in ibmveth_get_channels() and
ibmveth_set_channels() lets ethtool -l report a max_tx above the online
CPU count. The ibmveth_poll_controller() guard is a separate netpoll
change.

Would splitting these out make bisecting and selective backporting
easier?

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 1b1dd89dadf79..da14c69152110 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -3399,15 +3399,32 @@ static void ibmveth_get_channels(struct net_device *netdev,
>  				 struct ethtool_channels *channels)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
> +	unsigned int rx_count = ibmveth_get_num_rx_queues(adapter);

[ ... ]

> +	channels->rx_count = rx_count;
> +	if (adapter->multi_queue && !adapter->mq_fallback)
>  		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
>  	else
> -		channels->max_rx = 1;
> -	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
> +		channels->max_rx = rx_count;
>  }

[Severity: Low]
When mq_fallback is set and the live RX count N is above 1, this reports
max_rx = N. The ethtool core only compares rx_count against max_rx:

net/ethtool/channels.c:ethnl_set_channels() {
    ...
	if (channels.rx_count > channels.max_rx)
		err_attr = ETHTOOL_A_CHANNELS_RX_COUNT;
    ...
}

A request for any value in 2..N-1 therefore reaches the driver.
ibmveth_resize_rx_channels() then rejects it:

	if (goal_rx > 1 && (!adapter->multi_queue || adapter->mq_fallback)) {
		...
		return -EOPNOTSUPP;
	}

That leaves 1 and N as the only RX counts set_channels accepts, while
get_channels advertises 1..N. For example, ethtool -l can show a max of
8, but ethtool -L dev rx 4 fails with "Operation not supported".

This state can be reached after ibmveth_replenish_task() or a scale-up
register failure sets mq_fallback. It lasts until the next
ibmveth_open() applies the fallback.

The commit message says the cap "blocks growth". Doesn't it also block
shrinking within the advertised range? Could get_channels and
set_channels be made to agree on what is settable?

[ ... ]

> @@ -3482,28 +3493,90 @@ static int ibmveth_set_channels(struct net_device *netdev,

[ ... ]

> +	if (!adapter->opened) {
> +		/* Apply TX first so a failure leaves the published RX
> +		 * count unchanged.
> +		 */
> +		rc = netif_set_real_num_tx_queues(netdev, goal_tx);
> +		if (rc)
> +			return rc;
> +
> +		/* Publish desired RX count for next open() and refresh CMO;
> +		 * do not allocate while down.
> +		 */
> +		if (goal_rx != ibmveth_get_num_rx_queues(adapter)) {
> +			ibmveth_publish_num_rx_queues(adapter, goal_rx);
> +			rc = netif_set_real_num_rx_queues(netdev, goal_rx);

[Severity: Medium]
Can raising num_rx_queues here leak a stranded subordinate RX queue?

Stranded queues (queue_handle[i] still set above the live count) are
reclaimed only in ibmveth_close(), and only if H_FREE_LOGICAL_LAN
succeeds:

	if (!ibmveth_free_all_queues(adapter))
		ibmveth_free_stranded_rx_queues(adapter);

That helper also only scans indices at or above the live count:

	for (i = ibmveth_get_num_rx_queues(adapter);
	     i < IBMVETH_MAX_RX_QUEUES; i++) {
		if (!adapter->queue_handle[i])
			continue;

Consider a live scale-up where H_REG or IRQ setup fails and the
per-queue H_FREE also fails. If the following close then fails
H_FREE_LOGICAL_LAN, the strand survives with opened == false. This new
down path can then lift num_rx_queues above that index, which moves it
out of the scan range.

On the next open, ibmveth_alloc_rx_queues() overwrites the pointers
without checking them:

	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
		adapter->buffer_list_addr[i] =
			(void *)get_zeroed_page(GFP_KERNEL);

The same applies to rx_queue[i].queue_addr/queue_dma and
buffer_list_dma[i]. Wouldn't the old page, the coherent RX ring, the DMA
mappings and the pool buffers for that index be leaked?

The live path guards against this in ibmveth_scale_up_rx_queues():

		if (adapter->queue_handle[i]) {
			/* Left by a failed H_FREE; close frees it. */
			netdev_err(netdev,
				   "RX queue %d still held by PHYP, reset pending\n",
				   i);
			rc = -EBUSY;

Should the down path apply the same queue_handle[] check before
publishing a larger count? Before this patch, an RX count change while
down returned -EOPNOTSUPP, so this path was not reachable.

[ ... ]

> @@ -4203,9 +4296,14 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
>  static void ibmveth_poll_controller(struct net_device *dev)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(dev);
> -	unsigned int num = ibmveth_get_num_rx_queues(adapter);
> +	unsigned int num;
>  	int i;
>
> +	if (!adapter->opened)
> +		return;

[Severity: Low]
This reads adapter->opened as a plain bool from netpoll context. That
context can run concurrently with direct ibmveth_close()/ibmveth_open()
calls from ibmveth_change_mtu() and veth_pool_store(), which don't call
netpoll_poll_disable().

The writers are plain stores as well:

ibmveth_open():
	adapter->opened = true;

ibmveth_close():
	adapter->opened = false;

Isn't this an unannotated data race that KCSAN would report? Could the
accesses use READ_ONCE()/WRITE_ONCE(), or smp_store_release() and
smp_load_acquire()?

The close side looks fine, because opened is cleared before
synchronize_net() and netpoll runs with IRQs disabled or under RCU-bh.

On the open side, though, nothing explicitly orders the queue, pool and
NAPI setup before opened = true. Today it relies on the replenish_lock
unlock in open and on the acquire of num_rx_queues in the reader. Would
it be worth making that pairing explicit, so that reordering open()
later can't break the guard?

>  	for (i = 0; i < num; i++)
>  		ibmveth_replenish_task(adapter, i);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790319558.git.mmc%40linux.ibm.com

