Return-Path: <linuxppc-dev+bounces-24425-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F50BC44523
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 02:12:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3PD215WSz2ySN;
	Mon, 20 Jul 2026 12:12:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784513538;
	cv=pass; b=CxExJYpYk+8PY4JFR5P7IsBaNE0X8Zu4B8HQ6nq2Fv3Wqh9/pGI29eZz+RwrywBKy//cTOuqQyMw0UFPiwOOX6NFUi2DLSWWDfIST6FuNvbTkDOlZCrl6oOJD1JccrBVl0WhVynOFmja1iI9TxfPN8uXGdvt+6nuzUCIoigEC17EzfenK6CEj/GYiT//nNFjYkLfc/qecO5nOYK7uENoUH7UHFFqqoZxS3GcBJO/DBAdOrYiPtBjUXlLnjByMkTY1ySvoK6NPBIViSJuqHqeTf5eSU96jFFRB/zwxyzOvFi8uIHAtKILPnxYRHjYowYrEXnyc3vtF1mq4UConauOjA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784513538; c=relaxed/relaxed;
	bh=S4vLRlYEUHRJdCiA0jRJCd0qEEQwk25pntZuLN7f4FE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XuPacY+dEroKtW4usZ361qrg+GKx+xwPVNaKvszsemafpeAk9POLIiBRa6bKCc7keP41JfSl5GqY0QsMy3Fofv+kRbQ8m0dfN0/SQtaLR1eIutSkoWQFvRYhsvIn633S7c87tZ4U4oxx2T54AhbbmkAlxq2sOiwI/G7J2p7BSeiD7yv7zwKLongh6XbWKkDrgzpikElJUiG5IShn4Nmf3Y7ylVDzbCfllIbJjn7A3Xsd5i47XuMNTsMaBFzR0TFc48ptiCyRzmHCKeh6wqc1LsVmIoTjbuEjRGkOCXE9flRc8dmU1ZmYH7h3GTFnVCCSGcKeHAG5maqSOfQPUh7sXw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wJMZGKz3; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wJMZGKz3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3PD05ZByz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 12:12:16 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOOM+Hzsx3U0ovt4MCE9/bSq1sQglnOvcG346K/9FyP4XmlVSKjtVhHYFaPxDUtnS8YhT6D+baTSFjiPkccINAK7WQJeRkw9Stiy/HYghj78lU8mJmCOSwZqUwuWd3N+kqK/C5Yqvuxfx1pmzg/NyyPGuXEtb7Y6Z2I3FKZF8DQpjxPpscZGfuFzFb7sNxnoI1dG7Dbgm2+Yj5uyelSP62Ufd6R560bGNr09DLOwcpWOH7Ou+CWlVf32sh7HxCeAo6d+UnVBg3tyBHTaZ9twV1eXPXSKlXjp2/fr+XS7aL1OaLchKbOCWdV61qldYNw4e13DRzuAerUax6a89J75EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4vLRlYEUHRJdCiA0jRJCd0qEEQwk25pntZuLN7f4FE=;
 b=a+ukvt+JlAOkwZkvfDnh4ndjUQO7XqOpWOy0j4xXUKMwDa98X2KbqrFFnC4EbBLgHWVjfUO+WpTfEJOTj57UulweMUm7u9OUsfQroGpzc9FgAWNtUKv77Id8kebpQvX7fFD+XhaX5eBykLolMo2LAb9zw13IYw2sNYL3aBzfLgCLghm/OeXeMzl1jxL1SWr/DavBXTBVrOnKEiln7Pmuzh3Z/TGdpvFuI0byXwPBEKdVkpu6mSZwPhSBUd3Ub2Jyn78AFGQmWCWUbaPww7Oz5rz9beSqAQV4SUCGBQz1B+YNwhVA/nZgSWI+00uc8DlGShls2exj4kBVTP89a2svCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4vLRlYEUHRJdCiA0jRJCd0qEEQwk25pntZuLN7f4FE=;
 b=wJMZGKz3xOpypN6PrJiEmKUEjPZzT6uFRxATHYpVD9p73QFjIRPJgqaS23oaf9puZexlbFJva/CO6Wz/gBqNvWL7+FirB9jDN47tqAVxtUiC0tvsttWGtJ3W+v/SHpTfqyRgHNW/Azs6wKfvrJdk/VBFt0gEYEzguVYKMa21yAq7JQzgT4tAmttWQYA8WR4UPQp+WRbLVcbqnjp1sr0tuOeQfinDmHKhE1J/LW8It0EUHTvd676x+vDKtUVFwqgmwD/F6BeK071lWLZf4OhoA8w5fk919GXKSxalrTmaHYhzIf7AqMMtAOy3Kcyg4OB4Zfbe8RT45Iz4gyUhkwNM4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB11580.eurprd04.prod.outlook.com (2603:10a6:10:608::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 02:11:52 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:11:52 +0000
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
Subject: [PATCH RESEND v4 net-next 00/14] net: enetc: cleanups and improvements
Date: Mon, 20 Jul 2026 09:43:02 +0800
Message-Id: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB11580:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c5c266-a1ff-455f-5da3-08dee604436f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|7416014|6133799003|10067099003|11063799006|56012099006|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	vfm4C6dgB356ZDqHi89LFgVpeFkiLtOAjF6LjudC+PbAaQ380jCaNOtFqshXeyMJdlXguKKt5Z4Qnwv/jTWaTC0d5LgnfR+SpPaQY7BV45qyc/mYfEDC5ooz0qKZt65UfW6YywTy7eZuqsar5Z4I9k5K0pxao1u3JJbgYCgu+xZ3ZJwUp8CkBVPksuDYoifmEe4RTKO/f+RE4/+FdLKsryOsallloRXK7IBAwFIRyZgAm8GhKEQyLXH9eHEYnrsxL7b2nwSVaScWHYZvzUkreRoJdd29n/LnSO92VpX/fpu5IfVlb7dJprS/S25qXSMGxEg1cYcaoFe5/nHPs7VJQ4WgBqF88Hu7UEe+VanSbXTr8BQsc2J5qEER3VAYRQ6MHASuL5mZYGj+kenwWhrMk59cH5eexvhcAR4Q1ReGoLqkPEqFU19z6DwDo81fGSH8x9CqohAkhMb0fuiF11Xn0zCpucinDurh92PHxJVgUlCAg6skD34ghQ3yJ2Fj1r6N5gjYM3ajhWZPMXPuq9p7BmLJl0mJ4YfcH58fg5NQT4FkahxOrQavK8cJ+PjeLNoTQnXLdvWrAOnAZZu3olWFjpKST7Keij3yNY698/BcphXKLWZzEq9nEAaZDgJCb7j9cQqoh1ztDTDv3G5UNeiusjXToHHrvYJ/OsmcJRnltr45Y4hJ8kozacJAYlvWCT8HqilItdBkawP42uL6Pk0toQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(7416014)(6133799003)(10067099003)(11063799006)(56012099006)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gOpIwRjDoL6ua8+NNsVgcxuhNm53iCn0E15rfGsBAThh2SlVDwzj8bPNDjL9?=
 =?us-ascii?Q?8S8U3aug97dkGGQLcyJjuklBxaHl3KgMfYKlGJZaeEjrvhpAyO5donLMd9yB?=
 =?us-ascii?Q?2wFzU2LxMDWs0GFeQW/6vn1yuXDIH1LRQ0cZzbHh9VfmrJp9F44VwfI2nQ5y?=
 =?us-ascii?Q?pVmtb8+KT4cbvSgDbYkRVvMkdrz+KpGUP8lVHhT1+cl2Dm1o4Bc+ntMrC72K?=
 =?us-ascii?Q?ULHAszCZSblMuKrss/6P7pqU3sgNaB+sqzZzbr8eX+ImzZC3u9JCGU+sAwn6?=
 =?us-ascii?Q?AuIB4sn8yZdEZg4sI3/mygdoka6fLD3NRqNecidh8/GfvAsRYnZqLAavd9ek?=
 =?us-ascii?Q?9GXcdSy8XQiv4NFOPcRpkUZrHNetvtZTUVDXhJgNhAZP7+nc9MD0bdnbFN5A?=
 =?us-ascii?Q?pFugzdoLQbTLIOW4gQwoxFie2MyRuI47VsynTydSJ3vLEhLSMGxGEeMZlhyA?=
 =?us-ascii?Q?mht/P55St8RcGSQF+ZkQe+YwQ4YJDDf1sIPc4bXj4ClrqZybeqXiXFpUKcMs?=
 =?us-ascii?Q?27+bhTZ1m/1J65xYGFOOwEIVq0SpA9PqvmvW5bWih+gCTugDee/qltY0eVIR?=
 =?us-ascii?Q?7T80ImOPdxJALxoVfoLTdfDhsRNZiAuwQPdei9i/HSZEGddabsB8yXHuG/up?=
 =?us-ascii?Q?upcNQN2PLYIXLcBuFVcKxsrMrpAMtconTNvLDAPHCKwRxeLnVYm85uYV4fRR?=
 =?us-ascii?Q?qYF6MGRZqGrbVk283McH7/bRlQAnPuBKjwLNnEtpo48SaqyVEEDEDNTlnAhE?=
 =?us-ascii?Q?C1IZdutOHr7Nxv1lpisNlOMybKUm9FV3mdYxGh+z4tvc65s4IfggNnVQFqcz?=
 =?us-ascii?Q?OJoRt6n1Rl85SaZfOoc5E48UsNKBynOyA3OuG+jRa1NSTIMw8ORaOhy1fTGW?=
 =?us-ascii?Q?N5XjF2WlMaeohlNVIhw3aNnyGScZdA6Iko6P1nu+fNmapFMbz1T0Xp8DHOI5?=
 =?us-ascii?Q?2Hca5u1QVM7mLZpBJpn8Kh8dcb4cPKoLQ7ntS2SetbzEyFlFlEw0dcAhdijQ?=
 =?us-ascii?Q?DEfa6E1N5sgfR8lEHjHwGTiz6afM7wE8NRWA6hPeHbpzLn2MgEWFSm4CIb2y?=
 =?us-ascii?Q?aWmMzU6W6ucjqseEnTs8mP/hywAlObxd2kc5uida0LUNk6IL0sDyih6717ev?=
 =?us-ascii?Q?QiGYM89XHy1p7CHqdSEfKLSNwLNERxSy4ycctAF1Fu9WI5bDpEP2S7C8laQG?=
 =?us-ascii?Q?H2ye8O9I+3FR5zINO2XfBEw2UnjhOZf/6LHl+G2tjtCPsrvloes7EfNXmCf0?=
 =?us-ascii?Q?oAsqRsCNM0+9ypNjER9nx3OEk+wJrxDhTf/oPwKMMR+W4Ck4QuQQqG7zHskd?=
 =?us-ascii?Q?9Vg69yxuZ1VbIp8mdHEpO5+ekCXcag2opoZxE2mUWQ6ziZhMq8y8lBdyb1Mk?=
 =?us-ascii?Q?hkpyfVgMpfOlxUAinboBTm06+mEqSkI+VtlG2KgWmvJ3eUtX2UZglecg9b76?=
 =?us-ascii?Q?SZp6zWM9yh5qD9QP3puYIR6T9+8Jm4XtGafm4JhgulFbbGkWonsea1UCVNM2?=
 =?us-ascii?Q?YeJa/5PzYSX+awiPLUZv0gx8YX/u3XixWt0IW3UYpjJ8eeRNG5YQRV0jxssm?=
 =?us-ascii?Q?nqamOBdJ0yOwhljsB/V1QeeeBTrq9MBP+ZtqomK3bb3PPTuXhPjY8YGezmSw?=
 =?us-ascii?Q?6ID03TTZDFQuuVnEu+MaZ+50ZWpTNEMO/2dwsTbSW0VqnawhO5vdotSiNSgA?=
 =?us-ascii?Q?H268Wa3vKRedjyztb7mtWkZa19na9ZNrYlazSD9sJK/U5unUHTxOyynRpcsJ?=
 =?us-ascii?Q?lFli/gKfvOwb0AF5L/ktKqPe/C3oNc3HLOLMW7IM/kMB+iPi1dvE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c5c266-a1ff-455f-5da3-08dee604436f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:11:52.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mFTc9uDG8JNiDd96nSShcJ/IE0Kfd2hYezQ0XQiimRo3pR3PRrF90qGLAJ1hb6kulhRQqH4PavRvZW6dxnTWsNisUN8/0bf9IXeKqEDRsnc83wwaJyWuayHEJMqhYvG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11580

From: Wei Fang <wei.fang@nxp.com>

The first group of patches (1, 2, 5-7) eliminates code duplication
between the ENETC v1 and v4 drivers. Since both hardware generations
share identical register layouts for MAC promiscuous mode, MAC hash
filters, and VLAN promiscuous mode - differing only in register address
offsets - common helper functions are extracted into enetc_pf_common.c
and shared by both drivers.

Patch 3 converts ndo_set_rx_mode() to ndo_set_rx_mode_async(), removing
the dedicated workqueue that was previously needed to defer MAC address
list updates to a sleepable context.

Patch 4 replaces counter-based MAFT entry tracking with a bitmap, which
keeps hardware and software state in sync and avoids partial failures
during entry allocation.

Patches 8 and 9 fix phylink-related issues: removing invalid code from
enetc4_pl_mac_link_up() and properly differentiating phylink capabilities
between pseudo-MAC and standalone MAC.

The remaining patches (10-14) are minor cleanups: removing a redundant
VLAN promiscuous mode initialization in probe, using the PCI device name
for the debugfs directory, simplifying port speed configuration, removing
a redundant num_vsi field, using alloc_etherdev_mqs() for the VF driver,
and using kzalloc_flex() for a flexible array allocation.

---
v4 link: https://lore.kernel.org/imx/20260707081834.710730-1-wei.fang@oss.nxp.com/
v4:
1. Improve enetc4_set_si_msix_num()
2. Update commit messages
v3 link: https://lore.kernel.org/imx/20260703101328.550714-1-wei.fang@oss.nxp.com/
v2 link: https://lore.kernel.org/imx/20260702025714.456233-1-wei.fang@oss.nxp.com/
v1 link: https://lore.kernel.org/imx/20260630072036.382761-1-wei.fang@oss.nxp.com/
---

Claudiu Manoil (1):
  net: enetc: differentiate phylink capabilities for pseudo-MAC and
    standalone MAC

Wei Fang (13):
  net: enetc: extract common helpers for MAC promiscuous mode setting
  net: enetc: extract common helpers for MAC hash filter configuration
  net: enetc: convert ndo_set_rx_mode() to ndo_set_rx_mode_async()
  net: enetc: improve MAFT entry management with bitmap tracking
  net: enetc: use PCI device name for debugfs directory
  net: enetc: simplify enetc4_set_port_speed()
  net: enetc: remove invalid code from enetc4_pl_mac_link_up()
  net: enetc: open-code enetc4_set_default_si_vlan_promisc()
  net: enetc: refactor SI VLAN promiscuous mode configuration
  net: enetc: move enetc_set_si_vlan_promisc() to enetc_pf_common.c
  net: enetc: remove redundant num_vsi field from enetc_port_caps
  net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
  net: enetc: use kzalloc_flex() for enetc_psfp_gate allocation

 drivers/net/ethernet/freescale/enetc/enetc.h  |   4 +-
 .../ethernet/freescale/enetc/enetc4_debugfs.c |  42 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |   6 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 471 ++++++++----------
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   2 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  12 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  94 +---
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   6 -
 .../freescale/enetc/enetc_pf_common.c         | 150 +++++-
 .../freescale/enetc/enetc_pf_common.h         |   5 +
 .../net/ethernet/freescale/enetc/enetc_qos.c  |   4 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   9 +-
 include/linux/fsl/ntmp.h                      |   2 +
 13 files changed, 411 insertions(+), 396 deletions(-)

-- 
2.34.1


