Return-Path: <linuxppc-dev+bounces-23164-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF48DC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:49:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFds2fB0z2yhD;
	Tue, 30 Jun 2026 17:49:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805745;
	cv=pass; b=RNJzGZLMULyKPh6sQAqjY4i2629LYz3leRXk7y9t5Gta3SVLLmW2o7qtyOxYJPfSye6nLXy9KFcM66TuFgiw+xTDfcIK5Te8PZ3FG1TwW1drbSicAhjVdQvn3cs1jCoJYtmtYxuhPzAA6A1IefkmnFbQryu12S5CZbuBxRM56bEtI4Cc4evsL1yWwClfBYcsE8g+2qP5cOCS+wNkxnhSnXvXse5dcaq3wCV/crGyOPSoaaR/iULtwLZeVTfqUb5UdjUKIE+IKPSJyq7pL16kZiKQznYG4jsbsfoN3oiGfEfdEn9459v881QCSDTAkYiUM8MTq1PWwtYNVmsBn8rugQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805745; c=relaxed/relaxed;
	bh=ldRiNBCOJWyFngcj13VgJQfJt1BIcjx0qrIGck3hjtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YOWBkvUfoq2WvCr4lGXKb7N99Qb08D1unsw2tVKzg7GEoavvZRys9Nk3Ba8Z4ZJBX9+DjX8WOdHUaBUMB5t39oqUw63HXrij24CVLEv7oapJAsUK/B0eMo+N0We0fKm/NpkY1qHA/2XxtYF+tOzbn9u3qRem9e5sl5dT6NHe2w/+erZs90Rw+gwMeMtwUbf8yqvKRPjj777VBOas3cAoQyDd15fA0wyDgXkQhruSW5wavatwkGfTKw2AKizcKBCDVc9npzpfqa382zpb1rPzfOLE6ep9XgjFpeROgo4vmzWuA/oNi7WRxPaXGGxTjyMccHfpEDePey3LNMgO+3kLMw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=E1rCX5tQ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=E1rCX5tQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFdr1CCmz2yk6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:49:04 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMBuqure5bm5sOg6732aXqC00Tvm4eOzE1of2VqzmYxOONcLnhfbwkOtqv4GkbA7bO28xmpXYt/+WluQOJyUw84YmbhX8fOGGRtZc0ft3DvDJUxp3jJAHiPim/KV/iHBJynpUctoDrQ6K4F+CmPCBoX5aqwbvf8r0IK5XtNSXHAy4q6Yt44yhJvvL7XJ/Ya0ruuEIHl7GptZINbXslymEjtbTQcclsv6zB5mK0sWoqPPZE+MR9cvkc/dzGNKUwh05boCFEA9Cd879a7Sika1iSKIA987aBvUW+Qdlr6PG4uEceU8UW6Qcowbei8P4Ujkq0IQ3V8qqjNr+cTT6kUrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldRiNBCOJWyFngcj13VgJQfJt1BIcjx0qrIGck3hjtY=;
 b=sIwTFZRHYH0oJz71pD7pGGlKnrP7EdviNCFIbzV4islDXbL24KMs5Yvkuox/CMWEayzcK46f9Wex9kOCdknkWgdpnIpxxajvSsQBQHGc3nVefPTyidpZav9PaXmRPkCMi9VLckkXn6QcPo/zewoss44J/vEjAR6g7dlGbqtSH77AW3ZxFwq7NOmLewBdQnM66P7xTZadllmrj6habRZLDr/GlCZEd+zYtdrGxsuR2ldW10pZLn/voMuJljAPkpmPMXTRM19QAy1k0gLKmL13AkzkdwJ+9jDcWvrXLWV3lo92yHosMPzIAya7cS+z47EktQXA+qNPyZBWhBm2MHzFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldRiNBCOJWyFngcj13VgJQfJt1BIcjx0qrIGck3hjtY=;
 b=E1rCX5tQzGcGlq8fGvrfzTDiH5hjw1fvfNZRRT/xdrRmANIh8RYthHfey7v7CRkAbAxnWHzljOOlvUCUVTTG4LlvSCpra3NvnC15S3/L2nBClg+/d3pPa/D9Iw6qc08B8pymX56EUU/zaW/EdGpIWkvfCNgx3QE9NLU1P/Lk6iCBqHItmK0okuHZYXBTf9vc8PHe96ihtDnGm09y18/GyPMlUvTl4Pj+EFqUSKmRv9+lMnYyA7cmsb16y9dz7OiR/2VOOnwxz8j16jE6j46fRpZFRo6gKQiHQiZ2NerMTLR2lAxe8QaOH0P+5dZeFsMvR1HGh1aYkbcKXgBxBqz8QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:48:51 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:48:51 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 03/14] net: enetc: convert ndo_set_rx_mode() to ndo_set_rx_mode_async()
Date: Tue, 30 Jun 2026 15:20:25 +0800
Message-Id: <20260630072036.382761-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dec691b-4ecf-444a-9cf0-08ded67c0705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	EX7hTWjZFPggv2YMKp0Z7nclDizfWQ0+Ol+aU8taHv0V3iKbRI28+04+t0gE2Nz2H6xdC5pOndm9E79foZRc5g7TnyXh9FprYDD6T8IsN7ViHLn6HF2eZPLJoa6EPOEjnd2K9U48eKGLZCCzdbI6VaTNo6YPr91cQQHrJWX48yFeDWBQpVLQU62uJccTu+mwq43xBZ49gVsLghlutO3833ls32xbLogRtkr1aTHy3ONi1BgfYOd3pVpn6KeeCA/LuDm6wEEvVVroSWepRNb6u1j+gHgFjxU0o+B7jf96qERHmCnVXJ49es420slImjkFXuBNVrsJwG0FPhHeY1edmKiDQmLB3oNE1V8B3M4AnI8aPIa5n1SrFzY0fwZz40+PEIb1DnY+WdqIGAHUbCtlexH0LvqP2XOXo/iqnldxYnfbEzLDTlU8Z8byh6NLasZixCto1PCRmA6GnxKAvuUwfG2khZk+NHLVVAdL/R5wTmkvX1eVtmc1jd3JYEEdRnmVrQdKAV+rmg95ODaMUivnRcG0AETATX8G0X6NpIi2voxnTAJ9yW3EEOOU3/tA9zePy5ydxeDeton56ij35Z95WvGiYGW/b/aIUR+b732LQ65ZNI50VygcxiW9EonPbRi3mmlhiXICgXTKK+JEnoJ18PoauwvQ3LD3Qc1w1oRT6DeYWHtJ4tMrIUtpGk6Kq755B+QoVXey4U8bYQFSkaf6JQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fd30cYcM+3+BB1LMoNIUoqKA8vferQWnQGt9haJi6JSK/u8gCYige9CEead0?=
 =?us-ascii?Q?/N7DtwnsE2ppGp2lrovXi/i0lQ1ego3s0HxBkHvZOHlZD5ORZhuj3twv5pCo?=
 =?us-ascii?Q?yhjCexSv0K4eSQIaqhz4jaSn3dSwL17uCtjf6IREPU/NW7dIrV25RgA2/CgR?=
 =?us-ascii?Q?MtPO6RUCZKLkXla5U2XAPMO95nhfC8SR/iF6KPt/mJsWSNK3VZ4Kt5Kbe8H+?=
 =?us-ascii?Q?/DGdVmYtNHKWkJHTku8TbbOQaUqNGmXwREPfZAkxTzXtG37rMIMaBeKf9Zqw?=
 =?us-ascii?Q?oAwO5WYLEw8Dl8MN5GNHl74xrOcvdj5sfDQzbw+3bprfCSkL+gneeWXZ+Ixh?=
 =?us-ascii?Q?rxf2GTtbOk1uiqP5gKqSLOCSHJb8vNHl6ojdSGZVIdSnkIHZIsLNR+4+JraK?=
 =?us-ascii?Q?qUVx8tyC5xhnK0B0T7zhcTT9L+SgejrraX7a621zEJBeYu9lS7LHn9iifkfb?=
 =?us-ascii?Q?PZBhZut9//kdHZZ5ZUBsNTj9mJX1gkc/QPBMxHh2EXLT9sdvLVrOOxfrVziz?=
 =?us-ascii?Q?2ewM5g9beHN9pzAPm5MJaDflz6YBdZFgZZpPH5//wuXN3Kcl0lSMUaZvHl30?=
 =?us-ascii?Q?BjdUVYDUqrP84Ymz14o7r/z5taoc8jNdGEvxOZAUUUnuHzir+r+VnLAfyktv?=
 =?us-ascii?Q?LY7NNsNXqM+Xxxl4fF6YfxX/M3Hnw6/tbBbX0+fVDC42btiGhEBx6xKAMxOx?=
 =?us-ascii?Q?W8ZhOLeTPGZ552ZPIlhd7aJe/24Xy0CVps95Tw7F/4uKZ7ccJfjYDT9tK4HM?=
 =?us-ascii?Q?xsQ1xGzUyR9D5QEspyydrj3B/6eb1OzneRYGZ0XRrGIEQsdXw73ymjC/ocQc?=
 =?us-ascii?Q?OcH9uwoKB2iPKhK90HG+wYM99b9Om7qYvrOpmkUQKt0S7ghkr3UGvMv9bOWS?=
 =?us-ascii?Q?4hsJxvAGbhWGPNcvwjwRQlKOTwheIAY775T8us7oNHTR0fa4z1ifNFJo/XAu?=
 =?us-ascii?Q?M31nNeZSv4txoa69JYAWwJUrg2SZ2uprqBkOkyahSzqWnxWwkaw2RUXWQN5b?=
 =?us-ascii?Q?CiB7/0aStrH4TIa8Okfl2FKUx/9pOzq2oqsBkG2Rc1xiv37Z+jagglTcbUJ3?=
 =?us-ascii?Q?Ktn9C9atyCLo1/xCSk6t2GT8q1MtVAbzlAmmsv7+m+SLRfnyh7XYeOMGUeE5?=
 =?us-ascii?Q?moX5mmH1RLeS6CHUOoj6/u81Bc0ag+rWBoYf9gGRP7YU4bn2XpPm6vygFrbt?=
 =?us-ascii?Q?D/wyb1dnkO4ISotKmwbaC7hKY+kilC+8x3eqrn+WkidBXFamJbx/NoudUlAy?=
 =?us-ascii?Q?jrcV+Pm7kfbLNfV2IIg3AODviyx1l921wnmpsJs2qJinuGtkutGyS0Bdr9C9?=
 =?us-ascii?Q?fAfShkKqIzcUYZ6kWLrOcnyYIQ08/Dgj7tojBKjpQ6Z7O1FKHuJDaoVdSQzo?=
 =?us-ascii?Q?/RUvTYWXtMHmXczP4D4MHP4JY50gtfH9cuY0NXX12Nolk/LHgNWrJci6q2Qa?=
 =?us-ascii?Q?KdzHjVWUngVPq+w5u60n5tZ482nIRqGY3axu2ttOQiabfTYFKpcOLFQ8vs55?=
 =?us-ascii?Q?F/kdeQvNwQF4HDQY0LbeEcmp9T5KeWH2/riYt+ar8IQCA0PkdixA4Afpgrx4?=
 =?us-ascii?Q?dwKQpEnR1zaV1ckgJ0fHpkapflJU9QEbdAcV9QeaewBPhUlBXcJSLZd/TH5y?=
 =?us-ascii?Q?z6nfWtkhdbHuA0JXV9bB+5iBSco6SVoC6UW0ng2zFcpELctwz9MaxIlMCv61?=
 =?us-ascii?Q?/ZHRtdjt6v2qK1eWeOUEbYFSWsVjM+M8ZRq7m3AbkLCQlIXoIDM++kO9+0Tf?=
 =?us-ascii?Q?ueMpXjumYMECLpLmzlKY4tCnAy2lUEUuRMTkuLia8kPtJyUpB5Ui?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dec691b-4ecf-444a-9cf0-08ded67c0705
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:48:51.8052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChK2gCbkWoIjA2CP418pGX39TZLQQ09RgVl2jG190UdgsdnxBnMGBcc+/IjYff1kZ6zxbjy4qyK11+unmNNJHdBldL/4E7O6nP4YNIe0vA2vZk201w9WpwRpcFjidRew
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561

From: Wei Fang <wei.fang@nxp.com>

The current ndo_set_rx_mode() is called under netif_addr_lock spinlock
with BHs disabled, which prevents drivers from sleeping. To work around
this limitation, the enetc driver uses a dedicated workqueue to defer
MAC address list updates to a sleepable context.

Since commit 3554b4345d85 ("net: introduce ndo_set_rx_mode_async and
netdev_rx_mode_work") introduced the ndo_set_rx_mode_async() callback,
drivers can now handle address list updates directly in a sleepable
context.

Therefore, convert the enetc driver to use ndo_set_rx_mode_async() and
remove the dedicated workqueue and the deferred work item accordingly.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |   2 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 178 ++++++------------
 2 files changed, 58 insertions(+), 122 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 04a5dd5ea6c7..06a9f1ee0970 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -324,8 +324,6 @@ struct enetc_si {
 	const struct enetc_drvdata *drvdata;
 	const struct enetc_si_ops *ops;
 
-	struct workqueue_struct *workqueue;
-	struct work_struct rx_mode_task;
 	struct dentry *debugfs_root;
 	struct enetc_msg_swbd msg; /* Only valid for VSI */
 };
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 48a74db90ed5..a02b01753ff2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -101,24 +101,23 @@ static void enetc4_pf_clear_maft_entries(struct enetc_pf *pf)
 }
 
 static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
-				      struct enetc_mac_addr *mac,
-				      int mac_cnt)
+				      struct netdev_hw_addr_list *uc)
 {
 	struct maft_entry_data maft = {};
+	struct netdev_hw_addr *ha;
 	u16 si_bit = BIT(0);
-	int i, err;
+	int err;
 
 	maft.cfge.si_bitmap = cpu_to_le16(si_bit);
-	for (i = 0; i < mac_cnt; i++) {
-		ether_addr_copy(maft.keye.mac_addr, mac[i].addr);
-		err = ntmp_maft_add_entry(&pf->si->ntmp_user, i, &maft);
-		if (unlikely(err)) {
-			pf->num_mfe = i;
+	netdev_hw_addr_list_for_each(ha, uc) {
+		ether_addr_copy(maft.keye.mac_addr, ha->addr);
+		err = ntmp_maft_add_entry(&pf->si->ntmp_user, pf->num_mfe,
+					  &maft);
+		if (unlikely(err))
 			goto clear_maft_entries;
-		}
-	}
 
-	pf->num_mfe = mac_cnt;
+		pf->num_mfe++;
+	}
 
 	return 0;
 
@@ -128,23 +127,29 @@ static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
 	return  err;
 }
 
-static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
+static void enetc4_pf_set_uc_hash_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *uc)
 {
-	int max_num_mfe = pf->caps.mac_filter_num;
-	struct enetc_mac_filter mac_filter = {};
-	struct net_device *ndev = pf->si->ndev;
-	struct enetc_mac_addr *mac_tbl;
-	struct enetc_si *si = pf->si;
+	struct enetc_mac_filter *mac_filter = &pf->mac_filter[UC];
 	struct netdev_hw_addr *ha;
-	int i = 0, err;
-	int mac_cnt;
 	u64 hash;
 
-	netif_addr_lock_bh(ndev);
+	enetc_reset_mac_addr_filter(mac_filter);
+	netdev_hw_addr_list_for_each(ha, uc)
+		enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
+
+	bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_uc_hash_filter(pf->si, 0, hash);
+}
+
+static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *uc)
+{
+	int mac_cnt = netdev_hw_addr_list_count(uc);
+	struct enetc_si *si = pf->si;
 
-	mac_cnt = netdev_uc_count(ndev);
 	if (!mac_cnt) {
-		netif_addr_unlock_bh(ndev);
 		/* clear both MAC hash and exact filters */
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
@@ -152,79 +157,42 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 		return 0;
 	}
 
-	if (mac_cnt > max_num_mfe) {
-		err = -ENOSPC;
-		goto unlock_netif_addr;
-	}
-
-	mac_tbl = kzalloc_objs(*mac_tbl, mac_cnt, GFP_ATOMIC);
-	if (!mac_tbl) {
-		err = -ENOMEM;
-		goto unlock_netif_addr;
-	}
-
-	netdev_for_each_uc_addr(ha, ndev) {
-		enetc_add_mac_addr_ht_filter(&mac_filter, ha->addr);
-		ether_addr_copy(mac_tbl[i++].addr, ha->addr);
-	}
-
-	netif_addr_unlock_bh(ndev);
+	if (mac_cnt > pf->caps.mac_filter_num)
+		return -ENOSPC;
 
 	/* Set temporary unicast hash filters in case of Rx loss when
 	 * updating MAC address filter table
 	 */
-	bitmap_to_arr64(&hash, mac_filter.mac_hash_table,
-			ENETC_MADDR_HASH_TBL_SZ);
-	enetc_set_si_uc_hash_filter(si, 0, hash);
+	enetc4_pf_set_uc_hash_filter(pf, uc);
 	enetc4_pf_clear_maft_entries(pf);
 
-	if (!enetc4_pf_add_maft_entries(pf, mac_tbl, i))
+	if (!enetc4_pf_add_maft_entries(pf, uc)) {
+		enetc_reset_mac_addr_filter(&pf->mac_filter[UC]);
 		enetc_set_si_uc_hash_filter(si, 0, 0);
-
-	kfree(mac_tbl);
+	}
 
 	return 0;
-
-unlock_netif_addr:
-	netif_addr_unlock_bh(ndev);
-
-	return err;
 }
 
-static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
+static void enetc4_pf_set_mc_hash_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *mc)
 {
-	struct net_device *ndev = pf->si->ndev;
-	struct enetc_mac_filter *mac_filter;
-	struct enetc_si *si = pf->si;
+	struct enetc_mac_filter *mac_filter = &pf->mac_filter[MC];
 	struct netdev_hw_addr *ha;
 	u64 hash;
 
-	netif_addr_lock_bh(ndev);
-	if (type & ENETC_MAC_FILTER_TYPE_UC) {
-		mac_filter = &pf->mac_filter[UC];
-		enetc_reset_mac_addr_filter(mac_filter);
-		netdev_for_each_uc_addr(ha, ndev)
-			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
-
-		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
-				ENETC_MADDR_HASH_TBL_SZ);
-		enetc_set_si_uc_hash_filter(si, 0, hash);
-	}
+	enetc_reset_mac_addr_filter(mac_filter);
+	netdev_hw_addr_list_for_each(ha, mc)
+		enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-	if (type & ENETC_MAC_FILTER_TYPE_MC) {
-		mac_filter = &pf->mac_filter[MC];
-		enetc_reset_mac_addr_filter(mac_filter);
-		netdev_for_each_mc_addr(ha, ndev)
-			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
-
-		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
-				ENETC_MADDR_HASH_TBL_SZ);
-		enetc_set_si_mc_hash_filter(si, 0, hash);
-	}
-	netif_addr_unlock_bh(ndev);
+	bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_mc_hash_filter(pf->si, 0, hash);
 }
 
-static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type)
+static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type,
+				     struct netdev_hw_addr_list *uc,
+				     struct netdev_hw_addr_list *mc)
 {
 	/* Currently, the MAC address filter table (MAFT) only has 4 entries,
 	 * and multiple multicast addresses for filtering will be configured
@@ -232,15 +200,16 @@ static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type)
 	 * unicast filtering. If the number of unicast addresses exceeds the
 	 * table capacity, the MAC hash filter will be used.
 	 */
-	if (type & ENETC_MAC_FILTER_TYPE_UC && enetc4_pf_set_uc_exact_filter(pf)) {
+	if (type & ENETC_MAC_FILTER_TYPE_UC &&
+	    enetc4_pf_set_uc_exact_filter(pf, uc)) {
 		/* Fall back to the MAC hash filter */
-		enetc4_pf_set_mac_hash_filter(pf, ENETC_MAC_FILTER_TYPE_UC);
+		enetc4_pf_set_uc_hash_filter(pf, uc);
 		/* Clear the old MAC exact filter */
 		enetc4_pf_clear_maft_entries(pf);
 	}
 
 	if (type & ENETC_MAC_FILTER_TYPE_MC)
-		enetc4_pf_set_mac_hash_filter(pf, ENETC_MAC_FILTER_TYPE_MC);
+		enetc4_pf_set_mc_hash_filter(pf, mc);
 }
 
 static const struct enetc_pf_ops enetc4_pf_ops = {
@@ -467,17 +436,17 @@ static void enetc4_pf_free(struct enetc_pf *pf)
 	enetc4_free_ntmp_user(pf->si);
 }
 
-static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
+static int enetc4_pf_set_rx_mode(struct net_device *ndev,
+				 struct netdev_hw_addr_list *uc,
+				 struct netdev_hw_addr_list *mc)
 {
-	struct enetc_si *si = container_of(work, struct enetc_si, rx_mode_task);
-	struct enetc_pf *pf = enetc_si_priv(si);
-	struct net_device *ndev = si->ndev;
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_si *si = priv->si;
 	bool uc_promisc = false;
 	bool mc_promisc = false;
 	int type = 0;
 
-	rtnl_lock();
-
 	if (ndev->flags & IFF_PROMISC) {
 		uc_promisc = true;
 		mc_promisc = true;
@@ -500,17 +469,9 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 		enetc_set_si_mc_hash_filter(si, 0, 0);
 
 	/* Set new MAC filter */
-	enetc4_pf_set_mac_filter(pf, type);
-
-	rtnl_unlock();
-}
+	enetc4_pf_set_mac_filter(pf, type, uc, mc);
 
-static void enetc4_pf_set_rx_mode(struct net_device *ndev)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_si *si = priv->si;
-
-	queue_work(si->workqueue, &si->rx_mode_task);
+	return 0;
 }
 
 static int enetc4_pf_set_features(struct net_device *ndev,
@@ -540,7 +501,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_start_xmit		= enetc_xmit,
 	.ndo_get_stats		= enetc_get_stats,
 	.ndo_set_mac_address	= enetc_pf_set_mac_addr,
-	.ndo_set_rx_mode	= enetc4_pf_set_rx_mode,
+	.ndo_set_rx_mode_async	= enetc4_pf_set_rx_mode,
 	.ndo_set_features	= enetc4_pf_set_features,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
@@ -983,19 +944,6 @@ static void enetc4_link_deinit(struct enetc_ndev_priv *priv)
 	enetc_mdiobus_destroy(pf);
 }
 
-static int enetc4_psi_wq_task_init(struct enetc_si *si)
-{
-	char wq_name[24];
-
-	INIT_WORK(&si->rx_mode_task, enetc4_psi_do_set_rx_mode);
-	snprintf(wq_name, sizeof(wq_name), "enetc-%s", pci_name(si->pdev));
-	si->workqueue = create_singlethread_workqueue(wq_name);
-	if (!si->workqueue)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static int enetc4_pf_netdev_create(struct enetc_si *si)
 {
 	struct device *dev = &si->pdev->dev;
@@ -1036,12 +984,6 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	if (err)
 		goto err_link_init;
 
-	err = enetc4_psi_wq_task_init(si);
-	if (err) {
-		dev_err(dev, "Failed to init workqueue\n");
-		goto err_wq_init;
-	}
-
 	err = register_netdev(ndev);
 	if (err) {
 		dev_err(dev, "Failed to register netdev\n");
@@ -1051,8 +993,6 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	return 0;
 
 err_reg_netdev:
-	destroy_workqueue(si->workqueue);
-err_wq_init:
 	enetc4_link_deinit(priv);
 err_link_init:
 	enetc_free_msix(priv);
@@ -1070,8 +1010,6 @@ static void enetc4_pf_netdev_destroy(struct enetc_si *si)
 	struct net_device *ndev = si->ndev;
 
 	unregister_netdev(ndev);
-	cancel_work(&si->rx_mode_task);
-	destroy_workqueue(si->workqueue);
 	enetc4_link_deinit(priv);
 	enetc_free_msix(priv);
 	free_netdev(ndev);
-- 
2.34.1


