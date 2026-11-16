Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEB2606A885
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=RrjKN+TV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSw5t45ybz2xqL;
	Tue, 17 Nov 2026 04:36:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794850610;
	cv=pass; b=PIvdeR67f9uEjHGce/RYQgUSdc0JZ/YuVmBtxn8D3t8zRlZXxQrCcTz5VuxxbflR/OgVwW/XSCthNLnco1tAxxexanZdhwmSciDfwt+x6WlsFLDrKSJPm3O1HkvNhRoSHwEPEQjx272bhMNG+vbQlZVB7aYv7098cPlKjIIuHuSa86HrgELhTT/wCCr3ZcSXOmobfZCl+770VlXDtkYq9bsblNRye/9NHm0xLZrpPfUTyThYjMfHvK0bHfcxy9i63VXheBGZ4J/LMwwjQ/r5vRgwe66LT3+YM7SMER3Qx+aoci8c6mHjNHd8auGh0NmK9KdDfwkrR9sECnkCDKqImA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794850610; c=relaxed/relaxed;
	bh=cy5vRLB6Ac4/CWZXpQsEgSKzid72znqiijFZ2xT7i3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mQ5yE9eE/3Y/NMTZdxL3i/xYF5amWpdYuq9x1yDhrai8mSaZDVi1t5KMOV4mRmXENMU1GfzneHwwE8KM9UQWR2WEHS2V1AnsdhBo7yt+Z5Ocm4gC3lQRwLeZ1tSIYZE85fUVn+T1PjEBfHkUmlKjXJxyuKy7n0LjL16Xw13jQGeFzoDwwcJJr3Qi3y0bVe+kr0hR/2Gx/2giCzkKOXs9erE3Thjmf5/FvJHY80xwQUOR5yd12mJ4matuUDo9pXwmopzE5B24anYIVYFV51h1BXIaGe4GkYdRAywNvORpqdG38KiLXKG2CgpupKhcJrGIQ7yO+jXgfBL0EA5uH9NSZg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=RrjKN+TV; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=RrjKN+TV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSw5s09qRz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 04:36:48 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyMRqidajX9uGHXCztUoJvxlIOfIPFCYIB7yeNGa9gEc0xYCh2L5ZjnnaysZ8Se+yD4by/hzSd0m9Y50zvHYXxSZPLZLI+2eJF/1z/+jqxAl6r2MzTOIGjd74qHXxaVYYzcalbfJZ4kqkej3VYLy9pNQvzxqrgJu2q5jVcCCnsSQeckGF8MT/fl0gIWD+WPCfNOQI5LdwlrFryX0ESeD9M4OLU9AyTDZVDfdI3raJUyR+PxoJ+LIgk62d75pNxpHLE3TBe6B73kz3Ud1hjvbW/Cqa92q6Z3QcfnGdaZgQeWjgUlE0ONnWYAwUJKll0WQUuA68YKadnx2w/raRTzVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cy5vRLB6Ac4/CWZXpQsEgSKzid72znqiijFZ2xT7i3o=;
 b=BZiXNJk38v63GqEoDlODwF0CWUnCH6AAPIon/qqGCWYMC7T90AV8uZ5tpYv6h69RKVbvIFe8k26cy3DiEuURWDzOJVMzWPcmhg4V37v1AB5T6B4y2W6o8yjmQzujYjgV4gT/bKXewbVQf4nyPxKOSMXtwwxaa1noCTjQ/m8oC5Ide4RgaO0Za2ew2JyPdsy0FamT/viSP/1icke6lvWOil4RQ68B7vCNDV9PaKhYUF6QDBys27+CJlP5h39ANudRAZHc3f0OF4N4a4eQVZza1aINAm9SpdoJlzjA/cMeeLYKI0VKK+/36PBarq9Y4ecCHNFk7NULSGpGN2YPPepckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cy5vRLB6Ac4/CWZXpQsEgSKzid72znqiijFZ2xT7i3o=;
 b=RrjKN+TVAQv3bT2+2PCMkUPXfh2E0XOmkUnDSVqKd91GsxTzHnWbsAt17M5JLbwcWe1PLfjwRt7fspf6bKqcadhLmSP7fAW8fHCtggFiB1FHcvcHvN2ZXO804gmsOpPEJNgVhcmrY6kiHDrnbDheSSygSlp+nKH9HvR1v2nGGRLlr4zBrpJHvCh8cNBiFfeLmNOjkHrQb37KoRONs3n9zgeEY4YTB4yLKUNCyKsJquO/ZV+f6rgxVAtclHW45ywrX+Fb5AIiJ3nyk+v1gqmSOKvC4hXSpAI5IdanmpIFPolUK+1BlX197q6BtAhaH5IkRSOHFB+BO5TCWmfhU4mYaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by PAWPR04MB11570.eurprd04.prod.outlook.com (2603:10a6:102:50c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 17:36:24 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 17:36:24 +0000
Date: Mon, 16 Nov 2026 19:36:19 +0200
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
Message-ID: <avs62BhLjlpouTwQ@lxl00025.wbi.nxp.com>
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
 <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-4-fbdce4565a5c@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-4-fbdce4565a5c@free.fr>
X-ClientProxiedBy: AM0PR10CA0045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::25) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|PAWPR04MB11570:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b3d3db-7a70-46f9-d286-08df44082273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|23010399003|7416014|376014|366016|22082099003|18002099003|6133799003|261009223027099003|4143699003|11063799006|56012099006|261102123227099003|261026121527099003|261021121427099003|261022075727099003|10067099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	BNzTJ2mYn5GY/C4GANtNwOrrJ8C45N3klGY4J81iA1yad2+Mprsg+t/oKLzcuSnZG6S29AQBC9om8pey8DI1WfgSTmvNSnNtJ7YT0VCapFGLX8QMEmmyGl0rUyLNwmBq3F0y+zJwbwVf3ifWworMXMb9zRBVaJLYEkmFjIxSokpXh7FV6Ftd+WeTI5HsGJr8w1YCEMYUc6riFgt5012PeEY7a5ppBQIHTZzJRr0lMbaYl1sjMQ6ol7QaijZb6Ipp/aDPz8TspFHmcy8+QTbJbs49LjeVeWi4fqYLmhoZ6IksJ64ayuBSTvmqEDEoGbmnKDjDeNkBBfbi5lmODzrgQRME1YIcjnVatu5S7Ls+ZHZ8H6iuVRVplPEeAYlrM2FEq/j/XudE0KOJfxYDyZHJuWva9vKO7QWMRQSd8A+vRTg/gUKqSy9uRRnV8S1rxVIxIgKhNSwl0bMEQp/HdZ+LP8PWUvI2wyMxafpv7Xq0blITtSllZSi7s0G7JfUWIeYtWQPwEIjnyFtlqGFofXZqRKqEZ+Z9L29bCeKDbUzkr2tfSyVVc6jRVLtXyfSBVzAGt2ICtrAoehfdmBRN2hGgHLkRmlr5ZcmNdR6Md1RcA7tbDXixCtKtSY5KmQVleeup/YBraM0VY/ZyvpRQwU8jqZwi38NzY8d97rV0jnN4XVDcTbLD7UiTDjB1/aLRCEBop6/ngYZg88VKZFHz69Ajbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(7416014)(376014)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(261022075727099003)(10067099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?83j9TqllbE/500zRMt+C1LSbKlrl/roPhD45sFrPMiRymK5wGJ2GhF+Bz8po?=
 =?us-ascii?Q?WF7lxzK20VgshAoURE3VU8y+P6vHtkwJ3NaIjFH1kn/2S6ZQ2NS0O6L5mAqb?=
 =?us-ascii?Q?CkFIZMUZWX1OYZjLwHLe6h3YYqfA2L0Tm2NMT8zTDiT/F2dfzWdTMLrLQIYr?=
 =?us-ascii?Q?tcTxMLhlnTBevdcnTphrupxtZHh4LYjclq7XTRNR7/Rg/XnH4o8mK4qjDLjY?=
 =?us-ascii?Q?KG9iYiCss9MuOZf/eTtTpFooEsc7sPwibsJ/67/88v01JDkIXtHBNX2VmLgs?=
 =?us-ascii?Q?PFIN2bTys7BSANczRAydgpiADRsNyw6XjtAnPMvmxiPIgjCG833/82epOFZ2?=
 =?us-ascii?Q?G2Cz+PnXUEreDF+IiH2g7bZ+xdN1btmCGF0oIMfzzvG1BZ2naiFwjlIm7/Vs?=
 =?us-ascii?Q?Qb4PDVd4SRS7zQULICCnykvJsJdWbDl9i9S9dUTU3q8ch4AcK/ciKL2spwId?=
 =?us-ascii?Q?JYauMkEw1uIsd8T/K+4JT6JyDtA3KMeFyvSWV9UY97jKneOViRmFm1mEufbd?=
 =?us-ascii?Q?gBUvSZiaKHknQn5MOUXm5l+LYFQjCKLFlSqfh30wQwCYTEAlMAqP8W5hgRgF?=
 =?us-ascii?Q?9nqe2+ZRuc6dj41UuO9JTVB7fUDFBz/AFfy3R1uzJA/1OdquaqfqQh+iB++t?=
 =?us-ascii?Q?Flvjy89AP2TM0koWLJbvP0j6zQBXspWACkeuFhVY+r4R9DwybljAfWwzhgnS?=
 =?us-ascii?Q?zjC7N/1gQ4t+7LvxkleSE3K9W3ZhN/nft1mP0FfY6BBkwNAQckngc61IuxY/?=
 =?us-ascii?Q?Afb5ysNx9h7+0LUA3atCd6Ums4oLM1PG+dp8HcnTzfQgo6WsdaAqEX5Z6RJk?=
 =?us-ascii?Q?wGTwYoInIJFHaRwd53B97Y02ppS5PUekyCnZeqhDeQTXZbzT8iaYUj7C8PN9?=
 =?us-ascii?Q?GKCtlytKXyauolFGLJ7A9crp0acyYDZmXTj54DpJuuxP3DK80SWDJgqJc0Da?=
 =?us-ascii?Q?b/2KZ7b+gn+94l0oLmb2TqUoNZdGRISw2dX/CegYxbNPTJQ/E1xiiSZdWyKp?=
 =?us-ascii?Q?tqsrkAPY9OZD22ggg4hSOuqptRvmDc/1Hnc6Kth4Cd2A8yL1D2dVhsOCuO4A?=
 =?us-ascii?Q?vA6nTH/tlPIX1on+Xr1QoXZ08ndw1GKEyNEIpCEFJpmJfvw1uZUq6GxCPxAx?=
 =?us-ascii?Q?VcBDV9azXOvFXTofmDBSuMAG256hCMFb88+5mCpca4idRXSjdNu6dMltwva4?=
 =?us-ascii?Q?E0a7QpfmP/ugspfhZdl4u+OQzZLwmsz7HWDqV3X8ptIDtMiD5W3EwHbCYgiI?=
 =?us-ascii?Q?4CpzV5nBXATFMcBxTRBtv7dr4YV8msbKpqjnv6Vaeg2mLgLpECG9oy3cm4gd?=
 =?us-ascii?Q?JNOQz+3QIqrDDoO+bV+zeUF1Lwm409Upu4AcSGhMisu64fYFTx3ODKUghQPW?=
 =?us-ascii?Q?gzoij8r17xdZCsneEHbPmHR2WEo0eKUtuBch5D+cEjMkrMI/pPIrGQIYk2kH?=
 =?us-ascii?Q?hqgD1RBcMST+4bQyQW+uBZc9xGfZUpRTjUAyYrL9HUxD/fXtpka2Q4N5GFV3?=
 =?us-ascii?Q?5I3O2wwuNlcn957axJWKUhuZ8lP7G6Vu5vmOdwOUcAvF3LY6QQG3LBK6CNF8?=
 =?us-ascii?Q?WjHB2shuSoXYdz1pF6icSffwYnRjK9GYv4/n2XWeRPkY7K4uAHJy7bOAcwBN?=
 =?us-ascii?Q?qLbD6jBN1R1vlJPk82YMya4aVqxRHg0RLAkPXvc7LC5ysGNC4sGqe7vuFJqk?=
 =?us-ascii?Q?UgnuBWrBGXjAOakcUwJIE6VLABkLDNCckpSpKS0/c2FzKli8bZY070OCbSn8?=
 =?us-ascii?Q?HMDT4B0eIg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b3d3db-7a70-46f9-d286-08df44082273
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 17:36:24.0549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIeW9ot5AXmCik7xaxYj5nNV8RVrRL1tmQ5/swIyise8EST5cBankfmXwOO/Aoc9EqDa98jrLsjSWag0dke85A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11570
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 02:27:34PM +0100, Vincent Jardin via B4 Relay wrote:
> +static const struct rcw_pmux_func lx2160a_clk_out_funcs[] = {
> +	RCW_PMUX_FUNC("gpio", 1), RCW_PMUX_FUNC("flextimer", 2),
> +};

I was testing the /sys/kernel/debug/pinctrl/1e0012c.pinctrl/pins
debugfs, and I just noticed the clk-out pin group gets printed as raw 0x0.

I think you've uncovered a documentation bug here. The primary function
of CLK_OUT_PMUX should be 000, aka CLK_OUT (this is a debugging signal
of the SoC, along with ASLEEP). I may be missing some context as to why
the reference manual says this value is reserved, but it clearly does
something - because table 19 with the hardcoded RCW bits lists 000 as
the default value for this field. So the RM contradicts itself.

Also, I see the debugfs thinks our pin groups are individual pins:

cat /sys/kernel/debug/pinctrl/1e0012c.pinctrl/pins
registered pins: 30
pin 0 (iic2) 0:? sdhc
pin 1 (iic3) 0:? can
pin 2 (iic4) 0:? can
pin 3 (iic5) 0:? i2c
pin 4 (iic6) 0:? i2c
pin 5 (xspi1-data74) 0:? flexspi
pin 6 (xspi1-data30) 0:? flexspi
pin 7 (xspi1-base) 0:? flexspi
pin 8 (sdhc1-base) 0:? sdhc
pin 9 (sdhc1-dir) 0:? sdhc
pin 10 (sdhc2-data74) 0:? sdhc
pin 11 (sdhc2-base) 0:? sdhc
pin 12 (uart1-soutsin) 0:? uart
pin 13 (uart1-rtscts) 0:? uart
pin 14 (uart2-soutsin) 0:? uart
pin 15 (uart2-rtscts) 0:? uart
pin 16 (irq11-8) 0:? irq
pin 17 (irq7-4) 0:? irq
pin 18 (irq3-0) 0:? irq
pin 19 (evt4-3) 0:? evt
pin 20 (evt2-0) 0:? evt
pin 21 (clk-out) 0:? 0x0
pin 22 (asleep) 0:? asleep
pin 23 (reset-req) 0:? reset-req
pin 24 (iic1) 0:? i2c
pin 25 (ec1) 0:? rgmii
pin 26 (ec2) 0:? rgmii
pin 27 (usb-ext) 0:? usb
pin 28 (gtx-clk) 0:? gtx-clk
pin 29 (sdhc1-ds) 0:? sdhc

(which they're not - iic2 is a group consisting of SCL and SDA, whose
function cannot be selected independently, which is why you've grouped
them together).

I suppose this is OK? Not really a pinctrl expert here (and it predates
your work - pinctrl-simple worked the same way).

