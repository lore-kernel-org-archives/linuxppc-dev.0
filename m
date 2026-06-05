Return-Path: <linuxppc-dev+bounces-22073-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E3FCD6E75
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 01:45:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWklx6W0Gz3bsQ;
	Fri, 05 Jun 2026 11:45:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780623933;
	cv=pass; b=RibPTY4/9MewPpxVwjfBwvDwYTTos0Zhk/MniNcanlrH3U5BvtX/Ey4yid7F5MFc1AmFCYip0WSiM3gc6ReL9IBuIUAnaswWUem+Vy+limHK6GUp6vcWaxxBRvWWUu9yR3iVegooYWMX4PLHffFGsbY6Kvx6B5FKpwlFH1v4ZWTATB9dGTDR7oMYrpf74QnA26I1yJScP2ijhELby/MdHMvLizu1bUwNsN7UD6DSlga6pna04jzb/banEuhnkMjiA2K8a4H6Xan1XwrHhkxcbJ7w3Y25D4joShVhh3aN0k31xURaWzX6sxCxovmPhdtVkFb5j3dPLTffuyRnyPMk/w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780623933; c=relaxed/relaxed;
	bh=YisiVg7fOCuNVM1Uh7g8hNGz/0665L6Rr78N0pXoPV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NInV1x0eRh9uJ5olstDKyvARyREYy7hJmI7qQJxva6J6fFH3aaCerS4H7Wei+9vH5AioejOuV0AnijeF7zjfQ3t3eGYV8k522kQ3nA2SJwAsNwBpIZYPR4YKJ8Jg79SosMBRSQsGHR68MRjYzlIoQWvEvCaGWu+vk8D+401RLsP6wjoQBZSOea0dvHPx9dfHYhskjR+eF9fHt1RXukUq3yl9/FOSMEVa2CpcgqfQjgWNqQul5jD8fwu8Vef9WPn5D24rbH063jj5mwOLgSgP7Aj7pMqs8zPp/etf0WfOnT+nLrZTFEl/EqG03UOizrU2PWQT+gqfWbcyDGC46id77Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hpXda0OC; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hpXda0OC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWklw2Q16z3brt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 11:45:32 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCrgIroTH6xF2Yrs439xdmHPcQ7YCfeZvPWo5wM/YNZRtgurL/dLgYBEgt3L0YKeVIhlkqjh2BrmtUjl/JuyGuYDpXHvibA2NAYw2tFiFtSyTZWQLQzCnC3b3NVTzY78bw8g+4AJy7G6btfzfCXVfbKor92qjdtdjUpPcESbFHAxc7JN6c++8Im3q9zUf5+RTtE+f05COsfken1jTYNT10MsmbEs31RvLL5GBC8x9v0M3eVBBqI6lf46fCncTLNadafDp7hpNP7DMjFO0VSgBvhjzQ0R3SneI8G/K3TYiwHukuwevbuBD0r5e5r7/yM4oC1VujQRxoHn9TdQ5MW4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YisiVg7fOCuNVM1Uh7g8hNGz/0665L6Rr78N0pXoPV0=;
 b=OqyIVRIitB9Y8WOLp2pLhmhwcehU5S+4QlzNBHrw4Qc3V1T1i3OuMFfGOZ5k0AyEBiipT6vESAzOcO5w6oeO9u2YJcCXlyXLpQaNTS6tgRIG+hyrXb2Pf14A0r17JDNjOCcKn7JlOYrZ8CQsk2PbQD4IvVZfp8I5UYk5etFOb02EM2fAsTPSC7wTchlp/raxu65Rl+XC6aCkDP3pinbxg7LE8uL+3JyO9ypXwvbw3JZFeQ8ajJJ+UUcJXg4mp77m8lWZRPdsKvxqOp9X32I0n6mn8WlJjwR7lEUaT1MFgKsDGpy7LmOFcFaj0RBWRGwtwVen9arHB+OY8uEJxffJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YisiVg7fOCuNVM1Uh7g8hNGz/0665L6Rr78N0pXoPV0=;
 b=hpXda0OCv2jTW6sz/vDKJKpHUJJAUUl4vEaQnuwJ7/lMrSwJZ8DkknZ/4wCYStivNHzwO419La+3tpCkgV6KRXJlWT+jrTpVbzrkVtYWURSid1b0CMABIcRmp1+tlioQrQQRh+yrflODX4mWeJWyFZ+H8eTlOFcqr3CyFamPsXoGhkVnW6Bzpkj9NGgroAdkLRH1lyco9Z6RPDsj9bOLuQLZREmQwgOQCmNHWEEiIyyuzAZDboseuJOM37N0b9ZaSDejqBdUG/BXE6vJuRtHbn462HTcCtFuTTS7H0FJ9NJwKRaLdvPxXqgz2yPBFqO9lWfcuQ2kNTaxKiEElEdhNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:45:20 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:45:20 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 3/9] net: enetc: add interfaces to manage egress treatment table
Date: Fri,  5 Jun 2026 09:48:02 +0800
Message-Id: <20260605014808.686024-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605014808.686024-1-wei.fang@oss.nxp.com>
References: <20260605014808.686024-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc04f2c-94e4-42ea-ab84-08dec2a41a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|921020|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	j7NW2bpk9624Q0vXsjJTX/+ehj0KVqtDKtWMBpbP00dAr2BHh8K1TdEU8O+i6Xc9r5FS4P/wJAryznF6FxD6KrMiSgi9vHytQdjRm/Qy2eAvjVkbtfk/OZnWEX0NZZBR+K3WIGH/7YvLgJIEx4VHrkB6TdIpqbM/1UY3KXQkoCLcv3yJ4MiQXXfNe1op42LqWh+x+UHQhzU0cGtO/U5rEmfIGv/VcErVxdwIWIRQkugPSgWD3AL2TaZtWJApehRijUn965dfSdoGPZdr5uA7ak/TOYb2jDoO65vW4CXh7eIUgTraog5gnLbZKzIjBjdW2/MAEQrFyjzB5cUg7zrutWrf1VxZ9rhx7y2TJ1oUeimEc/GcPEdh/aVf14zzsZOOHKj0fvqhx4FRKfaBVf/wKwVkgl1oaBlWcyVRvkps2AjEb03gLp0w/fFgJBkoZd2FGLvEvv3lI5C82qDUwqTAhdFy9gvNMuQdwSdp6DNOZbWLsyQqdXgg4Eog4c3Vd1+izNBBv/6emvfuzD7qlGTL0l8DX6opdV2DgjDjbwf4iNyQUDv2rLP+M/Avmw8TVnA6mDM3ZiYYdrFwms0kZ+IwoO0a5Zu8My0ycJowQRDp26B1rbLzW+OspNeFZQ0IR6r3BqA91QVAueiBuQBarkBhAIl+OgWhjHk9rAX03jhvpUqq5KGGYouOlpC2fhmy+uktQubsjtZF77ZoXeAg2AKXBZamalyow9c8PksTDDC7HVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o9t9pipWazoRLEaTy8QrQyH01760hnOio6I8BY0okWADB6QpKortU4Ez8S1n?=
 =?us-ascii?Q?euojNIEJxVmfB7gwHDINrxlZZgpjFd4BUjxyh83D6l+BhF1FQCU6nes18bE3?=
 =?us-ascii?Q?/BJpeCZayhgSeTPSz69pWqPOfN72L49iTHgfs5zlRcMwxj5o/KioYJ2L01k/?=
 =?us-ascii?Q?Ho3cDALQVcBO79XL4j90hTTIYx5n8dT2t92EnyCoQ2hlIQ0VsYtIuq++7Vk7?=
 =?us-ascii?Q?pfzEPGy6jkvN02vdZaIKbr9Oir1W4AOCPqBlHo2byevWDeE1aPMW6GeZVaJ6?=
 =?us-ascii?Q?TprjUgNTur0HcXkTyOY/AxgLSvgbOJ/p78YVLiBvOZJgmYfgfxx5Tsgi7aWP?=
 =?us-ascii?Q?hIkj3GnQ4+TLKHZn2U9iR7E9VFHsjwidNh4R0lwFdm5tLto4x06OZJ9ghdoJ?=
 =?us-ascii?Q?htEMUsc7Vk8k9ZogGf9CdNx1/kvPi9X6B/ROaZM5tZH+VceMv8ZujsxgBFDH?=
 =?us-ascii?Q?nXzofpr8uafxkkuSvpSbeS2Ro1DJd3+WqLWyQd+1ONFEsTeKA41WU5XheSh6?=
 =?us-ascii?Q?EIwmgPSh0figEzJWgS6GVqiFfOindJ5NubV5SFE1l63popXA9PTui+tY8pO/?=
 =?us-ascii?Q?l4nnCPLjniFUYey5n2OOLxBEMaa1hXCpXvDPzF6z7uM8twpHOfFB1ZpYAeza?=
 =?us-ascii?Q?zPp6SWBtZXL4ifvgzFD9lV9BY/tL1X9CGLrq89/I5tnDdOd+pMwBhNFab+UQ?=
 =?us-ascii?Q?Y7nqdAO392tQ3Z4kTrPi/YVvp0nuRAbdhd2Cleve3XDPwYDg/wgw8Z7mW+mX?=
 =?us-ascii?Q?aqX6ppdTDCOqG7padprcNnYKb3WinXFzAnnxpi53A+sgkwRCbl3QH2IGKaQj?=
 =?us-ascii?Q?9R6qfrqPjkcMuThgg4+IDWhxNQ69DI/JkjgaadazybDbNIw22GW+y7oClHmn?=
 =?us-ascii?Q?oG3DeUDMpKqO5QqgYKhHyZ/1AXctJSNq4OYUihKm4HJW6sNznom0cYpX/MhS?=
 =?us-ascii?Q?1ZScFxD+UTHSXLL4FzS2bc4all2kK+6i3LqtIP8S8tin2NKzuS7KSo4Ikch2?=
 =?us-ascii?Q?hJJUqs8OiKFFZ8bteRb7fWdVaxw/+PZ6An+D8V2qs7wMsPeLKYPVIk+gUCnd?=
 =?us-ascii?Q?8NWWzaw11EujnJQGMHFDQmmaz4/DpuWP1IsIy8rM0hY4DXicIY7qmEDm+xtU?=
 =?us-ascii?Q?gt1IWYgvSgaY6jIhHhG4onLYT/Mg/nLJ/xURJGhGXXrPfl0xQvFpEd5HDmDT?=
 =?us-ascii?Q?0sQAza7qvax+6t/7X9JM51KULOySkdjW4lfqeu6nl+v19qCSVe0OQ4wMaKYH?=
 =?us-ascii?Q?DSEJ0mtKo15QX5oTBHb7cppQ43hHZuZJLpBwei2Dxfdv+9TNNfksnWXX7FFI?=
 =?us-ascii?Q?YdUAGKK5NQllbGs1nUJtUj6ufU5t3jnIKYPceUEe7b3jbedPn0SRdVqqXwTf?=
 =?us-ascii?Q?ZLFlr2xI+T5BINdh5nLedcBgOGkBlB6DEOR9cznprMVMCL7MkN27Fi/gmbvb?=
 =?us-ascii?Q?kWGAEWmYAfMznlCYnulDOOWEOVQoB5qP5VlAUfrr0nXiSgJOZbzKk4qxUr/8?=
 =?us-ascii?Q?rwAllS1ZkDp6BcDrt/E0y0xRAfk2sDXT/i8fCx2cojmH9xlI52iM/FcbFqHo?=
 =?us-ascii?Q?mVd68RghvZQ4WTtWnR3TX5X4JIruz1FJTdob5Hk5nXRRO8UUyuOr+d++BmWr?=
 =?us-ascii?Q?zr/si4fj/dzA2iA3KK4FaTN6Q2I3yzsbfJRLOB1HEkGVP9CejE9pqf5ArbKj?=
 =?us-ascii?Q?WC4colJioVI4ktM6/KXw1TVp7DwDXLThhKNKfvzmtJaU8xwC1VQOKt2jqtxf?=
 =?us-ascii?Q?oeyvG8jqnybH9rEHofcX9Ss7T0uCtEOTt4Nf28UcP1N5BwCry9hp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc04f2c-94e4-42ea-ab84-08dec2a41a37
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:45:20.4973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xA57LpQfBLFMzo5jvutJkBj428wLeeCM4KwmjWdqQMlgnK1RpEqN4AOKyNn2ff+7VxcVamUrKUph5jJM6REN00SmPpcdljDwBs4QeIi0tu/jFxvuyZmr2BLDCNFvFWrV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9375

From: Wei Fang <wei.fang@nxp.com>

Each entry in the egress treatment table contains the egress packet
processing actions to be applied to a grouping or scope of packets
exiting on a particular egress port of the switch. A scope of packets,
for example, could be the packets exiting a particular VLAN, matching
a particular 802.1Q bridge forwarding entry or belonging to a stream
identified at ingress. The egress treatment table is implemented as a
linear array of entries accessed using an index (0,1, 2, ..., n) that
uniquely identifies an entry within the array.

The egress treatment table only supports access vid entry ID, which is
assigned by the software. It supports Add, Update, Delete and Query
operations. Note that only Query operation is not supported yet.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 106 ++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |   8 ++
 include/linux/fsl/ntmp.h                      |  23 ++++
 3 files changed, 137 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 4e60bbc38cfa..9249f78219ed 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -24,6 +24,7 @@
 #define NTMP_IPFT_ID			13
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
+#define NTMP_ETT_ID			33
 #define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
@@ -284,6 +285,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "FDB Table";
 	case NTMP_VFT_ID:
 		return "VLAN Filter Table";
+	case NTMP_ETT_ID:
+		return "Egress Treatment Table";
 	case NTMP_BPT_ID:
 		return "Buffer Pool Table";
 	default:
@@ -1091,6 +1094,109 @@ int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid)
 }
 EXPORT_SYMBOL_GPL(ntmp_vft_delete_entry);
 
+/**
+ * ntmp_ett_set_entry - add a new entry to the egress treatment table or
+ * update the configuration element data of the specified entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ * @cmd: command type, NTMP_CMD_ADD or NTMP_CMD_UPDATE
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+static int ntmp_ett_set_entry(struct ntmp_user *user, u32 entry_id,
+			      int cmd, const struct ett_cfge_data *cfge)
+{
+	struct netc_swcbd swcbd;
+	struct ett_req_ua *req;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	int err;
+
+	if (cmd != NTMP_CMD_ADD && cmd != NTMP_CMD_UPDATE)
+		return -EINVAL;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd_eid(&req->rbe, user->tbl.ett_ver, 0,
+			  NTMP_GEN_UA_CFGEU, entry_id);
+	req->cfge = *cfge;
+
+	/* Request header */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
+			      NTMP_ETT_ID, cmd, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+
+/**
+ * ntmp_ett_add_entry - add a new entry to the egress treatment table
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ett_add_entry(struct ntmp_user *user, u32 entry_id,
+		       const struct ett_cfge_data *cfge)
+{
+	int err;
+
+	err = ntmp_ett_set_entry(user, entry_id, NTMP_CMD_ADD, cfge);
+	if (err)
+		dev_err(user->dev, "Failed to add %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_ETT_ID), entry_id, ERR_PTR(err));
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ett_add_entry);
+
+/**
+ * ntmp_ett_update_entry - update the configuration element data of the
+ * specified entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ett_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct ett_cfge_data *cfge)
+{
+	int err;
+
+	err = ntmp_ett_set_entry(user, entry_id, NTMP_CMD_UPDATE, cfge);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_ETT_ID), entry_id, ERR_PTR(err));
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ett_update_entry);
+
+/**
+ * ntmp_ett_delete_entry - delete the specified egress treatment table entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	return ntmp_delete_entry_by_id(user, NTMP_ETT_ID, user->tbl.ett_ver,
+				       entry_id, NTMP_EID_REQ_LEN, 0);
+}
+EXPORT_SYMBOL_GPL(ntmp_ett_delete_entry);
+
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 9d30f128849a..531ea7ddd145 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -217,6 +217,14 @@ struct vft_req_qd {
 	union vft_access_key ak;
 };
 
+/* Egress Treatment Table Request Data Buffer Format of Update and Add
+ * actions
+ */
+struct ett_req_ua {
+	struct ntmp_req_by_eid rbe;
+	struct ett_cfge_data cfge;
+};
+
 /* Buffer Pool Table Request Data Buffer Format of Update action */
 struct bpt_req_update {
 	struct ntmp_req_by_eid rbe;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 36a9089526ad..0c951e1c763d 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -36,6 +36,7 @@ struct netc_tbl_vers {
 	u8 vft_ver;
 	u8 bpt_ver;
 	u8 ipft_ver;
+	u8 ett_ver;
 };
 
 struct netc_swcbd {
@@ -214,6 +215,23 @@ struct vft_cfge_data {
 	__le32 et_eid;
 };
 
+struct ett_cfge_data {
+	__le16 efm_cfg;
+#define ETT_EFM_MODE		GENMASK(1, 0)
+#define ETT_ESQA		GENMASK(5, 4)
+#define ETT_ECA			GENMASK(8, 6)
+#define ETT_ECA_INC		1
+#define ETT_EFM_LEN_CHANGE	GENMASK(15, 9)
+#define ETT_FRM_LEN_DEL_VLAN	0x7c
+#define ETT_FRM_LEN_DEL_RTAG	0x7a
+#define ETT_FRM_LEN_DEL_VLAN_RTAG	0x76
+	__le16 efm_data_len;
+#define ETT_EFM_DATA_LEN	GENMASK(10, 0)
+	__le32 efm_eid;
+	__le32 ec_eid;
+	__le32 esqa_tgt_eid;
+};
+
 struct bpt_bpse_data {
 	__le32 amount_used;
 	__le32 amount_used_hwm;
@@ -271,6 +289,11 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 int ntmp_vft_update_entry(struct ntmp_user *user, u16 vid,
 			  const struct vft_cfge_data *cfge);
 int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid);
+int ntmp_ett_add_entry(struct ntmp_user *user, u32 entry_id,
+		       const struct ett_cfge_data *cfge);
+int ntmp_ett_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct ett_cfge_data *cfge);
+int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge);
 #else
-- 
2.34.1


