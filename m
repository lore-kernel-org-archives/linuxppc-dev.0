Return-Path: <linuxppc-dev+bounces-20801-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14085CD343F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:03:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdYx36TGz2xl0;
	Wed, 13 May 2026 13:03:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641381;
	cv=pass; b=dyUYzJMITOGGGMNLZCucEu7ue8FuIuS7hCVyFsEeUmF/NkqUPwbUelkudzLVCtNEWxpCRSFj/Lzxv5vJLipr6pIKA6eC/VZM8+q8viQqdHhmGqW/HyeFs7OOPvtAJFsd0xOkLdnuxhEvBtDG9X+A/foHLrGFyM0y1DGfedYILzOD0mE90dztzKEZ7oJatgPwC+K93lBvS+Soc5vwNGe7XEqet4s9PuRtlt5YnVz70aWvA+Ef2u1/Kcogrn6+P1sj+dLz/Rt8rzULK1n3L2emiHrpHeldyx6BKHpqgvQ7u+IAYjx1KeDPCJz87xbCyyawcPSksry83CP9f5G7N8rxtA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641381; c=relaxed/relaxed;
	bh=veWYb1lP61dcJgH7Bf49oCp88whn6TQDnYwM0FlrZD8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=clLCIZTuEQpu2GjI3C6YfZPuANbWzU9sPiIklM06sqoguiFqTdSy9MvMZupev+RoZXWzgmC8RzYgMId1spFXeAxPBN2MJgh0YXLWb9I58E5fWN36KPDgOuoa9vFUaNDbTdYhX/e4pkBS+hItcupSl0SoV1XNk3QW3d6nxHUzJoHZw2pLsrXJ/BdvDMCLSseKDxIlHGZf+4EFSOy6O4c3X/PyZz6m4QVBxflIoGAt9uEA1aS8cvfQs/Amdm6fQ6RcMiXmXBm7X/ImJ+1zzJ0qP8nh/n+R5LdROh1YFWyB0l1BfmiQuobrUeJgxolO+XyWmjkmOMpXUPb4KREkZr3uDw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=n69CHHwy; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=n69CHHwy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdYr2mGTz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:02:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VT153A1FO8vAeZgALYJ0Nz9PoE2/hlinCOdf5MnDt6vfcyqTf+SA5pnRjtCg1ABx8ShDW0FV6VeRj3tgKXP1Myw9SpiZsZwp8qJSkhcTNefd0jEcbHNtPTNkEt8KJ8UsNy/MaBNQmaNU+Y2xq8LqNZkrt5lhI5LyGwYama4EcacJSTGsym58KVw8zR4bFySkWiBveVO471GuYxGoCULLunSelr6IArs92xiYhEhSWDglN8GBmninP6pnwwmmU4fbJ1108gl0w9/CinHGphkv8oLUJKh+tK75QB5DB60WuakQdtqjpfiP8LglR9t2gsuPaKKXLkE6m2btcaAveADnrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veWYb1lP61dcJgH7Bf49oCp88whn6TQDnYwM0FlrZD8=;
 b=yR5vLFLLzAguCEGv0M7DNKQ2qeIf56NuGeFzUgrNvHEMxZMuVWgcGiN+ROtMHbK9F0UWN2hskOvwDCXKVbmjkEdwT1nUwaxxBUENR7u0LfmIg6arEpVaAfolmlgfSREWVrHocIUr+kBP0CuPLPY58WOu72vTxflsfR+RIxlExunLIqLf7G4N1iambwJSvPeYRrE1TVVtJvcY/hJM/nK0Y/M8kZr/5yVFdbpuMETEuYodqtfLNjdFRkFuSaAYxvE+4WQaqfAkhlvJaALJwL0XLe4m93ZyOQVid3cGig5nQNXyD0QGrwnnip+jaI5EcibPFbc+qL1U3o6y5DR43/vo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veWYb1lP61dcJgH7Bf49oCp88whn6TQDnYwM0FlrZD8=;
 b=n69CHHwyUVTxOEFaf4UY4u3RV/8D83fqGFER3hz2AqSRIm3EdlMm6XaK24DkDruh2HprWPxt/foTQ5C+6zew95A6YtAEEv4NgVewZdN1AgxwSZDx6HdkACi6+XLuEwN7qDlTpNte79wcEGTnk0YaNrVml1EVHDKPTtIz3Z2xpSXmVoZ+He3g+YaPzT6vOX0Lg6zrDN8rFh5d4Y+p8EcYjHt/aOtSnSdcf8znnw2/ZfCBJ8rhz2kMYB+BNgPzUS3UJI41RQXpfCK/coRYNcD1fk45tCLhGfjgX7VZgy/VWMWg6QDNb5vq/GhrDHl2gefVxzhUrQarAKL05PBwE1gNnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:02:26 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:02:26 +0000
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
Subject: [PATCH v7 net-next 00/15] Add preliminary NETC switch support for i.MX94
Date: Wed, 13 May 2026 11:04:39 +0800
Message-Id: <20260513030454.1666570-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GV1PR04MB11525:EE_
X-MS-Office365-Filtering-Correlation-Id: d7215169-9a67-41be-393b-08deb09c101b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|3023799003|11063799003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	VGbWs/A0cjCJ3IM00U21AwFlPX0kFCusvRLeVI6pIcmvioZinzFkF/TWY4Tus8pxWjc/u5Tb2QEpeWL/bS+QLc9oDC70Yykct5ZEW4Y1aQgfI+OIDax43eSOCjWSIUAY7j5n5tYGFqId59OZ2qGSGLJEZwdIOZ6FxgXvj+VxqSBrv8VoR8eznPwQXHYm+Whu2u/7Cw61bCTKpHO7NteMNH34GSfv6y9KtKvYwz8iSM8Ooawsm8DE4PrJJGcA/VijLUz+Sq01eJ2n5PgC2PRvv27FFKaKUrZEZxmoFBOmkaaqZF47RQzNftMihxpMzuPuODRJJCu0HmdstC6wCKdQBAi3d3zpeOIfJ2Ms4M9kGoKIFvDJiIBsCuksKNKjCI4mzz60EI1HxV26/TMAGkTrDHIdqD5V5H8mxYUjvRIy/ZACn9uRYcbw8+4eKQDpcqct9BL54wafoesuJGv4OJ3NK6oKMR6KJC8wTBMe8Wg9dygnqlLPcvmMxtNzqu22sxI50/Wh4Gb7lJLtJtOl1lnFRWNk9uhtDNOSwYHONg7Ab5ftQL/1qb6oD2Lt/zzviMYK3SCdBmK6hJo8bSZYFji7/59TJEWUmSOUDUnU0I25fhXGkZ3787PoU4y8ot4P4emst/enz5CHLAG22dZr2JGkBqhGVZ85tkczgf6UIQSx0Ftsd1jmqyEuJqzhOiRYeMeBeg71c0+5PT83JAMSNZioPhtLFjSa9LvjbOmUODTKuES1H78gzZN94LnkEJT20PNdAPL47FQIkT6gJq3D+PLoYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(3023799003)(11063799003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ecrLzwi6rYmANrqncsZPdBsEf8ReTqkpCuZR0wBnZZ602oV9Bq3Seg1L8J35?=
 =?us-ascii?Q?VQXyWeWV967y15AGyVw2V/MhETeZQBr5WVcWYh28jd05QjqB1LPWfnrmjWp2?=
 =?us-ascii?Q?PyyHy2ohJuOHII6zHGcYmw0Z89eOMMeZkcY9OgqDCWeD0ZGpPL1qD5Q5iFxv?=
 =?us-ascii?Q?hYnxLK7MloDL/yQM38h/IxRX7tGGULdtyN41uQCmTjwdqtNKPt/Dw6O6mB8g?=
 =?us-ascii?Q?RV//zQnl4fhWl4vkShysNvin4jGb0pr9ndRPtEa9uwwguJaGLYWpasKl9ZyL?=
 =?us-ascii?Q?zZTNgwIO5rXVXVfuYx+FnM4e4FM4Vxa1TlYX1zct8qXyYtROYaB6eBnjpE9n?=
 =?us-ascii?Q?Pe12pGC3pfTk2jhu2n7qh6kHwYrOWHvB6aH4dGgHHpcEAwBu79B/C3i2sRc0?=
 =?us-ascii?Q?+MiFbKRRprpZWB3l/SiHQ4/DpZn7miHtrUF089W0jTjpLzS6gnmofsI07eyd?=
 =?us-ascii?Q?8Z3wXHSeMFksXaHrJqAUO2YTGcNMk84YgsTSRXIR58+V7M8R1R6+QobHup6w?=
 =?us-ascii?Q?s/bzN4VQ6meYLrGBEpfcHolAm+Lk54l8uDWXYoteAIXlMVjImdVE32EV/YFS?=
 =?us-ascii?Q?dZ89zuO/Rr8fxRxbgtNof1MaMFAdOmQJuAuIhtRYEH/IYL0lf1+SV3gy7XWY?=
 =?us-ascii?Q?oH5SLsIJLGJAW7gI1bO7uD+9gvwsBG9Y0zFKfTLFdXQfRWXu9poIL0zGejia?=
 =?us-ascii?Q?qrg9XYIbCfhsEiEquxy3VHE0hWTQrS0VEHDDbCxypdueDoFFymozFdAKkI7C?=
 =?us-ascii?Q?B1Lo2z9f2bvVcRpKliE7IBY+wCtmCN2dg/xfv2BbpKfbG1qNPHKp28Kvh8C3?=
 =?us-ascii?Q?FhJDhJ9Zvl2M/bebDDXGd9eA3QunbZ/PFgkWXRQDvOtXKwkHXSK98EGRtfsN?=
 =?us-ascii?Q?wxatWBofEEkJtzMKXb1/1XpOaCcJQACX734ZGK7ZFCKMLl0rK+7G/unJehDs?=
 =?us-ascii?Q?Srp0yGMdbbPagX5S9XKxwK+qL2hjcZ+Ceqts/Sco9x0j5+1lLPdLwDD/TXJ3?=
 =?us-ascii?Q?jYHfpZhOL+mtxbQX2BOXdk5eE8eGAPZCLLxE1ZyCtEdekeeuDLydzr7FgibD?=
 =?us-ascii?Q?wMVVuYB1Ubojums87dfMKt0UUIMCm8O5bMfKy1RDWDnWZ8NnjY7GRtQ6bZbn?=
 =?us-ascii?Q?A/Y/d4Sz5hYymEGV6QQ5vvg1ijP+E/X+wUZdSE2Afv9+wMo+we1Sk40ZUxdQ?=
 =?us-ascii?Q?JIFcMZVIUC+fx0kv+RrAhM0EOl/VGXY4oW2iZx+JxhyrKAm+LDtXqQi2TtCv?=
 =?us-ascii?Q?adY+deTdKt14lkWaMg4C3iRzqQPfZwit2Afdziy/GErNB7JhswEQ6XpsyyIR?=
 =?us-ascii?Q?p2kq98N/F2DEDWUJGjeRz9lEh1CHkkaxo442E/Fx82LKUx93wc2WwiT+aWfY?=
 =?us-ascii?Q?ixfwLQXfzuhGuL7JuqZsFeE3/KLmKii/4Pev4Mmfak4Tmvz4qDeyXLJ5euny?=
 =?us-ascii?Q?fvb0KeNVy80cx4u1pUHcVAcq42aQBMTsU0mARSXPQfYuJfOkgAshRPJdUJg2?=
 =?us-ascii?Q?YL8AAzt5osYpmVOQV0bazHDVR1aT5SsRn9p7D7YR9nywQPmS5OL83ggdpQEx?=
 =?us-ascii?Q?TpfdYzMUA84+YtRgNFmIk6RyGaEnintw1dym7bav/Bi/k718YgvYtaP/X5xV?=
 =?us-ascii?Q?6/pLU+kL/6Z7RN6IXu1AAyfe0aDdvy3Rpeuw7kex53xxUg6hNf5StEXBPglZ?=
 =?us-ascii?Q?xsSGP2PEW26l9mjI3re4sIMyWoivGOCkBb+eg7+G39RveC5G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7215169-9a67-41be-393b-08deb09c101b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:02:26.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDF6UJxfWyFlBcN/jsLASOh/Hi9NIXKHRTJHLb1E2kB68WB6tyo34eun7HugltI2b6+rKgMFGA59AaVgyQPidA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525

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
v7:
1. Add items to dsa'member property
2. Refine netc_rcv() and netc_get_rx_tag_len()
3. Add "depends on ARM64 || COMPILE_TEST" to config NET_DSA_NETC_SWITCH
4. Add addr check in netc_port_set_fdb_entry()
5. Add more comments to avoid false positives from sashiko
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
 drivers/net/dsa/netc/netc_ethtool.c           |  297 +++
 drivers/net/dsa/netc/netc_main.c              | 1585 +++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c          |   87 +
 drivers/net/dsa/netc/netc_switch.h            |  173 ++
 drivers/net/dsa/netc/netc_switch_hw.h         |  361 ++++
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  |  185 +-
 drivers/net/ethernet/freescale/enetc/ntmp.c   |  391 +++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  122 +-
 include/linux/dsa/tag_netc.h                  |   14 +
 include/linux/fsl/netc_global.h               |    6 +
 include/linux/fsl/ntmp.h                      |  187 +-
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |   10 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_netc.c                            |  214 +++
 23 files changed, 3775 insertions(+), 30 deletions(-)
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


