Return-Path: <linuxppc-dev+bounces-21089-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A82CD4F55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:24:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrSh3wWKz3bv8;
	Mon, 18 May 2026 18:24:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092676;
	cv=pass; b=Z8phpEK5g8uKO4l1Zd8l34Bp+QMr/dPDzxm87Uugbfm7Jq9jf0cbqj1tfMkIxQQGk+vr2VmzxehdWKBiV0E/Vl+T+Ms1/JRImy6uFvT5oIYQkzr+gWllim3YncN6y/iY06gnkC99HFy2zR/l4h0sg8UjXJQ65io1Kl2p35f4r61wSA5a3oxHpmeaPVMZrteoLorrRhJNOjN0/d3pauHRiHTXUNdhneOMyxRQxGjj1bRQI2KL9jrrfWRTTAVO+OoWsOWNLnUQ12hHc79rISWGfGOMybpY5dnpAQQ4wrC7pNz1Dz5oX/AsUjk2zQlMclTXeRzRpc6VTKIiP7/UyouY6g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092676; c=relaxed/relaxed;
	bh=8gXN2ieQWRaIlT73lCZpsuBmz/t5q2k73D/g992Si/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VeoUVPjy0fEvWR8OtUbX7F1SlPubQvV20NNrhHnw3UO1SuWSqxTHpT2Bct9vm9jWL4t4SPiYqvUb4EBDJljvskhO3nbA26b2mPufidaeL2q7+4lTx4RFRjEQyZWhKcbJWx4PgyY6QAEMKMLYz+0cwVGCev3J1IVt8m5VChtTuY/nHG/NtzhPcu+YImR5YGj4YQprBoG3o9UBYxgXU5DuL2UdluRVDtxZ0iWp8ZYMVbvcqowbGTyvLWeD0yfLcPDQcTkr3bJZemk24AepsE/Cyt5EB5id6JBdlvJNAYDF7ug5Shh1r6qFRj5lZHwYpDWn0LYnLomMFfWmsRw2pN18KA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=I9FxsdOS; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=I9FxsdOS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrSg2shsz3bs5
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:24:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pun8Wuoe/xPOHKmUPGNCrmBWVG6E7h4QspBu3jSiJgCkDdoTO/zGmZwLlFn4YSWVMsjIyBq4p42x2XC0Dua+tgkeFs3ouCngeJmv/H7yJq2q3nu7gWF+SPNdMnrOxTadRWx5GQAnK70/ZYWrEC+NwbBU8IiuoLGUJ7U4hsX3suF3KUTPkxRz/dnOdSHUAOz6SADU+B8OCG0S+4ffcd+a8UeSyf4SkO83RSlZwtOR011t8kZbFg1Qba/LCufNDGHEwksTcFXEqzrCbiSJoGyDSD71HgUrhFfpMsLVsFN+MEwEf8Zf7QbAr6ziesV065PZYcueCgQ8YMFpKsZiUqWCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gXN2ieQWRaIlT73lCZpsuBmz/t5q2k73D/g992Si/s=;
 b=IsVf7s3EsF9ZHP5mm83/jfdG2mx/kDEVpwW/HKZbNc/YW857CUq8QGYSazyTMUeSM5qX6wrI5FKZ8Z3RmnaWxZA7ADvUfh2bvBxpfuVTwUeCsqHg/8xmSodk6oucE3Nbr/nKMXLzDlfSQglNnGw9a92ZJ85PmvWqYdyY16KwJZ6SxySSZvio7mbjR+sGS69/RvwMnYT+ZYrhvFe85leFEME+AREA/DqTz2ukNGsNPnE8+SLFzFGDiyve48PiJ0NbwF7+vrCo5d+9HtX6o2mriw94wAhY+rBcvLfHEgP8DN/B0ML4Eg8gBeVWds5+yolZELeFjo6FQODzuBDTELsYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gXN2ieQWRaIlT73lCZpsuBmz/t5q2k73D/g992Si/s=;
 b=I9FxsdOS0Bs8aVtx77aJIub8QHZl67x6QLaVQT75jCgizRMexWrdSqu33V5tQMwUMqdo1A5iK5B/PjR8Hg3YnC+Iv0fjHbQzeF7EI11vG/N+xtLCP1FALhSU34zb3Bgkdo9DvAY+YHFYAIPk8IY4SpUntMwelNNo2ChvMc3WIqvtsPmjvYZhS2tFktuL3My1GZHpRixKphjdfgXW/b+Fc5Ds7U2+bLH46BHvGHlA2WNSgd08JBWTHONkWW9wdzmUAC2zrt1rlf4HW9JXqFLGm8O1UK8oAuCmlf5QwUNQeeSxw2ebD3bpNaZzPdlHy4jgEOtr6dhSqyhDaXj/vRft2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 08:24:10 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:24:10 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v8 net-next 09/15] net: dsa: add NETC switch tag support
Date: Mon, 18 May 2026 16:25:00 +0800
Message-Id: <20260518082506.1318236-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518082506.1318236-1-wei.fang@nxp.com>
References: <20260518082506.1318236-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM9PR04MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 298e37a6-979d-4a1c-e087-08deb4b6d5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|921020|18002099003|56012099003|22082099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	NQUldncCIb4Zbe85HzXLHgUVSRUVxK1G/BRLaiwccBV++d3xL2Lm4A6usyzqECRYBEXYT69D5KGC329xCZ780tO+MTZWcYWv9kCvWpZ2mA0G4k5eoUkEayWiBkcjTiF4e8FXff0m9eX31+qvP13+FqIS28Zd6xpzDYcXsTEw1+3fjNFcDwE6NDgrXLqswEqDYNruxIOaliRgj3xwm1zedz0XNH/aLRWUSsxDgcfH7cGCBav7nAxRB+qc1+Y1rxP7z51QUwz2v7wdfo9a6rpqvLmR3svnH7dY6MESUYkAu0jea+ugwrDZqoCJ7edrYGWuRKnLBkPGdqMu5WbiYmkk+doq7u4bj1+nWo70h1e6eckOfomq8GwVdMke/y65oaNd/JS/3IYIku1YceaSOBluagSkSK65Nym4hx1MaghoOqyYemAERp5pHlu0hQmhZkSUcxCiOjUQxkjaL4TwsKbIJUliyz63O3br3dLUyAVn3iIg4FrFHmrq5ObbFwLRofZlz1tTVQfor/H1t0WoTPwJFoduayvoKlINJelco2Mzr55bQUNbdtNr13+CCjhMrr2Rob0iLQ6VAW/SfdiiZ8hwagJIDD0i1+PeR4ZSEcNOkYIvcbyS0kUYRoIE45UdfDEMP5IIU4xLK/35qrLXrSte2jEdZxcG2OWGcAoR5HlIH35+gCvBD3VAHuAjX5nfHlRqbWW28MdA35v60lg3NilnmjdzFnkTJoWamqiLDyxiyPXNN0pnsm4ptyP/1p/11RMNnEiyTgA62nhBy/TiQthE8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(921020)(18002099003)(56012099003)(22082099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?94BjaTrg9tS502Roj34lwklpyFBOuq7dBXCoTrlI3bAoDj4S6M45HxMGNbO9?=
 =?us-ascii?Q?o3iM76Fp5iJfs6zgeF8WbWfWPTWOIczLYXWGxto+0ZEX4AeHeVrh5aU1oA5L?=
 =?us-ascii?Q?6MF8d2MyTuV+XRLE2n2RwJwIkX6KilQtEcNvu0wQMQbgGwDViCkk2N4a/OPk?=
 =?us-ascii?Q?dBML04P7AA6zJVO6cQROz0k+fQnyqUSwv4hlBQWqIWEU138tjxfql2++LMxp?=
 =?us-ascii?Q?MavECFz/MMOX1GPzvNSCBopPgAELSti6e5GD5Qz15OeXrCXJDHcZa8BJzd2r?=
 =?us-ascii?Q?Txv+l2CLtXPFK+Yo0nciCuTgk2e/75PznEPsQsL+ZbIQdIRdD7F5o7PgEkPr?=
 =?us-ascii?Q?k26nvESwmMFMsPAygnbSG4a82nhXW3SUv8ypxlGn5oX0l8PuHuXwreAD8vGb?=
 =?us-ascii?Q?pLAXGw7sjAmK3FYKE7FokrYiMPUjQTTaoUOn6Tbv5m6Huo9NGQfvmKwyZPWd?=
 =?us-ascii?Q?93MOsiBzv95BHujfpn55Bnbq3oNBBPzIi1lD1B7U+RDOuES7KP9TcR6GM217?=
 =?us-ascii?Q?yH1U0lcpxrh7u5+rSxY/+TVJfwvcJRHJv8BdO43tYfcNWnuzg6nzIg2ZEdW2?=
 =?us-ascii?Q?Yt5Cpbb1bl/XcRekU+JSMjtpevgPjwJg5fl7e9znoRbIHp6UJSKSk3luAP+q?=
 =?us-ascii?Q?7Z0MUsDLZDRWAGZFaFftHp1zZrC+iLV4zbzYvkVD27FTpEs0ngePID3PXQZz?=
 =?us-ascii?Q?s4bqQ1IjnLb3+qG0YfSFpx7pHRq+sfaXdmbWk7U/x4N50IU/U5fozMIgsedv?=
 =?us-ascii?Q?XgdZ1zJu28KdfFhJiA3lYVY6ggdyMNuzbMy2zR3+bW4cyyPi4lRAPpv2LzHd?=
 =?us-ascii?Q?KUmyubvmio62mzNyG+0shz1v+yK7vJGiq9agyyQ4Eb862z9lFDsNaOGHrdzC?=
 =?us-ascii?Q?YdKLqpbTXH13wgPnMNaNmRbgNKYHs3z8g/yN72XLv93xeNBSVc29PaQoLnCy?=
 =?us-ascii?Q?hrIzsV4CW3NhVM1LiNUHWuZiUCeL6/fuyYHg0bbhJjPPZlSN53lUoNMQOEk0?=
 =?us-ascii?Q?Aw8Emx2DEmk+B0THgnCTOgCM2+p89bTtgcrX+SCikNWX6hawPKJ29HGMpSaD?=
 =?us-ascii?Q?KBc7eCDES5etjw235SnpCJMEUrRoTUUa8xc4IfeBBRuWpIk/q5jtPQ2HC15j?=
 =?us-ascii?Q?97FXVokzg+oIBros2k7WC45UwUBeNRqEFix+GDpU3oJ1+aMgQ+nrB2iMUheG?=
 =?us-ascii?Q?l/dlDTIHIrcX5T74vR1qiz3kCwxaHLEnspHy1ggLs0nHa0oCaRd4xI0MKWbL?=
 =?us-ascii?Q?73Q8dN+5g7Yh6qgsuS+/BIeZpQOwgP/PJCyuBIUlw6Val1L2s56G/dy7kDQv?=
 =?us-ascii?Q?utyOfQX7JQpVff+BMEQWmPadbVgEnk7pYlgqCLiJgi+DXnRidQYKGplmMZay?=
 =?us-ascii?Q?QS2xrF/b0e/sNo4dfh/2ClZlfK8d45YTsw8MsBMIB3fObtVSm3st+ZK8Xjqd?=
 =?us-ascii?Q?cI0fNDpuA+WYQoWXXOSAs3vJg6vLAHCKgqbzzo2q4c9fvTAtbbqb5sKmYIxy?=
 =?us-ascii?Q?jRwY8tEt7YnDknF/Y2sY8nozFTHCHuD5S9A0vriH2X04iTVG5RxNuK678F2g?=
 =?us-ascii?Q?csSuhv06fd2sew+T6b+uF04NCCnPHNXMXOl2JEqb4m7JyTgUQCJZpF2M3agU?=
 =?us-ascii?Q?47PQxRFwmeJGMaJn+OKpjMqqoYmrpDip6pZTf46hBSMIOVDUXpNLgu9AhNbf?=
 =?us-ascii?Q?YDWxIGnhJ1cZUnfZNOJdspUDrPI19LbYsce8EMLMAt6fY0SM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298e37a6-979d-4a1c-e087-08deb4b6d5b3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:24:10.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Irry8sAo93IVl21Ih37O6DQVYF3Bdw/b/+MedoLK65PXSAPMUc7YeofIZ7+VIR/cEduzFn1Qr0v1D6Dkde8h/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713

The NXP NETC switch tag is a proprietary header added to frames after the
source MAC address. The switch tag has 3 types, and each type has 1 ~ 4
subtypes, the details are as follows.

Forward NXP switch tag (Type=0): Represents forwarded frames.
  - SubType = 0 - Normal frame processing.

To_Port NXP switch tag (Type=1): Represents frames that are to be sent
to a specific switch port.
  - SubType = 0. No request to perform timestamping.
  - SubType = 1. Request to perform one-step timestamping.
  - SubType = 2. Request to perform two-step timestamping.
  - SubType = 3. Request to perform both one-step timestamping and
    two-step timestamping.

To_Host NXP switch tag (Type=2): Represents frames redirected or copied
to the switch management port.
  - SubType = 0. Received frames redirected or copied to the switch
    management port.
  - SubType = 1. Received frames redirected or copied to the switch
    management port with captured timestamp at the switch port where
    the frame was received.
  - SubType = 2. Transmit timestamp response (two-step timestamping).

In addition, the length of different type switch tag is different, the
minimum length is 6 bytes, the maximum length is 14 bytes. Currently,
Forward tag, SubType 0 of To_Port tag and Subtype 0 of To_Host tag are
supported. More tags will be supported in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 include/linux/dsa/tag_netc.h  |  14 +++
 include/net/dsa.h             |   2 +
 include/uapi/linux/if_ether.h |   1 +
 net/dsa/Kconfig               |  10 ++
 net/dsa/Makefile              |   1 +
 net/dsa/tag_netc.c            | 214 ++++++++++++++++++++++++++++++++++
 6 files changed, 242 insertions(+)
 create mode 100644 include/linux/dsa/tag_netc.h
 create mode 100644 net/dsa/tag_netc.c

diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
new file mode 100644
index 000000000000..fe964722e5b0
--- /dev/null
+++ b/include/linux/dsa/tag_netc.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2025-2026 NXP
+ */
+
+#ifndef __NET_DSA_TAG_NETC_H
+#define __NET_DSA_TAG_NETC_H
+
+#include <linux/skbuff.h>
+#include <net/dsa.h>
+
+#define NETC_TAG_MAX_LEN			14
+
+#endif
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 4cc67469cf2e..8c16ef23cc10 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -58,6 +58,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_YT921X_VALUE		30
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 #define DSA_TAG_PROTO_MXL862_VALUE		32
+#define DSA_TAG_PROTO_NETC_VALUE		33
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -93,6 +94,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
+	DSA_TAG_PROTO_NETC		= DSA_TAG_PROTO_NETC_VALUE,
 };
 
 struct dsa_switch;
diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index df9d44a11540..fb5efc8e06cc 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -123,6 +123,7 @@
 #define ETH_P_DSA_A5PSW	0xE001		/* A5PSW Tag Value [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_IFE	0xED3E		/* ForCES inter-FE LFB type */
 #define ETH_P_AF_IUCV   0xFBFB		/* IBM af_iucv [ NOT AN OFFICIALLY REGISTERED ID ] */
+#define ETH_P_NXP_NETC  0xFD3A		/* NXP NETC DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 
 #define ETH_P_802_3_MIN	0x0600		/* If the value in the ethernet type is more than this value
 					 * then the frame is Ethernet II. Else it is 802.3 */
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 5ed8c704636d..d5e725b90d78 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -125,6 +125,16 @@ config NET_DSA_TAG_KSZ
 	  Say Y if you want to enable support for tagging frames for the
 	  Microchip 8795/937x/9477/9893 families of switches.
 
+config NET_DSA_TAG_NETC
+	tristate "Tag driver for NXP NETC switches"
+	help
+	  Say Y or M if you want to enable support for the NXP Switch Tag (NST),
+	  as implemented by NXP NETC switches having version 4.3 or later. The
+	  switch tag is a proprietary header added to frames after the source
+	  MAC address, it has 3 types and each type has different subtypes, so
+	  its length depends on the type and subtype of the tag, the maximum
+	  length is 14 bytes.
+
 config NET_DSA_TAG_OCELOT
 	tristate "Tag driver for Ocelot family of switches, using NPI port"
 	select PACKING
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index bf7247759a64..b8c2667cd14a 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
 obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_862XX) += tag_mxl862xx.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) += tag_mxl-gsw1xx.o
+obj-$(CONFIG_NET_DSA_TAG_NETC) += tag_netc.o
 obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT_8021Q) += tag_ocelot_8021q.o
diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
new file mode 100644
index 000000000000..ccedfe3a80b6
--- /dev/null
+++ b/net/dsa/tag_netc.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/dsa/tag_netc.h>
+
+#include "tag.h"
+
+#define NETC_NAME			"nxp_netc"
+
+/* Forward NXP switch tag */
+#define NETC_TAG_FORWARD		0
+
+/* To_Port NXP switch tag */
+#define NETC_TAG_TO_PORT		1
+/* SubType0: No request to perform timestamping */
+#define NETC_TAG_TP_SUBTYPE0		0
+
+/* To_Host NXP switch tag */
+#define NETC_TAG_TO_HOST		2
+/* SubType0: frames redirected or copied to CPU port */
+#define NETC_TAG_TH_SUBTYPE0		0
+/* SubType1: frames redirected or copied to CPU port with timestamp */
+#define NETC_TAG_TH_SUBTYPE1		1
+/* SubType2: Transmit timestamp response (two-step timestamping) */
+#define NETC_TAG_TH_SUBTYPE2		2
+
+/* NETC switch tag lengths */
+#define NETC_TAG_FORWARD_LEN		6
+#define NETC_TAG_TP_SUBTYPE0_LEN	6
+#define NETC_TAG_TH_SUBTYPE0_LEN	6
+#define NETC_TAG_TH_SUBTYPE1_LEN	14
+#define NETC_TAG_TH_SUBTYPE2_LEN	14
+#define NETC_TAG_CMN_LEN		5
+
+#define NETC_TAG_SUBTYPE		GENMASK(3, 0)
+#define NETC_TAG_TYPE			GENMASK(7, 4)
+#define NETC_TAG_QV			BIT(0)
+#define NETC_TAG_IPV			GENMASK(4, 2)
+#define NETC_TAG_SWITCH			GENMASK(2, 0)
+#define NETC_TAG_PORT			GENMASK(7, 3)
+
+struct netc_tag_cmn {
+	__be16 tpid;
+	u8 type;
+	u8 qos;
+	u8 switch_port;
+} __packed;
+
+static void netc_fill_common_tag(struct netc_tag_cmn *tag, u8 type,
+				 u8 subtype, u8 sw_id, u8 port, u8 ipv)
+{
+	tag->tpid = htons(ETH_P_NXP_NETC);
+	tag->type = FIELD_PREP(NETC_TAG_TYPE, type) |
+		    FIELD_PREP(NETC_TAG_SUBTYPE, subtype);
+	tag->qos = NETC_TAG_QV | FIELD_PREP(NETC_TAG_IPV, ipv);
+	tag->switch_port = FIELD_PREP(NETC_TAG_SWITCH, sw_id) |
+			   FIELD_PREP(NETC_TAG_PORT, port);
+}
+
+static void *netc_fill_common_tp_tag(struct sk_buff *skb,
+				     struct net_device *ndev,
+				     u8 subtype, int tag_len)
+{
+	struct dsa_port *dp = dsa_user_to_port(ndev);
+	u16 queue = skb_get_queue_mapping(skb);
+	s8 ipv = netdev_txq_to_tc(ndev, queue);
+	void *tag;
+
+	if (unlikely(ipv < 0))
+		ipv = 0;
+
+	skb_push(skb, tag_len);
+	dsa_alloc_etype_header(skb, tag_len);
+
+	tag = dsa_etype_header_pos_tx(skb);
+	memset(tag + NETC_TAG_CMN_LEN, 0, tag_len - NETC_TAG_CMN_LEN);
+	/* As 'dsa,member' is a required property for NETC switch, the member
+	 * is used to specify the switch ID (thus the hardware switch ID and
+	 * the software switch ID are consistent), its range is 1 ~ 7. The
+	 * NETC switch driver will check this value, and if it is invalid,
+	 * the switch driver will fail the probe.
+	 * In addition, according to the nxp,netc-switch.yaml doc, the port
+	 * index will not be greater than 0xf.
+	 */
+	netc_fill_common_tag(tag, NETC_TAG_TO_PORT, subtype,
+			     dp->ds->index, dp->index, ipv);
+
+	return tag;
+}
+
+static void netc_fill_tp_tag_subtype0(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	netc_fill_common_tp_tag(skb, ndev, NETC_TAG_TP_SUBTYPE0,
+				NETC_TAG_TP_SUBTYPE0_LEN);
+}
+
+/* Currently only support To_Port tag, subtype 0 */
+static struct sk_buff *netc_xmit(struct sk_buff *skb,
+				 struct net_device *ndev)
+{
+	netc_fill_tp_tag_subtype0(skb, ndev);
+
+	return skb;
+}
+
+static int netc_get_rx_tag_len(int type, int subtype)
+{
+	/* Only NETC_TAG_TO_HOST and NETC_TAG_FORWARD are expected in RX,
+	 * NETC_TAG_TO_PORT is a TX switch tag that does not exist in RX.
+	 */
+	if (type == NETC_TAG_TO_HOST) {
+		if (subtype == NETC_TAG_TH_SUBTYPE1)
+			return NETC_TAG_TH_SUBTYPE1_LEN;
+		else if (subtype == NETC_TAG_TH_SUBTYPE2)
+			return NETC_TAG_TH_SUBTYPE2_LEN;
+		else
+			return NETC_TAG_TH_SUBTYPE0_LEN;
+	}
+
+	return NETC_TAG_FORWARD_LEN;
+}
+
+static struct sk_buff *netc_rcv(struct sk_buff *skb,
+				struct net_device *ndev)
+{
+	struct netc_tag_cmn *tag_cmn;
+	int tag_len, sw_id, port;
+	int type, subtype;
+
+	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN)))
+		return NULL;
+
+	tag_cmn = dsa_etype_header_pos_rx(skb);
+	if (ntohs(tag_cmn->tpid) != ETH_P_NXP_NETC) {
+		dev_warn_ratelimited(&ndev->dev, "Unknown TPID 0x%04x\n",
+				     ntohs(tag_cmn->tpid));
+
+		return NULL;
+	}
+
+	if (tag_cmn->qos & NETC_TAG_QV)
+		skb->priority = FIELD_GET(NETC_TAG_IPV, tag_cmn->qos);
+
+	sw_id = FIELD_GET(NETC_TAG_SWITCH, tag_cmn->switch_port);
+	/* ENETC VEPA switch ID (0) is not supported yet */
+	if (!sw_id) {
+		dev_warn_ratelimited(&ndev->dev,
+				     "VEPA switch ID is not supported yet\n");
+
+		return NULL;
+	}
+
+	port = FIELD_GET(NETC_TAG_PORT, tag_cmn->switch_port);
+	skb->dev = dsa_conduit_find_user(ndev, sw_id, port);
+	if (!skb->dev)
+		return NULL;
+
+	type = FIELD_GET(NETC_TAG_TYPE, tag_cmn->type);
+	subtype = FIELD_GET(NETC_TAG_SUBTYPE, tag_cmn->type);
+	if (type == NETC_TAG_FORWARD) {
+		dsa_default_offload_fwd_mark(skb);
+	} else if (type == NETC_TAG_TO_HOST) {
+		/* Currently only subtype0 supported */
+		if (subtype != NETC_TAG_TH_SUBTYPE0)
+			return NULL;
+	} else {
+		dev_warn_ratelimited(&ndev->dev,
+				     "Unexpected  tag type %d\n", type);
+		return NULL;
+	}
+
+	/* Remove Switch tag from the frame */
+	tag_len = netc_get_rx_tag_len(type, subtype);
+	skb_pull_rcsum(skb, tag_len);
+	dsa_strip_etype_header(skb, tag_len);
+
+	return skb;
+}
+
+static void netc_flow_dissect(const struct sk_buff *skb, __be16 *proto,
+			      int *offset)
+{
+	struct netc_tag_cmn *tag_cmn = (struct netc_tag_cmn *)(skb->data - 2);
+	int subtype = FIELD_GET(NETC_TAG_SUBTYPE, tag_cmn->type);
+	int type = FIELD_GET(NETC_TAG_TYPE, tag_cmn->type);
+	int tag_len = netc_get_rx_tag_len(type, subtype);
+
+	/* The RX minimum frame length of the NETC switch port is 64 bytes,
+	 * and the frame is received by the ENETC driver. From the hardware
+	 * perspective, the receive buffer of RX BD is at least 128 bytes,
+	 * so the switch tag header is guaranteed to be in the linear region
+	 * of the skb.
+	 */
+	*offset = tag_len;
+	*proto = ((__be16 *)skb->data)[(tag_len / 2) - 1];
+}
+
+static const struct dsa_device_ops netc_netdev_ops = {
+	.name			= NETC_NAME,
+	.proto			= DSA_TAG_PROTO_NETC,
+	.xmit			= netc_xmit,
+	.rcv			= netc_rcv,
+	.needed_headroom	= NETC_TAG_MAX_LEN,
+	.flow_dissect		= netc_flow_dissect,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for NXP NETC switch family");
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_NETC, NETC_NAME);
+module_dsa_tag_driver(netc_netdev_ops);
-- 
2.34.1


