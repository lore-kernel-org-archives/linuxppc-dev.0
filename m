Return-Path: <linuxppc-dev+bounces-27675-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D8AC88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:25:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmPKV071sz30Vd;
	Fri, 18 Sep 2026 17:25:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789716317;
	cv=pass; b=Yc0NpE/VjnUQ5iK5Ms3PuKO+P6AEZi0caXm43PQNYpfd7vt2I7xJdgVud8jYdZKlVwqryqdhQVcF5MtxrD1XKAqkaGxpSeG7Ev8XUMisPtHVqCpd0BvknZMSsWcNuUi5hEFrHkKd0WeBDYCjUOqGuUdC3nXqmY3iwFU1dyjtnlW3O4NoevRXe0TNY+BVBnC4lH/tlT2SpP0LFRC1/+xuaCT7HxbiRnETH/HFwSq/ArOgBctU1xQ5f0HWY8LFPJ7SXP34wCD03kbBeUuYV68T/hpLwQWCw25QLT81Rd+ognZrlmBiUTcXhrg4SnynU6XeKI/IJkD1l9sXH+bRFPrQGg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789716317; c=relaxed/relaxed;
	bh=0mY2CnvyLiilgStSmY82ck4KyXQ8qtTMMTeQYFTqZmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ga26dR0TDFNQyjP0MciNaJD8MnEyhZqX5XaqhVnfRhkfRvo2YZmn52EAhuoP/vl8sFcHFZIbPRgs4dGh6/fRgMUrJQN81beonLZd8wna4zQggD7WIH4oSNQVhr2qsoLCsQ5Y63tAVP+6EQe/26XwxdFEsNqPuNoDm/QKQeg1Zo3lNbESMEN8ALooLPAqP1E1Pb9PGdm3cjbNS8KXiGf+/zlatXtUpk0TjJQAutrg+8zLjzZEeukv9Dko47i2/B6CrY2PB5wCqAH8Om2L8yLh6qco6YLNJmyVQcHfvurNTmLkRlLLGk38ITYSQN03aRU86JvBorHmbQevhIMqXC/UAg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Yhd/I5Ns; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Yhd/I5Ns;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmPKS6rp8z30Vs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:25:16 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSoaz6OAvigs7T2BkTdMbPuc+DEBQAyyb0X3FandD8603RVat2ekrz//8gVdNvRFHi38341uRnCcvX/f9kONXQTmIJp5ltzTF9UBIdcS+liI3EkGwvRT3cTm0EhBYgq5vSGMHHeg09viYQzCE9ig/wCmoKbGLZngT9SG3trYzqQtdxJUwfah2ovBXM9w4c99jySHvDYUysIt5iJuYkoglF1d2EjUjWeFX15pqil/rRZ5wSa8rg7YSkCy0qvPRoJ7ny++cq2pt1Wf0HlSce277W+OMj4Hq2P6QhctzkjeEFtyGOY8XXxlmKCnceWTWcQefYoAAINI49MuCri0bCHOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mY2CnvyLiilgStSmY82ck4KyXQ8qtTMMTeQYFTqZmM=;
 b=JLvyoSql+Wyd/i+/xWgauR5GuhZTsaKTZP/j90Y/X6nbS+QzwEVBCruRDQand42xvSSvajZpy4gEa8AVAVCAxLLoYx2vLSc9t7rc8ZfHLga5Ajpgx1gaBGJvPml94jTfWJhXrSJA5wTxaHDgz/TiaszGGqq56QEOFrfzNcjOAxjIxcNMi7BEn1PoRa86GBxH6AyQ+qBprDFd2eMOigCr8YR7IbJHkLTKXIWvrONiUh3br1ntYg1JLz+vAPP07yLr/0f2fEViwMA1c+acO5zwVz471Qfq2sdQGHbNFO99GVQcNFJB/t7FdT6YT0zhQVT7DuVNEFT4xFsDoGlAAw+PIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mY2CnvyLiilgStSmY82ck4KyXQ8qtTMMTeQYFTqZmM=;
 b=Yhd/I5Nsvb2XNp6FHH8rt3Fbwk0bm4d/NK1iQTonB5LW5iQ0u54ZPpbzsjrW/QZsM7Ol0o3dKz4hxdAJpWKuZ8EUJQn8B7OfZJaVnU6jJZMgBN58DhkibJEpl7SE6BKSJGpu1xyl9CCGhlwHlLr1nLxTzRsSdKczosGyDgBa7JOnK0VJSrk/R8Vu/U7hCtaDg6ucKmFAWAFB0ZhZ9iTMHY9XhMzAJd3qs4VNh5JW8lEVFGkIobKnHIjJtho/Tfd/IHp9LL//og91DVElUrBitKxRjiszrP5h6rvxZzKdJlVtWnhzaVrE7X78IbmVvM+8f5U96YDYJJVGCAr8HKmbKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 07:25:08 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 07:25:08 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	linusw@kernel.org,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 4/8] net: dsa: netc: use entry ID instead of pointer to track host flood rule
Date: Fri, 18 Sep 2026 15:28:48 +0800
Message-Id: <20260918072852.501420-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918072852.501420-1-wei.fang@oss.nxp.com>
References: <20260918072852.501420-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0068.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ea6fa6-b383-4ea7-a1fe-08df1555f804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+edlhwB66O6B2ZaAS52Xds4PPuJAeLfHQHe6mNxnWNDwJZQhAXvpHzBoILNhwy1j/o1MAkm26ys+SU+wlU+r4U91p4Oa2VtVMTkXzgXGXbs6B8dzbLZhmvMrud9UZaNtYC1fBi4WAh5s5pg2YjJEIRfCpbO3R9FE1zCjG+5eG3R3ZE9KMNOMk8YqOTkzKph9WP/a/wbuHhKh8qHJLq1MU3PTA4VzXhkEvIBJoBRRULVLRXPwsmxY9JNnDe3C9tIDi/kHi1teVMQERBsCVm5hkNIhyXtTw28eAp8MNxX5691IoBFfCPa3PwzoEixcfWyfb2NRCzshNQDZNMxIYgl9fDJwVbxLnc/jR+gIqW/2/pX2k7RXW4hOtnYbw3dKgb+JZGGdPvhWlMhkxK5jRH3iA316qw4y2k/NgMdCP2o2R/bCOddZB2fhQUsqBZ9imNNjZ62/M/pgXjhWOnPh5q+Qwa472TLYKnx+SZ/vp7YS5Cn/CmN6Q2YuLMnYLsR7+rjGoS5IZe+Kv/0Gd97uuyCSzGJ8FCrm5ecT2h3Js70SezhAafMXDcibkEunPOsCrc/dlKsW+Cvwiw4SnpJ06HooJ4wgRoSKlfcuJkGMCtIvSjbV3XndsT+M9KFWfVhZe2NWd4rwC3tIYCqS9bp/gFT7a3jGBm/dl9NGVU1xYISHLK3dZZZEHvtoJqRQJYc83NCVnz+04cPYSu95GX/PiFvAzw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WTg82Oh+vw8draFFEWLBF0y+1NAIa2k2bVyTwi7j/wCRTIT6uOVPqhxr2VKN?=
 =?us-ascii?Q?eErPodKYT7IR2DXfn+cvlPn8qS+SzYHg084Gg53QSl9TSqWVbLTBYm2Rb6o5?=
 =?us-ascii?Q?4r6qzODR6Yus2Awd4OF//4ylCfQeIsDcRQ1FWxkSDBAe/j0R6KaGW/dpG6r4?=
 =?us-ascii?Q?Ejj7fDHJgs8o8XGqIwHDEayo1ZuRpngHJpCYM80ZtfMsRcvZuos2qEoHidH+?=
 =?us-ascii?Q?Fy3NBKx2aS0rq4Jt1gMiTGUjGGeHSp8nRGJU9mMbOz83TyMhatBTsHWUbyvz?=
 =?us-ascii?Q?iEUM1dirbhA1GWrCdyMSCNsSFJhYhulrf6YZH14tGzJJprO70GSNzRuto0Os?=
 =?us-ascii?Q?/RuzVyxSSgy/trRXcikfYehLVz3TO2VDZIMyTHMTreT42bFrrCgqtkr5Tqgd?=
 =?us-ascii?Q?8MW9QHqSAk+Nm2+P3tfcvzSLCboZI7PrdRgXMTQnatOHlOLXULf9zDbjRCsn?=
 =?us-ascii?Q?7ZVtq+vJwwryY+Knko8tojvWtYjRiyMF2dsFMLwLKlcrSJO7tyhCtOJUZnIT?=
 =?us-ascii?Q?YPQszy6g4xAEjq4yjB45NO0s/IRkDKvt2Lcu09WZmMZKgQciJk9ssgVIWgd8?=
 =?us-ascii?Q?0hM0sN6p/mGRxKFpggn7EBqhm++Byfpt4DbviiaHaJvWwaGlX/BPO8Roi8AF?=
 =?us-ascii?Q?hqpDRZB4vD7LEhN5LHabkVkDbpTvgaqNK8u6nHY+9KnA6LEpVwP+77JMLict?=
 =?us-ascii?Q?bSPJwmdR+L53iJ9HRlL0djj73r02HPkTUIq9eAa3802nohjbritcHNRSuaFg?=
 =?us-ascii?Q?HGA9h2nuOWuWxBfLIU3vwirkS5CbNvxfOHfWNHVQT4fO2NAzzpQbOVVWDl7p?=
 =?us-ascii?Q?iJqs0tj/4MQpJLCX1LhtdXYDq/PTNrk6Hc/flYc4wmYJM2xXD+BBCWPAjfoa?=
 =?us-ascii?Q?3i8Z8ame6sZf6tX+N2m1uZ1dAnoMrtkGe51AesjAUqT14FgF5jW3UAMrdtXt?=
 =?us-ascii?Q?DHjr91GM0r2bczmRcZROfceM957XDHzSHM3YyfctDJIUspnLoTTadiirOUJM?=
 =?us-ascii?Q?spLfZVmOLGzRZB6rcHYxkgkddSbrvwJAFClYkC6u6F+4DpuyyaYJhIyFO8Hr?=
 =?us-ascii?Q?uLevZnRNv9UsmJZefOVG6D42/DmIzNEBd3ZjaiYX5xHWoh4tJccHzmuSume7?=
 =?us-ascii?Q?fT/7FKajZem+6+rlU0ivUCsOSa+BavtCFRX2NMSqQZtUTnA8yiX9HVwwrlcg?=
 =?us-ascii?Q?ei/hQQsPZSlXqAOf36/IQ0++hgFo6A1qosBXDDzm+pjyiTq36Aq+XBE2QjSE?=
 =?us-ascii?Q?+pSQa2mHMUpliRWjB3C2lRwZ4SAseZNGHDFWFW+4yhuCFX3zxuSND2uzj8Fv?=
 =?us-ascii?Q?P+3p+BVma1mQMOLtndIx3mGRLxbHDzel8rQ+21DIui2BQh3bOEtkI0BQQyQo?=
 =?us-ascii?Q?xxdbBveqDeSbUW7bg9WRLKsDpo9d59LqizUfOxMY3eCYvz7uhGfz/sSDU3RW?=
 =?us-ascii?Q?5taWyNDzcQIJMAn/qrnho6K1XSfp7nOGxe55vdQCUnJ6Uo7pFaDCQs9s3fKh?=
 =?us-ascii?Q?B9HZvnKqS1rtVr787o169L1P1ebYAfNwSOS7VfDCjvMO6UU1BOcgVB8dsZ+c?=
 =?us-ascii?Q?TT/OU7nY/arJBczHi9oMvVSv1XDZWL5nsje31mFg8aXWYRAd6whzFq7+4qJN?=
 =?us-ascii?Q?ERXVrkUge4lLRifNmk6kOi1cnimWC3jjMMX5N6u3bhkC/AGbrf/Rmp5AL56D?=
 =?us-ascii?Q?VgqvqRj6fhpy4oQvGUY0YhyZ4BdPYYEvoZmt3sVQ0593NkF8nUkCRjC+zIwD?=
 =?us-ascii?Q?1ATk24MfHTikRzZEv0lOkUgk7R43bcuPMQJbapEq/UfyS1UorDIg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ea6fa6-b383-4ea7-a1fe-08df1555f804
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:25:08.8506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGhEaT8BgE3BEElEJH8zGj/sN/w1igqapfiLGPfVwfiP9xbAxGLE90tN54yMH7zE3+XyMzZH1VpiGWZYIclw/rq3fH6lUXOrEBEd13w2g45RmyC3GqbUbEaAAJitkQI7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541

From: Wei Fang <wei.fang@nxp.com>

Replace the struct ipft_entry_data pointer in struct netc_port with a
plain u32 entry ID (ipft_hf_eid), using NTMP_NULL_ENTRY_ID as the
sentinel value. The ipft_entry_data allocation is now freed immediately
inside netc_port_add_host_flood_rule() after the hardware entry is
committed, so no heap memory survives beyond that function. As a result,
netc_free_host_flood_rules() is no longer needed and can be removed.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 62 +++++++++++-------------------
 drivers/net/dsa/netc/netc_switch.h |  2 +-
 2 files changed, 24 insertions(+), 40 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 77077352c1a5..c590931a4e1b 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -266,6 +266,11 @@ static int netc_init_all_ports(struct netc_switch *priv)
 
 		np->switch_priv = priv;
 		np->iobase = priv->regs.port + PORT_IOBASE(i);
+		/* The ipft_hf_eid is initialized to an invalid entry
+		 * ID because the host flood rule (IPFT entry) has not
+		 * been created.
+		 */
+		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
 		netc_port_get_capability(np);
 		priv->ports[i] = np;
 	}
@@ -938,30 +943,12 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
 	mutex_destroy(&priv->vft_lock);
 }
 
-static void netc_free_host_flood_rules(struct netc_switch *priv)
-{
-	struct dsa_port *dp;
-
-	dsa_switch_for_each_user_port(dp, priv->ds) {
-		struct netc_port *np = priv->ports[dp->index];
-
-		/* No need to clear the hardware IPFT entry. Because PCIe
-		 * FLR will be performed when the switch is re-registered,
-		 * it will reset hardware state. So only need to free the
-		 * memory to avoid memory leak.
-		 */
-		kfree(np->host_flood);
-		np->host_flood = NULL;
-	}
-}
-
 static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
 
 	disable_delayed_work_sync(&priv->fdbt_ageing_work);
 	netc_destroy_all_lists(priv);
-	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
 }
 
@@ -1759,37 +1746,36 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	cfge->cfg = cpu_to_le32(cfg);
 
 	err = ntmp_ipft_add_entry(&priv->ntmp, host_flood);
-	if (err) {
-		kfree(host_flood);
-		return err;
-	}
+	if (err)
+		goto free_host_flood;
 
 	np->uc = uc;
 	np->mc = mc;
-	np->host_flood = host_flood;
+	np->ipft_hf_eid = host_flood->entry_id;
 	/* Enable ingress port filter table lookup */
 	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
 
-	return 0;
+free_host_flood:
+	kfree(host_flood);
+
+	return err;
 }
 
-static void netc_port_remove_host_flood(struct netc_port *np,
-					struct ipft_entry_data *host_flood)
+static void netc_port_remove_host_flood(struct netc_port *np, u32 entry_id)
 {
 	struct netc_switch *priv = np->switch_priv;
 	bool disable_host_flood = false;
 
-	if (!host_flood)
+	if (entry_id == NTMP_NULL_ENTRY_ID)
 		return;
 
-	if (np->host_flood == host_flood)
+	if (np->ipft_hf_eid == entry_id)
 		disable_host_flood = true;
 
-	ntmp_ipft_delete_entry(&priv->ntmp, host_flood->entry_id);
-	kfree(host_flood);
+	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
 
 	if (disable_host_flood) {
-		np->host_flood = NULL;
+		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
 		np->uc = false;
 		np->mc = false;
 		netc_port_wr(np, NETC_PIPFCR, 0);
@@ -1800,7 +1786,7 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 				     bool uc, bool mc)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
-	struct ipft_entry_data *old_host_flood;
+	u32 old_entry_id;
 
 	/* Do not add host flood rule to ingress port filter table when
 	 * the port has joined a bridge. Otherwise, the ingress frames
@@ -1808,7 +1794,7 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	 * will be redirected directly to the CPU port.
 	 */
 	if (dsa_port_bridge_dev_get(np->dp)) {
-		netc_port_remove_host_flood(np, np->host_flood);
+		netc_port_remove_host_flood(np, np->ipft_hf_eid);
 
 		return;
 	}
@@ -1818,20 +1804,18 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 
 	/* IPFT does not support in-place updates to the KEYE element,
 	 * we need to add a new entry and then delete the old one. So
-	 * save the old entry first.
+	 * save the old entry ID first.
 	 */
-	old_host_flood = np->host_flood;
-	np->host_flood = NULL;
+	old_entry_id = np->ipft_hf_eid;
 
 	if (netc_port_add_host_flood_rule(np, uc, mc)) {
-		np->host_flood = old_host_flood;
 		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
 			port);
 		return;
 	}
 
 	/* Remove the old host flood entry */
-	netc_port_remove_host_flood(np, old_host_flood);
+	netc_port_remove_host_flood(np, old_entry_id);
 }
 
 static int netc_single_vlan_aware_bridge(struct dsa_switch *ds,
@@ -2020,7 +2004,7 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, vlan_unaware_pvid);
 
 out:
-	netc_port_remove_host_flood(np, np->host_flood);
+	netc_port_remove_host_flood(np, np->ipft_hf_eid);
 
 	if (atomic_inc_return(&priv->br_cnt) == 1)
 		schedule_delayed_work(&priv->fdbt_ageing_work,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 305f2a92e2f9..aeb08e6eda09 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -84,7 +84,7 @@ struct netc_port {
 	u16 uc:1;
 	u16 mc:1;
 	u16 pvid;
-	struct ipft_entry_data *host_flood;
+	u32 ipft_hf_eid; /* Must be initialized to NTMP_NULL_ENTRY_ID */
 };
 
 struct netc_switch_regs {
-- 
2.34.1


