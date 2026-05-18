Return-Path: <linuxppc-dev+bounces-21084-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A3DCD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:23:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrRV0nBfz3c6c;
	Mon, 18 May 2026 18:23:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092614;
	cv=pass; b=AApdziyt8/FaFfx9KOqWTz4Yi2qvzZix6mJFGe9cycr08so6J4QhLHabc1wnNojrtRn/sNUcyU+Xl3wXHdWGiYhlLHbWGtXKgzNYS8UO1b11nqtZpe33IwqNAx2XzroAFRErD5aA8CrPC2/yj/HwLX1OJjAlhGKC4u7Lo+a5zlcXKokRGmRN9eQDfeBdPMhJ6u+8Fw7WaIoTCbVnasuP2f2zBX4D8d5YsDfc0fOBw9Eq98AkIqksMo7ujENOtWBLhfUIaNlt1x97+w324w6naWLtAagK6uNIT8fG9jC6Cza5m1F+5YCgJyJ+LZnUnTnhHC6APRSc4fjU5ppkPZd/Xg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092614; c=relaxed/relaxed;
	bh=/B62fPejed7Ldum3h06+M+/Eww4lOevQpJ4rElrPhHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y1EAamW3wkoR6iZ0ogB82vHMagm6uW3qfZ2l6xKDRo1P6w2DLl6bVkyHzTjhDx3Z+12l3OxWSDUdTneXyhRztPbdj3zgUaC+XZ+BhyT+R9pFPu3eIFv8/H8HEjUnABbW/zeHW7BFI6dp+4ysm3GHpFvURfE7s2e+zwXim7t76YhE7tzuQ7WsypC0Tw9G2SR624ZZtEUTtfTLPttrgHpV2j7EbsVIDbT+l9/7Ru1zuIQaFYOLPtBDOmylMzgak/8xRWlZb6ZYUN5nESimel+X0UA9FpCCnj0f5m9ed+D+/ZRZDfQ20ZAlyFB4bX9wrlmXfMzddE6U302Gx6immhy15w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=B3gW42+n; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=B3gW42+n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrRT1WGGz3c4v
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:23:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKs/APF3yZJu9t4iprzpLSnJGCbw3c2XXHvL0/dVgqE6cv4qmo3ZQl9Ewkyp8p/vjFv2h7xHV93+idgofsVsGUvHuFwq4Goowu/bDT6VV1/GtLEXGoppDfe0h4q4v0rZD4lrjxnWzyE8ibkiR3T57oWlGEbf1sCcY0j1bsYzJEDoVvYlQ9sXrTdjjjs3kAxiFse1EbJnTBwPkgEv0h/wYFMRhYahIH/4fj64NoHBRIUn5gDzSfxXodGSt8uUheNFKY+F/A588QurQ4VTRbqG7jhXdGRooUPkvvx1i3SnlWsWHvyDKgakyJaGSbI+bGZKNC4/pXERj9hs4Y3COHb/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B62fPejed7Ldum3h06+M+/Eww4lOevQpJ4rElrPhHQ=;
 b=K8999bjtqFnYQ/Nta0CY2hd5h2QYG//ZDbR/V9ZTuFGUn+o+sS8tRuYcaP8GAfShlle4RFgG1nvYFwTnYJd+GVvZqhjo99vj4P1vYozJ1kbIwPN5Z7PhbIwGUsgdTtI/QAC7clQLLnQ3OEx3qszRIzTSyVaCml4GfIdql5Jub98Kn0xZViT9Adnn/QdXcfbpscxcqyIFm8Nujq1ilNztXFlddhFDMZmwCAP6KHZJExtWJKAjyl4TTT53f3yrekAqtHwxDxqIopr2Z5Yd4vfWea38V2WnL1BjtjiJw9P1iPOt5/IckZl2qCu6KQr1LCig1R8BvKHL7VQuRnd4RL/Pjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B62fPejed7Ldum3h06+M+/Eww4lOevQpJ4rElrPhHQ=;
 b=B3gW42+nuYL+k22a56u5fVSu49LRU9Bg2tFGe6iohikqPQMLiTtYPYAwdJYFa+L68P5bwiVRHxlSkyiKL8176IpF9kfFyIsTnaugny8NyqPWdGBoE/jsrZFF//k80cFJ21GfLGHdPxekqrhJvHdY7shK80xQRGHZAxiJKT9V0q8z7hnt6GZIRV1XCJ6AaNgQgzBi2MqtstRwCg5wHYaFhimCD2mgJpgJ22BcqqHVaMZGkgpF8js90DMbgHmjIYjpxPROzDdBM14Oe/EL7ZTvUtEMrpJtH4Rzu/Jdehu2j0a6RkwxaVO26mb6Zj9hu6Za3ESjk0XqTKce1JZmryNqNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 08:23:27 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:23:27 +0000
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
Subject: [PATCH v8 net-next 05/15] net: enetc: add support for the "Add" operation to VLAN filter table
Date: Mon, 18 May 2026 16:24:56 +0800
Message-Id: <20260518082506.1318236-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518082506.1318236-1-wei.fang@nxp.com>
References: <20260518082506.1318236-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM9PR04MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: f073a3ec-cc4b-434f-fff2-08deb4b6bc64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|921020|18002099003|56012099003|22082099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	grNeUTIabIFRNMDT3Z94ONZy+nmbANTS7Ag7E+87hpf9hiwMJFt1Uw2SwHpSBVFN+BgswqjgpsA7OmUIiFTAwjbgzHXtE/hBlIZhZ1IaDv4IBQ6MSW5shq6+Ev8OF1vdIab+fSNq2Qc/w/Kj+ovk+44tDQxUcq3azuwr90G3D1tHg2VgLFoA+H3yy7IS2LyxvmSQQcuIvs6bQ2YTEcSTnorItygxdCfumDUB2zP1CBIHZVBa9q+gBC1CZQSq+e1lzln8DYYp3fm/mNS7SRCkqzLZnNUzF/ijTblcS0yObomqWE3cbfpBaljqzxvYZqE5JB8adG858oXOUhnkQoZx3MktnmrrFKxO8x+4QUOYKFI4+z2W0KSmOm8QTYU51RAmbgNCFd2BqvTlQORuSyZtZC/9bpz3an9Yrpf7FQQS/wPGEIKEv/bvG2WmPrRXoyJPlXVcUJNtZOEvWI4KM8FNn+xRNFClLxI3rFfx0uTQ4mg9U6vzoScvZU8tkqEuH+MmO5TcXm5sjKp7Xdj/y0ThyI0BiSmcFmVEAIv0+ZuanhevYWS1nUN7PuTQv1QUAWlUDo88EIlNya9HD1BuZrA29pGh9TDMPAFJb4D6qp28sHvCOD58KBSbfuW2p2T6D1vN/xGv7WiopRsfh4iG0U5QGyuI7xTKgZhp2KV8kap9ezHjRJVOV9z9TeFQC+cW2zD2ZxebQMrE92BQh4iP/394LVTSPgRqk9vpOpIiJJjLoDlAICYkdHM10Ol+Yc5GLQUseqn+JlVnZ1PE5cKordqyQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(921020)(18002099003)(56012099003)(22082099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oJdeVN2c8jX1y2qq3Sqxvieg5yV+kTL+q5mZBKbpiW3oJAkjmUisUoVZylJi?=
 =?us-ascii?Q?FcRBPQ3CWUqmp4mgXttwXlGajB7xdNsZyTPe9KMjCyB/8XmDgoMBCW6z8N8T?=
 =?us-ascii?Q?GQI0wEQLEgqhBF5Jy9TOi/t7l+cnlOacCo0+3N/k79CjhUhfgwKRmkMoj3CH?=
 =?us-ascii?Q?MNBAnmoCC/DT2GR+CQGJvEnMuYH7MQlXLVkT3nQXIICgk+DotmLuwuKRgEmP?=
 =?us-ascii?Q?jhclBFHxtSugbGKM3kPQyVATQqs/B6lvhCGDEQAKYuwZSrd2OyP8Yho0g0Kq?=
 =?us-ascii?Q?xVGrSWnK/lM2ER/2E5wE91etszuvbAgpRKAk6WPb7GSlhTiXE6W2OEKCjcGj?=
 =?us-ascii?Q?iUhR5Wq3HfSWp06+bVof+XI68HpA6XkxOPknRBRSGTpmxcyirTEczjztajOp?=
 =?us-ascii?Q?b71WE4cjmDTYXQyWlcWNM2Aqvj99AgJvVRqyPlyDBIbClaoTzsi+hL+Zv132?=
 =?us-ascii?Q?QysfnsKoCQSEz4DA7K9g4r9nweUUBh4Ch1YQyYWg7mMjfmlRfjqUo+Eu3a0W?=
 =?us-ascii?Q?PzVxsmViKEVSGwA6Bq+IseMJ0SLdi//xlTKck6CDAfIFaWEZFzgnfQrw+3Dz?=
 =?us-ascii?Q?V8aO+ySn8llwykae9g5m7zKdVG4CP9aJBdVPZcCajgCfj+4FbVWf9MNWPogK?=
 =?us-ascii?Q?eFDC30lcpbZRTpAzeRDCnUFeGlS6f3LBr7WBRtX7+3PEqikCEbMMV73BrNVq?=
 =?us-ascii?Q?7Rto02XNF4s1hPRzLfEMKPU3cwgJ+15cQ3vw9Js1MgX30b71/jhaKzwnHHnx?=
 =?us-ascii?Q?DKTvhAL0E6jJFviibvnhGFm0s1GKoper/KQNpQrzuyis8/KMvcdTIOQp1a0y?=
 =?us-ascii?Q?KLT1BNd/b/p5DxpEfXXb3N/AM2hlmvOepXrpvfgwdQ61v9d9w8HZwLEdaZQv?=
 =?us-ascii?Q?8SRa4joZf5h/z7Sz3Bavo5oYSJTHtdUZ5+l2UTQ1WQueU9wCTsH8Flg+alVX?=
 =?us-ascii?Q?prs+vpI3x/BbDae9xiZTbaLCopFoordy7L9P2dce2CZsuYaKUtRf5d5Pr3r9?=
 =?us-ascii?Q?IDVbc9ttqYZt7wX+4M3xUh2tCtAO8MqGid1g92q3z2X0LOBL0zb5KfA2cRtH?=
 =?us-ascii?Q?ZvDvO+TPRHYQxh5BhS55vPGfkIs085IBtx8XKyhCtmrEy/axz6nRcntOG54T?=
 =?us-ascii?Q?iDR6LCPsjGs9++jrpAJNvLhmmZMPmXfsImkzX+Sb7f/cwC4d0cZQvBKuot06?=
 =?us-ascii?Q?tl6WumawUm3viiUbYk+qwn/jLU5D6iFMwv+IvRrwy+ZDqlyckuJumJFn7tqH?=
 =?us-ascii?Q?uyu21sngZByNDjBfdVVoRwkBfd6UyGv8/l6Zi2Z1XLqnNN5UPlyk9+FGGrOH?=
 =?us-ascii?Q?W2tt7EO7OuAGe+CgXTyrMTqMRarsKxGcQezrDTiZ2XLPjNWNrAKXWxRkbfFZ?=
 =?us-ascii?Q?tdEB+eqttpF09z9bkJgt2lMz61jXdS0CKHc1GyJsdOc+inVyC+4/TurgD/yQ?=
 =?us-ascii?Q?2k84QqkH2Lw7ZfQBaQZm2U4/OqcGnvBJoDytYRFU9j+AR/hydwYK463ralT4?=
 =?us-ascii?Q?yNcNRhFs4UsSi1KEzyC+kPq7SeIGnS/50UfOX4PBVN6l6C1mWCFL3tkERFRw?=
 =?us-ascii?Q?fPh3y801zoXZH2xOEEgdYvMsgfVorYHLJYZr4VCQNFt5ehuhEx4Rrza0vOx9?=
 =?us-ascii?Q?d3zVFWwd+WVAVHZdPb7srRTiZ3eIUmC2i27PTVckSShVJmpqsbIYPIEj5aQ/?=
 =?us-ascii?Q?IYfiI4OK4YlYl0jX+8xlotOQSdxa61m+8oRgpjWkUPh7ZkGNE+ObYAVEo80m?=
 =?us-ascii?Q?dS++uIOn1g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f073a3ec-cc4b-434f-fff2-08deb4b6bc64
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:23:27.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFd0rycSDBAStWavyCwfzC1DFMQY2qWkM59L2+2w/hJUAG0/0jIO/Y08g2tOej1XxINdpFuJWa1xZW+wxfDbxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713

The VLAN filter table contains configuration and control information for
each VLAN configured on the switch. Each VLAN entry includes the VLAN
port membership, which FID to use in the FDB lookup, which spanning tree
group to use, the egress frame modification actions to apply to a frame
exiting form this VLAN, and various configuration and control parameters
for this VLAN.

The VLAN filter table can only be managed by the command BD ring using
table management protocol version 2.0. The table supports Add, Delete,
Update and Query operations. And the table supports 3 access methods:
Entry ID, Exact Match Key Element and Search. But currently we only add
the ntmp_vft_add_entry() helper to support the upcoming switch driver to
add an entry to the VLAN filter table. Other interfaces will be added in
the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 50 +++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   | 19 +++++++
 include/linux/fsl/ntmp.h                      | 24 +++++++++
 3 files changed, 93 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 6074eeafd5a2..db74a9107975 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -22,6 +22,7 @@
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
 #define NTMP_FDBT_ID			15
+#define NTMP_VFT_ID			18
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
@@ -268,6 +269,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "RSS Table";
 	case NTMP_FDBT_ID:
 		return "FDB Table";
+	case NTMP_VFT_ID:
+		return "VLAN Filter Table";
 	default:
 		return "Unknown Table";
 	}
@@ -699,5 +702,52 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 }
 EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
 
+/**
+ * ntmp_vft_add_entry - add an entry into the VLAN filter table
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge)
+{
+	struct netc_swcbd swcbd;
+	struct vft_req_ua *req;
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
+	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0,
+		      NTMP_GEN_UA_CFGEU);
+	req->ak.exact.vid = cpu_to_le16(vid);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_VFT_ID,
+			      NTMP_CMD_ADD, NTMP_AM_EXACT_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to add %s entry, vid: %u, err: %pe\n",
+			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index b0b5805ac4f6..575ee783be47 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -156,4 +156,23 @@ struct fdbt_resp_query {
 	u8 resv[3];
 };
 
+/* Access Key Format of VLAN Filter Table */
+struct vft_ak_exact {
+	__le16 vid; /* bit0~11: VLAN ID, other bits are reserved */
+	__le16 resv;
+};
+
+union vft_access_key {
+	__le32 entry_id; /* entry_id match */
+	struct vft_ak_exact exact;
+	__le32 resume_entry_id; /* search */
+};
+
+/* VLAN Filter Table Request Data Buffer Format of Update and Add actions */
+struct vft_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union vft_access_key ak;
+	struct vft_cfge_data cfge;
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 4cfff835954e..3672e0dc7726 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -32,6 +32,7 @@ struct netc_tbl_vers {
 	u8 maft_ver;
 	u8 rsst_ver;
 	u8 fdbt_ver;
+	u8 vft_ver;
 };
 
 struct netc_swcbd {
@@ -101,6 +102,27 @@ struct fdbt_entry_data {
 #define FDBT_ACT_FLAG		BIT(7)
 };
 
+struct vft_cfge_data {
+	__le32 bitmap_stg;
+#define VFT_PORT_MEMBERSHIP	GENMASK(23, 0)
+#define VFT_STG_ID_MASK		GENMASK(27, 24)
+#define VFT_STG_ID(g)		FIELD_PREP(VFT_STG_ID_MASK, (g))
+	__le16 fid;
+#define VFT_FID			GENMASK(11, 0)
+	__le16 cfg;
+#define VFT_MLO			GENMASK(2, 0)
+#define VFT_MFO			GENMASK(4, 3)
+#define VFT_IPMFE		BIT(6)
+#define VFT_IPMFLE		BIT(7)
+#define VFT_PGA			BIT(8)
+#define VFT_SFDA		BIT(10)
+#define VFT_OSFDA		BIT(11)
+#define VFT_FDBAFSS		BIT(12)
+	__le32 eta_port_bitmap;
+#define VFT_ETA_PORT_BITMAP	GENMASK(23, 0)
+	__le32 et_eid;
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -125,6 +147,8 @@ int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				u32 *resume_entry_id,
 				struct fdbt_entry_data *entry);
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
-- 
2.34.1


