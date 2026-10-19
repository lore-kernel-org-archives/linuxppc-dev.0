Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7D606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=f2K5nsOq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7nYl4lwtz2yb9;
	Tue, 20 Oct 2026 07:43:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792442587;
	cv=pass; b=meHFb/ycOG8iWJdP6z8p0J9hXf9K9QwvX9ULQ4sY67WjMqzv7Q5SSN/1d1jRFAxhpSWECzvWtO91t1SzyKYCe4IJt5L7yn8bxfl4CUDjoFvoJYj+a1ynS61LSmo3k4IVqZxF01GNjmLxklvGw1LRFCYHmAmHqmf5LqBovTI+8tKlH/TKDjxkHGj5irslOrmoq0NHkJtrL07pZNGwdDLSn5oCmx/G1aEg40QtSKYxuatdRedVRd/UYyjzJkXCZTPM+n/SiW6jPQSO4sZlvvhTLqvGMzsA4NhP8nRIu62YaZD43KL/Gf6hM+zTshKR8nxBkt7gniY97OZw6zZnji303w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792442587; c=relaxed/relaxed;
	bh=o2QjvA/y5Btd8S5rN1Zmuz1Z4m0p5O6mlwHr8eDsAl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kv40bmsTVOC7mTPaoSKtkFKkOKdmodjiRsetiP5+lhykPi/tCUeiqsWqez/4fn0g4ar44DhBsiFN+OaBWLbb1n/9bZUzsV69pWXVk963r3bxduqfH92/ipk6bMFF4I0HG396WvxBVlGW+egfUvGWiCCCwVpawHsdVEPkNV7cT78QQbyym6QMtulehxKIO0ne4HbO9AbqxKsfP3xsjIvNaiwHQIUUz+s/etjOme7vnbI1RJjo/URa42qvubNYd80NNDRcul2uI0BomiKgzOUshyw4cMc+WAX9aoRI18LD8D8M/kuAW7NYeB4Xb45VNQ68ttl6pVaH1vFJ2fIsEuVf3Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=f2K5nsOq; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=f2K5nsOq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7nYk46KGz2y2T
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 07:43:05 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmmbb1NftZH9qB+rL6NLH+RrECEORrq6121SAM0xk2fgJcGyQONdHWmJC+5+EsQkmyKcLqBxcbsjWriwkYZVXX7ITDny4eepMqEhYOUuNCKBDs7H5M55e8cU/e6HuZkb3NRRGKCLaC0i6/Jsc+LhLwicARZf0dXT0q0ewOF+LeElzKqvBnGGrv+h423o9JGe5iRGn4xorVuqpjutWsw8LnYG76rutTCKdDvf1bm8T9H8dqYOcdPc153+PZzBJOjCZWgurSpl05fC/r6WPkLurTsKpjPIKCh7BOQX4DtuoNkfbyC0kkTtED8LDpLYoa/h/HH5e7ks3k8p+gbKO+llBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2QjvA/y5Btd8S5rN1Zmuz1Z4m0p5O6mlwHr8eDsAl4=;
 b=kEClOTy0GYfepV6Nv8LPm+2ubQFgVBEvr6UpwiHpL0d4gd1REVPM5GgMqSnYABO5l0hu9JQTviDw/gDtE0M7QRruWPLT6di538Mf/tfVJgDg1gGrhj+Gc4CCMBCymsPWrr3tj4Lt6oZoE0FFUGdaqYEOX9PWl+rOyA6UBNAZKsefT2j9JsAJy3IhhvOS7NVwiu50DRNGlmvfyntmW7TTfJB5MgZjN5yT2PpUWSIGs7GUXJGwLuBepgk/FfcifFrgsDbPXhSZ4PyxNyyN588WsfcA5gwX2bnRPdyCKS7kEGjfAl1PV/qBbeXD2FldxShF/E+wDSSZ95OBJoX+05r5Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2QjvA/y5Btd8S5rN1Zmuz1Z4m0p5O6mlwHr8eDsAl4=;
 b=f2K5nsOqy/GZwC1cP65AU3cDNkT5E5oN4uIM3M67BUipHY0K0afjqwUb4L7OFYYWnJRp/7By0793HiIaPK6OHeV23Z3A2atuqsxw2i9QI3tGCyK1WyFKc5JQRmBpuvpHIj6KJnZoaoL4ALvPqeoipzTXD33q9m5sZT1evyjTe/ZJRvxC453ZsufMinAX7cQnxV2ijo3pVeSYD56/ocXvmOBYZs5ym+iFNJzYbKccVEfkpy4aZg35tixWoFV+Eqn9oeilGHzKUWVkn7K79z83qRiDRRiUg2raYJ9FnIDaTrq+PZvoucAw8LIjy6JrCdX0UCeKL5yOryxCsgD0BTg3vw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by MMZPR04MB387749.eurprd04.prod.outlook.com (2603:10a6:190:4f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 20:42:40 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 20:42:40 +0000
Date: Mon, 19 Oct 2026 15:42:29 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Chancel Liu <chancel.liu@oss.nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Chancel Liu <chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: imx-pcm-rpmsg: Flush pending work in hw_free
Message-ID: <ataAteh8BJKbhyOV@SMW015318>
References: <20261019-b4-imx-pcm-rpmsg-concurrent-v1-1-c1fb8c33f4db@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-b4-imx-pcm-rpmsg-concurrent-v1-1-c1fb8c33f4db@nxp.com>
X-ClientProxiedBy: PH0PR07CA0074.namprd07.prod.outlook.com
 (2603:10b6:510:f::19) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|MMZPR04MB387749:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e18ae2-ffb4-4414-a6c8-08df2e218486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|19092799006|23010399003|1800799024|261009223027099003|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	rYwNi/H6s8/CZGOutrW3XXPmCaHvVlBiTruMS1Cyg1PIVNhOyVEiRLAn03cy5ln0hR2AsNitn1XL8eLJwqVHgxP2xJxObAfH6n2ZODUW7e1qlLnoe+p6bqFjeWdP6PLYXUboJvSpBIYUZzk72qFuBUzMa6ezmwFZJIudqRWQ9jt0uc61DVPO1zHjVpxPyMWGSWeR3Rs0FiW+FndSzGIilgjOvx/63uW7MTq7DPGh7eDj+FcTAZF+aYcdppFRDOxvZr8rW++b/B+LyFVgB+1u1tNJ5OD4P3oazvQALqOhf4mu/SaSMSPtEEUBRcIg3ifbmKB2PdxVX9JFfeD78IOOAlIgetTqCWCViMiMGnZ8l9+x5fZwKRB0bJ/CA+J0u3i80yhAWV5Lxv9fXQVex64zAW3+amN5OWdBZ6n08fs7QjVpusSROXoNm0x/mV3Yc3gNjh7oP2ibY6+An3pYSrospvSZgtMyyefPW+5pNbX961KNDnt2T7IhL9H0KELKfD8iqE/RKAbJ6z8BuihrOv2bDrKfErE3u4idx47/OIfyGQotLSmkUBvxQao87Brq7eYLQdI6C0JZ4kHwMYpHY0vYJbumb9FGY4WrnwG870yn9aAy7lRqrv29kBBQkm87JqOph1xuqPDvUi+A38fi0UXPAfihf17+I0S69PyB3gslEZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(23010399003)(1800799024)(261009223027099003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kCHzq4ZW/9uyo+57UF8DADhoyovtwxebcYmsd7AeSjlsr9BgpILXjHwQnW1c?=
 =?us-ascii?Q?cljvIiv/2UWGhhKwUVPh6wpN+gYgoEIHu8XlxBGHdGMQXg4NxI+3w8adQKhA?=
 =?us-ascii?Q?pqCnZYsZRtuUG9hWaURSiJILwIqM4TK+UeCZ111562/suKSaak8BRiBhq3XW?=
 =?us-ascii?Q?Eg7RI1KDr15ZIs42mzP5S+LFeWkWTn9hx1m9yS6IYd1bMolfHJFC9R9qKhrF?=
 =?us-ascii?Q?yuZPNQSVBPNS9tW28PS8YgXsDzm95mqZUFh1bGHv+St4EKwTSbnzpONMHFu1?=
 =?us-ascii?Q?627SBoChOt7p0TuzKjK0S0FlHXR67KBM16oYxACMs8yibYcLUlE3+gRmuiVk?=
 =?us-ascii?Q?ov295IlkrScreOX/771bEkNDyRxQAWkT6XeWNHoCKA1cT9nJTfXzSFjTrz1A?=
 =?us-ascii?Q?fYVwJYEbmy0X6nK/bmILI5BsB81YWFkG6zqCtaoWW/mDUxUv9efE5yeYa8Hz?=
 =?us-ascii?Q?ez2mxi1oeXo2tHm4R/wNAlpbzq6PXij2kBhitEt+iu1JTIz1F7gdis7WVDwV?=
 =?us-ascii?Q?eD1Q46hluf70S54YC/F5znaUOJf06WeqojjfEHFDGr620z534nS4At6aCdrN?=
 =?us-ascii?Q?mpeYiTm/CUPX8Z6CShEk/SAfodPLAEPhndrpH80A9myKsl2LROKVwE7mEgMw?=
 =?us-ascii?Q?xwdwyxlH0fkdW7ibjsg3tv7cSB+Vodf7i7QtlSZrdcFg/tc55CISq0ohjkzM?=
 =?us-ascii?Q?PTqQ0nCrH9iOSdfzyJVTWqylI1iAOTkjoN/I1IPFI+mDRQtXa4Gyx1irlBT4?=
 =?us-ascii?Q?B50I4C8CEDA0omrKjoIr1FaZOF6kIPMuC2B9eAJF8wyqApdmLc2ECHQcE3Ol?=
 =?us-ascii?Q?n6bT1khh1KQYJeGVgZpqbteO1TF+Kl8XBDx8I5TxtTAQpljUlJ0UzzNJPEN7?=
 =?us-ascii?Q?ECs4MT6NSFfVHysHfPWyC3CVOxVO6Gl3QM+aL2X77uQcF9US/ExH7t/vzRFc?=
 =?us-ascii?Q?TQjcWhnTYeUMxkl1X5GD0uThef7N5HpMz+nQVVErMdZmcXNq4o8ql/1JVDmW?=
 =?us-ascii?Q?qpOvmAWkWPZl58CyzVGvd/M9YTGu5eWQEcD44s7ZsF0UWX8VwlE7ly00Qg5z?=
 =?us-ascii?Q?KuErMCDhTvxH5oX25HG+NE2BSSUNwh+VQ8ry1MBy4pmIvf0oTK3nDAeS6kmL?=
 =?us-ascii?Q?3FZu3wdFrUzEMd74SjH7QbmIqyj6ZOy8amTvEjOK+vpQQ2A23yg6tmBM6Kvl?=
 =?us-ascii?Q?m7dx5XxG5QjiP9lVGo/rWIzBdDIpISgHD3iGpb4ZHuQg9pOCPWzdx9oSBcrw?=
 =?us-ascii?Q?zjrDmTraZ8kkswFiC4ujApURRIIDfNkEVoR+4RT3w4X1jTAS5r+Ivozfwoyf?=
 =?us-ascii?Q?bvcReCEIX8c+NyQ5qkY1mwn81cyK3qVRnzvsbXXFT6fp1YPsQavgua9TPLCV?=
 =?us-ascii?Q?VDWP/j2TnY66q3gVDXbZNO3f/Kmx2/wMbJVOyhm3AalXwkwZAScoAzLqzXxQ?=
 =?us-ascii?Q?zEi470GEd6MpN8dFiAZh5ZqrqcjexIJvNIT8U7qglK8nxUCX/rSSor1CkjLt?=
 =?us-ascii?Q?tyiwfy7MGStU5eldH1fgk1xfY9t/TqCT2GHXhoqseyWa/EcwzJZg9cdnK+zb?=
 =?us-ascii?Q?ye/DNv8X5d4vduuYBlJNDlrGUMmsu5BqWL+IgeciRR1d3JoBoGtXLLgIKx2P?=
 =?us-ascii?Q?ox5pfLvcbiy2+XF0nYZiUGPmjkZ3eJKRVGqI+GaBX3M5e1F1C1WYyH918cbn?=
 =?us-ascii?Q?PE48Qxh7BEFnbQqbFHOZ0v74MBMsMnHSq1vGi84kDKtOq2pOwpiPAIKYfk0W?=
 =?us-ascii?Q?j1Uts3Z0gBDJgqxS/WN1yujNL0dAAaVjWtSXLSDi57GMg0l3uM/b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e18ae2-ffb4-4414-a6c8-08df2e218486
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:42:40.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqEe2eVFqjATHMCx8ifVXah1qDz7DO4YpB1qf9gjhiqgXm/KjM/18HBdjMCm4a51HVhveCApipP/mfZxRojyH9HLuBjDY+ylgDBvw/JTSM5fkSk6lHRHYJJXAbvWN+Vx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB387749
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 03:58:20PM +0900, Chancel Liu wrote:
> From: Chancel Liu <chancel.liu@nxp.com>
>
> imx_rpmsg_terminate_all() queues the TERMINATE message to the workqueue
> and returns, while the DAI hw_free() synchronously gates the audio
> clock. The two can then run concurrently, and this concurrent access to
> the shared audio clock path can cause a stop failure or even hang the
> system.
>
> Flush the workqueue in a new component hw_free(), which runs before the
> DAI hw_free(), so TERMINATE is fully handled before the clock is gated.
> CLOSE stays the last message.
>
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  sound/soc/fsl/imx-pcm-rpmsg.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
> index 85b7c929a28a..6a0174d6c78d 100644
> --- a/sound/soc/fsl/imx-pcm-rpmsg.c
> +++ b/sound/soc/fsl/imx-pcm-rpmsg.c
> @@ -178,6 +178,16 @@ static int imx_rpmsg_pcm_hw_params(struct snd_soc_component *component,
>  	return 0;
>  }
>
> +static int imx_rpmsg_pcm_hw_free(struct snd_soc_component *component,
> +				 struct snd_pcm_substream *substream)
> +{
> +	struct rpmsg_info *info = dev_get_drvdata(component->dev);
> +
> +	flush_workqueue(info->rpmsg_wq);
> +
> +	return 0;
> +}
> +
>  static snd_pcm_uframes_t imx_rpmsg_pcm_pointer(struct snd_soc_component *component,
>  					       struct snd_pcm_substream *substream)
>  {
> @@ -285,9 +295,6 @@ static int imx_rpmsg_pcm_close(struct snd_soc_component *component,
>  	struct rpmsg_info *info = dev_get_drvdata(component->dev);
>  	struct rpmsg_msg *msg;
>
> -	/* Flush work in workqueue to make TX_CLOSE is the last message */
> -	flush_workqueue(info->rpmsg_wq);
> -
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>  		msg = &info->msg[TX_CLOSE];
>  		msg->s_msg.header.cmd = TX_CLOSE;
> @@ -624,6 +631,7 @@ static const struct snd_soc_component_driver imx_rpmsg_soc_component = {
>  	.open		= imx_rpmsg_pcm_open,
>  	.close		= imx_rpmsg_pcm_close,
>  	.hw_params	= imx_rpmsg_pcm_hw_params,
> +	.hw_free	= imx_rpmsg_pcm_hw_free,
>  	.trigger	= imx_rpmsg_pcm_trigger,
>  	.pointer	= imx_rpmsg_pcm_pointer,
>  	.ack		= imx_rpmsg_pcm_ack,
>
> ---
> base-commit: 8d00cfd77ffa64477129969eec8249c8cdadc9c2
> change-id: 20261019-b4-imx-pcm-rpmsg-concurrent-1522959ba768
>
> Best regards,
> --
> Chancel Liu <chancel.liu@nxp.com>
>
>

