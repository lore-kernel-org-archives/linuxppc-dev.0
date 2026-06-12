Return-Path: <linuxppc-dev+bounces-22593-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C9ECD98CF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 21:10:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcXFs4k4Sz3c2G;
	Sat, 13 Jun 2026 07:09:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781298577;
	cv=pass; b=IK9N7N4BCk6d8KX9mZztm0dHdqiQEGMgyWCVhQX42Zy02jKLuaUqaYM12ayBOot+CwHCkd+pyYw4pilK8LaAuf2RnyoCaBJ1d6LXTyv6VQUc+4nDtSWl0/vU9l/NVlrHtt4Eo8pSVqarU+pnlxPAiBvBE/ga9ZvWNP4YYcVpx43JITy5zdQaQLFM/EcyELpvZArcs4mXLOWtsJFVGuvkqxz4DUQ7fyOQGojkL8NVW6rrNHTKEIvhoTHIuQvAhCTtF06vVLaJ3ErrP9rHsyrsSYgoYYoWC9LULv9IhWQTKZCuIqfO23G4x/rMMrJGKdIQ+FoYX/MWZsUrOIeCf1k8ig==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781298577; c=relaxed/relaxed;
	bh=f3HjaoB5XGe0z6qMLuYHFSUpCX8+fPUAvfGnwKYJ9JM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c7WRMueAfmBdHcIrke3G27DuHloqKirtq/DO7UQSTa1nJq7EcQnXZaRbVJ2cOYnR3vv/3uFwD3KBl5jF3UcQDgfyLQGYSkRCLYuAuKFneaAfupQeK+UBiqcUmw+PgXOOK+ujr842tBBN0H4Xw3ec3ZkcIGSE5gZ/I692i9KN8p9G3Hb5pM/9VruZbgSiI+WBg5pKi0bDWpLQWfUhth5xLdZmPRoRbocV7QAcVJx0k7Z2Tfq8v1W79WnHc7MKmo9GmMaKirBTuuX4R4O5HsjCsx2hfluv4VKIoyGHZsgtbqcIhAInqiHbfjOemTwlMng+ng/ohyZk+z9kM0qag8lcQw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gFClNyF/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gFClNyF/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcXFr37Lgz3byt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 07:09:36 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dftjM8uaOfxLj0x3zj+fNZ3kzBBukwadQGs7gdQW9XwlWKL+GMEVmGCTp7xrBbuITe0fHjLLwg5heWIk7bOECjHHFKzzFQpLDdWYaq8hHDGoHwPYGzzDgLLmZ+OUsiHOR03qpTUPSlWaTwzTTumuSByEpA+fOz7fq1XFtaU+JTugx8qOpb+2j/1bV37Q+KLnfHzSm9JAxd69D4emR9ikD8kFyda36H0LJV13AFCkGTACkRm2t7+fMZbd1Mb4OmBDCG3uQwbW7YlTrBdpM0l2aAK7kpOEkH5beZKo0lmDHYt04iWb7b8O8nTQjm9yuzkg4yALs9JhkSk4SdomsBmLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3HjaoB5XGe0z6qMLuYHFSUpCX8+fPUAvfGnwKYJ9JM=;
 b=kcu2Az8adxpuUfIxCSlGU4JRZgVuT0728r+aluAy14LmAY5UDE0FVBsrEXbznXGqU60JsCFuHyHre1ZXjtnaQsSR77TFqxGHgowN7c+yaqDjbd/hren+FUgLIRNIKCPFkemWLGvc1nuvJ6lkCe5J5+4pI7/FHK0mJwSmwifbzME3hN4b10xEdqW8zlhtCVXlcYy9TFjzoctkRmhlMzimnETUVoDaifMYM59USXxiuHPHLUUgvjeJovr9gTJoL7oIObaZuks0LcrVwC6NWYl4zKx2/T7JG4zcrianean9eJFN0NoohZYc3UWIbFLAVpl+xnweSiT6+2/kxtqYounfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3HjaoB5XGe0z6qMLuYHFSUpCX8+fPUAvfGnwKYJ9JM=;
 b=gFClNyF/CFeE0wuTMDOAjghdO7+lkI2iOqZkw31fA9f//IyoLA1omxN262t3kUV798PpQJAXphoitzxgYYuZenU5afK572RTG+7y95xWDV47Ur0K4Tna1sSMLkpS9v79yPPC8PkSeJaDf9BEvYACQ8407wbQr/o0DmH2XvFAWmPUzESo9ZGxxTUlvrqr//XBnZDMRhtbFHUdNtyX6HvpgKCKnfMOEW/Al+z4ewdgtRfV38Qr9cGI3nlc03AdZD3Rd7aWeTz4iQo71iIrKc78rCPGoXTG1k0a8/+UM0lC4J+ayYBSd/hD1m0yOlUKl99/OtBsCt/wH+m/Vn0nvsG1aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB10969.eurprd04.prod.outlook.com (2603:10a6:150:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 21:09:04 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Fri, 12 Jun 2026
 21:09:03 +0000
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
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 phy-next 0/8] RCW override for 10G Lynx dynamic protocol reconfiguration
Date: Sat, 13 Jun 2026 00:08:51 +0300
Message-Id: <20260612210859.266759-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0014.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::17) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB10969:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebbec01-0467-45ba-1079-08dec8c6d4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|10070799003|1800799024|366016|7416014|376014|56012099006|3023799007|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zqqImel0McPuXvluCS5i1VlJ9C/nzBbqdhLQUqnfGb2OROv0meTZiV0OJkrkyX1hjg/+W/sm3t856/vPQdDnPFssClH5i63KrhhmGzYdM3+62L8D4A2IR4cMGJTu6a7Aiu3JNfUrji8X+V9K27IWlH+mHept5iiwcc9xz10TlopBmb/a6hSzDzkLZRVWZ8jclCN97LIarWVxpiYLnkTn6C6Sk9Sq1TJHE4tmLMwE7CotoaDudXnTLb21LjWTSHgzr8FrNxMvT8CXl3EwitzeCnkFTINvSaFs8l3L9oBFlW2YrdA1ybYBAVtXLtukZ8cutbp9+w9aLscQ6tBBFMzXWcoFdPgFGEXM72AEYYdEK2qUYqQeBuV63jzOYX3RJn57BrFQVp3nDU0MU8co4380vtg3HRfMnYJ8NsWWp4k7hbutrapnyv+3r8T1sSLYfmDNYRDFx0uoijqY1Nf0hCZA/dKTglkHUa4ITEGyXThAyimaHdr04Kuy4SsUY3T3IppxmZLhUp4+EyIw4yrv+0D2/Yeg8AVMEvKpt1Yztwm1an/40YJuxVdv3Be5QhOCjJpoghp0dljqARW4npxRWeaFbw0w1D4kBkkie641GfiSBz5RjYFk9TwWAmHpZITxydpA7zLo6uzNgBeFH8W6NrcahCAqVtC16wraM5BVF3pDLinRup6cArKk9cG2PR1Khs+O
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(10070799003)(1800799024)(366016)(7416014)(376014)(56012099006)(3023799007)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vC/OCd+kK8rlhHKkT+LItwZSPbwV4FJ5z5FZOKrG82DZyJaYDSW2MkYBTlTo?=
 =?us-ascii?Q?o3hwfYN/jaAA2Ath0OdA0n1+xWMf49Fqcsqx+/qcm6avKDOZl1AV/SdrZmCb?=
 =?us-ascii?Q?QXb1jyT2bfr7WxtVDbjJh3f0bkpaFhPU0J4WbJ+gtvKyXZn2Nbpzba9AkDYN?=
 =?us-ascii?Q?UxuCuY13TWS5/FMURivyNag2B056dgwTHO2MNq9to9hmG9No7AqgQqB/aWMO?=
 =?us-ascii?Q?q4MGV/rDrK+qDn9Frkwf9mdU1ixMDHEarzWFSlGdm8Z3PvU/JjK4/cvoAgPd?=
 =?us-ascii?Q?ZKBzpYWGn0O80QzY9M7cVVhiyCj8fLwQgukVk67HOpnwiRDdHzDeAcmHTB9h?=
 =?us-ascii?Q?WCTL1AI1G3gEVhepMnWmEfV8mEElBpOryg/+kFhEGTcNgwrCSshEP8IwL6iV?=
 =?us-ascii?Q?vDXZ1KtOSsiT26BTqeg3Hv8/ja8VnVgH4YpyhK25AtXKI/IlNwH2xGdmC1Zg?=
 =?us-ascii?Q?IUbidbp25X1kQNOgmKvPWNedoykgsMCJPAeJUx/dV/OXRx0CzCCGfR0lmGg/?=
 =?us-ascii?Q?8cYOZjCxvXyYufhqmxXVZWAQO1FG7A9xyuoGOsImmr6NQYLqVhCUioJ04/3J?=
 =?us-ascii?Q?74bpq+ftdx9Xt+VxFj1jjiT8ZKsGQs131ppmr+gyyJxiKBpSq6i9np7AYHm7?=
 =?us-ascii?Q?1qkGhVihSW+KdPgnxlkbIo7DmTyi/WsaoIjjJwKwuZKe4sAQfmQkLHH5VU+l?=
 =?us-ascii?Q?ktrxq5FDtFKnlxB1JLeId82WHhIEEjlQ87spMAbaqfLOp0VaVuA7Ncf9V9EV?=
 =?us-ascii?Q?cGDuF4G5qf10bTJzIVlXo2YSYr4RH7UMlrwDgMhrv7jj6sK17VDMepHcjWZ8?=
 =?us-ascii?Q?mY+bOlE+xbqV57gSoaI2h/Dv3rDEhqaQ7H6BOn4NOBLYx5G/AUuVx54gqnIO?=
 =?us-ascii?Q?ojQkHNOlDksSis1qkLAhUiUojc1a7BsZjQtaf3Z8puyAARxsWrPPNXHBkzCR?=
 =?us-ascii?Q?OxKMiWZnIqYzAiq/RvyPY2kA8yeDevT5mYSobxXHeBN1tXOOvD5CaNdPwW58?=
 =?us-ascii?Q?Lv248kGf3rt+Yxnz+tU3peMBP/CstnlpVrdb7zFsSd595oUEBjNMLLbbtND+?=
 =?us-ascii?Q?v/VwahFGE3dDdqaCoX79e0L/gEIjAuSDLFJsdzGOwCpecHUj2hP1MeUird4L?=
 =?us-ascii?Q?lICTaGHtuYBKSpeZRuVRXvZ/hVC0DZcCRvHkgYapbBi+3ocAmbP2mPMWujhK?=
 =?us-ascii?Q?12ELTB4s7uTn3PFOtEFIcd8hkghn+oYGgZ9rf573fHjDhVDMXqv6XdV4vJJj?=
 =?us-ascii?Q?h/xLHPwpABbioBOlqosfoiud9Kk+6vvRh9Px5dzrSPe9GgYef5cSiHCMA2zQ?=
 =?us-ascii?Q?yb4DQTq2ULW2dNOk2nLqjqANVp1laLFkJpDoMzsqO9OB3uQ4dO+iLX2GWcgu?=
 =?us-ascii?Q?Ym3OSvrPlEna8YosLJB/1ZIav0V4IR+7onUtbts/IpEVWvdy8ThH70IB3WkM?=
 =?us-ascii?Q?aMwr+hig06Ehza891wjQhkbNyD5PVzN+PVbQfDvsggYk0EmWVbbShnREkhcs?=
 =?us-ascii?Q?GfKCMuFpvwkGm/dXYRjs5NgBispOoPyt5460rnFV8CfQ2t34lyxN82UABsvr?=
 =?us-ascii?Q?Xm73gDjTMl92cK5IWXAxoFN7GDSxrl/YONcf3o8hGmUZzQpCVQKMZx+VH166?=
 =?us-ascii?Q?MPcDp3t84qJTop+NOmA1GZRxUE9tiJVjlROdDJNgWwoPtyWXnYwVzTdbHlYT?=
 =?us-ascii?Q?sfntncAW+L2CuVTX13fD/nTwPtKpyHnfbx3NjjK3nwGsE7n9RfajJE5hmG2v?=
 =?us-ascii?Q?Z6wfRA8MaqRX9QQ0UfgIGGc/jjyF2qwwWVS2aB3ctLSKSPDFC6ee?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebbec01-0467-45ba-1079-08dec8c6d4e1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 21:09:03.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DbJB+5FfEfvY7UkziDNAR5j9x711YiWk8e/I8KVkOohwzuMEAEEB92vFwk0C0OIHibheLbWJsMeJvmmdWHyFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10969

Previous set "New Generic PHY driver for Lynx 10G SerDes":
https://lore.kernel.org/linux-phy/20260610151952.2141019-1-vladimir.oltean@nxp.com/
introduced the 10G Lynx SerDes driver with a reduced functionality set.
Namely, only minor protocol changes are supported (1GbE <-> 2.5GbE).
The major protocol changes need a procedure named RCW override,
explained in more detail in commits 6/8 and 7/8.

This series adds kernel and device tree binding support for RCW
override, completing the SerDes PHY driver functionality.

Two components are involved:
- drivers/soc/fsl/guts.c (binding is fsl,layerscape-dcfg.yaml) - Device
  Configuration Unit, this is API provider for the SerDes driver to
  request RCW override depending on SoC
- drivers/phy/freescale/phy-fsl-lynx-10g.c - SerDes PHY driver, this is
  API consumer

The guts driver probes on DCFG blocks from multiple Freescale SoC
generations:
- MPC85xx, BSC and QorIQ (PowerPC) are all covered by the
  Documentation/devicetree/bindings/soc/fsl/guts.txt schema
- Layerscape (Arm) is covered by
  Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml

It is ultimately the same hardware block, just that (from what I can
tell) the Layerscape nodes are also compatible with syscon, and PowerPC
aren't.

RCW override has only been validated on select Layerscape SoCs, so
converting guts.txt to a PowerPC schema is out of scope for this
series - we don't even touch that (just in case it gets asked).

Using syscon to map the DCFG_DCSR register block in the Lynx SerDes
driver instead of creating this guts <-> lynx API was considered, but
because the RCW procedure is SoC-specific, it was ruled out for
polluting the SerDes driver. The guts driver is all about SoC awareness
anyway, and it offers some abstraction of all the gory details.

Resending because Sashiko didn't run on v1 (it runs on linux-phy/master
instead of linux-phy/next, and linux-next, used as fallback when
applying to linux-phy/master fails, wasn't regenerated to include the
Lynx 10G base patches at the time v1 was sent). There was a build
failure on most arches except arm64 anyway, so it's good to have that
fixed.

Changes since v1:
- add Conor's review tag on 6/8
- update email addresses of DT maintainers
- drop DT maintainers from explicit CC on patch 7/8
- keep devicetree@vger.kernel.org CCed on entire series
- include missing <linux/bitfield.h> in patch 7/8
- namespace SRDS_PRTCL values for LS1046A and LS1088A, even if they are
  the same. For LS1028A (not covered here) they are not.
- prefix SRDS_CLK_SEL_{GMII,XGMII} with LS2088A_
- reorder alphanumerically (LS1046A should come before LS1088A)

Change log also in individual patches.

v1 at:
https://lore.kernel.org/linux-phy/20260611193940.44416-1-vladimir.oltean@nxp.com/

Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>

Ioana Ciornei (5):
  soc: fsl: guts: use a macro to encode the DCFG CCSR space
  soc: fsl: guts: add a global structure to hold state
  soc: fsl: guts: add a central fsl_guts_read() function
  soc: fsl: guts: make it easier to determine on which SoC we are
    running
  soc: fsl: guts: implement the RCW override procedure

Vladimir Oltean (3):
  soc: fsl: guts: make fsl_soc_data available after fsl_guts_init()
  dt-bindings: fsl: layerscape-dcfg: define DCFG_DCSR region
  phy: lynx-10g: use RCW override procedure for dynamic protocol change

 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml |  15 +-
 drivers/phy/freescale/Kconfig                 |   1 +
 drivers/phy/freescale/phy-fsl-lynx-10g.c      |  24 +-
 drivers/soc/fsl/guts.c                        | 369 ++++++++++++++++--
 include/linux/fsl/guts.h                      |  20 +-
 5 files changed, 393 insertions(+), 36 deletions(-)

-- 
2.34.1


