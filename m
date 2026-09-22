Return-Path: <linuxppc-dev+bounces-27880-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88192C982DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 03:30:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hplwH4rMNz2yHT;
	Tue, 22 Sep 2026 13:30:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790047807;
	cv=pass; b=GR8cJFhr8FICClAkLW/yTfzzvJvGSs8Yv7LXVbWAjhWFo+c3JfJjz7oIMf82KSMlAFHaCQ4DlRasDZgKyty89xvoHR9yShk9LVbijYQ8Uax0kau3OUzflHef4us12HTlXkzxFB4Y3GXo17BmHK9tWY0QGZuFpofXaG2lFD7LdcwFD9A4JH1eMv9yX9VWRWdiGS48tFseLdizVdiV/c7gv3pBtkqsiBXJpjaI3hydObuqQyVraLqGMatek3aoLeLvVczJASNrpMs09XeohDP9xMk2maxjlAa6OFK5yxRUlCjouH0zZjem854nG/HzgsvFQSmxqpX9L2/JCQcs0uu/fw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790047807; c=relaxed/relaxed;
	bh=GKYfn+QTFMKSxRRGZOhU1Q1saK+2DGd+mdOZM0oSkjo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UIb/GBAQ3TnJQVD1XBPAie37yy38jJh8SIc50Jg6iVA8qUA2F+2fDoYxezKXTTtadK3VW2fW0DpCy6ygZHtiZfiK2/0TA/EagXxAA+AwmJH4uoR7O+6b9KrH9Tp4b8v8DwwTa7yndSPlPSQYDDrBjnMcHv/iXDwjhr/uBaujB8oKiMy47/zxossaT35FY19Pl1QPonpoUnB9d5jtx6qmxZHzlp0M5JwI2BVavVQxEvAU4z3EkF677l5Mr7pARW+RiQVa9enqdbxVx+9VFIYkY0uShYSIPaouotQdPdK+cDDqyu1me0GPqvoMD0ABf19qWJT7lvfMdg3hXvx1L+uisw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Pbu3zxKV; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Pbu3zxKV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hplwG1yVFz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 13:30:05 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHzC8AarB49qv6kI69323cZeo23vy7Q1CDxlZqPPP6gZZAJIzO4Ryovby3WK+uR6lehm8BvzKhoPmOwgs0Kg7sJ3UwIxMOdw1JpF8f+tdgSMUrIE86ck5yTeg37nONdgMwGkHJAk4n68FWZJ88UdCWk9n+qrxTqB0f4ZREc3PheuxcBsby2MIQQnmjBp+5u+8U5AZsmSC9NvH6pSa8Q1MtMPbU7IgnCtSMwhR49iwWDs7UVPS+MEugUJCaaaeBW5X5hFWUVI1BbzhoujsfJbny3GU23qw3a3/Wq2Yk2vElHmgfuVeBgVRV96uvcLaYGlJh5A0K+gln4x6OY1tRyMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKYfn+QTFMKSxRRGZOhU1Q1saK+2DGd+mdOZM0oSkjo=;
 b=AI49SiA6I96sZP5ni9INVbcPNqCbbNA/1K9dl/UYeh/4Bq4/L7l2STlhUNrpmokhjIiOzgiBJS9wzY/I4zJADZAOiQoMVeUqeW0gBsVt7pVuPdsV4KsyIwoRjwRbQUMnX+I9QLNSfM5I2bByHFP2xsE579RcNRYbJNvtvF6XAdbPMSv/H24raV5Yp8aAXCFFm5fBFKKnYhccY5RYy8xAoCnrrCydTfqUSsjEI691Xm+rhuvBa84WtC28Bn1M6RgBD88tjebsu5mSH6n+J0Qs/noATCTYgCMNT0st8ShxwarGZ8FCBIyB1+gB/sgZtewWuC+e0qkxwZI4U+mGUIz2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKYfn+QTFMKSxRRGZOhU1Q1saK+2DGd+mdOZM0oSkjo=;
 b=Pbu3zxKVr0SU9CnpSj7m1tlxmTVOEUEdkrM/WFv+I0ag4YrLgHxOWjcW5U5izrMyKdYBsmyeVQslCuVW3fJWzWOYfWstwcGtZDrHKW9hcMQsUYTP/O/fGmoD7w9lXJntQqFIeS0WOVZl8qZrAWh+dVhMoBiHB3qkm3PiIfS1AwX9lkIla/B6XEM4NSXg0VJNbPNkU33retaqJa3OQ3Msz6xoQmh6h4CYmZvo5CnvYTAxvfAP3ycXsrgIFi+T4j3WVzQGpcKbmBGfANQqYW5gBUgzdQpTRXlWfkvRQ88BIywtEKmBlAB2vt13Q6R+KfGY9kISKl8evtt6sG/v8vW41w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by GV1PR04MB10941.eurprd04.prod.outlook.com (2603:10a6:150:201::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 03:29:40 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 03:29:39 +0000
From: shengjiu.wang@oss.nxp.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shawnguo@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [RESEND PATCH v5 0/5] ASoC: fsl_asrc/fsl_easrc: expose per-pair/context DAIs and fix DMA race
Date: Tue, 22 Sep 2026 11:34:23 +0800
Message-Id: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::14) To PAXPR04MB9351.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::17)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|GV1PR04MB10941:EE_
X-MS-Office365-Filtering-Correlation-Id: 19aad4ce-38b4-4309-1f3e-08df1859bbd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|23010399003|921020|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	1GUwtuXSRNlTb729gWrSb19E/NLmyUweY26jDBUfvFPIrWXC5cZiK6TPSnqKv7AkHhNh+uQOxPYEEa4JDr9i1GpkgO22Jy6JY8aE9JuidtHsruJ3QHyV6Wa1HsQAT/2Q7evRVsEUEFnLgRTl6qLU7k81rzO0+aUMDaLHpAY7vaYoLWD1t4RTEU+VMH35VVdchiYh/5cgwy4Ht0HVe09TpV0uHmVtO8b7FpjxRiOqQidgQ4iqhtzQaPq+aRLMwiz773iVbRqH4kz/jqgzJuIhJGt0zVfxxdWmmbCopGFPX3cM2/sF/BNha6a8tHs0rU1gw/jqa0ttnYxkKosjl/kxCMUVNTQjW5klGDmrdixmRAhCwRACVK2xR79RyulPSEX1K301seaCItjGe/sjmGBf4OJgxi0dWKSWnds5ytZCRMCx6m8efq4bSWft0Z/w5qsHF9V2bKDz9hQvEer5E2qTsFgpaopU/TUjCpoE3tXosJL9XUj4V0auqghBIYMlD3maxtq6TpgZqteKMU0AhpwHCCGyBIr2+gB/iQzBWz+QEk73iQSdW4dND6udzxpnRZcjpbRsVt53AUtaTejoeXl3963PqQrdgCs4jGX34iJo3OthxcJmlFyeDVBAEaueaQYrsvrO19RTA7/vuu1nPlpVh4qLPDvwp7rhRzAPZJ99TImRtgnZblH2BQbnQ38QG4PFPdf5J4/PcgWMelGmUFQTDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(23010399003)(921020)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YpYLMkxSupYpBJ8UXqRmqAZers1qZxHdx0BaeQHjr50xlluNY+FOfeS4dTDa?=
 =?us-ascii?Q?zTU5DCvfXletjgIMiF7X23z2uDQMV3q4e4lCfTT2tPo+Q6JpdF74qm70FoWC?=
 =?us-ascii?Q?EdN92sXstA/mSowXy6/qkQSF/L5vmBwsWFj7c2HeHl+Svm3bf1eDjFCfWaM8?=
 =?us-ascii?Q?xhGLotF4e5GK4aCL8V15F4q9z2BlwZMWFr27zDyQqnfhkyARn6tXDEtRiiXT?=
 =?us-ascii?Q?JpLLbWITMJ0aC/B9CFcEOCohduyDn2By9m5uOLn0BnNSFEnsq+X5U1i1tYg/?=
 =?us-ascii?Q?1cYQRo7NJzyuhMXcZMYlnA636sSHOS16W8MQwCOakXUkYTItPqg0N2cXpNqn?=
 =?us-ascii?Q?BedWYAnDAZkVCfbRpxKuT4Z3+hwH+qGz/+L2xsaVTS52+s+UVX5etKYNSeVN?=
 =?us-ascii?Q?7LGorKcaMv7NZdQhPyFhBSj/RCs4xD/7zjesFmITY6fMqx6xyso8vB1moV2t?=
 =?us-ascii?Q?YqNzCYy1r/pa2rk97RpNN7W7Rm+xaj1KDjx2S3WLFk8tYgcylV0ZexzpCERK?=
 =?us-ascii?Q?WUUye0QegBXYKV2RCG3XBmvmdMRZaQZCW0Gr/L3tlQLMA16eFrvW4qe2gJ3p?=
 =?us-ascii?Q?2o7PmYCDZmTyrFCGBGBUDTh8delT8Dq3LjeNs9mpAP7Bfe30I0nW7vZt1LAQ?=
 =?us-ascii?Q?/JV/3/E7UZsAbX8CSFfzM2LDDeMvnElMUZvDeJTlZrVTGXF/3jLQYEhYQwPH?=
 =?us-ascii?Q?DRKMgVSGAR/DfLKAcNcJRQGQYuTDOvdHw3xZTt+fVLMQANThkKj/HTJOQCVO?=
 =?us-ascii?Q?FRGKXq61Wadk2MYIGo66LuCbiNThYFLf6VdjJMrOcbiEbwRmQzNugYl7tAmq?=
 =?us-ascii?Q?nGHJiRYK/naogEM3yU9SWfmBAXGyJ6qaJTPX0f9LFMf8RpwaPEmF+6AAkD2a?=
 =?us-ascii?Q?PSsCeHty1bQJMmR1AIhC27ALxghugooHtIeGxRm76SRJ5NhCZQMGxwEHe/qg?=
 =?us-ascii?Q?yWbReC1iFytwZoPC3gp9WW9u3D+J70/Ln6oVmvkYOREAvAoP7BoQOeAxkrmN?=
 =?us-ascii?Q?1slPzyFNYZCuWQZFRieXYoZTTM03G4FUQttIovvaIw2MA4HY8RNeMV+MwDqC?=
 =?us-ascii?Q?WnZiVQhlJuN/1HS45mhaMUofWbUDZASsAabcOlc9/bmg3My93pBD6MYhVbPF?=
 =?us-ascii?Q?zG7tN6cx4Ezgs+ZoMOUZSsN0MhsbdBEPRvexNwtwKQKdcih8kJkIWD2IMqY9?=
 =?us-ascii?Q?hw++BFGdvDg9xih2UhtYswpVZuo89ttJ+oPBKQqY9ncIipeES59xsKAjtBQ7?=
 =?us-ascii?Q?0akBoVYboDLrL8s75PHAynmKeQ8G7F+4A6e9IjwJRuFmjOwR1WM6bIm4kZzQ?=
 =?us-ascii?Q?AM3P4crYcrjOnqjEbES39FtbwoJBfNbZYSwIoIJWNnrFhxNOLeR9YHkE4xMF?=
 =?us-ascii?Q?Zf3do7+ZVHnLpMbXiSN5rce/6C/nbgF34rojFv/Xf9jGmdIAcSuEgqIwdEwt?=
 =?us-ascii?Q?gn6MlLQYMvWyElLvD5ia5LpGA6pSz911JF1yDonT0f6bZemHBljv176aIyy7?=
 =?us-ascii?Q?SGTwZDd/jJycaYgc7NtYXkI9oRHfkKNzUIDZYLCX548Q08haUB/3fHUHsgob?=
 =?us-ascii?Q?guarz9sooIlAYDQ56qxXg36EUYh+rg8gnPgUiMBUnwLtNYS1fnRrZu6JXy2G?=
 =?us-ascii?Q?RV/cXVFP14jXIFeJtuzfSp4rT1hGTA2yoK0GshGVeSD/O9m76z39Q1dTJ80a?=
 =?us-ascii?Q?qnhcl7leIUzYgVEAJO5FzwBdI0WEAYv/5/szRmb6tNRgMH/gjr/DrxBarVmv?=
 =?us-ascii?Q?OM+8KVNbvZAKoQSZ9ZgE6KLKglV16MAKC+7yfke51eplbRbShMQw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19aad4ce-38b4-4309-1f3e-08df1859bbd9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 03:29:39.7848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgICph/gxR5IJplABVu37LocXn+VTvFPl4O9jB3YDWkFjASs2wV5TO1euFI0BPERFiUq6yQMOvj6nLeNALD8DryLHlS02GEOz/J1HxUnDt5CSzoVlqV3/AgsyISUJDSk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10941

From: Shengjiu Wang <shengjiu.wang@nxp.com>

This series extends the i.MX ASRC and EASRC drivers to expose one DAI
per hardware conversion pair/context, allowing multiple independent
conversion paths to be active simultaneously.

Patches 1-2 update the DT bindings to add a ports container so each
conversion path can be wired independently in the audio graph.  The old
single port property is kept but marked deprecated.

Patch 3 moves dma_params into struct fsl_asrc_pair so each pair owns its
own copy, and registers it with the cpu DAI using per-direction setters in
fsl_asrc_dma_startup().  This removes the per-DAI probe callbacks from
fsl_asrc.c and fsl_easrc.c, which are no longer needed.

Patches 4-5 expose the individual DAIs: fsl_asrc registers three DAIs
(asrc-0/1/2) and fsl_easrc registers four (easrc-0/1/2/3).  The first
DAI in each driver retains the original generic stream names for
backward compatibility with existing machine drivers.

Changes since v5:
- rebase to latest master of linux-next

Changes since v4:
- update commit message of Patch 1/5 to add all variants
- add Frank's review tag in Patch 3/5
- add Krzysztof's review tag in Patch 2/5

Changes since v3:
- Update commit message of Patch 1/5 to remove reduntant sentence.
- add Frank's review tag in Patch 2/5

Changes since v2:
- add ports example to original example case in yaml file as port is
  deprecated
- remove the label in example.

Changes since v1:
- Patch 3 is new: moves dma_params into struct fsl_asrc_pair (one per pair)
- Per-direction snd_soc_dai_dma_data_set_playback/capture used instead
  of snd_soc_dai_init_dma_data to avoid clearing the other direction
- dma_params_tx/rx removed from struct fsl_asrc; single dma_params per
  pair suffices because each pair is unidirectional
- per-DAI probe callbacks removed (startup now sets dma_data)
- Cover letter and commit messages updated to reflect the above
- DAI names changed: paira/pairb/pairc -> asrc-0/asrc-1/asrc-2,
  ctxa/ctxb/ctxc/ctxd -> easrc-0/easrc-1/easrc-2/easrc-3; use index-based
  naming consistent with port@N in the DT binding
- Stream names changed: ASRCB/ASRCC/ASRCD -> ASRC1/ASRC2/ASRC3; align with
  the index-based DAI names above
- Binding port descriptions updated: pair A/B/C -> conversion path 0/1/2;
  hardware-agnostic wording to match port@N numbering

Shengjiu Wang (5):
  ASoC: dt-bindings: fsl,imx-asrc: update port binding to support
    multiple paths
  ASoC: dt-bindings: fsl,easrc: add ports binding for multiple
    conversion paths
  ASoC: fsl_asrc/fsl_easrc: move DMA params into pair/context struct
  ASoC: fsl_asrc: expose individual DAIs per conversion path
  ASoC: fsl_easrc: expose individual DAIs per conversion path

 .../devicetree/bindings/sound/fsl,easrc.yaml  |  45 +++++++
 .../bindings/sound/fsl,imx-asrc.yaml          |  43 +++++-
 sound/soc/fsl/fsl_asrc.c                      | 100 +++++++++-----
 sound/soc/fsl/fsl_asrc_common.h               |   7 +-
 sound/soc/fsl/fsl_asrc_dma.c                  |  14 ++
 sound/soc/fsl/fsl_easrc.c                     | 123 +++++++++++++-----
 6 files changed, 262 insertions(+), 70 deletions(-)

-- 
2.34.1


