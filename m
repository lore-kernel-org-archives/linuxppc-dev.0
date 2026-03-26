Return-Path: <linuxppc-dev+bounces-18804-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9111109E54B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 06:28:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDPP2N5zz2yjN;
	Thu, 26 Mar 2026 17:28:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774506521;
	cv=pass; b=oNttRq3Ozhi1h+jQhpAvBJD0hiATwlkjWzn4dzN4lgI7XEs4hQ9avYRj+X4GdJucZokp+CvPge+6neDpy/qJPAYUOfGJeic5TQdkClUBK4/8HvOUYQIefOBTYrwOyllOdFVxcqe2xbmg0wF5HIOsuS8Rk/ZKGj1RO1Y0sjXauAgXp0WIBr0Y7/FKMnol4EZsLpBBql0OahEhtNkbATRd/HgiIoLmFGqNMThrFmAkfyw7oAlppnspYIuCkJ+DjpJkBux3/tJQiUwG8AmVALNN6OIpleVnQ9a39gQdXFCu0rhb0KJWt2WeChCUaRnZNjv3qXoZRGtIylusA2POJBNKLw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774506521; c=relaxed/relaxed;
	bh=enC+UQAaNN7bbyUaQSWZ4TmvKi8/JoljnoJJAwDPrrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Es0hf8sMiI6klH8TToT2rMlhDzPlF2Fu01A1nAKvGWdHL+tyZ+JrlqT0vGKJutpMHghV6KlIX78uAAM+7Tk0NPZtqABpLN5+veql8JO4ltoRhJhxi/SWRp/BXMPtDfNxfs5KGw3k5rVXLdeRZXJUsG0t+DVdOwQPoVwA9vZsXiMh/dAiVfhzFcy6UBp7zR0qFtJ1ZgIQ5AW9NTDQU7s5qdF3muMLGeklp1WUqJAKag3daufh3TJVkaXzkXUsqwZx5EYKZ2oLoWpOsCO5HBIl8e7K92bDBDXIMAZzJLitXd/i5hnGXKk3vNZreRttbrOI/toMuAt821fvdRE8rAjYuA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=g9EDShdW; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=g9EDShdW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDPN2zmXz2yvc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 17:28:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isftSmAaxKCSxlwsx88lpmgOSzvRpJG3V7HCjbEyp52LzmB0VBWcSmjmZdtQk/1E51SupdRfW8Ampc9wAUnCaOAwb4G8RR1fWgBDMfx//BjFKKun4VyvEoCNQrZXiepBUDqsGCAdOnSMthMl23+XZhFNoqxBWCIlIBj0Equ8rD8dgwjOs8KQ6v5m8yBOTeHOEOFdM6+TKc8Qibb5EEFu8QIYE2ohW+U/IcFPxt3fqnPIygkSHQYMHTsO5u0zVzZIhs1AxdopiJEI5zcdLXfydVBblsM1F61Kdp6msaFvimbPbMoB0Hf6pj3A+mvLl//BCjhWQ78AUfUvVGhKk/kvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enC+UQAaNN7bbyUaQSWZ4TmvKi8/JoljnoJJAwDPrrw=;
 b=wIZJtVXAuJLGBRr9YRtTWAy3KlsUW/+kY0dkf74qx716+VXGB/otlBpGQabCLCInKiGXBVRZ8/o/CnxdKuG1mW1NBSREiwoF/EkVZZM4mZs9O1l8/fVnG5Icj1qOBI3PlPRPnf/o+mChY1UsD8vYBKuFJ9EILni8Hft5OtL6/lMiqIB1YeSp14Dscrobpbrzb+kelOv2NMOX/280qVZYj4p+3m19gaL0WtvxeKmuLkwEz5w29xK5IWH21SWN0i/pv20BUDB+gNXXaNNxZWS30sNAfgz17AVij9OoDzT8Ohpq6UbAm7Byjs9/wfdVsF114FO4zYTT8tMfPskZ2Mp0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enC+UQAaNN7bbyUaQSWZ4TmvKi8/JoljnoJJAwDPrrw=;
 b=g9EDShdW8vsihVXFAGxcmUzT7V9ElF0pFylCYOclxTyzY5DSF5s1uzEyT9xDdGMhwWU3cvcIzsFQNIKDR1Fc4+D6Ui7PqiToMrczkQsa8TghFmM4lEEU7AMxDOIAXYzKf9SpEBcJpAZQ9zN9/KhYyrunPePWa2FsHpWww2ww8m3F/Jxln2jV6gyqgoGqPJBYxAtaTHksJML9zDWUBP87xjOdVd7vMrzZKut4sZEm7ptQ58RTvWpcSM7n1/EbC+YOSMCoWRCgmWV6QH5r8Mx214I7oi0pm9GNXdoD7BFX3zzYMNEn7H+EP5f/VNLNOs8rbOvEK417x6xsU6YKQBnHjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 06:28:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:28:26 +0000
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
Subject: [PATCH v3 net-next 09/14] net: dsa: add NETC switch tag support
Date: Thu, 26 Mar 2026 14:29:12 +0800
Message-Id: <20260326062917.3552334-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326062917.3552334-1-wei.fang@nxp.com>
References: <20260326062917.3552334-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: e953aa2b-bbd1-48c5-aea9-08de8b00e33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wXOPhC7QP9ucYyUftsdzY09WXhby6XbFEuSbE6MMX83xfkD0IZHr6h+LZyVnlnI6IQYLstUWddQhNs1TtVoqIaDZcxAS+QFXLCwAtPofAtEUYq8kJKlPzq+HlDc0e55B2dp4ePKfXKWZAWTqM/3r7ygbopnQq8GafDdH9VPuWJvvQwA3RhVr0yk4T9/SqEE3rUI9BVknzwtor1tCoPHJLKzfHth/JTfyJ83I3u9xfm676x2mL9bq+xCMv2Fq/M8VbLPtskk3ZCeqqNcmVbRZDS32GyNKAqd79+idljjZutKU2YkbzJAzbK4S9PwotAQjfIAkcFj6zxArbqdP/4o67rQ0rZg4HR6hkxXKTevrFwlWtS/kHPLlrOEhhPOxyotVwp/IgbKC8lIxQdO7u6EOm+poCBMgMHa3m13BnnYhoQpktVVOn6kjADjEoXwz4CUhfZDuVibY1F9nvpYD9XmkGGOFE9OOkoklYT7bEw+4bauzeFbvPiDq3jRxMBfeMZRpH0IRKxod4+qOAiPWbQxp0cTbbnPbwIVLPHUsYX+3+M8wZ+sBgdpfIJwErtxFASiwKP89PMp9xORjFziINZr8BtmX2Ho21xtlGTvrAUy/LPNG3DIe7uXqF25U81QMpmYgEqH5JFAVX3GRxH3/z4USS+3FmVfJdI/twIPMeCpBmXmtdkcSn7I4UNujZ3D+otiXgXEoSH2FcEx6lIA+NOlNP938x3tOKmLvUFySe4HvebFhmR5BeV+MUpeqxLdrXKCICZQklzea+sRMv1CjGGb/tKOX+CVQpckAO1Hrir8s7VxHx+ybFxK2AifBQo/UtaVC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?123a8Y/jVrPtZynDhYEdGUf80ql2FgnXwwRQNHHXyTZ7Ye8MZ4Ia0lY5UfEb?=
 =?us-ascii?Q?Fdanr3q0kFMq4DV98uKU9ivSxWvJnkMMStArG4tg9v2tVvdSS7EymV0IHpZX?=
 =?us-ascii?Q?eRw9LwxPcL0bArQHAlQOo0+0XQIVwKZXlmectsK61Mg2VLAM7TzreVqeQmvs?=
 =?us-ascii?Q?gX4yGdmCO88x8nK6jR7YJRBx2L57eIV55ZRnM+0SLa78OtNS+1mR8/KWTvax?=
 =?us-ascii?Q?5wYG+dSdHXaMMJpyh/ouX0fyeuM/3JuILX5vk/IJ+7GiNC8raukzfrVk4XOk?=
 =?us-ascii?Q?j4lZYxmBvccQCAk4BXyvMpGQpNpZI9hnAkmxvbF3Oq+Svu7bgh3enm3whT3q?=
 =?us-ascii?Q?Bn2OhuIyX6FeFEiWjmCuO5fwHkmBG/NVPv6oRVR/TZnsQqWDYA+G4VYY8GOI?=
 =?us-ascii?Q?WNWV6um3GvMotqcMkCzUDZVxugxNNIG2qwpDkpURHHnVoDH97pxbMDr2WkAj?=
 =?us-ascii?Q?sWuC7n/5sbX0DkgChTQBW7MXyZCfpARxeYKJz1rmSsj3iLnTnmepqFg5eQFD?=
 =?us-ascii?Q?U0/SSOoQwQJYXmzkJVstTwM9fWD7qUi8xSypq+i9zHQlV4yfKvbEXvfbw8e5?=
 =?us-ascii?Q?uKjtdyF1YEd6g/DQP1s4O2yXsn4s9nLv9pGndEvJqF0rUkE0pn0oQN23E7SL?=
 =?us-ascii?Q?CXDyq/V6q2Bf2RYXJyu1FpxKK9tGV3ovnFCcADaps/QeTafK1xdzG2TWdhz/?=
 =?us-ascii?Q?78DBeCwEeGQh0L8kAGRzvwU1yYeM238YV+4Kvc6VZhn4rzGspn9S7TqVxYXl?=
 =?us-ascii?Q?5FUxOO82ORLlriOwsRklqMZlZ3sKykECano88VTYl+vHiUofaIQ8Ulzts3pB?=
 =?us-ascii?Q?gcBDsYJS/7O/y29hHvtkqFIC90n93ne8i3goLX3E1KF7Y7V/EeUTpX7abH5D?=
 =?us-ascii?Q?itiT2COftyJYtuxSllVJSBdIwL3CiT4jCleZqyA6FddPJ2/hpTTqQgCKCE8b?=
 =?us-ascii?Q?8vrGxX2GnhtCXhPwP2kppTJsqT6lhdZasgMjZcQnW4Q8oJT54kiVN/3oujD4?=
 =?us-ascii?Q?Z+3w9nX7Gvufe5tZOUWaPaFn2SXOweJxaYF6Yz37TqDzTo8rRx8VVW9HQTTR?=
 =?us-ascii?Q?nChxzoun2zjC30QtTOh4Mo3pLY/sCUGVjl/8iyhxdTyJO/Rv20obVtmoPJZ1?=
 =?us-ascii?Q?GDMAo+N5imJXo2VOtI3SVsTX+CsezMKnmFfoZApkYwthz6J+VfoGnBoO9Np7?=
 =?us-ascii?Q?Fhhn4JS0N/k54GpzAJI9l9OVFTkHAhiaFOXu6RMVtDmCeU4Q7XRCvB9/c1Bp?=
 =?us-ascii?Q?UTbdSN0OZEVs91LW+ueCMxpOWnSqHj9P3CKCDR9ymtYwRx2ZGFA27/zlCTjF?=
 =?us-ascii?Q?/7mW54/l2AfBaPFxQ3paU0h2OdlhaMV85FXqZZtzG9nPw7DewnALwdnS7sq0?=
 =?us-ascii?Q?nIhh8tdPrRVysrKtmTpzk++0o8EM38EguZWaD78oS6higmuUReYlj5ZJxEZT?=
 =?us-ascii?Q?CCLAhgxEwqSk/Ow2Z0wMZQlI0T1z+gwEkayMAEl6vgruDtxrMPo3TYAkJ2R0?=
 =?us-ascii?Q?YtOoVzMab/1PA+JQDPX2i/rVXDDQzgbtweFh5Pn3I7KXPnOIyfHqvFN9dnQS?=
 =?us-ascii?Q?h+Ht6yr0kYdglQkQ3kh4iby6BD0hfTEB3IHE5QmlbqRNeK/YDpsrxcqOa2UD?=
 =?us-ascii?Q?P9xItxGxfGnt1x4Sq1E6gcOoMyAoh9IJ7b13QBLlPeFPNDkxt/tdHm+to6xw?=
 =?us-ascii?Q?kb/tTSYHGRQtzcXt7K9VHweYF7zwTx4HrwRHn6UX0fAF31X2tyj//dGfuUzm?=
 =?us-ascii?Q?LGuJ22FYVw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e953aa2b-bbd1-48c5-aea9-08de8b00e33c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:28:26.2900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XqZ91Kh6chw3k6h6G8m5FZg8MkoHyZa1X7B/TS2H7goP9+7hhiJHTI5lCYVDKMH2vTWLnwMEZTKKaRcTrm9jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355

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


