Return-Path: <linuxppc-dev+bounces-23689-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D479CC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:47:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvZcT4G4zz3bsT;
	Tue, 07 Jul 2026 18:47:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783414073;
	cv=pass; b=OIRIfZ3zqbaveWBFK2XMNu6H3IHONOSDTygWdyYokbnc/Twwr1y6ZNUWvKoA5YsNGIkCf1tMUy8fbFzWqKztTR7aI0j7o74YIe3XlvEAbcCLeBbC76r3H9r1y3ePEYdI3U0MCUV2J+JQGr0Svtt7eD1reKgq0g3KtCNmk+c5P/sJ15TbnrD0lkcqUZB3GiWthgQsSBWc6rxJyIemfH9qkksxNbzkxfbbqCTJWZ99hvLU0owBTxY9AhGyd4igetcEi0CxM97VyXhehB19C6fi+fVKD1ZlWfy7bGoyazlrSMugF/z5QK75Ok3bpnMx+DYRTbTS9uJ4enSRuvVEBAsKLg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783414073; c=relaxed/relaxed;
	bh=Zpnnp1ejX5Oa/Yy6yvmaD7X3n2NEc28KsJx7aRM5cgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MtyxEDRLUIkSO1sVLfeNqHXb28fAQS7LE2uza06z7m1NdVeL9LiILOioOae1R1PN5s2mHrpubWBaXXSD7fzTYJ3hNBJZiaV0I7qw5dF21tusy1dvCisy+MrzmHgUVyr5yRhHbhFaiMEewJRZitdfZvYYAzytQXSfnsKxyBLeCJ2vLa8ak96ExtaqXuRYUZJ9oayTX/83r26lydS/CzQnqlNZR7mSv0KDENJopH5WBJ9dWywHFRHaXcse/I39IycYOxNarLFDP5yBAA10ODqN8ymsjm+jglxqQ7V8ck8PA2nRVWlKSq32QiwZDOZAeXlQvLq6Ubunj8TlCfAPwxOIAw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=CA63kETV; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=CA63kETV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvZcS6DRCz3c4l
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:47:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMhCpLULli7cdjzEnGi9iIyPivcZfmVkVik7n5EuZ3i7Hyyk3ml0bb8A396MtOvH227U2jzRRR1X7Zebmlooc6eoQFv/900F7QDs3czNMGR9Bf3yajALiIR3wIf3aPu1cvPoGTJS1aHYGmfQRufX2At8DboF5qfB1jTSuW/DFueCGMjp9r6UKita67S0vBW++M/nEL7wMQ5FvvyDXJNT5DkAH5z7CzgIMhZI/HdnvHS1fQnFraOzrBLsHAdKyiCyo5W/M0OBYz2BUXF8uHGJ1m6diaY481j6yO178vHGLtFsauKEF8Tsplpa7BXxuFVHnMo/dFtFZbGewom7YTb4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zpnnp1ejX5Oa/Yy6yvmaD7X3n2NEc28KsJx7aRM5cgQ=;
 b=Pq2Aofecky+e+qatxkmhA3/QKznfva/JU2V+QidZuDFK5vOU3M7ylPoYcfMdsIeo1mbQOyq8g/lKpunJIDwvnGlF2JoRtskr9/VyjyJYyhGt5UqFiQiXY9x0e5wb0Rw4ugWTsyz65YT5vhSE3vyJdIUVqU2+K0dfeYW1XFKYwblvAaW+DRUldjDSkzgzCv2o0hXm7JU4ysxQVw7ik/dmp287+tey7BUtbW8PrJ327Xv+3weIaGYf9uJ3vG6eghsCZ27rhOOKirPwYcmDoAcLz77Cho1UF/LF1upmxgqVJlCWb9Q6eU31alQ2xtAYIZU6b7Bv+j2uf8RRIJADwOKaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zpnnp1ejX5Oa/Yy6yvmaD7X3n2NEc28KsJx7aRM5cgQ=;
 b=CA63kETVkisQJXEkdkwWRhJsNEcLjtRwCZVkBFp87IRPOsI1U/WJ8V+l//CBBGH0H7vJKfvbv5OTJmPu1GPtgW5D2BeoYIj0JdA0fnjEO81DWkHVOzmB02WLl1Wgy4gFRUCrg2EKtMK/darfuSsjIm/v7iwCnA0BZ7rScL2E6W11LDOcRGaGLSzEsh/6DXAMmM50Ld0lWoXGkldc0ZEbUL/k72uKl4zr51UZG0tpcIgFuiyhBfS7KPpehkR4nYoaI+lqIuIHQaCtXTFESZWZN9wgVSv6lYs8TGk5xvQj4FgKKaZdJoJLtaAJZ61twXYcvqdKX5wEqgTI9WuzLpI8oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:47:29 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:47:29 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 06/14] net: enetc: simplify enetc4_set_port_speed()
Date: Tue,  7 Jul 2026 16:18:26 +0800
Message-Id: <20260707081834.710730-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: f94664a6-69ed-48b6-3f28-08dedc046091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|11063799006|22082099003|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	H1WlYaWpGNUIFwriUl/CB3MIiIJZKSJDV5lq3IbDzeN1UwSv4kyCgNzTpHrghjhOa05abA45dJADyaVbDOv3BB7yNBZz2o2NK9LfYRc4nEz2T5HFZw5NmEs//qJFB10lphtw1+JH3MKmnAzWZZBrAjVGNPTSwlKoLDWF9XSJo0te2PLaM8ahWhaw+g0FXQ1qxgG8bGgXWHnW1NWjoOrDGBvkR/G3hb1lwCJZQvQnWWKG1VJPa3MOaznODPAKhVRCF276Y5/HJG/NYdreCbHYD5VmeDUAerhkxoTAz5whWdXWYXt+fzEOwlcWPjC5xyEQrWoscoj27XCyBDWTxUffNeP67k4DhgdR91cM473pbPPkV/Lemusu8bR5YP4Sw/FEQ/qzt6WJq7x3zv4GgztqNTEs23v8GJ/Jk9SD7lRC49nEcb+BniWnYZmv5FjPgloQIH1dbglpyZTJ8cWy0+Gm4ClcncfXGWAhCLDMdBj25EheHLBtoD0lWh7zD8JiA6HtbQtA4CXnLKjB45/NirqiLZN5rbn2JthV6ZxUIL5H/+SMMl2lkTcbyiAmoO0DbqmY3+mpVn441NHTR2nVTiR+gEnktpLOOloZHXZm77Kaf4zkTElaIlMvv6puS2D+/yvwUl48kigwJj1ESVjj0H/8UI5DoRDzZ6FAAjDVvR6ZuBkiGX2rxCpNuEPwouopIkoZ49RiU6AqMSBEyQMHD4MLgw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(11063799006)(22082099003)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIRDxGoNA04YN8woz/EG+akw+ER8UC0X1ls+ZY2CcnP86PJyUBQYnXWx2fE8?=
 =?us-ascii?Q?KDstl6WXi/15pyxt3QO9t+EVXHDjnI9cHcPg03jJoAs5oq1YAxJP9CvazgIq?=
 =?us-ascii?Q?CPSCEEUqyWLfuh0tI3MUlzrDBfan0Wu3l1Mq9OswMeVHWD1vDfchLccWUlUk?=
 =?us-ascii?Q?WcC+QGqhi3E9O/7kSTRNHHVOBOdYMOMo4OM/TBzXpxIWB3UIueBrURm+P3N0?=
 =?us-ascii?Q?uaKxN2O2zRAR6Qi8vOiMwj5u2VmdQVK7ywWD2WX1UDPr3CHfuizcNCd6Cd29?=
 =?us-ascii?Q?VNvDtyI12kmTWwIGw+9ISKdLf7e/B7MeiF0CWIiGGAG6bxm/K/syh5Cvr3bG?=
 =?us-ascii?Q?HXNN5ZEq8e3T3Y6NZGlXoI2WRd17mCzBUXxCvQp/EuiDozeteYh9DNv47bUU?=
 =?us-ascii?Q?UcjzzttaWBQsrmL71Cuto/XV7gCCzrSHP7ynyycw5DXJdJlkRgYiqfwj8d+5?=
 =?us-ascii?Q?IOkULGvyV3wswGNMHFEd2q09MOq26D6Aaa9CO5UIT/AhpkflzC17wjgJTG06?=
 =?us-ascii?Q?7CtOddUKCS1kjXog+t+jSmTXn24ZpdLOKU/0sDfN4G59nGrfwWPtfKv8WJxy?=
 =?us-ascii?Q?JCSeWwqRCNce9kx3JxYO+5/h2XQUTfPMfkULT8aZ99XABWbvLYwVbdEGX/2g?=
 =?us-ascii?Q?0jwbyo9kDQ5O5AjTjnE2DLFKma1SwELlakek/7UQezesj5GiWk/WI7QV8qNL?=
 =?us-ascii?Q?NCFCaCtLHQFY9t8JSLEJRgKemiuAXwy85f7AZlFH0b+gq1MLMBmkc4E+hzGt?=
 =?us-ascii?Q?tLMvQC0Y+hWsZ5uRd1FUt+U8j/hOgx0XFb15LMXzTx6sbyso4XiXwZwUTDXu?=
 =?us-ascii?Q?w1DWIciyPGpXtPTbihfbzjrmZ74crDzNNz8xd0ix+c0emA8Cm1iDOLOsh6Zo?=
 =?us-ascii?Q?Qp5FX1YNjjo6hocIUCNAGUMRUD7iFS8MGkn+4+m0konv6tsaRsvoWc11nZFH?=
 =?us-ascii?Q?NR1US7A4/fSkDYNuZIsiDPH2Qhcn4cEbEPjgGKeDeKrY21jcZMTkRSEZFo1q?=
 =?us-ascii?Q?XlA9ya+4yRtGLes5lAL9pqN+VpwhNHL0EskcAiQ86mDI+wUngrFZQo3hM44w?=
 =?us-ascii?Q?USraLzH6+Qh8M9febBozte+Fdl9eHrYhNR0VnAzVWoz3pKdDVGHMrTnZz+MC?=
 =?us-ascii?Q?YWk5gLuhdufULw14YHcSWlyz87TN2s+S75alOeHWR3QbO2HklJYyCeP2ieCK?=
 =?us-ascii?Q?D6fmyMpcF6eqHY5TBKpMG4AFYEaBT9rLmKy8YJbniPufF4H1T00+TY8D48yz?=
 =?us-ascii?Q?LyWOoROvykgZy8EYr/11i2c/UGZG+dXtfhoCf/00wRC3ulkskqXo9HeVYW+x?=
 =?us-ascii?Q?ucdSBae/C3GBkbzZwws8lZNRbT2JCC5BUcbziP83f+3BEJ/qQD3z+OFzPWp1?=
 =?us-ascii?Q?z/Aqr02WFSTYp2JY8WTNV3eOfZJplmGpxl5r5HzWCv1NhlCmMJAuYAKmJnMh?=
 =?us-ascii?Q?rkFCv3cgcmSVUJR6a7MHiXGbZl7+M3tqR0ZtH3b+/l5gKeIgd2/xvbuuT7GZ?=
 =?us-ascii?Q?LqWR4TH9saiehRU8dMRTJ1/X/UenL2jrAO4QlxK0CC+rCiQcwviXnKbV0iWu?=
 =?us-ascii?Q?ll1s5MBVsFJduPZw5/YQ5ePoPZpbD0tv6uQbYj5Puv1I9216yl0C0yT0ik+1?=
 =?us-ascii?Q?Di19NcLZYCRNhbO+vnQxIWBA7ab1Z7zlkjv0S+w+BPLxfc3eIFZO/4OOVxHU?=
 =?us-ascii?Q?u4ZcZgt2OFj3S2A/fftHtpV55GnGzNOWOlsJSomG9D/F3a+fOo6fDSc5Hv0f?=
 =?us-ascii?Q?crKzZ18R9oNnokMcj4QTfOqMV1BxfoHesK+AEnUEx7dntgZ79flG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94664a6-69ed-48b6-3f28-08dedc046091
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:47:29.2811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvQHeo/lXjKwo5WNC2LP0EWMG5qYvG92ppgz+v+ZLZ+mkhwljcnBSTFLMtTuv2qhqCHrSR8eSi6BZH58oiPEdzQZON0CfOvlMWrVsi0HzqAr3Sd7RsdnxJrhb+6nGeRJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898

From: Wei Fang <wei.fang@nxp.com>

Since phylink may pass SPEED_UNKNOWN to mac_link_up, handle it
explicitly by defaulting to SPEED_10, then replace the switch statement
with a direct call to PCR_PSPEED_VAL(). Also update PCR_PSPEED_VAL() to
use FIELD_PREP() for proper field masking instead of an open-coded shift.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 25 +++++++------------
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 6a8f2ed56017..dea1fd0b8175 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -148,7 +148,7 @@
 #define  PCR_L2DOSE			BIT(4)
 #define  PCR_TIMER_CS			BIT(8)
 #define  PCR_PSPEED			GENMASK(29, 16)
-#define  PCR_PSPEED_VAL(speed)		(((speed) / 10 - 1) << 16)
+#define  PCR_PSPEED_VAL(s)		FIELD_PREP(PCR_PSPEED, ((s) / 10 - 1))
 
 /* Port MAC address register 0/1 */
 #define ENETC4_PMAR0			0x4020
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index b966637572a7..f24269a48c26 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -628,26 +628,19 @@ static void enetc4_set_port_speed(struct enetc_ndev_priv *priv, int speed)
 	u32 old_speed = priv->speed;
 	u32 val;
 
+	/* If the speed is unknown, use the minimum value */
+	if (speed == SPEED_UNKNOWN) {
+		speed = SPEED_10;
+		dev_warn(priv->dev, "Speed unknown, default is 10Mbps\n");
+	}
+
 	if (speed == old_speed)
 		return;
 
-	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR);
-	val &= ~PCR_PSPEED;
-
-	switch (speed) {
-	case SPEED_100:
-	case SPEED_1000:
-	case SPEED_2500:
-	case SPEED_10000:
-		val |= (PCR_PSPEED & PCR_PSPEED_VAL(speed));
-		break;
-	case SPEED_10:
-	default:
-		val |= (PCR_PSPEED & PCR_PSPEED_VAL(SPEED_10));
-	}
-
-	priv->speed = speed;
+	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR) & (~PCR_PSPEED);
+	val |= PCR_PSPEED_VAL(speed);
 	enetc_port_wr(&priv->si->hw, ENETC4_PCR, val);
+	priv->speed = speed;
 }
 
 static void enetc4_set_rgmii_mac(struct enetc_pf *pf, int speed, int duplex)
-- 
2.34.1


