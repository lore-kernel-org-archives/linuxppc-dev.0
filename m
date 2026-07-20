Return-Path: <linuxppc-dev+bounces-24433-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DB4C44512
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 02:13:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3PDh3vVpz3c01;
	Mon, 20 Jul 2026 12:12:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784513572;
	cv=pass; b=A5Xuf50WSMlcdXxHBnlyzx/fxDrZ3ZQZIDOSdkYvMZ5JFugfPw55Rxh3CveqcRaUmWgXuZBZwxmcSvkDLcqO3VFNM6UZmG5n4mEPXuv5Gb6Bjg1NYYMOPQ4x6poGnn5Tw6Oo4cD3wnAAsL/WpUGjMWq556g+ia+TM+5KIzFrfAwWv38HvKMS7vjXcfbr8hblG0ihjsNUdPZibnRngRL4qtjcKckBGklPCT0GInP2Ef/o7d1yOzCxAXVQ7gIy94/xdJEsRdEMKN9I9CPIxMdcvOcIOKmdBT/6Xg4EhhWnZOMvyiYSAJLk48Py/m/cvZllbaM/au97daPzRmOES5FGhA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784513572; c=relaxed/relaxed;
	bh=lXObFrFI4ieHCs+YnoMphsXVCjKXrlVokbXMdZ6VFnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hkv3H7a0wmLErWBGvyBoy6bMNCvN4ZupYmmiR6ze/1MGQ4tHYJwon65/YKgYgkPibVVLO9vMvl/2QeHIZCnf0SOgHO0cnwx05695FQSaHv/8YzjTqmKM6RRaom1zMikEh0PEmiN9uCBBuruUzBJi6oIf2xCIWOfZ9DaX9ikvR3z8S9WAeFQ2UY8qTqtkFAafaITUuhqRDusviXv/Ag+iilr6xtLP1Sdn4kLnAPfIAJOD+uIgBwhrmTEYC9jE5zAWJGcvZdcmmwPeBxgSo9dWvM5P1vV/ky9fIlfREr5FMsDlgVineCHTfbZA5DMuf6vVynJ3ea1/CRFaiY8CnVpo5Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Hsxe3+96; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Hsxe3+96;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3PDg56B6z3092
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 12:12:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCqyd0X219u0zwDfYxCZFwSsbqeYdDSZg3JI5WiR9z3RqFeEWFs2guFquYYND7vRe95Ghh0GjutrD0jgkSL2EDT2Qvgg2tSPipELp5zhdi0jh7Zl5BGWwPRrA6IjqqhoY7YuFaAOU4k2X70HJNpbYgq6weJEy9zvfRLWduOWhKlv2sp7L1AMLz15OsXNJe6HNfYI4OUHEtRmsyvc7uRRJJquVNVu8Yq6RRY4t3YvIsPT9QNdzOhPbO3hOsh75F7IXxc+v+8BX6HDKr64e8JwzX2Ax4hFdrdVKoPdMapvRCPjbivYpfr28OAt9gC48d8RBdQMRVAZJB4KDL3WB/Oc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXObFrFI4ieHCs+YnoMphsXVCjKXrlVokbXMdZ6VFnM=;
 b=jDs5j/U1SFcufEyVzJ0QaCk5oXE393n0FtOvoIuHp6x6uEJChv/cMaeTr38MJ/CiNOMeiJnYWMr3gLGbcu37tILTa10aEMrtepAmgstvf+T1PwvR/a5ZcQhZghMt1eAnJyK1sHl1KiGA6NXALmqqcuPubYvrpkOU4pxN+B00poNx6BmA9iWkjVR06iPO0xovb99tUSIlRPq/IZ9I24p6fx1QJogOWbQbvLlFtJ+AFYlD8n0vSi6s3Hs1YosuAjMTW6jKePSVhr5+kxReRBfX3JTuFODd9QaFQO9rKQiXvTOW92WbfEKf+vo1wMi0WnpJIeMylKvpCFuSbiuobKF4rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXObFrFI4ieHCs+YnoMphsXVCjKXrlVokbXMdZ6VFnM=;
 b=Hsxe3+96+NOSwpt5mxUlUHW/jg7jigzS1Y9iW1NEssMjPFxA/pWJcoBKxmD/GPWylMTiC0Bm6hv5d1ZY/ZCgIM71/Pg8LGxhNMWqR+WvgyBBGIuugrjPHEwb+bWRJQIijgzDBpgSzEzr6WkI+Sbu+zQSLv3fpbahku6XYvhjyVPLuDSmuLeS72F6vXnvrw/q6pR2Qn1N6Wxdxt7rgnKltph90fbHANh2Y8ob54mP7cZ/GXOa9v6dKD8LKCPSiz3Rlev2/Dl3khZUiRmRPQ55qUNEzAlb+1sgJynaYQeTBXpN09bXdsSnVqHwgr15jzRKIRjSAq1FwNp5EFgfbf47XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10872.eurprd04.prod.outlook.com (2603:10a6:150:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Mon, 20 Jul
 2026 02:12:44 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:12:44 +0000
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
Subject: [PATCH RESEND v4 net-next 08/14] net: enetc: remove invalid code from enetc4_pl_mac_link_up()
Date: Mon, 20 Jul 2026 09:43:10 +0800
Message-Id: <20260720014317.1059359-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::14) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10872:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3c3931-ed85-4a6a-0aec-08dee6046267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|921020|18002099003|22082099003|3023799007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	q24/7Z+Bynx20RGelFW5YvgU+1xtdXtFX2GBEv1/MUXiwgm3Abt0fBfpneqQxeCFzOVE7SIMzjU6VFIynvEXHlXweOUvjTDbBbxSnxiljyF9NhbxsZU9jpbnb+PniUVKPOuO1iUhqb0hITN1mrNddDA3L8Cy9u6qr+N3OATUqAkNXoO9YWtwJSA9eUtEuvIbgrwM25PwWnitwNCmfWiIvkJGvJjUU43prlXBr/gDJ12ydNt6800kf/41ArJWKq8BrJ5wm8Am+JCRokX9GG6UoOHgbk9Y7uA4p9cX7XnQeyDfnUo249GbEZSDgTEcEVkUKliDkMoe3eMxsBcKcIg1RMmwpOT1NebSTOffiKnnQBLsB7dR4Po/NZ/vk2X6RGFKllF4TGZRR+0OOHhPlrXz5Ci96VTd4uHH6CAFp04VmEKDiKsGDQqpG/ueMU7uRXv34ce7XUCTC1Pu1ql7cJHgGQPgGV1tuxOP0VULzP4bJwVA8H2A/k4PjMzQe1Bt8mJeJEC0JtrUfzcGmv6yJy+NLHCWAw8Lp5SBLe3W4qb8tEv75n4Bu4bzOI8JdKBjE6XKfBmZefXjraFFa+v/lwo8OoPzAjwaEFVSEuMvlq7KCJh5TtjZoATPkmns7wkst31U1XKFPSxwHlTXo94OCHZ/ELZosSsama/2IBDNwUzSMautb6f4FpI5lmMPGKpeBhkkTVz9DPT+h7SCUZB5T0Kk1A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(921020)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K9Ul7QPpr+M8dokAOiUd+x1mNK3m5xjHNcduL6Ex/ijV84XLzic8vT5qArxA?=
 =?us-ascii?Q?seapwTy/rGD2qq0e394X+rW3FgV7SMCWI1eS9+dciO2wE6WOkDzWQD3Zi1XU?=
 =?us-ascii?Q?ylhtt0V3vdxTUOX9akJApsEcejl1J2yiwy5IEm+h0F+OIogdWppXXTecYAOq?=
 =?us-ascii?Q?M3s9jua83UlWgdmj/f1Ki7ycuureB3Xh1lr6Duw6LKx/y0k4DpvMkRg7otq9?=
 =?us-ascii?Q?vdbmt7B+ICeOfKOWcgie/WZkWUGHCaKGXrp0VK9d5qmgCwUdPYN+mm88lz3Q?=
 =?us-ascii?Q?HIx8OExYOGKAwA9dJDYq6J4ZgJMNJjBGeW70l+NFWRXisR3DRYEn9jVFZ2mK?=
 =?us-ascii?Q?MNGbIPS8RilbSXYqOlQ+RQzgoznqEt5zJY5tBZL0xh98IAh7RiPBcR028RHZ?=
 =?us-ascii?Q?sBpZXYBp8a9Wcq5xhj8urTg3GiZHC6rEkfc66FUU7P877DUlbDSIG4vKVYiW?=
 =?us-ascii?Q?dxSPNWVoscfjpU5q2r2HkFledu6GlDEjIOQHmuJp8w5oU4cVWXhRWpbJHVN7?=
 =?us-ascii?Q?AOLm+Q5AnAPaXuoJJpR2rR05EZMbX0Ngms2w60nxQHwthRdjWs7uf2EO19HA?=
 =?us-ascii?Q?Nm6r3l6sRfcx7L54bZom7eFnaN79d4hNd3BayEreFmo6M+o9e4hRsJK13HeC?=
 =?us-ascii?Q?heBRTIyiEoxOL3vxWH5PnGM2lmmKr/oUUWjvu8PYItOrLNoGUc0MjZnkY8mL?=
 =?us-ascii?Q?cBx3NUZvMNCjPzQ+BSuAPWUOJvnYC7YatI6kj9vBMhxDP3Kja6qMQ6huXbas?=
 =?us-ascii?Q?Ikftb7gakHIfg+Ek1G0cB/pTRJZop/aw0en38PZv7zyZcfB7DjCgyyAZUdpg?=
 =?us-ascii?Q?nPp+vIVD/Zx3EoWwxjwK0hMy9FkBA3GamQpgXvA7lQECFojtnL2PXLOtEnpm?=
 =?us-ascii?Q?VPfD5oEq16UAiPw5p5nLf47j8riHLuSYkQqOQFLeW2eIbiXyDlZBHRdAKO3I?=
 =?us-ascii?Q?mzy28WVSkkQyaUB91wbwkQAjwj8Un+r8mHgJVag5/CNKlqAnozVjv9/dE5e4?=
 =?us-ascii?Q?WU0uu2i92nBDttfkMYdmcJqhkjuaFS7qc7kYvEscDKRCWzaQ5iAX3REWtncn?=
 =?us-ascii?Q?BlZHw/yE5MKo4mfDesATL/c287ztDa4E7dex4v75rw/vD5sgOWPt66CokulN?=
 =?us-ascii?Q?e2CIPc0SHxbORlawPi/nRX8+oeWi/mLeaSGMxFgUzuIRvGEgP47O9mFiV/9S?=
 =?us-ascii?Q?k/ZONfHUp9lPPYH1YPn8Cwj1XGHggHUIBFS743IsBJTmRKqsF502SUOY35FZ?=
 =?us-ascii?Q?C1QdOVI6cMktpG+4l9cy6ORWEdr/qU0IB858k2S4l+Lfah2aPwPaZjVEFPuR?=
 =?us-ascii?Q?U9UWKyi4XKSzNUb3hbMtm4zPX5nUH6V5VI+EEUe/pfC70j65kpWgrpCxog8p?=
 =?us-ascii?Q?Z76g2HCWKET5aHteGLvvnS8d0AidumUxO+ooWBtfnV7V1FOWlE1xe2sxW5yO?=
 =?us-ascii?Q?zJPWSpO8/Na2eZKSqjYY/7E9oH9fxICgnKu8YAJESo8fQ7XtRgvf2uuUR30e?=
 =?us-ascii?Q?z1WWxZvPFsN4EHOuC3fYiUzXDwSTAdQlHK5DJ+EXEgqCkqFX3Uvg0+YfZiLH?=
 =?us-ascii?Q?A3sF9EIUWly5gQd4pU3/eZO6MA0B/SyASrrpy+UpCojr+9NQuFIqzv6iAPXF?=
 =?us-ascii?Q?+FWWjY9eydWY8hkpiecXGJASsqBxlkIQao1UbPaSLhTUIR7d3W/KwtQ6RUeV?=
 =?us-ascii?Q?cmZi26hEhN41G0hIpqPOhNh5XowgjgxfRprHVEADRHitT8xb5y/LWqWcYRDc?=
 =?us-ascii?Q?ostf9nQURixJX9d42tXPLOfexlmi85u3NwD7McFYJhB9E8eCHCqR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3c3931-ed85-4a6a-0aec-08dee6046267
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:12:43.9514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFRVvIqpyt3Wr8Q2ejsejmokJj1qjXWbWjJdznpOhZgBx+P+fp8Ic452fzI+GUzRyXw4MsuKGxSdDkeb/UYEfcLjItY8GDKPlH1uRSZLsTmKdbZGbxX398UZzxBivUfB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10872

From: Wei Fang <wei.fang@nxp.com>

When adding phylink MAC operations support to the NETC switch driver,
Russell King pointed out several pieces of invalid logic in the
.mac_link_up() implementation (see [1] and [2]):

1) Half-duplex backpressure is not supported by the kernel, Ethernet
   relies on packet dropping for congestion management.

2) phylink_autoneg_inband() is unnecessary, as RGMII in-band status is
   not supported.

3) TX and RX pause are disabled in half-duplex mode, so there is no
   need to override them in .mac_link_up().

The same invalid logic is also present in enetc4_pl_mac_link_up(), so
remove the invalid code from it.

Given enetc4_set_hd_flow_control() is removed, pf->caps.half_duplex has
also become useless and should therefore be removed as well.

Link: https://lore.kernel.org/imx/acEIQqI-_oyCym8O@shell.armlinux.org.uk/ # 1
Link: https://lore.kernel.org/imx/acEFwqmAvWls_9Ef@shell.armlinux.org.uk/ # 2
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 38 +------------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
 3 files changed, 1 insertion(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index dea1fd0b8175..09025e7a2a3a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -135,7 +135,6 @@
 #define ENETC4_PSIVHFR1(a)		((a) * 0x80 + 0x2064)
 
 #define ENETC4_PMCAPR			0x4004
-#define  PMCAPR_HD			BIT(8)
 #define  PMCAPR_FP			GENMASK(10, 9)
 
 /* Port capability register */
@@ -198,7 +197,6 @@
 #define  PM_CMD_CFG_CNT_FRM_EN		BIT(13)
 #define  PM_CMD_CFG_TXP			BIT(15)
 #define  PM_CMD_CFG_SEND_IDLE		BIT(16)
-#define  PM_CMD_CFG_HD_FCEN		BIT(18)
 #define  PM_CMD_CFG_SFD			BIT(21)
 #define  PM_CMD_CFG_TX_FLUSH		BIT(22)
 #define  PM_CMD_CFG_TX_LOWP_EN		BIT(23)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 75ee117e9b1d..859b02f5170a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -29,9 +29,6 @@ static void enetc4_get_port_caps(struct enetc_pf *pf)
 	val = enetc_port_rd(hw, ENETC4_ECAPR2);
 	pf->caps.num_rx_bdr = (val & ECAPR2_NUM_RX_BDR) >> 16;
 	pf->caps.num_tx_bdr = val & ECAPR2_NUM_TX_BDR;
-
-	val = enetc_port_rd(hw, ENETC4_PMCAPR);
-	pf->caps.half_duplex = (val & PMCAPR_HD) ? 1 : 0;
 }
 
 static void enetc4_get_psi_hw_features(struct enetc_si *si)
@@ -588,11 +585,6 @@ static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val |= IFMODE_RGMII;
-		/* We need to enable auto-negotiation for the MAC
-		 * if its RGMII interface support In-Band status.
-		 */
-		if (phylink_autoneg_inband(mode))
-			val |= PM_IF_MODE_ENA;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val |= IFMODE_RMII;
@@ -695,22 +687,6 @@ static void enetc4_set_rmii_mac(struct enetc_pf *pf, int speed, int duplex)
 	enetc_port_mac_wr(si, ENETC4_PM_IF_MODE(0), val);
 }
 
-static void enetc4_set_hd_flow_control(struct enetc_pf *pf, bool enable)
-{
-	struct enetc_si *si = pf->si;
-	u32 old_val, val;
-
-	if (!pf->caps.half_duplex)
-		return;
-
-	old_val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
-	val = u32_replace_bits(old_val, enable ? 1 : 0, PM_CMD_CFG_HD_FCEN);
-	if (val == old_val)
-		return;
-
-	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
-}
-
 static void enetc4_set_rx_pause(struct enetc_pf *pf, bool rx_pause)
 {
 	struct enetc_si *si = pf->si;
@@ -886,13 +862,11 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	struct enetc_pf *pf = phylink_to_enetc_pf(config);
 	struct enetc_si *si = pf->si;
 	struct enetc_ndev_priv *priv;
-	bool hd_fc = false;
 
 	priv = netdev_priv(si->ndev);
 	enetc4_set_port_speed(priv, speed);
 
-	if (!phylink_autoneg_inband(mode) &&
-	    phy_interface_mode_is_rgmii(interface))
+	if (phy_interface_mode_is_rgmii(interface))
 		enetc4_set_rgmii_mac(pf, speed, duplex);
 
 	if (interface == PHY_INTERFACE_MODE_RMII)
@@ -904,18 +878,8 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 		 */
 		if (priv->active_offloads & ENETC_F_QBU)
 			tx_pause = false;
-	} else { /* DUPLEX_HALF */
-		if (tx_pause || rx_pause)
-			hd_fc = true;
-
-		/* As per 802.3 annex 31B, PAUSE frames are only supported
-		 * when the link is configured for full duplex operation.
-		 */
-		tx_pause = false;
-		rx_pause = false;
 	}
 
-	enetc4_set_hd_flow_control(pf, hd_fc);
 	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
 	enetc4_set_rx_pause(pf, rx_pause);
 	enetc4_mac_tx_enable(pf);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 6f15f9ea1664..7e886dc49997 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -17,7 +17,6 @@ struct enetc_vf_state {
 };
 
 struct enetc_port_caps {
-	u32 half_duplex:1;
 	int num_vsi;
 	int num_msix;
 	int num_rx_bdr;
-- 
2.34.1


