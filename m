Return-Path: <linuxppc-dev+bounces-23692-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59ACFC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:48:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvZcc57qYz3c8G;
	Tue, 07 Jul 2026 18:48:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783414080;
	cv=pass; b=csybRfBqu5KGdCSPUH2P8+ryAsij3bVc+LA2ST/dHDhk6sWNN2hFg7qQ3U1Y4ZyMuk4KV3M/wPJb881WYX+eCDsQxV+ZsnulW7LIPiOkgPLyOQiXbrgGgE+xToBsVA/TIOQWL0vE1Zbpa2ZX/aY4chazrBxYlYhZPS0DPCsYMKh5/8/PZBgYkBFKRzKQcmmD1a3wkzNtaKRlaA2I7AflX7Irdg2sRv5k0tzzaDkFTkRGDRQqaoI6vH5LGDeeGwIQjWCFVX+6ECiDZQUV5rfBdNCDuzdQmYcljIxHyPX3BEdShUYzai3L2lLXBjobIrXpZz2ZTJ5MrA2uBIEf8W4Rmg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783414080; c=relaxed/relaxed;
	bh=RmvpWVF47jUc8h9psj97e6zsVGtTYxdvQZtCviyJaDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T9i+4LuAcpNH36MNmVAUV5379jRqTAd6On7uac/f+Y5nspikBN+U0g4TKwQ+L2MTcolzRA0W89HjBnhDhIcVrTJxuX9USpNnqyIQN7rG0YdXc8KE63YLedP0bwNe0Lh4qECp8At7aH9dEjJbrB+YOmZmRodxllyR2802kzVmBcen6TI+msNgUDM8gUig/Ab2Zu1yMmnDWmh3esjQ3hn0hUH0Ifa3Dp+iqOFcg6jQeUZ80h4SByECQbG2KsTYFgLbKfW3dvW8EKOK9+wbQ+jP9a8WFNt4yXIpnu/WLf0i6cM71jJZLoxEX6NfqRQ5OtTL5CG5TMqxwp0RjhcvRmsHSQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=pBIlw2tn; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=pBIlw2tn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvZcc0Fjlz3c7S
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:48:00 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g49M+7P0HvF5ksDL1wfZDkGYMeamOAK1MwNBz/YgP4W7xgR7G1l6A9OEFB5S3dUNv18tZ/ACbQcR15BsgSF4p0kQ53cIoybv15z4a0hqOH3e1CcXGoGqs8nd11CFY/a25uy4Ns9kTHJIa+wbGtFxTh5biT2MeFFsXbparFJFL1Bp7NoYXF+jVPbhr3O+Iui6DsWPKCNwoSshjf1EkUQYgwsX61cXQ6KXdqluC5bY2EZvZlBMNEbRzLW9TLaoKxh1m6xefZz/8xRIbT03sgcMwy3BxoRWEiauVD7zOgQYQKdSizO+uJu+6VlfYY6HIXQawl+QzoV/X7QmwprQNL5P2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmvpWVF47jUc8h9psj97e6zsVGtTYxdvQZtCviyJaDU=;
 b=rwa4UCuNXEOiSS/fFudcOxDRD0o9mNGVRodeEtCvIu/WRrfEJBJe8RQzVt4OMvR256NDSxl6i7Tkk0lHuOCj5NvORY/Tv33D3bflJeJf58an9wTYifMbqYx/HNgcELus97YYiPqCKbYdpiKKrrlgUygqux/NEUrFyg4fn3tVu77qHpTV/YJ4Bch+f201yQ0oGuf4bXhqnWet21g8YY8Xz6Ylx5B4+v04iLzF1AxXq+aE6Y6Q73NthCztS7YRTQhBN+PLNAbYgm+T1W4kH8lmKRBPttlyvhfAYz8dmKINAgJYpu9nVK7hezzmTw6OXW4ROiJSBjMxpoFuMg74May35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmvpWVF47jUc8h9psj97e6zsVGtTYxdvQZtCviyJaDU=;
 b=pBIlw2tn7xc9V0PEULBHFC+zgtT9smOsChuhlnJE9PcIqGU4/RNHmzOEPzE0YGrA/wri58f5bl9rQ2MGZIGcaJf1Gi/mhJCeoNf869x5g7JICCnfMsE0WKKSWjyPf7nlcFQfVh/DRYWaniNs/8CFjfhJ2jH/Umg9HVHCvGAk0mQtejp+uZASlNVIxJg9CCsIe94kGZzGa8o3zaN2la93qRAkA8vQz8R0OIxCdnrkTwn9Ix8QZIeW/mNU80AYEV/E6TC+6mzf2ltWLl9Rmfomjr/0j0yvDnHLlnysCYLXn8wq3xjSWlsFP82vWmPRlVYGijPzrZsm7VvDycQ0lTQXww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:47:47 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:47:47 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 09/14] net: enetc: open-code enetc4_set_default_si_vlan_promisc()
Date: Tue,  7 Jul 2026 16:18:29 +0800
Message-Id: <20260707081834.710730-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0205.apcprd04.prod.outlook.com
 (2603:1096:4:187::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4fdf13-5b92-4306-2bfc-08dedc046b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|19092799006|56012099006|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	InPvcSiE66104x9Op3XtB0UFgtfvfNVBBZmBtVfkovdochT9SBca70seNugh+viNUBlbJVJ44xWiKVPZzHb7teSCYfqzvSk55Vg5qupX4/1ps5G566PjlXwiNd8xaakWDIzBu8Eath7Pjy2XF2V0SJGBR6m7Q9QlW5yrec7ZVMqvskGZ49sYzAyDwMiWG3eLQVJi0J9fb/cXLiQQFJBwEWGvBZ6Ba6bMyJPPVvy9Xj3C9UcYV3U9swPivbkuyItli1Q25FluzdBRi8on8BK8MXJOYBD0Vvq3HDOmwA3kVyBiGjiqHGrpAArN+kXsWeVM46BssB0dHOSYWkHxlwdrDybhwkXemQXPWW/nhEXF+lj34oPxGU6wcd0K0qFkt3auInDxYKDIMz5z69TcP6ojVukgDjlBBrxfwuTTzFC2tDXuQCjp/HoL5YdzZfcmqG8Wfts2avQ9lg0onT7/ahLtXFggAIBGQlYwkSEeV9o+N59qIXizp1ddWlY06NmW/pWxGQW7/GJHm/tQ0FgEioJTAP7LKZFXqWa+SL2ocTHhhOA3n6jpnfWEr5cXq3r0Fu1b3N9/nDkbC2q03J4jnWGJy3l5lnu5ZuFue9xiwEil8Hu+gUZLPXuEhd5QS/e3lPwudy0y0p4Y4+92P1EM7dAm7TzK+BlvSORi7kImDY1SjT6VLefocDocyElNonAcirAXukzqAW5GhzJ2rOeXRM7ljw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(19092799006)(56012099006)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x/CzgU9MEZnUKMLZKnDuhzdyvmuk4OWK2gIIN1PeH0yntHS37SFE+hiNY2o+?=
 =?us-ascii?Q?ZHeguraHagUsHznn0DqZjKccwWXRvaqIB0xRWNjZ3RQB1YSK8l/MYD/cWwHc?=
 =?us-ascii?Q?VBFf9Bsy884fl6zZH6264uVIV+FXXlcki1q1VBw+tZMi9G8H6xM8qUYbTJfL?=
 =?us-ascii?Q?u0Oc5VXgg/IsgU80qIblsLd8NCHCgZFvCRqY/Cbq3kTeSOW2hkCxGXQ2ySOL?=
 =?us-ascii?Q?yGCPb0ick3LWaoE0LO8sGBb7psVHoexU63NJM98amzqJbjpvmectSaLgBpv1?=
 =?us-ascii?Q?/yNx10D0F4/VYLQd1rfIgSKjRGi7cnFFXos9liVc7g5OmxpyjeRGzi22WQ8x?=
 =?us-ascii?Q?cQJAk5uTdqPOScKHKPfSeyttdOCA7oqqsAPbo2JiQTA8iACZENOrFzwaiUaq?=
 =?us-ascii?Q?ck6Stf9WvkBWc/cO1838cQkbvp/62Y9UA6Ri3k9vMKgnm2gTg3VNRnwrfxK5?=
 =?us-ascii?Q?mp1wxoLvX/b6jc87MKIH1jpHsEPVEbOYGvJCcJNYwSrl5S5FBh72FDt3yUnL?=
 =?us-ascii?Q?Gzf0hdVRowFsyR8UId5vMwW++oor4H4UzRUj0tBVHVlbviAclCSPRVqEAhrq?=
 =?us-ascii?Q?an2tU93ktfJCMplHmbWhEQAj0U2kjKk9mUbzwDD75KesrjR42FFyW6s7E3a9?=
 =?us-ascii?Q?gVFoccUmEhomBoS1ApyusKkfZYpOQ0Iz2x3od6JqYgXOPsFO3kdhAswJjpsd?=
 =?us-ascii?Q?dU+BRJ11Q8oPjwRFEvCMNSQ6gfkBLb+L+1r/WAk3dCRL7MMWaZ+GMvlUa4kC?=
 =?us-ascii?Q?HFBTfHJGJEjcBtdkKExKrb/IOtTlCVrpYcmUQPrrRE7NNEUcgpXsM/NeV0cL?=
 =?us-ascii?Q?dpyjbg1HMqYoWwBmPV8GEP/FALJYX1HOZghNdaXjh8xDj5KFJ7cZMuPIGiKQ?=
 =?us-ascii?Q?5DQ5rW8sqJnDQaqSj1WmZv9Sk+tVfK+N7InWTHXT05jipkeYXgVrYKaj1Fvu?=
 =?us-ascii?Q?O0gU7hfGBjcZS5/ASKw4GaXXBcplECGRiq683KMbdeNu7/y+YQ5oS7hK2qul?=
 =?us-ascii?Q?EdFcEDU/lqkr3XPBvo8Kwa3aAI5QIEuQD+4s2kI2ABDYPm61ggW40k5xc9sn?=
 =?us-ascii?Q?PZOahmyEJVED/eUtmtxsr/l48CXCxYbLMmU4ma4i4ziwuV6larZ6J7cQOcMA?=
 =?us-ascii?Q?eWXWEZzyAgHhhf/fL9SGD/EMRYD5jDm1pcbCw/5AmsQZIkelXFXZke2oGhFL?=
 =?us-ascii?Q?poXe6yBdKYrVihCi9Y4C1nglakYcu/aGOMG9+d22yatObbJR2IMl4aVYYJWJ?=
 =?us-ascii?Q?NCUXfyoDh4gTzFLVsWRoZxI+AUOUfPKhzwCe91epDZqsAJpKdmFNwEKbMNHG?=
 =?us-ascii?Q?oO1FB42UGwCRImysKcsHhax7cxzL+2rs5zS0j8s6whOGyEi2L8Ttq4/YZSJM?=
 =?us-ascii?Q?X42CS9s8+kZ74+a/A+5oij8W4VIjCGaG13tkb0xfLFhcPMSZ+VuX1i2Mqt9q?=
 =?us-ascii?Q?hgtz1Q4yEhFuxOe3eRhlhCYq4+hskiq3al00Z2iF1A9WHaYUUjpA3KC24odn?=
 =?us-ascii?Q?9f81XSaU60aqO1atCOUXDffGxyyef13yXbw36e5aOhbg1nQPm74PsxYrhq32?=
 =?us-ascii?Q?zn8g7tZ4ZdDPNlZfOyKKqeYVY6UG6rcwfZcRMzDGhKYSuS/dNDUJnIWwkyFd?=
 =?us-ascii?Q?cyvNgU81QwX584feFZXzyMQjxc11fHhkhqxSPztMSouNRGk139TBAyTpI2dk?=
 =?us-ascii?Q?qAmtkK8Bs0U1z2KwQlzC2tdPGKn/aHoRhvSYBg7qPTcpBl00VBTszosJJst/?=
 =?us-ascii?Q?nyCdfMQVm2XxrPqPUqqRyRF0pXrDR89unPs9JdKGQ1HMCMZxLN+/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4fdf13-5b92-4306-2bfc-08dedc046b7c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:47:47.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +A++iAtKY6H8KTxvZ/0S+PTZ+4BRKWeAhOz2ncTXVmeUoY9KQluDZQ5PF9Y9JVsJNLJX4sLZCjwwn/py0Lykz0fxG8vpQ9wm+BBm0F2RAPB18hkuVLG7qqn+DN/qduTA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182

From: Wei Fang <wei.fang@nxp.com>

The function enetc4_set_default_si_vlan_promisc() is only called once,
from enetc4_configure_port_si(). Open-code the loop at the call site
and remove the single-use wrapper.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 859b02f5170a..505e4abf6c37 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -307,17 +307,6 @@ static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
 	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
 }
 
-static void enetc4_set_default_si_vlan_promisc(struct enetc_pf *pf)
-{
-	struct enetc_hw *hw = &pf->si->hw;
-	int num_si = pf->caps.num_vsi + 1;
-	int i;
-
-	/* enforce VLAN promiscuous mode for all SIs */
-	for (i = 0; i < num_si; i++)
-		enetc4_pf_set_si_vlan_promisc(hw, i, true);
-}
-
 /* Allocate the number of MSI-X vectors for per SI. */
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
@@ -361,7 +350,9 @@ static void enetc4_configure_port_si(struct enetc_pf *pf)
 	/* Outer VLAN tag will be used for VLAN filtering */
 	enetc_port_wr(hw, ENETC4_PSIVLANFMR, PSIVLANFMR_VS);
 
-	enetc4_set_default_si_vlan_promisc(pf);
+	/* Enforce VLAN promiscuous mode for all SIs */
+	for (int i = 0; i < pf->caps.num_vsi + 1; i++)
+		enetc4_pf_set_si_vlan_promisc(hw, i, true);
 
 	/* Disable SI MAC multicast & unicast promiscuous */
 	enetc_port_wr(hw, ENETC4_PSIPMMR, 0);
-- 
2.34.1


