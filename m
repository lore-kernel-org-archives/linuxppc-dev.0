Return-Path: <linuxppc-dev+bounces-29611-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E3CCCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 20:00:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5wln5ybBz2ylm;
	Sat, 17 Oct 2026 07:00:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792180821;
	cv=pass; b=LQ+0z3jWgQXbBIccufcttPp8GlZuKArEY253Oah6cTrlvAmVGtl8qWIH3k0DXM7dwUC95Y0GeWGqDmSIFHLznMMjl3/ytRDZZ1+WFQ28glwIPEyu43Pbkab8hbu0Sr7/a1GhzSsoE9v6o0eXLEyqIH9u9mP53D2mK7XL/vy171wTZKDKnxjBm1k8+Q9OnyCQa+Yo5xlSe43G0/z9hNpsL3qDC5pmlnk6sR98ljQMWb8mIGMGuNiteouqQSzhi3LkL88eTmtlrOi3gXc2BMZGquG6Vk42DtmUTxPY7xb2IzMQu2vtgJ2acCip2TnDJbFIYlu9Co/py00IyaqXyTkZqA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792180821; c=relaxed/relaxed;
	bh=C18b9HSGMPw0L46fNtigi+g7MMS8VXgK6KifXzqgpOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hXgsqRgkNU2FNMMy9hE+QnY2J9UR1YX6CWXDEYBOKsatsblMEc0rMxbhKlhlhEChyZbBePCDzVmxmkw0Ug+1h5/rBoYQRhbDwBnS3u9pmSudS9ehnEm5OTTSBSgwGJGissd01Us/armpYQ9z3oScwth8anLsxrVbENOXV6GCWEpbQFxOfGMw19xB7/kzY+v4QPxO6JS3cbzoh3SyIrmBqsat7X8IYMQWoS76smHrFYQmnpGIrV2Tt2gZ/zbKRifF2hqzS0KDTaiDWq8MnZwAhYVE6g7ld6mgUIpzmeMyedIZYkR4JWa9UJ36Gw7RCr8Bx61jkmNdG5OtvS3JOXOb0w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ch7VwI7f; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ch7VwI7f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5wlm2PpCz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 07:00:19 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lx7KohWuMluhcL7KHp3hNGoh7WIfHvOQko5yQbMZy/0Lq5boRUXej0R7p4KXPu923J4Ihi0j1auPImbjfUy89J99RKq4Wa1k6UTyqx76Af2SZy6qfLKbEr4MhNwxmZsqoujDTg2KPAIplyAMps9Z5TCjnX5VC+oU3WFY7LfV2Xslv0+6zdAMBXpbjdK9BT4YKxrpEAKlCgcznLUk8YSGn6JLPkwbyVYFXEi3ua78fxUCn8ZhrhDFXE4qiI2OCmr9fPvLvYNiUiW4Fy/BB+3aBnvALcGpLIR9Fv4q3XM5WH3dFfl9a2EANNQvOjhAcsX9JdskQJKjtx3qrsUdMgDCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C18b9HSGMPw0L46fNtigi+g7MMS8VXgK6KifXzqgpOk=;
 b=oZNopwHYSgCYCbNOvIei9jn5xepd36dvdAVEPv7wjPmMbuSVxFAF8avw2ob83gdC9y87PW4SpyrxRDizwlXwvWq4lr2y3adkvVgiKpXkxzwlcHbV7cNHP6IRaoKLxPLWs6sR8SeoznsNp2AMyy31yd4DZZDAbN+h8f26R40KB2psNKaE8ofwdTQARuoV/4/S1XvwYfAIjG7TBeVkTc+1EEeIuxxcLHiTgFgmscK2yIeA1HFcxS7BoPCfC3WJRamxSKqEnzsnNAMFhaaGCYMPEwAYs8nv0HJaROiNqX0HlnRiGmXrGFH+LmY4m+4ehgKU0F4Kjs8CGhyz1rjDihP6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C18b9HSGMPw0L46fNtigi+g7MMS8VXgK6KifXzqgpOk=;
 b=ch7VwI7fSqYtBDTG/o8IXpO5eihU9AtVtBuXiIfU6f6zGhicFvAmkq16oo2uNsbDMqI0+oiHhPGj5Xj9NXE6665Mg7qOeAOx4WBwXO0cyQ64XGdp+Ah69HmqxqkSHqPuFxvZlRpm/NBGVxJXJR9kSsmlEg45aHnKMpq5MLaXCdnXE9vUIxqyY+fccETabk1O03j6n4tfXG00xkVwXqxuCJIvV9E9a3vEa/DpYNNOYh3xL3hWFq21lpHwgiA2De+vbsnejT5fUDmEowweMb1YHMkjL8mYz/K1A6u/IPK62R0LhUrdkGcwgj9ZNYjr34/3y802knHQ6XJ2OLdADujn1g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB7190.eurprd04.prod.outlook.com (2603:10a6:20b:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 19:59:53 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 19:59:53 +0000
Date: Fri, 16 Oct 2026 14:59:42 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [net-next,PATCH 1/2] dt-bindings: net: enetc-mdio: Document
 optional MDC clock
Message-ID: <atKCLsgM2V4_RxyY@SMW015318>
References: <20261016193344.115518-1-marex@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016193344.115518-1-marex@nabladev.com>
X-ClientProxiedBy: PH0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4bcf05-4a5d-4798-e446-08df2bc00ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|19092799006|376014|7416014|366016|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	0BHFqfblMdqrkODqWu7m0DxP7uyzQXz4EENWq3VR9vwP2/PhP0DQZDB5FEEmZDTVg/k6TEbyCTfE/+d6a78LM4qRP5DgFwkk7MVCmyeamRCcKNLdpZFntjYBNRk72rYElPwCXJ7G+wmB5l7WFEMiyf3rb3Hkp0LoluM9ycLk/5+eeNOAB41fGsBRCP5Dq6zdK0mplUwUCj43lQ6HlCjdVseNYALPFjIcf/7wIOlzP+MK0n99jEPOZX+RR+zsr8cOlkVq4n4UEHnKqG57mPMLKEI6W+G1FjLEtm38yyLWXpr0ahXLVXAeQZvpDp2TY6AENNNCAFe94VU/ghCs4tk4064mUTQNiyqjxi4xkF/gs8GKIKELlwT9K8b17bFdgebv218NR8N1/xgVLBnDIxMzk5XRzjmQNUJLzODscDwJ6IPLfnhZ/fV/VR0I62PbnRknH+3rzhnObWF9ZmMUyen/xG54PJWYktiQ25s/qS6YwGI0ZuU+vbjsYb3F/blWVDK5kltHjjyu3QpC/g4HdgZLZbrroX60QnskNW0dTuwrCJ2Pvobp9LFAstXTakPaJYHYZ6s9Ecr3JU+gjlzC7bZoNfP5jJpBcPIQxjI0MEzWVJH1Ip8htWCg5E8yZYyWcXPgSeCKUjpUI5EbpKpYOJoTY2odUQq5e9IbFGxqyIuSkwY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(376014)(7416014)(366016)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AjgF99lN488KpWYj+Dzgfi2FQcMQhDNd8tMbYrFln+8MYFQ2Aa0YMVm2YfO4?=
 =?us-ascii?Q?s1Sp7xxDUDY1E+9d75fgcZ0MmHFfvLYqJwmK5OYTsgS0zL/ZvtcDD+Rnq9vr?=
 =?us-ascii?Q?L0kom2UqNzEDymnGBMJlgSoxRuobXtL5xzvcBfokKzFHZLpakeYt0iK2Y2eb?=
 =?us-ascii?Q?pXW0ofK629Y4QW240SXsDr8ggV63KpIzPzrMR8mCkFr7L6RFfgKj/3+5JQW8?=
 =?us-ascii?Q?3ZLJz+VJxRX3Sgg63/eeNNqimrr5/20pg2YiGFux/lKev6Nf1suVgDCwk1VO?=
 =?us-ascii?Q?D7U2BmH4sexJftoEfgOB4tUEJ0a6jgqjI/RXLoAaNcVcUeZ8xuz5mmRg/oW1?=
 =?us-ascii?Q?a1wWIq+EY1c1kaTU6SBqB3mzWA5N7EiiiezezmmU2vdT1RSXao3/zmTxKY5C?=
 =?us-ascii?Q?laMG6/O58Iua0tuL453zcnAcfEW0IKNNWwi+8H6ZIYxQ5qZak4t0NG8xMnEw?=
 =?us-ascii?Q?ZGDaA4RHNPQFtfWjwSmmpnSeiCBZmU1iA64zNPNIgX1ha7P/PCCdRDkRYmw1?=
 =?us-ascii?Q?8nYWAScOVaq+mu6S3lveGYd3BT6G8okKEHhJZdKVI+5W7c31m5ByZolCeO9/?=
 =?us-ascii?Q?ccbL5kUp/FH4nCB+7xTETDuXQfcDgp403Jiwq6WWnUw/4qUHrj3SIuHX+8rF?=
 =?us-ascii?Q?C74mnQkiDNTCuOusnAP+I4hlHxDGyvYXIufq9dTPrLSsgMypiJbmRfsHD5XO?=
 =?us-ascii?Q?QWGL089GPO32+0sf+hvgcWzg1meU0Nfx0s8dABGwKOAj3p0tex/nhAvpN1/h?=
 =?us-ascii?Q?RG8maCZu3CaHPYPI3HZq/3MSzINAXDiKuJoZzfJKFdprO1TaoRFcc3qPcETv?=
 =?us-ascii?Q?McLkTtY5+dbjkG427yr12oqZhf4bVufcsx+MVNBb1CQ1EQeKKJqAo0nao/1i?=
 =?us-ascii?Q?u1O+rjcQOKvPeJiRmCzMkL8mMjq9d3ut612phH+Xat8uzuk2JemjlWoO16SR?=
 =?us-ascii?Q?3QCbQE7YlKpzcd+rI4Lczk9sE6JEaozYcX2rBzu+Y/DMvMZDZ2qqg+P+BFqe?=
 =?us-ascii?Q?wsvWo1FHnuswo4/xwjw00mezWmip6xlTQ5Tlya4Q1Sfza6/LV0Ipx1s00cs2?=
 =?us-ascii?Q?JClNdPmTSRwtd0CC6Qg1TkyUCPKVnGgpxUg3hgvdoJr3WB6vWh+1UICl6xG9?=
 =?us-ascii?Q?dQoIkOEq/IofY1VM1dAChX7lg8NM5wBtIONPsTq8QH9ZDlnoNLCdiYRSWMUP?=
 =?us-ascii?Q?zYwlRY/jT7YOTy14ykIwgKppDWizp95C/gEp+1b7MLcjM1LoLKm9bxXhc9qQ?=
 =?us-ascii?Q?BASzp+SO3nJctE+1ss1OrxEzFb0jJNxq4pQWCmZ4nhNtdptoUZSQK6SP2zPa?=
 =?us-ascii?Q?lgfuG56bpGNSyDBVR4nqPAg7zVvD0HGBfNZkLmChx0YwvjcqsMfZHyrG2dKr?=
 =?us-ascii?Q?wWrcpX6NvkqpukreOgASTOUPI6ZtsMwGyruHq6t/PtqlZVhRGMHMtGbj0n/K?=
 =?us-ascii?Q?PsPV5Pk0C3l/ytMQUyeksJ3M/2RXuQUUw2uh/0c73K0kFLZRC7KGJgtc1b/h?=
 =?us-ascii?Q?qc3zJmWGrcoe8eO1H/5O3sUDpyxvQ94eZ8Bh35EmQCicwhVM+YGmp/3nRxwl?=
 =?us-ascii?Q?xTFe/2CkX1K4ur7j3/2TtuxRLYuHX6qGzevsArMJ6/GfIarU6C855tgVfomu?=
 =?us-ascii?Q?d2UbNAwJ8jII/FktqqMdetcahWwzbfMHCtqqeouYjbo2cp81yVYd9mtbyaeA?=
 =?us-ascii?Q?dtZXb70yP7rtMbgGjnxwAwmyJjW6m9MB1Hdd0xdavWa9EM+nqnVqVSd4aw1a?=
 =?us-ascii?Q?NNlZ+DatXYqd2ZpqpwmmnkUv8+XyBsON/q2z9Wya/9dwHEPrc1Hc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4bcf05-4a5d-4798-e446-08df2bc00ad9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:59:52.8859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzw1JHNonSmOp+yh0uQHa28ctVuUJJZROsTJT4/L6dyr8buzYFdTl6t1eiPH2nCuX4H6z+dPlaoAwKuWXKSQ0xTZ8hnmodtGl5xhIRwPI+RpoNUXf7G3iRsLXVeoDQ/j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7190

On Fri, Oct 16, 2026 at 09:32:00PM +0200, Marek Vasut wrote:
> Document clock from which the MDIO MDC clock are derived from.
> While those clock are always present in every SoC, they are not
> described in legacy DTs, make them optional. The clock-frequency
> DT property is not described here, it is already part of mdio.yaml .
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Clark Wang <xiaoning.wang@nxp.com>
> Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@kernel.org>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: UNGLinuxDriver@microchip.com
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Wei Fang <wei.fang@nxp.com>
> Cc: devicetree@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: netdev@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> index 71c43ece82954..708d410187baa 100644
> --- a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> @@ -31,6 +31,11 @@ properties:
>    reg:
>      maxItems: 1
>
> +  clocks:
> +    items:
> +      - description: A reference to the input clock of the controller
> +          from which the MDC frequency is derived.
> +
>  required:
>    - compatible
>    - reg
> --
> 2.53.0
>
>

