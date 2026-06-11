Return-Path: <linuxppc-dev+bounces-22518-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB0FCD98D7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 19:40:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbtKp6WvTz3brB;
	Fri, 12 Jun 2026 05:40:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781206846;
	cv=pass; b=K7o3iZJoPOIl94p6ChP1gDgtIs0FoiPTsEaqNUnl3PlEbuB1vrCSt1YmMzJiqlx7JfSr/7un83IWvInUClvJl5tY7oD9Y5Y27J/VLaIsbTUYhKSJHR0xn5Pe1pinymhf/5xkjVDTvtG0lXDnJANS0lSDxfFysD1SEzpbMLlojyw5R3diTZpB21fGBh8fXFa5bw6JVKu0R/wVj5DqdjRg1g/8/v2EYuOmWGBoIWUgrPhqT00MSE3nd+bMKTlgGNsIBNuoNxzCJXVuAknkE1XKPUbNjU+IeGFNIAXfL4dJaNNnws4L5FoBghKx7INO3WM7/3dFlHaUs40z2HzGKldHKg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781206846; c=relaxed/relaxed;
	bh=j7rNEP1S7XK0YZyzNph/SaT8wXUQ3uYQB0xA03POlpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W4KaUUe3VKGc8DjTAZARnbFCMf7edxqQkq06rqma+ScPxyKZN1GFXtmSYjoMubbnGOn0xsnnBJ6FMmSwub0R35C8NzYszJIgJpeU7cHd7EroGf86PcE3JnqR2joET0+PEsjgl4x+brsbk8BKqg7k7xDZOyRfqAVdkncHsLO9dU7CpUoC0T97XUP6YImIxneo70+Jmkn7gzxQtAi4NTomHJVk6OnVL0qEuJ1Vi4eq8jkht325wGcj9zt88nCj8JAFotRXLvpjDz5hu+U2D08Qy6XqUtaQUMLj3aOBefeMvMJKVvl/PvkW44LmF+WojcU1vEm6arY1yjKruc3ZX9YcMA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=IX+P0ZQa; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=IX+P0ZQa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbtKn1Y71z2y8h
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 05:40:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWZZPXaJJXuiR2rXiE95Ecxi5j0K4Af4dYdfQnEo8+IDNnngmhzG+sAI8MH8a3cJuJwnIrjapFkqQcQgXiBCee624Ca+Vob58eKDdVjE5OxwfalhA6WIuEvWfkvxnpDFUip2DnuXmwgtq0yiHhvN9SKJhdrMrVPmNsgI/QepzyN6b2+MI0C40bDU0cpOHrgDJqgcDJJWzRsdQlM5Y66lN9vbVkBnEOJKIJUKeTmQiFc4fo8RjDI2JfN7p04LrD+A0JLqhksO32IV69VwhoBOjYC4+NB4CGbHHitKRcPh46p/a3LNj89tlTuXfZERVO9d3w37x5HUYZHo4ccq761gGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7rNEP1S7XK0YZyzNph/SaT8wXUQ3uYQB0xA03POlpc=;
 b=oO1GhlQt48apxLl37H8/EOkfPhyWTq1ehCfQCnrUFHPovp2BksHjUEno9Po0uAcgb6FYU9S6jPPBpL+9a30Hegybt+TPeAjTESHGgUvJx7tnqZyWhOwTuGIP4Yu1oU78gKDyc141+4B420pL753PtnoKqEPNFEqxuqqvjAGdIN+EIcTbSz2Wo5iqR/0cF+A0mlQlqzKBAQzEnI2X//FtIDYfLqt0QDTohA6lg0NKvfW6KMeQ082MmXFXu6PAcoP7ozLhA8m9/X1Odzoo7neoFKtycmFGfPsx7fFunNtGDewNr4C9QONpm5EkQDZtKi2qRwmjyxrL6YpOKF3aUtnRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7rNEP1S7XK0YZyzNph/SaT8wXUQ3uYQB0xA03POlpc=;
 b=IX+P0ZQaqTbHPcetlUxaqjfpXEAL1LvqtntBmxl4KDfLvErWPZJMXD1DxLqvvsC6Afkdb+iklPhPns6PP2axyFyNeLPySqr8gWgWUiyVPTyagmoFt/P8An1R5CVdfkYog/H5FK71wGEySRaLsqUzCOL5y5pKgn7e1SsPCJUX1OkPj4VfEdfufUMJDloQu69+jyMrBziY3/6eM+PcU8S+kW2h0SYq2ctWqiwy830yNCbr83ufy3VlyCO/NuI/YTweDsxSUIWO9Qll0ZhC3l1Kz4EUsMNK/tebLCPCVatW1EQF1+JAHEmjvs8pinjbcuicfgVzmWU8QpQKiP4OtCeQPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 19:40:19 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 19:40:19 +0000
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
Subject: [PATCH v1 phy-next 1/8] soc: fsl: guts: use a macro to encode the DCFG CCSR space
Date: Thu, 11 Jun 2026 22:39:33 +0300
Message-Id: <20260611193940.44416-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611193940.44416-1-vladimir.oltean@nxp.com>
References: <20260611193940.44416-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::11) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ec46a1-684e-4ab2-be91-08dec7f14543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|19092799006|366016|7416014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	HtSTS7t0Z/5EeZO2FgjuFrn2vuMxlEMek4/MAPC624dM8lk934ksfnrGpwETpt+Z5XAqdYX8B80nscwBdi4qcyUm+BbEq/pOC2NcG4YEbRGrvRe+H5eEErtrPhHkhOt2PJxcgqxFqF+68ZYWZt01lx5b0auQLNSbO7YRZps9ak9fsP4lxtPqaFwyCZI8Xi/nBcZP4VUtGauzfFQ2nZqgeXVefa3ngC9+qqxHcVXxKx7bvx1G2ox1IdHq7GmTQeGfEk4VFBPECu4C4YzUHhvAiOHXUyGVTZF54+V+8koa60duvgZO1+YEvN4WMIH23Zr06CSsl2ssH4Yra5BMW7BEK8fYuzY/1m5Cho92TeKyWEoRGSWypQYD/CH0TWMeAONN4kYypMhN/t4cL9PaAyj/3+pWdugEK8CY5xr0r+JDIVACymyebjonoIKLOOA7z+ODDfXLH03pSv1tVc0iiTo82ye9+jx17eFgeg7VXaBW3dKaUgxvMf/mIjGKwa294SHIr0mWKIgsmEnvJzJyQ0RlYf1FyFyO+mQqz1YctG37uScUK8yo2DypJHmJ5X93peYdLGdIKCM7lZe8Ri//r4yTSL+nc8ULLH2URtbTEtMpWgBlBxOW9CTpOgM+GkbiRyfpo3tXcHiutj31VM7aS+q0Yy6NkiUcl4oKat21jpyXdRuBcTToMXXuGd7IPx3o8ZMQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(19092799006)(366016)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hcr7O7gDL1y4/IyIL/h+P+f9MzkRJoebUfRtk0vAl+1pK1CxOnGpWfweZXkk?=
 =?us-ascii?Q?Ur47KxJviMqi7LK8L43PVBZU1+LCvvrAnjruYzsLKsz9H+KPCBSUKqyu+goC?=
 =?us-ascii?Q?Yfl31ZzZg0I5XES0zboeKjkhJ3Mc6zdiF07+mf6dN9NO0FMI0NeMNrgGCLdy?=
 =?us-ascii?Q?AzY21MJ97E4kS4ZlhAE1vRinVsbUncow5kdTfWr9RhuCcbGfQSxdkmufD8GH?=
 =?us-ascii?Q?7Wr7jnh70fe1rJ/rlaNS0lyY5mqYTYBKshKU51+aQdRaMoEgUqqWSWplXhxp?=
 =?us-ascii?Q?6/iLmN4WXsZjoKbpH48lIigcJ0pifqzSJCFZYkhatB9JiwDK8+6cqc3YRzA1?=
 =?us-ascii?Q?QYpfeH2cG3XTHKpsAE7saXS10uXm4vHKGwoz5H0wvzYBzqVxDb5rF1FVevO3?=
 =?us-ascii?Q?3HXMOvZ/cz+sJG5db16z4EAeuBpEuiAiLY50h8nIHgX36vLBmPoqwBZR+rYf?=
 =?us-ascii?Q?4h6zMN3F0vaTDiCw4gCSPs0Fsl/WWIsRCbbUCDUfdCPipLX1arSpb3nUqKfE?=
 =?us-ascii?Q?g99Q7mCex3r6dTQ/v7Jw+iFP1Ia/Mw7dBq7l6uL5mnJA44SIVbviDyoEdIRh?=
 =?us-ascii?Q?IzQRcuoJ3+PpIr6t04B+UsSH/5lC5JXmmbQYk0EjjaahKCwOXcsXQHSx0Im4?=
 =?us-ascii?Q?1me20uMLtEQ28eB8/Dw/ooBC2p4Ujb4sVulEaGuUXn4oYumTOqbsLsV4z/6b?=
 =?us-ascii?Q?LTi6v1hlx33oRc6n4zQtAFArpgl96MwJ3dufWpkG1kPMkRRqySOhIESx2OdK?=
 =?us-ascii?Q?y65xDoob13k2c6JAEbP7m3Xq2cD5Ec47Nr7fDsVNAEYCk2RWW5bS2KVGhAoY?=
 =?us-ascii?Q?nahnYN2FXbcTepIJZzaW1QG0vVCghW9Mliem/dBWYsaZ1bPVXQ1P0wTB0dH8?=
 =?us-ascii?Q?6dXjVyV/txuseZRBysKgRADjiRIIp84yoTn4BYu8S7mJwFfdB339eNdtrJX+?=
 =?us-ascii?Q?6AmMLTjTRv9i4g2otHwyDR63iobkRi7v3ibwGfvTrJfWI0dLTP26NmS5DFpK?=
 =?us-ascii?Q?HqoHvzUvdrjKmtpr1VGYEGw8lEfxOun8yhTbAKD6tm0+SdoyeiNWp+8ECfac?=
 =?us-ascii?Q?f/Jpret/9+uUqmpdMrpEOIyV2TLeviGo3yiuBilCc3/zwHLgRxBXz9KPjuyV?=
 =?us-ascii?Q?8P8QKg3DZZ0hh0IFNiUC2UNMnulzwBVFbtQiQO69MaBaz7Lph2smCebA4uV0?=
 =?us-ascii?Q?NvPPXEEz1OAuXXP7FMgEs9Z8PeBOEJs9AV7dH6AopbPpqUDuBXq49IbxnUao?=
 =?us-ascii?Q?uc9CN42ZrmgMmaDtd3kabfex4y9de0+F5ORpyUtJyzmp2ftQKxD6d8T3Vyi/?=
 =?us-ascii?Q?RsFwpD7nSWvNI+LdeidKCKTGH37+If0iDgEuCTDswPxO7AtD/6APsRsp+gxW?=
 =?us-ascii?Q?ALDhy8mKucaB/rMg3XBBsD8xQgTpMo+PtwsohZ4Fy5PfHWw65zD7jRnll+kb?=
 =?us-ascii?Q?BWctnXs4UJRIfwESbb5pW0enOxvRk0QwZESmgnzra/8n+QoYONJ0S8iyV48A?=
 =?us-ascii?Q?zsoR/Pce4NMp/B/p56Jf1MbDPqa+xu1z9eiANI1ga6SIANOcQiMFCG70ztFp?=
 =?us-ascii?Q?8aVJUDUWCByjsiaisH+YFP3JZQys22A+Kukgm2xjL5p/SSDFelTF1vL7O1lU?=
 =?us-ascii?Q?755CN2HtanwhAkBFuuwgHSRDZO7Nnm3Z8vZzVP2Gv/kbQPuHrObig2UBi6H4?=
 =?us-ascii?Q?wKpK4LhrNLkeO2UKIg5e9b1RGgStgIM+ha2ZDfZvlohnOpXY9fNuA+tPRuw+?=
 =?us-ascii?Q?kVtD/p/V3rEcYm0osrZmPRtudpY2AKqTTbbJZzBNWuPFELctelay?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ec46a1-684e-4ab2-be91-08dec7f14543
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:40:19.8083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxailRuc6o7NoQzdjCvCYf9lAeQWueqE6O2tRW6LCBekJepqA5xxfRCQkwcyhOI8+U3mZmseIUXRG5ZeGJ620w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Instead of using a hardcoded value when iomapping the DCFG CCSR space,
add a new macro for it. The code will be easier to follow this way,
especially when we add support for the DCFG DCSR space as well.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/soc/fsl/guts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 9bee7baec2b9..f87ee47c1503 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -14,6 +14,8 @@
 #include <linux/platform_device.h>
 #include <linux/fsl/guts.h>
 
+#define DCFG_CCSR	0
+
 struct fsl_soc_die_attr {
 	char	*die;
 	u32	svr;
@@ -197,7 +199,7 @@ static int __init fsl_guts_init(void)
 		return 0;
 	soc_data = match->data;
 
-	regs = of_iomap(np, 0);
+	regs = of_iomap(np, DCFG_CCSR);
 	if (!regs) {
 		of_node_put(np);
 		return -ENOMEM;
-- 
2.34.1


