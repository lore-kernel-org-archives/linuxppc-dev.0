Return-Path: <linuxppc-dev+bounces-22519-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BB9CD98D7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 19:40:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbtKs0SDhz3bs5;
	Fri, 12 Jun 2026 05:40:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781206849;
	cv=pass; b=X6Kz+nKVFrH9vKpSwfAP07vvZ8Vpy0RsEg/769Uuw3fvCX70MD5v/A6WBsGPd5x6rwWj1qv/xxDL5Ufaowcdt6LjS+EXNjvIBn8b/RffUGfSFWrDJt9keu8UlWH5XUWX6Z98froPSh4N8bIKEW5W2W6+sD3TluzpzpQrfKZuzQ07lxZL9HUSqd5UkSspSltm+XAV/qo3GTiydNjWtXkE4MY7ZKuQK7FG/4rc7BM5/gCqXsyRZVG82SDR2eklIPSrmiPAE4hDb8K8xAEBvh1wpi7ujLqRMPXV3Cdo1eGTLPfuV763EUASdz+IHR2ppk9C1MUdLJMul1RpbJFvkFwDdQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781206849; c=relaxed/relaxed;
	bh=whGa75IbpHw8TmVGKr0kEe5dfQC4HtD5P5gDQJtmmAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dz0CnSefUblXTsCyb+l6v/rZaBJVsK+KkbU8TL5wHHvlXQyn7sfErjqeG+xwU/C91LCg7jd82YtL174fJ8b3IBzVm3IDpHllyO027YXoKc971X7N853TLYwfiqnFPPT6qbvnE7gVVhD1rhil10IaHhJ59jNfbVY61hWZks6JKYVuytqE/9nEyWxHnYVz7hkIhamFcUfgMKWS4/eSE0iDLv/pQmCo8xpuJLxA8xzgxDxsYAIbwSmbLTdXH/5dHgxiNXkRnHpaSFjwN6wKI8aVlY0GCoU7lIj2aN10ZI19cXDJ8vuAX9XudqKjgf0W1jViiA6TSTp85DeWaXWMwMRdaw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=UmWq4MYx; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=UmWq4MYx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbtKr31Knz2y8h
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 05:40:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETofhTKfzFXaeGO7sr0MnMf83pTn6k+m/nADpgKNiAmjRMKRhc/Usoi/jSmDAc9Gu7ljOc3GKjilPwY+vMDQo2o9XuTOXwB+Hi262NN38AbEEyNG94g9zGnATude1IBb3o3aHWKiqEVDjN7jtu2AiQAVNTD1E0AvsgDWdfFs1D+aSehU1DPHyhgBhZ00kxd4ifeCJQkINGnGLxGqvHVS+qvvzTtzTENVQGzj7pGUAB3+Ah5X3X5YY/k9u/GL9s3rQ+jOkj6UDHO9zvA74xYtnmve6sRvEpJothcdpz2XVXgpTZvHUSSUxRPQukMJbVOMMp/84eAmpQIkiTEba5rPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whGa75IbpHw8TmVGKr0kEe5dfQC4HtD5P5gDQJtmmAU=;
 b=a5QX1VErYHriFv+FSKbLwZvJY2oi8MDoYSGixEiPJi/7RUe2XCEEqHA2h6rZ683DvmcgcNmRVNtEBwvuqoVH1F0rgmv0LlNCrXd+I7SlMucvDoa4klUfVb/+Y1IY5jU9pbJGxkKzIFMJdAbiCIxM4tLbl6n7wGT/Bfpz3AvgoTeU5jox9bA/KcrN6ZsRhMVb5wAB3yF+Rs9TLXN4ksd7Qf8xChG8nRmpiV8mzxsf9FjJdghpO/uxmt82zI3jYUtVSLxQh6LbsWnIVaA/yYXUZOLi1VVn4OAI3btzuwA8MRwoFrkUXJn6kiCiSe0FUz7jH444xJqWoRY/V+c5NwN92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whGa75IbpHw8TmVGKr0kEe5dfQC4HtD5P5gDQJtmmAU=;
 b=UmWq4MYx63T3lF1fZcEtOq+G9iQndl6PT1oEBnITPVrAWIyTc3JIomFcrkqD0f6SgjdF4WEGab18r24FJY/1oajMvTWuilJUOUmbMZJEoTJUxurgsDP8hNEwuCBT3Imn/GL4UdDD3msrt4hVi80bmXRlrbzFQ6UPoZleod9LIjPVxk9CPGaQ7yYkPXolbJdgEoZUT3XGsdlZ+GXWefo1oXZuB5XXRJUHSHQtAk2atRy6y6Ymz1k7yH+o2I3ZQt9XRWCw/6OQRjpWnNQDi+7m3jSglYSJU8cWpMs054uVolk0aDhpRacPe+UltQqzkXsR9CPz8zJWPtNrVleAb+/fdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 19:40:21 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 19:40:21 +0000
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
Subject: [PATCH v1 phy-next 2/8] soc: fsl: guts: add a global structure to hold state
Date: Thu, 11 Jun 2026 22:39:34 +0300
Message-Id: <20260611193940.44416-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611193940.44416-1-vladimir.oltean@nxp.com>
References: <20260611193940.44416-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0129.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::26) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed5e05a-2c91-4ae5-ed09-08dec7f14657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|19092799006|366016|7416014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	78ch9LNb/zwHL5xzu1bI0xsg5+P+h6ivZHRaXjzX/pTW3WS/K5iDGOOk6L/VJTETslz0C9qxjmFVHLVPrRGMqH4+GAcwIK2F+7sGQTdIfX2vp+cN+kXGQUhQDlKMgmfbwmZ7o2fZ/s9dM/Q+wmXdMeYJslWVf9qxSYaKnMf3GsZ/SazRmhJB7mdZ09fTfOuZyIYA+Ma7Jla59PI1I33gPZJH+vn5Oxv6GwmuWy2QwW0b5+fbChysV5qUECHvot9IvRuA/yilhlW0O/crQOLwFLWcc92GpD/SM0s6YonBfutE5Pz3NQfOUKaoVlauXvRCVsHSPTa4F0gfs5jcWljiVhdFDfG+noP63HJB2kkC1n7zO4ttswbxwiOfPt0ZpOyaaadQ9p+ToOBM6aY/vZ2kVEHtKtrXzyUvw7UUhiA5qy8K61EJtUrOJxPsul/drX1UPb6XtRvH5nQM15svyxUxxFUMg2ikV/ICQszg9SV942VhbHzOPasDhOYAgogbyO3USr9l37D2NVP3VTHCBjzoTnOEw4G1f/fsSkdK3RjKxxRMZO5Q4brcpZ+dqCBN3FG03cAawCqPiySU72qPrps9tU05WDWSIMLe8RZIKN6cGTBgxgi1M4FFUoQAIe+Rkv2Yt3bA72HhP/d4iXm2/ngSopx2Tzzf0mKza+++eO9VjdBLHY8aXIc2MxepqjJh9TKE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(19092799006)(366016)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VHpUJBONhdRgpmlhBKw6T456JGfLlQpVtiLaJvWjyulfwFyKC1ixLoSp/tYe?=
 =?us-ascii?Q?REKBVdZQY1AwA096Y65PuOYMsrvO9wjda4/DyfErT9yk/DnrtOkdyI9puBnY?=
 =?us-ascii?Q?wnXlaGmmYv8R+quBPJiqfA9NK/DXKrhvCfCBBmrdTjHIoubm0+YAukqi32gW?=
 =?us-ascii?Q?1Oah+HFVfEBueZeazGHIJtgC8075reHAbp3XEcor2Oww9ghLiV3F9hn57clN?=
 =?us-ascii?Q?kQoPtzMgSXS47n1ytkvhxY8X1OuCMQinIPBe5U/frG1q1PZ94/N2k6lKI+uL?=
 =?us-ascii?Q?3/GA00XFM/B7DB92qGB67qy0JBler9EGNZxlQ0CHC1sRGM4jMulSk25mrCj1?=
 =?us-ascii?Q?ng8ZefyM72MIcEOiD4Tbbz64gs2tOWUxiDWAV4F+FfLLI81K21WUCakNbfu0?=
 =?us-ascii?Q?VB2D0I+3C+yHU87/ddK7cLet+3doVag6zKrBMsVwhVilCyzW4HAO/Mu5SGuX?=
 =?us-ascii?Q?dl5mVYkjiACHVyUSwSMUuB3J0Mxhr1+9dimWwpu6e+8iK2MenepNsXRCC3Tq?=
 =?us-ascii?Q?0xwtkD2ExrYjCHsAtwqDA3Bo4Qb50GFxjo26y260LNJgxbCYByHIHLrRJKd5?=
 =?us-ascii?Q?iZ82YuRL+Rbb7YlEej8VI/Pw0D+4/W8zCaKB11UkcwPS+ikxV9M1dyFCd5lf?=
 =?us-ascii?Q?tTsxmT4LIQiZr351TyRV3FPOi585wEasz2ldghqRmZC66uED2g6HEBziFEI4?=
 =?us-ascii?Q?hJWPPDQXhvQMKoSr8kwbp/uwFW4aQaxFnY7ukqtDCJ958hX4B0tpu6WFzzD9?=
 =?us-ascii?Q?NB56dDV6x2mVW9sdgaL4lH/OCqem/lX6mgvEd4vLew0iqvLfgInNZsBp7L1S?=
 =?us-ascii?Q?j7+XwknHTsj+VF2VpqMJ6tmF/mGWUT5/UGvMg1XAPKlr/1MITRg01tv3bObt?=
 =?us-ascii?Q?6q/zEUoSU+8G42G8fVk8HtBPdgCp7jkM8Qv1nWjpIgTJI20tPRpcmKfI0/2y?=
 =?us-ascii?Q?XrenkyprVWvVXvTkdA1sPEIBGXtc7aAp/guRx3Gb7k5TSlIn+PqSqUNuZYOo?=
 =?us-ascii?Q?ZwxRUW+SpElMhSX4xCbmiSDQOK0dcIhSeOqcCAXBDQlOc0sXFarWnznDK5y2?=
 =?us-ascii?Q?/HTHYc4uRyqfToFFDVSMlwjVx9Uy+21R3/aH8yQtxiRpWTEOtE+Ub6TgW8OA?=
 =?us-ascii?Q?WcrBhSCpkc2m2EVI7+DpFvJQRKyQ+dtGk9ZIVjMDXzEo9T1muZ/VRAJhOapZ?=
 =?us-ascii?Q?wwFMcGanIBNbyneVUNrimz1TyZNMBtUXRh/33Guz6MMkxvM42acf34vJz6Ne?=
 =?us-ascii?Q?wzu6q0ZcuOCdPAqQgsu67IXq8y6ue2OS8DQhmGABVr3e567C4yHM7RkMzHur?=
 =?us-ascii?Q?nMGzYEcniozjbLOTYq6myTxNH/0srkYRT5w4MGZqgdFAbjI19iWsz7jLj52n?=
 =?us-ascii?Q?hVOrKV8iRLua4U/R/97MrATzMkUT4lSy7TDLQdMBIh0JtPymuUo3EfK/k8HF?=
 =?us-ascii?Q?XsPfOiswUGkaCy5GWwjOcfv498UGsDbgyAMm6ML1V0tE+l+aD9Ub6B4vfU0Y?=
 =?us-ascii?Q?u9rYKGSoYcHO7DA/gboq1BoatuqAVL2NBkrIAwcSPpBN9PWxh9t0kAzcOwIh?=
 =?us-ascii?Q?WHbUkkC0SWWjlCuUYxwvkIauMAmZYtCNWW5baNb4ztEX2hBQCTEaumaXBnYU?=
 =?us-ascii?Q?g4kIXBvegaBqdW98IV/LvLbWDPZRBiW05NFw+aWu42woZmdUjmzdAN1JzQNf?=
 =?us-ascii?Q?6MiiKpwWETKg4BhpdgsYB160/7gHQuxBqJVq9nuKEBiodrXFHINxxvgwUfwn?=
 =?us-ascii?Q?1+XbIGj3eQhMu9fOPqgJ+72sB2L5AMJ2zOdRI1OVpxMXn4IgD4O9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed5e05a-2c91-4ae5-ed09-08dec7f14657
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:40:21.5427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQLjCBLRnuQNQa1tuA2JT0ktutfr5S0FVzCGWdGBpQrj2xb/5TAXY8Rk3Z7lI/xQjJ+M/rg21RtMVa556ZByiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

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
 drivers/soc/fsl/guts.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index f87ee47c1503..a0a52a5603a5 100644
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
@@ -199,18 +202,17 @@ static int __init fsl_guts_init(void)
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
@@ -263,6 +265,8 @@ static int __init fsl_guts_init(void)
 
 err_nomem:
 	ret = -ENOMEM;
+
+	iounmap(soc.dcfg_ccsr);
 err:
 	kfree(soc_dev_attr->family);
 	kfree(soc_dev_attr->soc_id);
-- 
2.34.1


