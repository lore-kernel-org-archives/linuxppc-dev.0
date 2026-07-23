Return-Path: <linuxppc-dev+bounces-24704-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85308C4453A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 02:20:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5FFR0F9wz2yhb;
	Thu, 23 Jul 2026 12:19:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784773195;
	cv=pass; b=lNBWmKe20ASuLZuVio/ewNHSvmm0RWvVXzRhpxZmXQmtdBZtl45YXqZWpXl0Yt1Jt+RczYUMEy3RsSNbVbS+Q7+1ftPSrhNFJDGb9EzjZhscmac6wvEnCEYgEk3AcWq69hoH855Q81yEdlIpUWpPLm5dwhkiQKe4BBM9f8nZI20MTgZ+HFgraM6+RlE/XM4dj+71XGX5J4btmMnbHFWNinuMJ7QfRX0C1JYrhIsYULOuiqZoQRjKdH7/TYM8v/Vs/T3HkWbZGzm7HRIiIhQ15TW8nwCLepxFarQTFyvuC7EAw2H8WtZEilP/CSnoBJV2JIPNh0YuuNAZukplD66AwA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784773195; c=relaxed/relaxed;
	bh=qWZRFKKqtu5oiO5cFyFL3KD/Olr/VFR5kzTPGDjVHnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rq9qyDE0jVeHowpx7d249UfKqj/fhyJ18BTITI2hc5F2zooYLjz5FVYcxWcjy5MqGirZidvXWza7qsBB3/a+jgTiDqAeauZGN+8udDzvsijcRyfsGSM2B5uz+x1WmKFMpPrVVw7lIlkhleq8+7O1JjDWuR6m4pa2js+cjksDQzq8FUiLnkCjYRqD0c5+NWF4XDL+8C4mo0cUQ+guqe/CWi5AA7eQ6HqBPwyDBdB3ZFhY4qDe6/A0Hsb3mKtr+Jj7IOmECtGLbfXp8Yd7goLhjde/o/pSv4jjN9FXJFBZoKrEKZsazHlZc0cODNKoaoyhe0HZ9b5H4qG4myLgiYEL+g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=l1zRgOtG; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=l1zRgOtG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5FFQ0Kgbz2ykc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 12:19:54 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0JDWG5+j6ruAr10IjV4Yo3NhYGU/IIhfYdXxGZQrQY6b2/PZ/25NTDjnHeVS3Uql0/6TNfAKKX1C80T7SUsep8Srh3OFFTiYkpFxsNOGnQfDv30q24LEuOBKErq7Czgn9HJ+beaVcZWBsZDKOV0HwgoLHpirFpNjut7MOH7Co/1nkc9yRVNBhFQMRLc76SwAuO4lefjgx65ekAjj2sC9bF4lHax4jUoYugyGqfnkbtcbNDu/7YB0KacaM8HQSCIfkXVGeOng/rRj9V7OQEK3tFRMlR5B7tX6JwTqc0chKYk0Ofgt4K3RoJmMFC84NayfsHKE5eOnnOa/OcnIL8sJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWZRFKKqtu5oiO5cFyFL3KD/Olr/VFR5kzTPGDjVHnY=;
 b=lN/toGqE43C7ZK6Mllz5PZALhm83XYLLEthHVaDyz5GFtlQPF5+/8xCYLhQmAFUIyWnd66mYzOO46X0gFq3mrqx3eiHcTzTUg43yzsRlEfsD1FLUQ9aZFcqFnj1avfVRFSdmYZ4q6fHagSJMNjKx+d14XRLU3VouZksRptfw1Bp8phbBOUMGX3tUDb1fRNpZhhTAOq8e9XUb0yCJyui04GSfbFPF2I+Sljk77i85GDhNdOYEDqPt8xIH7IuKn5yJ0zgPOW3A5fWbLhNWR8MKREnM9/eLVjvtCRVQDWoGKIMHrYeFNmREh+9g84Iyp/RdvpuT2jcuexXYw+qI4cwn/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWZRFKKqtu5oiO5cFyFL3KD/Olr/VFR5kzTPGDjVHnY=;
 b=l1zRgOtGaowwBQ43Dr4bI/tTkq5PihWa1zUpu+uTiZ57bqd0OkHF2+BOz4vHg4QTwRFFy8mgPyNk/ptFWGkfgHTJbNZpnvbFsNGDeGCGqg8Cbiy0OOGsC/B4rzZ4dSugwrzJWiZRxPKybmi3HqkbnNetNqqhFA+D5UeEpc3fMFe/9TzjFNNgWsdvynmXsATFok7pshgIV4aRdXxZRx2Ae9hqQ7aQeL/0+6lMHNxlqg99tj/N5E4MgTUAXm65ROLWpBwey9nqGQLPc+Dl7X5hJGXFBEEqSQi5dnEO+yVawLL8+/9vJbeZhZeJX2E2dmdDdT6B/KU41EFzXct1hYp+7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by DU0PR04MB9252.eurprd04.prod.outlook.com (2603:10a6:10:353::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:19:40 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:19:40 +0000
From: shengjiu.wang@oss.nxp.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shawnguo@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH v2 3/5] ASoC: fsl_asrc/fsl_easrc: move DMA params into pair/context struct
Date: Thu, 23 Jul 2026 10:23:11 +0800
Message-Id: <20260723022313.1905051-4-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723022313.1905051-1-shengjiu.wang@oss.nxp.com>
References: <20260723022313.1905051-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0091.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b8::11) To PAXPR04MB9351.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::17)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|DU0PR04MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 9565db22-7a35-48fb-9b99-08dee860d9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|19092799006|1800799024|366016|921020|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	lw/2Jjkr9yukgXsEObr2gjDyokUZfyBt5Khs2vFDT27IzXHSPR0NC9AexbRqIEIr8ioG5j0ZigsDrYjGFO1Db/c5eC6nmXzo0FCRkonx7c5lm/Q+y9w1ay7Hf/M3OexmajD2ug1L4R9Gt6aFlBI0zwGL6uiGoXzrT+5tP4L7cEt4g2iNqJS9WLAGcMyGlOyAuGUbVVY9YxqyLWSYCATaMoGVrFziIcKwteaW8GaTStN+yVNRvdgOdnzkUm+OmcgYdiLalmhLut8LrvcNJqyRS28xxQSOB0//960PG3IWR0JDcdQHAR0zbDNINiw7//AhITGUeR8izepR17NX8QrZKIKAa+UKKwrqFq+kBGun8ibKWCJP85QHDGWDFtu+61iQI9bLkwhaDnURIveYfr6AyL/FDhRtKlAHMbDVs2tAZ9095Ig2ZjelEKakY9drdGEmXN7+qFNXqnP2WSpdMhtnX0/9Vf1Bf59TtbrHUKCaDueNd676ieqfgtYwX/ZGx8OV28EkwfsQNii7441ZXvGP+/4tWMQMULTez0gbw/4mjkluzW++2d4IIyldmO5oTs+zSF54pLpWsSY+MRjI1BTE7VV0ilVOhfd+EhuGsmnZ7vHyBL6Y3ypz/Cgac4VzVcYjvkwSDY0KVPqoVr44Cz82gplFRecVDZeknVa6IEQV4iXwFO4KMmHxrIY9hUvG4AywnpVH8Z0nax9JBs9EumjtCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(19092799006)(1800799024)(366016)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uuj2xD6EeoDTT4mf41G6LgrMOySbg/oipzRarNBE+zhK15cJTojtCBWCIP4t?=
 =?us-ascii?Q?AjaTLjgXfWDRzVEzl3VFrdJ1t27a/X2BC9Zyd4nMWPYCbpeV2M2b8TlLqRIW?=
 =?us-ascii?Q?L1pQyAIndtM1YP0oaoSrVf5RZo38qViprZwv11n5sVZQROg0mJRkIwfkeGuU?=
 =?us-ascii?Q?jn1v6LcEB2X5dHEDGZtedwP207Pj2f42v31iJCt9rqIJOqhOMAjO6mT9aLWC?=
 =?us-ascii?Q?4P4vtlX+wMgkdIYPWYJ+Tbls86uH2980QR+VCG+T7uPLEHKQp6WvDS8alHti?=
 =?us-ascii?Q?lN2KQXn5STy9q04AuW0MFmyD4s9158dk5Ayb39UvQg9gBiWOvIJOAiu0lPc5?=
 =?us-ascii?Q?BQN+fnt3AmCB7urf1Ar8FvrMUxnnn0ROnUpAM701tihWiGvb4R7njDTzl08o?=
 =?us-ascii?Q?qalaUdpKPzOySVM6Wbme0kbn2tW4BgfWAeqAIB2tmj9AQPf5C1wUON7CGern?=
 =?us-ascii?Q?81WFmgGgNuJ7HQaM4OVZn7WbANe8MgOsSiptPhOxRM6JL4VyKASOjieu6mAq?=
 =?us-ascii?Q?AVjySVLiUIx7KoMoX1pL0hU4RvtXufYhAMEQKr5AAiWnzLAz8u8sKpcRY8Rw?=
 =?us-ascii?Q?Neu5dZvbvMUM9oguMu25drLncGjj0DIJ1z8acR/n90dZnmGzR6aLMH2J4CqF?=
 =?us-ascii?Q?+h57B+tnSacYe7xbkxeDnz7lO+zE4ZJ9NXbeN3SDaYZrvirGY4lj+aJKdmFJ?=
 =?us-ascii?Q?2A1DWC0A/gEaOM+yO2o6/4N19yww4CxOhP5Bs6cPqHq8avyBkeG5G91/1eKJ?=
 =?us-ascii?Q?4/prytABjGG8prfispOSsPF1wlHsvmrP8/tPHw2VyJmxQqVw3k/0KhaAWYws?=
 =?us-ascii?Q?HwSscWCWa+gGr6Hc/Gkx2gjEoUI8QER+8xgcSUHEJrjoKwCbmQ2B0RhR0Oio?=
 =?us-ascii?Q?a47wJUl36o/EFCbBwigKVDKg8lTSRlZ49tScz1tzIOtjXt0PkxKD82H5n/pm?=
 =?us-ascii?Q?DAZfxk4GFVDo7XrvG2tY1CwSFCzARlGfRqLhV3XkNN8G327Ybf+PP0mwirDr?=
 =?us-ascii?Q?37tl3/d03MAo1STNzRi4J52r1FPuicneJB13nkh2GxaKrjcYWO7cfYLW8s/e?=
 =?us-ascii?Q?Vvb/kWxcHA4ZU4NGt72cUZa/7kJh3lCHSuDy1WP+e3YqF64k879mk8loMmmt?=
 =?us-ascii?Q?RAh/wv1ioiqKan0dH0tSTsE3dP0sgyaqaTpr5wjBm/7RaNWFp915sHX305MW?=
 =?us-ascii?Q?fxL1GQt6GdFat+yqe1gTqcF8hW6/bNHQ5lNE2vvvZD/EHrZwUsv+WkgAs/0+?=
 =?us-ascii?Q?l3G5S7wmPz+H/0cfUdEfkViD8GW15MxbJCXXd3SYyBtl7DVvZ/oS2+a/Utyi?=
 =?us-ascii?Q?xopOYz7FLWoLywq01cEZPp7/um/7HWs1oSEgF4Ai8LRGII5N5FLXgGoqydZM?=
 =?us-ascii?Q?KhKDjGkcoN2mzEjjapCwr2g0w/i/tVrj5/S31k4zmkaAsCG5aFRUG1veD3PH?=
 =?us-ascii?Q?J8BohpzhMo8CVTqJzIE3470N3tbHXQcCdGWVXL9tqPIDA+mSYB3GFgVF1sk7?=
 =?us-ascii?Q?k3O9OLHBBeZVkQkJ+BHcFOcp7GHJCZETV4frFxq271n84nxjJfLJs2XHq+3Y?=
 =?us-ascii?Q?I745QYfxu+AAfOFF+RSg7xHjjRdrYPaY7OkXc8VDRMneh7aFJmR8Hxzn5xbv?=
 =?us-ascii?Q?CVZoNrYVnOFh85ZMUI/g2L8WUO3YHrx3QSkNPIfgbfiwGUBphHrFFuS1+W9c?=
 =?us-ascii?Q?Cl7Xde+xJgPl/Wz1Dw/T3XZcFm2pS/1twZwZ5DPRgm0p3RHWHMfDX5RuBLu+?=
 =?us-ascii?Q?NrIJXOkv3EZ/w3zJ9DJ5ZiJKfZ53QqCSolC6faY3NYA375f2YAyt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9565db22-7a35-48fb-9b99-08dee860d9fd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:19:40.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2N49z0uj8ufaQzLjNPSmUD5ea8YEX3AMwYJMo4+JW5ke9mVFmu/lVqu1ylwFvaMIHVW+h44nFtTYGx8XUiDv3YyF0x3GCV8sZOfE70ZthVCsZ+kQdxO2t36ZLDwywDy6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9252

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The shared dma_params_tx/rx fields in struct fsl_asrc were a single
instance written by every concurrent fsl_asrc_dma_hw_params() call.
With multiple DAIs registered (one per pair/context), parallel stream
open+hw_params races would corrupt addr and maxburst for all active
streams.

Fix by moving dma_params into struct fsl_asrc_pair so each pair owns
its own copy. Initialise them in fsl_asrc_dma_startup() where
the pair is allocated, which makes the per-DAI probe callbacks in
fsl_asrc.c and fsl_easrc.c redundant; remove those as well.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c        | 11 -----------
 sound/soc/fsl/fsl_asrc_common.h |  7 +++----
 sound/soc/fsl/fsl_asrc_dma.c    | 14 ++++++++++++++
 sound/soc/fsl/fsl_easrc.c       | 11 -----------
 4 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 0b28bcfa47fe..986a2e26819a 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -781,18 +781,7 @@ static int fsl_asrc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
-{
-	struct fsl_asrc *asrc = snd_soc_dai_get_drvdata(dai);
-
-	snd_soc_dai_init_dma_data(dai, &asrc->dma_params_tx,
-				  &asrc->dma_params_rx);
-
-	return 0;
-}
-
 static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
-	.probe		= fsl_asrc_dai_probe,
 	.startup	= fsl_asrc_dai_startup,
 	.hw_params	= fsl_asrc_dai_hw_params,
 	.hw_free	= fsl_asrc_dai_hw_free,
diff --git a/sound/soc/fsl/fsl_asrc_common.h b/sound/soc/fsl/fsl_asrc_common.h
index c8a1a2b5915d..4e6b00cb5d63 100644
--- a/sound/soc/fsl/fsl_asrc_common.h
+++ b/sound/soc/fsl/fsl_asrc_common.h
@@ -53,6 +53,7 @@ struct fsl_asrc_m2m_cap {
  * @dma_data: private dma data
  * @pos: hardware pointer position
  * @req_dma_chan: flag to release dev_to_dev chan
+ * @dma_params: DMA parameters for transmit/receive channel
  * @private: pair private area
  * @complete: dma task complete
  * @sample_format: format of m2m
@@ -76,6 +77,8 @@ struct fsl_asrc_pair {
 	unsigned int pos;
 	bool req_dma_chan;
 
+	struct snd_dmaengine_dai_dma_data dma_params;
+
 	void *private;
 
 	/* used for m2m */
@@ -92,8 +95,6 @@ struct fsl_asrc_pair {
 /**
  * fsl_asrc: ASRC common data
  *
- * @dma_params_rx: DMA parameters for receive channel
- * @dma_params_tx: DMA parameters for transmit channel
  * @pdev: platform device pointer
  * @regmap: regmap handler
  * @paddr: physical address to the base address of registers
@@ -128,8 +129,6 @@ struct fsl_asrc_pair {
  * @private: private data structure
  */
 struct fsl_asrc {
-	struct snd_dmaengine_dai_dma_data dma_params_rx;
-	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct platform_device *pdev;
 	struct regmap *regmap;
 	unsigned long paddr;
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 38f2b7c63133..64d66420e7ad 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -390,6 +390,20 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
 
 	runtime->private_data = pair;
 
+	/*
+	 * Point the cpu DAI dma_data at the per-pair params so that
+	 * concurrent hw_params calls on different pairs each write to
+	 * their own struct and do not race on addr/maxburst.  Use the
+	 * per-direction setters so that a concurrent open of the other
+	 * direction on the same DAI does not NULL out its pointer.
+	 */
+	if (tx)
+		snd_soc_dai_dma_data_set_playback(snd_soc_rtd_to_cpu(rtd, 0),
+						  &pair->dma_params);
+	else
+		snd_soc_dai_dma_data_set_capture(snd_soc_rtd_to_cpu(rtd, 0),
+						 &pair->dma_params);
+
 	/* Request a dummy pair, which will be released later.
 	 * Request pair function needs channel num as input, for this
 	 * dummy pair, we just request "1" channel temporarily.
diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index edfd943197a0..e68f6cbdd653 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1582,18 +1582,7 @@ static int fsl_easrc_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int fsl_easrc_dai_probe(struct snd_soc_dai *cpu_dai)
-{
-	struct fsl_asrc *easrc = dev_get_drvdata(cpu_dai->dev);
-
-	snd_soc_dai_init_dma_data(cpu_dai,
-				  &easrc->dma_params_tx,
-				  &easrc->dma_params_rx);
-	return 0;
-}
-
 static const struct snd_soc_dai_ops fsl_easrc_dai_ops = {
-	.probe		= fsl_easrc_dai_probe,
 	.startup	= fsl_easrc_startup,
 	.trigger	= fsl_easrc_trigger,
 	.hw_params	= fsl_easrc_hw_params,
-- 
2.34.1


