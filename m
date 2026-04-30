Return-Path: <linuxppc-dev+bounces-20308-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FA3FF887E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 02:48:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5dry3DWwz2yS6;
	Thu, 30 Apr 2026 12:48:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777517298;
	cv=pass; b=TEFkq4tnXXO8wT1OPiZ6HmQ70sZhJViKEGFsf/vloJjKnrWM2EfbBlhIRwrd9MPyO4tymI9oFY+hYhv/ng0uP9xcjGGYIAL68G0JpgcuQtp2dMCjC1eAunhixBK6gb8APXSZuc7O2iDZXj2sLW4oR1fw5S8f1v2yFnjVnR4eTUPpRX/c17ErmHPWJobiJI4YyZNRY9MRXP1xLR2Id0+nTa2ALiz8IvKRkZQ4Cvfqq2wMioAz+wjDyjQ15h00+sGkE9pccGAgiZgZkzzILBLn10K6jyoxuP0vk6XuedIpuR59whJNSeoGGTmYB9DNV2vXIkjQuNHwvrAR8s+RW7rhYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777517298; c=relaxed/relaxed;
	bh=CGyWMr34sOmRve9pQaB1i48erLlrlhLvlyJNA9dS0ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MCuk6qyKIoaGdYgHN8eydHEvSNV/PyRPvsYwMzeWa5Vgxre3TZw3lKADomLN74VKUJpNJlYBIJQIfNQ5ICrmJHJTXfaeSnWawQ7zK5YOydBmZVDpnwyKLfjMY5b+RwPAv1kKBP6KBvnrkBeXea75sSHtYRk6SyDQz3hdO9n9UbRuDql1ULMv2Lj8WcHv4J5tkOMuDbvOmWU2kxc3RZ98dfDeiVpoKLkugmYvtfH8PI9QpGEogHWQHS772TUP2ZVa8D1v+HuWaeHmsA2rERwHs1FRsdimlc7nhFuc3i6Ul2Zp7UXl1FV6k3jLjMyFu+kiI6cJSKSog0hAKv8KqGWjlg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=GIU7PIXJ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=GIU7PIXJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5drx3mJwz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 12:48:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gImuSuXRDlQ3PRKNa17349gUFHIyUOIbBMzXQ0JnWsnLbVbopk36bXyZmh7mo0OA5te6G++LTU1pNsQ3Sp2W3GMvmDLeZ3406qi+trHAQUMJPG06oa2/x8XK1P1VNvJs8oe+xfrJrRDC4Zz3UGZ2FWFekP8nFvC+XR6hsaTILfpbaIQXXuQpeBABW8bBro15g6RZoS/nHNLDTNvL/CFO9KSdWcQsbfXtL6V4Xw+nmPAGuTFVjfAmZFhVlrS/EuFTJbE/mwerEHD2Id+BEVRxf00Kqj/S3GzPuJgsbjyby5BMkhsTgVPYmF3kHnqk/2HVA+/AfwPLxcy1vGLIEy1TMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGyWMr34sOmRve9pQaB1i48erLlrlhLvlyJNA9dS0ok=;
 b=J4kW2bOXsYGgbVWcEVWC47eB/qch2klwqYf1d3KrhA0eAGRRi/WmvC5bUYRc4a7w8d2sRLa4SQw6IhaAPL90BfXCtG4A7QUo9j3y3AVwZL2jCdjricQXCnLmgZuaNhGeWQPRV5qzFFisTM3IN0j1VQ8xCKx05yJIqrBJadoZO+gLo48KZAdKhU5s0eoVhFkkOva4j881rQtn3VnteeAZNLg23gKjSoiPiw8TVzep0JAX69T5oSqHqy88DqFB+eDPKc7da1uB7J3E3dRVm5eL5dL5dG9LdPZISM6ido11ju0uonE+hIGSTJwbQn24wk3W9rn82w9cLls2IeR99y4Kxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGyWMr34sOmRve9pQaB1i48erLlrlhLvlyJNA9dS0ok=;
 b=GIU7PIXJy6a+4sHb5cqGUpWRnMUADfeyhOpUTrKJjOd7SGCv5nlNZcAgwesRId4cQfiNGfE7RdOcu+1gpW6yD5SzvuPgraOU2WEluIn1rgEveonx71jSG83rgmoSJFrFnspJ4+s+pdFgg68GIGS/YJsRKrupc5JBftGjXsvfKlr6Qpq/v/3c+Z0A8iDhIPEEdkMAISS8c21IPdUcmP74rC0n7+MBw3Rlig3Ov6Yu9NlbCSuVG4ZBWkChF8J8K3NkTxCnARXtgbi26pcCFCE4kCzSb8S4q7WaW0gs3XbO/iR1X+C+J++fps7SWOz8AgjLgjccbr5oBPaXSVSjz3YeIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:48:00 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:48:00 +0000
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
Subject: [PATCH v5 net-next 05/15] net: enetc: add support for the "Add" operation to VLAN filter table
Date: Thu, 30 Apr 2026 10:49:35 +0800
Message-Id: <20260430024945.3413973-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430024945.3413973-1-wei.fang@nxp.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d6b146-98f9-4ca7-889e-08dea662e44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FyAqWtcjKU7jzLRSB7SHlDFtoSs43dcP0Uw+nCJbEAgArMXJaGYhPy2IFuQoqhcdqNwgGDGOZ4t2V6CSutW7YkejncRCMHXqW23Web7D+U1aVjD+Z5yHj4pbMT935ehOgy/RgYIIdOWyYPP4/9vnpE8PstlbM7Y7NxKRqAy2k/2dcQqYQPJVbhVLeL+PWkE9rJ9H1IO686BwE1V7QcAgnga0VVyomwYo9rm1ODwcH/Q3RgPilrdGg93UGMrS4pI69FLN3D3Lc775kIXRDBWPHkh8729dBQUtfrPyhB987ROV9U7luYvHgykzQPiwjqxhDDtF5oEnKWffdPiB1I9QQYp1sRepN+pp14em214MKFvUlJ4DYTlIJhyzvgrjubyRzNNaUkxfhkDbMCmI9XkU9tbkjr4PInHM9L1+zxNuUy1K5dpwM0FP8v1spz6QfawQk51+zQHBs6kuVjNbCIZQWD/7a6oGcIbt1lB6/Z+EvnF3nbhMPJz9YOipYKrgRF+Out0Adw/uFfBRwMSARvhJWd+BTkCOepZhU8wOVn92va9Jr9UlzYcmKoSgYzmD5uBId+LSXG1zAqGDaFnnTmrqhTiPe/fFiDoXi0u/ZmCwXs+dBRTjvuNtAIFjXBslsab81L5A4MULUMlzXMReBa0c4tMAFpnaBrYvbIHta//89bto/bISxWisCszyygyVD1NwjaLkwmwyBlg37Aon02SNvX03PdE09RkzKSNe2K1o/zoG2MSkBpHK+0ewos0JhU0nXXuCNq6SzisWcLH48WWpCkoI0Z6EMR2ImozvEohEbum/FwjcjiXJs8KTz+3J2GxR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FlhT6IrrBBUnxphvRWnRVd4RgUbD3qlK9SFmeeXBQYpDYOG31YnW4XcWmOID?=
 =?us-ascii?Q?mm9RLaYQSP6uN88J/Az9lRnvbEqfqWyrcjGaKhgwoAsbw+aNQZ8/h2IxgzF8?=
 =?us-ascii?Q?rR88fK7H+D/G4qqB1HRQR4Ddi8zv/PsQxcQDXSGYXTW1t43wNJRo7h84gAtn?=
 =?us-ascii?Q?HTHjXbBb9Y8dI43NBjXZVhrVqZKsJ/jh+wNAZXhaOCXogTmCfYtD4eXHDHiN?=
 =?us-ascii?Q?kbxQFoiOxkfWeiy5+Zlo8MGurvKdnhOx+l2ktBXthBIJZzY7QiSr8mW2hP/y?=
 =?us-ascii?Q?biUUUrU77GkeWqVO7Mgcyi0UfYT+ubNS/kDSzu0Imxf/w6DC6hZIFMGA5Odj?=
 =?us-ascii?Q?gNBijS1f9ZjtHH0pSz1WxZDciKd+evyUCR5OjDj6RheSq7/aYAjT783pbrhw?=
 =?us-ascii?Q?Rz6HtxtFJlMF6UwlMNrCyADHjL1aJ/q6UflLfPwYjp0aZym9PQWyVqEkvrHt?=
 =?us-ascii?Q?btP9KoRH5qRPWKHfwC/BiiwNlPDP3vPOGGK14wyNVDpq9RrVcx4593da7Nph?=
 =?us-ascii?Q?1P34TtJ/lQo9V6rc+/GFpbsLlnX1LBWG/TKJ8Gk2kbAJ+y0GWaLVHYtbYoWh?=
 =?us-ascii?Q?9QAMMa0O7RCS+ayxtqNqdi4CDVyEWY4Tuoxg1GE/+X9Ylpb1uUaaUGxRsBpo?=
 =?us-ascii?Q?lNKW7LsVlZauRpZct7wvyGSkp+q54BlRkWTiv2dnDcMJIhqxLERUiM3DAb7B?=
 =?us-ascii?Q?mpT2o9BWaRYcfAIlHAdf8Aiy1lBz5vnynuzxF0x1xlkdpX9UoBekTYFm0otF?=
 =?us-ascii?Q?3eV8DP65UPp70VtKr3YVN2xVwFIS9qAiQU3IVpWIrHpteUq9R8SJ2s4kQqcz?=
 =?us-ascii?Q?7fXKoKu+BerO8c+mBx6UcQ/Oz2Htqof94hgcXDFeP4qgz5WV0LGYXWvf5v82?=
 =?us-ascii?Q?70dBlp9AT2zrHunqnh4fSAxBaUH9CGL//qIQ53ocn4NFlmYnIiQXPGcPv5n0?=
 =?us-ascii?Q?HfLbviUrhnnOqfmskxI+dcsVTvgyU9Xl8aXhDLuzKqowQlPqgeRccUnqB7KB?=
 =?us-ascii?Q?pRnBlRluyTTVO4O/7bQpI5+0X131JkpdZgWEIIiS6cEy+CNZ36FxbjxPLpiy?=
 =?us-ascii?Q?Eu2Ce1z8Puhu1ildlWxplShkDG4Y1bJhrrZk03TMwB4suU2bYRO0R92Wwva0?=
 =?us-ascii?Q?0twCAD/pvZ1rY2KOnBBVg4P1Z0pc+uks00B92fhRFwdfVVqEE0U1pGnYdpIb?=
 =?us-ascii?Q?7P6CLXuH8gdACeoU5GSAvh66M37wwpTNq/iXfKo/qBynbdWqpX7EuDPX4I8a?=
 =?us-ascii?Q?aAapKCsDh18i5hvfyiaKkEJaP8Tlt16mVsAxWGJWHjZkPwS0c81JVkh1CneJ?=
 =?us-ascii?Q?Hpl4iyBgIq7LH3n5mnKdwE5pfwmiVqKhbJdRI8FExzqzXPp7C5S/ur+Ff5wI?=
 =?us-ascii?Q?V2Ks68M7siUOFd/xHRPHip/Hxbc+OUmW3TGevNO0WcPQhMJqyxUj2iffjOnx?=
 =?us-ascii?Q?bAvQR9AC8IB1wesLOSIAGAKXhn1q0dUtqNoqVv6fYw1aqk/IS5FOtwB5iY1W?=
 =?us-ascii?Q?zvihOzox+iIlgeZpkWNQH668L8AhikhHu7L6lzvsQ6d+i0ICG393nCDRiqt9?=
 =?us-ascii?Q?ezB9pbmxAVcc7WcVmshuYFuppNuqrkjlXZDMszlA4ZA5LzfiOxV52E4Jbpy5?=
 =?us-ascii?Q?ygryDdZTd+SQGu84icXn11p0aXWR3FjY99gDQZV5c6fP6EuAdI0WqVQLZKsC?=
 =?us-ascii?Q?E3xj9u/FXkhJ/No8z01Fo+VPh6jk2JhkP/SlBMgIA/IckubU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d6b146-98f9-4ca7-889e-08dea662e44c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:48:00.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boBsqXUt4sTBn/VcVCfFzSb9RRwp0BKeFGCCPSjQOZWCyfGpCblBkkBEB25nbg6hpbeZHyVeKAAUAzR4zVubqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608

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
index 4ed8d783a9a2..31e8945de6cb 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -22,6 +22,7 @@
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
 #define NTMP_FDBT_ID			15
+#define NTMP_VFT_ID			18
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
@@ -266,6 +267,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "RSS Table";
 	case NTMP_FDBT_ID:
 		return "FDB Table";
+	case NTMP_VFT_ID:
+		return "VLAN Filter Table";
 	default:
 		return "Unknown Table";
 	}
@@ -697,5 +700,52 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
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


