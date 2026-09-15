Return-Path: <linuxppc-dev+bounces-27427-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFDAC88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 14:03:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkkJX45r6z2xlZ;
	Wed, 16 Sep 2026 00:03:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789481020;
	cv=pass; b=D+vCHj+fES6R93NoRoDIC4CM5fQ3+Kb7ifmQIy0QcyTwWGOTCKNJ22QswyMq+Kmbv1KGxkeKyiA2z5QmxOz2AEHQ6nqzZ0VKh+qOzUSrD72oa4J5wpCYGa8wBPvA7kOf7sliy53o0kd8/k+enpJ/QcLqrGFZ71ldAadNC8Ist07nOFzoiF/40i5wgf5dNouW1f/hqn7PBv4bbmQqmv7i58ONgbXkuEvlOjKOtbWBAaBu1a7pB1roERQqWKx3sl5+VVgZJeTOuujbxHHNFMPYoR5YKJs75zwOwVhZYBDB8j5hvoRxlqD/zfwrpNNzZHkmBNIy9cPlprifUUEmDsmR/A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789481020; c=relaxed/relaxed;
	bh=aLXEl3KfzsbufszMDvYBahI4QY00DKf4jPSPzuCxubA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OAAzLtSZHQno07AksMKGI48rYaL3EZyGAjT8s/EYlqfOuQhlY3p+QuHYitGgGMYhNd0MolLARyuH/Mj/fbqElNrT8EmNCP7HzH3bLX0Q0mMJzNHdkXwPeU4wiLg/ShXyPtTrdZehQCIDszuA1LsEuX4H/fJLwn+a0+WAFit2sAJaNsTmtyYiJNXLTgkT/mnFiahEv9WnuIAKf7cI4aFA7vW9QUgNrLvf/8iQTEue9o+gy3eyGyuXAEWxx+tUEVQnNmsdPZAbHKPg+UdMQW0np7e/+01ER72//POSwC8QODQ2dUWtaFDxcbMAIdIEZhZWg+LdEHv0EiY1Rm9LIGRUVQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FoJlFx9u; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FoJlFx9u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkkJW1NMQz2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 00:03:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=da5fGi6ZjhFDi1zxLHv8VR8EwY5mmc+l6QiB3SgfzLzFdLJjDonSwxq48FlgOo2+HS5CM5fU9j/utoVP4Y6I/XlD26wNxXsUfybDGQ2LxGxagLj0FJGigI1P0CaN/4ZIwo7InnUZEbXUU8mJYDiX3YDBy9LSFD0imwCS0aSON9ka4f08MLveKMhA0fPD65Sh2YgxFB8GQ01WgPGumhW8v1nEOIFyeXpXyLQtvvOJ3GZbAd/TNJWkMyxEOH7ES3QhezWG90mOikqgzVlQDscPakCw7pxkbwVIMwbrI6LH2AvB9CkKt/QDMRIQcydj/dip41sszbzljs6b2eqcdO2zQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLXEl3KfzsbufszMDvYBahI4QY00DKf4jPSPzuCxubA=;
 b=e1yrKtc4+PZNAiPw2tVEtDcE85X/QASqLGWQyQGt1wMAlyQ0rq/h8dLCoI3GUnMPlPqrWq/z244Z7Yuw5qLyffZvYuPAwwE7cEGDpx6V9GYATDsPplvPlM3YEWMcfS2P4xNnolEGLvX3AnOPM9Lr2OSilnvLoVwvd/5W9R5nTFQ7Ft/dKkPvF7RvCKpzns/GkIQ8WdJBVTXhuM8y1gNWW2HkjPnmqnG1onGE6fxyD5WUvbUp+2/H8ZHinyF8odbhIeDDHykREPyFup9w5yLy3VTPdQBt1gapMVifEAL1yogyP9MPGpi1l8L91GkcUs6yzyZf9qzJvW8wQR+yrvD/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLXEl3KfzsbufszMDvYBahI4QY00DKf4jPSPzuCxubA=;
 b=FoJlFx9ur1p1xl7SUwnzRHCBujgcnTQRSRSuY5NfvzkP8fZ9YobhzwXpdPwuWJH59XL/Fycn4ZOB6e+IZa20e91OqNiilxi4b6d2w3z2uR9MNnZLJz8qKyKBLCquv/HnzIMJ+zeveXS1yt1afl4FsdGLTRMZFAlCRYy4clohMIVGrPFjFkKMxAXWYjTtnK7I3zuAWiSfPz2dklUh+po4y9zpb0vBmJRY2jsj4xcXPF24c+aIOIorTiAbwPL6FshwCzS9rYajmmddrqiGarPdgxQbF5SM/SkBRTCEtVMLyv7HzH+vFfoegxcxzUpskQON1iJgI4SpsSobzE96kkc8eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB9188.eurprd04.prod.outlook.com (2603:10a6:102:222::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 14:03:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 14:03:13 +0000
Date: Tue, 15 Sep 2026 09:02:59 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Tianchu Chen <flynnnchen@tencent.com>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v1 5/7] ASoC: fsl_asrc: Replace
 dma_request_slave_channel() by dma_request_chan()
Message-ID: <aqlQEw57-XJavFBL@SMW015318>
References: <20260915100931.3593242-1-andriy.shevchenko@linux.intel.com>
 <20260915100931.3593242-6-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915100931.3593242-6-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: PH7PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:510:339::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 683630a8-0cea-4ed7-bcd9-08df133214fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|19092799006|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|3023799007|41080700001;
X-Microsoft-Antispam-Message-Info:
	FdWzMnBCti1pDumiRo+0OAsB7/S8ZJNTIoacvaJaAXgrx5e6mdmGTrHb1dnsoRDcKg4TZyLgk2vtGMGWGTwoBbWflr76cUQlOMw3mhuVs6g19qlYy3trREcx3CFvUPB4R9VNOsdeq5lk40Zr28hwSf3Pk5Y5+vEOsjUDoU65sKt+Dk1bF9T0PMYcm18GaTFwb42SUeFRQz+oY9nj2IWEfkG3Tz8DUYIF/vBznBoEksCKIkv0tZFuSY1vLWOo37bFnr0wE8nvguahpGwe8a/MV20mQbCPn6DsXpCL1H/TBdMWWuIWxXvNR7oLbP9nwQPStY4cNTXIotK9Hh8cFurMokzWwjGlIdGwPJM67jORH2XEineHCe/kVR1obO+PY0P+VakUR4X1o+1R3H+djG6IoGUvzkTwxYl8V8j/HfAkbtOiQGvW/jUy4d8fOOpjmfYIEgmSkqrTqgEcCSbzk43aV+HYrLnATA0IfpqVFBC3T2ydp8KeqTcUAdGcKvuUTcbxwdLi332BsYkrCcl9O6sCfuS9Ua0gB6GK2gtvjVzQPYdMETtttxEqFk3F9EIw4GHGCMriIlE/dpPPqS82vw6awqnzCJSrGhkqIH4xdOL34ZiAfKJ8dbTUjQxHD8B1lf0aW1itU2dr5vDXkWwyQa/R1sUl/g/SaK0wDX3hcN1sqP/w0SjjyHc/CidyB6XQzttgqmLqK6AJFdJjiT54EHGzGOqeRFmE2sGkz9PnMCuIkEk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(19092799006)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fh/qODXiSERrqngd/vloP8bIDBHmMr597hhFYo0/nhyxLlC6BDfxh9oE3AUi?=
 =?us-ascii?Q?f2q84DORJTFdHm9AjxpMqk5ADyg7GbrXRnNG6s8LPhyOnXVcgZMT7wyXUrwO?=
 =?us-ascii?Q?vPgrk8qOWrNCeyz3/sAnftc++NJYToQ40kT4AD6i/PX6CeCNhC2KSzBm9yMP?=
 =?us-ascii?Q?5bua3A/nltPRtkdr/pEV3KYgYlVSO+OLtZGBOKXyHI/03295jDd9F+a6qEpb?=
 =?us-ascii?Q?028okFCBXs1HAqCct+Y45jBkR90MmXyLAKuF57jicdbEkDQXJxf2ibpcgb+g?=
 =?us-ascii?Q?BuLpCX94TcXvXbTIVlgwa/DHzA7zZX/IaC9VpFFBDDKG4i84JwO/PrMBSqt1?=
 =?us-ascii?Q?zhbPbIncqEdW/6Tk/9+NW3Ie+0dRuIoKLoKu0bzglUPxXZssNNxqaYNxSuW4?=
 =?us-ascii?Q?73eaaaS/Ny1wwDzuk7/CO0xCXkrNCTCoFOxx+4iStSBG45UebIJhoJfcbVIb?=
 =?us-ascii?Q?MmsBetalASKbw8U+DZRgXgg7b2/VwHKTlXNGhjK8VENMkfQkmkAmctifOONH?=
 =?us-ascii?Q?QNmVv770X3WRFgNE+/3N0OovHJswaXryYJzoXB3WTmE8eG+iCN4KzH2Q0l7w?=
 =?us-ascii?Q?JOcaMoZhaY277h2HPV+cHFeNpqQAkcFka4T5JW2OOzCJUQFNPCE+qNweZ0HH?=
 =?us-ascii?Q?51B5THd0ZBpHAasML9ZoYDM2cTW0C6RwKdJxCGED0mp95/EAZW+eX2hlFMXv?=
 =?us-ascii?Q?07bE2EuzC66twlZYINyOIhVU0qE0ZDWgy2PUYJsII+T5f58HXRC7o1f0o/Ya?=
 =?us-ascii?Q?3QLRNx2mgCwIdS+AurV673CxaOAdVKkRbH9cK3TcyE9tHXr+D1IBr/09N1hm?=
 =?us-ascii?Q?80RdBZQMWlnzuhJAj9iDGdEOMU5SVw3QMZET59hftGl0jQdiD2DsjTBJMAwR?=
 =?us-ascii?Q?oZCHgAHVQk2uChsJbwrIgO+WUFJT/0AvAJYHd4yTDmG00gBpG9CLHnMCS70D?=
 =?us-ascii?Q?JbQWq7ItCBvEAC9baf+R5G0pA3oBqQsPQvuhZ/5KMYgpOi2+W2rIyQB+ISDc?=
 =?us-ascii?Q?34F9E8S7DWy5mgqHElOOFcw2uSwocNC1XkrKrWk3Yh9a9QNKpQrP/zTutofD?=
 =?us-ascii?Q?3SvxoR2b3+ePpu8FfhfHsxYg6MHCODhX0aUzoitg/qDyC6CQcL/7JcEQnndY?=
 =?us-ascii?Q?jUYlUm7JLpzBWpyDEci+U1buQwtwWKl3q4iilovtsFmy5PB4eyxl+skUbllP?=
 =?us-ascii?Q?CXG4X521B0gsyHZgmI0Kk7iO6T0l+mbqozIA3OZQW36Xk4wT5MeNq8HhyJkf?=
 =?us-ascii?Q?DCf1zuaSidOHnV8eDrziUrykfD72sfK2DAbV0eonz4IKzhy9zvdFbz+WRdpk?=
 =?us-ascii?Q?qXXdJGN0mST7CTz8FC+bVc5IuhBWbO9/L+5FZ8B+35T7UkyTfg/SJwFFAv0K?=
 =?us-ascii?Q?tiiNayM5yzbnRCOYqvOaZnDseANmw9BBird+q2RlTP0yBV7ZTZ6C0SNtMhOQ?=
 =?us-ascii?Q?Fd6Dc2AWMxv5Aa2pJ+vBkovMY+NA3wCOgw7mFR6B1z3/vWQAm90xgQw0Somn?=
 =?us-ascii?Q?K88F4irpRbW9v7xAzfQkimgjVh3XxqNbAsz+WIuCIZLTRcXTqUooA/widqES?=
 =?us-ascii?Q?896QQvgTVykbpS5BiFD0GVcAduYlvqi+bhNDXIFm0rX6knD6hB4XRQWXl7b8?=
 =?us-ascii?Q?QVdYD/JqoqoufC20q12FSWSrn0rLsQX6NXHngX8LmTZuGx5aZMhy8KcnoLoe?=
 =?us-ascii?Q?W9qV/LIHpzOwGHKLrT7TDUyEWaQ1VY2hwcfn5gCTMdbnURjJjlWfT6eFsidb?=
 =?us-ascii?Q?1PA0QZLTYdNla7HLRhfubimdHh0Tkmnxeh1h63qMx6ZNSnH5mJXO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683630a8-0cea-4ed7-bcd9-08df133214fd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 14:03:13.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9y+OdqEbgjFh4usmgr+EI2RpnhI2bUnSZdjTLBgmIgI5n8HvP192/tZOS1lIN7uVtp2jKwGVee8Iatf6DFCnhdhf98p/25K/OfNUHvLN7En2g/0g+g9r8XxOLz5CdgLs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9188

On Tue, Sep 15, 2026 at 12:04:26PM +0200, Andy Shevchenko wrote:
> Replace dma_request_slave_channel() by dma_request_chan() as suggested
> since the former is deprecated.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/fsl/fsl_asrc.c     |  2 +-
>  sound/soc/fsl/fsl_asrc_dma.c | 13 +++++++------
>  sound/soc/fsl/fsl_asrc_m2m.c |  8 ++++----
>  sound/soc/fsl/fsl_easrc.c    |  2 +-
>  4 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index b24737add001..ae682bf450f6 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -638,7 +638,7 @@ static struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair,
>
>  	sprintf(name, "%cx%c", dir == IN ? 'r' : 't', index + 'a');
>
> -	return dma_request_slave_channel(&asrc->pdev->dev, name);
> +	return dma_request_chan(&asrc->pdev->dev, name);
>  }
>
>  static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index 2f662bdf14d0..5cd12781c604 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -191,9 +191,10 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
>  	dma_params_fe->maxburst = dma_params_be->maxburst;
>
>  	pair->dma_chan[!dir] = asrc->get_dma_channel(pair, !dir);
> -	if (!pair->dma_chan[!dir]) {
> +	ret = PTR_ERR_OR_ZERO(pair->dma_chan[!dir]);
> +	if (ret) {
>  		dev_err(dev, "failed to request DMA channel\n");
> -		return -EINVAL;
> +		return ret;


It progagate error to caller, it should be okay. I think it'd better
mention at commit message

Frank

>  	}
>
>  	ret = snd_dmaengine_pcm_prepare_slave_config(substream, params, &config_fe);
> @@ -404,9 +405,9 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
>
>  	/* Request a dummy dma channel, which will be released later. */
>  	tmp_chan = asrc->get_dma_channel(pair, dir);
> -	if (!tmp_chan) {
> +	ret = PTR_ERR_OR_ZERO(tmp_chan);
> +	if (ret) {
>  		dev_err(dev, "failed to get dma channel\n");
> -		ret = -EINVAL;
>  		goto dma_chan_err;
>  	}
>
> @@ -497,9 +498,9 @@ static int fsl_asrc_dma_pcm_new(struct snd_soc_component *component,
>
>  	/* Request a dma channel, which will be released later. */
>  	chan = asrc->get_dma_channel(pair, IN);
> -	if (!chan) {
> +	ret = PTR_ERR_OR_ZERO(chan);
> +	if (ret) {
>  		dev_err(dev, "failed to get dma channel\n");
> -		ret = -EINVAL;
>  		goto dma_chan_err;
>  	}
>
> diff --git a/sound/soc/fsl/fsl_asrc_m2m.c b/sound/soc/fsl/fsl_asrc_m2m.c
> index 4bc40f328f58..e440cc083ebb 100644
> --- a/sound/soc/fsl/fsl_asrc_m2m.c
> +++ b/sound/soc/fsl/fsl_asrc_m2m.c
> @@ -503,16 +503,16 @@ static int fsl_asrc_m2m_comp_task_create(struct snd_compr_stream *stream,
>
>  	/* Request dma channels */
>  	pair->dma_chan[IN] = asrc->get_dma_channel(pair, IN);
> -	if (!pair->dma_chan[IN]) {
> +	ret = PTR_ERR_OR_ZERO(pair->dma_chan[IN]);
> +	if (ret) {
>  		dev_err(dev, "[ctx%d] failed to get input DMA channel\n", pair->index);
> -		ret = -EBUSY;
>  		goto err_dma_channel_in;
>  	}
>
>  	pair->dma_chan[OUT] = asrc->get_dma_channel(pair, OUT);
> -	if (!pair->dma_chan[OUT]) {
> +	ret = PTR_ERR_OR_ZERO(pair->dma_chan[OUT]);
> +	if (ret) {
>  		dev_err(dev, "[ctx%d] failed to get output DMA channel\n", pair->index);
> -		ret = -EBUSY;
>  		goto err_dma_channel_out;
>  	}
>
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index aced16d1228a..d30cc3e90215 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -1433,7 +1433,7 @@ static struct dma_chan *fsl_easrc_get_dma_channel(struct fsl_asrc_pair *ctx,
>  	/* Example of dma name: ctx0_rx */
>  	sprintf(name, "ctx%c_%cx", index + '0', dir == IN ? 'r' : 't');
>
> -	return dma_request_slave_channel(&easrc->pdev->dev, name);
> +	return dma_request_chan(&easrc->pdev->dev, name);
>  };
>
>  static const unsigned int easrc_rates[] = {
> --
> 2.50.1
>

