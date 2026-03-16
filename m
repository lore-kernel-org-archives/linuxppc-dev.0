Return-Path: <linuxppc-dev+bounces-18233-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B444EF4643B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 09:42:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ99K0kjvz2ynT;
	Mon, 16 Mar 2026 20:42:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773654133;
	cv=pass; b=PQ9ZTyHcVi1WrgqC6zZhV9JKNQ7IfR2A2iD1HeG9rNRJd48ZDd1am5T2IpesJIwJyZDplMcx5wtBGh2LZHegrAP1Ot9EDJ3fBHFZ7ye9a5zBKPq6Op8DbUsqTxbW8wu7wUEncg1L09hfFS94PEBtLAGt2UbQuMm+oR4VRStRpeQvyySAOI13wN5XsYXp9vh61tfey8dpF1Yvs157YPFor/dPAHwpBWAi6/HEEIyCeDfR4GAof+/HwbjMJIb3ADXncWfxgK+9hYa6Kd+8LiWHEQ2tMquiQoKcLrVjrGltfMv9WzLu31EXMwGzcrvPFRAaV+hkjLBXxlAbvZc6hxLtoA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773654133; c=relaxed/relaxed;
	bh=CoCNwl/loVfYHJxUYQ1sQfOUAUoOsKYyYv7iU2NJVSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ahHPS48cEGickm9xRasMpaV8Qsh3h0lFsmuGlfmYWQS26/8zwZkK0EEYAHabT09THiYFky+Bo/MEF5iM6TdUDvjlhJPmBAStZ3no+QVCUtcys2qKHR6+lkLUKS3jjUozYl4ieS/J6pYiEbmJJv2JaZh2tfFFO/YIyiR7oWe+64b5ivEwIcJ5Q5nNJk+Cm5mlu5S988nqIzOFVRTLIyOlw9xVWwYHgJ6tU1sFSNcf+mGik9CpcP5i5vWUGh2iT0gHKpBknj5G5sxWUUymY2zOypP0+iHb1Q2Loo7QX0AIpCohLy3DiJsoocq2c58bUtM6Z+Iw6RjtjhYjukJkpwr6nQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Jm5MFRnQ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Jm5MFRnQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ99H3bN7z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 20:42:11 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ6Pu59c8jUCwKdoZmAVQKoX0KkSgUeb7AbDXji1wQke/myMTjl355NYeMy9iQGhQC9immHUURdq6ipHBwE23756peGLkxJtzrSWcQYWuzccxbyC8vLbbFRBDJGeQS45PxRGsviFT1cByrWt+Ggh8GcnmKwBxPwzspuZjHgXknVJLyYGQI1QUzLHMCNcSQMr89MW2nJttXhGI7FXNl/llgWO16900zu0qRN274Cg/mQ5EXNydbX3VTDWYjaFvqgjRaMRnzx6aC6w29BbaJw+gGjS4FuL9YHSjQ7QnABAPpumLDr/nJbahBnIWHOetN6QcsBeJjnGNTQ3pXpsEWkvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoCNwl/loVfYHJxUYQ1sQfOUAUoOsKYyYv7iU2NJVSU=;
 b=NJwx6ipYrGHGuBhFo37bJ85DzKL7eDs0rM/lPb7RN5CzjgnY5vbyLkUHd0hYSBQIbG8mGoutP/W5+zdyhiWs1BX8Z+x7FcmPERdhTdgPlzatR0bCk5M0LnjE1E0PqrnhALiVB55FEdiMCpMqeNH0mLX+wvbGYAd8VdBgwgUr742J7zxr4/MCz6Q7nP7a/h+HHPjHO4hqoqd26NC+SH46f8ISDl4MwmkX9546RFr22PgVciT3J+XS0MtUjZyY9A3+Lgf6Mg9GXEbA+nF0pTRM0Y92l9oG1hIwVlZyg3V0BgJ4mHECFrmPuNEdEDLYWcI8Igf1SRz7U1RO61qukEJr7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoCNwl/loVfYHJxUYQ1sQfOUAUoOsKYyYv7iU2NJVSU=;
 b=Jm5MFRnQIvVF6AWWiicj6F9UZnDrgFVkoz8CIrIGiZoijAcYDr1ntsJZOqwdPgFz3MNYfgbVo+sTveY6pbtRCXofazR5bne615/5g9qJoSahiI47ZtYJlSuV2HJthLsDpuUSGJ6bUQGOiTTO8aZecQUvJ75IDs/E53ZQt/n3KSnGXSfZm5FLWUpS4L40gv0DbECmFDV1P/bOXJTMh5SnzEqvkzX66W7S4v2OrdJM/VUSALhxhFhc4oe4Qel3u7t119YIigv1LnPkrK8NLKRCKdButqyIVqoYVk1P1gjF3oMFssKONf0pl/pRjXCVpVdgyf8JEa7bFVx5TMtFBv9Euw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AMBPR04MB12412.eurprd04.prod.outlook.com (2603:10a6:20b:75f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 09:41:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 09:41:51 +0000
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
Subject: [PATCH net-next 12/14] net: dsa: netc: add more basic functions support
Date: Mon, 16 Mar 2026 17:41:50 +0800
Message-Id: <20260316094152.1558671-13-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AMBPR04MB12412:EE_
X-MS-Office365-Filtering-Correlation-Id: df812e6c-c2ca-4579-8a6c-08de83404029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|7416014|366016|38350700014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FMxfyJeSeQZ2+7H1L+gC6TWIqK6LWoDNMz1mUAKHusK/ScQnjHV+6oQOHAVpuv+80XRu8QlRCJXFnY4jR14XHDMIGK0ek5h3I6pUpXmEQ1sCz3P/69nwkUdRpkO7IODNz0TaGml65peC1YGF6N4/M9fvl8F0bhAtVAACmg6qN0RkcWzQ8nqqYfz4Fd7wwq71NaEAWyDSFXgNSZH8/5GDEQse8/4PZWYyYz9S6dF0o+23YfZZuJQNC/88GS9MefjnfbTiIigK2bC9PkaTxWiAuqGMJ5awhd6ggIxPzw+saX5ciEM9aQo7q6RqHd6VRS7tNbRLg79vJZjNZPVXkBvCVBdAGIWCdKNCLl/ILxNuyst0+m+tOglfbYTVJ3/xZJsQrAnFGhnSzNQ1IR0fP9Z4IqAcuu5BIKpt0jgselIhfajjmZSOxu+HW1v03fPO5LDBczwqDYX6GjRQIcry0c4/gHkyOGo/O1Un5EMeXNuy5rzNxDSU2ViDB/SqNaP107ep44trgKbZ+h31QqdzyvI/ZuGmy8WUkwcIXNu5K3Mb+CzkulgSYHAJTaPetCtX3jkQKLSk0W/W1/FB9YVVev+8OE2MON3oSEfNhFszLEtF4at0mk1SCVbetTqjXUIySls2C9l21UJulSvVwmh2ybZ4GW6ANIpjKzlqEydNpbVXi+F3NqsYRrd8PdneA+Q/vrqgkqA6Scd0qVi5ckZ1vYpsJKB2wYMfBEW/OtIL02aV+RfllqnBcOA2eEGZJxvghYO1ls/Ko0TYf+3+mOdT3CxJMso6AsPAIy0XWDcZtTwZTui46RQiYJqdSquECZtu97ME
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(7416014)(366016)(38350700014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?coKxBHkVzFY2DzrfGXPbRH/czcPtoEo8mXuJCN2I8QDWvOfsBtE8sm4zif6D?=
 =?us-ascii?Q?hpaf/AV8SKg8K4sdakjinUTw+l+eijkY7rMpvazu0VyF5ao0NqvWaU5Uc+lv?=
 =?us-ascii?Q?6JRBQkTuRgkbLDq8lbYhdjfoFc2qTFscaTcv+fmONbT5/wPHqRX98G/6Ksqn?=
 =?us-ascii?Q?V5CRzfBT/58jq0HuV1i1iWaiq2T45I+o1eqw/VJ027OjnzBRw/JRo/ByowRi?=
 =?us-ascii?Q?0+fIL81ugFxiJsguFLDu6O4CmIpWWx5P75lzRTMJ6M1tinD47EWZfTddein/?=
 =?us-ascii?Q?5nHv2Yg6ixRAV+G0xfmeVJMyurzOuV4zkEbbmNLPukf3q12iqeQE+gZbqQ2V?=
 =?us-ascii?Q?WnVHMgDRCS6CWZbaWiuTQGaVrlVaKD+fcib9CoF4oCCaVMGRzKSsSBGOOlDW?=
 =?us-ascii?Q?lr5DzeeNyl6N3yQDPeyn3pZzn5w7GKMqjp1PsuyfA8gS6vYBZoNY9qx3zTB6?=
 =?us-ascii?Q?tHse81u5vOoiE/cvy2SdkDNVLx53XoDcNAiiBA7dkgRgDt/Daxzt9LqapXuW?=
 =?us-ascii?Q?PD0kye3EG138JM/0/Nh3ULX+ecSvycF5238wNSX//qgsMeHPamDhK1N3QS06?=
 =?us-ascii?Q?vaxszlYTlbgl+Xv6KQaWjP8wUldMH25B3KRfBQc8/gC55De1Sya2ur8m8GU5?=
 =?us-ascii?Q?DjjDRXu20/25au7GsPaLfafFCAnv/+6kpnr/xIA2AYgFzRXJH2XlfUnveQzf?=
 =?us-ascii?Q?PXGnVpknPDHCbacGRD5XA+xB5iWxWkpDNT4xbM/jM0HkRSSLsSLkGhb2kcEa?=
 =?us-ascii?Q?WeboKs1PGVFAIhek/cIKQrrJ3o/VauReRpGmNsSMPQi6zIbP3SzNbiFi3yr/?=
 =?us-ascii?Q?B1xc1ZmVbXV39juwe0msSLi84+Ks/hIPj/a0FDK8tXE5TrtwSClEr3gkO8dT?=
 =?us-ascii?Q?MF90JJuZEb7RLVW6Brbp3vO0wxE3QXDZoD2lPdxPxcF9HwwbcN4AKSiUcPjs?=
 =?us-ascii?Q?LNdmlgVZUvo2kOS6EOR9t9kOht9K1kNSFLd7rq6wU2Zsu48YLjFKUw35M8V5?=
 =?us-ascii?Q?w9cwBUiO8pMp+KY0DpnCmOdr3xpfItXgizqxX+pY2FpH09Km16ekbfQ1S+xi?=
 =?us-ascii?Q?2kkgHuhLukRAAbAB8qJIMtKbJaQGMktFri6ubT/cPc++SG5oF52LzXC91PVX?=
 =?us-ascii?Q?80Ee8UGcaMdtD1lDY/7uxfVDz/0KzSAYcBDga6hURFyWFoT37gP8K7TPuyYJ?=
 =?us-ascii?Q?aGE7TCebO/inr82vR+l9SF41F9hI01B2Lv9ZMQ5eqXaRdunoS3e9Y5TL0jtx?=
 =?us-ascii?Q?jOloJi5CDWKdSGmh80hIO4kJ0JVU6Vkm8k5vISxpGjy0GzfF3kNTZ9WuLIwJ?=
 =?us-ascii?Q?HuBAy4hg7mPOp3NdZ3Oyq2f4qE7pMd1cmej9W4MOGuuIqoTJvPj6PIWF5xG/?=
 =?us-ascii?Q?NDoi8UG6Y3tBGgbDv56JvmkbndR5jMzpM9uencCoyjbG3CHltKNdt+DsRzNa?=
 =?us-ascii?Q?98x/wh1k3kHwXVrYb9ZkqocUJv0eyY1l4ivXzoD9561b3lz0YyVSWBwMEEvc?=
 =?us-ascii?Q?QnA7wvog5I/LhLmnjo2Whn+djQoWDE5oO+6ryVOJLnehq8qMtDUzo0n3wvlb?=
 =?us-ascii?Q?ywBaDUqGwEo8IVM9I0MSacaBafhmktfcAGRne1jIejoeXmUrtsqQxfNVHS6y?=
 =?us-ascii?Q?fxCTjVEZPjFfIqixv9OOLVkW9Kxbo6X5/55/GUMT0czpt+QbHxaCj+6jdrye?=
 =?us-ascii?Q?GdrGCXzqYiFmWqJY1VUyILinAYZNFSXMNhC2Wv1iFZreZK2xs5upfO/2TAat?=
 =?us-ascii?Q?8Zc84jfjJA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df812e6c-c2ca-4579-8a6c-08de83404029
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:41:51.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J344kW4ResC4Misybcz7xPZkMvt+ZGSFrO6regnv924y1QZLQUch7g6q3dBSW1+Q7vRL2z2epVKiHdPBaUv58w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12412

This patch expands the NETC switch driver with several foundational
features, including FDB and MDB management, STP state handling, MTU
configuration, port setup/teardown, and host flooding support.

At this stage, the driver operates only in standalone port mode. Each
port uses VLAN 0 as its PVID, meaning ingress frames are internally
assigned VID 0 regardless of whether they arrive tagged or untagged.
Note that this does not inject a VLAN 0 header into the frame, the VID
is used purely for subsequent VLAN processing within the switch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 531 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |  33 ++
 drivers/net/dsa/netc/netc_switch_hw.h |  11 +
 3 files changed, 575 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 884ee899fc89..fd952b507cbd 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -7,11 +7,36 @@
 #include <linux/clk.h>
 #include <linux/etherdevice.h>
 #include <linux/fsl/enetc_mdio.h>
+#include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
 #include <linux/of_mdio.h>
 
 #include "netc_switch.h"
 
+static struct netc_fdb_entry *
+netc_lookup_fdb_entry(struct netc_switch *priv,
+		      const unsigned char *addr,
+		      u16 vid)
+{
+	struct netc_fdb_entry *entry;
+
+	hlist_for_each_entry(entry, &priv->fdb_list, node)
+		if (ether_addr_equal(entry->keye.mac_addr, addr) &&
+		    le16_to_cpu(entry->keye.fid) == vid)
+			return entry;
+
+	return NULL;
+}
+
+static void netc_destroy_fdb_list(struct netc_switch *priv)
+{
+	struct netc_fdb_entry *entry;
+	struct hlist_node *tmp;
+
+	hlist_for_each_entry_safe(entry, tmp, &priv->fdb_list, node)
+		netc_del_fdb_entry(entry);
+}
+
 static enum dsa_tag_protocol
 netc_get_tag_protocol(struct dsa_switch *ds, int port,
 		      enum dsa_tag_protocol mprot)
@@ -409,6 +434,212 @@ static void netc_port_default_config(struct netc_port *np)
 	netc_port_rmw(np, NETC_POR, PCR_TXDIS, 0);
 }
 
+static u32 netc_available_port_bitmap(struct netc_switch *priv)
+{
+	struct dsa_port *dp;
+	u32 bitmap = 0;
+
+	dsa_switch_for_each_available_port(dp, priv->ds)
+		bitmap |= BIT(dp->index);
+
+	return bitmap;
+}
+
+static int netc_add_standalone_vlan_entry(struct netc_switch *priv)
+{
+	u32 bitmap_stg = VFT_STG_ID(0) | netc_available_port_bitmap(priv);
+	struct vft_cfge_data *cfge;
+	u16 cfg;
+	int err;
+
+	cfge = kzalloc_obj(*cfge);
+	if (!cfge)
+		return -ENOMEM;
+
+	cfge->bitmap_stg = cpu_to_le32(bitmap_stg);
+	cfge->et_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	cfge->fid = cpu_to_le16(NETC_STANDALONE_PVID);
+
+	/* For standalone ports, MAC learning needs to be disabled, so frames
+	 * from other user ports will not be forwarded to the standalone ports,
+	 * because there are no FDB entries on the standalone ports. Also, the
+	 * frames received by the standalone ports cannot be flooded to other
+	 * ports, so MAC forwarding option needs to be set to
+	 * MFO_NO_MATCH_DISCARD, so the frames will discarded rather than
+	 * flooding to other ports.
+	 */
+	cfg = FIELD_PREP(VFT_MLO, MLO_DISABLE) |
+	      FIELD_PREP(VFT_MFO, MFO_NO_MATCH_DISCARD);
+	cfge->cfg = cpu_to_le16(cfg);
+
+	err = ntmp_vft_add_entry(&priv->ntmp, NETC_STANDALONE_PVID, cfge);
+	if (err)
+		dev_err(priv->dev,
+			"Failed to add standalone VLAN entry\n");
+
+	kfree(cfge);
+
+	return err;
+}
+
+static int netc_port_add_fdb_entry(struct netc_port *np,
+				   const unsigned char *addr, u16 vid)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_fdb_entry *entry;
+	struct fdbt_keye_data *keye;
+	struct fdbt_cfge_data *cfge;
+	int port = np->dp->index;
+	u32 cfg = 0;
+	int err;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+
+	keye = &entry->keye;
+	cfge = &entry->cfge;
+	ether_addr_copy(keye->mac_addr, addr);
+	keye->fid = cpu_to_le16(vid);
+
+	cfge->port_bitmap = cpu_to_le32(BIT(port));
+	cfge->cfg = cpu_to_le32(cfg);
+	cfge->et_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+
+	err = ntmp_fdbt_add_entry(&priv->ntmp, &entry->entry_id, keye, cfge);
+	if (err) {
+		kfree(entry);
+
+		return err;
+	}
+
+	netc_add_fdb_entry(priv, entry);
+
+	return 0;
+}
+
+static int netc_port_set_fdb_entry(struct netc_port *np,
+				   const unsigned char *addr, u16 vid)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_fdb_entry *entry;
+	int port = np->dp->index;
+	u32 port_bitmap;
+	int err = 0;
+
+	mutex_lock(&priv->fdbt_lock);
+
+	entry = netc_lookup_fdb_entry(priv, addr, vid);
+	if (!entry) {
+		err = netc_port_add_fdb_entry(np, addr, vid);
+		if (err)
+			dev_err(priv->dev,
+				"Failed to add FDB entry on port %d\n",
+				port);
+
+		goto unlock_fdbt;
+	}
+
+	port_bitmap = le32_to_cpu(entry->cfge.port_bitmap);
+	/* If the entry already exists on the port, return 0 directly */
+	if (unlikely(port_bitmap & BIT(port)))
+		goto unlock_fdbt;
+
+	/* If the entry already exists, but not on this port, we need to
+	 * update the port bitmap. In general, it should only be valid
+	 * for multicast or broadcast address.
+	 */
+	port_bitmap ^= BIT(port);
+	entry->cfge.port_bitmap = cpu_to_le32(port_bitmap);
+	err = ntmp_fdbt_update_entry(&priv->ntmp, entry->entry_id,
+				     &entry->cfge);
+	if (err) {
+		port_bitmap ^= BIT(port);
+		entry->cfge.port_bitmap = cpu_to_le32(port_bitmap);
+		dev_err(priv->dev, "Failed to set FDB entry on port %d\n",
+			port);
+	}
+
+unlock_fdbt:
+	mutex_unlock(&priv->fdbt_lock);
+
+	return err;
+}
+
+static int netc_port_del_fdb_entry(struct netc_port *np,
+				   const unsigned char *addr, u16 vid)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct ntmp_user *ntmp = &priv->ntmp;
+	struct netc_fdb_entry *entry;
+	int port = np->dp->index;
+	u32 port_bitmap;
+	int err = 0;
+
+	mutex_lock(&priv->fdbt_lock);
+
+	entry = netc_lookup_fdb_entry(priv, addr, vid);
+	if (unlikely(!entry))
+		goto unlock_fdbt;
+
+	port_bitmap = le32_to_cpu(entry->cfge.port_bitmap);
+	if (unlikely(!(port_bitmap & BIT(port))))
+		goto unlock_fdbt;
+
+	if (port_bitmap != BIT(port)) {
+		/* If the entry also exists on other ports, we need to
+		 * update the entry in the FDB table.
+		 */
+		port_bitmap ^= BIT(port);
+		entry->cfge.port_bitmap = cpu_to_le32(port_bitmap);
+		err = ntmp_fdbt_update_entry(ntmp, entry->entry_id,
+					     &entry->cfge);
+		if (err) {
+			port_bitmap ^= BIT(port);
+			entry->cfge.port_bitmap = cpu_to_le32(port_bitmap);
+			goto unlock_fdbt;
+		}
+	} else {
+		/* If the entry only exists on this port, just delete
+		 * it from the FDB table.
+		 */
+		err = ntmp_fdbt_delete_entry(ntmp, entry->entry_id);
+		if (err)
+			goto unlock_fdbt;
+
+		netc_del_fdb_entry(entry);
+	}
+
+unlock_fdbt:
+	mutex_unlock(&priv->fdbt_lock);
+
+	return err;
+}
+
+static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *priv)
+{
+	const u8 bcast[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	struct dsa_port *dp, *cpu_dp = NULL;
+
+	dsa_switch_for_each_cpu_port(dp, priv->ds) {
+		cpu_dp = dp;
+		break;
+	}
+
+	if (!cpu_dp)
+		return -ENODEV;
+
+	/* If the user port acts as a standalone port, then its PVID is 0,
+	 * MLO is set to "disable MAC learning" and MFO is set to "discard
+	 * frames if no matching entry found in FDB table". Therefore, we
+	 * need to add a broadcast FDB entry on the CPU port so that the
+	 * broadcast frames received on the user port can be forwarded to
+	 * the CPU port.
+	 */
+	return netc_port_set_fdb_entry(NETC_PORT(priv->ds, cpu_dp->index),
+				       bcast, NETC_STANDALONE_PVID);
+}
+
 static int netc_setup(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -427,24 +658,57 @@ static int netc_setup(struct dsa_switch *ds)
 	if (err)
 		goto free_mdio_bus;
 
+	INIT_HLIST_HEAD(&priv->fdb_list);
+	mutex_init(&priv->fdbt_lock);
+
 	netc_switch_fixed_config(priv);
 
 	/* default setting for ports */
 	dsa_switch_for_each_available_port(dp, ds)
 		netc_port_default_config(priv->ports[dp->index]);
 
+	err = netc_add_standalone_vlan_entry(priv);
+	if (err)
+		goto free_ntmp_user;
+
+	err = netc_add_standalone_fdb_bcast_entry(priv);
+	if (err)
+		goto free_ntmp_user;
+
 	return 0;
 
+free_ntmp_user:
+	netc_free_ntmp_user(priv);
 free_mdio_bus:
 	netc_free_mdio_bus(priv);
 
 	return err;
 }
 
+static void netc_destroy_all_lists(struct netc_switch *priv)
+{
+	netc_destroy_fdb_list(priv);
+	mutex_destroy(&priv->fdbt_lock);
+}
+
+static void netc_free_host_flood_rules(struct netc_switch *priv)
+{
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_user_port(dp, priv->ds) {
+		struct netc_port *np = priv->ports[dp->index];
+
+		kfree(np->host_flood);
+		np->host_flood = NULL;
+	}
+}
+
 static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
 
+	netc_destroy_all_lists(priv);
+	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
 	netc_free_mdio_bus(priv);
 }
@@ -595,6 +859,261 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
 	priv->revision = val & IPBRR0_IP_REV;
 }
 
+static int netc_port_enable(struct dsa_switch *ds, int port,
+			    struct phy_device *phy)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	int err;
+
+	if (np->enable)
+		return 0;
+
+	err = clk_prepare_enable(np->ref_clk);
+	if (err) {
+		dev_err(ds->dev,
+			"Failed to enable enet_ref_clk of port %d\n", port);
+		return err;
+	}
+
+	np->enable = true;
+
+	return 0;
+}
+
+static void netc_port_disable(struct dsa_switch *ds, int port)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	/* When .port_disable() is called, .port_enable() may not have been
+	 * called. In this case, both the prepare_count and enable_count of
+	 * clock are 0. Calling clk_disable_unprepare() at this time will
+	 * cause warnings.
+	 */
+	if (!np->enable)
+		return;
+
+	clk_disable_unprepare(np->ref_clk);
+	np->enable = false;
+}
+
+static void netc_port_stp_state_set(struct dsa_switch *ds,
+				    int port, u8 state)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	u32 val;
+
+	switch (state) {
+	case BR_STATE_DISABLED:
+	case BR_STATE_LISTENING:
+	case BR_STATE_BLOCKING:
+		val = NETC_STG_STATE_DISABLED;
+		break;
+	case BR_STATE_LEARNING:
+		val = NETC_STG_STATE_LEARNING;
+		break;
+	case BR_STATE_FORWARDING:
+		val = NETC_STG_STATE_FORWARDING;
+		break;
+	default:
+		return;
+	}
+
+	netc_port_wr(np, NETC_BPSTGSR, val);
+}
+
+static int netc_port_change_mtu(struct dsa_switch *ds,
+				int port, int mtu)
+{
+	u32 max_frame_size = mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	if (dsa_is_cpu_port(ds, port))
+		max_frame_size += NETC_TAG_MAX_LEN;
+
+	netc_port_set_max_frame_size(np, max_frame_size);
+
+	return 0;
+}
+
+static int netc_port_max_mtu(struct dsa_switch *ds, int port)
+{
+	return NETC_MAX_FRAME_LEN - VLAN_ETH_HLEN - ETH_FCS_LEN;
+}
+
+static int netc_port_fdb_add(struct dsa_switch *ds, int port,
+			     const unsigned char *addr, u16 vid,
+			     struct dsa_db db)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	/* Currently, we only support standalone port mode, so all VLANs
+	 * should be converted to NETC_STANDALONE_PVID.
+	 */
+	return netc_port_set_fdb_entry(np, addr, NETC_STANDALONE_PVID);
+}
+
+static int netc_port_fdb_del(struct dsa_switch *ds, int port,
+			     const unsigned char *addr, u16 vid,
+			     struct dsa_db db)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	return netc_port_del_fdb_entry(np, addr, NETC_STANDALONE_PVID);
+}
+
+static int netc_port_fdb_dump(struct dsa_switch *ds, int port,
+			      dsa_fdb_dump_cb_t *cb, void *data)
+{
+	struct netc_switch *priv = ds->priv;
+	u32 resume_eid = NTMP_NULL_ENTRY_ID;
+	struct fdbt_entry_data *entry;
+	struct fdbt_keye_data *keye;
+	struct fdbt_cfge_data *cfge;
+	bool is_static;
+	u32 cfg;
+	int err;
+	u16 vid;
+
+	entry = kmalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+
+	keye = &entry->keye;
+	cfge = &entry->cfge;
+	mutex_lock(&priv->fdbt_lock);
+
+	do {
+		memset(entry, 0, sizeof(*entry));
+		err = ntmp_fdbt_search_port_entry(&priv->ntmp, port,
+						  &resume_eid, entry);
+		if (err || entry->entry_id == NTMP_NULL_ENTRY_ID)
+			break;
+
+		cfg = le32_to_cpu(cfge->cfg);
+		is_static = (cfg & FDBT_DYNAMIC) ? false : true;
+		vid = le16_to_cpu(keye->fid);
+
+		err = cb(keye->mac_addr, vid, is_static, data);
+		if (err)
+			break;
+	} while (resume_eid != NTMP_NULL_ENTRY_ID);
+
+	mutex_unlock(&priv->fdbt_lock);
+	kfree(entry);
+
+	return err;
+}
+
+static int netc_port_mdb_add(struct dsa_switch *ds, int port,
+			     const struct switchdev_obj_port_mdb *mdb,
+			     struct dsa_db db)
+{
+	return netc_port_fdb_add(ds, port, mdb->addr, mdb->vid, db);
+}
+
+static int netc_port_mdb_del(struct dsa_switch *ds, int port,
+			     const struct switchdev_obj_port_mdb *mdb,
+			     struct dsa_db db)
+{
+	return netc_port_fdb_del(ds, port, mdb->addr, mdb->vid, db);
+}
+
+static int netc_port_add_host_flood_rule(struct netc_port *np,
+					 bool uc, bool mc)
+{
+	const u8 dmac_mask[ETH_ALEN] = {0x1, 0, 0, 0, 0, 0};
+	struct netc_switch *priv = np->switch_priv;
+	struct ipft_entry_data *host_flood;
+	struct ipft_keye_data *keye;
+	struct ipft_cfge_data *cfge;
+	u16 src_port;
+	u32 cfg;
+	int err;
+
+	if (!uc && !mc)
+		return 0;
+
+	host_flood = kzalloc_obj(*host_flood);
+	if (!host_flood)
+		return -ENOMEM;
+
+	keye = &host_flood->keye;
+	cfge = &host_flood->cfge;
+
+	src_port = FIELD_PREP(IPFT_SRC_PORT, np->dp->index);
+	src_port |= IPFT_SRC_PORT_MASK;
+	keye->src_port = cpu_to_le16(src_port);
+
+	/* If either only unicast or only multicast need to be flooded
+	 * to the host, we always set the mask that tests the first MAC
+	 * DA octet. The value should be 0 for the first bit (if unicast
+	 * has to be flooded) or 1 (if multicast). If both unicast and
+	 * multicast have to be flooded, we leave the key mask empty, so
+	 * it matches everything.
+	 */
+	if (uc && !mc)
+		ether_addr_copy(keye->dmac_mask, dmac_mask);
+
+	if (!uc && mc) {
+		ether_addr_copy(keye->dmac, dmac_mask);
+		ether_addr_copy(keye->dmac_mask, dmac_mask);
+	}
+
+	cfg = FIELD_PREP(IPFT_FLTFA, IPFT_FLTFA_REDIRECT);
+	cfg |= FIELD_PREP(IPFT_HR, NETC_HR_HOST_FLOOD);
+	cfge->cfg = cpu_to_le32(cfg);
+
+	err = ntmp_ipft_add_entry(&priv->ntmp, host_flood);
+	if (err) {
+		kfree(host_flood);
+		return err;
+	}
+
+	np->uc = uc;
+	np->mc = mc;
+	np->host_flood = host_flood;
+	/* Enable ingress port filter table lookup */
+	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
+
+	return 0;
+}
+
+static void netc_port_remove_host_flood(struct netc_port *np)
+{
+	struct netc_switch *priv = np->switch_priv;
+
+	if (!np->host_flood)
+		return;
+
+	ntmp_ipft_delete_entry(&priv->ntmp, np->host_flood->entry_id);
+	kfree(np->host_flood);
+	np->host_flood = NULL;
+	np->uc = false;
+	np->mc = false;
+	/* Disable ingress port filter table lookup */
+	netc_port_wr(np, NETC_PIPFCR, 0);
+}
+
+static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
+				     bool uc, bool mc)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	if (np->uc == uc && np->mc == mc)
+		return;
+
+	/* IPFT does not support in-place updates to the KEYE element,
+	 * so we need to delete the old IPFT entry and then add a new
+	 * one.
+	 */
+	if (np->host_flood)
+		netc_port_remove_host_flood(np);
+
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
+			port);
+}
+
 static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
 				  struct phylink_config *config)
 {
@@ -810,6 +1329,17 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.setup				= netc_setup,
 	.teardown			= netc_teardown,
 	.phylink_get_caps		= netc_phylink_get_caps,
+	.port_enable			= netc_port_enable,
+	.port_disable			= netc_port_disable,
+	.port_stp_state_set		= netc_port_stp_state_set,
+	.port_change_mtu		= netc_port_change_mtu,
+	.port_max_mtu			= netc_port_max_mtu,
+	.port_fdb_add			= netc_port_fdb_add,
+	.port_fdb_del			= netc_port_fdb_del,
+	.port_fdb_dump			= netc_port_fdb_dump,
+	.port_mdb_add			= netc_port_mdb_add,
+	.port_mdb_del			= netc_port_mdb_del,
+	.port_set_host_flood		= netc_port_set_host_flood,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
@@ -851,6 +1381,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->num_tx_queues = NETC_TC_NUM;
 	ds->ops = &netc_switch_ops;
 	ds->phylink_mac_ops = &netc_phylink_mac_ops;
+	ds->fdb_isolation = true;
 	ds->priv = priv;
 
 	priv->ds = ds;
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index eb65c36ecead..4b229a71578e 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -30,6 +30,8 @@
 
 #define NETC_MAX_FRAME_LEN		9600
 
+#define NETC_STANDALONE_PVID		0
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -43,6 +45,11 @@ struct netc_port_caps {
 	u32 pseudo_link:1;
 };
 
+enum netc_host_reason {
+	/* Software defined host reasons */
+	NETC_HR_HOST_FLOOD = 8,
+};
+
 struct netc_port {
 	void __iomem *iobase;
 	struct netc_switch *switch_priv;
@@ -50,6 +57,11 @@ struct netc_port {
 	struct dsa_port *dp;
 	struct clk *ref_clk; /* RGMII/RMII reference clock */
 	struct mii_bus *emdio;
+
+	u16 enable:1;
+	u16 uc:1;
+	u16 mc:1;
+	struct ipft_entry_data *host_flood;
 };
 
 struct netc_switch_regs {
@@ -58,6 +70,13 @@ struct netc_switch_regs {
 	void __iomem *global;
 };
 
+struct netc_fdb_entry {
+	u32 entry_id;
+	struct fdbt_cfge_data cfge;
+	struct fdbt_keye_data keye;
+	struct hlist_node node;
+};
+
 struct netc_switch {
 	struct pci_dev *pdev;
 	struct device *dev;
@@ -69,6 +88,8 @@ struct netc_switch {
 	struct netc_port **ports;
 
 	struct ntmp_user ntmp;
+	struct hlist_head fdb_list;
+	struct mutex fdbt_lock; /* FDB table lock */
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
@@ -91,6 +112,18 @@ static inline bool is_netc_pseudo_port(struct netc_port *np)
 	return np->caps.pseudo_link;
 }
 
+static inline void netc_add_fdb_entry(struct netc_switch *priv,
+				      struct netc_fdb_entry *entry)
+{
+	hlist_add_head(&entry->node, &priv->fdb_list);
+}
+
+static inline void netc_del_fdb_entry(struct netc_fdb_entry *entry)
+{
+	hlist_del(&entry->node);
+	kfree(entry);
+}
+
 int netc_switch_platform_probe(struct netc_switch *priv);
 
 #endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 6d7758631e61..a2b0c1a712f8 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -67,6 +67,9 @@
 #define  PQOSMR_VQMP			GENMASK(19, 16)
 #define  PQOSMR_QVMP			GENMASK(23, 20)
 
+#define NETC_PIPFCR			0x0084
+#define  PIPFCR_EN			BIT(0)
+
 #define NETC_POR			0x100
 #define  PCR_TXDIS			BIT(0)
 #define  PCR_RXDIS			BIT(1)
@@ -122,6 +125,14 @@ enum netc_mfo {
 #define  BPDVR_RXVAM			BIT(24)
 #define  BPDVR_TXTAGA			GENMASK(26, 25)
 
+#define NETC_BPSTGSR			0x520
+
+enum netc_stg_stage {
+	NETC_STG_STATE_DISABLED = 0,
+	NETC_STG_STATE_LEARNING,
+	NETC_STG_STATE_FORWARDING,
+};
+
 /* Definition of Switch ethernet MAC port registers */
 #define NETC_PMAC_OFFSET		0x400
 #define NETC_PM_CMD_CFG(a)		(0x1008 + (a) * 0x400)
-- 
2.34.1


