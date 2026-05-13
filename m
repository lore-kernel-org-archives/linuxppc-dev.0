Return-Path: <linuxppc-dev+bounces-20807-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570A8CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:03:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdZc4pXFz2xld;
	Wed, 13 May 2026 13:03:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641416;
	cv=pass; b=nSGCNfPL5z6DEMFJ7zf5R2MQuCM6FOUplb1MMfsAB8/cVFV6Cs95aMdR02ASoOyBId+HhbiBAiFAS+IwkPy9uoFgag29d5mroBvvDcZhB0gtwoYXSN6FvHsdS9iwsnIj90ZGxyo/Ma6+WU8ftiY3ht7u9TIsoRgxdB2/79aZmRut8YUNAhTpgT9ux4mBlVZqz0MQ+UHZjA65iPbWgvUFdbYfZ/79gUYaCkvu4gyKwN4TWH/qnlyfBPtEAHWaBQsrqkY0OnHBAEMg/ojIGplSS8zVB2nkOnVeOdV8RGHNdtjCWSVwjcGNvel8q9vy1aeZm2FlVWIqjlPPK+KcELbk6A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641416; c=relaxed/relaxed;
	bh=zc96kirrHSX+oXQaOUbocr+WdlZAYDkzUsDniprt8HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ihQ8x8CUokQaVOJor9IFHALVkU5i98LV6YdrwUK908c2yK+gNyhoJt4i8AAkPjJXDeIbNKHgqaojD+NoUjzEEfoBg5wyrTXpgF2iU7Kv6xAkwgAP3WPErxsxsDNG7yTNYDyMHd4AzGN+6pszzFkn8LP32fu7vPjKpZY7THpiYbx7l2bdz8MkHFqvfn8wflCGduY+s7dcyiVxLYqzeCuZB5zETdnc09yv1MP5wPu4/NTlGgXgGyXEi4Ya9MhvZL+Rs9004mLOKvGOVPyPaB7l0feQQ/BXbOVe2b6Vwl3PNfhQYP4z0YX7AMLFXRx1fS2/a0DuiCXzIYbB42wG/DsJwQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FU9QZXLx; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FU9QZXLx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdZb2G4Tz2xl0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:03:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEr+A3tY8YMYH0lEuA0aFF4hE+lnv9wZ2IHLeRd0GoJIze0fPfE+FeBK7lVslQ2ekz6R0JJVVKOxXtgk1D0COH6KEiuBdBMaJf247U8BfNSyHHoqMgxfVqyPC7ISIy1sRv9O31MHNI5RryoUl2imumauB/2ib5vNT1v8OoAWmeQnw8tvr6ONcY58MH58LiCWZCA1xwkfQVlLTY9JotRY7SQHmD+LyzlKAKeoJ7Pck29DdfCjsY+cYzjxr1OgA4eKhUcw5HNHFfjNqRvM+E+nFireafz92yLLZPzJVkk9ewVWUlsBBkD3VpwDpDftTJJfvvGZf+20hQMezWJrADmjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc96kirrHSX+oXQaOUbocr+WdlZAYDkzUsDniprt8HY=;
 b=ulQ1sU3cMTF7UuoGeDD3DpVV4W5l1y5+GK3hrXFLW9tpKLgBiT3bgRwRXKOmW77ngvOPETFCjv2BHSPivajQQzRz6qtscEjqwrW/JkZOBCb6TDT/FxDUccl+GlCXmvfC5+RB1+8qOMvvvnV4y/iGy9kLIp143lxbItur8gvVcWi84tToJAkHsQoyExH/H9YtyEJD+aXu4G+u59fgR6mpHOHsXa0SwFajDHlKmtqjkCC3WIBm4kPW47QUz3qF5zQ5nt9nwOCkyXGSTzPX1Fgd46OgiILDzjVDVXzrwgnZwAKJC0OcMcYVrSXeeSpktw1aTH/ug5bR9OTSxAtsecb1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc96kirrHSX+oXQaOUbocr+WdlZAYDkzUsDniprt8HY=;
 b=FU9QZXLxhWUnN7RYw5R2z+u670pCrHAooH5l/HOM+Hxufz5s3j1N0eKjR1d/WGzLGEt7oRp2ZNsRbFYpAfWsi0YfHL2fz8BeIf/Ox+N8afDik9xY972HlokOeT0D9F7vvEkGbY6D3k26/pRbRbzCwLuTVU7ha6n6iKHhrS/mJ7geZVyWNn1pYu2liTa8v3oUm+o+ws838hsIy4rXqjrMt+BoPrIdaC73YFj3O3LErrOZRCtP8D4ylBL9kRiI4TWxbmq1MX/guK2A236Iw1rJm23ztL3YoWU3DsO3FtbqIQQE+9EBBFackyNOA85EiFSUvrwujlnGzuULBCd9MiLNig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:03:10 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:03:10 +0000
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
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 06/15] net: enetc: add support for the "Update" operation to buffer pool table
Date: Wed, 13 May 2026 11:04:45 +0800
Message-Id: <20260513030454.1666570-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513030454.1666570-1-wei.fang@nxp.com>
References: <20260513030454.1666570-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GV1PR04MB11525:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f0c196-3142-43a8-5770-08deb09c2a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|22082099003|11063799003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	Qm2Ok/WOIH6tn3eb2zQMWOutrhhrqN5QFZQyfRmjYN60bZ8MsSlWUTpwKVgu9g7kFHQFmiEE5rIk46RkHQSG6B40a9ZLLIJDFbOClmJZsRhySzy47JQSzz3ERSihFkNBcfp04rUAA8wBxc3y8I9a34Uz6kYF0Fhb1pnaKswcTQ/iSujBx6Kfp5fSrmgU72NMIF67YoEGGiOlPbJjVupjjWRjneNdwhBX4F4bxlmOuA4UyyeZmjSYaXhtd/znUKQUTmamo3VDjmSroBbq0ApWCKkwIHuZOSUu1tKRQ714Aa80EXeWKtUvSW1Dyl2TtUhySmYrWp7bKfJO0K/9lkFP2JpmK0garC7QtAtz51C2SmS5QUtjz894UXKl+UtOkRRU4s9eugRFejBVPqyXiiNJ2RpHW4TqyRKp/nZOeqaRGE0s+rmWDPUcMAGE2DfkCzS2zPtU8XRAGXfumtnzzpbgv5Anc0i+1exgtlDizMQpkXoeFQFDrrVC2Zf+nxqmdJK8fCBVt1GKCvwanrvyGZZWGWGSBhX2/OJE34EBOc55t2OrXVliekvm/A80aZlbEgZwpFmJLBUbGNgfvualkBZTK9BbIfwCkma3CzhkCXoVh6Dr6hPQmg+d5MyhRQ49KuK8o/IctCon9K2O0uVEI3qRGSn0Y7zTivGaggTV52uIAgt93ACqZlSAGz1LNDMtGxCldUwKoRguR3bH79GpnrzfxEW5lJvFwu6bZtlFhUVJUhFOzBqwsj8lV0ZoS6yRxENFpejFiBAu2QUIYchb6BByaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(11063799003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q/pZM2kNRAfjgk45XcnObqw4NOKVRl6hrOCy+vzUa29tmrezSok9tGNHd/z0?=
 =?us-ascii?Q?Tma0ct003FglunASs31WjP5CbnANMR4Uv7kMBWveqftuzjqFGIhLptu9fwTZ?=
 =?us-ascii?Q?WDpPLranTZKrx1TJaDHDglw+Ggkj8J2c4bGQWkOCi3JebRZa2sLNwDKFjiuD?=
 =?us-ascii?Q?IhEOkT1bL6arl34skpm+5t2tsJSs78KEvveOGqk0cOWeNuZ5Seef+RVPtlnt?=
 =?us-ascii?Q?p3UqiAedRNUO5De+qQLHbU6DaAuS+3lBM6edt3QzyTISvofFZykMEKoGvR7t?=
 =?us-ascii?Q?/6vdW6SvC2BJKjmhnLjuXNy+3ueF5HbDj1KOQTQP9sZxyqpYbR5NaQDs4Sfd?=
 =?us-ascii?Q?9AN1/7QZ4HX54JFlCl+0KPIo81uuXFiyW+KDll8TQ7t+IPm3k0Q5LBXSyjAj?=
 =?us-ascii?Q?TI5i5a7DRsydpJoTPaePSnt+wkegU1U4dBiwk/EMd66/VTsCROtdkGHvTKQ8?=
 =?us-ascii?Q?PKMAdANsrx2stit4OJ8yD/30s0v5Mt6vjV/L3SHm9W5iZ/zPFHsneO9owtGc?=
 =?us-ascii?Q?bg9mi0rUpWBgx+K/QMGfhBp+xF16VZCiwc10HFnQFiuLIuc5QDx+03q2q7KO?=
 =?us-ascii?Q?GD2fD0copvolDm8CCJmMMl75oFRybNb7kNhA55NIfTzwCy9RXhY7UA1K3Hjm?=
 =?us-ascii?Q?IbOlMu8nWmWbb4JanVVrc1QMgI5cKTLMBAhu+QC1Hp9zQxd1dOrIj5GW46YL?=
 =?us-ascii?Q?wEElgj3rBxRN85lX6n8QiCR8c9ODfqfTfj4TJnowRavqHJ1UOCMaNehu+hWF?=
 =?us-ascii?Q?vQkgxTgTkiVMEMSn68TQ7/AWRWLufJaLd5HQMbr01ZkWQ5iQzFELMEC99SPN?=
 =?us-ascii?Q?WWGZBNishQcWHHbnYfZqac4yf4IPWCD47aigyTvtnfBl2FeQR7o2x7ET9jEi?=
 =?us-ascii?Q?30YL8ohpfwkWXsMmKyoypCFOpWzp1ZulyKwaDyZCUh2FClXpgvqqMJyPHUVG?=
 =?us-ascii?Q?fUK9lFSobAf7jH34krFYP558+DWXr/Fldm/WBc3OzWeCWfKkTNRg2+iRG5oL?=
 =?us-ascii?Q?I4NAkQrNGRZ+M60J2b5EiFP6Ae2gwDeYQMdDXm1rbnxTofA/TXZYAQY2zsqB?=
 =?us-ascii?Q?BUzVPNp6s5ouE2FO4crHG3DiBuoYxuSiOclZQ4GsTJPB9blhlbu58nshVqYx?=
 =?us-ascii?Q?lbpJRBDHD4+e94L1RbzMXRI69zqLV1ourrVqstdCARQc63iSQPO3o59RylDP?=
 =?us-ascii?Q?AB/x1utsSvfWo+/tnwtCL9Kz+VtCfAfccIoaFAuNnQuVWP493T7nB+kbBOTs?=
 =?us-ascii?Q?qRQiP5saoIF0gOtWY/vbB0P/mDwpcx/mrwO6XUF1uk017rEHvxhBInr8Qep5?=
 =?us-ascii?Q?wRl6EtSXa+fq8acF71VJPpk2FNnXMtqRDpFw6taXATBUXhOWTvWz4t4FT7Hg?=
 =?us-ascii?Q?XhtgpRwJO18QQe+rXe2If347zw5ZA2nkmu9XkMqpxRQDUfxli5HbjZyqprBU?=
 =?us-ascii?Q?dgrZDb6Rh2VNZ11vJ5zyq1FHhqqpeu2aZ+3q9eUcHX7s/b0HztmtGiVyDB0w?=
 =?us-ascii?Q?0hpgqkq6Lo9tmbyyOhgLl+UKCEaoImjfIfUolZdYGWoVJAdIPKFLElG/D1A7?=
 =?us-ascii?Q?TvCcg0MoNEKIMGEdNymnvW+QsYIKHqGe0Eyumctxy3yQbPhKZwZ5/cfeIUgK?=
 =?us-ascii?Q?07Yd3li5mkg0W7c4pwISWOvAo01HqdhW+U8jkxHGrUblFKl7cqWlrRfW8HIG?=
 =?us-ascii?Q?D4mCfyYu5Y0z092C8uM0GRen1XXU1ijGxRJJsv73H1+dsly1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f0c196-3142-43a8-5770-08deb09c2a39
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:03:10.4839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwpMb8aV3PS3ZxLLPbk4k3VftcExaQCKBeNojviBNyNK9x4CBuoUqZTRfwQzm1K1z4eJMvgwqCOUThkYwxqosQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525

The buffer pool table contains buffer pool configuration and operational
information. Each entry corresponds to a buffer pool. The Entry ID value
represents the buffer pool ID to access.

The buffer pool table is a static bounded index table, buffer pools are
always present and enabled. It only supports Update and Query operations,
This patch only adds ntmp_bpt_update_entry() helper to support updating
the specified entry of the buffer pool table. Query action to the table
will be added in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 43 +++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  6 +++
 include/linux/fsl/ntmp.h                      | 26 +++++++++++
 3 files changed, 75 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index db74a9107975..ad89be85b185 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -23,11 +23,15 @@
 #define NTMP_RSST_ID			3
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
+#define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
+/* Specific Update Actions for some tables */
+#define BPT_UA_BPSEU			BIT(1)
+
 /* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
  * ID are not returned.
  */
@@ -271,6 +275,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "FDB Table";
 	case NTMP_VFT_ID:
 		return "VLAN Filter Table";
+	case NTMP_BPT_ID:
+		return "Buffer Pool Table";
 	default:
 		return "Unknown Table";
 	}
@@ -749,5 +755,42 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 }
 EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
 
+int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct bpt_cfge_data *cfge)
+{
+	struct bpt_req_update *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Note that BPT_UA_BPSEU is used to update the BPSE_DATA of the entry,
+	 * which is maintained by the hardware. The BPSE_DATA is not present in
+	 * the request data for 'Update' operation.
+	 */
+	ntmp_fill_crd_eid(&req->rbe, user->tbl.bpt_ver, 0,
+			  NTMP_GEN_UA_CFGEU | BPT_UA_BPSEU, entry_id);
+	req->cfge = *cfge;
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
+			      NTMP_BPT_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_BPT_ID), entry_id, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_bpt_update_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 575ee783be47..64df49e9a3ef 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -175,4 +175,10 @@ struct vft_req_ua {
 	struct vft_cfge_data cfge;
 };
 
+/* Buffer Pool Table Request Data Buffer Format of Update action */
+struct bpt_req_update {
+	struct ntmp_req_by_eid rbe;
+	struct bpt_cfge_data cfge;
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 3672e0dc7726..d74714a402f6 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -33,6 +33,7 @@ struct netc_tbl_vers {
 	u8 rsst_ver;
 	u8 fdbt_ver;
 	u8 vft_ver;
+	u8 bpt_ver;
 };
 
 struct netc_swcbd {
@@ -123,6 +124,29 @@ struct vft_cfge_data {
 	__le32 et_eid;
 };
 
+struct bpt_bpse_data {
+	__le32 amount_used;
+	__le32 amount_used_hwm;
+	u8 bpd_fc_state;
+#define BPT_FC_STATE		BIT(0)
+#define BPT_BPD			BIT(1)
+} __packed;
+
+struct bpt_cfge_data {
+	u8 fccfg_sbpen;
+#define BPT_SBP_EN		BIT(0)
+#define BPT_FC_CFG		GENMASK(2, 1)
+#define BPT_FC_CFG_EN_BPFC	1
+	u8 pfc_vector;
+	__le16 max_thresh;
+	__le16 fc_on_thresh;
+	__le16 fc_off_thresh;
+	__le16 sbp_thresh;
+	__le16 resv;
+	__le32 sbp_eid;
+	__le32 fc_ports;
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -149,6 +173,8 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				struct fdbt_entry_data *entry);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
+int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct bpt_cfge_data *cfge);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
-- 
2.34.1


