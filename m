Return-Path: <linuxppc-dev+bounces-23480-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07862C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 10:42:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs9LF28ngz2xd2;
	Fri, 03 Jul 2026 20:42:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783075333;
	cv=pass; b=JFoexi9Q/niwO4bdNeoPqDWA0Uy835/2MfaY62l/VBIKHB7OR9E46gucy0qKIyIJ5p6d6fCtn5C/qK1T0kRkaPMAsJrqFF9L2uuEnVRG+Sy6LDjLDugNcy6vi3bWoJTSygIUa2aoR35YEISPb3P2kxcyIAIT79DkJZBGvvXhCyTOxPytYG678nfrLR26Q1vk9dbSLHWAhx8CJY4SWmtqG6a/Lsfq9m4GFLvigsbLF8olxsaS8E3P0GDwPMW8uHhx5DN1FinyADpEVgPDqDKg08ypcYDJSe4669E2JCpBI7qA5ISY2+zHp0HMZEYB6CX7OxB5hwzcHLBQq0hUc4Bsvg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783075333; c=relaxed/relaxed;
	bh=jr7g0vGTjY7JyNqWCSffK40WR1pTE+c5LTsuZA34Vv4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MmCpX6hV9oBYs/21HeSSsTBo02CGWhZ8dUl992+92QuGaT+pF3xe+/b2Le0lcnHxKT6nagdW0BBwit3UryRo535++xbCs0lA85sdFBXb3lz8vsBfnkvpq5UbmbFmQQBTY3Hk8ez7ZLG4R1udd/bpFm+3jN6T4e+mi6E/ZkE1eZ3FOu8cmC/f4tBm5vBBlLHgC29ZvzB2eQy0vHQ7LWwSZj47uEUZbe+b5UHMUenPTIj1k/U8Y0MUOPZW9UKLCODU6WdEiCQsPzahiRF+ajuE24TXhGjgvxnmUT8g3qaqJ3kIAAgbxVivHDbGasAar9AbkGS3sFSgH0RCLeFeKmPmcg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=euTMMd/T; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=euTMMd/T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs9LC6dR2z2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 20:42:11 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTF7qIlZXodupflGFlkFZj///LOjlramIYVDPfwLoWZWWlk7P0hK36J4SWYbjnnFDUSbYw24jj2DOLOz3uLzrduGF0W8YGZQRj/M3fuTgi4chDeFyTD+7XbNlVBBL3OzrUxyqM9WfQaRosIWi8Gb9PznsuzUklZ/zzGj7X5ZiYNL4UbBkIWSoLwbyWwM4FAUzQXPUfmrxzwWTVpRqZz0HG1cdA4qijEz4i9iFhE2enjcCgaE8rMuCiTTAXFztlwjD0z8XiYG8y5y49hERukL8C7p7n1FeKRLVEz8VyOQn/SA1ayd1igVGyAgP60BbeUa+lnj6wLwIXW9bnNponyJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jr7g0vGTjY7JyNqWCSffK40WR1pTE+c5LTsuZA34Vv4=;
 b=AZJYuyBKyiQYUwcO9RpUHVg2hAtuYKGqtG4k8xZ08xPV0QWUgI11M+ilEJpLKG2L0/ryz/jO8sAYjddMuAnMvJuJVOxEQbDGolunzerlutbi+855cybBUVqSuMfNcq6bPekFN5hB2N7nqHJsFQTVqZ2n/pDWvvS8Zz0Z/Twgkd7fvLbwmxCJAVpJQSwCCZzepKkX1DsLmtxVeseR7YKtaGS9Q9CEV+hmgZsv0TtNx7D86xXwbxdNtv1q5Q2SqfjBTpxn0m2Xy9tGuTjbalxnFN2K8vh0+zNfRedcc/GNsbjJuHa+4RF/4d7O9LMHs3HmcLgtK9ES43IlO2NEwOq0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jr7g0vGTjY7JyNqWCSffK40WR1pTE+c5LTsuZA34Vv4=;
 b=euTMMd/TjGqqNldNJ6zHDZCcvMxsHa9Y/zLIouIlC3Rf4A3A42h3heBxui/qAvBtkPUbEiudsjSIN0lbj2UHwBN4w0KPBVFnT2lCzIkPq1ENTFwgeac69CM1Ho+gkAZpQQgxAZ/CP5kjy/QR42uQt9PECSPpJlrwdMy2nH2LKaDxnlA0vGEda0JNz2v1AHrqlxbtJ+YHb4rUcXJCJJHyaCEGh2JAsuatcRdzGQCsRa3WgCiqDhZivbPKr4LzkUhvmAy7wXiXJohYiRQjvGYSn2ktKRi8TxRYhm55xjzhBs5BaPHnCQR01/2bsMOB8/hGPWkcU5ZhZ9t8mCYXtDuyXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU4PR04MB10741.eurprd04.prod.outlook.com (2603:10a6:10:581::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:41:47 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:41:46 +0000
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
Subject: [PATCH v3 net-next 00/14] net: enetc: cleanups and improvements
Date: Fri,  3 Jul 2026 18:13:14 +0800
Message-Id: <20260703101328.550714-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU4PR04MB10741:EE_
X-MS-Office365-Filtering-Correlation-Id: 64910e44-c272-4756-6fee-08ded8efae33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|921020|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	PswWCAD4QyasXCC4C7nVuCZ0pJmQaErAVi0CyDXnayZFCiwEj5aXvw+3CrDcMH1PaUjnIik+WG7a3WQ20Hyov6ejpf+ESLY2YlkZJROBH9Ft9fNdRYZ6a9o5sWckJbq5Ghz/uTJUTWrLaVfgQvdakQgfIUtZdiwFxCt84Ny6eqpFW7iDs8HiJwAXBMGqqPHJ6qX7SQYSmgr+bmYPv/6blQ/c/hA9Um7uyQSSh0ikfN0pTMET/GlPRcIpJTubsKgrwUFn8ay5y3GXwOuBoML4mNx5bKW9nRYEgIoRjRKX9bGcIBveOpSRtWW6TmCbBddg6GCWl0PcvX2HC38ROnGNxF2HygkikYHOzjSg0Kth/bLjNg1stZioXasBuElTUJTEnl9iwCGqjdx3z4uUcEz3dRjObgO4J1JLMbJ2oB3liMijCeque6ovbvgfl9TCHZxWUJ1EeGlYRcCkp9B66TAgb79P9lOVr6xr9HZn2Rdwk2sPN3OqPwvRiptfA/T0MSEwbNkV70nD9QyFNU5AO5sP7gYC6tMTG4IdGmJetLAM0hwr2atQrQFPVoqIVjYQzvMMTtC7gTf8r0AaWcEDrw+O5RqwCOvBx/qGo4uv8fvg1H9zK+RhIHpdQ4heS1CwT8F049E5V75aXOxfxFep2ZVzjzLwpESWA6l56ppyGYIAbxCEVJuuU4BiHKDFar4EYrCvfuDkaTange4X6DfioycEhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(921020)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7NrXDrBC+5lkxIrbQKmNIGMgOQ60JpwATpob1ymIo/GFZHB8U5whacBGBGEG?=
 =?us-ascii?Q?C5seOCv+sa6E8qmjUXoJYflFcr1hHfTJCnIrws9z3mrNVKz3lJ+FO38FNxf5?=
 =?us-ascii?Q?zo9uZUbw3buBnBzBSv/IscpPZJ3g8S8VdtO5sbfkEf8/aurlyjYvlcs+Nhmy?=
 =?us-ascii?Q?hly9k2eRIRPThE3b7FXmIgdlaPRj3n/Se675VD0szEHlRt1hhMCdO/p/2EjK?=
 =?us-ascii?Q?3Wc1wZBB2dC42gmKxG7EAgQiwkxMkjRd50A9/+vrfJWmBxaQlNibrnIcPQTU?=
 =?us-ascii?Q?mkfW1tzXhnTDSWe9kKjANh1lHaJr7PnBE4yeklB7i0YZfe0NbTa77Nj6sQES?=
 =?us-ascii?Q?2PU0ff17vyuDqEYqcScfAELAJhgoPvxFBQeT178WN6/CQuFTj63DxDLbbPDK?=
 =?us-ascii?Q?B0WXaN09DxSHF6DyAzWEpdVdQYE+5rGgutOVjbavAK9HOqJBjHlF1wB6Jg6B?=
 =?us-ascii?Q?GbiL6qImJncRUbH4IfkoodtX0sOIEKHm/EjgQfxqTfSau+jIpy4J8bdnU0oI?=
 =?us-ascii?Q?8zMQexOKYEWtKQUtMtr/EhGUtUvGyG1soIWPhiExg+/mTtA766AOt1iWl1vP?=
 =?us-ascii?Q?PnyZY3zs3JHTVdftld5LN2GYlT5vk1ky6MRKJPS7D8acgKvBYe9vm96LegCT?=
 =?us-ascii?Q?QIjjASiwZ/MGablOMLCFyXopzumUJw2JtX2tyGumu8klbSUKKFcCsCIImLRo?=
 =?us-ascii?Q?wONAbaIfQzLrLdqL6nMD/shjLuX1HHgpaEKkNOCdNcp+XrjY3LSFmrP2YktP?=
 =?us-ascii?Q?EGj/X3PtCL2PTYuW8jy4OIJclp4jOKfkaGOkWHzhgM+2XYjkckNWu3lT3XG8?=
 =?us-ascii?Q?g2WvkLGom2OmroirHfeV04TENC/HH9Z/5hNgRhxW3F216hWrS5yReZ3On3bW?=
 =?us-ascii?Q?wEcZKvU18GI/A2cicV72Sgvt7KSqz6Gg72aIbax0FlR8smwGYRhO/t7YafJX?=
 =?us-ascii?Q?RfEqDr3bmQ5u0OJ6+RZArsg4/e4u8q1bSQ7/g/iXt1VLZipoC5lD4PiAchiq?=
 =?us-ascii?Q?wsf9E+EHWzG7dw0tIzvQ+GkJRTS9TwrIKlMP4RdEfS4MgCqjnonTTQiHWxYU?=
 =?us-ascii?Q?GSDHEW2EOafXfLk88n13DUX+bnfOmwsI6AWvNEvOI68p8e0Ysa1aULK2qJzr?=
 =?us-ascii?Q?BYH5FuMZlXPUmMREsxYSdqX524CjLb/DyVmhZSM+DcY2itpe4/3aXiayPZEp?=
 =?us-ascii?Q?J1kX1TpwWbcp1zoi6TcONltSVpt+OEhpZ2gOfBdQOtpYkB15AUKX9yUR7o+F?=
 =?us-ascii?Q?FS6XpQ0H88lE5c/9eEvkncGvt9rBniax8Olj5mtW6N0Nkj5ubAf4qxJXzXVa?=
 =?us-ascii?Q?GaGlrdbDUWPLQUEpoBzZ6WYJyg4IAavHOjFyqCGkNeBIHQFY7W3At6fm3hYZ?=
 =?us-ascii?Q?FmAzKdJg3qQF+KL6em+inwJ7HZRR3XxfXtRWs8rQUzi6lOs6mA5Nxn5LWuxa?=
 =?us-ascii?Q?Vr+k4dY4WREichhEOqfLHHiPaeHMAQ+KUxxHelLb38EkSnKDGGLxJqJTYvah?=
 =?us-ascii?Q?7vhkOmNmP6upKk03fmr7ed3kH9KywOJCDI0OsbshDfK5OWzoyOH1JEEpF0fQ?=
 =?us-ascii?Q?xmNMsiaejzSHXdgBcLDzavWdjVJYDGUYc2vRaHlFVRpjyX9Wq3d5Kvm5F1Sn?=
 =?us-ascii?Q?oBFVWb/0Mm6sKWBROazN6e2MvZs2d02gUtMfBl+HsCg7GcPx0xNkmXLeuvdI?=
 =?us-ascii?Q?Ja1rMI/qZ28so58DRzENvpDZ/zb9I/UiPsOuNrAplKCEEuHPqFV0YDqXm4qf?=
 =?us-ascii?Q?Nd+uK3km1IPSCKkGxJoCX5I1WOw666Pu2GXNem53cWtwMJrsr+aE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64910e44-c272-4756-6fee-08ded8efae33
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:41:46.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzzGIyCxwGuVCf8nV+ox9gBekW8HCvv4nW/SPigAMX83NsQi89Rsy13WKuqf2M9CNnc64pRJJlXfwt23KHZFln10HgHL8PF1/SbSQc4ZFhQVuA65lSpAoYfO/QAsNV/y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10741

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
v3:
1. Add a check to speed in enetc4_set_port_speed()
2. Remove PHY_INTERFACE_MODE_XGMII from the driver
3. Restore the VLAN promiscuous mode setting for all SIs in probe phase
4. Remove half_duplex field from struct enetc_port_caps
5. Limit the maximum value of txqs/rxqs of alloc_etherdev_mqs() to
   ENETC_MAX_NUM_TXQS
6. Update the commit messages
7. Collect tags
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
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |   7 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 424 +++++++-----------
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   2 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  12 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  94 +---
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   6 -
 .../freescale/enetc/enetc_pf_common.c         | 150 ++++++-
 .../freescale/enetc/enetc_pf_common.h         |   5 +
 .../net/ethernet/freescale/enetc/enetc_qos.c  |   4 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   9 +-
 include/linux/fsl/ntmp.h                      |   2 +
 13 files changed, 367 insertions(+), 394 deletions(-)

-- 
2.34.1


