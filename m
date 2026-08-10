Return-Path: <linuxppc-dev+bounces-25690-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA51C5B567
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 19:08:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJkmr724qz2yvM;
	Tue, 11 Aug 2026 05:08:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786388908;
	cv=pass; b=Dwlqeen92Ivl67Hnztr6tnaHq6fQqge0r7XP3rvNVmIWD2Jx75FegZlG6LE88xct0EqKo19oxQTEx9l0w1Yc0kqkNtjEF2NxVLdsAYVn9uzByi1AGSbmCWeKy9QtOL+PGmWyFYpJI1qrFGMKpST+cohOBbyeJogkkRsH+5HwigXNRL0p1q5bdcAvD7ZNzLow3AdqYKn2fPPTYej1UmwuxzW4+Pt2FJNqAvAgKRpg8U/1MKiXp//APRE3k57ctpodBAddDxZcJl238TECR0vGb+0jAm51joZh3/E5GAs3sVeqOyJN3+LK8/PeU4xiH7M7gKRu2JQNJkGAWh4y659Erg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786388908; c=relaxed/relaxed;
	bh=goZhmv+K3J6ketFp2viecP1qDi21FVgaJkpYf1GR+r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MGpng9yPgSE30xoUIq5bbAbrcsuRLgWpAXTMOqTLzEWrs17ZzV2K/xCnVhjA5F3EDCBT6FR5O+h7CBnlKa9u20KXGIdLdvmL4klX4YLcN7NjSU8gj6dowuIuvhdhZcmBKY8hV4r1V6bMQS5D0XiOWw4xpwt/v1dAaAb1Pxllil2HRVoQy5dWQPjtW88IVxnRZQFGYkE1i1EyLxd1Bad5mZhHBpwPZrtSy28aJ0rOPEgQ7A2yZPSk+D0F+ahDtH8DFi4+9yVq3cDdbQWvQKtGDy557MUdoholPemWkocRkjje8+l7aVVyKwp/oHoIhbRgjWP1PllJ4t0QfdZoSdqj9w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ybc1VYQw; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ybc1VYQw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJkmq2kQxz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 05:08:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9EOZs98DaKEyNU7hsix9GZrDAvgDjjppFhvy2DQphOwSLvtLIzltxK+CADuNts871fMN06YmIk5b+/iRF1vF12SM79RjQcw12As6nw9y9kCqnrnGniVeBH3HgKa2LoGLd5Avoo1pCosjSpj6K1OpwlPuFIN74yuFO2DndOniWaKRjfOOOZlP+mGmTwDupuoQc7v3yWdsrk5hArn8I6kr+kYf+RKm7P4amw3cTZ6dlY39NkYppN9F+Fd5Hx6+0pwQrSGHjyrSuhHnZE4jfmNDDogkFkVAzHl9hsCFhkIYSpCTpNoEZqAq3Pi+pISnqCvbJcmkaVLTQqfyZ/Il2EdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goZhmv+K3J6ketFp2viecP1qDi21FVgaJkpYf1GR+r4=;
 b=Oy+pEwp11orqTKuFt1tKa8eKOYQYbBaCg/ObqYF7qeeGZMYo2r4NwScVEoKnwagoVBDUjFTpInDKzh1yvlKXKTnsT6JGiuHA29+YC1EsYKgSNdwOv6EJWMCZ+sjdjLl54ynkkiF7Hhv0V/pyAOt8w6jQgKzeWVKYdHEJbZHpyBJG6tlPIFFfbkOK9tCQ+gFo+Pg5ywRoSM5nyX1Z9twC/hvwHphlGM6beOetCctqDOAv+HAU10C3yCKR92N6AAJ989KkM4HT2bksZnunDZi63D3bgXP06EWQDeIvey9Bp/FZCkJfc81bc8upHYVj+rqE+y8+0btwsXJ3znxZEod8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goZhmv+K3J6ketFp2viecP1qDi21FVgaJkpYf1GR+r4=;
 b=Ybc1VYQwx7J2VNxmrIrv88bb5M3FpqTjS3xbPdkNawOP54SCdEWt5Vp82T1ym+w0riqyOxAnBwFjhdnNgHDeU6AdeIRqMVa0fXzzr0qNgnHhjwRyWinxi+K2LmZm1H6EJTxJ8RHKIXr7tQudvLZ+UoNYNNsxhuzAUYxoOUVSRRP8bITuQ1EU+BVjhDqsTVUYPTupxIcXaIAR8sfRLV27abeVtTvaGhbxv/XtE3+ydGWVBG3M/umkQ76fOiJfF13p/vybvnTBggMvG9NBZ65NxK1JkG88bB46GQEzpwqUNnDdChYhH9gJspKhvS55KZ6F1XKgIlA6Q7jjiF3d4Nwhpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS4PR04MB9508.eurprd04.prod.outlook.com (2603:10a6:20b:4cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:08:01 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:08:00 +0000
Date: Mon, 10 Aug 2026 14:07:47 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, shawnguo@kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz,
	tiwai@suse.com, linuxppc-dev@lists.ozlabs.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
Message-ID: <anohg7YCylTQ47pk@SMW015318>
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
 <20260804100218.49587-2-shengjiu.wang@oss.nxp.com>
 <anH5i7y3JkB1moee@SMW015318>
 <20260810-magic-olive-gecko-5e8a36@quoll>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-magic-olive-gecko-5e8a36@quoll>
X-ClientProxiedBy: PH0PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:510:5::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS4PR04MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: fb190196-97f0-4ef5-a520-08def712b23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|19092799006|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	6pSWrkKlcGpuPShYiZX64cJ8TCcyplS/heQxaMA6FSFNzbGC1sN7ywtGCtn0Yp2pp00Y3vmR8VvnIk3BV/lwXxDT6CmX5P/NcG11bGroSmt5VMCCfpMcA6eFBuQ4gufzcquMb7vjeV20sIjlZgYTtQRVEtMmhhalDr900l4qjdo3Whz8i7s0gGLEmB48iLhP5yX/SqMLhCJgIoXokbnVKgELT1Is8e/BHCab6HhUZcxgehcE38WM+jq/mZGQRy5Tmd6pJTrAzNs88AQiBrzC2x0FWWw12XUKxhdIdQ5CVU3HwHtD9birMWUqfUcpwIlqZar67JT+nso55dDkuFzvqPZ481dP7GY/1dycA4NzK1DGxqza+XgCTIogMmnPEqbLseDL0TmiCkdsltEriMcBzposDwJP0812kXMQk2xHl5/jGoMJib0w9h5YKw5KxVWmKLU3nLVgPWxXdEo2G4VNSB3UQJsqzFWrhLMHZ4zAe0HsOFnL0d8LiJ37PwR17Oxt+E9/BXAo7s4MhfUcOw62/yNolotN1dVF9Ikm9oA2F0eww7MDOMVEK+JAfco72+53dXmBCxL/mauDrDQXJAVEH6FdbgIx79UZFut8mDBw3C9mMGH5fWBnlG1LBsw/nJD44qpdhEAPcTpzSExn5kLVyfWRiclW4j9fmfpkH/OaEZw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(19092799006)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7vi3Nqi4+hg4Ahxln46TXMAvfiT3OqwsRiI/601n7qITqKFb6iAz3meCOdt0?=
 =?us-ascii?Q?8Kv60zynLd3sNlvStvXGU81oRsBTaEdIXS9wMQURDcLJjQfswrKfnOtQM+RL?=
 =?us-ascii?Q?PzF28kXffe5LH7XMyTeVwaejn4zKWgYy14hdHeK6pe8WXMQ7RFHy61/MMkzK?=
 =?us-ascii?Q?gvS5i1JO8UAl5/KgV3hhqtO/dvxURNZjuC/PC2JMuNAjA6zWJencn1fp+5rz?=
 =?us-ascii?Q?znImpefqMB8p3xPsE5KLmKUWRsPMyVWurqBTt7MKyi1dUl5uS1YdO9LJz1h/?=
 =?us-ascii?Q?vr+1E26N0azzutIJV5V5t9fAy9l36u2cdjbybjzevjTo34bmjDdemJsAvITt?=
 =?us-ascii?Q?Z6pMwEOgqJcF8sMoXsqRmU0rxRE6CegRnVAbtdFD0T/pxfP3lesZrqV5GKw7?=
 =?us-ascii?Q?FnHTfcD8/ZXQAZRh8FLmhc+ypEV//KXQ8cWGr0sFG2MtoTiQ+/XMWh4ZhSPO?=
 =?us-ascii?Q?6DzdsbcI9MGi6px/k1Hgk0jssPWPbN2rSDAnvh5kPoYAbNoz8tkt027JVfKw?=
 =?us-ascii?Q?SpddKXe/JBkrFv9JlMZ9TERkgnytAXkVzkOWM/vlpw/EhRzydr/yAA24H5AT?=
 =?us-ascii?Q?eL0DrTd/EiPal1c9/hM4lhF2QbKMAx30wVOYw7vbW2FfpPG6USDX41vTvjZg?=
 =?us-ascii?Q?JHATHw5agzUx1Xo2eFqrrYa/CEYIiUrmKeI56x94Tt/eDNR/SYmUcay9EtMy?=
 =?us-ascii?Q?EbDC5wNxSuK2nQwEsJgfN/6dn3FiajW3iz9+YTYSt1rJTP2TppTopu5a0QMm?=
 =?us-ascii?Q?qau04tNrULneZFndsCwaA/V2cuSZVgmcl6J3SDd+1sUnKXa6Lp1rBkqFtmzm?=
 =?us-ascii?Q?qATkryYn9qRrxrfzPKWirqyDU+t5CYBljX4hAOtQ28yb2+iYz7An05pFpRpS?=
 =?us-ascii?Q?P1Sapz04j7zv/bL8zME6iieIh6iG2jAlNzMVwDCAgDNQ5p6QVyx4hsR+v5Zz?=
 =?us-ascii?Q?ud42z6WpyWvqQvLaNmAlIBgYRNFX5dvFeg7Vuzh8vXJrlPLBfuljSfUKtxxS?=
 =?us-ascii?Q?C6odCfTu11W5sXfKmNGpgcOEhWxSY4VLEOA1gZQkBfcl649PLJg86L61fCX9?=
 =?us-ascii?Q?ejgGEO8iASvms7AkQ8BZaKZHFE018nAj5LWtCvsqLfPcfrmSbPKRvY7pSMoc?=
 =?us-ascii?Q?+gp6U34Zipw7tiRHITp2vnniOK6aW13BidpV78XcfpIxtfYVbp4fWtvvrP1M?=
 =?us-ascii?Q?CAFVrvF7xz1XFkWqvLyqNdWAGT/dSbAf32VRgkULf6GT3bOdHTWamsdMl8nX?=
 =?us-ascii?Q?zKhYjxABLQYg74FPSIkrIusHStvtkk7+HkkDUmrFmDs1PbEqRlMPeb6SQUOl?=
 =?us-ascii?Q?bY7400K3VZzGIeyAi4nOxNtekZBsJZ9eeL3d7YsXvT2u0KFAwsExkWBzt93L?=
 =?us-ascii?Q?Haghi+tPSAlzowS7jADlavmD+YAHoZDyxMey4omRvHzYe+fb3AWeetH7l6HM?=
 =?us-ascii?Q?xM0ECTBjy8QxxoXh22t53n285tz46Cc1hBBke5FhrCDcCVjoMWwp8dE3LUeX?=
 =?us-ascii?Q?BLFMlOENE4pJ4AXusNMjRdiAoWtCxBdaL1ezqW0vVXtdI002AHILhvPa8UTy?=
 =?us-ascii?Q?NpZHGNrWCSjOHxCnGpdSCSx/OKULFZTqhLUybE2+9gqSiFMD6RT6FUX9RGJu?=
 =?us-ascii?Q?ZYwozg0DkxuCaXqg+j673AyMoSENUvmzvGeBvW7MQ3hfOGW9QFqE1YXj1ooT?=
 =?us-ascii?Q?FsK/pjBn2FTXvQ6djpqqv6QmTekv/XWxH0MKfro3WkMT3CBs5uGvBPhWsyFS?=
 =?us-ascii?Q?oZQTaE8Oa1Dp2BTIyAIBo14P4Vm57wBvVi6pN7LZXgWlETSnfTd+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb190196-97f0-4ef5-a520-08def712b23d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:08:00.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsGhF9wXmt4Ec8iOSYaqOj9P9yYSlXTb09K/7SdTfEwwg5y8e/Aq/Yzq9Bz7W6/bMrBOHLpLUeHLDf8Z7e6xX/JJzFWGST+vaOQyMPn5k+kuycjYG6Q6CVbLS3vhYOVF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9508

On Mon, Aug 10, 2026 at 09:12:20AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Aug 04, 2026 at 09:39:07AM -0500, Frank Li wrote:
> > On Tue, Aug 04, 2026 at 06:02:14PM +0800, shengjiu.wang@oss.nxp.com wrote:
> > > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> > >
> > > The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
> > > The existing binding exposed only a single generic audio-graph port,
> > > which cannot represent independent conversion paths when multiple pairs
> > > are in use simultaneously.
> > >
> > > Add a ports container that enumerates up to three sub-ports, each
> > > representing an independent conversion path:
> > >   port@0 -- conversion path 0
> > >   port@1 -- conversion path 1
> > >   port@2 -- conversion path 2
> > >
> > > Each sub-port references audio-graph-port.yaml as before. Hardware pairs
> > > are allocated dynamically at stream open time; each active stream
> > > direction (playback or capture) on a port consumes one hardware pair.
> > >
> > > For backwards compatibility, keep the old single port property but mark
> > > it deprecated. A schema constraint (not: required: [port, ports]) ensures
> > > that both forms cannot be used at the same time. The binding example is
> > > updated to show the preferred ports form.
> > >
> > > No existing upstream DTS file for fsl,imx-asrc uses the previously
> > > documented single 'port' node, so this change does not break any
> > > in-tree device tree.
> >
> > if no existing upstream DTS file use it, you can direct replace with ports
>
> And what about all other users of this binding?

Kernel is that only known user. Uboot don't use this part.

Frank

>
> Best regards,
> Krzysztof
>

