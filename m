Return-Path: <linuxppc-dev+bounces-22297-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375E2CD6E79
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 03:27:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZDqX5jt5z2xKh;
	Tue, 09 Jun 2026 13:27:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780975640;
	cv=pass; b=m3Rr7Oei0nC4+mfxoEJ9Z3V9rR4gUavWp45gQ8RF9xQgaAOzqqp7B7emmeUStsLjTBVeBRVt86BZQsbl+R+co2+spkBGETRuBeD0qEeCzSaBYDHextC6B/LDqUzCk+z6tvBaA4XBkgEiA+KLmdRmeTOxXywOJtj3gBJN/j24bDTy9ntGFSnKCSTZrUMpFPhdehRb5J+EkogMhmGsAFozo6XeWy/poymzvB6z6bCqpayt0ikMuhd9vieK3hC3xn164ovOfqSjCr7Ij/wT0kHMY2evwQsvq7vjdTla3I1upoC3qZeFrf8geFRlCIkRZugOFKHt61EHLjh8xDf7icFWrQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780975640; c=relaxed/relaxed;
	bh=lAUhzvi8NbszROiGJ3s8aDYnWtzWcAo7Drdl7nvwpbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqGOf0lpA49ZhzI6ZLun/0GJPmiHT+ccLOdeHCCtU5O1puIIw+Ps8rfjn3s8fMfgB7bRrDykukli0GDcMMbbEo+Kha7fhQDG2bp45OeP0crKZPbu993nYljE+I9zNXIm7gqAzHwnhjVLoaRPuMvm4qxcygORM53djQ+H3gYOTqq+iN1IxkgQS+UjMNQAlcWMWXjhwcYu9DBYSoQavtT8C6UpzOeGSP4L8Ex4UHR+PHIncpDopV9+66TvJi/nqe16edEaSl4prDjhec/WhMnsUp1+8UqMuyRXGFwT12T/6gjSLEVZo798D4c1HDbBO5vwt/s5CfmNc+JJ4TXZSj+E0g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fJfa1nBd; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fJfa1nBd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZDqW2G9nz2yv2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 13:27:19 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGxxeqD1fCos48BeuyOjf/KUoHQ4J6aNqWCLw2NC5qXpaiabYrEr1USQuTqcNEIv4fiyss9bRGfORwTeMDvaRXWRb41mGGDqaduA02ZPMj+1YNAGxiE8lyzTH+0J6mq49+0pZU6BojpnyhupEa8bohpzlxAWldvcUOzRK5hdro8vLeeahFeH06DudcrOmKEVCFCl3RBc66I5Hx7WE2OtD7Ynw93SpvuhrnOp+wS+6wX09VCsg+xFF1WaxFkTLio2ZKwlnUZAmpv7IokGSlP6dkvTFoYOTHuJAS8yMpyplgZhK9mlgxoyE5T5Ii2KAyWzWz/zC88auwaDJJf/8+eL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAUhzvi8NbszROiGJ3s8aDYnWtzWcAo7Drdl7nvwpbU=;
 b=XC12WK0u0uSvVc1vuVlVqGN07Q870H7L8NSEX38PbLUvmiT1Nwk4F7T3pUU0cb08BzDvBxU5Rbr09Kx6VHbsl3qkcM0GaZoVi4S7NUD/WWdlZjLPKnlksZi8ijljoMMveYLe8k+AjfXk0aUFs+2op+agrE5FWMNjN/rf+qQJwBnsoz1ALgZ3gxpDQILuHXi2mVigl3aSp7iiVH+LrhPUQkkq+eIGFiXff8xbxk5JyJhsriM34vjKW/8ddcFLAQyIbmOrG8IqZTqJ96UuGRdPTbOwJg+dTtEeZBJAMilhekiPa+ORDNqCvu6DgJ1iXgvXuHQP2Ci6YJ9gXldscOMDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAUhzvi8NbszROiGJ3s8aDYnWtzWcAo7Drdl7nvwpbU=;
 b=fJfa1nBdJpthnW5nWgYrgYmtclz+PzNDwjgMKzhj8SIDTpjXz6RInMeJaWv0B1btmy73EgT0qoK+yoIPioFjtBbZIHnlOme74AxF0UuOnERLFiAMPEBETBbV0sh7VJHiCbsWq0FqtnMhgfO+PNolreCZTWdqRAD7iT49LsFNOtx8tf9nBfIZ+eQrj3wztMaUsbmJSoSLKFhtZBK8aOKBQZ+SLd925l+vgV4quJBSYkv9w2YAnDI2Owr3x7CurPxoaY+0rr/lpIu9dfy7tx7oU2L+dpQUA2aJcOeBLlXwAaW2kxpJQWBJ13WkKugfHcDXsZrBbsBeG3qTebfF9jxViA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 9 Jun
 2026 03:26:57 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 03:26:57 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 1/9] net: enetc: add interfaces to manage dynamic FDB entries
Date: Tue,  9 Jun 2026 11:29:47 +0800
Message-Id: <20260609032955.2066089-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
References: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0197.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: f38d5602-5045-423d-79ad-08dec5d6f5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|3023799007|22082099003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	mhWdD4MIkh0K/syWyR0Nu3Mtk9C/pXqxGTvMkJMkJIhZl7HHMvtawYyu7CT4A4emB1r4E/t9y+08thw+Rgwib31a/nmeGdpNCiXCRcfCEa6Qav3OoedTlN3mWDIZdQGrQTVvy/6GU+83uaL6P2zP7o8VT6HyQe0oLAuWIBEULghgVtyBsXcUEJX7hgFy/4h7D61NWEwtiG11HTxoPlBa92FoMPssadZr+X04iT1eTTN4Bh4DsZ5tij9TZpduBJMD25tOL0peiJy2GjJ0SkCpywhA9Kw9UGCssMSwvLwM83/tD27JC062mGCE0yt7IWAqF+B4eRYdA1HHw4juttS2HyVabLmLhzAcHMrepXjaGH7bmQ7NHU/Z7eLKfSnIjolP3FIfCpjPJZCLiIU39pLs7/u7H+fk9P/PuCBFdtPGo7zXbb2GJljNSIw8fd8hLLbj05AVs1cLzkGva/ltXvbb9n5bhAhpMmXx3wV60mSP+daNNCTzQqPmKJsfnc9ecGUzxLEcusu3whVvyq52hrzLYh4FcqU3e4XqRJfjdaaq6Gv4lwb9m+fLC/FMB4Iy+3/D59BRToAiMsKGeFd9vuJbssBJgQgYEVlEXZ/uYbeipzBdULC4gEb1aOeoXyBZl77W0OTpvDCZFGxl0GApVowynh9TW0j5idKI8afogyvnO1P2yroeKhOzMA9dqdkxQuzsM2vi1XVg/gH+FlcHURHAwQuGB63Mhn3+7jIaTBRh9Gk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(3023799007)(22082099003)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SMjyBmlMv1NBDq70sUBavO+caZeRWHRafPVFKvjsYJ2SUdkH1ZWLdUMifjym?=
 =?us-ascii?Q?+27Eg3EkWH6xDEDoFnAWAbP3dfle1lKdyL4L/aF27kQOSn3wdoHRznzFu7YK?=
 =?us-ascii?Q?+kkAnx59MEwzGNVbwNQ2ToarMo2odvzA3V5fMIfxT+nxv13OGvHuQmpfk1CS?=
 =?us-ascii?Q?5kf4klAKChUOb3mTO77J/hx7nKzZ0JW04ycr1n4PX9+mQmRgcSPkQbc04Mnu?=
 =?us-ascii?Q?9ke8c2zihek5Kb+KWAwN9dn8ZTQ3M3vlwhoDQgVHSiHnAPifep/nyqkqbYWX?=
 =?us-ascii?Q?1EKzp6KDgjNbdjiQh/LKNzz+3WkDY2ZDLMbtW+S5d1aGBIOI1kBHsioQ6lt3?=
 =?us-ascii?Q?/xKfobEBSSiew3Z2WbD8lT2tgmR67XMIV62ttXElPYs7OpTcooYUFygdYQuW?=
 =?us-ascii?Q?7LL3QZtOhE6bVTxriVEYISyOcCtKpGxWEhrAdj3FwCocTaOn2x2u1gA9RdYB?=
 =?us-ascii?Q?yLOXti5qyl/Z2y57mF0sitAf6wdpVzLAU1Hb6xdKqTna4I6J/EhiAD5rF4gc?=
 =?us-ascii?Q?TPFBOnECQlxPHOKewkGgIMnpvEx75LuUw1yYMvcrBhMU2EMecku2SKatzXwh?=
 =?us-ascii?Q?Q13yvZ32sMxsIZ8u+jbckMuqqAP6IgT0S+MxIme6Hsy68+IKv081k9emHP53?=
 =?us-ascii?Q?jafTjHx0yCTAPT+JUDlAjWVWIcythkpHMLSWng/vDPu2UR8zKiWF63kIATyg?=
 =?us-ascii?Q?aCkqK1OvfqrRTzLqqvsn0AyHxFjU9N9Mm4JvaqJh3Ta0GKffylnKxBVdJAxN?=
 =?us-ascii?Q?m4R1D2LrvwUxCdY2Htss6OLRzbt1O9zNXpDbC0od387/GnaxGeBo4Ado5bvl?=
 =?us-ascii?Q?DYLAHfd8qTuoGODjLUHsR8taz3xVLiZYefognCxxZKZTZKXH8IbAue2aF0jF?=
 =?us-ascii?Q?yRiwJLTUkiEDIIy+L60x+3CBkVkzN2YfINd/BS4K/BL7DDwBCPDO4dlW4E48?=
 =?us-ascii?Q?6hZ4Oyp/WEJqYrTLJBiZGLiaWtIXIkIJApsRt0WlVjLuV4GDQlp5QCXUR/lc?=
 =?us-ascii?Q?8kX1OrAlWRvQT6XeJ7GQMnil+VYPrw1yz8l6TjerJcEwdWASoiH9G/QbnJOr?=
 =?us-ascii?Q?3vxJ9zNSbc8q8SeMpiKbiR+z6kwu8G5TwJW+o1Rw2hA4/YtnswDvzxzUtFJC?=
 =?us-ascii?Q?RksCx1xPJ3JAxBBxG4mDNLiFhRZPBlnbxg/vocHLJuFB6xFx7OorNdunwEAC?=
 =?us-ascii?Q?tnzfLa9K7jaZ2LhIZKMVswMaOFKDHlbPZTjhzsx3fvZd5DerxESRV/PNKsNx?=
 =?us-ascii?Q?nCMeGUWQZpD67fFx5+hSIJDV5HewtGhto+unWQ+LXQ5AJtrXmONDSZssXHRe?=
 =?us-ascii?Q?Hc+MLYN2AYCF1U+DhrdlCyJMxQcKmwSSOjGBwUCKNZ7EUsdo7JP62XWad7XT?=
 =?us-ascii?Q?s/dlvGhQcWGvvVBS+JsagcmsSZh9XPGBGzupUxX2fbTMOOrfpHL4qnyq8g+u?=
 =?us-ascii?Q?QShcgH2dCx/i+w1bOKfQtyz04H9XCpC49m3dsqrJUdHUAHNNuhG5yrWby5vJ?=
 =?us-ascii?Q?vjaaMiFOEM6qG9i4Uccgch3tVnUavRCI70pqHtaiI8if1a8Ka+r1Ty8KOgSL?=
 =?us-ascii?Q?tIdoua2Cd3FuwK8/Y77xCQRV779NLkUD2a2pxFkyCJXG1A1SXFv+Xy0qEFJj?=
 =?us-ascii?Q?4xPIywhrjLpZJBvBcsPqURE/rv3QAZW1bY9AInFCwomsRqcT0eevT2O/zm8t?=
 =?us-ascii?Q?KzmczjttBN1auMy74D5WHjRRhB0qcaRQs+4M3Mdsou49VVOjY7m/Wc7a2IiH?=
 =?us-ascii?Q?jus6l3W7xyHbzftzIylV9ys5GpqavpBWvbA8924DhC5OUbRs18SH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38d5602-5045-423d-79ad-08dec5d6f5e7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:26:57.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjghg3mP6ynuLnhQXkW/8ufb1qEGUNp+GLP7Onp+SJGuWN1uKw+QgjykHDfLAcxJ1kZDetz1YZ+AZ0iqnG0eSnK19fP4JH8PsljBI6kyYNP7NSn62J9CKIf3p7usvWvp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946

From: Wei Fang <wei.fang@nxp.com>

Add three interfaces to manage dynamic entries in the FDB table:

ntmp_fdbt_update_activity_element(): Update the activity element of all
dynamic FDB entries. For each entry, if its activity flag is not set,
which means no packet has matched this entry since the last update, the
activity counter is incremented. Otherwise, both the activity flag and
activity counter are reset. The activity counter is used to track how
long an FDB entry has been inactive, which is useful for implementing
an ageing mechanism.

ntmp_fdbt_delete_ageing_entries(): Delete all dynamic FDB entries whose
activity flag is not set and whose activity counter is greater than or
equal to the specified threshold. This is used to remove stale entries
that have been inactive for too long.

ntmp_fdbt_delete_port_dynamic_entries(): Delete all dynamic FDB entries
associated with the specified switch port. This is typically called when
a port goes down or is removed from a bridge.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 162 ++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |   4 +-
 include/linux/fsl/ntmp.h                      |   3 +
 3 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index f71cad943424..bda26fe93b8d 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -31,6 +31,7 @@
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
 /* Specific Update Actions for some tables */
+#define FDBT_UA_ACTEU			BIT(1)
 #define BPT_UA_BPSEU			BIT(1)
 
 /* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
@@ -793,6 +794,167 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 }
 EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
 
+/**
+ * ntmp_fdbt_update_activity_element - update the activity element of all
+ * the dynamic entries in the FDB table.
+ * @user: target ntmp_user struct
+ *
+ * A single activity update management could be used to process all the
+ * dynamic entries in the FDB table. When hardware process an activity
+ * update management command for an entry in the FDB table and the entry
+ * does not have its activity flag set, the activity counter is incremented.
+ * However, if the activity flag is set, then both the activity flag and
+ * activity counter are reset. Software can issue the activity update
+ * management commands at predefined times and the value of the activity
+ * counter can then be used to estimate the period of how long an FDB
+ * entry has been inactive.
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_update_activity_element(struct ntmp_user *user)
+{
+	struct fdbt_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, FDBT_UA_ACTEU);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	/* For activity update, the access method must be search */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update activity of %s, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_update_activity_element);
+
+/**
+ * ntmp_fdbt_delete_ageing_entries - delete all the ageing dynamic entries
+ * in the FDB table
+ * @user: target ntmp_user struct
+ * @act_cnt: the target value of the activity counter
+ *
+ * The matching rule is that the activity flag is not set and the activity
+ * counter is greater than or equal to act_cnt
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_ageing_entries(struct ntmp_user *user, u8 act_cnt)
+{
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	if (act_cnt > FDBT_ACT_CNT)
+		return -EINVAL;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	req->ak.search.acte = act_cnt;
+	/* Exact match with ACTE_DATA[ACT_FLAG] AND
+	 * match >= ACTE_DATA[ACT_CNT]
+	 */
+	req->ak.search.acte_mc = FDBT_ACTE_MC;
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete ageing entries of %s, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_ageing_entries);
+
+/**
+ * ntmp_fdbt_delete_port_dynamic_entries - delete all dynamic FDB entries
+ * associated with the specified switch port
+ * @user: target ntmp_user struct
+ * @port: the specified switch port ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port)
+{
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.port_bitmap = cpu_to_le32(BIT(port));
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	/* Match CFGE_DATA[DYNAMIC & PORT_BITMAP] field */
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete dynamic %s entries on port %d, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), port, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_port_dynamic_entries);
+
 /**
  * ntmp_vft_add_entry - add an entry into the VLAN filter table
  * @user: target ntmp_user struct
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 0a9b87286105..ad532b059ba8 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -155,8 +155,8 @@ struct fdbt_ak_search {
 #define FDBT_KEYE_MAC		GENMASK(1, 0)
 	u8 cfge_mc;
 #define FDBT_CFGE_MC		GENMASK(2, 0)
-#define FDBT_CFGE_MC_ANY		0
-#define FDBT_CFGE_MC_DYNAMIC		1
+#define FDBT_CFGE_MC_ANY	0
+#define FDBT_CFGE_MC_DYNAMIC	1
 #define FDBT_CFGE_MC_PORT_BITMAP	2
 #define FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP	3
 	u8 acte_mc;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 88166f9ad3a2..5db078e1caa0 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -263,6 +263,9 @@ int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				u32 *resume_entry_id,
 				struct fdbt_entry_data *entry);
+int ntmp_fdbt_update_activity_element(struct ntmp_user *user);
+int ntmp_fdbt_delete_ageing_entries(struct ntmp_user *user, u8 act_cnt);
+int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
-- 
2.34.1


