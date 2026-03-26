Return-Path: <linuxppc-dev+bounces-18795-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5A3109E54B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 06:27:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDNM1bLFz2xlM;
	Thu, 26 Mar 2026 17:27:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774506467;
	cv=pass; b=FrTbWLhbhMIyah9NXx5zFr/vQWWmHuKm3kgdU8mgoHGrsQV9+3KzTG3axMvQi5RSZCfoNbngIwq1Nt4QWT1cgKMrtzQ3Gnkus6qINzdZF1hS62KTB8+4cHv9Fui+yq0BwqSsIwzVxKrwbQ0yNjaobc6A4NGrj3SC6n03QxDaxBVbOrPF7IW/ZJCITOdIcY/D+nq2V8UHonzTG1T/vL0OsBvHj08FZy8SaIVjMkeeO8LfwAKPcXif7Q9YS0jsAoNaGB6DEc1ftL+yTLzO5TOg0qaPvOsvMDMVK2v+0Y1VaqagKr3rb2U9n7llqegjk7Kjt+/YECdNkQ+pUTXyyyCxow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774506467; c=relaxed/relaxed;
	bh=0/Ig6QHm6f+vAuUX+t5kRLquc9gxss9/tlRHXXrTG5k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gnWXQ9RwSSNkpkdTTuQcF67QiSw3T+njN2X3Bavm4varrS/4S+XX/ctR+3GDGL6MxLkQHqdlZDMX6v391f3/KnJ8mCEepTVAJpXvfiumvnT/L5xaUk1eD09Sc+CCOWEukt5OKuV5/qLRr7jExBcOxUdcX/uy081z5IE4fG39DlXIks1y7vXHOa1cvtSoUUTtzdO1HowXvkEC7h/toEyuEKFYBEuRPKRI3eaqyAnosgLm8Xjy5Y03xwgegq1VZOr5PhRtAcYHjMjiDYxWkZp+VnTWYb+ipfEGGhAZJccZx+ZhAevCbDDFIpW7iXmX4yi6SbT07SoLuC2uce2jcyCu5g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EYxkafqC; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EYxkafqC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDNK3l2Fz2xd6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 17:27:45 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exyGiZWhw19WdOG2ya+sBjGf+ArubCdqFChAC73JjlpatZZzCRVp+j7/DDvGv0e8kBSx5/M4R8d9TVmQPuk4fyZORbdh6yUVgX5+YafMSTfkBxnhyye2g9GTMYEt8EDj/F7zm4O3rkefVrDGR79YNWhgC2JmbXxUJk8ENRaBeEakRhaOELwDOB1i3s0CzUOExxcK5vdYyY0o5UA7VhH4/UsaEMr5s+WgznOcKiU189WWv3YNRN3yCpSUTi3aYZsq0bKiw3hHIv2pfW9Vn5piOYcGxFR/wZl0QO8NfOyR5EU7hxJ2LktCgo5KvwnT8nmWj89V/t7wuohwC73t/lGWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/Ig6QHm6f+vAuUX+t5kRLquc9gxss9/tlRHXXrTG5k=;
 b=yyc6HLeSUPtOCTZSDP7BaBnOcu/ytC5R6Ox5EBlaXOeqe5kPjPJJYsiqHqJq+CUwU4E8A9SKd+5/yg+6U585DNC4RVMCEQRpqss7kMJ0fmHB+MXZeWXTv34pmNUzPkGsjvZ/YM4bG+DoMzOvSVs1rGwsC84rxhxhwYsDHT3hBS7IKrzqqmjNMXIj08TpuWensI4EOBmpVOAUQbuAnIct2zoK/c/JqUEPEXE2ePeEwm0j9QpoGmq4U2K452Ajbu//XQYM332AWn7uM9UkRJCv0qu9u6xu1ohXBLle+fHyWo0OBAMBtMyDyX/8h/mnhflwS3V4sKdLdnkgM/T1Hgzr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/Ig6QHm6f+vAuUX+t5kRLquc9gxss9/tlRHXXrTG5k=;
 b=EYxkafqChvRnfAmqIdw2jylgU7zsI1vVWCzZn53ZOLMYsCWFub9wJVKOxMLQ56EqJJCeHj0iOaC3InwdfDg0UnRIPjlAm3SjabumGBXhi03vSFyg5PMZBJqFWB8+zhReup3I/sJYmiKiJ0LpE1kS+Gv+xnRgnlJAv7S53scHuG2Uw7GhUHkQjGquZ48qjZzEW6C4Q8FxHjgm9TuW7lFAaB0moOTYcBy7sEt39AvcpC9sdY9B5PfYUUwpEPAxHz7m/6VUiz7qO0Zb/MUx6CKNAVYrYkmk8/02XdAQsYMku+tM7TclKAhGzdxH73NKXVNxm4Bw1ib1KigJYPfn2hhIpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10309.eurprd04.prod.outlook.com (2603:10a6:102:41f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 06:27:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:27:21 +0000
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
Subject: [PATCH v3 net-next 00/14] Add preliminary NETC switch support for i.MX94
Date: Thu, 26 Mar 2026 14:29:03 +0800
Message-Id: <20260326062917.3552334-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10309:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4b04c3-2c56-4135-1ba9-08de8b00bbf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|52116014|921020|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	n/IbjOXh/hvAVBW488W2FliTqx22f71NwkVYt/9cBjsMFLqE5qeA8IfrXGLj7SPNSOaprvk5LYlmtJcODrir/y7eHDlzltN4VYVt/MK5M3wbcswsZYWuNVzcuTT3koccC7mmRvwMSbTtcTANDRMfFISR0USoU00pv95S50h8wA6xF6lKoMPDc1aiMIO2pRVKc2CjxHEtrkcO03cZAoBbli4VmY2y47g4GrpBRck1e2bGT5wVGyd4iV2gyel68eidt+vQUc+J/zPTbcJLUgKvOr2y14iS40GQanJbvEK9SlBBgtj05Xqc95UUo6yKlwgH752vNTO09puR65owQuiUr/HFv7kO2L3xvED5QbzCu0SsZuoSSEgrzsvlaosnZjhMtxb5AxMIfpbzTKZW83EDDDa5IYoRxCogtUVgTD9ZgXLcmyAAZCZ2mRwGkwulZTvkyzFxwfyu5wmXuoWQvCgyCMSH6lwUblNu+9g+R2hHw7DurEPrdu56zpfkKaNKOOKDW2qQWLdHNBIIJOYDUvJDBxKkxsybGL4ln0an56EUxYAG/YpupyZvMqoIvpC/Oyv4HfAxtFOhMdIDyFe1BTWeXy3I/CD85c5G2jrSqFHh3021NfPoBWGdMshUD5/wVxgzZ8FAeHkYSsmUpLDsAR4Uw9uyktN9IgfwcC2zwGgyaBcyX2Dual94Txnc1xi7Ry8tco0F0VQcgz+BENPYtz7yXvA7bJmYTzoD2JkvufgU7xeAtioih2E0QnSJhyVjVJmvNSAirJllPK6n5r1bWT9e+uFErBmb4REUp9uGmmcld7C4TzgatnmAziQkskh/QCSx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(52116014)(921020)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3+4ddGcUU/vzWpyHkzCUi1tuU/92tmICIq+NxtpJqXNHVNJIcuAoDkDHBevq?=
 =?us-ascii?Q?A9kXk8oAw6lbxG+ZlQd33y/yuUulpKkzldsD66wSB+NiAJ0k4rQj3Xz7KV/K?=
 =?us-ascii?Q?/qittqKB97oQg7QG/Vw5AcPBdoBcztZumjeVvIPTBJRAvZpBAbIJJ2Zjykcy?=
 =?us-ascii?Q?YYM4olR0mpdCtBEdwHRZePKDOU+WPG8JAAFxH5ue8xPGGyYHWjZINEuqxmPQ?=
 =?us-ascii?Q?fyFNYHAco3J103agIs7cJjYi7VBEzmW0qhxNN5W8Zy1S8FE35IKL+gWBccd+?=
 =?us-ascii?Q?RTWXMbnaiVLIx154xE5xKwrudlTVpQ7c8H+tRgrdMYmVgEuNGeak+ARMKcds?=
 =?us-ascii?Q?s/EK9BQbJaJyFJ42rMkqEgNx393t3H137/qn7FpdGMk3+6521cI87f3Iqb/3?=
 =?us-ascii?Q?TA4KDhGT7kLezgG5MujPUGvQEuPRaJlO/CJZliBndTLP58UukHH27kD1MqUc?=
 =?us-ascii?Q?XOySH2pQs3I2AL1U3mwHMqtut8qFRu6Iz7pIdA2wd23hQKZzNb+fJ4xpA/Ot?=
 =?us-ascii?Q?q5K9ca11w/eECblxqoEpr2hYe03lxln0fFsCvKcpSVbzWz/BFZXZng3rpwwB?=
 =?us-ascii?Q?XJ0NTh7H3TrPwMpUbJOlboOIyw1Kkyr3nqw6gzhehvn4wvuXDnt6lSeeOM6N?=
 =?us-ascii?Q?mkMvKL5UHfHe+YAApPiZnnbvBF7OZOCegm82YOATH17sBxdW0kGLnqDfdj2A?=
 =?us-ascii?Q?Vpr2ladmiDDXwW8tUIbcRkk03iHisC016r54JILXf/+DmxhbaKkRy9pSNDd/?=
 =?us-ascii?Q?uPWAVomsiRvwucRdyy5xu4NLG+8xkKQF0uW1Z+ZgusM5V+CA/9LaNb1ld88W?=
 =?us-ascii?Q?pGVh/EeKpQ+hkEjAMapJWzwggoUzz8x1OVmT6kxrMHImKj1IT7+MbuQBKzNW?=
 =?us-ascii?Q?STA7Shl39neeKWketMIJq2DgaviqcfK8MYs+a+jZ4LPtTLWFOjecbRyhrfyD?=
 =?us-ascii?Q?6WkrcTxJuVnlpCFqZNCqockE0Gvg011jar4R1cJLRiMU/4XmvHusZBfqybBL?=
 =?us-ascii?Q?UCLW2K7cx2152ta1O00ImpQ64y7KPDXFnjZfQ5lbS+wOLFQKHjPMTeDuwPA5?=
 =?us-ascii?Q?dRRJwVs4xLvsDJ5oxk5FK2C/3eZsgvEJBqMjnkbjBZoMtPv4EBYquyt5uWOF?=
 =?us-ascii?Q?HYm0Om7EZIozaTH7RGRvXNLqXXLh9gCL1i7fg2CTLh/a6NZw39r+tFvx+QDi?=
 =?us-ascii?Q?1p89NGIAVRbMSZwTJcZQU1BzWVHrTqH51wtija1JaqbDK4jzeiI1ZA1oQtuE?=
 =?us-ascii?Q?eMxPGuz143+bnAM0yVi43vHr/CuuZcy9QRGCdt3ngKjTMvzHHRlZZGY0UIZT?=
 =?us-ascii?Q?MBbK2Pmgd5Ru4R3Zte0bkVWXOJJiQmnban8f/LiWB4RzzKlHlJYnLKbh96G0?=
 =?us-ascii?Q?2I80HF9ImE1O0YTbBTxTRbGBmadtt6p/Io+QPz+xuQR7bzxxU3qvRPqG85Jp?=
 =?us-ascii?Q?iRW8ReJvK5s4ImHuBbtgY3ji4fRirfkSy3sIlPGAQGDyl5lOdtZkuKVExS4T?=
 =?us-ascii?Q?x7Vg9PHXLVasSMTee4SS6N9gn0fG42/V9zSBcH803ejTw3afyAzYa9ggpvbB?=
 =?us-ascii?Q?J6ud3mWWb/5k7ntax3qaV8wI5GFUETKuxbig5P39Te2HOKBQwJnxLkjKqapN?=
 =?us-ascii?Q?jaklgLCzQnnStrn7qcBqfbfx398mTCrgTiCpYva3+BgplzoXzAX8Po8OEnvb?=
 =?us-ascii?Q?UBOBVpfUtfK2tAdOlcQNrZ6N3LlE0JOGYKNlwg8wRn9NOa9C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4b04c3-2c56-4135-1ba9-08de8b00bbf0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:27:21.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92Epaf3YVdyUvXVmfllqh2cEgjsRmAvXn1bWHTP/2NRUY5n3OrS490QPpV/1dPvBknbYHP3rZDRKgY8HIPZ4Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10309

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
v3:
1. Improve the description of 'dsa,member' property in patch 2.
2. Remove netc_select_cbdr() and use spin_trylock_bh() instead.
3. Use pskb_may_pull() in netc_rcv().
4. Remove phylink_autoneg_inband() from netc_main.c
5. Remove netc_port_set_hd_flow_control() from netc_main.c.
6. Impove netc_mac_link_up(), remove unnecessary code from it.
7. Restore cfge if ntmp_bpt_update_entry() returns an error in
netc_port_set_tx_pause().
8. Improve netc_ipv_to_buffer_pool_mapping().
v2 link: https://lore.kernel.org/imx/20260323060752.1157031-1-wei.fang@nxp.com/
v2:
1. Use raw_smp_processor_id() in netc_select_cbdr() instead of
smp_processor_id().
2. Remove netc_port_free_mdio_bus() and netc_free_mdio_bus().
3. Correct the mask value in netc_port_set_mac_mode()
4. Rename net_port_set_rmii_mii_mac() to netc_port_set_rmii_mii_mac().
5. Check the return value of ntmp_bpt_update_entry() in
netc_switch_bpt_default_config().
6. Add some comments to avoid false positives from AI review.
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
 drivers/net/dsa/netc/netc_ethtool.c           |  192 ++
 drivers/net/dsa/netc/netc_main.c              | 1558 +++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c          |   89 +
 drivers/net/dsa/netc/netc_switch.h            |  155 ++
 drivers/net/dsa/netc/netc_switch_hw.h         |  335 ++++
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  |  188 +-
 drivers/net/ethernet/freescale/enetc/ntmp.c   |  383 +++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  122 +-
 include/linux/dsa/tag_netc.h                  |   14 +
 include/linux/fsl/netc_global.h               |    6 +
 include/linux/fsl/ntmp.h                      |  235 ++-
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |   10 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_netc.c                            |  185 ++
 23 files changed, 3614 insertions(+), 30 deletions(-)
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


