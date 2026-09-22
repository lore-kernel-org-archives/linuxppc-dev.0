Return-Path: <linuxppc-dev+bounces-27906-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743B3C982F1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 08:26:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hptTm1QmQz30Tf;
	Tue, 22 Sep 2026 18:26:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790065564;
	cv=none; b=U1J3F3/458UppQQGvFq+eZ67Qgjsd1YKU2oyyVyGICj/ZOaV21BhhH1Va/RlmGK1vdPgRGYtIh6acoi6plV071B2EKJ3AYA4UuIWlPwEr3p4Algia7EIbHCbq5+L9kWyAK6catIBTx0XjrtI1cr0cAKXZqJPJpOsAjLVqUs8q33R44ufU5iIRJWzCBOso4/PzrvsJEWVK/aJ+QOW/Lp/nzfZlG6ggSKR0eZrTUofz3zNcJIlrrTWpLZEyIt4B401c2Wyvs4flwMvaq+uaNQ+hGhz+h/3qtbsLlvVzacfD+L7VrGgcQ8ORXiVKtl2Ut0eCFxotv8MQl3MpeLqgST+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790065564; c=relaxed/relaxed;
	bh=RbQ9XjhZ2j0CdIcU+vMqsjCdGOBqEhk3IqJOU9DIHV0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MD6BjTbM8PvnSUvhMJF68Zad9HWsi+X7eWjd4SKA38iZtlUoNcHowBk8QXLrronSmMBgtWhDq3tjetWkAD8WvOMKjGplJpPCU8GSK2rjijFxNHRgeHFE4lzJ7COeAVZuAMtfdlODztrZGGp2zG7+/SbOA0ukiefAfCcwZJy5Oy12Vde5hKLarUKpC7LyvUy7AH332cKw+FDSUOOqYTcEJqeMQzOfnVU1eZNm8kPUlcbpoeQXsBSOLgpcF9DJnqjv2NQdcmQ7YDb+P3FdZEwiDGAP3Nha5GZwqtZCQWeze8jwN1NtpPdtshI3Fx1M5ZBaq0kCuZwMvg+jEPu8pl6cWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V352S49/; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V352S49/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hptTj62Dwz30Pn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 18:26:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C715343B08;
	Tue, 22 Sep 2026 08:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891EF1F0089D;
	Tue, 22 Sep 2026 08:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790065559;
	bh=RbQ9XjhZ2j0CdIcU+vMqsjCdGOBqEhk3IqJOU9DIHV0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V352S49/8vBBhnb2gqojB+qiVNvIF+mrER/uzo7g6lpK3PE5zO8VgUd6eYrvT6Qkp
	 qjyKXVlcNCy9rsYAQGbsZhDnINDMR93aWOLzsYN0CoX4xjNhIJXvoUXVGqNr6ODnVE
	 VxgRAPuy4iATyOxac1AiYY60muf7Id556JWaPyEmn0kiM/qn5/CzsSYGBoiy4iCb1m
	 R7JMe0E+URFGxxmNjA0Lnkpe/PZTLfhkkCGeCKB3yhba7KJwLDRQUrMpuWJuzecWxn
	 M1MxMtnViu4qb/fAR5NzY+9yJlbPcfnQukY8g8wIJlK0LeN+sbLJ6rVRo/ZORfMIsG
	 1IGSATRZlEuhQ==
Subject: Re: [PATCH v4 net-next 7/8] net: dsa: netc: add PTP two-step
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
Date: Tue, 22 Sep 2026 08:25:58 +0000
Message-ID: <179006555805.2160803.10349234944420509540@kernel.org>
In-Reply-To: <20260918072852.501420-8-wei.fang@oss.nxp.com>
References: <20260918072852.501420-8-wei.fang@oss.nxp.com>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] A timed-out timestamp-request ID becomes immediately reusable,
  so a late hardware response can complete a newer skb with the wrong…
- [Medium] Partial IPFT deletion or a failed rollback leaves the reported
  RX timestamp configuration inconsistent with the rules actually…
- [Medium] The PTP ingress-port-filter entries programmed by
  netc_port_hwtstamp_set() are never removed when the switch is torn…
- [Low] Commit message names a callback that does not exist.
- [Low] netc_get_ts_info() advertises HWTSTAMP_TX_ON and
  netc_port_hwtstamp_set() accepts it (even together with…
- [Low] The new TX-timestamp timeout bookkeeping reads the global 64-bit
  `jiffies_64` variable directly instead of using get_jiffies_64():…

--

net: dsa: netc: add PTP two-step timestamping support

This adds RX timestamping via IPFT rules that trap PTP frames to the CPU
port, and two-step TX timestamping by cloning the skb, assigning a 4-bit
per-port request ID and matching the hardware response frame back to the
queued clone.  It also adds the per-switch netc_tagger_data and grabs the
PTP timer's pci_dev so get_ts_info() can report the PHC index.

[Severity: Low]
The changelog says:

> The tagger dispatches both to the driver through the
> twostep_tstamp_handler callback in netc_tagger_data, which matches the
> ID to the queued clone and completes it via skb_complete_tx_timestamp().

Is that the right member name?  The struct added by this patch in
include/linux/dsa/tag_netc.h is:

struct netc_tagger_data {
	void (*txtstamp_handler)(struct dsa_switch *ds, int port,
				 u8 ts_req_id, u64 ts);
};

and net/dsa/tag_netc.c:netc_twostep_tstamp_process() calls
tagger_data->txtstamp_handler(), so grepping for twostep_tstamp_handler
finds nothing.

The same paragraph mentions netc_connect()/netc_disconnect() on the tagger
side, but not the new .connect_tag_protocol op
netc_connect_tag_protocol(), which is what actually installs the handler.
Could that be mentioned as well so the dispatch path is followable from
the changelog?

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 336f5a4633e9..03200fc63a09 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -949,6 +993,21 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
>  	mutex_destroy(&priv->vft_lock);
>  }
>  
> +static void netc_free_ports_resources(struct netc_switch *priv)
> +{
> +	struct dsa_port *dp;
> +
> +	dsa_switch_for_each_available_port(dp, priv->ds) {
> +		struct netc_port *np = priv->ports[dp->index];
> +
> +		if (!dsa_port_is_user(dp))
> +			continue;
> +
> +		disable_delayed_work_sync(&np->tstamp_timeout_work);
> +		netc_port_purge_tstamp_queue(np);
> +	}
> +}
> +
>  static void netc_teardown(struct dsa_switch *ds)
>  {
>  	struct netc_switch *priv = ds->priv;
> @@ -956,6 +1015,8 @@ static void netc_teardown(struct dsa_switch *ds)
>  	disable_delayed_work_sync(&priv->fdbt_ageing_work);
>  	netc_destroy_all_lists(priv);
>  	netc_free_ntmp_user(priv);
> +	netc_free_ports_resources(priv);
> +	pci_dev_put(priv->tmr_dev);
>  }

[Severity: Medium]
Do the PTP IPFT entries survive teardown here?

netc_free_ports_resources() cancels the timeout work and purges the clone
queue, but nothing calls netc_port_del_ptp_filter(), which is the only
release path for np->ptp_ipft_eid[].  It is static in netc_ptp.c and
reachable only from netc_port_set_ptp_filter(), i.e. only from a user-space
hwtstamp request.

So after unbind, up to five entries per user port are still live in the
IPFT with FLTFA=REDIRECT, host reason NETC_HR_PTP_TRAP and IPFT_TIMECAPE,
while struct netc_port (holding the entry IDs) is devm-freed.

There is also an ordering question: netc_teardown() calls
netc_free_ntmp_user() before netc_free_ports_resources():

	netc_free_ntmp_user(priv);	/* destroys the command BD rings */
	netc_free_ports_resources(priv);

Since ntmp_ipft_delete_entry() needs those rings, can the table cleanup be
added at the natural place with this ordering, or should
netc_free_ports_resources() move before netc_free_ntmp_user()?

In a multi-switch tree this looks observable without a PCI re-probe:
unbinding one switch runs dsa_tree_teardown() (hence netc_teardown() for
the sibling), and re-binding runs netc_setup() again on the surviving priv,
where netc_port_ptp_init() resets ptp_ipft_eid[] to NTMP_NULL_ENTRY_ID
while the old entries are still programmed.  Would PTP frames then keep
being trapped and time-captured with HWTSTAMP_FILTER_NONE, with no way to
delete the stale entries?  For the single-switch case the pcie_flr() in
netc_switch_pci_init() at probe seems to hide it.

[ ... ]

> diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
> new file mode 100644
> index 000000000000..2e743443ca03
> --- /dev/null
> +++ b/drivers/net/dsa/netc/netc_ptp.c
> @@ -0,0 +1,492 @@

[ ... ]

> +static void netc_port_tstamp_timeout_work(struct work_struct *work)
> +{
> +	struct netc_port *np = container_of(work, struct netc_port,
> +					    tstamp_timeout_work.work);
> +	struct sk_buff_head free_list;
> +	struct sk_buff *skb, *skb_tmp;
> +
> +	__skb_queue_head_init(&free_list);
> +
> +	spin_lock_bh(&np->tstamp_lock);
> +	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp) {
> +		if (time_before64(jiffies_64, NETC_SKB_CB(skb)->ptp_tx_time +
> +				  NETC_TSTAMP_TIMEOUT))
> +			continue;

[Severity: Low]
Should this use get_jiffies_64() rather than reading jiffies_64 directly?
The same raw read is used in netc_port_prepare_twostep():

	NETC_SKB_CB(clone)->ptp_tx_time = jiffies_64;

include/linux/jiffies.h says:

 * The 64-bit value is not atomic on 32-bit systems - you MUST NOT read it
 * without sampling the sequence number in jiffies_lock.
 * get_jiffies_64() will do this for you as appropriate.

Since this comparison is the only exit criterion for a queued clone, a torn
read on a 32-bit build could either purge it immediately or never purge it
(retaining the clone, its socket reference from skb_clone_sk() and its
ts_req_id).  The Kconfig is "depends on ARM64 || COMPILE_TEST", so only
32-bit COMPILE_TEST builds compile the racy read today.  ocelot uses plain
jiffies with time_is_before_jiffies() for the same pattern.

> +
> +		dev_dbg_ratelimited(np->switch_priv->dev,
> +				    "Port %d ts_req_id %u which seems lost\n",
> +				    np->dp->index, NETC_SKB_CB(skb)->ts_req_id);
> +
> +		__skb_unlink(skb, &np->tstamp_queue);
> +		__skb_queue_tail(&free_list, skb);
> +	}

[ ... ]

> +static int netc_get_ts_req_id(struct netc_port *np)
> +{
> +	DECLARE_BITMAP(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
> +	struct sk_buff *skb, *skb_tmp;
> +	unsigned long ts_req_id;
> +
> +	bitmap_zero(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
> +
> +	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp)
> +		__set_bit(NETC_SKB_CB(skb)->ts_req_id, ts_req_id_bitmap);
> +
> +	ts_req_id = find_first_zero_bit(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);

[Severity: Medium]
Can a timed-out request ID be handed out again while the hardware response
for it is still in flight?

Availability here is derived purely from the clones currently queued, and
netc_port_tstamp_timeout_work() frees an ID by unlinking the clone without
knowing whether the frame has even been transmitted.  The timeout clock
starts before the frame reaches the conduit:

netc_port_prepare_twostep()
	NETC_SKB_CB(clone)->ptp_tx_time = jiffies_64;
	__skb_queue_tail(&np->tstamp_queue, clone);

so egress queueing delay (link down/flapping, or sustained PAUSE from the
link partner) counts against the 5 second budget.  If that delay exceeds
NETC_TSTAMP_TIMEOUT:

netc_port_tstamp_timeout_work()	-> drops clone, frees ID
netc_get_ts_req_id()		-> hands the same ID to a new transmit
netc_port_txtstamp_handler()	-> late response matches the new clone

and netc_port_txtstamp_handler() matches on nothing but port and the 4-bit
ID:

	if (NETC_SKB_CB(skb)->ts_req_id != ts_req_id)
		continue;

	__skb_unlink(skb, &np->tstamp_queue);

Would that report the old frame's transmit time for the new frame, and then
discard the correct response as lost?  ocelot_port_dequeue_ptp_tx_skb()
additionally compares the PTP sequenceId before completing a queued clone;
since the NETC response tag only carries the 4-bit ID, would a generation
counter or an ID quarantine be needed here?

[ ... ]

> +int netc_get_ts_info(struct dsa_switch *ds, int port,
> +		     struct kernel_ethtool_ts_info *info)
> +{

[ ... ]

> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
> +

[ ... ]

> +static int netc_port_del_ptp_filter(struct netc_port *np)
> +{
> +	struct netc_switch *priv = np->switch_priv;
> +	int ret = 0;
> +	int err;
> +
> +	for (int i = 0; i < NETC_PTP_MAX; i++) {
> +		if (np->ptp_ipft_eid[i] == NTMP_NULL_ENTRY_ID)
> +			continue;
> +
> +		/* No -ETIMEDOUT here: with the command BD ring enabled, the
> +		 * hardware never times out on a command. Any remaining error
> +		 * means the entry is still present in the table.
> +		 */
> +		err = ntmp_ipft_delete_entry(&priv->ntmp,
> +					     np->ptp_ipft_eid[i]);
> +		if (likely(!err)) {
> +			np->ptp_ipft_eid[i] = NTMP_NULL_ENTRY_ID;
> +			continue;
> +		}
> +
> +		ret = err;

[Severity: Medium]
When one of the up to five deletions fails, the loop continues and the
last error is returned, so the hardware can end up with a subset of the
rules still installed.  What does user space then see?

netc_port_set_ptp_filter()
	err = netc_port_del_ptp_filter(np);
	if (err)
		return err;

	np->ptp_rx_filter = HWTSTAMP_FILTER_NONE;

On the delete failure path np->ptp_rx_filter keeps the full old value, so
netc_port_hwtstamp_get() reports a filter that is only partly programmed.

On the add path the opposite happens: np->ptp_rx_filter is already
HWTSTAMP_FILTER_NONE, and both netc_port_add_l4_ptp_filter() and
netc_port_add_l2_l4_ptp_filter() discard the rollback return value:

del_ptp_filter:
	netc_port_del_ptp_filter(np);

	return err;

so a failed rollback can leave live REDIRECT+TIMECAPE entries while
software reports NONE, and PTP frames from that port keep being trapped to
the CPU port instead of being forwarded.

Is the failure reachable?  ntmp_ipft_delete_entry() -> 
ntmp_delete_entry_by_id() first does:

	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
	if (err)
		return err;

which is a dma_alloc_coherent(..., GFP_KERNEL) that can return -ENOMEM
before the command is issued, and netc_xmit_ntmp_cmd() can return -EBUSY,
-EIO or -ETIMEDOUT.

[ ... ]

> +void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
> +{
> +	struct netc_port *np = NETC_PORT(ds, port);
> +	u32 ptp_class;
> +	int tx_type;
> +
> +	NETC_SKB_CB(skb)->ptp_flag = 0;
> +	ptp_class = ptp_classify_raw(skb);
> +	if (ptp_class == PTP_CLASS_NONE)
> +		return;
> +
> +	/* The rx_filters in netc_get_ts_info() has already declared that
> +	 * it only supports PTP v2, so TX only supports v2 as well.
> +	 */
> +	if (unlikely(ptp_class & PTP_CLASS_V1))
> +		return;

[Severity: Low]
This isn't a bug for real PTP stacks, but is the comment's reasoning right?
The advertised rx_filters describe what the ingress filter can match; the
uapi definition of the TX mode makes no protocol statement:

include/uapi/linux/net_tstamp.h
	/*
	 * Enables hardware time stamping for outgoing packets;
	 * the sender of the packet decides which are to be
	 * time stamped ...
	 */
	HWTSTAMP_TX_ON,

netc_get_ts_info() advertises HWTSTAMP_TX_ON unconditionally and
netc_port_hwtstamp_set() accepts it even with HWTSTAMP_FILTER_NONE, yet a
socket asking for SOF_TIMESTAMPING_TX_HARDWARE on a non-PTP or PTPv1 frame
silently gets no timestamp here.  Could the comment be reworded to state
the hardware/driver TX restriction directly instead of deriving it from the
RX filters?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918072852.501420-1-wei.fang%40oss.nxp.com

