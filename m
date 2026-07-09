Return-Path: <linuxppc-dev+bounces-23875-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3C4C44501
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 02:03:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwdYD4v75z3cMG;
	Thu, 09 Jul 2026 12:03:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783562624;
	cv=pass; b=DReotfRTgN/jG95n8rdz+k9Bp0BkB01ulshSGA+/JY1WpVPXfnIRoeyakXiNNxIuHmfOe4rZM9ypzl4LoHzWe3W24X38KCriK51D7XD4lP9YEYNB6P10xh4vBm8cmqdP4nmoT/tm2q9IEcDzffWcCNGxx2n0VGRcCiZSHN43Q+W61bXiRg3cDi9psPOzH0zX5TKHU8q5izvW24PlqPcF7tXax7ScEeLpyVPumyvHz/9V/xlFIHoeJsUNh7C9GIWLV/5d4LprYrCN/FgDMUoFUuNCQtZfEnsRCUEO2Uxd36G31AEHB6DDjdiSyRMtSsshj/5+chd3tEM2IE5zatxSvg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783562624; c=relaxed/relaxed;
	bh=bcYuUN++YijPeAvZWnhou1K/p1rMyZPGpdEII7b//Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f6xVI/4QP2uNlrzHD+sR7Rs0SyUTvj8DgY6PCNsvFasoKUtCmLLYaNqeUn4LgKMf2y6tfPSMUg7v0gZX1WaPrXH+w+LW/EN/NS+gslagWP1pH/i5NZyzKqSesJMSO1lMFxO3bheZ9XUnRzs10EmAkRg2pvyBft0/b7FR/mSuQDXC5/d/aZgw/7YWCYf/pNBqbqO3WjWrUnIVhdXGBKfxsDo7VEmUzQvWj5PXUDJfI+rrRTOqn/6JyeMp7ENa+5Sg9lNHj0hIJt+P8s5nBnjaQnjQa75JTRb06zJz+2kcdJY3f4pkVY3SASRhGgQsH1DWu0X0eo0bHPDizHsJ4Z4LwA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Uw5Rddiv; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Uw5Rddiv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwdYC6rwZz3cFD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 12:03:43 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBdHhuf4DQpt61yziG4nFUZOzq5KsKiiWrFCBP/EyvPN5gKHLlZ16s6CZ4vkkrdyn99c5ifq7d5jyufmoTl0UOCFo41PF4pYE78M+iM7r/80uC1qHkgMd6GXfxNIo38QdOjwBMYj6GzctfI/vAYLOajV42NMtrdnpjPUgRkfNZywd9FAZA7QMHznBhLhclWAGzIpYUIfcVKxfwPhbK2vmcxhDbPCoZiA2k/jGDoLnLV+AMjeE8IN3WS97p44nnKespF/2ZZnMqC5HKdidXcqhw91j2rvtiNJZQUN9Ub3+xvi/PSAp6fmbA/ruAq7l7ItiEWva3JhiGD/WnG7RQymnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcYuUN++YijPeAvZWnhou1K/p1rMyZPGpdEII7b//Rc=;
 b=aK7FoQWcMc6NRG72ZkzxlYr44UvsPUKzi0mLJuI6IDSL6uJ4eJ8uXTprubLnPtwmlnvHlOpjmlzgfeULFZxJMjV+xdLbDHaFPlSdP4sDqxNeO8uOrf5+xC0ZObF8xoJtId1X0ZoQm00wcLGooC6vRrpuNOWln1PyhVXU2oYy9Aq1WqokTeD0SbIGzT02xzQIUoZyxO7fIUC2PGz1GrIf6t3BHvuNP0hqocASfuvGApD0+TqNM7spW7k+yC928g4y6vrG26ONMCK+625aNk6heGPf3g7sC3/wC/WqM/gRjCCJEcl7fYi9IOENWxnNRKTxIKwl/wP1WEUGXrxqKW1WvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcYuUN++YijPeAvZWnhou1K/p1rMyZPGpdEII7b//Rc=;
 b=Uw5RddivG0piHTIHX+qMBsnYSc71Wm0qm8C8rcUNyI0YRQ76A6RfXgowCsKIHbwsTm1hwoKviwN05iNypvw4RNXlliDMV0ycR9rVyHws25xCCCUPW655TZpY0BjhdCTZ0T4cksPIK1LhPa8QRkx4d2PhSOJjmoT2prRuOOCeLAwqiFDNSq/fPR8MHapYl+fkTXXrMMwNz2gWPLnRdb7/VxMVk2d4EdSR7N36TkGUeX5KVRqyG1A2LqTDcGBBEsVB+Bp3INoRsIRQ02eMydMqPN2iOaOqJMDgDhTdPogHAsjzNgccIQK+DDfeXXdK+hqGc4Gt+Glbe+Ckrv5bDdxEtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS4PR12MB9818.namprd12.prod.outlook.com (2603:10b6:8:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 02:03:22 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:03:22 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 2/5] powerpc/msi: Treat bitmap size as allocation failure
Date: Wed,  8 Jul 2026 22:03:08 -0400
Message-ID: <20260709020312.133977-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709020312.133977-1-ynorov@nvidia.com>
References: <20260709020312.133977-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS4PR12MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fa4ac8-423c-45a0-7bdc-08dedd5e4119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	11pc6oHr/ybMr6UARa+zBsumt/cdsbv5vQkdpIVOy1zgS9boqKYlKwHrHMscDNqir0wvr+Vtb1aj0RL1WdAB11TsbTua/TnjAbheHCqrUuJlxwaibecNR9OG+oxbSm58kNC4TSi+SiSZ9XyUKCOz1WyU0iyWDtobwU6as4mO0mlZh72mlqzbcrnnXiahPdY6YV+tiNrJ7uBwLJTTeOhYSMzl4abHI0peCaob5dEnZvjfbylB1yyf6u9dFPzPK+6iludopQR5aZwgL5QfZUfXTiz4Z9+M9ALiRbJ1ZRkQJlTo7WvY8cO/v3j7S7F0JS/OelNWI0siG8OEkShX/wIHdOP+MiD512R/zuy267hMfqbXAPN5d0gsABOS0lFVbSWf+TNuRobaiUif50/7vQTJ6lotUQ8cYeyHeUomvyChX4WIkRikdTYKzDJ9Ak6G4GZltjSpLtwwHEJ9J5UhzYDtwVzJE6b/HFkEb1Hjt4tl+AGZ10EcYbFYOqvLPLNoq3c9PXdf3aFAcTq688Jp20ESsn5wv3rIK5l0gHXE5ysBg2FYDf4v8aiLOhBRgdPEIcTeQWOaJ0yz4XXPRIayrWWxRxBg80V2cYFN2GGL1n0KG1Zad6p4Runb1ASX6fvEspP70ykUsw6c/28gSL1ugKzdGQHKiaarmHPSwl8pA5uiB9w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8aF2smE3pPSoEOWcVh7zpWBuuXpEaQ4Nrvt4XAMfxzI16LwlAsYG91UC7MLA?=
 =?us-ascii?Q?ArI+x14jnzewxQWNvmCDhjOSLrg6Q7x0wMg0ooAwhle6AiDms+DdWxXs4tb/?=
 =?us-ascii?Q?LauSY9fBsewmTEF33M6jQf1WH5CTEDOaTMLdzg1aHUewNy5MCScn55Ce0aBR?=
 =?us-ascii?Q?HnGyop7Ut6bT7L3jcEw4jD0JN96BTs0xX5ZNooruSmsMz7VE06B19Sr+h7be?=
 =?us-ascii?Q?xRVzfpFj8TuEWMjD8Lea7q9ltP8q1Gs2R6aiqoOXOI+GCwSVa0FTX5uBQzw8?=
 =?us-ascii?Q?hnjkVh9jVRY8LaEdMHgYDSkxuJOITCO57XEAFM8C2YGiTdsBFJlE2Ya+jqmy?=
 =?us-ascii?Q?Si6EhqOrg3JQEpyaXwRVZDIfRjHPLmidZgFWW1jLgfDzKe3vr4Myh/ztSPsH?=
 =?us-ascii?Q?L2XW9tJNz80afZGgGD6puZAEkN0Uz2J3rklloxQ8Gzrp9v2gHueA6mM8rnO2?=
 =?us-ascii?Q?RFmiPKqDwVk3BF6wlS3YLq/CqzD5mAPYu6KGiUIQUDceBS52c6W4hb5iUpJ4?=
 =?us-ascii?Q?WKWQxc6Hkv7hk3IR0jO6XmNDonjTqXc2JZvdYPjeTpfwPOYodJdHnd3LlylA?=
 =?us-ascii?Q?LgG7QZRUUYrzOSkj2TYaaRqM5F6Ee5+OpJ+vEhERRhXkNWJzojfAci+2wZ20?=
 =?us-ascii?Q?bwC+5RVsiFGiwLwVam74GyEgZqf+U8Gynu+lruQU1aGFuvgfn3qtuBxseu+P?=
 =?us-ascii?Q?n2QMmtTSxHJOaoauvnUeYhzyg+7WTpuxeffHi4LpVqLprk6cEtq8QDS0MGRG?=
 =?us-ascii?Q?3WIO5dXxp3xcBx+gMfBXl35j3o4hG6jCm7F4nfxD5bXenOBPjKayL/asDUk4?=
 =?us-ascii?Q?I1hi/N+Zmk/UPmgPKiUFw9gxGZ2uPZRZk4hyDVhmm6L+clxvCD+axY6/v3LV?=
 =?us-ascii?Q?kF6RIRYIH7RcSmajLIrNHgCL5n/KipaLlkOC+wf7HBVjboYiC2n/xQ8VOlS9?=
 =?us-ascii?Q?ZYkCX9vAdwBt9RMyTSEHfy6UxLEa2/tlCuHkAeOQuL++/nr/tqGSVKAAI57n?=
 =?us-ascii?Q?d8hro8F+HUcUm54v2tFRNB63E03IKeDvvpIBFTSs7gC5yyrD0QsPboMnvEgb?=
 =?us-ascii?Q?VnCioFRq/TsLz7tNbElXXudL19iUP6BCJxLcY2Yf6L135nUKac+PksoaRAWo?=
 =?us-ascii?Q?dbRoKUswrXRxgrnOqv6gsFnlR/sjhnc+Vysc0cxdIqpLpCoij3EudeoBOTnU?=
 =?us-ascii?Q?qKg/qmgFqT6/660bB4dxE2GGHiZYpCdpYq1nIFrLov2azTOAt5gTTdvtg3uW?=
 =?us-ascii?Q?j/FTq7+D2ERfQI3eQfc6MIpPAXXOMMDLsCsgOvXwMi7mpnlyceZXQsVhmTj0?=
 =?us-ascii?Q?w5+Q59d8QwklYDm4VBDemh20p/HU3tz0wyeCMqCPa7WHbiKl8Lp1hM5KHhEi?=
 =?us-ascii?Q?DlfsejtidCUSVhRaB4bbbtcUJfrzGr6M5QMlQw1qWUivGxz1smMqqOibyjW5?=
 =?us-ascii?Q?oFYofAK92HtOHs59mEgBrblcE5il7sG2W118BZoEGqWfk18/QTBfM72kQ/Sm?=
 =?us-ascii?Q?6HpdUc8tAJ0PmEohP9qUaKnvk7hcRWW8zKG07nCaTWZ0xp9WaqyC1Nz8CE4+?=
 =?us-ascii?Q?WCYYgB2sZS+s2beQDlBjLiP9vOswxdhDLb0Ym+3VTXp9DDCBlNo1xbgGUSrh?=
 =?us-ascii?Q?ZuLBaKYy3aZgb2xVlvx2uMAX9b7FJGScmxgMYv8kTQ2Ej0keKZ/8pg5ZdNBS?=
 =?us-ascii?Q?4xlNuUokULPymBZ1b3uO+ZiO6UtiNu35cPXIFs9T3KATT3goRNa+QnDuwh1A?=
 =?us-ascii?Q?IwrNG/ONPQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fa4ac8-423c-45a0-7bdc-08dedd5e4119
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:03:22.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTU/IlOAokPKKYdSFk+0p9rAdEkffa/nJh2OxP6bbp5JvKeL9Q+u7mV15fQopPErUH9WJoNnr7VVb1FMdY2LFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9818

bitmap_find_next_zero_area() uses an out-of-range return value to
indicate failure. Check for values greater than or equal to the bitmap
size so the caller does not depend on the exact failure sentinel.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 arch/powerpc/sysdev/msi_bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
index 456a4f64ae0a..2f38d4b41ad3 100644
--- a/arch/powerpc/sysdev/msi_bitmap.c
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -21,7 +21,7 @@ int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp, int num)
 
 	offset = bitmap_find_next_zero_area(bmp->bitmap, bmp->irq_count, 0,
 					    num, (1 << order) - 1);
-	if (offset > bmp->irq_count)
+	if (offset >= bmp->irq_count)
 		goto err;
 
 	bitmap_set(bmp->bitmap, offset, num);
-- 
2.53.0


