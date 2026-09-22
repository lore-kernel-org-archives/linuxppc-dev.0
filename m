Return-Path: <linuxppc-dev+bounces-27907-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41314C982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 08:26:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hptTp18b9z30Pn;
	Tue, 22 Sep 2026 18:26:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790065566;
	cv=none; b=LNt4EF84ggOSUNkk5eQS5lOS9VukH/Yp57p2NTbLShtetNtWK2hUwgSr+sZ648+ein6JOxmS1cnZqEDxco8HtZRjpEX8hk07pvHtB5r+5hRGHpe9vGZAXjlcT8mc2E9ioIqHCkLI7Na41UKxG5pdeMiuqlPzinGm7qUIFldbgO6LJKkF8o7n6C9DcyOwq5lf6VTz7Vs9ISba4OPLe7Gq4sE8mywelVIjUWkq5y79eRDRFF8MHS0RGbL5Tsc/vNIZ8mawyrjwOIkzxAaoAQKq8cSmPK6MqsmccavDfX0Ig3HPlEwTBsGn2m2y+w0lkyDFEchuQ8xkZHOsdGOb31+Sew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790065566; c=relaxed/relaxed;
	bh=gHWXc9phQsI3ErJv8I6JHBG46mFzFITgaznMfyDw404=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nE5AR95/+H9iI1wkLJjWHRssxtXHg7CYPLjTG4a6v3E5tCnNkxjV1ld51pC0YrxqfllGCIL3CTn7mKn1tmle0gw6piyLdkLKwCSIJfclilUJilChbtUjEHzKt95ANnhZ825aGGYnJkl7BuL0ovoobmdt5AB6BTm8V47cXn4LhDGXA45UzqZOzQbjuHGENqyEk7rgsJpIbXg30snQ6ULjKdxEGdaavPjmvoG8XTGTwP5b65pwwbtXFekX2AOrh8sKziaTNAHNo0hPgHJataunTm2vYtZngXRWa62UCY/roVPPG6WvsMVPKEWu03WA0c6GYUFiD4Dhb1p0UnHXnRcFDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GaqAjyZ2; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GaqAjyZ2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hptTl6TfVz30TP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 18:26:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B012E60DEB;
	Tue, 22 Sep 2026 08:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CB01F000FF;
	Tue, 22 Sep 2026 08:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790065561;
	bh=gHWXc9phQsI3ErJv8I6JHBG46mFzFITgaznMfyDw404=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GaqAjyZ2ZlV7TmcKVsOlAhh8SE1WlVQayaXr0Rut/3bwxuytWIrnYUSNrDW69Y3Hc
	 OYayKckisaOT5os1fxL++IdVrCyYlm7hMR1aCKTR2zKgAoImk8cgFqIfKmDsf5YvzC
	 T/dumvtSuKBW1YkiNqCb7kV9Gnq+nInAzlmOJ8W28hfRJsGHZZayV2oKVv6i9krNkl
	 LIwLytqfcauefNw7BlGlIc4z5XJOI+uryX0fBTX2VUWBzQsTUiwxxTEjUIgjN8aK0s
	 LnT9llP8n1Qf4byEl3B2Cat9n0MAV7U1uGbBuwIWllLwPHd2gf5UmeQk/eyLY8FZQ4
	 pAfsw6NbN/X0g==
Subject: Re: [PATCH v4 net-next 8/8] net: dsa: netc: add PTP one-step
 timestamping support
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, linusw@kernel.org, linux@armlinux.org.uk,
 wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Date: Tue, 22 Sep 2026 08:25:59 +0000
Message-ID: <179006555987.2160803.11394642259806679085@kernel.org>
In-Reply-To: <20260918072852.501420-9-wei.fang@oss.nxp.com>
References: <20260918072852.501420-9-wei.fang@oss.nxp.com>
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

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Lost-wakeup / incomplete state machine: once
  netc_port_onestep_work() commits np->onestep_state =…
- [High] In netc_port_program_onestep()
  (drivers/net/dsa/netc/netc_ptp.c:99-163), when…
- [Medium] The one-step Sync path silently discards TX frames on at least
  seven paths with no tx_dropped/tx_errors accounting and only two…
- [Medium] In netc_port_onestep_work() the 'no ts_req_id available'
  branch drops the dequeued frame AND unconditionally re-arms itself…
- [Medium] ABA race across the split tstamp_lock/onestep_lock:
  netc_port_txtstamp_handler() unlinks the matching clone under…
- [Medium] PM_SINGLE_STEP is a single per-port MAC register that the
  hardware consults at SFD time of the one-step frame (it supplies the…
- [Low] drivers/net/dsa/netc/Kconfig gains 'depends on PTP_NETC_V4_TIMER
  || PTP_NETC_V4_TIMER=n' with no mention in the commit message.
- [Low] netc_port_set_onestep_control() programs PM_SINGLE_STEP through
  netc_mac_port_wr(), which silently returns without touching hardware…

--

net: dsa: netc: add PTP one-step timestamping support

This adds one-step Sync offload for NETC switch ports and advertises
HWTSTAMP_TX_ONESTEP_SYNC.  One-step Sync frames are handed from the tagger
to the switch driver, queued per port and drained one at a time from a work
item that programs the shared PM_SINGLE_STEP register.  Non one-step Sync
PTP frames keep using two-step timestamping.

A few questions below about the new one-step path.

> diff --git a/drivers/net/dsa/netc/Kconfig b/drivers/net/dsa/netc/Kconfig
> index 8770b65d0f62..7c930579f1c9 100644
> --- a/drivers/net/dsa/netc/Kconfig
> +++ b/drivers/net/dsa/netc/Kconfig
> @@ -5,6 +5,7 @@ config NET_DSA_NETC_SWITCH
>  	depends on NET_DSA && PCI
>  	depends on NET_VENDOR_FREESCALE
>  	depends on PTP_1588_CLOCK_OPTIONAL
> +	depends on PTP_NETC_V4_TIMER || PTP_NETC_V4_TIMER=n

[Severity: Low]
This new tristate dependency isn't mentioned in the changelog, and it does
change which existing configurations stay valid.

CONFIG_NET_DSA_NETC_SWITCH=y together with CONFIG_PTP_NETC_V4_TIMER=m was a
legal combination before; with this line make oldconfig silently downgrades
the switch driver to =m.

The motivation looks right, since netc_timer_get_current_time() is behind
IS_REACHABLE(CONFIG_PTP_NETC_V4_TIMER) in include/linux/fsl/netc_global.h
and otherwise resolves to a -ENODEV stub, which would make netc_get_phc_time()
fail for every one-step frame.  Could the changelog describe this restriction,
or could it be split into its own patch?

>  	select NET_DSA_TAG_NETC
>  	select FSL_ENETC_MDIO
>  	select NXP_NTMP
> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 03200fc63a09..af39a71aece0 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -94,7 +95,7 @@ static void netc_port_rmw(struct netc_port *np, u32 reg,
>  	netc_port_wr(np, reg, new);
>  }
>  
> -static void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
> +void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
>  {
>  	if (is_netc_pseudo_port(np))
>  		return;

[ ... ]

> diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
> index 2e743443ca03..1bc0f0956206 100644
> --- a/drivers/net/dsa/netc/netc_ptp.c
> +++ b/drivers/net/dsa/netc/netc_ptp.c
> @@ -11,6 +11,15 @@
>  
>  #define NETC_NUM_TS_REQ_ID		16
>  #define NETC_TSTAMP_TIMEOUT		(5 * HZ)
> +#define NETC_MAX_STEP_OFFSET		0x1ff
> +#define NETC_ONESTEP_QTH		512
> +/* The 30-bit timestamp of the To_Port subtype 3 tag lets the hardware
> + * account for a single wrap, so the correction field of a one-step Sync
> + * frame is only correct if it is sent out within 2^30 ns after the
> + * software timestamp is read. Past this window the frame is beyond
> + * repair, and PM_SINGLE_STEP becomes safe to reprogram.
> + */

[Severity: Medium]
This comment argues that the correction value is beyond repair after 2^30 ns,
but PM_SINGLE_STEP also carries the correction-field offset and the
"update UDP checksum" bit, which the hardware still applies at SFD time to
whatever frame is being transmitted.

If the previously programmed frame is still sitting in the switch or port
egress path (egress congestion, flow control, TAS gating), the next
netc_port_set_onestep_control() call can change offset and CH under it.  For
an L2 PTP frame the correction offset is around 22, for UDP/IPv6 around 74,
so the MAC would write 8 bytes of correction data at the wrong position
inside the pending frame and may recompute its UDP checksum.

The "no ts_req_id available" branch of netc_port_onestep_work() has the same
shape: it overwrites np->onestep_state with NETC_ONESTEP_SCHEDULED, which
erases the record that a frame is in flight at all.

Would it be safer to only reprogram the register when the new frame's
offset/CH match the pending one, or to hold off until the pending frame is
known to be gone?

> +#define NETC_ONESTEP_VALID_WINDOW	0x40000000 /* ns */
>  
>  static void netc_port_tstamp_timeout_work(struct work_struct *work)
>  {
> @@ -68,12 +77,276 @@ static int netc_get_ts_req_id(struct netc_port *np)
>  	return ts_req_id;
>  }
>  
> +static int netc_get_phc_time(struct netc_switch *priv, u64 *ns)
> +{
> +	if (unlikely(!priv->tmr_dev))
> +		return -ENODEV;
> +
> +	return netc_timer_get_current_time(priv->tmr_dev, ns);
> +}
> +
> +static void netc_port_set_onestep_control(struct netc_port *np,
> +					  bool csum_update, int offset)
> +{
> +	u32 val;
> +
> +	val = PM_SINGLE_STEP_EN | FIELD_PREP(PM_SINGLE_STEP_OFFSET, offset);
> +	if (csum_update)
> +		val |= PM_SINGLE_STEP_CH;
> +	netc_mac_port_wr(np, NETC_PM_SINGLE_STEP(0), val);

[Severity: Low]
This isn't a bug on today's hardware, but netc_mac_port_wr() returns without
touching the register when is_netc_pseudo_port(np) is true, and it reports
nothing back to the caller.

The one-step machinery is gated only on dsa_port_is_user(), and
netc_get_ts_info() advertises HWTSTAMP_TX_ONESTEP_SYNC unconditionally, so a
user port with caps.pseudo_link set would get its originTimestamp rewritten
and a subtype-3 tag attached while the MAC single-step engine was never
enabled.

That combination looks impossible right now: imx94_switch_phylink_get_caps()
only marks port 3 (the CPU port) as internal, and the binding requires
ethernet-port@3 to carry the ethernet = <&enetc3> phandle.  Would it still be
worth refusing one-step on pseudo-link ports explicitly so a future platform
cannot silently drop the register write?

> +}
> +
> +static void netc_port_program_onestep(struct netc_port *np,
> +				      struct sk_buff *skb)
> +{
> +	u16 correction_offset = NETC_SKB_CB(skb)->correction_offset;
> +	u16 tstamp_offset = NETC_SKB_CB(skb)->timestamp_offset;
> +	u64 tstamp = NETC_SKB_CB(skb)->tstamp;
> +	u8 *hdr = skb_mac_header(skb);

[ ... ]

> +	if (NETC_SKB_CB(skb)->is_udp) {
> +		__be32 old_sec_l, old_ns;
> +		struct udphdr *uh;
> +		__be16 old_sec_h;
> +
> +		if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +			csum_update = true;
> +			goto update_timestamp;
> +		}
> +
> +		if (unlikely(!skb_transport_header_was_set(skb)))
> +			uh = (struct udphdr *)(hdr + tstamp_offset -
> +					       sizeof(struct ptp_header) -
> +					       sizeof(struct udphdr));
> +		else
> +			uh = udp_hdr(skb);

[Severity: High]
Can udp_hdr(skb) be trusted here?  netc_port_prepare_onestep_sync() derives
and bounds-checks the PTP offsets itself:

	if (unlikely(tstamp_offset + 10 > skb_headlen(skb) ||
		     correction_offset > NETC_MAX_STEP_OFFSET))
		goto set_ptp_flag_drop;

but skb->transport_header is never validated against skb_headlen(), and the
safe computed expression is only used when the transport header was not set.
The code then reads uh->check at offset 6 and writes 2 bytes there through
inet_proto_csum_replace2()/inet_proto_csum_replace4().

Two AF_PACKET paths can leave transport_header at or past the tail while the
frame still parses as a valid PTPv2 Sync over UDP with ip_summed ==
CHECKSUM_NONE:

packet_snd()
  packet_parse_headers()
    skb_probe_transport_header()
      __skb_flow_dissect()
        key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);

The dissector runs with skb->protocol taken from the user-supplied
sll_protocol and nhoff = 0, so a frame whose declared ethertype disagrees
with its real headers can walk attacker-chosen IPv6 option hdrlen bytes and
end with thoff clamped to skb->len, i.e. transport_header == tail.

The other path is PACKET_VNET_HDR:

virtio_net_hdr_to_skb()
  skb_partial_csum_set()   /* csum_start = headlen - 2 accepted */
...
skb_checksum_help()        /* flips ip_summed to CHECKSUM_NONE,
                              transport_header left as-is */

With the frame length tuned so tailroom is under 8 bytes, wouldn't the
uh->check read go past skb_tail_pointer() and the csum-replace write land
inside struct skb_shared_info (flags/meta_len/nr_frags/tx_flags/gso_size)?

Since the validated expression is already computed just above, could it be
used unconditionally instead of udp_hdr(skb)?  The same udp_hdr() pattern
exists in drivers/net/ethernet/freescale/enetc/enetc.c, but this path is new
here.

> +
> +		/* For IPv4, a UDP checksum of zero on the wire means "no
> +		 * checksum". For IPv6, its UDP checksum is mandatory and
> +		 * never zero.
> +		 */
> +		if (!uh->check)
> +			goto update_timestamp;
> +
> +		old_sec_h = __get_unaligned_t(__be16, hdr + tstamp_offset);
> +		old_sec_l = __get_unaligned_t(__be32, hdr + tstamp_offset + 2);
> +		old_ns = __get_unaligned_t(__be32, hdr + tstamp_offset + 6);
> +		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
> +					 new_sec_h, false);
> +		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
> +					 new_sec_l, false);
> +		inet_proto_csum_replace4(&uh->check, skb, old_ns,
> +					 new_ns, false);
> +		csum_update = true;
> +	}
> +
> +update_timestamp:

[ ... ]

> +static void netc_port_onestep_work(struct work_struct *work)
> +{

[ ... ]

> +skb_dequeue:
> +	skb = __skb_dequeue(&np->onestep_queue);
> +	if (!skb)
> +		goto set_onestep_state_idle;
> +
> +	/* Clone is a ts_req_id token only; its payload is never read, so
> +	 * sharing the buffer with the mutated original is fine.
> +	 */
> +	clone = skb_clone(skb, GFP_ATOMIC);
> +	if (unlikely(!clone)) {
> +		kfree_skb(skb);
> +		goto skb_dequeue;
> +	}
> +
> +	spin_lock_bh(&np->tstamp_lock);
> +	ts_req_id = netc_get_ts_req_id(np);
> +	if (unlikely(ts_req_id < 0)) {
> +		spin_unlock_bh(&np->tstamp_lock);
> +
> +		/* Re-queuing the frame and immediately rescheduling the work
> +		 * would busy-loop on system_percpu_wq and burn CPU until an
> +		 * ID is freed, so drop this frame and move on to the next one
> +		 * in the queue instead.
> +		 */
> +		np->onestep_state = NETC_ONESTEP_SCHEDULED;
> +		schedule_work(&np->onestep_work);
> +
> +		goto onestep_unlock;
> +	}

[Severity: Medium]
The comment says re-queuing plus rescheduling would busy-loop, but the work
does reschedule itself here unconditionally, and each pass destroys one
queued one-step Sync frame at onestep_unlock.  With NETC_ONESTEP_QTH at 512,
can this discard the entire backlog in quick succession?

The 16-entry ts_req_id pool is shared with the two-step path:
netc_port_prepare_twostep() takes an ID for every PTP frame that is not a
one-step Sync (Announce, Follow_Up, Delay_Resp still flow in one-step mode),
and holds it for up to NETC_TSTAMP_TIMEOUT when a response is lost.  So a
burst of two-step requests can drive this branch.

The only trace is the dev_dbg_ratelimited() inside netc_get_ts_req_id().
Should ID exhaustion apply backpressure (leave the frame queued and arm a
delayed retry) rather than dropping frames, and should the changelog mention
that exhaustion means one-step Sync frames are discarded?

> +
> +	/* PHC is unavailable, drop the whole queue */
> +	if (unlikely(netc_get_phc_time(priv, &tstamp))) {
> +		spin_unlock_bh(&np->tstamp_lock);
> +		goto set_onestep_state_idle;
> +	}
> +
> +	NETC_SKB_CB(skb)->tstamp = tstamp;
> +	NETC_SKB_CB(skb)->ts_req_id = ts_req_id;
> +	NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
> +	NETC_SKB_CB(clone)->ts_req_id = ts_req_id;
> +	NETC_SKB_CB(clone)->ptp_tx_time = jiffies_64;
> +	NETC_SKB_CB(clone)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
> +	np->onestep_tx_time = NETC_SKB_CB(clone)->ptp_tx_time;
> +	np->onestep_ts_req_id = ts_req_id;
> +
> +	__skb_queue_tail(&np->tstamp_queue, clone);
> +	if (!delayed_work_pending(&np->tstamp_timeout_work))
> +		schedule_delayed_work(&np->tstamp_timeout_work,
> +				      NETC_TSTAMP_TIMEOUT);
> +
> +	spin_unlock_bh(&np->tstamp_lock);
> +
> +	np->onestep_state = NETC_ONESTEP_IN_FLIGHT;
> +	spin_unlock_bh(&np->onestep_lock);
> +
> +	netc_port_program_onestep(np, skb);
> +	tagger_data = priv->ds->tagger_data;
> +	tagger_data->onestep_sync_xmit(skb, np->dp->user);
> +
> +	return;
> +
> +set_onestep_state_idle:
> +	np->onestep_state = NETC_ONESTEP_IDLE;
> +purge_onestep_queue:
> +	__skb_queue_purge(&np->onestep_queue);
> +onestep_unlock:
> +	spin_unlock_bh(&np->onestep_lock);
> +	kfree_skb(skb);
> +	kfree_skb(clone);
> +}
> +
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
> +	if (unlikely(np->onestep_state == NETC_ONESTEP_PORT_INACTIVE)) {
> +		kfree_skb(skb);
> +		goto onestep_unlock;
> +	}
> +
> +	if (unlikely(skb_queue_len(&np->onestep_queue) >= NETC_ONESTEP_QTH)) {
> +		dev_dbg_ratelimited(np->switch_priv->dev,
> +				    "The onestep_queue of port %d is full\n",
> +				    port);
> +		kfree_skb(skb);
> +		goto onestep_unlock;
> +	}
> +
> +	__skb_queue_tail(&np->onestep_queue, skb);
> +	if (likely(np->onestep_state == NETC_ONESTEP_IDLE) ||
> +	    netc_onestep_timeout(np)) {
> +		np->onestep_state = NETC_ONESTEP_SCHEDULED;
> +		schedule_work(&np->onestep_work);
> +	}
> +
> +onestep_unlock:
> +	spin_unlock_bh(&np->onestep_lock);
> +}

[Severity: High]
Can the port get stuck in NETC_ONESTEP_IN_FLIGHT forever?

Once netc_port_onestep_work() sets IN_FLIGHT and hands the frame to
onestep_sync_xmit(), only three things can resume the drain:

  1. a matching response in netc_port_txtstamp_handler()
  2. netc_onestep_timeout(), which is evaluated only from
     netc_port_onestep_sync_enqueue()
  3. the ts_req_id exhaustion self-reschedule

The changelog says:

    A dropped frame produces no response, so reuse tstamp_timeout_work to
    reclaim its request ID after 5 seconds

but netc_port_tstamp_timeout_work() only unlinks and frees the timed-out
clone:

	__skb_unlink(skb, &np->tstamp_queue);
	__skb_queue_tail(&free_list, skb);
	...
	if (!skb_queue_empty(&np->tstamp_queue))
		schedule_delayed_work(&np->tstamp_timeout_work,
				      NETC_TSTAMP_TIMEOUT);

It never touches np->onestep_state and never schedules np->onestep_work.
And once the clone has been reaped, a late response takes the !skb_match
early return in netc_port_txtstamp_handler(), so it cannot clear IN_FLIGHT
either.

Concretely: frame A goes IN_FLIGHT with id X, frame B is enqueued inside the
window and only appended, A is dropped in the switch so no response arrives,
5 seconds later the timeout work frees A's clone and leaves IN_FLIGHT set.
If the sender then stops, or falls below one frame per window, doesn't B and
everything behind it stay queued and unfreed until link-down, port disable
or a hwtstamp reconfiguration?  These are the original TX skbs and still
hold skb->sk, so the owning socket stays charged.

The queue-full branch above also returns before the netc_onestep_timeout()
check, so once 512 frames have accumulated even continued traffic can no
longer recover the port.

Would it work to reset onestep_state and schedule onestep_work from the
timeout path, or to arm a delayed work for the validity deadline, so
recovery does not depend on new traffic arriving?

Separately, the changelog says the work is scheduled "when the PTP time has
advanced beyond NETC_ONESTEP_VALID_WINDOW", while netc_onestep_timeout()
compares monotonic jiffies_64 and only at enqueue time.

[ ... ]

> @@ -395,6 +673,66 @@ int netc_port_hwtstamp_get(struct dsa_switch *ds, int port,
>  	return 0;
>  }
>  
> +static void netc_port_prepare_onestep_sync(struct netc_port *np,
> +					   struct sk_buff *skb,
> +					   u32 ptp_class, bool *twostep)
> +{

[ ... ]

> +	if (unlikely(skb_linearize_cow(skb)))
> +		goto set_ptp_flag_drop;
> +
> +	ptp_hdr = ptp_parse_header(skb, ptp_class);
> +	if (unlikely(!ptp_hdr))
> +		goto set_ptp_flag_drop;
> +
> +	msg_type = ptp_get_msgtype(ptp_hdr, ptp_class);

[ ... ]

> +set_ptp_flag_drop:
> +	/* Drop instead of falling back to two-step: if it is a Sync,
> +	 * one-step offload will not be executed, the timestamp in the
> +	 * frame is inaccurate, which may affect PTP synchronization.
> +	 */
> +	NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_DROP;
> +	dev_dbg_ratelimited(priv->dev,
> +			    "Port %d: PTP frame dropped in error\n",
> +			    np->dp->index);
> +}

[Severity: Medium]
The skb_linearize_cow() failure is evaluated before the message type is
known, so a plain ENOMEM destroys any PTP frame on the port, including a
Delay_Req that this code would otherwise have sent two-step.  Should the
linearize failure fall back to two-step, or at least be handled after the
Sync check?

None of the new drop paths are accounted anywhere.  dsa_user_xmit() has
already counted the frame as transmitted via dev_sw_netstats_tx_add() before
the tagger frees it, so from userspace the frames just vanish:

  netc_port_prepare_onestep_sync() -> NETC_PTP_FLAG_DROP -> kfree_skb() in
    netc_xmit()                               (linearize/parse/offset checks)
  netc_port_onestep_sync_enqueue()            (queue full, port inactive)
  netc_port_onestep_work()                    (clone failure, no ts_req_id,
                                               PHC read failure purges all)
  netc_port_purge_onestep_queue()             (hwtstamp reconfiguration)

netc has no .get_stats64, so dsa_user_get_stats64() falls back to
dev_get_tstats64(), which folds dev->stats into rtnl_link_stats64 - could
these paths bump dev->stats.tx_dropped?

The changelog only says "Frames that are not one-step Sync still fall back
to two-step timestamping", which does not tell a reader that enabling
one-step turns a degraded timestamp into a frame that is never transmitted.

[ ... ]

> @@ -449,6 +787,21 @@ void netc_port_txtstamp_handler(struct dsa_switch *ds, int port,
>  		dev_dbg_ratelimited(np->switch_priv->dev,
>  				    "Port %d ts_req_id %u which seems lost\n",
>  				    port, ts_req_id);
> +
> +		return;
> +	}
> +
> +	if (NETC_SKB_CB(skb_match)->ptp_flag == NETC_PTP_FLAG_ONESTEP) {
> +		spin_lock_bh(&np->onestep_lock);
> +		if (likely(np->onestep_state == NETC_ONESTEP_IN_FLIGHT &&
> +			   np->onestep_ts_req_id == ts_req_id) ||
> +		    np->onestep_state == NETC_ONESTEP_IDLE) {
> +			np->onestep_state = NETC_ONESTEP_SCHEDULED;
> +			schedule_work(&np->onestep_work);
> +		}
> +		spin_unlock_bh(&np->onestep_lock);
> +		consume_skb(skb_match);
> +
>  		return;
>  	}

[Severity: Medium]
Can the ts_req_id comparison here match a different frame?  The clone is
unlinked from np->tstamp_queue under tstamp_lock earlier in this function,
which immediately makes the 4-bit id reusable, and onestep_lock is only
taken afterwards:

CPU0 (work, frame A response overdue past the window)
  netc_port_onestep_sync_enqueue()
     netc_onestep_timeout() -> true, schedule_work()
  netc_port_onestep_work()
     spin_lock_bh(&np->onestep_lock);

CPU1 (A's response arrives)
  netc_port_txtstamp_handler()
     __skb_unlink(clone_A, &np->tstamp_queue);   /* id X now free */
     spin_unlock_bh(&np->tstamp_lock);
     spin_lock_bh(&np->onestep_lock);            /* blocks */

CPU0 continues
     netc_get_ts_req_id() -> X again for frame B
     np->onestep_ts_req_id = X;
     np->onestep_state = NETC_ONESTEP_IN_FLIGHT;
     spin_unlock_bh(&np->onestep_lock);
     onestep_sync_xmit(B)

CPU1 then sees IN_FLIGHT with onestep_ts_req_id == X and treats A's
response as B's completion, sets SCHEDULED and re-arms the work, which can
transmit frame C and reprogram PM_SINGLE_STEP while B is still pending in
hardware.  Workqueue non-reentrancy serializes the worker, not frame
completion.

Would retiring the id and moving the one-step state under a single lock
order (onestep_lock then tstamp_lock), or matching on a generation counter
instead of the reusable 4-bit id, close this?

[ ... ]

> diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
> index 1404ae41c7bc..37d1dd7ec2c7 100644
> --- a/drivers/net/dsa/netc/netc_switch_hw.h
> +++ b/drivers/net/dsa/netc/netc_switch_hw.h
> @@ -203,6 +203,11 @@ enum netc_stg_stage {
>  #define   SSP_10M			1
>  #define   SSP_1G			2
>  
> +#define NETC_PM_SINGLE_STEP(a)		(0x10c0 + (a) * 0x400)
> +#define  PM_SINGLE_STEP_CH		BIT(6)
> +#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
> +#define  PM_SINGLE_STEP_EN		BIT(31)
> +

[ ... ]

> diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
> index 6b492451d092..c1c0ffee75c1 100644
> --- a/net/dsa/tag_netc.c
> +++ b/net/dsa/tag_netc.c

[ ... ]

> @@ -129,17 +139,69 @@ static void netc_fill_tp_tag_subtype2(struct sk_buff *skb,
>  static struct sk_buff *netc_xmit(struct sk_buff *skb,
>  				 struct net_device *ndev)
>  {
>  	u8 ptp_flag = NETC_SKB_CB(skb)->ptp_flag;
>  
>  	/* Fast path: the overwhelming majority of frames are not PTP frames */
> -	if (likely(!ptp_flag))
> +	if (likely(!ptp_flag)) {
>  		netc_fill_tp_tag_subtype0(skb, ndev);
> -	else
> -		/* ptp_flag == NETC_PTP_FLAG_TWOSTEP */
> +	} else if (ptp_flag == NETC_PTP_FLAG_TWOSTEP) {
>  		netc_fill_tp_tag_subtype2(skb, ndev);
> +	} else if (ptp_flag == NETC_PTP_FLAG_ONESTEP) {
> +		/* The switch driver takes ownership of the one-step Sync and
> +		 * queues it for deferred TX; the deferred work tags it subtype
> +		 * 3 and transmits it directly to the conduit. Return NULL so
> +		 * dsa_user_xmit() stops processing this skb.
> +		 */
> +		netc_onestep_sync_enqueue(skb, ndev);
> +		skb = NULL;
> +	} else {
> +		/* NETC_PTP_FLAG_DROP */
> +		kfree_skb(skb);
> +		skb = NULL;
> +	}
>  
>  	return skb;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918072852.501420-1-wei.fang%40oss.nxp.com

