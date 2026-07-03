Return-Path: <linuxppc-dev+bounces-23483-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCF9C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 10:42:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs9LK6K4pz2yfN;
	Fri, 03 Jul 2026 20:42:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783075337;
	cv=pass; b=RqHiPIsJ33OIsJ4JZ9fL2kEP/Hils5VvdTn0kt8ZdNbAG7wq11UuzSr1Wa7Aw3dGRErBHCHZHpmjnTtTCeqcWN/HY4VH+7cTgL+//XD2Vdy+77nyhT7J3d7qzxhKrCw8kKw5O4rC1TgwT9PutYuBR5WCEN3EL6GRbRNds9f42rCiQL5Xu0/Mkm4lhrBD2xtH/YKaySbaeAYmzKkfRjrEkN1KLkTqxUQ6rKzZuKEGOPcvJy2c+z8LHNerzpP07fmvBbVUZb51dzhTilp77sRcXBCROw27O8Q/lNtZZdIhOII7FuKFL7GWgfewPPWCIXDdDpUcrV+/IVHgTucRriLtNQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783075337; c=relaxed/relaxed;
	bh=ldRiNBCOJWyFngcj13VgJQfJt1BIcjx0qrIGck3hjtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pe2VFp6HRNbR6Ve1p+GJJ3dYsEuCHeK/CM/Jb3Z6wyG9cmiLvCKmKxOYSGaXDPXbprtVmBxEOXww//x31/hUDNSyR2JCA7UWNMCKjDquja+GIfHIrjCqb5YzyLvj07I05B2uoH4/xGIjL/3C+uqRvC8egPnQBGNM9ABTkYr2Z1IQAJeAjI86lNpXiSL5+hRVJbMmspNpSlOBnZBC/DTLS3XN9dxF8iJSSHU90COepxNLq60m/z9adoOvxM/utyUQ2j/f0n5Lde929XowN/22iH0m6nVGAH+c1D+2x1EalFg/DgsqrKctHqIqXfpo1lpbRM3wvv2qGHR3N9GgDqs8mg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mZKxofmc; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mZKxofmc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs9LJ4plTz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 20:42:16 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wI9e4unrxsFTPXptpfx7B78x+KdA6KDR2tz3BqmXSG8QVZAEl4hbL2uZ2tG1aEBB/IW7+smaK8I0s4W9/U18ofNB+TSiPp0IZ5N2UrTsHRNSFmCfNsgri6Fzz3KHVLslPRFfT9JfiWbX0SUVPkC1yyP8sklsmFtYSzjoF8mhS9hOeqHv47M4+Ty7ZDW3yQU+ebyijwRUUzOhcjy16x7L+BR8Y8scpMF0spCc5xGccF+tXQiDi24rmhys8m4sUBcjx3o0U+nFRYyB3zKEiVmRc2kgX6r2CuasdIDun/cYVXQhbdoFaJQ4E96wv8KqSRyplSaAmP+t7XFwio0kHslrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldRiNBCOJWyFngcj13VgJQfJt1BIcjx0qrIGck3hjtY=;
 b=C6xH/AF/qp5j1S12mEcS7/OF0dHYsnaQ7T28/wVGQehRcMgq2HohgEmGhALKypIbpk9CwAefxYhk5ruJoONV+YxnQqTimayYbY//AtSh+wnBYV2Qc6WpLsaDRdxLD7u19XTVNfPZryw0E3q+KiU0pI4WghyYplb/n5Tt/vWeQHU8e9orggcFjRl97Lp3u5wWOXoH4FFtjOm6ltoM5RrrG7tzNVWvONBvKOLEmswcomcT1ksudFBSQfeNYXmLXR36G4OatSRx4NSOoGk53jgODKsPp9vuhIzBeGEFqdtK28JhhBIk5Y3fNK09F5r1LDQdXx2vFq41lCw500FDg8Kmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldRiNBCOJWyFngcj13VgJQfJt1BIcjx0qrIGck3hjtY=;
 b=mZKxofmco9P0h5MerPqW6VOoXkIYC0E5bKTIpD3OShOMiCz2sOCFxVPRPZ602gVu1zhVLE1HiBR5C0kEloCcbYDXWuL9oqNtd+ipvO+8GMVPv6s+gGmdlECdvzpu/xgNOnQo9Xh/6XOjRao2vbi9rS2xZrzbAnefJ9PGD9MLG+CmnYp+tG0hDWL3GK9qgPZ0T21IUkl+7Rq6vOl4qCe4fNSh8QRmJbVZg9DJ00GDl8uJviwXiT7Ka+KxGr/QGx/juoHF4GnjtTO5kAVJKsu+iBAzR8AlEuZ73gXPatBh6Bov/JZINzfngfptB/0dX/H+19Zm7p0GLhfnAkaChrDwbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU4PR04MB10741.eurprd04.prod.outlook.com (2603:10a6:10:581::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:42:08 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:42:08 +0000
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
Subject: [PATCH v3 net-next 03/14] net: enetc: convert ndo_set_rx_mode() to ndo_set_rx_mode_async()
Date: Fri,  3 Jul 2026 18:13:17 +0800
Message-Id: <20260703101328.550714-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703101328.550714-1-wei.fang@oss.nxp.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0276.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU4PR04MB10741:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e83d0b9-79f5-445d-5262-08ded8efbb3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	NnCVJcxLrNgNntQcBgjYWjCWz/3yUEBfUGyyCn45HCU7I86cnigXpkWg9vez9hga+i00M90IAfneZQJ7+rIybmED4iXRLzV9S4xoB7FK1diYYbrnpZXrfFzzCmdfsGNK1hqlx7IqdzAEUulrkdDu+r/KxYHXRD0zNT2DFgb4ttlfqx73XyZfeS5L5WBL4ZzYfhfVLj3i6eWdoCkH+MLjNdv8nfdC8JiARQmN/HHuctR+fm2kbmbbL/S8JwykGzxDErZ7jtQnaLeWlLShgb71rOIZw8XpKjt5QoBlGnjQDFvTJgl8MFgd/TwvgZBdoqoH67YLBwLvc+BvInIdFD62N54jSZ6JuWaNCcDr3fnT9JDrW6es6QDzKsxlwCP/G45GxvyZzIiyq5Jk0AJSkcgCIjQrERcp1A6QjsP30iYIg44EpRnpSp97b9WBfT312O4uLyRQWtzTc7PeNGxgZ1SpKhrUj//tj7ichYJPmygB+4XN+0TpZb1HDtxWz0ANbRayUnzbf+HdGNEYqEE+2JUjgnrFHXML+VsbpGjqtbBeVAIV9NAWEVT8jUfkb4XyukaHKk+TR697h5ZAGz8VyfDocrN2ELMiIiQTsQfIBDC89QEOzmL/BRbPx3iEhTp/jqLy9dbnWxm74Zrzp+PvcxsBPRneHcz5qxztvXaDCHjCfTh1zXtj9I1Z5pbkHsqVGVZSxYXKyvQMJYZ7G/vlBL8oeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KGMMy+nMNZlqtJ9Oqc1fSHiy+qD0bx35YBcj/BBJTuLamuL5akQub5Ly0B7S?=
 =?us-ascii?Q?UI9/xIOUTOk9Uz5MdDmhm1nIlfzMX9Ql809wmo9fHQSRtdgiAI3qM9lRDJ+f?=
 =?us-ascii?Q?guKGBsem7ZC3uakwmm6gUri6sknAKKP0itukANhaNpLajEgY+bZCsQhdvQyu?=
 =?us-ascii?Q?EtBrJhsojW+qexqf/PPuCqAbML46AfBUe3YCoIV89DuYpjSo7ItNH/U3hDHL?=
 =?us-ascii?Q?2+8zyHibIps9oQ/nCkr5knw36dW8nBJt+sSvpXndgkWm1KhH2NlJUpYbye41?=
 =?us-ascii?Q?M/iBgsIC1G7jH5v6+Vw70hxxmXwApzN021KqXqF0+daiHz8V4hSznURlk84s?=
 =?us-ascii?Q?gYNNlZwg8bUnNMWS824ZdH/Jbgk2aW+BSLxoifGRC5bLiCiYjN1SuWWiEvGB?=
 =?us-ascii?Q?K++Po0Bc73QOsiNnONuLxDww2Pn3mcUrcRZfsrd9utJ7L8SGhChlkvc/cjgS?=
 =?us-ascii?Q?Ayjnl0pZ9vUB5yIMghkpXAWIA/iUPLUZfgsPKG5Tu9PdCPha925yWx2Z3Gnc?=
 =?us-ascii?Q?QesSEVEr1IaNmYWL9yrNuH3eMl0pisHTvFBJGXA0p4z96X1sGr2rvC6r64gl?=
 =?us-ascii?Q?sPo1yyIz7/ejAkMJBMNl51g3Bix1WFP16i1LpgS/0kw/Vao4302v9vozujny?=
 =?us-ascii?Q?wkPuyV3LR2wtqjI6HEMZJEkQg6GT5YhbntTYDnWE7T/oJnWmblYHZVoRInuk?=
 =?us-ascii?Q?QKEOHc14QtG+VrL8JqDuqhFJyrFZVpHbjLXpz1m8w1mF1u4DvDjy1TDYchFS?=
 =?us-ascii?Q?0HoiuOxZs9SJSWkEx1KI9vJHj6oQuRjVMxBncifvp7pYl7mjsHc/gWqe16/h?=
 =?us-ascii?Q?GQBd3aTa9Vp1PsZ1V6ZbD6thVPGZp6F0tHvnVByTiBMbsWJxRtvFEBhGM6yo?=
 =?us-ascii?Q?DIDcJC9FJ5L7qndyJjLK1XeuSMGTQDAPVdWkxYLf4rQDK5tXbQMqSAq6YyA8?=
 =?us-ascii?Q?pWZKh3AQAHQJ/HYeIJP9ZtX8NZqopwXh9IFjl3Vx4ihulw/eJcylwuu5N+9/?=
 =?us-ascii?Q?nTu2ebZ8UkA6FYJhplNQY7shuSPrjgbaFrAyJ2H+/WzwJiIlpH5oABTPCUx7?=
 =?us-ascii?Q?u7456uaVxfX+lOFOQdc7pLYfs5oyQOjtqZ88hCK8WHHKbEG3m/4+qJrI7jRn?=
 =?us-ascii?Q?jfS7DnmWofWq6Qdt2BdHYq/7TLYFngQmK8K6DB9UpS+IoOK8UADnVey1vy3i?=
 =?us-ascii?Q?O7wjeraLMv4CpDbaut9R1qeb7hTW5yj6SAPQ6T0t/MyAh6telR2ZAkDb9G0W?=
 =?us-ascii?Q?oPj5ZCKV/TcQy/sxfCFjO9nJtLMI5VBU3nm+kRPAE5OF3JxQV1zGC7QP06Bg?=
 =?us-ascii?Q?wCkxAytT6ihOThUmjr2xxjjJt4I2mEwKKsOm2bvcFmI6bgHxRk3ijXnjqkr6?=
 =?us-ascii?Q?A6lq3y+u1tUhY2zINFKqWporIUM5cu+k2cvMT7Jxe9ZEcWLzyZ6R7Phr3w7p?=
 =?us-ascii?Q?8HCCLixIr2Zdjxj7KaJO6KAFqKzLWUgQzfhMlrzLOeyY3orrZc/y7Y1pZI29?=
 =?us-ascii?Q?7PU7aOPHdJzFe1/fGjJmZxl1sr4LFCRv5AzavIVK8KFJXxIaP9/kZag9z7+C?=
 =?us-ascii?Q?ulgK0owhfSct3v0AFkIcnGUDmvy4dv6e8/01REGIt/Lsu5FdFtpgdRYvyT9w?=
 =?us-ascii?Q?c3h63GPbvqLSDrtCSQSSF98Kz4RwmCn8GHPrFMvZzSFzv8jWnd046t8Pm/d3?=
 =?us-ascii?Q?wRP5Rp44Id+Gol0ufv11vKtI/MpJ53DQF7wQufa9B2T6QfuNDfPYzjCPBJQL?=
 =?us-ascii?Q?Khhdh1j44vOB1+UgpqTS/hv5qSWFPaWc09I9vv69unbN6BG6bd2x?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e83d0b9-79f5-445d-5262-08ded8efbb3f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:42:08.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/uQC+Bo4d5CHaGKeDLUESCtT14AGOhcW6CJnFPhrRb4cthWrudyw+C27nO43vy4/1Y2DVwdT69VF89rMJUtnPPRN8nnxX2jq4ykF1fRp+iMxSu1g3T+4k2EbyQZ6HXG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10741

From: Wei Fang <wei.fang@nxp.com>

The current ndo_set_rx_mode() is called under netif_addr_lock spinlock
with BHs disabled, which prevents drivers from sleeping. To work around
this limitation, the enetc driver uses a dedicated workqueue to defer
MAC address list updates to a sleepable context.

Since commit 3554b4345d85 ("net: introduce ndo_set_rx_mode_async and
netdev_rx_mode_work") introduced the ndo_set_rx_mode_async() callback,
drivers can now handle address list updates directly in a sleepable
context.

Therefore, convert the enetc driver to use ndo_set_rx_mode_async() and
remove the dedicated workqueue and the deferred work item accordingly.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |   2 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 178 ++++++------------
 2 files changed, 58 insertions(+), 122 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 04a5dd5ea6c7..06a9f1ee0970 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -324,8 +324,6 @@ struct enetc_si {
 	const struct enetc_drvdata *drvdata;
 	const struct enetc_si_ops *ops;
 
-	struct workqueue_struct *workqueue;
-	struct work_struct rx_mode_task;
 	struct dentry *debugfs_root;
 	struct enetc_msg_swbd msg; /* Only valid for VSI */
 };
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 48a74db90ed5..a02b01753ff2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -101,24 +101,23 @@ static void enetc4_pf_clear_maft_entries(struct enetc_pf *pf)
 }
 
 static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
-				      struct enetc_mac_addr *mac,
-				      int mac_cnt)
+				      struct netdev_hw_addr_list *uc)
 {
 	struct maft_entry_data maft = {};
+	struct netdev_hw_addr *ha;
 	u16 si_bit = BIT(0);
-	int i, err;
+	int err;
 
 	maft.cfge.si_bitmap = cpu_to_le16(si_bit);
-	for (i = 0; i < mac_cnt; i++) {
-		ether_addr_copy(maft.keye.mac_addr, mac[i].addr);
-		err = ntmp_maft_add_entry(&pf->si->ntmp_user, i, &maft);
-		if (unlikely(err)) {
-			pf->num_mfe = i;
+	netdev_hw_addr_list_for_each(ha, uc) {
+		ether_addr_copy(maft.keye.mac_addr, ha->addr);
+		err = ntmp_maft_add_entry(&pf->si->ntmp_user, pf->num_mfe,
+					  &maft);
+		if (unlikely(err))
 			goto clear_maft_entries;
-		}
-	}
 
-	pf->num_mfe = mac_cnt;
+		pf->num_mfe++;
+	}
 
 	return 0;
 
@@ -128,23 +127,29 @@ static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
 	return  err;
 }
 
-static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
+static void enetc4_pf_set_uc_hash_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *uc)
 {
-	int max_num_mfe = pf->caps.mac_filter_num;
-	struct enetc_mac_filter mac_filter = {};
-	struct net_device *ndev = pf->si->ndev;
-	struct enetc_mac_addr *mac_tbl;
-	struct enetc_si *si = pf->si;
+	struct enetc_mac_filter *mac_filter = &pf->mac_filter[UC];
 	struct netdev_hw_addr *ha;
-	int i = 0, err;
-	int mac_cnt;
 	u64 hash;
 
-	netif_addr_lock_bh(ndev);
+	enetc_reset_mac_addr_filter(mac_filter);
+	netdev_hw_addr_list_for_each(ha, uc)
+		enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
+
+	bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_uc_hash_filter(pf->si, 0, hash);
+}
+
+static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *uc)
+{
+	int mac_cnt = netdev_hw_addr_list_count(uc);
+	struct enetc_si *si = pf->si;
 
-	mac_cnt = netdev_uc_count(ndev);
 	if (!mac_cnt) {
-		netif_addr_unlock_bh(ndev);
 		/* clear both MAC hash and exact filters */
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
@@ -152,79 +157,42 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 		return 0;
 	}
 
-	if (mac_cnt > max_num_mfe) {
-		err = -ENOSPC;
-		goto unlock_netif_addr;
-	}
-
-	mac_tbl = kzalloc_objs(*mac_tbl, mac_cnt, GFP_ATOMIC);
-	if (!mac_tbl) {
-		err = -ENOMEM;
-		goto unlock_netif_addr;
-	}
-
-	netdev_for_each_uc_addr(ha, ndev) {
-		enetc_add_mac_addr_ht_filter(&mac_filter, ha->addr);
-		ether_addr_copy(mac_tbl[i++].addr, ha->addr);
-	}
-
-	netif_addr_unlock_bh(ndev);
+	if (mac_cnt > pf->caps.mac_filter_num)
+		return -ENOSPC;
 
 	/* Set temporary unicast hash filters in case of Rx loss when
 	 * updating MAC address filter table
 	 */
-	bitmap_to_arr64(&hash, mac_filter.mac_hash_table,
-			ENETC_MADDR_HASH_TBL_SZ);
-	enetc_set_si_uc_hash_filter(si, 0, hash);
+	enetc4_pf_set_uc_hash_filter(pf, uc);
 	enetc4_pf_clear_maft_entries(pf);
 
-	if (!enetc4_pf_add_maft_entries(pf, mac_tbl, i))
+	if (!enetc4_pf_add_maft_entries(pf, uc)) {
+		enetc_reset_mac_addr_filter(&pf->mac_filter[UC]);
 		enetc_set_si_uc_hash_filter(si, 0, 0);
-
-	kfree(mac_tbl);
+	}
 
 	return 0;
-
-unlock_netif_addr:
-	netif_addr_unlock_bh(ndev);
-
-	return err;
 }
 
-static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
+static void enetc4_pf_set_mc_hash_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *mc)
 {
-	struct net_device *ndev = pf->si->ndev;
-	struct enetc_mac_filter *mac_filter;
-	struct enetc_si *si = pf->si;
+	struct enetc_mac_filter *mac_filter = &pf->mac_filter[MC];
 	struct netdev_hw_addr *ha;
 	u64 hash;
 
-	netif_addr_lock_bh(ndev);
-	if (type & ENETC_MAC_FILTER_TYPE_UC) {
-		mac_filter = &pf->mac_filter[UC];
-		enetc_reset_mac_addr_filter(mac_filter);
-		netdev_for_each_uc_addr(ha, ndev)
-			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
-
-		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
-				ENETC_MADDR_HASH_TBL_SZ);
-		enetc_set_si_uc_hash_filter(si, 0, hash);
-	}
+	enetc_reset_mac_addr_filter(mac_filter);
+	netdev_hw_addr_list_for_each(ha, mc)
+		enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-	if (type & ENETC_MAC_FILTER_TYPE_MC) {
-		mac_filter = &pf->mac_filter[MC];
-		enetc_reset_mac_addr_filter(mac_filter);
-		netdev_for_each_mc_addr(ha, ndev)
-			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
-
-		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
-				ENETC_MADDR_HASH_TBL_SZ);
-		enetc_set_si_mc_hash_filter(si, 0, hash);
-	}
-	netif_addr_unlock_bh(ndev);
+	bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_mc_hash_filter(pf->si, 0, hash);
 }
 
-static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type)
+static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type,
+				     struct netdev_hw_addr_list *uc,
+				     struct netdev_hw_addr_list *mc)
 {
 	/* Currently, the MAC address filter table (MAFT) only has 4 entries,
 	 * and multiple multicast addresses for filtering will be configured
@@ -232,15 +200,16 @@ static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type)
 	 * unicast filtering. If the number of unicast addresses exceeds the
 	 * table capacity, the MAC hash filter will be used.
 	 */
-	if (type & ENETC_MAC_FILTER_TYPE_UC && enetc4_pf_set_uc_exact_filter(pf)) {
+	if (type & ENETC_MAC_FILTER_TYPE_UC &&
+	    enetc4_pf_set_uc_exact_filter(pf, uc)) {
 		/* Fall back to the MAC hash filter */
-		enetc4_pf_set_mac_hash_filter(pf, ENETC_MAC_FILTER_TYPE_UC);
+		enetc4_pf_set_uc_hash_filter(pf, uc);
 		/* Clear the old MAC exact filter */
 		enetc4_pf_clear_maft_entries(pf);
 	}
 
 	if (type & ENETC_MAC_FILTER_TYPE_MC)
-		enetc4_pf_set_mac_hash_filter(pf, ENETC_MAC_FILTER_TYPE_MC);
+		enetc4_pf_set_mc_hash_filter(pf, mc);
 }
 
 static const struct enetc_pf_ops enetc4_pf_ops = {
@@ -467,17 +436,17 @@ static void enetc4_pf_free(struct enetc_pf *pf)
 	enetc4_free_ntmp_user(pf->si);
 }
 
-static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
+static int enetc4_pf_set_rx_mode(struct net_device *ndev,
+				 struct netdev_hw_addr_list *uc,
+				 struct netdev_hw_addr_list *mc)
 {
-	struct enetc_si *si = container_of(work, struct enetc_si, rx_mode_task);
-	struct enetc_pf *pf = enetc_si_priv(si);
-	struct net_device *ndev = si->ndev;
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_si *si = priv->si;
 	bool uc_promisc = false;
 	bool mc_promisc = false;
 	int type = 0;
 
-	rtnl_lock();
-
 	if (ndev->flags & IFF_PROMISC) {
 		uc_promisc = true;
 		mc_promisc = true;
@@ -500,17 +469,9 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 		enetc_set_si_mc_hash_filter(si, 0, 0);
 
 	/* Set new MAC filter */
-	enetc4_pf_set_mac_filter(pf, type);
-
-	rtnl_unlock();
-}
+	enetc4_pf_set_mac_filter(pf, type, uc, mc);
 
-static void enetc4_pf_set_rx_mode(struct net_device *ndev)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_si *si = priv->si;
-
-	queue_work(si->workqueue, &si->rx_mode_task);
+	return 0;
 }
 
 static int enetc4_pf_set_features(struct net_device *ndev,
@@ -540,7 +501,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_start_xmit		= enetc_xmit,
 	.ndo_get_stats		= enetc_get_stats,
 	.ndo_set_mac_address	= enetc_pf_set_mac_addr,
-	.ndo_set_rx_mode	= enetc4_pf_set_rx_mode,
+	.ndo_set_rx_mode_async	= enetc4_pf_set_rx_mode,
 	.ndo_set_features	= enetc4_pf_set_features,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
@@ -983,19 +944,6 @@ static void enetc4_link_deinit(struct enetc_ndev_priv *priv)
 	enetc_mdiobus_destroy(pf);
 }
 
-static int enetc4_psi_wq_task_init(struct enetc_si *si)
-{
-	char wq_name[24];
-
-	INIT_WORK(&si->rx_mode_task, enetc4_psi_do_set_rx_mode);
-	snprintf(wq_name, sizeof(wq_name), "enetc-%s", pci_name(si->pdev));
-	si->workqueue = create_singlethread_workqueue(wq_name);
-	if (!si->workqueue)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static int enetc4_pf_netdev_create(struct enetc_si *si)
 {
 	struct device *dev = &si->pdev->dev;
@@ -1036,12 +984,6 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	if (err)
 		goto err_link_init;
 
-	err = enetc4_psi_wq_task_init(si);
-	if (err) {
-		dev_err(dev, "Failed to init workqueue\n");
-		goto err_wq_init;
-	}
-
 	err = register_netdev(ndev);
 	if (err) {
 		dev_err(dev, "Failed to register netdev\n");
@@ -1051,8 +993,6 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	return 0;
 
 err_reg_netdev:
-	destroy_workqueue(si->workqueue);
-err_wq_init:
 	enetc4_link_deinit(priv);
 err_link_init:
 	enetc_free_msix(priv);
@@ -1070,8 +1010,6 @@ static void enetc4_pf_netdev_destroy(struct enetc_si *si)
 	struct net_device *ndev = si->ndev;
 
 	unregister_netdev(ndev);
-	cancel_work(&si->rx_mode_task);
-	destroy_workqueue(si->workqueue);
 	enetc4_link_deinit(priv);
 	enetc_free_msix(priv);
 	free_netdev(ndev);
-- 
2.34.1


