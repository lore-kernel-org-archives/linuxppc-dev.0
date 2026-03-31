Return-Path: <linuxppc-dev+bounces-19065-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D48A1061B32
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 11:28:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flQqY5cNsz2ybQ;
	Tue, 31 Mar 2026 22:28:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774956537;
	cv=pass; b=l5Soci7MMfFvxV2GTNEmt5thLZhrsRclJKjmBWnncBIinCr4l81JMEsRnCgF0WslWJXId/IDwDi4WigWFUNl72yRhF/az8vA6oJgjwl/unZnNY08h6zqo8ajcHzO25gTcqZ2i5JPIk7ekyzqTNwrz1OmBoQvDWPB/HnFtpYndTFsZvyTm7Glm+REx50FdXOY4wyvwhuaQFFIJoirNIMFc71Rdw4KH/tIqix5GLNiwZJWT96z540ctDaZUPclEzZK1Rzqpz3LKawmtWmKWQGKc39Ah43A6qs9W1Rx3p1f5VtvMM2+BpgXo1JDhhWI9R2bSBwPskl+lcOliy2kS0eaBg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774956537; c=relaxed/relaxed;
	bh=5jcnRm0BumwIlGcbyzvJHquB8nYFg38oeUdyH/Havak=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ISCFsfb/rcMKq1I27GjNHC5nAzLZpyP+sWxoS6nXzJ9kQ0BYXg6Co8wt195j9bEcqIWbnL9FVqm+0kq/E9r/7IwpfbaNa/HlaULltgyrZgnYDya1FTWHho/sDuJkTPzIBABbcj431kI3xnZeIrgSZJLituZHk52Btg9pDQBNCN1fr1BZv7f3f9cs3iuZPgTDrFmIGSMbAyUYMeTaCreS0vWgOcAEPSiqLYKrEWgyDKJyXFo2dfyRfcHmCy1c8LrL6aeGdp8pozlYbjGGGH/4NNd3VMIDNX8J0i0PyQGgcZdz3uCsDaYpF8mVlyB5NXCSdH4mhv8MfTlSnKdijbxW3g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EMyjoGzI; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EMyjoGzI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flQqW5Kqjz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 22:28:54 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gy85vFN5Pd1/fnfLPhU6Prl0/23MwkzfoSsGuYO5y9nRleJ3jQJjvEEJS8hl4t1s5VAv8otyqhnn+EWaf1gFgtXjaJMMDeW+YRfHGF2Qh3dVxLxzqxdGqWhulcBRENL1SwfVIoonVmQbEPKYen+n0VXTwvRrx52FX+5TEc2SIq6hJIKgBdwc5yTevxzuAdrRp/jLewJyXhuRtNrDFkYoihRFd+g8rM7VOaPwlda08BrDAsYa9x9twZiHTKDWmQoGau9mrDpfEod9aUE/rhOYoOWo74Wu+VC1KHfz09jC14/S5weeR1LYuSCIG/8lOLMZaj5AHa0VSgf3fpzqztwI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jcnRm0BumwIlGcbyzvJHquB8nYFg38oeUdyH/Havak=;
 b=F945RdErYlTf+IB9zphhYdPRelBGxgRqrUvBQlY2xDgQ5nET61lkpo9mIOHd7t99O2NiA0yYjvB6p+nmMUMzyspG7FYiFVlrtj8qQOwWgeCcDc5XoFU4TaDr6vPK+Ojj8DGwKf8/xt8CvE43+6TSurI3/XLbxTMJGKx73ZS5T9iqUYyyNuG/dfQ7Qsk+VPrH7456XPqN9L7FOoLeP6O28KvTYL/p/Vr/pa76uqHCn09RhOr6i22xGdZr62Qy5saeqQJw70C0ru4YD01QPpl4m0W8imMHD9fD9Ol45GwuLtgxuifdrVJTCeiV1o2cSaDiSUdE68NFbwS1tqoLubhIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jcnRm0BumwIlGcbyzvJHquB8nYFg38oeUdyH/Havak=;
 b=EMyjoGzIJRN1Z8YOsj6UROvx1hbXJVU1LqO5LainWCtwS9i97soUta9ts8XkIN9pm2YBqsdrxnGibn8F9UF/BSAN3nRQMYfhV11s/JRywhvPYxS+Wjq6VEFMW2FdxiOfD+v233sQJAAawY86bKWM/HCj1ft/7lTxplD4OfHjAE+KjyVOpMFYTkdgeh3lRU8RD89IjYOAtMLS6LjQiZzGNNc5XA95fyz+VGneqI/3i7U6wgKP3BsxauwnOXLD4QpAR+Bp8rzhipPXgG9UKf4z4wEUM6Sz1X3ydrpRnc9gMtEp96Mq4/hANVH1ZCwZN6ZvG4SMu4KI2CWJPYBhsiJoDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:28:26 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:28:26 +0000
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
Subject: [PATCH v4 net-next 00/14] Add preliminary NETC switch support for i.MX94
Date: Tue, 31 Mar 2026 19:30:11 +0800
Message-Id: <20260331113025.1566878-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 925ddcf2-fdba-4c41-1618-08de8f18a02c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|7416014|1800799024|18002099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	niXsti/1qNTpWUFwB1kLOsHqjBjBDL7jyJrTuoOORhLwuaYxJucnsT8gZrnjwJxT7nHfs4BjbvJOtvN8yUHayL5e7myIMQW2bf5nGZTLcDPnzmL1SgHu6QcsZ3Ca38fJlG+zJPmq8ER4cM+b0zaEYqMb2QqqaS7O6KiGF+8+XXnHVilS8kYQfB8CUH7x42mFyn7wEhoSf6SkR7z0z2QHqN6xMGQXhpWrnRBKxfkgvOecAdqxyu8EPBJd0wbJGxPXwj8Yyra5efVYGwH7tYZHl95EGFTXKxMHn9R9kwQH1iSI+hwRWNpt/vlJe+c0nCDNs8+LjVZhqmQAy1fU5C95sURS1M1i8mJ7QQPh1ldfr1NaHQsTgBak25rkJ6Wv6CcV/AhYmEKpZicwFnjP3EXZskbvxCJa9WQgsHFYniHmTt1/TrQAiPOe+W7//EdjV1up8ZlACqGGBMzrpWJtdeLL8RQW09UpW+S9sVLkGixEcczSd6AbV8uwk4l/SSOWOb65ofwsGPgR/FsiRdxbq7WfQApBeMCupDbVxp83fz8ZRN0+j894U5bGVlleeUhABCmLLmq60tvVkHI2OcOexkjURh+9PozJnoDRK+eHvaBh44wvGbNuiGyegjehgladRZOUy6S/SfU0V6/vQU7myBKWTLTYCzcMODlr38txaMiZJjYBsha6CLvSaJBihmppg+WllidizAhvyfC0m92gYfO1m5/xcBVKxC2/5bIenoEerS4QbweA6IR70VEMhQnvufmxzEBM5dBUQ8GwPfMajP04+Mc+iVuWghgfOFKlAAtag7hfBhbdtxFgF3Zt9aM4Dcka
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p4J13O73iyu+rnAsDdG2pUt2OUvTlpat724afifA6Bcdsg4Sch6az4RWIb/e?=
 =?us-ascii?Q?cbm8U9hNf7ZTi2c0nrNOnWu0uQ+2eXOW1IJQq8dxr9lrcOJhkaFlnlDRsEBY?=
 =?us-ascii?Q?pBskFJXB9Qm7kLPtfle0cU/WkotPYKHXwbKSdv04j4onSFP2J4PoLjtWW8i5?=
 =?us-ascii?Q?UjmLw0TT4iveERTRvUg8a5dSrhLb5sIjaQA1EWWiOIRie8naT4E52KCWi6ZZ?=
 =?us-ascii?Q?00X15qFNzpz67vpEn/F1oA92dEoIeE612JM4+TrxKuP357F0itfpl5DxS3fH?=
 =?us-ascii?Q?AbZxjSpckYKJrVaDVoFWmyJRAqBLjp2THkLiZ3Eklq8cj7FfSKSCPLsk9ZSP?=
 =?us-ascii?Q?oZogVdt2k8gW+eS0DRX4ARQDypZumGGomjH0lvYNCLtBiPjimSjO8M23mEFT?=
 =?us-ascii?Q?JEMHHVLOwQ4CBZxaW78svK+1ii4pcTqcRTx0DM/J62Yf24OH9Oay/gv8f3q/?=
 =?us-ascii?Q?UnWz28ehWOcN6PaKpfU4lRI8in6BE9RrJiplJZGd+Bwzi4G3blK5aeECLv+u?=
 =?us-ascii?Q?N2lCwLxh7Ij+q9d/KghSFmWQmCjdjyDj9/L/yl5uF4BqoTy/4zeD8ZMnWi42?=
 =?us-ascii?Q?0/l8IjyZL4PiD9NjkDaqo6mJjWMNvoVWDmtuKzDWZytF7tsMf1efo2RICqLh?=
 =?us-ascii?Q?FhV18tRA9OazCC/4SNv5Vxl7ln0FWTgyAP2suw14SLpVXdUmrxyP9N2KAV7G?=
 =?us-ascii?Q?yk9b1Uvn7RKdF8GgvyUz3Nb+xeN2sp1R7sWWOOTbngmq0HczGvDEt8KfoyrZ?=
 =?us-ascii?Q?qRV4RDMXHYHMtI0ckBE3k9vr7NXFQ0nM/kc0A2zo/XB9nru1aITd6FbG5EvX?=
 =?us-ascii?Q?9C/4rVd0sDOJhWHBbIMgaBNr8sHQOKFo4g9DXc6goJZt4GJI0YL5QuSiHUCG?=
 =?us-ascii?Q?beNnnf1Ll1WI0kR5KHPcuurI8AFdNBKxY2eXTNnmPEGLB31jdHXApbJB2S2G?=
 =?us-ascii?Q?+pi2vrF32xxfsUeUhrX2L9L0fcHJOQu/ajEPH9pHE4IJdqdHpqT+ffxJZ5Gy?=
 =?us-ascii?Q?JBkVZm/6SSjtsL4lUOXxTTd8hbv654lG5mR02dKD1irlKjNj3kLbhjUQpRCb?=
 =?us-ascii?Q?UauI2wxtxbluUw668H+4tHV/b8mjfhdo5jBzogXxa1ibf7OQs4KH0UzBm7qW?=
 =?us-ascii?Q?hn4oM2BoOZpZYDblXpqjwgZ0qbDyd63lf8pIOH3CbulUmFVF+kQYadmfbdKo?=
 =?us-ascii?Q?djGCFeWIx7dl5O1FnF2e7XUZpqEAOKhRxq+1kh3IvXewQPH4poXF7ZFvXaV8?=
 =?us-ascii?Q?I/HaQtU5v51hTUFU6bo2asptTx2KiEu5qbVEXRcJsn1KEi2Pu438oD7gSWg1?=
 =?us-ascii?Q?PKcoPTgAA+bXESvipFw4rdc6HjGj0FtRmT5ceC8uQt+ksOANLUaxpLztgHLd?=
 =?us-ascii?Q?DOmLSAjvyhsqcdTKFUre6VXhja3Tx6c1blTlW1YZp7EHQ37JDClsEJLJQ6Hq?=
 =?us-ascii?Q?2/a7sLEiRnX3s4Ll/PkNOkPGVovl7fjfNDz0bl7QP3O2Q+0DazoMUo0BoCEE?=
 =?us-ascii?Q?zJius2OzwCuhcKCZKguDr5LymSAqo/Cy6bgY5eQruvyLCUdelvAUieohuD06?=
 =?us-ascii?Q?i85qAtKqWutOk7nsgd6Q1UYIodPnw9QCad6KQBmNLgsEZ8ktHnQQruR3YgVK?=
 =?us-ascii?Q?dG+fVhEktrfb1sljOPsbUo7FhGxZvsh1xcdNpmf8myFhLzGS/XRUCvLDlM10?=
 =?us-ascii?Q?Cp2Fc+OQi7827jJADV+GwTFjsdLiu8gPhG6rIClTBj46MlwC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925ddcf2-fdba-4c41-1618-08de8f18a02c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:28:26.3847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thVRyfkjGR2jq2gYWNCh/YbsyRihhQeS6GPx54B+eDkIlaZwcnYh6w+9ZIneW1c40t/9Ij8CvNL+mse0TclwPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406

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

---
v4:
1. Fix some nits in patch 2.
2. Revert netc_ipv_to_buffer_pool_mapping() to v2, the new added code in
v3 is actually a dead code and was only added to address false positives
reported by AI review. Therefore, v4 optimizes the comments in
netc_switch_bpt_default_config() to avoid the false positives.
v3 link: https://lore.kernel.org/imx/20260326062917.3552334-1-wei.fang@nxp.com/
v2 link: https://lore.kernel.org/imx/20260323060752.1157031-1-wei.fang@nxp.com/
v1 link: https://lore.kernel.org/imx/20260316094152.1558671-1-wei.fang@nxp.com/
---

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
 .../bindings/net/dsa/nxp,netc-switch.yaml     |  130 ++
 MAINTAINERS                                   |   11 +
 drivers/net/dsa/Kconfig                       |    3 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/netc/Kconfig                  |   14 +
 drivers/net/dsa/netc/Makefile                 |    3 +
 drivers/net/dsa/netc/netc_ethtool.c           |  192 +++
 drivers/net/dsa/netc/netc_main.c              | 1528 +++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c          |   90 +
 drivers/net/dsa/netc/netc_switch.h            |  155 ++
 drivers/net/dsa/netc/netc_switch_hw.h         |  335 ++++
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  |  188 +-
 drivers/net/ethernet/freescale/enetc/ntmp.c   |  383 ++++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  122 +-
 include/linux/dsa/tag_netc.h                  |   14 +
 include/linux/fsl/netc_global.h               |    6 +
 include/linux/fsl/ntmp.h                      |  235 ++-
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |   10 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_netc.c                            |  185 ++
 23 files changed, 3585 insertions(+), 30 deletions(-)
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


