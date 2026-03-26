Return-Path: <linuxppc-dev+bounces-18801-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC7A109E54B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 06:28:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDNy4d5mz2yd7;
	Thu, 26 Mar 2026 17:28:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774506498;
	cv=pass; b=HYYhpPWR6XXncSXPf5HzowFB6YkYbeq9b4E5LTRgZ8NX8a+Lj0w4bIw1iU5wojbTeiySWqvyA5javM4HSRFUDSIKuF46iBEKT8cFJDxgJVSTO6JRfkjpGsDX57CPLQWhBSoK553IDC5rZYsVEtlA1AZn7AVNZoNY6SSUiDTsp/vfOhJxcK2uLFhPtw264QaXGbI3V9dJdG8hx+gU0CaHWZdySKKFRKUPdrB/IVKoa/Qup44XOfJEw+r9H479zDkPv4WhZhz3i5l08BlxKvdnacWmze67wnInEuB3YkOtnpBxcOpnRXgsB3pFP2QZDAhlrx+fsoQHV72Y5mgPVUSruA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774506498; c=relaxed/relaxed;
	bh=Pf9Y9p6ICXZrv2WVScN5pUjaB1x+5qUjldE+EQle0AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzjBUerxUCEL+Sdb/oZvRpPC0LvWSifrLbd9zW9Zft9I+twoEYTm0E4xnlJbquCBGo7jjGIy8k+4AwJ3/4sgROlmDJ6aMAlfndbxu4svAZ9sBrafyeZGwL8Ac/qKx4B6Bibf/bsYm5UEc9yt4uzXs3s5e+sAwxg4Bd1WJx1FLXtwCSkigE/Jrqmr5uLnSFnAVm8oOhHqzNEmmcOnhawOb0Do9DqPKAgQYMlQrtFJmaTRAfeYw2MWtdEnxpGXpZ3ZijF4XPwLkBMvr3Atmme4kqSsZcZcMLQTaNZTvzVy4vuaNHRrZvgj8ucUjKj/aduAoGyhgkYAflzPAB3Ib/mo6Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=QlfUhMAB; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=QlfUhMAB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDNx4G3gz2ytv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 17:28:17 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lww+Ref+7DqyUuNpwLD1BUXCMV0e/5R81EBL4aW87ZOjTL0+Bw7Z6aMseRxqbWlEV9mcSF53bKvmUFJLhZJod7wgigViIgtBNaGFmMqEaGNmyhibwCsBMf9V9UAha+2O31QVS4HsKixQLxNyUZ6mqcJV4ZmzHJyZCBAASrTxfiWfQg21SRw73rzK5Nw9oda3cflPqE1UeZZhypSBUwQaBmMlhwrj8/wMZoxuHJ9T247Wp2PJD9exeHSgTUeWPoZrEfVEcaCh4j+lpJwzYtuH7ICRKBxbFYRINMSUndQGjTgDMlwXc24pvD6mbtftrhMqZdZfoj7448HwB+8FbuF0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf9Y9p6ICXZrv2WVScN5pUjaB1x+5qUjldE+EQle0AU=;
 b=Ssjo7KZ3kSsyufgk+QF7X78DhOxpvfoLZSGzZ8qToR0ZGbT87ct5QfYcFurfcNmWd+hIcbLHVcVNO91rLgtrw9HfYEB42DLxZF9gfNViJxlExW7P9sO2mzqEnterXLxfOSecA6CKZ8Oz3Qu9fVSi24jEJi877u1FOIriDKq1j1ib9GJ5EK2MkDAHbkpqfWkSsHT7AJF7WUvXdoCXP35q37wUZbRHY8dN9AZTZO4HvGzzxZ/EAhS9vnLABEqOh1i2XJxqgOTh30V2g8SqeIXbHTTKQkWF40WiIFkopRdOvZInHjXARwu8TQMA4LRzLbYb6noPdM3wwXhRJOMFfkPKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf9Y9p6ICXZrv2WVScN5pUjaB1x+5qUjldE+EQle0AU=;
 b=QlfUhMAB0/O8chmVb7L7DtzS6cARlZ9TUc9Au59EW3VRdIO+BUv8DgLsKFBUvxFOq3VGv1Jkd5+7W9Dt78wp46KIV4jSlh6GT26qBJq4Z9BtOm7TVC+HCAGZiO+I3rs+mwUv9fBlhXCYicFSohDMiglYnvO9OjCQjkW3BsKrGThVLxf8NajT2+XjvnuVNzyqe/mS66GICbcmGH+kT/2T0mxe/UOcGzIMZYZm1kCnc8r7w5ITYSHQJedGvXY2clLnJ5FSc+WV3OYzKQG7tyNfMk5YVN76Fe66sUy5w+z1Qj7z8v4eA/VGUIrL5Xmf1bIUWUEz0FPP+y1LSLb9Qh1ozw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10309.eurprd04.prod.outlook.com (2603:10a6:102:41f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 06:28:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:28:06 +0000
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
Subject: [PATCH v3 net-next 06/14] net: enetc: add support for the "Update" operation to buffer pool table
Date: Thu, 26 Mar 2026 14:29:09 +0800
Message-Id: <20260326062917.3552334-7-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10309:EE_
X-MS-Office365-Filtering-Correlation-Id: f28b4d40-53a3-45b7-c94c-08de8b00d705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|52116014|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/9/QQlfTgIg7l0OLKXNuFiL09E58ZKTkJl+owy/6MyBjrK8sUzZPFzZYNeUII8EDptWURv+Kd+XdMN+FJGpytJl3/12h/P6YZk4NVt8Vi96kjAgEOydnsZc70s8AQ6cjW0Ycnxy4WqvjEiXqnvS/BM7hpgzopLpX7cBbXClr60t7yDDWNjmnCBAVE9nD7iUOH9mb6dhNotMEG/z6z6Ae5WTfxFezCjxJAVTvaTf+zObuYVgBs27bnAxsK5SoCeTjf9VeAYWw80J+tx3BGaShc/c+YeLiV56zBU8DMWEq24rBoR+vxKr0o+ax0stgsEa5sN3eLKswPg6yPgMjP/Bl/7XGHYKauXtPkZ1UmExNYo69RjA+6cHCDR/NgPkIahJTnG4lThAKPFWLl9V5LDfBidSEqhlPgeiItKQpEpZxJWWwfPtMm7cY81wfRROfqrKW3serACVb+TLlpa50nk/UxFro6mRS4ye5oEhCKkdneNEk2VvHLd6eMzZisEZoX2NwApdKEAe3x0uSpWvQasx0uZr12IWe1D452w+BXFS4Vyp48lP7YOMhMPfRhLB4ZD/8+MdEGt7NbdenVlZC4bBHoNPZAadh0qwSbOPlUylthUy7ir/fMli44FXXqV8M+oLBYq4/6XBuwUgi9/RWHorQVkuSvTEzg5sa5ssJhhZMBQ1n0QEqVhG8XErtoPE6KltoAGCmF/3tvs2vXgu0BLkZk27TOMcfRXyo4ZQmDFbepz06uI6nitZNT0o1Co0dHxnMzlnf7m9hKTV2MYYSXaxO4VP3X6rBWidiIkOgOa2kNzYD/JvE77c6U0YwZvjiwqk8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(52116014)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BSKz2LwIDHndbNTxCxkQRWptd9zZnXIuIva2MldY2s5975vpvVK2lrL+quv6?=
 =?us-ascii?Q?y6jpUYALmm+87Ufyk9wTUT0jlAlTl3BDlYG7b8czD/yF2xk4AJO49Z2GSYkg?=
 =?us-ascii?Q?acT4Bo7E8nuIWQ3bQdaYCaofLflBI/NVSA7sLaEv3qcrf5mWoeP8gmhKXcgE?=
 =?us-ascii?Q?X9gTbJ5JaMih98aft13zy8q5Aq8yZJV1g7Vaifu4OkfCVkzNm8upnDCP4iF+?=
 =?us-ascii?Q?2062Hgo5E6+09C88gfo6F3pAtJ0+Vo8R+2dgEFYaOwbuy0u/cDt83UT7Ajok?=
 =?us-ascii?Q?2Tip+ANorHW6PhOgVAvgaPujpxrXYtBfoOc9RIkk6SXVDH6ZJ3YmJN8UGMtc?=
 =?us-ascii?Q?vWu2YEH9Rj5UlUqx0sG2QBfkS3lc3g+Z4+Dfj+90r+3GDav+r8m97s5g+YQ+?=
 =?us-ascii?Q?hSrIhQ6+okLJCqNN5FGEGJdg3ZxH8pCG/PeUnrSsTxRbCuzeEiN1Njx0Tch6?=
 =?us-ascii?Q?Ca0p5S8ZXPN3EQg0+6rB/v6fpKYKqpLUgRbdfsinI7PTaPkqippXnGtmn7Mz?=
 =?us-ascii?Q?JsHbKn1eu7qGVZxTDN7JiKMo55BUYeittQtYP9h5qlLUauBrIRJFOGGM60mI?=
 =?us-ascii?Q?gwFXdYsovpfWl/UifT121B+IicLxylHcsGFg2ofySY6TdSV+YfTKmC801psJ?=
 =?us-ascii?Q?Aoar9deLL+aSKb3Dw2oBiXv2CB+NLgP3IHk4//ic4ztR4I/VWqn8SwV3hZBz?=
 =?us-ascii?Q?vMWjzOcrBsqH27oWwrJ4poq7/gybP5XuWHgtmG0ze0qnXBWQpvd6JWCBm9OC?=
 =?us-ascii?Q?0/gb0FPr65/FdUXEULxGCZB3kmK0khie3JNarWL+p+1JfFMvQTvdq73J7aFX?=
 =?us-ascii?Q?8LGwQNmyWxW0yUnSSY2BAdZwGxFdpbs2oZoPFsUgQIg2fSNVBu+l3jDN2yH1?=
 =?us-ascii?Q?V/rZVuhfz7+xWs/imutSz7uhj4BY6boKvWo0+7u5ZhyDE5jYRjzQg1wQQ+8G?=
 =?us-ascii?Q?Py1cUbVOtEASpr0lWwEkHKfLhwY2uOArrbMB1pOXHvGXTabNKcTjHdYO3b/j?=
 =?us-ascii?Q?AKtQd2smkFnDB3c1niFlA0GGxAIssAD3lrUJ3xZ3GL7ECtsQPQDqsQbPq9MF?=
 =?us-ascii?Q?gzOJpJohYecXoT7gzwfyoorIZTPYsv+ezoV0Wz1GJiYqjAW4nl++FRYaOxR7?=
 =?us-ascii?Q?74aY4ptntuHYkSrWf4ATFwPmhznBmMuFH4a+UlrZzT1XYtKNFnUiy08USae7?=
 =?us-ascii?Q?Z5va/rSR9326ITARWHD+rvubAs1xl7gJfPfhnvy/ks21eS+NlFt6b1Dvx2Tv?=
 =?us-ascii?Q?Nt1h2zWW8EGMZZJP719JlzVK8+OX7JmE6oDpvLYWkwqxWsvPZJ++vyKiH/B+?=
 =?us-ascii?Q?/siuvdKwb1Sa2Je84OL4xt9tiM8UyHrstDabOcuHS8vN0Q3tbs41csApo1eQ?=
 =?us-ascii?Q?iEe2o5muOlHPgvlqBT8LpxgMaQ8yjJLQmBl7usUFnlxTmUXwboUrLeDy3MEg?=
 =?us-ascii?Q?T5oVOIiiS+Qfc6izwnvsDIpHJrK4uOH01qVUC5kQz1WQ8d189CATD78ruhx9?=
 =?us-ascii?Q?S55hpigQ33LQIitaXGJgjYXg7YzLtfYx+dZViB1jm9tZ7Wsb7ftmz9u/sm+7?=
 =?us-ascii?Q?/vJe+BplwQd8aUG6ZyC8qRJXmo1Lb9ZaAVoAeeVJXzMh39YJcR4bul1btMJK?=
 =?us-ascii?Q?peBKmthE3jHme/dooiBAZ+h2rEl8QdcZjtnekWFIDQVkjSMzMeXJmWF1topM?=
 =?us-ascii?Q?nhBRmYYenpYpmGd5vnGm7p9MMXPGhKfiO5CFxu8Y29NTHgTd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28b4d40-53a3-45b7-c94c-08de8b00d705
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:28:06.0548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lY1L3OrThfiS4CAonCpkxuiPHS2hSqJxodKlO2gqEYCc/SAaYGUrUEqMHV3q0SQpUsFFWgTM/1uvcFPghZMbRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10309

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
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 39 +++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  6 +++
 include/linux/fsl/ntmp.h                      | 32 +++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index d7d8a37078d1..3c59b355c142 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -22,11 +22,15 @@
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
 /* Query Action: 0: Full query, 1: Only query entry ID */
 #define NTMP_QA_ENTRY_ID		1
 
@@ -234,6 +238,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "FDB Table";
 	case NTMP_VFT_ID:
 		return "VLAN Filter Table";
+	case NTMP_BPT_ID:
+		return "Buffer Pool Table";
 	default:
 		return "Unknown Table";
 	}
@@ -702,5 +708,38 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 }
 EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
 
+int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct bpt_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct bpt_req_update),
+	};
+	struct bpt_req_update *req;
+	union netc_cbd cbd;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	ntmp_fill_crd_eid(&req->rbe, user->tbl.bpt_ver, 0,
+			  NTMP_GEN_UA_CFGEU | BPT_UA_BPSEU, entry_id);
+	req->cfge = *cfge;
+	ntmp_fill_request_hdr(&cbd, data.dma, NTMP_LEN(data.size, 0),
+			      NTMP_BPT_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_BPT_ID), entry_id, ERR_PTR(err));
+
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_bpt_update_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index d2a6399b0a36..7d50af7745c7 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -179,4 +179,10 @@ struct vft_req_ua {
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
index 2aedea17307f..a54945dcdc61 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -33,6 +33,7 @@ struct netc_tbl_vers {
 	u8 rsst_ver;
 	u8 fdbt_ver;
 	u8 vft_ver;
+	u8 bpt_ver;
 };
 
 struct netc_cbdr {
@@ -116,6 +117,29 @@ struct vft_cfge_data {
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
@@ -142,6 +166,8 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				struct fdbt_entry_data *entry);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
+int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct bpt_cfge_data *cfge);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
@@ -213,6 +239,12 @@ static inline int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 	return 0;
 }
 
+static inline int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+					const struct bpt_cfge_data *cfge)
+{
+	return 0;
+}
+
 #endif
 
 #endif
-- 
2.34.1


