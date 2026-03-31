Return-Path: <linuxppc-dev+bounces-19074-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F180C1061B2B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 11:30:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flQrP0GyRz2yvC;
	Tue, 31 Mar 2026 22:29:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774956580;
	cv=pass; b=gJyV8yAmNNQ/Zdlfu3IOhPaGNab/a6ZTtHeZ8AioAI+Efrx+8ZAMI5KqNYpzklK7UVHFOse9NWqYeTuJ0lNQ5bqr0HeN0+J4MHZ3Gi1Uh1WQSw0yTxqkYlRPal4+J2MtU7j7DTajUhwLwiWcLXX+jmqoJo/+/fq9gLUkPeukOpaAU3X8AKa6wsj6T1trlYkhXBHAKUFBZqcG3WaVoYoU3A+2pYNrQ/r1v9cpWBQVoNvVtbhhry/vRa2ezimpe5b+dn9H3XqcbR/7zkIcb/ERsjOqoF2Iu/odnS/0uEDxw4znsW1jYOcWSkNoT2EhNhVWQE61xbzf1pHciGioUXPl2Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774956580; c=relaxed/relaxed;
	bh=enC+UQAaNN7bbyUaQSWZ4TmvKi8/JoljnoJJAwDPrrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PUYWvcVzpQWeM7FFuAMLjQOtigNhCUK9fEUPJnSDU2QOPoYL6TTz6hH1kMODBy8sCx6jCFQOvIXgfRjV8AsVwbSJ+zd99Huw7HAZ1lOaPd4Jm4RohCFmPLOwpgpCli8Dpl6P1xHpPE602bAVH2Fh23p2RzNZTKqtYZdL1EsBWTAWPdhXA+z8n7BKtnX4Stg7yLXIiqZw+eh85Q6gZRUj78ukP5jJE3qV4jY5i7nnGfUqQAZbm0LhKpKMyRGb9bJhhofkeAnCkVwSkTR2DiOKxA2Q1hUwSTpncTfTwcS1nbhDSsVS5iBKitUFmHkLXRi+4XanavWDsiiTjdGXSM3oCQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=KI53ofRu; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=KI53ofRu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flQrN0gxNz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 22:29:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sh/f/l5TExl0S6wdXTER+p3ESVBurAnDN/4xvEGIgscSpD8krbC9BEoy8hL7iO6M8dBHP8LW2wCzGpNvFlG0Yj4bFBPqLDvzjOtABtWNoOOEcfut1HzMV9sXYsI1FMgWDn88fJFQ0MfFkwuyqs4LQI7NGf4H0/ZUTgzox2YstnxjHKshBti+t3q82h8sVfZ915n51P/kQwwHyaojwCs1trPxa5n4vLTTGtXjobZIKHkyvk3UDrkPPLPr0+h+3Xafs8qZ+IJGCvqUE8M3vffcodFaa3cgkMiuqAGZvHspAYNtQ12IEvcyEjd9gNMib7uPSVrYSFoTANBVpty64WM3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enC+UQAaNN7bbyUaQSWZ4TmvKi8/JoljnoJJAwDPrrw=;
 b=OXFB8wdOEWjD7TaJR08k2trF6lyGwzCL0vpsotDB3uLF4xyCkJ53c7vcgYPZBAI3al95arGMmax63FBbnMPuBdzGLq8BiUuST+TBHZYElrmCySVUKqhl5YNBBvNgLgXZ0c+Ea0VMlpzxfHm+XLiDo6piSzxKDYt5nCYIlQ6XxTca12vm5eVXLCW9uHsv0i9tCUJG2zISTeznjHlCZmsbD9BzFC0+QZLeeBNDYrvoRLdhJGVcGS51tegFq/zZaUPHFkRTGXQnFYGwqWxFLcJiiehHoTqERnsWUgPp+MJgLH0b0S+uQbrwNq6XrTycuKSWzywLTNwGYGco/8VILYHIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enC+UQAaNN7bbyUaQSWZ4TmvKi8/JoljnoJJAwDPrrw=;
 b=KI53ofRuVqLXC98y9fu9voGthFcDubsTxQjYsTK2Ga4r4fNL7OmRPRJcucTL5LyhwW0JQ9r6NsjHBnApSQV5X9HH1IcxQqt001+VnASFaz0fBq8YOGrF2yndM19fwoZo4NalPJNOMFNtn24rKfv1ZKhkGQg9fjL+hPPNcvo56w9wzE53E+6nVBJdFT5GK6ZW/0UfzpsOoBhdGZ2gE3UkylaXXXqjvvDwmTMwzip2RM2X3koQ9qzTEFDsvEoT1LdPDtAArq0FmWJrWagodj1Vex66tGVyENQlJzqAOGZCrgImaQ4DZvyVKmNa7PSlnWKimsdT5OzootxxgZpTXDT3+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:29:35 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:29:35 +0000
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
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v4 net-next 09/14] net: dsa: add NETC switch tag support
Date: Tue, 31 Mar 2026 19:30:20 +0800
Message-Id: <20260331113025.1566878-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331113025.1566878-1-wei.fang@nxp.com>
References: <20260331113025.1566878-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0151.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::14) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc86f70-b6c3-47d2-53e6-08de8f18c96d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|7416014|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	TWvCn0/K+6gUoDTFut9F0N5p7OEM+0jO71p/euMe5NZ80GXJt2Rt6QcYKmyUInpj1Uu74Zq79kHsqEBKA7iCE1ljS2rZed0Zlid2z+ZXtN4P53PFfkV+Fx12Kt2kznlZiRmD49lQ9f99EH7sk2NUkyWMfMI5xFSAzUSTa6xDLGj4CXK6LxeVEF2eSzUhDVpVGp8fcsFQZpKqYoxmPS57xPbJKGZKPZqnQ47GjstnhFvEyf0z6oYpiaiXqO/tRrWhXmaxXy/83X37E2mBeOusYCJKR1YC0CE7xIFF87gWvHG4V7W64AmtSAI8Mz2f95puEjzA/kfDeGG/E3TXFF+uX1STgi8jzQLx5dnZUrH3GpJkJwocM4L3nRgQDbSKiwMDzoXWy3Ss4JRfh1a3S0Zvx/TbOasY5yT3ZzcE742f8eeuQ/MM4efN0JShuzTc768aMhXmD8J0PdGUw9CvimhWIze2O3CNAUGvCxAVsCBxNSa1W6lhMC6LsuQcwJz83fix1BRL+PG+m98CcyFFo5dqFDirfkTCxIGIe0BLAWYnx13gaJ6yyGYTy7+B1kCP7H+34UiNkbRCPEzkLqamj3/ux+gyeyZf7V/4mzWpDFKkEUAwJQEpHxWfX765znGbDzPfcfd5UC1hj54sN01KvZZs6lKCrWNMH+CDuseln612NJD7DMeAAn/ynI25EEdbc35xlyqOXJYi4LLX4u7x/5d2HJLYp1Ua3+tJziBhdzgUGCMkVsYw2UjuS8mWSb3sKIeJG+Xs3xk/rxWSAviTlG+UPekk1QDNbatf+1ov7IBmSGo8APuH2Bgu21fZEl9QRj7S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9PAVgsIc2QlOTRDEhXKlumBTVa7T2Cl4y1UdCcRThpISBUwFkg7/w+f1oV1O?=
 =?us-ascii?Q?+W+ow3iZC8akMCJhBRzby9g42ofHWkaLdcSoZZ27rQ+CeMY2WVx2SjbohGy9?=
 =?us-ascii?Q?pjSv4ju3zBzxd3MxP9xCop2COoiseHAu/IxFiexp3ym5phrtndb/e3DXp77n?=
 =?us-ascii?Q?hVwR5uTYP9qpOKLc67QRSEaoXxNtxYfO6wR5c6wehaaXBSbNGD9y0PyK0G9m?=
 =?us-ascii?Q?pY/+aXSuFu4NIfeGBCekzjoxq6vC1dYOL7Yd+dYgHOCkTcoVJyiozhXL9Kr0?=
 =?us-ascii?Q?K/VJ3IoP5ONX6IMFF857FuK8gQlyJRhCAJOMduEMlq41yUgWEYVnwqHis1Vg?=
 =?us-ascii?Q?5tdat5XpjxuwZI9kiedAQm6mDd1yPOOjyv1TFJLnJW6tB4xrVkni1Qa4AlAk?=
 =?us-ascii?Q?cKvYe95BP3TEfQfbfG41KEC0Ud2jCqQd37uwB7jdT0sZkux7uSUUDp8OOrgw?=
 =?us-ascii?Q?2Hu/y8oRwgihsD+EFe5l6NvPlknWhYWMzH2IbNV2GWodT5wuzC/LFvX6kLjb?=
 =?us-ascii?Q?xGTA6oPMSSqwGHFI0uwQdvgjSiC6Ltc61TBA3SgrKh+wSRs49ifUQVye0IWk?=
 =?us-ascii?Q?cmZx9NFL+DlyrPCmuEr+OOtiG5sw90AIIcF+wLeNiGt3Dix7b9M0OTyCvmgo?=
 =?us-ascii?Q?XwZrIhdBZ09fKzpRWyUjVu5x1F8K++v/MMth5Ze2/hZHIaDs0HTabPyfDUhB?=
 =?us-ascii?Q?5CipitzB1prtqxn33ILq2oLIODp1tnMZ53QbgmtGsBJnkw6vmDDhhf2Ze7z8?=
 =?us-ascii?Q?0R7KzSuXfiADHQc/nt/8eGxV5bJLaMSm73+AHy4ZMR70wcXZsLWzd4Ojb3sj?=
 =?us-ascii?Q?zajdXSclUiJtRKSTWRDUtJL+roBu5pW/YcWqTEoTNVnH63K3IO1VRz8UBBm6?=
 =?us-ascii?Q?Z9dShhIqaXTzhNLjVpjQLfCoRTZ378LHp/Ay+ND4FKso2D19DZJMVHvbz73b?=
 =?us-ascii?Q?HQcf/QR0t/hcEUxga4vkQAW1zCLSwF+wWPJDS6ujsLMY4vbycbOBQ6NphMuY?=
 =?us-ascii?Q?azPnIzILqAAC89Nn5vjYiFXXmbIZ/gQ4eavIOTEkJA2O1fxz3zYeOJE8uorT?=
 =?us-ascii?Q?K0KON1kv/QRoF/Sbveo+zXUHrLNKvzpnDupMbavit7mgKbg+Br+7yRBMzYXw?=
 =?us-ascii?Q?HJsGP0Vl2jTWoGGUpmfr0PvGvkrnDkBeLTOPrjPRKH0Q7JSSTPo/qByrhRCd?=
 =?us-ascii?Q?3vV60h2bbeTvqfvgrAuigf8fLTO1WX04/MMmFOcTi5AzHi6Lor83ne9kXkQX?=
 =?us-ascii?Q?k51ESQuQbMvy8hQidGY8FE13nLihK5KvusAndeCca0KKI39pTmebeOjwsfdW?=
 =?us-ascii?Q?5sWiWJx5XwPZE7OwZI2g38Y0oG+o4fx3rI6XjQNxFAyFns2v5Gui3XChA8sN?=
 =?us-ascii?Q?1TFxYANvcZR06gP6JAWaq/ih50+mzuwzppq4G8SXR7RzNvkqARNYcn4nxEez?=
 =?us-ascii?Q?jIbInHwAe8IKV3Hv78QgubZw4QvueqQ4hMdZkzPzorw7/gCyfisjlvPhK29g?=
 =?us-ascii?Q?lx+NMy/WoF/CYSqlDbI95+ED0wg27EWQ2T0OsYazHy0gRzsd+DWc8bIlJ4lS?=
 =?us-ascii?Q?PmT7MVQRdb9lKkXApDb3KG/9zMSGRkoYj9QUvOptJ09LDpDegSldHnY4ZP1w?=
 =?us-ascii?Q?x5HBZGkuq0o2jB2jQWnXzEpT/2CJGJbRQuphz/hNk42w65hzs0xjs3ClZBjk?=
 =?us-ascii?Q?pp9ru2oNrBeUeO1FRnCi3DHmEoPODD9WTtlbhkDT2cwvB53fj4J3d4LHyRAU?=
 =?us-ascii?Q?HRXdSlTGDw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc86f70-b6c3-47d2-53e6-08de8f18c96d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:29:35.6056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1jaKyPsSvknH8JUnkYxJ+4O7+n/vFToxE2J94qoBXcgVcbwidsCOFmnW1mcN2U5YPoxM1/oeD4f4qX45YWpvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406

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
 net/dsa/tag_netc.c            | 185 ++++++++++++++++++++++++++++++++++
 6 files changed, 213 insertions(+)
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
index 6c17446f3dcc..6bed824d1f07 100644
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
index 000000000000..addd41f7f1b6
--- /dev/null
+++ b/net/dsa/tag_netc.c
@@ -0,0 +1,185 @@
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
+	u8 ipv = netdev_txq_to_tc(ndev, queue);
+	void *tag;
+
+	skb_push(skb, tag_len);
+	dsa_alloc_etype_header(skb, tag_len);
+
+	tag = dsa_etype_header_pos_tx(skb);
+	memset(tag + NETC_TAG_CMN_LEN, 0, tag_len - NETC_TAG_CMN_LEN);
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
+static int netc_get_rx_tag_len(int rx_type)
+{
+	int type = FIELD_GET(NETC_TAG_TYPE, rx_type);
+
+	if (type == NETC_TAG_TO_HOST) {
+		u8 subtype = rx_type & NETC_TAG_SUBTYPE;
+
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
+
+	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN)))
+		return NULL;
+
+	tag_cmn = dsa_etype_header_pos_rx(skb);
+	tag_len = netc_get_rx_tag_len(tag_cmn->type);
+
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
+	sw_id = NETC_TAG_SWITCH & tag_cmn->switch_port;
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
+	if (tag_cmn->type == NETC_TAG_FORWARD)
+		dsa_default_offload_fwd_mark(skb);
+
+	/* Remove Switch tag from the frame */
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
+	int tag_len = netc_get_rx_tag_len(tag_cmn->type);
+
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


