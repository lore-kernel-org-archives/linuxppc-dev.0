Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD54606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PbBao557
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jT0yg4GY0z2xL5;
	Tue, 17 Nov 2026 08:15:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794863755;
	cv=pass; b=GRe1vgfMbLpIp1jYHo18R25BnUNwvBA2juGbf2WdAClwCRb354Kg1uNN32bjyOSDRqDrj6mTr39YOyBQyfb4INdq507AXA68W0/rcxoNADGb43+96r3CbXAevJi+wNJeCDc8gggigCjx5TjfyJ7M4VID9WeTYV949OjiJ2nYY/m4E4E7qSUNf6QNpy5Gobbgv3fpTGlsBreRDTYSghx8PXTcbTxPFRZKpcj6oBemFP0D+tJSrZUXjPqvGTTomF5Vn5+keAlkXjM9uGsGgnAhnHB0oD6XPIGHGquciGXwInXQV2NkhNvcRHUnnfwR2cV3XpIBm5+oI4i1EJe69iaYLw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794863755; c=relaxed/relaxed;
	bh=gppz6Eixz6RelKMBIkKcmwJq0OoAPs+EHo8jitDWE7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mz8brrVIGS4MJMw5dvN5HAbvZBa6kcVEaQWd/OTV8AZ+c1uqTMoUCp665iPQXmr3C8Bpc1gtRAYy8cMSg82xCYQw5aaZHczfs3Ur90GAGyA1FlWOrjG5xZ4ZHZX3LCbPAi3G4fmAQYiEWj1yGZy6Qg+xVIIdDrxuBEgLrs30+RHe9QhmO0X1RQtE6mv/LQmeks5PNehArxiXZYb4NSI5ie71A/8KSieA2Fb4i0gtgx/bcelk/GS/3BnUes3Qg9nLAUfuwQBbm9TVPTCjm7Lq6ac2S8KwbrBQYwlXfTyMakp0tNOUuMe4vcFExxJU5vVKDVDI08ntJoz+s4EyD+CIPQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PbBao557; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PbBao557;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jT0yf34BVz2xB1
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 08:15:53 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vm72QLDb9G2bf1GeDYdndAa0N7r8iLx3BjKqkfgEp4Lc6Z8iqNg5afw8E3bAd7UuHvl5Zc5f1Fhf+PN2NUH7ksk3rYXp0sU3S/yjAvua/JNa/xGWOLV+TfJR8Gn18QUFFofwQjGXtFF0xPjcSH10Jzp/d/J8ccJVpBa9HzalfYxSJY9beicPe/eZzEH8hm1PaXp4jqQ1R/7XKbuiZmK5ZDaJnAEcNdLrvUrhJhAIdLPx666lD2nCkx64VdDWzu6TENQ0Dwp8YPqSGhEbD74JcNPiCKToOmwCfQSbW+Rp0nzgmWzRMVt6+fkSI//oamhOEiJqYfUA7ybm6eZe93Skpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gppz6Eixz6RelKMBIkKcmwJq0OoAPs+EHo8jitDWE7M=;
 b=ct7Km8WNKuqd8aN97+dAL7+jOkCfyfzNZ3FnhVD2YLq6cVm382P8yctT3ryZkrPzoZKRjQ4+e7F/S1bPzPdrbUiwNs5OZjC93oSEyym0fPU9Omv7HjsLN9xAo5FY2vPwqvgfhjTWLLq5Ywh/S1K5uniyrX1J0ml7EW25qEnJ08iIw4VzVjto3OFMxKosIW9eCV4DcfyN5qF9AWQNHNqx1Ni6/b1XMCh4d6d4bgmKLEToM6D9gXSs6MudbXfVX3NMFFTq55wCjoMs339/9YUsoWt2gYsPxdFy0YHxt9X2gwvQS5gcPdQx1ZX6xfiYhcAooNn4cxqKMS3UHUelgxn/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gppz6Eixz6RelKMBIkKcmwJq0OoAPs+EHo8jitDWE7M=;
 b=PbBao5577gBJhMmLB80V6YQ959wFqTAku5RZDwiQpEYnm4iMn7w0hMX9bbdTuXYdXlQGJ9ED4ey3CxwREK7dtZ+iJuWgfOh4pKJdgQFtGFD3BxNBj4ajr5aBKlOMjwLOS6KmR5IFRtZZNN4ImPg8xldnhHsxK8lzUPtLx2K/7kJiCohspG2ydL+UNF9fs8DpbiHTFYZIKHFrX7Pug4P9V3TOqbQ/b730SlOpXnISHZnymfYLpAhhK1Ft0aMW19rsNXup1zeglcnqO8b88nKDkg/U26VyQsXk0+SrOi4tFtLSFQWuMv3WI78cQI7C8oHHsgfhMpErS8bcTe01DXnjjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by BR0PR04MB385734.eurprd04.prod.outlook.com (2603:10a6:2c8:61::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 21:15:28 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 21:15:28 +0000
Date: Mon, 16 Nov 2026 23:15:24 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: vjardin@free.fr
Cc: Dong Aisheng <aisheng.dong@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v6 4/5] pinctrl: freescale: add the Layerscape RCW
 pad-mux driver
Message-ID: <avtsY-7-I7_pdyD0@lxl00025.wbi.nxp.com>
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
 <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-4-fbdce4565a5c@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-4-fbdce4565a5c@free.fr>
X-ClientProxiedBy: AS4P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::16) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|BR0PR04MB385734:EE_
X-MS-Office365-Filtering-Correlation-Id: 275c3d33-27f5-4bfe-b72f-08df4426bce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|376014|19092799006|366016|23010399003|261022105027099003|4143699003|5023799004|11063799006|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261102123227099003|261021123027099003|261009223027099003|18002099003|6133799003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	UsZ/DL0rMZRMlAQ+ocPW6alQNUwCmvNDR2doa75nlZ7N//5veCY+K6R25X8oks/NBnSIC2i4w7cpoV5SYc/udUuYCBW1yj+95VwILaIfJTtVUD+4ns2akJrM7HbGYkeZvlCssIVHNkhPmGf6M9Fbx2BLuux42Cr2oiD28sJfuTumPfkMql+ofXaoRJv4chlGhgW7UNu20GdLArNNBIIOWzFDuNWB3EqTslmYcq3b39n2D7XWRSA2PqkLJtn4ruhwdF1Q6gNgAMSlk0NKmlOFRF6bIO4XS4yWiJ/tx8SjoGrnWDNmGDrwX7aBOsmbB0I21vD4cv5dqh+kVW8Q3N/+mugEVVW3Qh5U9qFV3xCfCvuTwjcnQYw8f5Abp4OsME5R4w7HX8ayyO5HjmgeTZvxv2+QV0q8LGYl+WdldPTnEzGVu0+MqhWa87OBxVC5tWQKKlj6KZkNPlQYrJB3afhaZzcMuWM8yuF+2CabRxnJWlvW6H8u9q5DAmHuYAeIu/JgDn09IFoqY5S88qBY7ig+klkDeY4dMUCkoanSLzXt6Awi5jCAdJeW2q3EOfDqzAgHugY9/HAzmYtm+L3XB2vgiXPTla9vs7+e1czVIVwVxuX2WHzVnARa1R1Aeep34lW/1Z2GJ1dPcrTgesZmxdyk00EomK2q0eVPdSAIS7HwSGglpLcqzybD2Sk8QVtVHZAIWUX8yahX8HPp4kMm6D2ogA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(19092799006)(366016)(23010399003)(261022105027099003)(4143699003)(5023799004)(11063799006)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261102123227099003)(261021123027099003)(261009223027099003)(18002099003)(6133799003)(22082099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sDjgkQZrjbLEDIYd8SJv/nr2QqDLJCRuxKTowr5X5qtF4+AfWrjUy0IMVVR2?=
 =?us-ascii?Q?7lYxMcY8UXg59w+kHb1/mKClDEfr/vP/q/8n/FBC4KAyKVK9Y7K9v2n2UPg2?=
 =?us-ascii?Q?PuwbwOs8A01S9B8/T67O5HUdEPvMGyaTs7DCEwmJP7o642GNf12CVPm9wEQi?=
 =?us-ascii?Q?CcfRFIN1BlMkVDbbBVU28YiYhexOe/bBuv1vlJ8p/omysfSYuoJT7/CFkksq?=
 =?us-ascii?Q?G2PKXdpkuf0yo8Fan+gbY+aQCHtyX0ErFBEtX6sh0y52+VRr9qL43FXHovNR?=
 =?us-ascii?Q?J2JNAWbBgTcNMTKpqTIQU6wdF6oo3ni6BKEoa4De0cOV5AINeVIO7l9sFmM8?=
 =?us-ascii?Q?BapiawAG5exvhY1sos5KqswUaB0oM0rFKfcrYO31B5ORHYea3ctJfuv0YzXg?=
 =?us-ascii?Q?wlnx+GwMT9cl+g5L8bB+V888QXNMst/OTEuT1iQEhmkjrt7Cvb4LPvZZIdmv?=
 =?us-ascii?Q?+VmWHFBDv3++ufkDy0LFxtDvSPsYQ7hjRjhHnyzhnPlok/YeKiQt8B3g5wdG?=
 =?us-ascii?Q?q3JN2opKI3k8yjFm4xftnM6svI77Ggz9fF1uUXP1KZUJQ2Mc/Ve+a5cDr4mW?=
 =?us-ascii?Q?UyrCilY7YUFcs5huOm+asy9+TuszvweXrU937lvh04AC2dsYIkD19R2u6l9i?=
 =?us-ascii?Q?aBrAjmwgAwOtItrW/an5kSPyDqK5Y4voq6BdbR3vWl9B8lhJ3dG7hcJmJd7i?=
 =?us-ascii?Q?CAJw6evMlpS33fzcPityD9yhZot1V9p2jbEZZQtsem3YgD80RZiV8XaLLl78?=
 =?us-ascii?Q?w7xpFjnAKpACrjwvM8Fe/bay9ppIdmnfkkq4A0iKpYcpJttGVjcrJWHUxmBp?=
 =?us-ascii?Q?h4RoDEwqaBjS5QC+PnwrnzUjm2C9qTN3ULOl/JUCgv2exEiDafhoYYD9H4Hd?=
 =?us-ascii?Q?TwqdbJV4nlo5xjrv+Ud91J2gjqLsV43WS+kD0APMHIBVn/I754MjeDtB/g51?=
 =?us-ascii?Q?IldhrvDREhr6bCqWKa+p3RQT+BBkrB/lVmeTzjlnrN/Q9b4FLFAvdUelbVYj?=
 =?us-ascii?Q?xbIskrHqlWnImuv/ixPzAnnjnwOmcIukzbz8ARSp4dDWRRGEuC96yUb6cvSu?=
 =?us-ascii?Q?w93VHOr1qdNxyEdDNeEtyAaLpvBf+TFY0hK5KJyLxUj6ORlDSlTlbxqFc4ph?=
 =?us-ascii?Q?mhzMdX4RWPc1rX43i5S1vG3DraXYd4Vwo7P/9Z0b2LAw4zAQTHwR+iFSUXe4?=
 =?us-ascii?Q?UXTPcpkRzn+rTOm6i8aTnS5KqT2neYdSL6Zp7r3lEZab5impe8T/G5oAWOHn?=
 =?us-ascii?Q?BofLgavaZljLMzfD37wHOErtkF+qGbTe9V+5GksastEB27cxis6+vxQa5bIa?=
 =?us-ascii?Q?iAn5U6rb4oZrpF4HrwH+GD2CpOXnElDaoPecGoWr1fMDZNZ3QvtxDhOgi6hm?=
 =?us-ascii?Q?A30diOHgIcf/1g/HTmtED3W+SNnrOmooLOdoYhnIkSowssUhea8rwphbLa2h?=
 =?us-ascii?Q?Bukea6/XEeoi9guXBHoRJoXbBeMGM3oQmiufiGh4S3E7Dh/YqDyGyCza3UlK?=
 =?us-ascii?Q?5kRoixTt++s+mrCv5xdQlH/XXjoevIeiD/GE6d+ZgJN+B19B+OGisq34Wbv9?=
 =?us-ascii?Q?4+EDk0x+Tj25aRFvPCut9VkrdhI0J53RxIBfzRKV0X08ZiGUplg/6B8pxGV0?=
 =?us-ascii?Q?VpHQPt15/YXW0IL8reUo4/JsP1Oj2JztxdyRHKmm4ufUhUPTaqQIccfpcsG9?=
 =?us-ascii?Q?E8gr3O1gVDYTLc+IBWcTg38hXSkMMr8BG94IS2GSiSYzv5bsxKK/WVIMNi7e?=
 =?us-ascii?Q?aCY78gr6hcnQKbg5TR2w/gGvUVSXDmXds95QmeFGnvwz1TCQ2CiLVO9zSlwE?=
X-MS-Exchange-AntiSpam-MessageData-1: SOxmJw1KNdxFtA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275c3d33-27f5-4bfe-b72f-08df4426bce4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 21:15:28.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmYZof7RQG7TzAwPI+GQxowCcdDm/ddy/5ruRetvYVY4S6B7opHKS0nwZxxqZ4SmKKumTA0iHe1vyGdurO/ByA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB385734
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 02:27:34PM +0100, Vincent Jardin via B4 Relay wrote:
> +static const struct rcw_pmux_func lx2160a_sdhc2_data74_funcs[] = {
> +	RCW_PMUX_FUNC("sdhc", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("i2c", 2), RCW_PMUX_FUNC("flexspi", 6),
> +};

The "i2c" and "gpio" functions of lx2160a_sdhc2_data74_funcs[] here
hides some real unpleasantness. These 4 pins either get all assigned to
I2C7_SCL, I2C7_SDA, I2C8_SCL, I2C8_SDA, or they get all assigned to GPIO.
But they cannot be assigned in pairs of two (or individually, i.o.w. not
in the granularity we need), which makes independent I2C bus recovery
practically impossible (i2c6 as I2C while i2c7 is as GPIO).

The way the code is currently written, the pin_request() call will fail here:

		if ((!gpio_range || ops->strict) && !gpio_ok &&
		    desc->mux_usecount && strcmp(desc->mux_owner, owner)) {
			dev_err(pctldev->dev,
				"pin %s already requested by %s; cannot claim for %s\n",
				desc->name, desc->mux_owner, owner);
			goto out;
		}

And even if it weren't for this core pinctrl rejection, there's still
the functional problem associated with I2C bus recovery independent of
another I2C controller, with whom you share a pinctrl group. Even
assuming that these two controllers are hacked to acquire a shared mutex
to serialize bus recovery operations of A with transfers of B, it's
still not enough, because B may be an I2C slave, and in that case, the
bus recovery of A will cause B to miss events.

Due to the fundamental issue of this limitation, I don't think it makes
sense to have the pinctrl states described in fsl-lx216x.dtsi for i2c6
and i2c7. Perhaps you could remove them in another change (either as a
follow-up, or another patch in v7 if you need to resend).

