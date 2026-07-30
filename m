Return-Path: <linuxppc-dev+bounces-25109-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378A0C55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 13:02:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9q9z6cVsz2yDs;
	Thu, 30 Jul 2026 23:02:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b9"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785416567;
	cv=none; b=lEPBd+6o/VagHl9HajlZ0uMRh/WkadDwhw3sl7ntAkDjGy76Jdf4S66eOaGUBL3sH2ZX+7DJZc42mivWlRQq90bQe4CyzQegrVFMlsT7x1sUM660a2p461KCE7jST/UzPiLVjQW2tea41gK0bSotvuDIScSF8oO+obaeV87sZ68+Z0FwLhOZNZAAaxr6Ens5Q4hR0UCT7fAk/6vIbNB6YECILhim/tXtanLJdnXOIMHCMNsA6S/F5xXKAmzO8DS/aVjY/G0u4xxTb6iPE4LtLywGN9cx2Gs3gH5g+rCHCSZ4SwUUHAZ6GJcuh7cCsZpPlqZSqJ/rusf1B4KozM2d+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785416567; c=relaxed/relaxed;
	bh=zLMzAM2jhcBcjvUbjDVz8nPB2UWdb+PQz/+bnXZY5Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8EwuWpSSao6OxGn1Y81upr7JNcbo62bjJtVKxKG1x9tsmb72569jAO4UEbIqyLtNkmD3MUvqMmhGrVoYa8FtD5oxVU4ubRvC1D87eNxfltNaAPKmnIgUZv8RS08gK+cOxFKgUECTaHZNrBc6wiTiQCrIljPWB3hHD2lzZYgqsUk18WoMqYdev2WnGAprF9IyHO04BLAZLTgKY/s1foBjApCz3Eqws4gu8R5T3D87LH6zuo2J2uVJdjRnoLA2QpkBx9hU6FfdtKPu03EkFpBTzgVyq908Vkdga97xHu7bCqrk1cbDC/Eo9MphN2zaSwYhlxtGyewBfPOIwNOK9N13Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wBl8/CeK; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b9; helo=out-185.mta0.migadu.com; envelope-from=vadim.fedorenko@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wBl8/CeK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b9; helo=out-185.mta0.migadu.com; envelope-from=vadim.fedorenko@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 84035 seconds by postgrey-1.37 at boromir; Thu, 30 Jul 2026 23:02:45 AEST
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9q9x1w64z2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 23:02:44 +1000 (AEST)
Message-ID: <48631703-cbd9-45ba-b079-c4d94f4cf405@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785416543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zLMzAM2jhcBcjvUbjDVz8nPB2UWdb+PQz/+bnXZY5Sk=;
	b=wBl8/CeKE7+AeEZjGa6VWejw62/EHMA7eEQYOJ3nVvQ7kjaSGESyyQG4pdczMaWLVPNOEK
	9xfo2BxYDy2gNs0som1K/KVC7F/IghOggkT8Ca0xYfBzDMDke2F+sXTlfEgHe7FUlq8DS1
	RqCo+bpdLqximLeWFkxfXBw9iZoZVPI=
Date: Thu, 30 Jul 2026 14:02:19 +0100
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
To: Wei Fang <wei.fang@nxp.com>, "Wei Fang (OSS)" <wei.fang@oss.nxp.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
 "olteanv@gmail.com" <olteanv@gmail.com>
Cc: "chleroy@kernel.org" <chleroy@kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
 <20260728104548.3301214-7-wei.fang@oss.nxp.com>
 <59ecaa4e-f111-4dd4-914a-7704990ac58e@linux.dev>
 <GV2PR04MB11739A4EDB782AB83B60968D988C92@GV2PR04MB11739.eurprd04.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <GV2PR04MB11739A4EDB782AB83B60968D988C92@GV2PR04MB11739.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/07/2026 02:31, Wei Fang wrote:
>>> +int netc_get_ts_info(struct dsa_switch *ds, int port,
>>> +		     struct kernel_ethtool_ts_info *info)
>>> +{
>>> +	struct netc_switch *priv = ds->priv;
>>> +
>>> +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
>>> +				SOF_TIMESTAMPING_RX_SOFTWARE |
>>> +				SOF_TIMESTAMPING_SOFTWARE;
>>
>> SOF_TIMESTAMPING_RX_SOFTWARE and SOF_TIMESTAMPING_SOFTWARE
>> are available
>> by default, no need to add them.
> 
> Yes, you are right, I will remove them.
> 
>>
>> the code doesn't have skb_tx_timestamp() calls, I wonder how is
>> SOF_TIMESTAMPING_TX_SOFTWARE implemented?
> 
> The switch and the conduit port (ENETC) are integrated into the NETC IP,
> so the switch can only connect to the ENETC MAC. And the ENETC driver
> calls skb_tx_timestamp() unconditionally, so I thought
> SOF_TIMESTAMPING_TX_SOFTWARE can be added. I checked the existing
> DSA drivers and found no drivers set this flag, maybe I should remove this
> flag as well. Thanks.

well, you have the hardware, you can actually check if enetc driver 
provides it for you

> 
>>
>>> +
>>> +	info->phc_index = netc_get_phc_index(priv);
>>> +	if (info->phc_index < 0)
>>> +		return 0;
>>> +
>>> +	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
>>> +				 SOF_TIMESTAMPING_RX_HARDWARE |
>>> +				 SOF_TIMESTAMPING_RAW_HARDWARE;
>>> +
>>> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
>>> +
>>> +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
>>> +			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
>>> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
>>> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT);
>>> +
>>> +	return 0;
>>> +}
>>
> 


