Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F261606A32F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Vi0NIYzo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVNXj1hPCz30Vs;
	Thu, 19 Nov 2026 14:01:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795057301;
	cv=pass; b=IX3k0RixJACVY9u+JtJpqizVC616CFlkRvuhYzKbSrOUD6oOzFlbcVDfKeF1imFgQP4ZfYQ8TWR/z5VjAIk3heIoWhwQeWFntO8U8/F10VdMGd7DTuUXgnHNoUBsxSklDKJDwbn3Pbt9nr549tY4hLMKSek2mQYIC2LieDkpQH4252EO8PcXB6WiFy3CIGQuPPcu/quiEaivdPJMFIekytbNTvSPrOQT29c0f6ac89OKhvDR4+/+m1i8UBMod/G/g2MdeZLHpD1rXaYVwExvsJcV8mLJ/Dgtj3wuDPsUmIkBICRZilGw/u7382+DM7RPr/65IGBdccFhYvaYY1362Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795057301; c=relaxed/relaxed;
	bh=h3myb9Beb2Vq/zysnRUJQHeLn5KfQQro9KTdEEyF7Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LI0pw1Amp75ftS9bv5RYasLvu+kCFmJRDNnWJb8BM2kvxiL5VxfA4OViEtUXJwwstHIxGgWYE/lr04FOUqZ0/g5a1RFPddlZ3DRgaaKOPh2/sgVZ1Nh77afBsIbG08yLRLrCIVMCBElOlE24XpTk3HqFYErdfvSkeSU5lfF4xevAxSMa+G/LfCBUYF+hiHyIxCw6E3ZOkAHNvsailLIHrCDj7I6k0zjopiVJn9cAs/jweGHJNiWLj9WXKS0BVGfRqRVmu9uBOLFCPD5DJwe3oUjHjxV0B0B0TU5aoB0d8DBkmQ6HM1kRVBsGZ1REzp2mV7hi/SLl//AzqPkF5Qewkw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Vi0NIYzo; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Vi0NIYzo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVNXf3dlmz30hg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:01:38 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCMqv+evJX0a5k2r5kPQsCo2zZ9u3+DkIn6EMcyHyETjJBmPR8xPqDjD1TqC2gm8+/H7PdZ0ul9hGH3SyVvT0Ut+SDEOJpVrdSwIGgqBnFjNyY9q/uki/CWZrOfJxgRcZXB6EWe3SLZM9orQoLVRr0GsSnxs5qqo7p9lqO3vkEIHFoxlqnIv4v0i0Ci/j86i30l1QA7hMRmilKgvmt+luAnno0vLy0nC2wUSQoZUIncCB8GKA6RBboqCCvlXYFA2WyRR+ylPixC3br7e4wsT/15RdXkPeil0iut5qNYV1Y5wG18xS6quJSImOikxnNrmRVneE9ckXcpQFwVQ/bKhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3myb9Beb2Vq/zysnRUJQHeLn5KfQQro9KTdEEyF7Xk=;
 b=C7Cy5QOknaQHRA4D5sUgaXm23iDV/isnj/v/zibOM5aXsBvieQISV2GZr3BgWdgC5+lMiihrko4UFZ+zZZRhJKKA/650MIAuErCPnL5FDIDo+IezE84JjFazGvK9WuF2FKOOiz9zMBXPDDdWFgEI/z3UEzaJL7cder0wDCpLdchLHfUrHGO439oPglfB/8szr+ERIASAPo6+Z9KlPbPibEQ0hRadOgayZRySavd6kPcJmNUWQa+J0iWjo7NzUBE7WhDRm3PWMU3oNMVj0oE0yHlMl4Rcz+rVSH4e6fYfeT3+uN9yIlQjQUoHLXGfuVzjKI7FNlpST/wvwW/fB2Li3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3myb9Beb2Vq/zysnRUJQHeLn5KfQQro9KTdEEyF7Xk=;
 b=Vi0NIYzoSW2ZYXRtL106fCF8CFu+JF8Nq4fvgc1Wdip0BhSyKLbETp4Yv2OgX8lTmTUmR5IRr05CUmUXBUbBFMlMCy41vpdLXzKJbQNBLHmTEXDPUU0nTVril94sl0uCfVtQhDa6geJzI+arQnEk609ol3ZgJZlQssqTL9RvBCsg3hiQfW6P6SYqwd9PkwBmz206fsJIHj8rAhu/HiLXXoAKarrz2pxPoGYzpqeK8iS4j5G1DEf+rZ8vNnFsnwgMcUtHUy9NPc/sxmFhg1S0ZRxvn7+n+vzRJgsjMWDPIwKcXqsYbXxyTnonjpH74gYTY//TgSsy+SZUqbGQl4Jysw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM0PR04MB11880.eurprd04.prod.outlook.com (2603:10a6:20b:6fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Thu, 19 Nov
 2026 03:01:33 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 03:01:33 +0000
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
	richardcochran@gmail.com,
	linusw@kernel.org,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 net-next 9/9] net: dsa: netc: add PTP one-step timestamping support
Date: Thu, 19 Nov 2026 11:05:34 +0800
Message-Id: <20261119030534.1892935-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
References: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM0PR04MB11880:EE_
X-MS-Office365-Filtering-Correlation-Id: e84f2a5a-e89f-4a21-68d1-08df45e96a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|7416014|376014|1800799024|22082099003|18002099003|6133799003|261009223027099003|3023799007|921020|11063799006|56012099006|261102123227099003|261026121527099003|261028144727099003|261026130827099003|261026140227099003|261021123027099003|261021130227099003|261021121427099003|261021135927099003|261022113327099003|261022075727099003|261022105027099003|261022115727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	eG0+rnYKeTi3m69eRhc9HuhzfVmAxU73GJDv5PxBL+yqddQ03rbi5tCp0qULwA91ifZv/9dzSghrxYovqQCgLvlS2H990lw+f0dCsGf/WZDPKeYG3QtTp2o7alOQIhfKBBs71QS1CSb2tQGrDx9nZ5ZBuwPMk+YED8ArE4r76In4H/cEZuIpmYXdPZPHnUPYDrNrHdSv8QbBTq9K+zKDZ+89u9HfioRqHxpXtEVty6QAmC+B3Anm2AUVjEvlewOyo3e3zcPWuIK9rqHqeAnZglyTGhQgpesiVky79uZurAERomd/kNSNpUUVXpMBaV9IqJAXjCPspBcwy+hFtETZglDknTbB/LHwRpMVsUvmas6nl/2ypgPhabvJZBkGp092Gen8vX/IT+aBNgV8gI8wzFW54dt9LUQc4gdm5Y/yDqWPa8aXMz87a5eLQKPiZ35im5DmTT6L2l6y3+JkrJVdS7ol2Q0+hytSlOO5JGyLMO/QIPOuV5B18IBdozEq6FQ1OeM5kehApgSuMO7yo4hFaUkupQHp66D4Mg8Ag74RHzttN4KWVvFEs4Ck2Ahf4vphzB9IhL0lHTEuOaIRj2VYvHTOClt0mjcRIjulVu8THddhp/gUZU8EsvWAcEgcdIT4qGxgOKiQ0pYmyTptLraK3bUCUkyXLB0U84Jz0l5TYpTYeHgnAi9/biQZu0BVnKK/xIypFupAosz8Y44uljRKIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(921020)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261026130827099003)(261026140227099003)(261021123027099003)(261021130227099003)(261021121427099003)(261021135927099003)(261022113327099003)(261022075727099003)(261022105027099003)(261022115727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ERawhoY6pVQpg84KCNqqjETG8K/0elT3XVtRUFHGvtqq5N/NpwoW0VOiricV?=
 =?us-ascii?Q?jIl2/geJDGmb5o6FTTPX6Y9SAgcHaPx2PyDaLNkRfOqMAf58GFyFm299Yy81?=
 =?us-ascii?Q?/OhAyHT+pe9JFzI+8i5sMgfFOg2W3f/SR3axgquzvf7a40Tc2EeY5FGZvYXf?=
 =?us-ascii?Q?Y7/E0aIUHBbOivq9WPqpUOKzqvUFaCey1+zybQyNLVOYu4Hl6/OY4pMdtOls?=
 =?us-ascii?Q?QJ+WVUGNCNG52i0cqqnp5LTOYdJ5YMxGovXtUTI0nWEy8XILXCXPSrutN4wk?=
 =?us-ascii?Q?VRwONXIZ/ehrXUBmXYftNO0X+Y+E3DKm7qUa5pDvjIRYmfSlyRg5vPpWDK80?=
 =?us-ascii?Q?ivmrhCPSRXkWehn7ng7GHzfWM1K1MBLxChwXKUycxvnzPTEg2OqnjvAIxkvM?=
 =?us-ascii?Q?Wk8YvSCBgMV1qluB228q1uedhO+vpdC3K0lj72Ic1XRRwWD+N/OgC9KzePEp?=
 =?us-ascii?Q?G6QtpAaSq1W35XlvurMgoPuVDCR2l6AIXSAeDUFCiSTZK5Lbq/MppVBiJSMk?=
 =?us-ascii?Q?WQVthObOWHQEPVvA1kMc6cGdcwsHIbgpe6y00a5N7stBf2LfJYBnf3HeOhtv?=
 =?us-ascii?Q?gIYui4djC1Bup9Xy66wS6hY5Ij18aN5WHUX6pIEZUUtEHzaJPH5A8mcBoktA?=
 =?us-ascii?Q?uDWBHpNDHOb7JljA3z5LUlCU/NpTsEOaDYF9VNvw9qH+kXjf8B5crAtrpKW0?=
 =?us-ascii?Q?23dRjYO8X5eOAhkwJPjbPGS6mSANf6Ky7r0quFEfWi/0kMwGFa0f8ZJgszBg?=
 =?us-ascii?Q?Ie4A9S76sl1l+9TC6y/oJ2tPIsxB+INwyVIPM7Grw+emI3DzngV67nRVpLLJ?=
 =?us-ascii?Q?wiHndUH7ZyKnoIPPw3btACpPTWPRkvu5G76OVoUKTcWyYIzhahSeFe0/wQXO?=
 =?us-ascii?Q?hXv8z0nEcLVrmW6Anm0mES0JqdU+7vvEQGq3hJPuxs4vW4PeBXHTUvSCD/Yr?=
 =?us-ascii?Q?0k/kwUXwcr0pje/acCUmU2ZkcLQ5ownX9iv3tGH+/Uo8v+1aHDtZ86ZV8emi?=
 =?us-ascii?Q?CKqrXJiy/GFqEU1Xg9OQzl5uIYV2syBAWuqjtPvdZl5JDr+Uv3aJBVp/OkUK?=
 =?us-ascii?Q?4/7ajzj1VizgnMbGhW76fREr9JW8bCx4LgSbYYsyeCunm/15CG2uC/DhThql?=
 =?us-ascii?Q?QPAN6UfZot7ijA1cG6C/dWx5N+HlTqJ3o8wTu/C2WJoLTHkMGPLeAHR7zU01?=
 =?us-ascii?Q?Qs/3Fi0ggWquCK5W4xmdYlFq7GhqvA3Cs6SQ/UuBPLda2TbnNNc6hkUl/crp?=
 =?us-ascii?Q?z4Igzy74Btt2VyaQVIR2hGxw5hVE0ud1RxB3vIEjSacihC6jHwQ17xo9OTky?=
 =?us-ascii?Q?UbG7hKfJMiyzRudEoYmW99JaWUaC35+GHXKKE3vUtgBHWNtqJFVMqPiHj0sP?=
 =?us-ascii?Q?0ip/n98Ui8U02AzclXh9lewf9m4UvvSawyJ3WHFrqOmRyEPCmEA3jX/h27ZN?=
 =?us-ascii?Q?EcAHSEYvj3QIC04Ri+1xNktnPwKb965XBN6jEjVHOrruLOaytFDOOE8BVyj4?=
 =?us-ascii?Q?3R3ewucYrRHJJ+XJ0nFnRXUqbq0pluu9NyFQiVLXIZY7VyVMeM3/t8Ttsi9F?=
 =?us-ascii?Q?XjH18zRRZt2cd6TpA02/jOsz++njYVIyvxyBSKn9NFRTp/YZyc/hTR8AEsS2?=
 =?us-ascii?Q?uyDAFemB/mbSP3Bnzx7Ly73wkjqz4lzkNF7Fg3ZBqkQmF3CI1K+8PRqjGuvc?=
 =?us-ascii?Q?rhLIJNYkDDFdufXANH1vaYDi8rUmD8Vxw8nE0ubWWwF49b45uJ3zGIUq538j?=
 =?us-ascii?Q?Iyb2kmgpeEkqgnqtfHscWcHpREvKnQ3jGWmmG+WHzGBWeWZ8Ooqm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84f2a5a-e89f-4a21-68d1-08df45e96a8e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 03:01:33.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Te6p1kxarsxgiOjjWFLiyM89GbgD2/JubLeLN00esEY/kgw86xIuT8nPdxItOxUEWWMHz7MM1vRjyGpwruPUk+rf9x54Zh7/uyX6eISzZ4q902P2jxhvBBJ3QCr+qIi5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11880
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

Add one-step Sync offload for NETC switch ports and advertise
HWTSTAMP_TX_ONESTEP_SYNC.

Each port has a single PM_SINGLE_STEP register, which holds the offset
of the correction field in the Sync frame and tells the hardware whether
the UDP checksum needs to be updated. As the register is shared by all
frames of the port, one-step Sync frames have to be sent one at a time.
Therefore, let the tagger hand each one-step Sync over to the switch
driver, which queues it on a per-port queue and drains the queue from a
work.

For every frame, the work reads the current PTP time, programs
PM_SINGLE_STEP, writes the time into the originTimestamp field and lets
the tagger insert a To_Port subtype 3 tag carrying the lower 30 bits of
that time together with a timestamp request ID. The hardware captures
the SFD transmit time, adds the difference between it and the software
timestamp to the correction field, and sends a response frame echoing
the request ID once the Sync frame has left the port. Receiving the
response schedules the work for the next frame.

A dropped frame produces no response, so reuse tstamp_timeout_work to
reclaim its request ID after 5 seconds, which is far longer than the
expected transmit time. When that reclaimed ID belongs to the in-flight
frame, also resume the drain from the timeout work, otherwise the queued
frames would never be sent unless new traffic happened to arrive.

The tag timestamp is only 30 bits wide and the hardware accounts for a
single wrap at most, so the correction field of the in-flight frame can
no longer be correct once it is sent out more than 2^30 ns after its
software timestamp was read. There is no point in holding the queue for
such a frame until the 5 second timeout. So when a new Sync is enqueued
while a frame is in flight, also schedule the work if more than
NETC_ONESTEP_VALID_WINDOW has passed since the in-flight frame was
dequeued for transmission. Measure this time with jiffies_64 instead of
the PTP time, as the PHC may be stepped backwards. As the check is only
done at enqueue time, the queued frames still wait for
tstamp_timeout_work if no new Sync arrives.

If the originTimestamp field of the sync frame is not in the linear
buffer of the skb or the correction offset exceeds the hardware
capability, the frame will be dropped. Frames are also dropped when
the ts_req_id pool, shared with the two-step path, is exhausted. All
such drops are counted in the interface tx_dropped statistics.

It is worth mentioning that due to the introduction of
netc_timer_get_current_time(), a new dependency has been added to
NET_DSA_NETC_SWITCH.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/Kconfig          |   1 +
 drivers/net/dsa/netc/netc_main.c      |   6 +-
 drivers/net/dsa/netc/netc_ptp.c       | 392 +++++++++++++++++++++++++-
 drivers/net/dsa/netc/netc_switch.h    |  23 ++
 drivers/net/dsa/netc/netc_switch_hw.h |   5 +
 include/linux/dsa/tag_netc.h          |  17 ++
 net/dsa/tag_netc.c                    |  69 ++++-
 7 files changed, 507 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/netc/Kconfig b/drivers/net/dsa/netc/Kconfig
index 8770b65d0f62d..7c930579f1c94 100644
--- a/drivers/net/dsa/netc/Kconfig
+++ b/drivers/net/dsa/netc/Kconfig
@@ -5,6 +5,7 @@ config NET_DSA_NETC_SWITCH
 	depends on NET_DSA && PCI
 	depends on NET_VENDOR_FREESCALE
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on PTP_NETC_V4_TIMER || PTP_NETC_V4_TIMER=n
 	select NET_DSA_TAG_NETC
 	select FSL_ENETC_MDIO
 	select NXP_NTMP
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index ddbb12573cfe4..6c19b3a811aa9 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -75,6 +75,7 @@ static int netc_connect_tag_protocol(struct dsa_switch *ds,
 
 	tagger_data = ds->tagger_data;
 	tagger_data->txtstamp_handler = netc_port_txtstamp_handler;
+	tagger_data->onestep_sync_enqueue = netc_port_onestep_sync_enqueue;
 
 	return 0;
 }
@@ -94,7 +95,7 @@ static void netc_port_rmw(struct netc_port *np, u32 reg,
 	netc_port_wr(np, reg, new);
 }
 
-static void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
+void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
 {
 	if (is_netc_pseudo_port(np))
 		return;
@@ -1702,6 +1703,7 @@ static void netc_port_disable(struct dsa_switch *ds, int port)
 	if (!np->enable)
 		return;
 
+	netc_port_disable_onestep(np);
 	clk_disable_unprepare(np->ref_clk);
 	np->enable = false;
 }
@@ -2562,6 +2564,7 @@ static void netc_mac_link_up(struct phylink_config *config,
 	netc_port_set_rx_pause(np, rx_pause);
 	netc_port_mac_tx_enable(np);
 	netc_port_mac_rx_enable(np);
+	netc_port_enable_onestep(np);
 }
 
 static void netc_mac_link_down(struct phylink_config *config,
@@ -2572,6 +2575,7 @@ static void netc_mac_link_down(struct phylink_config *config,
 	struct netc_port *np;
 
 	np = NETC_PORT(dp->ds, dp->index);
+	netc_port_disable_onestep(np);
 	netc_port_mac_rx_graceful_stop(np);
 	netc_port_mac_tx_graceful_stop(np);
 	netc_port_remove_dynamic_entries(np);
diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
index bd4d0b70e7ee5..a7ab62f76e352 100644
--- a/drivers/net/dsa/netc/netc_ptp.c
+++ b/drivers/net/dsa/netc/netc_ptp.c
@@ -11,6 +11,16 @@
 
 #define NETC_NUM_TS_REQ_ID		16
 #define NETC_TSTAMP_TIMEOUT		(5 * HZ)
+#define NETC_MAX_STEP_OFFSET		0x1ff
+#define NETC_ONESTEP_QTH		512
+/* The 30-bit timestamp of the To_Port subtype 3 tag lets the hardware
+ * account for a single wrap, so the correction field of a one-step Sync
+ * frame is only correct if it is sent out within 2^30 ns after the
+ * software timestamp is read. Past this window, the in-flight frame is
+ * already invalid, whether it has been dropped or not, so PM_SINGLE_STEP
+ * can be reprogrammed for the next frame.
+ */
+#define NETC_ONESTEP_VALID_WINDOW	0x40000000 /* ns */
 
 static void netc_port_tstamp_timeout_work(struct work_struct *work)
 {
@@ -18,9 +28,11 @@ static void netc_port_tstamp_timeout_work(struct work_struct *work)
 					    tstamp_timeout_work.work);
 	struct sk_buff_head free_list;
 	struct sk_buff *skb, *skb_tmp;
+	bool resume_onestep = false;
 
 	__skb_queue_head_init(&free_list);
 
+	spin_lock_bh(&np->onestep_lock);
 	spin_lock_bh(&np->tstamp_lock);
 	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp) {
 		if (time_is_after_jiffies64(NETC_SKB_CB(skb)->ptp_tx_time +
@@ -31,6 +43,16 @@ static void netc_port_tstamp_timeout_work(struct work_struct *work)
 				    "Port %d ts_req_id %u which seems lost\n",
 				    np->dp->index, NETC_SKB_CB(skb)->ts_req_id);
 
+		/* If the timed-out skb is the one holding the in-flight
+		 * one-step frame's ts_req_id, resume the drain. Otherwise
+		 * the frames queued on onestep_queue would never be sent or
+		 * freed unless new traffic happened to arrive.
+		 */
+		if (NETC_SKB_CB(skb)->ptp_flag == NETC_PTP_FLAG_ONESTEP &&
+		    NETC_SKB_CB(skb)->ts_req_id == np->onestep_ts_req_id &&
+		    np->onestep_state == NETC_ONESTEP_IN_FLIGHT)
+			resume_onestep = true;
+
 		__skb_unlink(skb, &np->tstamp_queue);
 		__skb_queue_tail(&free_list, skb);
 	}
@@ -43,6 +65,13 @@ static void netc_port_tstamp_timeout_work(struct work_struct *work)
 				      NETC_TSTAMP_TIMEOUT);
 
 	spin_unlock_bh(&np->tstamp_lock);
+
+	if (resume_onestep) {
+		np->onestep_state = NETC_ONESTEP_SCHEDULED;
+		schedule_work(&np->onestep_work);
+	}
+
+	spin_unlock_bh(&np->onestep_lock);
 	__skb_queue_purge(&free_list);
 }
 
@@ -68,8 +97,280 @@ static int netc_get_ts_req_id(struct netc_port *np)
 	return ts_req_id;
 }
 
+static int netc_get_phc_time(struct netc_switch *priv, u64 *ns)
+{
+	if (unlikely(!priv->tmr_dev))
+		return -ENODEV;
+
+	return netc_timer_get_current_time(priv->tmr_dev, ns);
+}
+
+static void netc_port_set_onestep_control(struct netc_port *np,
+					  bool csum_update, int offset)
+{
+	u32 val;
+
+	val = PM_SINGLE_STEP_EN | FIELD_PREP(PM_SINGLE_STEP_OFFSET, offset);
+	if (csum_update)
+		val |= PM_SINGLE_STEP_CH;
+	netc_mac_port_wr(np, NETC_PM_SINGLE_STEP(0), val);
+}
+
+static void netc_port_program_onestep(struct netc_port *np,
+				      struct sk_buff *skb)
+{
+	u16 correction_offset = NETC_SKB_CB(skb)->correction_offset;
+	u16 tstamp_offset = NETC_SKB_CB(skb)->timestamp_offset;
+	u64 tstamp = NETC_SKB_CB(skb)->tstamp;
+	u8 *hdr = skb_mac_header(skb);
+	bool csum_update = false;
+	__be32 new_sec_l, new_ns;
+	__be16 new_sec_h;
+	u64 sec;
+	u32 ns;
+
+	/* Update originTimestamp field of Sync packet
+	 * - 48 bits seconds field
+	 * - 32 bits nanoseconds field
+	 */
+	sec = div_u64_rem(tstamp, NSEC_PER_SEC, &ns);
+	new_sec_h = htons((sec >> 32) & 0xffff);
+	new_sec_l = htonl(sec & 0xffffffff);
+	new_ns = htonl(ns);
+
+	if (NETC_SKB_CB(skb)->is_udp) {
+		__be32 old_sec_l, old_ns;
+		struct udphdr *uh;
+		__be16 old_sec_h;
+
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			csum_update = true;
+			goto update_timestamp;
+		}
+
+		uh = (struct udphdr *)(hdr + tstamp_offset - UDP_HLEN -
+				       sizeof(struct ptp_header));
+
+		/* For IPv4, a UDP checksum of zero on the wire means "no
+		 * checksum". For IPv6, its UDP checksum is mandatory and
+		 * never zero.
+		 */
+		if (!uh->check)
+			goto update_timestamp;
+
+		old_sec_h = __get_unaligned_t(__be16, hdr + tstamp_offset);
+		old_sec_l = __get_unaligned_t(__be32, hdr + tstamp_offset + 2);
+		old_ns = __get_unaligned_t(__be32, hdr + tstamp_offset + 6);
+		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
+					 new_sec_h, false);
+		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
+					 new_sec_l, false);
+		inet_proto_csum_replace4(&uh->check, skb, old_ns,
+					 new_ns, false);
+		csum_update = true;
+	}
+
+update_timestamp:
+	__put_unaligned_t(__be16, new_sec_h, hdr + tstamp_offset);
+	__put_unaligned_t(__be32, new_sec_l, hdr + tstamp_offset + 2);
+	__put_unaligned_t(__be32, new_ns, hdr + tstamp_offset + 6);
+
+	netc_port_set_onestep_control(np, csum_update, correction_offset);
+}
+
+static void netc_tx_dropped_add(struct net_device *ndev, u32 cnt)
+{
+	for (u32 i = 0; i < cnt; i++)
+		dev_core_stats_tx_dropped_inc(ndev);
+}
+
+void netc_port_disable_onestep(struct netc_port *np)
+{
+	struct sk_buff_head free_list;
+
+	if (!dsa_port_is_user(np->dp))
+		return;
+
+	__skb_queue_head_init(&free_list);
+
+	spin_lock_bh(&np->onestep_lock);
+	skb_queue_splice_init(&np->onestep_queue, &free_list);
+	np->onestep_state = NETC_ONESTEP_PORT_INACTIVE;
+	spin_unlock_bh(&np->onestep_lock);
+
+	cancel_work_sync(&np->onestep_work);
+	netc_tx_dropped_add(np->dp->user, skb_queue_len(&free_list));
+	__skb_queue_purge(&free_list);
+}
+
+void netc_port_enable_onestep(struct netc_port *np)
+{
+	if (!dsa_port_is_user(np->dp))
+		return;
+
+	spin_lock_bh(&np->onestep_lock);
+	np->onestep_state = NETC_ONESTEP_IDLE;
+	spin_unlock_bh(&np->onestep_lock);
+}
+
+static void netc_port_purge_onestep_queue(struct netc_port *np)
+{
+	struct sk_buff_head free_list;
+
+	__skb_queue_head_init(&free_list);
+
+	spin_lock_bh(&np->onestep_lock);
+	skb_queue_splice_init(&np->onestep_queue, &free_list);
+	spin_unlock_bh(&np->onestep_lock);
+
+	netc_tx_dropped_add(np->dp->user, skb_queue_len(&free_list));
+	__skb_queue_purge(&free_list);
+}
+
+static void netc_port_onestep_work(struct work_struct *work)
+{
+	struct netc_port *np = container_of(work, struct netc_port,
+					    onestep_work);
+	struct netc_switch *priv = np->switch_priv;
+	struct net_device *ndev = np->dp->user;
+	struct netc_tagger_data *tagger_data;
+	struct sk_buff *dummy_skb = NULL;
+	struct sk_buff *skb = NULL;
+	int ts_req_id;
+	u32 qlen = 0;
+	u64 tstamp;
+
+	spin_lock_bh(&np->onestep_lock);
+
+	if (unlikely(np->onestep_state == NETC_ONESTEP_PORT_INACTIVE))
+		goto purge_onestep_queue;
+
+skb_dequeue:
+	skb = __skb_dequeue(&np->onestep_queue);
+	if (!skb)
+		goto set_onestep_state_idle;
+
+	/* dummy_skb is a ts_req_id token only, it doesn't need any payload */
+	dummy_skb = alloc_skb(0, GFP_ATOMIC);
+	if (unlikely(!dummy_skb)) {
+		kfree_skb(skb);
+		dev_core_stats_tx_dropped_inc(ndev);
+		goto skb_dequeue;
+	}
+
+	spin_lock_bh(&np->tstamp_lock);
+	ts_req_id = netc_get_ts_req_id(np);
+	if (unlikely(ts_req_id < 0)) {
+		spin_unlock_bh(&np->tstamp_lock);
+
+		/* The ts_req_id pool may stay exhausted, so re-queuing and
+		 * rescheduling could spin the work forever. Drop this frame
+		 * and move on, even if that ends up draining the whole queue.
+		 * This only occurs in the extreme case, once the ts_req_id
+		 * pool recovers, later frames are handled normally and PTP
+		 * re-converges.
+		 */
+		np->onestep_state = NETC_ONESTEP_SCHEDULED;
+		dev_core_stats_tx_dropped_inc(ndev);
+		schedule_work(&np->onestep_work);
+
+		goto onestep_unlock;
+	}
+
+	/* PHC is unavailable, drop the whole queue */
+	if (unlikely(netc_get_phc_time(priv, &tstamp))) {
+		spin_unlock_bh(&np->tstamp_lock);
+		dev_core_stats_tx_dropped_inc(ndev);
+		goto set_onestep_state_idle;
+	}
+
+	NETC_SKB_CB(skb)->tstamp = tstamp;
+	NETC_SKB_CB(skb)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
+	NETC_SKB_CB(dummy_skb)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(dummy_skb)->ptp_tx_time = get_jiffies_64();
+	NETC_SKB_CB(dummy_skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
+	np->onestep_tx_time = NETC_SKB_CB(dummy_skb)->ptp_tx_time;
+	np->onestep_ts_req_id = ts_req_id;
+
+	__skb_queue_tail(&np->tstamp_queue, dummy_skb);
+	if (!delayed_work_pending(&np->tstamp_timeout_work))
+		schedule_delayed_work(&np->tstamp_timeout_work,
+				      NETC_TSTAMP_TIMEOUT);
+
+	spin_unlock_bh(&np->tstamp_lock);
+
+	np->onestep_state = NETC_ONESTEP_IN_FLIGHT;
+	spin_unlock_bh(&np->onestep_lock);
+
+	netc_port_program_onestep(np, skb);
+	tagger_data = priv->ds->tagger_data;
+	tagger_data->onestep_sync_xmit(skb, ndev);
+
+	return;
+
+set_onestep_state_idle:
+	np->onestep_state = NETC_ONESTEP_IDLE;
+purge_onestep_queue:
+	qlen = skb_queue_len(&np->onestep_queue);
+	__skb_queue_purge(&np->onestep_queue);
+onestep_unlock:
+	spin_unlock_bh(&np->onestep_lock);
+	netc_tx_dropped_add(ndev, qlen);
+	kfree_skb(skb);
+	kfree_skb(dummy_skb);
+}
+
+static bool netc_onestep_timeout(struct netc_port *np)
+{
+	u64 expire_time;
+
+	/* Use monotonic jiffies_64, as the PHC may be stepped backwards */
+	expire_time = np->onestep_tx_time + 1 +
+		      nsecs_to_jiffies64(NETC_ONESTEP_VALID_WINDOW);
+	if (np->onestep_state == NETC_ONESTEP_IN_FLIGHT &&
+	    time_is_before_jiffies64(expire_time))
+		return true;
+
+	return false;
+}
+
+void netc_port_onestep_sync_enqueue(struct dsa_switch *ds, int port,
+				    struct sk_buff *skb)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	spin_lock_bh(&np->onestep_lock);
+	if (unlikely(np->onestep_state == NETC_ONESTEP_PORT_INACTIVE))
+		goto free_skb;
+
+	if (unlikely(skb_queue_len(&np->onestep_queue) >= NETC_ONESTEP_QTH))
+		goto free_skb;
+
+	__skb_queue_tail(&np->onestep_queue, skb);
+	if (likely(np->onestep_state == NETC_ONESTEP_IDLE) ||
+	    netc_onestep_timeout(np)) {
+		np->onestep_state = NETC_ONESTEP_SCHEDULED;
+		schedule_work(&np->onestep_work);
+	}
+
+	spin_unlock_bh(&np->onestep_lock);
+
+	return;
+
+free_skb:
+	kfree_skb(skb);
+	dev_core_stats_tx_dropped_inc(np->dp->user);
+	spin_unlock_bh(&np->onestep_lock);
+}
+
 void netc_port_ptp_init(struct netc_port *np)
 {
+	spin_lock_init(&np->onestep_lock);
+	__skb_queue_head_init(&np->onestep_queue);
+	INIT_WORK(&np->onestep_work, netc_port_onestep_work);
+
+	np->onestep_state = NETC_ONESTEP_PORT_INACTIVE;
 	spin_lock_init(&np->tstamp_lock);
 	__skb_queue_head_init(&np->tstamp_queue);
 	INIT_DELAYED_WORK(&np->tstamp_timeout_work,
@@ -111,7 +412,8 @@ int netc_get_ts_info(struct dsa_switch *ds, int port,
 				 SOF_TIMESTAMPING_RX_HARDWARE |
 				 SOF_TIMESTAMPING_RAW_HARDWARE;
 
-	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON) |
+			 BIT(HWTSTAMP_TX_ONESTEP_SYNC);
 
 	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
 			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
@@ -329,6 +631,7 @@ int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
 		return -EOPNOTSUPP;
 
 	switch (config->tx_type) {
+	case HWTSTAMP_TX_ONESTEP_SYNC:
 	case HWTSTAMP_TX_ON:
 	case HWTSTAMP_TX_OFF:
 		break;
@@ -366,6 +669,9 @@ int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
 	}
 
 	WRITE_ONCE(np->ptp_tx_type, config->tx_type);
+	if (config->tx_type != HWTSTAMP_TX_ONESTEP_SYNC)
+		netc_port_purge_onestep_queue(np);
+
 	config->rx_filter = rx_filter;
 
 	return 0;
@@ -407,6 +713,67 @@ int netc_port_hwtstamp_get(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static void netc_port_prepare_onestep_sync(struct netc_port *np,
+					   struct sk_buff *skb,
+					   u32 ptp_class, bool *twostep)
+{
+	struct netc_switch *priv = np->switch_priv;
+	u16 correction_offset, tstamp_offset;
+	struct ptp_header *ptp_hdr;
+	u8 msg_type, twostep_flag;
+	bool is_udp = false;
+	u32 pkt_type;
+	u8 *pkt_hdr;
+
+	/* Ensure the buffer is linear and writable so the packet can be
+	 * parsed and updated in place. Otherwise, fall back to two-step.
+	 */
+	if (unlikely(skb_linearize_cow(skb))) {
+		*twostep = true;
+		return;
+	}
+
+	ptp_hdr = ptp_parse_header(skb, ptp_class);
+	if (unlikely(!ptp_hdr)) {
+		*twostep = true;
+		return;
+	}
+
+	msg_type = ptp_get_msgtype(ptp_hdr, ptp_class);
+	twostep_flag = ptp_hdr->flag_field[0] & 0x2;
+	if (msg_type != PTP_MSGTYPE_SYNC || twostep_flag != 0) {
+		*twostep = true;
+		return;
+	}
+
+	pkt_hdr = skb_mac_header(skb);
+	correction_offset = (u8 *)&ptp_hdr->correction - pkt_hdr;
+	tstamp_offset = (u8 *)ptp_hdr + sizeof(*ptp_hdr) - pkt_hdr;
+
+	/* Ensure that the entire originTimestamp field is present in the
+	 * linear buffer of the skb and the correction_offset must be within
+	 * the hardware capability.
+	 */
+	if (unlikely(tstamp_offset + 10 > skb_headlen(skb) ||
+		     correction_offset > NETC_MAX_STEP_OFFSET)) {
+		NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_DROP;
+		dev_core_stats_tx_dropped_inc(np->dp->user);
+		dev_dbg_ratelimited(priv->dev,
+				    "Port %d: PTP frame dropped in error\n",
+				    np->dp->index);
+		return;
+	}
+
+	pkt_type = ptp_class & PTP_CLASS_PMASK;
+	if (pkt_type == PTP_CLASS_IPV4 || pkt_type == PTP_CLASS_IPV6)
+		is_udp = true;
+
+	NETC_SKB_CB(skb)->correction_offset = correction_offset;
+	NETC_SKB_CB(skb)->timestamp_offset = tstamp_offset;
+	NETC_SKB_CB(skb)->is_udp = is_udp;
+	NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
+}
+
 static void netc_port_prepare_twostep(struct netc_port *np,
 				      struct sk_buff *nskb)
 {
@@ -446,6 +813,8 @@ void netc_port_txtstamp_handler(struct dsa_switch *ds, int port,
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct skb_shared_hwtstamps hwtstamps;
 
+	spin_lock_bh(&np->onestep_lock);
+
 	spin_lock_bh(&np->tstamp_lock);
 	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp) {
 		if (NETC_SKB_CB(skb)->ts_req_id != ts_req_id)
@@ -458,12 +827,27 @@ void netc_port_txtstamp_handler(struct dsa_switch *ds, int port,
 	spin_unlock_bh(&np->tstamp_lock);
 
 	if (!skb_match) {
+		spin_unlock_bh(&np->onestep_lock);
 		dev_dbg_ratelimited(np->switch_priv->dev,
 				    "Port %d ts_req_id %u which seems lost\n",
 				    port, ts_req_id);
 		return;
 	}
 
+	if (NETC_SKB_CB(skb_match)->ptp_flag == NETC_PTP_FLAG_ONESTEP) {
+		if (likely(np->onestep_state == NETC_ONESTEP_IN_FLIGHT &&
+			   np->onestep_ts_req_id == ts_req_id) ||
+		    np->onestep_state == NETC_ONESTEP_IDLE) {
+			np->onestep_state = NETC_ONESTEP_SCHEDULED;
+			schedule_work(&np->onestep_work);
+		}
+		spin_unlock_bh(&np->onestep_lock);
+		consume_skb(skb_match);
+		return;
+	}
+
+	spin_unlock_bh(&np->onestep_lock);
+
 	hwtstamps.hwtstamp = ns_to_ktime(ts);
 	skb_complete_tx_timestamp(skb_match, &hwtstamps);
 }
@@ -484,6 +868,7 @@ bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
 void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	bool twostep = false;
 	u32 ptp_class;
 	int tx_type;
 
@@ -497,6 +882,9 @@ void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 		return;
 
 	tx_type = READ_ONCE(np->ptp_tx_type);
-	if (tx_type == HWTSTAMP_TX_ON)
+	if (tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
+		netc_port_prepare_onestep_sync(np, skb, ptp_class, &twostep);
+
+	if (tx_type == HWTSTAMP_TX_ON || twostep)
 		netc_port_prepare_twostep(np, skb);
 }
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 5a8e57b01f35e..ae5e24c91f1cb 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -87,6 +87,13 @@ enum netc_host_reason {
 	NETC_HR_PTP_TRAP   = 9,
 };
 
+enum netc_onestep_state {
+	NETC_ONESTEP_IDLE	= 0,
+	NETC_ONESTEP_SCHEDULED,
+	NETC_ONESTEP_IN_FLIGHT,
+	NETC_ONESTEP_PORT_INACTIVE,
+};
+
 struct netc_port {
 	void __iomem *iobase;
 	struct netc_switch *switch_priv;
@@ -102,6 +109,17 @@ struct netc_port {
 	u16 pvid;
 	u32 ipft_hf_eid; /* Must be initialized to NTMP_NULL_ENTRY_ID */
 
+	/* Serialize access to onestep_queue, onestep_state, onestep_tx_time
+	 * and onestep_ts_req_id
+	 */
+	spinlock_t onestep_lock;
+	u8 onestep_state;
+	u8 onestep_ts_req_id;
+	u64 onestep_tx_time;
+	/* skb queue for one-step Sync frames */
+	struct sk_buff_head onestep_queue;
+	struct work_struct onestep_work;
+
 	/* Serialize access to tstamp_queue */
 	spinlock_t tstamp_lock;
 	/* skb queue for TX timestamp frames */
@@ -213,6 +231,7 @@ static inline void netc_del_vlan_entry(struct netc_vlan_entry *entry)
 }
 
 int netc_switch_platform_probe(struct netc_switch *priv);
+void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val);
 
 /* ethtool APIs */
 void netc_port_get_pause_stats(struct dsa_switch *ds, int port,
@@ -244,5 +263,9 @@ void netc_port_txtstamp_handler(struct dsa_switch *ds, int port,
 bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
 			unsigned int type);
 void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb);
+void netc_port_disable_onestep(struct netc_port *np);
+void netc_port_enable_onestep(struct netc_port *np);
+void netc_port_onestep_sync_enqueue(struct dsa_switch *ds, int port,
+				    struct sk_buff *skb);
 
 #endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 1404ae41c7bcb..37d1dd7ec2c7f 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -203,6 +203,11 @@ enum netc_stg_stage {
 #define   SSP_10M			1
 #define   SSP_1G			2
 
+#define NETC_PM_SINGLE_STEP(a)		(0x10c0 + (a) * 0x400)
+#define  PM_SINGLE_STEP_CH		BIT(6)
+#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
+#define  PM_SINGLE_STEP_EN		BIT(31)
+
 /* Port MAC 0/1 Receive Ethernet Octets Counter */
 #define NETC_PM_REOCT(a)		(0x1100 + (a) * 0x400)
 
diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
index 5a567af200940..baf0f93bd9946 100644
--- a/include/linux/dsa/tag_netc.h
+++ b/include/linux/dsa/tag_netc.h
@@ -10,7 +10,9 @@
 #include <net/dsa.h>
 
 #define NETC_TAG_MAX_LEN			14
+#define NETC_PTP_FLAG_ONESTEP			BIT(0)
 #define NETC_PTP_FLAG_TWOSTEP			BIT(1)
+#define NETC_PTP_FLAG_DROP			BIT(2)
 
 struct netc_skb_cb {
 	u64 ptp_tx_time;
@@ -18,6 +20,9 @@ struct netc_skb_cb {
 	bool rx_tstamp_valid;
 	u8 ptp_flag;
 	u8 ts_req_id;
+	bool is_udp;
+	u16 correction_offset;
+	u16 timestamp_offset;
 };
 
 #define NETC_SKB_CB(skb)	((struct netc_skb_cb *)((skb)->cb))
@@ -26,10 +31,22 @@ struct netc_skb_cb {
  * struct netc_tagger_data - NETC tagger/switch-driver shared operations
  * @txtstamp_handler: Called by the tagger when a two-step transmit timestamp
  *	response is received, to deliver the timestamp to the switch driver.
+ * @onestep_sync_enqueue: Called from the tagger xmit path for a one-step Sync
+ *	frame. The switch driver takes ownership of the skb and queues it for
+ *	deferred transmission from process context, where the shared
+ *	PM_SINGLE_STEP register can be programmed and the PTP timer read. The
+ *	tagger must not touch the skb after this call and returns NULL to
+ *	dsa_user_xmit().
+ * @onestep_sync_xmit: Called by the switch driver to transmit a deferred
+ *	one-step Sync frame directly to the conduit, bypassing dsa_user_xmit().
  */
 struct netc_tagger_data {
 	void (*txtstamp_handler)(struct dsa_switch *ds, int port,
 				 u8 ts_req_id, u64 ts);
+	void (*onestep_sync_enqueue)(struct dsa_switch *ds, int port,
+				     struct sk_buff *skb);
+	netdev_tx_t (*onestep_sync_xmit)(struct sk_buff *skb,
+					 struct net_device *ndev);
 };
 
 #endif
diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
index 6b492451d092f..c1c0ffee75c13 100644
--- a/net/dsa/tag_netc.c
+++ b/net/dsa/tag_netc.c
@@ -18,6 +18,8 @@
 #define NETC_TAG_TP_SUBTYPE0		0
 /* SubType2: Request to perform two-step timestamping */
 #define NETC_TAG_TP_SUBTYPE2		2
+/* SubType3: Request to perform both one-step and two-step timestamping */
+#define NETC_TAG_TP_SUBTYPE3		3
 
 /* To_Host NXP switch tag */
 #define NETC_TAG_TO_HOST		2
@@ -32,6 +34,7 @@
 #define NETC_TAG_FORWARD_LEN		6
 #define NETC_TAG_TP_SUBTYPE0_LEN	6
 #define NETC_TAG_TP_SUBTYPE2_LEN	6
+#define NETC_TAG_TP_SUBTYPE3_LEN	10
 #define NETC_TAG_TH_SUBTYPE0_LEN	6
 #define NETC_TAG_TH_SUBTYPE1_LEN	14
 #define NETC_TAG_TH_SUBTYPE2_LEN	14
@@ -44,6 +47,7 @@
 #define NETC_TAG_SWITCH			GENMASK(2, 0)
 #define NETC_TAG_PORT			GENMASK(7, 3)
 #define NETC_TAG_TS_REQ_ID		GENMASK(3, 0)
+#define NETC_TAG_TIMESTAMP		GENMASK(29, 0)
 
 struct netc_tag_cmn {
 	__be16 tpid;
@@ -57,6 +61,12 @@ struct netc_tag_tp_subtype2 {
 	u8 ts_req_id;
 } __packed;
 
+struct netc_tag_tp_subtype3 {
+	struct netc_tag_cmn cmn;
+	u8 ts_req_id;
+	__be32 timestamp;
+} __packed;
+
 struct netc_tag_th_subtype1 {
 	struct netc_tag_cmn cmn;
 	u8 host_reason;
@@ -129,17 +139,69 @@ static void netc_fill_tp_tag_subtype2(struct sk_buff *skb,
 	tag->ts_req_id = FIELD_PREP(NETC_TAG_TS_REQ_ID, ts_req_id);
 }
 
+static void netc_fill_tp_tag_subtype3(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	u32 ts = FIELD_PREP(NETC_TAG_TIMESTAMP, NETC_SKB_CB(skb)->tstamp);
+	u8 ts_req_id = NETC_SKB_CB(skb)->ts_req_id;
+	struct netc_tag_tp_subtype3 *tag;
+
+	tag = netc_fill_common_tp_tag(skb, ndev, NETC_TAG_TP_SUBTYPE3,
+				      NETC_TAG_TP_SUBTYPE3_LEN);
+	tag->ts_req_id = FIELD_PREP(NETC_TAG_TS_REQ_ID, ts_req_id);
+	tag->timestamp = htonl(ts);
+}
+
+static void netc_onestep_sync_enqueue(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	struct dsa_port *dp = dsa_user_to_port(ndev);
+	struct netc_tagger_data *tagger_data;
+
+	tagger_data = dp->ds->tagger_data;
+	if (unlikely(!tagger_data->onestep_sync_enqueue)) {
+		kfree_skb(skb);
+		return;
+	}
+
+	/* Hand the one-step Sync to the switch driver, which takes ownership
+	 * and queues it for deferred transmission from its work. The tagger
+	 * must not touch the skb after this point.
+	 */
+	tagger_data->onestep_sync_enqueue(dp->ds, dp->index, skb);
+}
+
+static netdev_tx_t netc_onestep_sync_xmit(struct sk_buff *skb,
+					  struct net_device *dev)
+{
+	netc_fill_tp_tag_subtype3(skb, dev);
+
+	return dsa_enqueue_skb(skb, dev);
+}
+
 static struct sk_buff *netc_xmit(struct sk_buff *skb,
 				 struct net_device *ndev)
 {
 	u8 ptp_flag = NETC_SKB_CB(skb)->ptp_flag;
 
 	/* Fast path: the overwhelming majority of frames are not PTP frames */
-	if (likely(!ptp_flag))
+	if (likely(!ptp_flag)) {
 		netc_fill_tp_tag_subtype0(skb, ndev);
-	else
-		/* ptp_flag == NETC_PTP_FLAG_TWOSTEP */
+	} else if (ptp_flag == NETC_PTP_FLAG_TWOSTEP) {
 		netc_fill_tp_tag_subtype2(skb, ndev);
+	} else if (ptp_flag == NETC_PTP_FLAG_ONESTEP) {
+		/* The switch driver takes ownership of the one-step Sync and
+		 * queues it for deferred TX; the deferred work tags it subtype
+		 * 3 and transmits it directly to the conduit. Return NULL so
+		 * dsa_user_xmit() stops processing this skb.
+		 */
+		netc_onestep_sync_enqueue(skb, ndev);
+		skb = NULL;
+	} else {
+		/* NETC_PTP_FLAG_DROP */
+		kfree_skb(skb);
+		skb = NULL;
+	}
 
 	return skb;
 }
@@ -326,6 +388,7 @@ static int netc_connect(struct dsa_switch *ds)
 	if (!tagger_data)
 		return -ENOMEM;
 
+	tagger_data->onestep_sync_xmit = netc_onestep_sync_xmit;
 	ds->tagger_data = tagger_data;
 
 	return 0;
-- 
2.34.1


