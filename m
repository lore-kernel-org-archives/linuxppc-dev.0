Return-Path: <linuxppc-dev+bounces-23167-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4902BC43327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:49:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFf61KGSz2yv9;
	Tue, 30 Jun 2026 17:49:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805758;
	cv=pass; b=gIp4dj7w0ku445xYJIr275MmcmlmrUA4QEM9zDh0daAE6e+ZaVmMqSlLOVRcJVsO7glxh5A5invcZBw2haZqC4hNAjdaDM76xnGwASQar1+OW1qjjl4dYZDi8aD0/iWs2jBdP2kodWZmHyBx8PE1ZaqVYIcDXyXk4LlCdNigTtjtERnWChJqaSyFxRNIDCVvUWXHa5WOHzcdyPPPfzMjYZ9SX36PKX/HmuhNVn51q03R4axJWtsTWP8pxsIN14H9vkjO20BKjTDg9MHcqbJPjS2i9oKr6nYOf3U0PPXB/O79RlToNO02U2/oKFJ4p6IIj2dzGX+KseNA2txrlWQHmQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805758; c=relaxed/relaxed;
	bh=L60EmV1Xc031R3GK0ggOHzJ5YHjfAxNz6KdYexjM28k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h57ox4pBeeMj8relbCUJzZMchC2aRDchIaF3wFzxqeRNamcqRmDwFg3dqczzyeYTxT2NrEOCO3JesVijKJkz67nFHBzrNhDLg8xOcF8D3cZgxYMao2xdPnp9pABrrraSGVV7x9lue5X8KuhgZlz8cmsm1ny7MTZRfXsRfj/HPjSECHeem4/5lk6GIsDFM18nN61okzhCYsJ7k6RjZHlKD/p4NoCqcpTwqd7taoPVljw6pQcZ3ZJ58u2deTxsuy0GkBcHYMJlH+Oxc95CRyHEOAkIL4mr+ieciy0kQMzQWj9aaW7n6F6+iSuD45MgSyyExLUC2woVVLcPB6qxo+cISg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GfiNADLx; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GfiNADLx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFf538T1z2yv8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:49:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTsWYVw9kNTMyIh4qRSoFlUHNQSk7vdnVUiBRMUZFWIsrt9lhrrzYYuNkVGHfHiMMsU5OTRDpRcwZiG7BIaGtXxZvf/8aHaiS/zARqSjAPoywt6Nz2s/S5MA0/rUtZOZMDzhK6JtEnYd4+8Nq5jKXLtL1Vm+Ge4/5oXiLo8ARzrtCTU2la6u+/aRL3cgwrswHzu7pAJHlvwjuUoKogBsqB0vRQncTafINDL8bDlRnumDMKRVvjWWxSlPAWtj7pbWf8H9z3/zncJmWN64LBahivrNxDGC0K7HiO9Z67iyUprMDaCPLDXG1XucIESO4nMdUnMyqvWE+gUGkPYuE1FbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L60EmV1Xc031R3GK0ggOHzJ5YHjfAxNz6KdYexjM28k=;
 b=ASGSIV+qepg1HcW4GIXP5WA3gCkbpJQ2HAWMgimhWPHaDJQXVV/W1Uy3uj0afbnus8lshGrzLMJaVXEGFi+1KZIrvF4M2OC+rCWzos9I+vUSkiA4CCsvCvzzK7PVooGE2UJeN2BjNyK7IDdOkGsuQhLxEhw6l5ITZ4h6sgOXTO+qoMKw3pIhNvlNc6TNnnDKBUvOKcbcJUATkoJXJJ+zHMo0K81nhmehSYnehZ3+BKlfvFtYYd8g7cr8vTzw+5og+oIdA2vBw6Hn+tm0cf5She/uL9HfzhvXINZN9WA2MtfKbVIlVet9Bjy11E36aUHtFFDFcQ3zx+TXMEDmzKMXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L60EmV1Xc031R3GK0ggOHzJ5YHjfAxNz6KdYexjM28k=;
 b=GfiNADLxkbFOQngmGjHtv/WFdQZ+f55ZyWPpVMD+NXjVXwEVvgstQ53XXzh6wg/h0cGOVbTkB91FrUvBzEF+K8em0/++3cMkmmO+HwFiiMxcjvXUjvOuerDkg43hlU+0kUJEbpSy8GpTtKiDzDbOjg1pTkDcXRS0Is/Wz/T1MiASdJ6DlajjDezwp5dvqO8O9BjI86vTIwbZ4C/hTn6eIC/JEw66D0vpiHZ1yBuYi8umZfUeq7DBGuoSzTBt4fcMcZhZcyZeUDVgcvQ2pmIE4jWpmlTr7f19DEiL100gdMfi5AyxI/5ZZFU0jrR8fR30neNuWvlje0J3NjFl/43EYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:49:12 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:49:10 +0000
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
Subject: [PATCH net-next 06/14] net: enetc: simplify enetc4_set_port_speed()
Date: Tue, 30 Jun 2026 15:20:28 +0800
Message-Id: <20260630072036.382761-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 43158760-69fa-41eb-56c5-08ded67c1274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|19092799006|1800799024|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	jUCJ3YS0hF+QbNFz5weHEZpKxoXS1V56JbgYoQF3z3Gik2qugGWP6pUxHXsqe+sQyBj4JS99se7fJPYaUr/5mV4fx6uWB0Lt9AZZz5ANJ8AbVsArtpljGsTrn+zFFDU0nX62feZEMKa29hxcH/FGDtpaMkZXltw6RjwPC0Up6HDJbCTXnIHaIS8LxebnY73Y5BIDHlNvd92eIAOOxmsnhstBlzB0FmTD6Q4zlQKqq7jVvDlTPHf7PC1S1R0DpmOLW7/TxvJHfxLnfbD9LLaVYUcB2fZk76TtvgkYmSJpHlGmDJQHm4MpbkrcvJYyMP7WrT3V6CxE25ib0olp69JGmIUCBYP6kuqN8FQ0v5cdsnmZzaI6t+swIOl7PzbjREwqfSB1plyVs9mzddc32h1cHQxrkBWd5IDiD7vEIRpT84ewpPq8yqDVvxqbRd12WNoKthb1+BrzLp7ucNYM5Ykp6JR/iVzmpXXlAZMTuSc88JgvL8uBh7KiNJAIzns+HLboyhkcctqNxnBtEr+cT1q3hyDW4e+sZqXIp+ZTU6w43JvibT1YySbsSWvVzm31sh+bGiAqMB1B8WhQ0Be572vcyn5+GO8GP/xjbEWRQ0vVFPTP6jmFVPRvMaI9EPooBLO2ZlD4UYuZ9+lJjpaJxdTYDeT5Y+8Td6XWuw/bDVD77u8Hc1LVV2gdftrFozQFJM16PH5DDW160W8nVLGr9mBhDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q8aPcfoD72Qb1Lk5Guo48NL45CBLdX/nrAy2E1E0LFeiGgZOHXsDmkIgsrrl?=
 =?us-ascii?Q?nwBrU8TBy/6LYUKrLFHycRWm7gKYglt53t0yHssuj5WnmDQNmsRbCVNgUuXj?=
 =?us-ascii?Q?K2oHDeKO7qXOm94SAUlFi9iVi2RK8MKlODIDQ4algpc5kk2xcdiiiskgSm3i?=
 =?us-ascii?Q?IHUS+HC9oYkrV2tbPC5USgtIiRt9FIiGDOI2iFAImd40SpaRXE5ZEGtTY8jp?=
 =?us-ascii?Q?wiOHpJBGxL92jUngNKszvg9aQBPvTsRECHaJpSUskRdRNFe8TANidPA1DjOL?=
 =?us-ascii?Q?NK/htEFfc9+OVm+UdO1JmMrr8p2KbwGxYgBGGzI3b4mTJGzjeUOn7kJxpMnC?=
 =?us-ascii?Q?wINxWueSJ8UjXnz0E1M+xBZ9ipLgAV3s6boP/GTZ1YrRczXYh0DGuAvTgMty?=
 =?us-ascii?Q?zolWtK8lWZa1IYaD0FrVPBdPeFvXXLqXD9Hdhk2gDZRdpPzUdHmOa+opbsGs?=
 =?us-ascii?Q?YOISQ4tYVlLlEzBK72qjuv9XTLdKhczz50LhGZmITX3Qgaxlz0aioIsrJ19A?=
 =?us-ascii?Q?QO6y4AN1ZGH7MQxZ2c35bg+pDMFV/Ulcx2/LelHM/zD+1mtYRqAJ9vF+pnD5?=
 =?us-ascii?Q?rdWUujz63QEC1w9NyCvo0cYwK3a3zN+uarp65uY6k8ueCHBlanvQ0cjc+ZBF?=
 =?us-ascii?Q?QOPW+7dg8rsPUEWKGKGIcjp/b+QYOVqpltgsNyp/TjDjPvEwKcaCJdfJ8kpO?=
 =?us-ascii?Q?hwpf13TcQo1hgfqvmaMO8gsKtRIuRQ534rjtLX6+XsHztLOb9fxXUA44hKQs?=
 =?us-ascii?Q?KXhykqWpHOK3X9Ow7VEOEjIfj0CYTcFCCevj+Vkk4FcgS5S2nWKBbN1f6rjb?=
 =?us-ascii?Q?tD36ZTRt5whehgmVF6LUEKHwKWwaryShxJHv7mE0RuB8nz2sm2oAF89bf3yC?=
 =?us-ascii?Q?ir1dfJSSohFnrcR7sbp9ORLkyS9r06ezsO1U1TxGOznCDPAjd+IvTYPhlHt5?=
 =?us-ascii?Q?zEwSrwDkX8slzs0OGJIhwn7owUGsp2LbvO8wjIDem0WrDnHIrc4r2alqIzK8?=
 =?us-ascii?Q?DEjshHmhEdsacH4Fs1UBMbrX97ks599yU1Iva3p1l23HGXoFh/1YGjiZCeup?=
 =?us-ascii?Q?Up2AmRJ9KKxSRKP3GQiVGeuWFPZ4VGOGonXr/NeVRoungdc4lQM3qOHB5YrI?=
 =?us-ascii?Q?GL2X0znNLyjT5ZsuQS2S+DI18KtuxlQWGTvwjpMlrtlLJxGLjR5tl98uecxs?=
 =?us-ascii?Q?vJ2JxBYnrJfFROAO7itzC7LPRJ7yjIZQbkvbyHm43SPm4Wf9lOCQFP4TmF8L?=
 =?us-ascii?Q?JIDRkPSAxw5U922Yh+fEcEWT6/HJpenjRqdGn8mKrcrNlLiRa51ccq1mswgi?=
 =?us-ascii?Q?3dDwzhfsVTmXiRgUcQHfyg6jaQ8Zh+eJijhIpZzOrrkbRM90EB+10xhsb3IY?=
 =?us-ascii?Q?6cc2LnBQoH/xYRPtPgHu99FvNzpwS2V++j7U1ftmQkdKfA+aZBxaRyBUUjqI?=
 =?us-ascii?Q?cEjwKUYIAmnoB9IoVrN1JoNESTXoyIUBAwSQrX3EtHCgTVaMVeWu2TxttFrE?=
 =?us-ascii?Q?u2gagQPBonw5w/qbUtjiRMXbxkxk0QrmHprAexZDsdiseHKbtJDtq7BueAP7?=
 =?us-ascii?Q?TMYsYYYnaaIdUdkOrZ+26epBrs3W1GyTL6IQlsH214LJRWh6hxB5eMx+3qAy?=
 =?us-ascii?Q?UQTQ1CqAklPKmAF3mDtvntQHJBkxQlQxgjY026Z2G//sV79uegsmuascQoG5?=
 =?us-ascii?Q?Z/EVPEfRdsoaF6xd9svPuCByS7GF9cqEnHgYplNlWLkHa/PhKNkotKjKPz6V?=
 =?us-ascii?Q?9OHpW5pmC/ZVUnH7WVedDMMSlvjwuUrw/Xwys56CymvpY3b7XRNW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43158760-69fa-41eb-56c5-08ded67c1274
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:49:10.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGtM9AkyXsObRi8EtZUNEkZVZiCdraHM9IWPmg6phcYPmnocS5pUBX7Fz4f6rDFeNoArBNSobiW3DOO7my/ffaLyNHkEH8nnmxAsJ/JtvF53pp3/NNvQ9SB63XllIwk6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561

From: Wei Fang <wei.fang@nxp.com>

Since phylink only passes valid speed values to mac_link_up, the switch
statement with its default fallback to SPEED_10 is unnecessary. Replace
it with a direct call to PCR_PSPEED_VAL(). Also update PCR_PSPEED_VAL()
to use FIELD_PREP() for proper field masking instead of an open-coded
shift.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 19 +++----------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 6a8f2ed56017..dea1fd0b8175 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -148,7 +148,7 @@
 #define  PCR_L2DOSE			BIT(4)
 #define  PCR_TIMER_CS			BIT(8)
 #define  PCR_PSPEED			GENMASK(29, 16)
-#define  PCR_PSPEED_VAL(speed)		(((speed) / 10 - 1) << 16)
+#define  PCR_PSPEED_VAL(s)		FIELD_PREP(PCR_PSPEED, ((s) / 10 - 1))
 
 /* Port MAC address register 0/1 */
 #define ENETC4_PMAR0			0x4020
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 4143438ea7a7..b21ff362c31e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -631,23 +631,10 @@ static void enetc4_set_port_speed(struct enetc_ndev_priv *priv, int speed)
 	if (speed == old_speed)
 		return;
 
-	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR);
-	val &= ~PCR_PSPEED;
-
-	switch (speed) {
-	case SPEED_100:
-	case SPEED_1000:
-	case SPEED_2500:
-	case SPEED_10000:
-		val |= (PCR_PSPEED & PCR_PSPEED_VAL(speed));
-		break;
-	case SPEED_10:
-	default:
-		val |= (PCR_PSPEED & PCR_PSPEED_VAL(SPEED_10));
-	}
-
-	priv->speed = speed;
+	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR) & (~PCR_PSPEED);
+	val |= PCR_PSPEED_VAL(speed);
 	enetc_port_wr(&priv->si->hw, ENETC4_PCR, val);
+	priv->speed = speed;
 }
 
 static void enetc4_set_rgmii_mac(struct enetc_pf *pf, int speed, int duplex)
-- 
2.34.1


