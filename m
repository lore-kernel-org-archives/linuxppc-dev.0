Return-Path: <linuxppc-dev+bounces-29072-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3024CA6017
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 21:08:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j12fV0R4Xz2yHD;
	Fri, 09 Oct 2026 08:08:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791493729;
	cv=none; b=CO0Xa4kpONiIEPCeIodAVtXBGyOfGNbCL5z+5Jtr/SnjrGUxTv23Lbs6NZ5bsg68ef2WP0d3Y5qgatb/bRgIg4h1sHVO3mquNJegf58o2kjE3jW4BPlnA6c29PRT05903sZzBS3pXJd/SKCEkLl0t56gmrxMLvatUEu4wCOEP9UbYXe4BXerBNKKxUDWG5CmeiSVmi4xAHgzpr3xs2aoBKKYc+55ZxAms9BhLwPaO0akScid+VfkPldXi8tlvvdKIVL0+IktZEoYhI/XOV73kM7z2XdxGlbd/mkPgStMHgKDi1mxrp12U3a3uGvzLmhVlY0/6Wo6zL9f2fIMrl0ExA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791493729; c=relaxed/relaxed;
	bh=udzqviPeQAmd4a3ztX+c5gHSOwTCz3cVPXAnwWZa3Vg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JOgTXhfAn9DpHPu6Ul16XdxhSPWqjpF+QchcIHioNKFxwCF0g8XbH0A82jEow1BlHdixPq/zDAd68gVdJItrWNc6idpi1lvblDMCTNoxV21KIDzH6Ev22RLxaJtj47wEXV4PLPfJzsIHPb5AAGcoM+agXb4QmxmeGW/lEP+j1kJNPKORNClQwT4ttgWFM0U46DRrKIxUp7PJxpdirBB2R3yYlHSqni450RHHgUkP8Z4UIRUcTVNgvuiMlAX+jyQDt3y7EPlyCRp81F3TrNpuulSgxFi7NhL0TxNUA37NxYMM6ewPvh0cQ2aIxr754XPjCES8jNpP3sWjsZhy9g4rsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oi3LJxQX; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oi3LJxQX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j12fS06ZSz2y32
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 08:08:47 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0C77B600CB;
	Thu,  8 Oct 2026 21:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2351F000FF;
	Thu,  8 Oct 2026 21:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791493724;
	bh=udzqviPeQAmd4a3ztX+c5gHSOwTCz3cVPXAnwWZa3Vg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Oi3LJxQXCiDGwxIaOEPewZVHnK0sF3DVFnUviceDAtpul8LjQet7WAMFMW8UexlWT
	 6SELdLLOHw0KoVoC1IdjymseZd/56u8koqFjyAqy9miu1f8IoSJoOfeQw+Cw2juQcy
	 bnFcR/mW9bhq4ii425JHaWdfKdNPePXd+l4gwxkU6WNtcQ2qxY34tCZ/8iADgBVezf
	 1TWkl7kgAbFn/7y0T3YyndOBwoYskkhq9iGDNEbHnFKgMBrVAbnlS0NCwm8xkvEK7X
	 vmz/bHQRcDxq6ZFf+iCf6seUppB+/DASdwEO59fHIKtqcqs1HCNehcjNcShNnpU+oo
	 iz7olbmjWC/3A==
Subject: Re: [PATCH net-next v2 4/8] ibmveth: step past bad RX correlators
 instead of spinning or oopsing
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 stephen@networkplumber.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 21:08:43 +0000
Message-ID: <179149372321.434549.3176990477501610987@kernel.org>
In-Reply-To:
 <26003e69cff6824798d289d67c163f868bfbefc1.1791178212.git.mmc@linux.ibm.com>
References:
 <26003e69cff6824798d289d67c163f868bfbefc1.1791178212.git.mmc@linux.ibm.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: NAPI list corruption and panic on bad RX correlator

Pre-existing issues:
- [Medium] Not introduced by this patch, but ibmveth_poll() takes the
  frame offset (flags & IBMVETH_RXQ_OFF_MASK, up to 0xFFFF) and length…

--

ibmveth: step past bad RX correlators instead of spinning or oopsing

This patch moves RX correlator validation into one helper. The helper also
rejects pools that have no skbuff array, such as inactive pools. On a bad
slot, ibmveth_poll() now advances the RX ring, counts the drop in
rx_dropped and schedules a reset, and it logs with a ratelimited
netdev_err() instead of WARN_ON(). The patch also adds and extends KUnit
cases for these paths.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index d269599f5a990..3bac6cabbbb4c 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1515,12 +1556,19 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
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
>  

[Severity: High]
Now that the ring is advanced before each of these break statements,
can ibmveth_poll() leave the loop with descriptors still pending and
go down the completion path before the budget is used up?

After the break, frames_processed is below budget, so poll calls
napi_complete_done(), re-enables the interrupt with h_vio_signal() and
then finds ibmveth_rxq_pending_buffer() true for the next slot. It
calls napi_schedule() and jumps to restart_poll without resetting
frames_processed.

If the restarted loop then uses the rest of the budget, ibmveth_poll()
returns budget after it has already rescheduled itself. The NAPI core
expects a driver that consumes its whole budget to leave the NAPI
state alone.

In net_rx_action(), __napi_poll() catches this and only prints the
"Budget exhausted after napi rescheduled" warning. However,
busy_poll_stop() calls __napi_schedule() whenever poll returns
budget. Would that put napi->poll_list on the per-CPU poll list a
second time and corrupt it?

A burst of traffic right behind a single bad correlator would be
enough to get there.

The !ibmveth_rxq_buffer_valid() recycle path already keeps looping
after it harvests a slot. Now that the ring is advanced on every
error, is there still a reason to break here rather than continue
with the next slot?

The same restart_poll sequence can already return budget today if a
burst arrives right after the interrupt is re-enabled. Should the
restart also avoid returning the full budget once napi_schedule()
has succeeded?

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. The patch
hardens ibmveth_poll() against bad correlators from PHYP, so should the
frame offset and length from the same RX descriptor be checked as well?

ibmveth_poll() reads both values straight from the queue entry:

    int length = ibmveth_rxq_frame_length(adapter);
    int offset = ibmveth_rxq_frame_offset(adapter);

offset is flags_off & IBMVETH_RXQ_OFF_MASK, so it can be up to 0xFFFF.
length is a full be32. Neither is compared against
rx_buff_pool[pool].buff_size.

On the rx_copybreak path:

    skb_copy_to_linear_data(new_skb,
                            skb->data + offset,
                            length);

Can this read past the end of the RX buffer? If so, nearby heap memory
would be copied into a packet that is passed up the stack.

On the non-copybreak path:

    skb_reserve(skb, offset);
    ...
    skb_put(skb, length);

If offset + length is too large, would this reach skb_over_panic() and
BUG() in softirq context?

As with the bad correlator case, this can only happen if PHYP reports an
offset or length larger than the buffer it was given.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791178212.git.mmc%40linux.ibm.com

