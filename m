Return-Path: <linuxppc-dev+bounces-23697-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53126C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:48:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvZdC2f9nz3btq;
	Tue, 07 Jul 2026 18:48:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783414111;
	cv=pass; b=Pubh0/Iy8RFrherWnRXVqUQw44FKIs+2Ejyfyj0X5WaV706B1c7jAnGsPyeVHes3hfi+yxXbf3PjSOMShVCAjPp3icD/E+B/RWSDiPARHnk0Ehgbd+hLcN9qtoiygQu7bZih6PndCwjD7I9msAexFOMX06WCJQlHCV18Se39IXQOJxAtNfVfasZN8oNzN11Y5UYFxEcNZMGex2H9t3GQCytVzXBtEa3kJpUaEiOJT3Io/Y/BP6wyopR90yZTgHno8WCnneRQXIL7HZTu2HSDt4qjTScS7T7s/Jp8knX6g/pghH9hXhkoYirBgk1bNgLkzyir/7wWhu+aZmLYcmdvOw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783414111; c=relaxed/relaxed;
	bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQsbyZLecfMaOvC3XeJmpDZ+SupS+HWvgaJCQXfLpQmCzbYGEtUlECQeDHLzFDKSEI20zZKNpYZWmB+QXiHIjLVyMqGtDYL9H7orP+XHqPBJ/4eYnMaNgYnag02FybOIoVWD6o37HJGsw/LsEB7lC9DB+y8KjsdA3UqpvZihDF2N3bqj+V3frByUZprBcjElgiuQr+9VO3IDfMbXnywDBAc02hBSVOIMMcLG8+WzYKHFJ03voe3J3Zyf/icQrDrIkNAi9QJdE+9Ti08J0C09pVOFZ19hkt0M1qCT/krkcnx5gcqCO/ZMSVuujosAmpIJMIrCl0dSlxmytmX/NmivnA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WT/BGaAv; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WT/BGaAv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvZdB4Y78z3cX6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:48:30 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cB/7t/YR6wEqFPFHDdJciqNu/Ud6YQowUlBWa1COUirQ1CCb1HJ6XCEvVYzxDOdYJZ1MSIrtSlG+jCv2Q582WaGDUbW4TQZ7S5JKwSknmkE1/Or/S2zJJm/SdikCktlVMHIGBQfPRmp1ZgvW1IP5wwbs0b6bhylSNNX7BHsQFrbSC1pIPDZpOdIWRQopjnDc8wU/ATQo5DJx7puU5py06f0iCht27uEmCUIKWMOPr/iges7xXvQz48/ve8eyGHJ63DOka8EdhtK+y5usguYoV7CKSp2r6MiHIArna7Vr6z1kx0Tx6/6J5xWXX1gRHCvO6kcVrjNlHFEDrxJ/2ILbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
 b=oqJAA/oCwuCX/8xCkziXltt5tErpg9rIUJy9v7KZYInnXesMmIUUfaYEU6q7Txj1Bn0GgNUiYuqbrcfMVx+IVqqGurP/3FPohDupqGsctMe65F2sk0a3MeQM6h3Ao4PCgGd7I9g5ZlEnTRyl2r7xaqPiHQgA8GpZIg4fXFs+THCy+pphQc00/DYrOJxVs0w5fRzXmbDfZ1n/3MbYMRGGcc5Cn8TI8XgU1gctOsV3O/G/2/7T3aHupDh3+9RBbWa0Kv1tu/c9JImOySbQAna/VLym5z/dnVdPUDPuBLRl8iiTlmTBvqfsd0LjbXxOkserkIeGfL65HWFTw5R+3QNf6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
 b=WT/BGaAvBxbEEWENWl+12BMrzOdYPRXenUdHPk5WsJHPQbd9TVJyUUYlj979R7l0cuinpJIlo2AGMbIlfMIhKEMGwHve8smiDf9IA1Yxdq8tMEXSkFYASPGvmbUbdewn+wQlZ5VijrckjqS7DTiZllVNJtZx9eMc7eI9czMK1nnnR1MZ8SB6hEtIpzvV6RAkq5ygfyvrg4qkcatMGYLcUMLlsKT/AI1xjSgXHveU719JUZyo6Qfg+OMOdmpOLyU/3Gp5bY9TBykw5g7EkJmty6jFI1VlXP12uVw+3ncUQyr9b/CmPnx7WSsVWS5eA/4e2o7BUPxDY4IqtH3a3Vv2yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:48:17 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:48:17 +0000
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
Subject: [PATCH v4 net-next 14/14] net: enetc: use kzalloc_flex() for enetc_psfp_gate allocation
Date: Tue,  7 Jul 2026 16:18:34 +0800
Message-Id: <20260707081834.710730-15-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0317.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::8) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 90729543-9d93-42a0-aac0-08dedc047d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|19092799006|56012099006|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	ZDGAq0qLJzhP/UKyd2OyNWTf8Mqc6e8oXIYg1OE0MUpNMAv26TDk0fjuhB1HXvcfbOFgmQWnESZPLzgYmjDXgucSax+Aa7Pt6eAQuuj+8j8WzjaYzh3KpPyzkzJtsym1VpRyf3BHRlhvdLHmDqTiVlUDCd5/rz5MFLHz3noE9SrBuMvDsp4s9SOlRF1AWNSPk0chcIFuw4XRfZVSH5OLknZzAPUt//zYLvnqzUDJ74L75LROfnWhnXO/SXJs7BswzNgFOrym+ceoRjbZgPOnZm4IK2AP/GUrQPKd7V8xGSSVASk4+aUQ46q6YYXgcvvmjRKWXs9Dj5cngJwn9+TMCrHzElFN9k77DIZPo2C8XYTv6rKmwQrkpJDx06sbt6BDUxoxnWHuB35Fxvg8XjWppM/Dkj3+Z1QAGq2o39fMrXj3S/097a5i1bMt7D9RIjZs+eLKsU/5E/bFMA1Qs3Jt6OQiwC4M6LfW6XQCnuP71BlW8XejQuK0TNWnItctb50+2PkWUChRmNQqdBVc5+JWzxbHlcR9efqLqhFa38tO+edigSwAz4MrFVnwDlmNpVMhOdrwRWd8lx1fX+7iBMtwthZc2+2v+nUsDz8VCcR+lzQMQBzE/ePq6kGzWq62Ayqez+W0VL0xnd8jyNhRLOlV/MD6I6nOFj/5b9pL7MRpHVDaXbGqC0CdUdCxCkEXinql1Y4BzocxY5ij78ZFxZHL5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(19092799006)(56012099006)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t/xuDg6BkzR70l53qP1oxSm2bdhp/k+Ui4CTp31PN37dNgWWViArt8tGZJKG?=
 =?us-ascii?Q?u5BC9b4JcdL2ZsiiJfm45hAoGscKFRcRYXECPo0s+k3w0R636P0BwYUC14tk?=
 =?us-ascii?Q?e4iM1Qau99hHrM1lc3ZBV1DCswJp0Y6mxJGIZbbFNwgID0Uru3KcPUaXcfPM?=
 =?us-ascii?Q?TeBk47wNUHseAh5hv6IBh1BfDJ5wWyieZQ+NsjJBNdhjjw9guroYmJiG+q0A?=
 =?us-ascii?Q?u4Ta56cjWWxHaV1Q8/g71PXfX6H656MAUJDeC8t972FQER5cvugWDfgiPcWz?=
 =?us-ascii?Q?fSWmyO3zkyBxV+vJqllpM/bTLHmIznh2CQZM9hIvTlLKnZBSGBe2LaTuR3iJ?=
 =?us-ascii?Q?J1XRA6f2aqto7iXryg4gj9h3fLbZO3d+gUgilQSplZTqZZYzuPwTmASxDI0G?=
 =?us-ascii?Q?ltHaMc2LaHYXtlqVtgZuDhbF0zg3tBiu0UcRn+PsFkOdbioVSW+SOj3q8+KE?=
 =?us-ascii?Q?NA90QJfBlS5+8LtXcxd3XUJb5/qBVh/E7vY6pezHvWD9q+iBuqNDDETm9V5/?=
 =?us-ascii?Q?0ZeqKqorrwqhCySPd/kTvefFo4CUIY9wuhdgMKTCnfTrhwavPnJIxA7Cnm7X?=
 =?us-ascii?Q?UmDRgoVWYTHmh0/CYkRlKy0mW43B0wBcX7qG4F97zVY/Uy5s5TLlS/Foe0bR?=
 =?us-ascii?Q?6cKo3F+yfndcvYsIHMpw1noRFPoU1qeM2EKh+kyW/UdAkFCthNOB+TkUGK6y?=
 =?us-ascii?Q?zxmCw4a4gHXceuAYQ7YOo2XxujIcBnyStDjceFVJhlrcUaszkzT0H+KTNkwi?=
 =?us-ascii?Q?5CcaiK2fov/Odma6mKSft32urXyFeW/4kv1BqKCDhQ5KF2ee6WIDQ8NN2jra?=
 =?us-ascii?Q?0zTdX+lcARjrsJvEBC6AW7ZvtYSoeU1zXohMwF5zdZfa6stKqF9me3GheRjp?=
 =?us-ascii?Q?irI60jU8mLEEZNvHpRQlnZKYK0uR9NpHoDGXpiAOYtaBWHphzkSLFvc84Fgy?=
 =?us-ascii?Q?0v+pTzOWMcd4N9U7Kqt1/tFpJ7NPjDcZ2II3MwwHgKw65cUn+xmQDoy3hI9t?=
 =?us-ascii?Q?adiNfCNJ+mrVLGDCM4/r2YiIUUoASp0nibiGf1i1kqhbAE6AX49t/RGrsnJR?=
 =?us-ascii?Q?MjT3k/yTolw0dcecxD/Ya86yKdc0H/vqBvuxIX8QFu5eHLdOYzoYomi9J3mb?=
 =?us-ascii?Q?WX33E2eiYQcL0ldvN2Zhj7GcXUyISVrjaJCH2P4ddjZb1995f4FFAmNv02of?=
 =?us-ascii?Q?IPaBcyK5GL1Cs9rYhqm5iQyL7qDA3MwIM/dup8KIDSVb9/Dn0ritdMuj0EYP?=
 =?us-ascii?Q?0KO8dzWx2XtxTbnKn/MswZ1ASs96fdzcmnk1I9RSdDCDs97zuf84vuZNwB3Y?=
 =?us-ascii?Q?vRkB9uSshQk2WT04NsxFiaWpb3AbtRXvwM71G3Uwz9jnArQLv4IN1j2hiCad?=
 =?us-ascii?Q?SDXzhDc+oXw18doP0M7PQjEj4FF5IEOsQCUlDmNjD4b738ZDcGu4Vupq60dn?=
 =?us-ascii?Q?lLq8XNTyb8XdHrVwa1DMwG/COu3QQol/mVww4psY56Yr/5k7LRoNx8YcDH4p?=
 =?us-ascii?Q?XoVLRcPKgPeaNUyJ1Bf9zbMePyZeMjGA1So+V4iI8I6i11yZAbtgyXZv1isc?=
 =?us-ascii?Q?XehAn3tSiG4XSiFtwrNcfhBF8b18uQBfH6Zp2DfqYmLWXGeato09OwmFAGHv?=
 =?us-ascii?Q?7HO/9hosdHqP40OaT7Y61YmP0EudckusyoY4AbycaznXL6C4pFzU7dvW8xja?=
 =?us-ascii?Q?OuOfwaAT0YtvyCd3ncpG5CGwFor7flMLiHeheqX8wqCPqYPxJYar78IA2WS8?=
 =?us-ascii?Q?sOu1DYEb69XddbrU46QKQSvh8SXBW9q4ZFU2yv57q36YiKoWrNRh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90729543-9d93-42a0-aac0-08dedc047d76
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:48:17.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CMzbzxBDUErTlHEcmFz6BGL71L+1jiDBtvT4iqX/YAlQFEc2GJOwq4ND17SnBa2kmZNM0XgqyOOx4tK5nOoTPnMqCjjZn0rEao4dfgs1J4A0DXCZ9A4NHO4XXT/d5Uk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182

From: Wei Fang <wei.fang@nxp.com>

Replace the open-coded struct_size() + kzalloc() pattern with the
kzalloc_flex() helper when allocating struct enetc_psfp_gate. This
removes the intermediate entries_size local variable and makes the
allocation site more concise.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_qos.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index 7b17bca24f26..2aa0fcaafcd2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -1135,7 +1135,6 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 	struct flow_action_entry *entry;
 	struct action_gate_entry *e;
 	u8 sfi_overwrite = 0;
-	int entries_size;
 	int i, err;
 
 	if (f->common.chain_index >= priv->psfp_cap.max_streamid) {
@@ -1242,8 +1241,7 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 		goto free_filter;
 	}
 
-	entries_size = struct_size(sgi, entries, entryg->gate.num_entries);
-	sgi = kzalloc(entries_size, GFP_KERNEL);
+	sgi = kzalloc_flex(*sgi, entries, entryg->gate.num_entries);
 	if (!sgi) {
 		err = -ENOMEM;
 		goto free_filter;
-- 
2.34.1


