Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E01B606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 01:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P06DhByh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXnnk2WCLz30g6;
	Mon, 23 Nov 2026 12:06:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795395978;
	cv=none; b=gqZ90Xv/pdpM6vQY+r8OPoI1s/a44XC5rS0z8lWOoAKS0ql4+YA87ZRXXqXQGwVSU0Ymt7KR11T7gbkSbwmgUKACtgBpd2tk9R+jFjEZ24G4GwXqOIEUHYcqCOFDphZkiuB9o+OkOJVjSJIgV5spkcpt+fLW8KWvmytVF+uYb4GusBdLaXtbSSYjkEuXxQ+Tfh+HhFfzXiDRj7vFx3obpZLTG0MHRwZli+drbTgup5cfs9w+TCjGDuumqLI0T8CiOKiyBrJyBgOZlBWxdjFQK0SJ2EqbDM99zx2N9KliIjS3yK4eSic0w0XvnnUkd5FIRdQfvzXb+1REFfTMMuf1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795395978; c=relaxed/relaxed;
	bh=GT8u9eDgHjpLy1q95C+aJQ3RfZ/aTWtvLFOTauQjW14=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZOpIskmX6BzIgYreiKX2Pbv+4XnhU6hgrd5VdaN6n1mwsrvb2XXxYHIEWN6rbpmqvyoS3qxPXIwhQo2ulm8B6vMZvSq/defnUgOPEGvRB8Ry6UDosH9vzpYxGjwDNjWPLj/H56FZbG4MtHAfFgUeXVz8t4geFpRot5/RkiSt/LTbQdZ02EsbVD7qORFBTyurZx88Wximck2L5D5yBqdHLH2b8uhzM/w7EVMr3eG0+0ptD+tq0cRI5JZ1HINRiaiv7nvddSYoMHW+c2Qf8l8Toy29HuJR3KlR5tFdmIT+/fr7mdYSilFj6uC13aJlnnpmJvLybpep3fYagPL0I718sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P06DhByh; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P06DhByh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXnnj4SPhz3bZR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 12:06:17 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1F50D44D21;
	Mon, 23 Nov 2026 01:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CFE1F000C0;
	Mon, 23 Nov 2026 01:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795395976;
	bh=GT8u9eDgHjpLy1q95C+aJQ3RfZ/aTWtvLFOTauQjW14=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P06DhByhBLMb9DZoTx3L1qvZ5ZKjzu6QlCW6TGHKLNrAoqvIU3uouKFO1HQSMaeQr
	 Ju3+AIkPlAv5HBMkIkFs3JUuqnP099GraoLCtcxr6CSKOas3EPo8BWvWQfn/QlKDIj
	 Bjz9htPslbQCymHIaLVHA3Ddk98924TZwdEldEtYejJ3Pp6vT18hBN7SS/LsMx2f2n
	 BJs0ozXwIMHoOcMmPMqV8jEsXlaHLiteHrl+9z8sz2z1Tgr/5AnPT2TZdQq0pWEjCP
	 FdWf2GEjnIoW6LYgvAzypQiTdpeyFINHTOshcswh8e1jX80kiLQiaoRgDOdj0X60qR
	 DEOrZ5UPlRwZA==
Subject:
 Re: [PATCH net-next 8/8] ibmveth: Split RX poll into per-slot helpers for MQ
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, horms@kernel.org, davemarq@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Mon, 23 Nov 2026 01:06:14 +0000
Message-ID: <179539597459.3135.8252131963439580422@kernel.org>
In-Reply-To: <20261119000711.18093-9-mmc@linux.ibm.com>
References: <20261119000711.18093-9-mmc@linux.ibm.com>
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

- [Low] The helper ibmveth_poll_drop_oversize() in
  drivers/net/ethernet/ibm/ibmveth.c has a misleading name, and the…
- [Low] Two comments still name ibmveth_poll() as the place where per-
  slot RX handling happens, but this patch moved that code into new…

--

ibmveth: Split RX poll into per-slot helpers for MQ

This commit moves three pieces of per-slot RX handling out of
ibmveth_poll() and into new helpers: the invalid-slot recycle, the
bad-frame drop and frame delivery. The bad-frame error message now also
prints the queue index. Otherwise the commit intends no behavior change.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index a40d9a6abf51b..a36dafb8e8937 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1995,6 +1995,148 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,

[ ... ]

> +static void ibmveth_poll_deliver_frame(struct napi_struct *napi,
> +				       struct ibmveth_adapter *adapter,
> +				       struct net_device *netdev,
> +				       int queue_index, u64 correlator)
> +{

[ ... ]

> +	skb = ibmveth_rxq_get_buffer(adapter, queue_index, correlator);
> +	if (unlikely(!skb)) {
> +		ibmveth_rxq_advance(adapter, queue_index);
> +		netdev->stats.rx_dropped++;
> +		return;
> +	}

[Severity: Low]
This get_buffer failure branch now lives in ibmveth_poll_deliver_frame().
Are two comments elsewhere in ibmveth.c out of date as a result?

The kernel-doc for ibmveth_rxq_harvest_buffer_test() still says:

 * the toggle at the end. This covers the harvest path; the advance after
 * ibmveth_rxq_get_buffer() fails in ibmveth_poll() is not tested here.

ibmveth_poll() no longer contains that ibmveth_rxq_advance() call.

The kernel-doc for ibmveth_rxq_harvest_buffer() also still says:

 * Context: called from ibmveth_poll

Its direct callers are now ibmveth_poll_recycle_invalid(),
ibmveth_poll_drop_oversize() and ibmveth_poll_deliver_frame(). That one
is still roughly accurate, because these helpers are only reached from
ibmveth_poll(). The test comment, though, now names the wrong function.

> +
> +	pool = correlator >> 32;
> +	bpool = &adapter->rx_buff_pool[queue_index][pool];
> +	room = min_t(unsigned int, skb_tailroom(skb), bpool->buff_size);
> +	off = offset;
> +	len = length;
> +	if (unlikely(len < ETH_HLEN || off >= room || len > room - off)) {
> +		ibmveth_poll_drop_oversize(netdev, adapter, queue_index,
> +					   off, len, room, correlator);
> +		return;
> +	}

[Severity: Low]
This isn't a bug, but does the name ibmveth_poll_drop_oversize() fit
what this helper handles?

It is called when any of these three checks fail:

    len < ETH_HLEN || off >= room || len > room - off

Only the last check means the frame is too large. The first one catches
frames shorter than an Ethernet header. The second catches an offset
that lies outside the buffer.

The message inside the helper is already generic ("bad RX frame offset
%u length %u (buffer %u) on queue %d, dropping"). The commit message,
however, uses the same narrow wording as the helper name:

  Move the invalid-slot recycle, the oversize-frame drop and frame
  delivery out of ibmveth_poll() into helpers.

Would a name like ibmveth_poll_drop_bad_frame() be a better match?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119000711.18093-1-mmc%40linux.ibm.com

