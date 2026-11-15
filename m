Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB42B606A32E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ko9M+Oay
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jS2Yr0bLWz2y7r;
	Sun, 15 Nov 2026 18:24:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794727472;
	cv=none; b=TN1Z/mOxt/9aQBKME3lAcyvqNT8ytWkICbp+3WuRm0LpOruTRrYZkMbLSdrCJGs/jx3c7g9nA0xzy1c9BpKo1nO2sxR0/Z1cIGA6Y71xC9+I1mw101ET7PBocBt8com+S39kHET3hkaxt3WQBf/os8GCYR8nqKrF95nYz5w37vbSJ1XxLR5zKZF9M1ItjXBHuulVmvNpSpRh2ksCvI4Qtudtbq7JE0GLMYtDwdoMn/n1pGtuYlZmw5m9ngy3JZejBC5m+QnRSKyF3Sn3J25xpkSkorpj0XagcxlQR1C+dQIisZZaJE8PHW2cSadnXKsjzVniH7HueEL0W5A30Mev/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794727472; c=relaxed/relaxed;
	bh=g8XCj3VmupwTgmei3ccSJ336G4V8n0s/RIq73TfG+uE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lhwp9jozNfBoCesSBwiwCQOtQv7GACtrYqlCDha/cgtPHmnzhONKUfoyhX7HonjQbe5GB0BgM2fsSBiJ25AKd1wY0xDYs8zvMV8HEek8+d5oATg/7oH3URPPAx3gVqyelfFtVg3NDAt4bDhjZMiQRcNv110Nfzd7v8mmucvVOBKR7ebUaMUs9Lo6zWxSikwihE5btb96NP8MdgPGkBSE6RV9Zq6ySoSTFBBmUqz+0WjOhDnzIgfFI4g8Rw5pyMdJzewDVK/hhKSLhBt9W/PQrjcPbVZ4LcAVP5bHIMBFwxUa9lgCXfQVARyxE380mZIzZPggvcNy+JsDtqhQl2yFRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ko9M+Oay; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ko9M+Oay;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jS2Yp2RCDz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 18:24:30 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 660EB6123F;
	Sun, 15 Nov 2026 07:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B751F000C9;
	Sun, 15 Nov 2026 07:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794727468;
	bh=g8XCj3VmupwTgmei3ccSJ336G4V8n0s/RIq73TfG+uE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ko9M+OayOZlmNrk9y4ORNlESO+7FTWempV9V5dMDxG/Jn2wnoFB9mqN5XDQCSbfUt
	 756QVfT3V4bKNU9kF1LIkli3jDiR9S0HKAdY0/um8eh3cpHs8zmYEb/Gfop7nEYhSZ
	 h0HbXxvayEWc9SztmE5FO1OrFf6QMbNm3WCPTAT0FeUFcCj03HuhdFmbt2qnvfX9Xu
	 72baXIAbo64Gt+NzoN9R75FJ69HWqD9v6RZv+eIM3dmP9xp9C0k2bxlv/Lg8sEHMWp
	 UQKtEVpygqNKqcMuymm84uzNXJQVoikHB17YlpO2z4fDGSCCdlkYtVpY8SslB0mFkL
	 E+swMDRN8qMkg==
Subject: Re: [PATCH v7 net-next 8/9] net: dsa: netc: add PTP two-step
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
Date: Sun, 15 Nov 2026 07:24:26 +0000
Message-ID: <179472746660.2199510.5760653548195700469@kernel.org>
In-Reply-To: <20261111062753.1397582-9-wei.fang@oss.nxp.com>
References: <20261111062753.1397582-9-wei.fang@oss.nxp.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] net: dsa: netc: incomplete IPFT_FAF_L4_CODE mask in
  netc_build_ptp_ipft_keye()

--

> diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
> --- /dev/null
> +++ b/drivers/net/dsa/netc/netc_ptp.c
> @@ -0,0 +1,504 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * NXP NETC switch driver
> + * Copyright 2025-2026 NXP
> + */
> +
> +#include <linux/ptp_classify.h>
> +#include <linux/ptp_clock_kernel.h>
> +
> +#include "netc_switch.h"
> +
> +#define NETC_NUM_TS_REQ_ID		16
> +#define NETC_TSTAMP_TIMEOUT		(5 * HZ)
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
> +	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp) {
> +		if (time_is_after_jiffies64(NETC_SKB_CB(skb)->ptp_tx_time +
> +					    NETC_TSTAMP_TIMEOUT))
> +			continue;
> +
> +		dev_dbg_ratelimited(np->switch_priv->dev,
> +				    "Port %d ts_req_id %u which seems lost\n",
> +				    np->dp->index, NETC_SKB_CB(skb)->ts_req_id);
> +
> +		__skb_unlink(skb, &np->tstamp_queue);
> +		__skb_queue_tail(&free_list, skb);
> +	}
> +
> +	/* Reschedule if there are still pending clones that have not
> +	 * timed out yet.
> +	 */
> +	if (!skb_queue_empty(&np->tstamp_queue))
> +		schedule_delayed_work(&np->tstamp_timeout_work,
> +				      NETC_TSTAMP_TIMEOUT);
> +
> +	spin_unlock_bh(&np->tstamp_lock);
> +	__skb_queue_purge(&free_list);
> +}
> +
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
> +	if (ts_req_id == NETC_NUM_TS_REQ_ID) {
> +		dev_dbg_ratelimited(np->switch_priv->dev,
> +				    "Port %d has no available ts_req_id\n",
> +				    np->dp->index);
> +		return -ENOSPC;
> +	}
> +
> +	return ts_req_id;
> +}
> +
> +void netc_port_ptp_init(struct netc_port *np)
> +{
> +	spin_lock_init(&np->tstamp_lock);
> +	__skb_queue_head_init(&np->tstamp_queue);
> +	INIT_DELAYED_WORK(&np->tstamp_timeout_work,
> +			  netc_port_tstamp_timeout_work);
> +}
> +
> +void netc_port_purge_tstamp_queue(struct netc_port *np)
> +{
> +	struct sk_buff_head free_list;
> +
> +	__skb_queue_head_init(&free_list);
> +
> +	spin_lock_bh(&np->tstamp_lock);
> +	skb_queue_splice_init(&np->tstamp_queue, &free_list);
> +	spin_unlock_bh(&np->tstamp_lock);
> +
> +	__skb_queue_purge(&free_list);
> +}
> +
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
> +	info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;
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
> +		 * hardware execution time for a command is much less than
> +		 * 1ms, so no timeout error will occur. Any remaining error
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
> +		dev_err(priv->dev,
> +			"Delete PTP entry 0x%x (type %d) on port %d failed\n",
> +			np->ptp_ipft_eid[i], i, np->dp->index);
> +	}
> +
> +	return ret;
> +}
> +
> +static int netc_build_ptp_ipft_keye(struct ipft_keye_data *keye, int port,
> +				    enum netc_ptp_type type)
> +{
> +	u16 src_port, frm_attr_flags;
> +
> +	keye->precedence = cpu_to_le16(NETC_IPFT_PTP_PRECEDENCE);
> +	src_port = FIELD_PREP(IPFT_SRC_PORT, port);
> +	src_port |= IPFT_SRC_PORT_MASK;
> +	keye->src_port = cpu_to_le16(src_port);
> +
> +	switch (type) {
> +	case NETC_PTP_L2:
> +		keye->ethertype = htons(ETH_P_1588);
> +		keye->ethertype_mask = htons(0xffff);
> +		break;
> +	case NETC_PTP_L4_IPV4_EVENT:
> +	case NETC_PTP_L4_IPV4_GENERAL:
> +	case NETC_PTP_L4_IPV6_EVENT:
> +	case NETC_PTP_L4_IPV6_GENERAL:
> +		frm_attr_flags = IPFT_FAF_IP_HDR | FIELD_PREP(IPFT_FAF_L4_CODE,
> +				 IPFT_FAF_UDP_HDR);
> +		if (type == NETC_PTP_L4_IPV6_EVENT ||
> +		    type == NETC_PTP_L4_IPV6_GENERAL)
> +			frm_attr_flags |= IPFT_FAF_IP_VER6;
> +
> +		keye->frm_attr_flags = cpu_to_le16(frm_attr_flags);
> +
> +		/* Set IP version bit in flags_mask to match IPv4 or IPv6
> +		 * packets
> +		 */
> +		frm_attr_flags |= IPFT_FAF_IP_VER6;
> +		keye->frm_attr_flags_mask = cpu_to_le16(frm_attr_flags);
> +		keye->ip_protocol = IPPROTO_UDP;
> +		keye->ip_protocol_mask = 0xff;
> +
> +		if (type == NETC_PTP_L4_IPV4_EVENT ||
> +		    type == NETC_PTP_L4_IPV6_EVENT)
> +			keye->l4_dst_port = htons(PTP_EV_PORT);
> +		else
> +			keye->l4_dst_port = htons(PTP_GEN_PORT);
> +
> +		keye->l4_dst_port_mask = htons(0xffff);
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int netc_port_add_ipft_ptp_entry(struct netc_port *np,
> +					enum netc_ptp_type type)
> +{
> +	struct netc_switch *priv = np->switch_priv;
> +	struct ipft_entry_data *entry;
> +	struct ipft_keye_data *keye;
> +	u32 cfg;
> +	int err;
> +
> +	entry = kzalloc_obj(*entry);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	keye = &entry->keye;
> +	err = netc_build_ptp_ipft_keye(keye, np->dp->index, type);
> +	if (err)
> +		goto free_entry;
> +
> +	cfg = FIELD_PREP(IPFT_FLTFA, IPFT_FLTFA_REDIRECT);
> +	cfg |= FIELD_PREP(IPFT_HR, NETC_HR_PTP_TRAP);
> +	cfg |= IPFT_TIMECAPE | IPFT_RRT;
> +	entry->cfge.cfg = cpu_to_le32(cfg);
> +
> +	err = ntmp_ipft_add_entry(&priv->ntmp, entry);
> +	if (err)
> +		goto free_entry;
> +
> +	np->ptp_ipft_eid[type] = entry->entry_id;
> +
> +free_entry:
> +	kfree(entry);
> +
> +	return err;
> +}
> +
> +static int netc_port_add_l2_ptp_filter(struct netc_port *np)
> +{
> +	return netc_port_add_ipft_ptp_entry(np, NETC_PTP_L2);
> +}
> +
> +static int netc_port_add_l4_ptp_filter(struct netc_port *np)
> +{
> +	int err;
> +
> +	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV4_EVENT);
> +	if (err)
> +		return err;
> +
> +	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV4_GENERAL);
> +	if (err)
> +		goto del_ptp_filter;
> +
> +	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV6_EVENT);
> +	if (err)
> +		goto del_ptp_filter;
> +
> +	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV6_GENERAL);
> +	if (err)
> +		goto del_ptp_filter;
> +
> +	return 0;
> +
> +del_ptp_filter:
> +	netc_port_del_ptp_filter(np);
> +
> +	return err;
> +}
> +
> +static int netc_port_add_l2_l4_ptp_filter(struct netc_port *np)
> +{
> +	int err;
> +
> +	err = netc_port_add_l2_ptp_filter(np);
> +	if (err)
> +		return err;
> +
> +	err = netc_port_add_l4_ptp_filter(np);
> +	if (err)
> +		goto del_ptp_filter;
> +
> +	return 0;
> +
> +del_ptp_filter:
> +	netc_port_del_ptp_filter(np);
> +
> +	return err;
> +}
> +
> +static int netc_port_set_ptp_filter(struct netc_port *np, int rx_filter)
> +{
> +	int err;
> +
> +	err = netc_port_del_ptp_filter(np);
> +	if (err)
> +		return err;
> +
> +	switch (rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> +		err = netc_port_add_l2_ptp_filter(np);
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> +		err = netc_port_add_l4_ptp_filter(np);
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +		err = netc_port_add_l2_l4_ptp_filter(np);
> +		break;
> +	default:
> +		err = -ERANGE;
> +	}
> +
> +	return err;
> +}
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
> +	    netc_get_phc_index(priv) < 0)
> +		return -EOPNOTSUPP;
> +
> +	switch (config->tx_type) {
> +	case HWTSTAMP_TX_ON:
> +	case HWTSTAMP_TX_OFF:
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	switch (config->rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		rx_filter = HWTSTAMP_FILTER_NONE;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> +		rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
> +		rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> +		rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	err = netc_port_set_ptp_filter(np, rx_filter);
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to set PTP filter");
> +		return err;
> +	}
> +
> +	WRITE_ONCE(np->ptp_tx_type, config->tx_type);
> +	config->rx_filter = rx_filter;
> +
> +	return 0;
> +}
> +
> +static int netc_port_current_rx_filter(struct netc_port *np)
> +{
> +	bool l2, l4_v4_ev, l4_v4_gen, l4_v6_ev, l4_v6_gen, l4_any;
> +
> +	l2 = np->ptp_ipft_eid[NETC_PTP_L2] != NTMP_NULL_ENTRY_ID;
> +	l4_v4_ev = np->ptp_ipft_eid[NETC_PTP_L4_IPV4_EVENT] != NTMP_NULL_ENTRY_ID;
> +	l4_v4_gen = np->ptp_ipft_eid[NETC_PTP_L4_IPV4_GENERAL] != NTMP_NULL_ENTRY_ID;
> +	l4_v6_ev = np->ptp_ipft_eid[NETC_PTP_L4_IPV6_EVENT] != NTMP_NULL_ENTRY_ID;
> +	l4_v6_gen = np->ptp_ipft_eid[NETC_PTP_L4_IPV6_GENERAL] != NTMP_NULL_ENTRY_ID;
> +
> +	l4_any = l4_v4_ev || l4_v4_gen || l4_v6_ev || l4_v6_gen;
> +
> +	if (l2 && l4_any)
> +		return HWTSTAMP_FILTER_PTP_V2_EVENT;
> +	if (l4_any)
> +		return HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
> +	if (l2)
> +		return HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
> +
> +	return HWTSTAMP_FILTER_NONE;
> +}
> +
> +int netc_port_hwtstamp_get(struct dsa_switch *ds, int port,
> +			   struct kernel_hwtstamp_config *config)
> +{
> +	struct netc_port *np = NETC_PORT(ds, port);
> +
> +	if (netc_get_phc_index(ds->priv) < 0)
> +		return -EOPNOTSUPP;
> +
> +	config->tx_type = READ_ONCE(np->ptp_tx_type);
> +	config->rx_filter = netc_port_current_rx_filter(np);
> +
> +	return 0;
> +}
> +
> +static void netc_port_prepare_twostep(struct netc_port *np,
> +				      struct sk_buff *nskb)
> +{
> +	struct sk_buff *clone = skb_clone_sk(nskb);
> +	int ts_req_id;
> +
> +	if (unlikely(!clone))
> +		return;
> +
> +	spin_lock_bh(&np->tstamp_lock);
> +
> +	ts_req_id = netc_get_ts_req_id(np);
> +	if (ts_req_id < 0) {
> +		spin_unlock_bh(&np->tstamp_lock);
> +		kfree_skb(clone);
> +		return;
> +	}
> +
> +	NETC_SKB_CB(nskb)->ptp_flag = NETC_PTP_FLAG_TWOSTEP;
> +	NETC_SKB_CB(nskb)->ts_req_id = ts_req_id;
> +	NETC_SKB_CB(clone)->ts_req_id = ts_req_id;
> +	NETC_SKB_CB(clone)->ptp_tx_time = get_jiffies_64();
> +	NETC_SKB_CB(clone)->ptp_flag = NETC_PTP_FLAG_TWOSTEP;
> +	skb_shinfo(clone)->tx_flags |= SKBTX_IN_PROGRESS;
> +	__skb_queue_tail(&np->tstamp_queue, clone);
> +	if (!delayed_work_pending(&np->tstamp_timeout_work))
> +		schedule_delayed_work(&np->tstamp_timeout_work,
> +				      NETC_TSTAMP_TIMEOUT);
> +
> +	spin_unlock_bh(&np->tstamp_lock);
> +}
> +
> +void netc_port_txtstamp_handler(struct dsa_switch *ds, int port,
> +				u8 ts_req_id, u64 ts)
> +{
> +	struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
> +	struct netc_port *np = NETC_PORT(ds, port);
> +	struct skb_shared_hwtstamps hwtstamps;
> +
> +	spin_lock_bh(&np->tstamp_lock);
> +	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp) {
> +		if (NETC_SKB_CB(skb)->ts_req_id != ts_req_id)
> +			continue;
> +
> +		__skb_unlink(skb, &np->tstamp_queue);
> +		skb_match = skb;
> +		break;
> +	}
> +	spin_unlock_bh(&np->tstamp_lock);
> +
> +	if (!skb_match) {
> +		dev_dbg_ratelimited(np->switch_priv->dev,
> +				    "Port %d ts_req_id %u which seems lost\n",
> +				    port, ts_req_id);
> +		return;
> +	}
> +
> +	hwtstamps.hwtstamp = ns_to_ktime(ts);
> +	skb_complete_tx_timestamp(skb_match, &hwtstamps);
> +}
> +
> +bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
> +			unsigned int type)
> +{
> +	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
> +
> +	if (!NETC_SKB_CB(skb)->rx_tstamp_valid)
> +		return false;
> +
> +	hwtstamps->hwtstamp = ns_to_ktime(NETC_SKB_CB(skb)->tstamp);
> +
> +	return false;
> +}
> +
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
> +	/* Only supports PTP v2 */
> +	if (unlikely(ptp_class & PTP_CLASS_V1))
> +		return;
> +
> +	tx_type = READ_ONCE(np->ptp_tx_type);
> +	if (tx_type == HWTSTAMP_TX_ON)
> +		netc_port_prepare_twostep(np, skb);
> +}

[Severity: Low]
The mask is built by reusing frm_attr_flags, which only holds the
value bits. IPFT_FAF_L4_CODE is GENMASK(11, 10) and IPFT_FAF_UDP_HDR
is 2, so FIELD_PREP() sets only bit 11. That means bit 10 of the L4
code field is never set in keye->frm_attr_flags_mask and is treated
as a wildcard. The L4 code part of the key then matches both
IPFT_FAF_UDP_HDR (2) and IPFT_FAF_SCTP_HDR (3), not just UDP.

In practice this is mostly hidden, because the same entry also
matches ip_protocol == IPPROTO_UDP with ip_protocol_mask = 0xff.
SCTP frames are therefore still rejected. Still, the frame attribute
mask is not doing what it appears to do, and it is easy to copy this
pattern into a rule that has no ip_protocol check to back it up.

Should the mask cover the whole field? Something like OR-ing
IPFT_FAF_L4_CODE (and IPFT_FAF_IP_VER6) into the mask separately
from the value would do it. If leaving bit 10 wildcarded is
intentional, a comment saying so would help.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111062753.1397582-1-wei.fang%40oss.nxp.com

