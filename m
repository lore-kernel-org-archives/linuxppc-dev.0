Return-Path: <linuxppc-dev+bounces-22520-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75A6CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 19:40:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbtKt0l84z3bsj;
	Fri, 12 Jun 2026 05:40:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781206850;
	cv=pass; b=JIaCVfDxkocb/2lAYGLgXYZvR4tLoyPzH0MMyureoLeZ65mod/w6zDoehrbp+5SejrRrBKPqcYHxg3uz4bK2y/g6VsFAB/VAqMuBE4AcvYNUPhLPyZDW0ZN43sK1LnGe/8hV6fLW9wDNRySTRkGDwP9Y2iaOEalE6KJOMkuESpcFzDLskNDnirwC/6iDWqfAn/7xAydB5Hkr6IvUnSmuR2gcLNe2RgoXbNI5tvh9jPTTtmOQXDrlT9tb+6xj+ix9flzaJCSl7/XX/GFVHGVsBT0fHXISQy26NtsEeszL6AIofZrdMxl93eJu5a7sp4QvFUi10wmq5We4W7GSkzLyeQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781206850; c=relaxed/relaxed;
	bh=c+bmot+GD7jB4zYmqa3CNTB7toawJOmyZxoz/4v/mxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iX8VKGFflnjfdmThKutJfsxLinfyQG3bwG5vqi+1rGIW0bZRz7c+cBRKEcQ07CWaFa8BZwUMo7sGrCj4nz0mcDuGhe9KmeLZpGZYttT8vDfGKV2Skue6qhA/0B9MxWYw6C7L2nNVD8ctW6PReTIIPan5QLJHl0QE2871F2B4DW6KiBtu7rdYRYjkVlDk9BBtL1thVVnkgKTSexEUjuhbYCgkMdQdl1LITovj6bXRZ2yjIyLSUR5KTxLVgYkPYJl6rvJ61AnPByT64/PM4/f5WbBkb6pr7bFoHHlNlBIyCQA2IBquHdiJ9Z0sSqKM+lWmdq2MvGLnf2uhnA29OWwwhw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HQnaBhHU; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HQnaBhHU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbtKs2hc5z3bsM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 05:40:49 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnBz0Kk1HKjQZsvd2LIlqMP0gLFRYU6W6JYMf2K7jMweJMRGaPkOT50rd6fcphKSS6YRS/+fFc6wxImoFNBOxULvTiVVDxfEX0awPESoFNVWmEfbw5ricvP43s1eSTj7BxrPNCDtAL057htrAxQg7d54dCGbYVe5kPw+97HXmoTLd0exrrjKx4YmV/XbtYjO6/WdqFvILI/FxXpjpNMpMMhgAxFM6wb4zOoCfiTCehuGIAKAev4qSDc4x1wBdUdeQH1oBTp5eKxEmM0CjmEXmKiJ3YwAmhCc7U3zwb2la9cvlyI290CgWs6+hTYqcXcumrI/y6lgH0l2kl8BwagMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+bmot+GD7jB4zYmqa3CNTB7toawJOmyZxoz/4v/mxI=;
 b=kO2d8duW0dGclDT946IXnvRvomvmVasyvEhdfUvl6GbeIeI2V47t9a8kYcZ97WccQjoZAjKtoqNHt2l9AT0qjTukc6SUI8KojjO4HhCa04K8xZslaO/ignWZllqpwy2SAbgBjoY/1xUxKV3enILlAec7sLmPGM9DvurOToCsdDTzNhv8cv2SdlOWvR5AEO/bQTCTndQCeMwKX7GY/2jRUqErRd4uL7N4PCTgb8a2xPjSShcNIsgZVqHWa9Yd2f1j+KZt9xdUUCUg8ypvQK9pJPKWhVyNQ+3RfWSzqIiswSyz7bxfB6ahN9/usr6I4GnghclOhR49Tv+ennhI3e9enw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+bmot+GD7jB4zYmqa3CNTB7toawJOmyZxoz/4v/mxI=;
 b=HQnaBhHUErxLiMaqHhv76V7n19yAPM9wslMQrtFZY+F91xzfd6e+HPpOtibN6NrYXD9hwVl1G0wlNcfu9hyVpl7hRgpuke0gjJafnRUCgM40sojPHilcN6d/k9+CnqKlbGY002KXj9dfUhD3gBV5mzBI2LQlIT62dawwUbBVkkNxPRRAtYmX6TRI+UUHomTam1vMGmhR3bekPdXxiAnPRnPilwSkk9mHjKlz6J4lBQmfLq3CSaxeOvCrPB1fHmdLoMaf4PTACQzQCupt2mPu7bqQoyywtbZ+fwUZH+YJiZGpOEgh6U2XwfdPoESKKgD6Hjp9EBCIOwRkhCoSwf5hsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 19:40:23 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 19:40:23 +0000
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
Subject: [PATCH v1 phy-next 3/8] soc: fsl: guts: add a central fsl_guts_read() function
Date: Thu, 11 Jun 2026 22:39:35 +0300
Message-Id: <20260611193940.44416-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611193940.44416-1-vladimir.oltean@nxp.com>
References: <20260611193940.44416-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0137.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::34) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: c9c30ecd-bc54-45bb-617c-08dec7f14750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|19092799006|366016|7416014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	qkv+trB07DfPVqjvkxLEP3eAPrNQsWyegqbDgWME8OZhPDz7Jv8zNWowTI/flwmUxRCVvsZhyDLkwEqK8D8o4uxZKrmC8up94XbLHITNkErs4V0J+BT4s8Crp6TYmXlXNbJktK5YZKC9qxnsDH/Uck0aaoHyxZ7H6vIx6J+PG7hfu2q30fVD0dljnbGHirh2Mo7D9BFi9f3zr3jpvknJ7FDMzK/TE/ytb41ZstDGwRfCM7f05+ZWPDYrSnAY0sQPfwQ33c+0IJ7InVX3KMAy9f7HRjrALJb4Ogp2bvImuOrXF45xfNLSYsTbtjuIpaNJWZ4vb6QToUxe26kFWagrUGGpB57i/wwk31+Mq2xaekE8vCnw+Cg3+e3IoqvuV151QUKHSZYDXn15eFZRmEwf6iTuK5GusguOU8QsheALfc8cn8xn9I1PqkEt+tbJu2dUtfYtu+HgSGoJpd9CnpkQ3MjOUtxweZM8b2CR7rnDgbZ4BXdYqZLVNc8YfqWTZq82OWDMcI1sBgDWYrcq7dM7g9jxX/vtupNtE0S6nFPRrdhttivEuNFluIwhyDsdhRuT2eE3L+8q02Mg7LU10nmqExYU3qTUvBw8mnqIkPiWbZpNu71fqmSSHd5UJdv47vab9p5iJc5YnwmQZScTc8teAM2ZGyqSddB7qpFlo0qmcaB1OlGxTmB9qgc1Z3nyZpfE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(19092799006)(366016)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7tv920hTrEERVGd/N4gzMegnG8SsTSgbLB0BiX14FqB6/haVnvHJsImReIYi?=
 =?us-ascii?Q?ARM+Hj7ChrFn7JiBHnLw0XcuDs8pr6JYGDsdXlzyyVRXT4fsJaLZMfa7uBTe?=
 =?us-ascii?Q?w1VnEOiSxJP3EQ49b/6s/CJXSlSZOdpJMHPaeELK69vhgD0iRPpgUCk+4PKy?=
 =?us-ascii?Q?e2C/Xp3XP06/gNBSUTH3001vduesdiMKIioKwrmhN2yVwmQzdG88HG46N9iR?=
 =?us-ascii?Q?2BdqTRFyxB0cFANxfV426IoaKp5KVnZKrZaO96qthm2w5nA5ku1eIFXdcJLK?=
 =?us-ascii?Q?Vi/Ped2Nkq+B/KZlTjfkGfqWDnNIGkfnNp8jJI063qqVPBPXTJfYKcnFrfEg?=
 =?us-ascii?Q?KLxasXabf2Soo+xamHsaQ06Tm4tQ/WK4CYp2rQD0sqhignGVRStBq4uN9S7c?=
 =?us-ascii?Q?DQ/tRI99pux3iPH5Nd5kUVN8V2c1VJLrpS/Bx/OT+QYJCNg8BiLqyO0a5+3T?=
 =?us-ascii?Q?J1aLUEp+WesE15BfxbTPbV/tbdAODHH4wsuTV3ss+O5KuOrlJLEHvAocAhw0?=
 =?us-ascii?Q?2Hy1MZf5wBoWYRkNhIwc8QxRCA1jphh9B2n0IunFpRSpid3k2AHYEF8wV8mx?=
 =?us-ascii?Q?Nh2Seeo/ZS0MXgFAC2czNuTn2Ti67Xz6aZjq+uva2E3VHhPP770nho87dGSv?=
 =?us-ascii?Q?EGzR0r9QIyEjvnLlSJe3YwpPtg+a4tdQJJxRTeRCp96R57byUQ4eR16sBiGO?=
 =?us-ascii?Q?bQKaXSI9gZhwfViCui8kcvF2L99krskcyGNy9qGQ8zg9HiiA45/oPjj2qVdQ?=
 =?us-ascii?Q?sB5IEs8comhFDoAeC3UscXDFDT83WFlj1GalnwmV0WdzLM/PDCIDi5VUaVqT?=
 =?us-ascii?Q?nsRTSMkT5JZ6l38taFb+Sst8nXGlOOyWzFqRkHK+7MQa47rmkEBImIIPFx6M?=
 =?us-ascii?Q?LDtGzyTOdtiIF0lJmTYcSXlYYnY9BAeEFhQRPfomOSw35c2zvIX2kx/2e8Ni?=
 =?us-ascii?Q?LsHlIBxl3DWhcPehm6sxc0UJVXd8xGKOzZiBqyrCzy/NTg3YWymFR0RlOst6?=
 =?us-ascii?Q?Pcu88gJgTPlr0JTvqmDV6kU0wGcPH4HMWEgoURoDatk4y6atrvVXY9NhfDVR?=
 =?us-ascii?Q?pgKBLxg0DFQBGtN/gGyH0ugIRJ00ThSsQVVDRehAHRP5EaPB9ZOB1YTEQ67o?=
 =?us-ascii?Q?84cI5sQ4kHLNZv0Ae1/B8vzu5Z8XiFGmE69Inj2hr7BJ0hLZgv2g/WBSpvyV?=
 =?us-ascii?Q?hhC7wkvu4gPkp+uiN3aySq6BaU3GIdTHQQnprFt+EKPwFETZ9uvjL2S9Q7TM?=
 =?us-ascii?Q?RJkYiKWa2eY34HF529+B4QxrYM8g4IqfnM+gjB57cOJagM81dxP8XK4qikwo?=
 =?us-ascii?Q?7URIIhIwyY0NsIRd+G4oCm3sTYmqM/odVVPmlzG9+/2laHxor5AWwgGCnIIm?=
 =?us-ascii?Q?D0/7wX/bUCf3FH3s5Uey4SscvwlC44vU4L1e8BoRNZ4bPD8ubUgBTC5a3l6b?=
 =?us-ascii?Q?ytop26UyGlYtZ13hgYC0gJoMCgXpd6KHWlhNDMKFEpn3XDOY2aZvlTxz7uXU?=
 =?us-ascii?Q?ko6SHx8GnZQyZUJK+hA5I3tSMxTNdsADaht0LkQua9ztjGdPaGR/DX0BUs6i?=
 =?us-ascii?Q?fRxVINMe0va3hncxsIZPnBPGRCo8oUy/t2QkmUrgze1vQJ1AGwJrF0kMRQaT?=
 =?us-ascii?Q?a+yJV0D1WxuWu8NszYE+7A1IBpk9wwzo+pwkg2ecjoNEhdy5hR3suQWLelTM?=
 =?us-ascii?Q?5bmzhXSF781nhcJl+D95V2ddPkHrwOBKj1xJllQHoEv8XMeeqKqLeSgXj1Vr?=
 =?us-ascii?Q?oRq9qp4j9r2eTv5iSf9IrhWWqzyivSrETliloapDhJOYLW+THccC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c30ecd-bc54-45bb-617c-08dec7f14750
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:40:23.1928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8f0erGsSwojnotYX5GqiM1w0nVyBPHAjACCbPnU5hf/N4RugKEqeWIfzZZ31qnGH1yu5X7kxmOyRn6xekOnzTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add a central fsl_guts_read() function which will take into account the
endianness that was already determined. No point is duplicating the
if-else statement each time we need to read a DCFG register.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/soc/fsl/guts.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index a0a52a5603a5..dc1a42cd9544 100644
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


