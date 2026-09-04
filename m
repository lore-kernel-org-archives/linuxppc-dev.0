Return-Path: <linuxppc-dev+bounces-26576-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6456C79F8E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 22:25:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc9yn0fTbz2yvs;
	Sat, 05 Sep 2026 08:25:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788560737;
	cv=none; b=jk/qJmvLZ03Stgo2brr5Vvw6V6DlJth2Bs/Ccaiw7AqWJn+jheIT8TP1teZ9GkLJmpkQwSxnOTSfW2J/wzvhch+XitBYTw27pZM2aOVjmJdrM5BDTcKJUpDSKgZTmO5ODIKlnBagANdmsP0aIMvHvmeH0q0L/MznhybUkcpfP/M1iCFu5dCZfWyAFBj5t8ZVc6YQawiQfTzhSL+R5T9/mtTZKy33F9EROalQLSPa7kSvRgQK3sb0Gk3C5+VfkM76d0DVm38A7ZVffgNzSptsKMrRsiGuzGnrBE482Gw2cfElO3mj0/9Md93RRU69aYC/10bP4cZewdvwTQpwfd6G3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788560737; c=relaxed/relaxed;
	bh=UHO+mi1IOt4R3cvz6YT+A6aAyOSJzeHq5bZ5NQ609xA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RoN/s9MXTvKpVjRwJd+rrzt2smQSVQUwFGNWkf8zHNPr4P0Pwen3MAPeW/1LCITFYnwHPMMUZHugV2SP8W6cjTSX6DpMi8bCPboVFSrFoGR+fPk0TmuXhS/6fhrbiBp+Rn1XFNubNMoxca+/AbKuJw2tZK4DABdX4x/+z2tx44s4QB1w44vOfMgT/KHT2G7DHqSyas1jIsKwPQTRVWLyigLbeVpm1xON+yy34Wf0KEj3RZ2Y045OPGqNWHCcY58E8T6UFWk/RVpWct5mhctj9P8E4vXDi9bPDDRjixy3CPurDD6EASAcTg6V83XoJeSaS0NP5XZZFsdiXk2ezqEOnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNo/UfXg; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNo/UfXg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc9yl50Vlz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 08:25:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B9C89602C8;
	Fri,  4 Sep 2026 22:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7B71F00ADB;
	Fri,  4 Sep 2026 22:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560733;
	bh=UHO+mi1IOt4R3cvz6YT+A6aAyOSJzeHq5bZ5NQ609xA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SNo/UfXgNwMgteS4V59nftI0a7XprY1+K+ybYPsfJrIGlMphl4rCUIyLcuLOxoRFO
	 /BPcIIgTM71pWYL0S7c/e33lPGYOqeABE7s04QbIwqomi7Uk3yaS5z/IZnPT3FatrI
	 jLTsAA2+pktclE1YWWpKLSoqdGxpYocyu1+K06ODT3BiOWy756hPXvhPFyO+0W9i8a
	 ApfKNy5F4NXqg4Aj/HdYKJRCJsbCBE7wAgpJmo6Ahe4OcptRIhml3WRV/6BtDYLxK9
	 ncVG/Q7kdRLiRlZuRu2grv/Xcjre4vZ5spAIH1xRfQOkE+x28iD2oOX5ZMFCcktKHf
	 sdEpfGEhJ5XWg==
Subject: Re: [PATCH v3 net-next 7/8] net: dsa: netc: add PTP two-step
 timestamping support
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 04 Sep 2026 22:25:32 +0000
Message-ID: <178856073223.219967.8253414459480029392@kernel.org>
In-Reply-To: <20260831082335.1184605-8-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-8-wei.fang@oss.nxp.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 1

- [Medium] Failed IPFT deletion leaves PTP trap rules programmed in
  hardware while the driver reports the new (possibly NONE) rx_filter as…
- [Medium] netc_get_ts_info() and netc_port_hwtstamp_set() use different
  definitions of 'hardware timestamping available'.
- [Medium] The 4-bit two-step timestamp request ID is recycled purely on
  the basis of 'the clone is no longer on np->skb_txtstamp_queue'.
- [Low] netc_flow_dissect() (net/dsa/tag_netc.c:295) decides to skip
  protocol/offset parsing based on the tag's subtype nibble alone: 'if…

--

net: dsa: netc: add PTP two-step timestamping support

This adds RX timestamping by installing IPFT rules that redirect PTP frames
to the CPU port, plus two-step TX timestamping where a cloned skb is matched
against a hardware-generated response frame using a 4-bit request ID. The
tagger gains To_Port subtype 2 and To_Host subtype 1/2 handling and
netc_connect()/netc_disconnect() to manage the shared netc_tagger_data.

A few questions on the new PTP paths below.

> diff --git a/drivers/net/dsa/netc/Kconfig b/drivers/net/dsa/netc/Kconfig
> index 793f7691a24f3..8770b65d0f62d 100644
> --- a/drivers/net/dsa/netc/Kconfig
> +++ b/drivers/net/dsa/netc/Kconfig
> @@ -4,6 +4,7 @@ config NET_DSA_NETC_SWITCH
>  	depends on ARM64 || COMPILE_TEST
>  	depends on NET_DSA && PCI
>  	depends on NET_VENDOR_FREESCALE
> +	depends on PTP_1588_CLOCK_OPTIONAL
>  	select NET_DSA_TAG_NETC
>  	select FSL_ENETC_MDIO
>  	select NXP_NTMP

> diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
> new file mode 100644
> index 0000000000000..f55010f46819c
> --- /dev/null
> +++ b/drivers/net/dsa/netc/netc_ptp.c
> @@ -0,0 +1,471 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)

[ ... ]

> +#define NETC_NUM_TS_REQ_ID		16
> +#define NETC_TXTSTAMP_TIMEOUT		(5 * HZ)
> +
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
> +	skb_queue_walk_safe(&np->skb_txtstamp_queue, skb, skb_tmp) {
> +		if (time_before(jiffies, NETC_SKB_CB(skb)->ptp_tx_time +
> +			       NETC_TXTSTAMP_TIMEOUT))
> +			continue;
> +
> +		dev_dbg_ratelimited(np->switch_priv->dev,
> +				    "Port %d ts_req_id %u which seems lost\n",
> +				    np->dp->index, NETC_SKB_CB(skb)->ts_req_id);
> +
> +		__skb_unlink(skb, &np->skb_txtstamp_queue);
> +		__skb_queue_tail(&free_list, skb);
> +	}

[Severity: Medium]

Can a request ID be handed out again while its response is still outstanding
in hardware?

netc_port_tstamp_timeout_work() unlinks and frees the clone after 5 seconds,
and the allocator in netc_port_txtstamp_twostep() derives the free IDs purely
from what is currently on the queue:

	skb_queue_walk_safe(&np->skb_txtstamp_queue, skb, skb_tmp)
		__set_bit(NETC_SKB_CB(skb)->ts_req_id, ts_req_id_bitmap);

	ts_req_id = find_first_zero_bit(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);

So once a clone has timed out, nothing records that a To_Host subtype 2
response for that ID may still arrive.

If egress of the original frame is stalled past the timeout (link down, or
sustained 802.3x PAUSE from the link partner), the late response reaches
netc_port_twostep_tstamp_handler(), which matches on port and ts_req_id only,
with no generation tag:

	if (NETC_SKB_CB(skb)->ts_req_id != ts_req_id)
		continue;

	__skb_unlink(skb, &np->skb_txtstamp_queue);

Would the newly queued clone then be completed with a timestamp that is
seconds old, and the correct response for that clone later dropped as
unmatched? Would a generation counter, or holding a timed-out ID back from
reuse, avoid this?

> +
> +	/* Reschedule if there are still pending clones that have not
> +	 * timed out yet.
> +	 */
> +	if (!skb_queue_empty(&np->skb_txtstamp_queue))
> +		schedule_delayed_work(&np->tstamp_timeout_work,
> +				      NETC_TXTSTAMP_TIMEOUT);
> +
> +	spin_unlock_bh(&np->tstamp_lock);
> +	__skb_queue_purge(&free_list);
> +}

[ ... ]

> +static int netc_get_phc_index(struct netc_switch *priv)
> +{
> +	if (!priv->tmr_dev)
> +		return -1;
> +
> +	return ptp_clock_index_by_dev(&priv->tmr_dev->dev);
> +}
> +
> +int netc_get_ts_info(struct dsa_switch *ds, int port,
> +		     struct kernel_ethtool_ts_info *info)
> +{
> +	struct netc_switch *priv = ds->priv;
> +
> +	info->phc_index = netc_get_phc_index(priv);
> +	if (info->phc_index < 0)
> +		return 0;
> +
> +	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
> +				 SOF_TIMESTAMPING_RX_HARDWARE |
> +				 SOF_TIMESTAMPING_RAW_HARDWARE;
> +
> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
> +
> +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT);
> +
> +	return 0;
> +}
> +
> +static void netc_port_del_ptp_filter(struct netc_port *np)
> +{
> +	struct netc_switch *priv = np->switch_priv;
> +	u32 entry_id;
> +	int i;
> +
> +	for (i = 0; i < NETC_PTP_MAX; i++) {
> +		entry_id = np->ptp_ipft_eid[i];
> +		if (entry_id != NTMP_NULL_ENTRY_ID) {
> +			if (!ntmp_ipft_delete_entry(&priv->ntmp, entry_id)) {
> +				np->ptp_ipft_eid[i] = NTMP_NULL_ENTRY_ID;
> +				continue;
> +			}
> +
> +			dev_err(priv->dev,
> +				"Deleting PTP entry 0x%x (type %d) on port %d failed\n",
> +				entry_id, i, np->dp->index);
> +		}
> +	}
> +}

[ ... ]

> +static int netc_port_add_ipft_ptp_entry(struct netc_port *np,
> +					enum netc_ptp_type type)
> +{
> +	struct netc_switch *priv = np->switch_priv;
> +	struct ipft_entry_data *entry;
> +	struct ipft_keye_data *keye;
> +	u32 cfg;
> +	int err;
> +
> +	/* The previously configured PTP entry may not have been successfully
> +	 * deleted, so there is no need to configure it again.
> +	 */
> +	if (np->ptp_ipft_eid[type] != NTMP_NULL_ENTRY_ID)
> +		return 0;

[ ... ]

> +	cfg = FIELD_PREP(IPFT_FLTFA, IPFT_FLTFA_REDIRECT);
> +	cfg |= FIELD_PREP(IPFT_HR, NETC_HR_PTP_TRAP);
> +	cfg |= IPFT_TIMECAPE | IPFT_RRT;
> +	entry->cfge.cfg = cpu_to_le32(cfg);

[ ... ]

> +static int netc_port_set_ptp_filter(struct netc_port *np, int rx_filter)
> +{
> +	int err = 0;
> +
> +	netc_port_del_ptp_filter(np);
> +	np->ptp_rx_filter = HWTSTAMP_FILTER_NONE;
> +
> +	switch (rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		break;

[ ... ]

> +	if (err)
> +		return err;
> +
> +	np->ptp_rx_filter = rx_filter;
> +
> +	return 0;
> +}

[Severity: Medium]

What happens here when ntmp_ipft_delete_entry() fails?

netc_port_del_ptp_filter() is void, and on failure it deliberately keeps
np->ptp_ipft_eid[i] populated and only logs the error. netc_port_set_ptp_filter()
calls it unconditionally, and on the HWTSTAMP_FILTER_NONE path err is never
assigned, so np->ptp_rx_filter is committed and SIOCSHWTSTAMP returns success.

The surviving entries were installed with:

	cfg = FIELD_PREP(IPFT_FLTFA, IPFT_FLTFA_REDIRECT);
	cfg |= FIELD_PREP(IPFT_HR, NETC_HR_PTP_TRAP);
	cfg |= IPFT_TIMECAPE | IPFT_RRT;

so would that port keep diverting all matching PTP frames to the CPU port
(they are no longer bridged) and keep capturing ingress timestamps, while
netc_port_hwtstamp_get() reports the filter as off?

The reverse case is in netc_port_add_ipft_ptp_entry():

	if (np->ptp_ipft_eid[type] != NTMP_NULL_ENTRY_ID)
		return 0;

If the hardware actually executed the delete but the command was reported as
failed (command ring timeout after execution), a later enable request becomes
a silent no-op. Would RX timestamping then stay dead while the driver reports
the filter as enabled?

Nothing retries the deletion, and netc_free_ports_resources() does not touch
np->ptp_ipft_eid[], so the divergence would persist until the driver is
unbound. Would it be reasonable to propagate the delete error out of
netc_port_del_ptp_filter() and fail the ioctl instead?

> +
> +int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
> +			   struct kernel_hwtstamp_config *config,
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct netc_port *np = NETC_PORT(ds, port);
> +	struct netc_switch *priv = ds->priv;
> +	int rx_filter, err;
> +
> +	if ((config->tx_type != HWTSTAMP_TX_OFF ||
> +	     config->rx_filter != HWTSTAMP_FILTER_NONE) &&
> +	    !priv->tmr_dev)
> +		return -EOPNOTSUPP;

[Severity: Medium]

Should this gate use the same condition as netc_get_ts_info()?

get_ts_info() advertises no timestamping capability at all unless a PHC is
registered for tmr_dev:

	info->phc_index = netc_get_phc_index(priv);
	if (info->phc_index < 0)
		return 0;

while the set path only tests that the timer's PCI function exists, and
netc_setup()'s own comment says that function is created during bus
enumeration "even if the timer driver has not probed yet".

Neither net_hwtstamp_validate() nor dsa_user_hwtstamp_set() cross-checks the
driver's ts_info, so HWTSTAMP_TX_ON with HWTSTAMP_FILTER_PTP_V2_EVENT succeeds
and installs the IPFT redirect entries while ethtool reports that the device
supports no hardware timestamping.

The same applies with CONFIG_PTP_1588_CLOCK=n, which the new "depends on
PTP_1588_CLOCK_OPTIONAL" now permits: ptp_clock_index_by_dev() is stubbed to
-1 and ptp_classify_raw() returns PTP_CLASS_NONE, so no timestamp can ever be
produced, yet the set path still returns 0.

On the same subject, netc_port_twostep_tstamp_handler() passes the echoed
value straight on:

	hwtstamps.hwtstamp = ns_to_ktime(ts);
	skb_complete_tx_timestamp(skb_match, &hwtstamps);

whereas the RX path treats zero as "not captured":

	/* ts == 0 indicates the hardware did not capture the RX timestamp
	 * of the frame.
	 */
	if (!ts)
		return false;

Would a zero or frozen counter value from a timer that is not running be
delivered to the socket error queue as a genuine hardware TX timestamp?

[ ... ]

> diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
> index df72a61796ad5..d46576ae2f751 100644
> --- a/net/dsa/tag_netc.c
> +++ b/net/dsa/tag_netc.c

[ ... ]

> @@ -190,16 +300,48 @@ static void netc_flow_dissect(const struct sk_buff *skb, __be16 *proto,
>  	int type = FIELD_GET(NETC_TAG_TYPE, tag_cmn->type);
>  	int tag_len = netc_get_rx_tag_len(type, subtype);
>  
> -	/* The RX minimum frame length of the NETC switch port is 64 bytes,
> -	 * and the frame is received by the ENETC driver. From the hardware
> -	 * perspective, the receive buffer of RX BD is at least 128 bytes,
> -	 * so the switch tag header is guaranteed to be in the linear region
> -	 * of the skb.
> +	/* The CPU port of the switch is connected to the ENETC, so the frame
> +	 * is received by the ENETC driver. From the hardware perspective, the
> +	 * receive buffer of RX BD is at least 128 bytes, so the switch tag
> +	 * header is guaranteed to be in the linear region of the skb.
> +	 *
> +	 * When the subtype of the frame is NETC_TAG_TH_SUBTYPE2, it indicates
> +	 * the frame is a hardware generated timestamp response, which is only
> +	 * 26 bytes (DMAC + SMAC + tag), so the frame has no payload after the
> +	 * tag. Therefore, there is no need to parse the protocol and offset.
> +	 * For other types of the frames, they are all received from the switch
> +	 * ports, and the RX minimum frame length of the port is 64 bytes,
> +	 * frames shorter than 64 bytes will be discarded by the hardware and
> +	 * will not be received by the software.
>  	 */
> +	if (subtype == NETC_TAG_TH_SUBTYPE2)
> +		return;
> +

[Severity: Low]

Should this test also require type == NETC_TAG_TO_HOST?

Everywhere else in this file the subtype nibble is only meaningful under the
To_Host type. netc_get_rx_tag_len() returns NETC_TAG_FORWARD_LEN for any
subtype when the type is not To_Host:

	if (type == NETC_TAG_TO_HOST) {
		if (subtype == NETC_TAG_TH_SUBTYPE1)
			return NETC_TAG_TH_SUBTYPE1_LEN;
		else if (subtype == NETC_TAG_TH_SUBTYPE2)
			return NETC_TAG_TH_SUBTYPE2_LEN;
		else
			return NETC_TAG_TH_SUBTYPE0_LEN;
	}

	return NETC_TAG_FORWARD_LEN;

and netc_rcv() only enters the subtype switch inside its
"else if (type == NETC_TAG_TO_HOST)" branch.

If a Forward-tagged frame (type nibble 0) ever carries a subtype nibble of 2,
netc_flow_dissect() returns before either output is written:

	*offset = tag_len;
	*proto = ((__be16 *)skb->data)[(tag_len / 2) - 1];

__skb_flow_dissect() would then continue with proto == ETH_P_XDSA at offset 0
and produce an all-zero flow key, so those frames all hash to the same bucket
for RPS/RFS/GRO with no diagnostic. Does the hardware guarantee the subtype
nibble is zero in Forward tags, or would
"type == NETC_TAG_TO_HOST && subtype == NETC_TAG_TH_SUBTYPE2" be the safer
guard?

>  	*offset = tag_len;
>  	*proto = ((__be16 *)skb->data)[(tag_len / 2) - 1];
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831082335.1184605-1-wei.fang%40oss.nxp.com

