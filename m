Return-Path: <linuxppc-dev+bounces-24621-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11516C4452B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 23:17:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4YDf5vBHz2yjm;
	Wed, 22 Jul 2026 09:16:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784675810;
	cv=pass; b=INFvJzXlDcvQloLf0CfVdKk45lMDrXvVV2unpsmP2wMC3uCvHeo6t83gFRLms+yQ4FWLNBOY2/xsldjECr/zuw5APyML8u1yc7nIZomWVlJu6Z7HclPfIEW+i5AN1X7KEwJLTC4gmrbE2SEvdzCQH5oWFXJSqdvdlRjwDPqSlrWFBWum9bW2tNMgPpsnodG8ttlRx6an3zgcE+ePc4ooGtsKFviXEKvTsG2wJD3vnRZmwBHq3VmdgFxZK/D+zO5QKE1+glYjYNTHWkctk415UxxS6HsX7pEm0Cb2gSFv2u7MKTsQvvjNqPRQ6iH10A2ppBaCzm2+YRwWGa06owohrw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784675810; c=relaxed/relaxed;
	bh=ZFRiqYOADgod1HhFQwXXpJzQGHPRuHPz5syauC/0Loo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cg8T+kecrqtyqt0BRkoK149O600VPd52oChzIZgFwD7wkhcOsUK2j0TVwa7cm7ua38Vat7bPNZPPb2gj+teBd+0NMPZytmRoROSLFZR4PYkuOrQ2riZ1BQs+0MrgPZZekGNI8F3m06s1v9mPtX0f16UDMoMPMo8cEoX21DjJWW4n7F8w8bulmp5WEEBhw9hn7k/A1ph8y5oaL28YQfcwRLeNzFdeJFuv9BzSPEZumjZjvNVO+3YrbUNnGAmyHHaxo+pAbA3M08HSWa7tZqzif3y2YAuZmrqGgQkcpbqVBryIkVPb1rnr66b6JpYicFFDyLcXoLWwOse/VcBB981srA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FH3PFcb9; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FH3PFcb9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4YDd3xjwz2ygG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 09:16:49 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGPL2HO1qoIAYj4QB/lDEPTWzbfQ//B13IkpJjASjfIwzOqXp4QURVN0HFpH8Us4Ndgn1WhsjePhAfR85STyhw8pYvLWpGCoBeqzcK0Z6sYwpuMVZtRI5QfnIge4hF5yKaaaGHrVfHzebHFE7B8KsBr6U0631qg3WrW45ddIZMMxkkPS4fycruJ8rHgFB0JicEaXxKD+wbaGyrXtw1o3Xrt1xRnKLSXpeNugN8CN1RFGdXrBsCyQwJI6X5lFPahyz6RiCQRKvwVY7dMNsLGrEfhBPYf/MOGhvx8GdZ6sQT9YwnBJ/4Xwi96h9ifmvTKuRAeUaA7K2dxSio7hNDx2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFRiqYOADgod1HhFQwXXpJzQGHPRuHPz5syauC/0Loo=;
 b=ivHt7AhfkUC9+SMYdYhHL2iTiM9jaXK7ZKudD+bLCYhn3NT9tSeoob/5PElkcT5kNWYZW62Yb70aNHZkljsKORKPSIQrX4bZyv/jvulFtWSD98VLy5I6oe0OVuksf6q1xubeHXxO3XzsoT3k9YgiYBILyIyLFSbNr/WHIIbQpdvuvngeePveQnGMJDPLFZQoHtZF3p6sxNXnyY0rOO6MOkKdbMplvJuR03tOpfqyHdRpJtoFC5Z1oiUdJds+aEE6ydSW/1phaAAxrw5ttwIYJ4fJtGGv3j1Ti+WqcNQZ9D/HmgUtZZphT4RN9DhSb4XMBg/2FQh44XNolYEy4jMTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFRiqYOADgod1HhFQwXXpJzQGHPRuHPz5syauC/0Loo=;
 b=FH3PFcb9r+VjI3dhJarVsDUwyQB29GW6aoUjsSsoj4nXuHvrV0ZCqhSkvyDdIUkvvwydhTXOlCcn/qEZ1j5vp//35ZTSi4B56rPNYpi6kiErrBYw8sx+RBS+7ITZCY5NYc701amyzsw8M2WHoTd/4b75Ic/t9GjBaJLzRw0JqcftP/RCnB39IuJC/g1BhOfam5mZ8TKfbqSBprLXsUkCPklKiD/EOTttqzpCS8JqjYDaHNnPVkHSZnez09IhXermEjX+Qh8iRnOtIrcBAtBkZXpB2Gf7pMqeSUCfnAjTWl+JyrpT7+tvNSjnGB29RNL9S0fACCVc72OuM+4ejwY+lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB11817.eurprd04.prod.outlook.com (2603:10a6:800:2ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 23:16:18 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 23:16:18 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 phy-next 3/9] soc: fsl: guts: add a global structure to hold state
Date: Wed, 22 Jul 2026 02:15:57 +0300
Message-Id: <20260721231603.67865-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721231603.67865-1-vladimir.oltean@nxp.com>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::8) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB11817:EE_
X-MS-Office365-Filtering-Correlation-Id: da89b679-2a4e-42da-4c30-08dee77e11f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	MK2etD0tRNdKYI3IZg78xHVtzulhRKobdOqc0cLUVeHkyhH7U6xpvPuv8P+/Fhrn84Qt8bhLzRcx+fLqmwbNIlWz80r5i3xxhdaigduffXxCIT9ggGYVd5Kx1WBtIGLapc6LMTl5ebW3ZL2RJSviOunTLu5+noBEZbVuUBhjUNmau0AB3yigbI5V3cTTOdLBlD5a5G8rUsMTdnRLORepI20iNoSLwZvk6yJao3oi5fXcz2zDKFQy+dkA8XXRSLhyoklSWnnlRswGgaRZ4YIF9vePW2Dv3d+mVzm32UXKj80yOxecIJz6hdDvfzYmuR+2kMs67qUzoYbK/9kF92N6zkBl9NH70/c3kAbKfnWX7N4Uz+1rTqcuv0JpM+8DapsWuy9mZsTt250EWopIqAWHBgfOceOhMjP/ML1AMfwXXv6TtJ4YuoNIe3y+gLEFxVngGC30S2XNiyojaMpWdq745SKM+Yo/Rzzlla2X2G8cOBLkM9FJ4K3p3Ba3zvXhCjG18aBplHtwZDRNqIybq3OQxL2pYhPwGqT+tBYGtIsSOelPCMF7rm6IDYz2HxmNZ2yyWfrrf6yv48DnWSrxwugV5OTz9x4bk3K4gWVzqIYTP+YpooUJEegKC6qMUT3/bqirxSkTbHfZa/oS5ktwFDK9mbFy6BtnNCHicGIwUxx0zLM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8wACB/otcrSe3jHEcPFgISh8MR2K+UitI2FvL7Ji6/uKWgKAGHSMamYXxb2S?=
 =?us-ascii?Q?cwckD6DJgVxyboyAi63mgxBK0NyLAq6tHd849zpOPkQZnpSOqr/qSkmC6XRq?=
 =?us-ascii?Q?SKTQRUIWZSHPTTHOIxRyljaDLS1LZ/QbVagWD/RRzXfVT97hIZ9e3QJT9BRx?=
 =?us-ascii?Q?v01lTfvefG2JgXzLXTF8mU7PgM6Z3JcqNhppoQLaVkzsLALv/wdnPDLwaq+Q?=
 =?us-ascii?Q?Mvm8LWe+KRHCfADSRStrKD51X4rBAw1MveJPmwDfF+ObQJhRvUKvnxpWHaKc?=
 =?us-ascii?Q?jA2PoRosmF0eAfXrhmbrPzExs6BEfptSwKqRnZ5YNQtax6OEXeRLE7ncuANp?=
 =?us-ascii?Q?qXpzTk69W3PONHGWQeqExJzQK1AIdHR2JEvDSitZrfVWOZsAk82b810Iwf+n?=
 =?us-ascii?Q?zUnGn/7tS9xB0RBw6JCUHrqqopkn/DKs1fAlzpT7rc2Hnk1sNCiVe/8KLwV8?=
 =?us-ascii?Q?VPfrhahHyhAv4DX6ZzrtzQaMaAy/0EGhj6IBI0R4b7iUtQdhqtFC+dAr6yuS?=
 =?us-ascii?Q?uVA/8+DvHQWMG8l6aYGWptgYvJnQD99FbblPtP8nE2vjocdEEfJ9t8mpz1sm?=
 =?us-ascii?Q?dSgG4J40TV0FvWBwxmNFkxSDuF1ceqnmdOHgIqyF8PLAEGb0UnMqc+3DFCFY?=
 =?us-ascii?Q?OKyVPLbIv91ipHkIqjc0AB6qniSOKtTSfNJBUBh55vNS0uwZUccRjOtNiVvc?=
 =?us-ascii?Q?tVwbqDvoeECrGOzJB6vbmXjF7TFqKZ674aM/K96srNf903GMlR8jfgWMznOT?=
 =?us-ascii?Q?H80O1WGdSKJD2yoCFTg97ndNhP5BaGWq8+trA8lA//o8FqOKARwysEFvEUBa?=
 =?us-ascii?Q?4Q5rU17ScbzLj+xr7OkDR+wS0pGNy8q5aO04xh4+IpnVq2FONp76QQkL75UQ?=
 =?us-ascii?Q?iI0NSxuvOchoMawtUioE5RJnwsXVLvV9/qMobtUHhwU4KL4kNvUIMAMT6W5H?=
 =?us-ascii?Q?Ew52OojHYcL+tyRfy+YhxJxYgCv/L3ruItErQR77EACXQYm5Q8AE6Dd/yXJs?=
 =?us-ascii?Q?8R2+KKdJrM0kdQAiJdGqa2mzUQTV90avYig3r+R5UAnM3oQk7WJkyO+jP1sp?=
 =?us-ascii?Q?B/UbZG0tcdLPuMMfiXZ7PM89TVWeSz8tAaxjg3paYRL6k/NeZZeG8I1Z6Ygj?=
 =?us-ascii?Q?M+YBHgxPzysE8Hqw/TxllFtrsdU2rWMk/DrTMueb/Y4OlcHs0sBoJxxKshcW?=
 =?us-ascii?Q?dr8/ZSN+ErY5RXna8bEYZLxBynQ8K0fsc+AEbDEn+MoC8AvWEzzQYxgGa/hV?=
 =?us-ascii?Q?fPubXaQfKcR/TuoptRkzr/vbNgSW7TYZHkg7gtOqBKZaYku2LN6agTnfQWpw?=
 =?us-ascii?Q?YRJDDLw17uK20WGIwQryd9SlYjbykI5Ugej9YqGz3/TgLmGeHiN72L1tHlec?=
 =?us-ascii?Q?iTBYVlY3/CBwqdvmppzwv0+r96ewZoKUYz5siiWDdUbSkG3phfvC/yAfCxSI?=
 =?us-ascii?Q?h7dvfOzKDAwEgnCVGsOHGdL95k6htoUBWN0jDZci5XnN9OEmvOJlV2rP9Mad?=
 =?us-ascii?Q?MnBeRxoQPx1rOq26mwbiqaX/uFmVfYnuE5NBUHhAGeBpakC91+gmm5Zlxwhm?=
 =?us-ascii?Q?aTwuv/X0a08hMcl/8iDHsOvANKnkG75GLc6LjqNFNmGCfW6M1cirkzPXzKrf?=
 =?us-ascii?Q?3FR/s/SG/QjOk0pREvryAr6ocSy1WbLeM6SMJIdzz2I3NXrR40Xe9pazUAAB?=
 =?us-ascii?Q?TYpAFhW04c2D9eQ0nvUiiPQATtIvWMhcpgiXM4wv18QdzNNnAjBEVZFes6qo?=
 =?us-ascii?Q?5/UYtH/syQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da89b679-2a4e-42da-4c30-08dee77e11f3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 23:16:18.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjzz3QnxNxBhsfZbsKxYoHxrgc21S9a/BG+6nto1Oviele6N+va2njNYDdfg6pTStNv5fDBYrPDF7fuKVaICnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11817

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add the fsl_soc_guts structure in order to pass information like base
addresses, endianness etc between the init time and the runtime
operations (RCW override) which will get added in future patches.
There is no point in mapping and unmapping the DCFG CCSR space every
time we need to make a read, just map it once and keep its reference in
this new global struture.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4:
- change error handling to a dedicated 'err_unmap_dcfg_ccsr' label
v2->v3:
- fix error handling in fsl_guts_init() - iounmap() the CCSR range and
  set it to NULL on the "err" label rather than "err_nomem"
v1->v2: none
---
 drivers/soc/fsl/guts.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index b97eb80cea95..bb65b62ed805 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -106,6 +106,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 	{ },
 };
 
+static struct fsl_soc_guts {
+	struct ccsr_guts __iomem *dcfg_ccsr;
+	bool little_endian;
+} soc;
+
 static const struct fsl_soc_die_attr *fsl_soc_die_match(
 	u32 svr, const struct fsl_soc_die_attr *matches)
 {
@@ -187,9 +192,7 @@ static int __init fsl_guts_init(void)
 	const struct fsl_soc_die_attr *soc_die;
 	const struct fsl_soc_data *soc_data;
 	const struct of_device_id *match;
-	struct ccsr_guts __iomem *regs;
 	struct device_node *np;
-	bool little_endian;
 	u64 soc_uid = 0;
 	u32 svr;
 	int ret;
@@ -199,24 +202,25 @@ static int __init fsl_guts_init(void)
 		return 0;
 	soc_data = match->data;
 
-	regs = of_iomap(np, DCFG_CCSR);
-	if (!regs) {
+	soc.dcfg_ccsr = of_iomap(np, DCFG_CCSR);
+	if (!soc.dcfg_ccsr) {
 		of_node_put(np);
 		return -ENOMEM;
 	}
 
-	little_endian = of_property_read_bool(np, "little-endian");
-	if (little_endian)
-		svr = ioread32(&regs->svr);
+	soc.little_endian = of_property_read_bool(np, "little-endian");
+	if (soc.little_endian)
+		svr = ioread32(&soc.dcfg_ccsr->svr);
 	else
-		svr = ioread32be(&regs->svr);
-	iounmap(regs);
+		svr = ioread32be(&soc.dcfg_ccsr->svr);
 	of_node_put(np);
 
 	/* Register soc device */
 	soc_dev_attr = kzalloc_obj(*soc_dev_attr);
-	if (!soc_dev_attr)
-		return -ENOMEM;
+	if (!soc_dev_attr) {
+		ret = -ENOMEM;
+		goto err_unmap_dcfg_ccsr;
+	}
 
 	ret = soc_attr_read_machine(soc_dev_attr);
 	if (ret)
@@ -276,6 +280,9 @@ static int __init fsl_guts_init(void)
 	kfree(soc_dev_attr->family);
 err_free_soc_dev_attr:
 	kfree(soc_dev_attr);
+err_unmap_dcfg_ccsr:
+	iounmap(soc.dcfg_ccsr);
+	soc.dcfg_ccsr = NULL;
 
 	return ret;
 }
-- 
2.34.1


