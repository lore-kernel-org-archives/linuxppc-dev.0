Return-Path: <linuxppc-dev+bounces-18578-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88711D58B00
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 06:07:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffN486Rjfz2ywy;
	Mon, 23 Mar 2026 17:07:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774246040;
	cv=pass; b=cwL9FlT/3ATU5aaAjY+dkRhqu5Lu6CAF0PaCGyno96/5dIVGJNzJ6KzSsVqHxe4KTf/pg1bwuxRYPhM4iZNwBHeNVNtw/PIzpndeEUJNEt0YZVQuCqHVqthEd3HnfN9xIGWsx6gFMaEU1tfFxYXa8W6MgNuLhr1GsdJbCZ4VYXnZaZTHLK+C6cpFATpcdVBO2sKtVBBENAfe3QCX81JQRk9bEx/Ubtfr5WbAHTOkTThXFiNuyRK4vTWzefd4QXt7ZPuv8+e/ezudIwE9z4ST0WdJxz/9guyd5q+/cTkmU5UdRFIgnEBFYmJuqNVaj3PAhGgzE/Dsm8oXc8lW3gXEKw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774246040; c=relaxed/relaxed;
	bh=PBQrjlw2rTWR6At9Th/Kk4N3QU1TvCLV5DqehKos/NM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AbZ/ILmZ9/P8p1H6agmOn63nUDn1KJkCaGf9WrsiCNQncao36AOyL2wkm2q+otSyQTxk+gKKWktktMxhIJw4JPKG679JKn0QC2rB57yTnpuPRLEhbZP7YpGAP3WtpUcB1IC4DdRyzzfLobls5D34M4mcJT32SJuqQqGyXq1w8bmm/8xULrC5X5R/L1Q4ixLT0Ao1JuXIysYxhFmdjJ1qirxgrg+pG4wlFc/1CL1mDcEnMwoBmVLry3Bm/hA/ERoL5n7klO+9sIhe25kj3QlJnqczw/Dc6JReD9urpowJYONtz1mIm55TkBFd8VFn/u2Te2oh2aDxEuEFd887b3qphg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=YKNRCRE7; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=YKNRCRE7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffN475sW0z2yvC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 17:07:19 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0j2kPGGr7tytyDOPNZIKZ9o+avFfx+G0hBGAnMsJgBWrpLGF9XFhYKJox9eNP8NV7t21IKkVUAEsR+q9NfsvoSNkB6XwkKxRZTic3XAuR8hhtHafyBscZ6V83d62lKW/N4eKMJcZGWMq5PrTJxd+n0mywkOvUZ4OebDx2x6E32NCb8gcCiC3/KN8sfuEJ11WP1vQT3gcwAINdHnCmS3z1A4pfJmMSPx459VR4YonTJ5mK3FzYVve5N/7lWoOTJPTq+ixIA9mBNdGooUb08cJwVjiJMUiTfKZIbB0QbvShHcWI4TALbYh+SRENU+ZQo8DZldGVuwSniwXZYDiuB3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBQrjlw2rTWR6At9Th/Kk4N3QU1TvCLV5DqehKos/NM=;
 b=GV8NY/afvs3z3qSNPlyDlkMPqOxUGLLkaJOiECpfiPF/xy71dc9LTsF3Erngppucv2FxWayYkh+xMX5ZSb6SsH2HsKEts7+7g/l0qw01wv1Tzz3194fdWrgMT/oDie9aHG33f8zcLXMtEzkQkZ4dAKJe0ngSAFmj9/kb+IeEt7D7w9vOfmCQLJnWhsHzwrA+YDdmQ2oYzEbijXJgjpNPVABHoBwrZ7rmZWB8q22R1Ho0P0y6xcOA9LhbXAJqHziMPctET18+o+Xx6OfaX1XlwOy+Xj9MxjxkJ0NLZr16c93VPh4w+tFPcDHvIhAZWXphT8fG9Oo3VG/E6p2T7Re8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBQrjlw2rTWR6At9Th/Kk4N3QU1TvCLV5DqehKos/NM=;
 b=YKNRCRE7TGfkUakUgcQnlOtCqPEDEyhTwcwmxkbWfhfZTv8c9kR8Frs5p87t94T92QtNDev5mXC+L3KDOyrkYeBPwa98oOgzr7i+YZZnXJKhxpIP7A4W/IvJ8p1A/ARp4lRvye/AiY+AKm9WTKhlMrG2dg4b5k2DpTqb3ZIPeoJsb0nmcMpVJlPbUbipSbmZZzfb/mZ3BGcNtjkpAJaw8Bfox4z3a+8CDOd2Q8SVimheOE/1mS36hASqZTeBcbgLwConvC3+yshD4a7hA1muW5//d0wCO2vNEwFeen5ZqY0sRrsMv04eTDRuRqdz9ryv3ThXV6GY/PNjCSqSCwam4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 06:06:47 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 06:07:11 +0000
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
Subject: [PATCH v2 net-next 09/14] net: dsa: add NETC switch tag support
Date: Mon, 23 Mar 2026 14:07:47 +0800
Message-Id: <20260323060752.1157031-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323060752.1157031-1-wei.fang@nxp.com>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|PAXPR04MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dcc740b-8ca4-402e-d9ce-08de88a26ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AGXljbhWLzUPuMW/iCyAs0PN8gCBSvf0vgfx+rRkx2b+9FQbtwKeFoG8qK80c4gSfw5FtjUxuYLgOtLGWFcri93ignsrL6FrU0dkGa4FKzTptfnO2M41OzlYdBsUhh6NBG4SaZT8KVbfsNXIpKZlhan2kopWU8ztdp+2Auh0oKUE8kCHCXGe6LhF+Rf7lCDXXwGXl/cdMAnL9wukPZ9i58viHAW4TToeqaxE9J/83ybkQL6W8HmWOKqN1MiiSxSdxLPx8AWCYmVbLcSONje621KihztorNLRfVx2dlIA/TJBbwXGyePhgCrIx4vxl1Xx6mqeaP3APiMMsS6zRKPGx5g60A5O7a6sf13mTzVhbVRR3c+SxBrns4MNnAMDgpZvCwYgfMqAxBHmqf7y0rJD9l7Igy5095pRmqwbaIbquNmf30+Ckeq/clyVZpp4j1Cs+ukA9Y5jcsYLVOwtCCMmQOXAeXJ4CDqPUoQ1zLjyhDsmetFb1j7hCgnvo2vKpRvft/5ik4AV/ftUrh6yFoDJRPltgDl5M4vO+ncRBOFs3PFyBTcmwQxnloVqEHZxJRMGGUi2IjPaxjbrsG+rujOg7/S2v4ows7LAXDXDJ1t14EOpJlk7p+0WRAr/sD7rM7LGghuDLB4BhAMTbxMevSBTDCiE2W/PC5C+jgS/eBIscEDVNTi6XeiEoN8HUJVkNAyqjhNMNUxGWEM9HHKw3IBjGXd+2WBNQpaRG3ernuEKR5LVah2VPsVzUkFPKkNoc4cYVQoI3WK2+6oWR1O7NmLFToyudGb1YCOiamepZ0+IGrcs0mDE3VrVZ2dwlsF26/tk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GUIZhyP6jybwvckjf0vNr4uYSTh0oEIp0EObxdmkO8NPv2RotGkCpSEfSXpP?=
 =?us-ascii?Q?l/rt0WF1MlHcCLksAeLRkaMX66OFuIgs63Iwd8e1GvXsEkCXcBV6a3IhjkG+?=
 =?us-ascii?Q?XkEbLtbspA8vKGvIwF3paATHL1vmRyjgGA5Ieoblqi3rJewyCUoNMiulULSl?=
 =?us-ascii?Q?2pTDj/IpSVfEADnBQLpwWavQ3fEXu85Ij4TVDezsxhNmiwq3Oy/VwlUhJcMz?=
 =?us-ascii?Q?iWFbL9bnh9lAjsHGDMIvRHd6TfxQHrRNVP+2wII+WD3fhjGNgAb1772SiskZ?=
 =?us-ascii?Q?MmPoLnoEe0UOK9fMCCGg4Czhj83WemHw9Gdo7V3YI69+VMZQ+vcVbN0HXkrP?=
 =?us-ascii?Q?zkE679XUQOmA36p7lw3nX0A2ECh6QhxKWjVQga6cNJ/O4mIkVGLrZj8tK6st?=
 =?us-ascii?Q?ZsDrJo4CX0iQGTgMvfLxqtA/XBNqrIE61UrBQGRwii24VrtVZPQ/VD5PvcbU?=
 =?us-ascii?Q?Jy8kMVs1eItySrec6eUxH0tUIN0eb6cq8kJuKU1GdUJRjOlUR+AbWSRBMGuU?=
 =?us-ascii?Q?geBH5tz/GpbBX9W08cpwDygTIoIkJOh3eOjwJZPKRjY2PWGURTy1/2rdQojW?=
 =?us-ascii?Q?2y/UaTZ38yXA/MxX9LquwlYfybNgqkMV+pINiG8n6r7nu/2unN6IOephUlaa?=
 =?us-ascii?Q?gdMzboVzaiWb5tgyoMHAB9TGr0w8d42zs00kT7J2I/TtqNErapMousgRBesB?=
 =?us-ascii?Q?oCfiVdFsYPzzNH5ItP+SqPMvWIyfU9XL6F89b/kcAcRIYsElM/MZlH6GlBVj?=
 =?us-ascii?Q?OBGcaqhhO6qTH3AQiEQqs+w+Zbziet+hSwJ1j3nllRBb2UBeQIWBWc4XCqX+?=
 =?us-ascii?Q?DAb+rbZ4i3pvsu8vqwM2ozvfRIfaeljMR7TpKEk1JQk0iVL/zojM9jZWhPct?=
 =?us-ascii?Q?LmrMhRmZaYyDJ59UsZM25ZugHtm9vTepANIzvu4HHJS1lpQTqNSbzyo6luvL?=
 =?us-ascii?Q?dgB4X9shNBw2/usptXEI3o6kVP1Ueq6gtzRW+0FbWvb5lUENMIIWXabl9zZY?=
 =?us-ascii?Q?Y4mtbCAGLIpTrwgaVZt5n0TKYgVV1nSo4nKx8VoX8u1OQMJDWV7AQdZZWcdE?=
 =?us-ascii?Q?egpEnzFtj0YIHatt8R+qLjsTU/tHJC6Z5R+gjLB2Xoi6JwI3mC3njL4kN7ku?=
 =?us-ascii?Q?D28WiwxVBQsbhR6Ozzt0/S3eIZZ2f0/wvvOMY6Ghfvj3s2mbc6WMWvUobCOl?=
 =?us-ascii?Q?EYk482k3Jth9FFIwvJVbQ4NkW0drWL2GkogtJKS9GD0FnnSV9OKksz0UTUSI?=
 =?us-ascii?Q?BxFkmRXLO4wmik6cBbuCyWBC2DEOIy2Eq+x75AiFeDvZduh1QmcMkgQr2CfT?=
 =?us-ascii?Q?A++GvXUhAN0aCqaH63kP1QxwM/pbdY4Yzpf/DReWj3eVs43kHMJEZ3eOvmvS?=
 =?us-ascii?Q?v3L8ZVYI+GzrGCR3mA6v1ihIohdrgpR0BfGxRLK8lVJOZaJi5ufrLDcwlHLG?=
 =?us-ascii?Q?B4tRAtfCyMbJFpNeJZlDP9WIAMkECuReurRaZ+PTaiq0hln0zdAq2J4YWnUO?=
 =?us-ascii?Q?YwIYn17FYftVOoccmPVjYB47clmpZtTXM1AVF1aJLwcs/3Lvc0pYX8TT29dx?=
 =?us-ascii?Q?tY2HTxxFTy3f72/10aBq2rndB/OHyj5Ug/G0SGRrIA8h86Jto3IBgK7X1IL8?=
 =?us-ascii?Q?OU1X5KHpKg4nqMz8eZFk8w9OS/MP9y1FwNVVecDMs1+P2bFc6wsZc8QigZLr?=
 =?us-ascii?Q?27FNYVaE4OqVjGH9SQeTOOXZdSnIU/Zjn1atjqjc78WbqpC5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcc740b-8ca4-402e-d9ce-08de88a26ba3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:07:11.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NREdy5h+ntR7Sahwuc5jgzeN92NeSI5bOa0X9tOllf9K6p+fJw1i4maCMSiAURmgWjoGpHWVai84lcmnDflVFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911

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


