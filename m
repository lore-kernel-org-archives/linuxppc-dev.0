Return-Path: <linuxppc-dev+bounces-19750-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1532FA0C2D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 06:06:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwVyv4lp8z2yxf;
	Wed, 15 Apr 2026 16:06:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776233207;
	cv=pass; b=NAYrzWJLtEjQvQNx/KvQQZBkMafm13OOqo7Bwv0F+pFiYD+LayrDxkbExh05AhqnMdV/kpDZvbtFohhdAlOKn2Jszq5+deGB31ESeu/0w23HTJPKIn86CboA+i2DMttsZQ/LFLP3R0ktNN4afXcwhWua7hohypNKiHoyVmka+3eJ7LHWddnYrwgUM/9TBIH9WY8GQetPs8Z5oukSNIrBtKKj5TNx2SUqIeri02rLsraZCHb9L9jtphEfboxlzwAxqFMbRW04IVvCRhsiPs6esVGiidxYXyFNZ6zfDPhXTyV8CZEgRzTk+DsY4OUTMiez2+Vw9Mu9etXrf/QKZfzhdQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776233207; c=relaxed/relaxed;
	bh=4SWD3oYMo/OSgAIlg8xpmXUcvH3V62NjbPvp5lRIQx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eEsTZ0syH4SWhY5zdpIBRpa4GqlEuks1nyXPHiQdzTXCAEjgAfC4XcGz+/rKdjb7yOHewUpHrNkLGjZ7CBLlKpAyC8zb0U9R2mgXetchF2hxokzXuYaxezqeXiUs708IWy27pfXxZipvKsc9xZB5dcsNub7Rj1f9q1AvhYLBvwtvvb59kxfifv3SlQaqL9CJjQdJjtAAsLcMFZ+DRfLhcElp9C5lUBsCud5Di378nSZIWFup/6BvXlzelx6mYFcytFNbwvxuvfUzymUKV/y0qYxsjqZ2Ghac1tv1HlB0TyYOY5ILlCyJGgGkLQS9lQSuJ6mSUH3pYlsMcGRtz88PfA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gftyaAGk; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gftyaAGk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwVyt5hv3z2yvb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 16:06:46 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HS6O4Il+d6L2SkGQAev8AefqIdNOwByJ1W+5N9OQUf9ANA1Ne6tlA+CSBUnAXMJa0wEbavex0rTvEv4gLxPsb4bPQ/5KitRPwc/s9KAWMEVZsdLHX73BLI6hHnl0flMQvk/V9efjSt4aol5VC5H/rx81eqt4n/NBZLmE/macqgQ4Q9PE2M6ap1iNjt1f55Xg6sXmA6UBpCXiey9Enk612/SHCM5GJddX+dSa6RyHr9zBvT+8ZVBfiBYu1Eon2nGXbmSdJT7ukrnAVhi4lRH/fo7E1a/MO8y74VVyHJDUqktJfICDtBM7xWBugHqFOR8TcnJlgxY8qBzG7ZFSWQrL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SWD3oYMo/OSgAIlg8xpmXUcvH3V62NjbPvp5lRIQx0=;
 b=sxDT8sJR4xOGzVv7zrvst8t2bNZiUZhJ3osu+X9lVVykLM4FgaC5FJWDsTHbp2GtdJ2j5ilg6iQlAQMEJikkBYmkGo0ig96wR5acNxaLSLR1Fvr/6/zgfbKLcMmD5U1azn4fqJkWQ/7EKRAy2c4dUSOmlMGkdYrSxIHPG6r8TsqiEgu2HzKj4eHyGaUGFmvrS2zQvNuySzsydZhoH5D/0R6OPX7rLdhq6Ogo96d+tasZP6sk81CbVQei2Q9KFioZTafpgs/GkHhUBMx5y/+hSyOgoTD4bmPhhIiMFeyISr9kadZo3/DtQ/+VjS8zJCY0sR7i/dY1MdXiRtL9KVlAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SWD3oYMo/OSgAIlg8xpmXUcvH3V62NjbPvp5lRIQx0=;
 b=gftyaAGk1xPM67RqWX7FCg4dF2rmZqJHlzwWeFbCsAEVT+Bc9svfq1KyTzBlNGLx4APOzxIKAWWMDB2CQ3Taglwfq72X22bysczEEnvIW8pKLellDu28mGgS6lw3Y6Ox6NTVrzxWAp7rvnJLDj5RRfoHPW0ETz6eg8VmXH6j3mIT+65Nv0a2UVdk1vUFa3H9jgOTYZKh4dzdOdZjUsj5irIAsGNaH9gt3Sm/7XyhMwFbbiv2FeXC5ehBe8sVNu6qGRUIMXD0eDl+CJPJDv0s2riMK/KnT7SmsuM+EzSJ+0Z1OxRHe7qbRzSVBd+SNlKgA6itQtZ6P0CguUAHO5fBqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by AS8PR04MB7701.eurprd04.prod.outlook.com (2603:10a6:20b:293::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 06:06:19 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 06:06:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net 1/2] net: enetc: correct the command BD ring consumer index
Date: Wed, 15 Apr 2026 14:08:32 +0800
Message-Id: <20260415060833.2303846-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415060833.2303846-1-wei.fang@nxp.com>
References: <20260415060833.2303846-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To AM8PR04MB7284.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|AS8PR04MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c37a7ad-841e-4825-f1ee-08de9ab51c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WVAlToTS1Oa31fq0Qyd6v9dn8TN8ZRCVyHZOhC8sN3Guxs38D4BJ0LCdYKo1t3cq2TF8tYhyFgVQ5F7NfBhi5Gc1Sl+i2bfXw682ch2NKx6P1A9683UoPkamGMBiZ2mry2TGZMHX9iWgmT53a+ypRi1JJFvjHfHE2q5MJCvSjthlzazdaPMPoWkqS7Fkn+j82n+gkeCN6Dnrykza0p3ByJ0s+zYcrCZc1NZVz5W7hlA0xZImr7oV1d7KCqRr8NyzEyeWxmsuCeMkgqgs4pYyeK/EEUZEV1/RIYkLQw0msCADFHZ27pciy9w9peE0nGGfiOYS2iBfq5ioHuCERQvCuhCkp99HEPTSc2i7MQAe6VprLdtyXJT0S3QRA07Wa/iH8JFHG/+ZbEz2rmYeteJHqfM+8kF6P92/oSqNftCSUx4oYXBYtM+Rm5JEkQI2Lw1rWFasnj2DRQWtyb9LfYnvdXgx6SKj4e2xOknCMrhbtYAOd0kuASVoR+qOi/08pr0qCu0p0KmGaLkLEyRVjvdNNHgCxc0LEZ5ibVD+ctUCKXNH64EXDamYJDVlUhEMcmSw7GG884y5Pf3zuxS44i+Kaj+Ct+ir6DaeYD3uDqXU/VVsEoL55yd45eNMCuiz0WJwnqWxQIS5pWVl4fBkvJCCgvMVm0mX0mpxidfoBw8dMntnawUk0DBqIME6oFVx5w81aYicp0Y8KmI5xvrHJo7ZughTUenspjszSxrkI/74KaqLzm36+cDd9cqVCmF8Z3CLkBRrw8FQCkYVyDLjHdIRoVPndHQMP9KJN8WBTf47KtQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1LkaGLw0uuoPQwGATfaNqEnd98bnGhqhgs8oglz9BdYhnQ7mJ0UO4QoCO7jh?=
 =?us-ascii?Q?ZfKNvHK8YLr0witSaEnfzQ/IKxQW3UXou9wpej29MQpr1HNNMliWt7bN+98P?=
 =?us-ascii?Q?D+Hl9Vli3CIj7/xgOTidH8cRGHcEGbEKptQ8OndeysASYkTpNweTk7zgtwYO?=
 =?us-ascii?Q?JATug+EKUXYRgFLiQL1Aolq1uQ+nrtCxP6czBOWHDBCs212lcnGCWL7QBbqK?=
 =?us-ascii?Q?zYeysoyxqDh6c46UX6yk0A0LbD+CCV3fyhJ7UhSEps8QZDpdQF0/8LLZ7cdl?=
 =?us-ascii?Q?NT+ZjJi+eleekEsyFWH9/lq3JpaIupaHt1CJ3WG9oWWOKY9jo6Ji1P2Zbyw2?=
 =?us-ascii?Q?X03KZZp8NAO+RXPRpvqyTGyE4jz8xtxBTCn/nBBTeSmFyRk2hK6URi7hh3W3?=
 =?us-ascii?Q?dBZdicSZAC34ghwy6huQXeOvT2iro9c5Ke7D4VeOdQCwJ4Dsnz95vGvnZG4f?=
 =?us-ascii?Q?z8Wh1bgGQrSk2tytthl8Ame1PPGBPS29sAcxkdZmvj2bbtqjz0fqOmmEweF/?=
 =?us-ascii?Q?IqrJV7h/mUVtCHDyZWQq2b757BNHgPPA2MAg3vp1JN1nLxqo7JCnPsON31o7?=
 =?us-ascii?Q?q3fKWBpaCGhxYtZidoqpPWD2vz+GLZG8LIskIwRAJ4Ihyt/yMMkhBXxCM4Zn?=
 =?us-ascii?Q?+cGPvNM1GxaMB30Fs/pt5VVwkrK4fTEDDnfO+/OpnhEy7mm2RCihNBODRRyG?=
 =?us-ascii?Q?QmPdVuKvL6rbZCmJMTUEB6V/6lGRtgMNm0bqH7QDSEdW3P7dPH1Bryl7Js8V?=
 =?us-ascii?Q?6/6JFAIS8WvpNmO6Je9Vcrr4hJTLDh2tmNlZF3vvKsCYzgj4gTnNO4yn5+Eo?=
 =?us-ascii?Q?tr8HWvTqpPwhrlar230eXxxMdnIWKsXQgY+7Omhk/CNi7JjJ9ifn4TwAML1G?=
 =?us-ascii?Q?HsmNpDr/nkAi1Ps79cdv0IcO9c9AhqIRoUUgGiZ35c+Fsa6RzbndtnLTZkl7?=
 =?us-ascii?Q?I8RLxOQbSx0blYCLjPkfzK5cbWrCu8GwmhyjBPahthq0sPglv8LAgiLTWJTH?=
 =?us-ascii?Q?HbU1yyirmEj/sFVgITtMaJL64ak0qmL0WUmlbDhbm32arxtLnax1jFRVsRGP?=
 =?us-ascii?Q?CDGQ+8KCV3SoyQJQexfgyyhOkBreWVIMembXYS0dKrTCA11R7ndAKNE7hacu?=
 =?us-ascii?Q?E+opWr6eDrcN8t6yrgjnpV5rQHoc39iIO/vY7S2e1nsvmO5gHr90+l4rbZXR?=
 =?us-ascii?Q?E4D34KnkXTca+8AV5ur27jHGfusjGLd3nXZ9oAnkZzPPSXNAPps7LjoOg/wu?=
 =?us-ascii?Q?q8wx1WZ+/5Xa77rcfI+EmXdEdC1T5wL7TAKQvNce5IOQjbatXA3ehP+moabI?=
 =?us-ascii?Q?OThkX1uWQjjA7vbJrsxSfRpSus0gd4wlOrPOQOKGXSrtv+/8wVcslaJJbhA1?=
 =?us-ascii?Q?lCeDw8DnJXho9Oqo8FvKUhGh15qVhi6/90JE0lNNtbCbEvqbnVG7yMltf0Zg?=
 =?us-ascii?Q?L0nKoSxMicZEONU/eX534f4n/lUdqvoZCen4YSSkxykpuM7YP10/5a873qQI?=
 =?us-ascii?Q?OWSVPFupV81AjQDH3ZbWQtrMUAJIl0S3Jt+ioDzxL3VWUml6rG+aauisZjI5?=
 =?us-ascii?Q?q5sB0V7VmSdSdcX8IZVLVnkYTWnehnNyu3QDLBVGhimwGr84seF7XbYkukHe?=
 =?us-ascii?Q?HlZj0bihEJD42mFICP4q5tMea6INTBWio2IBWcd4UHvl96bABa05vHRkB78A?=
 =?us-ascii?Q?Z3M9IB9VuFAO1ynUXJYEyadD9VZuWnQNYZBs81OTbO0q++uFhGH6JpuUBezt?=
 =?us-ascii?Q?irznSUxOrw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c37a7ad-841e-4825-f1ee-08de9ab51c9c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 06:06:19.7096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oyGzwLZCBxWJng1a287kU3A/5D6ORN79xhx2gxddTp6nGS2AaDlAQB6+iNWZHHSb4ijK4qxhHfY52ths/3DWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7701

The command BD ring cousumer index register has the consumer index as
the lower 10 bits, and the bit 31 is SBE, which indicates whether a
system bus error occurred during execution of the CBD command. So if a
system bus error occurs, reading the register will get the SBE bit set.

However, the current implementation directly uses the register value as
the consumer index without masking it. Therefore, if a system bus error
occurs, an incorrect consumer index will be obtained, causing errors in
the processing of the command BD ring. Thus, we need to mask out the
other bits to obtain the correct consumer index.

In addition, this patch adds a check for the SBE bit after the polling
loop and returns an error if the bit is set.

Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to support NTMP")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c         | 13 ++++++++++---
 drivers/net/ethernet/freescale/enetc/ntmp_private.h |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 0c1d343253bf..b188eb2d40c0 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -55,7 +55,7 @@ int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 	spin_lock_init(&cbdr->ring_lock);
 
 	cbdr->next_to_use = netc_read(cbdr->regs.pir);
-	cbdr->next_to_clean = netc_read(cbdr->regs.cir);
+	cbdr->next_to_clean = netc_read(cbdr->regs.cir) & NETC_CBDRCIR_INDEX;
 
 	/* Step 1: Configure the base address of the Control BD Ring */
 	netc_write(cbdr->regs.bar0, lower_32_bits(cbdr->dma_base_align));
@@ -98,7 +98,7 @@ static void ntmp_clean_cbdr(struct netc_cbdr *cbdr)
 	int i;
 
 	i = cbdr->next_to_clean;
-	while (netc_read(cbdr->regs.cir) != i) {
+	while ((netc_read(cbdr->regs.cir) & NETC_CBDRCIR_INDEX) != i) {
 		cbd = ntmp_get_cbd(cbdr, i);
 		memset(cbd, 0, sizeof(*cbd));
 		i = (i + 1) % cbdr->bd_num;
@@ -135,12 +135,19 @@ static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
 	cbdr->next_to_use = i;
 	netc_write(cbdr->regs.pir, i);
 
-	err = read_poll_timeout_atomic(netc_read, val, val == i,
+	err = read_poll_timeout_atomic(netc_read, val,
+				       (val & NETC_CBDRCIR_INDEX) == i,
 				       NETC_CBDR_DELAY_US, NETC_CBDR_TIMEOUT,
 				       true, cbdr->regs.cir);
 	if (unlikely(err))
 		goto cbdr_unlock;
 
+	if (unlikely(val & NETC_CBDRCIR_SBE)) {
+		dev_err(user->dev, "Command BD system bus error\n");
+		err = -EIO;
+		goto cbdr_unlock;
+	}
+
 	dma_rmb();
 	/* Get the writeback command BD, because the caller may need
 	 * to check some other fields of the response header.
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 34394e40fddd..3459cc45b610 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -12,6 +12,8 @@
 
 #define NTMP_EID_REQ_LEN	8
 #define NETC_CBDR_BD_NUM	256
+#define NETC_CBDRCIR_INDEX	GENMASK(9, 0)
+#define NETC_CBDRCIR_SBE	BIT(31)
 
 union netc_cbd {
 	struct {
-- 
2.34.1


