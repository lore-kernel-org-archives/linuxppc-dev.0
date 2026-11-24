Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3382606A32D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcO1jkNN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYc7J3JHkz2xf8;
	Tue, 24 Nov 2026 19:54:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795510460;
	cv=none; b=d2pvnx43DcMzJMVMpF+AnmO0Hl7GJPiVqkJj60qCZIbj8cAJf0doJGAg0xV4XElTwmjPK3FpXy6p3WRiYlA1V8zkRQFCy9Mr5nn9n4bZrregN9ZiedoQvjbzzyvP25Xy7vH0t2KYnNz6LzbseNm1IDHpkXO6E//1b95hid1+nkd7UIgRLk5iANCh2g9Sqh5/2bo1YcRuTg9uyt0mPJacAiDxUG6rPjtsxjuvoy0qo+ASgpoIdwxl/jFtJLodh/VRNRsbB4rZbVxW2pjcwamFAnSEJEjHKyXi/16WK3FdxH4yfVM5z5F0mZ8+982eopTM2It3bJnF5K/9ya2aHckHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795510460; c=relaxed/relaxed;
	bh=iS94JK1jOdY+h44hOhoK83b/1UtofAXx+07J9jYlskE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F+zhU4qyGoAQWzccid2JN9JG+dMZ3nQjnBe5whgt4gkvxK+netP+/TsUFuUbka+Y5E3jc89Wp04m/uXzeVdFelMa+x3KhkWaogJjQ6G55Y2VA0DDUQww5GO1ybOt9rBOYacVnc6N9KdmphfcUzEaAlse1w0QjeZ8cAV456JOORDbued+pw7dQW6KQbJwyJqBvkIUIxDTitts6os7cQNJARxSCn3mNINQxO+n4UQgMx1ayRcPQeN8d5m95IkO3ZsR5lyRANcsLWUiYH20eizThaN5NevypleRvCjPeH691a0VWXSI4EA6q0xhkzXYt79EUYa0AD0RXbwe2K/xF9exMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcO1jkNN; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcO1jkNN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYc7H3PTZz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 19:54:19 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8D976623DB;
	Tue, 24 Nov 2026 08:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F381D1F000D1;
	Tue, 24 Nov 2026 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795510456;
	bh=iS94JK1jOdY+h44hOhoK83b/1UtofAXx+07J9jYlskE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bcO1jkNNiQfwNBX5PYZwMsqbeJKPp+Wdm6kJV3MuYvIyUdvvFmW+17OQUTeQU574B
	 yOJ2pSFaMEH1SA07iIvzo5hksFfHunkS25Xq/Yq0NeJ7h3zEjFZY/w02n7dV03ulP4
	 53n/pJtDuoapKZTjy2XXDXojidfM6ONG0XDP+GJk6SgPjaPHUNcFJ2z+FSWa/cyX5X
	 NIiiGpvMHmgdOl/zGyol0kjzLoYlfB9zKEvjePurtp2prwonfW5yx8/xMcDWjBSNdE
	 Hl8JA+eH/F5PSfSKTJLAERH7vmYnAv8Q3g36zjyxGdLTK5Pgm0MoQmAt73fWBmx33b
	 4cBTZ1l+EOfVQ==
Subject: Re: [PATCH net-next v2 5/8] ibmveth: Refactor TX resource allocation
 in open/close paths
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, horms@kernel.org, davemarq@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Tue, 24 Nov 2026 08:54:14 +0000
Message-ID: <179551045457.3135.17656003339909508108@kernel.org>
In-Reply-To: <20261123075136.3278-6-mmc@linux.ibm.com>
References: <20261123075136.3278-6-mmc@linux.ibm.com>
X-sashiko-severity: Low
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In ibmveth_open() (drivers/net/ethernet/ibm/ibmveth.c, lines
  1194-1199), the commit "ibmveth: Refactor TX resource allocation in…

--

ibmveth: Refactor TX resource allocation in open/close paths

This moves TX LTB allocation and freeing out of ibmveth_open() and
ibmveth_close() into new ibmveth_alloc_tx_resources() and
ibmveth_free_tx_resources() helpers. The TX LTBs are still mapped before
RX buffers are handed to PHYP. TX queues are now started under
netif_tx_lock_bh().

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index ea0e5158040cb..06741a6756b88 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1147,7 +1191,12 @@ static int ibmveth_open(struct net_device *netdev)
>  	netdev_dbg(netdev, "initial replenish cycle\n");
>  	ibmveth_schedule_rx_queue(adapter, 0);
>
> +	/* netif_tx_lock() takes each txq lock, so a sender that then sees
> +	 * DRV_XOFF clear under its txq lock also sees the LTBs set up above.
> +	 */
> +	netif_tx_lock_bh(netdev);
>  	netif_tx_start_all_queues(netdev);
> +	netif_tx_unlock_bh(netdev);

[Severity: Low]
The commit message does describe this change. It is a behaviour change
justified as an ordering fix, though, and it sits in a patch titled as a
refactor with no Fixes: tag. Would it be better sent as a separate patch
with its own Fixes: tag?

The change in ibmveth_open() looks correct on its own terms.
netif_tx_lock() goes through netif_freeze_queues(), which takes and
releases each txq _xmit_lock. That gives senders the pairing the comment
describes.

The new comment sets a rule that the driver's other LTB publish path does
not follow. ibmveth_set_channels() runs while adapter->opened is true. It
publishes new tx_ltb_ptr[] entries and clears DRV_XOFF without taking
netif_tx_lock or any txq lock:

drivers/net/ethernet/ibm/ibmveth.c:ibmveth_set_channels() {
    ...
	netif_tx_stop_all_queues(netdev);

	/* Allocate any queue that we need */
	for (i = old; i < goal; i++) {
		if (adapter->tx_ltb_ptr[i])
			continue;

		rc = ibmveth_allocate_tx_ltb(adapter, i);
    ...
	rc = netif_set_real_num_tx_queues(netdev, goal);
    ...
	netif_tx_wake_all_queues(netdev);
    ...
}

The sender side then reads the new pointer in ibmveth_start_xmit():

	memcpy(adapter->tx_ltb_ptr[queue_num], skb->data, skb_headlen(skb));

By the reasoning in the new comment, an ethtool -L that grows the TX queue
count on an open device would leave the same gap for the new queues. A
sender on another CPU could see DRV_XOFF clear and still read a stale NULL
tx_ltb_ptr[i]. In practice this is only a load-load reordering, and a lot
of work happens between the LTB store and the wake, so no failure has
been shown.

Should ibmveth_set_channels() get the same netif_tx_lock treatment? If
not, does the lock in ibmveth_open() need the justification given in the
comment and the commit message?

The set_channels code is older than this patch, and nothing in it changes
here.

>
>  	adapter->opened = true;
>  	netdev_dbg(netdev, "open complete\n");

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123075136.3278-1-mmc%40linux.ibm.com

