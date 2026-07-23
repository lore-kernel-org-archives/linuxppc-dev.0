Return-Path: <linuxppc-dev+bounces-24743-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F327C531D1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 15:01:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Z8K2t2Gz2yhD;
	Fri, 24 Jul 2026 01:01:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784818897;
	cv=pass; b=D1aDte5B0KmqZIfYWaioF+8KVGl179OKAuN5Zc3CzL+Pspq4TIx39jK84fV6NnHijU1pjhjpf7kM9Oe7Sy86Hku8fYb9A/D68GLkMxHfgqckA7bZGR7teRT9Jxj4oCH1Ge86yCzMDQZKKBtHMa7Ni7FN830tDRuyK/jGKjuaFo0EiP7sZI/fFQbjDDSWCFKqhTt7T0u65BnBIqAIyNQlDkYX8O15f+nQvw4zNYFj4CbBFF84Y8yp6TL51nCjIrijbRH+hOabVWtx7rzbbvGzzTkwqJrRhIQR2DS5bqeWM+cCaNu5piDdqLeBdfEGCiO4x7gPLLZ4SwmolvGV+TSWQw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784818897; c=relaxed/relaxed;
	bh=Su8mcUR9YFhnTPYPiJSIa/mrW/RVdPNcEzgnPNm8aCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R6UWwk7glkmbPk8ycDY9EpmHzLAixNBShXYANR1p7lhbwerbFIuigv30ZfmpMU7kicXeGDe6AIR8zVQPVtH2lZ06V5B6S5RHsW8wLe3TI4//oIYc215QqVqWY6Ts2p1h1onPknnmw+Dy94tgkKDBYaS3AvFcQ9s96z5V818P/OLOOr1RXXn3qF6f28e/VAejD3z3EJPKR26s/c8/NPloymATJ+bx+XhRUMW7CKKE+1r1o2XJEJUUoVP9omE8iglmMT6iw01lphR7eK9TYfVRJXUI5QPQiieGjU4TwvcnwSu+eCumpLV8WuJ3c5TraV1kzeOml2KWvo1riMPmpZa7Lw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TIzgtQKs; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TIzgtQKs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Z8H4RFLz2ygt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 01:01:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tnq3a2JCPS63oW+hvR5LA0/bvgXBEAYDcsVKkAq0z+CjLR81HG32xKMv8VhGiY1zGnpRiGzQWEKi8aUK8oJ++zkdj7C37GIwpLY3f96gAauFW8YtzIr0lFG2qGp4Yrx3PlGLN6IJa01QYDzkeNzg/BfK9hnkCmClCp8CslL+E0geSSP0a9CgHiwmDOgAvpq67Qrp3edm8b9CmokTZyj88F8QgGFUh+JX2RhkM04WpjhsLnCS1Sb/DbXNF8CpWxPamW2x/+sdAMKce/8/zoneVpYZjYKhmpSWfN2VOwbYtYqgww4NShaup1uFPdby2gMEja60y3rsnj7yQRnvAeWBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su8mcUR9YFhnTPYPiJSIa/mrW/RVdPNcEzgnPNm8aCU=;
 b=iujKGYxDCLz529LUzzFjxrFBrkATXYhgTgBHPgIqMHqotJOE5PYo52GHnfxZgPV9wDGT2zAki1Azp2bJ9O3vNG+IWtI9Hx6/02EBvXiwm7/eZIgq4VQ0tYoobWNvH2hhckF/VbNct02ULv0ENW03pBqIyRdw0Znyve5/TXglhv0Y+BM4/+shs80gmRubSNPNgKKobmu1obXATxccEM8uke4FmSJJIUc1Dnn9MaID9CGQJGB31DmUXrCdmEeEFo7CJZAiveAQwVH0SxOVKVrxKpA/hfljfAe452VwOe6jHut5SGKAuHXOref5aGhix/lUzBiCUclzrohdDQgrsvpZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su8mcUR9YFhnTPYPiJSIa/mrW/RVdPNcEzgnPNm8aCU=;
 b=TIzgtQKs0LkLsIRLcdYfAjkTjK3AH7Y/TrkJGKTiwJpYbIk52lJ35hIOarU7FHc9N9TW03iK+Z2oA98WSsiMoZzrCPwMRezSewc40iwON569XjnDTk8qPSS4CQ8TnqBRupOdgXWD16HtU14WhzXd1/v1BkgDSvk1pHT84yILJO90ytCFO8fmixyWNiek3sX4/GhXXBvkdZSkB0E4Ox5pnO4+qZxFCMlcAYKXd6NKkGcTVt2pxKM56XRHDGl4FKLveNX2iEnMHvCvUMHkrEggiARVz64sEgYUw5y1FWk6gSuIkgVIsY1umF4727WB7BVpEvNOEUlusScimMBF2LQICQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM0PR04MB7011.eurprd04.prod.outlook.com (2603:10a6:208:193::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:01:10 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:01:09 +0000
Date: Thu, 23 Jul 2026 18:01:05 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	Michael Walle <mwalle@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 phy-next 0/9] RCW override for 10G Lynx dynamic
 protocol reconfiguration
Message-ID: <20260723150105.da2cqgtb7t5vw2d3@skbuf>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721231603.67865-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: WA1P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::24) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AM0PR04MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c90f67-e9f9-4ac1-6150-08dee8cb3a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|10070799003|23010399003|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	TUoR9Sjer26d2HB3+x+Dv4zOk0dZPP8MguT+nPSM1Faoz/4s+W98iKfE0Tnb9ho9FW9bN2einzEciZOElIREMTDQuyzJdP/vJ0J5N4w91Ryh1UmuH5rOpDK31G1h6bAY3+X8vRLDj3/6T+4jpqjtWGM7qV6bqup7NawMoBWsqyCcBrv6qSM5XvUnatkD2GhJ5MKuZ1zj/080PT4ha08BOn+JhzQED0r7pXZnmNKdQOA8n20LIwrNZCUoDla6AkHh5nqF3iZyDpIuYQ+dTkPAdhFw+uVfEfxJDI8Z7qm+/5NFm4tNNVwwr2jmt4Xz1YC6+isRydbpVTDEGq6UTFqa34EDLvyN9nqAmjT1Z2obYTS8P1wqsnWAr5DVWAstFo4+4CMXa1Ihax6QjB5tyIg+aS0SwtvD0VbyFnK9Q2iYJBVkVzAlNhov+y3yGiQQp4d+pOushvpPkOH0ClCfYHKIe1BPcboYnfTMkGamsi8ZWxFddl8XUeEb24k+nZkPB0F8OOUgG6NNO0+eHFJiqYSxkUQPiqaC4jW/GlQSbXcRdJKXP/t5WZYh5xsmlihAU6OtL4XE6dbTz7dZqocuD+f2a+2MHoW1c5z5AWv1+Ft93TCyKkxnufTXMz2yPVd9s0TgEB7wCKf78qi8SFcx6sydMuIg481pAMke/bAAe0uG/1Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(10070799003)(23010399003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5zgYoT2K+4IswEkzDcL60ppXNn4eKvLQ5oGrVwLopS28cEclym83w8KMGtxE?=
 =?us-ascii?Q?bqW6zt7aBoKrjthCS/T6zCfp6+henwe8dcTiilb6mOzdXt+G5go6oKG++WRS?=
 =?us-ascii?Q?awxwstOmbdJQqqrS7UVYrhCGEw79SN+DAlNWXvFaK1EMGFCrMY8VsBgTE+Nk?=
 =?us-ascii?Q?uwo1jcT4CoEi2kfrx9Uz9WM3FG87UEJVdF4OY995gXaTZgxJ5A3GUViXyJ5H?=
 =?us-ascii?Q?jgypp4oVFpzG/5YtD3rvMUlHhwTv8Gn6uelJrtBNdaC2eKvKnhX9B305ps0N?=
 =?us-ascii?Q?1Rz30BD3tuFs7nQn8RSG/KVJbdA643JU36dIIp/1v4mDKdAuRm+7k9XpgHKZ?=
 =?us-ascii?Q?90rJoeAUhMGuxgn3oNPQ7NV4+TKF7XItHQsO4ew0QVf1pa5POJLx7sauDpiQ?=
 =?us-ascii?Q?cMQOV3mUR+Yw3egSxxlElp4rcHRRj6S0KJQ022Llpggu7U/lpmrnFeyfQ+or?=
 =?us-ascii?Q?obw0x+DwCxVNq4xM0jDzh3Ppi2Fx0MJ6qQRbaHtIDxgeJu9Lgxo7KwO21/YC?=
 =?us-ascii?Q?beB3jpMfn+HlOZ8BmStcXlerj+jf3MpAQgVeJyAOT+UpFTHnqbZOgf5ZiK+7?=
 =?us-ascii?Q?fDPFzTAnnAmNs5XkR+jNXl0Mq19sERcVPzwpLlTHF984QGlLzx9vlIcxqayu?=
 =?us-ascii?Q?yNmt+lfwILrJI2AiuMpVUkKBiuZ5urbE+19gIAQY615JE6U/GtlkqSdJYbyx?=
 =?us-ascii?Q?pBb3du8XhiHGbs+9nyodqMMiax9tBhfw7WGieaksMhd5ifd8tvEgt0QHNnb5?=
 =?us-ascii?Q?JroYcwsA5p9DhAqhvy047k5KUCXvY3nKi/r14cvfHbNOAycwcKBjwhIiBpH5?=
 =?us-ascii?Q?QUoVyKLHJwmGwtjvhfsAmYucDSMYLIs37cLLr2aQdO3phw6iZAJe+hXa38qR?=
 =?us-ascii?Q?+DOc3mvrcMskjxNGWYDf8VscYxaNvNmWeXl23Mg7JhFGli2Gf8QiVsYMqaS9?=
 =?us-ascii?Q?MOksu8GB/qG8d92J5bnf0Q41LMAXCIkx/ZO9o972aIFD3VqmrMaP30bylUer?=
 =?us-ascii?Q?l/NLbse/gN01U0qSjmtICOqoZzuHfZAqnmue5C+T/+Cv+Rxreg9W9mY+72EP?=
 =?us-ascii?Q?ZgPfDZPg2Ii+R+eQDWhq9zvSsQEVILUhoDeVMHN1ghD2gW02DhECmmSGKoOi?=
 =?us-ascii?Q?50+/zpjrkVYbmZZ53u3jp9PJj96NPxwxPcYpw108P+NPRE+URi9UiJALtTTY?=
 =?us-ascii?Q?x2ldvJT6QKnN5EBWwdP6CuDKE9ARiZ4esmUQDBXLj5Mn3PiEc1vFk63/ZlAb?=
 =?us-ascii?Q?DurgvzAUaC/J+09DWe2nUH8w//LffPw+jlvTglj27uU8aMNRlxsBiBk/gMuk?=
 =?us-ascii?Q?QK8QIa0DSQh7XGp6Qt5wSzBG3cySVsZQbyHPz3yFWGrLMauDCJ3oQuWabjRW?=
 =?us-ascii?Q?nk4t1IgyR/93PfQIzm7xq+P8sDBV7bwldmKq/ko0aad/kU1u7Oh6278GHSnx?=
 =?us-ascii?Q?KCAsHoqV+TfKTrazNOU0wmLm0IoOJyg9iN1KYcAinwQXFQzbOM8Q/0diNG0A?=
 =?us-ascii?Q?3UkJAGvibtTGmsvFJZqgsfpq5b07j5XOFjF9B7bsEfCP0Zl5lwdQvW5OF1pU?=
 =?us-ascii?Q?X0Xb2SkEKExoM9/VJ1bSNogKgA+ldI+Xxh6jL9toe1vfT/hv7bPSmpsCv4qf?=
 =?us-ascii?Q?DdJtqaq48n0WbgtLsqYTE2d/MldKfEugsy46mHY/9UPvM+fdsrvjNi6bsz90?=
 =?us-ascii?Q?i64bXvQfQoqdpne969lsTCtnbqEZkRP0hQonHOR2ND2p9WSVeBHDLxtQx6xg?=
 =?us-ascii?Q?5Y4+SIyGOPffBZlqwPl2LlmrppxjnGtcxwrHb3X2Cf4tHxTk1ZrgtjZKKMoh?=
X-MS-Exchange-AntiSpam-MessageData-1: GYl9YVPciE/VPXuv0qA1uQz4zlqKgCFOpTQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c90f67-e9f9-4ac1-6150-08dee8cb3a64
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:01:09.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7if4pV/YghCoEv97r3NyphLfngKVS1mNg/E14U1M/mrSwf1oxtjgrD/j3gtp9ET4sWrTlzKEIjDV1Jwcn78MMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7011

On Wed, Jul 22, 2026 at 02:15:54AM +0300, Vladimir Oltean wrote:
> Ioana Ciornei (4):
>   soc: fsl: guts: use a macro to encode the DCFG CCSR space
>   soc: fsl: guts: add a global structure to hold state
>   soc: fsl: guts: add a central fsl_guts_read() function
>   soc: fsl: guts: make it easier to determine on which SoC we are
>     running
> 
> Vladimir Oltean (5):
>   soc: fsl: guts: perform fsl_guts_init() error teardown in reverse
>     order of setup
>   soc: fsl: guts: make fsl_soc_data available after fsl_guts_init()
>   dt-bindings: fsl: layerscape-dcfg: define DCFG_DCSR region
>   soc: fsl: guts: implement the RCW override procedure
>   phy: lynx-10g: use RCW override procedure for dynamic protocol change

Even though I intended these changes for linux-phy (they are also
build-tested there), I'm fine either with these changes taken through
Vinod's tree with Christophe's ACK for patches 1-8, or through
Christophe's tree with Vinod's ACK for patch 9, really.

I see on Patchwork there's a minor issue in the commit message of patch 3/9:
https://patchwork.kernel.org/project/linux-phy/patch/20260721231603.67865-4-vladimir.oltean@nxp.com/
"WARNING: 'struture' may be misspelled - perhaps 'structure'?"

Could this be fixed up while applying, if there is no other feedback?

