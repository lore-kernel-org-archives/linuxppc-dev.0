Return-Path: <linuxppc-dev+bounces-20648-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57B3CD3447
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 10:30:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCMgC13c2z2y2B;
	Sat, 09 May 2026 20:29:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778322583;
	cv=pass; b=kY73ibiPylejUtOhnTQz4oSakte/5yJklSi4PuUtg15odzYeIixlBtZuVJQgn86XUYDqmbCfz+TPZeyqUG9Hv0iJ0QssANd4Iq3bPs3/AVR6GO5mayzHVoMIznZeF0JVU+IGmvKnzPKhLNytikdnHYAUcwKa9BQOP0n/HFTLypUtA2jz9clvJz++crfpYvRgBGQJiaEUIQRcMPX0/sLHX0j9GtAWDswWFDHYNvbYStO/6Chevif+rWBQ8N+q0oVV4cW1jwDnrg260WlGB+2aHkBckgUG7NImKpEVYn396VBn53L/kDJ5UM81iHu4GXVk63JZIFF9GPZsruHe0+wumw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778322583; c=relaxed/relaxed;
	bh=bLL8kR60HWiGfBZjWm/4TuxGBOepa12A1njCqZE/dOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JFgu1Ns99fRUcSZ2w3Fiv3UJPuz9i/RMmvk2nN346RCF022l6A1UHqjYw2atVzzQhiYtCCB90/2mtyzshsCdbku4Ulfz4hwQluVybLu9UYjzgKxmi1IeF4gSrODuPnUkPUeZ9fvxBf3dXN9Jr4Amt3H3dMvwx4VgkjsHExVv54RDXa8d3Vb23HKeabgQ5RN4dUq8Q7ZO5SUxtnlTiX1bdL92otmaCbusbDYNJ0y4SHAm8azhqwG5s1Saet/YdqPYv3uTb1YzezfYeCO4UJKpXAfB0eCu2V9bFbNKt4gbmzLHfDVwFXBs7XYioPGUEhXtU4tdd6y+jv6PLWpp3gsAiQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=VlwFsBjJ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=VlwFsBjJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCMgB172tz2yK8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 20:29:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCjPZZ78hrkeo0iKma49Vod0bdnUMIljltWMMc9ThuQMX8NxsXaf9KB614Zhmxg5kU7bzsJrWNvM5nrYtWcLdpSaoJQarz+/YtnVCUm3cp9AS7kTQ+uMFGzIMFnv07ChFlnJ8BCwA6xVH/jdWdAEU/LRC2WFbmQq2DupGCp19rpeiZnyqZPLtLVgTFuJWNjzfDfAHoJvmvmSi18OUHlyiuAhUvQlmOU+O9FfAsLLLw7u3jjygOtUPG7A+F0donsbzBNbTB8Si6ZykFg4+xgm1pJbT24vmnHQNiqAZpIKLDt5MDanR/MFnFIl0pBXJcByJaWjvEakguhxjBsB+eCmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLL8kR60HWiGfBZjWm/4TuxGBOepa12A1njCqZE/dOg=;
 b=t/0JqkHFmsH9cqAPR7DqujLyrBDW1uPiUf4+FEoug3lR+Vv0EcLv36ThawwcHVpRz8tAg4ugzcxlSSg1RVk6laWjjzTU6wFV95hCX81a6/OuQMF0UqlB8bR4ylrjs8Im7Vs1VhP1yW0v/k2eDVmM8pY6bBq8wKXu2HFJWx77AdanIpE/ddVkezyaPz8v8PPeOxy2g+z3zsJxFow5YFScYyV0k/Y32pN/PJR/9lr1imn3neTtP/X+FsKpP0ZsO5xeZM5+1o6hSoxCgz6fnHLFFpdBSELW6mMuktaAeVCn9NNDLA4x3T+Zfj1NF3x7GS9yODD5bhblS7tIW7jrO5pw2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLL8kR60HWiGfBZjWm/4TuxGBOepa12A1njCqZE/dOg=;
 b=VlwFsBjJl5yyqBLBen3LVV7dqI8MnpKqYNVfVx1VHKol/UXCKEMl/cB12Tpq3veMjbPbVpYhkqqUAp8tmKpttuK1HWmivY3nz8sNzado1mFF3obKN0LARkIkaec9BwPNft6SCofq7Mu1+dsR03YdVThVFcyBCDgJQ8PqgtMwOrstKLQEnBQlQ4NLEwbkwZTdzgfKP7w+lfqR4sGzTe3Hu3XELBp5nbWM8HMrSi9LmKlFNm8hvnyMi0WD17tx4cIRQxydhocm/EUwKahyUJUKmeQA+yS2neX9DtcbsUjyCqBxWbrYUqy9pN0riDWZkJ25OzQuo4RWZAaiNlZ6rmz9ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DU4PR04MB10385.eurprd04.prod.outlook.com (2603:10a6:10:56d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 10:29:24 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:29:24 +0000
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
Subject: [PATCH v6 net-next 15/15] net: dsa: netc: add support for ethtool private statistics
Date: Sat,  9 May 2026 18:29:54 +0800
Message-Id: <20260509102954.4116624-16-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509102954.4116624-1-wei.fang@nxp.com>
References: <20260509102954.4116624-1-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|DU4PR04MB10385:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ef3643-d5a7-4446-ab8b-08deadb5d731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|18002099003|22082099003|921020|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	exYvn6AuEFCaSZM5pa7I6DvsxideEJv7NSKTGBGt0rwSZMEs87Sswe7YWKOhijFHz16wY8ZO+Mia5tIXe8wPpcV7otvUGVaoXO+kyNvdey5Ukn5W2FDtD+fCwPWto+67+T8Cgdg9KtK6Df+00TOyHbDPGM2HhZKrAW2+MVijR2184RGZBSTCzzWSAKnEtkqwgIlaziq8d98QP53/8sNLXIdMyCmLsmyuR+x7M2dIeoa5HeDH2y70ooKcm5POLQr0UVrkx92V8tmYgIbj8M9FVoEDlckSNc94epZwf9c0VoWp1lc/rw+YAnXJHnORevRflOayLITUMkp16awkl2DzsriBVt4Iy+iybQ6/w50Gdq/kQcNKPtDX0mGAEh85shi7/xk8WC2RwDL72W8PWkYbbrnym0sSn9OoVlAg2Yj1OTwAaeojt38Jjc9/5jSzD65a6oiAG9JJWELysIKiSdPrar4TVHqjwVxS5hCta4DGIxO3iZeyllQDqyvMrtnLzToQeq5Aq94JJWv9EwFx3fpi3jeclMdK++yu/Ft5OVuQRTAmGb9yhuFZkc9mkRB39VsaYcV4ftG3uVjY+p7AZVozdGS0uKbrD6IWOThyNwMHojym6it9MFyxDFYCUdBNM6p4OaC9dTA6Yj5zsI2k5FggH66FWGD6yTuJrEihf/8aYTZDDOEVITzDCIa/Oezb7sx/TsAanBO8iqQ2cHmwZNPm9QYAI64EfYqoQPGESre6L9qWRo1ABpIWGGcFIFmBd4/eK155RNA/u9QmcvL8IJQQOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(18002099003)(22082099003)(921020)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sVzY5zPlVSodKxIFy/g9nrDb8gvISTtV8+gubsrBOIXzhXhrrB/QoFKd24Xh?=
 =?us-ascii?Q?ro3V2nPrCsS22OR2bw1CEtttavupzsAGz7zuR0orLu31qHpHcjgBa1hPiiJ6?=
 =?us-ascii?Q?2+pBCPoxDL/HTOwMIoC1B3hkdfeHmEShLNdrhKVbQKW+ddIf/w5wJNdkL9aF?=
 =?us-ascii?Q?R1hPHgpCWdQ05aDq/v2b3BAwFBFiteq/Ux7230OtwKZ+XUTm7LC/f7LUpI09?=
 =?us-ascii?Q?h8ugzpwEhIQBN8GMpNMMejhiUPiN37+vgiVU889NoJAoRGB/oMxV+sf/U1nz?=
 =?us-ascii?Q?TTWGRGzVDmgzfDEKK4gZNm8O+Damcys7jjl0WMVZ8xR5lRU8GQXUOQBfHO06?=
 =?us-ascii?Q?uuAEdlFYWlvO+JjdI3Nt5SBt6xqQloOtXIUhUCM2Ys/+rEwTE9Dk9pBc+kU3?=
 =?us-ascii?Q?xDwXBt8evgxP4c0Q5ohkqrnOtaZ5CmdcGqMAKJeQ+UBxtovym038YzYUBa7E?=
 =?us-ascii?Q?3PGkJk6mwyRAjZTO07b3G14H594LKti0IZFgataKgzj5QHS+0a49zCKdQOvp?=
 =?us-ascii?Q?q0zHjfqPCYXVgkx7nZqpfWYcOvQESuhEC0iAQCCNbbOkN21tHgrQdXRbtVDE?=
 =?us-ascii?Q?cOr+Py5DQsT+46xnUz2d0wfEAXlwPc7/jiKDxFtYBf0zO8jfRpEeV0UF0SVP?=
 =?us-ascii?Q?/sE+XeiYUvsKgInqm67UzgWFS3+ME0ivjOOP6XoafVHEydVo+PbVChN66VR7?=
 =?us-ascii?Q?UZi+JC9ipHTgbrgnhPVkbq8iTzekw1XyqZj2TRoYd+gFEvxQ37WkqDs80lWv?=
 =?us-ascii?Q?sHRtIDH4RySH75xNxb6ggc7J/gZ9E5FJFixr6wgFRWNwZLq9ZM6ci5Ihs1fH?=
 =?us-ascii?Q?rPWt6MmUn1RAAGz60/tF3nCQmUHN70MdPXyMnXcCg8aB4fhzDnAfFIDCwgeq?=
 =?us-ascii?Q?+97+ZFz4eX2r9Uaw1VRLHj21lIbNqU0drWzoQSdSlU1jM+KEBBpEKbD3iNQ5?=
 =?us-ascii?Q?cIrq/sya7Nu9UVQJYhkp7USA1reNG45qvkmVGCrGOGPfpjjMdfXgtxVaSDXJ?=
 =?us-ascii?Q?RnERdC7ukAwRwEqOsS7ABCmEKTxtXozpMmt7JXtRZybm1Q3NQfwMwSpeV+oZ?=
 =?us-ascii?Q?bUvfmblHaLhn1zEk6+Q8Sf16B7yV2fuDwaLPCQmRoCb0y6cJB487fzjqph6S?=
 =?us-ascii?Q?awEmdCuUx6+XPPl1wI+/Lri8aar9meywwA0ZcJYcMfF56o6h6iIfqDUDDUhy?=
 =?us-ascii?Q?n3leJCJguZZ1+wUZEc6OITfC1hGjnGtepPZEH+ScU2Q015+Fh6Oi/26GvKce?=
 =?us-ascii?Q?Hu9DrARCNISfC6NKauGwB/xRCBShz4Fn4HnvE0a07ebu+KZRV3V5tMGsJOE5?=
 =?us-ascii?Q?iEOk6rhEMgPK+Ec8AooCONwH9/VgZ1lkHsTVHBOsiPVnuZ1d9GXL3n6ORmms?=
 =?us-ascii?Q?EfDEPFM/H13hhOQlQYwCXWxIw/xhMI/kz6NKqOy6j2JUMePPzPQgDsjSZEvH?=
 =?us-ascii?Q?niTzVxhdObUWBRgzPl1ywu5ca7ewKPoMxCNOQUlrdiqQgFexBiLYndhx6HTA?=
 =?us-ascii?Q?SrO0EAFYYUxe7s+WxvUlf8J/TKwDXKdiOziT0xAgsKjXpqPZNeiypL60XO85?=
 =?us-ascii?Q?Der2Z4ZYtWessO0ibJt2iqEmq7uusCZKGFvaU3j6zGwbBcMf3FbVIrXFd8cq?=
 =?us-ascii?Q?Mgb5rA5I6v9MaLWi0B0+lHXHTLsAYDHZ7M2nnnr5LjQWQZm15MeKj50RCpiy?=
 =?us-ascii?Q?du6NdCUTBV1FzvfKJ95cNb2UTGqAuiBkaLp1+bXiR1Eh+knd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ef3643-d5a7-4446-ab8b-08deadb5d731
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:29:24.5954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x76wFTtaY7In+pPQvFu+phUSPU5TR+Z/ak9tmp2gox6l9QVw3L7yHjfKOT4UZt5f8WrLLs7eQ1ZbqnP+Y+IKAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10385

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
index 338f2421ccb4..a82e156ce86e 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1467,6 +1467,9 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.get_rmon_stats			= netc_port_get_rmon_stats,
 	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
 	.get_eth_mac_stats		= netc_port_get_eth_mac_stats,
+	.get_sset_count			= netc_port_get_sset_count,
+	.get_strings			= netc_port_get_strings,
+	.get_ethtool_stats		= netc_port_get_ethtool_stats,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 40e54af0c356..740e1f307c45 100644
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


