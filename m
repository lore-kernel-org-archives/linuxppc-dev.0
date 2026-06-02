Return-Path: <linuxppc-dev+bounces-21847-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAAFC5DF71
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 07:21:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV2LD11tvz3brN;
	Tue, 02 Jun 2026 17:20:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780384852;
	cv=pass; b=DsVC5Ge4Sw38l+OBqu0PnMFg8hgWFHIsd5wAuTPAjlIXHeJVphIg38a72/cV/ltBjSWpBNFovCoE1NMLvbvPcl/dYBIM21XiQy1eJuNgjZr0Uo4Tu6JnArOIp7WVn25VhhQOrMaoQhGv1P+VCeMmtNxSeq2Z60649dP8o/MFhMZK5kVUnZMfNkohYEUO/NUXh9gMJQZlTUunIl+YsZ7NVyCk+Fvzq+YpsbUfyA50ZIkEI2wyMZmrO5SuvsIlWWo//FSZafC6XuJw9XfcKrFkinQ8munrD4l9iWcBypZUOxe6X8+uypxQntM8ZgDNbsKklyv7N7x2epo2Y0mMuBT4oQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780384852; c=relaxed/relaxed;
	bh=DLppnyE34xQaim1p+0XWhUc0EaQRldSEbf183f9F9Os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gk5mPKlTfhnrX09ge8lPL7MnoYqJuqlz3Ik6b32619R6N79UaDOyWNgT097Z1XJBfkZN9ncUiP45ppf/WU5lFJdKTCKMtW20yutyduRxpoFvNpduf+IogFTxFKf3GCQtwCvYoXFO6EU1O06VjWV/aZnMVTEe9Ms1MfSi8HfYxeXXbt+bsIlemlkQCNbReVtiX34SI1nrXLYntaw5MOU3yCaBkeiEn7MY3y9Y49ZsIXx2WA20bwvn7T6boWlrsve82dOcpi8B9OBU0cVpFpwUaQ5jrViJEeGi8NOqa/78KqW4uNkJO76D27ugUzOu5nHBe0ktuY+jmq8cl7TS7ouI1Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eYc/MxLF; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eYc/MxLF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV2LC107Cz3bsy
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 17:20:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNfzXBr1CxQcDAHUVEH3U8uA2nHS1eESwgsGHwSxv4Ag6Z6XvFigjITQXLnrg5wQIC7gkjO6qKgXcSqv3NE9/R0yJt+SYv+euxXsx9xi0AsCAu3+85CdBrDXlo+xv8zMFn0XIESlYRw051sbLy4vqpdhfjsHBb9Gbl6rn4ZDkfa5Utdfw+/zgN+DgzScEBGNTlxm6leVDF2FNDVh2bJ26UAoyIai449LiiLDnfcHndPTUbqR3PTfcMApm0AjJSOzdYZXeaSz7Y+sfHu+WpoYN6qVAZdsAg+QpbtFGWbjEwGh4kt05/1mH3IsCvPuLkNqhmGXbYdABg9B9+4z6niLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLppnyE34xQaim1p+0XWhUc0EaQRldSEbf183f9F9Os=;
 b=WXGLnExZpC+13VJY3EkpE78D5BFsBgKqUFvBqxCeT1Ra5PQypAOec5gi5dt12RBP9Kj6eo8XHzZlQp9WoGSTHDZdWTkbOzvnbUe5/lgGwrMUEWa/ucKxE9j/yOnREpV2vbn1oAJKeEKb4+BOrwAan84ctaH1NZhqgvLlUXOBAVwC8n1H8/Y5mPFtRp/eWok5TtHXfnJN615c5zJ4cKWdmJgnYPvc4XetEy/0WradjMGQEPtbHK9m+jhpoXspFHZG+O5G7SV1HgDp8M/uBJkwZCbcgm6YbPwMlGmJceH00fKnb7ckEtsW0InSu/ifkJt0RTQI1R7SFpdV727vR/W1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLppnyE34xQaim1p+0XWhUc0EaQRldSEbf183f9F9Os=;
 b=eYc/MxLFHUQOWfCoMVLAqbQGY/PpI4QnyMkXMxYfXC5PfnHbApEzewe7TdYONWNQqWSwwhn+urssDlepfs4Itq07u3MkMZSc2Zb3O5ndAnUlgu4VX7LV6FAwPQtVhm8qn2Z+7lbpnMy2vCBDWXVP18c9ZNUq+lOILXrjEnGirAGm9UMI1WfY7FIZahTzXxoByEW+CZwOBeACHYv8NYDL6Ji8WyaiqmzZBYcOcbysp5kIs+0ftIDViCjtUi3Rc8/36g7twIAQUYHusoDL/MIHdT0xg28z785uuxeNqB12ZIDgwhM9DlvP+ZbbLPIRL2IJLZdXrCLTv5716Ky1022ePg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM9PR04MB7684.eurprd04.prod.outlook.com (2603:10a6:20b:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 07:20:44 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 07:20:44 +0000
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
Subject: [PATCH v2 net-next 5/9] net: dsa: netc: initialize the group bitmap of ETT and ECT
Date: Tue,  2 Jun 2026 15:23:09 +0800
Message-Id: <20260602072313.3162120-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
References: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM9PR04MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a0fa9a-cefd-47dd-c0ba-08dec07775d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|19092799006|376014|921020|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pNkHgkogz56cmW0lo99pa64nk+KdXNBZF1OWJgxeV7wegCo77B/si0RpReZfNHJNTh3OV7OpJzmXWgBHhDkE2jprlc5U2TgReuWX2v2UJhiLsse3dbORa3kzzwcyMA8ndScSQw4nG5+QiBXGUsW+S74xaX8LWdlF+Sx3pdatFztPiuyf2D+tuuiC18On1vbR3ZKmsB7tSwWGFJF+b8FU3VI+sPSiZcrIgF3/GUj6a29W3MDeZIFVFCxjT0hKxpSHL/zaX8V90rVHI8dhPeknLGj3Gs+2TZVzJkFHD6slUMhcqWa7pimH1Yx4sb6lO3jbmakumA05VBkZyFtwsfPhX8h/G+hVFp944Z2xUHb4varss0zG2sYZIKOgHGMsSNYWYqE5Gk33QswPx756JcqLhYHtOO6K70ln525DU4wDiZlxxthOKheMog3UGG70/A9/l02AdGySwN5/JijUTY8jI+0XKMaMRoJxBhUpHZLuDpJvZWUvv4fcAjdoKl16luZyrbh+fPaD/8QS1R3zBrpv2UH1q24P6Q8gt0ohRPB5+MceN8hLbvZp1gjGtIQetMiUz8jzYVdps9sHiEpFpx2yWSJB0eAcXb2uMb3KkIHVMbg2zVz7k0sdQb++xMzpUKJdfRVs+66Te2h4/FHH7pz1qVCISqZrYEM89OB6MhSu60N+VD9RFTnFDOJogG8YvUEABw95TvDljKVNB/PQsJ4AWRvXgB7ZV+zkbi43v0Z3ECA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(19092799006)(376014)(921020)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dfe5R/hJBLax/NHgf7zrYoRBbnHw1MtdLOgG4Ybdm/BWc/TYY/aZVCwJaSeD?=
 =?us-ascii?Q?Lgt5rBnoipBmwWVu4lcRX3Z282uouy0oN79BybaHqw+0DJRC2ETgvyAc9o7f?=
 =?us-ascii?Q?eQ/ifDVkLg2waiKbIte7SSy0YB0mX8ht9pBz4SvgQCMAZjCJMe8RN64Op5ws?=
 =?us-ascii?Q?MZnn8ueYPv9rKZc92PGD1pWMPMrWVAcCp0+uV+RlTFj0KiSfweZyQibFa4E4?=
 =?us-ascii?Q?Yj8Id/to23C7uND2C4ZqxAsnhxGgpu80MvsSTSL0BqiA9sFAzHs34/oZ2va7?=
 =?us-ascii?Q?LP05uMAYrxlv4gMdSWhlvJDfSvpKKcPWJWKcy6IihsbC3p/V9FEWlPQAph6f?=
 =?us-ascii?Q?tFVaRRKM3qR424U6KZ4ezqya7cU5or3AhTr/h/5nj/50jHWfD59gYHb7HeiR?=
 =?us-ascii?Q?QUgqvaXaC0JvJj5nCLNthtFP7C90nil6YfGtWAXU78Zn5URw2J17jFXhvqnL?=
 =?us-ascii?Q?DiA8oDq2hXuL1qfBr0+7aco/brpEON9oOxeX/3Y2evYFgp7haLTNnLv0iX5V?=
 =?us-ascii?Q?ZriLiqsOlIw3zoBEM3wAjtdJuXK6AlJeuCuWOPnp3DJK9z7lBtKODQN0SKJN?=
 =?us-ascii?Q?Ms7UXVixKtXARHV23qlJOiYUb50K2vTZSQo3hDBZh28PQ6sXuUdYdkrKTG5K?=
 =?us-ascii?Q?sQEhqkPlI4/nrANxrBWOueTWWlstu7EdgUa6JkQy4Lr1BFN0Y3IIqVvRqHGi?=
 =?us-ascii?Q?30Jy3SFt3SoumeLfO1e5R50DdRkY7VFA44He+iVmYdYMlL5+Ms5rqhrhDZSM?=
 =?us-ascii?Q?3Ap52tqx8zAfxX0UHiD7Yprdo/7OGW87ipSpk99HM3VpvoKAh7ILERLCJ4mR?=
 =?us-ascii?Q?VDq39ruu7tXOtLPXa+ARKptaOlccuWYzVS4gV8o9UcIX8SiA1761iuRX3rTq?=
 =?us-ascii?Q?I/t3k4M9pXpdf5Tbg2NdfGH3MkMLXkNPVaOM/zB/Ns8SrHH22Ayomrtgsj1T?=
 =?us-ascii?Q?aBK/ip3omzuRZ1tsmLLXw8b3cUafG7O0DhJDmTJpHBmfXzS9A0BCW6gTEdHB?=
 =?us-ascii?Q?ccYk/2HtsSah9V426DdC8NARJq6nFZJ/yQWlazFwEj7eMmrXWYm86wu74wzj?=
 =?us-ascii?Q?rquOqIglIG0Rie0rIlDOMMwpBR9fPCdryuQQGxYkXMRNG+4GFB/JMIdJ/kda?=
 =?us-ascii?Q?fT1apdn5UOjGC2MADUYHfKCf+GxJ1jR1AMxtKpS4gu2bIp+3hO1im0pypiU/?=
 =?us-ascii?Q?FumGqIWclPvhq89liJeRVjyOeCXQDZSCtKMSCCCTOshmuPiSqO4SZw13eY2t?=
 =?us-ascii?Q?iiTJH1Sb/YaDgDzf7PN1c2ZTg17XOGNWvczuNWSVGYKVhVasv9afLzgVFLcT?=
 =?us-ascii?Q?nLqCLad9uKzi1AP3S8NXVG4br04g8OrwRXgT4tGX/AiJNpb3vmdpL6fERaVh?=
 =?us-ascii?Q?tHVeeMpj0Yv4ka8ON2KETVp8maQfk0VkuGEwYNJqQKGnuxKZV+KMnFl2nv/T?=
 =?us-ascii?Q?PbYQ1JedBQK87Kw7VftZM209Ef+QIjrXwrKjlTtlMJWeMJ072z+22SvpzSpx?=
 =?us-ascii?Q?Fvj100kUbSQlyDTROknalJbKSMPo7fa22BqYTgvtI0rpqseya/X5xHIk1w3Y?=
 =?us-ascii?Q?Z4XihUFq5dQitiLgn2jDxUdh4GdXk3kcU621rM7eq6F+flYvTJdoOEP1Jjmd?=
 =?us-ascii?Q?k0g8IvUmqPEspBZQmCPD+Wh/EnORmIZykCRW5XVUFm+mMa1FINu0ZzabkxFT?=
 =?us-ascii?Q?0NwgNrGacZSsLzbsYaCt6rTFTbVssf6JRam19neKgzcyF3ECwkeBMZJYxmhi?=
 =?us-ascii?Q?dS5jsLhdn4YYsfr1H6IWzonqk4QzBBrTrym8ndDFqej36O41C6NX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a0fa9a-cefd-47dd-c0ba-08dec07775d7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 07:20:44.6677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFHcjk5XlG47mmXSwNDmgr56Zuyh2lcBi0V1MvYfu/Wdvjp30qBlWQk9YuWERaj+5aq2nJDby2LgM3z3onUIWCZAOASagDiv+twe+LrS2kKpEmVdmzNBrT+MMkE1WCLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7684

From: Wei Fang <wei.fang@nxp.com>

The Egress Treatment Table (ETT) and Egress Count Table (ECT) are both
index tables whose entry IDs are allocated by software. Every num_ports
entries form a group, where each entry in the group corresponds to one
port. To facilitate group allocation and management, initialize the group
index bitmaps for both tables based on hardware capabilities reported by
ETTCAPR and ECTCAPR registers.

The bitmap size per table is calculated as the total number of hardware
entries divided by the number of available ports, which gives the number
of groups available for software allocation. A set bit in the bitmap
represents a group index that has been allocated.

These bitmaps will be used by subsequent patches that add VLAN support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 90 ++++++++++++++++++++++++++-
 drivers/net/dsa/netc/netc_switch_hw.h |  6 ++
 include/linux/fsl/ntmp.h              |  7 +++
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index fa7dd307ce13..d4475ad7ed6c 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -323,16 +323,104 @@ static void netc_remove_all_cbdrs(struct netc_switch *priv)
 		ntmp_free_cbdr(&ntmp->ring[i]);
 }
 
+static u32 netc_num_available_ports(struct netc_switch *priv)
+{
+	struct dsa_port *dp;
+	u32 num_ports = 0;
+
+	dsa_switch_for_each_available_port(dp, priv->ds)
+		num_ports++;
+
+	return num_ports;
+}
+
+static int netc_init_ntmp_bitmap_sizes(struct netc_switch *priv)
+{
+	u32 num_ports = netc_num_available_ports(priv);
+	struct netc_switch_regs *regs = &priv->regs;
+	struct ntmp_user *ntmp = &priv->ntmp;
+	u32 val;
+
+	if (!num_ports)
+		return -EINVAL;
+
+	val = netc_base_rd(regs, NETC_ETTCAPR);
+	ntmp->ett_bitmap_size = NETC_GET_NUM_ENTRIES(val) / num_ports;
+	if (!ntmp->ett_bitmap_size)
+		return -EINVAL;
+
+	val = netc_base_rd(regs, NETC_ECTCAPR);
+	ntmp->ect_bitmap_size = NETC_GET_NUM_ENTRIES(val) / num_ports;
+	if (!ntmp->ect_bitmap_size)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int netc_init_ntmp_bitmaps(struct netc_switch *priv)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+
+	ntmp->ett_gid_bitmap = bitmap_zalloc(ntmp->ett_bitmap_size,
+					     GFP_KERNEL);
+	if (!ntmp->ett_gid_bitmap)
+		return -ENOMEM;
+
+	ntmp->ect_gid_bitmap = bitmap_zalloc(ntmp->ect_bitmap_size,
+					     GFP_KERNEL);
+	if (!ntmp->ect_gid_bitmap)
+		goto free_ett_gid_bitmap;
+
+	return 0;
+
+free_ett_gid_bitmap:
+	bitmap_free(ntmp->ett_gid_bitmap);
+	ntmp->ett_gid_bitmap = NULL;
+
+	return -ENOMEM;
+}
+
+static void netc_free_ntmp_bitmaps(struct netc_switch *priv)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+
+	bitmap_free(ntmp->ect_gid_bitmap);
+	ntmp->ect_gid_bitmap = NULL;
+
+	bitmap_free(ntmp->ett_gid_bitmap);
+	ntmp->ett_gid_bitmap = NULL;
+}
+
 static int netc_init_ntmp_user(struct netc_switch *priv)
 {
+	int err;
+
 	netc_init_ntmp_tbl_versions(priv);
 
-	return netc_init_all_cbdrs(priv);
+	err = netc_init_ntmp_bitmap_sizes(priv);
+	if (err)
+		return err;
+
+	err = netc_init_ntmp_bitmaps(priv);
+	if (err)
+		return err;
+
+	err = netc_init_all_cbdrs(priv);
+	if (err)
+		goto free_ntmp_bitmaps;
+
+	return 0;
+
+free_ntmp_bitmaps:
+	netc_free_ntmp_bitmaps(priv);
+
+	return err;
 }
 
 static void netc_free_ntmp_user(struct netc_switch *priv)
 {
 	netc_remove_all_cbdrs(priv);
+	netc_free_ntmp_bitmaps(priv);
 }
 
 static void netc_switch_dos_default_config(struct netc_switch *priv)
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 1d976882a6cc..1404ae41c7bc 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -36,6 +36,12 @@
 #define  DOSL3CR_SAMEADDR		BIT(0)
 #define  DOSL3CR_IPSAMCC		BIT(1)
 
+#define NETC_ETTCAPR			0x18c4
+#define NETC_ECTCAPR			0x18ec
+/* Index table NUM_ENTRIES mask */
+#define NETC_NUM_ENTRIES		GENMASK(15, 0)
+#define NETC_GET_NUM_ENTRIES(v)		FIELD_GET(NETC_NUM_ENTRIES, (v))
+
 /* Hash table memory capability register, the memory is shared by
  * the following tables:
  *
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 1123d060713c..1e087316d4f4 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -3,6 +3,7 @@
 #ifndef __NETC_NTMP_H
 #define __NETC_NTMP_H
 
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/if_ether.h>
 
@@ -70,6 +71,12 @@ struct ntmp_user {
 	struct device *dev;
 	struct netc_cbdr *ring;
 	struct netc_tbl_vers tbl;
+
+	/* NTMP table bitmaps for resource management */
+	u32 ett_bitmap_size;
+	u32 ect_bitmap_size;
+	unsigned long *ett_gid_bitmap; /* only valid for switch */
+	unsigned long *ect_gid_bitmap; /* only valid for switch */
 };
 
 struct maft_entry_data {
-- 
2.34.1


