Return-Path: <linuxppc-dev+bounces-23685-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADCBC44500
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:47:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvZbr40sWz3btt;
	Tue, 07 Jul 2026 18:47:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783414040;
	cv=pass; b=FBeTmRiLJrtPMz2NxL+JegJdYMQBZlPsP047kyjlpIJCT5jm01iJkPXg6ciFD4CnktgOCEusqY25iVtmA3PjeWGCm7aRTU7c+kEsakZ+WV4DYsEWuiLIYK9df+kTepSomRF+chypO6OKotVF7ulTa61Yyw27S4H4ORb+MUyhKK/pdwHxZUCFW6FR2gNvMwsO9o0TMzXSoE6QU+eL73lELhHFDBBwwoQz8u76FzVlBr7PxH4dzBSCmapBbaEVadztvas3z8NxZrbCncBmZHuDjBTcwD/CBH0zIiWL4ho8uXmsnuy2WXM/3cAa9kextrpdCRpK4W4vBSECGI87U8NRnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783414040; c=relaxed/relaxed;
	bh=uf7R3hDgk51Q5WBhT1WZQt5pblRb/WvzPKESaRYdXgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZRUPoNrTgS+gob+zq+ylJXrwjdF/zppMDuJumA3RQDg2x47wiA2aAz0pC/5sxm3N2zld5kRyj8ynwPBsMWWGuzn/zV+w3ALVJvFkK7+HN4G1jocV7bI/X0PsGu0/RurCEX+VRqqFIocG1VfR7ZZOcONccR/vcHzoAJu+QS8AqA0RFHy6zDFhk0Htci2NpeWXWOka3wNKceNtOOICStxj8/66b42+dDD4TX5sd2EmqDjrw3qCBCqyUcYX8ifR9cUP1wRarkq8U+YvCabj7oLc+FYNzeQks2xwrz1Likx9uaW3hqcvQFRanoAjfp7u0Ag2nhCVw0Imwzp1L9A3QpQ3Vw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ayFFJwRy; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ayFFJwRy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvZbp6kDpz3bt2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:47:18 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3fFHBqAPPX0umtJ+kfAB6erJW5FEl+ergdqZ8nbrPeOh6IZnYcg6jfvP1rQkq7CalFI+mL7XBhN9kRLw/P0I7C5RiYLiruEKH/3yJFYujVMvk2bLhRKtnqFmVgGlWWTfiablRl/1vf7R5ColZfJq85L8p6egdRnj7XrayehTBST1RuVWuUWS2GLqJsL66rWfptxTtmyabXx6arBtngAzLIG5+b98mwwEyVmJ/UQZc/yqDUkefvnGb997xCsuYql+rBWQZOzcb48wyQ/O+vj+HAWEwHMaqqpkw9xEG57d1oxxWiQ8QCDxUVhqreRJw2v2ll492eu1SOS/2bGq/V5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf7R3hDgk51Q5WBhT1WZQt5pblRb/WvzPKESaRYdXgs=;
 b=axoMVjne9jvcAVsModJbPpM8joEBqmrxJKr3LNtwJ76bunipzCT9Cufnppdo/M2RYtnPZbqokfZN6ry061jcG7XI8+9KJzJDfujwRYPfxmpv7yqpfYMRCiqhf7aFQ9kU+L+d0bgM23Bww0Z3s7xNP0M+uZN8F58sKnnirV7iW/+wmRHJ8i/x4jXEB6JLUobdbWWwGpwU4b6XxrFMRCGZRz7gw6QMVXWJ/daxWdXC7FOXi8+faNx1dVpb1HALsN7Pzs2Q34BfrZvpwF+UQtJa3sph90DFciloa72E7iUrjNd0vl9Lb6tmMHsoZ/mcyZkJDIWZILhWs8yuzbn/nnHSIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf7R3hDgk51Q5WBhT1WZQt5pblRb/WvzPKESaRYdXgs=;
 b=ayFFJwRy187xtBuWEA0WIJuTPpHsjOEx5Rrg4fKDApHQGBVV0Z+W1SFed4e+wZ8kiMtEryc3F9kSUN3j2sT70c6EH0L76fpTbYFBgRlhAT9w9lZXuBtOhTgTODjdUUfgpryRr27NyVBhtIBSN+75ihY5p+w+R0RmAdSsL/NqypGYvmvVbiX2b8py7IyeZcgNk0HG+VeS5/ogZrIpn5iIRWW/SOgcrRb/QOdbt/fE5Zsb5hsQaW6hV75ufdDrWMKmHbJZIzlSB3VA1xfW1gbbk11WDAsKhHA9TOblehTHlIS9NXUIRqVqKYwYSex8HDPwynlfrmVNcLz1o8HR7Ba6dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:47:01 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:47:01 +0000
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
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 02/14] net: enetc: extract common helpers for MAC hash filter configuration
Date: Tue,  7 Jul 2026 16:18:22 +0800
Message-Id: <20260707081834.710730-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 8844f483-dbe9-4f0f-7ee0-08dedc04502e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|11063799006|6133799003|22082099003|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	e24xHcbQoT6UGBFJWWQ+FO0qfSB321+BI8hqxT/iIr+n4yoVFDhT0N8vO+TK7iPIqz8QOqnrKhdnrCzM2ZOUgcN0hXXoUDh5ay4b/I5u0ziuWtfrZYUpsNPoKq62BIghl6NamJsxQ7YDPqur4LZbNOhsZcbT9qlhvsR9P9u2rHekb/4gnujaUGz+KZfGva3EPWY/yqvVcMwFpi01JfvGbE9dLpVfrqa2K6OrxZsXOwCkwxYy3n7W+kvOzqjIvxGLEy/fsXe4I+yyv3j53v6mPz45+P87+X5bn4twKWiZM7ayIOwCrnDg3xEfsc49yjegIRAxoceBnpLXLkF/mOQNGC0wxDs7um3CJUUwunJOgxO/XFnDJd4dOKDMkjz7a41TOKzV4LPxJ0p0Yt7bEh0sEd2zRJc4ExhPEcwCvhT68X9dUgKN/YvzyjHPC1KbH3Eu7y/VA+IGELUxBDb4uA/pCtiZCnB2txrCXU5HvecgjuNdYQEEhiVwHZurur7DiFww4Qpr1A5vLXeKYXKG7WhjAjQa/2tvW7lvDeyfTyEo1/QamMKtN2LmKlZ9DDwW7yGZcrxYnksPMZyT3fy3HJFhv7D9ibW45nrrX9QR2MuQ/Lu4pWukhqtHA1b/suVK5xhYfa3DYGhFoWIDeDey5imCjK4dF1Hb9PO84mXA1xg8W8wJU8/bhftkms76daSgXpYOkx92zWfn9IfGnHK9cOh+PQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(11063799006)(6133799003)(22082099003)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JTmRdlnjqWcZvjFw4vaPuAAzwhJvxAnnfJ8QXRG+bVzymUQUX/HsIYK6qcIx?=
 =?us-ascii?Q?jqaj7VRnCFuwg16k2+SW0vlLGWP0A8KEajSc9/NaQmKuf77lzEdoLwWx9AF3?=
 =?us-ascii?Q?pcqfp+WZ4x/sLdVJRQEqvGswPdXG5H/5xnbzN65zqehinD0B5nfKCEYn2LTn?=
 =?us-ascii?Q?H6jFqJ/53e2D1Ta83G1wTzkUL+my1l+lg3vT6U8d4I2lQXk6VSElNJPGfcOD?=
 =?us-ascii?Q?A9ddVt15mot9s8Iqjr1gLk5Q7PFtWemK0WwcvFJRa+lzWIPvKO82XcOuaIgm?=
 =?us-ascii?Q?i6IL4zGVe1G4rSu0jpESj9g3SC2BKMRrgY/567zWjDZdjaxiFBtDr4bvgDtA?=
 =?us-ascii?Q?6eK/IGSN6sULemKE4wFvHRen7dEewlNoayAtAeaNBisoFHan1bAApWUx0T06?=
 =?us-ascii?Q?xayMIH52IDoXhh2LKLW3CTJCtWj73t56z8XXgZB2y5nTL4iZo9s15q0KwnQy?=
 =?us-ascii?Q?GqhBi8QMdZT0urjEgREY18bn4OLlYQljBs8UqY+8TSwMRPbwATa3+nhg99pm?=
 =?us-ascii?Q?EyWuP1BkahJw97n6zXYThvVfw93UfEX2/+yNm87DQKcfNg3Xfi3TVoTJAyve?=
 =?us-ascii?Q?rxb1qSrOqd0MnSGhKPEr6taNlyHkU03QsaWqHJNKUWNqjTGB0ZTQ5kKJt9DE?=
 =?us-ascii?Q?PmCx239PR3JmMNWh4A4PvAtngnfKJMB0dbCwLq/ksc77E8SEIeCWrMgKTa8H?=
 =?us-ascii?Q?dLiWfEaS1DZPfuHjyPiJYbXhxKqnxFWLUZdwy2aJJa+D0nDQYo5G0WJlVeGg?=
 =?us-ascii?Q?xbWgZm/zTR31L7mPZALNSxUjqwMu2LvxYR0fH6sRnuL1Hp9o+X5yqgIUC2AE?=
 =?us-ascii?Q?4dGK554QnFyU4Gb37OOFL0Pc6KyJtJBmve5uKj09NYubKGGZx3hKPcyDym02?=
 =?us-ascii?Q?CtPH9LY5zDkjr6mPKDx4jYcHPccg4w2YzKavpBV/pN7aY0PRq0eeByjFcBGd?=
 =?us-ascii?Q?wmXLgEzSgAPEnc+0v5m2vS4BbT+itcelUl+hw8gOWOIeYbubr/upcxUDYjhV?=
 =?us-ascii?Q?Og37IPY3QvFkNb0tGIfsxnt/H76uQ09PXwSlpDOOk7rrduqHY2etwTt7PxIA?=
 =?us-ascii?Q?UeEP5p+5GXg9ut2dQqyzUazDFE7/jrjoHU8eMKvarE3emW6z0htXzOVc+49K?=
 =?us-ascii?Q?18vYKFovChx3UFDGxycfz5BA0DIQTaVpu622UBaIXQ9b1GQPFzlIrZ6em8xl?=
 =?us-ascii?Q?U9s358nJ1sXl/Q3ihoXlMDGYhwk10Iley9PcAEKaP7QZZHpeXWdpfGiC+lea?=
 =?us-ascii?Q?n1Hq5bUz2PXD0xrW8nu977/U877Eyyh43NEzywjAC1ZrXkggASPUZNwWwK/d?=
 =?us-ascii?Q?Up7sS4OoJM7D4EmYSnwBh0Jk2v0dUDQ0UZzA/VXhd1/HhclKpme+IddWndEW?=
 =?us-ascii?Q?BWjo6O/ckQDi+qaLW4fmd8OxFW5XetuWHxuIAxmRw2SF/nHaeZwzti/jnaPw?=
 =?us-ascii?Q?UpMU08H1IVRwTwLlJeCCIoSXoIW4x1pLXQ8+PnZWAO9Wp7Sob/knYyEw9IiS?=
 =?us-ascii?Q?6ig0KF8TYkxBCqzvp6PByNmzUqUHUBCoUJrgFdKgbJ5xHajZY4TZiim2bFeU?=
 =?us-ascii?Q?F1o1bTs4ukhRBWHco8uGTTvmZiNB2CA3DdLZ2eHaAuKmuvWBIBkLTdGXX2Ps?=
 =?us-ascii?Q?o498Wh5Ufh3MJOjUM+O4HpgvU27qePLHB2pqgL/84W01mQZa72xzEPCAMuS6?=
 =?us-ascii?Q?+6TYkzAEMEqamaa/azq3u1/0Sr5bKwy6TKxV9kF+TXwP6H64f7OomkYeZujA?=
 =?us-ascii?Q?4KP+yk5M6zE3iSngI2qKsDhcj4SpMwvSvZbNESaeaP09z1nj7Ak/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8844f483-dbe9-4f0f-7ee0-08dedc04502e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:47:01.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4HpC1ONEn/2wXhEYyjo4a0ZmbamJrowjZ0JW96igU8x+6x4ctscnox90xvG6tOHmqsU//ydBvjLctTJ12leNzFPF/ab2ErQuvXzGD1UmBryQXjPBv9sfhCbWjzUIRyO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898

From: Wei Fang <wei.fang@nxp.com>

The PSIUMHFR and PSIMMHFR registers in ENETC v4 have the same bit layout
as in ENETC v1. The only difference between the two hardware generations
is the register address offsets.

Since the register functionality is identical, the MAC hash filter
configuration code can be shared between the ENETC v1 and v4 drivers.
Extract two new common helper functions, enetc_set_si_uc_hash_filter()
and enetc_set_si_mc_hash_filter(), into enetc_pf_common.c. These helpers
select the correct register offset based on the hardware revision via
is_enetc_rev1().

Remove v1-specific enetc_clear_mac_ht_flt() and enetc_set_mac_ht_flt()
from enetc_pf.c, and v4-specific enetc4_pf_set_si_uc_hash_filter() and
enetc4_pf_set_si_mc_hash_filter() from enetc4_pf.c, as they are now
superseded by the shared implementations.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 43 +++++++---------
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 51 +++++--------------
 .../freescale/enetc/enetc_pf_common.c         | 40 +++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 +
 4 files changed, 73 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 304ec069654d..48a74db90ed5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -75,20 +75,6 @@ static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
 	put_unaligned_le16(lower, addr + 4);
 }
 
-static void enetc4_pf_set_si_uc_hash_filter(struct enetc_hw *hw, int si,
-					    u64 hash)
-{
-	enetc_port_wr(hw, ENETC4_PSIUMHFR0(si), lower_32_bits(hash));
-	enetc_port_wr(hw, ENETC4_PSIUMHFR1(si), upper_32_bits(hash));
-}
-
-static void enetc4_pf_set_si_mc_hash_filter(struct enetc_hw *hw, int si,
-					    u64 hash)
-{
-	enetc_port_wr(hw, ENETC4_PSIMMHFR0(si), lower_32_bits(hash));
-	enetc_port_wr(hw, ENETC4_PSIMMHFR1(si), upper_32_bits(hash));
-}
-
 static void enetc4_pf_set_loopback(struct net_device *ndev, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
@@ -147,11 +133,12 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	int max_num_mfe = pf->caps.mac_filter_num;
 	struct enetc_mac_filter mac_filter = {};
 	struct net_device *ndev = pf->si->ndev;
-	struct enetc_hw *hw = &pf->si->hw;
 	struct enetc_mac_addr *mac_tbl;
+	struct enetc_si *si = pf->si;
 	struct netdev_hw_addr *ha;
 	int i = 0, err;
 	int mac_cnt;
+	u64 hash;
 
 	netif_addr_lock_bh(ndev);
 
@@ -159,7 +146,7 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	if (!mac_cnt) {
 		netif_addr_unlock_bh(ndev);
 		/* clear both MAC hash and exact filters */
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
 
 		return 0;
@@ -186,11 +173,13 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	/* Set temporary unicast hash filters in case of Rx loss when
 	 * updating MAC address filter table
 	 */
-	enetc4_pf_set_si_uc_hash_filter(hw, 0, *mac_filter.mac_hash_table);
+	bitmap_to_arr64(&hash, mac_filter.mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_uc_hash_filter(si, 0, hash);
 	enetc4_pf_clear_maft_entries(pf);
 
 	if (!enetc4_pf_add_maft_entries(pf, mac_tbl, i))
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 
 	kfree(mac_tbl);
 
@@ -206,8 +195,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 {
 	struct net_device *ndev = pf->si->ndev;
 	struct enetc_mac_filter *mac_filter;
-	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
 	struct netdev_hw_addr *ha;
+	u64 hash;
 
 	netif_addr_lock_bh(ndev);
 	if (type & ENETC_MAC_FILTER_TYPE_UC) {
@@ -216,8 +206,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 		netdev_for_each_uc_addr(ha, ndev)
 			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-		enetc4_pf_set_si_uc_hash_filter(hw, 0,
-						*mac_filter->mac_hash_table);
+		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
+		enetc_set_si_uc_hash_filter(si, 0, hash);
 	}
 
 	if (type & ENETC_MAC_FILTER_TYPE_MC) {
@@ -226,8 +217,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 		netdev_for_each_mc_addr(ha, ndev)
 			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-		enetc4_pf_set_si_mc_hash_filter(hw, 0,
-						*mac_filter->mac_hash_table);
+		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
+		enetc_set_si_mc_hash_filter(si, 0, hash);
 	}
 	netif_addr_unlock_bh(ndev);
 }
@@ -480,7 +472,6 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 	struct enetc_si *si = container_of(work, struct enetc_si, rx_mode_task);
 	struct enetc_pf *pf = enetc_si_priv(si);
 	struct net_device *ndev = si->ndev;
-	struct enetc_hw *hw = &si->hw;
 	bool uc_promisc = false;
 	bool mc_promisc = false;
 	int type = 0;
@@ -501,12 +492,12 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 	enetc_set_si_mc_promisc(si, 0, mc_promisc);
 
 	if (uc_promisc) {
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
 	}
 
 	if (mc_promisc)
-		enetc4_pf_set_si_mc_hash_filter(hw, 0, 0);
+		enetc_set_si_mc_hash_filter(si, 0, 0);
 
 	/* Set new MAC filter */
 	enetc4_pf_set_mac_filter(pf, type);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index a97d2e2dd07b..db2a800a7aaf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -80,37 +80,6 @@ static void enetc_add_mac_addr_em_filter(struct enetc_mac_filter *filter,
 	filter->mac_addr_cnt++;
 }
 
-static void enetc_clear_mac_ht_flt(struct enetc_si *si, int si_idx, int type)
-{
-	bool err = si->errata & ENETC_ERR_UCMCSWP;
-
-	if (type == UC) {
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR0(si_idx, err), 0);
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR1(si_idx), 0);
-	} else { /* MC */
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR0(si_idx, err), 0);
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR1(si_idx), 0);
-	}
-}
-
-static void enetc_set_mac_ht_flt(struct enetc_si *si, int si_idx, int type,
-				 unsigned long hash)
-{
-	bool err = si->errata & ENETC_ERR_UCMCSWP;
-
-	if (type == UC) {
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR0(si_idx, err),
-			      lower_32_bits(hash));
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR1(si_idx),
-			      upper_32_bits(hash));
-	} else { /* MC */
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR0(si_idx, err),
-			      lower_32_bits(hash));
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR1(si_idx),
-			      upper_32_bits(hash));
-	}
-}
-
 static void enetc_sync_mac_filters(struct enetc_pf *pf)
 {
 	struct enetc_mac_filter *f = pf->mac_filter;
@@ -122,12 +91,16 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 	for (i = 0; i < MADDR_TYPE; i++, f++) {
 		bool em = (f->mac_addr_cnt == 1) && (i == UC);
 		bool clear = !f->mac_addr_cnt;
+		u64 hash;
 
 		if (clear) {
-			if (i == UC)
+			if (i == UC) {
 				enetc_clear_mac_flt_entry(si, pos);
+				enetc_set_si_uc_hash_filter(si, 0, 0);
+			} else {
+				enetc_set_si_mc_hash_filter(si, 0, 0);
+			}
 
-			enetc_clear_mac_ht_flt(si, 0, i);
 			continue;
 		}
 
@@ -135,7 +108,7 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 		if (em) {
 			int err;
 
-			enetc_clear_mac_ht_flt(si, 0, UC);
+			enetc_set_si_uc_hash_filter(si, 0, 0);
 
 			err = enetc_set_mac_flt_entry(si, pos, f->mac_addr,
 						      BIT(0));
@@ -147,11 +120,15 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 				 err);
 		}
 
+		bitmap_to_arr64(&hash, f->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
 		/* hash table filter, clear EM filter for UC entries */
-		if (i == UC)
+		if (i == UC) {
 			enetc_clear_mac_flt_entry(si, pos);
-
-		enetc_set_mac_ht_flt(si, 0, i, *f->mac_hash_table);
+			enetc_set_si_uc_hash_filter(si, 0, hash);
+		} else {
+			enetc_set_si_mc_hash_filter(si, 0, hash);
+		}
 	}
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index b0c0dc668e34..3597cb81a7cc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -131,6 +131,46 @@ void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc)
 }
 EXPORT_SYMBOL_GPL(enetc_set_si_mc_promisc);
 
+void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
+{
+	int psiumhfr0_off, psiumhfr1_off;
+	struct enetc_hw *hw = &si->hw;
+
+	if (is_enetc_rev1(si)) {
+		bool err = si->errata & ENETC_ERR_UCMCSWP;
+
+		psiumhfr0_off = ENETC_PSIUMHFR0(si_id, err);
+		psiumhfr1_off = ENETC_PSIUMHFR1(si_id);
+	} else {
+		psiumhfr0_off = ENETC4_PSIUMHFR0(si_id);
+		psiumhfr1_off = ENETC4_PSIUMHFR1(si_id);
+	}
+
+	enetc_port_wr(hw, psiumhfr0_off, lower_32_bits(hash));
+	enetc_port_wr(hw, psiumhfr1_off, upper_32_bits(hash));
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_uc_hash_filter);
+
+void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
+{
+	int psimmhfr0_off, psimmhfr1_off;
+	struct enetc_hw *hw = &si->hw;
+
+	if (is_enetc_rev1(si)) {
+		bool err = si->errata & ENETC_ERR_UCMCSWP;
+
+		psimmhfr0_off = ENETC_PSIMMHFR0(si_id, err);
+		psimmhfr1_off = ENETC_PSIMMHFR1(si_id);
+	} else {
+		psimmhfr0_off = ENETC4_PSIMMHFR0(si_id);
+		psimmhfr1_off = ENETC4_PSIMMHFR1(si_id);
+	}
+
+	enetc_port_wr(hw, psimmhfr0_off, lower_32_bits(hash));
+	enetc_port_wr(hw, psimmhfr1_off, upper_32_bits(hash));
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_mc_hash_filter);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index a619fb8fed9c..bf9029b0a017 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -19,6 +19,8 @@ int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
 void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
+void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
+void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


