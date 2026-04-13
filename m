Return-Path: <linuxppc-dev+bounces-19667-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563E5EBFD10
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 07:51:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvKNZ1Zf2z2ytv;
	Mon, 13 Apr 2026 17:51:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776066686;
	cv=pass; b=Ou8fJpmS6J0woT3WAv5YZyN+UygG1nbGBU/taY+qd1dpzhtkVnidNknMRtnt8M5AVPnQVXGogi2S3/VBiuhzXZ9NlX+7NnHSW/eej+QFt9vXShHl0YJHYU0gw2PAgQr8z4/U//HVn5vw4byYKutteaBQFbHjnfePiWl2Q/t6AuVa8sLnrLBOgyRAWVUpbkMz7hbdKICKmnOmwZbgGoeniWz743YZswvTdkFzk9luep9NZIkGCmPAWIYg6zASr1/6OWj6BA+GQ/Gudqpv5LtbWdSRqt9Dc0ZWILqdMzEeKm8Co7lrJVikBwtMxvEYyEjKXZALLn3bjOIXpzWHZcyoig==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776066686; c=relaxed/relaxed;
	bh=5fmphqKwb0TwqBXKtyWbZh8v9y5oBNjn1xeHgIQJZ7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dyQ9Y/FcxJCtbKtYFWyV7SVfC8CLHasgufzRr+6oII6UId0uOYir42VlTVdSRGohNh4az7kSRZub0n+fT+l+9hRXe+e2ehQCc7uQrDbJfct6pZ/YLSWiNlsC3ZfP7xLxhVr1sjP0HrnvM2TEd5eKjjmZBeVrmeDLViyUDkSXr7Z5sl4izURYfST5o/R+delfK+ccYJHm5oe3jR+nxWJAGwUbJaz1Hef2uAEEa0sqtEJ05WXVJ89Z8C4eROW5taGDdkLpuMWaUhvdhYphh6A4lwKyqNp3aBOZzRUg61Go1vcbsWOAy4Cj8KBGEYCGeVpc3IRLGlXsX3PwqqFqHL3j4w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=YNGCaWcn; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=YNGCaWcn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvKNY2nT0z2yrg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 17:51:25 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vatks7fuaEbxN1OqDdum4S3ihiVzDBaAptlIawwE2waHZYQmnEOVH1G0vRLuZrmWYic0NrwoJ/XooaElFsoJW38v1OQSn3FW8yvYCLD/THM8peorvVHcufHezsAbOh4RHciQIyVkuwMBhS1buLlGbKCPQEdUgfxnLJNivNEFmW3fjUbNdcosrn4qkABv7EQu7JzUh1l+AJv0z7eNk/8s3FbGZ48gcawkrG+v163N/cmWjq0kunnzrYFPkKjzsT+g6a1FcUTstcvdQjBH6nG+qOQuvNCM0wzT24XaTaLcKZ/+5LzkCijq5xw751h9bU5Gab9VJ8LsDxe93E9IFpv5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fmphqKwb0TwqBXKtyWbZh8v9y5oBNjn1xeHgIQJZ7k=;
 b=XL+c4oZ6j2GaJrU7S59ZissHgcDe9BsWOpfQRxfiGH5l8hxlI6a3lQ18ZXaAam3KL1F00l+l+O/+LFMTcVxhuDCcNl5vyFmnEwg7JUEFiuoMMGbKq7zw2U0Hl3Rjq2k+jXJYntwUJKmY66q54Hu++X/HFgmFJGRuGkxoNrsgsIb43rRYC0QJ94FYATHSNaE5VJRN11TLzoctPNN5LmjfG88SZg8gThwP/BTgoI+Ls1+dFrVN23cxmF48a+xOdA4k7r7PwLe6Fg4KX5GXwK8dxOMW2fuY2GcsdMSohz3dTFL98fddkaVik1NMIj4af1QsVussXaLA+9I0bFZH0Lpp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fmphqKwb0TwqBXKtyWbZh8v9y5oBNjn1xeHgIQJZ7k=;
 b=YNGCaWcnHz809fqWWa0sv+VSOEo3+iGrAZduHecJ7HQehAZHjbUY7aBfwiOWceIVD4nHDdB69B2k+nUx2WjH6ktxxbbtd5KRWnW2RVSYDOQAU/zc3HN3let0EIVpFGu/CStc/AwbEzC4Q8BwPQR5131sZOSFw3cvQxaByKmIG2bQqaibtigC8FK0hph7MQ1iEtldKmrPyVjf0WJNxpJ7bZqeUWiNUrGjkTXDCHPxLlNg/34uCTUOzhcuNTxIJd0RitEHV5TrOWJI7aptQQqDlhttp3DF/oi3TniPyLU5NvkkLVdvjys8uai/UilYCv7nG7yFGSva4ESb6++KZNZ1Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DBAPR04MB7463.eurprd04.prod.outlook.com (2603:10a6:10:1ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 13 Apr
 2026 07:51:01 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 07:51:01 +0000
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
Subject: [PATCH net 1/2] net: enetc: correct the command BD ring consumer index
Date: Mon, 13 Apr 2026 15:52:49 +0800
Message-Id: <20260413075250.281653-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413075250.281653-1-wei.fang@nxp.com>
References: <20260413075250.281653-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0236.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::10) To AM8PR04MB7284.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|DBAPR04MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c7608c-acce-4e0e-92c2-08de99316789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MUIjxBD6XM5U/ZK46K0DsVa8A3P7u0ZCM8k6UGLzcvye0AkCVW4+8D3fD5PPBNPOMjC1HPkHbwTNlFvTpbfZIftcvfWppLQfSyYBJJBIN7tKn3SknaxhVVsPea/RRkZpOfyogZLRWVhvsZjWTneRi6wCMFSYFjD8+mlkFIG20Yi213DMPwsOqpPspJSBBb6ApmRCg/kfEHlQr7Zjx41dzfwpwwvUaUesrWEaGmqrChOuS4bsJk45zW3Fd2033jySOHPPThDGtMr4TndUEiCZGIQEae8DPU4amcJ0R0vK4A8YtsV+NyGOYrNam60PIqd2YFQIvCMWBW5ZUOGFStq/CSWK74r2V+swLnQzzg4vlWjwkUXf6WqXa6xh45HykN/bzzyQs8M2TbuxDXy+XsfTHi5+5uQ5Wx97+DOT8b77KVwMacDsgfvabhxk0oNauY40Gwm4csDBvbNKMr+EjleN4G6ci+85og7baAnBaZwhQtkV0nup42YEacZgZaRpopiuj7EV3RgNasTBkZHgoiqY5ZFBbth5CrwvDRzEKigUyhS40ceJzXWVCGGHHtrWDY1jiUMj6yvd1JVldHpRbcrypwBOBaTtoM9pw+m96hJ82bbrHpIVqBylmo8YfyENH7dqC+G9ajKhQD/IRuOT+d8pv1hmnyH+HUR4IAbM5hxO4GqK45Hko0GGkDcF9ZxtbL6d7GJ+RerHsIdG6UQI3Hzjj4OWpS+uCy6GMRjJ3dbj6lxlyvwbgXkB+ymBB7JTKUP1IND9LBwZ47TIVESM5ZD2ZgwUgVSTO/xa/6fTmJYXGy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TBt4xwYqJpBJ3eZgmBRKmmBTvFuRBayXnzonsfzFnsBrtiyE9IgTZE7WFGjc?=
 =?us-ascii?Q?D7GPR4jZ9EfRKdZ9n3e6bpmlp1UfDvNUggXDTR21AuD6K+IwqlZsNrBtXTOJ?=
 =?us-ascii?Q?Idwxfr8xvoXL7UCAsP/Ibb7QFwT2YP6iJxkHG07kfPWmtOnd8LIkXi+i4jdf?=
 =?us-ascii?Q?2Bqwk6YepWygH42ozYnTALOiTmI/llvd1Snj2fpzVX5JKnXSlG3c8pJJJ06J?=
 =?us-ascii?Q?aQNrDR8X0GU/t8kLum0YZAnqYWL3ggmb5L8CPXmrvk6WeU0nQaZ0lQkFQZ8/?=
 =?us-ascii?Q?RUwDEEFnFk2Ofx0s6+oWYJ3cX5RaNv9dFvXHHUebXr28gDrhW0BixXoWarsC?=
 =?us-ascii?Q?buC9xOU4H1Xp0X2RzvugDpDSdIznQDvirpdopkdO5FAm9p2QXSBMKwDKiPhp?=
 =?us-ascii?Q?xfgU6O/Q4CzUZeJea78rFUEKGbcu8UZYrSm0pDhN/N5mdtVAKg8ZHRIgzXmC?=
 =?us-ascii?Q?yI/V5W0c9QzwjznILTn9FlHgeYhZdLtHUaAEMNDMJMYZxhcnZheDbijbbBL0?=
 =?us-ascii?Q?cNGys7czRAEkIF3kJKOKcv2pP0WoYTWLXasnvrGHsF3Xz0I/swfJqigwdhyB?=
 =?us-ascii?Q?zHvebMj4whRnAg4adQIL2DW6irTpQCeNWc3aOM0Sreyll+tkeaZLJe5PALDC?=
 =?us-ascii?Q?Pq0NMfZfAr2cR4xmegu6/d70CH98Ds2Oq39S2oBL4sNKvLxvCt+KzGvvd8sM?=
 =?us-ascii?Q?eZ1yVrsstVNgbOhmqlovTssRFbcjrZzgvQR1lW1JGTvy7jAyWKmBLXzWHpOi?=
 =?us-ascii?Q?1+MU/Rnl64DsafKzUCSnpklbvOC3lyXipRycEb+AucKU4hxyyREZO57e+axH?=
 =?us-ascii?Q?7DHWlF8VCKIdnQKoVFXxKRHcoSuTlJ4CBqaPulKgrRjalRSCE2nMPaeH2mq/?=
 =?us-ascii?Q?+7SRLodsCW9PNRBvvFsdiclqRfyHdUXvvGU25JUT/v2oXNvpPpfE8wK/OCv6?=
 =?us-ascii?Q?kdXmFxGcph/ienSJwRuQThh5JJu4a9dmtNYOL8+G/dqs0fI/LX6r6TJ6m7cT?=
 =?us-ascii?Q?HydMROmx/9+437mT2oVmRWxHgqLTFukH8g7d7+m5L+x9UTJR6qhO5hjHysak?=
 =?us-ascii?Q?fM9Re+pNWZoT1CyFxyeyUduqEwFMGvMGQJKSEZXwGPHwygSrzEyHTdqC6Uk/?=
 =?us-ascii?Q?EI3sqfNfPW+DmFqFpXFs9lXoskZgRb2k49UuwptI+7lq1O+HkuLwUYjWDggF?=
 =?us-ascii?Q?tR120JCJdsQrzb8PiEB1RZpVA5BYrykaILwpiAYdzJb2/Oc2iM49aWxBcqLJ?=
 =?us-ascii?Q?8eNA6eVqfGnjLxdr6NorIN3Fon8RaZCSN1KzhhJyNEj83kXHZnyljHCWyUa0?=
 =?us-ascii?Q?1iLAr1hcALgU/ZfiUFR39HEimgTG7+Y7xLI2GNEKJOeuuT0fgbyxtCJ0aZM3?=
 =?us-ascii?Q?u+0zS7WAGcAEzkRn8nzP+MVdSTLyRjXWk6+rOqYeBNkdeMVmxlbZ86sxQ83S?=
 =?us-ascii?Q?9rXJTXWdo4hjpjpkFZx12xU6+7c1YgOHBY2MQGZuxC/Gy5D/r7BHWKWnZmng?=
 =?us-ascii?Q?STbvcKXQZpNjKNsEtEK+7OpBHuDOdF5ul92Ms0WmxplaqNLU0yiWMAjLxYdC?=
 =?us-ascii?Q?xBtPkAlGM/C9URUyuvrfDcV545/l2/nNloZKuV6b3px1YfFfxbJhchnNqvZ9?=
 =?us-ascii?Q?/jJ/naFiHnHLp5U9IkECTlPybFHjYDMByty5fVAqhFC/b9AVUjR9ya/TPg8I?=
 =?us-ascii?Q?/3KnqWHPSw48snJE/35WcgG4BkStgLvgaqI1D3Yk5WHhF+inCd9DcKwcMIxB?=
 =?us-ascii?Q?07GoFpz0bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c7608c-acce-4e0e-92c2-08de99316789
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 07:51:01.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0opaxWxupVaOXKrb0imnGX0DPTrKxvgkMP6K2I3+kudLu5SJKyGnKywjbL3XXs//02Ky7jZ6gHf338niwP5Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7463

The command BD ring cousumer index register has the consumer index as
the lower 10 bits, and the bit 31 is SBE, which indicates whether a
system bus error occurred during execution of the CBD command. So if a
system bus error occurs, reading the register will get the SBE bit set.

However, the current implementation directly uses the register value as
the consumer index without masking it. Therefore, if a system bus error
occurs, an incorrect consumer index will be obtained, causing errors in
the processing of the command BD ring. Thus, we need to mask out the
other bits to obtain the correct consumer index.

Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to support NTMP")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c         | 7 ++++---
 drivers/net/ethernet/freescale/enetc/ntmp_private.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 0c1d343253bf..1b1ff0446d0a 100644
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
@@ -135,7 +135,8 @@ static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
 	cbdr->next_to_use = i;
 	netc_write(cbdr->regs.pir, i);
 
-	err = read_poll_timeout_atomic(netc_read, val, val == i,
+	err = read_poll_timeout_atomic(netc_read, val,
+				       (val & NETC_CBDRCIR_INDEX) == i,
 				       NETC_CBDR_DELAY_US, NETC_CBDR_TIMEOUT,
 				       true, cbdr->regs.cir);
 	if (unlikely(err))
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 34394e40fddd..7a53db8740db 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -12,6 +12,7 @@
 
 #define NTMP_EID_REQ_LEN	8
 #define NETC_CBDR_BD_NUM	256
+#define NETC_CBDRCIR_INDEX	GENMASK(9, 0)
 
 union netc_cbd {
 	struct {
-- 
2.34.1


