Return-Path: <linuxppc-dev+bounces-18224-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BFEF4643A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 09:41:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ9856bTsz2ygl;
	Mon, 16 Mar 2026 20:41:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773654069;
	cv=pass; b=YP87ypepgOwy7W9grZhkVs21shO7JVS/qzlVUpv0XmCToOkHudnp+AvtlteA2XlSjmr/RkiWc8SgMVice0CIEC2jca7W5Xh5dXuGMD+S7Bvu0NSDGhETqG2unJz+SsNbKLtBeO1Y9u3NOJ9SKsIQFs0PkjP1wzKRMZDfq5VM2CvuY4I/UvhhbMiQGX8H7g29bu4669Ea/GNmlf5FxD9DX/n6JmBDz2f6HOSi84jwEbVXju+J4cZaBR3rrteN3mMxtB0fnOPQjSr0yM7X8JnsR8m6yo8Pk7PwrtQTo8rdGrS32xaYphg+E6zuupmQUP0SsjMBF4QMtMHQtULMfD0SmA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773654069; c=relaxed/relaxed;
	bh=tziJeOEw/BS+e7YU+4V7x/VXYezCf1g2NlxkGwA58ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cAc0/Bo+KMEM2+e+XvUBB0xgfsjYDl4/lsvjk+LOsaMovvG2PAL0DmjHvSaEp46ZOcwroFRa6JsSmS2IKhepzf7nuM4J7c/hI1/bC9QJ9uDiBb8ErEJrK2A81/vG0tvg+KmKCxA5QvG86yt0NS8eLih2ovnrDGML6KRNtBh1ubjb+eC9A+BYad1fofsGmQAwJ7p+HYuL+44HVQ2otMerVvrP4He/nDkjUEesxG9Wm0BtaW1enJNR1inGtDc8TU9DZdiheUGKsnu6BQ93VsXsajFSzto0jTvV1s2+ZbNWLr8nzBXYE4DPCYoWHaYXGeJVRkNP+dPbJnI379fyDo/V2g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Hn2ljKWK; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Hn2ljKWK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ9850YZrz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 20:41:09 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYzdmng6FBfXycTawqfAcftzO/hxxfiuNRMEy/39KMRlmtJU6CyIgTzXnmf8ePj33rYRoTEB256Nwx3TwYJGuh3VRop50+fGmP5zHeYtx3sn2EEFEuj+sugihY+zN839b8C7xFEEe5RX1CrRv6kiEKZImsqSS8tZfT1Pna+vPeA8Zm8qWcSYgcSbUQYDY5b9FU9LzqqgnIMhpUQcEZ3JowxfZWQu5lX6dEw4B0rGE7s0oqHv6oZEkKT86RPe5WL/luIecmJgyTWK9LGVSf1lQEDbS5X74BPk86nLxV3rw86kXZGoHr818Zs5KNknLwgM7rfboAZUDg60Pl+BVamT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tziJeOEw/BS+e7YU+4V7x/VXYezCf1g2NlxkGwA58ng=;
 b=dMe8n38t3wpMA+YgjsgfCH35ZIJxDrAnbIVg5+1ZB3Xtpv+FYYLC3uIVG0TrGkQC64WvBf03AmmVCRJWgXuNqDyiIV6z64kl6BFEvsueT8j2CdbztpGNFdcAZZR1faFpI5w9TjCUx9rpBVQYkhZOGeBnQ6ooR1p0eg2Tw/SNtoHAtW5cwgG7h/wn/68BXO3D2aVaq++f/Z805oiYX3SyXycRq0hze0jJRBK1w12KetFVqCJ/F9PxeQuUd5A11M6PkF4K+lP/QoYh+urIx8YaUhfOclaT6AYhv8Xl3V0QNUryy/2WNFr7slNLX/Uq/3yXzTt+hYASYPYhp7fZFEZ8Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tziJeOEw/BS+e7YU+4V7x/VXYezCf1g2NlxkGwA58ng=;
 b=Hn2ljKWKqYzMs8QUnXtwC9nBpS5ZutxnP8MDpfKDSVzkGvGgxijC9zTRW7MM3o4nSm2Y78dfufErAMpkRzKVusCgq4hdeM4HvQIEAvH8I3KfHFuiqpgYKHaq215CQjElRcGofmtog85oon5UkgMLxjH1dHPstcbaf95GKgpJYNxMRzvYfTBmppoxKdQ8e4zs75E3pN0Ipn6rCl9ycGhGl8R5wJsMANCS8PZizNPgIEAtIZwVhk+hGu99lbzC4JdN1y7JlOiMW/sPwj0QZkfj+sd5ZSS+LKdGA/VQCVjeBMYPG4V2rEG1e1QIfyB9/x86YnxZsVA02SFx6hOlnBjFng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 09:40:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 09:40:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 03/14] net: enetc: add pre-boot initialization for i.MX94 switch
Date: Mon, 16 Mar 2026 17:41:41 +0800
Message-Id: <20260316094152.1558671-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316094152.1558671-1-wei.fang@nxp.com>
References: <20260316094152.1558671-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: cd377f6d-8e7f-4a2d-5776-08de83401a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|921020|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Dw+sGWXSh9E1S0cu/X3eCxCA29FfqBFYh/2W1vzGSvLTICDv6XHbA4iGmz6XdA4v8q3W7/qRBwIXz/G4lXiQIcLTB5UJe5fBwCQDrQuHi+UMo2eyAEdgbQbkJCUXdgsLMBdPqpfzDjdr1ewJPIhYkvS1AWxNoz4h0DCSRGB4JzNeCVOAZCveZ9oX4vlbjGNYM+ZTyqKdRGy30P5/3Ui3B9eEFQvBVcP140YcnX60R7WDDZeKH7Fx5V4rZjPdwxY4dRSPBolX+tJf3qWUglTwFu8jQS250TsL0OQOPsn58hwttgrHmFPIoGa5OwvnQsv6UsKxWy6hRIWEFZe/F4liPWLz5+un6ZFqxR0rlTXNjw5q/rPfgtKbiEfgfNvG9sirsNxXqV/z/5jr5pvYVIzRVMr8rp4Z4tB2EjQIZRwf85gx493c3xmCeN+3xvN6Cw2ep0k7qo4WuUSWOTnU9bVVwqFvPWeyD7DgfHU4wPocGLcIWvJXzR1ebLCkCTsaQw4dYW7gvSMVvn9m/TqMDeMfOcABosLux9KSOL7Ibz337sM9KQJMnoWBByIrx9YgDnLWY98OMK0lLiHiqdSn2Od1NAkstQFm8iPLJMrQ0IGeWEPGcHKiGVojMf3+ZWM7QFGiDtbqDYT4A7x8l6KY02BKxiaaRnAtEdfDWr+kzmizI+GMRWTYlhnZneuTcCb72pOsFThHQDblo/zLvC4Ul1NfrugG610TSncH9WDzeN1f6trhjLPGOzqZoPl7yJV/OYrsVUTcSyoVW+6mkYaJs5rZhmxGYxwI3eoXufmigW6tyx+jgO26uWhSF7ZqjVKP5+Kz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+flAa9XVQcq+idc3NpQ/6mmr1JbXsOCynq7BHKIkflLEVi6P7kiutC1UcFBF?=
 =?us-ascii?Q?iV3iR03kqzz8baYcCbUo1ilG/3O24B0jau7OOVYodMvBmfilJLVPIKK0nROY?=
 =?us-ascii?Q?uALgzRpUnRdCCgPSOi2vxdfbLV+iUKYOD+iTdSWx56BeYfr7kz1pRgjZ0WwB?=
 =?us-ascii?Q?kApgv/PGz8OlQUzbUyZ135bCVcLuOAgRSDSJY5MPUFLx3DOCXk+Gztc8NWVk?=
 =?us-ascii?Q?FF/cSgQgPtLshCsdKCIo1TgUFog7ne8EWFuEIHr0BGmPjARSMd3kNYlKsVMu?=
 =?us-ascii?Q?lDW8iNvKoQVsUEGhV+7IUJ2YJpYQpnyKsBQc+XABjBYrtvDiy6iMRQ9B1pl6?=
 =?us-ascii?Q?edF5TYnPBycB29h6F7MrtK38FWrmFSA54gwr9lziwe/ha2/IX5OEaHDAqR51?=
 =?us-ascii?Q?3EKpmrNReT5MsqK5o3nbFQtWvzK1EHoyAy9BsrSaNlwiVFgGyPMhrtu3K/9v?=
 =?us-ascii?Q?k11wFz+au/LGc03O9aAOKfb6FBmyM1UV0i9pinH2sY8hNI3EujYJebIlHHxa?=
 =?us-ascii?Q?U9lGK4UCpEixy7/9yWYr+fDG0haH+iR2JDYBzwBVzz/Usi9I8+Y/KBvSQ9qA?=
 =?us-ascii?Q?Oux88ZG8mv8ExVUHWb+RlGXiJYwPi2nTciaVvr1cESbYrl1hgTNekH+wDon1?=
 =?us-ascii?Q?9tG7B+5jdnvx9j3IjWlJ5ONvPm2JhZktbkQ/vGt6AwmVZqHD+v17kKtgiFCC?=
 =?us-ascii?Q?pvgaishVLLARSQB0MxLDe1W/bXx2sY/VUbZWB4G6mwlSR//hiHL/5LFD8ZWr?=
 =?us-ascii?Q?ZlJvfXzEFaWaX8rALt9mrrZL2s0WN1ke4u21UuxskIN2zkMhT6aNbFIOLQmy?=
 =?us-ascii?Q?7/wmN2yaMD/K01T46NMR03iRktIfxzOnFjuT9o9mGC5JrSrBKI1ZexMBtclX?=
 =?us-ascii?Q?gsNdy5Z6YBPclsMn+M6eT95qNUhP+OoJNAPVxCTu0R6Og5ns8vJsrE3fMah5?=
 =?us-ascii?Q?lbd19wXBF/b0409EII6x2+SdgVYe3Nw788jtqTBzlEdp/aljoo9rmxUCFJOF?=
 =?us-ascii?Q?OJnn3usQwxVdbk5Xh1OkgvKKkf+QLKoRomT78DsP9ghTPpXOzii6+fXdukhw?=
 =?us-ascii?Q?23ndKK83V2M3U69qAB+eGXGi8u+u+9Rex0yjfNu3b04nh0reOEy/kH687LXp?=
 =?us-ascii?Q?ByiB/7owlvEFkIXzpSqUc1HAhtBcolOA7LuefJvGWqvALOkk0NpEvX3Xh1Tg?=
 =?us-ascii?Q?psKBKyjRDhVALr4QJ4E40J1AeKvEnxHI0rR2Ijl58H0QEi1suI1VIqB+OeF3?=
 =?us-ascii?Q?hIssh3RIPclRQF23lTkYB/QYv1UWv8JcCe9/83rGxFTaywQxEMnk+ggAARW0?=
 =?us-ascii?Q?htwUJzhCnhx2drYpD4jIKmYE2xN2weGPm+8vmspiQDneje3079CVuTIXslix?=
 =?us-ascii?Q?GcKnX+Ow6B0Mvn7npWNjgip+qHyAlfxsGJspfnvX88GFKS0AaSzTNIKuPrQw?=
 =?us-ascii?Q?ziTbMpM2anm3xqdCSZGSd9HyzB7hekvi8gJYrNfJ+Wk21Pao85/ziRrFxtK5?=
 =?us-ascii?Q?yfwKQrb9b4/kW0LpXdoMD3DdJcci518cSo27fD4/mMrc9xxGxcXaL49GGFQ+?=
 =?us-ascii?Q?l4YAODYsEgZES7+8S+VTaaEGrKpJGQs4BKrLpLNYPH1Mjo11lOQ2gmJLBbZt?=
 =?us-ascii?Q?0VQPsPCXnAoS9EBz3T2hZfJAv0U5bBhqIYrqD7nLQi7qZTyWp7Pw2v7rjZVX?=
 =?us-ascii?Q?17TZmMGs5pM2Bsr2fUF+ukj/+SvTZyqc5IZLYr1++m4fgp/3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd377f6d-8e7f-4a2d-5776-08de83401a06
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:40:47.2895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoMpmh3RXinLcZUZY5JsW3dqkk3utePuBEtQ3mJudgaq+tTCN2v/VjoVDm5RzY+/ocFrzm+pUtd3YZg8MgT/Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195

Before probing the NETC switch driver, some pre-initialization needs to
be set in NETCMIX and IERB to ensure that the switch can work properly.
For example, i.MX94 NETC switch has three external ports and each port
is bound to a link. And each link needs to be configured so that it can
work properly, such as I/O variant and MII protocol.

In addition, the switch port 2 (MAC 2) and ENETC 0 (MAC 3) share the same
parallel interface, they cannot be used at the same time due to the SoC
constraint. And the MAC selection is controlled by the mac2_mac3_sel bit
of EXT_PIN_CONTROL register. Currently, the interface is set for ENETC 0
by default unless the switch port 2 is enabled in the DT node.

Like ENETC, each external port of the NETC switch can manage its external
PHY through its port MDIO registers. And the port can only access its own
external PHY by setting the PHY address to the LaBCR[MDIO_PHYAD_PRTAD].
If the accessed PHY address is not equal to LaBCR[MDIO_PHYAD_PRTAD], then
the MDIO access initiated by port MDIO will be invalid.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 188 ++++++++++++++++--
 1 file changed, 166 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 92a0f824dae7..c21230f7a7fb 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -261,40 +261,112 @@ static int imx94_link_config(struct netc_blk_ctrl *priv,
 }
 
 static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
-				   struct device_node *np)
+				   struct device_node *np,
+				   bool *enetc0_en)
 {
 	int link_id = imx94_enetc_get_link_id(np);
 
 	if (link_id < 0)
 		return link_id;
 
+	if (link_id == IMX94_ENETC0_LINK && of_device_is_available(np))
+		*enetc0_en = true;
+
 	return imx94_link_config(priv, np, link_id);
 }
 
+static struct device_node *netc_get_switch_ports(struct device_node *np)
+{
+	struct device_node *ports;
+
+	ports = of_get_child_by_name(np, "ports");
+	if (!ports)
+		ports = of_get_child_by_name(np, "ethernet-ports");
+
+	return ports;
+}
+
+static int imx94_switch_link_config(struct netc_blk_ctrl *priv,
+				    struct device_node *np,
+				    bool *swp2_en)
+{
+	struct device_node *ports;
+	int port_id, err = 0;
+
+	ports = netc_get_switch_ports(np);
+	if (!ports)
+		return -ENODEV;
+
+	for_each_available_child_of_node_scoped(ports, child) {
+		if (of_property_read_u32(child, "reg", &port_id) < 0) {
+			err = -ENODEV;
+			goto end;
+		}
+
+		switch (port_id) {
+		case 0 ... 2: /* External ports */
+			err = imx94_link_config(priv, child, port_id);
+			if (err)
+				goto end;
+
+			if (port_id == 2)
+				*swp2_en = true;
+
+			break;
+		case 3: /* CPU port */
+			break;
+		default:
+			err = -EINVAL;
+			goto end;
+		}
+	}
+
+end:
+	of_node_put(ports);
+
+	return err;
+}
+
 static int imx94_netcmix_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
+	bool enetc0_en = false, swp2_en = false;
 	u32 val;
 	int err;
 
 	for_each_child_of_node_scoped(np, child) {
 		for_each_child_of_node_scoped(child, gchild) {
-			if (!of_device_is_compatible(gchild, "pci1131,e101"))
-				continue;
-
-			err = imx94_enetc_link_config(priv, gchild);
-			if (err)
-				return err;
+			if (of_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_enetc_link_config(priv, gchild,
+							      &enetc0_en);
+				if (err)
+					return err;
+			} else if (of_device_is_compatible(gchild,
+							   "pci1131,eef2")) {
+				err = imx94_switch_link_config(priv, gchild,
+							       &swp2_en);
+				if (err)
+					return err;
+			}
 		}
 	}
 
-	/* ENETC 0 and switch port 2 share the same parallel interface.
-	 * Currently, the switch is not supported, so this interface is
-	 * used by ENETC 0 by default.
+	if (enetc0_en && swp2_en) {
+		dev_err(&pdev->dev,
+			"Cannot enable swp2 and enetc0 at the same time\n");
+		return -EINVAL;
+	}
+
+	/* ENETC 0 and switch port 2 share the same parallel interface, they
+	 * cannot be enabled at the same time. The interface is set for the
+	 * ENETC 0 by default unless the switch port 2 is enabled in the DTS.
 	 */
 	val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
-	val |= MAC2_MAC3_SEL;
+	if (!swp2_en)
+		val |= MAC2_MAC3_SEL;
+	else
+		val &= ~MAC2_MAC3_SEL;
 	netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
 
 	return 0;
@@ -610,6 +682,77 @@ static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
 	return 0;
 }
 
+static int imx94_ierb_enetc_init(struct netc_blk_ctrl *priv,
+				 struct device_node *np,
+				 u32 phy_mask)
+{
+	int err;
+
+	err = imx94_enetc_update_tid(priv, np);
+	if (err)
+		return err;
+
+	return imx94_enetc_mdio_phyaddr_config(priv, np, phy_mask);
+}
+
+static int imx94_switch_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
+					    struct device_node *np,
+					    int port_id, u32 phy_mask)
+{
+	int addr;
+
+	/* The switch has 3 external ports at most */
+	if (port_id > 2)
+		return 0;
+
+	addr = netc_get_phy_addr(np);
+	if (addr < 0) {
+		if (addr == -ENODEV)
+			return 0;
+
+		return addr;
+	}
+
+	if (phy_mask & BIT(addr)) {
+		dev_err(&priv->pdev->dev,
+			"Found same PHY address in EMDIO and switch node\n");
+		return -EINVAL;
+	}
+
+	netc_reg_write(priv->ierb, IERB_LBCR(port_id),
+		       LBCR_MDIO_PHYAD_PRTAD(addr));
+
+	return 0;
+}
+
+static int imx94_ierb_switch_init(struct netc_blk_ctrl *priv,
+				  struct device_node *np,
+				  u32 phy_mask)
+{
+	struct device_node *ports;
+	int port_id, err = 0;
+
+	ports = netc_get_switch_ports(np);
+	if (!ports)
+		return -ENODEV;
+
+	for_each_available_child_of_node_scoped(ports, child) {
+		err = of_property_read_u32(child, "reg", &port_id);
+		if (err)
+			goto end;
+
+		err = imx94_switch_mdio_phyaddr_config(priv, child,
+						       port_id, phy_mask);
+		if (err)
+			goto end;
+	}
+
+end:
+	of_node_put(ports);
+
+	return err;
+}
+
 static int imx94_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -625,17 +768,18 @@ static int imx94_ierb_init(struct platform_device *pdev)
 
 	for_each_child_of_node_scoped(np, child) {
 		for_each_child_of_node_scoped(child, gchild) {
-			if (!of_device_is_compatible(gchild, "pci1131,e101"))
-				continue;
-
-			err = imx94_enetc_update_tid(priv, gchild);
-			if (err)
-				return err;
-
-			err = imx94_enetc_mdio_phyaddr_config(priv, gchild,
-							      phy_mask);
-			if (err)
-				return err;
+			if (of_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_ierb_enetc_init(priv, gchild,
+							    phy_mask);
+				if (err)
+					return err;
+			} else if (of_device_is_compatible(gchild,
+							   "pci1131,eef2")) {
+				err = imx94_ierb_switch_init(priv, gchild,
+							     phy_mask);
+				if (err)
+					return err;
+			}
 		}
 	}
 
-- 
2.34.1


