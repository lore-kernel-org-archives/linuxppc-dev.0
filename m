Return-Path: <linuxppc-dev+bounces-20633-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C933CD37B2
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 10:28:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCMdT0gJBz2xqv;
	Sat, 09 May 2026 20:28:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778322493;
	cv=pass; b=HMZIo644F5HKUn2GAjJ1g7W3Ow8955MU5cmZgB7IDwNJP0HWmf3w893YDnGBToU9qTRs8aa9s3DQn6sBqFmjxxYV5grRlzEfydUJdRlQUYu3hnbqVxvnM1CTS1Fr8QmCNb58ByiD6pw/0c9bQIRh257pWFYXZlAONtXj4cshZT6eQm4ek8Ccad63G2mFAPZT3yWtJBMXMaR9Z+1KxYOW+lTe5UaiKi4v5Xuky8KlJMiWIiPLfXGYQghC3Y5YheKaRiIP/W43dfzPRrO6a1VeCKumfDrNCY93l/3YybkqnJKALMWIzKe1nmLpRyt9IdZdu3mDeUESmF2TArQBYZ/B7g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778322493; c=relaxed/relaxed;
	bh=kE3Wr3Q2BKRWH4rWqJ+I4SkacaFTBbusLh3i8EIa0aU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N6vrSqsth7fBfNZOeCt/1FAUF22F2YTA1AhYiSzqOfiAxQD2DT2DCFBIj2DLThTkDJEs2xxF5AZb9Ij1+dhEzBfVCwY6AM+503Rwx5Ke/cX5AM0PUEifTYNpZDkn0sAYjK6V3kO+/3kgcC8p9VOCXI5B45gmwVqYJKe6jKN4r3hpVPF1gUBpUqIF0FTrfE4jPB/fqQ9Eb0Dp3NlKlQZJqjCW9qRk6kEer8v9SpgOs9xbgO539DNr8+U/Hj6Clx6XUjfHPN9Tam+jbCVnHXSE2y7mtY1kD8KgQO9U1T3OFFOwdVU5ksnXtQ9RJiLzkl8E+mR7oajWOEq30VpKN9Mutw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=iUJMM2pO; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=iUJMM2pO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCMdQ1Fmyz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 20:28:09 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GG1e3ScEDgvFR96gX7ujXGP2eAkrwA6R7Nr+SrYuXwYfGtH4D5QD3JMoIPQZsDgkxWMnpgHD6S77Tw+1f54Gb49/tDb3d0PahuDzEmhK8axboqdDsubgJvPwMR7NVAWkKi9bxZ6jfm89WacUxOE5FngtBe86h5LQ+Dh7X4tKMNcW3LWYfTVGUomHW28TaJBjC2FFCxgpUmomRHYC+o3YBbmXnOGYj1rifx7vK84NuII4wzcb+JM8W9VXTprfq5aHN7Na7BwYlAPtmb1GrRoozSzJOf1EqDnbaT5a87BX1Yala1qyB7IMlcawlIhxXTjRBxU0qjQ4lWBjQ9o9h9hT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kE3Wr3Q2BKRWH4rWqJ+I4SkacaFTBbusLh3i8EIa0aU=;
 b=r/OzFm8SaXL9C5n65Q0fEqAYG51R1kS/yAWW1V23ixR/8CmTXOqCu/VsjyU91hOAyQUk1HQ6MMx06JI1RhY4xHPQghfngb/SVavC4Htgc0fkME+Aur4OIu9urBrKjAldvhBq1XuQFG7UTaGuUBOYNJeccvSf27JpuGPP63kqYfJkr/KVQmTWmxmQixs6Rg/mf2f+3J3Z6jU9nn2RLnCHqFT/saWno3AmJOabA34xkofXzUHI8YaDUdyEDwmIyLO+r/5oxe2jpZnLd0ysFMgQk0FxGGHQuXkcv2+zQe3g2bbB34eTfgYaq1hgwhZAs6PaxgR82MPOngNSUpQrMc1xrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kE3Wr3Q2BKRWH4rWqJ+I4SkacaFTBbusLh3i8EIa0aU=;
 b=iUJMM2pOu7wKVDvHBy0VYmCExR10FZg+9mRGWUgFwPyyuYCd6/9vQvhBsT7sdX3FuG1TdD1LqiakDIS5QuowDAm+Mm4ZpscSHm7V3qrMFjFmH63Ek9cUFIeEcfJQ37I7JA8Kk6FO3Fjh82l1UbwAvdbqE0Z3JTm+SZfky+rqF30alZVwqVvOyzt3c4BnBVgfSZuBbRQZQO2XRwszMhV5dYSrpsnIIQpUPKjIsJKwp6vvgLQOy3hN8UcnjfxTz4KdnnMOtOXmQNT7qXyTzuD1oS0o7BRTJz/zx7Bluj52Qy+NzDTjk1RUgrYPgmQyBH3HhuzqE2UE516i0xwckAMOJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 10:27:41 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:27:41 +0000
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
Subject: [PATCH v6 net-next 00/15] Add preliminary NETC switch support for i.MX94
Date: Sat,  9 May 2026 18:29:39 +0800
Message-Id: <20260509102954.4116624-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DBBPR04MB7500.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA1PR04MB10604:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df4fcb3-55fe-4db1-a501-08deadb59964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|18002099003|38350700014|921020|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	bkM2pfREo70MJ5FjOLGpKqnoBKOgj5rUanJNbohrJAlLMf3SU+WU9iIEG4QNPtKwL7Vj/qW6CIYOLRNEbx+tqCPEf2XS8i1BaboS2Z3Nq0NhUzH+f9oesudowiMfxQZK6RyV1Tt5z7Z6tu/xrJi28TIXa8B2LAmfuKY8Q+3n2vQN1egu2pQxvWCB8y1InaUKjXnDH1QBwaQCEh5DZP6j6ZWPkncqLsIR6TwWk9T3svF1mby/EaRTYTi5abU5u6l8m4HA/XGLQ6/Y2TnrEV2dFIsVBbIGxk0PDiw2xShz6nx2e4t4X1+tSnlJ1CMK3bQS0pu0VMwaNsL/ZvE5XEyKfQAeC33mZvbfLj5u+qiIIxuPiiGNUth6uHlAya+M/VJFHsqPqtqYdjS293tFKEy7GgKIKC6mnGe0E1+eAsISXvPZabwpz5MrXqPwZv4A8u/GD0GolWULzDacsHoNKXVhGJRmqExkG3afDe12UpLp7iopLzRAtUviRs/KrvLEKnpYgWxryA5FRlUZs1EajiSIl+pVo6cVQc7n8chznFACkVawfYqouEsTZaMdD3qX5iGryGQ0UB1oKTS70JChjh5n78AHILfD9T9s4xk9yE6iqSODqJgo9w/ANdkMqAl9v7JcL7x4ohuooiAd08pA4fhutC1z6avfTq9yHsCMu/xE5tnT7VVLNE8WS1Cqp6l1egQzV5TVA09KXDtQutsXGck2YGQWLgb6hSEsxS4A/MproijSZ22BEeQkNnfKbmyRyL101eZAlrCT21g6IcXBygpUHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(18002099003)(38350700014)(921020)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RtZS0c/5NblsOVBUBThivVLwLzoBeF01nWpe0ll26cRcSb8vxG2RoxBpAptZ?=
 =?us-ascii?Q?EOeCO6oMxftzmwlRf3mrUEgnFgSG9LP7YooYm2bo4kwI5zVGDdTiituNLyYA?=
 =?us-ascii?Q?vfV+3h/KvpzqNxpCCM9QW9APD7ThX563Mr0WiFMtkJNjy/+AcSiR86wfwKu5?=
 =?us-ascii?Q?BE/ZQC+7Hq9aOxMQs2z/YiSw+NxO0pUISeJhQAeiTrqp16YNRiAb5iuiYbb8?=
 =?us-ascii?Q?RbyI29vS/nkKG95Evemmqgd5ls3Ma37YMqcs05r6nNeRxHku3K8njUR19WQp?=
 =?us-ascii?Q?GBOG2Kr5S96BAZsRAsHX1Vw04AmdinSdMwqmfEiOdooJc/CmMXOiLrTHvqeO?=
 =?us-ascii?Q?njuytul5ULDQu7au0RSvXI8/AOaNxTYAE/9/yr8eSWWnueHjYuutUOgTIXQH?=
 =?us-ascii?Q?aa54cJLH9LuI9P6kLR+FjF6qxnV6dwLupj/hROUg1S71wJtToISD2V9IqRlx?=
 =?us-ascii?Q?8/282i6LXhyKFimjjZZlWWtD0Xxw8ISi91p9S8bMIPq0mx3qpa4VMWfakWSH?=
 =?us-ascii?Q?Y8CTTlKHuW3FQH/zyde/07E0+h2cd6dwnTJK7J73cy+J2sZwEeQ6gvVBNiFd?=
 =?us-ascii?Q?m7RH/ymMwP/pxxbfBpHx5X7NUAuXQSaVpiSHfPTPzv46aFxVEETjINQMYR1r?=
 =?us-ascii?Q?gvZg0kcwOPg5QQcKPjr3PCiDhFVgtML+yxnYskliR+ZRBmHqz6mn9kvG+JeE?=
 =?us-ascii?Q?0+hcpQUiCl15TmHmV0rHaPie09s0LNP5NJMHz0MqGXxOb9v1GnqgZxSZFpEg?=
 =?us-ascii?Q?9qzv1q7a6nm9wWIKWEB0yHDlrCiu1etAKCEU32eBqa93ULb6FdhGHse7pxc/?=
 =?us-ascii?Q?0KeBCLG0nkbtjUAKKwvghTR9Ih7be2DUHbh7HxlEJ6xIS4rDS7QNT2gkPJKB?=
 =?us-ascii?Q?Omv1hej6b/P5qBl17PMcmdD2EBjVcuZT50OobyRc3SSCEuclFnTV2tR5ogOL?=
 =?us-ascii?Q?dfUVqvzItxYsqTF/3LOPXEDt621Veuo4n8cEV+7BQcCv+HTm3hNr8KYIHlY1?=
 =?us-ascii?Q?GuIvDGMPQogYzXU//l04R89F37ydV+P+bPtQF0XRH13GaQP8ZN9ipyNGewI7?=
 =?us-ascii?Q?k73ae0IeumbsLpIp4DgLozbBm/u15dMYiABybIQkO1wr43VN3Zjxd/7oDUuK?=
 =?us-ascii?Q?0Bf5w9h6MvBjafV3XDMfg9M06KLGq6IwvT09i+fd6GK6kmPA3rrbrJeXAGbq?=
 =?us-ascii?Q?VWdU1/kBU1GONYmI4VVQSexIL+6nQbooFtBM3GvW/bpcSVnyQwMVG6x13qI1?=
 =?us-ascii?Q?MS79QK7bwDzc0AapQCywDaISuLlu7mgYphy3wxiz3x0Dr2IwTT6ZBNsR8lYn?=
 =?us-ascii?Q?KigNUubN3OB2DA3jQBucKdvNkUYtVHDgkp6pmw5sG/aQWZcis6lkyhGNQxng?=
 =?us-ascii?Q?W+qfEMYfH53Rzjo2G12MKrqtY6If8ylqSxe3/0V8S+ceyHVf8ihBtGxSwClj?=
 =?us-ascii?Q?GKOUOyApbyM9BWIDEHw8PpTd08ISPMKSVYj+ko8PnttFYKOhAy7O+mfk+NFM?=
 =?us-ascii?Q?mIznmVHMtQtlzbF9b2KGzqseq5M8ZvdaDuJBn7bhv+V2QZ9bQw9t5csTpyKI?=
 =?us-ascii?Q?PUgoLx8bGzLyaunJnCHnWSa3Beg/e/PcKzt+rTYFEPdNTMu2UMZHZujniY8K?=
 =?us-ascii?Q?Q+YJvDbzrcRnullVzqxS6u7N6V9SJlQoi1qmoDY/XgZlMjyOU5lOwG6cJ20j?=
 =?us-ascii?Q?b+oNmooZukWoIO+ZYjSeqOVO2DoGJu2kDTWtMZBWda3JWCEsgE/6sbobLFy5?=
 =?us-ascii?Q?qGRPiCkhpA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df4fcb3-55fe-4db1-a501-08deadb59964
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:27:40.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1JkvF+A6HtRy8jIyKF1r/Wf1wo2FSLctGzK+zInlV3ZXWrLsLZmvbHyi504tDerKn8Swkn6N1VJN2gKSzBlwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604

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
v6:
1. Use FIELD_GET() to get switch tag type
2. Add PCI BAR length check in netc_switch_pci_init()
3. Remove CPU port check from netc_port_change_mtu()
4. Move netc_port_get_info_from_dt() from patch 10 to patch 12
5. Update the comment for NTMP_QA_ENTRY_ID
6. Collect Reviewed-by tags
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
 .../bindings/net/dsa/nxp,netc-switch.yaml     |  127 ++
 MAINTAINERS                                   |   11 +
 drivers/net/dsa/Kconfig                       |    2 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/netc/Kconfig                  |   14 +
 drivers/net/dsa/netc/Makefile                 |    3 +
 drivers/net/dsa/netc/netc_ethtool.c           |  297 ++++
 drivers/net/dsa/netc/netc_main.c              | 1561 +++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c          |   87 +
 drivers/net/dsa/netc/netc_switch.h            |  173 ++
 drivers/net/dsa/netc/netc_switch_hw.h         |  361 ++++
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  |  185 +-
 drivers/net/ethernet/freescale/enetc/ntmp.c   |  383 +++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  122 +-
 include/linux/dsa/tag_netc.h                  |   14 +
 include/linux/fsl/netc_global.h               |    6 +
 include/linux/fsl/ntmp.h                      |  187 +-
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |   10 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_netc.c                            |  193 ++
 23 files changed, 3717 insertions(+), 30 deletions(-)
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


