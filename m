Return-Path: <linuxppc-dev+bounces-23345-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019D2C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 03:26:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grMj51jNQz2yjR;
	Thu, 02 Jul 2026 13:25:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782962745;
	cv=pass; b=bOvO9Q2mNVK5+xDJdSIXRfdYc0l8AOEb9ANaIjSHZLSYttqiSRPr/dRoN4ncQDDTYJ27Lmvp4T9KQZu6uKWx8Zdgd9J67gbdlHb6NU482RVL1+vRYc9vRMg2HzskUsuwRTa5IzqcPQHtHIgi11isp8p4Qi0ec+0cAwdbIlu8AgUDU4JfPbKix4HedfLCntVGUMlszBCvZdpw1V4tyjakOfxwIb3gLd3TQCfgledplbdJYGNMowkCrc1KxPrFsKb02u559Gc0wGM+gH0LKkKHkGeK7vMUxEI0kFtyXsX9cbV3aGaC79E08UsAqTbX/CsoG02n4pPn9TwvlqaI5D/ttg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782962745; c=relaxed/relaxed;
	bh=ldRiNBCOJWyFngcj13VgJQfJt1BIcjx0qrIGck3hjtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LpuIzbYWDixJ4Fq2Cjhs5/Uv+RBVQpuisQ0zVQ2J1K5kKbGmANe6/XlBpGCyWDZuzHhpPtRCy0wRvD0aU0AhaxoEhnPxJJ/MbTddvzf3REQysYHbz2vL6GYYHGfRgyqEjpkt2h1WQxKNrBLWlZphZvDJaH8f1Ubdp7XcOaOCZjKJEcp+sdC41u11b/PTSAhJKajq8D3GsoPAJ9aYs7Wkcx+IFvrtbEg5iK4htLdHrvy3saCwGcJf32NZ64rbTCXYb8zvWckEhR8tLUQrIApiTyOgb8s7zylnL3LMFrTmR/6WzZPxsbGHaE4i99nPYkTozrKXHa6s/YKouQ1Ns3bUAw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ki5mVdTM; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ki5mVdTM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grMj33Npkz2yks
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 13:25:43 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqYY/h/jKKsMDqmzvpyxUWJ8+rpo/9qWIhZjoZ0tUtZ7xXH+/WfqMrweszmD7NxZ5VAehQiMS/jPG0C4IGXpgVX8bUtT2FRXstRYi7UBjfm2bWH2lAkHXVUj1n3oLmzKRSeEPaUeiJpUTp+Kgme7GwfCGKik3Kzai0D+w0QaDzAuORydeJOGxBHgs1yif6MeIotescOjKd2CXmY7+01mQjr98zTMx08oIdClcUHOY0Kx71jWuVkmUCaG4ZwcpKKgSGzIw6vVS4GHxc2ThUsWLfxl+eUZkIYkXPHVA7BRwWWPXds3arz0kOeId2ebHPO9flUeg2C/fHpYJrzOZFfwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldRiNBCOJWyFngcj13VgJQfJt1BIcjx0qrIGck3hjtY=;
 b=RY3966HhtCN5r62KAnQWzzcFrn1D/RuMJ/m4Ls8Bp+Rqm9rPwl9SzrixEOxNiAfbIk5wogqUCqRZ6doxLUt4jFkArS4/azUJE1j2E6BqjQ8SvA2xz5an0xQVQdiZpoLMcURMNoKt8z42ZmlyHBDdzMSTb+NNm8SOHRYgUQtZ2UFGpAaFnxp1d2Sbx4Q+0hss6/P7tWj5yGTsnNYc9wxEc0CyejaK+Keah2+sALgH6Pg2WI8r50MU6zWuIo2K2juVOt5wX3pIpN6doj7KmnT+c1wmzNcfAvtVJllHsI4L3NVGPPbAteo9hBrdPZQeVK219Wd0L+Fo6ZNtHduU0pdS1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldRiNBCOJWyFngcj13VgJQfJt1BIcjx0qrIGck3hjtY=;
 b=Ki5mVdTMfZSlVt8sAB+BsPPeCkfPbYUhsgMNSjiYQYPEFz9ei4mPnvZHWAqbLRIcXbp/wXUhRF6JI3aAHlOLo6dSc2pXx8eUiEuDMc/qNReL2Xn7/QfME1+wOohhYOvfHNJitd3RW9QCuYofPcFIEaVplUWRtnQiDidGuSvLNGpfwoOa3uyWuOhtzG5o8Gd1y6Zz58DsWdtpcKsWMj3EpbbmbuFca+inEuj3a3YhzCKotUawJgotVgaN7/REg/jlKZ98kmNV16B53H9agh48ZzjC/gUVsjQOJpefabwJdzidRb8Gqpik9AiPyrWoLk3FDxdNIF3o/juYT24eS7rTLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:25:30 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:25:30 +0000
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
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 03/14] net: enetc: convert ndo_set_rx_mode() to ndo_set_rx_mode_async()
Date: Thu,  2 Jul 2026 10:57:03 +0800
Message-Id: <20260702025714.456233-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702025714.456233-1-wei.fang@oss.nxp.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0315.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GVXPR04MB10248:EE_
X-MS-Office365-Filtering-Correlation-Id: be715d79-27b9-4dda-efce-08ded7e99162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0c2oUbo7HvckoHgn8LRTULJ8bA/jpdDrj5D2RapAfZ2cemIZZKwmxOYfIVuhwlHAcKyWOE2m65Q2YwlyUIv2AyqdwIXZPFN16gknugjzwZPT2ULUB2ZhHcljjK2q5nbVCZGn0JIYAgxsC7xIXeBTFYCOeCvEg7aTczrBBMDTtv/K6P27CF0honQbo0d7BWnJpa4/9KyaI61QxF/SIuYhXUAUFW6NwNVTfXPaKx8Qnq4azY36odBDbo712QEoU+wvXk8K4ZQilNwMju//ZsQ4yXdmGuSo2tbdfAeerzeq5ZCnx7q+GQAEQUVBU9ZIlr1YxUjYjHfiJicJc8X3gvU5ZDAYVuXEBHg0+VEFK62ZLLO/DIfawCdNaFWcuJy4mUB4NSA007Q9o1iWx20JJtdWeq0s2ho0lsVSUVNwAczevn8nrpdDTN/YDprVUQ/OsjNdTCSWwG8kKTuWKcl63Vq7drl9Z6vnIMyiKVvf9hWpeP3Fvs94Kkn4dNUCEhj11GsZuG/sxIvcnC/yGywD/q9Gg1Pw8TuS2nbxjvQcR8WE88HTAJ5IV4fBjU98Y6D0T+DENKV+wWg/DmS0IdQr14230nmptHPX4IQkLA5hi94/B6VMKuJEn4hK3qVyHAIOLNXIF9xhXflYolPQ5EQNDW1Raax0XMGa8EAk6Xmuf9sUK9XXveEM5k0oiu8CpHu1+96NEsH1qwb1DLBb8J4erAAsgg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y8I7lS3s5J5tv7NF6JJtS8llrkXmhgCyXjl3aUalz3v0nPP9O+5pk/cEk3R0?=
 =?us-ascii?Q?S7jdE/uppPkBOQAWCbnnt/0f45rfMf7hYbdDSIUVuSB6U+P74Vx52B1sCWBM?=
 =?us-ascii?Q?fOryxIZlXWhuzPMx2G6xxrhb7ZXnnnELNlG50w3U7hK1u86eQij79Gn3ezGz?=
 =?us-ascii?Q?Om9oUTPsQumPg2t0s75N+FKvU0Pi1dE2NpVMCTDOy368Ql4Bcylx1RPPlS5v?=
 =?us-ascii?Q?NoywC/jfXwfpkgCZQqJltC+FFzhUGi8lT3y44Htirzpr1Y4V/bCijGFYsP8X?=
 =?us-ascii?Q?YFQdhLMUJEmxbDmkZNfzwyqe5pW5YLeOWEe+Fhelmsw6AFOmC0pw3fKxPbhB?=
 =?us-ascii?Q?VsXtMEog1CMNxVde4VfdsFZbhHg5XCo+slrrWU2xSlGLd7S6+o9Reg/OYIRi?=
 =?us-ascii?Q?FlyK69z2RJerGUy0wTIlAWLAgcBSjkO8YMOaOIqK9PhilmcokFspuUf0RCZX?=
 =?us-ascii?Q?r5gKBmartHX1JxkQhcAv3Rtuo8iM1sHlSOBv2og7rpCNeHt0rBMpwhVspr9w?=
 =?us-ascii?Q?20v0LKYhKQ6dF/H4Vo5wo2HWPziORmG9+V5jt7C5/8UPCUUvyNWO2mxqqJnm?=
 =?us-ascii?Q?pTmMTpPSwDiaR5dNKbdtWmC/mE1r1lc/oDrRnfyT52ZjiAl2wR48U7pi9lFl?=
 =?us-ascii?Q?03vYGPuqFapc0xet1vYGLZvEuJd9r5dYctUWBckmYeuITIo3mFsOh8Y+ZaDD?=
 =?us-ascii?Q?fDiPG+Msvx6qLr5ONCGOORnabmeUfRwxMN3uxiPeZ53Pi7qzkwGiUwFLsCOR?=
 =?us-ascii?Q?ePE97trrbkMGi/Sua1MuPil8gdoIBfrJ4mjhI4lMPC++GY+Lfe7B2NH2oWEL?=
 =?us-ascii?Q?d4paGMtjNbPaqeFg8IBui6gOS707gnrqGs8U2IZKmxz562TWtRxxvnpe5MKT?=
 =?us-ascii?Q?5SWDl7ooT4hyEpuc5YyE/WFQd1hyQiGBcipUEZdvIMSwftaBgPMCIsIg5hJz?=
 =?us-ascii?Q?EyYZOlWEBWYw3viJN57e+0UtZ3aakwfcDzR5WmiarH2NZaLZsyteRrdqOoLj?=
 =?us-ascii?Q?6k5smXZuaIw6Hao4uyusXuoH83Rqi9NIIIQ7bAGk1qx81z6HAOc9rdzOf9BK?=
 =?us-ascii?Q?fEJgeN2RSTb0zujphfrVrn9pb4R4QdEztNBXbB8HHbA+covIhrcQUT7cTyvA?=
 =?us-ascii?Q?MyBJ3XxpodFjVB0uWY3Dc177dRutf/gNfwHG795/Hkqv+8IoXybp7BQ94slY?=
 =?us-ascii?Q?lZLdmSeMk0NIquhByCLPFUrTtH9E8NTYH775mzNOwcj52jB3T98E6TnbrYC3?=
 =?us-ascii?Q?xEfMqTPhRyN9TRqnsEWLnlCq7c4VDkn4uBanXt3mp7AN+IRlxzYiK7MNJnPh?=
 =?us-ascii?Q?Iwfr8SAJrMfZlY1KgpXLkVr6fVTTKa3D+h5Ilt9gb1yHhceYIx/OzuwM3wGp?=
 =?us-ascii?Q?RicamQWRNVpEujceVZjg15A/ljgV9GlrBWb6reqAMLEYZefaSGudsYqimPYM?=
 =?us-ascii?Q?guclGw2FkE00x9c9XzHyu3su0lwm01czfPU2+TVdYQSm6OGy4E6YvBbwwJW+?=
 =?us-ascii?Q?7j6ABSfekiqrKhDWt1YfeKVTTE+ItmeI3gd1ZtZTldAxPQRZSE5kX40YxtFc?=
 =?us-ascii?Q?EuU9pc1lC+66/tm8KzCsf2fRbDWfW3ctULn0u3FmiNA03rqKpmxuczlykrM4?=
 =?us-ascii?Q?Ig8upfXS4x/Ex5A0mE0q3dIyxHol6bCX5fTgrJuNM5CUOBULc9++wALrx58Z?=
 =?us-ascii?Q?Ui3qdeqbCVCEXSC238+VFW8xTmPNUWmADmyw9zebE1BR8CpOljSkq/+JaxjR?=
 =?us-ascii?Q?bQYfWOI3+3xLJL8lDKuThbI/iRntL8L5pm7ZnpIVEONwrYzd9sOV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be715d79-27b9-4dda-efce-08ded7e99162
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:25:30.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjRwPLYUagjRucCEhAcuyKRBUPnDtVAe9k8kzRSxo3u8//jPuINP9if6aHf4/w4vHIFdIraNB58TWwgn4Bu0DQgg78kYRr0I1v2nqchUCajEWl49B79IV1FHAs0+k7Of
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248

From: Wei Fang <wei.fang@nxp.com>

The current ndo_set_rx_mode() is called under netif_addr_lock spinlock
with BHs disabled, which prevents drivers from sleeping. To work around
this limitation, the enetc driver uses a dedicated workqueue to defer
MAC address list updates to a sleepable context.

Since commit 3554b4345d85 ("net: introduce ndo_set_rx_mode_async and
netdev_rx_mode_work") introduced the ndo_set_rx_mode_async() callback,
drivers can now handle address list updates directly in a sleepable
context.

Therefore, convert the enetc driver to use ndo_set_rx_mode_async() and
remove the dedicated workqueue and the deferred work item accordingly.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |   2 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 178 ++++++------------
 2 files changed, 58 insertions(+), 122 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 04a5dd5ea6c7..06a9f1ee0970 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -324,8 +324,6 @@ struct enetc_si {
 	const struct enetc_drvdata *drvdata;
 	const struct enetc_si_ops *ops;
 
-	struct workqueue_struct *workqueue;
-	struct work_struct rx_mode_task;
 	struct dentry *debugfs_root;
 	struct enetc_msg_swbd msg; /* Only valid for VSI */
 };
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 48a74db90ed5..a02b01753ff2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -101,24 +101,23 @@ static void enetc4_pf_clear_maft_entries(struct enetc_pf *pf)
 }
 
 static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
-				      struct enetc_mac_addr *mac,
-				      int mac_cnt)
+				      struct netdev_hw_addr_list *uc)
 {
 	struct maft_entry_data maft = {};
+	struct netdev_hw_addr *ha;
 	u16 si_bit = BIT(0);
-	int i, err;
+	int err;
 
 	maft.cfge.si_bitmap = cpu_to_le16(si_bit);
-	for (i = 0; i < mac_cnt; i++) {
-		ether_addr_copy(maft.keye.mac_addr, mac[i].addr);
-		err = ntmp_maft_add_entry(&pf->si->ntmp_user, i, &maft);
-		if (unlikely(err)) {
-			pf->num_mfe = i;
+	netdev_hw_addr_list_for_each(ha, uc) {
+		ether_addr_copy(maft.keye.mac_addr, ha->addr);
+		err = ntmp_maft_add_entry(&pf->si->ntmp_user, pf->num_mfe,
+					  &maft);
+		if (unlikely(err))
 			goto clear_maft_entries;
-		}
-	}
 
-	pf->num_mfe = mac_cnt;
+		pf->num_mfe++;
+	}
 
 	return 0;
 
@@ -128,23 +127,29 @@ static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
 	return  err;
 }
 
-static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
+static void enetc4_pf_set_uc_hash_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *uc)
 {
-	int max_num_mfe = pf->caps.mac_filter_num;
-	struct enetc_mac_filter mac_filter = {};
-	struct net_device *ndev = pf->si->ndev;
-	struct enetc_mac_addr *mac_tbl;
-	struct enetc_si *si = pf->si;
+	struct enetc_mac_filter *mac_filter = &pf->mac_filter[UC];
 	struct netdev_hw_addr *ha;
-	int i = 0, err;
-	int mac_cnt;
 	u64 hash;
 
-	netif_addr_lock_bh(ndev);
+	enetc_reset_mac_addr_filter(mac_filter);
+	netdev_hw_addr_list_for_each(ha, uc)
+		enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
+
+	bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_uc_hash_filter(pf->si, 0, hash);
+}
+
+static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *uc)
+{
+	int mac_cnt = netdev_hw_addr_list_count(uc);
+	struct enetc_si *si = pf->si;
 
-	mac_cnt = netdev_uc_count(ndev);
 	if (!mac_cnt) {
-		netif_addr_unlock_bh(ndev);
 		/* clear both MAC hash and exact filters */
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
@@ -152,79 +157,42 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 		return 0;
 	}
 
-	if (mac_cnt > max_num_mfe) {
-		err = -ENOSPC;
-		goto unlock_netif_addr;
-	}
-
-	mac_tbl = kzalloc_objs(*mac_tbl, mac_cnt, GFP_ATOMIC);
-	if (!mac_tbl) {
-		err = -ENOMEM;
-		goto unlock_netif_addr;
-	}
-
-	netdev_for_each_uc_addr(ha, ndev) {
-		enetc_add_mac_addr_ht_filter(&mac_filter, ha->addr);
-		ether_addr_copy(mac_tbl[i++].addr, ha->addr);
-	}
-
-	netif_addr_unlock_bh(ndev);
+	if (mac_cnt > pf->caps.mac_filter_num)
+		return -ENOSPC;
 
 	/* Set temporary unicast hash filters in case of Rx loss when
 	 * updating MAC address filter table
 	 */
-	bitmap_to_arr64(&hash, mac_filter.mac_hash_table,
-			ENETC_MADDR_HASH_TBL_SZ);
-	enetc_set_si_uc_hash_filter(si, 0, hash);
+	enetc4_pf_set_uc_hash_filter(pf, uc);
 	enetc4_pf_clear_maft_entries(pf);
 
-	if (!enetc4_pf_add_maft_entries(pf, mac_tbl, i))
+	if (!enetc4_pf_add_maft_entries(pf, uc)) {
+		enetc_reset_mac_addr_filter(&pf->mac_filter[UC]);
 		enetc_set_si_uc_hash_filter(si, 0, 0);
-
-	kfree(mac_tbl);
+	}
 
 	return 0;
-
-unlock_netif_addr:
-	netif_addr_unlock_bh(ndev);
-
-	return err;
 }
 
-static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
+static void enetc4_pf_set_mc_hash_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *mc)
 {
-	struct net_device *ndev = pf->si->ndev;
-	struct enetc_mac_filter *mac_filter;
-	struct enetc_si *si = pf->si;
+	struct enetc_mac_filter *mac_filter = &pf->mac_filter[MC];
 	struct netdev_hw_addr *ha;
 	u64 hash;
 
-	netif_addr_lock_bh(ndev);
-	if (type & ENETC_MAC_FILTER_TYPE_UC) {
-		mac_filter = &pf->mac_filter[UC];
-		enetc_reset_mac_addr_filter(mac_filter);
-		netdev_for_each_uc_addr(ha, ndev)
-			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
-
-		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
-				ENETC_MADDR_HASH_TBL_SZ);
-		enetc_set_si_uc_hash_filter(si, 0, hash);
-	}
+	enetc_reset_mac_addr_filter(mac_filter);
+	netdev_hw_addr_list_for_each(ha, mc)
+		enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-	if (type & ENETC_MAC_FILTER_TYPE_MC) {
-		mac_filter = &pf->mac_filter[MC];
-		enetc_reset_mac_addr_filter(mac_filter);
-		netdev_for_each_mc_addr(ha, ndev)
-			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
-
-		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
-				ENETC_MADDR_HASH_TBL_SZ);
-		enetc_set_si_mc_hash_filter(si, 0, hash);
-	}
-	netif_addr_unlock_bh(ndev);
+	bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_mc_hash_filter(pf->si, 0, hash);
 }
 
-static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type)
+static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type,
+				     struct netdev_hw_addr_list *uc,
+				     struct netdev_hw_addr_list *mc)
 {
 	/* Currently, the MAC address filter table (MAFT) only has 4 entries,
 	 * and multiple multicast addresses for filtering will be configured
@@ -232,15 +200,16 @@ static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type)
 	 * unicast filtering. If the number of unicast addresses exceeds the
 	 * table capacity, the MAC hash filter will be used.
 	 */
-	if (type & ENETC_MAC_FILTER_TYPE_UC && enetc4_pf_set_uc_exact_filter(pf)) {
+	if (type & ENETC_MAC_FILTER_TYPE_UC &&
+	    enetc4_pf_set_uc_exact_filter(pf, uc)) {
 		/* Fall back to the MAC hash filter */
-		enetc4_pf_set_mac_hash_filter(pf, ENETC_MAC_FILTER_TYPE_UC);
+		enetc4_pf_set_uc_hash_filter(pf, uc);
 		/* Clear the old MAC exact filter */
 		enetc4_pf_clear_maft_entries(pf);
 	}
 
 	if (type & ENETC_MAC_FILTER_TYPE_MC)
-		enetc4_pf_set_mac_hash_filter(pf, ENETC_MAC_FILTER_TYPE_MC);
+		enetc4_pf_set_mc_hash_filter(pf, mc);
 }
 
 static const struct enetc_pf_ops enetc4_pf_ops = {
@@ -467,17 +436,17 @@ static void enetc4_pf_free(struct enetc_pf *pf)
 	enetc4_free_ntmp_user(pf->si);
 }
 
-static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
+static int enetc4_pf_set_rx_mode(struct net_device *ndev,
+				 struct netdev_hw_addr_list *uc,
+				 struct netdev_hw_addr_list *mc)
 {
-	struct enetc_si *si = container_of(work, struct enetc_si, rx_mode_task);
-	struct enetc_pf *pf = enetc_si_priv(si);
-	struct net_device *ndev = si->ndev;
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_si *si = priv->si;
 	bool uc_promisc = false;
 	bool mc_promisc = false;
 	int type = 0;
 
-	rtnl_lock();
-
 	if (ndev->flags & IFF_PROMISC) {
 		uc_promisc = true;
 		mc_promisc = true;
@@ -500,17 +469,9 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 		enetc_set_si_mc_hash_filter(si, 0, 0);
 
 	/* Set new MAC filter */
-	enetc4_pf_set_mac_filter(pf, type);
-
-	rtnl_unlock();
-}
+	enetc4_pf_set_mac_filter(pf, type, uc, mc);
 
-static void enetc4_pf_set_rx_mode(struct net_device *ndev)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_si *si = priv->si;
-
-	queue_work(si->workqueue, &si->rx_mode_task);
+	return 0;
 }
 
 static int enetc4_pf_set_features(struct net_device *ndev,
@@ -540,7 +501,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_start_xmit		= enetc_xmit,
 	.ndo_get_stats		= enetc_get_stats,
 	.ndo_set_mac_address	= enetc_pf_set_mac_addr,
-	.ndo_set_rx_mode	= enetc4_pf_set_rx_mode,
+	.ndo_set_rx_mode_async	= enetc4_pf_set_rx_mode,
 	.ndo_set_features	= enetc4_pf_set_features,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
@@ -983,19 +944,6 @@ static void enetc4_link_deinit(struct enetc_ndev_priv *priv)
 	enetc_mdiobus_destroy(pf);
 }
 
-static int enetc4_psi_wq_task_init(struct enetc_si *si)
-{
-	char wq_name[24];
-
-	INIT_WORK(&si->rx_mode_task, enetc4_psi_do_set_rx_mode);
-	snprintf(wq_name, sizeof(wq_name), "enetc-%s", pci_name(si->pdev));
-	si->workqueue = create_singlethread_workqueue(wq_name);
-	if (!si->workqueue)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static int enetc4_pf_netdev_create(struct enetc_si *si)
 {
 	struct device *dev = &si->pdev->dev;
@@ -1036,12 +984,6 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	if (err)
 		goto err_link_init;
 
-	err = enetc4_psi_wq_task_init(si);
-	if (err) {
-		dev_err(dev, "Failed to init workqueue\n");
-		goto err_wq_init;
-	}
-
 	err = register_netdev(ndev);
 	if (err) {
 		dev_err(dev, "Failed to register netdev\n");
@@ -1051,8 +993,6 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	return 0;
 
 err_reg_netdev:
-	destroy_workqueue(si->workqueue);
-err_wq_init:
 	enetc4_link_deinit(priv);
 err_link_init:
 	enetc_free_msix(priv);
@@ -1070,8 +1010,6 @@ static void enetc4_pf_netdev_destroy(struct enetc_si *si)
 	struct net_device *ndev = si->ndev;
 
 	unregister_netdev(ndev);
-	cancel_work(&si->rx_mode_task);
-	destroy_workqueue(si->workqueue);
 	enetc4_link_deinit(priv);
 	enetc_free_msix(priv);
 	free_netdev(ndev);
-- 
2.34.1


