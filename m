Return-Path: <linuxppc-dev+bounces-22074-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A47CD6E75
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 01:45:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWklz2DcXz3brt;
	Fri, 05 Jun 2026 11:45:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780623935;
	cv=pass; b=kDFwG6HQh946eQ1Sx3Ja9ASxmp6zgozK87i7nLuPp/RlFjwXhIe4hiwcBZehqJGdKBqgddE27QHHuzknQWE6fOL9D53Km04+uuQPiEhqoX1PZ3ZLy8ZDp85RVkNdEqHeq0FvNsfWIXuDkGqAkrjNgc6a+80gA0e/V9lnJmrRPeQ8eK0gO4wMQCnCNKX6WWNbfx7YoJu4FeoDhV0Isf8mWueeFC2bWROMU3AixXg+wpc3gNWv52A6kiDwA8XtaTrnRkzLYeARs52/m9w66BYkbIHLm+oeVZgysZPv2VUUSUM1bNZnikxw+A6R9ePykEmXKyuZDrVGvcZulVD0NQlb6Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780623935; c=relaxed/relaxed;
	bh=NO3q3FjeZxoBvWVc1q8if2QrGoMmsDL+VfIf8U72prQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UcdoYS+9sIda70KSaxoTtIyQDmdf9bL+zyTQPhwWKd7UljO8SbFkBDtwpLpzwLWnTvp1YttiltiiVhg+OnotZVbcquD3/22UfX/EHZImVY6o4Pp2hB+aHho758njISIfLYqWqCq0k5o7kG27DsqyTgFjl9ur3tUfX6b0LPCUPyPkDjWs04WRFs8qSRspxifKXzS8thTnmREBGJTkVAerK/Dw4ksG7BfycU8FUkoc0Y++2DUEdrItW9rX2Gqi0N56NRFQGnTlZYXsSFOb/NMOjG/aMpycJxfuWkzfFWX4lMInjA2GCtePMPNT1PtyxBE8KHQmTNN1p45VhzZyIMf3/Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=s7yt8YSH; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=s7yt8YSH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWkly1T2wz3bsZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 11:45:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA+Ab7brCq4/5W0HRsadoA9w2CkmBd8k2rEOCw/DsorFpSGyrUQK0K9OWWSH7T/By2lvXJ4EQRjIMMEkcDG0Pibcr7aFD82uCSo/UkIu04Ktl++lLKUdwrQChAbk90ZfnHKqFceYvXG7EITg9iOrGjd3aoPh3oDL0/B2VJrqLC3USqBuigDBktxUd7nuA2NPtp+fcU91ngY6269ukj8PcKGFStYOFo9iVi92gNu7VSUIW9Zt48+4YEMRzjUzxWARmtFN4FgQ8CKio9U0HRay5qZpjWo15UX3cCrWXaOgKEirMJbBJyXcWAPNil1nUjdLm9rTkHZ/1WGI+lbckOQ2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO3q3FjeZxoBvWVc1q8if2QrGoMmsDL+VfIf8U72prQ=;
 b=rSfYvsZ2Pdy9fZNbQz1iP+oFgT6dNm/gtWQpbbVH3qHydaPqPKlvCFrM1v8jxttgTyvX5KHb6EKKT0gT8DCopV6zLrgOkGDGCopNDqB9Ce0iEwdKDTz9BO9HdA7vtz+2y7J2HiAb1FcKaQCNbBYV39yUU5ZKTagC5TcCtZx7oIhrN6cIhKg/4cuJHD5YJoi7/MNClnjLnRxHPVPuvpAoGc+VVp2bmnGT5N5LjcoHbygiiOx5mdidPIegZRHP8dN6R6A++X+fsfsLB4RLq8/LkCYwDSqEgwhScJsStKP9zRh85fF5PsieFs/CGMY/4TrjAyko9j0VGAXapnGK+pglIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO3q3FjeZxoBvWVc1q8if2QrGoMmsDL+VfIf8U72prQ=;
 b=s7yt8YSH28FoJU837G9iXrMbnajc4y1ss54mbcTXyqEsz+WbFIkycALxkHrPZDZhCTjA3zZPCuNyeiQSrBhK6g1Ou6DivD3Xy9l3/pYQJzBHKzBFPhJ6hYDwgl/KUypnNoZPV8TLDn4nQv7GsOBS0Zc0PQ/SrOmPAzrpYSGptQFnR1+eZhLz6KG6ySF3QSaJ3DstA0MdVPzTAxVlkjavzQLdxppwGZUvih0zF0wbXgehDJ9R0XcNYgHcZN6aRI9cde9rq0oNhlKz4sQmbqlNOSQb/FlR97+KD2jEDXdAS0pHfpAv7DQevMHBSwzg62DZvWNcZM3EAJ4gho/SXJ7lgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:45:25 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:45:25 +0000
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
Subject: [PATCH v3 net-next 4/9] net: enetc: add "Update" operation to the egress count table
Date: Fri,  5 Jun 2026 09:48:03 +0800
Message-Id: <20260605014808.686024-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605014808.686024-1-wei.fang@oss.nxp.com>
References: <20260605014808.686024-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b400d07-ed7a-4f1d-15c0-08dec2a41d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	s3Yr0uyCB02IxDM7QkhP4V19KAaiQwV6GRPAnjpcTLhSVYzWFw00fr1unI3l+Q/YTOnNEi3fTPb/JGjmonq0ot1YnkpqwDWxLFlqSL/av810wyb4gIp1S8GIKltr+WXE+4Ih+yJzZvdc4AAh+eDXTT5jiGwX+j+YdlV+D0RZsngvvrqgg1CezZLcuxyT7HTLntoHhatKXgPLF/PkKjH2OXlQDtZjij+hO7dGPp+MpOsKkQteHNgWky1e5UARR2X7Ms4poeIBUrPllWyNbVz87N0uMeu7FEbDDIcXzQkeOX7DXUsF/ymMTyWU7ielqTMe11HrpXa6eBZRMereHcy/HWM/nlkP93Lqx1BLa7erZVvQyPkf7Yi9kBZETiLrwGJJG/hoor3o3StTj5UNKtUAOclyUxRTHfSbmQwjFWRw7tzK8OnROqZGdzVrFU02M2RZSnDxHs6PvzLqE8ko3fI8KUE9AJHYUOfbrM61IhZMTncdc1TokCRxWzSQuSqNLLSV2xtWPHt24fj8QiOngdaumHfEeXQPJoB+/udfuECb8dTaxsWNTh9p36Ac7kVLe94nEeDl7IeaDBfRi0cyP2t0yy+9w7wQtbBDQBGsC3YVsxikglTvc/BwciWTYOhoEB5W6Khi+XdFAXlrqR37UU4voNLtuPxkmDt0NWqwPkb7qalA+HBpGZOIHEK0MJynwcrpQ2kU0C+bN9cXTCHhjyrhOcXNasDqtfpp3/NfCPkO2os=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kaJTWqyx0cBYuCsmd/b4ITYf+4kruzpBJg5tCp5F8pRKHykj6wZ9GYQZT2Ka?=
 =?us-ascii?Q?q5KmbgCBfEEYvcVdUpsdkZAEkivUetyTVX5BdZP95fyzIlI7j5kB64bls0mZ?=
 =?us-ascii?Q?Fi6au8P7/PoXDwnKSnjXs1Qg9nlofrMMx+XPSO0BiZf8D0+cU+R/Wz/TH17C?=
 =?us-ascii?Q?pUNYclIjISEIyG5TKAYVmTDzLnkAmccHSm31FyBGa6PMw0/tPc0yT6GYYu1H?=
 =?us-ascii?Q?UHpNNWmkpCN/x9ewpBZUhmKvKwxD2YvmyQrL+vrKEuap1IIrCefPJgc6f+j8?=
 =?us-ascii?Q?kGzCS9jIOCfdYQBRYGKvq8hnCmtsOWRMTESPEywEqIp81htArREu+9WAa6GL?=
 =?us-ascii?Q?G4olbLnRGIznBx/Fp0t4tHjz8SVaqlaiuK7KwwEfjNq4lernSeUspllkqL66?=
 =?us-ascii?Q?DQCjsLkWUQZusVryLsqCevpvEXIhlixseWLb8nowlQ9MMGd/lj+BDHNR/h6Q?=
 =?us-ascii?Q?3L4tDf+1bdkBXFyA1UniEl2wXgBCewU0VRbOP3rb4cOoy3TAmS/tB3+y50Ci?=
 =?us-ascii?Q?pWN8f0k1Vk7/9WHXGWaMBXKCUPwsSkImD3vI2j1+8KxyYam8Ao59F+Ck6lzC?=
 =?us-ascii?Q?KpBKmBQX92Ndvk1chciGXg7nv/SuhBheniPkd7PMViT3fxZK+hUtm75K8e2L?=
 =?us-ascii?Q?/z4EZx3hksgU47B71Y5eTy1IbCbcXBUZ0jXMFgSg00CLRDqiGnCiAbM+1++P?=
 =?us-ascii?Q?ct5LBl7rsfMgTKobifnIBInzA1jMAWPAFb0WiqnwZByHA/h4zfGMOLz+R2g6?=
 =?us-ascii?Q?9V1O4g1eYajQUV7oa2Y4hjR5KWS3nhpsKxBtUtF+w0+Jofunfyvr757wA1nl?=
 =?us-ascii?Q?221TKUWsCNVjBz4ohOM2BIbgzO5T7sRjgLhfRe8lpu7/NvvRBH70dLexrUOR?=
 =?us-ascii?Q?OPpxFZ00BO4nFJu+P7bxGgW+ONCyWOxDv9D0XM0JXAyKxF/Nu2+fWMBCSTVP?=
 =?us-ascii?Q?ZzYZztApF4VMx+aJ1Fg26J93qI4kT1bpgeoXjRcqhsMoEQ7ScJEAiXeRmmab?=
 =?us-ascii?Q?66GZuts3y07W4xewgIkBENoUtwv34Jc/OjDPHcl4EXikCggBCs7cMWD5qAKe?=
 =?us-ascii?Q?6Wj41S0DQYxdMM4tDq60NzVMA/S1R6+lK2L19RS9OX5is3NStSCqTyPTNyiX?=
 =?us-ascii?Q?1zatrhXfVwNXk+2Pe1iTzKMqrFQBn0QmnysLrGOF4azmAV1LUzC74ARWYG3j?=
 =?us-ascii?Q?bfUK8og6MV7My0KfVX6OPoWCaUtBa5joQJB7YawmNwIISeQ27oeK70dAm+d7?=
 =?us-ascii?Q?wfIxUsNcir1knzu1XHA/5oQ134iVWIymnMR6aokKW5O72fQY/NJDOYgQfy8g?=
 =?us-ascii?Q?pvOruUPC2lIZ7N/ns7x/7u7rIiDZUcc0hQ78ci7WMCGqfcNmoz0WEDRiLi22?=
 =?us-ascii?Q?avMf1mdjKDNBfX3WJBlcq46nTSgSasQvW7kLVYIQupvnKbqg8WJb063EuCRB?=
 =?us-ascii?Q?MkIWJvS9yXikshDcAeuB9x8nPLUZynz11XajqWvzpKCO0vhyy9XDIyDtF4Dl?=
 =?us-ascii?Q?wF97Q3CQronyrHswfIHG3SKuQC5X4kaaC3VkVf5hmLx69gXuMo0RQmZYFhiX?=
 =?us-ascii?Q?Z1ga3iW/F+kHIhoJrWgdwwPa8GQPt9iMUauycIEe+heYJ6lazR/P5hQiBl5D?=
 =?us-ascii?Q?0bwSJ30gCCIMubJOxYF6fLHrgi4IxC1zoGXshsviAbsJEvW+A5OmQzKT3QVB?=
 =?us-ascii?Q?3Mc3p8TzXuLeaSb29OK8AuPIJN2Q8VUJSceazN2v56txVmvH5zfn3EoYWvFf?=
 =?us-ascii?Q?2fXqTwy0AbOVwNn8MQqRBfzMZLe/whVleP0c4WG8s+UQAKEiWXa3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b400d07-ed7a-4f1d-15c0-08dec2a41d5f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:45:25.8127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGynBDIo47vEEMpHCLOhjoMDQ+YOrHWkKEBnI4xLUpSHWFyPR/V5PxP9M3ifV0/R39alE6wI28lJaTTd4dPOGwfoP86XGkQ/PFiXwlpAJ0cyF4+ofb0nsEY47b7G9WTr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9375

From: Wei Fang <wei.fang@nxp.com>

The egress count table is a static bounded index table, egress related
statistics are maintained in this table. The table is implemented as a
linear array of entries accessed using an index (0, 1, 2, ..., n) that
uniquely identifies an entry within the array. Egress Counter Entry ID
(EC_EID) is used as an index to an entry in this table. The EC_EID is
specified in the egress treatment table.

Egress count table entries are always present and enabled. The table
only supports access via entry ID, which is assigned by the software.
And it supports Update, Query and Query followed by Update operations.
Currently, only Update operation is supported.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 45 +++++++++++++++++++++
 include/linux/fsl/ntmp.h                    |  2 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 9249f78219ed..601435966ed1 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -25,6 +25,7 @@
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
 #define NTMP_ETT_ID			33
+#define NTMP_ECT_ID			39
 #define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
@@ -33,6 +34,7 @@
 
 /* Specific Update Actions for some tables */
 #define FDBT_UA_ACTEU			BIT(1)
+#define ECT_UA_STSEU			BIT(0)
 #define BPT_UA_BPSEU			BIT(1)
 
 /* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
@@ -287,6 +289,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "VLAN Filter Table";
 	case NTMP_ETT_ID:
 		return "Egress Treatment Table";
+	case NTMP_ECT_ID:
+		return "Egress Count Table";
 	case NTMP_BPT_ID:
 		return "Buffer Pool Table";
 	default:
@@ -1197,6 +1201,47 @@ int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id)
 }
 EXPORT_SYMBOL_GPL(ntmp_ett_delete_entry);
 
+/**
+ * ntmp_ect_update_entry - reset the statistics element data of the
+ * specified egress counter table entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ect_update_entry(struct ntmp_user *user, u32 entry_id)
+{
+	struct ntmp_req_by_eid *req;
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
+	/* Request data */
+	ntmp_fill_crd_eid(req, user->tbl.ect_ver, 0, ECT_UA_STSEU, entry_id);
+
+	/* Request header */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
+			      NTMP_ECT_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_ECT_ID), entry_id, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ect_update_entry);
+
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge)
 {
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 0c951e1c763d..1222901f48a7 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -37,6 +37,7 @@ struct netc_tbl_vers {
 	u8 bpt_ver;
 	u8 ipft_ver;
 	u8 ett_ver;
+	u8 ect_ver;
 };
 
 struct netc_swcbd {
@@ -294,6 +295,7 @@ int ntmp_ett_add_entry(struct ntmp_user *user, u32 entry_id,
 int ntmp_ett_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct ett_cfge_data *cfge);
 int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id);
+int ntmp_ect_update_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge);
 #else
-- 
2.34.1


