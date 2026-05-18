Return-Path: <linuxppc-dev+bounces-21095-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BA9CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:25:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrTm64Tnz3chK;
	Mon, 18 May 2026 18:25:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092732;
	cv=pass; b=WWD+GfT5v/FzG7iEG2JecBnYyCpMZc1yDnlqr+Fk6dpRB+uYOuSuEB3Dy6+dDZMObJeqE3iwdBL2N0TzVR2h4OJ5BEhpTk9rXGwodNvEwiwUVf+12gJXmkqEMaANjHspoFFSm8jm5mUfDBSgOw4ruXeOqYvT6nkRLBfrbtr8ZhTiQNe2T8iWFdzALo8qA0lvRclzqYhBlUcgmx62m3ikuY1MWkGNw0aJ/ixvH68amHRRQNFvc5PtqRADc5cauV51a768rO6ii3OLom68laJ7lme10WNIq9DBH9JgzNyShL880psywpNojSKR4S1EAat+7z6+iUGGAz8QSOzBd/e7EQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092732; c=relaxed/relaxed;
	bh=a/mR9nGypa0ce5ElZvZFmoLBXdjnYpOAKwHiE0wdWek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IkbidPEzumtM+urhQCSTHv4QmB68NZIN9yeicmNsx+WZ70LJRMeD4PB0OQ+FQGRNN7nUa4DoJiSX4Z1gTkJ9vQwrihqFgC0BfXRaz2LhEajpNUhrpyDMzedsNB8Q+mq7zu8sXulgfu9bbGVkEQTuSlUgtHKv5/X9mbzrC38HbqMNFWhvy0JTJVGaBUoTFY/u0e3MNup69eSvTWvLK5+DJtVL6O8nyJDqQ/AghMdAox4Q8avmKORNisfQ5WjqKY0HArpPDYZaDaMXBa3WerH5bDOugI0XqVVEzrfvpmKzCrpGHSzQa0PmrCMYqsRg5itwLtaUqE2UxC1I9gL9PzhCXQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=isa6YLdj; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=isa6YLdj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrTl5Kqsz3bsP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:25:31 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhhMhhEA10w9Gu0+/R8D+iv1kFUJLg4hyB5mWc6yaGrMaNgFOZ2hVmla2auu6Oh+Kd6yVak9Os/PLJnoQ0PyTfVkeBuhToMtwptW4ZimODxYXne8C4CoBoxDpAyYx68fEmmHHOgvJfhqjavg11o9r6Ht+n5PpqEO06fuYDvcIoJZAgv8jogtpukhp6ma8N+V1TRfemOvzfUEwst9MLZrGMb2mx4TYKa3U7tKm88oEuAqd/U72DiEdYkSs1kIc7nl4hUngI15KqZjrbszCJt06kMSju8jEQx9ELjNgH3NmB3dQ6QRNQ4ckmJVjLW1Dloc9fJWsSgN+bDh/A8BYz6B6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/mR9nGypa0ce5ElZvZFmoLBXdjnYpOAKwHiE0wdWek=;
 b=P8jKPBypnmMbZBsDNTnDD858B1RGDZrzNrB5fGIC6ipoJOf5QfIcXbDmC4/ioy2Rr8tDEdEUq1YyGihfYN47K6mb7UgVUA0CDHLthM2YLbW0n6c1//gCcPb7H2kgV+axoo9CLyjZh6CMJmwTFbZS/MCD/squwKCK721PiTa75mwOCcgp90egYTxnlCuaq/KXTlL4o8Y8zKV4imoNH9MnTKey9F+kdsO9+HbNrvLg8khTHV/mU2uE3JkiVkRpllnELFipN9GcKaSss00sjpigSrrLSa0RQwlTpnVdfQBo8lxh/9PKeJdiUEZwpEi+aP30y4KTFNs01Qk3K31RAWTbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/mR9nGypa0ce5ElZvZFmoLBXdjnYpOAKwHiE0wdWek=;
 b=isa6YLdjpqyJKKDl7W+j28dq1lvuAryZfnLENd2FzQHZ/Vc6a3dinrlzUd1YcTTpGtNBZbofSlNKI1Dh5HvB0xmbH1y8cIp/J9GzOBk+HY+ePeJ7jBNLP+gtH+536wDz38f/2fynILhHLsK3otAGL+Ll+PsjFPY/97dcXNDVsx03Fp1pM1RiXjQEB7vBVHd+IefApVRzAQxw8cctR1Fcw5o0MVdu477jwuRAl0w5/u+uybl7oWFttBgYzp3cb1x+NGlJezBI6ME8LIe15rMlsaxhTwLKU/fp6JY8M96yvoYIxh/X9q31uUVjicp7E0fPE0jwquL3izl4HWSffvUj9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 18 May
 2026 08:25:14 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:25:14 +0000
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
Subject: [PATCH v8 net-next 15/15] net: dsa: netc: add support for ethtool private statistics
Date: Mon, 18 May 2026 16:25:06 +0800
Message-Id: <20260518082506.1318236-16-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518082506.1318236-1-wei.fang@nxp.com>
References: <20260518082506.1318236-1-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM9PR04MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: c07cf21a-83df-4343-ee56-08deb4b6fc19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	TkEw8YeWkXVXrggTIEw/tkvGJ3yOriKmPSynReMlGEMxEwJ/yOHvXkOg1ZUEXwHlMT11/iCCvD82xOGbjM9474pHMmLScU4LgCmA+0/wizOTV18i40CDV7cvDvP1WNTMxmq30eKh+lOAY16v7CK61vEdTj3sDbM2Rw5f0oFnZnycdhQYv6sJhzbSQERYa5gHL2sy1EEgKhmQWaCLFuUz3VkxubJyThV/Gka+c5BCogUONxA1IeFttRjWLTDkjnYu3n4qPxxpyCXYvXvmmCDTjCPIHDi0LLBx2XN5Eeq533uKFili/P3vlQhbWV3PLaZKqZOx4es3fJ0Xrd+xj0Ogi8o5pW/EqvXj0022QQMjEOMjXzYHf3TBwweTFysCT7EUZcdOsl2FqM5U8g/49bL15sD9q8f3DCS0iA3tG8pmXyWHKlMirsK9hprScG+BJgj5b5RN9XbNAkGnjEr2OLhq7XwYdzM5B7le4rnSFlQsHACFTe+KyhGhek/OeIdYldzKowRUJSGotnYVFvNC8mPImUftMiQ/4GLOL2pV5wFSBmc2SzSprHdBrvnDad6lky41qwB64WuPzJ4xP6lI9YtId6Bhg9ulvYhDUmXXjDn7K2/oaVxnJIBQBJRnbi5Rp5Yz0ujQtmYwcjmwzNXzBEnHKzbNZ9ctc0X7FNEye2GE5DVkVHrfyLKZ+hym7pTW54BUvC2cGqJ4XRhhpggQBuMvd+iSBAXvOpj0vY0W9PMot+89FFGFaL8fLXovQ+YWiEWX/eiwe4wo9HW7nrsymz+npw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kqh2Zbl/RL9vT1Mu2Qp1mum0+043sMXybgCfEYAmphCuHUTMe+TM0HN0H30w?=
 =?us-ascii?Q?AzbOs262O+G0Yj2Sb0WCM+AE64oJplPFkbE/3Lap24k9rNj4RIeE3qZw+FqF?=
 =?us-ascii?Q?jz2nuIGhLwr9UkSP9sXh19zBbka758AmqNQF2AnNfkI2r0dism5NXEPeo5up?=
 =?us-ascii?Q?dmxqjC/UQfL/vJJ/oU52drwHIAqdRIm3z6ikAma/jmP3BJGXv48BBxnEzA0W?=
 =?us-ascii?Q?UUD1Wkzx9rGwmQg9AaITqEMzEcaAGFeM8IcerQM8z3tOezbo9oEJANGspiRp?=
 =?us-ascii?Q?uPvlJayZiSZS5K44Ckh5VZG5114xlC9vYB5QpAPSWnW1fMHPYg0ddg3hsQ/Z?=
 =?us-ascii?Q?1GamWJZ7khCtrTZdnaIllmuaa/b54ylacIXFYMDFj1/yRgs6yBkcakev4Hgr?=
 =?us-ascii?Q?UTxaQ3x71Gs47+uNNign6tySMfW1lHHd9gzdVAld1jWPe4AAKCvoktIXXLHd?=
 =?us-ascii?Q?Pd3ZN7mGlyYNwMle+Art+KfJrSWIj3BbAU/k6XLUFn8gcz+w0JXA6MZIAYfH?=
 =?us-ascii?Q?Q3FbxgtkwEZT6mQKoLSb8gz/0AWiOJsB+q9qtHg4x8UrevgNPaNINB13ZE/z?=
 =?us-ascii?Q?/z5HBrTR0+qNuU+u4ES8hUfAfMpjFxo7HbU/gAnOeFCBp3gmq6YzOIuVNSrv?=
 =?us-ascii?Q?ZPGEAFoAHyX5DJZsG4TgWOWj91QoBRuFz8iATovWvJoNBBHtSyhDtFvwrVEy?=
 =?us-ascii?Q?2unxgs7yeEdh3rGQdGM2p3MDRBuvW8dEKOTTzUpHexVDXMJM+9VpOLB/L4B5?=
 =?us-ascii?Q?5i/epAtg5IES/pjmS48QAwyt93sbyIDbEfbhveMG5v6SfmZ3b+UokuvqfunC?=
 =?us-ascii?Q?V2Vcp6O9x3sJxeonHgVHka4jZwoUfTGEgsmZ55MrfX0B2pV3jqaKnOkzO3bo?=
 =?us-ascii?Q?6Pa6s3YnsoZCjlxJIOIojkIAsfKT79TPxA/aUkX0CTlEV5fzr7yK1jeH7rTL?=
 =?us-ascii?Q?U+NIenSNQPZYVAKdafzdsLEPXep6u68QoVJ1DB2owkGBma5JZml2RcJuTQQn?=
 =?us-ascii?Q?k6QVa21xP/4Ip57PV00z6SGXtdDVbBlI02rOW9N/2TYBIy+6gkAkalqXNZad?=
 =?us-ascii?Q?Ml9QxHxAfzTXbI3lXOa8P7C8m0BpS7C+PXIPlue7pLF3fBfrCexqxbeBIWeY?=
 =?us-ascii?Q?6DP9K9P5ilCXRgqVyouzn0LMCXfAuXMmlfFquLklNCjnUprAUJ6nLHmkcSIm?=
 =?us-ascii?Q?kQpZljjhdTkXDjOZtjm2gCtVMdK2lMnoefFfpnY8/kBsuGUDkbo2aZ2Bbkqa?=
 =?us-ascii?Q?z7lb6ZuBfC5uBe4ZZa4yW828cOUCeX0B6VeKgRWPdCZ/xakyt26hWQpX4Dri?=
 =?us-ascii?Q?Izq0PisnYVbTSw8lEIXRyeB9ofJKT7re6f72J6P5G1mwO7ykilNhXvUxuANv?=
 =?us-ascii?Q?Ys2dtZvx9sGiY15EJ5qqtBAgb3lqwCweF/KnN1gMHiFAtPbZBBRB7jEnyEvq?=
 =?us-ascii?Q?FKsVL47yF7u0YJcMmQ646c1QaljUURS42I7wkVjugaMS+isEeMD/GoNqIUy4?=
 =?us-ascii?Q?0boH20DVDjJMf316STsC9TT7WtMlVHQodSz1ygUyXnnNhllT8z0k4i8cehwz?=
 =?us-ascii?Q?1Cq516bv16xTXIZifBvrgePBGytWg8fhZaze6DJmoMA+nawcv8PKY59id047?=
 =?us-ascii?Q?1vK8fgxD6sH9sdMKuX0Wx9W5XjqowpQoQCpIXWhOZMCGXyoGY9mfKAWSZ1gU?=
 =?us-ascii?Q?wxiyZMwchqLvPSFK0Iri4H72lOVE+8vlDymvjDHRhkvwWgB4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07cf21a-83df-4343-ee56-08deb4b6fc19
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:25:14.2413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8J8AGx8A1A0+SqFixUe+0UV9mJ/C7zuYNvm0U3W2ThStFPktikrUXYSJ/YYm7WC+8sZliKAdehtbmDsPVcnOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8938

Implement the ethtool private statistics interface to expose additional
port-level and MAC-level counters that are not covered by the standard
IEEE 802.3 statistics. The pMAC counters are only reported when the port
supports Frame Preemption (802.1Qbu/802.3br).

Note that although rtnl_link_stats64 provides some standard statistics
such as rx octets, rx frame errors, rx dropped packets, and tx packets,
these are overall port statistics. The NETC switch supports preemption
on each port, and each port has two MACs (eMAC and pMAC). The driver
private statistics are used to obtain statistics for each MAC, allowing
users to perform analysis and debugging.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_ethtool.c   | 101 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_main.c      |   3 +
 drivers/net/dsa/netc/netc_switch.h    |   9 +++
 drivers/net/dsa/netc/netc_switch_hw.h |  52 +++++++++++++
 4 files changed, 165 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_ethtool.c b/drivers/net/dsa/netc/netc_ethtool.c
index ac8940b5a85c..e6028851a6d0 100644
--- a/drivers/net/dsa/netc/netc_ethtool.c
+++ b/drivers/net/dsa/netc/netc_ethtool.c
@@ -19,6 +19,50 @@ static const struct ethtool_rmon_hist_range netc_rmon_ranges[] = {
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
+	{ NETC_BPDCR,		"bridge port discard frames" },
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
@@ -188,3 +232,60 @@ void netc_port_get_eth_mac_stats(struct dsa_switch *ds, int port,
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
index f3ab0c7646da..fa7dd307ce13 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1491,6 +1491,9 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.get_rmon_stats			= netc_port_get_rmon_stats,
 	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
 	.get_eth_mac_stats		= netc_port_get_eth_mac_stats,
+	.get_sset_count			= netc_port_get_sset_count,
+	.get_strings			= netc_port_get_strings,
+	.get_ethtool_stats		= netc_port_get_ethtool_stats,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index ed83201d128b..4fbd12825b67 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -94,6 +94,11 @@ struct netc_fdb_entry {
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
@@ -160,5 +165,9 @@ void netc_port_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 				  struct ethtool_eth_ctrl_stats *ctrl_stats);
 void netc_port_get_eth_mac_stats(struct dsa_switch *ds, int port,
 				 struct ethtool_eth_mac_stats *mac_stats);
+int netc_port_get_sset_count(struct dsa_switch *ds, int port, int sset);
+void netc_port_get_strings(struct dsa_switch *ds, int port,
+			   u32 sset, u8 *data);
+void netc_port_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data);
 
 #endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index f4e8ef983c21..1d976882a6cc 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -98,6 +98,14 @@
 #define  PSR_TX_BUSY			BIT(0)
 #define  PSR_RX_BUSY			BIT(1)
 
+#define NETC_PTGSLACR			0x130
+
+#define NETC_PRXDCR			0x1c0
+#define NETC_PRXDCRRR			0x1c4
+#define NETC_PRXDCRR0			0x1c8
+#define NETC_PRXDCRR1			0x1cc
+#define NETC_PTXDCR			0x1e0
+
 #define NETC_PTCTMSDUR(a)		(0x208 + (a) * 0x20)
 #define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
 #define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
@@ -105,6 +113,9 @@
 #define   SDU_TYPE_MPDU			1
 #define   SDU_TYPE_MSDU			2
 
+#define NETC_PSDFTCR			0x4c4
+#define NETC_PSDFDDCR			0x4c8
+
 #define NETC_BPCR			0x500
 #define  BPCR_DYN_LIMIT			GENMASK(15, 0)
 #define  BPCR_MLO			GENMASK(22, 20)
@@ -153,6 +164,8 @@ enum netc_stg_stage {
 	NETC_STG_STATE_FORWARDING,
 };
 
+#define NETC_BPDCR			0x580
+
 /* Definition of Switch ethernet MAC port registers */
 #define NETC_PMAC_OFFSET		0x400
 #define NETC_PM_CMD_CFG(a)		(0x1008 + (a) * 0x400)
@@ -187,6 +200,9 @@ enum netc_stg_stage {
 /* Port MAC 0/1 Receive Ethernet Octets Counter */
 #define NETC_PM_REOCT(a)		(0x1100 + (a) * 0x400)
 
+/* Port MAC 0/1 Receive Octets Counter */
+#define NETC_PM_ROCT(a)			(0x1108 + (a) * 0x400)
+
 /* Port MAC 0/1 Receive Alignment Error Counter Register */
 #define NETC_PM_RALN(a)			(0x1110 + (a) * 0x400)
 
@@ -199,12 +215,27 @@ enum netc_stg_stage {
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
 
@@ -247,6 +278,9 @@ enum netc_stg_stage {
 /* Port MAC 0/1 Transmit Ethernet Octets Counter */
 #define NETC_PM_TEOCT(a)		(0x1200 + (a) * 0x400)
 
+/* Port MAC 0/1 Transmit Octets Counter */
+#define NETC_PM_TOCT(a)			(0x1208 + (a) * 0x400)
+
 /* Port MAC 0/1 Transmit Excessive Deferral Packet Counter */
 #define NETC_PM_TEDFR(a)		(0x1210 + (a) * 0x400)
 
@@ -256,15 +290,30 @@ enum netc_stg_stage {
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
 
@@ -304,6 +353,9 @@ enum netc_stg_stage {
 /* Port MAC 0/1 Transmit Excessive Collisions Counter */
 #define NETC_PM_TECOL(a)		(0x12f0 + (a) * 0x400)
 
+/* Port MAC 0/1 Transmit Invalid Octets Counter */
+#define NETC_PM_TIOCT(a)		(0x12f8 + (a) * 0x400)
+
 #define NETC_PEMDIOCR			0x1c00
 #define NETC_EMDIO_BASE			NETC_PEMDIOCR
 
-- 
2.34.1


