Return-Path: <linuxppc-dev+bounces-23162-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26151C44500
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:49:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFdp2L43z2yYs;
	Tue, 30 Jun 2026 17:49:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805742;
	cv=pass; b=AzfZDqzrP9MSQykQuvQPZtwd7HHidhzxuj3LWS5PpmWc6U9ldiXDO5qtoLTFFtH4J7npR8mwV60amFwInURu2kvnKShLWBprRsG2b0KFWybWbrDAm6EYpzTu/nYLq7rdAoCwkVPbC8mNd2tZyGWIlcStyU5xNB4PhOTywPEcaQIw8fEaKeJXC60QK178nEs68WkqWvi40GA9GtQadgxjCn5Sj9EuJcfoE+ozDvvlMpzNUBDsCHQogQbMshKm7uwRFdJez31l0wI+gmhMSKECEXrziT/ISQi0JteuLKAdMF1p+e3XVVEYDgfULOyZr2C0EnBnO48BcgddvZDlqHGJxw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805742; c=relaxed/relaxed;
	bh=GCXpVfilOobuwtQo1MG+AfHJM40d4RwVXZ+w/PwLVOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QyY4/35i44tKdrdbq7Ewk2sQQD155BjFMrIQwc5GligVwaoN0TFD5SfYt45WNQFHFmGDOiNsm+fpYwiir8XAf3izhdlN/GiTg6YrsKKHab0LHOIK6Bi1JWXPl6sWoI6OfGa+CTkskgoO/LtANlCCsumMnMcSTwxFeQl9NMuW2au29mWcTvVphey0j6cJ73Dki38v99ZiAwx7W7vsPfZBVC2hjUJZZy7efe8p+Pqg2sqD1O1uGY7ncVdqpgkMsXohqFmg6ug5VUGqgcNLASMoMISfHo7HXbB5zcbFy9JGBU6px0S3n0+aO4s7apCPj9vLY6+TX4bcpchmISKeA4ztdQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=V7XktZkt; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=V7XktZkt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFdn11Twz2ybR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:49:01 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDzdCEs54BXpvCG2zR/eSGbd1hgbSWxAvP+5BMZ4FkR2kz6KPLaZn8m3Jtwuap5sJbxSebLwCURJb6DuWQtwmHUuTRlcnT3K3tS9ySyg/ZnoFYRkdAGbVkaQfaZCvC8sPWS4WRWwHmwdKD9Uf6paRB2Q2jpPwnnd/TxDPRrrVf6D90GONl05gDu32VVCRdbNpRWduOSPjozpY4M4caqOUB4XcsMkQVujOVT42Ff6s54PsLDyFcoDQPHjv5nu47SbJBsE1Wh9iS6l+ThlCJ+fwmKFdPP1KaZpO8hD/dqyAAU/YqXf9HuFR8uTnECWli4rv/gy7DlbilvtURdFWYbkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCXpVfilOobuwtQo1MG+AfHJM40d4RwVXZ+w/PwLVOY=;
 b=yxNC+95zfvB3nN0yioNfEbzwanjcePATzxvkxpx/Mb5PWOmlgjx+g2gUwCIL4zH0qQtLcbGEAAIOsUnNtcc1ptoIvq8KGaAI3MZg48h1S8nptjtkktiw94FQmCFhO3uMH1O9HhldJBBDoUCDhWqNjfq1tpMpz3O+96iXiIEdVChIYzkMrCZ6qRSbs9IycbnfLXXueT6ynsUrW+gMvWlPY6bJ2bICEtwBW+AByvjbMk/OC6QmYGYTGzzsRpfEJtc9dt4hjObHg9QAuju2Z/XpttNoacxGvuYju/SAijXes7GhmWYPvtUx5wVFFHO53CA7fWHjOUCb9fXlbAgWw4aCUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCXpVfilOobuwtQo1MG+AfHJM40d4RwVXZ+w/PwLVOY=;
 b=V7XktZktjFdDSE7We0RZPRnJarriBhzAbYT3SH+dKOmPvow08gTNjLY/nzEiEGGegrB4fshl95J/EFrvYFX/T5CsbaUfyyjLTSMmfmyEhE+SqgWWdtoym7MWA/s5hcxsRH1ep0UyG4BiQVC84S9zg3W2t9dxyEl60lPytSE0vbZo9pvt6k5y7ImTYTy2lRoQr0rcrLWf8ubX24zmMfWPPNHjzcCiFOb/qNT2vMeYIRxxuHZD9+fuownZfjKj7Y6H3vCGvDYg9SDEko5w9XW2BGwcjVchzBQkVbe/MS3MJcBxGl4/ZFd8zufVn/IHf7daHBEprM1zFK/dWILMe2zrrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:48:40 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:48:39 +0000
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
Subject: [PATCH net-next 01/14] net: enetc: extract common helpers for MAC promiscuous mode setting
Date: Tue, 30 Jun 2026 15:20:23 +0800
Message-Id: <20260630072036.382761-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e1d99c-1c3c-43f7-7435-08ded67bffe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|6133799003|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 z9AffuljeIIg2vbpECnb261VwBUsKM8TJ/Jkln2/Jasegsm8aQx6pp8EGltAYJERBp0THn538VgAAOD4X20kUrarROpr8nWBXPFgkAhuhnJ7dvXlNOH7f+WtK+70h43mbt8cSWhexDvpVpnMiw9bqRqw8pwtL8BjBgY/cYEIlCYBSkHEJ0kPyA8b/BabTRg+1QGRS6zeyvTgdBzbuUrCeaqByMM4b/Y7AMbaXwA4PXEsFlwdPtWAnGVJD+GkTxU/v2Ic5Cs6zXjdBlCcemUmJc65SupVSQcdyyOUGENGCsDh/2haHrvDM5SgJAc2MPQKnUYleIJegQaxz8UoFHkCQsLphuPrP1GyNaFkzEs+xo/rzWscSb2Q7MUCM2kSjATGrTteKXjpZVjlbR6BNZCzwzM7BSPtDNYPx2erpdrjhBEd95H6/7rB1M2FsQWIGvVdVq4xz9UgSsCo0zu+rhwc8vqmxlxi7mvfN2lQQABIP6d1VcOkIbJ4skb4JrWipxccEIGewX4h//e8q8Ml+6ba6QpvqkCibTCKHIdCizt6bLXvBUrxAg3Sty2OQkAtCKjg6lITjNd/8usYsJdmD11IDRzJxHtNrHuYp6ktlxfPzoio9xMBbrpDxxDZseRCnKhHmPgXR4fhmEFwcKi98YoIjW0tohEcNyZ0ov7IGB6HVaK/slHV7ooq6zKlf9ywrP9UWbchrWm10zJmyNkTzzgaWQ==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(6133799003)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?YT/ZJCrIMDLllFS1Jc8a7blmcT0lObNIMesYHDJPj7sy4xn0Qs48//XQPYq4?=
 =?us-ascii?Q?IFYj0VMFZOipSBO1J2c+lNKHYFFSXT0nvX4cN/qLz3wiROuYjzB0eGz02VCr?=
 =?us-ascii?Q?NXTDOtmY2wz5x+XoqPNPRNMvF4W8ywC1+Gg2x6QPzKqnwuh2oBeyplmOfXxB?=
 =?us-ascii?Q?ACWcK37hgm1DIByVcaf3djkipUGL11/yn4DgPyGRywXGA/QM98XHoAkqm+10?=
 =?us-ascii?Q?CiG6eH3wjQGR/qQ4jYXIGQ8aOw4eg1+YBE17YuKpCsuo2ZJEDzLVbppHx7XB?=
 =?us-ascii?Q?aDhQE3s3ry4a4yXk8wx2Diky86OGThOQQb8uYUdrcVAOE5LrFYKZwjD+2ppI?=
 =?us-ascii?Q?K9jhRM6w0D/jrJuVODbtJ9n79cWRXGIsDZq1ZI+DCUaeiT0PGiDVuT6608Bj?=
 =?us-ascii?Q?Ulc5FKaZqJ8GHwC0LyJcxWV16+LOsPH2pRXuvc8S14RTDNBWvBgxbiqq7T0H?=
 =?us-ascii?Q?/W4/q7y5cpeKlYSaLqrVzaifOQjp99dAXaIIq4PTaSwFJgx+e5G4PdQg7/7d?=
 =?us-ascii?Q?r+gzGEOLbZ16O+JFcOt6LAM8MxGEhG8GHNGKCOustIKeG2QwCM4pTI2Bp7nh?=
 =?us-ascii?Q?Cw2vSmH0F7OP5b3C2TCeV0gL6nsCEhuk3E21IAIsRFMbPZi4HovJTDtFRXDr?=
 =?us-ascii?Q?ivj+7AgESS0K8pFsztOZBDFPDFlxvPthrcTNGW8rX2Fwb8t+Fh/1rgSwTwO3?=
 =?us-ascii?Q?9Whr+YY2fVG9PYw/Ye/mwToIbabgH+VB7gUKftYU9G48MbeHxrtZSzrCClQt?=
 =?us-ascii?Q?FM33s9urEGJSryxGcJCxahhjvlCWEOeCuUw1EoQZaVHUnfFaoy7faBKZluwc?=
 =?us-ascii?Q?Yc3orBsLxzXUCRum+lZ76v0yvY/8ey8/08gRTle6O0vI+RgKAO5BWpmYuMdd?=
 =?us-ascii?Q?/Xax+FzZX7FCBL+jLGpVb4/jp4+xqvPDAP11WmFbvp6bp8UFxjy+6eBspQw1?=
 =?us-ascii?Q?liyKVC+EO4jdbXmSMa1aiUanJWh8fT/JUbQy6/dsORdX66SXYJvUio5uECMg?=
 =?us-ascii?Q?mP1X4Zgy05NioNLa8xK6ltJCwYwEnM29dAmzVRbyp008NuFv3OL4VZxk0ovt?=
 =?us-ascii?Q?Qf+vCQguxbpb4altjtQo2ic/jaHfJuTDzz2P7PWRWGzwdngI/LkNRWi+PFqA?=
 =?us-ascii?Q?F2uMITP0Pvxg2JMr8vstkfEUCtWqEskfjZH+pf8sEo1Ea73jHJJQP2OapeJ4?=
 =?us-ascii?Q?DD3qBY6i0tL2ukZ5TaSKkZs4GRK9cR2dnw2mMvaQx3eguHlSDdUQRVdi7s3e?=
 =?us-ascii?Q?woZ10PWjgAqtD4fclFFgXYGcpvgKSTPUIfWsutTnreMKIzS4swwXYU9mUiE3?=
 =?us-ascii?Q?lG1p1hbW2TZMOIMtYuSob7PTmjHvLr9QNf+7FE1Y1K8N+AneO076v1s3mmuT?=
 =?us-ascii?Q?cfAtXEWytW1ophOL+1ph/Rakr6BBCwpnGQePVxsjTbqahbm1Ei0rxqTZ3Ayk?=
 =?us-ascii?Q?RN/XFLxasBy/LGqZ7eBeV62rHPQXh7fe/rspy1E2FzZI+0rTOuSCBIXFNiXa?=
 =?us-ascii?Q?kjJwF8AbcUYpONsJp9ojZngb1Kq07JHDVy3waB1MYPl/5tTEG8b/+Q/vZpVY?=
 =?us-ascii?Q?J4PJBsCQGMo+5/9x5QPLXhAkAQYnRGLagR6kS+Iqf4Ti41b2fu2CnVGhQnHH?=
 =?us-ascii?Q?J9tAEtx2sZSf90vFd9nup35xOShi3IbtbNlgvU2RZOwT3SU82amHEoh+39Xe?=
 =?us-ascii?Q?595B7Qbj5gfu+QIRC8kDr6j+PfCYxzLfDoB0MCyjQ8RhPrFyGjpySs6SuHIC?=
 =?us-ascii?Q?rZlJlDfwQhNevZlPp6iMFYWCJ2g8obvg2oZMtpN0zq/NPvoy7ZkI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e1d99c-1c3c-43f7-7435-08ded67bffe0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:48:39.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LneHzl+ZCxAclwOaXty91RuQNm1P9Cr3Y977dKtjl4hD1ZdYp4cPQ62+KLIsMyhb+x+nxAC15YRUYGfTlHRUa/9Ri6wTXvqIikQxu5QjN+wcqErlYbEujrO+K07q/+L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561

From: Wei Fang <wei.fang@nxp.com>

The PSIPMMR (Port Station Interface Promiscuous MAC Mode Register) in
ENETC v4 has the same bit layout as the PSIPMR register in ENETC v1: bit
n controls unicast promiscuous mode for SI n, and bit (n + 16) controls
multicast promiscuous mode for SI n. The only difference between the two
hardware generations is the register address offset.

Since the register functionality is identical, the MAC promiscuous mode
setting code can be shared between ENETC v1 and v4 drivers.

Rename ENETC_PSIPMR to ENETC_PSIPMMR in enetc_hw.h to match the actual
register name used in the reference manual, and extract two new common
helper functions, enetc_set_si_uc_promisc() and
enetc_set_si_mc_promisc(), into enetc_pf_common.c. These helpers select
the correct register offset based on the hardware revision via
is_enetc_rev1().

Remove the v4-specific enetc4_pf_set_si_mac_promisc() function from
enetc4_pf.c and the duplicate PSIPMMR_SI_MAC_UP/MP macro definitions
from enetc4_hw.h, as they are now superseded by the shared code.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 21 +--------
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  2 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  7 +--
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 11 ++---
 .../freescale/enetc/enetc_pf_common.c         | 44 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 +
 7 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index f18437556a0e..6a8f2ed56017 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -69,8 +69,6 @@
 
 /* Port Station interface promiscuous MAC mode register */
 #define ENETC4_PSIPMMR			0x200
-#define  PSIPMMR_SI_MAC_UP(a)		BIT(a) /* a = SI index */
-#define  PSIPMMR_SI_MAC_MP(a)		BIT((a) + 16)
 
 /* Port Station interface promiscuous VLAN mode register */
 #define ENETC4_PSIPVMR			0x204
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 437a15bbb47b..304ec069654d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -75,24 +75,6 @@ static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
 	put_unaligned_le16(lower, addr + 4);
 }
 
-static void enetc4_pf_set_si_mac_promisc(struct enetc_hw *hw, int si,
-					 bool uc_promisc, bool mc_promisc)
-{
-	u32 val = enetc_port_rd(hw, ENETC4_PSIPMMR);
-
-	if (uc_promisc)
-		val |= PSIPMMR_SI_MAC_UP(si);
-	else
-		val &= ~PSIPMMR_SI_MAC_UP(si);
-
-	if (mc_promisc)
-		val |= PSIPMMR_SI_MAC_MP(si);
-	else
-		val &= ~PSIPMMR_SI_MAC_MP(si);
-
-	enetc_port_wr(hw, ENETC4_PSIPMMR, val);
-}
-
 static void enetc4_pf_set_si_uc_hash_filter(struct enetc_hw *hw, int si,
 					    u64 hash)
 {
@@ -515,7 +497,8 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 		type = ENETC_MAC_FILTER_TYPE_ALL;
 	}
 
-	enetc4_pf_set_si_mac_promisc(hw, 0, uc_promisc, mc_promisc);
+	enetc_set_si_uc_promisc(si, 0, uc_promisc);
+	enetc_set_si_mc_promisc(si, 0, mc_promisc);
 
 	if (uc_promisc) {
 		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 71f376ef1be1..07b7832f2427 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -29,7 +29,7 @@ static const u32 enetc_rxbdr_regs[] = {
 };
 
 static const u32 enetc_port_regs[] = {
-	ENETC_PMR, ENETC_PSR, ENETC_PSIPMR, ENETC_PSIPMAR0(0),
+	ENETC_PMR, ENETC_PSR, ENETC_PSIPMMR, ENETC_PSIPMAR0(0),
 	ENETC_PSIPMAR1(0), ENETC_PTXMBAR, ENETC_PCAPR0, ENETC_PCAPR1,
 	ENETC_PSICFGR0(0), ENETC_PRFSCAPR, ENETC_PTCMSDUR(0),
 	ENETC_PM0_CMD_CFG, ENETC_PM0_MAXFRM, ENETC_PM0_IF_MODE
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index bf99b65d7598..66bfda60da9c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -180,9 +180,10 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_PMR_PSPEED_1000M	BIT(9)
 #define ENETC_PMR_PSPEED_2500M	BIT(10)
 #define ENETC_PSR		0x0004 /* RO */
-#define ENETC_PSIPMR		0x0018
-#define ENETC_PSIPMR_SET_UP(n)	BIT(n) /* n = SI index */
-#define ENETC_PSIPMR_SET_MP(n)	BIT((n) + 16)
+#define ENETC_PSIPMMR		0x0018
+#define  PSIPMMR_SI_MAC_UP(n)	BIT(n) /* n = SI index */
+#define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)
+
 #define ENETC_PSIPVMR		0x001c
 #define ENETC_VLAN_PROMISC_MAP_ALL	0x7
 #define ENETC_PSIPVMR_SET_VP(simap)	((simap) & 0x7)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 2d687bb8c3a0..a97d2e2dd07b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -159,21 +159,17 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	struct enetc_hw *hw = &priv->si->hw;
 	bool uprom = false, mprom = false;
 	struct enetc_mac_filter *filter;
 	struct netdev_hw_addr *ha;
-	u32 psipmr = 0;
 	bool em;
 
 	if (ndev->flags & IFF_PROMISC) {
 		/* enable promisc mode for SI0 (PF) */
-		psipmr = ENETC_PSIPMR_SET_UP(0) | ENETC_PSIPMR_SET_MP(0);
 		uprom = true;
 		mprom = true;
 	} else if (ndev->flags & IFF_ALLMULTI) {
 		/* enable multi cast promisc mode for SI0 (PF) */
-		psipmr = ENETC_PSIPMR_SET_MP(0);
 		mprom = true;
 	}
 
@@ -211,9 +207,8 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 		/* update PF entries */
 		enetc_sync_mac_filters(pf);
 
-	psipmr |= enetc_port_rd(hw, ENETC_PSIPMR) &
-		  ~(ENETC_PSIPMR_SET_UP(0) | ENETC_PSIPMR_SET_MP(0));
-	enetc_port_wr(hw, ENETC_PSIPMR, psipmr);
+	enetc_set_si_uc_promisc(priv->si, 0, uprom);
+	enetc_set_si_mc_promisc(priv->si, 0, mprom);
 }
 
 static void enetc_set_loopback(struct net_device *ndev, bool en)
@@ -474,7 +469,7 @@ static void enetc_configure_port(struct enetc_pf *pf)
 	pf->vlan_promisc_simap = ENETC_VLAN_PROMISC_MAP_ALL;
 	enetc_set_vlan_promisc(hw, pf->vlan_promisc_simap);
 
-	enetc_port_wr(hw, ENETC_PSIPMR, 0);
+	enetc_port_wr(hw, ENETC_PSIPMMR, 0);
 
 	/* enable port */
 	enetc_port_wr(hw, ENETC_PMR, ENETC_PMR_EN);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 6e5d2f869915..b0c0dc668e34 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -87,6 +87,50 @@ int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
 }
 EXPORT_SYMBOL_GPL(enetc_setup_mac_addresses);
 
+void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipmmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipmmr_off = ENETC_PSIPMMR;
+	else
+		psipmmr_off = ENETC4_PSIPMMR;
+
+	val = enetc_port_rd(hw, psipmmr_off);
+
+	if (promisc)
+		val |= PSIPMMR_SI_MAC_UP(si_id);
+	else
+		val &= ~PSIPMMR_SI_MAC_UP(si_id);
+
+	enetc_port_wr(hw, psipmmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_uc_promisc);
+
+void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipmmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipmmr_off = ENETC_PSIPMMR;
+	else
+		psipmmr_off = ENETC4_PSIPMMR;
+
+	val = enetc_port_rd(hw, psipmmr_off);
+
+	if (promisc)
+		val |= PSIPMMR_SI_MAC_MP(si_id);
+	else
+		val &= ~PSIPMMR_SI_MAC_MP(si_id);
+
+	enetc_port_wr(hw, psipmmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_mc_promisc);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 57d2e0ebd2b0..a619fb8fed9c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -17,6 +17,8 @@ void enetc_set_default_rss_key(struct enetc_pf *pf);
 int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
+void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
+void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


