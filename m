Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A88606A320
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VlcBN2L9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVNWx3vPJz2xLs;
	Thu, 19 Nov 2026 14:01:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795057261;
	cv=pass; b=WxiQIMuE4qK0M/CZo/Px0fPkA9fKADO5l2Wwj474J0rcVDi7ARt4njrX06MUW+Fpmd1GW68429TfQHjJi+mnKFt/Q33t7QxJ0BrNDMK15vuTOCX4bL94YTmjdQWqRhXmC7l3zBFIzQkLZEwmnFTEamqbwgPTroJVKu4SPTXVlyOG2gFwQIfPWqczSALl48jtpfkqPUD/1yKAWBGOJ+oHFkOg3RrIoWD9MvLgF4hquzLHGypYkbHf41Mr0dkgGyN1FUMSeQStBGqr7giH1NS3PSj1v7dThazRKnNYgUN+DLsciHtXcRWLAhUAol07Oz5bwhNiz0taconRXVC2lGmYmQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795057261; c=relaxed/relaxed;
	bh=jkoVjUM/KHFuQNxlpqv/oGWYFlx4Sr/xeA2WCG78NHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/oYJPYa84MYENL09uyWHRfYv6KyqgC83TI4Q+HvBd0i6U59bw6FBN1D9jJnsfuImbH9KNUlof9+5QR/6h0qCcHrBZPf8GAXZ6EMl1libwvSzAUahDHR0g2yoYs+1ke41Hi8tTeagQVK5fTY9ak/FLieXnMm4p6+NVUmDiLjlS8WF/U4FiIOK04cIKUayvjROYe27wVbt9PJslHyoEVE2v3d5zc2XfRKbQepHIJpOxZ6zWnn1v3J7ROfjkxyaElS2f4/odYwQ4A7hsqgsA97xiWRBqQEAtzGVGUPvxD8skFe3+Wr07XGnpA6lbvGPxHjUrtHkM8rBVVL9/iespiU0A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VlcBN2L9; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VlcBN2L9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVNWw2Gfbz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:01:00 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQqLCOoSSLADWdm4OzPm6m00DSLNF/CDRvMBSq7zcfIMaWxG6I91Q+ufddlTktT2kkCojzpyyYTrtLBr3jRV6YU3uG1egBoxUuxjvnToYpcRpUy3DMKvuw2hYY4OmJ3vTJNP/rCYTppuvwYlXfPB0g0eMi9SJ69+pQmFaicumHU75P778eBXAhTFh5ag0kF2WYnEfxeyIFzkOyQvM3mZbLsPTppTpJc6hewLEjzcXTTTSD+vRFMMid+GTtZs5Aig1wuneOUWKjRnCsEDCM+SM0TAAv++uY8RWZrtXoqfpVvoAEDqgFNq3dYh6O+MTZNLgjl456mAaO8oyob4D15QBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkoVjUM/KHFuQNxlpqv/oGWYFlx4Sr/xeA2WCG78NHs=;
 b=GD6Xn7b1L7lY1bq+8TF1hMVmSeQTrkQWsA+7MZ1rD7prKNhfdRCLW1OwcJMchxjzCFWLdvh7bEq6LpuuNdNLVDy+FwTpihcVMi7mi+M6wQDf18bier7zPxVGcyP9AtCrrjVTACfofBSV9oq9WOpqodz0T1bRFiaU6U51YEvRWgBD9gBjceU5J9P/WoiIopUoVtVPnabUaqgCyoAUrDkZit2VMYeDpbeE4cCn4UODblxIno8O7DTpYK0jYaLb6zEuPr20XhdmkzOMs82xKJMVl2lWPprurF57T4GaeEj259wIJWkIJEIXGYbhRSixr9ChBu9zSdtcDKwmXZch8tVcHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkoVjUM/KHFuQNxlpqv/oGWYFlx4Sr/xeA2WCG78NHs=;
 b=VlcBN2L9P1oUXIHUQd4GYC+aKyttVt/KcyvWaqmiuqrCibxa7NwU9u3gG1K0qZmcH8FXtXc17xCJMxUfwZoDwAHWdsGIgN8hXyF1+mdfNeV64JEjB6olTsZq46iq24zrmjJN5r5XDysyHl+TlwtDftkbMpZDddt7oUPGfJQt3yX6QN0fZKDcbecYhZa8i/rCcnSSI78hVwwnUcBKGceg2ruxCHIkua8/vM3mAcjbN7UomYpguh3TiCbvrOVIS5kZZs6GtPUZ3IkiXdiewMZnLqgJDn9c47qIkBttAUg3y7qiqwko45GfmeDgifWC1Wc736GfhB6AqJEXjliQWKQgGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM0PR04MB11880.eurprd04.prod.outlook.com (2603:10a6:20b:6fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Thu, 19 Nov
 2026 03:00:46 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 03:00:46 +0000
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
	linusw@kernel.org,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 net-next 1/9] ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register access
Date: Thu, 19 Nov 2026 11:05:26 +0800
Message-Id: <20261119030534.1892935-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
References: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM0PR04MB11880:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de3fe66-8ebe-45df-b5cf-08df45e94eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|7416014|376014|1800799024|22082099003|18002099003|261009223027099003|921020|11063799006|56012099006|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	jOxp9vIoWdlBFKP240lU2xHkpJdaXyL5FQi/Of/ncjCcjAZr/0/5elqVw0p/HPk8t9NAbmH3EmNWprLCEKjHvCCeawZ6ESrczh1lGzYbHLEpxZmR9UhCX5lxlFDBjEzwDpM/6+JvipYiXzWwyZ3JW1AWK2aiPkzC64KDOkbJJXzQhyKG2RMINvh+FJHFdA2inFU9XlbOGxViNQIQIEsBnGJVSEK3Y2Pkkwvh8SfEy7HS6/CM/qqxPcp2xg4jAhUguZvEqN9ImzdWxxarvx04tA6T2RnRg8YzH8ReJ2BJmh/t2OwNs1HGgILRpmB5RavA6bx4D4Z1Obkz8MvwjJHctlLwjTpqho0eYQMAuWib33RwGLQPoNZGScr8zDbBaJz14cHRNBR/BFfdEvjA0K+sSsdZADMEcQhja3m2IlHdv67a0yrqJTuhjFYm/Ne/y0eKl4L29N65vqcz/CqfdnFrvqdfCgZp0e9ktXOBibQFVIxCxmtOwWeA9gagOR/mfnAGFs0bHG+skYjTRJbRoobjhBVX0QEs6JW3wuS/fWRgOX9SsrL4NkNnF1G6khws6T8/mZ+8hp1HaRSsBNzawZYv2u41uAxVcAENbbM4BQRkkgAtNFbER+nByu+ZRosN70GOaigzd3z5miYCFCleCSR4AFhyJyYKWPL3AYd5OMq9LVQbbg6G+2aHrSm3gTrvLrQYe+/ikQqWgTNG16FTXZoz/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(7416014)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cJ8Uj2MgFFnP121zRdrtDs91vvEH/mggHMl5a6L/kpBa3JrcsRFhbI9qAIxq?=
 =?us-ascii?Q?cVvFBe6qPSRP1+hCS6zIaz5WszaM1OCJS3i+9EIFF6OUYPEZryS5Bjo4qRwr?=
 =?us-ascii?Q?ry8/15SssVrN/T7c3cv7G8Nh+1pj0ILhIWOENidtUyzcaFGot2b08uolnQmW?=
 =?us-ascii?Q?5QNeUs9HpvFooQhQkJR+MNisJJ0hGNrp9KrbEi1MeZbaGMXCwAopwYua+7aB?=
 =?us-ascii?Q?Kv90TiRuhTn2XwlflkUDtgOV20fpcqyzlZmvLcT+W1PMVcT6MR0chmR9I+Ld?=
 =?us-ascii?Q?xQRr62raRSyZqJnue690rzYFhXzCHdSNyyBVryoJy5Kj+gAJ7Rra5Q8Tj398?=
 =?us-ascii?Q?BrSy3S36FxyAk4mw13Lv1r3hkn2J+YOrlGCnDgTf07rhQGU2IpNWg1wnNHVJ?=
 =?us-ascii?Q?R/8HvlpQZdnCKralRJrgoaJGhgOC0CzCHKQ4zR25mmAUXNrewPOrwxh+MX7x?=
 =?us-ascii?Q?0QDF+PFG9nYbTnPpMatQ1OueAgDuZoG1DivDH+oyCTXFPVu/PkY8Co0hcEa5?=
 =?us-ascii?Q?9FXL9F8EWYjRtRahTtdYu0o0oFxldfe/m+nMGIvYDBg04F15gBonRCydkUa5?=
 =?us-ascii?Q?rLnwBSjVik0v+kTPFZt4H5TpcP8/bKNX5YLgk4X4t9hSLBQgMQ3uZdHgpzk5?=
 =?us-ascii?Q?ZWi0IPvkwuinfQL8jE2cncnHCfhsv4T+BFd8L5cdHz7wPPiCu4c8xVMseJ5T?=
 =?us-ascii?Q?kamGMbXMBIOEcEW/PuqyGS+Rlqxu8D3rKmFQItMU9gUmAi0LlB2Y7SfnuUMf?=
 =?us-ascii?Q?9Ha4h8DrdDcEIz8TZqxWn5ER5O0XC8TdQwB77l8DbmHjHXtso9P3zK/IbGV7?=
 =?us-ascii?Q?56+hNLrqx/AxSSK4UILrRHoIGrXQnH70F5DjhzHTike3TWCR0YDZdFvSxtEw?=
 =?us-ascii?Q?bcxrn8Tkxbs+6/ZKbHIln6rRpK4StittECEuiWsjmUDqIGzHgdrFERuY+/2w?=
 =?us-ascii?Q?U719DgX/SAEs/SGGVSamMEBvkDZVvBW4Xwu3KwoBGUEkUD8wxY9yWh7QFy6p?=
 =?us-ascii?Q?1Ootp4jptEG+XMTZOAmAuc8TLk7wFvsrmo9DGNhrdk/Bwn8uCz4QNrSqpl5I?=
 =?us-ascii?Q?8sSqcH6CGUbZdtoY9IkAVkaqSvuP5PBjTXjMsDdZqCg5lqpHtJrsDFeEZz/T?=
 =?us-ascii?Q?b7mEkm6GkBWriOXn7dmv/NysJwsAZLOgPsokClHYSYgb+iGtVQodVcBmqvpO?=
 =?us-ascii?Q?julTNO/5N9GUoB03S9F9DCdj9hGmYQqnxQGEyPWwTuJ7PUYes5lL0GB3pH+I?=
 =?us-ascii?Q?2hgHUDHFrH4vupiqFKjAlnHVd9Dca8gbC1NtgwAH4+CnIy1akYEcV3xLfHHb?=
 =?us-ascii?Q?uJzAbUjKWzxMFEcsZjlmJEzac8LxQYkqcSjipHs+LQHBixlp9S241OOcBd6j?=
 =?us-ascii?Q?/hEqSXi5p4IKX2LWKi1qDM5BslH5+pCYgJHvl+Bq15OXcu6CofB871pnEfCm?=
 =?us-ascii?Q?68KorHGKRXLEs0Ui8EHt45FuIeg986RgLSqWD8tgR1Ro4gtxnALkhnLdDl1T?=
 =?us-ascii?Q?OpMxtEJeTy4tThRr3rS8t5FBjQ4YKiGmkc0bFVbmbUO5bpEg5Gce2O0Dmaoz?=
 =?us-ascii?Q?mFFeU5eAUihC+C18GwrFDjkUp6ETYZazf9UmwNnOCpdttKhUtmnEyh1c2lwL?=
 =?us-ascii?Q?LJ+Hs1rHXsZzqBpnSBA4CwIMKYl1l+BoVpiwmf9nU+g087GUbHz6oECISHwv?=
 =?us-ascii?Q?wzda/tGjWfPdLH63tXd7pI6F5kC5PWqddgkTDopjzD1vzpzd7PRKhQ3oZhhQ?=
 =?us-ascii?Q?EDpGwHjeaBcEhK01ffT1kflsHA6ib9emdpMWe1w6t54s75DNCetY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de3fe66-8ebe-45df-b5cf-08df45e94eb3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 03:00:46.2221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOU4VzrC7LA0hADqPkng2AFNUf2dlOGy+uECGRblbanfzHFM1BhCxhV527KcZJWMoio83yxetFsnARx4PYoOEIgUxx8CGNGnIgqkXuSZFbMEvQYnSqCGjNLJdOGDp4m8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11880
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

Replace the open-coded 64-bit register read/write sequences with
ioread64_lo_hi() and iowrite64_lo_hi() helpers. Introduce two new macros
netc_timer_rd64() and netc_timer_wr64() that wrap these helpers and use
them throughout the driver. This reduces boilerplate and makes the intent
of each operation clearer.

The high-half register defines (NETC_TMR_*_H) are kept to document the
register map; they are not used directly since netc_timer_rd/wr64()
address the 64-bit register pair via the low-half offset, relying on the
hardware layout where H is always at L + 4.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/ptp/ptp_netc.c | 72 ++++++++++++------------------------------
 1 file changed, 21 insertions(+), 51 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 1a327a7561e39..25f059efc831f 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -127,6 +127,17 @@ struct netc_timer {
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
 #define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
+
+/* The 64-bit timer registers consist of a low (L) and high (H) register pair.
+ * Hardware requires a strict access order: for writes, TMR_xxx_L must be
+ * written first, which latches the value into a shadow register; the write
+ * to TMR_xxx_H then atomically transfers both shadow registers into the live
+ * counter. For reads, TMR_xxx_L must be read first to capture a coherent
+ * snapshot. iowrite64_lo_hi() and ioread64_lo_hi() enforce this L-before-H
+ * ordering.
+ */
+#define netc_timer_rd64(p, o)		ioread64_lo_hi((p)->base + (o))
+#define netc_timer_wr64(p, o, v)	iowrite64_lo_hi(v, (p)->base + (o))
 #define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
 
 static const char *const timer_clk_src[] = {
@@ -136,66 +147,28 @@ static const char *const timer_clk_src[] = {
 
 static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
 {
-	u32 tmr_cnt_h = upper_32_bits(ns);
-	u32 tmr_cnt_l = lower_32_bits(ns);
-
-	/* Writes to the TMR_CNT_L register copies the written value
-	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
-	 * register copies the values written into the shadow TMR_CNT_H
-	 * register. Contents of the shadow registers are copied into
-	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
-	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
-	 * register first. Other H/L registers should have the same
-	 * behavior.
-	 */
-	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
-	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
+	netc_timer_wr64(priv, NETC_TMR_CNT_L, ns);
 }
 
 static u64 netc_timer_offset_read(struct netc_timer *priv)
 {
-	u32 tmr_off_l, tmr_off_h;
-	u64 offset;
-
-	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
-	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
-	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
-
-	return offset;
+	return netc_timer_rd64(priv, NETC_TMR_OFF_L);
 }
 
 static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
 {
-	u32 tmr_off_h = upper_32_bits(offset);
-	u32 tmr_off_l = lower_32_bits(offset);
-
-	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
-	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
+	netc_timer_wr64(priv, NETC_TMR_OFF_L, offset);
 }
 
 static u64 netc_timer_cur_time_read(struct netc_timer *priv)
 {
-	u32 time_h, time_l;
-	u64 ns;
-
-	/* The user should read NETC_TMR_CUR_TIME_L first to
-	 * get correct current time.
-	 */
-	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
-	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
-	ns = (u64)time_h << 32 | time_l;
-
-	return ns;
+	return netc_timer_rd64(priv, NETC_TMR_CUR_TIME_L);
 }
 
 static void netc_timer_alarm_write(struct netc_timer *priv,
 				   u64 alarm, int index)
 {
-	u32 alarm_h = upper_32_bits(alarm);
-	u32 alarm_l = lower_32_bits(alarm);
-
-	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
-	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
+	netc_timer_wr64(priv, NETC_TMR_ALARM_L(index), alarm);
 }
 
 static u32 netc_timer_get_integral_period(struct netc_timer *priv)
@@ -500,22 +473,19 @@ static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
 					 bool update_event)
 {
 	struct ptp_clock_event event;
-	u32 etts_l = 0, etts_h = 0;
+	u64 etts = 0;
 
-	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index)) {
-		etts_l = netc_timer_rd(priv, NETC_TMR_ETTS_L(index));
-		etts_h = netc_timer_rd(priv, NETC_TMR_ETTS_H(index));
-	}
+	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index))
+		etts = netc_timer_rd64(priv, NETC_TMR_ETTS_L(index));
 
 	/* Invalid time stamp */
-	if (!etts_l && !etts_h)
+	if (!etts)
 		return;
 
 	if (update_event) {
 		event.type = PTP_CLOCK_EXTTS;
 		event.index = index;
-		event.timestamp = (u64)etts_h << 32;
-		event.timestamp |= etts_l;
+		event.timestamp = etts;
 		ptp_clock_event(priv->clock, &event);
 	}
 }
-- 
2.34.1


