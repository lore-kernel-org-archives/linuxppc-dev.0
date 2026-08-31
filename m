Return-Path: <linuxppc-dev+bounces-26258-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ABBC61DE2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:20:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMP4342Cz2yqf;
	Mon, 31 Aug 2026 18:20:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788164408;
	cv=pass; b=Ww/7/GJX4ZU7tSfnLLWNnU3PEblwKzJH3ytXZM/s82c5sPHIPMZwWTpk2AbfWzQASi7pFxPbxQvXhzdHZqkKNBVimBiQ9PR91D+FoWN+jvHIvFgbIov1AUH3urCzshDNPVSpt4CkZzDfafbBO6VHgekCbT/NBJs9P0tG/gmxOoVSvuIwdmA89V12JN82B0kcRXUpyb4G/fMDzrHoPN5cIt+NmYsSZFtHjEMH1xRNIPZ/YxyKOPBYMRIMnu4k9v31o/26eQPmsAHU9eX6c3Bds9jfK6tpNivpqkiQ+f+B8VVMYgZ50SDrRM98YqLXv1/NJ87thQeKiy1y3ips5foIgw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788164408; c=relaxed/relaxed;
	bh=6O+wswqrHcHRFnLAbs5sUdISK1XWYXYWnLyuqneGK0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GZ1IcLV710tC0hjEKVd4u920JDg6K6WZ4Rte0aC+Bmtq4b4/IH6ZpGrHMvElGJNt3q4jZl3kkiZRxxjBV+UArbEFWzbgfaVpeBR8XQynXV4kmASnrhJ6QTSACFHCB39AWLnfhZby3Pl1aBXi0n4WVrQZgJWwXf42OKdZPt/2Ds+jkdIsRltsroA5dJbNTKIHDO7lg9x+Tcq6wfMV+4ZR7A3tzXI1oyaHB+w17LoTyqkVW0KCz4IqGoejIlQCPvsieqK9zEtD998pg2MD4Ln42JyjQ9v8Z7RC2LVp8KYfF/ihml1Bm46KABnzKKuWyliRx0fojHzPoiRb8MMCHyFLzQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sh4OdM4w; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sh4OdM4w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMP32qbFz2yrX
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:20:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qe28MlAbAdcT4TII0+g11K1q5BTKNtJ5Y9t70n6bYIfl3uZs8GPyy/TCQMATib8rWfsGsd+kJG6SbxahGZRHAXZVE+o6JT+aSEG7kIn0PkTwYpbiHl8txtIBLnB4cTFnVuAqT8mEq6jL9nWS4zej6IGjpTWbwJI8o4eJZn3j+WZRtffGbj7N6zMpbXhaOVUCjksGkKTH0rSGgML0g7FbW7LLJ5Qzc3vmwkHoPy6UbwBj6NjsQ6AylrM8HncDbEOGPwiE/cUjUFVOZQT5yOcF4GXQ5RlnJik+Jpi+GiBeHJF5xw7Gwds23F4y+z0MAG0c97ng2WpZCZri3arIhE/5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6O+wswqrHcHRFnLAbs5sUdISK1XWYXYWnLyuqneGK0Y=;
 b=mDpFUaJXesETWUChT0f74AewxU0C+LvrNqMIMJj8thrP6Gs7VfkqH4950ZllVO1n68EmD9Qw7w9n1Ubl1Aa7NpTiOliCkmXvGiMj81SnoOUyi+xl7sXDwP+EujwV3SIuAP+2gNHr8G8BjGZaLPDhS2ufGfxcWijkX2HJXXekRr1VXHwioLMPCh+pCpkt0YMwRYDXEXFvJ7rNtDafncGNrQcOPoSa24LEI6slSG6ahAowRcoLT0HlRd7uN32oUg3E4MDszWy6i72PX0s1op/h3MJMguYZYTSbCfN7ro7kY+ae016cqBlUL4kw/VP5taNJLZDoNTNAW6nZOaLspzAfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6O+wswqrHcHRFnLAbs5sUdISK1XWYXYWnLyuqneGK0Y=;
 b=sh4OdM4whjJ617hTcErV3bQylDiO3EgYEEzPFqWIw54SyecnobxNRxH7iostzX2h7SQ3paCSFAyVRuTuRN5anGPMnff0XJz6hSFxVjHGp8KyIrbb4C0q3dWPPLhC+35gxrk7BaMR+4TJagdCblrt8Qvh7BY52bdJzTBcFrUrPIZ0Drsb8v8LZzm6QGTx6ouFi/fskJWBUu0d+dKwNS83KtfKNkRpwWb0dZEG3nvGZbnLgcGfLK2TausJVTu6xPtSV6CGnJjfRDjAWyUdvF+kyj9YDMZRz8HYJxRScRutkIf9+CM6Qo4JYdmOtODVKq4ELCLkPWjtVSMWax7KImf0TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM9PR04MB8440.eurprd04.prod.outlook.com (2603:10a6:20b:3df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:19:55 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:19:55 +0000
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
	richardcochran@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 4/8] net: dsa: netc: use entry ID instead of pointer to track host flood rule
Date: Mon, 31 Aug 2026 16:23:31 +0800
Message-Id: <20260831082335.1184605-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM9PR04MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: a461e979-d848-4824-1863-08df0738a381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|19092799006|366016|23010399003|376014|18002099003|22082099003|11063799006|6133799003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	yZsUIgmu1AluXsbiacC9mtaZu9QfnIWKjeVEJMfTEFIxRqoJi83KI+FJem2f1WYySab3mGOP5/HkGtDNhGK0dkuD/Hf6BNuQScytVypxZOSw97R1Wk+jCCiQAnwzTezM3e6mdStg7M1lSgWC3XiSGoPiW/HoBjDXBiejVpt1SP999u8H68f+znUTspMcK7hchd89wmgG4XsDWlNeAujyBQjIM1NOxgW2MQ0q1s0zlDjn34rmZkovsQP1LaNqZARJQ97QV5puZCYLJo2XWSTdQcdpHx9n26KorHh0Cq9VwhvFngLv+lWl4oPsHnStIYQ3/O5TWxbRTZXaFtE/0plXzAVINg+hQ5a7b7OMVKV5AZUSnBbaSJwhCEs9b2OtWUeK8X4AKTQLQMjUk5mX+uh+gluwU6zm0bxl1u8KS09oANZ+6KumE+CXmiVjPLn623RAWNauT2tjKU4PeOIJiAEkjeCwSEDlu5PWrfmZsdhGcQXOWMvhUtu+t9POFdO2uls/hk5C0loNjBxNMscIx041ISVD2eI2urmT7y/Lk6HoZE4uAT3ibCerm9NAknTdJWKMkXskDE8pqogL08OW96EeXHgLoh00tV9hd2K8HCaA9eqmo6rS8Lhw8WNeQTQyZYLUVoDrH+tyM+GBfC+emEqWrrI2klVsVBRkxfVXqIqD9vwVhpBPrmD67YCeyvMpfDmHd6jLukbY19C6uytAxmTRWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(19092799006)(366016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cZAEahdlPcQO7rtSRg2ypspigT55YTNViGNh7fyIMCC8yW+pn5QfclYSJu3f?=
 =?us-ascii?Q?sI3lGZA93t3bRMo4zXMVH60edIcuYENh0GlvuKCv2knWEFZZcE4CdE6dfCZ/?=
 =?us-ascii?Q?pzbaPoi00jyK6noVUR46QajziGft1mqKFNk9+bBVbTJ3oef0/YC/QiV9L/IK?=
 =?us-ascii?Q?U1lbpCrfPaTgo28m/U3tjuyTT+OsQ39qTdIWq5oWQG6Y32y2p/uRMnBZIdsM?=
 =?us-ascii?Q?7r2TPM62N5MHtjTqiLy1gkZwDMKyVLFEETxFxW6/0MhsBPZlafsVTyiRcymu?=
 =?us-ascii?Q?inTk2uXHtq44pT7IFapc89qoi9ccrm+sdi1HscG+kpgFX1RemMafJVsnJXxF?=
 =?us-ascii?Q?XWv4w7+lJ6ea2CD8/W+JWPfqctE9pxY6jfRuH64ueUthkTw9YBo7RhhO3KmJ?=
 =?us-ascii?Q?1FkZ21b1ickO13U/nGcLv4pkB6DCjjwmxhOEqpKjZQJ/qjd1mDDj4Rg9BIVE?=
 =?us-ascii?Q?82vHe1C7TqNqYNlSkalI41WVWJ+nlJsxlbtPecTtaB9ArvCyEIyZMq5JryvT?=
 =?us-ascii?Q?2PVocvk0BiESdvy/1LNm3smSdSuaQLKXhnBjKFkO+zLabuoI/RsU4AmJSIbM?=
 =?us-ascii?Q?ejWJdD3FtKCjYqbzCXu3vlr2B5aaU4xvqGbHD1vOywdMDu1DVbwjrKdxrzQX?=
 =?us-ascii?Q?Unr5xwprH3uAlxjg1l1kb2kYd1JnDsYGLpqyj6VOVtQOvueadRKrYAdyd/Me?=
 =?us-ascii?Q?O0bkKDc4LcCNzpp90zLzsraKWagIdXvvgTNaVXT5YWkP4QX/0oENmGTfxp2E?=
 =?us-ascii?Q?SAgCdosk1Hd3Nz58B3k8CaVht8XJlqXefmg4OZRBk9fg5qhXz/NIVTJVDyAt?=
 =?us-ascii?Q?ek9uuFMB1SGLzsDSnC6uZKAXiI6LCWOjUtPJLLwN/KBFmL5B8vTLX8HJnrpc?=
 =?us-ascii?Q?sxRo7Uu5qquQIhbEKapfZynfQgYZvHAsqr3j/osBAOFRVpcx/dXPt+Q1q/gC?=
 =?us-ascii?Q?NsuEs8YRN/v0CfaLrpH5MqOIko6JEI+jhEUI7wZbR/kgR2rLgPPGDkG8ahjE?=
 =?us-ascii?Q?F6VxxKjYxZ6JWYbyN1BDVWk00uDIHcDUUdIPaYuSS/mNiHTPdrqvTA8DtGUR?=
 =?us-ascii?Q?6DhqOFQPpqE8WJ2vG6AYWdqNPR8SjB4w7s6HbVAefdIbICD0tFUIiY0MT3Qp?=
 =?us-ascii?Q?Gd9SF4wnfoWNnTycWTEfeUcGkCFtbKyfHHX//ADblRufNiaeCwzDOzsmTN7L?=
 =?us-ascii?Q?LXgvMbDDFLgOSh/GRKHIvC1Uo52YCll3uAWPBxu6dMTggUYCK6iUyQV7iJqK?=
 =?us-ascii?Q?yxD65st2bwc3F/TjCnfLfWXjqI12cIl6PPDB2QTs/N3u3zgr35ohVFeBVTPs?=
 =?us-ascii?Q?nyeU2j5fATPjQPj/vNd8eZQjdMtz/zo97A1efzse11JkAwTkycXHYJeoQi4B?=
 =?us-ascii?Q?VFcSjwq/WEiQRf+wImfMLDBSghuBAU43XD5lZAkWZynX/ep9yVzZ3dqUyT1i?=
 =?us-ascii?Q?oWO8M/7SkWceJic/fUuu1R+L69V5MlqstQ0G2UlJlOPnJtz58bZizpQHcMsy?=
 =?us-ascii?Q?ARCt1F0AjsMo/3VML0/0e2Ur3PVeiSk+k3w1lH8fYB9ren+paVOm/FDsPS8P?=
 =?us-ascii?Q?i4DtnslY5SXYOQzGZGrmvosXnv8fIq1vmaGwUuuQ8TF/j9SiX/dSj8zF7ZXU?=
 =?us-ascii?Q?CJoZKxtlBJ3WIlTlLAhVCNkQBpyRHJCvIjPRETPSNF9PkfPluNk+DJ19AXnH?=
 =?us-ascii?Q?zOvP2fAh74lJHwVyMY0iwQVFWy8ekxWZtzfKJojAxLXZklsUr+HbUjwMYhUk?=
 =?us-ascii?Q?iWuRp5YnPsaCKl1v2moxwxWO3+Hb5537Vbxh/Aqx9g5WmdYlHAH2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a461e979-d848-4824-1863-08df0738a381
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:19:55.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOWxxCQeCJTk/Fo14pLTFx/tZNq8MmWA8lqszx+PKA6ZsT+s7A+YxygzC/vjmEvIw8jjZ6peyLZrT7xnJGwamEj5JsHNBp+jjN0RYwon8Ohc4LFsB/ztV4Kg7XVAt0hY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8440

From: Wei Fang <wei.fang@nxp.com>

Replace the struct ipft_entry_data pointer in struct netc_port with a
plain u32 entry ID (ipft_hf_eid), using NTMP_NULL_ENTRY_ID as the
sentinel value. The ipft_entry_data allocation is now freed immediately
inside netc_port_add_host_flood_rule() after the hardware entry is
committed, so no heap memory survives beyond that function. As a result,
netc_free_host_flood_rules() is no longer needed and can be removed.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 63 ++++++++++++------------------
 drivers/net/dsa/netc/netc_switch.h |  6 ++-
 2 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 77077352c1a5..d326a00104e1 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -286,6 +286,12 @@ static int netc_init_all_ports(struct netc_switch *priv)
 				dev_err(dev, "Failed to create MDIO bus\n");
 				return err;
 			}
+
+			/* The ipft_hf_eid is initialized to an invalid entry
+			 * ID because the host flood rule (IPFT entry) has not
+			 * been created.
+			 */
+			np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
 		}
 	}
 
@@ -938,30 +944,12 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
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
 
@@ -1759,37 +1747,36 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
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
@@ -1800,7 +1787,7 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 				     bool uc, bool mc)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
-	struct ipft_entry_data *old_host_flood;
+	u32 old_entry_id;
 
 	/* Do not add host flood rule to ingress port filter table when
 	 * the port has joined a bridge. Otherwise, the ingress frames
@@ -1808,7 +1795,7 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	 * will be redirected directly to the CPU port.
 	 */
 	if (dsa_port_bridge_dev_get(np->dp)) {
-		netc_port_remove_host_flood(np, np->host_flood);
+		netc_port_remove_host_flood(np, np->ipft_hf_eid);
 
 		return;
 	}
@@ -1818,20 +1805,18 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 
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
@@ -2020,7 +2005,7 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, vlan_unaware_pvid);
 
 out:
-	netc_port_remove_host_flood(np, np->host_flood);
+	netc_port_remove_host_flood(np, np->ipft_hf_eid);
 
 	if (atomic_inc_return(&priv->br_cnt) == 1)
 		schedule_delayed_work(&priv->fdbt_ageing_work,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 305f2a92e2f9..020e3661b866 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -84,7 +84,11 @@ struct netc_port {
 	u16 uc:1;
 	u16 mc:1;
 	u16 pvid;
-	struct ipft_entry_data *host_flood;
+	/* ipft_hf_eid applies only to user ports and should be initialized
+	 * to NTMP_NULL_ENTRY_ID. Other ports (such as CPU ports) do not
+	 * require initialization.
+	 */
+	u32 ipft_hf_eid;
 };
 
 struct netc_switch_regs {
-- 
2.34.1


