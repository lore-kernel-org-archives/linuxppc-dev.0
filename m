Return-Path: <linuxppc-dev+bounces-22305-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB2BCD8C85
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 03:28:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZDrF0469z3bpG;
	Tue, 09 Jun 2026 13:27:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780975676;
	cv=pass; b=dJEhKHbsiNbVpNiYguaShMo/OrlBZfuXJLVsJ97sXVBvTx28QlhHvaXFGxfYdrnJQyRzb3A4JKX4rS/DWO8z618gubTK5oAoA4aHRuND003nu+M6Y5nuygMzBL+KlD2KGLlf3XApiwMRUmOsG3DGDn9zrPcwN+BOtN5hRsE5hqheTkxhOkgD6JkvBySS1L0J7KaRF6586b//oPmf73mr/yN5LB/xHTo29286kGWneXOG5dbe2VyP/VQtOXWqqxcDJGdDlficPf6jpegcTnVXXweALctqeQaRnnaJFSjVm8dnmn06jpSPZxgLS4WpfY8ETKloSBeyn8CbyrOfuNS8vQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780975676; c=relaxed/relaxed;
	bh=c3wZ2J0bG5FHp8ZaFE9Fot88k5dKTeGOujpGuBDm9Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SkdNKfYPB4/rC8eD9AOffhvbYxHeUR502XfZFs34EB5nNWUxegeYgnxguOOxa9DlUJyoSHltdLF3iUylIwGN/FnoZbBDPvgbq0q2NJw9TclQsknsUChd/VdI8jfYYhAMPUH+htQVQyh6hwl3hDWFbQiTeLS8BoEAeCZuNu0Q8Exh3JX/j09uwwNmVNQXtGpJRWu/7LyqDLe1KdjnGFh7qsY0v00VH++doj9n0GxqmL2IkVG4CR5X+rCOYAp56Jv0L4rZdg8/hx1F+HHZunBD7Xv0U0PTeOV5mvNf0QvBTIPMUpnduUklX0YhQ2LQU/iM0sp2Zq/PbDpf38+1YAzT6g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MBUOKbbe; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MBUOKbbe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZDrC6l77z3c2t
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 13:27:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdWOSE9ZWm0afZA0CZQkb7IonI4KDLgeybx/oDNsfS065l8c54oNkBSAE51FQTa/HKonl5fVsr400VcqXpXOJHzWgFu5echvN3Zc9YiPSmxcXhv1w2cwuMotvD0yurkNI+w3iafmAVHYjqt8HXeYRwPHbwhWxw8Vi2f7So4MfekIAeaX5osMgFfR4p66aq+lYYA8v8YqOSssSp3vRb2ZvcPrJclrwJNJ1JXZ9hNsXoy4mkzT81OQ/rjM5FkeTIwbB/i62k2/zYEs2MRRnEVG0+dY4ru6ADf4HX++wLEn/ylacq1+M+6CmnpNN378gu9x9+H1MrtbZShXA2nJGL9/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3wZ2J0bG5FHp8ZaFE9Fot88k5dKTeGOujpGuBDm9Yc=;
 b=CKByrtvHc8ElCEzxd848FbGH8nthSOT/Jyt4cRQj+vex4G/dJKa80FIS5bPpIiqQedz9W02C12p80i5+tJUor03dw86m9FTRsbmj47n4UAYV9N+jyhI5NiTMi5RCzusUBz1F9JwVr7F1rqXD8TPaWUb8SaP7scrAhWAmMWQRlSNqdjR+lweW5VLuWXFdP3zLB90ANGVTPAPga5LUi4g2f+Eyx3x0Nx40AEdLdeFS9zm/K1gCl49Ln0jEZ06rJrZIlyVPy/2dNv9ZmMvOQm3nHbdva3zuDuZGrkkvM81xCeCJSzOHAJck3z1D486MKqCzIAUIFNl8yVphMphQ2SPVBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3wZ2J0bG5FHp8ZaFE9Fot88k5dKTeGOujpGuBDm9Yc=;
 b=MBUOKbbeRosAI67hoid3T910PlX2nOtk87pEDIJh4jMDXCmrYd8is+E3CsHkVTIxLPIqCORYMwISiqVM34eg7cXuS7wHNaw203Pc9TzcRyyCxQUww9wF32HVrDsZ/AyvNXRFMHYo85K4IpxdPLcbSb3o/bZIbfJUQlFLuPlWROjA3ACaUFH0nA1YnRibuuP/It2xnBb4hVJhnmHg3rhybSnozv47ntI71bLdys7k9YnZy6SVpV9XfNqGaDzU3fB3iCSM9ZguzUNQ5rJRvksUoGJtN0pmF1o84G0VErmWXbPlEsR2kK6AyQBySYWnrvbKMjNDbx4HiwDEFY0WbLx4uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 9 Jun
 2026 03:27:52 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 03:27:51 +0000
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
Subject: [PATCH v4 net-next 9/9] net: dsa: netc: implement dynamic FDB entry ageing
Date: Tue,  9 Jun 2026 11:29:55 +0800
Message-Id: <20260609032955.2066089-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
References: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f3efa0-3504-4634-f376-08dec5d7166c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|3023799007|22082099003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ocFaiceIkUOeXFCugFWnn2Omry9Ba5YvJj4Q5+YisR7qZc1K4pyZaCikTGk3Vm/udXpJd7u2Fc23OTbk0mOB8WD+49FgZz+xJy5CzPJL2DrrovaeSLRN7ALSFzK9g+zHcrRXMxZPZMWRtKC3Eyv3bnhMbpZ8rc4OhXH15EN1p90rj+xtkWsCQFZwUSkHQmedY5NJNpy11eePmtwuzssoFrwxvq4aBP0O20+6ggxXBg77KZc+DyyfMy4U0Z6XsWzAcVL7tuHu9kCSOqD+40DKhFRTWAgGxspOdIlIp7vjTirHz8kjJtelblHMUPYWiYwAn0NsgsUl2F4roxBOujTPAyOi20AnmqeV48lO/KKr8WnOg80I4Z6ZADsEaNcfiHtpYk3Yz7oabLi8Dp7rBTkF8ipTQtpam5ki3dH0ZoG4fE6KGnvacMTLciB/KjXAVwUyfgQC1tChbvvc9aJdYGSRjrEhxzZZsSUmS5BTCoa8fqpfIPdrsL29CPLwYQvSMegq5pdxI4SWp7irvXCt67A7qfwB3JahRqY0TMfAF8pqxd+EzNLj5gj72mHMlkmH93orB5XOmGyFw58iPNQA0YJyre42OwteXe2pBpPvkG37wbPlhnmqMbIWLE8c+fxQ2sal4djVrQCZH9XQ3VwaROlLbITq5aQM9XhdojtCa52fzQDOTYYd4H8+R2L+MyaeEJQ7Ni/2nI8cW0BegdX7FhHtiwO84k0orPpq5grIn0Qzt/I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(3023799007)(22082099003)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yMuBkH3cq+Q9+7dKmN2oyiWy8iwXsOIsvHkQdDOzeKqRJ4c2CiHEgveR5nZX?=
 =?us-ascii?Q?ZcVe9+Ssl0e8gVuwpsOw8VfdGAUfvKWCeuSOpjSCptEqLHxm1JFIPMRNvwIt?=
 =?us-ascii?Q?hCsIxtWOmKEdDiSQ1SHK23z/Ocb9CgUE2BFmBti3HwPL3rTLDNFm9xrYG/62?=
 =?us-ascii?Q?Ko3pQkXfZIqn7f8x5j8FBJ1ops6n3/QSWLDaYU4PpoT5nwkWxOJOizfQL3Ou?=
 =?us-ascii?Q?a33CL3uXmSAu/9xnTquDt9UWpiVXHU1uvgMbK7GrcY/LIWB6Tw3ro5Iw9vf9?=
 =?us-ascii?Q?ilOIpG1T+YolwaHACWkkWbaD3GRmx0K8MqEmP1iBvhtkt48SykNnjvHWQqZ/?=
 =?us-ascii?Q?Gp9k8ZBWOCXHPUOkMMveNYIv/9ayCcZ2Em/2pv7uqde3YDv5VTWSNiAHY1w2?=
 =?us-ascii?Q?YiQRjllaKhbQxuQc6czbm2uvgvRzkL77SMhtk7TVPpw4WPFtJ9yzgZbHg18M?=
 =?us-ascii?Q?CiNHe95VMIrtO+tkjjLQQWvApkdirgz7XRN7V+EFDIqpEJzfLvUKjf/rEaiv?=
 =?us-ascii?Q?eD5XiIHLfaGiXJvmHmczz32CvCYYisrR34g3xhhMzc7njxzX7Mit7oENiB5b?=
 =?us-ascii?Q?/HRZEue9Q7DIXiMRmXUZqDF4LpyMGseHsNZaQRW1oZleOP2EechO+IEeuY+I?=
 =?us-ascii?Q?FmIXrx5etPwnALKgLsrPW4Y9rzpmZrHVwccg38671XiIXPYPMMFK50v7PRiP?=
 =?us-ascii?Q?tI1fyecCgcE3x0YTGeuCUSHinoXOzkFjkw7EGqiJIImFkD7SZASRtAIgS6jM?=
 =?us-ascii?Q?OFnJ/Aazb3NSFScmT3geNkPkd3eRXtrCuZXloXuMHb/MyPOR7OZwjBoB5Ew1?=
 =?us-ascii?Q?ookG6rIwkySIEzJ3Zgl3DPLlbTMaGi9YYp/SZ6CnJ8JQE18NsUoOJntWK9cn?=
 =?us-ascii?Q?i7qe3Qwlx83lPWAIJZaE0DX8c9wDlJ9DZgckGSL9Ze3nzDZ/PnrBKyLnGNLP?=
 =?us-ascii?Q?d9wNM3886np5yqSbiVjDivognZpdFE6xkAOqnj4RZ1pfs8U9ctyxb7LJOsWR?=
 =?us-ascii?Q?BdvvJJjECCdO84Glt0HffsI1iNrZB/ahGaCFKMWqTPB6kaLkoQH3R+Mrkq9U?=
 =?us-ascii?Q?6/ahVPWMJ401WIk8UP2750do7DOb0pdtNbrYU/mzzs8P9Ig07xOUvgcOfbPB?=
 =?us-ascii?Q?D/6sXUFTRUhR2fDj32FaFpqyy8lbqOEDZsskjmnoupAWJoaszRU2HK6HwOIF?=
 =?us-ascii?Q?XRvlUaHVJx5M0QWa58XRB1NLgsruun0bpe5nFi17BS3I50juKQm2uyZ3j+/5?=
 =?us-ascii?Q?LRQlJLBrqWYQAGNG/S3ozpocXrvqbiEM07fsFtyhGPiFfOGR/Ug7M6Rj/33A?=
 =?us-ascii?Q?VzSyHj1TqxOkeya9raJs8ciTawZJDqVNc2EsGXm6818SK9Qpk4XYqSz8xy9L?=
 =?us-ascii?Q?H22jIq+P8pOJ9d211vc+V4jdhtDWD9bOHpEcVS03u0RY8UXUGRF+G9rx+W8h?=
 =?us-ascii?Q?4kZAmtQWrjjAJK/NYrccbOnVBT/wrGutk8mpYwlekeNjoGIf70QDhDWVj8bj?=
 =?us-ascii?Q?nvl5WCfN4mUgPZEqRyCBjtPJA4dybsXPoMvtBiya7j6hw5TigzxxpplxomSJ?=
 =?us-ascii?Q?YjyP5zTRY4P8JxY2hQDXrNlwnoODB4AyDc29x9iLzyKmJYwRWLnYeaQgiRti?=
 =?us-ascii?Q?R/MrGmyNWgnYThSzO8EA5s9juSx6p1nFaqXpBJ61ZUnLZqePwHFFFWwNI8xk?=
 =?us-ascii?Q?Uq6uGfjxJFWVtFZ7AoIbXo1mMO8ZU7cgKzESOiX4GAyc+kOIClAHsdfmcfb9?=
 =?us-ascii?Q?j7np/tVch9ee7tIWaqjoelNyS3alprVSve91dLjpscVZmssmvShi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f3efa0-3504-4634-f376-08dec5d7166c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:27:51.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mVLnAEyHT3H5F9jtRZ+lI0ioJwLq5ZXBKKnbu8MHUf6J1P2T3c+1Il3oAQfnYcrnQ0y9yDOYKAH7DE3chqos4J1ovhSZtxrzFOFEUzJEq9Rt9+QgPFOKhLs7jVq6QbH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946

From: Wei Fang <wei.fang@nxp.com>

The NETC switch does not age out dynamic FDB entries automatically.
Without software management, stale entries persist after topology
changes and cause incorrect forwarding.

Add a delayed work that periodically removes entries that have not been
refreshed within the specified cycles. The effective ageing time is:

  ageing_time = fdbt_ageing_delay * 100

Default values are 3s interval and 100 cycles (300s total), matching
the IEEE 802.1Q default ageing time. The work starts when the first
port joins a bridge (tracked via br_cnt) and is cancelled when the
last port leaves. All FDB operations are serialized under fdbt_lock.

Implement .set_ageing_time() to allow the bridge layer to reconfigure
ageing parameters on demand.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 67 ++++++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h |  7 ++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 299a9e76b9aa..c6082c6f8fd9 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -447,6 +447,25 @@ static void netc_free_ntmp_user(struct netc_switch *priv)
 	netc_free_ntmp_bitmaps(priv);
 }
 
+static void netc_clean_fdbt_ageing_entries(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct netc_switch *priv;
+
+	priv = container_of(dwork, struct netc_switch, fdbt_ageing_work);
+
+	/* Update the activity element in FDB table */
+	mutex_lock(&priv->fdbt_lock);
+	ntmp_fdbt_update_activity_element(&priv->ntmp);
+	/* Delete the ageing entries after the activity element is updated */
+	ntmp_fdbt_delete_ageing_entries(&priv->ntmp, NETC_FDBT_AGEING_THRESH);
+	mutex_unlock(&priv->fdbt_lock);
+
+	if (atomic_read(&priv->br_cnt))
+		schedule_delayed_work(&priv->fdbt_ageing_work,
+				      READ_ONCE(priv->fdbt_ageing_delay));
+}
+
 static void netc_switch_dos_default_config(struct netc_switch *priv)
 {
 	struct netc_switch_regs *regs = &priv->regs;
@@ -872,6 +891,10 @@ static int netc_setup(struct dsa_switch *ds)
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
+	priv->fdbt_ageing_delay = NETC_FDBT_AGEING_DELAY;
+	atomic_set(&priv->br_cnt, 0);
+	INIT_DELAYED_WORK(&priv->fdbt_ageing_work,
+			  netc_clean_fdbt_ageing_entries);
 	INIT_HLIST_HEAD(&priv->vlan_list);
 	mutex_init(&priv->vft_lock);
 
@@ -936,6 +959,7 @@ static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
 
+	disable_delayed_work_sync(&priv->fdbt_ageing_work);
 	netc_destroy_all_lists(priv);
 	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
@@ -1970,6 +1994,7 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 				 struct netlink_ext_ack *extack)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
 	int err;
 
@@ -1997,6 +2022,10 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 out:
 	netc_port_remove_host_flood(np, np->host_flood);
 
+	if (atomic_inc_return(&priv->br_cnt) == 1)
+		schedule_delayed_work(&priv->fdbt_ageing_work,
+				      READ_ONCE(priv->fdbt_ageing_delay));
+
 	return 0;
 
 disable_mlo:
@@ -2023,6 +2052,7 @@ static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
 {
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct net_device *ndev = np->dp->user;
+	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
 	bool mc, uc;
 
@@ -2030,6 +2060,9 @@ static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, NETC_STANDALONE_PVID);
 	np->pvid = NETC_STANDALONE_PVID;
 
+	if (atomic_dec_and_test(&priv->br_cnt))
+		cancel_delayed_work_sync(&priv->fdbt_ageing_work);
+
 	netc_port_remove_dynamic_entries(np);
 	uc = ndev->flags & IFF_PROMISC;
 	mc = ndev->flags & (IFF_PROMISC | IFF_ALLMULTI);
@@ -2066,6 +2099,37 @@ static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
 	netc_port_del_vlan_entry(np, vlan_unaware_pvid);
 }
 
+static int netc_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	struct netc_switch *priv = ds->priv;
+	unsigned long delay_jiffies;
+
+	/* The dynamic FDB entry is deleted when its activity counter reaches
+	 * NETC_FDBT_AGEING_THRESH (100). Each delayed_work tick increments
+	 * the counter by 1 if the entry is inactive.
+	 *
+	 * Therefore:
+	 *   msecs (ms)    = NETC_FDBT_AGEING_THRESH * delay_ms (ms)
+	 *   delay_ms      = msecs / NETC_FDBT_AGEING_THRESH
+	 *   delay_jiffies = (delay_ms / 1000) * HZ
+	 *                 = (msecs * HZ) / (1000 * NETC_FDBT_AGEING_THRESH)
+	 *
+	 * Use DIV_ROUND_CLOSEST_ULL to perform a single nearest-jiffy
+	 * rounding, avoiding the two-step rounding error of the intermediate
+	 * delay_ms approach.
+	 *   Maximum error = +/-0.5 jiffy * 100 = +/-50000/HZ ms.
+	 */
+	delay_jiffies = DIV_ROUND_CLOSEST_ULL((u64)msecs * HZ,
+					      1000 * NETC_FDBT_AGEING_THRESH);
+	WRITE_ONCE(priv->fdbt_ageing_delay, delay_jiffies);
+
+	if (atomic_read(&priv->br_cnt))
+		mod_delayed_work(system_percpu_wq, &priv->fdbt_ageing_work,
+				 READ_ONCE(priv->fdbt_ageing_delay));
+
+	return 0;
+}
+
 static void netc_port_fast_age(struct dsa_switch *ds, int port)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
@@ -2357,6 +2421,7 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_vlan_del			= netc_port_vlan_del,
 	.port_bridge_join		= netc_port_bridge_join,
 	.port_bridge_leave		= netc_port_bridge_leave,
+	.set_ageing_time		= netc_set_ageing_time,
 	.port_fast_age			= netc_port_fast_age,
 	.get_pause_stats		= netc_port_get_pause_stats,
 	.get_rmon_stats			= netc_port_get_rmon_stats,
@@ -2406,6 +2471,8 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->fdb_isolation = true;
 	ds->max_num_bridges = priv->info->num_ports - 1;
+	ds->ageing_time_min = 1000;
+	ds->ageing_time_max = U32_MAX;
 	ds->priv = priv;
 	priv->ds = ds;
 
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 982c8d3a3fbf..305f2a92e2f9 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -50,6 +50,9 @@
 /* PAUSE refresh threshold: send refresh when timer reaches this value */
 #define NETC_PAUSE_THRESH		0x7FFF
 
+#define NETC_FDBT_AGEING_DELAY		(3 * HZ)
+#define NETC_FDBT_AGEING_THRESH		100
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -124,6 +127,10 @@ struct netc_switch {
 	struct ntmp_user ntmp;
 	struct hlist_head fdb_list;
 	struct mutex fdbt_lock; /* FDB table lock */
+	struct delayed_work fdbt_ageing_work;
+	/* (fdbt_ageing_delay * NETC_FDBT_AGEING_THRESH) is ageing time */
+	unsigned long fdbt_ageing_delay;
+	atomic_t br_cnt;
 	struct hlist_head vlan_list;
 	struct mutex vft_lock; /* VLAN filter table lock */
 
-- 
2.34.1


