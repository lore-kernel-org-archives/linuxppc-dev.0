Return-Path: <linuxppc-dev+bounces-28870-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22F0CA5FE4
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 02:13:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hy5dr0jbPz30RN;
	Sun, 04 Oct 2026 13:13:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791079983;
	cv=none; b=mvJiQcz2SIOoOPHpaT3jc9LQy974OmZoxWdCQyKWTXnRXdvD1ixZV5gXe2dmV1Xn0KGn2JbGvkgWVDu8l5ebEgFhJCZTAqM4UB4ajIw1FAAJvmmcyUb5OSfhc9+7kZSdOA0r464ZY6Y9Kc/EJ+8AlSYPORlcYxeia3rX75M7V++Hn2zmtFdkiF3dVp8++LAohA12I+Le3VBaE+wuxDE73Ko2cfqkjsQ6f1LO/EuMuZlSE5/2bgXc3MNI1jMCXej+ot3FgqqHPAJ9k9SyiZMyL27gvs0wnnRSOx9xv6YX0QoT6Ta9J+GgRAwRNIgj5EXJ+qo6HC6aym9rf0GIAnrOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791079983; c=relaxed/relaxed;
	bh=16l66Uzb8+XvEx8M4vY8FEkREMfnLp+3Kdb9Sqc3ZAs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lCmrNjEYQuZtb7xUThhnM5EnThvlwTheBoD9kiUYu0dTHxF6jQVypG66qtxU7nMsMI399HzjPYU9a0uFqT0kEOYzMJKIHlT+bA8LUfkmJQEVMJ68rGrVLVslkBSPy+OG3aSEO0e3VlgC6jl7xCW+psp77R9cptZNnkAEBdydtI40Pesp4QWEQU8hXV7lvvPO32S39FJDoZg2or2Ts7Rr3LV2JlGRKI/q6q1y19FNGBlE9/ddbVEnfwe85FJwmsZF9BQvro0IMDj0jqzcJC9I3dQLNRvUvfum4x1NQac6hpf3LZse6sysBu1tTBBjxd45TqAXNa8flEk61qFPEyCi7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYSPumFT; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYSPumFT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hy5dn5dSlz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 13:13:01 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9616360052;
	Sun,  4 Oct 2026 02:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6101F0089B;
	Sun,  4 Oct 2026 02:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791079978;
	bh=16l66Uzb8+XvEx8M4vY8FEkREMfnLp+3Kdb9Sqc3ZAs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oYSPumFTA7i98EAHE4csXPxrTukm9EyCmwVPyNW4HeyKW1oNpTBHfwBRaw1zQwnUU
	 YbXcJizX2fJiOrkph3bUgSVy4agx77Z3FnP5k1euRqjDJYvx+fS8/dkG2WofgnN1rJ
	 lSOIH+W1+aIS1WV/VgbtN3o8EwqokS5ZVnLT+XoNzqR1T2YjkjS5fHAbEuIWyNDfLB
	 CtZRM6hxHMG79bhk+tysjTUrlWpD1B4WC6XdGgdMMBUknWpy4kncbqCCzviooxKBwc
	 kHn9EDRKPtTaGkatg4hsR5gAqAzZsOhKDHpqYiLmQN+HAsEhXK1rfnTzWaHWjmYxWN
	 KV4gdrh0hS5BA==
Subject: Re: [PATCH net-next 4/7] ibmveth: step past bad RX correlators
 instead of spinning or oopsing
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com
Date: Sun, 04 Oct 2026 02:12:57 +0000
Message-ID: <179107997707.434549.11109515809612717921@kernel.org>
In-Reply-To:
 <14aa52f296c474726c049efc6b5a045187c45868.1790991039.git.mmc@linux.ibm.com>
References:
 <14aa52f296c474726c049efc6b5a045187c45868.1790991039.git.mmc@linux.ibm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new bad-slot handling in ibmveth_poll()
  (drivers/net/ethernet/ibm/ibmveth.c) neither charges consumed error…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but:
  ibmveth_poll() uses the PHYP-written descriptor length…

--

ibmveth: step past bad RX correlators instead of spinning or oopsing

This patch adds a helper that validates the RX correlator returned by
PHYP. The helper also rejects inactive pools that have no skbuff array.
On a bad slot, the RX ring now advances, the drop is counted in
rx_dropped, and a reset is scheduled. WARN_ON() is replaced with a
ratelimited netdev_err(), and the KUnit cases are extended to cover
these paths.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 77d3740cc52a6..b89ce389d951f 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1468,6 +1503,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  	int frames_processed = 0;
>  	unsigned long lpar_rc;
>  	u16 mss = 0;
> +	int rc;
>  
>  restart_poll:
>  	while (frames_processed < budget) {
> @@ -1490,8 +1526,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  			__sum16 iph_check = 0;
>  
>  			skb = ibmveth_rxq_get_buffer(adapter);
> -			if (unlikely(!skb))
> +			if (unlikely(!skb)) {
> +				ibmveth_rxq_advance(adapter);
> +				netdev->stats.rx_dropped++;
>  				break;
> +			}

[Severity: Low]
The ring now moves past the bad slot. Should this consumed entry also
count against the NAPI budget, and should the loop continue here rather
than break?

frames_processed is not incremented here or in the two harvest error
branches below. The break goes to the tail of ibmveth_poll():

    ibmveth_replenish_task(adapter);

    if (frames_processed == budget)
        goto out;

    if (!napi_complete_done(napi, frames_processed))
        goto out;

    lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
    ...
    if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
        lpar_rc = h_vio_signal(adapter->vdev->unit_address,
                               VIO_IRQ_DISABLE);
        goto restart_poll;
    }

With a run of N bad correlators, one poll call would then do N
replenish passes and 2N hcalls but report 0 work. This all runs on the
CPU where schedule_work() has just queued the reset.

A bad correlator never decrements pool->available. That means the burst
is only bounded by how many buffers are posted to PHYP, about 1024 with
the default active pools.

Documentation/networking/napi.rst says the budget "limits how many
packets driver can process in a single poll". Would it bound this work
to count the consumed error descriptors in frames_processed and use
continue instead of break?

>  
>  			/* if the large packet bit is set in the rx queue
>  			 * descriptor, the mss will be written by PHYP eight
> @@ -1515,12 +1554,19 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  				if (rx_flush)
>  					ibmveth_flush_buffer(skb->data,
>  						length + offset);
> -				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
> +				rc = ibmveth_rxq_harvest_buffer(adapter, true);
> +				if (unlikely(rc)) {
> +					dev_kfree_skb_any(new_skb);
> +					netdev->stats.rx_dropped++;
>  					break;
> +				}
>  				skb = new_skb;
>  			} else {
> -				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, false)))
> +				rc = ibmveth_rxq_harvest_buffer(adapter, false);
> +				if (unlikely(rc)) {
> +					netdev->stats.rx_dropped++;
>  					break;
> +				}
>  				skb_reserve(skb, offset);
>  			}

[Severity: Medium]
This isn't a bug introduced by this patch, but the correlator from PHYP
is now validated. Should the length and offset from the same descriptor
be checked as well?

ibmveth_rxq_frame_length() returns the raw be32 length as an int.
ibmveth_rxq_frame_offset() can return values up to IBMVETH_RXQ_OFF_MASK
(0xFFFF). ibmveth_poll() does not check either one against the source
pool's buff_size, which is 512 bytes for pool 0.

The copybreak branch does this:

    skb_copy_to_linear_data(new_skb,
                            skb->data + offset,
                            length);

If offset is close to 0xFFFF, can this read up to about 64 KiB past the
RX buffer and then hand that data up through napi_gro_receive()?

The non-copybreak branch does this:

    skb_reserve(skb, offset);
    ...
    skb_put(skb, length);

This path has no tailroom check. Could an oversized or negative length
reach skb_over_panic() -> BUG() in softirq?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790991039.git.mmc%40linux.ibm.com

