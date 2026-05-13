Return-Path: <linuxppc-dev+bounces-20806-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F37CD343F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:03:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdZ4297Zz2yTP;
	Wed, 13 May 2026 13:03:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641388;
	cv=pass; b=HjuLy0ZyohTuLAxuEDA2RSx1U5Bee54U2JlEBge4cDfktqLpDTtetyzAzpmEMwVrnvx94bwopml3sBM2Jd31iLCCmIKeZfUoGXxSkRd+kP0LLKnBFAHEWWcMW5k7D8BNFXwgMdBBz3v9HMET4CqHrvqXsc7/W6KZCQIyYQLQbzjZ/TIHGnaQD0d558VggIROVgFFX8s8Rmfva6WbFDaF0r9QqRcLalO9m7UI2dy+8bFUA0sPCCz526PebJaWWvoTYZuo6t2FcBwQT58dFfcpQQDFNIggJhi/UAHvbUOO717XpSJ4/tzVQ1qAG1arnxNxTER8gN4sFVR+9YZQYXRBlg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641388; c=relaxed/relaxed;
	bh=/B62fPejed7Ldum3h06+M+/Eww4lOevQpJ4rElrPhHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U0o9HsGjsrVzuQeKPY4IlhPtXxn9zAeOuFys9jcRdcxvBtu4kr3BLhCyeJUh6KlPu7yVwtUbw+DncySNwfAhVGLDKof7PsFkcQIlUfpa+v8XDGHym7TYGoAjHvjHEr6uzM4wSJ1UBEnctPeZXctXAIXwGEsxrZzaGfS6g/C+sbNBQJk7vUXRaF3ddXT4YmTXWGfdK9f/MlPTMTdufHvWX31EM84LGO9SD5Q6tbmyaFRBQPGOgbs2o9SVuc/e5O0naNOa2Ezw2Ky5+I5KixkNkskhwj3lhdxXXcHRTnvL1KXBAnqpa9c+rRpJWmY9Ubk5KSNLncIXvegDbGODYfXWNA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=QBi/wLJw; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=QBi/wLJw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdZ32sqvz2yYy
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:03:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGjMT3vh9fARnGEQ4oGp+l5C3rO/4b4PhKwUo3ZTNhLJYxudr7QZgDXwes8trL1tlMtgVZCHKtm4CD7Nt0f/i0TrW9dVDEknpV3t11fkZRAbX26IMR9C/taXiMPKkB/pWi4giuvN6Xb/F2OJ4exIyVELvoMcessD+dkIeU5g9JALUe0gmY0GOq4imLERIftEQVsjHfGWW/tbuYcNesXB5MGvS6aFEWHBPrb7OQ/9VoMGUCkqmwmw0SEXT+sKCcHiVoTpWEUYYQ9QEbW12mYyJ72AeCi1LQGKmrJ7jzI7qhqu5ZNvIqtYYeJ/qsy18XkYequfniCNVrbZ0mb7vjyjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B62fPejed7Ldum3h06+M+/Eww4lOevQpJ4rElrPhHQ=;
 b=G4mwVqm+OWNYar2wm8CXNaKcII+ChKzHUBoG8xbGjFBGhEPHfj9FJTt4dqb8onnF+9tr4aC4oaO1hmFxMLSRWV4ou86d4fkNwHHESENP6ogkwUGT0TdVwC3p/GAkLA90OBgeRNLFR3OY4offD58Tcg3ByLT9BaAmZDzwem+zPwF8H10niW4o6qNLq9mcZdJiFcF7EQFmGGdG7hNo4xtGOf5VO+g8AnRi7KrKEBIBifgUZ1SrxEGEdMn9McmFgtkPqYzkVxInifIIGeqO+PxyPimxuo0/XIssrBqKb3yFGBFwc5FNPPoG1ehdPNcXdHUybbJqqyEntdlYDJcRUljFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B62fPejed7Ldum3h06+M+/Eww4lOevQpJ4rElrPhHQ=;
 b=QBi/wLJwI0xvXFnitgoN2UD0Qr3VARpZhVtSBz5VUJi4K/LWv8xa0AixKh0WQ4owAt/dfadCkKKsK5Em3b7fnOq1Rm951LOoAjfkjg1ViFzXt2tkxs9k7WtxwJ7RbmhTyTZvcW+s7I19oY/ALzYqxnYT5pXBC2WAPGschWIgtIB5eENvDQNDWQLMsfVzhElW3nsNt5N0GC2pupC6CWNHlWp32xKAQT+gwr430dlOGJ+lPC7IARZ1BPLrFTkoPCanIxhVuneDhoju39IdUQJ61MfwgP0Z14fnz1Ca8AfhsmYI3gEe5DvVdUCYWZmeho8NkfRN7qGHYKyPDeNhuCwDtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:03:03 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:03:03 +0000
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
Subject: [PATCH v7 net-next 05/15] net: enetc: add support for the "Add" operation to VLAN filter table
Date: Wed, 13 May 2026 11:04:44 +0800
Message-Id: <20260513030454.1666570-6-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 30ef5945-3845-41aa-a10a-08deb09c25e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|22082099003|3023799003|11063799003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	QfxXy0L6sIAL139XVv6//VoIpr8TwRRpL9pjXocajomNQmaPB59MGS8NLoMEXPmowQ92gLpsyph5ZYIK3y1zVr33hNi2i2tfovvqxlJ/oAmz18FA9QQANQrekKPRLurcWKMHCJyTCG+eLYP7noONxdpwdcXv2nl2nYdQ5ajhiZSFoHbGiv5CAyD8NOx443yCB+t4RnV+U5fV/Kh2LE/XtVNMx5zIeHW0THqUai6V5L15dZ+iIvRSjgiGROfyysQA91WOcpR7RQJDdOJ7zITP2/zJyaA+sCtGGPcJkTqbyDnKq4Dte6GAK++bG6UH8nO9nLynnJnLq3CpAaR4AH/yZ+62cJkzbEDn2j8t669UFNruUsonAKB3/gd0sG38o7DlhwWO7s/VrOiWjyWAk9gASChwI+JdRakwIh8AaUbbQbsLVv8NT7U3l0+9ZjWsGlN+xPGDx+kTJgItLSxvfA+N/oMtGyvlR1j1NmdtixsEAq8PrcUNyA/fmnIDNHiGlAuV2+V/w7YUOIj5xS/TQV+pIV9x/GWhfqSjPxcTxxhfqjXlqegLd1Y0sQ8oEyhJSUlPsQDhoWDZ/vlNnY3tadkgDAmPTRC7CFRaEDurALer0hCZvEw4eb7u+xQHSxGMFmCjR9lPB5HX73H32jUN0LGGLr2Li/i+Bqx9tJa6GIQlW5dMYIqxwzJgNQySaW3A0NcRHXFhBrvZ48qJEvUEUc+b4nMd0aCpVMdD9TNb4ZC2+0Pvb9IUDPMUEwznYEfBpVKZAPvrTO0ovIBfZpsIQox5iQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(3023799003)(11063799003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?moNpgKeZM/GqREAG2hr7t5fW7Sx2s1CJ7Y32wSQ8TMyb+zJ6Mqx1jGwX0fQN?=
 =?us-ascii?Q?sZzvky6JE1/Rbftoze990UVHKs5NqQHSmw+/CBb5LsONec2waNd1lpNxCrUW?=
 =?us-ascii?Q?a0ap4xoVPSahve6qAq7p1B9UVFjmzCPDSd3OqrW2lPCJo7V9rpL1/iXJpQLf?=
 =?us-ascii?Q?2Nzq34gsrckt4qlc8sT+2SYkNXdVVdOFYgC5I/zXMLJzpvPh23lpsvZl2Jyt?=
 =?us-ascii?Q?nk95Q/8iYSmeKT9uA857QicODMRZGhcisqAoYLugNnshY+YoJaL+DQYNw4UV?=
 =?us-ascii?Q?LZO6svX2wmVQFm4QglUJRQSIqcjDdWplxt+FZo2n4gco1WPuGzNsyLHDGW/u?=
 =?us-ascii?Q?vd4UcZpq48jhJ8c9TPMAHNF3bIvfAMqLOZXLFnuovkbsmjQz3XtahIwQlLY0?=
 =?us-ascii?Q?twWraG5M1KohNiAdG0Tp7TZhKK4pVmdRKZWES7RCItUOr/KrQE2C7SH4y6Ph?=
 =?us-ascii?Q?x922sYxl95WcpoN92pDRkfn2CcUyzeGJLBBKXUi4X8FoJ5ASIZJKlK48AFGw?=
 =?us-ascii?Q?Bi75JPlPIkSKx62wVLaWgw85CC/LoK11wVAOe5q0nNVLI3xg4Ojhq6yW5wMl?=
 =?us-ascii?Q?RUaEsAeEiByRmDakr1PrJvbkZOkNOgaRP85ukPYlJ4sNyo8FFym5yaDmn2w8?=
 =?us-ascii?Q?R14I+JrDTimhVBZFlPoMeiNoqyAmOrtu04iKLQrsNM3dS2C35YiTwn12CwWK?=
 =?us-ascii?Q?O546nhk5Ats0OjSGdW0pZuUkluYESiI3lLgkzmFzFBdga8OXpOK7x5T8nV/V?=
 =?us-ascii?Q?kqoKbAd78mGNGy+gBUOYx2uukcOyaVcv23BI/sh34d7/CAdXKVH3pGE+qfvY?=
 =?us-ascii?Q?MK9kWtyBdoeGMNos71qv8sUnp2vT1msaaKnFakbogIPotw1kAlYSeLxLkngY?=
 =?us-ascii?Q?2/1CUrJsvHUBUnvQ4loIB/s77yi744s68qY8YoYDy0gg4pKCz4tDgjwJBcU9?=
 =?us-ascii?Q?J/mmM05B0lpNVIuK3i2hcCiKdFDawIlLfTavSoqALlE5a29yholzIaEh3ErH?=
 =?us-ascii?Q?l28/7dqXka+iyZGFTR9OBIJQkpmImKrHcRvyJfj+a+Ut4XxDfZ9KfLYTpBtL?=
 =?us-ascii?Q?EbSt9OM4xgqJf/RSoeBA1tAGMVUtwhrmoW/R7rh5o0Re950vlrEl3bf0v7+w?=
 =?us-ascii?Q?o1ZJYwtcFBYhf9XLTtLzYuS8h9d9aoVuZHoMHi/w9phpkykvTUUjU4M0oHn8?=
 =?us-ascii?Q?6QAn70+Vey86TjCzpgFNLNrwzTO19tlZcr6+6IfnFD+VJW/lDGV+1fpWSbP3?=
 =?us-ascii?Q?Z6+xGz/1jEEFCoO4m+ODGNI8pkF7FFl5XzaNJQyTkqTdvML3kNiG2jyhnZ1n?=
 =?us-ascii?Q?+6fQy6Fz/OPANTJqxw8dphBNTbDQuKvLxxdPE8tlMVyYOGOATjQswvUG3EIz?=
 =?us-ascii?Q?1GvcptRTAodv0swaKyK0Q6+L677WVPF2/6dT0tMTH/AB8ecE1or4Zr++801o?=
 =?us-ascii?Q?d6Lhj2B+KjWWveGijn7DtpqeVpKm83BgpyQoBeuZTEeUpip7fG4pkAR3JCif?=
 =?us-ascii?Q?psA6dXiXYI6+R8fcNzC++BhaR1X6Nq5WO4piiVAdBlzsjYmXu3fqV4P1YDos?=
 =?us-ascii?Q?X8QXZ6XRnqaJQsoSeG54XmXTjNqREeFFXGUXAl2Hi7l4sUE0BOzx3p7Zc/TT?=
 =?us-ascii?Q?v7SvBARo49NhykwuKVheLBrXqxXcyUun//1LjhK15Ls26ZGu50YII/UlEH0m?=
 =?us-ascii?Q?SOmDt9yDLgjWo/nOWBNLHroxytIw4WdSugvPrO7ec7nWD3tA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ef5945-3845-41aa-a10a-08deb09c25e6
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:03:03.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KVkRh/DT8xQk9C9fiGDAxcNfar2E48tDaD8nHyIHsXwlvuc0Svp0he+I90cIt/OY1qDVXygCPBHnXjit34oiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525

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


