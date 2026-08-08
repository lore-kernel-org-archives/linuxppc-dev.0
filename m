Return-Path: <linuxppc-dev+bounces-25629-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D95C5AC82
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 03:19:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH5ny2B1Sz2yvD;
	Sat, 08 Aug 2026 13:18:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786159126;
	cv=pass; b=SYhhbZA2VcyM2RWw0rsygxVFQRuXw72rkCU1mgGjhifXY3jC/LSEivqGn2dKF/n0T/N7QZq+u6iQRqtDz4Bj5Ltc5yC/qAuko3NQibYZE0PpKnT9fkDhYDjI3FV/JGphodpr1gkdjl82MEkcbzq771NiKnp+vRNwlQlD3HUw2MjF5p4iIgb/3CRUKDGLDRLRVcGyMwis9L/i5nexRHkVXivHY7/x+aoio0FFYvKv9r+Pdb0weQYIlOQSYtR63z36rn+qV/CrZk9zIkPLLkjypGGw7gHYvi1MAxMekoi0mb7T514++z/0v2XxjpALQLNw546vQt5m42xldO0tV6PR2Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786159126; c=relaxed/relaxed;
	bh=qzTEWsz6mTiJEpDFM7RYmrYxGYIR+itE5YjSuQo2gBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jc9mdQxpR/nsfJE5VWU7PThSqshwCnlLdCKETwnRZB76cMvbns0mt4SVKt0Ql1EXI+gU9mI04oVxwXQk7w8UYUzy0eJEFWqiEEnRVWZTe7tBjNmFT4XfMOsGEtGMtMIK90+e44vPJ9cqJhWeoFRH9ClP5Lpueflmrheys22kPpmrzrDVwl3r0octdfp+rGXe9TEuDnEpBCYPa8qZrwlDX1Kc0I6KZMuKWaLnzGQkUySCrnNGxyJekx6LM4dhS/oYCjEynfmmwujLUvkjUPYLIarwzBd7+eX99xOa/GqweNUC9UJRfSQ6qTx4FQD1WpJy7Y1gqSY8oOszeFPV4bJtcA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OpIYC6Qt; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OpIYC6Qt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH5nx3k4qz2ytv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 13:18:45 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFkcMIvy43gwthfX05tX35eLO2Ce185D1JEJPxnJUy94cBs1WZzgPSMfmOstChAVEpUDHGq9PglbvtCX+a0STWypOy0Rj20tUZnHHazOjK5Ll53clViFXh7tS5DwpN3I4hPdIGbXp3AIsCKy6G31OBXl+WV2kTtSJFunCh3MdgnV5D9wTr9P8Rz6CcTmiaXGW9xFNI8AQEKanQhuXmuLBlMvOkwF+6XDqYPg/avEXfXriYsPAJFuJfCmkIvZ9m2DwhcS+B/a7mV3Tfhn52cR2VqNGij2xIFYLtwolfCM6QXq/QMKu20YldYeAPM+LRFllDhpT6o9MTRFlaOnsuR22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzTEWsz6mTiJEpDFM7RYmrYxGYIR+itE5YjSuQo2gBE=;
 b=YJxmGorme8EbleUWtIGLs0jILiEdXol2j26AyZ8gmMarS56CBH+7AJ6m4655c1iXEZg8OdFbAcyS6fegWSkSVeqKTApRyI0Jnap/L+KBGuhiFY8+FrNyOn921pDliQGkm8IEYn6Za6H93LaTr0QPHPRMiJ78+nXSqwj0kzS2JQpOCh20uVQjv2Ej3x8wClqHAsJthzsMfeYpgmdLC769j+vGa4/9qFUyVu3UJByxnsWyx5+OhFF7J/YFKsLfoHssEBz5l7wmVhu16p4OyNYci61q5r8JwdgacQQzVmmOFHMFgUbMFsEX/cEecpUlO1oQr97aILOe2Fz/45muJOHhKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzTEWsz6mTiJEpDFM7RYmrYxGYIR+itE5YjSuQo2gBE=;
 b=OpIYC6QtRcGPdPyHml6J9mig7nuzAphJZGnvAn8oq94Cgk5Y5XwNsgbbAFD/j/ya+ikDJt0wNF7y3Cy/Lh7DEEHlWKy5mlUIJ762AlGE45dWxIwNa532rJzdLQTkyxm9ie2GkucusGROyVQ2nbjHVLTzI25OGltwbDQxwz8MkTBtsCtLlWW9+a0VR4t1oSa0txXVeIurnyjUMaJUX/4ehxapQm7rihBgsaFmddFDshVni7iqiV4pRQW3TQiJpSOjT0TfMXhEqAkgf+RtDgVdEhBnJmlpnOwSVf5tLFnFYE1GfuNDxgzF2M0sjSiJuBL87DSDtzU+Ot3t+tS2rahufg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Sat, 8 Aug
 2026 03:18:38 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0292.022; Sat, 8 Aug 2026
 03:18:38 +0000
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
Subject: [PATCH v2 net-next 4/7] net: dsa: netc: use entry ID instead of pointer to track host flood rule
Date: Sat,  8 Aug 2026 11:21:43 +0800
Message-Id: <20260808032146.2335723-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
References: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU2PR04MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 37565c6a-2dad-4186-93c1-08def4fbbd46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|19092799006|18002099003|22082099003|56012099006|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	NIpMv9RFxb5KHfRCeDRj6j1iW4gorB/CxZGZBb9+fmmYEz87knEi8qF9xttH9mbiKpuj14qqy+Ypaak3fOeJvy5ja0AZzjLx0AwiJT846RXoNMapl/NXhaTqopkItWdjFZITFa/mtz+FLKriQBUVbFROGjy5qwayEoLOqTE2c7AcC6wvoYz3VbdbXX47HdEdJcBZVfcDVz0kFWInkCUcpgVEyq2On3eVvMObxDUGI0XhX73VPsrjdNz+E65B6ry4DeqDkNY15DlvJLOEOvhqAPRwMyLSXf7QqknB+9e/ShbQhAnLS7ZJY5RC3KSNZmE7D7fHHNCt100HyZWzSaA+h8jMJyfHiAD+xcYBDwxJ9r/vVln8Utmj55e80mD8pdX8ysbEZFI1JO5UffxcHV5PMhFPq3sak+dzPrA5hVGqDqQnHnHXiG8yiq9jX/YvrrVlpv5A1wxrBAe/tSSL5guU0j/iC/l/FeWpZ6RJOONAsiHco/MDhsbeivN+Ijqw1MTRwxJuG1+EAY8FfEb9adSTL3znUYQH1lA0FFJiw7nSedKyzcm5HpTZQN1FMjNty5Lz6uSCkFnGu1iogVjLjvDwv5mVZB6l0y2ISxy/FYXTnHoiYyyIAQ4qvSYCrHvAOpj6xsyacyh2sBOSAXJ7iLxPQp5fUdF2AH61VUaN50u8Ua41vpA5zqhh0tQTtQDoq56I+c0vLTEa+6JlT1W4V2gXNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?328wpk4h04NjNf0OvYbAfxVwzIC52Fm0Vgknvf9CfXY5OSR/HVAVcXoXWKIn?=
 =?us-ascii?Q?wB6rN+KuHMjqMPOkflCXIRg+rmBUqBZ8YBMHS5BEO9950B5t9hFA1dfys0l2?=
 =?us-ascii?Q?RtC3JzkaiJJ1If5glr99oQP6BFWjN5MD9xVGhdQZieZZTq/muZy/YYH2jGj1?=
 =?us-ascii?Q?/Dx/l+lTe5+sm0hO8GaHozyUPlGD6tnhDdnH/PM38GRZRKUg0pgassDKqsBt?=
 =?us-ascii?Q?fX7ZZ/vLjfhJYm+oIHEBgrr7WfHUvVeZHrZ3jGMJphzMvDwPLVVbEOq0yOPM?=
 =?us-ascii?Q?DZf9j57TdZikmWYsQ64iBtKq9BM+jlbmkCd5kqwnKlpscLO4MNfhph0VY2gh?=
 =?us-ascii?Q?haFDaFTU4tza4UoDKp1cgIwwAVuFwGww69ZWv5X7Jx5OWnbWylrl4tiPTSYn?=
 =?us-ascii?Q?9cAUabZgoeH13icU/0NAcd64F0B6mi6d2+OTYiscdWmlbJFECZrpR+lAO6p5?=
 =?us-ascii?Q?y39pvetTgANqVsd+x/QaVsAAsaxBy2+yVFqIDLM7B2WRF4Za0o5UhwdU7xBM?=
 =?us-ascii?Q?K6yi8VcHdxD0xrBkC9FnY5ocUbx2VIjQ+4LXov9mZ5vJ6u7bRs8SNbAr66jc?=
 =?us-ascii?Q?Rcc6fIpJfdjzRRruC1KQbro2FL5NhTlke7aj9YkqA9pAohB2EiEQ2jxte1NX?=
 =?us-ascii?Q?RM4P9tA0ZxC/QhS0Xaera8M+Ejhbnpj2nvQWC8OytiGwXspxEHgyJr+eLWa6?=
 =?us-ascii?Q?7N5Y7jjcv/U3Fsvqz65t0nwVlZd6U7Mddtkdik3q9uRyt14bOweyk7z3uzli?=
 =?us-ascii?Q?gQs4Z+sYXrz6sPRu3kh85C9CQf0tLp0xxYNswENy6Acqq9k2Pke7EdPCag1P?=
 =?us-ascii?Q?2APziQz4su+AY6hNVJy1sQ0SnXeMsW9v5yeEdim0emvgEV4icOqE9Ulh/shD?=
 =?us-ascii?Q?ofeFezMOXZfzn6/1EY8esYxWx4h9xqjk5YxpqK6Vu2LZ5hZFy3RLTnge5n/A?=
 =?us-ascii?Q?6HFLjFETOzDh2knqtZ8suy04UorQKQFc0wIU7wajiMWtn7cW1OSoKtg/wMmx?=
 =?us-ascii?Q?VZexinznHE5xE0QP1P+iXVIHGB8yx9/M5JW1rhT92k+s7HnxzPtjuQwZd7Y/?=
 =?us-ascii?Q?gEaC3JCZrXglmRHOf5yS22ShRCHlX2pxG2ROes219696XEaZGmPSbPz4wMUp?=
 =?us-ascii?Q?8LnL99+/ehQRU8IfYjN/rrn6aqz4t/KqZhSZhXNSwetLshuTM/l4OVYKqUf3?=
 =?us-ascii?Q?K5hTBP8kSPSRRLbDD6w2sRGhXRhIZGjNLTkirYaYVdHFBaA+zXCpx4msUE1W?=
 =?us-ascii?Q?FIarXj6sjnPbtYcGquR6B81ej0U7PTpbTsh7Iz+fAma34TTnQe4G4hso7dyN?=
 =?us-ascii?Q?Znfp7lSTvSJs6RFx2dxqV/IKF1LqIfX3eO578Pe5l11iGC/6QGzI63webGxF?=
 =?us-ascii?Q?EE0KiPfG+dVf1kJhfK0KUdOY+3FBlrPTbyZJdMLsB0QSlK+5TJRl6OXrTu5m?=
 =?us-ascii?Q?yJQuhGAFuQnk0LRCwrMswbbwQoPmnLMvLw8N+/EP0Y+zpPSQAi+nygU81y7y?=
 =?us-ascii?Q?onU5q7F7vbNIBMgI83Ge66SgmlkKWB5lsOo2KGwlJcauBNqXssuyYWmIrUdm?=
 =?us-ascii?Q?/U87DA2qhoZnvc39uxML0/CuCEoXDkkKt1Zq26w9kn5YjsHI0WM5v5AtQSSe?=
 =?us-ascii?Q?GIsVKzCHFGCSdvXr/s0jYV2IvuIL+g9Tr4L7H6yEOrAWfqBRJh5aAl5hFfGX?=
 =?us-ascii?Q?osNltRIGlydDkQz/tZjL3Bvc+vYswI2h1v4WS61QAq2mS9vcP3O9MsMvrT50?=
 =?us-ascii?Q?iL43SXG2oidi+2EOxcPTLqVyD7KMmMlPBeJEAaSF8bBnKdXU+BWp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37565c6a-2dad-4186-93c1-08def4fbbd46
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 03:18:38.5337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKzlOyZxdvKBgNH07ZGH/tuHL5DAovhUyk3GhZ13Jv1Gbx8fRUlHdG+NNAx4HGkOQlijegKJSS7ovW4SeGnNNTzkjgFX3qwgxHcjPHpvvv6ivs4uY7uTQ+CFtyAVF+fH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936

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
 drivers/net/dsa/netc/netc_switch.h |  2 +-
 2 files changed, 25 insertions(+), 40 deletions(-)

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
index 305f2a92e2f9..fd36ec2d0e90 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -84,7 +84,7 @@ struct netc_port {
 	u16 uc:1;
 	u16 mc:1;
 	u16 pvid;
-	struct ipft_entry_data *host_flood;
+	u32 ipft_hf_eid;
 };
 
 struct netc_switch_regs {
-- 
2.34.1


