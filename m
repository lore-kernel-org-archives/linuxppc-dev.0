Return-Path: <linuxppc-dev+bounces-18230-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3725F4643B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 09:41:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ98h5BBVz2yhD;
	Mon, 16 Mar 2026 20:41:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773654100;
	cv=pass; b=Owg230djRmL6CHtV/242VaEDpctkwIr6arprf2/fcTPOaZjEC953n4AQcyWFVh16JRV3s26z7YiW/os4Md59fjkNrkW0MmULj6WItD605VTPXBMGH1UeDzmJwRC6ZvD74S7XWox/NmCfiOwb13IvqiTJM86MirPMDRiofeJl0YdgqXgCgwDiaLgtzhSgUkhcjdRbsC9Ecv05mNm3Fb8Bcg2aqaUSt/I4AYIeDm04uWgPGdzGdyME14r+mL56zkbfAbdzbRg9aUZ4/yaqW1wysVGp0xJZzU/rZ2qFn5KBJbJwdZ7ToqRmAk0Xj2jmoHvLnjT7ShACSqfZ+Fiv81OrNA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773654100; c=relaxed/relaxed;
	bh=PBQrjlw2rTWR6At9Th/Kk4N3QU1TvCLV5DqehKos/NM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fLsPfIuGlT1Lxl5yZRFJ3KJhDj3b0NXUgSVS+otXkJ6xxVnOgAC+jUUEchjteP1YU6kxMY3zP59Zc8E12hzzxsgb8D/VqMNKfxDQmp27EoVlrmDwY93PrkBbAUO5NJCwEL+J1mbuPiVYUNffF0hKUnSWqlt/+vzwUKJZJRRY/lBX0o1DSR9ETTtggKBPfwDVY/uFhN4h8lMhUidHcGUV1RFzKTh1AIN9VXewO/KL3YCJIBuDOQesnei8kEPgQ/iygbzTVVxxkbGsKRRuHlSdTuvvIJ0vkO37XZtUzyQvLLhO1cUwtxlRsrjSplvHQ65hGYrWKsiWlKfKni/HgDC+2w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ByBYwMEo; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ByBYwMEo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ98g75K2z2yjq
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 20:41:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pejmq8wKOyfKnLJxyC2/phzHjC/kphcKDQQP98MKIqbwgdtZZm7tVv35XV4Tng17UQp1FaC46m7MgZOJafBP9PutiyoTgNJhohPw7DX2E1lqLRxVi9N3xGIZ1r4Pp4Ak85j0z70QUOlQp7kj8LMUyXpjq4yw3QwD3FhOT3PXgZssS1xQXkeJpKZaN6CSGLVcrxRaPxA9Pl5d3/Xoti6w0Ex1MZ5X5gBG9mVaoMJJzSQwDSib+dqD9ANz/evDXLjhidD7FhxXZLVPYv/eqUvz/eGiNous8H+owMfxqXk8fDOjemWjgA716uKm7yfsIx2SjE/Aimd2Ed72SxResp4zLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBQrjlw2rTWR6At9Th/Kk4N3QU1TvCLV5DqehKos/NM=;
 b=RifOXiP3b8KJJDuqAVZAcAhwZdtbd19umpCCtiz5nvZc0WfCd3ef8a4Nm687BJ7ZpikFIdyDh7MLdXPTWOv+CV/ytkkC2xvCYqSQKSZpsTCG96a7bS2ggmc64vCUjhoskuo2mFxteEsSV7/dc1lVAmAWaynGnjjwMYnZzwGG06hBjy6z/YY2LNY9R8A1rGxyck/j9ydDG/2qdZiOwhlfrKqSPfpvOeCxqb/NlLd4dhNxrtcavf1cmlPzS2VfuL7OhKYMFqsNNkXqqtpKwWKr4HfucDcIj19eBb1CE7EqyOZS2YBs1NGzsXaXpE8coOpjEeJ037UKstz4cHRF36HWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBQrjlw2rTWR6At9Th/Kk4N3QU1TvCLV5DqehKos/NM=;
 b=ByBYwMEoRDdM7bBPqYaj/04NZF0WxwpT/4W48MeOMcFofqYuprcFROQLSeFFYNBzI2NEMNitE6E82e42tnjJLWB9fMqgd4s3mj1BoRz4dWXgdlEKxyZBf+i9LSoSmVruul4AcVwTqTj+4mxQRcmSomCfm8IezDfGGKU2EAzqtJYNCaNBIYrckmWdhjOUsO6fT6VYckothM3vVzis/SLVm9EZK1YtsMYgElPPUzCMWGBzXbzYYByaJF1Cvxb/whdFTb06Hj0N8XGuqw7YpafiC81n7tyaxgv3VZ9xiLBZsGAg8K7mSqpSALUXkoPkz5+JQWoV+zJrNCc1l8vDRAZ2MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 09:41:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 09:41:28 +0000
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
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 09/14] net: dsa: add NETC switch tag support
Date: Mon, 16 Mar 2026 17:41:47 +0800
Message-Id: <20260316094152.1558671-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316094152.1558671-1-wei.fang@nxp.com>
References: <20260316094152.1558671-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e334da-06f2-4da1-475d-08de83403295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|921020|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Jf4j7+cpdPFEvmORmgTYLVzfY1ZgRBuO3WWmoR57JFqanEROttMtMaLZ1y3r3dnYuyiPIntmo+cQmXpEa+8KNGMpasovJGdpTtGP6wuyJf26CoPtledrZdVcJo8D2Iaqx8UcXIdn6qv5Y//+RLMCTFFPR/BXxA80hKPfRdgktOBGzU+4uadrLrlTQHSAqIZJbMJ1V54GJDH68SHYAd/Rm064UMt70nFrJOt4uSmT2qls0HJaLZmBdx1llnfvIyudfdFKiPC43uX2ceb9z8iry2KQ8aaw0Pwvv6W8QT7SOnNqhOqs+FhRx/A2mYtOWA5xKam88Y6TdCEz6DkegXxf0tcUJAvwRuf6lFDgI700yVOtCWXOWBqxTtIq+CiVBVEFIkMR/3cYt+C+rhySjqe6HVRyAdiHI6PmxdbmDR2/pvp/Gai/Odoigmq1Jq7yByvlsKXdzQLVDZjpYahe+BNBo5kq1n8UCq5vaX0mYYgBGXgJQgWzHao09HASh6Lg5FiolGWB9SGrLZ0s3szomfxiVOICRQiaiJbtDb6dlvcmBwTY6+lLQ4wWczByZVcC6MJ/n2mNKuF6y1qwi0eppA7xvFRbmBoX+x4vKPrTuKQuuvmn3mFjVNz6BNw59vT5xmG+28oD0cx6itMSZtyEZ5026gr1JIU3bxy5+n6pJ3nIpuWcJVGnkQ2ZBDh6x0sgveoYpSh/EfEYZw8IEmwka2WqqA0cDZlSl6IETWJvzNyIy9jJQtJfcbhU2Pcy1OrPWzryhuvwGLGSxxSV3aZEVzMJw6NAoTHDt8WTulW6HVGqv4NQ6IYirbqOR9X+p1BtOrsd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S7gNDQjyu8jETRILph0yxF6ELaA2YNUenXy6000UG313sTs/SveJeDAqcW/T?=
 =?us-ascii?Q?gB6qXBJ5/vDRgK7JnocZ0utx5dWT5wkKEhOFbahlQzoNJOsfoE3vlsWQIktv?=
 =?us-ascii?Q?26EGBwcfgU8l7djxdgrRQwCRiPAQ72aHfOlS7AElhS5XJHnW8+U6Bsa/9Ysb?=
 =?us-ascii?Q?1p4Z05/+sfnWk/rDQWw9OhYTF2bxpr9THEkWc73foYx+2jX+fu9evXu7iSlo?=
 =?us-ascii?Q?Oh39J4aKOLSLXLMkC3PsKYdM1lSXbwzjYDSgplAfQfXAfjTlbWH7RvUypusg?=
 =?us-ascii?Q?FO4SojqHj+EI+Gt+PDM90LBxlnGVzFOJGEs2ikVwtna0f9H1yw8ywg9MIq0I?=
 =?us-ascii?Q?SQ2l+Pfy5nrkH6suGtC4yH7aUUAO++H55bBzrhC4P3dy0ueQ2liBmRKndnvJ?=
 =?us-ascii?Q?xHcoDEeV1z4SyUCRdXJLSI+tsZfT8J9T0eeTXl56og44wRCnnxFYxi5+IJ1I?=
 =?us-ascii?Q?gHpHEq/7wIXFPpVJ0HwymzNBOULGA2NtmzZidsp0BVYkSdb5+om2Lol3nta0?=
 =?us-ascii?Q?dnbxHRFUbPxwmzPbT8SNNmTjcbzDnQdetK49dc1Ei8cTTW0CKo8G/cw47oyJ?=
 =?us-ascii?Q?csQzQI0p29v/2Fk95HRmfnCjx4UDZS+rgZvaCaRDdo3cHtQoul0uSeiw3wYj?=
 =?us-ascii?Q?mVlHHZoboYTUdlaQMW0tTmhizxBEPF7VzB2qVXW+iyZkT28pMqDzpv1Y4kRt?=
 =?us-ascii?Q?4L+Ne3RpSlSmv/x/mA2T6+aZOQfBF0ANUSNXIkwfgyPCKQD+AfbcWwUfJRp6?=
 =?us-ascii?Q?+Msu1YAc2NK/kqy9KuYIzw/zU0KfL5fvyGWODexEYklaUJqm7ku5Gr3yrlvR?=
 =?us-ascii?Q?hWhlfeJTw/FkbY0qr2lIaYWNj+TDnm8iEjcFh3+Ay+yLdhOWmxR5MxPqN4sa?=
 =?us-ascii?Q?p2XHAtrhO1bFKvkBkFEkvtJdTA/jXCrrwiiPz/djveoaCMpJCiFcyJyRF9bU?=
 =?us-ascii?Q?gIRRVlOr6K+0SW7fu3NXQFCU9lcy8KiOZMo1WrcZZ2aZFz0qBb+AE7V25WcJ?=
 =?us-ascii?Q?WA101ZFBoEP3/CHpclIdci9RRkXQQ3NNd9FFY2GMEdlwRoq9TrcTYYJHRa2S?=
 =?us-ascii?Q?Xowfkx7YmiUam2NaIwerh9Icult03hzZrtZq9CYG0JuGeRpvgX+M1DgDhnqZ?=
 =?us-ascii?Q?1Vro0wHjB6c/ygEQS1A/bcI9r/OOQfYZfEp80is4Zft+EewDwta4g82wFdXO?=
 =?us-ascii?Q?qu+g+Mw01Q4IEEf60LPSVRWrUiTtHO9xc07S1dqtfIBdZHixIOIGJ2BfJRGW?=
 =?us-ascii?Q?pY6uT8gYm/NnjKHRA6VeUDY4wSjdKXcmEbidaBxXqEK+hR7jk23DmBAPZi8q?=
 =?us-ascii?Q?O6sFKDp3r6VM9EPWHaMJQEW4ZH+S+0yDQY6t26m3vwpKRpsn0p6di7MDSHPp?=
 =?us-ascii?Q?rFiriOcBe2Y76Io6Ue2yJ5ikmxozFCzVEch6lNn3E3lYeIuSa12Pl32WVFTX?=
 =?us-ascii?Q?eWA4IjW4uPx4bcja9Ix2GhWRSrE6hY9vduFy9BLTHL56z15HYS7OHNSr/qYI?=
 =?us-ascii?Q?5XUL9pJvvNcVtXZzOCOxljMW1RuR46EejHXKTFDnhXzFHLgfeGEI5bBsQ8+L?=
 =?us-ascii?Q?fxowoRo430qAKliCn5usaYnEGvYrEe2emLb+WfJarzedUIVilzpX0xwGcL0H?=
 =?us-ascii?Q?s9cvWTntt4zQqzGQA3TSpa+LujsTq/vqixukmxw6u0ec1nAxMMTYbcWecPTX?=
 =?us-ascii?Q?23s2Azkqpg7pfF88gdZ+eNixCdx5expzun3SsNNxO9WSmofe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e334da-06f2-4da1-475d-08de83403295
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:41:28.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmg8zL+xRvlnB/F2v8cssvXno7QlZHFRoJlgQ/pH9E9HVZlgY4LfEI0pDC5PbhP8J6cibUyzSAkWc+WqztyPJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195

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
 net/dsa/tag_netc.c            | 180 ++++++++++++++++++++++++++++++++++
 6 files changed, 208 insertions(+)
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
index 000000000000..15b0dd5c5408
--- /dev/null
+++ b/net/dsa/tag_netc.c
@@ -0,0 +1,180 @@
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
+	struct netc_tag_cmn *tag_cmn = dsa_etype_header_pos_rx(skb);
+	int tag_len = netc_get_rx_tag_len(tag_cmn->type);
+	int sw_id, port;
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


