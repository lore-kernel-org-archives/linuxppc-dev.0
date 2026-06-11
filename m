Return-Path: <linuxppc-dev+bounces-22522-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BDCCD98C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 19:41:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbtKw14G6z3bwf;
	Fri, 12 Jun 2026 05:40:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781206852;
	cv=pass; b=giLj3wJB8/S2UmXNtc0nQ3Z/0XNLWf2m6l9YQClHXdtujE+nVjleUQrpcyBpqnDyWjGybLQbqtWuS6+A4EmzBSGIM5dyM0pMkS0ztVRR4nNgaQ4pi15VfkfIgfcMOPUSxSYi/gbhTi94Q5uc567IOgAjTpk0tSCisjw7LjpxVO77zY08iOLuwpnfDn+5hGih3bbLHAtzfqtmNMYbrvXI7rqwIGlv+AKiVA7M+NtnmyYdVPSGf/ZXuETkEvoK7Nv4urgVTEX42yFEps6qwZWoJeeSDE0Lg7NaeAVZsj8/50jFbVtEYceFL0qhlohQRlFaglFLbA22QC+QGiFklKWEhg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781206852; c=relaxed/relaxed;
	bh=l00/Ni3blUNnuL2MDCiWNUWKpErycyhbKogk2N7Vhc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B0S8f/wW+/NhlZjzCFABYE9jnf3DcFD16ZQuwKIt0e1hC3TMkmxvQTk7iLN/QWsfBS9viTSKPN4Q9dWCPNDN3WnWD+6m6A4RW6Ko+jepjaGtvfhVltX4Aa8hWg6ZMoEzRsT640E4m7z66qGnezKVwZaGPeJjT8OiSXwA4y+ljFabCQ2nxhpPKFuVUN/jAiXxLfe6CmyG3Sv4MLhgam8vERhYOVxp37KzJ34RWawaxYur5Ygvn6PCEOCpmPBLu2aoycaUNkdqTpIxHZVMKKW4KX/S6y1j5ygA9bvn0jbQEmI+rFOB9Fv8SqGL3uAJ0Ot9tXjoynUpIOM3ibrwjb7qCQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=hLnU/VpB; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=hLnU/VpB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbtKv3XTRz3bvX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 05:40:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4Pp1T1mD2cFtvyTp7vyN6E9YTn/wpssI/I1iSTkts5nOTf5eE4Q+X/ACNFIRzlyrUwUV8KvFmwQg3+iVLOQQs1lhTS0speYbhL4HgA/4ufxzU8vJveyVYFshjQBiHRUshLHtOIj9sy3miQYTQiRa+y5w0uPTFhhKJ/c5sKsRlh7bTOnCnwdXcxIwiToq6IA9/ZZyIqdprk7EWP2i19DRUOL7FUsPscRnufn9hX6LSrJ5QBOnd1rOIVjlCbF6+SBt07tjGGZQ6zi2gxZ+lwAsI+UY/P1WLU3RM+93XDpaY5U9m43z6cuV9A442IEvd5KGtfhTrKTX8Pb+BqaGZ4EvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l00/Ni3blUNnuL2MDCiWNUWKpErycyhbKogk2N7Vhc4=;
 b=ntn94COs73/J1HnL/Yl8TK83w8ysX72GUUPH6s8fyGVHF/DH6710tBzokD5HHP4OzT0ldo42ypDk6Q9plxO99QCfGNSTmfte7B+05Gk2WktuzY6iJacrT6BE4reWyb0iJuXe6WbHF1QZGgOY2VnABmc6MaVvJr0wiekwo7SUQxP6zRJUFHRD0+pEq4ygPhQ5utMLsR7Oq2fiVeT8tbNlIaBOs2x1FKlxghroTsWhjSPDzR31Nd1/0T9L1DFOsySVpI1RG29cxAZbnPkAzflZ5mLfc4TGMwvKc0bs/u/x+zWmyCrjvbTGENYVL+1aDcyE50I85OcdqjbOB0RRY5DdoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l00/Ni3blUNnuL2MDCiWNUWKpErycyhbKogk2N7Vhc4=;
 b=hLnU/VpBsEZutP01//GOHDaNBQTOG66eG3CJtHFQfu52wIxMAfDKeLthF+HiIgPIOPmPaWa8HsrSvoemGmsnIBKXIYRBZH/BOEPGh/hDwy0/z1BIBQjyKuVDyxD3y87QV1U/bOlOqHXxYZZhEmd27W4HxOnMUU/nyVEWU+Ix6tZWUCAT6UEwbj7uwY/bTE1Kv0K839WGoxLXE9APX1xeRbH3Q2kwrrI61DO5yqBdBcbWRChbzYoqCeFcP4wjcrpoNgDUN8wPoER0roYktFXeU+JBuEX+GSfTQyzl6xf9R9DGukDWaWQR2fAhRqE71t2jWVu7oxaXmh/MQ47JNssT3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 19:40:26 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 19:40:26 +0000
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
Subject: [PATCH v1 phy-next 5/8] soc: fsl: guts: make fsl_soc_data available after fsl_guts_init()
Date: Thu, 11 Jun 2026 22:39:37 +0300
Message-Id: <20260611193940.44416-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611193940.44416-1-vladimir.oltean@nxp.com>
References: <20260611193940.44416-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0122.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::19) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 674e52d0-fa45-45ac-be49-08dec7f1493d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|19092799006|366016|7416014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	QCdNWQh5GYPwGyty3griE7Gg9hJx/SbxjybQ25F4aEOaxktfhfXvhMJ19/CvnrD9h8DkUJ9e6RdSOM2Pr+EtgzxLBsX1yriuOXmDnoVMKIGms9bf2cm1cS60hSlknuobCWTLBd3rJ0H+CSe1r+wtV6wVzhge8gFVHhxgA4Q0loeYTR++NLhLn4KkWMpTE3kCR1PM4BMZGHSqZkjsFFp4Pk81JHwXGEyJMtwn0X8QFA3VHZsMXSv8slLQIsop9iPBQ8u0k5WWM1qYgi7SY34CVrRTi2hirpTM/azVlHodeEnqdK8+WpDw5/jHkLzVQo2yplnGKeOtQhdfQRToa5lS+sn32boRlFrSXk08M8NGK3lH5NaK7qWFD7JuURJaHw6D+mnpSmQtbI5d9L8I7hMbcR8eHJeqVTvVTPrGz6gf4rVHUZar60fNrY3YZTlYyPZzN7VVY8JjL5YfEH3sT4bf/JckBymC4he/Zcg+R8tHnulq1hIio0Q5gX+O+IP6D08ZdmO0NsVRuDPEy7xUzS4++RmGmPXN6FCIeuoyi2M7kQx1hqXk+39MB5RF/iRYkF0CmMCjFofAMPcB3dH6DE0lCl+xuRH5UEH0pn/L5nx6SKVQIWu7BaNsUNurypoi1A8gHXUZ1Bgur/QfOv4HX1kMnXV8Q9YcI9V6O3sJpusIR66zhpx6C5V6dvC35aqhdJ21
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(19092799006)(366016)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mO6v23WyAf48GXxr4VUv/WV8z8YYrKAy6YW794o8/iiny8aim7OzwXQOQWu0?=
 =?us-ascii?Q?9kJwBBrS0ktTPR0qNB69Nd/Xv+ipsfwacihCBd8DQaqxvorYMU8lwuiGpUbg?=
 =?us-ascii?Q?4SdaJxhtNQQr9YJL4HfwLat/IytpdwDsF0G/sTX56GU9s1daNzAJ5FoJA1dl?=
 =?us-ascii?Q?IMULT9IExzxh0Ze5uqRjnda3ZcWOXEhnhfAw+PxE25Pbje6dFIxTgS5C87DI?=
 =?us-ascii?Q?+yLnY0yROBFgIgr70I/Ydzr9+6O3looULW3y6D33tRh61nVW6nW5Kfoc7CRC?=
 =?us-ascii?Q?k9OSfeKOYbpeVc4jr8FQxysLsDr1vOnSiH8aVBskkwyk2SDfYPFMnPK5YoTU?=
 =?us-ascii?Q?VPntFG36UfCaf5vpZUfdJEGQEBfpK3PaDFNdskEchlm2rR3FinthEk1JgOud?=
 =?us-ascii?Q?zkvn1cv7OlC/nBkqi7qXHlP1qog67Wbdz9tXs2EXzIc116ugdLBXOo3myUfw?=
 =?us-ascii?Q?NRJJiNOkKqOU1ct6uWDXUeolSmkJmDt7R0YAnmIK7jHIL9wDFfqKVlkq4VLS?=
 =?us-ascii?Q?LA8GjyCY+midYzs+SzrhRjGF94x0s2KCfVW+FWPHNj6IlUUnvcYYyKuWiRgG?=
 =?us-ascii?Q?HhxtbhDgsqwqmNn9JQXCsyaL2JUfgnBN98LRpEJK8NeOzawHKCJ8E/1AC9mO?=
 =?us-ascii?Q?sTKxq7q9cErQF4AZBTaK+BBq6S+u6VL6ipr1viZz9cORUrARVAVP/lr8h6wo?=
 =?us-ascii?Q?p2JAm1W7sgdyctzZ8g0IWqwc428Zx6MekDwpZfZgFvh8Bue+itbgLts0aPHj?=
 =?us-ascii?Q?kFuvU1rugd6CUHiCCmiFghgmvvaUzLprpip4QosQ/MmtEp29HOWKKGSCMxbK?=
 =?us-ascii?Q?AE2Q3ut3Ke3H71Ry4C356pJFY+kDBNHx8axcV2eqItUcADpBtag9wkiHtUau?=
 =?us-ascii?Q?z74nyPg3hZhToP60Peiffs7LkiFz378lRi4Ws7SzwyENyghMud0OTCG40Jgi?=
 =?us-ascii?Q?Eg8M8FPeDw7ZgE1yUwlPP5CbyAd7igcgCfuy3KlSxgqFuKFSzv0BI47UwYVN?=
 =?us-ascii?Q?WB0h26AucYpG7dhDkauaBXAhc+mucOwTbwbW0wooLF2EuIMQn7qz0vp3k7pm?=
 =?us-ascii?Q?3BtE0FtJkPZoD4DV2KJngH/4BI+2cKYN+ujdY4GkZoKZW8OLVhWEm5xkRFnQ?=
 =?us-ascii?Q?31nH2v4xDGOkxQXJ1plR7uirox6MYv+Cf8szje2HRGKoUGGTmhNlEDPzeVEm?=
 =?us-ascii?Q?v6ifqvxL2OLp3MtBmSISgdaJHKHc9gXh0dB8fXvasgGk0V2H7iub3B08drkB?=
 =?us-ascii?Q?rKZT4tvpSrHi+Y9DFPlOW6SlqQZIsrX9PYpkLDK0s/bk90sIhdE/cKHdnzpC?=
 =?us-ascii?Q?21h9NuMvjy7zqb2KI6vew6GiL3xkdKTlX1/RF5OXXvwsHF+9eJ5BcIYNaruB?=
 =?us-ascii?Q?oUgDPU2CoM7Afdy5nTFnzPuKBx6xRvdy12++z8+VF0vm+IoERTb/nOWLqSNj?=
 =?us-ascii?Q?zFPzzJczlEiOWLMOPUwFJSbsLsKTrHHT9mJvKlPSJ4EBEJbojB/ebYI0DPHS?=
 =?us-ascii?Q?qoz8qxpc7NGwyc9DvbGiWM/bpHwD30KvB7VBwjfJwhPLM8Sqpqfp5EYk0JJt?=
 =?us-ascii?Q?BRyEknCKxVOwQSPBQLYVsvGW/l62kTgXEmez3qgIeOW5vdlNyzlW2tl8J3gf?=
 =?us-ascii?Q?gLwcf5rmbKN8MEDQQ0rOh2XPUngsKVwJpqvTiNPfw6blAzcoabmLQ4OIi9I9?=
 =?us-ascii?Q?XkJgddkY3iTFpFVozsaEVBnbY2kKnKD8xSCBWgEJlYKO/Ex0x6gZ3YP/CNaG?=
 =?us-ascii?Q?0tqbJt0VwuyKth/B6rmW2U7PAcm2YrvnrIrteS7dhVVgSoyixcGA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674e52d0-fa45-45ac-be49-08dec7f1493d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:40:26.4299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIs4i0tkbp8OTzeUKhbyYq+kEf4xOIze1CeVbeBzQOYFs0tNi1wx8COeCNoUexpgmz2I1dT38saINP7IQJzUzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

In a future change, struct fsl_soc_data will be extended with methods
for performing RCW override.

Since this will be performed from a calling context outside
fsl_guts_init(), we need to keep track of the soc_data that we determine
at fsl_guts_init() time, so we can reference it later.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/soc/fsl/guts.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 1494b545bbb4..9f2aff07a274 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -138,6 +138,7 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 
 static struct fsl_soc_guts {
 	struct ccsr_guts __iomem *dcfg_ccsr;
+	const struct fsl_soc_data *data;
 	bool little_endian;
 	u32 svr;
 } soc;
@@ -234,7 +235,6 @@ static int __init fsl_guts_init(void)
 	struct soc_device_attribute *soc_dev_attr;
 	static struct soc_device *soc_dev;
 	const struct fsl_soc_die_attr *soc_die;
-	const struct fsl_soc_data *soc_data;
 	const struct of_device_id *match;
 	struct device_node *np;
 	u64 soc_uid = 0;
@@ -243,7 +243,7 @@ static int __init fsl_guts_init(void)
 	np = of_find_matching_node_and_match(NULL, fsl_guts_of_match, &match);
 	if (!np)
 		return 0;
-	soc_data = match->data;
+	soc.data = match->data;
 
 	soc.dcfg_ccsr = of_iomap(np, DCFG_CCSR);
 	if (!soc.dcfg_ccsr) {
@@ -283,9 +283,9 @@ static int __init fsl_guts_init(void)
 	if (!soc_dev_attr->revision)
 		goto err_nomem;
 
-	if (soc_data)
-		soc_uid = fsl_guts_get_soc_uid(soc_data->sfp_compat,
-					       soc_data->uid_offset);
+	if (soc.data)
+		soc_uid = fsl_guts_get_soc_uid(soc.data->sfp_compat,
+					       soc.data->uid_offset);
 	if (soc_uid)
 		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX",
 							soc_uid);
-- 
2.34.1


