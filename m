Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD36606A8B0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 23:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cxy5gC43
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQckX0Vhvz30WS;
	Fri, 13 Nov 2026 10:57:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794527827;
	cv=none; b=DnyzqQmYjnlH/MEMFT214wBr8MoOys0VTz0PsoT9Nr37fdb48ZBIQfbxjtEiDcvwwv8ilY7pFXCTrBK8o5cOeTsv1A/WnAIq4qxEuzs0YLWUNuccxs0ndBq7Eyt52q+gGTWsbb9XUTJN1hldnlalUceKw13/dFvIpJt5fe9HdyRQciUCYDNE+aSMxh3rEJ9W5GWGbZYhP01HfHmCo2Xu38f/7vqKQJ6Z7znSzysJOEIF2F8JtVnZEClUmPuTXB28204SyKHmpEwu9Lm/DXM0mE3IQby+apIDu2LZVXlUpkjxsD/8jteouRx8miyMkU/IcBU5kGMexWf3YINa+5IWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794527827; c=relaxed/relaxed;
	bh=bkTBVjfmsLTYAtJp+mcX3wQqhGIKnbZRF44NSEvyCeo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EOI+VIZa9I79hXPOntDhb4FHNNgT2HcjsnqOG6Yk4cQqZK3lXRgkSJXzvwT+kgY0RzyhqxMUw+t7z8mZZQj/HDzU6qL7rMgRJLDkFJoX0B7slANkeTMgL2rjP/BhQJiIcx0sxKV9OK72D3bCisjephydwJVgN/aycgE0kn5zcDHJniO0RbHgGIFaVYOKPTYEEoHQ2toq8RwHG5AMz3/34QzhXromZFKq57comhnnhvrSwJ9HWJ7YfgXEokgjK8PopMl4h+7oBZ+Neo6l1QeLZPMYGhuR7reG3EYSJMXP5A+kgvRKVJ7YuuGHz9Cn7y+PayYXF15275OD53aWaDi4GQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cxy5gC43; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cxy5gC43;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQckV6Pp1z30C6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 10:57:06 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7D83461149;
	Thu, 12 Nov 2026 23:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBEB1F000C5;
	Thu, 12 Nov 2026 23:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527824;
	bh=bkTBVjfmsLTYAtJp+mcX3wQqhGIKnbZRF44NSEvyCeo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cxy5gC43KuICfUriaDdF12tFBcRvOR5tupQEh25n+k3JgJclesg4m+yDqu1Ah9Fxg
	 BvH3NKUpuYHUXvKpvrSyYfReo+pKAdn+/HoUliyRfQfNXgaZ6iqwYCK+st2U0JW17W
	 +/IP3/BO8z2GNNi16G7DnEsRqAGwejsYAyxh01qUcLlhT85wEwne/vu7KTGF5vn0Fp
	 +tXwPDu5JOBprIGP4by8ugrGwB/FhzS/IjGSS5jEXtOmol5/pzZSN1mfKuO9jl3DaT
	 vCVIWDlMHx02D7a5dMpEKoKfPw/WyYqLDJVQrcIayG1s7ZrTJLMReSv8g+9DWFKvEE
	 bpG3y/pkd3kyw==
Subject: Re: [PATCH net-next v8 06/15] ibmveth: Refactor TX resource
 allocation in open/close paths
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Date: Thu, 12 Nov 2026 23:57:02 +0000
Message-ID: <179452782258.2199510.1384176100068608942@kernel.org>
In-Reply-To: <20261109235556.60604-7-mmc@linux.ibm.com>
References: <20261109235556.60604-7-mmc@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch is titled 'Refactor', but it also carries the only
  fix for a NULL-pointer dereference that already exists in the base…
- [Medium] ibmveth_open() now allocates the TX LTBs (line 1432) after
  h_register_logical_lan, ibmveth_alloc_buffer_pools(),…
- [Medium] The patch makes a non-NULL tx_ltb_ptr[idx] mean 'this LTB is
  usable'.

Pre-existing issues:
- [Low] Not a real bug for the scenario described (baseline decision:
  false).
- [Low] Resolved later in the series (baseline decision: false).

--

ibmveth: Refactor TX resource allocation in open/close paths

This patch moves TX LTB allocation and freeing in open() and close() into
the new ibmveth_alloc_tx_resources() and ibmveth_free_tx_resources()
helpers. It also moves the TX allocation to the end of open(), after RX
is live. It adds netif_tx_disable() at the start of open(), and adds a
check in ibmveth_start_xmit() that drops packets when tx_ltb_ptr[] is
NULL.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 62e6c9a9f5e91..cab895cc970c5 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> +/* Caller must ensure tx_ltb_ptr[idx] is NULL. open() runs on
> + * probe-zeroed slots; set_channels() skips populated indices.
> + */
>  static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>  {
>  	adapter->tx_ltb_ptr[idx] = kzalloc(adapter->tx_ltb_size,
> @@ -1277,12 +1287,54 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>  			   "unable to DMA map tx long term buffer\n");
>  		kfree(adapter->tx_ltb_ptr[idx]);
>  		adapter->tx_ltb_ptr[idx] = NULL;
> +		adapter->tx_ltb_dma[idx] = 0;
>  		return -ENOMEM;
>  	}

[Severity: Medium]
ibmveth_free_tx_ltb() now takes a non-NULL tx_ltb_ptr[idx] to mean the
LTB is usable, and the new check in ibmveth_start_xmit() depends on that.
Does ibmveth_allocate_tx_ltb() follow the same rule?

It stores the kzalloc() result in tx_ltb_ptr[idx] before tx_ltb_dma[idx]
is mapped. On the map failure path it calls kfree() before it clears the
slot.

The stale sender that the new guard is meant to catch could hit these
windows on a later grow. After a shrink, netif_tx_wake_all_queues()
leaves the freed index j without DRV_XOFF. If ethtool -L then grows the
queues, ibmveth_set_channels() does this:

	netif_tx_stop_all_queues(netdev);

	/* Allocate any queue that we need */
	for (i = old; i < goal; i++) {
		...
		rc = ibmveth_allocate_tx_ltb(adapter, i);

The grow path has no synchronize_net(). A stale sender that already
passed the DRV_XOFF check could see a non-NULL tx_ltb_ptr[j] and
memcpy() into it. It could then put tx_ltb_dma[j] == 0 into the
H_SEND_LOGICAL_LAN descriptor, or write into memory that the map failure
path is about to kfree().

The grow-failure free loop in ibmveth_set_channels() also frees the slots
it just allocated without waiting for a grace period.

Would it be safer to allocate and map into local variables, and publish
tx_ltb_ptr[idx] last with WRITE_ONCE() or a release store? On failure,
the slot could be cleared before kfree(), and ibmveth_start_xmit() could
read the pointer and the DMA address once each.

[ ... ]

> @@ -1373,26 +1424,36 @@ static int ibmveth_open(struct net_device *netdev)
>  	 */
>  	rc = ibmveth_setup_rx_interrupts(adapter);
>  	if (rc)
> -		goto out_free_buffer_pools;
> +		goto out_unregister_lan;
>  
>  	netdev_dbg(netdev, "initial replenish cycle\n");
>  	ibmveth_schedule_rx_queue(adapter, 0);
>  
> +	rc = ibmveth_alloc_tx_resources(adapter);
> +	if (rc)
> +		goto out_cleanup_rx_interrupts;

[Severity: Medium]
Can a TX LTB allocation failure here now free RX buffers that PHYP still
owns?

By this point ibmveth_schedule_rx_queue(adapter, 0) has posted RX skb DMA
addresses to the hypervisor. If kzalloc() or dma_map_single() fails in
ibmveth_allocate_tx_ltb(), open() jumps to out_cleanup_rx_interrupts and
falls through into:

out_unregister_lan:
	do {
		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
	ibmveth_free_buffer_pools(adapter);
out_free_queue_mem:
	ibmveth_cleanup_rx_resources(adapter);

Any H_FREE_LOGICAL_LAN result other than busy is ignored. The posted RX
skbs are then unmapped and freed, and so are the RX ring and the buffer
list pages. If the H_FREE failed, could PHYP still DMA inbound frames, or
the buffer list drop counter, into pages already returned to the
allocator?

Before this patch, TX allocation ran before LAN registration, so only
close() had this window.

The commit message says a later patch keeps this memory mapped on a hard
failure. At the end of the series, though, ibmveth_free_all_queues() only
returns -EIO in multi-queue mode:

	if (lpar_rc != H_PARAMETER && adapter->multi_queue)
		return -EIO;

so single-queue mode would still free the posted buffers on this path.

Does TX LTB allocation need to move after the replenish kick? Since
ibmveth_alloc_tx_resources() unwinds its own partial failure, it could
probably stay before h_register_logical_lan(), or at least before
ibmveth_schedule_rx_queue().

[ ... ]

> @@ -1864,6 +1923,14 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
>  	int i, queue_num = skb_get_queue_mapping(skb);
>  	unsigned long mss = 0;
>  
> +	/* TX LTBs are freed on shrink; a sender that picked its queue
> +	 * before the shrink can get here after the free.
> +	 */
> +	if (unlikely(!adapter->tx_ltb_ptr[queue_num])) {

[Severity: Medium]
Does this check fix a NULL pointer dereference that is already in the
base tree?

On a TX shrink, ibmveth_set_channels() frees the dropped LTBs and then
wakes every queue, including the freed indices:

	for (i = old; i > goal; i--) {
		if (adapter->tx_ltb_ptr[i - 1])
			ibmveth_free_tx_ltb(adapter, i - 1);
	}

	netif_tx_wake_all_queues(netdev);

Some senders can still have a queue_mapping that points at a freed
index. One is AF_PACKET with PACKET_QDISC_BYPASS, preempted between
packet_pick_tx_queue() and dev_direct_xmit(). Another is pktgen reusing
a cloned skb. In the old ibmveth_start_xmit(), such a sender reaches the
memcpy() into adapter->tx_ltb_ptr[queue_num] with a NULL pointer.

If so, could this check be sent as a separate minimal patch for net,
with a tag like the following?

Fixes: 10c2aba89cc0 ("ibmveth: Ethtool set queue support")

Right now it sits inside a refactor in the middle of a net-next series,
along with the open() reorder and the RX helper dependencies, so it
can't be backported on its own.

Also, the commit message says:

  a sender already in xmit during the free is not covered, as before
  this series.

Isn't that sender already drained on the shrink path? When queues are
being disabled, netif_set_real_num_tx_queues() calls synchronize_net(),
and ibmveth_set_channels() calls it before the free loop. What remains is
a stale sender that arrives after netif_tx_wake_all_queues(), and that
is the case this check catches.

[Severity: Low]
This is a pre-existing issue and wasn't introduced by this patch. The
lockless read of tx_ltb_ptr[queue_num] here pairs with plain stores in
ibmveth_free_tx_ltb() and ibmveth_allocate_tx_ltb().

A sender already in flight can't overlap a shrink-time free, because
netif_set_real_num_tx_queues() calls synchronize_net() before
ibmveth_set_channels() frees the LTBs. Should these accesses still use
READ_ONCE() and WRITE_ONCE() to mark the data race?

> +		netdev->stats.tx_dropped++;

[Severity: Low]
This isn't a bug introduced by this patch, since the other drop paths in
ibmveth_start_xmit() do the same thing. Still, netdev->stats.tx_dropped++
is a non-atomic update of a device-wide counter. ndo_start_xmit can run
on several TX queues at once, so increments can be lost.

The later patch in this series, "ibmveth: Add per-queue RX and TX
statistics collection", replaces this with
IBMVETH_STAT_INC(txs->dropped_packets) on the per-queue counter, which
the queue's xmit lock serializes.

> +		goto out;
> +	}
> +
>  	if (ibmveth_is_packet_unsupported(skb, netdev))
>  		goto out;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235556.60604-1-mmc%40linux.ibm.com

