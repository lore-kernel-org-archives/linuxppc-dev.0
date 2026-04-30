Return-Path: <linuxppc-dev+bounces-20318-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55E8FF887E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 02:49:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5dt943D0z2y8W;
	Thu, 30 Apr 2026 12:49:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777517361;
	cv=pass; b=O9FNFFn5xNuA0iLKMswEa09+istJ7juf6SAD9uIRDxuPJXVvFwfr5SpFnAdGyc2SfnYum2uBxzYS9uDpu5D2MISAskjYykxx/UV0P1JbA7aY9N7hvjbkhExIoZG0lgi1QtVOKAV+CXdb7dg4241QYSEYiGWL9xHugmpeMvRoGei3MvPISNtkjgjn2eQDWEAOsdkdXzi0n2UZhFf9//79EMPsi3vuiSJIzZ1NI+V49/4QZlM1qePCxsy+JNULokHActURCOgJShWFPdR4xJKp5K4/Tgn5Zk2YlfN51cw6ePjiVLX819Dr/w3OITmnIwOcSsyInurP7KyGU83a1rzvbA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777517361; c=relaxed/relaxed;
	bh=vpFP/5ZCJ+bg+eA8fAjzxurulz/xwiGFfOFB8EZy15M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4Plz0yuqaWDBqsYKUXxLjfyT5VM9B/kLhCvD61/1a46knN/MXcqDvxmZBymlQQtAAgDisrJneYRaw78PHkM2AYiaUFvo0srGusoRMlNy0Py1KlBdGoA6kwvAzJwTbdWLfYklDcx6Jv42xnH0G2oxa2zrAlGTORg2Y7vSfj4Xlktb95TkIjZGHOxZLzr6u835zm3r5OrfaRWf9GyiWwCNdyfOiFau6rmgbv7CBrB9SNx4+dTbo+A5480n8xB8ZcYrccpypa22yuNh/D4uW1k48P00Fu6hY6GiiG9qsIyrVE/LblbXCrn7Pi3P8nScQkhriIrKn0QTaxwOkfDy95iyQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EvXjKQT5; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EvXjKQT5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5dt82rrnz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 12:49:20 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuj43wRpCeIZmUELR+JnoBGIFtlEfDP3n8HR5BX9x+scOWR+9cSBwa2/ltDdn5yu1j8oOLUwkZy3Tgm60/uvJ894uudPtQhdf80cbUnu9Y269MBXgbYZr/T2YnVhovQUe4hWg2Bs6erR3oQmQWQ7GhiOX628VcFp1el/obsD06GXl0cQC/fyOWANpYjZo+2LQqjWUTjONcX9bZjLPol0KKMewR8/LrIbiB0WAgUv78yFrtm/awV7Ulck7u+f930RD4PdXrSgAuR0UQbWlXYYCpV7WKcVEUrmOAsLnUhcZAfwZ3C3+M9Get0UBTuB7lFDO601q4fr24nTRArmhVYdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpFP/5ZCJ+bg+eA8fAjzxurulz/xwiGFfOFB8EZy15M=;
 b=iE3jwqdHG95wOf/jU1H2cJby+0lOt39l9dLWAyWAUwhKTIvlwH5HBtjXHilBnvzW5jwXv30vXDkpnbThfjYeV0hLDp2fpfpjBfQZ0FsuYkb7GHYLXX0sfPni4jNDbY4OSD4g8egBuDFx4td/5/sQi3L0xCgtwytlShZk5qyimFVOkeVSMCEtbtuzcad7i+r0ilUAe8jXAoIX3H+a5/kmvW6GuODGT29CDcIJPkFOsCvehqWoYAjdMClQU/LcDnIifCCvDQJzgN3MsHb9mXg4xbYFp8yZ6Pmh0prudmy5dwX2isbuNiF519EwU77ldcYAIXSsWE9xrqLBruy5ymnpTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpFP/5ZCJ+bg+eA8fAjzxurulz/xwiGFfOFB8EZy15M=;
 b=EvXjKQT5p2zCiDg8Yl75PMssrIwkePgjzkv4NwNQ2Ya9qDMuT771lWPf/+IRnHFWw962QuIcq+dL2GFs5G4a8qRkB+NnNdBypLXausmI1SCJDuec9XpfO2nyZPBkC9f2vOCpV0FtVA9Ov23vWoh89Wah6fZ02+WosUZzsvenPyGLyGTDeXx1p1aw++mukUYHfkhI4rxuEEBlWu0TQ8aZDtJq9Z1M8u3cfNll6/OX5PI9atGK8AToSi2uM2JVGs4Jg9NUlh9z77GrwETXKxHQFQVvJTG5bnaNjWmMSw9d9/l/nbwyR/L2DrR7lJgnQkUEM+83bZkea5iaBsANjxTBWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:49:17 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:49:16 +0000
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
Subject: [PATCH v5 net-next 15/15] net: dsa: netc: add support for ethtool private statistics
Date: Thu, 30 Apr 2026 10:49:45 +0800
Message-Id: <20260430024945.3413973-16-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430024945.3413973-1-wei.fang@nxp.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 863931bb-7cda-4160-efcb-08dea66311ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	omkXyNqJzMUGvrDATze0xn9OEWc4fUSp1dYH+xQUKQU2bVai8fbNN2mpEIu4MuOS8/76Wh8QWxrymBPS9msNapZoAdYzkrL1le+ZnAhfUlM+3q8uSWTStc84WKdML/yQhjmqai2ZntxDVBwx/M2Tl3iQBlM3x35dRKl2pmwco2bFsy70DzF8mgvNmBgY9C87FuPY4vBIMGKnJqAlOzEEWPll6mSkjuf+8uvDRHfSmuzzqciH72k2CE1QTpCb/K2kWRuu4v5z82pKTQjDEJaz9c7DNoq3wyn/YN5Md8Ttt71q1WR2lmNkgExIUpkCrIwdZWFZVYjWlhiQbehMS7fbOdn3JxDc9TwL9ENWxB9tC0o+NltP+n9iLJ+l8czjAjrLNPXhk7WFd3YBKoVRzma1gaNaJ673SL/3CUtXU1/nMq476uXJSJ4R/kTpUOGlZL41JX69Ui4w53kr6WpEdvctlO7mkXEq2iQOubJQ0v8h2/jfBp4jzO1wiGBXOwcGimaSDrgIhEFBF0FIV81rFzB5YqS+u1sFPY1jnamoU9xykd9u2xl7++DiRBSaASKSZ9Cvij2+uL+cqPia1qxC93/seQh01lzvxFctgIA35LmE5bN6ZXRzJyhU6fnc6X62zJbQ6rCKiI6J96SZqNVBwnLMs8hf5BnGILDJ7/1GPguwT13a52Pwu35HxgWOs0dL59nwzQaBz2R2ecSKVE33daaRH9u2E3hBSb+OXBKFeW/DOuKdXo+o1Fo+vSZ8UZxAqvddwFx4/EXsmPG0maH+q5gKaWhm4UNnJu6KW5h5mtJ7A0oYx8EDEtr8KqLfNP0RcxEd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JBpH7BX7f7Gq3dpgp2ycQ3ARnmRZoCB+cM2H38SjeO7i3E0knbUJrvC+brS9?=
 =?us-ascii?Q?OIOozH6JFM4E5SAsXUsuxbL94IJ8xAuvkMACcE5zgQqYSy+tFXPplvfUtWsL?=
 =?us-ascii?Q?AJwA5OqBpFn0NSTFhWX5D13mOlyVJSVu+gCiV2JniaY0lr8GBclwk/iF4M2H?=
 =?us-ascii?Q?p8ulSqPB6ft27kCn2Vv6BOGEou7ZxuU01ERG0+uml7jvz5+A+lRptYdyZE1D?=
 =?us-ascii?Q?XDxmWrxKG1S/aajDm5erFKHrL4ThrRKrah5HFCLu56IqC26xgSBbmVPRvP36?=
 =?us-ascii?Q?CUv7JnYIA2kQPNVbfCjnSAcfpTNLnXOQOPKpjEW70B+9dEUPDl4/iCYB3rUD?=
 =?us-ascii?Q?dobGyduwZDRV+N3+zN6hTawO89OPtHVSJpVDwWbDGVZt++8ZofLcKi3Ai16D?=
 =?us-ascii?Q?Pdp2jUre+k/q4/yUwaVO/X2+bM8sAvWZbub1LdaP2E0Gy0TA8QQ92db1gyND?=
 =?us-ascii?Q?buo1phbkveCE9o6zmirFPYZVofDA72ZbN11dhUNFJwNAVXO7YU/CcvYGpReO?=
 =?us-ascii?Q?vH49CDqvpCnQp78xZWID9+V9TBK5jPRtIvAEI8eStBXoGJVVdqO2gOg+XPqi?=
 =?us-ascii?Q?lO5ZtEWIOrfK3FNpWp/ZqoRBBj2tfV3jOJohIem5cfH32LZDPbV649UzoiBG?=
 =?us-ascii?Q?rqSAH+9NieJFQH86VAUU9GB8yFEAIq2NyUMsIuvB/c2GFM1KF/ai4bjQyQHH?=
 =?us-ascii?Q?veyaNnfrZ+kuA9e5vPBCFN3EIYytk8NTRlBOjXa9TQSovMEFis/GogIuq+0x?=
 =?us-ascii?Q?pVdDbsixE8PJQnORP1pFBu62wue4o1Ja99OJ+3LACIN40wIs4V7dpEskQVq3?=
 =?us-ascii?Q?pnwHggfUK9IG0SevegjLNaWUi/ok099Bksfw9CfgSTYgOMLCA8WZAP6Qx9UA?=
 =?us-ascii?Q?sUkFp7OamZ8mw5t4mi0p4DrImFCxAquLCLArTBNEvVdYs8GnaGFevw0MB2+B?=
 =?us-ascii?Q?Y0k/1crRI0OLUMhEPspdA1afHWKn9MDhwE/lzrWYq6VZzHi6E92NJGkPBG+s?=
 =?us-ascii?Q?AOkmQV71gkq0bMah22rTSRiltKClIue9DVbzlctjBEmYMSrkhTOW0zKxNTic?=
 =?us-ascii?Q?kPUDAwDM+fiKLJOcErf5kxFM3y+SFqAl+/gUhZs4OzsUUGSFHTVrvdq90O7b?=
 =?us-ascii?Q?cQ5iLnpC31DOho6TuLMh8bA6VV92opyj9JXuOiW7ffZkCF5weymwKSdE0wrZ?=
 =?us-ascii?Q?JR9BOfFgDTobyWpiBSNU6mKyPmAFp5jsjQjC6hwL3YYRqokcId76yJZatZ/4?=
 =?us-ascii?Q?HvBu5L2/t0J/KV5UT78miF0B94ZCeQEnnjwLhLpq2BRircNTMuUvTSwKav2Z?=
 =?us-ascii?Q?p674U/opKk/gvFmtlbjZ4rSJuWXVReObUFkf2hiobtU2dtavuAYlguEE1kUD?=
 =?us-ascii?Q?9aNQ+WQHE6vxoKNXDgraW1uecMkaz/QkUaX5GoW9r9HjvMV6h2wHQFiUhDq4?=
 =?us-ascii?Q?gfBXbQ4ag9awia6TooB9ZpuG8Q/abxW4dD5rwvWGUxsGFEn2v2Q2LuyOrpir?=
 =?us-ascii?Q?YvKa4fXcmrWk7cmfcKjeVtyiSQb+xCrl6ON1aj3Zy2NGvU41ikpPJePLWvA9?=
 =?us-ascii?Q?RrWyYMLteVvpAJYWGV+aXgl0Q9SBu7LYCPGeEFYeNmDLxJsHdsaBWUQErh3r?=
 =?us-ascii?Q?Jpn0fO78EEA+vnliG8Wfkmtk/OFRuSzf15Gy6qW9oh3JwQQjzX7Wlv9tMlUn?=
 =?us-ascii?Q?bDAn//eDZv2Qmn/3zm8Sy9QFCGCGCTITl9PKFRkxYXdI4s0z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863931bb-7cda-4160-efcb-08dea66311ef
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:49:16.7887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJvxUT4lYrDZnenDWCA7PU9Lz0/FgxVz0efCUqFi+NeaLUvEHZL4HltcUQ35qe63V0zRojy0QNAkVeDlbsnSkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608

Implement the ethtool private statistics interface to expose additional
port-level and MAC-level counters that are not covered by the standard
IEEE 802.3 statistics. The pMAC counters are only reported when the port
supports Frame Preemption (802.1Qbu/802.3br).

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_ethtool.c   | 107 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_main.c      |   3 +
 drivers/net/dsa/netc/netc_switch.h    |   9 +++
 drivers/net/dsa/netc/netc_switch_hw.h |  58 ++++++++++++++
 4 files changed, 177 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_ethtool.c b/drivers/net/dsa/netc/netc_ethtool.c
index ac8940b5a85c..8d04db534347 100644
--- a/drivers/net/dsa/netc/netc_ethtool.c
+++ b/drivers/net/dsa/netc/netc_ethtool.c
@@ -19,6 +19,56 @@ static const struct ethtool_rmon_hist_range netc_rmon_ranges[] = {
 	{ }
 };
 
+static const struct netc_port_stat netc_port_counters[] = {
+	{ NETC_PTGSLACR,	"port gate late arrival frames" },
+	{ NETC_PSDFTCR,	"port SDF transmit frames" },
+	{ NETC_PSDFDDCR,	"port SDF drop duplicate frames" },
+	{ NETC_PRXDCR,		"port rx discard frames" },
+	{ NETC_PRXDCRRR,	"port rx discard read-reset" },
+	{ NETC_PRXDCRR0,	"port rx discard reason 0" },
+	{ NETC_PRXDCRR1,	"port rx discard reason 1" },
+	{ NETC_PTXDCR,		"port tx discard frames" },
+	{ NETC_PTXDCRRR,	"port tx discard read-reset" },
+	{ NETC_PTXDCRR0,	"port tx discard reason 0" },
+	{ NETC_PTXDCRR1,	"port tx discard reason 1" },
+	{ NETC_BPDCR,		"bridge port discard frames" },
+	{ NETC_BPDCRRR,	"bridge port discard read-reset" },
+	{ NETC_BPDCRR0,	"bridge port discard reason 0" },
+	{ NETC_BPDCRR1,	"bridge port discard reason 1" },
+};
+
+static const struct netc_port_stat netc_emac_counters[] = {
+	{ NETC_PM_ROCT(0),	"eMAC rx octets" },
+	{ NETC_PM_RVLAN(0),	"eMAC rx VLAN frames" },
+	{ NETC_PM_RERR(0),	"eMAC rx frame errors" },
+	{ NETC_PM_RUCA(0),	"eMAC rx unicast frames" },
+	{ NETC_PM_RDRP(0),	"eMAC rx dropped packets" },
+	{ NETC_PM_RPKT(0),	"eMAC rx packets" },
+	{ NETC_PM_TOCT(0),	"eMAC tx octets" },
+	{ NETC_PM_TVLAN(0),	"eMAC tx VLAN frames" },
+	{ NETC_PM_TFCS(0),	"eMAC tx FCS errors" },
+	{ NETC_PM_TUCA(0),	"eMAC tx unicast frames" },
+	{ NETC_PM_TPKT(0),	"eMAC tx packets" },
+	{ NETC_PM_TUND(0),	"eMAC tx undersized packets" },
+	{ NETC_PM_TIOCT(0),	"eMAC tx invalid octets" },
+};
+
+static const struct netc_port_stat netc_pmac_counters[] = {
+	{ NETC_PM_ROCT(1),	"pMAC rx octets" },
+	{ NETC_PM_RVLAN(1),	"pMAC rx VLAN frames" },
+	{ NETC_PM_RERR(1),	"pMAC rx frame errors" },
+	{ NETC_PM_RUCA(1),	"pMAC rx unicast frames" },
+	{ NETC_PM_RDRP(1),	"pMAC rx dropped packets" },
+	{ NETC_PM_RPKT(1),	"pMAC rx packets" },
+	{ NETC_PM_TOCT(1),	"pMAC tx octets" },
+	{ NETC_PM_TVLAN(1),	"pMAC tx VLAN frames" },
+	{ NETC_PM_TFCS(1),	"pMAC tx FCS errors" },
+	{ NETC_PM_TUCA(1),	"pMAC tx unicast frames" },
+	{ NETC_PM_TPKT(1),	"pMAC tx packets" },
+	{ NETC_PM_TUND(1),	"pMAC tx undersized packets" },
+	{ NETC_PM_TIOCT(1),	"pMAC tx invalid octets" },
+};
+
 static void netc_port_pause_stats(struct netc_port *np, int mac,
 				  struct ethtool_pause_stats *stats)
 {
@@ -188,3 +238,60 @@ void netc_port_get_eth_mac_stats(struct dsa_switch *ds, int port,
 		break;
 	}
 }
+
+int netc_port_get_sset_count(struct dsa_switch *ds, int port, int sset)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	int size;
+
+	if (sset != ETH_SS_STATS)
+		return -EOPNOTSUPP;
+
+	size = ARRAY_SIZE(netc_port_counters) +
+	       ARRAY_SIZE(netc_emac_counters);
+
+	if (np->caps.pmac)
+		size += ARRAY_SIZE(netc_pmac_counters);
+
+	return size;
+}
+
+void netc_port_get_strings(struct dsa_switch *ds, int port,
+			   u32 sset, u8 *data)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	int i;
+
+	if (sset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(netc_port_counters); i++)
+		ethtool_cpy(&data, netc_port_counters[i].name);
+
+	for (i = 0; i < ARRAY_SIZE(netc_emac_counters); i++)
+		ethtool_cpy(&data, netc_emac_counters[i].name);
+
+	if (!np->caps.pmac)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(netc_pmac_counters); i++)
+		ethtool_cpy(&data, netc_pmac_counters[i].name);
+}
+
+void netc_port_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(netc_port_counters); i++)
+		*data++ = netc_port_rd(np, netc_port_counters[i].reg);
+
+	for (i = 0; i < ARRAY_SIZE(netc_emac_counters); i++)
+		*data++ = netc_port_rd64(np, netc_emac_counters[i].reg);
+
+	if (!np->caps.pmac)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(netc_pmac_counters); i++)
+		*data++ = netc_port_rd64(np, netc_pmac_counters[i].reg);
+}
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index ae8f28b82b72..803582d939b0 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1472,6 +1472,9 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.get_rmon_stats			= netc_port_get_rmon_stats,
 	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
 	.get_eth_mac_stats		= netc_port_get_eth_mac_stats,
+	.get_sset_count			= netc_port_get_sset_count,
+	.get_strings			= netc_port_get_strings,
+	.get_ethtool_stats		= netc_port_get_ethtool_stats,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index d477b0cd2157..90d750331fb9 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -93,6 +93,11 @@ struct netc_fdb_entry {
 	struct hlist_node node;
 };
 
+struct netc_port_stat {
+	int reg;
+	char name[ETH_GSTRING_LEN] __nonstring;
+};
+
 struct netc_switch {
 	struct pci_dev *pdev;
 	struct device *dev;
@@ -159,5 +164,9 @@ void netc_port_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 				  struct ethtool_eth_ctrl_stats *ctrl_stats);
 void netc_port_get_eth_mac_stats(struct dsa_switch *ds, int port,
 				 struct ethtool_eth_mac_stats *mac_stats);
+int netc_port_get_sset_count(struct dsa_switch *ds, int port, int sset);
+void netc_port_get_strings(struct dsa_switch *ds, int port,
+			   u32 sset, u8 *data);
+void netc_port_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data);
 
 #endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index f8d436ad9623..1b016e7dd03e 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -87,6 +87,17 @@
 #define  PSR_TX_BUSY			BIT(0)
 #define  PSR_RX_BUSY			BIT(1)
 
+#define NETC_PTGSLACR			0x130
+
+#define NETC_PRXDCR			0x1c0
+#define NETC_PRXDCRRR			0x1c4
+#define NETC_PRXDCRR0			0x1c8
+#define NETC_PRXDCRR1			0x1cc
+#define NETC_PTXDCR			0x1e0
+#define NETC_PTXDCRRR			0x1e4
+#define NETC_PTXDCRR0			0x1e8
+#define NETC_PTXDCRR1			0x1ec
+
 #define NETC_PTCTMSDUR(a)		(0x208 + (a) * 0x20)
 #define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
 #define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
@@ -94,6 +105,9 @@
 #define   SDU_TYPE_MPDU			1
 #define   SDU_TYPE_MSDU			2
 
+#define NETC_PSDFTCR			0x4c4
+#define NETC_PSDFDDCR			0x4c8
+
 #define NETC_BPCR			0x500
 #define  BPCR_DYN_LIMIT			GENMASK(15, 0)
 #define  BPCR_MLO			GENMASK(22, 20)
@@ -142,6 +156,11 @@ enum netc_stg_stage {
 	NETC_STG_STATE_FORWARDING,
 };
 
+#define NETC_BPDCR			0x580
+#define NETC_BPDCRRR			0x584
+#define NETC_BPDCRR0			0x588
+#define NETC_BPDCRR1			0x58c
+
 /* Definition of Switch ethernet MAC port registers */
 #define NETC_PMAC_OFFSET		0x400
 #define NETC_PM_CMD_CFG(a)		(0x1008 + (a) * 0x400)
@@ -176,6 +195,9 @@ enum netc_stg_stage {
 /* Port MAC 0/1 Receive Ethernet Octets Counter */
 #define NETC_PM_REOCT(a)		(0x1100 + (a) * 0x400)
 
+/* Port MAC 0/1 Receive Octets Counter */
+#define NETC_PM_ROCT(a)			(0x1108 + (a) * 0x400)
+
 /* Port MAC 0/1 Receive Alignment Error Counter Register */
 #define NETC_PM_RALN(a)			(0x1110 + (a) * 0x400)
 
@@ -188,12 +210,27 @@ enum netc_stg_stage {
 /* Port MAC 0/1 Receive Frame Check Sequence Error Counter */
 #define NETC_PM_RFCS(a)			(0x1128 + (a) * 0x400)
 
+/* Port MAC 0/1 Receive VLAN Frame Counter */
+#define NETC_PM_RVLAN(a)		(0x1130 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Error Counter */
+#define NETC_PM_RERR(a)			(0x1138 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Unicast Frame Counter */
+#define NETC_PM_RUCA(a)			(0x1140 + (a) * 0x400)
+
 /* Port MAC 0/1 Receive Multicast Frame Counter */
 #define NETC_PM_RMCA(a)			(0x1148 + (a) * 0x400)
 
 /* Port MAC 0/1 Receive Broadcast Frame Counter */
 #define NETC_PM_RBCA(a)			(0x1150 + (a) * 0x400)
 
+/* Port MAC 0/1 Receive Dropped Packets Counter */
+#define NETC_PM_RDRP(a)			(0x1158 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Packets Counter */
+#define NETC_PM_RPKT(a)			(0x1160 + (a) * 0x400)
+
 /* Port MAC 0/1 Receive Undersized Packet Counter */
 #define NETC_PM_RUND(a)			(0x1168 + (a) * 0x400)
 
@@ -236,6 +273,9 @@ enum netc_stg_stage {
 /* Port MAC 0/1 Transmit Ethernet Octets Counter */
 #define NETC_PM_TEOCT(a)		(0x1200 + (a) * 0x400)
 
+/* Port MAC 0/1 Transmit Octets Counter */
+#define NETC_PM_TOCT(a)			(0x1208 + (a) * 0x400)
+
 /* Port MAC 0/1 Transmit Excessive Deferral Packet Counter */
 #define NETC_PM_TEDFR(a)		(0x1210 + (a) * 0x400)
 
@@ -245,15 +285,30 @@ enum netc_stg_stage {
 /* Port MAC 0/1 Transmit Frame Counter */
 #define NETC_PM_TFRM(a)			(0x1220 + (a) * 0x400)
 
+/* Port MAC 0/1 Transmit Frame Check Sequence Error Counter */
+#define NETC_PM_TFCS(a)			(0x1228 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit VLAN Frame Counter */
+#define NETC_PM_TVLAN(a)		(0x1230 + (a) * 0x400)
+
 /* Port MAC 0/1 Transmit Frame Error Counter */
 #define NETC_PM_TERR(a)			(0x1238 + (a) * 0x400)
 
+/* Port MAC 0/1 Transmit Unicast Frame Counter */
+#define NETC_PM_TUCA(a)			(0x1240 + (a) * 0x400)
+
 /* Port MAC 0/1 Transmit Multicast Frame Counter */
 #define NETC_PM_TMCA(a)			(0x1248 + (a) * 0x400)
 
 /* Port MAC 0/1 Transmit Broadcast Frame Counter */
 #define NETC_PM_TBCA(a)			(0x1250 + (a) * 0x400)
 
+/* Port MAC 0/1 Transmit Packets Counter */
+#define NETC_PM_TPKT(a)			(0x1260 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Undersized Packet Counter */
+#define NETC_PM_TUND(a)			(0x1268 + (a) * 0x400)
+
 /* Port MAC 0/1 Transmit 64-Octet Packet Counter */
 #define NETC_PM_T64(a)			(0x1270 + (a) * 0x400)
 
@@ -293,6 +348,9 @@ enum netc_stg_stage {
 /* Port MAC 0/1 Transmit Excessive Collisions Counter */
 #define NETC_PM_TECOL(a)		(0x12f0 + (a) * 0x400)
 
+/* Port MAC 0/1 Transmit Invalid Octets Counter */
+#define NETC_PM_TIOCT(a)		(0x12f8 + (a) * 0x400)
+
 #define NETC_PEMDIOCR			0x1c00
 #define NETC_EMDIO_BASE			NETC_PEMDIOCR
 
-- 
2.34.1


