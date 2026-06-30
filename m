Return-Path: <linuxppc-dev+bounces-23175-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE01C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:50:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFgG1SRPz3cPl;
	Tue, 30 Jun 2026 17:50:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805818;
	cv=pass; b=M5fOpD7MkSaRYqY0/fUo+8AaktaQmG1nFMZHQQer5USGbwLeJcPnvE6oCcWL+HbqtOGz9ArEgunRXakO9YkKj5rVH8yjFVYiVH9ryoB3opNO58v/XRO1cWgoXCzaZRbecPK81SHFNzBu+pwaziiETYAPLTGQk0GxU/1dBi1kRQ9n4IpIMuPbH8N60SZejXDbGk7s9ZbuM1qLQga52A+KykUqlDwRT6w4JfnTuQ7ZjSifCOhI9uhcMn4JA3rvTkwRUybtCjuevAFn5MF2kFYrY2mhzC/Qzc6J4h4ICLablM6iI0VbRifpbJ0anlDQhfaE1vyI8PMsc39PrA5ZVY9HvA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805818; c=relaxed/relaxed;
	bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AtqyCAJWu8kX0CwgxgTDxWckAmsqQd+b0H/F1o7aens15/YX77Ks7E3PRdtVwYD2DPqyj6decsJyPc29CLSq4Di9P6KXKg3DSMBhWp6tCZwPNN0/KQsKrq3A0q0ejBjsgn/ODqXy5qT09EajMtOHfzRubMl6+AFt3xi7BL0G8ZTqpQutquJuHs2uXUwkYej+A3EYMr/qKWDMQMYOW4d3IBN4etKXuJrAqsd+RiD6EmbtzK8EN1kr890IRdpgu/WhMmqU9uKAVFwRiLgsebLExSW3yRGM4ufwhEvwg9duuJH18vx/X7nFDCy0MP9Bf/u9+u8Ia5VMAA+s6/2By+SgFQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EBySJ7DE; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EBySJ7DE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFgF4CDwz3cLr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:50:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8egj2QRV4tNoiKVLCV8+CvqGRt1QEofIiy0kiFdSaxS8+ocXRBHPhikCZxJho0n1uOl4IJ9th+6o/yULw7MowzKFi+umpthNSXKaxI5khDOxIvH7kSYJW4ZKKP9lJHQA2L3jCqA6KeaT/eSKHnvHZ99jXd/Wllm/ny3O507Kx7eVMPVGv/b0FKipL086fulbEmFs5J7Ir7wQ4ka8Rme1ShpIyvDP9w7Z8k9L3oVIApQ7qekmfQkm2VGAgtDMBuoELZx+Aus60uRu1GOUTCwrl9/2TBEFyT3UcZ5ZSLWwEGeIpDUZbRB9eUrSovu8/jCSDA4VPKBRFYo9S0RMzy5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
 b=FtE5jStyu3BgBj1LkqVOrhe6HYRavq3g/jJE6d5ay3zlJ/YMUobO8yYFEF9yxg/UxgqIKOi0yNU47FcGqCQeZGNnWcO/VX9KtJ2KJsI32rr0KjPbs0Rh3HVnoryeKy7r6YfYtSV35D6/J/ySEii9tVTEK9TMIan6SdTq6/O2A6Jw9LUmq3FeDtI1ZakeDLd/p2lR2AVYXWsWYE4X2bWd1XiSTaNvAfEj5HJrEtmsl/nHiU6EdVDt9rY5QdoryaROMqXw0j7oh+9vZPmPcDpmimdQe3LQnby8takhtN1U5vo9w4+IH3kkbUdStVSS4sWHqqJUnU3ZE84HylE6n5dWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
 b=EBySJ7DEc5jntHOj2twJGZf5gYFvQal2zlO1z6xyU2Sw1Ma4wBKEpji5rq13y4dhikcIMXd+lvEA2EMRDMSvVpo9Olxir9N3dPmzpYQVux89wSIXfOYYgU2RfLvvWcL1XM67y5hjjvQU/PyDhyYAWXDNEH750OtwlSo2Z2bF2fXeTsG6+7ykZjHGw7lKDd1DtXMjDO/pX2ZlccJkHrPt6JASGYEU9fOFLLZw9ASI/O4KewiKPl4gYMW72CB09ij0qWz8wpu6xL09t+ctBF65zRhh0K/yf4dLEXJBS+sAF4ZMQYRTXYBq2OfV9SDQOSf8JwVX01G+cyhsOdLALlb+sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DUZPR04MB9918.eurprd04.prod.outlook.com (2603:10a6:10:4db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 30 Jun
 2026 07:50:00 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:50:00 +0000
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
Subject: [PATCH net-next 14/14] net: enetc: use kzalloc_flex() for enetc_psfp_gate allocation
Date: Tue, 30 Jun 2026 15:20:36 +0800
Message-Id: <20260630072036.382761-15-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DUZPR04MB9918:EE_
X-MS-Office365-Filtering-Correlation-Id: 003567c8-053d-4759-4cf2-08ded67c2fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|1800799024|366016|921020|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nGN/ZmFzd8noCPaRjRP0ngr5fHdGttfEcRLktAzddnS3QTBkcrx78+pag509qfJTi1CQRaxmhEpkaXA5xfZBVvMf6ZrVdgcEuzw8jL4Glq4aNz7kBdXjgGxoOSDOiZ9IPt55gMf3DCzXH4EN5+JYEygNDjoh4eDkZApNgQSxwgarJP7zzaU4DAODQWwGBIlOU0WezL9zc3EUjYohTNzYNASORxi0JgIJyWwy0+aEY66pIXHr9wqdBuvub/CsE/YlBtkwXxj1X5gSO7XXEjlpKn8ib9LDk7u1blSJl7aWTq5x/xu+vEb7U63+jFA6X7i54kp3cmWHmYjaO/If9kHZqnSoAIvTbdRkBAP+7+r/lr4wDaFNXun+2pcLhG8gSPKHjnpbAdsSFpMqqvW4N4dMBAIu4pqz40NDjVNvLyHjVSX0esSD+rKAnYT1Jp3q32sJJpcFbGTulhbr9MVMvUZJRmKJPeMRgzBUs320/EIvAXr/1/vVZ60ESHyJz2RTVq6BSmgueEMCq1kw8+p2u7lcsPVPxZeRxpCct1OhtgpgLvwhG+rinrGA3wW5oG+pJERT/9llbHfEO07peZlbqPqDhxJ7yd71GcZrN6NuzAxtQ+Jn8sr+Z+u1iSImPOAfYVN45fnSWopwAuKAZiyBU2wYNE2ZbTYJ+93hYy0KL874S2DFf8Gg+3ijxHSt+7/ZTO/4Vo8L+JhTuOZvVehn6LXqGQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(1800799024)(366016)(921020)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yahuWumKpUJSe2TY/Fp914e1k49u6AGktApLBR8yo82HKDFECJq5HXnNxpxi?=
 =?us-ascii?Q?GX5Z4ciZPCoZ6+HBNfnJCRRRkUfs1nuqX2D1IafNknHa4OxgJZ5YI7/DwIbh?=
 =?us-ascii?Q?eSJ9bYdyBHkKtnbg6P0gXPNMKvl1kvJ3Vr7uWZ77PwOddxZFR9sXb2oTO9AB?=
 =?us-ascii?Q?8fP6K2CoQ9996nW28Hu/xE84g+KVwP4WjKoX+U+ZfiKXu/eRJQiL9G771Rac?=
 =?us-ascii?Q?Qi28SE7YrqzUemP6uCK929m8dxF2CjFi0Vh6BjcAmDvXNXPCKqIngZmMNsR6?=
 =?us-ascii?Q?tS4/WVnlRRrOZxePkCMolwxiBA6nHYrOBWbn3WG7naKRx+bVWziLsKDicezN?=
 =?us-ascii?Q?iLi6kKzaXUY/1gOHiw4WLD5Clv2dHIPF+XDdQCLgXpdJVo8YmMKHigaczCd0?=
 =?us-ascii?Q?l9K5l61tTaUv1KQmu8T6rsUMXpTPYwmtWeMjxC2rAws+j2VOAzUGaV3U2t1h?=
 =?us-ascii?Q?be4FN8zVEj+9IPASvDdOihz9sRgSRJ1dkVxxgu5Pvem1OVX426oZJEcv9Knu?=
 =?us-ascii?Q?wZYPFl1eo9VQ9Bw4xfUqJTSCYRocjYUaPhPPGJO0TzSvDJWlNGhIhX7Su+i2?=
 =?us-ascii?Q?H+4wLoxvb764PzPbCuyml3xlC8UHylEqcjJ4yGb9rTHH2dK2GYgfpPvQrF6h?=
 =?us-ascii?Q?6s6ZRs/lgyBjr8Hgag/dr77YgcG7pkQTwei13ohO66fcy67llTuLzuMnN9RJ?=
 =?us-ascii?Q?lGqEW7Zqshk33B3NfxlL/Ah4NaL9y7Qh9ePST2A/B++TaVXUfgQvEIwetygj?=
 =?us-ascii?Q?wOnDhGPo45m4HP35L6BcOzRthdnbiDCKw9k+Th6T947QLyNQ+hNjnMupkdoX?=
 =?us-ascii?Q?+4YljG5bzkNf0qqoxqaGpxzHIfrvGFdhNrBJGE+SRin4icrV0+p1jcCsashB?=
 =?us-ascii?Q?iGKBmtl43up8s/hUB5TqsVT/lfFiQmxz+nzzN27CfdyXyuOde9N32cJr+06d?=
 =?us-ascii?Q?4kGQh9Q511PJMK5yRJyVaP5mgqCtJaRrh7OawRwjFelVUom63vDVaZNdYdIS?=
 =?us-ascii?Q?SFeKt1qd/g8bv6DtP1WBFC3Ugr+muj8JiaDtinjqh+MHl6RnnYGEq0QFbOCX?=
 =?us-ascii?Q?+rkKI+5iByRShD41DyGw1VwLotB9mnMdiauXep3xAxmKLQi0WJGtIvjyMeTQ?=
 =?us-ascii?Q?ML4M641HVYIIlQYLDBjV3KBc5jLhz81MlSCurL4X2mJG0CNs8EE7jTnySP17?=
 =?us-ascii?Q?sFTlGornZU7kPbkFU8xE7NG/GY2mDrKrFqBhAaS+SpweQcqCCtfj1uhvRTQV?=
 =?us-ascii?Q?aaTyC9gloasBjrZe53KjQnl5DtRYb8AxXPRUK7O2uWexMrL+OccQ8XiEZAxd?=
 =?us-ascii?Q?KH7TKuWLuQycZ9JfL3YYfzUJ661oWsc5hzbmwZZeuHgYHJBL9Sfi0hO9Mr9o?=
 =?us-ascii?Q?oUecXvUSRRRsKNg3NFPjqNAprsKcDqM+m1XrCyc0M+zPuRmaiWA4VhCKljM6?=
 =?us-ascii?Q?CmxMixsGS+1DZMfu4p4Reci4onCsXz0yIneaujm/xN9BzCfNy49hS8Lv6oeK?=
 =?us-ascii?Q?DMg7mRciZdjCizS/ioaatwXS4yJk1nUy4A9MPD8mjSclcozwJRyWSnzWLRPI?=
 =?us-ascii?Q?z8m6jGI5M/9WghMjFzjD1m+mZMKKjTHz1Bd5XKbEZ+XAvdhm4TRvWpqy+1R9?=
 =?us-ascii?Q?/fGucIW1WEItpjJiMATrHIZvPHeCfVP8uHCWnPBKc54hgG+MDoO1dosjJ6SI?=
 =?us-ascii?Q?D1tPmpL+2Ndf3lFUeWx3wDuplL673nBgHViJn7mTYo1sUeMIIYiwUug/HF5p?=
 =?us-ascii?Q?5LKSBMCPtOVAHjfnJs6HZLRdL/z6TIN8+yFp4bodlHQaTFIvx1Jg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003567c8-053d-4759-4cf2-08ded67c2fe1
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:50:00.2568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4L4cq04jC4uZy9hFCPPlkP3QYIntqAylZ6CVUW/k8KNHVFql3GZrdI5MWIWSMgjtgsGjdsks7Wiu4tCBxwCl5ElKIQNykJ2nJuhUcfbeELlzuZZLjXnH8ZCCubglVLt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9918

From: Wei Fang <wei.fang@nxp.com>

Replace the open-coded struct_size() + kzalloc() pattern with the
kzalloc_flex() helper when allocating struct enetc_psfp_gate. This
removes the intermediate entries_size local variable and makes the
allocation site more concise.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_qos.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index 7b17bca24f26..2aa0fcaafcd2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -1135,7 +1135,6 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 	struct flow_action_entry *entry;
 	struct action_gate_entry *e;
 	u8 sfi_overwrite = 0;
-	int entries_size;
 	int i, err;
 
 	if (f->common.chain_index >= priv->psfp_cap.max_streamid) {
@@ -1242,8 +1241,7 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 		goto free_filter;
 	}
 
-	entries_size = struct_size(sgi, entries, entryg->gate.num_entries);
-	sgi = kzalloc(entries_size, GFP_KERNEL);
+	sgi = kzalloc_flex(*sgi, entries, entryg->gate.num_entries);
 	if (!sgi) {
 		err = -ENOMEM;
 		goto free_filter;
-- 
2.34.1


