Return-Path: <linuxppc-dev+bounces-26578-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355D5C79F82
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 22:26:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc9yr0S2Dz2yx5;
	Sat, 05 Sep 2026 08:25:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788560740;
	cv=none; b=ZHMhD/w8+igk/iXM6MRMHD+Pd97PCCDBVHdtDhfnDhpOQjE680prMB2yRjujSelf0CmW5QNhynswFL1i/boekqmiVb3j77HO05npTaDeJ6z5MoH5apMFGo4aJcmhvEU+nrTBKhNbW7jaesCZUlhrJ4XJ0B5yHWxmZEfVKwnnKFkUY7Mf04CZnA5vapcFJc0DDns1+bxVyWsoybv2j7MQbcDouoPgkJsK47YQStynS++e/TF65C2Y6buqEn12dcOlxCxBFGZdxavMXhOMMyrbBRkbOvUGreZr5oX39wcfVbWhzGXbUzdPky2o8fncrgYlriCfRxQTThxA4rxfYXV/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788560740; c=relaxed/relaxed;
	bh=/p0MwaYW8aQ0BJ6a1TuPdBmkEYreNxZkQRpD4pIs0as=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JzLuC3mY3DG2zsNK3NXk5a0uDqcvZYZc/wyBtVycbkb5tIIQmdMlJzqUzG6vMdx6VWAYZ1ZmTLxuer5YSwnPDk4jywn2rTnlBgzzQqO+FBN19oUVbgdqj2o0tIbOn/z6jFYgpANHPQSyk3NnmL+N8l7UycXFFAxlgYriDsEm1jhBzgvZPbS0H2HLHgUxMc52P6CWOZT+ECLSD+7a2kPOHTMOhst1vwr5nyo6iCwnYekOkoVaXcXy43C/8+4FgtW+kpWzJ5SUtNryg/JOPxsECPuv5ix52wyWdsi+at68PvCMTnwdT1n7wFgeNHoqoWKLn2p2kumjUhosUm2TWHtFAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdjq+vNm; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdjq+vNm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc9yp4mwLz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 08:25:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1DB3741A63;
	Fri,  4 Sep 2026 22:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A5F1F00A3D;
	Fri,  4 Sep 2026 22:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560735;
	bh=/p0MwaYW8aQ0BJ6a1TuPdBmkEYreNxZkQRpD4pIs0as=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jdjq+vNm9uqBKHx/HaxeWJ5GQpvuXlOmOWHNp46G892FFQ3BAklgsdccpiTq/lq78
	 E4DHHsMmHDBnkm4LwU0PLysWwjbVKMZ2ej7q8UA5Rmz0q0wD1gpOlhAbu49aSB7uEm
	 RsFwMoa0XAe81cFcwzohFqnsKuf2q+fD0CKrAZnM7We+VGNRS0nvzRR298XmiJTD7a
	 09YeaqAXfwJ7ltPc0RcJBoZ3akkLzKUQYfUw5LaPHb11MTHMx45T+Jkx5ny817oww3
	 aDTS6h+jM2bbvF17FcI24zSK6+mXWRWzY40kDO91sE7I7xz7XcC3jvg3+G0QntU8eq
	 3KimCsbvrpMGw==
Subject: Re: [PATCH v3 net-next 8/8] net: dsa: netc: add PTP one-step
 timestamping support
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 04 Sep 2026 22:25:33 +0000
Message-ID: <178856073363.219967.13962315129616292452@kernel.org>
In-Reply-To: <20260831082335.1184605-9-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-9-wei.fang@oss.nxp.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 2 · Low: 0 (1)

- [High] netc_port_onestep_alloc() takes try_module_get(THIS_MODULE) for
  every user port at switch setup time and the matching module_put()…
- [High] The one-frame-at-a-time interlock protecting the shared per-port
  PM_SINGLE_STEP register uses skb->destructor as the 'frame has…
- [Medium] netc_port_prepare_onestep_sync()
  (drivers/net/dsa/netc/netc_ptp.c) performs its unsupported-case checks…
- [Medium] netc_port_prepare_onestep_sync() accepts whatever
  ptp_classify_raw() returns, including PTP_CLASS_V1_IPV4/V1_IPV6, and…

Pre-existing issues:
- [Low] The three new drop sites (NETC_PTP_FLAG_DROP handling in
  netc_xmit(), the NETC_ONESTEP_QTH queue-full drop in…

--

net: dsa: netc: add PTP one-step timestamping support

This adds one-step TX timestamping for PTP Sync frames on the NETC switch.
The xmit path classifies a Sync frame and hands it to a per-port work,
which reads the PTP time, programs PM_SINGLE_STEP, patches the
originTimestamp field and transmits the frame to the conduit via a new
tagger callback.

> diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
> index f55010f46819c..8e6ab4b065802 100644
> --- a/drivers/net/dsa/netc/netc_ptp.c
> +++ b/drivers/net/dsa/netc/netc_ptp.c
> @@ -4,13 +4,307 @@

[ ... ]

> +static void netc_onestep_destroy_work(struct work_struct *work)
> +{
> +	struct netc_onestep *onestep = container_of(work, struct netc_onestep,
> +						    destroy_work);
> +
[ ... ]
> +	cancel_work_sync(&onestep->work);
> +	netc_port_purge_onestep_queue(onestep, true);
> +	mutex_destroy(&onestep->work_lock);
> +	kfree(onestep);
> +	module_put(THIS_MODULE);
> +}

[ ... ]

> +static void netc_onestep_skb_destructor(struct sk_buff *skb)
> +{
> +	struct netc_onestep *onestep = skb_shinfo(skb)->destructor_arg;
> +
> +	/* skb has been transmitted by hardware. Schedule work to send the next
> +	 * queued one-step Sync packet, then release this skb's reference on the
> +	 * context. If the port has already been torn down and this is the last
> +	 * reference, the context is freed via netc_onestep_release().
> +	 */
> +	schedule_work(&onestep->work);
> +	netc_onestep_put(onestep);
> +}

[Severity: High]
Is skb->destructor a reliable "the frame has egressed" signal for the
PM_SINGLE_STEP interlock?

netc_port_program_onestep() calls skb_orphan(skb), which leaves
skb->sk == NULL, and then installs this destructor. Any later orphaning
fires and clears the destructor before the frame is transmitted, for
example in net/sched/sch_fq.c:fq_classify():

	if (!sk || sk_listener_or_tw(sk)) {
		unsigned long hash = skb_get_hash(skb) & q->orphan_mask;
		...
		skb_orphan(skb);

Since skb->sk was already cleared by the driver, this triggers at enqueue
time for every one-step frame when the conduit uses fq, and sch_netem does
the same via skb_orphan_partial().  A qdisc drop frees the skb too.  In
those cases the in-flight slot is released while the frame is still queued,
and the real TX completion can no longer kick the work.

Even in the normal case, conduit TX completion only means the frame was
handed to the switch; it still has to traverse the switch and be scheduled
on the user port MAC.  Can netc_onestep_work() then reprogram OFFSET/CH for
frame N+1 while frame N is still waiting for egress, so the residence time
is patched at the wrong offset when consecutive frames differ in
encapsulation (L2 versus UDP, VLAN versus untagged)?

The commit message states the opposite invariant:

    "keeping PM_SINGLE_STEP always matched to the frame being transmitted"

Is there anything that structurally guarantees this, given there is no
egress confirmation from the destination port?

> +static void netc_port_program_onestep(struct netc_port *np,
> +				      struct netc_onestep *onestep,
> +				      struct sk_buff *skb,
> +				      u64 tstamp)
> +{

[ ... ]

> +update_timestamp:
> +	__put_unaligned_t(__be16, new_sec_h, hdr + tstamp_offset);
> +	__put_unaligned_t(__be32, new_sec_l, hdr + tstamp_offset + 2);
> +	__put_unaligned_t(__be32, new_ns, hdr + tstamp_offset + 6);
> +
> +	netc_port_set_onestep_control(np, csum_update, correction_offset);
> +
> +	/* Orphan the skb to release the socket send buffer quota immediately.
> +	 * This is safe because sock_wfree() does not access skb->data or any
> +	 * frame content. After skb_orphan(), we install our own destructor so
> +	 * that when the conduit driver frees the skb after TX completion, we
> +	 * get notified to send the next queued Sync packet.
> +	 */
> +	skb_orphan(skb);
> +	netc_onestep_get(onestep); /* in-flight reference */
> +	skb_shinfo(skb)->destructor_arg = onestep;
> +	skb->destructor = netc_onestep_skb_destructor;
> +}

[ ... ]

> +static void netc_onestep_work(struct work_struct *work)
> +{

[ ... ]

> +	np = onestep->np;
> +	priv = np->switch_priv;
> +	if (unlikely(netc_get_phc_time(priv, &tstamp))) {
[ ... ]
> +		dev_dbg_ratelimited(priv->dev,
> +				    "Port %d PTP timer unavailable, drop Sync\n",
> +				    np->dp->index);
> +		kfree_skb(skb);
> +		schedule_work(&onestep->work);
> +		goto unlock_work;
> +	}

[ ... ]

> +static int netc_port_onestep_alloc(struct netc_port *np)
> +{
> +	struct netc_onestep *onestep;
> +	int err;
> +
> +	/* Hold a module reference until the last in-flight one-step Sync skb
> +	 * is freed by the conduit. Without this, the module could be unloaded
> +	 * before netc_onestep_skb_destructor() returns, causing a panic.
> +	 * Released in netc_onestep_destroy_work() after all cleanup is done.
> +	 */
> +	if (!try_module_get(THIS_MODULE)) {
> +		dev_err(np->switch_priv->dev,
> +			"Failed to get the driver module\n");
> +		return -ENODEV;
> +	}

[Severity: High]
Does this make the module permanently unloadable while the switch is bound?

The reference is taken once per user port from netc_setup() ->
netc_init_all_ports() -> netc_port_ptp_init() -> netc_port_onestep_alloc(),
not per in-flight skb, so it is held for the whole bound lifetime.  The
matching module_put(THIS_MODULE) only runs from netc_onestep_destroy_work(),
which requires the owner kref to be dropped in netc_free_ports_resources(),
i.e. it requires the remove path:

  rmmod -> delete_module() -> try_stop_module() -> try_release_module_ref()

That returns non-zero with references outstanding and delete_module() fails
with -EWOULDBLOCK, so mod->exit (pci_unregister_driver) never runs and the
kref is never dropped.  Is there a path that can ever release these
references?

Separately, module_put(THIS_MODULE) is the last statement of
netc_onestep_destroy_work(), which lives in module text.  If that were the
final reference, can free_module() unmap the text while this work function
is still returning and while the workqueue core still has
worker->current_func pointing into it?

The in-flight skb already holds a kref on the context, so is the module
self-reference adding anything beyond blocking rmmod?

> +
> +	onestep = kzalloc_obj(*onestep);
> +	if (!onestep) {
> +		err = -ENOMEM;
> +		goto put_module;
> +	}

[ ... ]

> @@ -455,10 +754,100 @@ bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
>  	return false;
>  }
>  
> +static void netc_port_prepare_onestep_sync(struct netc_port *np,
> +					   struct sk_buff *skb,
> +					   u32 ptp_class, bool *twostep)
> +{

[ ... ]

> +	ptp_hdr = ptp_parse_header(skb, ptp_class);
> +	if (unlikely(!ptp_hdr)) {
> +		NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_DROP;
> +		dev_dbg_ratelimited(priv->dev,
> +				    "Port %d failed to parse Sync header\n",
> +				    np->dp->index);
> +		return;
> +	}
> +
> +	msg_type = ptp_get_msgtype(ptp_hdr, ptp_class);
> +	twostep_flag = ptp_hdr->flag_field[0] & 0x2;
> +
> +	pkt_hdr = skb_mac_header(skb);
> +	correction_offset = (u8 *)&ptp_hdr->correction - pkt_hdr;
> +	tstamp_offset = (u8 *)ptp_hdr + sizeof(*ptp_hdr) - pkt_hdr;

[Severity: Medium]
Should this path require PTP_CLASS_V2?

ptp_classify_raw() masks the version nibble and can return
PTP_CLASS_V1_IPV4 / PTP_CLASS_V1_IPV6, and ptp_parse_header() only length
checks, so a legacy PTPv1 event message reaches here.  For v1,
ptp_get_msgtype() deliberately reads hdr->control:

include/linux/ptp_classify.h:ptp_get_msgtype() {
	if (unlikely(type & PTP_CLASS_V1))
		/* msg type is located at the control field for ptp v1 */
		msgtype = hdr->control;
	...
}

For a PTPv1 Sync that field is 0, which equals PTP_MSGTYPE_SYNC, so the
message-type test passes.  twostep_flag is then read from
ptp_hdr->flag_field[0], which in a PTPv1 header is a byte of the 16-byte
subdomain name, and for common subdomains that byte has bit 1 clear, so the
frame is accepted as a genuine one-step Sync.

netc_port_program_onestep() then writes 10 bytes at ptp_header+34 (not the
v1 originTimestamp), programs PM_SINGLE_STEP[OFFSET] with ptp_header+8
(inside the v1 subdomain), and fixes up the UDP checksum over those wrong
bytes.  Can a PTPv1 Sync be corrupted on the wire this way?

> +
> +	/* Ensure that the entire originTimestamp field is present in the
> +	 * linear buffer of the skb and the correction_offset must be within
> +	 * the hardware capability.
> +	 */
> +	if (unlikely(tstamp_offset + 10 > skb_headlen(skb) ||
> +		     correction_offset > NETC_MAX_STEP_OFFSET)) {
> +		NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_DROP;
> +		dev_dbg_ratelimited(priv->dev,
> +				    "Port %d PTP offset check error\n",
> +				    np->dp->index);
> +		return;
> +	}
> +
> +	/* Only a Sync frame with the twoStepFlag cleared can use one-step
> +	 * timestamping. A frame that requests two-step (or is not a Sync)
> +	 * carries different on-wire fields, so this is a real classification;
> +	 * report it through *twostep so the caller falls back to the two-step
> +	 * path.
> +	 */
> +	if (msg_type != PTP_MSGTYPE_SYNC || twostep_flag != 0) {
> +		*twostep = true;
> +		return;
> +	}

[Severity: Medium]
Should the Sync/twoStepFlag classification happen before the
unsupported-case checks?

As written, the order is skb_linearize() failure -> DROP,
ptp_parse_header() == NULL -> DROP, tstamp_offset + 10 > skb_headlen() ||
correction_offset > NETC_MAX_STEP_OFFSET -> DROP, and only then the
msg_type / twostep_flag test.  So any PTP frame that trips one of the
earlier checks, including a Delay_Req that only wants a two-step timestamp,
gets NETC_PTP_FLAG_DROP and is freed by netc_xmit() instead of taking the
two-step fallback.

ptp_classify_raw() only inspects the first two bytes of the PTP payload,
while ptp_parse_header() needs 34 bytes and this code needs
tstamp_offset + 10 bytes in the linear area.  Can a short frame sent to UDP
port 319 by any local sender therefore be silently discarded regardless of
its message type, with only a dev_dbg_ratelimited() trace?  The same applies
to skb_linearize() failure under memory pressure.

For comparison, enetc_xmit() falls back to two-step when the parse fails and
still transmits the frame.

netc_onestep_work() adds a fourth drop site: when netc_get_phc_time() fails,
an already-accepted Sync is freed with kfree_skb().

The commit message states:

    "frames that cannot be handled as one-step fall back to the two-step
    path or are sent as normal frames"

Can that be reconciled with the four kfree_skb() sites, or should the
description be adjusted?

[ ... ]

> @@ -466,6 +855,50 @@ void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)

[ ... ]

> +void netc_port_onestep_sync_enqueue(struct dsa_switch *ds, int port,
> +				    struct sk_buff *skb)
> +{

[ ... ]

> +	spin_lock_bh(&onestep->queue_lock);
> +	if (unlikely(skb_queue_len(&onestep->queue) >= NETC_ONESTEP_QTH)) {
> +		spin_unlock_bh(&onestep->queue_lock);
> +		kfree_skb(skb);
> +		return;
> +	}

[Severity: Low]
This isn't a bug introduced by this patch, but the new drop sites do not
touch any drop counter.  The queue-full drop here, the
NETC_PTP_FLAG_DROP branch in netc_xmit(), and the PHC-failure drop in
netc_onestep_work() all free the skb after dsa_user_xmit() has already
accounted it:

net/dsa/user.c:dsa_user_xmit() {
	dev_sw_netstats_tx_add(dev, 1, skb->len);
	...
}

So tx_packets counts frames that never left the box while tx_dropped stays
zero.  The accounting side is pre-existing framework behaviour (dsa_user_xmit()
itself drops on skb_ensure_writable_head_tail() failure without accounting),
but would it be worth bumping a drop counter at the new sites?

> +
> +	__skb_queue_tail(&onestep->queue, skb);
> +	if (!onestep->in_flight) {
> +		onestep->in_flight = true;
> +		kick = true;
> +	}
> +	spin_unlock_bh(&onestep->queue_lock);

[ ... ]

> diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
> index d46576ae2f751..d9bc4a5e8ae9a 100644
> --- a/net/dsa/tag_netc.c
> +++ b/net/dsa/tag_netc.c
> @@ -138,9 +195,19 @@ static struct sk_buff *netc_xmit(struct sk_buff *skb,
>  	if (likely(!ptp_flag)) {
>  		netc_fill_tp_tag_subtype0(skb, ndev);
>  		return skb;
> +	}
> +
> +	if (ptp_flag == NETC_PTP_FLAG_ONESTEP) {
[ ... ]
> +		netc_onestep_sync_enqueue(skb, ndev);
> +		return NULL;
>  	} else if (ptp_flag == NETC_PTP_FLAG_TWOSTEP) {
>  		netc_fill_tp_tag_subtype2(skb, ndev);
> -	} else {
> +	} else { /* NETC_PTP_FLAG_DROP */
>  		kfree_skb(skb);
>  		return NULL;
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831082335.1184605-1-wei.fang%40oss.nxp.com

