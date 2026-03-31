Return-Path: <linuxppc-dev+bounces-19071-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D531061B32
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 11:29:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flQrK5F7Qz2yfK;
	Tue, 31 Mar 2026 22:29:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774956577;
	cv=pass; b=LWgVIbMoiuQiGUwbna5Wz+I/OGa5x+FDmDGxlPQToPcZsDu9ZJjCpoaAohnUbLeY5yoQdfOA9F3I78KqE1D19DX7xlftySSfQ7NLe/Qeywp8/46jduRNnK362BJp4wIofVCF1JTQYLq3bkgZlyRaS9S4OiX5F/xiemDElqFtPjmVodwkSKYf5UiW2EBfjCgvWoi8SE178da3W8X0sN3S9Sdk1eyxKIMDbp/e70W/uuIP4KVl6/bjiHsLllte/0syeEs6aNUUmNH5LcQKBDaRfbyLoI0SYBCA2TMloUkpOebGyOD3g6yp5NrAI1PTSYABk9TLnFVJ5AZiIXaaqxIsYA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774956577; c=relaxed/relaxed;
	bh=Pf9Y9p6ICXZrv2WVScN5pUjaB1x+5qUjldE+EQle0AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JIBztoZOJOjzl0M/z+spp5ODM9RU/xBoxL27vDWJT4zcSRVfw0I8vAl665Y9Whwv2iQUoKRzTnOWtJ8qZnruPcfU99DRfFKxjvOPtiOESlVRrxTdDbjtSlnFPcHsF7/3cpJBB2qWC5ivDeCtr0HOTfleP48jd3BxDDXKlpXUSw+R6jx/hgmNONB9eO/FoekFtFNNRL+yvdnJAzZpgx1cPL4TbOCy9JeYXP4LZSjEEfje9okZcQIc+PuqFEsvsC/T9QCfNUo3WB1Xk7qoj+GOADi5ps1Qf+khBjq9+1k8M0uEmZOPi57M+EXHRPb5MQJMeEWuLavPyjgkhvo1145MZQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=esvgF4MB; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=esvgF4MB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flQrJ3RSvz2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 22:29:36 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8UXuny7gz0Ey/Yk+gqmqlElL47W91dFxxpi7Zn/xxRp8WFemJddnv1wV7EffZZ3iey5ThWmfIW6/nxDlM9AWC9c+tP3vYsSHU/cPE4exU5llg/2oUp98HD2s/dv2q9bEme/2ETN2dUynYtQGmKg4piKH2xKl3H11lCf9ZOfaFbDITxK34c2yLD6zJEKooarLHOuecetOlFob48XgGpJOFUfillG72fjvN2QEr5UCxKOom5Djzccig4qLM7x2cmgFgXy52rEZEBwloeSZ1D7t8acQm6iPMIX4ySjUxBY09V89mWACdIdW5F6kvjM7Mt5UoKHREus64KvcTBVwIIiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf9Y9p6ICXZrv2WVScN5pUjaB1x+5qUjldE+EQle0AU=;
 b=dPDXcK7LR81F5zaCCoL3rLyQAZ+W75bSvRNYjAhBgKx9irz9vlGP92SKeYphvjkBEs3JFrRmd0Dh4CWhsa4eOhnxDaCx88rOyiFztPICVfhX/xM/hHDomAmpHS/svS0XpdxhXhm5b27JOZdqwVwi81aTrTTMkqZ6wx0fOg3RpaSBld+ZGrRm71vepdlxanGWM15lFwwhe44paO+KJSBn8UcUBKyFEdKYCTUBKjySZMkS5jDeHjzxrNeib3B3qK4DHRJa+IEQMl4EsC+1qk3n86JE/fgKpyPGVO9ekwpVHQBTScf3J/GoeKSj7rbktFVyPlqBy/+c5039bLFKl8WwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf9Y9p6ICXZrv2WVScN5pUjaB1x+5qUjldE+EQle0AU=;
 b=esvgF4MB4xA6SshAQAyM1Bc6aVWTx9Yf9r6SyRHgHqPj2dk5B1n4EXVgJHSxeaDPq20FEtkAvUGAWpTVb2xkMZ+DMIyvx3WL//4SL+qZ/RVtDEsU3EpMv1Id11HUXk55UU/vvZSCsd1kwBZImoS3p+TxYY5q83nUMb+cjf/VlXlnd9AlEH1Q62Z98UpWWkmPh5F9X9qQMgSwGKg1iVUoy4mV/EVZXBPV10iRWqmzHkJ1cDZcCZMkMY1e1uVEVJoeFyFF0WhxyFqem8W90Xl4FEnalgZP9X/E+lsG/b5FM/X2ta1Iut18KU6r48RWazlEbun9nA7lABG40JC6MpIcSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:29:14 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:29:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v4 net-next 06/14] net: enetc: add support for the "Update" operation to buffer pool table
Date: Tue, 31 Mar 2026 19:30:17 +0800
Message-Id: <20260331113025.1566878-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331113025.1566878-1-wei.fang@nxp.com>
References: <20260331113025.1566878-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0151.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::14) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: 028e630e-40c8-4fc8-4d50-08de8f18bc55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|7416014|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	MtNL2924XuAUZk+e7Ena0DDE4pxlSB9L9A37qEDXsVEcvXOODENzjqAZ/w1+XHM2Q2L98OEzDlyQujyb9OedW0v+mS0erGAplOxNPnr2yZRkfSZhpDmlZ55ccqhr/n7By4+7CN1r0WJPZiSNdHLASIoCRUminVwLXWd/sr6biHsbCwmY/TPPbTjue+a6gl1sqmsgBbMk8NbC7dqLW3oRktMLT8vic7CExOlZs6qF7hQULICete4exy9HoDtoIA9YMAf5lwgSGXKc4HPbx281vFZFG1ePXZwFZR/83K2CT4y+TL7OfzAuat7uw81eB1ZrMBKmtnUQlI1WGIzuE/XuspcVRF53Pvw1OOpu+wdEh5jlid2hn3FCgv8IyasMPDFZCwbm8zaThObqGaPaw79LYKY8GFaXVF9uHf4bbrJyFXfi/7UvIR7czdSn59YiPym8Mw6+x598cqP0mtK2IwJRt/6FsAG+nFFN4jFRJT7CWwkziK9Mx5Jh3LponleubPMd1DJVo8K1HkB/hHVbPKxhQQNpKETAcppcFqWR04UUqKPhNp15L2i/7mSz77LDWW6VfGwWtBHjw8jYZa9yJU7lR3WSeG94vX8y/fqHxUE59zgm66o5fLViidA0Lt1W+zw/DFQhl2ryMp4LHgUv0ZCN+R8z/VTAviaWLLGxoKNKLqb8tgtbpI/SSRcHnpoZymkmYzL9SRXq+zQo9uqOIUlfkFk4LCQnaLxoW2NmD8xiSq7rRpzjDObUydHYNoSTIlEmh9wPw03zOnKjdjIeaDMMiqKk1325O6eyVNk0mr4XkzCalQVBgKaTB2DgfEiuKe2p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aiA/pM4HdDwykpaKiSnOFAEH++JlbmPQMaAzvoVtEPgmrSIB5gGuXbDAfxmY?=
 =?us-ascii?Q?6mNvJVLCzyra9HjFnTM4xnfZalW146CkePzbv2hqSAK8juGeyy8ZnXfgYtIH?=
 =?us-ascii?Q?SCjxEspaWT+wF7r/in0MJCKAvWyzDJ+DyMsqzo8+qkzeTei5SZ4TrqTA6Byv?=
 =?us-ascii?Q?6NZjEDz1hPWiwcp+Ik0DJbyFQBnvCjuazXON/8jer5i+VIrJsEATKxncQiyJ?=
 =?us-ascii?Q?IvHUPwEiMfCPWx105EF+bF5ByTOCTO4QbKSfIFX2iGz+wcl+Tg6KHI2kTs2/?=
 =?us-ascii?Q?HI1E04k0NzD5tbQ/0KxTp+HRb6Ja0dUPMNmsgQt++mng1hmnAKDs9K9LKL2K?=
 =?us-ascii?Q?Mz5P1x3xazwtYpdxxyeF+yN1+agX3g0i6zAJ/o/dKVm+Sgq03YcWTzguFq4x?=
 =?us-ascii?Q?0umUQiKhSTJC96+qGS6SeY/yTZOJ50hXS+AqNgva2Rm4odUjXvxQci35MvJN?=
 =?us-ascii?Q?N4q40u/hWxhp/BAYRDK+FrRM2p71MSTqFzne3t0IFu0Gcrmlo/JGwa92bAMZ?=
 =?us-ascii?Q?LQWnQCqaO8F17g8imDYNNIGSi4lyMdJAJk9ERIsP08sxvkUmVJgIKqTM7CeT?=
 =?us-ascii?Q?5aMIOmfNiGt7uMOA9snwxYT7J/Bhim6IEQDYtxNz3lA/IQlAQnjansfNjBHC?=
 =?us-ascii?Q?0YW4UrihigsekwBkIUQ/R9s+rUKug3BwhPzL1/4stFtDUYVBzIiiAq4UwrsW?=
 =?us-ascii?Q?P8yXA1I0dqA3gWtfygvEqf4Vi8cUgJT+2K+sKf6gAGW0Jw1BB2psdxbv9JsS?=
 =?us-ascii?Q?4oS5pBRgilKU3SRYev1JSDbY1wlh/leyo9+7Zq9JClwmfAE0cOTofcR0f2fH?=
 =?us-ascii?Q?2qC8VOnYHXRC5+cA5xJzTjfOkmTjtwJwPLFc4mFnP7RI/cCm6elBG+s212bf?=
 =?us-ascii?Q?v5CeXJArpcC3Pdy4hxlV52IcRtEyD33tNXk1CvU4Jil2yXLfCybf7POT2XRk?=
 =?us-ascii?Q?P1KG/xv7UzEMb0l8NXbQQA0xP9E05MSbrqt9YtCT0mx/L6maIc51ScOfo4MP?=
 =?us-ascii?Q?xhTx2c2+6z3xk4Hk2nckNibWsJ906L1P308s/bcLPP5ZMq9NBY6lKTgRPq03?=
 =?us-ascii?Q?HBrHi86D4K4B2kMDl15GYtVh3LNMxTFybEovLOwOlt44L7oVGEnTijMKmhom?=
 =?us-ascii?Q?rQo+64je15tNzdnvdqDd/+fySF5rGCAUZ6BMVNlAnjiMSeki1naNRbKffj6E?=
 =?us-ascii?Q?Qucl/6jEa7/NFEy70m4AHtX0GCYY3DMqoHAWwbUtBqW3lJ/c9cJA4HCFkFIw?=
 =?us-ascii?Q?0EBeKM52K+KO8VRBTMCX6L9QecCPp9BopAJBfZarmHUBIWj63EUplWl5T+PW?=
 =?us-ascii?Q?OxETXtPF6n1IbVIHoC1mfghy3Hd9VR/GWOAYNe05egKAlu283w860s0Wbbv0?=
 =?us-ascii?Q?8WiOnIxqLqAHZsQppNNi+GpxWayOtQirLDp6UZNGZPi96BP9npjZOadWXksI?=
 =?us-ascii?Q?HW/o1iw7UZW80I2aDh/+fok4fW/4ZzgJTVWtAYJ0JHO1rDUkibu558eiTWi6?=
 =?us-ascii?Q?AD6bWrrZ9ZHWk5VEpy8k7dw46Rvv9SYZeguHNbiKCvAiesoPkspnZuXu3/1K?=
 =?us-ascii?Q?MBJzCTEO+OXo5XjQb1E+AwJEZ+eZVkaFXbCmhZ0teU7uyo09/GCg47ijPak9?=
 =?us-ascii?Q?b56z/CTFvjyPoKmgRBLWZoUuYqMYefRHC9p5BnUNS//911tiUKDhuzjUdTu7?=
 =?us-ascii?Q?yh3hyYouPRvIdt4Un288IasmSKewMAsH2p0DYnJE9N9sntAM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028e630e-40c8-4fc8-4d50-08de8f18bc55
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:29:14.1368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KAbA+pc8mIiLG1xyLL1lKVRDki9EyDCNtCx911dbLZwj27fJ9mF/sdqcAYQJRsWjRBRdC8Yo98REX7pGv0sdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406

The buffer pool table contains buffer pool configuration and operational
information. Each entry corresponds to a buffer pool. The Entry ID value
represents the buffer pool ID to access.

The buffer pool table is a static bounded index table, buffer pools are
always present and enabled. It only supports Update and Query operations,
This patch only adds ntmp_bpt_update_entry() helper to support updating
the specified entry of the buffer pool table. Query action to the table
will be added in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 39 +++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  6 +++
 include/linux/fsl/ntmp.h                      | 32 +++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index d7d8a37078d1..3c59b355c142 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -22,11 +22,15 @@
 #define NTMP_RSST_ID			3
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
+#define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
+/* Specific Update Actions for some tables */
+#define BPT_UA_BPSEU			BIT(1)
+
 /* Query Action: 0: Full query, 1: Only query entry ID */
 #define NTMP_QA_ENTRY_ID		1
 
@@ -234,6 +238,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "FDB Table";
 	case NTMP_VFT_ID:
 		return "VLAN Filter Table";
+	case NTMP_BPT_ID:
+		return "Buffer Pool Table";
 	default:
 		return "Unknown Table";
 	}
@@ -702,5 +708,38 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 }
 EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
 
+int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct bpt_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct bpt_req_update),
+	};
+	struct bpt_req_update *req;
+	union netc_cbd cbd;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	ntmp_fill_crd_eid(&req->rbe, user->tbl.bpt_ver, 0,
+			  NTMP_GEN_UA_CFGEU | BPT_UA_BPSEU, entry_id);
+	req->cfge = *cfge;
+	ntmp_fill_request_hdr(&cbd, data.dma, NTMP_LEN(data.size, 0),
+			      NTMP_BPT_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_BPT_ID), entry_id, ERR_PTR(err));
+
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_bpt_update_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index d2a6399b0a36..7d50af7745c7 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -179,4 +179,10 @@ struct vft_req_ua {
 	struct vft_cfge_data cfge;
 };
 
+/* Buffer Pool Table Request Data Buffer Format of Update action */
+struct bpt_req_update {
+	struct ntmp_req_by_eid rbe;
+	struct bpt_cfge_data cfge;
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 2aedea17307f..a54945dcdc61 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -33,6 +33,7 @@ struct netc_tbl_vers {
 	u8 rsst_ver;
 	u8 fdbt_ver;
 	u8 vft_ver;
+	u8 bpt_ver;
 };
 
 struct netc_cbdr {
@@ -116,6 +117,29 @@ struct vft_cfge_data {
 	__le32 et_eid;
 };
 
+struct bpt_bpse_data {
+	__le32 amount_used;
+	__le32 amount_used_hwm;
+	u8 bpd_fc_state;
+#define BPT_FC_STATE		BIT(0)
+#define BPT_BPD			BIT(1)
+} __packed;
+
+struct bpt_cfge_data {
+	u8 fccfg_sbpen;
+#define BPT_SBP_EN		BIT(0)
+#define BPT_FC_CFG		GENMASK(2, 1)
+#define BPT_FC_CFG_EN_BPFC	1
+	u8 pfc_vector;
+	__le16 max_thresh;
+	__le16 fc_on_thresh;
+	__le16 fc_off_thresh;
+	__le16 sbp_thresh;
+	__le16 resv;
+	__le32 sbp_eid;
+	__le32 fc_ports;
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -142,6 +166,8 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				struct fdbt_entry_data *entry);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
+int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct bpt_cfge_data *cfge);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
@@ -213,6 +239,12 @@ static inline int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 	return 0;
 }
 
+static inline int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+					const struct bpt_cfge_data *cfge)
+{
+	return 0;
+}
+
 #endif
 
 #endif
-- 
2.34.1


