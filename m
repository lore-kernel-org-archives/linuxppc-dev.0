Return-Path: <linuxppc-dev+bounces-24435-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CA1C44512
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 02:13:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3PFF3Wzhz3bdq;
	Mon, 20 Jul 2026 12:13:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784513601;
	cv=pass; b=jtCtnGgD7WtG1SZVMuChEbsMZjNrN278suG5sax/Qor7Ro9sDGr5idKPyMH/k0tNnMnR7NXjebe8xB2sylfRyhhZc1P3QWRKfza+kn5pUs5G/u7ALedg2ItZ8NCS2+meEabL/rtOP9S2TAKZFNGdG0dNugSAAf4ruRWSYj7DmZvnybL3CBLl/fo8kttqIQziSjJGZ38q0103vPUO6fFo7SxFQkJcim0S/5N78kx/fE6iMtZGr1j3ArPjecTsBNOU/idHsfdkEJ2eS0uEjZ9BEFVTG8E8UMkSpxs+MJYY3SNCEmhItMhspPD2aahhk2caG4nB0yg/mWTenv7LEZsxVQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784513601; c=relaxed/relaxed;
	bh=8CT8bO+ZvGjCsF5hZO2ObMW4OE9iaBDYdR5oCZ9JbCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OX5/6OZFcbrabvMGPK4M00TsWFcrly+R9z5ib2q+V5qLBd64zvcnXhsl20xQRG8NV+DHxDV/DsKuSU25HcFXpnOTjjBHO65mA8lEvRVlIJXwTpgdRqQe07l1Jpu94V+DtRkEuq3T7J3FmfLTgPnMthWQvkrEgTl88dMCnXbNybmRRF96+hwjDzmsp0pF2kvAMGrDT1J0lvhjsEl8qP7QkIFpbhn50KDco/gvB+oKfCG7slqUrKYzbwMiDoL5wYDBSkPgNEZSfvO/MV82+PmDmVZ+AQY/nU5dnwEaCbsk6Z70HaI3Y68YCYRtK8va48S3j1dCDZPIPmu15liRB2pCxQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=r6ORhOWm; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=r6ORhOWm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3PFD3r4jz2yll
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 12:13:20 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8WKqyBEIt1MAsKlyBA1ZUFZ6kE283uwW1ep78vF7pWuC3IbKtqBzj3VXqB1IH4PEg5kAB5sh79iW79M+HLPhV84ld004rcp+DCV1ajAJQ3r+P5xJG8nOXvO42gJgKObSugEXq0DETz/MYVnhX9G9bBzfb4vwkeAWodKEvqGealiFbXF65KuWcP9fhCRpU332vfhCl0OgA8jJSgsR5z/SHv5BzMCIcaqtK2/BK9WnKiaz93TDHDurIMg7cvoQubijDCWP5kfZAU33Npef0GlVRbUZXJzvGrTEcMPrvVvG0Ob2+RXDsNkHKGrD++u6c/CWFJPUr2TASEl48evbhpyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CT8bO+ZvGjCsF5hZO2ObMW4OE9iaBDYdR5oCZ9JbCY=;
 b=aE3OC9hYmNVIh3PVIrDClVPUf56H9FR5qrefDsvM/+BLjO9HPWd/5o8088JuN13Jp7JVBKXla+mXbsS2x9Zov9HIxHWE4cVV8lQBR98EAa/xVo/FuRGoe9z7Zbp+0/PYbBwT5sOYykaY7zcKBLvs3ahlF9Nhy/p42pgQeMadQbY0gmvJDYYuOgwA90tomT4yu5gJSKTvGGWlDMcP71kR7mmvK7gN/x9TrjmUKEO1YKGR7kRoOC6fExAMoYa+v6jlulqnvVB1pRiJOMwIxiABMuUsxuW4ukX2rIkrVeDJa+qFR89bg7plTSrRTJa+ljzWtg5B7INiJx9tA6JclNquOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CT8bO+ZvGjCsF5hZO2ObMW4OE9iaBDYdR5oCZ9JbCY=;
 b=r6ORhOWm+t+Vdg237I4gs5Zwog5X/6OmAvgGpKmGDCsx8edbb68i/kswG13eRYe8Dd6OgWib4hX2bbFGOMBqEAnEh+5VeDHWzgGBhB0dpyvVZSvmxCLtSig0JV/PuCz7G8u0ylxATC5K6qggRCoj5UqUThhI1kFjutlMZsx+toFvpXU56Ikpw4CqWz2xPME2wMVRfQdyuHjSGOZQ9v5EWt9Tx75uu3pdxpChlRKGANoyU3CEe6JZ+nSTpHSnoorncanyXMQS1EZHcvGzJjFRtjyGEZWIbGkdh5Ply1LCgYdvjX/1AwovrcUzEz44EVccgPpdma3dBvnmAquZel2o/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10872.eurprd04.prod.outlook.com (2603:10a6:150:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Mon, 20 Jul
 2026 02:12:57 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:12:57 +0000
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
Subject: [PATCH RESEND v4 net-next 10/14] net: enetc: refactor SI VLAN promiscuous mode configuration
Date: Mon, 20 Jul 2026 09:43:12 +0800
Message-Id: <20260720014317.1059359-11-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0296.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::7) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10872:EE_
X-MS-Office365-Filtering-Correlation-Id: 84074053-382c-4fca-771a-08dee6046a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|921020|18002099003|22082099003|6133799003|11063799006|5023799004|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	0RNePVZNjiGBt53m2vBoNzsRf+3Mnr3sNdeqApbd1qvLOp2BTouQFX3MIsu+rmawAf05bvoHA9sTogIa6QRHryaxR/+T1MqvLnbD+Flm6kDS8jIC45qc+MqugpZW2B9C00pqav/GX4bPutiYXx9+JREIsiyH5APcUuPX5pNtNCdU+gAhPGPMoLwom9hlyXUuoa2zsPQokdfeY1i1aO3gk2i8IRhiBQ5Xz0Hl6HQApIAf+nBHve/qYHiVrhuRRoAAPm4Hb6oLoHPmEkvOKqYwv0cKzn1MGel7SuoqRXk1oP8/8VUIQYm8XiCY7xDFRGu4isXNiYkAiU+rUHQwpM6KKMBsf9R6kRs2nahcbyvPwpioISh1xzcm/nCAIqeXvhirCFxaJcVO77iWs9VPjHozZ7xYlw0SdO0/3Vck28v7wPEZMmDA++0astF5e/tXJhoM18YxHPZEc65WpHWEXl3oZrs8ywfVzJ6SJNje1A7lbw42AkK97qe0ant57Ov4KAXt3XZlhClwvoOaRZ9/lbq8yaVUnOdU6DSVG7cX3OE2dfW1FmFs4h9/ii1GLBy3FHWPixc2jCipaVNOjV2LiUy6hb+8PvXyM6O58N1yWrQwjiVmFAOxf9Q+WJu0WbG3le6KTjNEo5lb8k6dqR5tpGcSsBRaUTMJ+tdrgPjW8WxwPpK/f5RRBnUEsSCsKjpev9PBfHmX9t+dOGOaKceRbjVRzA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(921020)(18002099003)(22082099003)(6133799003)(11063799006)(5023799004)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ay2YpSzwvJErIX9MoWdTGrBp6w/dYB8ZNXMCxOWGdlih7298ImIdS8lmzrPY?=
 =?us-ascii?Q?rItD4g39qlKJwCTVuVADtqrqQ+k25ighRYiUDqAg1tNGRtXFySNtVmKQV5Zl?=
 =?us-ascii?Q?jGcNIgkWsuDjMuYSC4bqwboTCy0hdkMGly41nSGYiW8P2lS/JHu2oCQm7N78?=
 =?us-ascii?Q?McnPO+hJSy6EjMeHF4bYWHYQbf3eE/scknERUhfLlFcDJ4LbadcI41S63QfH?=
 =?us-ascii?Q?YLLFdU7Sjc2asLLJxBZxSQhtDxTD2v3+praj2ODjocg3I5/Dvt0mH162p086?=
 =?us-ascii?Q?zHqYM+D6d0RUaFrYZ89c1DMb5S6RBdJLV7MpEMRyn1f4HlZQUWZL5ecudjZv?=
 =?us-ascii?Q?HrDcI9IWPax81hMIl2dEfsl23kjgg8XcHqcqNlNfC3DMLm5IK4GP7G9RM6DB?=
 =?us-ascii?Q?ZOdjuaVq6wJlXvlBjtP7tasAUshwcSvvCunATDml2fe5Df/nko4uXrNw3aa7?=
 =?us-ascii?Q?fmGzDgQHxOKEcMRsKo5nPTN+JCLB1nliA8bZ5SSzqtsw+Q6oYNRX6iCq7Sfi?=
 =?us-ascii?Q?im2RUnoz4YWT5bvbWjlUh5uNqAWC74Yd7VQxTeakA/uwG0XNxQhea2sf7iqU?=
 =?us-ascii?Q?yGXDL1oByx+jKras+F8WGXd3EH2mRURTGT/sLd+wkInG8A/2NPj52Onz7KlK?=
 =?us-ascii?Q?oN2Llzkal1iZqlSHOxiVcHanBYDAezqA57KFDVUES68wxBW/CORe1vlPOKM7?=
 =?us-ascii?Q?D+3x0aTt3f8WNsjUsskxp7NOpqadvB0PrAw2CfwA+wCAqIptdTpN8OaVTM2j?=
 =?us-ascii?Q?Z6XsNOANKohSMczqtb22VIiNl6K8palvdjf3WZvSbqX4IdVFBtx4puj3g0+Z?=
 =?us-ascii?Q?t43yM6EiQxuL1i7uGhR3rCv1gzqUNM81eiZZVkoWjk3KBwPtp0mOVBTqEqzg?=
 =?us-ascii?Q?xsTE7gOjokO0FpzlPao7zp8xeB6BjA+W+cTFVYnq22IrMvcEC5T1RQNbzvGC?=
 =?us-ascii?Q?K4kvPdbSXVU3xkyk5OwAjVUxkM6p1KBcXy3ck0uPpMIFWU0UQcrs4MOX+C6q?=
 =?us-ascii?Q?z6wqfUAvlq42ycL87LB0MkqPV40QKSmsQ/jlLqLieva0QVDO70WRw01fTAeA?=
 =?us-ascii?Q?g8PpXNczvO1S17G1gN89mz+0Aqt1zjggpXpi0i3Vz1jreK9tUKL1BQurPsJv?=
 =?us-ascii?Q?ghACuDC7Hlnd8GLbl0xsLGNdnbNLhCXwFVuRDiUb8NV2Cx9cP4RrujIcy/0J?=
 =?us-ascii?Q?5Qk+DxeIikRGnGz29FP/LOV+P61bbG1v9vMG1CoQF21vuKAHjXmwg99NrmcI?=
 =?us-ascii?Q?7xQPQVpmt0eUpwtgQfUYhryS2XwLkYzyG1+yBt8+ZHJkOTm4vIFhBeD9Lyj0?=
 =?us-ascii?Q?/vpEPFiBieQ5cYYLTI/cfvC5UAurpC9yxdDqUbwZNS4laRVNjSDo6NmblOin?=
 =?us-ascii?Q?jjxTgHoNATkQnzPW9lh/gVKUjh5ZX6fN/MrnkGnfxsBDkY1VeO2msOB8+9K9?=
 =?us-ascii?Q?10+txXSBGUxAx9AYyzWRcm7dMxQcywGTiWSIBmS7omwr4eaMmb8dRymX5Ebh?=
 =?us-ascii?Q?dqeLI4HPslOyYk/51iqZimnClVO6ba+vwmwm1OvyWOq44bt59nI34tKfqzIY?=
 =?us-ascii?Q?xJLDa5+CHxdd0agVnGGrHXelkkzTD7NEfKCf3X8d/IT4yb9IDuIKjmOq9rrX?=
 =?us-ascii?Q?RmSnMEsiUGgkf/qrzmC5DftxK/9BK5l9mi6dRUgZjn2DglFOhBql6Jfforwr?=
 =?us-ascii?Q?dY/z/WwlQ4zzoJ8Q3u7jrMSB3JuG2w8l89UhzyjHMKufDce69g9QPf56dmHb?=
 =?us-ascii?Q?1SUzlpEIaZCjNU654g0FP/JOTboNy9vCd7sGG4GSyJW4TAambe7d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84074053-382c-4fca-771a-08dee6046a37
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:12:57.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kgGztOHFtG7aJR/eoyX7+0JXZ3KKeLDkLYursTXcgHKbqd2IsR8ELSDj6a4WGqau6RiG8sMJ9wn1P7p6SGWnnA+AqECd9/oGTgkmMTMsj5eu5qALZRiRFQjGZeU+eNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10872

From: Wei Fang <wei.fang@nxp.com>

Remove the enetc_set_vlan_promisc(), enetc_enable_si_vlan_promisc() and
enetc_disable_si_vlan_promisc() functions, and introduce a new unified
function enetc_set_si_vlan_promisc() to enable or disable VLAN
promiscuous mode for a specific SI. This simplifies the logic and makes
the interface more straightforward. The vlan_promisc_simap field in
struct enetc_pf is no longer needed to track the current state.

As ENETC V4 only changes the address offset of PSIPVMR register compared
to V1 without any functional difference, enetc_set_si_vlan_promisc() can
be moved to enetc_pf_common.c in the future with minor adjustments to be
reused by the ENETC V4 driver

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  5 ++-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 36 ++++++++-----------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 66bfda60da9c..16da732dc5de 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -185,9 +185,8 @@ enum enetc_bdr_type {TX, RX};
 #define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)
 
 #define ENETC_PSIPVMR		0x001c
-#define ENETC_VLAN_PROMISC_MAP_ALL	0x7
-#define ENETC_PSIPVMR_SET_VP(simap)	((simap) & 0x7)
-#define ENETC_PSIPVMR_SET_VUTA(simap)	(((simap) & 0x7) << 16)
+#define  PSIPVMR_SI_VLAN_P(n)	BIT(n) /* n = SI index */
+
 #define ENETC_PSIPMAR0(n)	(0x0100 + (n) * 0x8) /* n = SI index */
 #define ENETC_PSIPMAR1(n)	(0x0104 + (n) * 0x8)
 #define ENETC_PVCLCTR		0x0208
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index db2a800a7aaf..afc02ed62c77 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -42,24 +42,20 @@ static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
 	lynx_pcs_destroy(pcs);
 }
 
-static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
+static void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id,
+				      bool promisc)
 {
-	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
+	struct enetc_hw *hw = &si->hw;
+	u32 val;
 
-	val &= ~ENETC_PSIPVMR_SET_VP(ENETC_VLAN_PROMISC_MAP_ALL);
-	enetc_port_wr(hw, ENETC_PSIPVMR, ENETC_PSIPVMR_SET_VP(si_map) | val);
-}
+	val = enetc_port_rd(hw, ENETC_PSIPVMR);
 
-static void enetc_enable_si_vlan_promisc(struct enetc_pf *pf, int si_idx)
-{
-	pf->vlan_promisc_simap |= BIT(si_idx);
-	enetc_set_vlan_promisc(&pf->si->hw, pf->vlan_promisc_simap);
-}
+	if (promisc)
+		val |= PSIPVMR_SI_VLAN_P(si_id);
+	else
+		val &= ~PSIPVMR_SI_VLAN_P(si_id);
 
-static void enetc_disable_si_vlan_promisc(struct enetc_pf *pf, int si_idx)
-{
-	pf->vlan_promisc_simap &= ~BIT(si_idx);
-	enetc_set_vlan_promisc(&pf->si->hw, pf->vlan_promisc_simap);
+	enetc_port_wr(hw, ENETC_PSIPVMR, val);
 }
 
 static void enetc_set_isol_vlan(struct enetc_hw *hw, int si, u16 vlan, u8 qos)
@@ -441,10 +437,9 @@ static void enetc_configure_port(struct enetc_pf *pf)
 
 	/* split up RFS entries */
 	enetc_port_assign_rfs_entries(pf->si);
-
 	/* enforce VLAN promisc mode for all SIs */
-	pf->vlan_promisc_simap = ENETC_VLAN_PROMISC_MAP_ALL;
-	enetc_set_vlan_promisc(hw, pf->vlan_promisc_simap);
+	for (int i = 0; i < pf->total_vfs + 1; i++)
+		enetc_set_si_vlan_promisc(pf->si, i, true);
 
 	enetc_port_wr(hw, ENETC_PSIPMMR, 0);
 
@@ -466,12 +461,9 @@ static int enetc_pf_set_features(struct net_device *ndev,
 	}
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
-		struct enetc_pf *pf = enetc_si_priv(priv->si);
+		bool promisc = !(features & NETIF_F_HW_VLAN_CTAG_FILTER);
 
-		if (!!(features & NETIF_F_HW_VLAN_CTAG_FILTER))
-			enetc_disable_si_vlan_promisc(pf, 0);
-		else
-			enetc_enable_si_vlan_promisc(pf, 0);
+		enetc_set_si_vlan_promisc(priv->si, 0, promisc);
 	}
 
 	if (changed & NETIF_F_LOOPBACK)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 7e886dc49997..1bd3063a3be3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -45,7 +45,6 @@ struct enetc_pf {
 	struct work_struct msg_task;
 	char msg_int_name[ENETC_INT_NAME_MAX];
 
-	char vlan_promisc_simap; /* bitmap of SIs in VLAN promisc mode */
 	DECLARE_BITMAP(vlan_ht_filter, ENETC_VLAN_HT_SIZE);
 	DECLARE_BITMAP(active_vlans, VLAN_N_VID);
 
-- 
2.34.1


