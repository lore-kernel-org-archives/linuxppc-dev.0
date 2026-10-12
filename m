Return-Path: <linuxppc-dev+bounces-29250-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED56CCA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 09:56:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3CXW6Cpwz3bSn;
	Mon, 12 Oct 2026 20:56:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791798971;
	cv=pass; b=YhhLPPVaX0pps764bOzJUc2EFwanpep7IR12B1M0Xn8ofulU/xW7UF9KtEPO6SnXib0q1FwNQU4zxHacGDf7jdcEwDQNWjUj1ERVeWI3iHZo6opARi0WxxV/TYBXYmDFZChPJRlih+0HCz9rn23vwsyxcSm5QZxEgkJdfBh/INU/wscUrctJtJG7GFBZ5bnxISEiHY2h7D8PQA7J+t0pFL89jKI+LXCQ3mIovoTIATlOqT+lpY7/LLDk6S/iHiQz0EYzkM9Aa1w6MOaF7r23JWdY0vfbmnxe0knVRHBFB61JC4KQOulcAj/0MRbFVOG4S2ird+UVUVVBFfVc4t0ZOA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791798971; c=relaxed/relaxed;
	bh=FlQViY4LLVyUMwOksB1N027hhSc7IP4SgiBeuxePAyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWLN5E17JXwTU0t/QRGEfEDR7wS+QYvNTo5vOqXhedz0qEYS2jQJlXjkz/qXQG4k4jA/+/awTMaPBhnkeGWQmopgSWkTNcljLjVG5GISaO6EolCOG/j8f3CBNrpEszAG1UV3kqAfaXfuFsoNWA4WttRG6wLvReKRGFpjdN5LwnAZURDLIC64Sa4B5UhWuK37J6FCM6kz2BNU2/yXt8BE8QtLoHj+NAZ4Nm/CHl577R5oco/LlGYaJtWXoNq83m1n6S37Ok+IIfzO4ffKRJ7X8rW969tKRjt7PmQuLaUi6ERgKQxXZxUbELTERfcEHj7K2W5+sEyptW5tGuzSsNjEgw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=RyOdbBIZ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=RyOdbBIZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3CXT2rXwz3bSy
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 20:56:09 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqk3kud3l8w4g6Ji+N43iuYmBA/7taYYmai4dUvV+cGVJoMZU4filBdSK7r33LcC9eyUyowtJVr0gR/dR2sXQ79/hoskVwynrmNqWyrPK+3Q7Pa8C/fR+cKv53JHpv/6ROBIYIP4hPezz+ytQQRhUKFOXMBzIWcPsH/uHgVePugoomxzdi6aAgkh3kfIb9+9BaUT9E9ghe5eTQVa7AFQD1vGHw6CcLkDDZS/lYZQmNEQgV2A337NMc1nsn1qiZG2gkexfGfA25ZHyLSqUrJ4ior34vC7FIOoJV7jvzyXN6ozcqNhExWNUF8n2s91WJ6Z9YdFYvzv9X7jGydnHrWevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlQViY4LLVyUMwOksB1N027hhSc7IP4SgiBeuxePAyI=;
 b=OTEXSVGKeegTBWruLrUIVQCHOAROID5R80TEIkfZds8p9XjwCTdz3Wg4vvw0634c78mUWh7JS9q+6nwmI1LfTvrYS7Y6gsD2jpVbX36mwd6w2KmzzW5Cyf+YYb9g/p8O/fpMhZprNGxbdJUmXFbhyChB+mzereHrLGDqj1wmX4+2huSkf8OAeoaMzFyKo7Cl2tj3MQm+KIJdZJBzYiqv6bsmkDgeWp2ceMSe66hX7EkruPnWYZ9YhY9N6pJ0HiMNY+RRd9kkRU4aS+MHOgT9nR6FBgwIB5eM/pkofZuMwICRPBOPpVQUl5r/lvURzSJqOdAftTEsiBPolz4yNJ7olw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlQViY4LLVyUMwOksB1N027hhSc7IP4SgiBeuxePAyI=;
 b=RyOdbBIZFkCKTYrw31DxrR8rK2GrWLeYo1Ly6FnOup01iDQKx3xgZwTA3aAaegmSBsG66o8V+DhxB5mwVfxFDfGyv7Y4/6WWlAbE6OgwPIrQK1zuvBJLh57aZDhquQSSJRTQ2ci9G2oQnwuppI2htoNJeczI0iln/6wuctrgSPWgrSAKFTxZDg0x6Sf4EIsItOflX2hgiMdwupxLDuMTb63SFzan69zW0Kcb8uf53uc+QfeD/zM+SX1uZAjzC/M1SZlaWvlLtLoRIlGWykz0FdXKh/aNtMrc2Y7XGBkoOW+j/CxWP6IHlp5kaPJNNZQEwJdWIqzMMWzPALKC8T2rRA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VE1PR04MB7248.eurprd04.prod.outlook.com (2603:10a6:800:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 09:55:45 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0496.018; Mon, 12 Oct 2026
 09:55:45 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	linusw@kernel.org
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 8/9] net: dsa: netc: add PTP two-step timestamping support
Date: Mon, 12 Oct 2026 17:59:23 +0800
Message-Id: <20261012095924.1129312-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
References: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VE1PR04MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b8a790-d883-469a-42fc-08df2846fbbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|19092799006|376014|7416014|10067099003|3023799007|261009223027099003|921020|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	FA22nQlV5O5LYybmA8p9QtUFKuqNav3HMSDMmbJ22MWuiTcpYHDFcVTiprOHZDhisgUHaGaTVEbo1Zna5Fy4C3c4UDWbdsdaf6Ix2tteEZwAna/T2gJHiKVE9ysRgc0Oo5VixcDMiUVYVD9ZehQEIbizYfHkr9nrIXOxRwui1VjdzwwIi2XzgAEUJtCAUyj7XD4vVukwAgUXfTpXwBpJPXDiofS7dXWmOhzF3zQ3QQP+1+IFKJrulb/LVPlDS8cuDXQ+cVlLan46T7zng+GDO7HzAv362bjxF6Zav+dgzWV+OqxEj6S5xIwaUSO8zfUWw6lQrN20m5SsDfE7mmuqP/zOIY3GoDGZ/FHyj82LsQK0n4mUfKOQ5Q5/sE1a77tF2FjW2mHCYMb1heTev+DRH+DRpUly/40pkKb+sS1sdL1OFIUpNC8DMveHfU+YTyK6Yjq+iteVcO+Lee0P+/2K25omqkqWFn9sj/nunmC5usHmvGYERAwOi5gN6XFOmV4JapcPxNzL1etqnxx8d+Xk8OUFMXDSOPM4dT8fzzXH0mT5atGeJ6aAmtAK0ts2755wWm3Mi59Yo0MMdgHcRrQCkLhqwfht9i1F8YY3x7j1mix8KXBUX1KH5SCSw/hoMYQ9mP+taBay7f3jV3OPI5TFBUdtOGqeEcD+RmyY2Vzh5As48a0Vzo023GipxR0l9qYSTjVm8QmRmj5JnuVcRZ7c+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(19092799006)(376014)(7416014)(10067099003)(3023799007)(261009223027099003)(921020)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ux8ttGoyA0u5v18mE6FSEFuk4bTutVqH1yNHA40G5kfo8om/fIhwXpM7arzt?=
 =?us-ascii?Q?oKdY/FaVFwlus/gimumPSVL71S//72jL972MZ/3SYcPYkOAwbXA/uzlUj0P1?=
 =?us-ascii?Q?D+1vERz1Ik9ICli56tnjIzVkDQsgh7K5oLY4cS8E7QlVCmQXs5+oqkRBy0Ot?=
 =?us-ascii?Q?TriGnN9HPEvTgmV1fqTdq2k+Vwg4PO2+eMl+0NtB7t0GkDwfDnyftRCvJ0qb?=
 =?us-ascii?Q?lY5XenEbu9U3fg1VzstVJX21FdmCkyYZwKAWBnJlu2zp9CYD8i0BHpJ6nMX4?=
 =?us-ascii?Q?Go0nO/y/UW/tFsZpjLOhWxir5npdPlrjOyF22kwz72JW9ET8sydupa9YGyTB?=
 =?us-ascii?Q?ExU/4ympYCo+a20ijyi8WVGy6S2qOUyXPFt6Msz+OIHUPe7+zas6vcukMaKc?=
 =?us-ascii?Q?HMlxpxRvuB4ji6w8vMBaIymDktAH7M5/doQOQNbv6RsDmcDYvP+BrnyAUgoY?=
 =?us-ascii?Q?g/clQaP/mcrGjdv3cQLlbang1DuucZvJyvBD8T+gYC0BX1hZjR04NU5v1/rQ?=
 =?us-ascii?Q?MaNeI8aNonUZJBhci5vgHikfDlI2OM95a+cFgjAlESE52s7xjQcJCtF9OCb6?=
 =?us-ascii?Q?xfdqnowgxDZkhIFQ/TabCYR6zQacxoyX2pGqHVrhWcWiZxvMe7YDMKtwatBR?=
 =?us-ascii?Q?x67GhTmnf9DAoMTCRg2AqbkEaJtR+etawJnwBhsgn29UjpAl0wpYvXSdiENp?=
 =?us-ascii?Q?GavlEJesMTQsI7UYepp4J4yiygS4Mid6isdjpoC4DOgx87xkgKEc4x5EyKIa?=
 =?us-ascii?Q?EpKIDowD4tjEAFE/W0660ZHPbWCAl5hKocG3Z6jOy0dlTyJDwfAPZv/y7Eu2?=
 =?us-ascii?Q?4xeFq7nKEFwHgA0+7f0FfNo6/PQjycnUJpuX5OiI97OvSFFmRuFdT9ORUDjR?=
 =?us-ascii?Q?/T/CUWSGioyt+zLdCY97bI3w9OEJBLbZJcrq7qJAVdxoghi8/Fa/E/Ui5nPe?=
 =?us-ascii?Q?mXN8dk1daPzsiT30kgfmMw9nlolN+67U1kdBIi89+mhFYAhYW4wgQuFQGR3l?=
 =?us-ascii?Q?seqUJbkDFrDJ9likiued16eVyh7M6f7tA6T1Rzbnvgx6NdGvWAen3FogdCM6?=
 =?us-ascii?Q?NZhUJjsTsLBBy4EGhzLv1Fi1LxJx336bqnnZCikGYJqQnl9YY2XDJf0zeEiY?=
 =?us-ascii?Q?5X6NfXTo5i9T6+fUfDtbXJ58AHTqj7bJWlfr6CQ7Rt61XorbKlKmZorz/fuJ?=
 =?us-ascii?Q?9dzQRdVSjM4Cx51m8XNhmKcEkG8ljoOLy7VybHuyH3y0+sn/+VrIulOWqizf?=
 =?us-ascii?Q?dSmyDaAX0skk40OYVq1mRhoqxzq9hbz2o47y3ot8FGM/uFTgvSQqCVLhNm55?=
 =?us-ascii?Q?QPEQMu7/8JcWKDi/hgXO4nJDTvwR3YWRfmk5g33QBbYEF9TDsanlJTxlXEq4?=
 =?us-ascii?Q?o8/IADP9Y0UrHatIOywhXYiIwTG6a4cxtZb5oCa87a+wuZXYncYfTUKJrQzP?=
 =?us-ascii?Q?zjE7T5ng5WZAqMK+krYQSrSkHgxl9qhUyESM0UJciRjf/trJAIAkMrOusVbc?=
 =?us-ascii?Q?yel1T+srqgVvk1ow3Ay/ssyfDRNQQCcmMStE8uWMjVOLU9nlXBeSIdwpuvlr?=
 =?us-ascii?Q?O5vb1rCZmx+u0RNnqhxpWS3J/rVoqANXym7UwoQ24a6KhJCrc9Gao7Ma0M2d?=
 =?us-ascii?Q?2sOY4jwVJCV1E4pQV5vAbtjvahvaYaXdMf5S7ZLwMB1dRoOHdisrQF+ptH5Q?=
 =?us-ascii?Q?wC4grUgzj2NUB4ZB5X8KEZYeV2yZkUKI8jSP2JV2/yk9aIHyhh6NrD/ugZ9/?=
 =?us-ascii?Q?04/kWGzKTWzWm77oHmM+ZR9D9Y3N7g04UdtDIYHcaMiiuF0Rn6q9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b8a790-d883-469a-42fc-08df2846fbbe
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:55:45.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrfAwl4B59IFxvvM9C7/O0cywnS0lf8uVdZwKU7ilg9QTyvIomnhDxWWChbJMol+NRZEhiZwi/B+0CaI1azZ9Kltxeom7hrUVPeyKaE+L/OpbZCMPTNDT1AYKAESbM/G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7248

From: Wei Fang <wei.fang@nxp.com>

Add two-step TX timestamping and RX timestamping for the NETC switch.

For RX, install ingress port filter table (IPFT) rules that redirect
PTP frames to the CPU port, covering L2, L4 over IPv4 and L4 over IPv6
according to the hwtstamp rx_filter. The hardware inserts a To_Host
subtype 1 tag carrying the ingress timestamp, which the tagger extracts
into the skb control buffer for netc_port_rxtstamp() to report.

Track the installed rules only through the per-port ptp_ipft_eid[]
handles, and let netc_port_hwtstamp_get() derive the active filter from
them at read time, so a delete or rollback that fails partway does not
leave software reporting a filter that no longer matches the hardware.
The four L4 handles are installed and removed as one unit, so treat any
surviving L4 handle as L4 active to avoid hiding rules that still trap
frames to the CPU.

For two-step TX, clone the skb, assign a per-port timestamp request ID,
and queue the clone. netc_xmit() carries the same ID in the To_Port
subtype 2 tag of the transmitted frame. The hardware then returns a
To_Host subtype 2 response frame echoing that ID and the transmit
timestamp. The tagger dispatches both to the driver through the
txtstamp_handler callback in netc_tagger_data, which matches the ID to
the queued clone and completes it via skb_complete_tx_timestamp().
Non-PTP frames keep using the To_Port subtype 0 tag on the fast path.

The response frame carries no payload and is only 26 bytes long. As
eth_type_trans() advances skb->data past the DMAC, SMAC and TPID, the
tag starts at (skb->data - 2), so the pskb_may_pull() check must use
(NETC_TAG_MAX_LEN - 2) to avoid dropping the response frame.

Manage request IDs per port: each transmit takes the first ID not in
flight, and an ID is freed once its clone leaves the queue. A per-port
delayed work drops any clone left unmatched for 5 seconds, far beyond
the hardware's normal response latency.

The response tag carries only the 4-bit ID and no PTP sequenceId, so a
clone can be matched by that ID alone. If a frame cannot leave the port
for over 5 seconds, its clone is dropped and the ID is reused while the
response may still be in flight, so a stale response can complete the
wrong clone. This only occurs after the link has been unable to transmit
for that long, when PTP has already lost sync, so the mismatch affects
only the first few frames right after recovery and is absorbed by the
PTP servo. Accept this as a trade-off imposed by the hardware matching
limit.

Select the TX tag from ptp_flag in netc_xmit(), and implement the DSA
connect_tag_protocol() callback to wire netc_port_txtstamp_handler()
into tagger_data->txtstamp_handler, so the tagger can hand the parsed
response ID and timestamp back to the driver. Grab the PTP timer's
pci_dev in netc_setup() so get_ts_info() can report its PHC index, and
release it on teardown and error paths.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/Kconfig         |   1 +
 drivers/net/dsa/netc/Makefile        |   3 +-
 drivers/net/dsa/netc/netc_main.c     |  58 ++-
 drivers/net/dsa/netc/netc_platform.c |   1 +
 drivers/net/dsa/netc/netc_ptp.c      | 505 +++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h   |  41 +++
 include/linux/dsa/tag_netc.h         |  21 ++
 net/dsa/tag_netc.c                   | 165 ++++++++-
 8 files changed, 781 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/dsa/netc/netc_ptp.c

diff --git a/drivers/net/dsa/netc/Kconfig b/drivers/net/dsa/netc/Kconfig
index 793f7691a24f..8770b65d0f62 100644
--- a/drivers/net/dsa/netc/Kconfig
+++ b/drivers/net/dsa/netc/Kconfig
@@ -4,6 +4,7 @@ config NET_DSA_NETC_SWITCH
 	depends on ARM64 || COMPILE_TEST
 	depends on NET_DSA && PCI
 	depends on NET_VENDOR_FREESCALE
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select NET_DSA_TAG_NETC
 	select FSL_ENETC_MDIO
 	select NXP_NTMP
diff --git a/drivers/net/dsa/netc/Makefile b/drivers/net/dsa/netc/Makefile
index f40b13c702e0..572b833ad80f 100644
--- a/drivers/net/dsa/netc/Makefile
+++ b/drivers/net/dsa/netc/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_NET_DSA_NETC_SWITCH) += nxp-netc-switch.o
-nxp-netc-switch-objs := netc_main.o netc_platform.o netc_ethtool.o
+nxp-netc-switch-objs := netc_main.o netc_platform.o netc_ethtool.o \
+			netc_ptp.o
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 1a7103fe1e34..cb262ae5ba79 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -65,6 +65,20 @@ netc_get_tag_protocol(struct dsa_switch *ds, int port,
 	return DSA_TAG_PROTO_NETC;
 }
 
+static int netc_connect_tag_protocol(struct dsa_switch *ds,
+				     enum dsa_tag_protocol proto)
+{
+	struct netc_tagger_data *tagger_data;
+
+	if (proto != DSA_TAG_PROTO_NETC)
+		return -EPROTONOSUPPORT;
+
+	tagger_data = ds->tagger_data;
+	tagger_data->txtstamp_handler = netc_port_txtstamp_handler;
+
+	return 0;
+}
+
 static void netc_port_rmw(struct netc_port *np, u32 reg,
 			  u32 mask, u32 val)
 {
@@ -277,6 +291,11 @@ static void netc_free_all_ports(struct netc_switch *priv)
 		if (!np)
 			continue;
 
+		if (np->dp && dsa_port_is_user(np->dp)) {
+			disable_delayed_work_sync(&np->tstamp_timeout_work);
+			netc_port_purge_tstamp_queue(np);
+		}
+
 		netc_port_free_emdio_bus(np);
 
 		if (!IS_ERR_OR_NULL(np->ref_clk)) {
@@ -346,6 +365,15 @@ static int netc_init_all_ports(struct netc_switch *priv)
 				dev_err(dev, "Failed to create MDIO bus\n");
 				goto free_all_ports;
 			}
+
+			/* Only the user port needs to support PTP feature, so
+			 * PTP-related resources, such as tstamp_queue,
+			 * tstamp_lock, etc., are initialized only for the user
+			 * port.
+			 */
+			err = netc_port_ptp_init(np);
+			if (err)
+				return err;
 		}
 	}
 
@@ -962,6 +990,15 @@ static int netc_switch_reset(struct netc_switch *priv)
 	return pci_reset_function(priv->pdev);
 }
 
+static struct pci_dev *netc_get_ptp_timer(struct netc_switch *priv)
+{
+	struct pci_bus *bus = priv->pdev->bus;
+	u32 devfn = priv->info->tmr_devfn;
+
+	return pci_get_domain_bus_and_slot(pci_domain_nr(bus),
+					   bus->number, devfn);
+}
+
 static int netc_setup(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -978,9 +1015,19 @@ static int netc_setup(struct dsa_switch *ds)
 
 	netc_get_switch_capabilities(priv);
 
+	/* The PTP timer sits on the same PCI bus as the switch. PCI creates
+	 * every function's pci_dev during bus enumeration, before any driver
+	 * probes, so we can grab the timer's pci_dev here even if the timer
+	 * driver has not probed yet.
+	 */
+	priv->tmr_dev = netc_get_ptp_timer(priv);
+	if (!priv->tmr_dev)
+		dev_info(priv->dev,
+			 "PTP timer PCI device not found\n");
+
 	err = netc_init_all_ports(priv);
 	if (err)
-		return err;
+		goto put_ptp_timer;
 
 	err = netc_init_ntmp_user(priv);
 	if (err)
@@ -1026,6 +1073,8 @@ static int netc_setup(struct dsa_switch *ds)
 	netc_free_ntmp_user(priv);
 free_all_ports:
 	netc_free_all_ports(priv);
+put_ptp_timer:
+	pci_dev_put(priv->tmr_dev);
 
 	return err;
 }
@@ -1047,6 +1096,7 @@ static void netc_teardown(struct dsa_switch *ds)
 	netc_free_ntmp_user(priv);
 	netc_switch_free_bpt_list(priv);
 	netc_free_all_ports(priv);
+	pci_dev_put(priv->tmr_dev);
 }
 
 static bool netc_port_is_emdio_consumer(struct device_node *node)
@@ -2503,6 +2553,7 @@ static const struct phylink_mac_ops netc_phylink_mac_ops = {
 
 static const struct dsa_switch_ops netc_switch_ops = {
 	.get_tag_protocol		= netc_get_tag_protocol,
+	.connect_tag_protocol		= netc_connect_tag_protocol,
 	.setup				= netc_setup,
 	.teardown			= netc_teardown,
 	.phylink_get_caps		= netc_phylink_get_caps,
@@ -2531,6 +2582,11 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.get_sset_count			= netc_port_get_sset_count,
 	.get_strings			= netc_port_get_strings,
 	.get_ethtool_stats		= netc_port_get_ethtool_stats,
+	.get_ts_info			= netc_get_ts_info,
+	.port_hwtstamp_set		= netc_port_hwtstamp_set,
+	.port_hwtstamp_get		= netc_port_hwtstamp_get,
+	.port_rxtstamp			= netc_port_rxtstamp,
+	.port_txtstamp			= netc_port_txtstamp,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
index 34aeb6fceb3c..4fd0ce6770c3 100644
--- a/drivers/net/dsa/netc/netc_platform.c
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -50,6 +50,7 @@ static void imx94_switch_phylink_get_caps(int port,
 
 static const struct netc_switch_info imx94_info = {
 	.num_ports = 4,
+	.tmr_devfn = PCI_DEVFN(0, 1),
 	.phylink_get_caps = imx94_switch_phylink_get_caps,
 };
 
diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
new file mode 100644
index 000000000000..756c69a02064
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_ptp.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC switch driver
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/ptp_classify.h>
+#include <linux/ptp_clock_kernel.h>
+
+#include "netc_switch.h"
+
+#define NETC_NUM_TS_REQ_ID		16
+#define NETC_TSTAMP_TIMEOUT		(5 * HZ)
+
+static void netc_port_tstamp_timeout_work(struct work_struct *work)
+{
+	struct netc_port *np = container_of(work, struct netc_port,
+					    tstamp_timeout_work.work);
+	struct sk_buff_head free_list;
+	struct sk_buff *skb, *skb_tmp;
+
+	__skb_queue_head_init(&free_list);
+
+	spin_lock_bh(&np->tstamp_lock);
+	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp) {
+		if (time_is_after_jiffies64(NETC_SKB_CB(skb)->ptp_tx_time +
+					    NETC_TSTAMP_TIMEOUT))
+			continue;
+
+		dev_dbg_ratelimited(np->switch_priv->dev,
+				    "Port %d ts_req_id %u which seems lost\n",
+				    np->dp->index, NETC_SKB_CB(skb)->ts_req_id);
+
+		__skb_unlink(skb, &np->tstamp_queue);
+		__skb_queue_tail(&free_list, skb);
+	}
+
+	/* Reschedule if there are still pending clones that have not
+	 * timed out yet.
+	 */
+	if (!skb_queue_empty(&np->tstamp_queue))
+		schedule_delayed_work(&np->tstamp_timeout_work,
+				      NETC_TSTAMP_TIMEOUT);
+
+	spin_unlock_bh(&np->tstamp_lock);
+	__skb_queue_purge(&free_list);
+}
+
+static int netc_get_ts_req_id(struct netc_port *np)
+{
+	DECLARE_BITMAP(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
+	struct sk_buff *skb, *skb_tmp;
+	unsigned long ts_req_id;
+
+	bitmap_zero(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
+
+	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp)
+		__set_bit(NETC_SKB_CB(skb)->ts_req_id, ts_req_id_bitmap);
+
+	ts_req_id = find_first_zero_bit(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
+	if (ts_req_id == NETC_NUM_TS_REQ_ID) {
+		dev_dbg_ratelimited(np->switch_priv->dev,
+				    "Port %d has no available ts_req_id\n",
+				    np->dp->index);
+		return -ENOSPC;
+	}
+
+	return ts_req_id;
+}
+
+int netc_port_ptp_init(struct netc_port *np)
+{
+	/* Initialize to invalid entry IDs */
+	for (int i = 0; i < NETC_PTP_MAX; i++)
+		np->ptp_ipft_eid[i] = NTMP_NULL_ENTRY_ID;
+
+	spin_lock_init(&np->tstamp_lock);
+	__skb_queue_head_init(&np->tstamp_queue);
+	INIT_DELAYED_WORK(&np->tstamp_timeout_work,
+			  netc_port_tstamp_timeout_work);
+
+	return 0;
+}
+
+void netc_port_purge_tstamp_queue(struct netc_port *np)
+{
+	struct sk_buff_head free_list;
+
+	__skb_queue_head_init(&free_list);
+
+	spin_lock_bh(&np->tstamp_lock);
+	skb_queue_splice_init(&np->tstamp_queue, &free_list);
+	spin_unlock_bh(&np->tstamp_lock);
+
+	__skb_queue_purge(&free_list);
+}
+
+static int netc_get_phc_index(struct netc_switch *priv)
+{
+	if (!priv->tmr_dev)
+		return -1;
+
+	return ptp_clock_index_by_dev(&priv->tmr_dev->dev);
+}
+
+int netc_get_ts_info(struct dsa_switch *ds, int port,
+		     struct kernel_ethtool_ts_info *info)
+{
+	struct netc_switch *priv = ds->priv;
+
+	info->phc_index = netc_get_phc_index(priv);
+	if (info->phc_index < 0)
+		return 0;
+
+	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
+				 SOF_TIMESTAMPING_RX_HARDWARE |
+				 SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT);
+
+	return 0;
+}
+
+static int netc_port_del_ptp_filter(struct netc_port *np)
+{
+	struct netc_switch *priv = np->switch_priv;
+	int ret = 0;
+	int err;
+
+	for (int i = 0; i < NETC_PTP_MAX; i++) {
+		if (np->ptp_ipft_eid[i] == NTMP_NULL_ENTRY_ID)
+			continue;
+
+		/* No -ETIMEDOUT here: with the command BD ring enabled, the
+		 * hardware never times out on a command. Any remaining error
+		 * means the entry is still present in the table.
+		 */
+		err = ntmp_ipft_delete_entry(&priv->ntmp,
+					     np->ptp_ipft_eid[i]);
+		if (likely(!err)) {
+			np->ptp_ipft_eid[i] = NTMP_NULL_ENTRY_ID;
+			continue;
+		}
+
+		ret = err;
+		dev_err(priv->dev,
+			"Delete PTP entry 0x%x (type %d) on port %d failed\n",
+			np->ptp_ipft_eid[i], i, np->dp->index);
+	}
+
+	return ret;
+}
+
+static int netc_build_ptp_ipft_keye(struct ipft_keye_data *keye, int port,
+				    enum netc_ptp_type type)
+{
+	u16 src_port, frm_attr_flags;
+
+	keye->precedence = cpu_to_le16(NETC_IPFT_PTP_PRECEDENCE);
+	src_port = FIELD_PREP(IPFT_SRC_PORT, port);
+	src_port |= IPFT_SRC_PORT_MASK;
+	keye->src_port = cpu_to_le16(src_port);
+
+	switch (type) {
+	case NETC_PTP_L2:
+		keye->ethertype = htons(ETH_P_1588);
+		keye->ethertype_mask = htons(0xffff);
+		break;
+	case NETC_PTP_L4_IPV4_EVENT:
+	case NETC_PTP_L4_IPV4_GENERAL:
+	case NETC_PTP_L4_IPV6_EVENT:
+	case NETC_PTP_L4_IPV6_GENERAL:
+		frm_attr_flags = IPFT_FAF_IP_HDR | FIELD_PREP(IPFT_FAF_L4_CODE,
+				 IPFT_FAF_UDP_HDR);
+		if (type == NETC_PTP_L4_IPV6_EVENT ||
+		    type == NETC_PTP_L4_IPV6_GENERAL)
+			frm_attr_flags |= IPFT_FAF_IP_VER6;
+
+		keye->frm_attr_flags = cpu_to_le16(frm_attr_flags);
+
+		/* Set IP version bit in flags_mask to match IPv4 or IPv6
+		 * packets
+		 */
+		frm_attr_flags |= IPFT_FAF_IP_VER6;
+		keye->frm_attr_flags_mask = cpu_to_le16(frm_attr_flags);
+		keye->ip_protocol = IPPROTO_UDP;
+		keye->ip_protocol_mask = 0xff;
+
+		if (type == NETC_PTP_L4_IPV4_EVENT ||
+		    type == NETC_PTP_L4_IPV6_EVENT)
+			keye->l4_dst_port = htons(PTP_EV_PORT);
+		else
+			keye->l4_dst_port = htons(PTP_GEN_PORT);
+
+		keye->l4_dst_port_mask = htons(0xffff);
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+static int netc_port_add_ipft_ptp_entry(struct netc_port *np,
+					enum netc_ptp_type type)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct ipft_entry_data *entry;
+	struct ipft_keye_data *keye;
+	u32 cfg;
+	int err;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+
+	keye = &entry->keye;
+	err = netc_build_ptp_ipft_keye(keye, np->dp->index, type);
+	if (err)
+		goto free_entry;
+
+	cfg = FIELD_PREP(IPFT_FLTFA, IPFT_FLTFA_REDIRECT);
+	cfg |= FIELD_PREP(IPFT_HR, NETC_HR_PTP_TRAP);
+	cfg |= IPFT_TIMECAPE | IPFT_RRT;
+	entry->cfge.cfg = cpu_to_le32(cfg);
+
+	err = ntmp_ipft_add_entry(&priv->ntmp, entry);
+	if (err)
+		goto free_entry;
+
+	np->ptp_ipft_eid[type] = entry->entry_id;
+
+free_entry:
+	kfree(entry);
+
+	return err;
+}
+
+static int netc_port_add_l2_ptp_filter(struct netc_port *np)
+{
+	return netc_port_add_ipft_ptp_entry(np, NETC_PTP_L2);
+}
+
+static int netc_port_add_l4_ptp_filter(struct netc_port *np)
+{
+	int err;
+
+	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV4_EVENT);
+	if (err)
+		return err;
+
+	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV4_GENERAL);
+	if (err)
+		goto del_ptp_filter;
+
+	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV6_EVENT);
+	if (err)
+		goto del_ptp_filter;
+
+	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV6_GENERAL);
+	if (err)
+		goto del_ptp_filter;
+
+	return 0;
+
+del_ptp_filter:
+	netc_port_del_ptp_filter(np);
+
+	return err;
+}
+
+static int netc_port_add_l2_l4_ptp_filter(struct netc_port *np)
+{
+	int err;
+
+	err = netc_port_add_l2_ptp_filter(np);
+	if (err)
+		return err;
+
+	err = netc_port_add_l4_ptp_filter(np);
+	if (err)
+		goto del_ptp_filter;
+
+	return 0;
+
+del_ptp_filter:
+	netc_port_del_ptp_filter(np);
+
+	return err;
+}
+
+static int netc_port_set_ptp_filter(struct netc_port *np, int rx_filter)
+{
+	int err;
+
+	err = netc_port_del_ptp_filter(np);
+	if (err)
+		return err;
+
+	switch (rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+		err = netc_port_add_l2_ptp_filter(np);
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+		err = netc_port_add_l4_ptp_filter(np);
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+		err = netc_port_add_l2_l4_ptp_filter(np);
+		break;
+	default:
+		err = -ERANGE;
+	}
+
+	return err;
+}
+
+int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct netc_switch *priv = ds->priv;
+	int rx_filter, err;
+
+	if ((config->tx_type != HWTSTAMP_TX_OFF ||
+	     config->rx_filter != HWTSTAMP_FILTER_NONE) &&
+	    netc_get_phc_index(priv) < 0)
+		return -EOPNOTSUPP;
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_ON:
+	case HWTSTAMP_TX_OFF:
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		rx_filter = HWTSTAMP_FILTER_NONE;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+		rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+		rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+		rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	err = netc_port_set_ptp_filter(np, rx_filter);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to set PTP filter");
+		return err;
+	}
+
+	WRITE_ONCE(np->ptp_tx_type, config->tx_type);
+	config->rx_filter = rx_filter;
+
+	return 0;
+}
+
+static int netc_port_current_rx_filter(struct netc_port *np)
+{
+	bool l2, l4_v4_ev, l4_v4_gen, l4_v6_ev, l4_v6_gen, l4_any;
+
+	l2 = np->ptp_ipft_eid[NETC_PTP_L2] != NTMP_NULL_ENTRY_ID;
+	l4_v4_ev = np->ptp_ipft_eid[NETC_PTP_L4_IPV4_EVENT] != NTMP_NULL_ENTRY_ID;
+	l4_v4_gen = np->ptp_ipft_eid[NETC_PTP_L4_IPV4_GENERAL] != NTMP_NULL_ENTRY_ID;
+	l4_v6_ev = np->ptp_ipft_eid[NETC_PTP_L4_IPV6_EVENT] != NTMP_NULL_ENTRY_ID;
+	l4_v6_gen = np->ptp_ipft_eid[NETC_PTP_L4_IPV6_GENERAL] != NTMP_NULL_ENTRY_ID;
+
+	l4_any = l4_v4_ev || l4_v4_gen || l4_v6_ev || l4_v6_gen;
+
+	if (l2 && l4_any)
+		return HWTSTAMP_FILTER_PTP_V2_EVENT;
+	if (l4_any)
+		return HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
+	if (l2)
+		return HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+
+	return HWTSTAMP_FILTER_NONE;
+}
+
+int netc_port_hwtstamp_get(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	config->tx_type = READ_ONCE(np->ptp_tx_type);
+	config->rx_filter = netc_port_current_rx_filter(np);
+
+	return 0;
+}
+
+static void netc_port_prepare_twostep(struct netc_port *np,
+				      struct sk_buff *nskb)
+{
+	struct sk_buff *clone = skb_clone_sk(nskb);
+	int ts_req_id;
+
+	if (unlikely(!clone))
+		return;
+
+	spin_lock_bh(&np->tstamp_lock);
+
+	ts_req_id = netc_get_ts_req_id(np);
+	if (ts_req_id < 0) {
+		spin_unlock_bh(&np->tstamp_lock);
+		kfree_skb(clone);
+		return;
+	}
+
+	NETC_SKB_CB(nskb)->ptp_flag = NETC_PTP_FLAG_TWOSTEP;
+	NETC_SKB_CB(nskb)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(clone)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(clone)->ptp_tx_time = get_jiffies_64();
+	NETC_SKB_CB(clone)->ptp_flag = NETC_PTP_FLAG_TWOSTEP;
+	skb_shinfo(clone)->tx_flags |= SKBTX_IN_PROGRESS;
+	__skb_queue_tail(&np->tstamp_queue, clone);
+	if (!delayed_work_pending(&np->tstamp_timeout_work))
+		schedule_delayed_work(&np->tstamp_timeout_work,
+				      NETC_TSTAMP_TIMEOUT);
+
+	spin_unlock_bh(&np->tstamp_lock);
+}
+
+void netc_port_txtstamp_handler(struct dsa_switch *ds, int port,
+				u8 ts_req_id, u64 ts)
+{
+	struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct skb_shared_hwtstamps hwtstamps;
+
+	spin_lock_bh(&np->tstamp_lock);
+	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp) {
+		if (NETC_SKB_CB(skb)->ts_req_id != ts_req_id)
+			continue;
+
+		__skb_unlink(skb, &np->tstamp_queue);
+		skb_match = skb;
+		break;
+	}
+	spin_unlock_bh(&np->tstamp_lock);
+
+	if (!skb_match) {
+		dev_dbg_ratelimited(np->switch_priv->dev,
+				    "Port %d ts_req_id %u which seems lost\n",
+				    port, ts_req_id);
+		return;
+	}
+
+	hwtstamps.hwtstamp = ns_to_ktime(ts);
+	skb_complete_tx_timestamp(skb_match, &hwtstamps);
+}
+
+bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
+			unsigned int type)
+{
+	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
+
+	if (!NETC_SKB_CB(skb)->rx_tstamp_valid)
+		return false;
+
+	hwtstamps->hwtstamp = ns_to_ktime(NETC_SKB_CB(skb)->tstamp);
+
+	return false;
+}
+
+void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	u32 ptp_class;
+	int tx_type;
+
+	NETC_SKB_CB(skb)->ptp_flag = 0;
+	ptp_class = ptp_classify_raw(skb);
+	if (ptp_class == PTP_CLASS_NONE)
+		return;
+
+	/* Only supports PTP v2 */
+	if (unlikely(ptp_class & PTP_CLASS_V1))
+		return;
+
+	tx_type = READ_ONCE(np->ptp_tx_type);
+	if (tx_type == HWTSTAMP_TX_ON)
+		netc_port_prepare_twostep(np, skb);
+}
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index e7af30e5fe9a..00c371d9e77d 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -53,10 +53,16 @@
 #define NETC_FDBT_AGEING_DELAY		(3 * HZ)
 #define NETC_FDBT_AGEING_THRESH		100
 
+/* PTP frames have a higher priority, so a higher priority is defined to
+ * prioritize matching (The higher the value, the higher the priority).
+ */
+#define NETC_IPFT_PTP_PRECEDENCE	0xf000
+
 struct netc_switch;
 
 struct netc_switch_info {
 	u32 num_ports;
+	u32 tmr_devfn;
 	void (*phylink_get_caps)(int port, struct phylink_config *config);
 };
 
@@ -66,9 +72,19 @@ struct netc_port_caps {
 	u32 pseudo_link:1;
 };
 
+enum netc_ptp_type {
+	NETC_PTP_L2,
+	NETC_PTP_L4_IPV4_EVENT,
+	NETC_PTP_L4_IPV4_GENERAL,
+	NETC_PTP_L4_IPV6_EVENT,
+	NETC_PTP_L4_IPV6_GENERAL,
+	NETC_PTP_MAX,
+};
+
 enum netc_host_reason {
 	/* Software defined host reasons */
 	NETC_HR_HOST_FLOOD = 8,
+	NETC_HR_PTP_TRAP   = 9,
 };
 
 struct netc_port {
@@ -85,6 +101,14 @@ struct netc_port {
 	u16 mc:1;
 	u16 pvid;
 	u32 ipft_hf_eid; /* Must be initialized to NTMP_NULL_ENTRY_ID */
+
+	/* Serialize access to tstamp_queue */
+	spinlock_t tstamp_lock;
+	/* skb queue for TX timestamp frames */
+	struct sk_buff_head tstamp_queue;
+	struct delayed_work tstamp_timeout_work;
+	int ptp_tx_type;
+	u32 ptp_ipft_eid[NETC_PTP_MAX];
 };
 
 struct netc_switch_regs {
@@ -140,6 +164,7 @@ struct netc_switch {
 	u32 num_bp;
 
 	struct bpt_cfge_data *bpt_list;
+	struct pci_dev *tmr_dev; /* The PTP Timer PCI device */
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
@@ -204,4 +229,20 @@ void netc_port_get_strings(struct dsa_switch *ds, int port,
 			   u32 sset, u8 *data);
 void netc_port_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data);
 
+/* PTP APIs */
+int netc_port_ptp_init(struct netc_port *np);
+int netc_get_ts_info(struct dsa_switch *ds, int port,
+		     struct kernel_ethtool_ts_info *info);
+void netc_port_purge_tstamp_queue(struct netc_port *np);
+int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack);
+int netc_port_hwtstamp_get(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config);
+void netc_port_txtstamp_handler(struct dsa_switch *ds, int port,
+				u8 ts_req_id, u64 ts);
+bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
+			unsigned int type);
+void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb);
+
 #endif
diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
index fe964722e5b0..5a567af20094 100644
--- a/include/linux/dsa/tag_netc.h
+++ b/include/linux/dsa/tag_netc.h
@@ -10,5 +10,26 @@
 #include <net/dsa.h>
 
 #define NETC_TAG_MAX_LEN			14
+#define NETC_PTP_FLAG_TWOSTEP			BIT(1)
+
+struct netc_skb_cb {
+	u64 ptp_tx_time;
+	u64 tstamp;
+	bool rx_tstamp_valid;
+	u8 ptp_flag;
+	u8 ts_req_id;
+};
+
+#define NETC_SKB_CB(skb)	((struct netc_skb_cb *)((skb)->cb))
+
+/**
+ * struct netc_tagger_data - NETC tagger/switch-driver shared operations
+ * @txtstamp_handler: Called by the tagger when a two-step transmit timestamp
+ *	response is received, to deliver the timestamp to the switch driver.
+ */
+struct netc_tagger_data {
+	void (*txtstamp_handler)(struct dsa_switch *ds, int port,
+				 u8 ts_req_id, u64 ts);
+};
 
 #endif
diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
index df72a61796ad..6b492451d092 100644
--- a/net/dsa/tag_netc.c
+++ b/net/dsa/tag_netc.c
@@ -16,6 +16,8 @@
 #define NETC_TAG_TO_PORT		1
 /* SubType0: No request to perform timestamping */
 #define NETC_TAG_TP_SUBTYPE0		0
+/* SubType2: Request to perform two-step timestamping */
+#define NETC_TAG_TP_SUBTYPE2		2
 
 /* To_Host NXP switch tag */
 #define NETC_TAG_TO_HOST		2
@@ -29,6 +31,7 @@
 /* NETC switch tag lengths */
 #define NETC_TAG_FORWARD_LEN		6
 #define NETC_TAG_TP_SUBTYPE0_LEN	6
+#define NETC_TAG_TP_SUBTYPE2_LEN	6
 #define NETC_TAG_TH_SUBTYPE0_LEN	6
 #define NETC_TAG_TH_SUBTYPE1_LEN	14
 #define NETC_TAG_TH_SUBTYPE2_LEN	14
@@ -40,6 +43,7 @@
 #define NETC_TAG_IPV			GENMASK(4, 2)
 #define NETC_TAG_SWITCH			GENMASK(2, 0)
 #define NETC_TAG_PORT			GENMASK(7, 3)
+#define NETC_TAG_TS_REQ_ID		GENMASK(3, 0)
 
 struct netc_tag_cmn {
 	__be16 tpid;
@@ -48,6 +52,23 @@ struct netc_tag_cmn {
 	u8 switch_port;
 } __packed;
 
+struct netc_tag_tp_subtype2 {
+	struct netc_tag_cmn cmn;
+	u8 ts_req_id;
+} __packed;
+
+struct netc_tag_th_subtype1 {
+	struct netc_tag_cmn cmn;
+	u8 host_reason;
+	__be64 timestamp;
+} __packed;
+
+struct netc_tag_th_subtype2 {
+	struct netc_tag_cmn cmn;
+	u8 hr_tsreq_id;
+	__be64 timestamp;
+} __packed;
+
 static void netc_fill_common_tag(struct netc_tag_cmn *tag, u8 type,
 				 u8 subtype, u8 sw_id, u8 port, u8 ipv)
 {
@@ -97,15 +118,57 @@ static void netc_fill_tp_tag_subtype0(struct sk_buff *skb,
 				NETC_TAG_TP_SUBTYPE0_LEN);
 }
 
-/* Currently only support To_Port tag, subtype 0 */
+static void netc_fill_tp_tag_subtype2(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	u8 ts_req_id = NETC_SKB_CB(skb)->ts_req_id;
+	struct netc_tag_tp_subtype2 *tag;
+
+	tag = netc_fill_common_tp_tag(skb, ndev, NETC_TAG_TP_SUBTYPE2,
+				      NETC_TAG_TP_SUBTYPE2_LEN);
+	tag->ts_req_id = FIELD_PREP(NETC_TAG_TS_REQ_ID, ts_req_id);
+}
+
 static struct sk_buff *netc_xmit(struct sk_buff *skb,
 				 struct net_device *ndev)
 {
-	netc_fill_tp_tag_subtype0(skb, ndev);
+	u8 ptp_flag = NETC_SKB_CB(skb)->ptp_flag;
+
+	/* Fast path: the overwhelming majority of frames are not PTP frames */
+	if (likely(!ptp_flag))
+		netc_fill_tp_tag_subtype0(skb, ndev);
+	else
+		/* ptp_flag == NETC_PTP_FLAG_TWOSTEP */
+		netc_fill_tp_tag_subtype2(skb, ndev);
 
 	return skb;
 }
 
+static void netc_rx_tstamp_process(struct netc_tag_th_subtype1 *tag,
+				   struct sk_buff *skb)
+{
+	u64 ts = get_unaligned_be64(&tag->timestamp);
+
+	NETC_SKB_CB(skb)->rx_tstamp_valid = true;
+	NETC_SKB_CB(skb)->tstamp = ts;
+}
+
+static void netc_twostep_tstamp_process(struct netc_tag_th_subtype2 *tag,
+					struct sk_buff *skb)
+{
+	u8 ts_req_id = FIELD_GET(NETC_TAG_TS_REQ_ID, tag->hr_tsreq_id);
+	struct dsa_port *dp = dsa_user_to_port(skb->dev);
+	u64 ts = get_unaligned_be64(&tag->timestamp);
+	struct netc_tagger_data *tagger_data;
+	struct dsa_switch *ds = dp->ds;
+
+	tagger_data = ds->tagger_data;
+	if (unlikely(!tagger_data->txtstamp_handler))
+		return;
+
+	tagger_data->txtstamp_handler(ds, dp->index, ts_req_id, ts);
+}
+
 static int netc_get_rx_tag_len(int type, int subtype)
 {
 	/* Only NETC_TAG_TO_HOST and NETC_TAG_FORWARD are expected in RX,
@@ -129,11 +192,22 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb,
 	struct netc_tag_cmn *tag_cmn;
 	int tag_len, sw_id, port;
 	int type, subtype;
+	void *tag;
 
-	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN)))
+	/* eth_type_trans() pulled ETH_HLEN bytes, so skb->data sits 2 bytes
+	 * past the start of the switch tag (past the TPID) and skb->len is
+	 * ETH_HLEN bytes shorter than the original frame length. The longest
+	 * switch tag is NETC_TAG_MAX_LEN (14) bytes, but since 2 of those
+	 * bytes are already behind skb->data, only NETC_TAG_MAX_LEN - 2 bytes
+	 * need to be in the linear buffer. For the To_Host subtype 2 response
+	 * frame, whose total length is only 26 bytes with no payload after the
+	 * tag, this check is the only guard against a too-short frame.
+	 */
+	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN - 2)))
 		goto err_free_skb;
 
-	tag_cmn = dsa_etype_header_pos_rx(skb);
+	tag = dsa_etype_header_pos_rx(skb);
+	tag_cmn = tag;
 	if (ntohs(tag_cmn->tpid) != ETH_P_NXP_NETC) {
 		dev_warn_ratelimited(&ndev->dev, "Unknown TPID 0x%04x\n",
 				     ntohs(tag_cmn->tpid));
@@ -156,17 +230,50 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb,
 	if (!skb->dev)
 		goto err_free_skb;
 
+	/* skb->cb may be used to store hardware RX timestamp, so clear
+	 * rx_tstamp_valid before processing to avoid data pollution from
+	 * the previous layer.
+	 */
+	NETC_SKB_CB(skb)->rx_tstamp_valid = false;
+
 	type = FIELD_GET(NETC_TAG_TYPE, tag_cmn->type);
 	subtype = FIELD_GET(NETC_TAG_SUBTYPE, tag_cmn->type);
 	if (type == NETC_TAG_FORWARD) {
 		dsa_default_offload_fwd_mark(skb);
 	} else if (type == NETC_TAG_TO_HOST) {
-		/* Currently only subtype0 supported */
-		if (subtype != NETC_TAG_TH_SUBTYPE0)
+		switch (subtype) {
+		case NETC_TAG_TH_SUBTYPE0:
+			break;
+		case NETC_TAG_TH_SUBTYPE1:
+			/* To_Host Subtype 1 tag is 14 bytes, ensure it and the
+			 * EtherType behind it are fully present in the linear
+			 * area before netc_rcv() calls dsa_strip_etype_header()
+			 * to strip the tag.
+			 */
+			if (unlikely(!pskb_may_pull(skb,
+						    NETC_TAG_TH_SUBTYPE1_LEN)))
+				goto err_free_skb;
+
+			tag = dsa_etype_header_pos_rx(skb);
+			netc_rx_tstamp_process(tag, skb);
+			break;
+		case NETC_TAG_TH_SUBTYPE2:
+			/* This skb is a hardware-generated response to a
+			 * two-step transmit timestamp request. The tag
+			 * driver must free the skb after processing.
+			 */
+			netc_twostep_tstamp_process(tag, skb);
+			consume_skb(skb);
+			return NULL;
+		default:
+			dev_warn_ratelimited(&ndev->dev,
+					     "Unsupported To_Host subtype: %d\n",
+					     subtype);
 			goto err_free_skb;
+		}
 	} else {
 		dev_warn_ratelimited(&ndev->dev,
-				     "Unexpected  tag type %d\n", type);
+				     "Unexpected tag type %d\n", type);
 		goto err_free_skb;
 	}
 
@@ -190,16 +297,48 @@ static void netc_flow_dissect(const struct sk_buff *skb, __be16 *proto,
 	int type = FIELD_GET(NETC_TAG_TYPE, tag_cmn->type);
 	int tag_len = netc_get_rx_tag_len(type, subtype);
 
-	/* The RX minimum frame length of the NETC switch port is 64 bytes,
-	 * and the frame is received by the ENETC driver. From the hardware
-	 * perspective, the receive buffer of RX BD is at least 128 bytes,
-	 * so the switch tag header is guaranteed to be in the linear region
-	 * of the skb.
+	/* The CPU port of the switch is connected to the ENETC, so the frame
+	 * is received by the ENETC driver. From the hardware perspective, the
+	 * receive buffer of RX BD is at least 128 bytes, so the switch tag
+	 * header is guaranteed to be in the linear region of the skb.
+	 *
+	 * When the subtype of the frame is NETC_TAG_TH_SUBTYPE2, it indicates
+	 * the frame is a hardware generated timestamp response, which is only
+	 * 26 bytes (DMAC + SMAC + tag), so the frame has no payload after the
+	 * tag. Therefore, there is no need to parse the protocol and offset.
+	 * For other types of the frames, they are all received from the switch
+	 * ports, and the RX minimum frame length of the port is 64 bytes,
+	 * frames shorter than 64 bytes will be discarded by the hardware and
+	 * will not be received by the software.
 	 */
+	if (type == NETC_TAG_TO_HOST && subtype == NETC_TAG_TH_SUBTYPE2)
+		return;
+
 	*offset = tag_len;
 	*proto = ((__be16 *)skb->data)[(tag_len / 2) - 1];
 }
 
+static int netc_connect(struct dsa_switch *ds)
+{
+	struct netc_tagger_data *tagger_data;
+
+	tagger_data = kzalloc_obj(*tagger_data);
+	if (!tagger_data)
+		return -ENOMEM;
+
+	ds->tagger_data = tagger_data;
+
+	return 0;
+}
+
+static void netc_disconnect(struct dsa_switch *ds)
+{
+	struct netc_tagger_data *tagger_data = ds->tagger_data;
+
+	kfree(tagger_data);
+	ds->tagger_data = NULL;
+}
+
 static const struct dsa_device_ops netc_netdev_ops = {
 	.name			= NETC_NAME,
 	.proto			= DSA_TAG_PROTO_NETC,
@@ -207,6 +346,8 @@ static const struct dsa_device_ops netc_netdev_ops = {
 	.rcv			= netc_rcv,
 	.needed_headroom	= NETC_TAG_MAX_LEN,
 	.flow_dissect		= netc_flow_dissect,
+	.connect		= netc_connect,
+	.disconnect		= netc_disconnect,
 };
 
 MODULE_DESCRIPTION("DSA tag driver for NXP NETC switch family");
-- 
2.34.1


