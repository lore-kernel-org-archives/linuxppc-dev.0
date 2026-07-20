Return-Path: <linuxppc-dev+bounces-24492-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE489C4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 13:37:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3hQW3nsWz308H;
	Mon, 20 Jul 2026 23:37:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784554643;
	cv=pass; b=bKXf9TKmL+G++wwfPd7GN6obmZJ4aaKazwQnalTwYzxTrna7v9N45goIP7TVwSAnQ5mXHzx0LphemcXOikhYOlC/y7QHLWLyR7br3T44hjIpVyIs8JnF01GKR30RHoLt8jZMnQVt+dBbNa6hQkZLq9X1MZFjSQ/PpF4cs2cRb+LNLX3iXqu9WlqhJFWFJDYigMR3EQToadblPo5iq8EwWnGb0UPTFwcu2ZgElGb7fM40OV7z195AboxaXYzogNpBSMw6HkKpZA17Jey7kuyXsIfDZHcxhSQLauBNyo54mu92vAYsjgdop5mNn8THWW4HOP1aS5QqbiJFMjzAQGNUdw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784554643; c=relaxed/relaxed;
	bh=dQb5uExHGwHHvFNKj70dy3iWwcHVK0OA39j5yO9Ig6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0SlC8c0TC0We+WPS0/oz05eXXjzj2uPDfFnKvQC1DmpuSvEThLMZjEXBBSbPKozfV0RGjS697x66eBrbm4SzYMSIxrydf62vjXYHDBTLxhnyB3AjAvAF7oNVPWG6ypBQr5iXmSqU4ZRnhvrwA0yJV+vF2rNoOqT/lKdUszHUNHMTUbLiKVSHPNs1S6LEvD5n24BGAi1TWryP+sINasWyessVMqYNxU7g8UqKkf/D5bHMhp5nixxUpUlZTbGXBpaoMavI/RO8sH3TQjB16oqDrAuyx5l4CCNel6sfiJefoCj6+p11fWZgqhnuuXnrZxzMywKPpa/oMokm10JhMX4kQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ROQxVezP; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ROQxVezP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3hQV4P7Vz304Q
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 23:37:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvseXg1Z8VmeVW/0sXiY6AZ7uQ5FyWaF2E5qnBR3eGBeEhdlwfOrgematjlBEE/69Hd3rpQyPxZwPb1Fxyu+YnE2080HDfKrKFUENvy9INOCge2+Q5oQ4z1msrGhvahJD392EG8zb+0YSC0LlFwXxW7W7XGWc1kRFhTrBpnnilgGPfHgp+PgFWu1bo+ev9gIvZf0JfSBB70TAdG6ORRk81YVoU0fzHhM7l5/zUno8kvQPuFUmqIueLFtwskd2zeCV975h7pFO5lr12UtSNrh91vbLt2Sr2H7XkwWAeoyAcrvdZlxxQJRFr/gKlo9knaaYxcq/hn4GJTRNFjUXqoJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQb5uExHGwHHvFNKj70dy3iWwcHVK0OA39j5yO9Ig6k=;
 b=nnHc9ZfAdzOX7Oyi03BdW2nD4Gz07PB7aBfApwnRfKJ4K50cSRB0E+S8uNflLzcyDo9N+g0CJsgyQIj8hNhd4nR2UgargmCCooRf0gFfbzeDjvGsEav2ShQ6BFjZvieMdTW9t1pLj7LUHt5TrtaGJ7hFXwLw9nMNXfHXGfhpzgNs4fYjOw9n1Y5KyhDezNzAPoz00l05VLo1hVnlMvJlF2HZqsbe7ii/iyFyZZJFZsGY00phVmLth5pGNUIdDVHvaKjbJPnGcnwrpTqQD+lvI0PWiLuIm6vnfvFXXgGt6273Efs8oNQCSA3zT9qZnyE6QId88XCIkj+XhLJ6Uztmxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQb5uExHGwHHvFNKj70dy3iWwcHVK0OA39j5yO9Ig6k=;
 b=ROQxVezPhpuvkgrxeadCJdGFFq95h4eVt15zDhO9co+gy0GzMZcviKR25oHvUG7btoBkDY225cL+IqqhM9mOyIi6974Zg+fZQJCN2iQmMzsjqqpK/PgTZaWFH4Ce/403m05fkGADoFIZU2GWyLWpcXlZsZcES9mkGCaCTsAmV15tSpka4pIBwnGVyuy2rx0fJ3ji37w6Gum0sL1fXz7xJrvNKbu55NVrA7cw8pFA42SI8NEk9gjePaVcP+Iw5vBRfYprAduMdWdULkp/IonVU04qGcEW8FRb8b6HSC04CSBRCcloHBb4hi6mqMgIDGYYtldKg2NBU4Q4NoFBnyXC5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS8PR04MB8626.eurprd04.prod.outlook.com (2603:10a6:20b:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:36:57 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:36:57 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 phy-next 3/8] soc: fsl: guts: add a central fsl_guts_read() function
Date: Mon, 20 Jul 2026 16:36:37 +0300
Message-Id: <20260720133642.136324-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720133642.136324-1-vladimir.oltean@nxp.com>
References: <20260720133642.136324-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::7) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS8PR04MB8626:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d5498d-690d-4d95-170d-08dee663f7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	0qUoL2OyM91Oe6XmhAEHMsYTsfto8/BEzTHliNL+obqqt0g5oNRwYcf01tPX5SyiART05YUOgOWhyCxVhMWglGdGPLqdI7hLdC9OdiONom72qcQ+ZCzLfTYOav3qeONMaVrkfZXTCTphL0L0sRNLi+fsQ1hqfvvLarI1jHeELBtlPg9dyGw5eZ53WcomosGo8/IE/svGcyEOjG2uYxh7KV67NLGDi4P6ClS73KOxXIDuXZoYsA7+vJ5kJgYk4tLvPTHno8tcKHxsWs/jRvojj2UncWXAciKhURCy0amvDP3vRIDH1hHq9SajXunTyq5fhCV8SJiqvpbd2nvlV9PIUbeRn8AQhu1uAkeEHtyQfW/szJDcj3tqxN/G7qqP3IFayc65s49ONI6cBxYCxA8WzfPBNJ3gBLNXJF6MdST+nPvhkP6b9+CLcNjfydxZ/B1gJN4UekMutmLVhom1ABzIHJ2fUEKol9bNfHZRXOQF1QqyGGtMD5mUs53q5cwPrYGq5KiX2YBiZM5zi/IqJlP/Vkv2YyPfsXRufxQJdN94WrdW2fo/2aUq8DrD4lIJ3+1LuFW7+hUc58nGhMAEOtltZiWAK+7rsSqFJsnhvB2XGf0NWKBIBbQ9idIvZatZSD0Kj+6hc6oE9SiBVehmjQj9LQUHUrumEYwrAXgofnSVfEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LhuzFpGYP0ecRUBrrpUoTCydR3ACIPx+Z3VdjgthO66PHHIjNCo8B6yBkMyb?=
 =?us-ascii?Q?P/yKIMQkncunVq5NLJL0KpMhZWGBryMJzK1Gyg8PKdwnxcDw5Yh6lxFy9CCg?=
 =?us-ascii?Q?WUbp/LT256TIJXp1L8T9MrUOZaEhdHSsPJenwPYUL5D2JAVyHUKqJ9aC7xzd?=
 =?us-ascii?Q?d5nxDvS9FQruJO+d0Wiapkay47rlJMtklM3ml7oAPKNobsX9wN7C9BRB6Hix?=
 =?us-ascii?Q?urzbTpfo2njKVqiCfBIGgVeOpnShk4OghsOltVV7tENlrVyaKmSrkvn9UOzO?=
 =?us-ascii?Q?Dgl6XcumnWdH/xIWuKnY42UnK6ty8EKfo9eiPP1oDIkc1zXCBo6ULMtyH+DB?=
 =?us-ascii?Q?oaPqoE5jEbQ5poA/ZMz+GisQ4PVd+jRWzFGtaS/TKH47rNYdVjbvVZiSkRDi?=
 =?us-ascii?Q?g81K0q3V1zvIUXqIwVbrJVchmJWPGNaVR2x2i2qxP+42+ouVZrzpFvOS0BTb?=
 =?us-ascii?Q?JYVSqd0VEYwFjG6+9VLDYv3oapEESxCq0RReAMAyPqYhNG56Mvcd8mwWDmKi?=
 =?us-ascii?Q?BkfOeaZoAv855qFyPIPVQVLGEsrAM9/dw20mLIQNAot30poWQ8un8on269ee?=
 =?us-ascii?Q?tn6iobIwmuBajBjJ6PggvDY46e7DHZ/X+5CisJHf+FLs4nispgDEc3t/Y1Dx?=
 =?us-ascii?Q?cychpwNXnL6xUl0KdgRMuJBrK/f+nvelsf+eM3AQoJ9CdfIQiy8sQISnZjWZ?=
 =?us-ascii?Q?htnOMKMOrDAp4dZkCLL/OA4lz//tronouYeATq1XKPDORV1XMJH+GEBF28PG?=
 =?us-ascii?Q?PEveZz+dxLi9K6OvV799mdxP8LEH9n6KZzw46oRFMt6CoUpu2JaJsGR4GYby?=
 =?us-ascii?Q?u3v+uk5xILVs0cfC4JYpSZxNFm4jMOP/LH8ivP1Dx+7f9NbgLPutoPq2Ij7j?=
 =?us-ascii?Q?1EQnFc7kqyt0ToYFzJGBnGYMYBmGyermEM+hwsrOZC5bWS4ZnSx+j18ia0ln?=
 =?us-ascii?Q?uOAnWqMPe6auG1kgwxFlPRGgdcJSdEdrmCgtub2Cn1rO9I3bUQY+sO0EhLmN?=
 =?us-ascii?Q?T2DtC4UguZsXOWepAIt166Yd0mzpwsLqZo5nxMaPyyd1PT+MMDx4TuWjR/Oy?=
 =?us-ascii?Q?k/0Lu/LhS6SbCqr4Jz635DljvmY0Ekq3XfQEha+7kVrH6Uc9n11xJKVQNbSQ?=
 =?us-ascii?Q?0i5aqUSlY6mbYl3MRfSaXOd/a62+5Eqy8T+tNmLvbxOtK+fUbINziJGQi9+X?=
 =?us-ascii?Q?UwDKJ1dRKcWbLGOa4hPwvlsPMej8fLIdB/aotkZ0DsQce/m0JUiuWmRvJ5qd?=
 =?us-ascii?Q?t5hk/zJae1SoONBvP4SYDwpKMQHfWp/6qjBTMypPJXn9Hi0YOCFQZWU0aUlj?=
 =?us-ascii?Q?cH+aXFZwvdHPyoRvBaRjizB+62Mp1T2F7XT8mnCaJscqmNWtyKz1zQB1fUwj?=
 =?us-ascii?Q?A0DOvDCguGf/Ybro7GqDszBKGzP1/dQZV88cMeQ52II0Xfmg2xDNqCoaOg3X?=
 =?us-ascii?Q?36h6qKdx5cV62/1PQ9LpI7N3cGEvgimfN0Bdif4JVh0Kz+nFllQ/0qgGmeFp?=
 =?us-ascii?Q?Y16Sz4FdEFYZQQcgS4HVAi3gT4Kfp0D8a3mRgo/TvYlHn1ROXbP8G9kf+YQ+?=
 =?us-ascii?Q?QdeDg9MUZ4nvrMsgFFvPTqlVrAPqoks+//thYer5tFUnSgBFd+Ig0VSE5GJI?=
 =?us-ascii?Q?ujeoOHu7mmbMN7TmBI6VFFKizw/0pRkb2ZOzHSSfdFfKhhut/9K9PuPRm7Iy?=
 =?us-ascii?Q?NsOmcKLrD8RcLFR9+GdkPvzmfcw+WXxTPWyqdQ9WiRA/xMo9f4lXdf0Ae7cH?=
 =?us-ascii?Q?oHShBvIAeA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d5498d-690d-4d95-170d-08dee663f7f9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 13:36:57.0728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTDf3J15HnAOr9F+z4mpX7dlNM0rdeMlzVNvkMN1JLVR2yiEoSwcLvVoBAEVC0yEnMPRIu8+zg6zjf9HWnW3NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8626

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add a central fsl_guts_read() function which will take into account the
endianness that was already determined. No point is duplicating the
if-else statement each time we need to read a DCFG register.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v3: none
---
 drivers/soc/fsl/guts.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index a2b4c477b064..e1b3a054e681 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -111,6 +111,14 @@ static struct fsl_soc_guts {
 	bool little_endian;
 } soc;
 
+static unsigned int fsl_guts_read(const void __iomem *reg)
+{
+	if (soc.little_endian)
+		return ioread32(reg);
+
+	return ioread32be(reg);
+}
+
 static const struct fsl_soc_die_attr *fsl_soc_die_match(
 	u32 svr, const struct fsl_soc_die_attr *matches)
 {
@@ -209,10 +217,7 @@ static int __init fsl_guts_init(void)
 	}
 
 	soc.little_endian = of_property_read_bool(np, "little-endian");
-	if (soc.little_endian)
-		svr = ioread32(&soc.dcfg_ccsr->svr);
-	else
-		svr = ioread32be(&soc.dcfg_ccsr->svr);
+	svr = fsl_guts_read(&soc.dcfg_ccsr->svr);
 	of_node_put(np);
 
 	/* Register soc device */
-- 
2.34.1


