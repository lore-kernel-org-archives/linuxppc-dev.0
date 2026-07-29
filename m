Return-Path: <linuxppc-dev+bounces-25014-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934EAC54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 13:49:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9DG54TFWz2xwP;
	Wed, 29 Jul 2026 23:49:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.184
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785332957;
	cv=none; b=Z2D8gIf3h0cGByxLi1l25b3rfPD2IQUKih9ALmEEflr+sziUsUoSwDBpp0oBimpUjiJaQZkJLavw2P808GLVuRC8Z7vsE7ZexgILC3pTGmz1g3ux3qHx0pPRWf3QHTKsD/CiJad3etA34bLRHiUiR15+HDITDGaba6A7hkY2C6a4sPtzwuUrdHQW0hZ01Wac3tgxEjuQ4qO4uzW9Y3j4OJVr099PPZUpAGxFeqNx0FS3hqeZd5j39I2clmXqwo+t4AbzUURM+ZDLTncNTeyJ2qsQkosgztxcW+T8lznaeY6beZHgbMylwyt2n7RqyDJHnuhUIR3ivFbZyErj6XYRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785332957; c=relaxed/relaxed;
	bh=ri/Un0MEVq2R5X4SwViYnsBFp4cF+iTbRU5sEtCszTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBHUgWxCXH2QSAZyO42zkEkPwu1O6TdKqchObtFyBuW45nlJrK721InmHGl6fx3OJI4AOTwNeraOoAC1uMN+++mrI1NYzamOB5LLygZssnEBrqiTueTvoGKaBhNPWtbeD1KrXDeBPaAKiCHjcjMf0EaO98emlpJCM5NBT6Xjm3CR/p+fEVe7kfjp/2lWQiZWaUx1xOCXHN0BtkhnaJF94pHKthy491RE0hqnRWQ1hOgMhreoGMlA25Eic7QgIelRVOvYGJSVcTDK454S2gRiLbTO8XZWbMwM2/Gdy9d7WPIYfZ3ymwg77NqSF781EzSq3+mHb4rJnt2qxi0XXofXOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lzZyWuW/; dkim-atps=neutral; spf=pass (client-ip=91.218.175.184; helo=out-184.mta0.migadu.com; envelope-from=vadim.fedorenko@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lzZyWuW/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.184; helo=out-184.mta0.migadu.com; envelope-from=vadim.fedorenko@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 432 seconds by postgrey-1.37 at boromir; Wed, 29 Jul 2026 23:49:14 AEST
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9DG21zlqz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 23:49:13 +1000 (AEST)
Message-ID: <59ecaa4e-f111-4dd4-914a-7704990ac58e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785332500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ri/Un0MEVq2R5X4SwViYnsBFp4cF+iTbRU5sEtCszTs=;
	b=lzZyWuW/4KOletf2OQGRdK5gpRSxzpGcK7PXG6tHx6wV+i5jWAxhyIkDSdw5wYnC9al3YI
	dAxDsynJHSa1alN2L8/flus0x/FSmMml1q26Bai3GR2vQz85cQm8DlV9ZahxWH/sxbFAbD
	Jb3yyIOxY/QzPSPozyRoN0U27mlYuk8=
Date: Wed, 29 Jul 2026 14:41:36 +0100
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
Subject: Re: [PATCH net-next 6/7] net: dsa: netc: add PTP two-step
 timestamping support
To: wei.fang@oss.nxp.com, richardcochran@gmail.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 olteanv@gmail.com
Cc: wei.fang@nxp.com, chleroy@kernel.org, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
 <20260728104548.3301214-7-wei.fang@oss.nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260728104548.3301214-7-wei.fang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/07/2026 11:45, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> Add two-step TX timestamping and RX timestamping for the NETC switch.
> One-step TX timestamping is not supported yet.
> 
> For RX, install ingress port filter table (IPFT) rules that redirect PTP
> frames to the CPU port. Support L2, L4 over IPv4 and L4 over IPv6, for
> both event and general messages, selected via the hwtstamp rx_filter.
> The hardware prepends a To_Host subtype 1 tag carrying the 64-bit ingress
> timestamp. The tagger extracts it into the skb control buffer, and
> netc_port_rxtstamp() copies it into skb_hwtstamps().
> 
> For two-step TX, clone the skb and allocate a 4-bit timestamp request ID,
> then queue the clone on a per-port list. netc_xmit() emits a To_Port
> subtype 2 tag carrying that ID. The hardware echoes the ID back in a
> generated To_Host subtype 2 response frame together with the 64-bit
> transmit timestamp. The tagger dispatches the ID and timestamp to the
> switch driver through the twostep_tstamp_handler callback registered in
> netc_tagger_data, which matches the queued clone and completes it via
> skb_complete_tx_timestamp(), then frees the response skb. Non-PTP frames
> keep using the To_Port subtype 0 tag on the xmit fast path.
> 
> The two-step response frame carries no payload; its total length is only
> 26 bytes (12 bytes of DMAC and SMAC plus a 14-byte switch tag). By the
> time netc_rcv() sees it, skb->data already points 2 bytes into the switch
> tag, past the TPID shared with the Ethernet header, so skb->len is only
> 12. Since the tag pointer is at (skb->data - 2), the pskb_may_pull() check
> must use NETC_TAG_MAX_LEN - 2 rather than NETC_TAG_MAX_LEN. Otherwise
> pskb_may_pull() drops the response frame and breaks PTP synchronization.
> 
> Add the To_Port subtype 2 and To_Host subtype 1/2 tag structures, extend
> netc_xmit() to select the tag based on ptp_flag in the skb control buffer,
> and add netc_connect()/netc_disconnect() to manage the per-switch
> netc_tagger_data allocation. Grab the PTP timer's pci_dev in netc_setup()
> so get_ts_info() can report its PHC index, and release it in the teardown
> and error paths.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>   drivers/net/dsa/netc/Kconfig         |   1 +
>   drivers/net/dsa/netc/Makefile        |   3 +-
>   drivers/net/dsa/netc/netc_main.c     |  72 +++++
>   drivers/net/dsa/netc/netc_platform.c |   1 +
>   drivers/net/dsa/netc/netc_ptp.c      | 411 +++++++++++++++++++++++++++
>   drivers/net/dsa/netc/netc_switch.h   |  35 +++
>   include/linux/dsa/tag_netc.h         |  23 ++
>   net/dsa/tag_netc.c                   | 120 +++++++-
>   8 files changed, 658 insertions(+), 8 deletions(-)
>   create mode 100644 drivers/net/dsa/netc/netc_ptp.c

[...]

> +int netc_get_ts_info(struct dsa_switch *ds, int port,
> +		     struct kernel_ethtool_ts_info *info)
> +{
> +	struct netc_switch *priv = ds->priv;
> +
> +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
> +				SOF_TIMESTAMPING_RX_SOFTWARE |
> +				SOF_TIMESTAMPING_SOFTWARE;

SOF_TIMESTAMPING_RX_SOFTWARE and SOF_TIMESTAMPING_SOFTWARE are available 
by default, no need to add them.

the code doesn't have skb_tx_timestamp() calls, I wonder how is
SOF_TIMESTAMPING_TX_SOFTWARE implemented?

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



