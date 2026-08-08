Return-Path: <linuxppc-dev+bounces-25631-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703C6C5AC82
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 03:19:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH5pV5Zs7z2yjs;
	Sat, 08 Aug 2026 13:19:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786159154;
	cv=pass; b=RCaL3EQ0uN+lebQ/QsvPGCJYzB7P5WBgnK0pi39GOFFJfZvgr+GC7SyXNZQjkqx9gysFcEA4BWhrIjneKhdQuRLC5ZbFVMRF1MrdnWOUv37xBCVM61B7+OuqZCCaHzmcliL89g61DEnPg/DP+K687s7ILhvCgz7rYFhuV/zEJYSk28SLoaxGvcJlLo9dgnucDgjMownMA5tEmgDYPJI5aqADRD8eGnoWLpfx7noAShD1ML5A7GN6KRw5Crk2GChTfrpjlBpKVG3CT+XK8mdPsNapF7q4hfZCeYV4Pk8sqkTpCGYZYKDAiW440XKNaU4XHe/QxFpMgvFOLL1UMgQmaA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786159154; c=relaxed/relaxed;
	bh=TvmvOpHsiy9EylPvqsnozNhXaHRLcyV2oboiny2lIzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DI0eUjxjPvpogUkdl6JVe+HOoBpZBXxtwNjamYErpi+iPN+E0ag9UdDY5j4E8tkonO6vDZh3NbwZM4/YAOsrr2imS7WV1Nba7Gx7/RilvcB/JNoLnxHl7NaypNWgHCFi7e+RqDEuT08fo2lvDwyifaSOuCtbne96t2WTpKownZAgPqkKOVtbdZFoDtF0h0EOsMxmwJOrpBp+5xn2/4xRutyHL+Z9td2OFCAMFBidBozkpowQmCK7JKAZlA5htLeJSJyYYX/w3pt5rcMB06T+rgU8vNMZbaJZ9Z8EpJBmzBjxpjNTKub+RSM3XQrSdJUN2H9uALIpnaq/JtnwkzhPDg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=haItoKOC; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=haItoKOC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH5pS2LJTz2yys
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 13:19:12 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHfjac8eMtu9dBCFhBBeZbvYhai2uBanIPTx7lp7rJaGtX6q9UBNN9d23IWHCGV23qPuqkAfGq0ltUsb65WXhbIq0mV5lCpfTpTUiAITVp+eGMNXgMS5VPQ01saOgJ3XdOkcI9IUeTobMXl8YkxEgNUD1WZnbSJPp3eX9NYxV9GohZ0Y9Vq3wqPJiwgkK79DPDKJO/PFNlSKMcL89g7BdMLAd18ebPXx/lUD7dc/e3d+AaQczIGh8nCIYCl8IfoIFr7drzthR/CWhQa+dWpmJKrt/ScjtpIMZMkffjy/RV/jSOh5JLVr+yfWAbmH0ptw6UmP5Js6klnYc3rYOcqyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvmvOpHsiy9EylPvqsnozNhXaHRLcyV2oboiny2lIzg=;
 b=B2AuCuJjo6hnZNvzrhM8Mklk4LX+raqwd3uEXl8cudjZ/OmTxyOdudLYYVfW0y2PA6aYJvJOOemyGIqkTetmS1lb2fiOhV7Iu3Kq/lISgMh5gmU04AwbEKh8kwZBdzqJdNMUaneAD7bs6tLjafE53/9t14AwQ6RdWGzaQfGYHRc4ow+gaQLnvIm3oWTQKaFoxd4H1D9nTBpjh/YOlp1HvmSP6GpSH621j8MMeFbtSVIUSy5hsuiGT3sHeI4QXsF7qG1d33VgLLs0HFz33puAltdYLu8HCUvjzEkACaX/MiUTRQ/fhuMzlOkBrE4HdkZxKHc9lcxHGH1z1/GCy51V2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvmvOpHsiy9EylPvqsnozNhXaHRLcyV2oboiny2lIzg=;
 b=haItoKOCUTa+xvXjgFcJWast9tsbuR7B2T8kkOabcMSN7DHjsg3DfTh4O+SpSyoyN8cunxVdJ+dcUs2b0Idq4ntuUdiBgbqccKTcx/pnA7loVareCAX6YsjBWx5ixSwnvHh/gjyCeqwGFZqw+7r+n4w460GbdCw4Mn2FvoZd4isLbXTVDQc7Yj23NS5H/A8dpa3MWx6XZr/wg7VSnTEAIu8y2NOdwLgc0aLz4yUcbC9LIrGAe13Uf8lmDsmMz/NFfa6uVXG+inZwILf/OSjNDyPMh37DgMBhCxXCj2Z/a5g8WVHrveubXHwtKEI83HxR5WfCJ902dT7P8YTuwAiE5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Sat, 8 Aug
 2026 03:18:49 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0292.022; Sat, 8 Aug 2026
 03:18:49 +0000
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
	richardcochran@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 6/7] net: dsa: netc: add PTP two-step timestamping support
Date: Sat,  8 Aug 2026 11:21:45 +0800
Message-Id: <20260808032146.2335723-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
References: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU2PR04MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd7a92f-18cf-4818-b266-08def4fbc3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|19092799006|18002099003|22082099003|56012099006|11063799006|3023799007|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	baTeAyq0tEg3Ly1kBD/FDVG0yqFT+OsNOmavxyPxadlJxQwuTBNIlWkMvcgas/jFpO23U+U3YGZJH69SAdo89fse8w1GIIxlNypi8jvygBF0hAarVxSdVjGeHeWwXpFPOQsYqEafIwyWe+OAdqW9bll+UMpmMQjPLOmlOR8WrmR7HSdNvg+hI8t4hwp7srxD5+WYKOFdj4CZ+ddVNkUOkNqD8h0pUTbyk6FE1G6PUYFI5aETK6AqMLIYOETmdTtPfjmwMX3qwfxYEq3a4vw5Sm7p5MwTkWSGv8qqLvWbDGzbdIG/vuBeRjjyxhTsf5Qs0BHZhsa8vze5t+Hiqnw8/fRm+Vss42KEW5YcCjdbMp5vH9R3cHFBl/Cytw90bqmctwUFx6wIVt7i/GbR4hO1RfxEJ7re2E8cw50Kq+voZ6Msm5d/hPgPBskKuzPvdLuDntnThiImMfy2VTyYlV5nlj3kZ8IK0vjvy15jqdoC3gM/Hv3JeoLjcvLeyKOuxD0T5UhWXS1a+XBLWZOJsRPUaREk+Ch3pTqypb3FCyDD1lAJlSNBS05i0OwSNCOYIMsqk3UF5qzoXJMtU6UGrhNMy8JkvHNPe/QHSJYi2UkttlzV5kl5nTu5RUDvKT6erYHibzhAsVGP4P8VnaI1UIlesYgO+JfjeJ/EVQ2T1rSVkwgBcqPnS1ejLTYo2014XRIt4zQA6LkpmM/xLNl9H2pwOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XuU0Kbe/VyBPo6fsoW4UFas0CK/jJ4wJ3RVJ3NGJrGTk+KJy+kVcj7rhAQN2?=
 =?us-ascii?Q?3xkLjWglhFhEnwmf+/xeZJEQOdDyJq9Q5pRg7WyjAwsXjmw4K1Mg9o1Xxcs0?=
 =?us-ascii?Q?JRTkTo0aXcri6jmBPt7ruM6yhQo4jHTLBNlvkIMPialiy1W3v/hpKZMEocFX?=
 =?us-ascii?Q?5TDR8wOSnyi6Gf5pu5+w6qH8V+jxGDgebVnrWMpInMbdfZBg804GKevS/5sf?=
 =?us-ascii?Q?1flNOCdQRJUS+BPq+PpsZArtUTu0XAkF73Ooo6HttYOvVdW56o3SDoQ/8BLj?=
 =?us-ascii?Q?eOiB2kyBj25fesWmBYzWWL7gzjW3RVasEboXya7bFKBy3+VaZuUse69vxB4W?=
 =?us-ascii?Q?o6S4SmcMw00fCJ6Mx0n303MqpEJxX/zcUYRC5nOqOzS1zx74p/xzdL2//uME?=
 =?us-ascii?Q?3Mq2ZdCtamdVi1LUx5n+oVT2yshcLOe//PtQRbnVbeYMAixa0Ibr04yhZ7Yx?=
 =?us-ascii?Q?LXxhe72OdOYocUOtAkKLtVDZ51Tly6d95yhwtESR57erZXDMWhD03BlWyPNn?=
 =?us-ascii?Q?CWOrApH7/4vXNhTNvYRbuo74+p0cS0BkJZ/NVLW33qzwHbKuF95MyMQ37f7n?=
 =?us-ascii?Q?530OLbOhJz06sLhs8qrQFyuRGukBzC1fT/gPmBumByQ1V19n7D9BJWd0Ln49?=
 =?us-ascii?Q?4chwRO3bIUSGu2sMq8wERYh6smLYR3u+3pz+1ZhcZkgn08dbZyJMYSDtYmzl?=
 =?us-ascii?Q?RDDfpQZfB8gW4T3Fn6Pp+hqX4mO77umvKWYXTlNdrHh88rIzZUFZdcvL39h2?=
 =?us-ascii?Q?+H/RIvA/9fGzKL7UJcCrQsH9duKz/lYV2wao7k5AhbpnZkaXN3b1qkk/4WnQ?=
 =?us-ascii?Q?+CWmC1GqZEWpp5AAmyKWuTPVO7sLDIHQWOhHJTJdFXniX8C2ebxDUPiFYhRb?=
 =?us-ascii?Q?O8QbRdwd/PVY6SEbZqisT7dHz2k2DMGmbsa8m0kGtua+TDlCoMYQDHv/9R6H?=
 =?us-ascii?Q?ZNeEX3ujir5qNsAJFqmDB+pORmYVXFN19z66mT7yl38HfyFx5fDJh6GltGGp?=
 =?us-ascii?Q?ezCZCYIklKdqgvdrU19SD9msUFd0d5I94ttUTxHJ3xXB61WqtFCwWtFTjVl/?=
 =?us-ascii?Q?gMm9qH2euzbHySG275spmE0giNshL6I1kl2qnEiuWAbm9CfFBYZERuHlM46h?=
 =?us-ascii?Q?TyoO65IJa1hHS2McDe8eIuR7A0oziJskM3fthlANPHScSraNnLrd0ZRZ+IrX?=
 =?us-ascii?Q?Tfqmw3CVxOdI2135MzHUUFJPEt7RpxVj/59ImejFYGXjl3aROrCVgpq8h0Ev?=
 =?us-ascii?Q?tgVWpeGVoR74Y5gyiUW8yw1rwC9/eb0XO0fj8N/J+Q80iNzoNTszWOIp9VmE?=
 =?us-ascii?Q?T/Wmu02/dF5lCiJV8Mren2YP7Y2GjwuRvPpWC/r2oWcjhk546h8r8ycTRCUr?=
 =?us-ascii?Q?+b0LPE+CADQyILn2gQ9efM1lHx6vhWyKkOENVUhLgCMm9sRURmzYgB8EDOnd?=
 =?us-ascii?Q?pSmmMNiNuWE9oB03nBPmqKoTC67fXn0m1dWvmV9gxfG9VbgQ1ogmQwXOGwHd?=
 =?us-ascii?Q?E38RK/unxGUtFtaYMSGlbS325jMOirpS3E+Zez2UxGywv+J/nlKmp0gI8KAp?=
 =?us-ascii?Q?BPK50GNgOd9OSLzJmbx1IioMAhpYXq1GuawtkGYzl8louaGfnEU3gi1Iv9mv?=
 =?us-ascii?Q?sAEFgvcLij8cWtkJzGTMjfgnVz5jqBh7SvfnekgK24IgivL6MnOtjKwWIlMA?=
 =?us-ascii?Q?91NCW9IaBSXapFDwmKQewXBGfDUqWlrJr8NBqy1OB63lHeLXFzvfzr/krcnF?=
 =?us-ascii?Q?ygGa2bL/DOH8oT4LF99rmJi6sNjM4AH8tkco6ebpzho9e99S5uS/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd7a92f-18cf-4818-b266-08def4fbc3a5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 03:18:49.2437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5OoNB89E+CsaOk/DJz9SYzed1OhHwNk+VDBrNWMbgkrMPZRtxT2DmbGMyExZ1ti+7uEQ+7gQLVrefD6lSTPJ8K9XnI5R5PtZ85x4zFHem1NiFi1rRGUoA/J/DAUaa7a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936

From: Wei Fang <wei.fang@nxp.com>

Add two-step TX timestamping and RX timestamping for the NETC switch.

For RX, install ingress port filter table (IPFT) rules that redirect PTP
frames to the CPU port. Support L2, L4 over IPv4 and L4 over IPv6, for
both event and general messages, selected through the hwtstamp rx_filter.
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

Reclaim the request ID when the matching response arrives or when the
request times out after 5 seconds. This timeout is orders of magnitude
larger than the hardware's normal response latency, so a still missing
response after the window means the frame never reached the hardware, the
frames should have been dropped by software. In that case the hardware
will never echo that ID, so reusing the reclaimed ID for a later request
cannot cause a stale response to be matched against the wrong clone. A
response arriving later than 5 seconds only happens under a hardware
fault, where the timestamp is already meaningless for PTP synchronization
and no amount of ID bookkeeping would recover a usable value. Store the
allocated ID in the control block of the transmit skb as well as in its
queued clone. The transmit path reads the ID from the transmit skb when
building the To_Port subtype 2 tag; the response handler reads it from
the clone to match the queued entry, which is completed and freed only
by the handler or the timeout path.

The two-step response frame carries no payload; its total length is only
26 bytes (12 bytes of DMAC and SMAC plus a 14-byte switch tag).
eth_type_trans() pulls ETH_HLEN bytes, advancing skb->data past the
DMAC, SMAC, and the TPID that opens the switch tag, leaving skb->len
at 12. Since the tag pointer is at (skb->data - 2), the pskb_may_pull()
check must use (NETC_TAG_MAX_LEN - 2) rather than NETC_TAG_MAX_LEN.
Otherwise pskb_may_pull() drops the response frame and breaks PTP
synchronization.

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
 drivers/net/dsa/netc/netc_main.c     |  70 ++++-
 drivers/net/dsa/netc/netc_platform.c |   1 +
 drivers/net/dsa/netc/netc_ptp.c      | 454 +++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h   |  41 +++
 include/linux/dsa/tag_netc.h         |  21 ++
 net/dsa/tag_netc.c                   | 146 ++++++++-
 8 files changed, 727 insertions(+), 10 deletions(-)
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
index 9cb9e618661e..4e139ffc2f76 100644
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
+	tagger_data->twostep_tstamp_handler = netc_port_twostep_tstamp_handler;
+
+	return 0;
+}
+
 static void netc_port_rmw(struct netc_port *np, u32 reg,
 			  u32 mask, u32 val)
 {
@@ -292,6 +306,15 @@ static int netc_init_all_ports(struct netc_switch *priv)
 			 * been created.
 			 */
 			np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
+
+			/* Only the user port needs to support PTP feature, so
+			 * PTP-related resources, such as skb_txtstamp_queue,
+			 * tstamp_lock, etc., are initialized only for the user
+			 * port.
+			 */
+			err = netc_port_ptp_init(np);
+			if (err)
+				return err;
 		}
 	}
 
@@ -881,6 +904,15 @@ static int netc_switch_bpt_default_config(struct netc_switch *priv)
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
@@ -893,13 +925,23 @@ static int netc_setup(struct dsa_switch *ds)
 
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
-		return err;
+		goto put_ptp_timer;
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
@@ -938,6 +980,8 @@ static int netc_setup(struct dsa_switch *ds)
 	mutex_destroy(&priv->fdbt_lock);
 	mutex_destroy(&priv->vft_lock);
 	netc_free_ntmp_user(priv);
+put_ptp_timer:
+	pci_dev_put(priv->tmr_dev);
 
 	return err;
 }
@@ -950,6 +994,20 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
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
+		netc_port_purge_txtstamp_queue(np);
+	}
+}
+
 static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -957,6 +1015,8 @@ static void netc_teardown(struct dsa_switch *ds)
 	disable_delayed_work_sync(&priv->fdbt_ageing_work);
 	netc_destroy_all_lists(priv);
 	netc_free_ntmp_user(priv);
+	netc_free_ports_resources(priv);
+	pci_dev_put(priv->tmr_dev);
 }
 
 static bool netc_port_is_emdio_consumer(struct device_node *node)
@@ -2388,6 +2448,7 @@ static const struct phylink_mac_ops netc_phylink_mac_ops = {
 
 static const struct dsa_switch_ops netc_switch_ops = {
 	.get_tag_protocol		= netc_get_tag_protocol,
+	.connect_tag_protocol		= netc_connect_tag_protocol,
 	.setup				= netc_setup,
 	.teardown			= netc_teardown,
 	.phylink_get_caps		= netc_phylink_get_caps,
@@ -2416,6 +2477,11 @@ static const struct dsa_switch_ops netc_switch_ops = {
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
index 000000000000..1384a6f31d1c
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_ptp.c
@@ -0,0 +1,454 @@
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
+#define NETC_TXTSTAMP_TIMEOUT		(5 * HZ)
+
+int netc_port_ptp_init(struct netc_port *np)
+{
+	/* Initialize to invalid entry IDs */
+	for (int i = 0; i < NETC_PTP_MAX; i++)
+		np->ptp_ipft_eid[i] = NTMP_NULL_ENTRY_ID;
+
+	spin_lock_init(&np->tstamp_lock);
+	__skb_queue_head_init(&np->skb_txtstamp_queue);
+
+	return 0;
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
+static void netc_port_del_ptp_filter(struct netc_port *np)
+{
+	struct netc_switch *priv = np->switch_priv;
+	u32 entry_id;
+	int i;
+
+	for (i = 0; i < NETC_PTP_MAX; i++) {
+		entry_id = np->ptp_ipft_eid[i];
+		if (entry_id != NTMP_NULL_ENTRY_ID) {
+			/* There is no need to check the return value of
+			 * ntmp_ipft_delete_entry(); in general, deleted
+			 * existing entries will be successful.
+			 */
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
+void netc_port_purge_txtstamp_queue(struct netc_port *np)
+{
+	struct sk_buff_head free_list;
+
+	__skb_queue_head_init(&free_list);
+
+	spin_lock_bh(&np->tstamp_lock);
+	skb_queue_splice_init(&np->skb_txtstamp_queue, &free_list);
+	spin_unlock_bh(&np->tstamp_lock);
+
+	__skb_queue_purge(&free_list);
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
+	    !priv->tmr_dev)
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
+	if (config->tx_type == HWTSTAMP_TX_OFF)
+		netc_port_purge_txtstamp_queue(np);
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
+	config->tx_type = READ_ONCE(np->ptp_tx_type);
+	config->rx_filter = np->ptp_rx_filter;
+
+	return 0;
+}
+
+static void netc_port_txtstamp_twostep(struct netc_port *np,
+				       struct sk_buff *nskb)
+{
+	DECLARE_BITMAP(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
+	struct sk_buff *clone = skb_clone_sk(nskb);
+	struct netc_switch *priv = np->switch_priv;
+	struct sk_buff_head free_list;
+	struct sk_buff *skb, *skb_tmp;
+	unsigned long ts_req_id;
+	int err = 0;
+
+	if (unlikely(!clone))
+		return;
+
+	bitmap_zero(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
+	__skb_queue_head_init(&free_list);
+	spin_lock_bh(&np->tstamp_lock);
+
+	skb_queue_walk_safe(&np->skb_txtstamp_queue, skb, skb_tmp) {
+		if (time_before(NETC_SKB_CB(skb)->ptp_tx_time +
+				NETC_TXTSTAMP_TIMEOUT, jiffies)) {
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
+	ts_req_id = find_first_zero_bit(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
+	if (ts_req_id == NETC_NUM_TS_REQ_ID) {
+		dev_dbg_ratelimited(priv->dev,
+				    "Port %d has no available ts_req_id\n",
+				    np->dp->index);
+		err = -EBUSY;
+		goto unlock_tstamp;
+	}
+
+	NETC_SKB_CB(nskb)->ptp_flag = NETC_PTP_FLAG_TWOSTEP;
+	NETC_SKB_CB(nskb)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(clone)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(clone)->ptp_tx_time = jiffies;
+	skb_shinfo(clone)->tx_flags |= SKBTX_IN_PROGRESS;
+	__skb_queue_tail(&np->skb_txtstamp_queue, clone);
+
+unlock_tstamp:
+	spin_unlock_bh(&np->tstamp_lock);
+
+	if (err)
+		kfree_skb(clone);
+
+	/* Free timed-out SKBs outside the spinlock to avoid calling
+	 * kfree_skb() with a destructor (sock_efree) under a spinlock.
+	 */
+	__skb_queue_purge(&free_list);
+}
+
+void netc_port_twostep_tstamp_handler(struct dsa_switch *ds, int port,
+				      u8 ts_req_id, u64 ts)
+{
+	struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct skb_shared_hwtstamps hwtstamps;
+	struct netc_switch *priv = ds->priv;
+
+	spin_lock_bh(&np->tstamp_lock);
+	skb_queue_walk_safe(&np->skb_txtstamp_queue, skb, skb_tmp) {
+		if (NETC_SKB_CB(skb)->ts_req_id != ts_req_id)
+			continue;
+
+		__skb_unlink(skb, &np->skb_txtstamp_queue);
+		skb_match = skb;
+		break;
+	}
+	spin_unlock_bh(&np->tstamp_lock);
+
+	if (!skb_match) {
+		dev_dbg_ratelimited(priv->dev,
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
+	u64 ts = NETC_SKB_CB(skb)->tstamp;
+
+	/* ts == 0 indicates the hardware did not capture the RX timestamp
+	 * of the frame.
+	 */
+	if (!ts)
+		return false;
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
+	if (READ_ONCE(np->ptp_tx_type) == HWTSTAMP_TX_ON)
+		netc_port_txtstamp_twostep(np, skb);
+}
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index fd36ec2d0e90..86fd15889733 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -53,10 +53,16 @@
 #define NETC_FDBT_AGEING_DELAY		(3 * HZ)
 #define NETC_FDBT_AGEING_THRESH		100
 
+/* PTP frames have a higher priority, so a higher priority is defined to
+ * prioritize matching.
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
 	u32 ipft_hf_eid;
+
+	/* Serialize access to skb_txtstamp_queue and ts_req_id */
+	spinlock_t tstamp_lock;
+	/* skb queue for two-step timestamp frames */
+	struct sk_buff_head skb_txtstamp_queue;
+	int ptp_tx_type;
+	int ptp_rx_filter;
+	u32 ptp_ipft_eid[NETC_PTP_MAX];
 };
 
 struct netc_switch_regs {
@@ -139,6 +163,7 @@ struct netc_switch {
 	u32 num_bp;
 
 	struct bpt_cfge_data *bpt_list;
+	struct pci_dev *tmr_dev; /* The PTP Timer PCI device */
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
@@ -203,4 +228,20 @@ void netc_port_get_strings(struct dsa_switch *ds, int port,
 			   u32 sset, u8 *data);
 void netc_port_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data);
 
+/* PTP APIs */
+int netc_port_ptp_init(struct netc_port *np);
+int netc_get_ts_info(struct dsa_switch *ds, int port,
+		     struct kernel_ethtool_ts_info *info);
+void netc_port_purge_txtstamp_queue(struct netc_port *np);
+int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack);
+int netc_port_hwtstamp_get(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config);
+void netc_port_twostep_tstamp_handler(struct dsa_switch *ds, int port,
+				      u8 ts_req_id, u64 ts);
+bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
+			unsigned int type);
+void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb);
+
 #endif
diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
index fe964722e5b0..da200e3ba8ad 100644
--- a/include/linux/dsa/tag_netc.h
+++ b/include/linux/dsa/tag_netc.h
@@ -10,5 +10,26 @@
 #include <net/dsa.h>
 
 #define NETC_TAG_MAX_LEN			14
+#define NETC_PTP_FLAG_TWOSTEP			BIT(1)
+
+struct netc_skb_cb {
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
index df72a61796ad..9f9a61d8133b 100644
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
@@ -97,15 +118,69 @@ static void netc_fill_tp_tag_subtype0(struct sk_buff *skb,
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
 
+static int netc_rx_tstamp_process(struct netc_tag_th_subtype1 *tag,
+				  struct sk_buff *skb)
+{
+	u64 ts = get_unaligned_be64(&tag->timestamp);
+
+	/* To_Host Subtype 1 tag is 14 bytes, ensure it and the EtherType
+	 * behind it are fully present in the linear area before netc_rcv()
+	 * calls dsa_strip_etype_header() to strip the tag.
+	 */
+	if (unlikely(!pskb_may_pull(skb, NETC_TAG_TH_SUBTYPE1_LEN)))
+		return -ENOBUFS;
+
+	NETC_SKB_CB(skb)->tstamp = ts;
+
+	return 0;
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
+	if (unlikely(!tagger_data->twostep_tstamp_handler))
+		return;
+
+	tagger_data->twostep_tstamp_handler(ds, dp->index, ts_req_id, ts);
+}
+
 static int netc_get_rx_tag_len(int type, int subtype)
 {
 	/* Only NETC_TAG_TO_HOST and NETC_TAG_FORWARD are expected in RX,
@@ -129,11 +204,22 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb,
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
@@ -156,17 +242,40 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb,
 	if (!skb->dev)
 		goto err_free_skb;
 
+	/* skb->cb may be used to store hardware RX timestamp, so it must
+	 * be cleared before processing to avoid data pollution from the
+	 * previous layer.
+	 */
+	NETC_SKB_CB(skb)->tstamp = 0;
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
+			if (netc_rx_tstamp_process(tag, skb))
+				goto err_free_skb;
+			break;
+		case NETC_TAG_TH_SUBTYPE2:
+			/* This skb is a hardware-generated response to a
+			 * two-step transmit timestamp request. The tag
+			 * driver must free the skb after processing.
+			 */
+			netc_twostep_tstamp_process(tag, skb);
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
 
@@ -200,6 +309,27 @@ static void netc_flow_dissect(const struct sk_buff *skb, __be16 *proto,
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
@@ -207,6 +337,8 @@ static const struct dsa_device_ops netc_netdev_ops = {
 	.rcv			= netc_rcv,
 	.needed_headroom	= NETC_TAG_MAX_LEN,
 	.flow_dissect		= netc_flow_dissect,
+	.connect		= netc_connect,
+	.disconnect		= netc_disconnect,
 };
 
 MODULE_DESCRIPTION("DSA tag driver for NXP NETC switch family");
-- 
2.34.1


