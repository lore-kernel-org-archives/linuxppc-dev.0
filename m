Return-Path: <linuxppc-dev+bounces-26689-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15831C79FA1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 15:28:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdrZ22P6lz2yvX;
	Tue, 08 Sep 2026 01:28:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788794906;
	cv=pass; b=BQjvmkKX/55ez6RwnVHmVWPWPNU/YPYJycuu/psRhx1y5Hv/5pqYLC7a0abu5BBghALYybO15ia87/yl2uEHV9m3aR0NpMZ+eHEhSX+jNm3D49URuAE7to59DxgXaVbYDTB1feSuVUk3cpO3WQJEAoKxKuz7g3tKqmrqNv/o9jvYUOGRnucdl1m64QyCJNr7/GGiFuuYKboZuuTvSjgi8AJ/BH540RW5xKzlnjybdym22y9T3qvzr0yR5pjwMTxDa/LW3sfdS1m14iMauayPEMvESZ+Jsqu1O5IwtnMpcJrPtGOvF6XMYUkkPnhD12H3GebYoMf7+T+c26/WvMSa8g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788794906; c=relaxed/relaxed;
	bh=VMacvcgL+lgBM2lkkuooDpurCkxBdStmRSqghi+FONo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W0VQT2eXRKVvDif9QFjyFJuJk9S05lXgBrxoTpyeIMGHubT42vinY6fojLmH4EdV8q6ftL6Qx0+JpP/sx4hBVXxQUU8eNob8hIahM2u7QPkaaL0lao/ClKLCAJpxwJICpXrgFvbbrVzpd5fYrSlFYVt6Et9I2TowFaGgZZjxCBSCcUBkAUWAAf0Y+s5HCQ1jmnHthWKZEt7QtlTe+w4K+3xdjCQocLwBRS+gvVQxMxlAq1pKnuf6CNC1KBJlyFANvucKQsHin5d6l834hvzS8J8FeX7VSnWVKO5H3ClLzWzlmyt31p0d24EQ412lqUSOjtCivahRf8bfgrbbWvYaMw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lS50wBo/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lS50wBo/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdrZ021hpz2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 01:28:23 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PT6iiWh3q7F5Gu4mkMkIMPdn9uhsbTflmelZszHhyQx4ZnLYW95WEcF6GV0j8OGAd18zkgh0B0FBG/ZSW2/4X46RLNuREyPK52qS/HiHYWOPt8ryFT2qHgjVEm3393rQ+NqJehReul5m6/xnFBMjRcEMwhBQEZ3lOzSp6Sp6v1ORIanq+v7ycxxrAEwpAQ1TlRobmxSAmx+CH6Iw/3egIqzZ5lKiy9q4viIj49HWe3laFL674pGTnzdP1QGIsZxMQ8IU8R2CKaaYMjWdtlf9HAkt7Oe3NQjb6IKITHiia4DEwjB0le6YVHjkHCoVgS2J92cZ4LfAnq4s0KTzzLjcCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMacvcgL+lgBM2lkkuooDpurCkxBdStmRSqghi+FONo=;
 b=sEuIRn8eAc5rre3m3txRVBflc6qHjMiiFhBVdZZ4Gsxx506bRasC4IDQ622dVhkcOUtXdba6uONSVNKhBow1grwbzyESu2NPgB6l2NfS9PbggMq+bSxLiDtBHDK82orvGAhZ1fpkV2+1O31urexy+9b7uaSBTLlWWpQWifzcyWdlyghorUW9GW1bTmFPc84zNSVH6b89Wug6xGAHiDCWZ66NgaVbpm6YvF3olkt6kUcc3KPiCKhGgAN4mqxJG+Uaud/pLHJ2/HHy0h0k1OLDzN5ODbhn46NMWOw5+sjAoNVY0JJZ9Bw5PCX+gNU7MpzD0TBhqXE21XkT9SL+i60IGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMacvcgL+lgBM2lkkuooDpurCkxBdStmRSqghi+FONo=;
 b=lS50wBo/RrvoUj7zU4Y9OGELz/sSrSHdA1XVXcXKbXilEcMbayyXt+eM5YwXKYZEc0bNyKc+geDicTTjgrDLk2qipdDdjBHaqULTlsDly9eeY/HVXFGTPSROOQio0PuZoU6zR8EyVkgTbZsS39XYT6M5HSfMcoJNHvs8CIq4iicHEW/FfGev36v40fNJiDdFEWiGbdT+tv1ASPTSSWhjG2Pb+1QPF7DLzhFJfXO6F4o6g+BsqdccfR7Het7vNMBJCtNM3wzWS8+tRSR7mw/prWTuWTVR3wm4tQbqfDcLNlpdhzgKLjq34j5TxuAXHDbrPcvrsIv2AO1auZ6tcYbGzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by PA4PR04MB7805.eurprd04.prod.outlook.com
 (2603:10a6:102:c2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 15:27:56 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%3]) with mapi id 15.21.0382.012; Mon, 7 Sep 2026
 15:27:56 +0000
Date: Mon, 7 Sep 2026 18:27:52 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: vjardin@free.fr
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bogdan Purcareata <bogdan.purcareata@nxp.com>, 
	Stuart Yoder <stuyoder@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: fsl-mc: set dma_mask for the DPRC devices
Message-ID: <gzcfhpyhe5bds5wwywzmlnxeg23v7vut723vjc5sz32p45hqlg@ogycqou76743>
References: <20260731-for-upstream-fsl-mc-dprc-dma-mask-v2-1-ea7058b90f06@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-for-upstream-fsl-mc-dprc-dma-mask-v2-1-ea7058b90f06@free.fr>
X-ClientProxiedBy: FR0P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::10) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|PA4PR04MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed42124-4c75-41a8-e94c-08df0cf49760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	eaU0WCNOb4FsLr3GHCEq8bPWyTgz5JCnxSGIQkE6YeKJzeP8bBXqW/djMmNlxV/kC1YLXvXYvqTBp6QUKd4lU22pU07O65L4Oz1MnMyW4op38uXf2SE8R6s47zPUM9bAOa1NzZwmpb9Tu26nhd5ZNhxErTFOHOjiLf9dgIQTS7irPW/Nujz0sfFVE9Y6xhGNI8FsVmhUURAUG+XHOYEfUuzH3afap05VQ3clUh6vPB//fNqTO4Oce0iYYrlj+YbEje+1uMQV+z2HLp2kR/znn+Gyp4li/szOTYW9DSeLbiASHa58aM8yXLaWftRySPSp+uu29YaWb5QpsoLsTp247yOAuzLX/AikksMPEvIMuV9CKLuh75WM29TVDS/F/6YvE+3a3uH658Bxo4ysxmcQxjXTmcCR/gS+xXo9D/CveT5aJi0mIAkbhOIp1IhlQr1WkVFsUpotTgTDg9D6tvLYiciCUK8BhSczMAJUkw8UwO1c+K08KfsqqHgZDXBmhoNZKC3mK2rRvD39KeURrzHLSXWvUW/X7JK71N8mCkIGiVm0YyF18nayjcrFUkHf30VNo/Dvgu8Frwc8Cg7kEgB3qYO9ceo0KahQ75zH3VrF+52CQACUqi2fAd3PGxac+lK/x96gJux9S64NqFbYqRaPjHcaqthhYMKHhzzWIWsXquHAZIt0I911gz7LReVe7HaGB65nbCMVUnGVkmBjf46SGcw1e8r1Y2mGYtwMIwhSNggp16L3kkq2Wjxk3iU7RKSa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3a7OlFgC04Wxq5nkmNYTvEHfxUNpr7/JgPXgBw4CMIAyt2jKeEppC8hUCmd8?=
 =?us-ascii?Q?Xjtj0L8gbnR4SsLXYYNHAMEJ8HSXpIhYlzys50WMfNYcSFKbo1GiOUgM0fJy?=
 =?us-ascii?Q?UTaXck7NC7fZkxGlxvQMzcXhT472Px7RtNEiZzikQy/HBYjj8emqh3i1fhxO?=
 =?us-ascii?Q?t6DqEFskB7LLr0OYP++++zzK4LFogqX7mAywQSwluCJPrmwupHHR4tZZmStI?=
 =?us-ascii?Q?m1hnZYSv80EGCwjj2e4rr1tWELHqF8tpMeXHjU6hHQ7BIIvzrahj3kt6HHTZ?=
 =?us-ascii?Q?diWd3kvx4Y3Yy5G8OExujcAj/ZFSbgN5wrGjTOPO70ku/TR7UlIctne5h1Rg?=
 =?us-ascii?Q?f3q4NXVUox8qlZyF0JVEY4/tiK70WgYIJMTwFlPY8atPe49Bhqg+L9wPBknF?=
 =?us-ascii?Q?JZhpOIVO/P6mJGFVfkAE8nuNbxcSv5vMwKbpg1fllLHlw06vCsgHyIVROfsL?=
 =?us-ascii?Q?2dRHI4ktbps3nz0rdtnW0s6gIX9kwCtSJfR6S9i2W30gQp36ZV2O24ll/7WM?=
 =?us-ascii?Q?+Fh2F/RWhTw2DjvbEDFVeRneurz5RrXI8Yg5jWibvlKH+rnADXuPUuRbDcvR?=
 =?us-ascii?Q?jE9lxNSX7NoIAIZdBFF7RR8HLzZCYvT5no0zUDJtYKu3lLRnPeXm+RpjI5S+?=
 =?us-ascii?Q?X7PHS30fHwhHeQvwYo/WfnmL6EP7o+kWuxFUqnavfVBzkt4JL7hhj4BKcg2r?=
 =?us-ascii?Q?HYynIMWr5IuOedMpoXe5Xpd0f894WD3FhUN70m6SHGuBNGwjYRABAvDtBOem?=
 =?us-ascii?Q?tOfTZTgrpJY34LmYIDeBiAu+68sNn8y86T+/xBeRn+pVgZJKXPBKOx6LUbfs?=
 =?us-ascii?Q?e+t+RHMNfteGC/ZzRZqbICgm7I+6MYKEh4X9yv/iHt+V/Re6cHTXAvZewP2h?=
 =?us-ascii?Q?9xnBvP1JIBx0MfW4vjFg9d9eETFNNhbpRPpH665klFCU/R/d91mXzmZeWd0y?=
 =?us-ascii?Q?nJF8K5b8sfyVY1X3wopCrlbKXRzma7mDlGsrR5rFhy1utByHG7PCj2MCr2m0?=
 =?us-ascii?Q?VHbNSs1JIURiBMtuKPCYSBqkYMIDOvy186wVN4wyg1lqWgrzw8Yvzo1Ldb4N?=
 =?us-ascii?Q?O+AbqfRkZ+ttFRggQ4hhF838jBVLQiY15yE766yhQlORd+Q1LK4DWNIFZbVQ?=
 =?us-ascii?Q?2hygoYO0rx6eI4WQxnweMr+XRXjggTn8UZ82V0CEPJsSSQCKWPRjYKC8Ggul?=
 =?us-ascii?Q?NQk4q5dR4ZayoUzpKqqA0QkCMAC6P9Uu/6MMmvuW6M8cJj7ytoMTMGZgzo45?=
 =?us-ascii?Q?9n0Nx0cvJCwWZQeWfApNaVUrzWtvG660ljp1z27lcDwlmrSKi//OCNYiCHau?=
 =?us-ascii?Q?SQqwmq4AAV3lpGQSQ53rfmm2+DHWUtCL5+wN27jyUawzPAf/c4KtnmbLiu1o?=
 =?us-ascii?Q?9GEBj8CeZPWzzBMzy/GqhRTr4FUv0Miiqc519b9FqQ04VJfXRW1Pk43wCpbg?=
 =?us-ascii?Q?DgsT9q62DOmeVjNM5AkDQJ1Z+Bt0T6ZfSySS3XaTyMFBOZsr92/kTfqjXsZT?=
 =?us-ascii?Q?q5vgnuVssRyqI659nirI84W6IxMIIu5ay5mJ2DWJtd4NxZ5RcFY6hFZZLH3x?=
 =?us-ascii?Q?vdDzMq9IaFfU2OKg1zrsk3T9I2Gk5qPC2w/RXB1Wu3lhW4pw10r3KqgC6aho?=
 =?us-ascii?Q?szG/DnqE69wxCF/+72FDHvv96DWa3HDEeh8l6M34bpRigJyevmR/VeZMdjZh?=
 =?us-ascii?Q?s82MZaQGfdUr9N0tGOpoAPMdj5GSfY8J+hPS2MW3Lem2cFomCzBvZVoT18Jt?=
 =?us-ascii?Q?C1d69wrvNA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed42124-4c75-41a8-e94c-08df0cf49760
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 15:27:56.2118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0woecg4/GRjy4quKsJOJOAFNyc4zo6qhzKmasUwj6g/9TZlRFqAIlab1GkmzShCyqOgjmt47OB8VUKuO6NMSXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7805

On Fri, Jul 31, 2026 at 10:13:49PM +0200, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> On Layerscape platforms when SMMU is disabled by ATF, the root DPRC probes
> with its dma_mask pointer unset which leads to a notification:
>   "DMA mask not set"
> so the device is left with a zero DMA mask instead of a sane default.
> 
> Let's seed the masks for all cases.
> 
> It was tested on LX2160A with no SMMU on the MC domain: the warning is gone
> and the DPAA2 children probe unchanged.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

