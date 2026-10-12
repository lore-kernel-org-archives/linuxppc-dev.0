Return-Path: <linuxppc-dev+bounces-29246-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8246FCA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 09:55:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3CWv1bDcz3brP;
	Mon, 12 Oct 2026 20:55:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791798939;
	cv=pass; b=KBP5v9+/vN+vOQ40veQvq7hJhtg7/GlckALUGB9eRsyqxvzvGDaesl9+J2RyfOwr71YvTLZf8ojypHL/1b3w2Dx2epYSvYBEaYAvJ4l1JGVs5xmvT+IsKo3nvpCmQdHyRqSpFa9NuUL7lyftDaILyV0LNuTBy+JUwNTxcEggq8LNDuwhL89oGawEA76d6m/lmqZc7OWWGbwFoZgfa7bOuRkvsoMB86WJ53n4veWPejuqM4dZgfsb8rNe3o0lnc4eDKfwTAydAOaYtvOuo16M8hc6iTNh0WjHkH2LArtqACM0owUDR17tBiKjpR8YA2PV1K+Uq4zUK/VExMvWZWN7OA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791798939; c=relaxed/relaxed;
	bh=zylPc57X8AySMsX8OVBve/BcFzmxvCCVjXS+GCy69cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wy/jLd37cJEs2vyi6hraU6+r/iahTH9jBcsEhLa8+CBWjJdwMbZnQx2o9zImb5O9EbZhi5mOVsWnroYSpBClGaE9G76zDrPDUFYbDeT1ruZuLCNHDzxwN6FNdeUxVFwH5ChC3ZsKGOvbhOXco1hRaYDLgQNQHungLzEV/wT88xfgm6j2l5jvgTI2WPKclznRPJkijAvjKXHnl/1b0Mv5bex2vR3oGbNnDlEipPZ0iC9nsFAG7UvF3qjhRVQmWhEgsRbsgEqTeDQLvAI4J28XU8atxvULJHkW3pRO51nee9+FAkAj4RejZem4pvMbOdhwxYW11B4sby+e7NMVefXfGw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=yK+nBfV8; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=yK+nBfV8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3CWs4Psxz3bx1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 20:55:37 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkDuquayEIzVXkWh1js5nhs+y+5lorRYYrxjkaMwz3pD6w0hVobZkKLHjHn4jlnVdg+tbj4+Pbu2z4zt9BksknbnbUCCn8nvN2Kk+mHcnDIZkdQ/pJv3a5DoDV/6+lwgDooJS/mmMlgAW0np3ZhGV6x1DkTjiy/mXHRvYcR7upno9SGrtTTvZ02k+3M7HXMPK06e3qjeoGptEHO1fRjPfiETudXnRHwPXctLNhu4/3IYFT1NOjOVcC2S0fhoXDmQkJdgVyZShkQdxcqZowBWq/xGp5zHZlddubHCklOWslWGycy53X/AD13yw7nExGHOva8ilFG8b5gzqRzxb0em6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zylPc57X8AySMsX8OVBve/BcFzmxvCCVjXS+GCy69cg=;
 b=ll1cOEGRqkuchYBbr9FOUwrGjDOpBdHQ7M56OeFUQ/aW7A98gaR1L3wtq5zwpt7zQxTmswXLuk5RWKwACUQrzM7spbXCnd96EnVKsXia3PRLP7kAi5IivF2CGsb1XOsdBGN6Ps5bkEigtcFRaS3wxk5JCkEhoSBJ2oUyAdE+cV6ZerPzC3hJYT9qc3ZIWP7yH4UzJWra0JK6VXJeBO/g2HvC8+dzztRPQbB+u46svbHENbwSG67zsg1Clm3hJBeXEI72jB46FWGUOp1kzhMKOM50LJhodi1FU1Mw3ipLtZX7j/T4vx2CpVsZJ3kG+O7D6Eo6hC0lDaTWHFkh6ExcMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zylPc57X8AySMsX8OVBve/BcFzmxvCCVjXS+GCy69cg=;
 b=yK+nBfV8Zfh2UtpXUOxiQlfGa9FFg9ztJ/+CcbRR6xv6xbXah32nddPgvH1svAzP+VV1N2TEFyPc6xt73MAZfondjBoHSBimWzvn1w8dV8WkLFZHjHu5Fm+1hpD242iRFH4QlUI7IFVRMbFyF9K4EgIdeT9j2skVoldLLuWdWWNuj0Vr0UdiBWEYkcxJnDTINtU3lr55mlzzXFDQWisIYnBvOSDE3e1tKWGHQFynvGslRgAaPPsUyhKZhEKT3tmtzLSyGMBM//rGYjIZpbLrgJh417Fik33e1icnA9GpIKklEpo20Jc2sFYIL3wJTeNI404+UufuYajD+5BNW1/fKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VE1PR04MB7248.eurprd04.prod.outlook.com (2603:10a6:800:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 09:55:19 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0496.018; Mon, 12 Oct 2026
 09:55:18 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	linusw@kernel.org
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 4/9] net: dsa: netc: tie setup resources and reset to DSA setup/teardown
Date: Mon, 12 Oct 2026 17:59:19 +0800
Message-Id: <20261012095924.1129312-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
References: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0076.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VE1PR04MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: fc25c89b-3a19-45f4-49aa-08df2846ec23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|19092799006|376014|7416014|10067099003|261009223027099003|921020|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dQQSp1K+nX5yBW26b+OmOtR3oe4zELdXWQ8eij/AywsUmCkD+43loVpPmaaljVLEvThidJmSu9XVXogemIs7WFETgcvTty370owHMvyQEdpO0KuqQGWFWe2rwgezzizrlNntA0iJ3qmMQDI+rfZu0m2asLZlB21NQdQ4IO66bdnDDr6JJdwpyDxtFm43G/MoUxqgBEVm8mWZPsHDvunSlcwdUFPArYbB9CUd2T3LF1bH+YejDgQW31K7AC8I5Zfdxs7mL9F5WNLI5dIKYR2T2+uAE3CQpPaFX9x2VAu+txUsT9mdoUxPmFEtBZ/5dSMiqnLDa/BvukW8T3Kisvln0vDfoxiLrPEQuX5eLsdjYll7E7zF5gbNc64pzOgMS5qUnxx16CVmtIkT35eXZP50FaNtEriZO462kZdGkxZ58czAoUwzRY4sDq7dmtvz0+2Md8cU4DkmGQvRhfg95uM4eIzb0xueUp1y+GsQ9FP5kuHgduzPTDWX3aGP2FNyw5twEGrUwvurgzM2+qwPjfHgiKDtEAOcF32jDhXpsUVHiPqLs6sNaDxgDGCKBc3B0YDr4cSt35abKXMXYY8rA7M5I9+30cNOvrWCgEfSQi7EKp2NvA7mgBoZFeNMZ0HLWqVN+9EEamhkD+IS27LddI5OTKgxM6SH8ariaE7OAtgu3HzZ4RJuosOvLw/jzHUlXnao46iPULqdOgzHhOUlwKygzg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(19092799006)(376014)(7416014)(10067099003)(261009223027099003)(921020)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UztvISflRAWyONJPlGRQ0u01KtLD2rhyjM3Wu4EXYO6p3+kikpWRfWQy6NMk?=
 =?us-ascii?Q?o+eHjfELLu6YdeWT3JQcFMY3aVR3/z+6/R9kjJ3278WWvdqyINxWOCGqmlar?=
 =?us-ascii?Q?Ads096gL2CrEhBt3w6D37Xfmwui+ZsPPMzqAvRyVx76ZV+catRjPDy5LfMtH?=
 =?us-ascii?Q?IVNXneWusCfAeva8qBO3h6udMR6q9S5ccQlyTbUAbBPI1zFUN9zQjQraszW2?=
 =?us-ascii?Q?0fNv5QBLq8nCvuyH++cN14UcMeFp3y000nds3NZ6vDwt/kGG767q70jMbgT1?=
 =?us-ascii?Q?/CNLxwL5o6jonqooY7AOoMiBV//CJzN/hUnOuqrFA52kEBAY+Xm8pYJJ291D?=
 =?us-ascii?Q?K2C9AI6Hos7qywP1CBsw/7ITHT7qv+vCCr3nODHAzQzD/ZB/7UnwqrRN8Ljf?=
 =?us-ascii?Q?W0Avn9mG92woe5Ihz6fSc2VtfHNMREy+Puxst9wjEHL83pW7rFD8YT7nEiJd?=
 =?us-ascii?Q?efFWTeB8ImfAFuPGyivA1goL7KJewbDh0XeD3Ye+6aiko8GUUvI+S5QNGXJ3?=
 =?us-ascii?Q?e4Ai8DBmfjviSDfTfDvUHCz9PixdwO1owlCxWz6GQhTqpMzXCGigV3fwOuUi?=
 =?us-ascii?Q?JyKQIXRknE4ICijllmw1F2TpNrSm6b+Whe1NLX2wEB7UCnchyTEiK9PxVXcg?=
 =?us-ascii?Q?fDbVMI2VoWCQfawbtadMel3NZeV6l4RBYYlpg+tNZ5le/QH+/I8pNcXozWcT?=
 =?us-ascii?Q?TVabFDJ7yBqw/muMwAlmCJjo7Qp+c21YMzQWWTYtS/Z4hmrSPujPIzk35KXK?=
 =?us-ascii?Q?hakV8B4drZGlqNW+102WKvI12Cpg2is8BvCWnIgV/uiw3/pv2vQi52n2hmYe?=
 =?us-ascii?Q?qD1QkSWD0VAw+ggfqx6ySFVkxvLBvnz808XU/WyZtWZpWqZFcs9fmjtLmBNN?=
 =?us-ascii?Q?fRVe2setrMgX4sF8MU5fiZ1jKBNRnhH8zJMOZbfXSVPEXoTr+kBqsQLF/n/8?=
 =?us-ascii?Q?1UTHVN+yL+H/UX0sAFma/H+Zx9Ns+JXgszng6vDk4uHU+wTR4UnqxHWXYCIb?=
 =?us-ascii?Q?MuCNzyF0tGA1l8UFPS3DAsNv0rFmJ5CUte751sQdebb4ypLlnViSfzMOKhxs?=
 =?us-ascii?Q?2PCHDLPARwawJYmAQZz63f48TkmWoQsD7xwAc536JL6pTg8+q7p2t/tioSFH?=
 =?us-ascii?Q?W0Pq1za15IahsaAG9rg8aFUI1Eq7wBtTkfXo+tyEABj9/Z7vA0Gbg/u/yyM3?=
 =?us-ascii?Q?sH1fiBHO2BHLYj8cLRwv606SUqAuU7otvi9wOJazI6Jb30abrXt57wRF7Bqd?=
 =?us-ascii?Q?M3ty8onDgrJYemKl5/jtAnC13qhX+lEI2nmAKhi/SY0Qvrsr+Duww2RuzQS2?=
 =?us-ascii?Q?9SPvp/jCq58Q9K5a3iUL0rH8gAupiTUJzeqNmBo+jGA6v8q6SdrxRQyh2GRN?=
 =?us-ascii?Q?ftGgYiSfQrxX7KITdvJbF0im4c7TkvTl0btGkVsw1V6R8gjGqWX4k113EZcF?=
 =?us-ascii?Q?Er1MCScp1oIxi+2ONfG0E2NQOKrexASUaHDiytqOv0C3kkEsvJJzvvnseo2Y?=
 =?us-ascii?Q?ZdPGHYFrO8rHEL6WcACv2GriylFOU2EPTBZ0Pbx8UDEu/zbTY61wNYWwp+O/?=
 =?us-ascii?Q?Z9Ng3Q5+M+9B+b4s7Etk3AyReSDgBTNf/cEbqtPgPQuo6SoVXCY6aqfduYfU?=
 =?us-ascii?Q?MU/NQOwySPCM4U3SMHytY3mAqlHufneoRihJhVZWJh/IToUwDqQQHzSOZPjX?=
 =?us-ascii?Q?Lw+GHXq5oKnMSDmyLnzLewQOEwwlsBQHhyc8DkylvS+9/m/Y6p8/bqBRB3x5?=
 =?us-ascii?Q?uTL+6SafdL1q6VEoZxpmsjFQmYDsWqZROgPHezZmdai3R9GAh3tu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc25c89b-3a19-45f4-49aa-08df2846ec23
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:55:18.6246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5S0y2+mjeITAIJIOxBuWDwDB3HREH6MKWIfYF5mjXHsWpkWT6TrcaZsuIowy+QT+DVi4byy2BEAHvSzol5pp1XLOqiZyQaZo1TmnRB7HHju2vge4gGQaooASYgdJHnxA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7248

From: Wei Fang <wei.fang@nxp.com>

The NETC switch reached a known hardware state via a one-time PCIe
FLR in probe(), and used devm_ allocations in netc_setup() for its
ports, EMDIO buses, reference clocks, command BD rings and buffer
pool table. Both are tied to the PCI device lifetime, not to the
DSA netc_setup()/netc_teardown() lifetime.

In a multi-switch DSA tree, binding or unbinding any switch tears
down and re-sets up the whole tree, so netc_teardown() and
netc_setup() can run again without a PCI re-probe. Two problems
then appear:

- No fresh FLR occurs, so the hardware tables keep their stale
  entries while netc_setup() builds empty software state. Hardware
  and software drift out of sync.

- The devm_ resources are not released by netc_teardown(), so each
  re-setup leaks memory and re-registers the same EMDIO bus, which
  fails.

Add netc_switch_reset() and call it at the start of netc_setup() so
every setup begins from a clean hardware state. Use
pci_reset_function_locked() during probe(), where the device lock is
already held, and pci_reset_function() otherwise; both reset the
function and restore the PCI config space, unlike the bare
pcie_flr() they replace.

Convert the setup-path devm_ allocations to explicit alloc and free,
and release them in netc_teardown() and on the error paths, so their
lifetime matches the DSA setup and teardown.

The NETC switch does not support multi-switch yet, so there is no
functional problem today. This only reworks the driver so that
multi-switch can be added later without hitting these issues.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 163 ++++++++++++++++++++++-------
 drivers/net/dsa/netc/netc_switch.h |   1 +
 2 files changed, 129 insertions(+), 35 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 77077352c1a5..c639ae67c9b7 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -135,7 +135,7 @@ static int netc_port_get_info_from_dt(struct netc_port *np,
 				      struct device *dev)
 {
 	if (of_find_property(node, "clock-names", NULL)) {
-		np->ref_clk = devm_get_clk_from_child(dev, node, "ref");
+		np->ref_clk = of_clk_get_by_name(node, "ref");
 		if (IS_ERR(np->ref_clk)) {
 			dev_err(dev, "Port %d cannot get reference clock\n",
 				np->dp->index);
@@ -146,6 +146,24 @@ static int netc_port_get_info_from_dt(struct netc_port *np,
 	return 0;
 }
 
+static void netc_port_free_emdio_bus(struct netc_port *np)
+{
+	struct device *dev = np->switch_priv->dev;
+	struct enetc_mdio_priv *mdio_priv;
+	struct enetc_hw *hw;
+
+	if (!np->emdio)
+		return;
+
+	mdio_priv = np->emdio->priv;
+	hw = mdio_priv->hw;
+
+	mdiobus_unregister(np->emdio);
+	mdiobus_free(np->emdio);
+	devm_kfree(dev, hw);
+	np->emdio = NULL;
+}
+
 static int netc_port_create_emdio_bus(struct netc_port *np,
 				      struct device_node *node)
 {
@@ -161,9 +179,11 @@ static int netc_port_create_emdio_bus(struct netc_port *np,
 		return dev_err_probe(dev, PTR_ERR(hw),
 				     "Failed to allocate enetc_hw\n");
 
-	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
-	if (!bus)
-		return -ENOMEM;
+	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
+	if (!bus) {
+		err = -ENOMEM;
+		goto free_enetc_hw;
+	}
 
 	bus->name = "NXP NETC switch external MDIO Bus";
 	bus->read = enetc_mdio_read_c22;
@@ -177,14 +197,22 @@ static int netc_port_create_emdio_bus(struct netc_port *np,
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-p%d-emdio",
 		 dev_name(dev), np->dp->index);
 
-	err = devm_of_mdiobus_register(dev, bus, node);
-	if (err)
-		return dev_err_probe(dev, err,
-				     "Cannot register EMDIO bus\n");
+	err = of_mdiobus_register(bus, node);
+	if (err) {
+		dev_err(dev, "Cannot register EMDIO bus\n");
+		goto free_mdiobus;
+	}
 
 	np->emdio = bus;
 
 	return 0;
+
+free_mdiobus:
+	mdiobus_free(bus);
+free_enetc_hw:
+	devm_kfree(dev, hw);
+
+	return err;
 }
 
 static int netc_port_create_mdio_bus(struct netc_port *np,
@@ -238,6 +266,33 @@ static void netc_get_switch_capabilities(struct netc_switch *priv)
 	priv->num_bp = FIELD_GET(BPCAPR_NUM_BP, val);
 }
 
+static void netc_free_all_ports(struct netc_switch *priv)
+{
+	if (!priv->ports)
+		return;
+
+	for (int i = 0; i < priv->info->num_ports; i++) {
+		struct netc_port *np = priv->ports[i];
+
+		if (!np)
+			continue;
+
+		netc_port_free_emdio_bus(np);
+
+		if (!IS_ERR_OR_NULL(np->ref_clk)) {
+			clk_put(np->ref_clk);
+			np->ref_clk = NULL;
+		}
+
+		kfree(np);
+		priv->ports[i] = NULL;
+	}
+
+	kfree(priv->ports);
+	priv->ports = NULL;
+	priv->port_bitmap = 0;
+}
+
 static int netc_init_all_ports(struct netc_switch *priv)
 {
 	struct device *dev = priv->dev;
@@ -246,9 +301,7 @@ static int netc_init_all_ports(struct netc_switch *priv)
 	int ett_offset = 0;
 	int err;
 
-	priv->ports = devm_kcalloc(dev, priv->info->num_ports,
-				   sizeof(struct netc_port *),
-				   GFP_KERNEL);
+	priv->ports = kzalloc_objs(*priv->ports, priv->info->num_ports);
 	if (!priv->ports)
 		return -ENOMEM;
 
@@ -260,9 +313,11 @@ static int netc_init_all_ports(struct netc_switch *priv)
 	 * difficult for us to cover.
 	 */
 	for (int i = 0; i < priv->info->num_ports; i++) {
-		np = devm_kzalloc(dev, sizeof(*np), GFP_KERNEL);
-		if (!np)
-			return -ENOMEM;
+		np = kzalloc_obj(*np);
+		if (!np) {
+			err = -ENOMEM;
+			goto free_all_ports;
+		}
 
 		np->switch_priv = priv;
 		np->iobase = priv->regs.port + PORT_IOBASE(i);
@@ -278,18 +333,23 @@ static int netc_init_all_ports(struct netc_switch *priv)
 
 		err = netc_port_get_info_from_dt(np, dp->dn, dev);
 		if (err)
-			return err;
+			goto free_all_ports;
 
 		if (dsa_port_is_user(dp)) {
 			err = netc_port_create_mdio_bus(np, dp->dn);
 			if (err) {
 				dev_err(dev, "Failed to create MDIO bus\n");
-				return err;
+				goto free_all_ports;
 			}
 		}
 	}
 
 	return 0;
+
+free_all_ports:
+	netc_free_all_ports(priv);
+
+	return err;
 }
 
 static void netc_init_ntmp_tbl_versions(struct netc_switch *priv)
@@ -308,9 +368,7 @@ static int netc_init_all_cbdrs(struct netc_switch *priv)
 
 	ntmp->cbdr_num = NETC_CBDR_NUM;
 	ntmp->dev = priv->dev;
-	ntmp->ring = devm_kcalloc(ntmp->dev, ntmp->cbdr_num,
-				  sizeof(struct netc_cbdr),
-				  GFP_KERNEL);
+	ntmp->ring = kzalloc_objs(*ntmp->ring, ntmp->cbdr_num);
 	if (!ntmp->ring)
 		return -ENOMEM;
 
@@ -336,6 +394,9 @@ static int netc_init_all_cbdrs(struct netc_switch *priv)
 	for (i--; i >= 0; i--)
 		ntmp_free_cbdr(&ntmp->ring[i]);
 
+	kfree(ntmp->ring);
+	ntmp->ring = NULL;
+
 	return err;
 }
 
@@ -345,6 +406,9 @@ static void netc_remove_all_cbdrs(struct netc_switch *priv)
 
 	for (int i = 0; i < NETC_CBDR_NUM; i++)
 		ntmp_free_cbdr(&ntmp->ring[i]);
+
+	kfree(ntmp->ring);
+	ntmp->ring = NULL;
 }
 
 static u32 netc_num_available_ports(struct netc_switch *priv)
@@ -842,31 +906,49 @@ static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
 	}
 }
 
+static void netc_switch_free_bpt_list(struct netc_switch *priv)
+{
+	kfree(priv->bpt_list);
+	priv->bpt_list = NULL;
+}
+
 static int netc_switch_bpt_default_config(struct netc_switch *priv)
 {
+	int err;
+
 	if (priv->num_bp < priv->info->num_ports)
 		return -EINVAL;
 
-	priv->bpt_list = devm_kcalloc(priv->dev, priv->num_bp,
-				      sizeof(struct bpt_cfge_data),
-				      GFP_KERNEL);
+	priv->bpt_list = kzalloc_objs(*priv->bpt_list, priv->num_bp);
 	if (!priv->bpt_list)
 		return -ENOMEM;
 
 	/* Initialize the maximum threshold of each buffer pool entry */
 	for (int i = 0; i < priv->num_bp; i++) {
 		struct bpt_cfge_data *cfge = &priv->bpt_list[i];
-		int err;
 
 		cfge->max_thresh = cpu_to_le16(NETC_BP_THRESH);
 		err = ntmp_bpt_update_entry(&priv->ntmp, i, cfge);
 		if (err)
-			return err;
+			goto free_bpt_list;
 	}
 
 	netc_ipv_to_buffer_pool_mapping(priv);
 
 	return 0;
+
+free_bpt_list:
+	netc_switch_free_bpt_list(priv);
+
+	return err;
+}
+
+static int netc_switch_reset(struct netc_switch *priv)
+{
+	if (priv->in_probe)
+		return pci_reset_function_locked(priv->pdev);
+
+	return pci_reset_function(priv->pdev);
 }
 
 static int netc_setup(struct dsa_switch *ds)
@@ -875,6 +957,10 @@ static int netc_setup(struct dsa_switch *ds)
 	struct dsa_port *dp;
 	int err;
 
+	err = netc_switch_reset(priv);
+	if (err)
+		return err;
+
 	err = netc_init_switch_id(priv);
 	if (err)
 		return err;
@@ -887,7 +973,7 @@ static int netc_setup(struct dsa_switch *ds)
 
 	err = netc_init_ntmp_user(priv);
 	if (err)
-		return err;
+		goto free_all_ports;
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
@@ -910,22 +996,25 @@ static int netc_setup(struct dsa_switch *ds)
 
 	err = netc_add_standalone_vlan_entry(priv);
 	if (err)
-		goto free_lock_and_ntmp_user;
+		goto free_bpt_list;
 
 	err = netc_add_standalone_fdb_bcast_entry(priv);
 	if (err)
-		goto free_lock_and_ntmp_user;
+		goto free_bpt_list;
 
 	return 0;
 
+free_bpt_list:
+	netc_switch_free_bpt_list(priv);
 free_lock_and_ntmp_user:
-	/* No need to clear the hardware state, netc_setup() is only called
-	 * when the driver is bound, and FLR will be performed to reset the
-	 * hardware state.
+	/* No need to clear the hardware state. netc_setup() resets the
+	 * hardware via FLR, so the next setup starts from a clean state.
 	 */
 	mutex_destroy(&priv->fdbt_lock);
 	mutex_destroy(&priv->vft_lock);
 	netc_free_ntmp_user(priv);
+free_all_ports:
+	netc_free_all_ports(priv);
 
 	return err;
 }
@@ -945,10 +1034,10 @@ static void netc_free_host_flood_rules(struct netc_switch *priv)
 	dsa_switch_for_each_user_port(dp, priv->ds) {
 		struct netc_port *np = priv->ports[dp->index];
 
-		/* No need to clear the hardware IPFT entry. Because PCIe
-		 * FLR will be performed when the switch is re-registered,
-		 * it will reset hardware state. So only need to free the
-		 * memory to avoid memory leak.
+		/* No need to clear the hardware IPFT entry. netc_setup()
+		 * resets the hardware via FLR, so the next setup starts
+		 * from a clean state. Only free the memory here to avoid
+		 * a leak.
 		 */
 		kfree(np->host_flood);
 		np->host_flood = NULL;
@@ -963,6 +1052,8 @@ static void netc_teardown(struct dsa_switch *ds)
 	netc_destroy_all_lists(priv);
 	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
+	netc_switch_free_bpt_list(priv);
+	netc_free_all_ports(priv);
 }
 
 static bool netc_port_is_emdio_consumer(struct device_node *node)
@@ -1045,7 +1136,6 @@ static int netc_switch_pci_init(struct pci_dev *pdev)
 	void __iomem *base;
 	int err;
 
-	pcie_flr(pdev);
 	err = pcim_enable_device(pdev);
 	if (err)
 		return dev_err_probe(dev, err, "Failed to enable device\n");
@@ -2475,12 +2565,15 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->ageing_time_max = U32_MAX;
 	ds->priv = priv;
 	priv->ds = ds;
+	priv->in_probe = true;
 
 	err = dsa_register_switch(ds);
 	if (err)
 		return dev_err_probe(dev, err,
 				     "Failed to register DSA switch\n");
 
+	priv->in_probe = false;
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 305f2a92e2f9..4a8c5f9cde38 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -118,6 +118,7 @@ struct netc_switch {
 	struct device *dev;
 	struct dsa_switch *ds;
 	u16 revision;
+	bool in_probe;
 
 	const struct netc_switch_info *info;
 	struct netc_switch_regs regs;
-- 
2.34.1


