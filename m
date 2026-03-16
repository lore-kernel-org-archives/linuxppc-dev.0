Return-Path: <linuxppc-dev+bounces-18221-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3EAF4643B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 09:40:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ97j3TL9z2y7r;
	Mon, 16 Mar 2026 20:40:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773654049;
	cv=pass; b=OZRRdZZI5mcp62jCXwYOfDMr/oS0zpE5m7TDk0AZNoclSgAfWbBAqnysiPEGa127xf4McQkA4DTjmqNxqx9ilqpeFNWws5jPaLGQDo/d73pPKM/DdQDZK1fEOZB92Mer6TmiwM08OGTTZxckJ0zH2HX8OIP2R6aD3CxXxBxILlNUUWWxAEQNtQ0ju24+XmLHsk2gX306VHUZGOiOkzL5JJ67liPQ7/PS/DLorJ+diRAoDCKxOZXaudrf8FPUj+uizK9pIcvrUBNUOuv2WqfLEkBYajU0eEmFLGn/t/wkyC2RSbs6EHSrXGFgfhSMUn/VQ7qmSEJJevW56ajJTUpbGQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773654049; c=relaxed/relaxed;
	bh=U7sxdXWUOuSTbxV4sO4U6MPtKzEPLu9f6ERux6/yywc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YAYRZHYUdAj9HX6ZriaHsnkaS2999dqt1Z4+2ALSJgIXiTMvWRpKM3Q0ODvqQnmH7c0SOY8Ytzvp3Nu8EO7QBDs3TxCYCNggTwipuMfe4GlkOy8764+YuQlkgmp49YJGFFv4eHtMaM7VXfjw6qDLA1kMhSiXajwoSBSlPt0VL6K13kI8zeWXMCEYSPDvxJSuVxncW8KPC9I/LK+uyI+3l8jtz0svywMaBPtGEjsDfKhL+qUOx7OVaa22rcJHiu5xIhyPtXA182negXsVfkL68USRhMIGQTKKX/Kr7RpxB4olGv9a0BLbbh0p4Qavn7tE+kORSB+d+XmnifIRte+Z2w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=GAvVHJ1/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=GAvVHJ1/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ97g5k5Tz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 20:40:46 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhB7dKNnihH4iwBdHrhr6DA7ZA76rdHKSUrljw7D1z3K2i5YOfoNIBbMxIUOMWUx9GDgnbJbPlO00CTmI+wswQKTwPqBq5nch5jmuEX2Qs2/L/fy23mXihSccJp9xF0DU2rTs/BVXNkxoPk89qSjL1x204PHhYvCrO7VUlDlp+YdKCkNLtA3xJ7SR7lAbq3ZKxDjeqGNYMdqnsZf5afO8uWy46zKs8YiTpyoTfmKHBSLxSiHrRpT/eSGtNjK+YNFwjKxH6w4M2BrMNRUxd7NUtMYBJ4cB+qjayGySX265VpjtLzOJBDt6Jlyx6x3Gvn/FSMOV70Zv8uJ6585cifLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7sxdXWUOuSTbxV4sO4U6MPtKzEPLu9f6ERux6/yywc=;
 b=WXwiSsWSGbaWElOhT75vKzK16ZzHY650Fs8WnjiETdg+0IcW5qD/h6WRLC8AVyhMT0gzoB0wTS+AqDArtfiHdDimGxOfFDEwVOKfEpiOW2jh65HzBZS3U4QqUuUPtmCao+9c3rIa006/iDhLL8d4AskZv26z9wOmX+5Mh+XYcYvK2mV33Ff+uZ07NOM5EISjxwxSHOzmoGyKbfIKUpjKSUaBdlpRrMVHi4q9/S2QQ3zkQzrNFqfBFk0exv/7DsvKxXRFagzceZnRYyHx1X/gqceZUEISH8lcQ+vw3H7Zydlj7qqxn2ap0UBDdyeK1bpzPXMRczQpZEc2RIQ+kgRzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7sxdXWUOuSTbxV4sO4U6MPtKzEPLu9f6ERux6/yywc=;
 b=GAvVHJ1/YXZqwSUBK4jc1sX5qfvdESmEevLqD6ihBgvSYLZgwuaO3O2pV39CH370gQLf2kv4Kyg4ZlpbfIEN3YDgCf8WeKTQ4odCbx7goWn4IY1nb6xTS1NdxjqG+Il4meGvVsREIVq/e7KgIwETj7Q1HBqfXI1VxuSRbVRxNC6DdDEDjC/bsQeV4cr84QmaJQXT/OAvd98n34zhcCfWp0Zbc7EcyMrMyr2DaXPg1Xsn8ZWefLFDtYaiG95uoUgrovYRxuBOz94Wgr7GtAtzXi39eVp+WkAxvxwyPkkFvyO99FA/zL28PKN96hMQjF/Oq4kl+1EiioJsxnZ9i7/GKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by MRWPR04MB12119.eurprd04.prod.outlook.com (2603:10a6:501:97::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 09:40:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 09:40:25 +0000
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
Subject: [PATCH net-next 00/14] Add preliminary NETC switch support for i.MX94
Date: Mon, 16 Mar 2026 17:41:38 +0800
Message-Id: <20260316094152.1558671-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|MRWPR04MB12119:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f956e6-5cbb-4499-690e-08de83400cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|1800799024|366016|38350700014|18002099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info:
	6qCxbAQ4o2sI6LgwOIGqjcEHvIwT1u+7l6dqDogPbz/4vLPkeuls3veHsuXj2AvSUdzvWtRv5fkByz8XMyh8lrkLvifA/4tiu+MKVge3kht1858iwrOkGuoYatihXQ690J15sNUg55kCmnW05pOcdKKKcHcmJSts/Fg9NmOGlLdi08ILaLiK6yUVo7UpzgvrDBLQrbuk+jXLB8qpEpifeLRvkfMRihDDFx6cmYhSrJPBtFy4OaDuFurrFZDrtvru6rqaLAjP9DkD+fUpZo9ucz1KLVjPLpQxwHiOu+sT02warU1wuU+DuBkp1rQc1h8l28HZih+HSFd9364QpbMCuqqaV9BN6uXA3zkm9+kdeZi97eq/gKDo/Me1zhLqX1jRWs6aeX/tvO+BXDzEQmAwScocHpyZy/qDEX9XiZSqXGCnjfZZPPHeZpGG1P7whP76kyQi35KiN2KF+KCbXP/4KhZlykcRP/eXNACJL+aeeCllhrHmP6dgii2ClwLYnYIcliY8UqkH3OtDhIqEIaT5ZDj1o6V7/9iXkBu1dViRpx69QOjwEGmpmCRyVtNSvoGAYax8JdDieJA/wiZKaKVJDoWN0j69veNprsjh8iVWldho7qjwOBO0xwrHYLrCgn0ImrrOyuUpSV4uUxpnYw3ud/4ilVibo7koNVYdfAK3HPOS0q46kKHzUh9mvw1Bubdb0Ax9vtFS50mu7b+ojf+CyyG+MV7fTDnSk+M9LbeSeqAQzqyvNQfMFEudcedNuQ6KRJaPKFiT/+pWNtSS69496ahr0LIXNS8S8t5Hzvn39/uqyWJl3+8HzONZ+NW4v0jS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(18002099003)(921020)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?afnRSdjyP9aRbasr/3cfBTkLvGTvQcnYqqTBSS78RhsSkD1KXEje3Wd45IBo?=
 =?us-ascii?Q?z9UWqobJRZ78qqrLw6gh92FSU5P5bFp14SZz2G5jQA9gQHascS7/Z7wH4xoj?=
 =?us-ascii?Q?oUoyz83FTaqenDBh9gFTUGn1p1s9aJ04P2bfP4qSf05i+9Jp7s2Ds5a+qrt+?=
 =?us-ascii?Q?jGQm1z18R/IAATR0MtKufHdvQGJBk4+TV2zNDjfLgVswIbUiGamKYLDAme8t?=
 =?us-ascii?Q?J7eCSJtRREOCx9ApGzYx7Xyty4CIv06Y7AfcbsmBI9SCoskzFN1vpyR3uofT?=
 =?us-ascii?Q?K24fCEU1i2dtQHTWwxL5s1IPRkQXzi724WF7NHT20N9wD1CcoRd+pTJk8QON?=
 =?us-ascii?Q?8NDTS7Yt+KBxioRCPrCVi3dj+zDaO6y3Nn03WArZ4zIkMj0+HNbG/nvTAhIF?=
 =?us-ascii?Q?a8tFRP4tyodxqpQfgp+5d8yEkzY+e45BIKtD1iMJ3cnprS4xABLjtS/aUK/o?=
 =?us-ascii?Q?vOhiU5Hh2vb3Kz37AFX4LFIuh68nWXCwa085QboRjwZ0H8fvYmO1vSyZMVGo?=
 =?us-ascii?Q?o4NvXeN5LfLkDMHZcwN2ltT2mWkIbE5Ja6+XNCBCXY424jZqOjO8K/xawMJy?=
 =?us-ascii?Q?7sUwMY0V311x6JZYTr/cB6JDQV/Alzk3bue3w5nkvCa67bM2cjaY2OXT2V4h?=
 =?us-ascii?Q?Fe/v766dFr8Gz2pghPOBHXzS9o55dUSDNBcdX3mIAqCNHN2TipBvPwlOWGAS?=
 =?us-ascii?Q?REdEMOilqGZ1v4STaPhapN48X2luKnVXRMZck1/TLyxCBAcCVlPqpiIccSkg?=
 =?us-ascii?Q?f/Irl1R0Oiojc9F6HpbF78FHuqLmmYUZaNS5KIyvoFe4V3dqhIwdOshZdHQ5?=
 =?us-ascii?Q?RsYP7801QeIostpvKB5s1wx1dqo4MZv0M3fP+XQRs/mXnCdZ5WA3ObqrZCip?=
 =?us-ascii?Q?el5XZ9rIbWvAjDklxe9toyrFlSIbP6Rx3gCNvWRpQRwy4JNE33l3z5uzaU3r?=
 =?us-ascii?Q?EgnkATsHHNMZHUoDE5EMgSFgMIMeRdW7PRcdBNN5RhU/MkXwjUOq8Gl1nzk8?=
 =?us-ascii?Q?/iwW4jTYdnaNDaASENS1Ja6pVFewhn4HeAG++Q6ZkSt5WtrKvC1XZg4hlLoL?=
 =?us-ascii?Q?FEGKr23TW6BvSgG8Btqf63YCpnQQ/rxAV89l+VDnxQP+mtXaukCrAAdCz6wu?=
 =?us-ascii?Q?arAcJ7szUVlkJImAv2OsNi5hzYnfDd/fC74IAMuMVAIZ5J8722mENZM8FcJl?=
 =?us-ascii?Q?5QG+qwyGiQLSBrefnp2X3T5Dqcx04QiKVznNbBlwsKIuIiOu86cIZNFp8zer?=
 =?us-ascii?Q?kMp3aMS2PnbPsoBC2kXNLfrd2s7vFjEhdXHfL7qPC4Q99nUre+23ZgZaF5gI?=
 =?us-ascii?Q?2nMFfq+yCrjeZ/e6b03IKLuSoXHjKUuEQDScZRPleXMSJvXl9PIjuQy22qL/?=
 =?us-ascii?Q?3JjJKejvgAF5geGqJvZbu/W5WQXJsHj3tE7RO9IpHIXwovrnYVJb0XdYwJIC?=
 =?us-ascii?Q?V7+vATGOK/rd1ssPAepra1H8qXEFunnet7LwwyK0DYwLenv/0v4WQi0YXdl2?=
 =?us-ascii?Q?mpOG9LSfDvSLT8FJ/Of16Tdkz4GCC6Cn24oKMO9cXXswxaQBvgiY5ZKdQa1G?=
 =?us-ascii?Q?Q+xsGUJGKniSf0TdtZGiWu6UpLK9wuehicR8bfR7z89fxFah7KkIDt5wD+zK?=
 =?us-ascii?Q?OYLkuB4iqdA/WcwZ3IdvoUNLccqob0qZTfd2SxoiITSCUeCWy2yHR50lYaaj?=
 =?us-ascii?Q?YILLuOoBhbe//zAFsb5zC3bvPC0x2BkNrhTpweOa1E5zqoL6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f956e6-5cbb-4499-690e-08de83400cc6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:40:25.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwfhmTLui1Ut65wEeOJDPp3RLfjsX2CK47sscmrQ1eFBZtq/6c1QPCQt6zX3hlpZTFS3sIhz95EmxJyuskhibg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12119

i.MX94 NETC (v4.3) integrates 802.1Q Ethernet switch functionality, the
switch provides advanced QoS with 8 traffic classes and a full range of
TSN standards capabilities. It has 3 user ports and 1 CPU port, and the
CPU port is connected to an internal ENETC through the pseduo link, so
instead of a back-to-back MAC, the lightweight "pseudo MAC" is used at
both ends of the pseudo link to transfer Ethernet frames. The pseudo
link provides a zero-copy interface (no serialization delay) and lower
power (less logic and memory).

Like most Ethernet switches, the NETC switch also supports a proprietary
switch tag, is used to carry in-band metadata information about frames.
This in-band metadata information can include the source port from which
the frame was received, what was the reason why this frame got forwarded
to the entity, and for the entity to indicate the precise destination
port of a frame. The NETC switch tag is added to frames after the source
MAC address. There are three types of switch tags, and each type has 1
to 4 subtypes, more details are as follows.

Forward switch tag (Type = 0): Represents forwarded frames.
  - SubType = 0 - Normal frame processing.

To_Port switch tag (Type = 1): Represents frames that are to be sent to
a specific switch port.
  - SubType = 0. No request to perform timestamping.
  - SubType = 1. Request to perform one-step timestamping.
  - SubType = 2. Request to perform two-step timestamping.
  - SubType = 3. Request to perform both one-step timestamping and
    two-step timestamping.

To_Host switch tag (Type = 2): Represents frames redirected or copied to
the switch management port.
  - SubType = 0. Received frames redirected or copied to the switch
     management port.
  - SubType = 1. Received frames redirected or copied to the switch
    management port with captured timestamp at the switch port where
    the frame was received.
  - SubType = 2. Transmit timestamp response (two-step timestamping).

Currently, this patch set supports Forward tag, SubType 0 of To_Port tag
and SubType 0 of To_Host tag. More tags will be supported in the future.

In addition, the switch supports NETC Table Management Protocol (NTMP),
some switch functionality is controlled using control messages sent to
the hardware using BD ring interface with 32B descriptors similar to the
packet Transmit BD ring used on ENETC. This interface is referred to as
the command BD ring. This is used to configure functionality where the
underlying resources may be shared between different entities or being
too large to configure using direct registers.

For this patch set, we have supported the following tables through the
command BD ring interface.

FDB Table: It contains forwarding and/or filtering information about MAC
addresses. The FDB table is used for MAC learning lookups and MAC
forwarding lookups.

VLAN Filter Table: It contains configuration and control information for
each VLAN configured on the switch.

Buffer Pool Table: It contains buffer pool configuration and operational
information. Each entry corresponds to a buffer pool. Currently, we use
this table to implement flow control feature on each port.

Ingress Port Filter Table: It contains a set of filters each capable of
classifying incoming traffic using a mix of L2, L3, and L4 parsed and
arbitrary field data. We use this table to implement host flood support
to the switch port.

The switch also supports other tables, and we will add more advanced
features through them in the future.

Wei Fang (14):
  dt-bindings: net: dsa: update the description of 'dsa,member' property
  dt-bindings: net: dsa: add NETC switch
  net: enetc: add pre-boot initialization for i.MX94 switch
  net: enetc: add basic operations to the FDB table
  net: enetc: add support for the "Add" operation to VLAN filter table
  net: enetc: add support for the "Update" operation to buffer pool
    table
  net: enetc: add support for "Add" and "Delete" operations to IPFT
  net: enetc: add multiple command BD rings support
  net: dsa: add NETC switch tag support
  net: dsa: netc: introduce NXP NETC switch driver for i.MX94
  net: dsa: netc: add phylink MAC operations
  net: dsa: netc: add more basic functions support
  net: dsa: netc: initialize buffer bool table and implement
    flow-control
  net: dsa: netc: add support for the standardized counters

 .../devicetree/bindings/net/dsa/dsa.yaml      |    6 +-
 .../bindings/net/dsa/nxp,netc-switch.yaml     |  127 ++
 MAINTAINERS                                   |   11 +
 drivers/net/dsa/Kconfig                       |    3 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/netc/Kconfig                  |   14 +
 drivers/net/dsa/netc/Makefile                 |    3 +
 drivers/net/dsa/netc/netc_ethtool.c           |  192 ++
 drivers/net/dsa/netc/netc_main.c              | 1575 +++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c          |   89 +
 drivers/net/dsa/netc/netc_switch.h            |  155 ++
 drivers/net/dsa/netc/netc_switch_hw.h         |  356 ++++
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  |  188 +-
 drivers/net/ethernet/freescale/enetc/ntmp.c   |  391 +++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  120 ++
 include/linux/dsa/tag_netc.h                  |   14 +
 include/linux/fsl/netc_global.h               |    6 +
 include/linux/fsl/ntmp.h                      |  233 +++
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |   10 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_netc.c                            |  180 ++
 23 files changed, 3651 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
 create mode 100644 drivers/net/dsa/netc/Kconfig
 create mode 100644 drivers/net/dsa/netc/Makefile
 create mode 100644 drivers/net/dsa/netc/netc_ethtool.c
 create mode 100644 drivers/net/dsa/netc/netc_main.c
 create mode 100644 drivers/net/dsa/netc/netc_platform.c
 create mode 100644 drivers/net/dsa/netc/netc_switch.h
 create mode 100644 drivers/net/dsa/netc/netc_switch_hw.h
 create mode 100644 include/linux/dsa/tag_netc.h
 create mode 100644 net/dsa/tag_netc.c

-- 
2.34.1


