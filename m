Return-Path: <linuxppc-dev+bounces-29355-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5507FCA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 10:58:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3rsP0CYRz3bxp;
	Tue, 13 Oct 2026 21:58:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791889080;
	cv=none; b=hHtnQyfvGhv9/FMVhLoqr24lNEFYTobpfwNM3vH+sDKzqBZpWgS1fDKbEzNDwn0e9LC3RSSSxkaNY4Tbt1sphW0GwuoY5FqCm6Sb+EcyTTM/XH+WnKIrOD/XwqoNShXKSFi75jXlwE4G37hdR1LEavWQp9wE2gON01unZg1g82omcQmdEKEiSZqAVoN8lvjOfUUQupAET86h91uDBHOCKfdpV3jH8O0FhOgQ3IsA7qrSJu7dvjUTzYSR21AlBHGLyQxi7gSTOwlah69tjgFXCqPTD0LQt0ZS0KpmeApNz0i1sLFiDxdI65tHvT4YI2CK3rNQerDI7K7uTGSK6ufstg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791889080; c=relaxed/relaxed;
	bh=QvPQmojfQvdSuKzFwSonxR1bfeKW0jigc5qUQGEDGRc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gIMamNtvyAD20iIGHhAbkWUToJGCsTy/mkNK87yL2fIWowuQo4VOtveh5oLtn9o5lIWCBzeUgqkXFcbIDOawwCt1yAhgMwJF2QhmFObyBpsUBJZ4S9Xzxor5A70vHX5+FagSyctNmWqfi+mjZBu4TFI6CaEJAxiEAs/sqXqX22k2mkkIpYIS7N3y3ZNuH+O6TGgrdx5jtupMC9ZY7kS19sOTF3AoGucw/RoZpVRVEcS++HsM4X+mfYTm6qWmFUSnWeLduJQKnPw4dX9R+80QT8miWivelrXY5zT3L4HPgw5djjq0bqb9kDTrUw/EX9iZN9WBrmIrdDd2FV2SEq7vEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtuHFFRO; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtuHFFRO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3rsM53DZz3bw9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 21:57:59 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AD58C60A66;
	Tue, 13 Oct 2026 10:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824E61F0089B;
	Tue, 13 Oct 2026 10:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791889077;
	bh=QvPQmojfQvdSuKzFwSonxR1bfeKW0jigc5qUQGEDGRc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dtuHFFROKKBVT90olJh3vQshzbvhEZIMKZJInp1SlLIZqBvMSYRGKp0k9GdEp+zR8
	 hqcia1+sB6J5fdOHUAMFr2WPYpSEDdHCTeLnCUdKJMNETK0izv1r96nZiwlKSpzglY
	 ScEbsQB5o6XcwiRVHqM+gBy5jLG4lIQ1PWSgrDFfEGjPMQpzCOdkbPFxB3Mpo2Chrs
	 MkvAqZaozczI8C1+/MFQ3BGdDnoaNecHCfQL1jL8MT1Daupb1XJRqGiwXh4peHKfvI
	 kLuNyeBn5vGN9taXByqxtg8SldmBQz1aow47h+ONF3DCje0QE9qocxALY3Lr3izKmK
	 Rx+z7+uPo0WIg==
Subject: Re: [PATCH v5 net-next 9/9] net: dsa: netc: add PTP one-step
 timestamping support
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, linusw@kernel.org, wei.fang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 13 Oct 2026 10:57:56 +0000
Message-ID: <179188907611.434549.18346411156046070175@kernel.org>
In-Reply-To: <20261012095924.1129312-10-wei.fang@oss.nxp.com>
References: <20261012095924.1129312-10-wei.fang@oss.nxp.com>
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

- [Low] The commit message does not describe the valid-window recovery
  that the code implements.
- [Low] The new one-step code reads the global jiffies_64 directly in two
  places.
- [Low] In netc_port_onestep_sync_enqueue(), the queue-full check
  (skb_queue_len(&np->onestep_queue) >= NETC_ONESTEP_QTH) jumps to…
- [Low] netc_port_enable_onestep() sets np->onestep_state =
  NETC_ONESTEP_IDLE without checking the current state.

--

net: dsa: netc: add PTP one-step timestamping support

This adds one-step Sync offload for NETC switch ports and advertises
HWTSTAMP_TX_ONESTEP_SYNC. The per-port PM_SINGLE_STEP register is shared,
so the tagger hands each one-step Sync to the switch driver. The driver
queues them and sends them one at a time from a work item using a To_Port
subtype 3 tag. Lost responses are recovered through tstamp_timeout_work
and a 2^30 ns validity window.

> Since
> the tag timestamp is only 30 bits wide and the hardware accounts for a
> single wrap at most, also schedule the work when the PTP time has
> advanced beyond NETC_ONESTEP_VALID_WINDOW since the in-flight frame was
> queued, as its correction field can no longer be computed correctly.

[Severity: Low]
This paragraph doesn't seem to match what netc_onestep_timeout() does. I
see three differences.

First, the check never reads the PTP clock. It compares jiffies_64 with
np->onestep_tx_time + 1 + nsecs_to_jiffies64(NETC_ONESTEP_VALID_WINDOW).
The code comment says this is on purpose, because the PHC may be stepped
backwards.

Second, np->onestep_tx_time is set in netc_port_onestep_work() just before
the frame is programmed and passed to onestep_sync_xmit(). It is not set
when the frame is put on onestep_queue.

Third, netc_onestep_timeout() is only called from
netc_port_onestep_sync_enqueue(). That means this check only resumes the
drain when a new Sync is enqueued. If no new Sync arrives, queued frames
wait for the 5 second tstamp_timeout_work.

Could the commit message be reworded to describe this?

> diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
> index 756c69a02064e..c3875bce80bc1 100644
> --- a/drivers/net/dsa/netc/netc_ptp.c
> +++ b/drivers/net/dsa/netc/netc_ptp.c

[ ... ]

> @@ -68,12 +96,286 @@ static int netc_get_ts_req_id(struct netc_port *np)
>  	return ts_req_id;
>  }
>  

[ ... ]

> +void netc_port_disable_onestep(struct netc_port *np)
> +{
> +	struct sk_buff_head free_list;
> +
> +	if (!dsa_port_is_user(np->dp))
> +		return;
> +
> +	__skb_queue_head_init(&free_list);
> +
> +	spin_lock_bh(&np->onestep_lock);
> +	skb_queue_splice_init(&np->onestep_queue, &free_list);
> +	np->onestep_state = NETC_ONESTEP_PORT_INACTIVE;
> +	spin_unlock_bh(&np->onestep_lock);
> +
> +	cancel_work_sync(&np->onestep_work);
> +	netc_tx_dropped_add(np->dp->user, skb_queue_len(&free_list));
> +	__skb_queue_purge(&free_list);
> +}
> +
> +void netc_port_enable_onestep(struct netc_port *np)
> +{
> +	if (!dsa_port_is_user(np->dp))
> +		return;
> +
> +	spin_lock_bh(&np->onestep_lock);
> +	np->onestep_state = NETC_ONESTEP_IDLE;
> +	spin_unlock_bh(&np->onestep_lock);
> +}

[Severity: Low]
Is it safe to set NETC_ONESTEP_IDLE here without checking the current
state? netc_port_enable_onestep() is called from both netc_port_enable()
and netc_mac_link_up(). The single-outstanding-frame rule for
PM_SINGLE_STEP depends on NETC_ONESTEP_IN_FLIGHT, and this write
discards it.

Take a link flap:

netc_mac_link_down()
  netc_port_disable_onestep()
    onestep_state = NETC_ONESTEP_PORT_INACTIVE
    cancel_work_sync(&np->onestep_work)
  netc_port_mac_tx_graceful_stop()

cancel_work_sync() only waits for the worker. A subtype 3 frame already
passed to dsa_enqueue_skb()->dev_queue_xmit() may still be in the conduit
qdisc, the ENETC TX ring or the switch port egress queue. The graceful
stop only drains the MAC TX FIFO.

netc_mac_link_up()
  netc_port_enable_onestep()
    onestep_state = NETC_ONESTEP_IDLE

The next Sync then reprograms PM_SINGLE_STEP while the older frame may
still be pending. Could the older frame go out with the new frame's
offset and checksum-update settings? Could it also get a wrong
correctionField if it waited longer than 2^30 ns?

A Sync sent between .port_enable and the first mac_link_up looks mostly
blocked, because phylink keeps carrier off until mac_link_up.

[ ... ]

> +	NETC_SKB_CB(skb)->tstamp = tstamp;
> +	NETC_SKB_CB(skb)->ts_req_id = ts_req_id;
> +	NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
> +	NETC_SKB_CB(dummy_skb)->ts_req_id = ts_req_id;
> +	NETC_SKB_CB(dummy_skb)->ptp_tx_time = jiffies_64;
> +	NETC_SKB_CB(dummy_skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
> +	np->onestep_tx_time = NETC_SKB_CB(dummy_skb)->ptp_tx_time;

[Severity: Low]
Should this be get_jiffies_64() instead of a direct read of jiffies_64?
include/linux/jiffies.h says:

  The 64-bit value is not atomic on 32-bit systems - you MUST NOT read it
  without sampling the sequence number in jiffies_lock.
  get_jiffies_64() will do this for you as appropriate.

netc_port_prepare_twostep() fills the same ptp_tx_time field, for entries
on the same tstamp_queue, with get_jiffies_64().

On 32-bit builds (possible through COMPILE_TEST), a torn read could make
netc_port_tstamp_timeout_work() reclaim this token's ts_req_id early or
very late. The time_after64(jiffies_64, expire_time) check in
netc_onestep_timeout() below has the same problem. It could report the
in-flight frame as expired at the wrong time.

[ ... ]

> +static bool netc_onestep_timeout(struct netc_port *np)
> +{
> +	u64 expire_time;
> +
> +	/* Use monotonic jiffies_64, as the PHC may be stepped backwards.
> +	 * Add one tick since the ns-to-jiffies conversion rounds down, so
> +	 * the software window is never shorter than the hardware window.
> +	 */
> +	expire_time = np->onestep_tx_time + 1 +
> +		      nsecs_to_jiffies64(NETC_ONESTEP_VALID_WINDOW);
> +	if (np->onestep_state == NETC_ONESTEP_IN_FLIGHT &&
> +	    time_after64(jiffies_64, expire_time))
> +		return true;
> +
> +	return false;
> +}
> +
> +void netc_port_onestep_sync_enqueue(struct dsa_switch *ds, int port,
> +				    struct sk_buff *skb)
> +{
> +	struct netc_port *np = NETC_PORT(ds, port);
> +
> +	spin_lock_bh(&np->onestep_lock);
> +	if (unlikely(np->onestep_state == NETC_ONESTEP_PORT_INACTIVE))
> +		goto free_skb;
> +
> +	if (unlikely(skb_queue_len(&np->onestep_queue) >= NETC_ONESTEP_QTH))
> +		goto free_skb;
> +
> +	__skb_queue_tail(&np->onestep_queue, skb);
> +	if (likely(np->onestep_state == NETC_ONESTEP_IDLE) ||
> +	    netc_onestep_timeout(np)) {

[Severity: Low]
Can the queue-full check keep the drain stalled after
NETC_ONESTEP_VALID_WINDOW has passed?

If the response for the in-flight frame is lost, onestep_state stays
NETC_ONESTEP_IN_FLIGHT. Suppose onestep_queue reaches 512 entries before
the window (about 1.07s) expires. From then on, every enqueue takes the
goto free_skb path and never calls netc_onestep_timeout().

The only recovery left is netc_port_tstamp_timeout_work() expiring the
token after NETC_TSTAMP_TIMEOUT (5 seconds). Every Sync that arrives
before then is dropped.

Would it be better to evaluate netc_onestep_timeout() before rejecting a
frame because the queue is full?

> +		np->onestep_state = NETC_ONESTEP_SCHEDULED;
> +		schedule_work(&np->onestep_work);
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012095924.1129312-1-wei.fang%40oss.nxp.com

