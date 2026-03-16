Return-Path: <linuxppc-dev+bounces-18228-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1905F4643A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 09:41:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ98d0Kzlz2yhG;
	Mon, 16 Mar 2026 20:41:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773654097;
	cv=pass; b=ib1hgqjChvab+/vR/pBC4Gw5Xks/p/Bc4m8nYfTFqJ1kn2oI/F/bvMZmco9ArU0ISlljNQXLM5jRLtfb3KTT7t87/7FVdLypp++rcLOMEAWJfXWir/bnn2PAfVLVuxJeQ7JOTnP5ezXJXrANimJqC2dx/ToQCjUGCVTJZ2ptC6KPac5OJXy+/uUodouL6+n34jTBISDjEkN1GToepOfLylO+YqERhIwh/nE8Y9RXnROWuBZPe3X2FHk+2wr/SMx/SsXvchoX4EICjGWwTjEaVpgLVNqRe45+xOQZOclUfTotbgLTUf8MXNqEnyn9M8OBUtHJkzZAPP0LubZCSoyyQA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773654097; c=relaxed/relaxed;
	bh=pKEUnRJ5C1qQcspSblD9yav6rNUhmBFQRiaqsPx2hd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ca4VAeApz2Qg4gH6+V8ORduPqOA6PLppKhsuYDUXRBuk3UqKpURLfQRcgzcJY+R5651r0aSpn1Dd9HrCbCVJmGdeJIzLEGbfi97QAweXebxAoW86WeIwAMUJI3rHmtsvS0PX/Q9wtTquPExPzMgEUx1gIMUaNgYGgWrlPaV0A062itBTkJqE10p0FjytuwMo/2VNUKaVg71JlXhhBSrVGUd0ARPpgdxk4aQzd8GhS6QucF2oVmGG62TYblIjVoAywsOKXHAUmwfmHO/qhDwBbZjBYvlfcvS30WXI1XXlJOSD7AqQBnWzEx61bCF/sl0g3t4n0wHMwqR/Og9DScMcJQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HHLb90KG; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HHLb90KG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ98c0fHFz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 20:41:36 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1hGSNbh+DaudfuNBGkhQCjHcL2ojNVIODJW0YPCJibRHEHz2GuTwdWFm3sVVn8iVYYxU9CrndWXl9/qG7pzeDcEycQi8YG57sQlWM0REr8fpCBPiKTgdHyOqqWN65Y3SNiKplrXHXDadjZhRFrtG779Qf9veMf9Q4uWvwmyVbiZnNWoNkjp2W0pr0U3C70NPY4ST5lxuJq6PjWUSpnIoJmXyWGjKTWJy8iSO1R2wz9R45INwu/BGwetQ0UG4/uUXT/KkekrPD20fI/OM/wW873p1Rsu0TtZPmRjJEZ/wIT2jfv8Il8MvpNbNe2gV7wotpDpXMLK2u118xz49dgVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKEUnRJ5C1qQcspSblD9yav6rNUhmBFQRiaqsPx2hd8=;
 b=lMYU/+XNueSOme/3rpwY79rhw+HWE1HU0BtNf/c2Bis9Q3fobABlwv7/DSB+NxjdkBJ+skl5DD5VK19fq/IgOlGfBMddsHWLwTsqcLg4Q4m9jZPgx3yIw2ucTl1V0ky2+VGMMT2SLyRjaCa33kxx3jJk4oT0QmdQ26r7i2Dk/MGW0BFzYmLDgmxbILzNTkAQqlcnnGnafoDFtYeXppaWuPb9+Me2A58hPqV6Axn6lrgiErllVPs1wfaXChqkYxjW5sNfsI5BYuRes3qESEfCw/wBO8WqIYgqNh3+5lERh1UlUIk833hmOUrIWUf707Pl6gQyrnfNBzfM6emIMpPIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKEUnRJ5C1qQcspSblD9yav6rNUhmBFQRiaqsPx2hd8=;
 b=HHLb90KGbS7jpZ+2eWz2BllJmO1H6O6ipzfRgXIvmxjJu6nMhc1q+JSkk38lSN2siJZLu7NorJY2rvhHOYS+zpXtGM6hD9KjJpUG8HB0TW6WrzLyZhXe4XE+KES81E0bWAuUIq8fpQIxPBe59UsMsh2wgFvdBpg4VCk6nlaXI7H3ikhyfjqIDKR9+13dlu95l6lnwbcnW0XTDfzUG8YrBZ1lrg0omYsIXhy5V3iFLiSzkK0Vjqn/yZo6KJikXQF2BN/Etw+CooD0lrnVUhlQtJ1sTCqPDxn9OWLpMksBEWWZOozIrt1vrMx/zz5Nn+cRqLiZlxVDbwmEtNO9PYoHJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 09:40:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 09:41:14 +0000
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
Subject: [PATCH net-next 07/14] net: enetc: add support for "Add" and "Delete" operations to IPFT
Date: Mon, 16 Mar 2026 17:41:45 +0800
Message-Id: <20260316094152.1558671-8-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ed523a2c-dc74-4b88-69ef-08de83402a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|921020|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ieZxePBwsdB4/f7fHfpSGzrnrd9whKc2LlrdbDRlwAlqV7lvbarFI5b9EwGnW5evon+V2kCtksldpztDAhikrYNJHVvNwH6WCNocXyZuNX+eJaQ8ulFCF2rrNPElmNHizxQ2s2je3WPGdK7Txe0poCm6CNyQ91HswJGF3XKrq9bx0u3N5VpJCSmgiX1BRcoVx8zdo29S7iFuRqtsdy7VZ0Iy8KEJmSsCOKlXnDwPhFfP5x7svWB53K2dMQl3v01hpupPY+uYVm4wxK3Vy0hMPMVDBJl0XaXsEKCP9pxYWj9QFuJG9Tk+H8A0bGwpX8QYzqW8lGNZ33DVkC8uTpgkLj1D9nln8l76Y6wCywHho9ZyRsiBOIXwqQMsYuKrngQ222Y8VfzbgIVz/50hDcL6ml+uG9v1Jlc6liiLEvzLjtM20/RrV6VlCCxHtA8ouCjA5/CAPzO+t2M9hN/brSVkpntN6rlgQe1dhT9Xv34UijuGnyluyXSpjzM2SclIzlNQUplodeSNmYmEWuRn1H3/0277DXp2wNEJks+fXEgrC8tEVrvKDgnQddb9Yee1xiGf1rKYChGdkkXvfIEpt5ChH3JgVxifCKu3iEl6xT7cou5MPHpTjFGsRvG2WU0+/QPRKd+f1rzEKesVtBNgZjklUCv0v327HsggwVGR8/q67d9Yq6osxrvz7TZwckumKh5hj1zkhtBfyLMAvZavPSZO4RAGmJj9Gnt4OAwL7A11NPcRGQg0MlMKLYJXVFd/DuvHftB/fRN7ZayLNXb2sx+iT4ERe6OqnHkmNpECXMLulVSoHWY3EAV15aHsxyF0Q4hJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8UJB9vDSTGT3PYd/9di2nVwMVtu4NmyRxQPBgaq4pkb9/ePsOnq2RD1g1EmO?=
 =?us-ascii?Q?fsJCaRrYejkXMTp2UpLDvcWiW+HlIDSYaiw9COh7uOXrRW35i9xSwNbDkR6X?=
 =?us-ascii?Q?wCNaVe1Oy6v/jY6q1oHa/QKBn/YVCaAI+DYd0wsF1HjMov0Rf1SIpkc6ITiP?=
 =?us-ascii?Q?vMEEqrHh+k9LQnzvGm2MFNFUC9IYEgzgrqCOpiiP/FUdIPOnMwk8FsAgtsMT?=
 =?us-ascii?Q?+UPx88lno5O8/ZjAFPEfqbUPDfEe7WNGa1JjZ2OTLTRVxTRIDTWrG1UpfgNF?=
 =?us-ascii?Q?OyXSF27HToIB6iYav5UbETGd87ZKA3UOKSM8Va6oEg9Ma0KdQwrcRlS9alEc?=
 =?us-ascii?Q?1ScfUzBlJg/l7tvB0SZc2rrFkMeJ2SOgrAbCMRJArhegFQDplFInNs5AGrsr?=
 =?us-ascii?Q?Z9NPOLwEMZIjQ8pqZgu1F00zyJ1ZCsEVBLDB1+SxEF6bV9g6CucTh34W+TUv?=
 =?us-ascii?Q?bL+7K+uTOiCoZu8kHqMgO0+HjbNLH5tRGbd/Z+X4Dknv7oItzkkJ/AjESfUg?=
 =?us-ascii?Q?X6AsgbZ7Q2nnXfqXFVu+56HtUplmZLyV689nCM2IjE4VuFyKZFSdoDs2+H2O?=
 =?us-ascii?Q?H9j7FVizlMabrMwiee0K3Y07sJKmOCWKuIq1C7XdHxO6rQHBlz+4hCp6oUAu?=
 =?us-ascii?Q?selez4yGxvXNclkIGvOszApYSm4pgbFRYPi7Gm5TbFPWMYf0zjpGvTfU5EOK?=
 =?us-ascii?Q?ckQPvEgXrQas40nTyasUPQcTrnPJf6c2AcT5mvQXUw6UQI8miRjQPbdnfjxU?=
 =?us-ascii?Q?socMKbibZqCBy7OhxDTXgQYXg/EPZnSYAKzlnS+RH9ADP/2+P/BTHPJkM7ZX?=
 =?us-ascii?Q?f/55xRrFNNFRgAySx1zQiD6fSyK8UTWT2z0Wzs//oj5/M0wJC0bRtKLw5Y6d?=
 =?us-ascii?Q?pJENrufX5iytxfTHxz7qG8SXKT/INFl6i7hiBNXuI0Iq6gyhRK/FKPtafX0Y?=
 =?us-ascii?Q?tMxZb47wYAkn5ojLxsB9cA0/gxanqebVJAI/miGqD25aUN23P5FC+a/IvtHY?=
 =?us-ascii?Q?oRCmLzGka/39vrdY2C9cKOf3rJIpSQFAXSpKo2XaFeMB5ktM74qmx1JTcqu7?=
 =?us-ascii?Q?BoHbhwwGuAaKCUDJIKZlEnM/2nid7Go1WOt0qMWdor7rU5SV+u/w4UjfnqYb?=
 =?us-ascii?Q?pD6l5/fVzPkegs3vq82BDWvEHTzif7JIntzmxfX9QxDUY/yYeEEOsIgVhur4?=
 =?us-ascii?Q?OWOFilMqcwBnJFOjprT7NpSWG6A9+SGR5DB36zIOeOTTZ0e5nwfek3iUoJpp?=
 =?us-ascii?Q?1R77DZWVKt5jxGRxzAATPt54qTD/9ySq7HZa+vXSgjGUoKi5u5p1ybaEdUXw?=
 =?us-ascii?Q?N36GOizviNGiIkX804juQkFcm0Acm8pIyqXjyLp3XAGtt9Ha0K/F6Sv+Zobd?=
 =?us-ascii?Q?EMDrhZPCOUmXtrG/7mFpV2YXlAGWhFJQA54bAH4uBlHg9WDpatyHNCTvNI+D?=
 =?us-ascii?Q?086MBmfUuphhz75W4hG2QaCir1CZP5cGBAgIPMoS728Tk3fZ9HeHGBJiK2CH?=
 =?us-ascii?Q?V/9UmdkzFSE5IA2/Q4PdBNwiqU6gUCBv4dMr+ZyIR0DOH6dW8FG6V+PJavnY?=
 =?us-ascii?Q?2sroWVi3oB/D3Emtkzw2q3WKYDr77cAIw/czTaX+UprFzGQokSQOveDRtHhC?=
 =?us-ascii?Q?GryWi0FVkajCqVOvmkN/R7IqlNcL3JW+zzkDe/uQpD1gmBRllV68/VAv+Nx8?=
 =?us-ascii?Q?TB1Rfqwk1Khnw8LKkUMlC1e2YbqmBBhj1lP8suE7h5E5lcd2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed523a2c-dc74-4b88-69ef-08de83402a19
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:41:14.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5OPSiwavZ5a1SgNREtbak9Bzb1Kba1ZEPdzxGeCd4I9GTquiTJ7Qt/pI5x0zUYI+yugdhE5olfe7qeg/NXoQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195

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
index ef38ebe94da8..9fc3422137fc 100644
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
index c5f6dca7b660..9411ec9f1777 100644
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
index 925a455935b0..f6d3bb2e318d 100644
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


