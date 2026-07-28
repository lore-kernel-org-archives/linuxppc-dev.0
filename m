Return-Path: <linuxppc-dev+bounces-24932-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF560C531F9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 10:43:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8X9g62t4z2yjg;
	Tue, 28 Jul 2026 20:43:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785235383;
	cv=pass; b=Cv32JvZkPiWASvUkLWky8vgwCu+UJBZsqujb7zLsQhVAqea/5rTD1obVCOdUURA+UOE1lZXNktGHCEvXCii8NAysA92KapEqAaUEY1WT8MtJAVMA2S3HFAOuxbcS6mvWCI9VaVZ/Omn7OAgmPlB8mvjP06SChGECiNCsPt3v+AgD4eGn0kAe2sttC8xYtF/FHmJ6gGpFnWJVUDTiahmyRkn11UoxtPtYOqTPbG/H37WbM5PZNY2BvYDtAfi52X2d41vj6jnrhGw6oIwTTq3ffiUr+zCVpzINWAUq+DTLTJDfcj8o6eo4mDgNCLpJebTmiu6eyTvNVrJ8BSJi1BIfQg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785235383; c=relaxed/relaxed;
	bh=Hp1yMnTfyiZ1ynAZbnRmPQdAkCNAeMGCHfcZw/Vs8p8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J3EFwyr359ehFzD+rpRFuS6h1ATVRdrH/8bhxXlQHMDGhGbf2L7wvUspF3N4EWHcZhJWbS2LK/p5xn53fRMrxW7WjvjC1UaBtTa/AROOAWZyWSFxO8TOElA814xOy3UIysBtLYSQzf8j4bPPr9oBwZAJIqFww3e3+zkgXXxte+NtKxD8qwz1JPWNE3O4PqoXDwIZqT0gnixZeEoRx6WdUa+BV4cxJ3m/yc1hdNgv20U5mPPstvWu8BystMAD1Cwef1LDIkRVIHJ5/rgqKRdNZ2Ahib1mgj6e7pfi9azoIvi8VV65edNgnFy4Zxw1m5JjccU9MMSGGasLh9zn2RBwRA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=T/HCQYCX; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=T/HCQYCX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8X9f1vkJz2yvF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 20:43:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5n5/fKtOOYekr9lLUXncCGAcpVcbNkE6EsTsf6d+XJLWAI8RES3GGESQYOCfsLb6GkGpEmPWeqJV3/fVrfvcLZqDS6hRQCq9skK0/1HexBthbrj+1ateTOrbxxIhWerQL0dDSBzl/3INlj4n/WJ1htqUegOvUiHshz9/RoiMnD3v/R6gYDngWe+G8s4+hbnd/FJRYANX4HG8m6PoAaoO5ZUfwGFaAb5R3EZQVUYKQz4r5C73rJu6gu0SJJLnWzON20O15mmrOAXutTKgxkR9aJ6lHCyJL2sh0UyX1QzWwlNxLv7J40t8BYdI7SdWZpvg7oVKmtL9K1CQq/MB4imbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hp1yMnTfyiZ1ynAZbnRmPQdAkCNAeMGCHfcZw/Vs8p8=;
 b=cOjvCA8IyOCOxFoNnPHehOornGGsEB+P3xpBqILRNvuSSalyzl3nj2C41sdaw6zNVcEFRP6kqG9lmGXD4UC6WZhsYbjODmvmkgPLViEiwkUR0uI/UHSKeRfW/rdZWBWl4I/UjuTKxgZUeEn+PYeHwae8HgHtAvMzUnXSHLeTVr7e+eBxoW8yXb7wFhnng3Y4gsdMpXufH+kOquEmgIIAKO66f63o5J4xE2zj6Vvx3ThMG+I7rDuMhovKORfB3BYzGXKLUZS5wURtcsEY5bBlAqmMI0vw3Fgxn0l4G9kV2oxwlfqEatsdfezx3uh3HbHc5yeWntCmfyfj/xufESt8rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hp1yMnTfyiZ1ynAZbnRmPQdAkCNAeMGCHfcZw/Vs8p8=;
 b=T/HCQYCXoAymTGfW5IdDk3Fb/lWg8tgs5Xbh+c2mxQbWpzLXWii01dsTmCjgyIama8kk++smW9M2sUPOQpGwHieF0mOKvr+opnD8vb8TKWUsJ6BGHtr0cHsWAZEHyTktUa1NzrEabv8rC/ipNyto8qyuRfQiGRQlpoNr90YxOFQXNSi4iDM6urG2c6PCNi7iw0gN1gtrVKkWeccmd5zohACuLSlZ5lbz1NTMAkJ3Mg4V5GSBDIZOlErWgZgdYy0gUyvbuMu7OZeKdlR3bZ0zpwJY5h0ytbOwZvelJtMSwGVyChLHEhZvN/vCYzjwiWJOHsos4BCGKJHvDRppXDortw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV2PR04MB11835.eurprd04.prod.outlook.com (2603:10a6:150:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 10:42:38 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 10:42:38 +0000
From: wei.fang@oss.nxp.com
To: richardcochran@gmail.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: wei.fang@nxp.com,
	chleroy@kernel.org,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 6/7] net: dsa: netc: add PTP two-step timestamping support
Date: Tue, 28 Jul 2026 18:45:47 +0800
Message-Id: <20260728104548.3301214-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
References: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::11) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
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
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV2PR04MB11835:EE_
X-MS-Office365-Filtering-Correlation-Id: 19becbe1-5529-47b3-9325-08deec94f178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	VvN85Yq/oNSMF6495p1Hn7GtY+WdTfekFfkR8NHALjF7HsUsIDnhR8yNW6oOo+/L9gLsNyAVvNhzxvY3qyCrKj9QHi+8GnRKCOckvXu/KdNLWtXYE+4j/Xydox9oC/E0JEglaA+vReZ5mAphre+cwGnI7f4ki+w5y4ObB/Q8p1u8Az3pbcxn7I6/VfMbGRSKBeKtmrQRPxf4NRb7LhEiyp/PWRcKpl+v2pgCI6R8ww/lbPAqxoKkUEmycTPbpPL/cBSdHxOUq0KZPt3ceF0ttpclfjhLkWUBdwkjXZ2lgkIX6TU82FKNzq4IBPnH50Gvjx0j2yglFIb5p8+lwe5t0NQsbBF6UpSCdxSKlJM1NV7CNieL6hsD+s75QjP03rh1s5vHNcZQYmgruH9c1SjNEsq9FK5LTaimQ4KZ7AYMbqyBIMlgY/8heSRD/zS1EJ7E3It1ZqKgQl1dy85W5+7AWUb1fgjrOjOdC0NhwDjVVewOmIryNVAGGWb6FscRGOASf7eUfoP6p355qQfampO9H1t6wHcVbvcb8KXqUmgzQPQEhTifJ5rBEfrHTG5XOSvOcqwxjpzwXSpQzzZtKZt153gLa69BQvzqVA3gkDIAPpN55az/eTuhETH45utBw0xZo5jRPG7IPKvjrvKKD35vYCBYNAVFa78Ycdn7Nnl8q7z7ye+a+Mrx9uRSayuELrRiD9pnB9HftRytL5WzwkW52Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LthYxYms0QNz1BdVbPapdQeJ2P2ogwaomU5cDxVEDD5oUJ8yEH9wyp0lQAwj?=
 =?us-ascii?Q?ZyQpVRseRwI0LAagZMQ2ZsTQ/seKgaLskkOOcUh7d/9+p1LY+kPR8mN/yEQL?=
 =?us-ascii?Q?DBbWDfB3Ed2phWROqfNPQ1ZX0lR04nMEeFRoCA9xlbl6GYZTt5w/O8p0L/eL?=
 =?us-ascii?Q?7d7wM57lhn/5E4D7FmFjLWqbDhNcPAi01gDezezASVbqgw3yyyV5EvJJgIrH?=
 =?us-ascii?Q?iE+tgH/BpvxhzbDaWoBI1QsWGsAw3KxnTHAsgGpPvm54cLWCeBwE20cdPQVB?=
 =?us-ascii?Q?zQujkyi37VOCPOJHpyD+tUJ4l8ox88m+VEzz8o7slhkSJR/WQToEi57ccMDi?=
 =?us-ascii?Q?WudEmAK8Kwf6vGzZdTXLq/mSxJztEFo6rwqooOUOv2y4+xwS7dh/GrelYrLX?=
 =?us-ascii?Q?yAXEIrOdRY/DL4T10Ew+0DtjPmx/ANZEBlFgMzHaO1LY1Zk8CGfRAfqbBaJM?=
 =?us-ascii?Q?2nK5dbPAqJ3FRA6Zc4Q8Vhb+S57Vg9zV5LgP/+ibi1VDhxxTGekjX6Ozk1Mm?=
 =?us-ascii?Q?VOd1k5l4tgzzXC2cuTa74RYXS/EGoR2B8lqX8y0R6CQ00ddGaeJmc7xdLIVf?=
 =?us-ascii?Q?l7YtRKMRlDWVuM9Br5bb7Nz7PsOjd9rrjlawKgW+sMLSX4oZWVdso731wve7?=
 =?us-ascii?Q?3zOxB7tzoXntIVKzNyBbGhHE9E8oHYftDi3TPq6lalTsE4fickB9mGhS7UI8?=
 =?us-ascii?Q?g35YcyWGBOGHB3x/Ory/XL438atsX0r76qNHTvFnf3A8AksIUtFkqNgZLx3I?=
 =?us-ascii?Q?GSImE4jwE1bDaH1qYCuKM+J+kjo9tl/6GWQWNS4AIPycsC2dhWPekONtDeID?=
 =?us-ascii?Q?XWYLQTbXP0P5GnzpPWjCUYQxfB/fyFPzIwG6oCaQJFytULBrG5eQWPcYHCOt?=
 =?us-ascii?Q?7BoxjSsbev6tZiuNy+qNdOLjW4q8vybf6CpQsKXj1EnJavh1sER+HptH9sjZ?=
 =?us-ascii?Q?wC88pyQF2s6koG4MdI0eOZiq2kF3Xx+JGMgograYu704lkFf2CStFttahhiU?=
 =?us-ascii?Q?XGHzBWyJfxG4jJgK4HMBe+SBQ+Yhko9CG6wxdCngHFWpo73seGbzpWgbPFEH?=
 =?us-ascii?Q?jLzDqxq7nUaOk3zrewcuajTYG3nflxb8RET8sIbEyuNQ4ZZB9FsBUvG3ncfN?=
 =?us-ascii?Q?h4uAZm9Rdl2+XJXdzeoXmtRKgqWkCsVNmccD1fk21f2IqgzsTZ+hjfOVqacI?=
 =?us-ascii?Q?u+r7/m7lGgrs0HXxFu12AD89L91nhcA6ErN4UHLFL0nrRMG+a15ctPli5IRD?=
 =?us-ascii?Q?DJSOMZQaBJz/MYPXKEzzSMxNm76XhynD1kxAWYqzl622rqa9f/dKh6n9jDdU?=
 =?us-ascii?Q?EEVwCExLgWPHnQ5CpI/OwEbCGju7wg6DqFbYWjVXbvy21SU5yrJZ8bOcKk4x?=
 =?us-ascii?Q?4JNiJTK61bWxTmsyi3cYL3/hDwO7iyjhSJvLJ6q8rfVS4yXg/j3ouRTgXCjq?=
 =?us-ascii?Q?yWcfcY6ULhu/ul5ZInzxO9h3RAgXDBbDDsKAdt1jsRUGdgU3oObMal/Tv2ee?=
 =?us-ascii?Q?OVLdJafzrZfUe2OoxvfVYsjJwfhlVK2o0ZhfRajPbwqU9UvFPbwWxC7OVuMl?=
 =?us-ascii?Q?Suzaqe5T28qxA0uvIQe1y/XerW93wCluvTYqLBwD6lXxw7JOWWpNUeS6nIDT?=
 =?us-ascii?Q?qlV509k5X13RfXkdIE8vVNnOU/Q0O9lrtGT8Ih9I/uWZJz8XSUh/xaJxDlDW?=
 =?us-ascii?Q?NIZeLHmn4HN5GcxMMvAGu711ou7NWJA50zaAoCv/a1oFenrsNKNWMGNa0qe1?=
 =?us-ascii?Q?IAoHRBC9wcjfoEnCc2xQpJdrn7b5WtFvOtv8cuOxNuvwEcuhUYE1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19becbe1-5529-47b3-9325-08deec94f178
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:42:38.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQXFbSVG0wDMTv3slj6t5q3x7Gpe3WX0vZ7jlKA6P4et8shSxw70gsIt0DDzZc06XtnSR5Zk1mxV2ftFWRvvHHsGkGZhfyDJ8Cjteznpa+V5GR1+Ez7Iw+1uOGE/rRry
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11835

From: Wei Fang <wei.fang@nxp.com>

Add two-step TX timestamping and RX timestamping for the NETC switch.
One-step TX timestamping is not supported yet.

For RX, install ingress port filter table (IPFT) rules that redirect PTP
frames to the CPU port. Support L2, L4 over IPv4 and L4 over IPv6, for
both event and general messages, selected via the hwtstamp rx_filter.
The hardware prepends a To_Host subtype 1 tag carrying the 64-bit ingress
timestamp. The tagger extracts it into the skb control buffer, and
netc_port_rxtstamp() copies it into skb_hwtstamps().

For two-step TX, clone the skb and allocate a 4-bit timestamp request ID,
then queue the clone on a per-port list. netc_xmit() emits a To_Port
subtype 2 tag carrying that ID. The hardware echoes the ID back in a
generated To_Host subtype 2 response frame together with the 64-bit
transmit timestamp. The tagger dispatches the ID and timestamp to the
switch driver through the twostep_tstamp_handler callback registered in
netc_tagger_data, which matches the queued clone and completes it via
skb_complete_tx_timestamp(), then frees the response skb. Non-PTP frames
keep using the To_Port subtype 0 tag on the xmit fast path.

The two-step response frame carries no payload; its total length is only
26 bytes (12 bytes of DMAC and SMAC plus a 14-byte switch tag). By the
time netc_rcv() sees it, skb->data already points 2 bytes into the switch
tag, past the TPID shared with the Ethernet header, so skb->len is only
12. Since the tag pointer is at (skb->data - 2), the pskb_may_pull() check
must use NETC_TAG_MAX_LEN - 2 rather than NETC_TAG_MAX_LEN. Otherwise
pskb_may_pull() drops the response frame and breaks PTP synchronization.

Add the To_Port subtype 2 and To_Host subtype 1/2 tag structures, extend
netc_xmit() to select the tag based on ptp_flag in the skb control buffer,
and add netc_connect()/netc_disconnect() to manage the per-switch
netc_tagger_data allocation. Grab the PTP timer's pci_dev in netc_setup()
so get_ts_info() can report its PHC index, and release it in the teardown
and error paths.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/Kconfig         |   1 +
 drivers/net/dsa/netc/Makefile        |   3 +-
 drivers/net/dsa/netc/netc_main.c     |  72 +++++
 drivers/net/dsa/netc/netc_platform.c |   1 +
 drivers/net/dsa/netc/netc_ptp.c      | 411 +++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h   |  35 +++
 include/linux/dsa/tag_netc.h         |  23 ++
 net/dsa/tag_netc.c                   | 120 +++++++-
 8 files changed, 658 insertions(+), 8 deletions(-)
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
index 9cb9e618661e..d98ee40a1af7 100644
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
+	tagger_data->twostep_tstamp_handler = netc_twostep_tstamp_handler;
+
+	return 0;
+}
+
 static void netc_port_rmw(struct netc_port *np, u32 reg,
 			  u32 mask, u32 val)
 {
@@ -238,6 +252,15 @@ static void netc_get_switch_capabilities(struct netc_switch *priv)
 	priv->num_bp = FIELD_GET(BPCAPR_NUM_BP, val);
 }
 
+static void netc_port_init_ptp_ipft_eid(struct netc_port *np)
+{
+	int i;
+
+	/* Initialize to invalid entry IDs */
+	for (i = 0; i < NETC_PTP_MAX; i++)
+		np->ptp_ipft_eid[i] = NTMP_NULL_ENTRY_ID;
+}
+
 static int netc_init_all_ports(struct netc_switch *priv)
 {
 	struct device *dev = priv->dev;
@@ -292,6 +315,9 @@ static int netc_init_all_ports(struct netc_switch *priv)
 			 * been created.
 			 */
 			np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
+			netc_port_init_ptp_ipft_eid(np);
+			spin_lock_init(&np->ptp_lock);
+			__skb_queue_head_init(&np->skb_txtstamp_queue);
 		}
 	}
 
@@ -881,6 +907,15 @@ static int netc_switch_bpt_default_config(struct netc_switch *priv)
 	return 0;
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
@@ -901,6 +936,16 @@ static int netc_setup(struct dsa_switch *ds)
 	if (err)
 		return err;
 
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
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
 	priv->fdbt_ageing_delay = NETC_FDBT_AGEING_DELAY;
@@ -937,6 +982,7 @@ static int netc_setup(struct dsa_switch *ds)
 	 */
 	mutex_destroy(&priv->fdbt_lock);
 	mutex_destroy(&priv->vft_lock);
+	pci_dev_put(priv->tmr_dev);
 	netc_free_ntmp_user(priv);
 
 	return err;
@@ -950,13 +996,33 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
 	mutex_destroy(&priv->vft_lock);
 }
 
+static void netc_free_ports_resources(struct netc_switch *priv)
+{
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_available_port(dp, priv->ds) {
+		struct netc_port *np = priv->ports[dp->index];
+
+		if (!dsa_port_is_user(dp))
+			continue;
+
+		/* No new SKBs can be enqueued during teardown. Purge without
+		 * the spinlock to avoid calling kfree_skb() with a destructor
+		 * (sock_efree) while holding a spinlock.
+		 */
+		__skb_queue_purge(&np->skb_txtstamp_queue);
+	}
+}
+
 static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
 
 	disable_delayed_work_sync(&priv->fdbt_ageing_work);
 	netc_destroy_all_lists(priv);
+	pci_dev_put(priv->tmr_dev);
 	netc_free_ntmp_user(priv);
+	netc_free_ports_resources(priv);
 }
 
 static bool netc_port_is_emdio_consumer(struct device_node *node)
@@ -2388,6 +2454,7 @@ static const struct phylink_mac_ops netc_phylink_mac_ops = {
 
 static const struct dsa_switch_ops netc_switch_ops = {
 	.get_tag_protocol		= netc_get_tag_protocol,
+	.connect_tag_protocol		= netc_connect_tag_protocol,
 	.setup				= netc_setup,
 	.teardown			= netc_teardown,
 	.phylink_get_caps		= netc_phylink_get_caps,
@@ -2416,6 +2483,11 @@ static const struct dsa_switch_ops netc_switch_ops = {
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
index 000000000000..7288eac11b46
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_ptp.c
@@ -0,0 +1,411 @@
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
+#define NETC_TS_REQ_ID_NUM		(NETC_TAG_TS_REQ_ID + 1)
+#define NETC_PTP_TX_TSTAMP_TIMEOUT	(5 * HZ)
+
+static int netc_get_phc_index(struct netc_switch *priv)
+{
+	if (!priv->tmr_dev)
+		return -ENODEV;
+
+	return ptp_clock_index_by_dev(&priv->tmr_dev->dev);
+}
+
+int netc_get_ts_info(struct dsa_switch *ds, int port,
+		     struct kernel_ethtool_ts_info *info)
+{
+	struct netc_switch *priv = ds->priv;
+
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
+				SOF_TIMESTAMPING_RX_SOFTWARE |
+				SOF_TIMESTAMPING_SOFTWARE;
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
+static void netc_port_del_ptp_filter(struct netc_port *np)
+{
+	struct netc_switch *priv = np->switch_priv;
+	u32 entry_id;
+	int i;
+
+	for (i = 0; i < NETC_PTP_MAX; i++) {
+		entry_id = np->ptp_ipft_eid[i];
+		if (entry_id != NTMP_NULL_ENTRY_ID) {
+			ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
+			np->ptp_ipft_eid[i] = NTMP_NULL_ENTRY_ID;
+		}
+	}
+}
+
+static int netc_build_ptp_ipft_keye(struct ipft_keye_data *keye, int port,
+				    enum netc_ptp_type type)
+{
+	u16 src_port, frm_attr_flags;
+
+	keye->precedence = cpu_to_le16(0xf000);
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
+		keye->frm_attr_flags_mask = keye->frm_attr_flags;
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
+	int err = 0;
+
+	if (np->ptp_rx_filter == rx_filter)
+		return 0;
+
+	if (np->ptp_rx_filter != HWTSTAMP_FILTER_NONE ||
+	    rx_filter == HWTSTAMP_FILTER_NONE) {
+		netc_port_del_ptp_filter(np);
+		np->ptp_rx_filter = HWTSTAMP_FILTER_NONE;
+	}
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
+	if (err)
+		return err;
+
+	np->ptp_rx_filter = rx_filter;
+
+	return 0;
+}
+
+int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	int rx_filter, err;
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_ON:
+	case HWTSTAMP_TX_OFF:
+		np->ptp_tx_type = config->tx_type;
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
+	config->rx_filter = rx_filter;
+
+	return 0;
+}
+
+int netc_port_hwtstamp_get(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	config->tx_type = np->ptp_tx_type;
+	config->rx_filter = np->ptp_rx_filter;
+
+	return 0;
+}
+
+static int netc_port_txtstamp_twostep(struct netc_port *np,
+				      struct sk_buff *clone)
+{
+	DECLARE_BITMAP(ts_req_id_bitmap, NETC_TS_REQ_ID_NUM);
+	struct netc_switch *priv = np->switch_priv;
+	struct sk_buff_head free_list;
+	struct sk_buff *skb, *skb_tmp;
+	unsigned long ts_req_id;
+	int err = 0;
+
+	bitmap_zero(ts_req_id_bitmap, NETC_TS_REQ_ID_NUM);
+	__skb_queue_head_init(&free_list);
+	spin_lock_bh(&np->ptp_lock);
+
+	skb_queue_walk_safe(&np->skb_txtstamp_queue, skb, skb_tmp) {
+		if (time_before(NETC_SKB_CB(skb)->ptp_tx_time +
+				NETC_PTP_TX_TSTAMP_TIMEOUT, jiffies)) {
+			dev_dbg_ratelimited(priv->dev,
+					    "Port %d ts_req_id %u which seems lost\n",
+					    np->dp->index, NETC_SKB_CB(skb)->ts_req_id);
+
+			__skb_unlink(skb, &np->skb_txtstamp_queue);
+			__skb_queue_tail(&free_list, skb);
+		} else {
+			__set_bit(NETC_SKB_CB(skb)->ts_req_id, ts_req_id_bitmap);
+		}
+	}
+
+	ts_req_id = find_first_zero_bit(ts_req_id_bitmap, NETC_TS_REQ_ID_NUM);
+	if (ts_req_id == NETC_TS_REQ_ID_NUM) {
+		err = -EBUSY;
+		goto unlock_ptp;
+	}
+
+	NETC_SKB_CB(clone)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(clone)->ptp_tx_time = jiffies;
+	skb_shinfo(clone)->tx_flags |= SKBTX_IN_PROGRESS;
+	__skb_queue_tail(&np->skb_txtstamp_queue, clone);
+
+unlock_ptp:
+	spin_unlock_bh(&np->ptp_lock);
+
+	/* Free timed-out SKBs outside the spinlock to avoid calling
+	 * kfree_skb() with a destructor (sock_efree) under a spinlock.
+	 */
+	__skb_queue_purge(&free_list);
+
+	return err;
+}
+
+void netc_twostep_tstamp_handler(struct dsa_switch *ds, int port,
+				 u8 ts_req_id, u64 ts)
+{
+	struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct skb_shared_hwtstamps hwtstamps;
+	struct netc_switch *priv = ds->priv;
+
+	spin_lock_bh(&np->ptp_lock);
+	skb_queue_walk_safe(&np->skb_txtstamp_queue, skb, skb_tmp) {
+		if (NETC_SKB_CB(skb)->ts_req_id != ts_req_id)
+			continue;
+
+		__skb_unlink(skb, &np->skb_txtstamp_queue);
+		skb_match = skb;
+		break;
+	}
+	spin_unlock_bh(&np->ptp_lock);
+
+	if (!skb_match) {
+		dev_dbg_ratelimited(priv->dev,
+				    "Port %d received an expired Tx timestamp response (ts_req_id %u)",
+				    port, ts_req_id);
+		return;
+	}
+
+	hwtstamps.hwtstamp = ns_to_ktime(ts);
+	skb_complete_tx_timestamp(skb_match, &hwtstamps);
+}
+
+bool netc_port_rxtstamp(struct dsa_switch *ds, int port,
+			struct sk_buff *skb, unsigned int type)
+{
+	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
+	u64 ts = NETC_SKB_CB(skb)->tstamp;
+
+	hwtstamps->hwtstamp = ns_to_ktime(ts);
+
+	return false;
+}
+
+void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	u32 ptp_class;
+
+	NETC_SKB_CB(skb)->ptp_flag = 0;
+	ptp_class = ptp_classify_raw(skb);
+	if (ptp_class == PTP_CLASS_NONE)
+		return;
+
+	if (np->ptp_tx_type == HWTSTAMP_TX_ON) {
+		struct sk_buff *clone = skb_clone_sk(skb);
+
+		if (unlikely(!clone))
+			return;
+
+		if (netc_port_txtstamp_twostep(np, clone)) {
+			kfree_skb(clone);
+			return;
+		}
+
+		NETC_SKB_CB(skb)->clone = clone;
+		NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_TWOSTEP;
+	}
+}
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index fd36ec2d0e90..61ecd12b5836 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -57,6 +57,7 @@ struct netc_switch;
 
 struct netc_switch_info {
 	u32 num_ports;
+	u32 tmr_devfn;
 	void (*phylink_get_caps)(int port, struct phylink_config *config);
 };
 
@@ -66,9 +67,19 @@ struct netc_port_caps {
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
@@ -85,6 +96,14 @@ struct netc_port {
 	u16 mc:1;
 	u16 pvid;
 	u32 ipft_hf_eid;
+
+	/* Serialize PTP operations */
+	spinlock_t ptp_lock;
+	/* skb queue for two-step timestamp frames */
+	struct sk_buff_head skb_txtstamp_queue;
+	int ptp_tx_type;
+	int ptp_rx_filter;
+	u32 ptp_ipft_eid[NETC_PTP_MAX];
 };
 
 struct netc_switch_regs {
@@ -139,6 +158,7 @@ struct netc_switch {
 	u32 num_bp;
 
 	struct bpt_cfge_data *bpt_list;
+	struct pci_dev *tmr_dev; /* The PTP Timer PCI device */
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
@@ -203,4 +223,19 @@ void netc_port_get_strings(struct dsa_switch *ds, int port,
 			   u32 sset, u8 *data);
 void netc_port_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data);
 
+/* PTP APIs */
+int netc_get_ts_info(struct dsa_switch *ds, int port_id,
+		     struct kernel_ethtool_ts_info *info);
+int netc_port_hwtstamp_set(struct dsa_switch *ds, int port_id,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack);
+int netc_port_hwtstamp_get(struct dsa_switch *ds, int port_id,
+			   struct kernel_hwtstamp_config *config);
+void netc_twostep_tstamp_handler(struct dsa_switch *ds, int port,
+				 u8 ts_req_id, u64 ts);
+bool netc_port_rxtstamp(struct dsa_switch *ds, int port,
+			struct sk_buff *skb, unsigned int type);
+void netc_port_txtstamp(struct dsa_switch *ds, int port_id,
+			struct sk_buff *skb);
+
 #endif
diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
index fe964722e5b0..f73dca5b5f24 100644
--- a/include/linux/dsa/tag_netc.h
+++ b/include/linux/dsa/tag_netc.h
@@ -10,5 +10,28 @@
 #include <net/dsa.h>
 
 #define NETC_TAG_MAX_LEN			14
+#define NETC_TAG_TS_REQ_ID			GENMASK(3, 0)
+#define NETC_PTP_FLAG_TWOSTEP			BIT(1)
+
+struct netc_skb_cb {
+	struct sk_buff *clone;
+	unsigned long ptp_tx_time;
+	u64 tstamp;
+	u8 ptp_flag;
+	u8 ts_req_id;
+};
+
+#define NETC_SKB_CB(skb)	((struct netc_skb_cb *)((skb)->cb))
+
+/**
+ * struct netc_tagger_data - NETC tagger/switch-driver shared operations
+ * @twostep_tstamp_handler: Called by the tagger when a two-step transmit
+ *	timestamp response is received, to deliver the timestamp to the
+ *	switch driver.
+ */
+struct netc_tagger_data {
+	void (*twostep_tstamp_handler)(struct dsa_switch *ds, int port,
+				       u8 ts_req_id, u64 ts);
+};
 
 #endif
diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
index df72a61796ad..33c285c8d1ce 100644
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
@@ -48,6 +51,23 @@ struct netc_tag_cmn {
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
@@ -97,15 +117,59 @@ static void netc_fill_tp_tag_subtype0(struct sk_buff *skb,
 				NETC_TAG_TP_SUBTYPE0_LEN);
 }
 
-/* Currently only support To_Port tag, subtype 0 */
+static void netc_fill_tp_tag_subtype2(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	struct sk_buff *clone = NETC_SKB_CB(skb)->clone;
+	u8 ts_req_id = NETC_SKB_CB(clone)->ts_req_id;
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
+	if (likely(!ptp_flag)) {
+		netc_fill_tp_tag_subtype0(skb, ndev);
+		return skb;
+	} else if (ptp_flag == NETC_PTP_FLAG_TWOSTEP) {
+		netc_fill_tp_tag_subtype2(skb, ndev);
+	} else {
+		kfree_skb(skb);
+		return NULL;
+	}
 
 	return skb;
 }
 
+static void netc_rx_tstamp_process(struct netc_tag_th_subtype1 *tag,
+				   struct sk_buff *skb)
+{
+	u64 ts = get_unaligned_be64(&tag->timestamp);
+
+	NETC_SKB_CB(skb)->tstamp = ts;
+}
+
+static void netc_twostep_tstamp_process(struct netc_tag_th_subtype2 *tag,
+					struct dsa_switch *ds)
+{
+	u8 ts_req_id = FIELD_GET(NETC_TAG_TS_REQ_ID, tag->hr_tsreq_id);
+	int port = FIELD_GET(NETC_TAG_PORT, tag->cmn.switch_port);
+	struct netc_tagger_data *tagger_data = ds->tagger_data;
+	u64 ts = get_unaligned_be64(&tag->timestamp);
+
+	if (unlikely(!tagger_data->twostep_tstamp_handler))
+		return;
+
+	tagger_data->twostep_tstamp_handler(ds, port, ts_req_id, ts);
+}
+
 static int netc_get_rx_tag_len(int type, int subtype)
 {
 	/* Only NETC_TAG_TO_HOST and NETC_TAG_FORWARD are expected in RX,
@@ -126,14 +190,17 @@ static int netc_get_rx_tag_len(int type, int subtype)
 static struct sk_buff *netc_rcv(struct sk_buff *skb,
 				struct net_device *ndev)
 {
+	struct dsa_port *dp = ndev->dsa_ptr;
 	struct netc_tag_cmn *tag_cmn;
 	int tag_len, sw_id, port;
 	int type, subtype;
+	void *tag;
 
-	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN)))
+	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN - 2)))
 		goto err_free_skb;
 
-	tag_cmn = dsa_etype_header_pos_rx(skb);
+	tag = dsa_etype_header_pos_rx(skb);
+	tag_cmn = tag;
 	if (ntohs(tag_cmn->tpid) != ETH_P_NXP_NETC) {
 		dev_warn_ratelimited(&ndev->dev, "Unknown TPID 0x%04x\n",
 				     ntohs(tag_cmn->tpid));
@@ -161,12 +228,28 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb,
 	if (type == NETC_TAG_FORWARD) {
 		dsa_default_offload_fwd_mark(skb);
 	} else if (type == NETC_TAG_TO_HOST) {
-		/* Currently only subtype0 supported */
-		if (subtype != NETC_TAG_TH_SUBTYPE0)
+		switch (subtype) {
+		case NETC_TAG_TH_SUBTYPE0:
+			break;
+		case NETC_TAG_TH_SUBTYPE1:
+			netc_rx_tstamp_process(tag, skb);
+			break;
+		case NETC_TAG_TH_SUBTYPE2:
+			/* This skb is a hardware-generated response to a
+			 * two-step transmit timestamp request. The tag
+			 * driver must free the skb after processing.
+			 */
+			netc_twostep_tstamp_process(tag, dp->ds);
+			goto err_free_skb;
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
 
@@ -200,6 +283,27 @@ static void netc_flow_dissect(const struct sk_buff *skb, __be16 *proto,
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
@@ -207,6 +311,8 @@ static const struct dsa_device_ops netc_netdev_ops = {
 	.rcv			= netc_rcv,
 	.needed_headroom	= NETC_TAG_MAX_LEN,
 	.flow_dissect		= netc_flow_dissect,
+	.connect		= netc_connect,
+	.disconnect		= netc_disconnect,
 };
 
 MODULE_DESCRIPTION("DSA tag driver for NXP NETC switch family");
-- 
2.34.1


