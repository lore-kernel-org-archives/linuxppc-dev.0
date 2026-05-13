Return-Path: <linuxppc-dev+bounces-20814-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD43CD343F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:04:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdbG0fCVz2ytx;
	Wed, 13 May 2026 13:04:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641450;
	cv=pass; b=Ezc1nb+oxY2cZ2Qml+DdxiOAaZ+eDy/ImPbvdlNheJICoY+XgD6+d8Vjn/2U2fbCcxq9sM80xZlg2oSsO0ptTXiIZp+/zCjYCkWD/THW6ym3f4DCNmUJAqzrZnpqoGWL2SAEJdnKT0HJ8C0x3/Dnco6keyQIK9/NsX8kl3ordnalh80pj0qopJ/jEHqsxXN0uawYQWOb2x4jTY44SFqDCA+KJDAZVBx/L4KdGwhDfxARLXAGyActxti+httio0Sw0DSgel0zR7V2bOBrO1HolQk903yWvbmwzHZmxNLK37mdLI3UQZ+J9KDfIOMlCBpl2S0oa55WooyViDUxRqrk2g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641450; c=relaxed/relaxed;
	bh=QIp2/YqzFhUchTFRGMU2uA3E+i9d/iUukEf+x9J9oxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hh5kZL7Wg4STrYra5YGp3QIRCEXUzJOuXI4fKDHTl2i1i2jNjLglnIgHfbe3IGkOZbVpbc48y8hczZP2MSJn67IKNhh9bTVRxp+wMNq0IR+SrS2BmDBURdTCZ28aiyLt0b44OMyN8zT3G3fxN5R9BsX5xTPYsMq5vLuqMeIDTgnrnSpn9SI6Fw6h/VJxnIEzyqdEcMIg1v8ZWCX64n5SiS53sFuvD4z0pzbJ5wgji6AC4QBwF1fNxmb60MITTvReCDX3Nya5zDsQ6qy5yk25v21IbbV7S1M3yAgivWI4elNmwu60QukpxL0fBaSTY9gDmXWdRLJSZKrrv58EQwqSmQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=NRp0Nd+p; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=NRp0Nd+p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdbF06k1z2yrt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:04:09 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+H37fj4eWWtk1bF2/Il2H7Jrz1Rdq1ta0PdYjIu2Wj0tlgceS/AypZDd6y0YsWeW3QUdOd/E3ua2awRt2adHZNbyaW8582gXYG94rg5+Yi6wSPbaEUrZ0JJTHbrj1nD+6JAIF3DWdJONFACVxM32wEXepcCEj88GyL8uIdmHlO8ocuXA3CMMqjOTtnLgqAFBC8/x+lKp5WVEVZA0r3naRvbDCeCsqSMAOkITGSGmw6vDS3qdQu4dcgmJmQb2fgI49ZdP2jVvvMoLTg6Ce6jzyiMia84002eaOn9Ue0PzYz5ZwA/krm2r40IYuoenPnKnpZSgBJ9Rl4sn+B+ywDmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIp2/YqzFhUchTFRGMU2uA3E+i9d/iUukEf+x9J9oxI=;
 b=PBca3wBzpPWmNeOK1XCUoxyYNHRGYrVOvXFK1ES5ITJJTTMhou/rCQS9thUgSHdp1Aj26ABnQ2vlPOGhRyZGhRmJKOC27Q6lUE6WQtlT+6YZGsnotOYSvIjhGU7peGvsyjoxG5FhDvNzzSUMJ6kMP0AspYRkSs9asuAvneenMuTi0ZlZwrqg27sGi+bALsrw2r0+wygDE8kDMzcNHnPR2NDWwpJipcro/6HEM+nwpyePRlndRxV8QvaWfLCOJsGlANBRonHZaNkEo4r/a6LngD+pX8r/spgDoEQDBoevj7ExOkbXW3UY/AjLTzTecWsOfNcFRZ8e7jys7Qxtfa0D6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIp2/YqzFhUchTFRGMU2uA3E+i9d/iUukEf+x9J9oxI=;
 b=NRp0Nd+ppXh1djJ6cyNwNIJRc/yfi1cW8nGkFe7W44GVwDgxjehhp85sp13FfuHJ2fv19psKqa40GCzVEfOw+xnFPATTiiGjIjUp+nfP/bSmZO+IJQ0ylrMDc/gscyUVTGZfNqdHc41rdPjj/bZoXoIKbJA2dV8LhTqApjDJ0YDY/dNDDUOZ1eC6jPy7hyie3Qmtiycw1y0oOoDEsIk+GOC2pZdM0eFcFJMDL45fQBX5LPddwci0SGCpbzdvv567Z/Y3M4Vc6uAl0INzp3oBMhPvs2kIIcPs1Mkk6gYpIWkJDu8oRJ9uew/0hxpVHnxa46viMDmzAxrdHNk/y1imPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:04:02 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:04:02 +0000
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
Subject: [PATCH v7 net-next 13/15] net: dsa: netc: initialize buffer pool table and implement flow-control
Date: Wed, 13 May 2026 11:04:52 +0800
Message-Id: <20260513030454.1666570-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513030454.1666570-1-wei.fang@nxp.com>
References: <20260513030454.1666570-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GV1PR04MB11525:EE_
X-MS-Office365-Filtering-Correlation-Id: 0714698a-b537-4659-8fe2-08deb09c4932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|22082099003|11063799003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	bAUnzeP5lkMQWnD7r46f0bdsKZx+Q2tPuiPh06eFi0+KBYxXD1QIQkhEG7iPCYSFPBoySfU4/tVK1z/e81e9173uEPsNYm1BLMUryjSuhoPx1MxCy48FWNGMxzD3zI5DoN5djbsJb623DktoO4QLSeXSyfIYsuMwmwDwHtz7yBwuc5yWfBHf1+RgkqBGV3y1k8C10zmjdeYx8qlDs9FNWIH9gttYhFL6vG1yhGJqoJGK3RwU1+PZ5jR2v42mh7D7lp/+rbNy49lbp48vl0kUH8lA+/N95T37TG83a2wQBZEOINEFw6QWka2BTVC8r+nquqLQ51ydtoqLykK7mub3C/zguuYPCjmgVed9Jlw6/i8ycP6PBNaqFpIm3ulPOL7xxSBLOKADpSlTrzlvn00ApolF0Dm5PZDNmePr1GTmUSPqckYP2sV2z1s+2yTysnUJ6pgi0WX/HN0v27ToMcTkrxU3T9llP4SZmxRt/ngLVEVC3UBcl3U0gGbemc182+7Kr3Kzjp6JhZDgbp8xhAQK5MD8GMyT/IGMBU4IJKITRokQgxa5iAYu7z5IHNiZofAZz/s30zmNO59Zj68djl99iDwYrz6GQqDrhOE/yWjFIFZeyNOkNfpwx9OhlIniG57oeKDQfJZDqyZQQIgGyiWD+pj0IQYin+EsEuK6kCQKlDaPn9jOeoSZAtnw9X7QkXla33KlzXoD8N+urCYlrnJwyf5Kh9nvXSgBY/b5J6abnql6rPNio6j/7AFYNz0vozAPdVfrcDzGWKPYjhgXJT8nvg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(11063799003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zis4BmiTU+a7aigcpQltKCjaySsrNDh3s+2eyXdYul6uA+GT7WQmEtqMs2g4?=
 =?us-ascii?Q?tdX7QJpRJG2RD1r9jmt/2AxRQEc+tPXp/Kyj951lpvW0T3y+HPoiENLdDB/A?=
 =?us-ascii?Q?dggtGxEQifThUSiTZ6eTVeGQGFb3hH+NTuZ+yQQR+QIvCPiGO63+0SEIMsjD?=
 =?us-ascii?Q?WTgBRXwmUlfhGvhCuPyo/i03dqgs/TWJEElzHNXOlwjxgAg9KWFWQ9o+UBDE?=
 =?us-ascii?Q?ncSPorJ+cuaqYBWgCa2d8ZIauc1sqxmeGIDcltDnFH5fXrdoMqcA1QhEXSJ8?=
 =?us-ascii?Q?K2dBtm9GIa9Q/YuHaV2cIUjzui3bm+vVF1xyhDIz9vEJmocG1ELAQVKl4TrB?=
 =?us-ascii?Q?EaNrq+s5iFLwpsxCQ+qbgwgG55VEefovrNyhbDIubmsSSPlvG79XbwGJO3LE?=
 =?us-ascii?Q?EowmAJqb8WUxgLpGGzg+WmO/dehkUkrO6Jyq9uqKgYcfPYEXgRiWzxwjUldS?=
 =?us-ascii?Q?A02mIMx0zJmP9aJ3e/LIwPpz8s1cFNRT2klu6S0mg+nK0JUOSkWYldwF+SK1?=
 =?us-ascii?Q?HYXszq5Kn+8fSMTMDcjrmYkctZvDYIJyif5rQEjybNmb6mXzIHwb2cgvzeHP?=
 =?us-ascii?Q?qZxPQL5VcLIMdlVnFUfQqeLwFghKcq4Gdr/OL6SCgwvEfHK2uDwiycawud7g?=
 =?us-ascii?Q?5sbhLd7b8PrKe9+oNxei8fZbu1WR0DSsKBshkYPw76tPY9crG1y8jedW9vXg?=
 =?us-ascii?Q?jDA1nhT0VvUKkmiuBmje7VC55NkgYdZ7xYQ5ZYD+vAnHRkftK+cAyh4+jwWg?=
 =?us-ascii?Q?AFe87lUImKB5NIZRiynohzEAPcFW2tJ/Kw5HTk/n3Zhuj6y+91O5JlxXJtCJ?=
 =?us-ascii?Q?mukCxqtwufk4TxZ61TM2nI/fbRNt1mEvKiWa2JfBcaNId+JYoW8GAkJZyqY5?=
 =?us-ascii?Q?dzHkYHDhtm747Naix9DOj4m+antFB4PbClWekJ9RgvPwrLEpxZQ89Z7YvDGg?=
 =?us-ascii?Q?/esOHL4BYmEB8JbDqjstVYyVHAyONNneoRY+VdTSyEMsU8nc/4N2y9R6ApEC?=
 =?us-ascii?Q?HY+o+A4X9wtTxciQVACD+XL7OdJzHktEuoOq5EmWvbOFVANttSF4ynbx4N52?=
 =?us-ascii?Q?Y1SMVaIM1ui7T1iCoBlOjfhFT3CHchoH3okGGxuVmsbT9kkR2Rmsv3+73n5L?=
 =?us-ascii?Q?o4eOpvISrcRupnahCLcezziUURCXzOh9QucPvFldyueJTJHtl6fmfrgK71Jk?=
 =?us-ascii?Q?2nBxj7euVR6ucew32xvTYtwa/kwYqGrBIFm+sw7Me0deECUVQYkte+y6DeOU?=
 =?us-ascii?Q?W2qZ2VAxrGcKNt/ALuDPjj2Kvo3q1wOjEo00jdSrV9AmwSV6UDYMpjCJpj73?=
 =?us-ascii?Q?a3fxiu+p2kq+oEwzCTc6/mzdX213wZm76P5p8xCN6emqP0FVycdDebr+AyZQ?=
 =?us-ascii?Q?fFNmEs+pa3yBKyuGdKCgXfaiQSAfnNnnmPgQ1wluVtGn2r2ynZY4ENo/E39D?=
 =?us-ascii?Q?WVKFUpryZ9XzTY0XX3KYEBVtvNXF9te8jL/7P1G0bn7FxZoBEgz+qbEoozpe?=
 =?us-ascii?Q?fjuoXRbuoicRQL2Rd32+vgTk9UuDAHJT6q21DZhakU5xQ3ULC/NvAtKkSdeI?=
 =?us-ascii?Q?pbLHPmQGd5WdLwStbSqRUbne0l1YwyvebRmeuDdTudCYTOnFcTYZw8gsK/lO?=
 =?us-ascii?Q?HkIi8Z30KMr5vTgCV0QQR0/QvdjWHoi256fPjWlcMOUYd15GtBLcfQZkg8Ge?=
 =?us-ascii?Q?1YcGj7kt0GMSHyfMAzYDtkYX8KnpdoPfBeXos5I3iryuB79b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0714698a-b537-4659-8fe2-08deb09c4932
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:04:02.5469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPIFpS9fy7MuIkCi270v0P0rqXbDo22+apdrhM7xDAnUlxhxp5rdtP5LhZiXLBvnVfUAjLgIuY3n2kdCEwFH1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525

The buffer pool is a quantity of memory available for buffering a group
of flows (e.g. frames having the same priority, frames received from the
same port), while waiting to be transmitted on a port. The buffer pool
tracks internal memory consumption with upper bound limits and optionally
a non-shared portion when associated with a shared buffer pool. Currently
the shared buffer pool is not supported, it will be added in the future.

For i.MX94, the switch has 4 ports and 8 buffer pools, so each port is
allocated two buffer pools. For frames with priorities of 0 to 3, they
will be mapped to the first buffer pool; For frames with priorities of
4 to 7, they will be mapped to the second buffer pool. Each buffer pool
has a flow control on threshold and a flow control off threshold. By
setting these threshold, add the flow control support to each port.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 130 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c  |   2 +-
 drivers/net/dsa/netc/netc_switch.h    |  19 ++++
 drivers/net/dsa/netc/netc_switch_hw.h |  10 ++
 4 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 34b5e655d1c9..7a4064849693 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -212,6 +212,9 @@ static void netc_get_switch_capabilities(struct netc_switch *priv)
 
 	val = netc_base_rd(regs, NETC_FDBHTCAPR);
 	priv->num_fdb_gmac = FIELD_GET(FDBHTCAPR_NUM_GMAC, val);
+
+	val = netc_base_rd(regs, NETC_BPCAPR);
+	priv->num_bp = FIELD_GET(BPCAPR_NUM_BP, val);
 }
 
 static int netc_init_all_ports(struct netc_switch *priv)
@@ -403,6 +406,15 @@ static void netc_port_fixed_config(struct netc_port *np)
 	/* Enable L2 and L3 DOS */
 	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
 		      PCR_L2DOSE | PCR_L3DOSE);
+
+	/* Set the quanta value of TX PAUSE frame */
+	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), NETC_PAUSE_QUANTA);
+
+	/* When a quanta timer counts down and reaches this value,
+	 * the MAC sends a refresh PAUSE frame with the programmed
+	 * full quanta value if a pause condition still exists.
+	 */
+	netc_mac_port_wr(np, NETC_PM_PAUSE_THRESH(0), NETC_PAUSE_THRESH);
 }
 
 static void netc_port_default_config(struct netc_port *np)
@@ -636,6 +648,79 @@ static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *priv)
 				       bcast, NETC_STANDALONE_PVID);
 }
 
+static void netc_port_set_pbpmcr(struct netc_port *np, u64 mapping)
+{
+	u32 pbpmcr0 = lower_32_bits(mapping);
+	u32 pbpmcr1 = upper_32_bits(mapping);
+
+	netc_port_wr(np, NETC_PBPMCR0, pbpmcr0);
+	netc_port_wr(np, NETC_PBPMCR1, pbpmcr1);
+}
+
+static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
+{
+	int bp_per_port = priv->num_bp / priv->info->num_ports;
+	int q = NETC_IPV_NUM / bp_per_port;
+	int r = NETC_IPV_NUM % bp_per_port;
+	int num = q + r;
+
+	/* IPV-to-buffer-pool mapping per port:
+	 * Each port is allocated 'bp_per_port' buffer pools and supports 8
+	 * IPVs, where a higher IPV indicates a higher frame priority. Each
+	 * IPV can be mapped to only one buffer pool, from hardware design
+	 * perspective, bp_per_port will not be greater than 8. So 'q' will
+	 * not be 0.
+	 *
+	 * The mapping rule is as follows:
+	 * - The first 'num' IPVs share the port's first buffer pool (index
+	 * 'base_id').
+	 * - After that, every 'q' IPVs share one buffer pool, with pool
+	 * indices increasing sequentially.
+	 */
+	for (int i = 0; i < priv->info->num_ports; i++) {
+		u32 base_id = i * bp_per_port;
+		u32 bp_id = base_id;
+		u64 mapping = 0;
+
+		for (int ipv = 0; ipv < NETC_IPV_NUM; ipv++) {
+			/* Update the buffer pool index */
+			if (ipv >= num)
+				bp_id = base_id + ((ipv - num) / q) + 1;
+
+			mapping |= (u64)bp_id << (ipv * 8);
+		}
+
+		netc_port_set_pbpmcr(priv->ports[i], mapping);
+	}
+}
+
+static int netc_switch_bpt_default_config(struct netc_switch *priv)
+{
+	if (priv->num_bp < priv->info->num_ports)
+		return -EINVAL;
+
+	priv->bpt_list = devm_kcalloc(priv->dev, priv->num_bp,
+				      sizeof(struct bpt_cfge_data),
+				      GFP_KERNEL);
+	if (!priv->bpt_list)
+		return -ENOMEM;
+
+	/* Initialize the maximum threshold of each buffer pool entry */
+	for (int i = 0; i < priv->num_bp; i++) {
+		struct bpt_cfge_data *cfge = &priv->bpt_list[i];
+		int err;
+
+		cfge->max_thresh = cpu_to_le16(NETC_BP_THRESH);
+		err = ntmp_bpt_update_entry(&priv->ntmp, i, cfge);
+		if (err)
+			return err;
+	}
+
+	netc_ipv_to_buffer_pool_mapping(priv);
+
+	return 0;
+}
+
 static int netc_setup(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -665,6 +750,10 @@ static int netc_setup(struct dsa_switch *ds)
 	dsa_switch_for_each_available_port(dp, ds)
 		netc_port_default_config(priv->ports[dp->index]);
 
+	err = netc_switch_bpt_default_config(priv);
+	if (err)
+		goto free_lock_and_ntmp_user;
+
 	err = netc_add_standalone_vlan_entry(priv);
 	if (err)
 		goto free_lock_and_ntmp_user;
@@ -1218,6 +1307,45 @@ static void netc_port_set_rmii_mii_mac(struct netc_port *np,
 	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
 }
 
+static void netc_port_set_tx_pause(struct netc_port *np, bool tx_pause)
+{
+	struct netc_switch *priv = np->switch_priv;
+	int port = np->dp->index;
+	int i, j, num_bp;
+
+	num_bp = priv->num_bp / priv->info->num_ports;
+	for (i = 0, j = port * num_bp; i < num_bp; i++, j++) {
+		struct bpt_cfge_data *cfge = &priv->bpt_list[j];
+		struct bpt_cfge_data old_cfge = *cfge;
+
+		if (tx_pause) {
+			cfge->fc_on_thresh = cpu_to_le16(NETC_FC_THRESH_ON);
+			cfge->fc_off_thresh = cpu_to_le16(NETC_FC_THRESH_OFF);
+			cfge->fccfg_sbpen = FIELD_PREP(BPT_FC_CFG,
+						       BPT_FC_CFG_EN_BPFC);
+			cfge->fc_ports = cpu_to_le32(BIT(port));
+		} else {
+			cfge->fc_on_thresh = cpu_to_le16(0);
+			cfge->fc_off_thresh = cpu_to_le16(0);
+			cfge->fccfg_sbpen = 0;
+			cfge->fc_ports = cpu_to_le32(0);
+		}
+
+		if (ntmp_bpt_update_entry(&priv->ntmp, j, cfge)) {
+			*cfge = old_cfge;
+			dev_warn(priv->dev,
+				 "Failed to %s TX pause of buffer pool %d (swp%d)\n",
+				 tx_pause ? "enable" : "disable", j, port);
+		}
+	}
+}
+
+static void netc_port_set_rx_pause(struct netc_port *np, bool rx_pause)
+{
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_PAUSE_IGN,
+			  rx_pause ? 0 : PM_CMD_CFG_PAUSE_IGN);
+}
+
 static void netc_port_mac_rx_enable(struct netc_port *np)
 {
 	netc_port_rmw(np, NETC_POR, POR_RXDIS, 0);
@@ -1319,6 +1447,8 @@ static void netc_mac_link_up(struct phylink_config *config,
 	    interface == PHY_INTERFACE_MODE_MII)
 		netc_port_set_rmii_mii_mac(np, speed, duplex);
 
+	netc_port_set_tx_pause(np, tx_pause);
+	netc_port_set_rx_pause(np, rx_pause);
 	netc_port_mac_tx_enable(np);
 	netc_port_mac_rx_enable(np);
 }
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
index bb4f92d238cb..34aeb6fceb3c 100644
--- a/drivers/net/dsa/netc/netc_platform.c
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -14,7 +14,7 @@ struct netc_switch_platform {
 static void imx94_switch_phylink_get_caps(int port,
 					  struct phylink_config *config)
 {
-	config->mac_capabilities = MAC_1000FD;
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_1000FD;
 
 	switch (port) {
 	case 0 ... 1:
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index cc278a862623..4a9bf69907e9 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -28,11 +28,27 @@
 
 #define NETC_TC_NUM			8
 #define NETC_CBDR_NUM			2
+#define NETC_IPV_NUM			8
 
 #define NETC_MAX_FRAME_LEN		9600
 
 #define NETC_STANDALONE_PVID		0
 
+/* Threshold format: MANT (bits 11:4) * 2^EXP (bits 3:0)
+ * Unit: Memory words (average of 20 bytes each)
+ * NETC_BP_THRESH = 0x334, MANT = 0x33, EXP = 4. Threshold: 816 words
+ * NETC_FC_THRESH_ON = 0x533, MANT = 0x53, EXP = 3. Threshold: 664 words
+ * NETC_FC_THRESH_OFF = 0x3c3, MANT = 0x3c, EXP = 3. Threshold: 480 words
+ */
+#define NETC_BP_THRESH			0x334
+#define NETC_FC_THRESH_ON		0x533
+#define NETC_FC_THRESH_OFF		0x3c3
+
+/* PAUSE quanta: 0xFFFF = 65535 quanta (each quanta = 512 bit times) */
+#define NETC_PAUSE_QUANTA		0xFFFF
+/* PAUSE refresh threshold: send refresh when timer reaches this value */
+#define NETC_PAUSE_THRESH		0xFF00
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -94,6 +110,9 @@ struct netc_switch {
 
 	/* Switch hardware capabilities */
 	u32 num_fdb_gmac;
+	u32 num_bp;
+
+	struct bpt_cfge_data *bpt_list;
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index b04e9866d72a..caf5977c5100 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -12,6 +12,12 @@
 #define NETC_SWITCH_DEVICE_ID		0xeef2
 
 /* Definition of Switch base registers */
+#define NETC_BPCAPR			0x0008
+#define  BPCAPR_NUM_BP			GENMASK(7, 0)
+
+#define NETC_PBPMCR0			0x0400
+#define NETC_PBPMCR1			0x0404
+
 #define NETC_CBDRMR(a)			(0x0800 + (a) * 0x30)
 #define NETC_CBDRBAR0(a)		(0x0810 + (a) * 0x30)
 #define NETC_CBDRBAR1(a)		(0x0814 + (a) * 0x30)
@@ -141,6 +147,7 @@ enum netc_stg_stage {
 #define NETC_PM_CMD_CFG(a)		(0x1008 + (a) * 0x400)
 #define  PM_CMD_CFG_TX_EN		BIT(0)
 #define  PM_CMD_CFG_RX_EN		BIT(1)
+#define  PM_CMD_CFG_PAUSE_IGN		BIT(8)
 
 #define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
 #define  PM_MAXFRAM			GENMASK(15, 0)
@@ -149,6 +156,9 @@ enum netc_stg_stage {
 #define  PM_IEVENT_TX_EMPTY		BIT(5)
 #define  PM_IEVENT_RX_EMPTY		BIT(6)
 
+#define NETC_PM_PAUSE_QUANTA(a)		(0x1054 + (a) * 0x400)
+#define NETC_PM_PAUSE_THRESH(a)		(0x1064 + (a) * 0x400)
+
 #define NETC_PM_IF_MODE(a)		(0x1300 + (a) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
 #define   IFMODE_MII			1
-- 
2.34.1


