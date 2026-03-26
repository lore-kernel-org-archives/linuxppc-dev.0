Return-Path: <linuxppc-dev+bounces-18802-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB673109E54B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 06:28:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDPL2kzSz2ydN;
	Thu, 26 Mar 2026 17:28:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774506518;
	cv=pass; b=Jdx1XNMHK5sV/JTEp34hzo+aP6fV4WlAdl9mkYrGzrAsgiUTUmhunU88OJbexS6L3ECC6BN13HKEx1fslrTgQPauIXkLQ51kBbt5Mkhd9x0Q1aQgKrOonysW+TRLgItEDHVMsOxfdiKddrNZJxQ5hWdz8+ensgwFhKKYiPLYxb3c/u4R6VvEXcGvZOat5xtD/nGQhWsEfP5ZwNakEWicjti4lH4ZLRf4l+nMW7fAC9dvq8uM/IJiQqraE3kIcvGzKMtEbedciGpG1bojvxIr8QjF8dAuT16zs/ZwqHJ4rj7+lzCdyONAqrqS/8JqyuzBss3se/Iq36R1fOpSvDYxdw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774506518; c=relaxed/relaxed;
	bh=tx8IlxNoilqLm5+3c5cpJbVBBo14AVY0MDedKr3KpNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TkGpgnxz3mWYri5e0fpR3EHn9UEaRb2d27G7kjvtfkTXurvUM3Gwia0qfrIX0Xi9gPpqeqyxD0TtjN9hILjGUOMHd4xkfL0MID47ZTWBVS45TgezOU+rDGr7jj46FBOwX0S3qYBDFzbybrp+B9JbOJp3fjq5U7nzR7Kh3vsXQu3kQAKZ3sB8wAZfJoRvzzWuPgK50G7ALK6boEz6xaQTGm+IA0BiWQnECc+VISEdb7hBtQZT61sBReND6bRScZuJYuLutGtlyigTgeDrCAqETOJn3u8GLefb6z7iyomIpAYHalIBuJ5VvKjImXibFv7u9CnRlsl/C0snxtLMqWUrhw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=McKog/Dx; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=McKog/Dx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDPK1V5hz2yVL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 17:28:37 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FN5WWe6CiFeZX/diCHRwu9il/undDxmTu6Htd6Ek3NfWVsWZGlD4dC4W3LMsuxwZ395BCDAxK4+kPe1P0emcQKhjvSAc/3bv6Sr0qw3oWzyHquFSIGKW0z9L/pYDrXzQvbKz5m7qdPb7oa/QgbAvHwaaw+98vEAfIE/+YW544OABLQteCg/Hlr/vKFfETuwUZ80K9mpofJDeYiG6XEkF4NrhXxIskUxOuPbqh3GuGZ6lIj056U28/iDuawqfWrC1Z3aF7x1RKQZLdUt3XlJnPBCOTV8mzCjyeoou5D09Eg1sWr+rhpwNybz7z0YOlscNga2eORpt+atS0EbJl5DjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx8IlxNoilqLm5+3c5cpJbVBBo14AVY0MDedKr3KpNw=;
 b=VHBnbph4RnRoZtXCwjGaD3FSDdY9/ABZVf06nAmjuC3ylcaA7QHjsLZOU+iMP3otXiTqy+hjJ0glaRneE9Y7GTPPYME8U/euSqEXS0khN7iWkvmuuHaABy65VVB8ZK+dXZHV6U13W5dPJpUsY9Q1ZQ5SfVqzVCSyJWJrzmMgawvHPq9/Qn2SBYmrOYc+RbJdnkDHWGswfME9LfeV9vXtKo4XrY/yiZa5/LMrrDtSUmS5YoXb9paLbxvaTo6Rdh7iW0QUSlKbgKR0tiOFu12hRaY7P2JIPLjIzco2AM+NC5p5N6wdStoYh2/74kmiA9vtfElck7xazUKjgUF7blpT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx8IlxNoilqLm5+3c5cpJbVBBo14AVY0MDedKr3KpNw=;
 b=McKog/DxnK/0eJoNnWzqbEwoW2aAVIoBS0UmvElx055O68JO9/SDhDdFZOfuIAMhJ8T/swu4wfZ3WCCbUg+2X/3q+oRqhnulT2O8dMwdgDZvil0LVKeCtVAltq4J4aT8XlfEhhVUGC55mF46nFi6RMOnSJ8Whhk87QgvEiylIkYlMVPwsYjsik79VLoRI9gL52zPWetQKOhfL99VMMBhKvVe+DFe9B6lVgo1AwVIaM9Q07928HS/TYotgbCWJRxFtYKhopdkhHbEFMmFWJ8Sa1To6ufZ7HyUF8Ih0ZegHdp18PPXXYLXqXV2rIFq5HmxL0mLWH4CyTzZ3912amonBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 06:28:13 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:28:12 +0000
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
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net-next 07/14] net: enetc: add support for "Add" and "Delete" operations to IPFT
Date: Thu, 26 Mar 2026 14:29:10 +0800
Message-Id: <20260326062917.3552334-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326062917.3552334-1-wei.fang@nxp.com>
References: <20260326062917.3552334-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0edbb1-e864-45bc-69c5-08de8b00db2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Zgj5PRuZ7Os2zb25fot31CQuBIBlexo/LYJX5SncM22bIZKiVtveZXZR70ThoGjkW9Bp9866Nt7T13ksixiUHJ8MxaxXFQuGhv2AiCgfLz5n+5L/rmL8frrj9yhn5NfM3/IA7yTthcEzBDdJYLKaMBHpe0KNLXzypTK690olqiD8IokhfUxnn/0YG+WTAOhY79kNYpL202laaAYhawBq1jk74AYpFEbmMPhn36VyPVOIojDtEq9qDLpul4iA3ay6pzDXc0/H8pIO554vD/AWCMW+IG3xzj5mKoexrGn3A1dhUAEljXhPdGhjfvTFtJf9lXi4ENKf5frMIX9Qa4SP/1edSWH3bypwsLNpH5oDVl5mkXvd65rnMKEZ/25OMlkjCH169CGRcxj5O9dIuUBPaHPhTTBb+iE1G0bxT1oLKk6cbTWGqTK0kzQ63r+I00ICiDEKO7Q+emK0O051qE7eS8psf8F5jCM4yrw9empwV58APSbp/8SlMs1whkUhvZlhZ7MqZt410BicCzaZDvBSYde/rtV2G3oZgd65i1b7sd2SCs437QByfwZ0E4if+PtymH9lrFcjMIX2brEUHP5XV/TI0fPZkUp14yqv4RTT5MyD18/zJ4cwbhKl+hVvM351LehWscNInzgrAma+dQJ6ERzHxRFF+lmLBrkH7oYj7VWpDz+kyiAqZcHThjSH2Oqr38IP90bLn4oRxHa0QWGufaoi6xh771d4k57JSkU4JXthyiuiLlhJIzkEBL23TIG5C1VkdTVkN0nTKniJMerSvceTvTJrY1+UpmsG8eSVe80uHgIw4HNYN5IiY8Y66PZU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FL2G5yhP6+vsVtd09qfqUol7L+5Zmtwla6ZDkhO9bf+7QdTG1KMnQBqOkwN5?=
 =?us-ascii?Q?a3L6WKsMq9pkfvf2dwcMQMGxCBOSaghChfW1bj8ohNTl8nPncuzhuGnC/fYl?=
 =?us-ascii?Q?HiSYrcQjMV/4N1IIKgZB75CyRrKn2DcYPh4LDkn3OAxh8dhJTTDYkhikDffG?=
 =?us-ascii?Q?BvYf8Ol5zMYPx9cKr/FTwa8aojl2R2KyreUhzBuqQ6KQRteEVq+AvlDq8mF4?=
 =?us-ascii?Q?kXg8Bngg7COSxVEAKGAECLppqlBo0dKbtHKAkNmyuDhxxOKspangj3eghu9r?=
 =?us-ascii?Q?qox+uiZ8EGZ9caDj7ukdxxhsYWq9eC+H/iVNmVXOr2Fxn45xwsD9uvDXT/yZ?=
 =?us-ascii?Q?dcMPE4JcQ/L/Vxb9mYH6nWmgU5YcagwDotg7FOiLd7qg6ufMK0xS7F1rgApA?=
 =?us-ascii?Q?4xEaycawM8uSGCEwU7FpqtbBf/cgnI28WEaMaa+vBLv1mkcXLn2xHcFdLdHG?=
 =?us-ascii?Q?D0ULYz205JEBKXAfwyK6vAaV99IuOcK7b/mllczc6DyhHCPKswBhpufcaHP4?=
 =?us-ascii?Q?pHC3E/iaygPfMiw6WiP+OSfIGbkr+aqyTSYmUzC5CcpqFZp6VBNKL20kfwXS?=
 =?us-ascii?Q?GuzsI0pQR9h4qIIhA849wPs0Zk7zLkTGf1JLcKScu3fzsZhxpSfiRj9IATg0?=
 =?us-ascii?Q?kk57Y+Lq/pLKehdDZvhwDnocnBSMn1/J3LDY5zs2sUtU468TLmA9+DeX7DBc?=
 =?us-ascii?Q?mMg0ueQbj+LlWEf/6nejJtkAAXCNnVmohJR/d9giUtig/F/oiW5+KA8X4n4/?=
 =?us-ascii?Q?GgGHOw/vE7rXTB0MvEOyhO4Ov7Gx71Vcni9qaROBG3JFI8/JkveOAdkewWzg?=
 =?us-ascii?Q?SqNFpAHUMqasQq6Ecb/kW+6Ny22V1nLWKb+tkkMOGMgLBtlNAYSARsmb+FvS?=
 =?us-ascii?Q?77Lf2SfhesUIr1zZBNDZZe/nzdILbB/MwjKjfC+pm65FIqZFZeGOPIFq+fNs?=
 =?us-ascii?Q?K9ZJIHQKDqYmDYfIhIq5r9aQq1MX4qIdMoJD++n9sQ1omCErU4kwQdJo6Mzr?=
 =?us-ascii?Q?uINABlwW62aWDHOc5LmA+jvW/NTJ7/orFt9si+dqzsH5MPivWI871NWaH5M1?=
 =?us-ascii?Q?ZIH/biXBr/NHX0sNKnXaZuhtJiO2A2YMzheNjtQcrQN9ch2ilhmJnaRwAwsT?=
 =?us-ascii?Q?d3bX13QjLpbIInj1u5tWWWQMpXlO7Wd2mscg9/6gSJ/AOYuVUbF6At2ebovo?=
 =?us-ascii?Q?NFKK5v6DbqzbtGOVeXPcGS9jHGZuQQVrK0Z9sorclrOsGD49spimhrqYAkb1?=
 =?us-ascii?Q?Sn8iYBfSvsvewCL/4ITBV75j5flZbP17M162G9rAqyI8YMeUq4jfnao8sN+w?=
 =?us-ascii?Q?XhBmOBZyP8OlHfwaY3R3Jo2bWWxWJIvnfQfk57m+ZjuXGqcw/2grW2Uo3Fd2?=
 =?us-ascii?Q?2dpl5DfPOb3s3YhREDXa18UgQf50GWbh8WsDqUNEvWyhkpr79cBYv7FoVLdb?=
 =?us-ascii?Q?VpJDEgBHwMPnZxuRldmE22chXwWGRAhSydW16Sv1TuEEVhRSIEST+TbL++WH?=
 =?us-ascii?Q?bNjv4qPEp4xm4zKb+Cbb5gnaexPTHBT3iukYNceU/b+1d4xGzLyUeTlbmo8K?=
 =?us-ascii?Q?hfH3qey1ojZFrWXgyhh0FzKfva4+XREQMJsVx0eG4pZeBb2kjSKCITJXaHPq?=
 =?us-ascii?Q?xfln+u70XHBNEqf5Ocl3rVP73C/aJ/rKuTWIFRk8fIsQeRUWa5haishdONKf?=
 =?us-ascii?Q?Kz86AfKMjGAH/9G+3/w/g5PXw2ZkE5KtJ2/h7kYjM7arfPz/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0edbb1-e864-45bc-69c5-08de8b00db2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:28:12.8755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uZcTYCAWedhk35ZETJ5xOrN/aMdI9w8i38eJYarfbXfyOiwIVOjB2T2K5IjbuD73PV07GzKBjGl7F/1/dQbRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355

The ingress port filter table (IPFT )contains a set of filters each
capable of classifying incoming traffic using a mix of L2, L3, and L4
parsed and arbitrary field data. As a result of a filter match, several
actions can be specified such as on whether to deny or allow a frame,
overriding internal QoS attributes associated with the frame and setting
parameters for the subsequent frame processing functions, such as stream
identification, policing, ingress mirroring. Each entry corresponds to a
filter. The ingress port filter entries are added using a precedence
value. If a frame matches multiple entries, the entry with the higher
precedence is used. Currently, this patch only adds "Add" and "Delete"
operations to the ingress port filter table. These two interfaces will
be used by both ENETC driver and NETC switch driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   |  76 +++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  36 ++++++
 include/linux/fsl/ntmp.h                      | 104 ++++++++++++++++++
 3 files changed, 216 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 3c59b355c142..960d5be8ec42 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -20,6 +20,7 @@
 /* Define NTMP Table ID */
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
+#define NTMP_IPFT_ID			13
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
 #define NTMP_BPT_ID			41
@@ -234,6 +235,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "MAC Address Filter Table";
 	case NTMP_RSST_ID:
 		return "RSS Table";
+	case NTMP_IPFT_ID:
+		return "Ingress Port Filter Table";
 	case NTMP_FDBT_ID:
 		return "FDB Table";
 	case NTMP_VFT_ID:
@@ -468,6 +471,79 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 }
 EXPORT_SYMBOL_GPL(ntmp_rsst_query_entry);
 
+/**
+ * ntmp_ipft_add_entry - add an entry into the ingress port filter table
+ * @user: target ntmp_user struct
+ * @entry: the entry data, entry->cfge (configuration element data) and
+ * entry->keye (key element data) are used as input. Since the entry ID
+ * is assigned by the hardware, so entry->entry_id is a returned value
+ * for the driver to use, the driver can update/delete/query the entry
+ * based on the entry_id.
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ipft_add_entry(struct ntmp_user *user,
+			struct ipft_entry_data *entry)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct ipft_resp_query),
+	};
+	struct ipft_resp_query *resp;
+	struct ipft_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	ntmp_fill_crd(&req->crd, user->tbl.ipft_ver, NTMP_QA_ENTRY_ID,
+		      NTMP_GEN_UA_CFGEU | NTMP_GEN_UA_STSEU);
+	req->ak.keye = entry->keye;
+	req->cfge = entry->cfge;
+
+	len = NTMP_LEN(sizeof(*req), data.size);
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_IPFT_ID,
+			      NTMP_CMD_AQ, NTMP_AM_TERNARY_KEY);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err) {
+		dev_err(user->dev, "Failed to add %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_IPFT_ID), ERR_PTR(err));
+
+		goto end;
+	}
+
+	resp = (struct ipft_resp_query *)req;
+	entry->entry_id = le32_to_cpu(resp->entry_id);
+
+end:
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ipft_add_entry);
+
+/**
+ * ntmp_ipft_delete_entry - delete a specified ingress port filter table entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified ID of the ingress port filter table entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ipft_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	u32 req_len = sizeof(struct ipft_req_qd);
+
+	return ntmp_delete_entry_by_id(user, NTMP_IPFT_ID,
+				       user->tbl.ipft_ver,
+				       entry_id, req_len,
+				       NTMP_STATUS_RESP_LEN);
+}
+EXPORT_SYMBOL_GPL(ntmp_ipft_delete_entry);
+
 /**
  * ntmp_fdbt_add_entry - add an entry into the FDB table
  * @user: target ntmp_user struct
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 7d50af7745c7..6d519d59a433 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -103,6 +103,42 @@ struct rsst_req_update {
 	u8 groups[];
 };
 
+/* Ingress Port Filter Table Response Data Buffer Format of Query action */
+struct ipft_resp_query {
+	__le32 status;
+	__le32 entry_id;
+	struct ipft_keye_data keye;
+	__le64 match_count; /* STSE_DATA */
+	struct ipft_cfge_data cfge;
+} __packed;
+
+struct ipft_ak_eid {
+	__le32 entry_id;
+	__le32 resv[52];
+};
+
+union ipft_access_key {
+	struct ipft_ak_eid eid;
+	struct ipft_keye_data keye;
+};
+
+/* Ingress Port Filter Table Request Data Buffer Format of Update and
+ * Add actions
+ */
+struct ipft_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union ipft_access_key ak;
+	struct ipft_cfge_data cfge;
+};
+
+/* Ingress Port Filter Table Request Data Buffer Format of Query and
+ * Delete actions
+ */
+struct ipft_req_qd {
+	struct ntmp_req_by_eid rbe;
+	__le32 resv[52];
+};
+
 /* Access Key Format of FDB Table */
 struct fdbt_ak_eid {
 	__le32 entry_id;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index a54945dcdc61..efda35e5e22c 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -7,6 +7,7 @@
 #include <linux/if_ether.h>
 
 #define NTMP_NULL_ENTRY_ID		0xffffffffU
+#define IPFT_MAX_PLD_LEN		24
 
 struct maft_keye_data {
 	u8 mac_addr[ETH_ALEN];
@@ -34,6 +35,7 @@ struct netc_tbl_vers {
 	u8 fdbt_ver;
 	u8 vft_ver;
 	u8 bpt_ver;
+	u8 ipft_ver;
 };
 
 struct netc_cbdr {
@@ -66,6 +68,94 @@ struct maft_entry_data {
 	struct maft_cfge_data cfge;
 };
 
+struct ipft_pld_byte {
+	u8 data;
+	u8 mask;
+};
+
+struct ipft_keye_data {
+	__le16 precedence;
+	__le16 resv0[3];
+	__le16 frm_attr_flags;
+#define IPFT_FAF_OVLAN		BIT(2)
+#define IPFT_FAF_IVLAN		BIT(3)
+#define IPFT_FAF_IP_HDR		BIT(7)
+#define IPFT_FAF_IP_VER6	BIT(8)
+#define IPFT_FAF_L4_CODE	GENMASK(11, 10)
+#define  IPFT_FAF_TCP_HDR	1
+#define  IPFT_FAF_UDP_HDR	2
+#define  IPFT_FAF_SCTP_HDR	3
+#define IPFT_FAF_WOL_MAGIC	BIT(12)
+	__le16 frm_attr_flags_mask;
+	__le16 dscp;
+#define IPFT_DSCP		GENMASK(5, 0)
+#define IPFT_DSCP_MASK		GENMASK(11, 0)
+#define IPFT_DSCP_MASK_ALL	0x3f
+	__le16 src_port; /* This field is reserved for ENETC */
+#define IPFT_SRC_PORT		GENMASK(4, 0)
+#define IPFT_SRC_PORT_MASK	GENMASK(9, 5)
+#define IPFT_SRC_PORT_MASK_ALL	0x1f
+	__be16 outer_vlan_tci;
+	__be16 outer_vlan_tci_mask;
+	u8 dmac[ETH_ALEN];
+	u8 dmac_mask[ETH_ALEN];
+	u8 smac[ETH_ALEN];
+	u8 smac_mask[ETH_ALEN];
+	__be16 inner_vlan_tci;
+	__be16 inner_vlan_tci_mask;
+	__be16 ethertype;
+	__be16 ethertype_mask;
+	u8 ip_protocol;
+	u8 ip_protocol_mask;
+	__le16 resv1[7];
+	__be32 ip_src[4];
+	__le32 resv2[2];
+	__be32 ip_src_mask[4];
+	__be16 l4_src_port;
+	__be16 l4_src_port_mask;
+	__le32 resv3;
+	__be32 ip_dst[4];
+	__le32 resv4[2];
+	__be32 ip_dst_mask[4];
+	__be16 l4_dst_port;
+	__be16 l4_dst_port_mask;
+	__le32 resv5;
+	struct ipft_pld_byte byte[IPFT_MAX_PLD_LEN];
+};
+
+struct ipft_cfge_data {
+	__le32 cfg;
+#define IPFT_IPV		GENMASK(3, 0)
+#define IPFT_OIPV		BIT(4)
+#define IPFT_DR			GENMASK(6, 5)
+#define IPFT_ODR		BIT(7)
+#define IPFT_FLTFA		GENMASK(10, 8)
+#define  IPFT_FLTFA_DISCARD	0
+#define  IPFT_FLTFA_PERMIT	1
+/* Redirect is only for switch */
+#define  IPFT_FLTFA_REDIRECT	2
+#define IPFT_IMIRE		BIT(11)
+#define IPFT_WOLTE		BIT(12)
+#define IPFT_FLTA		GENMASK(14, 13)
+#define  IPFT_FLTA_RP		1
+#define  IPFT_FLTA_IS		2
+#define  IPFT_FLTA_SI_BITMAP	3
+#define IPFT_RPR		GENMASK(16, 15)
+#define IPFT_CTD		BIT(17)
+#define IPFT_HR			GENMASK(21, 18)
+#define IPFT_TIMECAPE		BIT(22)
+#define IPFT_RRT		BIT(23)
+#define IPFT_BL2F		BIT(24)
+#define IPFT_EVMEID		GENMASK(31, 28)
+	__le32 flta_tgt;
+};
+
+struct ipft_entry_data {
+	u32 entry_id; /* hardware assigns entry ID */
+	struct ipft_keye_data keye;
+	struct ipft_cfge_data cfge;
+};
+
 struct fdbt_keye_data {
 	u8 mac_addr[ETH_ALEN]; /* big-endian */
 	__le16 resv0;
@@ -155,6 +245,9 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count);
 int ntmp_rsst_query_entry(struct ntmp_user *user,
 			  u32 *table, int count);
+int ntmp_ipft_add_entry(struct ntmp_user *user,
+			struct ipft_entry_data *entry);
+int ntmp_ipft_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
 			const struct fdbt_keye_data *keye,
 			const struct fdbt_cfge_data *cfge);
@@ -208,6 +301,17 @@ static inline int ntmp_rsst_query_entry(struct ntmp_user *user,
 	return 0;
 }
 
+static inline int ntmp_ipft_add_entry(struct ntmp_user *user,
+				      struct ipft_entry_data *entry)
+{
+	return 0;
+}
+
+static inline int ntmp_ipft_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	return 0;
+}
+
 static inline int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
 				      const struct fdbt_keye_data *keye,
 				      const struct fdbt_cfge_data *data)
-- 
2.34.1


