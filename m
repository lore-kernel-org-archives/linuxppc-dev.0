Return-Path: <linuxppc-dev+bounces-23346-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B21C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 03:26:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grMj654xyz2yks;
	Thu, 02 Jul 2026 13:25:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782962746;
	cv=pass; b=alW1edptCyiRbYc6mAbCizsjuA1b9p+w5/NBqVFlEMSwOZN7q0pSQ08qh9f5kolayc0ZFxUToVv3TMs1lj6dxhcss6dezXUFd+e7QI7A5YYR7ClW4V45X4lzQvqRLt5CBVX6NzEThHwPWpBF3f0+Ff9jj25QzeUnPMXIn8QVeT2gw0J7njolvYavt8Eq0vbjtx9wmL55Cb8U0MRnLXFHTde5FizgdQvw16CsC61DXjGORldv5tVenIkVDYERODoMzneo9kY8tsBodxY8ck/AHF1+CeeRiTJyTR3dX1tmzhBuEG4bABRRbwRUsNDUUH9+q9b467V6LaNlBvAqRIsxxg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782962746; c=relaxed/relaxed;
	bh=laEqqxQLZLzYQtBU0n5VfXeJP8j3yGHfiXlzBZT6bmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DHajxq5tpyMgOPFjuXHHn4TEv0fNCs++gBaWgUWUVhZkR+Doe/ie3Rj1d3yEucbREK4r6YfKbkWHTw7CamruyJgrviAIZTWV0+P8NCiKbEmTsVewGJO3T7laCuoLRw7LMhMbIgvyL2aVdJf4c8RvXRiyHjARlPPh//5cg/KJXU2jt++GnKuUUSYlODb16g6pyoyTrWhW6P1XBLvgp901CwzkqaTgQ++/wCEHRYISxPHGP4Si69Y5FimsGY9qn6wDcB5Qr5TQLBCeN7n08iB5bCjErADeGPwvPPmQuOwovvovqDPD3PDqJ4fjjJjacBkYRZsvrF0n94yhSZzQpSOkaQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gnXfnZE9; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gnXfnZE9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grMj53lcBz2ypY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 13:25:45 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJs8hdlWiC6cO4YU55I74+75SjJMdzHiCO3SyV8m4NlKTGwhQjX1K/SVdsw0sTrZoM8fqLnq7WOFErC0ZHERrW3B4tRplG5yx5Il6yiS8CDhlFvO1rx1sYx1+1Si14U1K+LZlaXZIkz8sUUzIcr3XDivjcgNY5PfozTQ70ssu5R9B+Eoae1qOWhbR0UPdV7Yqkj3yuQFv3b6AZgTsQ3hMPggfjL5adOp+4LcPdWhRHhTOgRxyVkg8hpBXOz9pxT4bKn0Y/weYWnLuU4xIT04Y9y3DCFXaCr0CwjuMOZwaHz3s2mGAowjqQc5Y8T9k2hACEvw6yFlyrCG4HZNDVI3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laEqqxQLZLzYQtBU0n5VfXeJP8j3yGHfiXlzBZT6bmQ=;
 b=gSbsJKZsOQNLnd9T6UYWKU84+GJjOpBJs3pkWKqsKOLb03uLN976oAXOEr995IcVERx47wobHCHF+85Z0O+70CWRr+7EK/gV3yyG3c8X4I4kOgY2UicJTfADSEwGmsnqA2le8smFw6EUDHUNx2lc6hRsW4uowFfnz9HwK1+9SBzKiCiAgtDDfiEFGYUIxa/UOb4D9ONsSPmBW1KeAKxLY6CbweMbgk+GO1cRWS6g3LoS8SB47uhaLB6mvZYQa09IZJkLpc/iDEtnCc9RMk3+OTJKbUgpaNjnk4GUuxUraeibH7ArFzz36Ks0xWVuZDLCXVA24pGy41VLd3NPDMirvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laEqqxQLZLzYQtBU0n5VfXeJP8j3yGHfiXlzBZT6bmQ=;
 b=gnXfnZE9szd76+bd1vBZjfwPEYO5De4YtB508tV8rhEkB9Ctx6b8PAvjnOAzM70ZBwdWnxO27etFPyYsvV9UEgomWM9bybSCyV6OPSnwuiEwJPxo4MwsQFw/zMj91l2gl1KheuCXnUOgfqD/NB/k++JCdwnWJWzHiUzUHdGMxMvucUFWWxPYUSIbuTN2DyoC/x4dsBhzt8sNRN5Vc4b/3dXsPrzR4xw8HhwbzHq/sgjXwu/rTNbKWVG76QVpmD4M05w2qWnxsLW5RcBMkhSRga1P+sngkqPck7bCYrheC5PNFvIIvfoJ2jkfr1X8TixezTsp4WbETk+cqTvZ1rFGzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:25:37 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:25:37 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 04/14] net: enetc: improve MAFT entry management with bitmap tracking
Date: Thu,  2 Jul 2026 10:57:04 +0800
Message-Id: <20260702025714.456233-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702025714.456233-1-wei.fang@oss.nxp.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::7) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GVXPR04MB10248:EE_
X-MS-Office365-Filtering-Correlation-Id: b005a06f-7a79-4033-c5fe-08ded7e99589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|6133799003|56012099006|11063799006|22082099003|20052099010|18002099003;
X-Microsoft-Antispam-Message-Info:
	OqibjrKKeqSclJF0qcK5ynoe+I0U1N+ZlWRzTRo8/93quARU+BCggoqpvU2S7lYdlWc21Cri+/tQrcLNwDS2xvW3JUT/igcewagrfO2zasHhNLdeNEsrDty9Jcth9Pl091hl0FP0yjKLPLOMAQSUONnuZMhZOolSvs9UR8f3j3/ta6T/5MDOfD/En4SEsdpqATAwWy7qBH+F9u7XGXRr9qC/VcMTjEoU0HktCbQfIxLWLlWq+9GZ1qea6hknPuWPvVGeDv15Jcr4nFAmAaddfAYGoE/1bQGnNfTdGK0DEPs54nCNrmQ+WauKTnJelI205V3KQUME9/vuInAYUE9DawywpHJY48AMk/lJ5socA0hs5XHXhaOx3rjWDDWAXCDvnDOGnDfeTdh8q4Rzk2AaBxHa4tDe1reoNYOASi7vrUqDoKtCfJ1Ipp6LT/mN/eMN3j0bankCc9edJIMdgfvTdKdczWtSRZlt/ODklxNShHbwJtJAgsS7A/GNnTf6seoE4xEuhbSZThgYM8edTzbDfMjmcw7JjL/HYbw69zHwAKg1JTc42kET0xM6J8KI5ZjOZIQPFc0qRbAnYe6tSROdti142VqsUUtVDjeZJeyR8iGV8TJN1lFJbnwIFXYv5ZpB9m5DCyUhTwXCkgR4LmpLSBuXCciDPT2t3SOuuSRTxIZ8buLZlAxlN6LpzFFef1WtXo28rv1uQj79EEodafgwHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(6133799003)(56012099006)(11063799006)(22082099003)(20052099010)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NPE8kOklFFxwd+uDb88dc56Vfjn1T17qpKvh4AuGsCN7+QnazrWZCZ1aNKRe?=
 =?us-ascii?Q?RYQvEcapX2wwQ+NYWCaet2Io9eOFlukni6CpJFo0cgKNWe5ivYRfz5ANwS4V?=
 =?us-ascii?Q?qBR/y90c5+nJ+6UQ7rrtgye7d1Shck0oaEYV3K1WvHAzbcd/nTTPUkMGxuws?=
 =?us-ascii?Q?YkncwwfbXsHOWbDl5KLpwnLw07wz+KVjblLLpJBRagJrvGn1vSV6p6yjpv3Z?=
 =?us-ascii?Q?cuS6IsHrCXToVbLmrQfqcTjPQ/yNOOBAbddYqsC9KqvZHyNiI6t0jkG1BC6s?=
 =?us-ascii?Q?RTKucqTHsZfMFbruNPIGf8Gz/aFs9qDedsTmsEYKSgHCfqzs3Hnjs65nIDi8?=
 =?us-ascii?Q?CA27kDAy4WiyA3y3lvdBDpQddh/9K7ryKlk+Ju3DDffbRANG7VH5I+Xa9CtX?=
 =?us-ascii?Q?xQluYwNGldbDzkrfXZGvhKy6AbBTHknz7I2TDG8fDxHeUCukhIGGXjfvVISG?=
 =?us-ascii?Q?dbgM5Pac0BL0PQAgFrAVrRLSRg4vYZp2AKIloB6ukOTkhMZHq9fg5Pdm7TMD?=
 =?us-ascii?Q?efa0S+nnhOUhf0DicVEQuHIe5P2rCGo+o75Szl6Mel5wmburlyV8gsjMRVaf?=
 =?us-ascii?Q?QjkaYXapmwXRsLcQwPsYx8Gk2emJVAd5GEZVCtOSppnXqmbYSsuCFZ2I6g7F?=
 =?us-ascii?Q?sB7LEhK6OFSO3lvaNXWPewtpBmSfJrs/Wq117EPeh9uBVTKiJ6JSVem+UlR6?=
 =?us-ascii?Q?yjj93MeCrxJXcJi3WM7SNlQl8j1mgd7FevdxoZjI23NPEY9msnRbcpYukOgB?=
 =?us-ascii?Q?yIuzgZWLN63vEoh97m8HkmDqNmFTadoBLWtaL50c8n4Z5w9RSngb0Yc46U+p?=
 =?us-ascii?Q?0sCT+eVFMEsHTfjZBoFIh3J7+WHALslEPe6GiZ0FNBW49se0xo7j7aJzXsNo?=
 =?us-ascii?Q?0mDf2lRgUHqaNMxbKhj6D1/LLDc2IMrGhVKrimJkkoMGFEhN69XE8Tp6WY6X?=
 =?us-ascii?Q?uvZNlbpy7UzlpHj4KvRrhmV+Ns+Ctt4aZNpusu0SKe+orW8k8yf6/o6toJX6?=
 =?us-ascii?Q?Nq9L6sBNhd1R8wG3q4kWM1wTWT2dBjXbc4M+L0d971pX1ye3UxsMsrRNWHsU?=
 =?us-ascii?Q?vgmvYM0VRNpGiS6Y/AuyQ46XxhigTwvFZzA0SVGTH9cu/8+k8b6rPmI96Erk?=
 =?us-ascii?Q?PM/8gliEW17jwCZOXN2DyTYB7ix9gcLjptpm4ox/T23o6MCc1vTmZBQcRQOR?=
 =?us-ascii?Q?9hSrYhSzGe3FToSy7wOCQTsMAAB3o84TAULHExAaeMYo8ppwjNS7LKGl6t2q?=
 =?us-ascii?Q?oGc/mz7YiDlia6Gl+dj2gMAA4zkcF4Pk6Q3oZ+DhmyF72JGz4GNvRPcj5niO?=
 =?us-ascii?Q?4d51s2svYi48IClTWQGK9ppHnz3gnqRSWHUzlKnYiqi+igtO+AqTDtrIB+45?=
 =?us-ascii?Q?YRzu1xkitEcuqv1L/8Y+KVr8YxJIjJROSUNfyfQOKdgaLeW764rx9Ovwgg/4?=
 =?us-ascii?Q?Jj2dB1r4x7Zz2yX5hH+/O9XyNr4nrhxRqZHactA6mOo0yXgnPG/ugnz6vINa?=
 =?us-ascii?Q?X2W2uyUFHZond1EJM8pcV4J1rLD3JZFZbSyhj2h6kDxqUrrbIy1V2WlkCyh6?=
 =?us-ascii?Q?cLD/WvljAsFY576uiesuPzsN080C8nL6eW1HmYhY05dsYZuhWKAKR/criUGz?=
 =?us-ascii?Q?oV7pyK8fAWNoaB0v+NYAkEeHoMVMtyxvmnSgL3i4CegY0zmFQjBpdg/XY4nE?=
 =?us-ascii?Q?yTFYPzEb77qK9mz9FOXpSTxlY0inCADe/NgpKMrZb47BWrsZTfDcdGn30OEA?=
 =?us-ascii?Q?pvetwTQiSWW+NId3IcViEQdLTMhOBjf/phb5iTwTw6Lexl0BGBbV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b005a06f-7a79-4033-c5fe-08ded7e99589
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:25:37.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5m1UhzOpagfNZOURbyeP0vs83hH1sN7inGAQYAox/m6LGaGvGxt4IYEU4dIKzBn7wMV3065GZuWEmzTlYV6ge1Y2pYb53L8NK4TDCH3Yb/LsY+uBSwuMcJwLAUDHmwT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248

From: Wei Fang <wei.fang@nxp.com>

Replace the counter-based MAFT entry tracking (num_mfe/mac_filter_num)
with a bitmap (maft_eid_bitmap) stored in struct ntmp_user, which is a
more appropriate place for NTMP resource management.

The bitmap approach brings two improvements. First, the entry deletion
in enetc4_pf_clear_maft_entries() now checks the return value of
ntmp_maft_delete_entry() and only clears the corresponding bit on
success, keeping hardware and software state in sync. Previously, the
counter was reset unconditionally regardless of whether the hardware
deletion actually succeeded.

Second, entry allocation in enetc4_pf_add_maft_entries() uses
ntmp_lookup_free_eid() to find available IDs dynamically, with an
upfront capacity check via bitmap_weight() to avoid partial failures.

The MAFT entry count is moved into ntmp_user.maft_num_entries and
initialized once during enetc4_init_ntmp_user(). Helper functions
enetc4_ntmp_bitmap_init() and enetc4_ntmp_bitmap_free() manage the
bitmap lifetime. The debugfs show function is updated accordingly to
iterate over set bits under rtnl_lock().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc4_debugfs.c | 30 ++++--
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 97 ++++++++++++++-----
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  3 -
 include/linux/fsl/ntmp.h                      |  2 +
 4 files changed, 96 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index 1b1591dce73d..4a769d9e5679 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -31,9 +31,11 @@ static int enetc_mac_filter_show(struct seq_file *s, void *data)
 	struct enetc_si *si = s->private;
 	struct enetc_hw *hw = &si->hw;
 	struct maft_entry_data maft;
+	struct ntmp_user *user;
 	struct enetc_pf *pf;
-	int i, err, num_si;
-	u32 val;
+	u32 val, entry_id;
+	int i, num_si;
+	int err = 0;
 
 	pf = enetc_si_priv(si);
 	num_si = pf->caps.num_vsi + 1;
@@ -50,22 +52,30 @@ static int enetc_mac_filter_show(struct seq_file *s, void *data)
 	for (i = 0; i < num_si; i++)
 		enetc_show_si_mac_hash_filter(s, i);
 
-	if (!pf->num_mfe)
-		return 0;
+	user = &si->ntmp_user;
+	rtnl_lock();
+
+	if (bitmap_empty(user->maft_eid_bitmap, user->maft_num_entries))
+		goto unlock_rtnl;
 
 	/* MAC address filter table */
 	seq_puts(s, "MAC address filter table\n");
-	for (i = 0; i < pf->num_mfe; i++) {
+	for_each_set_bit(entry_id, user->maft_eid_bitmap,
+			 user->maft_num_entries) {
 		memset(&maft, 0, sizeof(maft));
-		err = ntmp_maft_query_entry(&si->ntmp_user, i, &maft);
+		err = ntmp_maft_query_entry(user, entry_id, &maft);
 		if (err)
-			return err;
+			goto unlock_rtnl;
 
-		seq_printf(s, "Entry %d, MAC: %pM, SI bitmap: 0x%04x\n", i,
-			   maft.keye.mac_addr, le16_to_cpu(maft.cfge.si_bitmap));
+		seq_printf(s, "Entry %d, MAC: %pM, SI bitmap: 0x%04x\n",
+			   entry_id, maft.keye.mac_addr,
+			   le16_to_cpu(maft.cfge.si_bitmap));
 	}
 
-	return 0;
+unlock_rtnl:
+	rtnl_unlock();
+
+	return err;
 }
 DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index a02b01753ff2..b966637572a7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -32,9 +32,6 @@ static void enetc4_get_port_caps(struct enetc_pf *pf)
 
 	val = enetc_port_rd(hw, ENETC4_PMCAPR);
 	pf->caps.half_duplex = (val & PMCAPR_HD) ? 1 : 0;
-
-	val = enetc_port_rd(hw, ENETC4_PSIMAFCAPR);
-	pf->caps.mac_filter_num = val & PSIMAFCAPR_NUM_MAC_AFTE;
 }
 
 static void enetc4_get_psi_hw_features(struct enetc_si *si)
@@ -92,31 +89,45 @@ static void enetc4_pf_set_loopback(struct net_device *ndev, bool en)
 
 static void enetc4_pf_clear_maft_entries(struct enetc_pf *pf)
 {
-	int i;
+	struct ntmp_user *user = &pf->si->ntmp_user;
+	u32 entry_id;
 
-	for (i = 0; i < pf->num_mfe; i++)
-		ntmp_maft_delete_entry(&pf->si->ntmp_user, i);
-
-	pf->num_mfe = 0;
+	for_each_set_bit(entry_id, user->maft_eid_bitmap,
+			 user->maft_num_entries) {
+		if (!ntmp_maft_delete_entry(user, entry_id))
+			ntmp_clear_eid_bitmap(user->maft_eid_bitmap, entry_id);
+	}
 }
 
 static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
 				      struct netdev_hw_addr_list *uc)
 {
+	struct ntmp_user *user = &pf->si->ntmp_user;
+	int mac_cnt = netdev_hw_addr_list_count(uc);
 	struct maft_entry_data maft = {};
 	struct netdev_hw_addr *ha;
+	u32 available_entries;
 	u16 si_bit = BIT(0);
+	u32 entry_id;
 	int err;
 
+	available_entries = user->maft_num_entries -
+			    bitmap_weight(user->maft_eid_bitmap,
+					  user->maft_num_entries);
+
+	if (mac_cnt > available_entries)
+		return -ENOSPC;
+
 	maft.cfge.si_bitmap = cpu_to_le16(si_bit);
 	netdev_hw_addr_list_for_each(ha, uc) {
+		entry_id = ntmp_lookup_free_eid(user->maft_eid_bitmap,
+						user->maft_num_entries);
 		ether_addr_copy(maft.keye.mac_addr, ha->addr);
-		err = ntmp_maft_add_entry(&pf->si->ntmp_user, pf->num_mfe,
-					  &maft);
-		if (unlikely(err))
+		err = ntmp_maft_add_entry(user, entry_id, &maft);
+		if (unlikely(err)) {
+			ntmp_clear_eid_bitmap(user->maft_eid_bitmap, entry_id);
 			goto clear_maft_entries;
-
-		pf->num_mfe++;
+		}
 	}
 
 	return 0;
@@ -146,10 +157,10 @@ static void enetc4_pf_set_uc_hash_filter(struct enetc_pf *pf,
 static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
 					 struct netdev_hw_addr_list *uc)
 {
-	int mac_cnt = netdev_hw_addr_list_count(uc);
 	struct enetc_si *si = pf->si;
+	int err;
 
-	if (!mac_cnt) {
+	if (netdev_hw_addr_list_empty(uc)) {
 		/* clear both MAC hash and exact filters */
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
@@ -157,21 +168,19 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
 		return 0;
 	}
 
-	if (mac_cnt > pf->caps.mac_filter_num)
-		return -ENOSPC;
-
-	/* Set temporary unicast hash filters in case of Rx loss when
+	/* Set temporary unicast hash filter in case of Rx loss when
 	 * updating MAC address filter table
 	 */
 	enetc4_pf_set_uc_hash_filter(pf, uc);
 	enetc4_pf_clear_maft_entries(pf);
 
-	if (!enetc4_pf_add_maft_entries(pf, uc)) {
+	err = enetc4_pf_add_maft_entries(pf, uc);
+	if (!err) {
 		enetc_reset_mac_addr_filter(&pf->mac_filter[UC]);
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 	}
 
-	return 0;
+	return err;
 }
 
 static void enetc4_pf_set_mc_hash_filter(struct enetc_pf *pf,
@@ -393,18 +402,60 @@ static void enetc4_configure_port(struct enetc_pf *pf)
 	enetc_set_default_rss_key(pf);
 }
 
+static void enetc4_get_ntmp_caps(struct enetc_si *si)
+{
+	struct ntmp_user *user = &si->ntmp_user;
+	struct enetc_hw *hw = &si->hw;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_PSIMAFCAPR);
+	user->maft_num_entries = FIELD_GET(PSIMAFCAPR_NUM_MAC_AFTE, val);
+}
+
+static int enetc4_ntmp_bitmap_init(struct ntmp_user *user)
+{
+	user->maft_eid_bitmap = bitmap_zalloc(user->maft_num_entries,
+					      GFP_KERNEL);
+	if (!user->maft_eid_bitmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void enetc4_ntmp_bitmap_free(struct ntmp_user *user)
+{
+	bitmap_free(user->maft_eid_bitmap);
+	user->maft_eid_bitmap = NULL;
+}
+
 static int enetc4_init_ntmp_user(struct enetc_si *si)
 {
 	struct ntmp_user *user = &si->ntmp_user;
+	int err;
 
 	/* For ENETC 4.1, all table versions are 0 */
 	memset(&user->tbl, 0, sizeof(user->tbl));
 
-	return enetc4_setup_cbdr(si);
+	err = enetc4_setup_cbdr(si);
+	if (err)
+		return err;
+
+	enetc4_get_ntmp_caps(si);
+	err = enetc4_ntmp_bitmap_init(user);
+	if (err)
+		goto teardown_cbdr;
+
+	return 0;
+
+teardown_cbdr:
+	enetc4_teardown_cbdr(si);
+
+	return err;
 }
 
 static void enetc4_free_ntmp_user(struct enetc_si *si)
 {
+	enetc4_ntmp_bitmap_free(&si->ntmp_user);
 	enetc4_teardown_cbdr(si);
 }
 
@@ -422,7 +473,7 @@ static int enetc4_pf_init(struct enetc_pf *pf)
 
 	err = enetc4_init_ntmp_user(pf->si);
 	if (err) {
-		dev_err(dev, "Failed to init CBDR\n");
+		dev_err(dev, "Failed to init NTMP user\n");
 		return err;
 	}
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 285b7e5c48fd..6f15f9ea1664 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -22,7 +22,6 @@ struct enetc_port_caps {
 	int num_msix;
 	int num_rx_bdr;
 	int num_tx_bdr;
-	int mac_filter_num;
 };
 
 struct enetc_pf;
@@ -60,8 +59,6 @@ struct enetc_pf {
 
 	struct enetc_port_caps caps;
 	const struct enetc_pf_ops *ops;
-
-	int num_mfe;	/* number of mac address filter table entries */
 };
 
 #define phylink_to_enetc_pf(config) \
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index d3b6c476b91a..764ef2892608 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -75,8 +75,10 @@ struct ntmp_user {
 	/* NTMP table bitmaps for resource management */
 	u32 ett_bitmap_size;
 	u32 ect_bitmap_size;
+	u16 maft_num_entries;
 	unsigned long *ett_gid_bitmap; /* only valid for switch */
 	unsigned long *ect_gid_bitmap; /* only valid for switch */
+	unsigned long *maft_eid_bitmap; /* only valid for ENETC */
 };
 
 struct maft_entry_data {
-- 
2.34.1


