Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB06072200
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vXKxYLJU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJHCQ2rT7z3cNP;
	Tue, 03 Nov 2026 03:26:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793636802;
	cv=pass; b=fH1BOk3pM5roibHAnybRFSoK7T5NsbqnrLfqNhp1WhNfuVUd1UnUVRziXqvo1jdUraeEnznrrw//0SY0zjH7qWYHiVl6tKNfBo0ADgWJlrkP0nLzF+IszG8yITeOPGkZ5OUt4VxRIa33sAnQDe4KFm+rt/4FXM3znAIIOOCw/u8t9bDV3owxcZA/LjfYWfGBR0+PXPT18TbkLczLlXQf/geO5k2kaJfkTOhKqajoT/JhrkueoJKLzamvNFpc9Epd2fZPeraCzNhlROv6GpcTdB0bIZp1FG8hhLdc0IkG264YsOBwIGpP0zdGp1OWFKXGJEgTXQFUiGigZoaImXFyRA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793636802; c=relaxed/relaxed;
	bh=8OvSMMk/2vsIrHo30he7I8xKj/oaQZkTJ6zcjO0NW7M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Pzx0DNjiBKxvY6v5aquDdo9jOb2YFmYdU4vx22zlxlMeAP0IDIxE9X4Cp3DVLBdXHti5LWaDlYtOGH7q0fZ6We3AMf6aVA/sh9ZJ9dov9ZiWilah4fd5jpGKmjIcVtUi9IvaU30XcIJHSrAedPMTC7dExGMCO7BsipTwLToiKqJrmUaLNdzU/s35dPTFelRr2LB+WO36HLH12N7eGeJu5LDAEo/n+8AGO/y82SYRLkB8s2s9wnyXkiNYbAh023ojTBJJaxfunJcPkn8+oQJAR3g+AzjP8Fgcs4BYVHMjSaIYCV4jS532trVy47qcz9bzp2SFViDN8EkLlVtxx2IMiA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vXKxYLJU; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vXKxYLJU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJHCP0tFbz3cN3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 03:26:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDb9Px/kEx6gZiA3Ouq4s4QuNDS1BhpyTytqeNoptnZhQLlvDFSOHV3Az/dEreVbzv+Jl8CvBhgaOR7xQ/FMBUk2vIpoxsTasxNbFZZtPCyktkICv54VSK7ArMe5/JmyyeTHLUn/6VJ0uXPBH2+kwm/aviYhoZiHan3W03ow8ba81qyFEylBXe8Y5bHuNE2EOH4gsGHhTdFB53IUxEuRAFqoCLTyokcdcjFyqipCY7zpggmD6aQc06PlsnpgN4WR9LKgtlLOCnUpW6g5LopO7/gmWKaLjtmviA6ZC1NEMZVLAPYMrKpNSRjXrJnCoiUWJBaDxASC7dmVNUJdAfrdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OvSMMk/2vsIrHo30he7I8xKj/oaQZkTJ6zcjO0NW7M=;
 b=L9CEBrUY6PCuFjwORpsMZxGxsBTEwMgQMsgxMGl0fidL/6w7KH1yMge4tFF0bOnTJis5ncCTDYyOc5va4yAOOqD1auwcrENnS5E53+Mi1W9WAXUWHSQatVtKbBHW0RVL7xrpAQAwvGhM0z1J1gLlTKBg24i1rZ3/0fguzPYPlbYkL2A3CKpJuZvtXOM+e9/UndLF3Tl315VR0iXjvdVKrzDmz3R6g750+kltUnYr2yiCUuCvmJEdPr35/dezf2hj2da3Xn2dTFVk9ujp6xw3/Wmfw6lRbV1+bCdMKEHBVnyKnNr/s6c8cbvk5XLVFt2/LPOOz9XYB3zOx3g3D1mK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OvSMMk/2vsIrHo30he7I8xKj/oaQZkTJ6zcjO0NW7M=;
 b=vXKxYLJUz8HOZIlA/ziq72Ht2gEgmyYiI9c9rcLaB3MaHgsMZ6TnqedU0m8Ek1ZXAC6p6UwS9vpRueZY6DupbpXHk4pyTn7xVETi17yEQgGfDzXMmBT2x/8GcbeN1CymL3qeBVFXTNxZpFhe96YGwwWFe5tThFyUKbgIYi5cF7LveLZCyS5Yza4OsNSKCLrmCuwB4eKKRbq+SjmsZsPpel8AmPFN39Pqi2KwnpXn73K2R9+tyJhE5jp/Je7UEkrL+UwxpvU/eJrUnz7dlgTsqUJaRXkkb5hQEGEI0mGdElRq6l87qE8wyd56iK5DiBovZYU0F2oS/SgbnPDTcPDg7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DBBPR04MB8041.eurprd04.prod.outlook.com (2603:10a6:10:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:26:23 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 16:26:22 +0000
From: Frank.Li@oss.nxp.com
To: Anatolij Gustschin <agust@denx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Frank Li <Frank.Li@nxp.com>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC EMBEDDED MPC5XXX),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] powerpc/512x: use dmaengine_desc_set_callback()
Date: Mon,  2 Nov 2026 11:26:12 -0500
Message-ID: <20261102162614.3797495-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:510:324::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DBBPR04MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: e2078123-7c21-4698-4290-08df38fe089b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|10067099003|261102123227099003|18002099003|921020|56012099006|11063799006|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	DAe6aY8+KvFBaHyHb/EBMytTEhpDA7nfW6w3qa0NqShU4U96MA1eQNT/zoFdEr5Eo/2UL44Bbr0kmRPe92tDPRSkkzUgyD/meK27A9Hm+KvzJ1Fru/xMIOpBpJkXWXsNicE/Ph7ZRhARpLQgeO9aJ8R471HqZaRo9gx8Vq2cwW25Ejs7XtD3Deyp0xXY81x0m13GrMgIdGEjtX3OtOBLitqR3fOh5+fBwJ+kC6dvv5rd42mQT1YOWoN2FDvtCQIaXAi2p8+NDeM91DsshEf6ujkiDT/r2thKdnuk1zFI/Quq1Nzv64oIqhB0J6XX9JJ82ul7HXOOdQtDQ4RHTd9MgV+typDjAGRgRX5qIfwkXatSxeg877o5KHdtg+nG+E7DAEikKIbMxKSq2cMJbi+0j0fpQ+NE1tY9A3R5Uu+HjzYXbwgXtgCdljRGRoZiBimAEG3cLjmrDaBS0chFl3K8QnU59W5TVgD5p+KYLHEvnGgezPhIyiLorsrwou85qWI6rI6X3a+pmEE9vkqlOsCVTiWZmicUgQ2nM8tx0m0fah7j6K8tXnCVQgbsuutpo79Ym9DPn/rWPByFKNUR8PIYsCg3Zki7ShPuEGdcKgOnjcyaKxfbfRszdlVFj8125rvjlp1TOvhBhZV3K1RXrjtz9nXwXC9tuqnW64PJWdeKPO8mrj+b2Dod0UhI+SmQbtlgiXqNjAJCWXOqApgVMXnqhw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(10067099003)(261102123227099003)(18002099003)(921020)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BMcY3F6cILQgCOtCL5/b7256cDjTx6FBRIrnhd9BbGUcTjndKtjy+MSxZA+9?=
 =?us-ascii?Q?ylLI5R6Hf0WeIDkHQuwdrwUBQdeqf1ZMXudIYc6eoTgsudXNmVwwecFl0Njw?=
 =?us-ascii?Q?YeFiKysenwXueP9jsCF69H5g3OWMrfeLFD2QB0TPmoEGWPwlgFECCF8kiywy?=
 =?us-ascii?Q?7hEl5t3bSY2p8mNntGzNN8Plaa56RHdNzduKTGmI/I5pJgx8utDzr2AdSrBW?=
 =?us-ascii?Q?5EFvBRFEULzVCvlMdpR+kRhQs3RgI0TZnntHhnovNCQuJfr8AaaFJLMXU/bd?=
 =?us-ascii?Q?Izmc8Jfs6r3sXa8twRSyMKr1h2NsZWtYwUa/0nfUulMzfqXIDHT0lgUVKFIU?=
 =?us-ascii?Q?v8jPbUuF/caewtTZU/aVMVypA/qFrxRrTH80BrZsWgU4ZpmWqMrygs1IZSKU?=
 =?us-ascii?Q?rii2e/TOpH/ah9N5ALEMGQOh4i0JggH32A3rRXBgW9OOuTJVKNUeoOvYG/Og?=
 =?us-ascii?Q?O4pDoFGDKnjF+QkKlRyLQNUz0RdfB/iLw09CS5v8svy/WI3ySQInMqYrUW+x?=
 =?us-ascii?Q?OwoJwHhBuAR4jVCDCYS+9CyJo85RwQBRTA1g0WebwzfU1iorSQB9m8+NLECJ?=
 =?us-ascii?Q?+v7YfT2PxAUXkNpycxSYmArKysgSy3x2mIVJSfeIBd8psiOyU2ezKv3dzqeR?=
 =?us-ascii?Q?UCVG1T1mtSgsVbE4FhquVeEByKNUKjr9NPByhQSZB8zoyOSBOxgHzHpZ1qtS?=
 =?us-ascii?Q?I7zH4WJMW4QgH4yCaeb2gdrRljoj8hsz3xt8/6+YR+1Np1LMHqWQoU48bKHD?=
 =?us-ascii?Q?iJsXqxRXnw0d8Q5f9oxgl2DTztmE6WmGJIVCGinODwWfEF7XixTGqiK3Ov1R?=
 =?us-ascii?Q?xDj4NiGGgpCbQ1IBqjRi4jTwP3igsQSbwENl9sNbK8A6Wi0OqZre4Wc1juhj?=
 =?us-ascii?Q?5qvOwjzuX20Xm2DuiBUHcaW/o8RPZq5PrCjGKjxyEeMCcsq0ZZkq+KAAt51L?=
 =?us-ascii?Q?5l8bxaK5y6+4p2B4EXBUdEIPftPB7nITL50ekm9G8DsNVsG0c4VlTUyui5Mf?=
 =?us-ascii?Q?76Vx0HmrxPk7AC90wNBU8qZnAqNIV7XPQl3MOJiNbSCX/9Y3Dh0DwLoc5U4+?=
 =?us-ascii?Q?+PQhFYzEEi0qY0TKmhqfl5/8ITaVQbxtP7ITc9bvU4S9akAid6BaK0ar86yS?=
 =?us-ascii?Q?mgeECdKuy1EmeR1DectUqfTAOHC0CEjF1GSn6vK2oDjGRZtYLjFQqrbKo5yu?=
 =?us-ascii?Q?IusK9iqpup9iEt020p/ZKfPINfLP92pQG7hzYK88DlbYsk8eDfsYlAVyIFe3?=
 =?us-ascii?Q?O3oQi9TTq5Rxhd7vKfR1OrQmdDNO1OQKuDAGxqjiKv00pnNihLYA0eJ8wtVG?=
 =?us-ascii?Q?Jq34QhA6xxk81wb8zsxy4mHMUJbyjVG4k4wE9J32cAYq2A20DlK+av5jvl+O?=
 =?us-ascii?Q?Ig9eAVlpo0aiheAwclL9gTfiotidF2lkw7s3yaJiI+FcXrSq6skhHRAViopq?=
 =?us-ascii?Q?1GEsR266K3FH1iGxF0qZmgDav6/m7q2lYqiz41+fLUEwaBXuGaP4Vk2BBhxB?=
 =?us-ascii?Q?q1GZ+A/iSmjdUiXcARKfdvSarjtBBk7Zs6aF/HZYUdpxPmIEOsdi71p4K37q?=
 =?us-ascii?Q?oYKj6rwt1Skm9mqu3k0TZ7n6xPLtxYI38PHUrG+57NKWAw+Ov3ERwswZ5pFS?=
 =?us-ascii?Q?ujawr0dx3G6MlDau0YgKni96dMfqD3MjlqtzPsKjMlOrmL0n4vZ9VKPmU1Z1?=
 =?us-ascii?Q?aCDzumMYZXrxhaNFRHyZrb05y892EsB5I7sdOrRboLH+sS2pE9R4nLHIr9Fp?=
 =?us-ascii?Q?odL2pkH0mxHl3MMOuoQWeTSMFAn9/RLHODGAGSYx0OkfBTe6AWz6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2078123-7c21-4698-4290-08df38fe089b
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:26:22.9342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxTOVA+Ggkd+Bx44O8y/COlXlMGFq80v4hPLe+WxkLi+hufMfpUQCW0fQOsm4PTLnMyZmYYIj9l9SwWLRyaTFBq7F6ojvyDHUh6B+tWQl5JC+xUeJyMOg/S9LfXZdCLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8041
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded assignments to callback and callback_param fields
of struct dma_async_tx_descriptor with a call to the
dmaengine_desc_set_callback() helper.

No functional change intended. Prepare make to struct
dma_async_tx_descriptor private to the DMA engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
index f251e0f682620..0c1a4599e8aa3 100644
--- a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
+++ b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
@@ -260,8 +260,7 @@ static int mpc512x_lpbfifo_kick(void)
 		ret = -ENOSPC;
 		goto err_dma_prep;
 	}
-	dma_tx->callback = mpc512x_lpbfifo_callback;
-	dma_tx->callback_param = NULL;
+	dmaengine_desc_set_callback(dma_tx, mpc512x_lpbfifo_callback, NULL, NULL);
 
 	/* 3. Prepare FIFO */
 	out_be32(&lpbfifo.regs->enable,
-- 
2.43.0


