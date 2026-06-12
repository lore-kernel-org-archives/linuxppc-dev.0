Return-Path: <linuxppc-dev+bounces-22588-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF6ACD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 21:09:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcXFm1pwRz3bsj;
	Sat, 13 Jun 2026 07:09:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781298572;
	cv=pass; b=lSfY2OlC9DrN7cV5EeXlzwLDEXdXNtKwHp+ZGdciL5LD5v161GR91VECgHryMlumeGB1pINuzJV7lHz/yDKV4QEoY1Yo9Tmw0TyhX3I2zkgy+774j3O+jflWHH/1BzZbMroxgvW7YtLDEN1Dj3ovSy1HRzuLy4lVM3gRXfX6RZbzaVX4PdO7ZFK7MKB6sjmu78LG1p2RKZTvSZe6j6lYCqheU65gHu8Q++5WFJEhEd9xwto5B/8zytj84Vj6wZnRc3YfhwCP1nTFYsYbGus723cO3HVPzuXGruPBOS9l9P9nI1YT5vLrb/HcV3vNqXBSCLVZ1fjMz1NBrH/FRlQWsQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781298572; c=relaxed/relaxed;
	bh=bDAb84mvwzzdH4QlbWfj/UPGvGpj+bM76a5W0SC0Otw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvOOp2QYT1ChE2TorCHVGfmTwmimEaqSb4HuCZgWL1jgdzTrz0DZ3Bz0G/i6QtnpmtTGPLDv6hIsTt87M9X09nFrPwISdismlscLQxaFIIvARb71K+F2ppZMD4gicgPMfWdtd5Gzdi/G4OEQ48a60AzbjStwJbPxx5no6+S/302nWLaNCFHRHpz0uPympGL07Tc9YsFPWTtWvfBVJZLjtqlh+3vEW8PbzbFLBkbqdap8DAjdm4ZZwYhdfZlcPmTwkcSYaVrs9WjtCEIbVYhuBRHgZ9qtxqinCY4eiH73p/P+TdNW/lyZYAILWjmS3fuWBXoaK9qecEJ01LpdS4Nq1A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=DLA0RiV8; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=DLA0RiV8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcXFl11B7z3bsL
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 07:09:31 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gP/124kNaDXxQxtQWKgIgalGAyJzoWrhqjyPDNSglfC04nDoVVbz0m5SUEj1tfgKzkgCIjpMrRq9po50tWWB1dh8kI/8UdvClfBwkqsjJK+Sno6n3NdweY8VG/rF1xKpuL3cRsgnWIgDql7EH/ei1LKR+CtJlXcM4LT6+vdbRiDsPrfcs5NeSGqRkiD2sQqcHn1Zunqv1AqycVyhgcxo+sDMabG8FvfbTyi6TWU5yeBHGldOYCqA3jIW/9QMC+AbXO1zqac2C3Muo+IQ/67kskLFuLgE+UW/MYDQ4WJNFY5eZk/+D4Nrw95fezcrG7Zi9p4Dxo1q0OKq1IpfVtuPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDAb84mvwzzdH4QlbWfj/UPGvGpj+bM76a5W0SC0Otw=;
 b=O8EyKNqPfwsU2K/UpOyGJYOl+Nu/Lv/wJToWSlhRZRZsuOV2fHRXhoyQB9e0S56U3gAoLxrHGUNd1vEr1VlcUr1iuu5APsr4fxXCQCDynoLXK1ZO5qA6X/RqyzwJhe0oouLq/2mY1/xleM8EYzWXMfiSZ6ZaJl73miRBgZeWDSElCMoxLti5ta9cq8Ad+FRuYMpot1FubLWSi1lKqV31PXSP/XT0mTokX9ZQJTB6qMKBRsTdQzTxSkWzVI8/QFzatE5UnrVKsEayTKP7E5LCbhHypdZcgkmNfuO0lPHH9Ptknjf+I47k+CP2qVo7qO+Fq/PhhALpA8Ea2ppmeiT+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDAb84mvwzzdH4QlbWfj/UPGvGpj+bM76a5W0SC0Otw=;
 b=DLA0RiV889CUTgtDDWmqzcTXNh/xFxPOZH9GCAJikaTrHNcR0rnISSW4ou0AQzau0t5L8k9s7Gcwi2cQ2X92AlbEzs/rkGXbMNmTizqSxTodr/U+qSJNl3Wy4C/BdDCA7aoEkCLCwkKzIvSbhYMTUKZS7smARGDTAfsSYXwPweijfuvDidWA+8m1IZxV6c5ZOipqh/2Bbx4Z2hMULHtr9y5qL8GcGZpZ18tANl7JQ4qYo6I40IvJeIO7ncLbAB7YLN87uXlwo6ozzxOcIRRWhoj61TW6ozM6uWjZeoJSKPNeNB8BrBHyWtDhDAmYiRTmv9WBtDv0hi5GnheMHirG1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB10969.eurprd04.prod.outlook.com (2603:10a6:150:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 21:09:06 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Fri, 12 Jun 2026
 21:09:06 +0000
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
Subject: [PATCH v2 phy-next 2/8] soc: fsl: guts: add a global structure to hold state
Date: Sat, 13 Jun 2026 00:08:53 +0300
Message-Id: <20260612210859.266759-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612210859.266759-1-vladimir.oltean@nxp.com>
References: <20260612210859.266759-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0002.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::9) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 446c93e8-a68c-4c55-6448-08dec8c6d6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|10070799003|1800799024|366016|7416014|376014|56012099006|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BDZIvG8zUJ5AZZwdhF4VwdKq5e+3Tk0Igf+lILf6N0o/EdPiANQ6cjsPr/NIoU1vdkSXu4nTX5QxQpUbooD5iLuXEMfCBkKH0nzFfSPGYbFIDytYzZn3zL8CJDNklvRV4RuzaEQADtp29eGvXkE7RjiUig66nO/MeouqkCi0iUZ/Um5PxugoVaPdvBxn0P/5M3ru07W8+KWpjEpYQwf7vXqmCyDjF4KQVQ0AulJQWw6i5shcWR2lQ3ctGW3pJvw46prbsakXYMJX+5cv3D5O5wVkT1BqSX4HN1ycjknbbQCHQgbNn966g7jOTgrMTwei4Ie7lDJgOeKDZXk7B5N7NoxJpIJ8Gl3JfP3PtHi+ZjL/LXoOV9E3Dkun2imj5WehNAGKwxSiU/b9gHguCVgU6DHIXjs94B6WSFkuGkrVO4wH4esakyd1vlbmvZN6mylWB193MeSAyHOoMDRolZlH0k6HoxYBfzYlAfseProwxlgBAkHFWN5wP3LmA3+tUh7BgFyvRtjxzYoMMZ+UBYUynZ+n7/ev3IAGGHMynz+2PmclKJFf3olazFfXx9+A0Tbtd/hMIJqGW5V9mBgtFMtG+HLZZPrHiyFDB0E1GQNxhDM1PAAB8p5NDC8J2hD0w2nna4ivLQ4P4dfNqVF8KJGV2iQjwM0m4nYpe7vSbXOzLZ4ppYuEfodz32gCpGepp12j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(10070799003)(1800799024)(366016)(7416014)(376014)(56012099006)(3023799007)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vGZYtuNugtO4vSYUAo+R6bDELrSA6S3culpP1C5wupM9g0F4//VLKO1QsbUq?=
 =?us-ascii?Q?c5UmBiPs8l2LQ0bor/6pm9WAeVLEid6Iyknqj26nofbkh39/R5jDkJZDTVjY?=
 =?us-ascii?Q?A0sAe22lbsJHBr/XApyjZ9KLf3ub7bFDeLbDIYdLM2UGdaqMKyQL3TDyigsa?=
 =?us-ascii?Q?XWileVSUvTUgCdgZzryXvuVR9tFZmobQau7srCCVhfz3tGCRnFZoTIaqRprI?=
 =?us-ascii?Q?p+P0kuaJmmlRByK+9ukAzes7QfOAcRt80YqHc5pFI9mNI6sJXsWElO3oLNZa?=
 =?us-ascii?Q?vXanXlstBd7OgcCgyr6rKr3O43golYABGEmyDN2+0ERNJs+3MA9k6+stVryp?=
 =?us-ascii?Q?HAqgjHw4fbiwwK+Y7Fzk2mZ7jqHBs/mwZTEnfoXoj7rJRkSBj3o2VU4zA7ys?=
 =?us-ascii?Q?Sbx4vj/9QbEvPIZPlq40NVKGNXombne1NDFGSHkrEvft2eXpNQPskkPEISE5?=
 =?us-ascii?Q?is4IHBXQ0Na8VzpRA2Y1vVljXm2M+I8R639PBcdlWGuwSO1G/UvpLL+OfLn8?=
 =?us-ascii?Q?RdxarlsRh+7VOcIoqMzh2Fh4H0384fCOwpsnjFlMqNbvIprr2qsi8HPpJO6I?=
 =?us-ascii?Q?WEPz5awx4Ys9YZd3pBqbMPXAqJQ5JPoG6v9Phg+lFYP782i4meRivnXON1RN?=
 =?us-ascii?Q?Wsh6iy9wL02ZNoJdJLQYghVkCRZ9X2V4mn54detfGWm5wrxFSqRfXBfOWDbE?=
 =?us-ascii?Q?uoDkgGYfpBuDJXGpcp4UCxRyY+8eO0HaZVlT8rCOp7yF0ovcN27V0278Ba7Z?=
 =?us-ascii?Q?y0lPKNS1ogzKc8UWfd03GJnJfd91XHXAO9u6xse6H8CFQJwKLC8+HR4eBrJx?=
 =?us-ascii?Q?cfE7TD1Mc9319xPZvEQj7wUj+vl2wqnqZyJeTW14jPKw2hYwqRtUvr56Zox5?=
 =?us-ascii?Q?aI+jhiPSDAG9eXS1k5rzrt31y//QQdAvTF9qybUSH7ZDqkTJPWC2R5BTFDhq?=
 =?us-ascii?Q?fk+g7vV6Lvl6K3xu+8wvmwQ+u2OgIv0OIVw6jm3eUI1lJSs9jI2T016K/83k?=
 =?us-ascii?Q?FExaUUYGal/ymIHh2hG58s7AWf97QQaO4U0ZiXKR5eDL0eByUDBHT5dAeNEa?=
 =?us-ascii?Q?I/Pu/GrIUJHbhfQyyvRSr1mBAajcJVe/tyDaQYwdWg3hhgLw89OQtmzb+5QP?=
 =?us-ascii?Q?xgR2OrlDm7DlTkbmD8dGwaM1OObEiIgxMecGtCPSq+U8ZM3qtCeTMaEc5dIt?=
 =?us-ascii?Q?X23pHNbRDu5zguw2BPLeVnz7nD2+x5218QTzi1yHMPGVHh7o4I4bBKK+33US?=
 =?us-ascii?Q?pJhczYWCLny07pm/eZi8BlFe7ND34uIURl7CTcu4XesiGfvIsnG7dvITGxHN?=
 =?us-ascii?Q?fbmNaRnOdBU0a9CCEAheVBE1xU8rSH1eKGzNBjXsIGVz3zbtBJA4IjG4YxDi?=
 =?us-ascii?Q?LM4b72MYGUann4Wgu9uYHDGk+haVFaU5OYX0bckhzwFw2A0o7JXYuW5RXfRq?=
 =?us-ascii?Q?UkU3RMz8JRctbernLYcC9xJs5jGVQm3FQa7/cGw7xSBTREwU5FHYM7zNWx3R?=
 =?us-ascii?Q?4rp5ZMhgD7TSxTnrCVf8Minyb8Bm9TARRTP52U0IfEPmhhkFmGUmrRLRRNpD?=
 =?us-ascii?Q?HYlljd158F7qLjeaMW0FbkeR4/eDlk4dSoVl3Ha2PAYcr9XtFJe9T+U2wSQK?=
 =?us-ascii?Q?wnmeWBIgkpLa3aFNMQUr7lzJgiPDhx1gWy6W7vt0E/LHFuVyNxIpATMUCuGC?=
 =?us-ascii?Q?VXgWEtCSh1jEQtaIK/KLZjUapsMdWBE6jxd7HyjzNFhtg8x/GJh0PL3HtxHY?=
 =?us-ascii?Q?eqWAU19cWdCFLWNXTXOPE0Xygm7rPiXJrjHbTvoWUDJFLaqv6zWG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446c93e8-a68c-4c55-6448-08dec8c6d6bb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 21:09:06.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzZL8HhJIu1HYXBhkyyzo6L50kgvkd9AT/0ZPcWZ/ivxgtN0og9uVDg5J/f/R9MfhgDWXghkDJiFOjo/ZeqRPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10969

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
v1->v2: none
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


