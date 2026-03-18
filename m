Return-Path: <linuxppc-dev+bounces-18399-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE271088E50
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 22:42:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbkNc4sZ7z2yhX;
	Thu, 19 Mar 2026 09:42:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773873744;
	cv=pass; b=ThRZXXxx7TDyEIZLzlmI4aONZhYnaSzdU+n/yiDNYiR8mEtSpxzpP3j3OI63gWChPM826wz6njJNjdYb0Jc76fDeJV+dpqH9Jdj9xCkotWWQXqqeFSXswbWnVOGX1sfzNo7C8B2Vnoxa454XqjBdcfWL366A3njQltkfQrwpC6XEFSl/eAsORPtBTKb7whnli7iI2pj+RKFps+qCDNJuMq2kWl46uMJjyM/O5wF7I1eHpEC+llSBPIws+c10byQo+uHREsSa5ER3PBUf/al5xwahGtIrJggXdnNa6UiwVnHVDbLX5FxgeMUWnFvq5OlMzQZ+dS/w7xORmvzgcg1zoA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773873744; c=relaxed/relaxed;
	bh=RYyflVuz+2J7uOWBP/9aazAzaECW1sELMfxFY3GsYbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZA5geHdkSDqkShS8HU77KD5TQjUaJKFojVpafMH0I8ajC6eDjDxxOJcJz2ZEVfWU5y4nkfnlZq9Xo/amkzpJ+LOaEsKmKYbKjrPF5JSFmySDxcxicHQe/Pxidu9lSXqcLyMejtdL46GPMzrNH1yvXtRpdR/61nNqECwO+5gM18fJ+DYxsiP8wYfxCEA34QkcddHVyVinqaSL/tXk/Ik+KBvv2jU2BlwFa5tW+GyrBFb5jHqIUAZEpBr3GQQYZyeCz2bG61eemBYeUde5OXmltxnrU704NGy5yIf5CkeIPjSLHZWXjnEdLK1JO9lMMbRiT3WFm8iYVPt1ZgtjMXCGQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=a0V5VApP; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=a0V5VApP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbkNb3x5yz2yr4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 09:42:23 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhqwYmS9XW7BP1nJtoaAXwz3gMqZPA45y4dzwaaa0rCD0jZTAJNfEXqCe0/Ic1ej6zGpBfWYhiRx7CdkPxzANq1ODpecZNqpx8K2hgrwatepdYpAnApncEMl1jYQ7m5k9vseMPsjpnhZ/2BaRj0qwQxxCZ5rUlyazFoHQnOGUxogYbzSe+B2B37GRzhv1YhJHAC3MeLsmGExYGPUL6S+oettTmVfzYM//qUlzsq9g/CH4MMWVtcvaWC2rMInKUOWWmgXn+DtOW3znof9wirub2fu0UnruwFYaILZgGn2umnfKbWcguJZdZKh9bnWFOKVH6IRjmkS8XHikFtLVLaiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYyflVuz+2J7uOWBP/9aazAzaECW1sELMfxFY3GsYbE=;
 b=GjANhvd/m9KB/6sa16O2VC9a5Wfmn/AyL7VWWvmdDeKm8Wkmu2D/wANsDyqdpbsPb+NxeQS7IjvSrxmUwaNZ7ETkj9s/KKk19lQzcspZ0hhQjl+FWXlTB7R80TnMd3rF2/8YB1BFyzEvVWIcj4QFcVJJSz3Zj0+v3UKfHfTrNpRri0PI7FBlw9O+GoGcjHdKPWPVsMk8wg1dWW2KxTZ3Stq9FulrxA5jEQh8DEK84g7N3DHjvvdRLza3lrirJj6B/hX7dMTVAAmjjP5g3jbAZMa34SplUFu6FMuy9IevX7TT8i4CCxOqvCfMw/Thpjqafj0wCyMj8FdTW9eiXCfKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYyflVuz+2J7uOWBP/9aazAzaECW1sELMfxFY3GsYbE=;
 b=a0V5VApPIgA+wZDQrbaKEaZ1mDDKbLvsxUo6meJtplFrPbooTssqyO2RfBhOCFIyUGQ5MAv9pXpnoYYhIxiCMdhcMEaS7uaOu4euq0Ps/6+cDJG1iR/VgSuAk3lFhX4Mjh2tGysLpgw2gLHkHqEUCefMaY/X/GcgdN39ZFZetDs10+MfJYuanR9UOV4jWjkqFA3KQk7fvhHLit/iuddbTsBACQQABvOzul7Q03WgyHKifbAtnfLu7jYyvUUSAs+3AiZDrc6afF1A908QNKsIPMQ4tDioojQLVPd7k4ghfWY1DyBLNvnWDyaKVzLSVeNDtM1eFCylKdJ4rYhVt1coxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA2PR04MB10471.eurprd04.prod.outlook.com (2603:10a6:102:41f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 22:41:57 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 22:42:00 +0000
From: Frank Li <Frank.Li@nxp.com>
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
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net-next 08/14] net: enetc: add multiple command BD rings support
Date: Wed, 18 Mar 2026 18:41:40 -0400
Message-ID: <20260318224143.911762-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316094152.1558671-9-wei.fang@nxp.com>
References: <20260316094152.1558671-9-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:806:28::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA2PR04MB10471:EE_
X-MS-Office365-Filtering-Correlation-Id: 53bf4bc6-dca3-455b-70bd-08de853f911d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|18002099003|56012099003|22082099003|20052099010|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	fa9rL8msH5qo7uddGU67chGhM9RksmgT4pXCzTFLQRmlYUzLjQPpVcLSTJK3lmZ6dIndmmCE6M4fZsyByaXgFkndMkXqXZHCXmrcoe8S9Nl48AubIB1o+f6UO6MrhbMCqZKNvBmQsl02s7lgRF7gHF0wsbKcJ5DHS2FiAzokbbFNsgH8A14w3P1GpBrf7t8isxvD4TDKrOMaVJe4BYG1rbLKjGFofGdEdKcX5OYURyXJzcRwmuXp/4MTdG3oUdcy2Mh1NhRmeAadAtsD0iNcnwe+4KgGY9/2uTbsfXFZwPOGtoYxBC6vA1ftQ3q7I9pI1qcUII4+5xFe3mph5v3mdMeRx1YsyxOw5O92MCTKco0D13OUtbNADX7zv/EU5dikdDl26xaDBQZgAl+pEIcY2ypjmm+4AyNjufgDbwZbPkdpkBAVJ6lFtE/rIp313k9OxHE0cOiNdIzR+N+pWj6Rx8F0o9Y9OOTbbtj7204WMzj582ojATpzw8BgmoCX0dFzuCSjlAzCypKLgxXIdY5oYgus327xO3eRA3LPTxHoOCRsW4XgN4eKrnBv4IWx/P2t4KI93hcsrFTUgcSqWNmyFHpsqvnGKvTMZHrnCFYnCr7c32WCNyD4Lw/QNicdgaBeiYQSsONyGQRH+ottOSgOmQybfpc/x/EHd+KSLtmv1ocoJ2SkGooRC7J8PpPmWxDQFxdNXap307qNL1tpGTQIFcSZzoploMk7v3+Q3Ux1Znx2GldfF50SYIsv5AzG5jrJXyMYZ/69WF4r7GT+/1pKDn5rS4SsUHxIhtb72hRlRqnbgIq7Kec//KGWQUfz38dt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(20052099010)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q+8h8ZvFkirk2Qfm+vAx47pcw/gJzkXUeSqsSB+KlTYs4MOqLX/MjcTHe21R?=
 =?us-ascii?Q?LYPOCZN7eujRS7eW4CZeBLarKNd62ct2Q2GUxEpIVRbQUKu4u72Jg1c5ERi7?=
 =?us-ascii?Q?3xg3mJW5i3OjPfexfV/E0wCdvBzqQkwcOGzXGa9e1TCr6S2ncUTvhdc08xIm?=
 =?us-ascii?Q?VrIYN5k0f5mlp8LVUpJA168064kJiWXGHMFMFOwrs+7NW5+JRN5dPuYx0wqq?=
 =?us-ascii?Q?1NCMkuIEN9gB684ikVmdCf6Tz8427JcmxwPidieQFeogth/WuK7fP82WTXZv?=
 =?us-ascii?Q?AscQyLericw2X2xQ3M21Qh9KELsEEnbHhJ4uRpkDJlPP1kdQwduUmIJo/Xgr?=
 =?us-ascii?Q?00usnypoTWU+SgP6vp5gvO4pm7idR3djiw+EgM6I0pmyY+xuURry6DhWhSVi?=
 =?us-ascii?Q?4wdkmv5wMW8LRQPoaH7jYEsKDIhErFa/8XY3zDIlBJ1WuBphSXVQlwlT9Pt/?=
 =?us-ascii?Q?G7mkBjVNLH/MIzPBcxq7yRxDPSAIrVjPPVG6yI8m1VYMZnwxQ/3zlFtKdyUK?=
 =?us-ascii?Q?kgp34wZzjsctLEvsKiQvwP8ek0LY59OKgsqLNK9OJ4Psx14CI1lZm5QNRraN?=
 =?us-ascii?Q?5pFZ+6DqKvJAKWjJU7mip1TDXzE2enM55ulZDklixYlLpxipT0JG643avbA+?=
 =?us-ascii?Q?wrZtLD8XnvRWacNUYnKLodGuk2u3Yq2VX0RXTIYNScjaQCfHXUMN4fiz5f89?=
 =?us-ascii?Q?ZgSJIH8z+O491IfIkpkBAkyUA3XZ/Tt7ngFlX8teaG5UFILtSVLV9Pkl3oVB?=
 =?us-ascii?Q?4tu4S/juiYxSejQh6TgCAVPDFS29P2oiKY/gB6TJAYHTjAtGfJJBKA0+EYjg?=
 =?us-ascii?Q?dagtLiXDdtMiP2/I9G54dNOsuLvsgR5fZ8vQTdHGqHCgx5X52FIu3c17xYPB?=
 =?us-ascii?Q?KBbLJ8Z+wwon1qO0wSjOOiOmdW+VI7WzICagqaqloM/uDE1deSBKUSJPk8p9?=
 =?us-ascii?Q?yNdpXKJkvaW31bDa7c3bWYvvp3IF5FtJNW6+XMj37sykNJss+p0Tyqjane2Q?=
 =?us-ascii?Q?SrL8pfx6+yKxF1cJRlO53PSqgpo5SbZQl6eBjBzNhu7C6PghfefcJidN3xcl?=
 =?us-ascii?Q?ytpedrXAkIB0xxNssAtnG92t2uKYxEkEw5eAxd5Speu/kwZtivbZbMyAqqOF?=
 =?us-ascii?Q?YMj3AgaPgsq0HfnOaZJwI+SzTznrZ91l6EpUnfpqG0eH4Rnhz583Cinkh0vH?=
 =?us-ascii?Q?7USCIHuzOwgSPNAH/bw/bbhFyES8vnL+Yo6fiMCDYaD+ZhsNW8EF1U8O/5QL?=
 =?us-ascii?Q?9NK2Y1YdIlGL2QB9cvGcOUCnJwpPmuDrvJy34pKhN7L5ZTvzl9nxZAszsI/X?=
 =?us-ascii?Q?IijJiqfntbxs9dG5UBlxL6r540/clUh/D2AxYCXR7eC+4A3g/QGz15LkORjQ?=
 =?us-ascii?Q?I4R4ldrNwJ+6JHeL4HclhVX8639UvOX/dmFR9ZSDetXfLqMeaKi7DPKGeBfh?=
 =?us-ascii?Q?VgyYiH3v4igyEBlzubpECcUBmzu1VgaQxsOzPq9cmQyBQlVj4Em3+4OTb2T2?=
 =?us-ascii?Q?H+9zs11PDDBOSdOX+ixw6aDoPK9/wRSdvUCTVBC6nMxxwDQ0aK9h9640fOBc?=
 =?us-ascii?Q?I8Ws1eLMxnSMquLcPH+MWDMu30qJiHvIpMEyCgFlxmKNzAS5BBwmJkwcECqc?=
 =?us-ascii?Q?SQix3Z+ZPwTNrCr3aRk5HeYF2l7QA8aqPgzMiVcOW9coYWcx3INbwyZj3fKg?=
 =?us-ascii?Q?wLK9XRSyfZs3JcAi7w1up9ZLGHDIGy8JNHaLT8congIhlS6LLUCTJXqQQ8vx?=
 =?us-ascii?Q?GqppeedkpA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bf4bc6-dca3-455b-70bd-08de853f911d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 22:42:00.0646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nf8CHkWgKHmAOIkK9KqvC3SvrV04gyCAF4Gof4/bTduMDGEK0ZF/b1eeyLSW3C8s4cV4Tr96dJt7hEFtssRCLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10471

From: Frank Li (AI-BOT) <frank.li@nxp.com>

> +static struct netc_cbdr *netc_select_cbdr(struct ntmp_user *user)
> +{
> +	int cpu, i;
> +
> +	for (i = 0; i < user->cbdr_num; i++) {
> +		if (spin_is_locked(&user->ring[i].ring_lock))
> +			continue;
> +
> +		return &user->ring[i];
> +	}
> +
> +	/* If all the command BDRs are busy now, we select
> +	 * one of them, but need to wait for a while to use.
> +	 */
> +	cpu = smp_processor_id();
> +
> +	return &user->ring[cpu % user->cbdr_num];
> +}

AI: spin_is_locked() is not reliable for lockless checks on all architectures.
Consider using spin_trylock() instead, or document why this racy check isi
acceptable here.

> +	if (user->cbdr_num == 1)
> +		cbdr = &user->ring[0];
> +	else
> +		cbdr = netc_select_cbdr(user);

AI: The special case for cbdr_num == 1 is redundant; netc_select_cbdr() handles
it correctly. Simplify to: cbdr = netc_select_cbdr(user);

Need owner do futher judgement

Frank

