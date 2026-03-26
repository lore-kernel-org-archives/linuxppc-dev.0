Return-Path: <linuxppc-dev+bounces-18809-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D402109E557
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 06:29:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDQ33Cn0z30Tc;
	Thu, 26 Mar 2026 17:29:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774506555;
	cv=pass; b=gpbMJ4hbi/d793/ZRJtd82bLElYpi2jq+o4vimVr6rHxGisbp+wIEfJaHw+x0+6O+lB95L5tkN7X3kCG3Td++mhYQXiVRw4Tz6kDueTEE4Z2Ct1l7JOmYVcnqHbv0CDQMDnADvaDJ2sG/A+DEo6zTNb8GNwu3QV3UQ5NAfHIvyHAwVKz8GuJKzQzZKAjvc9rHdF9RAZ2hP2Lp8njJWIGX+C43QAEibYdvoWGaKNC9JTfC7qccuoKL+1uankSpUcn40T5NfiTjE9aY/sVxekrf3XUjffhAw75lfwo6qo6KxcuhPA7r0MSmjQky3LYOPqQ6uri+Qn9MBAsc88iciv2/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774506555; c=relaxed/relaxed;
	bh=/fUFdQUPNe50sUAEIdkGQ2v852eBkJVwPzglnYCvPnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QeSbLgLJcUqPob5+8vSDAwCefJomWprfoEmHhALQ6dHtEq1MtSqH3hrvmSRDvvlM1Y5EP8wfFTTdRcd25J+lGMtS2eJJiN8nYCFgPhgamcsenKQlMAPNQpAlJwlF0LVWp0oNSGhBlEfvFqIH9UTUfaHvaZxtnQTOO3XhJglR6N3hkOJmncSjiHnv+abqcqndWSuWgSESqeqBjxiAiGP8lUP0/WnPnt0Vjg7tKWu6A4xz2q34RYiu3k9ibjru2LoTocsjcM1+EEhi2YJWCQuj0ykuHGw2gXyP6WLnoLmGOGKc8R84TcfsM+mpR/M9VsWLycwh4h37DYlVu3xN91g4yw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HU1n0wou; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HU1n0wou;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDQ20mTqz30Ng
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 17:29:14 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsZe5zt6B5s2xbgg7198HwQyVgv9+bNv/Puj4uKzclMS6yh0lapcA9XHxZ7r8tGQeXsmOSss9VHH8I5SIOrmmQi9NmkkZB6cKPRWjUC+CNulRIk64sQkxGZWLKUin7kVzRa3TRnrGH9xVq/8/sO7lcdGsRSED9L1li1aIRFKP+p82MoRgxoV5L0o86vvhCq8ysu0TS29fLv6YasL/sSEptcessRSOVjwhDzwIi8fTrDx0RyNZOBrsRzps2QojLxnbAA0PCMpAAlmiU3B27zzVkYxfq4Ojlk+Ll6DqfViYs9Crrjrg4u+M9THkKleTMnRQt4mgVUN405V8k8bgwLxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fUFdQUPNe50sUAEIdkGQ2v852eBkJVwPzglnYCvPnA=;
 b=g5dpU5cR/0RKHCRARw3NCRVeEOfTTJaHld/NhjFBa8Keu1Hl0+5IzfnKkmqBBgy/K0tNHqxpeC2P5MKBS2hQ37mf8nt5MiLG9DhW1xWrTHdHL1eYbxBevEJF05qRajo9MR4OxXiz17DFVVT1+Gprj6qVrFf6ZDv55E/AsNJv3mQMzssz1Y+Hdz6KXyCJtZW55wseD7r9aQodBjevxTGtvJEvXy3njkha229ojxjT4oHZ9zAWphO6T4XcDlb0zzc2wPlisvJCMHqAE54Rt30p6muAyk3B7OUvo8UR+bE3tnpOCGGRDtQd5wf7+wsBXbEZDOlOp27GbzRnLOu7X14Bng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fUFdQUPNe50sUAEIdkGQ2v852eBkJVwPzglnYCvPnA=;
 b=HU1n0wou516OYT3Sa/d8Y8AlDNWM+KC7fCwWq137oSiqdPm+7IhSpvQaPidnFymu31NwN+31yc7p2SUQo7nPjkYahfldAn018WdQf+1wQYPXo8hQHULaxhqIfydcasjIth5yByE4Pwp4+QXigcxbcVGqE59ldbvjaOK1LWP35q9Mob/y+vH75pXgcKO2NrMpxjunNX8RB3ooWoZr+uLsoaiPwH8kK9MceqAfq2fCzYDkVyWL4zUbinUnlxs2VqJW8xnbh0nFiqqOvSvaA/M6M0XADYk4bnnm08qd5WPekDiW8MAzV86Lc4TXEy5IqC6Dk73aaKv4UbWF1HFFdktkGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 06:29:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:29:00 +0000
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
Subject: [PATCH v3 net-next 14/14] net: dsa: netc: add support for the standardized counters
Date: Thu, 26 Mar 2026 14:29:17 +0800
Message-Id: <20260326062917.3552334-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326062917.3552334-1-wei.fang@nxp.com>
References: <20260326062917.3552334-1-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 5857ef62-9528-4df9-fa06-08de8b00f7b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u48lLTZhg8HKHlfmB6dCNwVmM9zm8zTboAPg8yhzRqWeVlgTSmUZlvTpM1fvoiPTYQKfi9bS14glp2n3AJyDaZRArd/mIREH+jW3NpjyEB60YpYTrEKN7gsVdu3tk9tSWBeWNCnXU4hMLXEAnA4i/gVtcLrAgvuaRSjQDhiJs7ujZnqz8RXcSkIavSr80Dip2mm8mPeDDZkLa9TUUbNaL7pM2ysrp8AlDQhnfAw2s964N8LzfZRZ+TZqmtKzqlAJvbh/DePWqwUcFqRg0jsyIWCrJpZK5t/UTx4njnpz7lAJNmsTJwCJbSqBLsBTV8B++rjMMgfDljHMvbR7Kj9PhRmac2aPWMRDujzoe+pRatBc6FV17deh2r4ylCqSYY+SzmuPrSDTWMK0O/u7NpAFFWag1QUPPzztHyfF3oIAkg0TmNxSZRkL0we3FJZoIzo/HdglGfcggM92NRTaNk6AAdAi9Z3axV1G1U6jWfH+XW+WygCKsQh4QpCb+W2w4v0WP0CixQkthsnx6W3314bITYvzKxx8ftbjUDeGcUmtj/hSbRpFR4AVOB4SVt7LVkPEyzLkhn6cLKwas47dFBVII765j+kI+uzIk8CiwpyvzXz7ZhJ4YidpNAMu/XT1QzNvTulN/hEAZzpSfZzvrawKNH6K4ZKln9JBGtN0dbQaRQkmugdJs1q5JI4Z0szMlZk5MihmroV5sUyKM68A108s9DZh0KRvNt32zfZ+7Fz6fYZCpyarU+PdyVGfVi065TmrQ/MEeoT9CDFTthvM+iGArTPGBNlUdw1VIW2EBRTq1I99oZUIN6raZcuK+n86ZgVt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?//JWjKchJLflUwAvGkB5FVLR7iEGB4kR/bpLg+HC54JfaIpD+slgP6PP2Yfo?=
 =?us-ascii?Q?wb/TW2+o56F88xoSR6yJwH1LVrC2nDccMEat2f6tJQ+eYwKKEcNGlnPN1/+S?=
 =?us-ascii?Q?oLuRhR7XU9nbsyQCBMwlV/b6FkiVCkqgcaWWCa5MnrDkNGL0H6oXz+M00hcc?=
 =?us-ascii?Q?FgJprAqoUXKUYi0PTC2eUwFh3q2XfxmGgOz7pz6zWb+ltYVGlVBV6BB0c2/r?=
 =?us-ascii?Q?uZcrCBcrteeA/QBvZ2wJe3xHjluWfknhpxl8pZYBGgG7Uoh3fDTJQimhkD1X?=
 =?us-ascii?Q?Nf6v4v+CrvL/x8kF2uAkkSUFT3UgMxequ5ZLC2+bl5yoVS620dvgqc0S/8HF?=
 =?us-ascii?Q?iD9Rwu/r6Ro0lkLzNlo1ELdbqVbTfw41gJNkf3ESoWzCLvGMzXprbpl0wKBl?=
 =?us-ascii?Q?ICj8NPDdG0ODD4qgqi7TPQDsndTs8qQ+JZroWBabaGu32ZAMBZjXdfzO/zbC?=
 =?us-ascii?Q?ohwASr3MhTQmIrThG3HoUTQoott7x/4DLB0LNiNpTnzFd/pQbjCR2qTmPG60?=
 =?us-ascii?Q?EM/2MlMoSwu7bv8BoSxy03DQ14XLQsEDqevbXMPitDylVc1p4p8U8ZB7J3Ah?=
 =?us-ascii?Q?5QTupSIsoF2sEhcg9ZTzGnqaq6UsHBHQg2Owk05YIUGRrni0G8hEvTlrUCl1?=
 =?us-ascii?Q?opt6kE/ok7FnERUMpLxJ9XriCIr10K/ousrgDCpaaa1x04ULP2k34HBCzMMw?=
 =?us-ascii?Q?L2yovCvMuT13mm6g7VOIjpBmLtwH8hkFxOBDUjCdUfHPyldaG19IXeEGZc7s?=
 =?us-ascii?Q?a3n1z/QT8nR6rGB8nrDCRDLwwtpPd53nX1OqGNzfj72ItnK/iifU1eHvddGN?=
 =?us-ascii?Q?yAnUDpwnW5rzL//Ctcm0FvBT++VTpRWPxNkVKD1PRHz8acKatkglvriqtBxW?=
 =?us-ascii?Q?k14B0cvAc99X8Ooso73qbgpIgcBJmSJfNe9kywNMROi3n0gP8QLmpqIUPbEs?=
 =?us-ascii?Q?+PMmxHiXs2gkYq+oGJ7bmNTW+uhYm4wu28t4OaL3NdP42OqBAAcuXCeg8Ivs?=
 =?us-ascii?Q?WgpQUkUiMMTXosrgzlwPGqonqYoOg45IFXVuJvKUrOxZE1Yk/gW8fmKirrac?=
 =?us-ascii?Q?c6FhMnAqQ1Ly2W31uKz/tlAwtarEVXJPsTRHFAZNCHbSEkgsG5um1EH3eesG?=
 =?us-ascii?Q?8oHAHrHAc11gVGl081FU20Haka7yGXoT+M9acjlSDH3znq4oPyhLBR9yjmR7?=
 =?us-ascii?Q?Fb3/z5pr3eI6STbBp8gMReuxsbQuiCnQKBDZpR2j74UlvHc+79PQkrr7Noho?=
 =?us-ascii?Q?uNojz75FidJijpn4juA4BmYnDOrxh0JXHhy8UYQWD2OMu1M8XRUiqaY3Z6xY?=
 =?us-ascii?Q?4nxAHa3wcWQRYrz3Fkt2KVfELZlHo+jl+szdSS+Y9FBvhDQz7mhPENM8lPTj?=
 =?us-ascii?Q?Ow953UA+5QXE4FNYK3JASif9P2Rw8JNglhnrIH5Nx7Sb1A/8RVgKoLQHzysk?=
 =?us-ascii?Q?+OXxr/DKGb98428PRVZ6tky/OmlbsW0TgxQVpx6+8QCFwgA4XO409u4NC19T?=
 =?us-ascii?Q?QJfv46J9RzIP+UgAWqBWJLzwdcqg590wcUtr4y/7ljPvk2Q0jwhnQRZBhyLF?=
 =?us-ascii?Q?isp7YPl+vE7OBKPjpDgHfwj5Hrd6OYnuJ9AM+0cE5XRqEABxxjFTQX9Yrm9a?=
 =?us-ascii?Q?MXRBQ5Bah2VyWsI/WWCEyWyEV5MxEiY/xbRCef2E1a5tV7renZiP47HAp2hf?=
 =?us-ascii?Q?kPlLq2mYm5l6TPEWgbqeGIR1TvLshdIALeB1kTxAQ2Jo23YoD/cxTA/E2pPa?=
 =?us-ascii?Q?A8k2kb3Y4Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5857ef62-9528-4df9-fa06-08de8b00f7b0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:29:00.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwqJ+MUAENdmiYVtIKmfyfSi1lUse3c82ALyIBDIXgobbpmLMM1vrmmq04UheuxNgInpUsEl/CoVfu7WdXL+MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355

Each user port of the NETC switch supports 802.3 basic and mandatory
managed objects statistic counters and IETF Management Information
Database (MIB) package (RFC2665) and Remote Network Monitoring (RMON)
counters. And all of these counters are 64-bit registers. In addition,
some user ports support preemption, so these ports have two MACs, MAC
0 is the express MAC (eMAC), MAC 1 is the preemptible MAC (pMAC). So
for ports that support preemption, the statistics are the sum of the
pMAC and eMAC statistics.

Note that the current switch driver does not support preemption, all
frames are sent and received via the eMAC by default. The statistics
read from the pMAC should be zero.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/Makefile         |   2 +-
 drivers/net/dsa/netc/netc_ethtool.c   | 192 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_main.c      |   4 +
 drivers/net/dsa/netc/netc_switch.h    |  17 +++
 drivers/net/dsa/netc/netc_switch_hw.h | 153 ++++++++++++++++++++
 include/linux/fsl/netc_global.h       |   6 +
 6 files changed, 373 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/dsa/netc/netc_ethtool.c

diff --git a/drivers/net/dsa/netc/Makefile b/drivers/net/dsa/netc/Makefile
index 4a5767562574..f40b13c702e0 100644
--- a/drivers/net/dsa/netc/Makefile
+++ b/drivers/net/dsa/netc/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_NET_DSA_NETC_SWITCH) += nxp-netc-switch.o
-nxp-netc-switch-objs := netc_main.o netc_platform.o
+nxp-netc-switch-objs := netc_main.o netc_platform.o netc_ethtool.o
diff --git a/drivers/net/dsa/netc/netc_ethtool.c b/drivers/net/dsa/netc/netc_ethtool.c
new file mode 100644
index 000000000000..8e5861543d30
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_ethtool.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC switch driver
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/ethtool_netlink.h>
+
+#include "netc_switch.h"
+
+static void netc_port_pause_stats(struct netc_port *np,
+				  enum netc_port_mac mac,
+				  struct ethtool_pause_stats *stats)
+{
+	if (mac == NETC_PORT_PMAC && !np->caps.pmac)
+		return;
+
+	stats->tx_pause_frames = netc_port_rd64(np, NETC_PM_TXPF(mac));
+	stats->rx_pause_frames = netc_port_rd64(np, NETC_PM_RXPF(mac));
+}
+
+void netc_port_get_pause_stats(struct dsa_switch *ds, int port,
+			       struct ethtool_pause_stats *pause_stats)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	switch (pause_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_pause_stats(np, NETC_PORT_EMAC, pause_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_pause_stats(np, NETC_PORT_PMAC, pause_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_pause_stats(ndev, pause_stats);
+		break;
+	}
+}
+
+static const struct ethtool_rmon_hist_range netc_rmon_ranges[] = {
+	{   64,   64 },
+	{   65,  127 },
+	{  128,  255 },
+	{  256,  511 },
+	{  512, 1023 },
+	{ 1024, 1522 },
+	{ 1523, NETC_MAX_FRAME_LEN },
+	{ }
+};
+
+static void netc_port_rmon_stats(struct netc_port *np,
+				 enum netc_port_mac mac,
+				 struct ethtool_rmon_stats *stats)
+{
+	if (mac == NETC_PORT_PMAC && !np->caps.pmac)
+		return;
+
+	stats->undersize_pkts = netc_port_rd64(np, NETC_PM_RUND(mac));
+	stats->oversize_pkts = netc_port_rd64(np, NETC_PM_ROVR(mac));
+	stats->fragments = netc_port_rd64(np, NETC_PM_RFRG(mac));
+	stats->jabbers = netc_port_rd64(np, NETC_PM_RJBR(mac));
+
+	stats->hist[0] = netc_port_rd64(np, NETC_PM_R64(mac));
+	stats->hist[1] = netc_port_rd64(np, NETC_PM_R127(mac));
+	stats->hist[2] = netc_port_rd64(np, NETC_PM_R255(mac));
+	stats->hist[3] = netc_port_rd64(np, NETC_PM_R511(mac));
+	stats->hist[4] = netc_port_rd64(np, NETC_PM_R1023(mac));
+	stats->hist[5] = netc_port_rd64(np, NETC_PM_R1522(mac));
+	stats->hist[6] = netc_port_rd64(np, NETC_PM_R1523X(mac));
+
+	stats->hist_tx[0] = netc_port_rd64(np, NETC_PM_T64(mac));
+	stats->hist_tx[1] = netc_port_rd64(np, NETC_PM_T127(mac));
+	stats->hist_tx[2] = netc_port_rd64(np, NETC_PM_T255(mac));
+	stats->hist_tx[3] = netc_port_rd64(np, NETC_PM_T511(mac));
+	stats->hist_tx[4] = netc_port_rd64(np, NETC_PM_T1023(mac));
+	stats->hist_tx[5] = netc_port_rd64(np, NETC_PM_T1522(mac));
+	stats->hist_tx[6] = netc_port_rd64(np, NETC_PM_T1523X(mac));
+}
+
+void netc_port_get_rmon_stats(struct dsa_switch *ds, int port,
+			      struct ethtool_rmon_stats *rmon_stats,
+			      const struct ethtool_rmon_hist_range **ranges)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	*ranges = netc_rmon_ranges;
+
+	switch (rmon_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_rmon_stats(np, NETC_PORT_EMAC, rmon_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_rmon_stats(np, NETC_PORT_PMAC, rmon_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_rmon_stats(ndev, rmon_stats);
+		break;
+	}
+}
+
+static void netc_port_ctrl_stats(struct netc_port *np,
+				 enum netc_port_mac mac,
+				 struct ethtool_eth_ctrl_stats *stats)
+{
+	if (mac == NETC_PORT_PMAC && !np->caps.pmac)
+		return;
+
+	stats->MACControlFramesTransmitted =
+		netc_port_rd64(np, NETC_PM_TCNP(mac));
+	stats->MACControlFramesReceived =
+		netc_port_rd64(np, NETC_PM_RCNP(mac));
+}
+
+void netc_port_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+				  struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	switch (ctrl_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_ctrl_stats(np, NETC_PORT_EMAC, ctrl_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_ctrl_stats(np, NETC_PORT_PMAC, ctrl_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_ctrl_stats(ndev, ctrl_stats);
+		break;
+	}
+}
+
+static void netc_port_mac_stats(struct netc_port *np,
+				enum netc_port_mac mac,
+				struct ethtool_eth_mac_stats *stats)
+{
+	if (mac == NETC_PORT_PMAC && !np->caps.pmac)
+		return;
+
+	stats->FramesTransmittedOK = netc_port_rd64(np, NETC_PM_TFRM(mac));
+	stats->SingleCollisionFrames = netc_port_rd64(np, NETC_PM_TSCOL(mac));
+	stats->MultipleCollisionFrames =
+		netc_port_rd64(np, NETC_PM_TMCOL(mac));
+	stats->FramesReceivedOK = netc_port_rd64(np, NETC_PM_RFRM(mac));
+	stats->FrameCheckSequenceErrors =
+		netc_port_rd64(np, NETC_PM_RFCS(mac));
+	stats->AlignmentErrors = netc_port_rd64(np, NETC_PM_RALN(mac));
+	stats->OctetsTransmittedOK = netc_port_rd64(np, NETC_PM_TEOCT(mac));
+	stats->FramesWithDeferredXmissions =
+		netc_port_rd64(np, NETC_PM_TDFR(mac));
+	stats->LateCollisions = netc_port_rd64(np, NETC_PM_TLCOL(mac));
+	stats->FramesAbortedDueToXSColls =
+		netc_port_rd64(np, NETC_PM_TECOL(mac));
+	stats->FramesLostDueToIntMACXmitError =
+		netc_port_rd64(np, NETC_PM_TERR(mac));
+	stats->OctetsReceivedOK = netc_port_rd64(np, NETC_PM_REOCT(mac));
+	stats->FramesLostDueToIntMACRcvError =
+		netc_port_rd64(np, NETC_PM_RDRNTP(mac));
+	stats->MulticastFramesXmittedOK =
+		netc_port_rd64(np, NETC_PM_TMCA(mac));
+	stats->BroadcastFramesXmittedOK =
+		netc_port_rd64(np, NETC_PM_TBCA(mac));
+	stats->MulticastFramesReceivedOK =
+		netc_port_rd64(np, NETC_PM_RMCA(mac));
+	stats->BroadcastFramesReceivedOK =
+		netc_port_rd64(np, NETC_PM_RBCA(mac));
+}
+
+void netc_port_get_eth_mac_stats(struct dsa_switch *ds, int port,
+				 struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	switch (mac_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_mac_stats(np, NETC_PORT_EMAC, mac_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_mac_stats(np, NETC_PORT_PMAC, mac_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_mac_stats(ndev, mac_stats);
+		break;
+	}
+}
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 62611263a93f..9f145082921e 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1453,6 +1453,10 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_mdb_add			= netc_port_mdb_add,
 	.port_mdb_del			= netc_port_mdb_del,
 	.port_set_host_flood		= netc_port_set_host_flood,
+	.get_pause_stats		= netc_port_get_pause_stats,
+	.get_rmon_stats			= netc_port_get_rmon_stats,
+	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
+	.get_eth_mac_stats		= netc_port_get_eth_mac_stats,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 7ebffb136b2f..825601847c89 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -70,6 +70,11 @@ struct netc_port {
 	struct ipft_entry_data *host_flood;
 };
 
+enum netc_port_mac {
+	NETC_PORT_EMAC = 0,
+	NETC_PORT_PMAC,
+};
+
 struct netc_switch_regs {
 	void __iomem *base;
 	void __iomem *port;
@@ -110,6 +115,7 @@ struct netc_switch {
 
 /* Write/Read registers of Switch Port (including pseudo MAC port) */
 #define netc_port_rd(p, o)		netc_read((p)->iobase + (o))
+#define netc_port_rd64(p, o)		netc_read64((p)->iobase + (o))
 #define netc_port_wr(p, o, v)		netc_write((p)->iobase + (o), v)
 
 /* Write/Read Switch global registers */
@@ -135,4 +141,15 @@ static inline void netc_del_fdb_entry(struct netc_fdb_entry *entry)
 
 int netc_switch_platform_probe(struct netc_switch *priv);
 
+/* ethtool APIs */
+void netc_port_get_pause_stats(struct dsa_switch *ds, int port,
+			       struct ethtool_pause_stats *pause_stats);
+void netc_port_get_rmon_stats(struct dsa_switch *ds, int port,
+			      struct ethtool_rmon_stats *rmon_stats,
+			      const struct ethtool_rmon_hist_range **ranges);
+void netc_port_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+				  struct ethtool_eth_ctrl_stats *ctrl_stats);
+void netc_port_get_eth_mac_stats(struct dsa_switch *ds, int port,
+				 struct ethtool_eth_mac_stats *mac_stats);
+
 #endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 1e1c0d279a21..05a1c3e239fa 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -172,6 +172,159 @@ enum netc_stg_stage {
 #define   SSP_10M			1
 #define   SSP_1G			2
 
+/* Port MAC 0/1 Receive Ethernet Octets Counter */
+#define NETC_PM_REOCT(a)		(0x1100 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Octets Counter */
+#define NETC_PM_ROCT(a)			(0x1108 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Alignment Error Counter Register */
+#define NETC_PM_RALN(a)			(0x1110 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Valid Pause Frame Counter */
+#define NETC_PM_RXPF(a)			(0x1118 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Counter */
+#define NETC_PM_RFRM(a)			(0x1120 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Check Sequence Error Counter */
+#define NETC_PM_RFCS(a)			(0x1128 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive VLAN Frame Counter */
+#define NETC_PM_RVLAN(a)		(0x1130 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Error Counter */
+#define NETC_PM_RERR(a)			(0x1138 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Unicast Frame Counter */
+#define NETC_PM_RUCA(a)			(0x1140 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Multicast Frame Counter */
+#define NETC_PM_RMCA(a)			(0x1148 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Broadcast Frame Counter */
+#define NETC_PM_RBCA(a)			(0x1150 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Dropped Packets Counter */
+#define NETC_PM_RDRP(a)			(0x1158 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Packets Counter */
+#define NETC_PM_RPKT(a)			(0x1160 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Undersized Packet Counter */
+#define NETC_PM_RUND(a)			(0x1168 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 64-Octet Packet Counter */
+#define NETC_PM_R64(a)			(0x1170 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 65 to 127-Octet Packet Counter */
+#define NETC_PM_R127(a)			(0x1178 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 128 to 255-Octet Packet Counter */
+#define NETC_PM_R255(a)			(0x1180 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 256 to 511-Octet Packet Counter */
+#define NETC_PM_R511(a)			(0x1188 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 512 to 1023-Octet Packet Counter */
+#define NETC_PM_R1023(a)		(0x1190 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 1024 to 1522-Octet Packet Counter */
+#define NETC_PM_R1522(a)		(0x1198 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 1523 to Max-Octet Packet Counter */
+#define NETC_PM_R1523X(a)		(0x11a0 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Oversized Packet Counter */
+#define NETC_PM_ROVR(a)			(0x11a8 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Jabber Packet Counter */
+#define NETC_PM_RJBR(a)			(0x11b0 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Fragment Packet Counter */
+#define NETC_PM_RFRG(a)			(0x11b8 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Control Packet Counter */
+#define NETC_PM_RCNP(a)			(0x11c0 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Dropped Not Truncated Packets Counter */
+#define NETC_PM_RDRNTP(a)		(0x11c8 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Ethernet Octets Counter */
+#define NETC_PM_TEOCT(a)		(0x1200 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Octets Counter */
+#define NETC_PM_TOCT(a)			(0x1208 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Valid Pause Frame Counter */
+#define NETC_PM_TXPF(a)			(0x1218 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Counter */
+#define NETC_PM_TFRM(a)			(0x1220 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Check Sequence Error Counter */
+#define NETC_PM_TFCS(a)			(0x1228 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit VLAN Frame Counter */
+#define NETC_PM_TVLAN(a)		(0x1230 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Error Counter */
+#define NETC_PM_TERR(a)			(0x1238 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Unicast Frame Counter */
+#define NETC_PM_TUCA(a)			(0x1240 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Multicast Frame Counter */
+#define NETC_PM_TMCA(a)			(0x1248 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Broadcast Frame Counter */
+#define NETC_PM_TBCA(a)			(0x1250 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Packets Counter */
+#define NETC_PM_TPKT(a)			(0x1260 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Undersized Packet Counter */
+#define NETC_PM_TUND(a)			(0x1268 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 64-Octet Packet Counter */
+#define NETC_PM_T64(a)			(0x1270 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 65 to 127-Octet Packet Counter */
+#define NETC_PM_T127(a)			(0x1278 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 128 to 255-Octet Packet Counter */
+#define NETC_PM_T255(a)			(0x1280 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 256 to 511-Octet Packet Counter */
+#define NETC_PM_T511(a)			(0x1288 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 512 to 1023-Octet Packet Counter */
+#define NETC_PM_T1023(a)		(0x1290 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 1024 to 1522-Octet Packet Counter */
+#define NETC_PM_T1522(a)		(0x1298 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 1523 to TX_MTU-Octet Packet Counter */
+#define NETC_PM_T1523X(a)		(0x12a0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Control Packet Counter */
+#define NETC_PM_TCNP(a)			(0x12c0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Deferred Packet Counter */
+#define NETC_PM_TDFR(a)			(0x12d0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Multiple Collisions Counter */
+#define NETC_PM_TMCOL(a)		(0x12d8 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Single Collision */
+#define NETC_PM_TSCOL(a)		(0x12e0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Late Collision Counter */
+#define NETC_PM_TLCOL(a)		(0x12e8 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Excessive Collisions Counter */
+#define NETC_PM_TECOL(a)		(0x12f0 + (a) * 0x400)
+
 #define NETC_PEMDIOCR			0x1c00
 #define NETC_EMDIO_BASE			NETC_PEMDIOCR
 
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
index fdecca8c90f0..5b8ff528d369 100644
--- a/include/linux/fsl/netc_global.h
+++ b/include/linux/fsl/netc_global.h
@@ -5,6 +5,7 @@
 #define __NETC_GLOBAL_H
 
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 static inline u32 netc_read(void __iomem *reg)
 {
@@ -16,4 +17,9 @@ static inline void netc_write(void __iomem *reg, u32 val)
 	iowrite32(val, reg);
 }
 
+static inline u64 netc_read64(void __iomem *reg)
+{
+	return ioread64(reg);
+}
+
 #endif
-- 
2.34.1


