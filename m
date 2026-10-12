Return-Path: <linuxppc-dev+bounces-29247-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C786CA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 09:55:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3CWw3g8lz3bx1;
	Mon, 12 Oct 2026 20:55:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791798940;
	cv=pass; b=VQAVYbDaFxLViaxuW8X+mT9UsldKfcvBI2ghpu7SAvA3mwGPndk7sXNqz4UMjxj1v1En4EIiZuRW9DM8Ot8cGJCFEAnem84ivvkwPQiQFqD4wDB2jysKp8YGR5vSwyxpgvZogY7X69AK/MkwEmogfWEAOuF2Wd6wL3VLsWARGhTsDNeKC0T+2L6jANpzS3WOqRcupVj6dCFJVbugZM8iz2F3aE9TBIG6g4oh3HvmETEVk1+fn8JWWpnxgh0eohZAy7yyAJcSUhygax0pLZbHE+iKGiGZcRXYeeZ+ULZaVll5nY5tSZDtZLU6WgTs+WSAWMO9O18ewh0GljVt9buTrA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791798940; c=relaxed/relaxed;
	bh=roEMPy6ND5qI8UFPaAhVSOqIIUAEp5r6r0BzYw2trS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A5YBoM0XjSf3WjFdkLT6nVxvoHnwhpS+kIeptqSWq3NoHYGCaZgQTyFJ771N87llW84fIAa0QPHPr+/UFFaH0KR3SCJHEkMczIdRTlU67p873qOIMsd52thcB4ofgWLTDbBz1a1tirdleQ83jP9TYetE2+sU8Y/hNYzAo7wXXmDvRYGgSWm4PHNW0OA2kPqKI5uCXRcwNhPEVoTNJzPKu3ocXnQDPmmvbsJQI9XV92tpODzJ5iGmnQ1Hf+i4RLvuY0RzVoPVAYDYVEeoJzwK9A2V0r0ARvnwmakkw0Fh4tu7Xk5kpzqoqONNvtCaamGUa1W/X3yHfMqDga7UF7J/7w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gIh0ULXz; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gIh0ULXz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3CWv519Fz3c05
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 20:55:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZ4NE7Q2Rp0TYA6yOF2gJtk4ReXe7rNszZqfMi4u2FTuQBkV88M/d+faOSBKaqnYi143eq7VPweiNbap/rta68TUWVmm1Nu/fGO9lLB7t4ig+sufgx86LYXXqZ4Hpj48HCuJwvwzQ8D/rfuw/P5YE05gYzFYk/r+ReOJsM/RqM2DqqdUvG8z6aI+lgX/Wq9hLr/n6LdEd8di+GdL05vd3jRuBlZ9wEJ9GvY4FfXdX53yKCpsjthfScV4bAGTb8Wr4ASWPpuweNoWcFxQ7R5CxEEJYt6ijQXTvOOa0wIvdvth7EJmvPSwp27/oDlFX02jLgMa/PHter7ho1Hm7IzR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roEMPy6ND5qI8UFPaAhVSOqIIUAEp5r6r0BzYw2trS4=;
 b=nb1jgkzPoRBQ5gilm14rFFzLW52T5/4B/nwObuOf/B+4iLCwPw3ocMCEllyHLPConIgbuiTypREDvWj2rNG+f0ldJaforUxWcSpVmPTZVWN8K/4KGy6+y5gRuXxFOgM8eTFsWS+2PL7j+ugkQGMJf/TRWGCd2PIGuQZYXJo83VFCrJyRT3PgHm2CoMYhELa4J6zQZ94Pp+au1J85SvaePows4a++/PVURlU3I2a8/LuyCrMqn5hAK7fHje1o9nLbCP5rlEfBTGA/oLDetq+sX665AFnweOZVNHwMgLoLUa13wpuuIz5oW8zdG6ODg984Izett9nxchYIzGJSetYuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roEMPy6ND5qI8UFPaAhVSOqIIUAEp5r6r0BzYw2trS4=;
 b=gIh0ULXzwy0pBiy1HvTlO8lO8n5tJvwoHwbIxdpxvZi2XrFAkS+AXBF28OjHi8kZnZIFc60QLqHbknKyi0bA/tTyCtIb80Yjq2dTmwnDJDgLt3DCBR1zclwLn8bQLOrf+AewNA18kYgJ40SLDqejhB0KJxAlUGmpGTDpXSyt3TCgkSU7FJLEfYVU8eCNzVOS2SGG9ffNqeLXPnJql/saXejKIvotC6Z7GSHtB3aSfY2ozZccFgUQhImM/m8as1af1R/ANqlxF6nZjYNCxMQVS1ytYVk4S3P5YNF3Ns+0LukEFAe2g8AMnBt1wgBK2hOwUeeUj0lUqLUjBb/gs7SbNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VE1PR04MB7248.eurprd04.prod.outlook.com (2603:10a6:800:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 09:55:26 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0496.018; Mon, 12 Oct 2026
 09:55:25 +0000
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
	linusw@kernel.org
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 5/9] net: dsa: netc: use entry ID instead of pointer to track host flood rule
Date: Mon, 12 Oct 2026 17:59:20 +0800
Message-Id: <20261012095924.1129312-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
References: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VE1PR04MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e684d7-409d-4b93-b0db-08df2846f044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|19092799006|376014|7416014|10067099003|261009223027099003|921020|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2qSVJrwE5gmUd7YHK9XgJOyUwP8dlrXLdutVT98DhYsNEgic00TXz+uFYX+m1W+uWEpLEJ0FpCzfcsm8mORsUp7W5OLM8qtB/EQr6ODf8fpRohzWrhRJgnK5sJ/wVGwjEqU7oedHqD4+fJXMmJJXscXl80lMYVuNxHLhvjF+8EQiEtP8BiRTMYytA3Cc3INF1lR/gxgnS5Hk+FjeWcvjDsDPCn7N3XlsJLcmXq782XDh9UwvhbmajxHtClOrjKSkd06cbGN1gVN2Xk14M+9CxzUxVUhuSjfSDc33RnONQHW2SU0UcH7EV21BN6sL6jNQftdcp/IJnmxNLWSzIYH1eF4XYgdz9BGf2F3WLNZBTMeP9mdpelf0oOHxgiI7OZCeU2rQhdV6dyWpjp/Yl2TKokz3vLDSTqjgpGOGGeb1JwkVEhL8916cgGDSwfshVUxUdIyFtJiXi3JPBGAGC/2fkSUV6THTI4AniM07cd/QorAZifDk/yaNPR0a0Q/Jz5JQRlCU7EUwiaGfQVo+MGgetymvX62ldH/O5QTFvgerS8l3uHa9d2pm8uVjLjhkAPMttaa7WeQU3cPebqOFBgcEBv22nbwxqwY19S/6lDJaep5ArTE6tEUB40vxOQxpyGrNi6dDMo86VgKQf7Q48fcf3jI0sK0FGW9wFay0kb1hTvatoNFIf48l6xp9opKEBkiceoEMEzs3CxCqJIQHuVMeDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(19092799006)(376014)(7416014)(10067099003)(261009223027099003)(921020)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dar3BcmegMXfaa1s1qku9Kl2yPE1x/cdmHbLKnKX8Q9drhf+j5Jvg4Nnd4II?=
 =?us-ascii?Q?77NLveg6iCYYF5A6B0F7WitWm0L+abx8MJlZcYnY1wl0Yn8Vx2qI2lHbQPL9?=
 =?us-ascii?Q?Fg7RGLpc2T7VY43u0WXVKkjJ/K6p2IlcxAbxyyrfLi0WSdlP/y+NhO0k7M6i?=
 =?us-ascii?Q?oomaIN9VyQV8PEJmOVWbwPiMfkKQbix8k9GKSY9Dp6YVlGnx7uYAkrlEr8gL?=
 =?us-ascii?Q?ysDYs+TWWySlwR1C6UsiU0LNGmRCChRLaBHAggzr6aLsJ0pCJwj8fZpHl82D?=
 =?us-ascii?Q?nMQC0JECmM+KzO/DG5j4JW37cXOoUE/OUnMtYMVc0Ku7gWIucp6oag2oCj5h?=
 =?us-ascii?Q?SwrmfUwkc2rCBFZvybFX0Wf6SY3Ch/tcXHqvpfKAcyep+HaUUYxymXTO2aO/?=
 =?us-ascii?Q?THs4+OaqWTs/pGlZzhRsuWpezDco8ttOrqHllIFXs6y9MG23TrJXg6zk4kIj?=
 =?us-ascii?Q?XqrySNlTVU1G20Lp0gN4QiOfGPMdka53vmvTDKFp1RyewJ1f8M8n1edQoYKP?=
 =?us-ascii?Q?MRxzV7sGFEVMyt2Yf56/tcNwMyAZdeMSsA+usazRg2d9oNBLkdfzC99Rq5qB?=
 =?us-ascii?Q?lc8jKxs/f2aVnCQ0TOwEQfwM3fyLCmZelY5+IPDNmv1PFKMn0VbIakNPnUBv?=
 =?us-ascii?Q?KTsFtmJG491oJ4Q6P7k7QCRzjPhasAVEyoNkIRV7rMCfXVSYljHk2ajf4RsE?=
 =?us-ascii?Q?oF3VgEUHeh3cM1siNwVp3crBLYJicylpngaVEb9qbCxJdLbmV99gzZE4va4G?=
 =?us-ascii?Q?skHfXp6ILMCCAufdrN3G+0q3g0RI+5DcU0pQoSJLKbwsuI5JLcTLtExSb4Vr?=
 =?us-ascii?Q?TrLRh9rcnaFHeXak+GWaxgq3KzUegwyb1gibecB75lh90EzTm2GOyHOhLnb8?=
 =?us-ascii?Q?GUmXhJ7xIevb0PjqHya3/Vi7B9xrgZxJENqvV4e+4U5Qae8UsA4XrM6biPZV?=
 =?us-ascii?Q?Wnx9R9ZgWt1+mdAumwbuQ6oKQZ+D+Wa/mFkAgoqIuRS4hRt7RMJjNYSkQ2yP?=
 =?us-ascii?Q?VZM5FxFFBY17bIEPt1JVdrEdx0f+FZZQd15Fyjnge2wYMUvqHdrjEv8nszWL?=
 =?us-ascii?Q?91gjstPis+eiUYoTAtpbxU5vDVa6ktVnLJQ/nwMXgmHKV2JsDdRU0+LJDK5L?=
 =?us-ascii?Q?HSWI75cBt9l5YR10v8S0354VLco3n8bqElFou3Z9RSUP2rST7lz5PD4ROFZd?=
 =?us-ascii?Q?uher+KzYB8/icHiff3U2Xn1AcmJR8Rq42UZIbO1gAqbdDLUY63I81VKGw8Y/?=
 =?us-ascii?Q?8cEBRwtzgF4N4EiL/nl9B0apNktl5cJJgWAjwrwMJ4rMsZm318JOj8RL38Je?=
 =?us-ascii?Q?dFHcq9ZgfWPxDVN58+cdFSDkjMh3rKPHegJnOTkk9DhdEhA00JI9zLntfda9?=
 =?us-ascii?Q?h1AvlHZhJrTSGDM/Av2eOMW2bDiP/4F09qyJUMaENeV6zA1dPtt21/J+60OR?=
 =?us-ascii?Q?JmjSc/ftlNj6ZtLTYECMf2Ef49TpHRiK++RgZH7IQmKxBdbx4FCAU5U0EwZa?=
 =?us-ascii?Q?yZFRQVGQQP/AOwAcW1eFtSOMmwZUajvupljKHAwGhbLy1/zThbuqzYDu9u7T?=
 =?us-ascii?Q?KuHfDvGdCk4OeFBD3qxGa7kOpiA2OQNj93VhbsNwkiMe4YwqFt7BhF7m8yTz?=
 =?us-ascii?Q?vRCkpiufRyXl7i4Tc5lT/f62lCzLN3tUN7fr2RLGEAT5MP059FOw03jhyBNw?=
 =?us-ascii?Q?hMpgxVyLzg9iZxaMdoNFJQSIXGTEcfyG6usEYeaFePVsNvijXX8lG+bQsoaX?=
 =?us-ascii?Q?j8r1gCWsjsGucTcQjHvE22B6k2iKarXbn3fhfKBwpEanadhAH7zu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e684d7-409d-4b93-b0db-08df2846f044
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:55:25.5204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Uf+eSiJ7qvi51RJDogtsoKsRf6BFmkGP2M0mF2G/VgBpU4Dg4krffRHAjezllWykZWAOEkm9VErl78XWnYpURwF9D2X/AVUeBctyhueCy9W9uq3QTI+IRVnKRwV/3yX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7248

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
index c639ae67c9b7..e33a184fd005 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -321,6 +321,11 @@ static int netc_init_all_ports(struct netc_switch *priv)
 
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
@@ -1027,30 +1032,12 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
 	mutex_destroy(&priv->vft_lock);
 }
 
-static void netc_free_host_flood_rules(struct netc_switch *priv)
-{
-	struct dsa_port *dp;
-
-	dsa_switch_for_each_user_port(dp, priv->ds) {
-		struct netc_port *np = priv->ports[dp->index];
-
-		/* No need to clear the hardware IPFT entry. netc_setup()
-		 * resets the hardware via FLR, so the next setup starts
-		 * from a clean state. Only free the memory here to avoid
-		 * a leak.
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
 	netc_switch_free_bpt_list(priv);
 	netc_free_all_ports(priv);
@@ -1849,37 +1836,36 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
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
@@ -1890,7 +1876,7 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 				     bool uc, bool mc)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
-	struct ipft_entry_data *old_host_flood;
+	u32 old_entry_id;
 
 	/* Do not add host flood rule to ingress port filter table when
 	 * the port has joined a bridge. Otherwise, the ingress frames
@@ -1898,7 +1884,7 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	 * will be redirected directly to the CPU port.
 	 */
 	if (dsa_port_bridge_dev_get(np->dp)) {
-		netc_port_remove_host_flood(np, np->host_flood);
+		netc_port_remove_host_flood(np, np->ipft_hf_eid);
 
 		return;
 	}
@@ -1908,20 +1894,18 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 
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
@@ -2110,7 +2094,7 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, vlan_unaware_pvid);
 
 out:
-	netc_port_remove_host_flood(np, np->host_flood);
+	netc_port_remove_host_flood(np, np->ipft_hf_eid);
 
 	if (atomic_inc_return(&priv->br_cnt) == 1)
 		schedule_delayed_work(&priv->fdbt_ageing_work,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 4a8c5f9cde38..e7af30e5fe9a 100644
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


