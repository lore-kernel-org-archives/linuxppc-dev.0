Return-Path: <linuxppc-dev+bounces-21079-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DB2CD4F49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:23:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrQs1fFzz3brL;
	Mon, 18 May 2026 18:23:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092581;
	cv=pass; b=bQmu9WP1spgzo4DrUXiYBJAZ7qgBe0kgUK6+5gZmhL61PCTFoff2S5nvrMEOoJS+FdoxHkQpbv/TFhvdIBhdS3FJu4NSZ0DtHPibfl+4N7b2fmwOtcvAE3MJAMRhQF1Jg0jd82msvp0SL1omCox1rwEXbEl/CmxJYXv92w34NdACM4PsBbRJvzH91IcwzfTS/ubYHiDg80tR7KClvsRABOTrffvC9GY1ZOG6sLHhf/d2Uhy2Fbh4AFwE/Es9AYiLxe9gxYk3WPHANcXCdK+WssCvmnE4qVAskew+aiTBgSNoGDqHegLzee7iHMA30yUoIVewhMAKHyYomRSycrJhVA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092581; c=relaxed/relaxed;
	bh=u/AwtKtJ1cHYQaBxNYDgUizbz+huTSjEEo9GXTCRbBs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LKt/26iR9iH8YIXqahwZt+jgatT84gWCECZEBl6+ChIDlyCg2Ok7ryF0w8lsA2bsqVoPDSG8S4w/6JyT8N8Jvf3T8S6JslMQijnNUPXypQ+Zv85lk3gPCM0uqNx7nbj9Uf7XxYI/q02ya7YknlIcFb2x3131v41S9qO8DHyLb8ZeufelsJY2WZ2XJcK5HaRdG1ytDl0qoLEMY6cA5kRbk9f/opZcW0iB+7Issa219RQY63mWydfQkPd9x3OxjG/8VHbcHbiiHra0VmeE514iKXu8JaSwhrj15K0UTf0npsnix5n1swHAbAmln+ndee5kDxdVVdJ5Psb8CfVoCi7oVw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=l+efqyhP; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=l+efqyhP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrQp4Pypz3brD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:22:58 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sblKV1yTogt64eO5fGMz+j9CDi2n5iS36+PphtHXBEq6eVObXLQDlRrHhEcpWlSAiiiq8R0BCIUFtacQzIQFk/e5IHr6+rvKOckdpEl4If1YdTURdaBGdkGdLpdm+vE4Pt+uLxELnWdPp0FCAc5ySmX6Xt0Q+Jlofp/NWvgfa6rW1JYS6Tbk2B8D/rDho8iodIbaZ0oW0uzjXY22V7BYJDh1k1IWKVd1yp6EgneCdPYqFCaHF+IE+2dT3qR8bFH31LALHzzZncZfyxfThhD7TGLNy0SQpuiZrnYHXByTUQzLz2rVoPPh86kX4+pbUMk8IY+dW719oYbjiCiOcxOCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/AwtKtJ1cHYQaBxNYDgUizbz+huTSjEEo9GXTCRbBs=;
 b=iRdah5FFmQ7uzRe2vWAVoMtMZVW0m0mic/gm3GhYA0CDDstMPh6xCGaJsvP0TwVzeP/kLdDQn/PFjq13FHw6IxYM9P6z81WkyjXIaa4EVpQ0YP4q/SOUheCp2UpEBYp6o0v2DF1NGkzuim0Vuee9eL+q2qv2nzee+4KZw1kyvGOicJutqYhUd9qHFm0eXfwBBSipBOk6n/6Mry6QGLFBDO9DeZIt9ORV4IlmGaJGu4zjuCrktX+pjVZ6VbAIqeJU+FgQu9pbCSoktvSbOM3b3vbf9Phpzym49MgFrK4AMcN8Tg3NC040cqVC6FXMihD19Og2U8erECnRlKkfNkJy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/AwtKtJ1cHYQaBxNYDgUizbz+huTSjEEo9GXTCRbBs=;
 b=l+efqyhP+5uTax/8bR1n6kPPCjlmGLAdt4Nz7soDea/uEf58TR06xqa60WrXVvKqY1pa5kP3pTc80OUuTujgpoC/C0zkJVfXP78lyxNvvGoSO10SOQd44B8NDOjCHOKOZf6QSjEMycCaULLxdEBre51ajxULnxQmaoyFsN8Z18gkvCXEBZYHIlnBxjKi2EQjPeUIoht1ryPiUT2vxxqlNdvONfEXDRgEFVan/N686InyJ55Bh/eTu/HT3A+Ir8eOWMIMrt0dnKxyEoXO9VUDPCiT0SAV5A3btO6yP5AcgaSnqb3cKFCJfG4tynSPCNZFEGiSjLthpk0feCQWwhZPKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 08:22:34 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:22:34 +0000
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
Subject: [PATCH v8 net-next 00/15] Add preliminary NETC switch support for i.MX94
Date: Mon, 18 May 2026 16:24:51 +0800
Message-Id: <20260518082506.1318236-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: f7e8e5bc-1b1c-468e-e667-08deb4b69ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|921020|18002099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	zBJvU9npTtjF79fhlTH535n0NMZxjYmPq3rXqWoFfN+Klo0fBDIYGlVIh9DaeVCstdyvAYrkJizn0jy5Ae+q+1szGqT61WBE+qbmd6Y8+UbPHYpyDj/2QtZq1e3V+tV0UNUiGDBWGBtsVFeBG32iTN3SoFsqZI5A8VVBjb+6J3ci3i7vOigKvcloXeKplihSPlRK12jtL5XAPNsA2xyfwCRxDfzmmJwtCr0WWh/dEzZzgHecnIBJ9KfNWdhnxKKbf64Yyy7AV0UFNeLhzN4/QZLT1aeERSTNi9WsUo2lLkfbaywodORHJyB2MSf3Sn2NXVJWBVh+6yeYI73f0w8X90G81i8T5bAOFZ5jX7adVATfTVNLLCR5B+95WXnaJNgqrrYBgXLtRwIFMyHsv21RnkeYXJpnh6RkErMii5GSWKijOetDjfjFU8SrrYQNfFKpGQIAi0mquIa8gbmMKFi/mlCVn2Vh7O8ONdKftPz9PZc7+V4si0Fk4VzOk/OTRrLvmEX63lKrEd/sukYVlMcZp6ljUI0hTPi04LZ3cMvOE36bJcyG/B+x1sIOJAmO75xMJCM8hjlNX1eOIiOBsRyx7pjU9s6fXJ+YduJB5Qr0ZmA+dAp+Lo8si4ohijZBaKoXxefXrTjFnuxT9rIvH5J1V9o/76m9w3HrNwcVd6B4G7HWzR9BurCH+fAK7VZScMQdC6riIyqJaQI8hlQfdu2DnBltSyo7uLBGWPWE43Oe2qmEZdu7FoaOF0mvOWUrhAoOD+qPfWw9emLElc4xtNMbPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(921020)(18002099003)(56012099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bOn5R3UfBuyBlFur35aFvNSKX/4s6/KyywGHolrrIgrNhvP4KyNh1LNHfSyt?=
 =?us-ascii?Q?KYFnUdUCDWQOMYSzv8YLJn3cPWoIfC6OCcdwEpbA3zXkXKlCklKVAOWp/1iA?=
 =?us-ascii?Q?rSOL5+JkRMeAB3v1507rVT278iDj5Yh2by+08KCYJb5OGk7HMX3jbcYF+cuK?=
 =?us-ascii?Q?TPr13g20gzmAnThbYlIh4jPKUmlpa58EyXkZQdUmAutlB98oh2dWud+Iu7zm?=
 =?us-ascii?Q?lZOtsiz+CXFoMVj4nUdYregLCAqQm35eexSoUChijMeYp4CHjDgo6q8AqIFb?=
 =?us-ascii?Q?kT/eCdU47+HzMRjCna4Db2bFKignIxuNkC9hau82girueJ2rSDtbvQFyGuF3?=
 =?us-ascii?Q?ApZM5OKzL5ZGwaFNehW/DGQzj36Fpy80R4cq3ZNGc+NJgjx11xCEsuu2UcZK?=
 =?us-ascii?Q?uNIgdxiOKQi6dPvlAqK+srprLJZLzdXqBNi+wkBuuJNdhFlL4ihTIjBSK5sP?=
 =?us-ascii?Q?lu5U50hnMy1P0uOceCow/SuqZk8ftQVAD/VguGd5eoxHKhVSwSDDBg6U32dN?=
 =?us-ascii?Q?zE3H5TUDyiPKen1uHyct5DoWsUz8XYSxv7OTvcD5yVBD1yT+K7d+RLqBjKoH?=
 =?us-ascii?Q?mOwYgxkBXr7+e93XQW3FHn1HIngiCK4tBcIkHKU8iNcA53LejpHBdYe2OoEG?=
 =?us-ascii?Q?HZ6dqKgc4iLVhfq31odaEW6D3zqzEMX6Ldh7aIJ3Dz3bEQJEJvM2lUXQ7smP?=
 =?us-ascii?Q?cHe/L2eogywnVnxydVA1OxAQWUMoohEGhj3DqiXXDRvXlDW9WHIOkBalNwhk?=
 =?us-ascii?Q?b6/HZqO2iVFZUBj7HnV9WGTKa+YCuNavHSfOMr2ouwQTjdBHa0zyHgER7RSW?=
 =?us-ascii?Q?VmJosUeP3JKYqlF+1Yk5A7P2WICKzoCKyytlSEzP17jlbqhB6HIoUQhR7kyr?=
 =?us-ascii?Q?ndlR/1TVsHziRxXWUaKEs44NYe/oUoNug7Z7zHYuIU+j1FaumcGo55KOI4KK?=
 =?us-ascii?Q?JnV6sr2erCkzlB8gX2fMLcSdSr5VE38ZhDm/UdVGm1cOuKe8CcldQ1/XDwDd?=
 =?us-ascii?Q?/z/PwKXJYzXG68txwxjDkxm7C0KmNm2uqf3p2R7TtrR1Usrwm6cN2/PAguJ9?=
 =?us-ascii?Q?joZ/ewvkUqfPqGFBoklEGjsdIXQPxNUNz6ktAyAMqvYZzwlFEBvCnKRM/28f?=
 =?us-ascii?Q?b4ijUa6ir9Ob74P/TkdxaFUHM+SA3w1XEDntZNAa5qavSy7voqnDeVBJJ/3I?=
 =?us-ascii?Q?QsN17uqZTguILrZxuY6U6nl55FnAlJcLNpZ3RUJLO1jo+Kegglv3WFXrhAO5?=
 =?us-ascii?Q?H5l4DUfDzYRaopmBwfMHyoLvTjLCuZhgWPAn4GGbq5glAeAUpcEoLJQYfMGt?=
 =?us-ascii?Q?bHCN/80DkfInXKRSPTz7W5mrzJ9wtZRiMjdWpkW/nX7hpyQafJ62QJkdpoh2?=
 =?us-ascii?Q?95oP0y0vhw8S1Kppt9FndYzHR369YYn280NbLQWv5z1PUzi6MweL2RDousIA?=
 =?us-ascii?Q?vefi4W6pvItECWvBLFq+bKtTds75GC4BtNwbW8a+3fJWREpsYRY6ZOgs7P4i?=
 =?us-ascii?Q?6OLAzBg+f6iLWC7p6wlwCmp8aIjYjH/8b6rHfFzzCcUHWrnIo8nTEazq/1KC?=
 =?us-ascii?Q?sciG045hlIdgmjpwlFwgdumqOlFAMTMljZwhFJnEJLSJYyQzprzeJtz8Ttc7?=
 =?us-ascii?Q?pr992d2/ahHShnZnl75q9FqA+GEsdpHzpmodQdfre6pNLlkIetnNV5V7NLDQ?=
 =?us-ascii?Q?iRar7o1hSc3LdfzSOUov+GRMzwAUObSwDttJVG1YB3IkoOe8fwsMGMbW8EO2?=
 =?us-ascii?Q?XBqg7Dy/8w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e8e5bc-1b1c-468e-e667-08deb4b69ca3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:22:34.0891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiiVFywOLoM3ywpP1UWvgnI36ktg86hRuIZcm8jlHgasN7Ou7QCPzXzNy3NFn8ZQVCjt6kAOBO4ajm1yGHWBVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713

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
v8:
1. Remove the duplicated 'is' in the help text of NET_DSA_NETC_SWITCH
2. Replace num_fdb_gmac with htmcapr_num_words
3. Update NETC_PAUSE_THRESH and related thresholds of buffer pool entry
4. Remove the read-reset registers from netc_port_counters, and also
   update the commit message of patch 15
v7 link: https://lore.kernel.org/imx/20260513030454.1666570-1-wei.fang@nxp.com/
v6 link: https://lore.kernel.org/imx/20260509102954.4116624-1-wei.fang@nxp.com/
v5 link: https://lore.kernel.org/imx/20260430024945.3413973-1-wei.fang@nxp.com/
v4 link: https://lore.kernel.org/imx/20260331113025.1566878-1-wei.fang@nxp.com/
v3 link: https://lore.kernel.org/imx/20260326062917.3552334-1-wei.fang@nxp.com/
v2 link: https://lore.kernel.org/imx/20260323060752.1157031-1-wei.fang@nxp.com/
v1 link: https://lore.kernel.org/imx/20260316094152.1558671-1-wei.fang@nxp.com/
---

Wei Fang (15):
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
  net: dsa: netc: add FDB, STP, MTU, port setup and host flooding
    support
  net: dsa: netc: initialize buffer pool table and implement
    flow-control
  net: dsa: netc: add support for the standardized counters
  net: dsa: netc: add support for ethtool private statistics

 .../devicetree/bindings/net/dsa/dsa.yaml      |    6 +-
 .../bindings/net/dsa/nxp,netc-switch.yaml     |  131 ++
 MAINTAINERS                                   |   11 +
 drivers/net/dsa/Kconfig                       |    2 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/netc/Kconfig                  |   15 +
 drivers/net/dsa/netc/Makefile                 |    3 +
 drivers/net/dsa/netc/netc_ethtool.c           |  291 +++
 drivers/net/dsa/netc/netc_main.c              | 1585 +++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c          |   87 +
 drivers/net/dsa/netc/netc_switch.h            |  173 ++
 drivers/net/dsa/netc/netc_switch_hw.h         |  366 ++++
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  |  185 +-
 drivers/net/ethernet/freescale/enetc/ntmp.c   |  391 +++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  122 +-
 include/linux/dsa/tag_netc.h                  |   14 +
 include/linux/fsl/netc_global.h               |    6 +
 include/linux/fsl/ntmp.h                      |  186 +-
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |   10 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_netc.c                            |  214 +++
 23 files changed, 3773 insertions(+), 30 deletions(-)
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


