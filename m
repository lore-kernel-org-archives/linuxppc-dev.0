Return-Path: <linuxppc-dev+bounces-29544-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E271FCC6B1C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 03:56:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4vQ52lgRz2yqT;
	Thu, 15 Oct 2026 14:56:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792036589;
	cv=pass; b=CutH+zC75yXLmFc/wMT9hsv0Nt52rnPJFTRIU5F1ZJ80acM3L89C8/HExKdX76DtNJoVwyjt/f1hb5oV39F6iNgRaGdLKy9jcIPnr9qZGhHt4c61CypD42DD3449ES8Xatfm4Lu0pSAGxflpMraUkG1m5qgFv7A4qHk4D+Q601z0wq/UFo8QRrbI0x3vNSn2CBxpeN0se3C8LNad/K9tMmdKT/x5ulkd59vTI1oI+GKm5tI4BRzCfkRMm3/6rktPF0S4uYmWfaXwLTEDuPmC1PxZvF0u+dqSg3enPdfsPdjETmu8aDV/kY0K8LLIkJGIfxSlL7GJQRjL0Da9nqWYBQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792036589; c=relaxed/relaxed;
	bh=FvZz5cOK2QJv/it/kOYOZpRvIxM8j8zz94SAxWAtqLA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=kfMRtlnV5s4NeAMdkGXvD//xXFYvAccbcm49Gm0WzdMTqrMMAgUgCSo5XS4hZ79tHvF99Srh+kR+12hKF24Qne4DxJWzsGvGRD3/D99+nQrTFZuDbDBNfy6jtZl3wCG3kbHPlEIMLklExkNlqqgXmvk9uusATtn7lGJ8U5An5hIvAyc9bQGXKtd1me0YNLpNYgo/R+8vdyaUCAbNfgJus28n+Zxx+DQ5Jm+o6puYwwT8bUSC2dlBMv4RJEnTb9reflbR2+MdJTJAbuEIlyeMAygMCogJSHC6RcvWG0uYHw42knVlVe5vkBjKaEc1gKLkoZUTBiNMaB3y1hz9eh0fLQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=renesas.com; dkim=pass (1024-bit key; unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=nr7jvbZA; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::2; helo=tyvp286cu001.outbound.protection.outlook.com; envelope-from=kuninori.morimoto.gx@renesas.com; receiver=lists.ozlabs.org) smtp.mailfrom=renesas.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=nr7jvbZA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=renesas.com (client-ip=2a01:111:f403:c405::2; helo=tyvp286cu001.outbound.protection.outlook.com; envelope-from=kuninori.morimoto.gx@renesas.com; receiver=lists.ozlabs.org)
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4vQ45b6Dz2y8r
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 14:56:28 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnKnlIvg7VhEt2rqxfuiEIELs+kcPL30GSEnjimht+E6syt5Av/fHLAWANdjrYotfFWAsPt/v4J2yOYkR1aHINdu5DARE5EURBIhsd37tQc+KwJcU6thvFoRKbn0qfkmZMucBKhoI/F3/9lkbGn/iB+thAVHQV/fhtWY1z+RXBcUhxoxCij55whgYPwuU0l5FtNWKye+HIQrlXi26NZcpUyT9sptKaw1MdaWQseYRMsXKhKLqR1ADN9RUHqZoo1NP0l4Dj5NtXunNePXkNtMWHmdH6br4WEaKMIXFRJNpWNoyRHKMg0QMsSmcLWx4h1ujGPrdnwxRzW67iGBC9+gGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvZz5cOK2QJv/it/kOYOZpRvIxM8j8zz94SAxWAtqLA=;
 b=hFl/il1V36MopNG2RQI2qVGElQyN6yT7xkoT6fl/X2ZX64YE1C65EhTi58UF3yr+fFcDcrAF+MrrwlVdtQTUju4ow7BtkoIBpkVgMJsoLSYmWS0oF5jJrlUr6btqYR7YJlR+E7He1Qd7KrnNEDvGfDuQ9o7+qzuoZjgBSzo+94l/C+sUAxY8EuiiK3hDYWBVkCeG/tmSCvVv19EaEHCFnsH7RVTKkMElZKi0aTLdZVh8su6hTFwmsyREVLMnGsQC2GkfUF8b6I/q/Tr02CK2QkdTjxUQrLWliRU0hw1+dlMoLLz33sovG+JplOwL5vxxfVwa5nMs1X4Oqy+W0y5f/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvZz5cOK2QJv/it/kOYOZpRvIxM8j8zz94SAxWAtqLA=;
 b=nr7jvbZAFmZL1Qt3fgWK7DfrZ6ih/k3uMSF6LOR0387baUQuZvp+JB64cy1DqK9OQOljvwb31lmcCY4CL7s2HlqfqOwRsRTEP6Nsz//odK6RgJaluy2kWURrprSu7vXQprZXevC0Y1kTwN25TPllSXyz1xVOYGvIu/9LF7Gb45I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS9PR01MB820914.jpnprd01.prod.outlook.com
 (2603:1096:604:50f::14) by OS3PR01MB6627.jpnprd01.prod.outlook.com
 (2603:1096:604:10d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:56:03 +0000
Received: from OS9PR01MB820914.jpnprd01.prod.outlook.com
 ([fe80::12e4:c507:3730:2294]) by OS9PR01MB820914.jpnprd01.prod.outlook.com
 ([fe80::12e4:c507:3730:2294%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 03:56:03 +0000
Message-ID: <8733u7d3cd.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: phucduc.bui@gmail.com
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	povik+lin@cutebit.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrei Simion <andrei.simion@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kees Cook <kees@kernel.org>,
	Syed Saba Kareem <syed.sabakareem@amd.com>,
	wangdicheng <wangdicheng@kylinos.cn>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Neo Chang <YLCHANG2@nuvoton.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	u.kleine-koenig@baylibre.com,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Md Shofiqul Islam <shofiqtest@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Zain Aboobacker <zainaboobacker33@gmail.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Bo Shen <voice.shen@atmel.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-sound@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	patches@opensource.cirrus.com,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 21/25] ASoC: renesas: msiof: Remove redundant period constraint
In-Reply-To: <20261015014324.5569-22-phucduc.bui@gmail.com>
References: <20261015014324.5569-1-phucduc.bui@gmail.com>
	<20261015014324.5569-22-phucduc.bui@gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/30.2 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 15 Oct 2026 03:56:02 +0000
X-ClientProxiedBy: TYCP286CA0349.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::18) To OS9PR01MB820914.jpnprd01.prod.outlook.com
 (2603:1096:604:50f::14)
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB820914:EE_|OS3PR01MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: cf07033e-9629-4a38-38f6-08df2a703ba9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|52116014|18002099003|22082099003|10067099003|11063799006|4143699003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	Bvb5CO+Dsjg3Lo6MIlIzOJHXzdU1eAbhEoN3UACiWRVtbTrDF3DkW6WjynUvCowhRtsL6L1zPkldLwocUC3qukuHao23aLwiCL4Y2ZgoCchp/3/6m8U0ysKG6RWaxLC46uoOx6lVvKgjhLmoL9z1OyOYUaPjehKrzCGcrr//sIAD+TcWe5RCu1bewXgRfUq87UlGalTtOfA3RR8WEDdtBfjSeqdsfqX9EytMRtPzzkdpK1oWGtd2eIZrVVQmQpr7kACkk0+VLInRqipgaV9cYOGI8+41V6hrN4o8E35pMyAF2COvtRPcbhhP8WCAY25WbHw0HgdQ9yMIP17jUoUPasq1Bltbh3z60YLCR6EVGsk7uTLWDMFOVLuYKWNbtYT809DK+mRpKv5Ob1FkvQyfuA5EhxMDf959OO5pIhYKSBz9tqaa1odJlsixYXGO7NJ1ELNb0Xwn1X1oj9QLH8fwqR7LuRWjXbffwcCaNK04WgIz+jqQa+7+9zgKPU6uW6AbRJTkafaweNaEPIrpNZEb7rJ0mFFKLEI9Arrike8qHe7B0KSdEVwnbR20esgKZKAdO24P9udwDCaqBVXAxzlzNKsIUQ6+eFNc9GN99SfAs98vFc6VMmyMQfLlHWyatdpZ3YS30KoY9MEJ4McEIiaXDAuCjAh9nC3CqEOa7PyeO4wW+TWpox3Z0//4uGcnginBjhUIpedZaqblcd6+GedzhMZIVvpjs8ZIfm23Onah9l4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB820914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(52116014)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nO6DMYyAfqYcD9dkNp4NjBzUPAdr6oQqlSW+DsAwVrolkXEW65ulgg2Prr0V?=
 =?us-ascii?Q?M8FNJu6JumXt9mzXQei106ayUCqIVp9Oncgk84N7iR9jDt7QYRdLxhaKLDAa?=
 =?us-ascii?Q?3xf+GmTDyzG4GEWihgaAKt0Tii6mdfKsEYIo/uTXfi6K93D9nrFwOxgyB9NZ?=
 =?us-ascii?Q?x8ZuzgpPHdIBEOKF/SoGRELgPJkuq/1ctdSOGy/cFW0OfyOsLC5Ktv6y0ull?=
 =?us-ascii?Q?xf5JX0u0tDQtmtlORe2ifyPPWMpxmPED20tm69uFbSyRHUgk0srv2eFO6A0S?=
 =?us-ascii?Q?lwkH1njT0Cqu+aLErpEDj1VUKVl6svftdLIM7t9oNHFiDJTAJgdB16qmmKea?=
 =?us-ascii?Q?IEoQnCDty/iUXhhOKmoTmYKGbYqPaG6LwWGGC+1rzOFUPwytldk40tNUkV2x?=
 =?us-ascii?Q?aQKoVQUWIRhBOW++tONWid/N2HquAiw1tfJm2gcYqQmP/bQ9Huyv+UQ0Ttjw?=
 =?us-ascii?Q?rI5RVb47GCjpGZMGJUEP2uSNXYb055xo5D97pYF4AGUSUFW8x7RnED77vly3?=
 =?us-ascii?Q?tnSBzqXKRUN/yW+/iDqBkMn2x9cnKIQq+1iIUQSOvrqvM/sqUeDVXRO5M5SK?=
 =?us-ascii?Q?tUBy4a7oCzWKyTj0x2PHVUXp6jmw3e2CwZ/+TRDyjrZ3opmrJFVdK38TKnnW?=
 =?us-ascii?Q?iKPjp/cjFApKWZmNL/dysIhUQ8GodU7sabUrqWO61H5HVFDkDQWn5vT0XNTG?=
 =?us-ascii?Q?WHgV1u9RePIncMEGBmEhmnaxPcWhst5JIQJN4HHEgdofT4Kkbdp8vaSKhV81?=
 =?us-ascii?Q?Nsqxrp2ohH3f4kPVpRF1BKU6BQo8RLCOfH3hqwEI5KZI2LHJ/CNtiNKZtgzp?=
 =?us-ascii?Q?2r4XzD9M0ixke+QxnlVfmlrXcWa6O++iYowsWmXV0ddBqwgTgTlJOnHdb9Hg?=
 =?us-ascii?Q?HcXT9sBGOtDTJWPTI40SlcQUUMuwZdYFYMKN5YbFYS3RYFD4IGF0Z8Uj04VY?=
 =?us-ascii?Q?aEQ2y2Y9/pqcs8KoSnIWkypuM45V/fRbGs0bkmjr/bbkyQ4JzepWcQlIZYI+?=
 =?us-ascii?Q?L/BtZ7t9NRLeOyItX39o1HIWQIOX91e2OZVDl9xExOsoIhBo9ozkhK8aewti?=
 =?us-ascii?Q?L9mE19UkiYu1mzjWoOk+Hg+AjKTh1vbLxPtZzxf5KRHAZ9x2ZVweqwxtY91B?=
 =?us-ascii?Q?u0vJa7U87SisM0U7txndIMwSi0u8PoVSmIyUAoBclpTaQgiaL7MgX0LANVUX?=
 =?us-ascii?Q?FCev0YBvdM2pk/+SmTVIfkssLcunFyIKr9Rrt3MEMbLOsQExyEQ+s/udWXre?=
 =?us-ascii?Q?p9FlcAmr0kOkQV+ddshanPQYcQ/OwCANQkxjug7t7tqfkOlG8S6la82UOvPw?=
 =?us-ascii?Q?Layes56wzMYBTOlh5hzBr2ViUaL7YtgtheHxOYylDS/eyUADE4mnjw27ZX0K?=
 =?us-ascii?Q?VucHgDim5UtVn0x5IFCg1pTiNCewUClpbOmVFwLDVnzQ+16nEawnFL6m2Dxv?=
 =?us-ascii?Q?Qa2lnCuIxMbUOtSHcUXDjHrUNwOIgDIL0dvHVwEJezauCl0irZ8j2nvjvg11?=
 =?us-ascii?Q?HoecT/Xx0I1hdvSRhTnzCt9q3sBrdJvwQpZOAtkq1LvdumlOZPbgRw17+ZYj?=
 =?us-ascii?Q?EFpThIFAtSnvjxeLmI+VHg4xOOrVWDdBUHTTYLX63v1sOqFZ1KgXBLCvwGfj?=
 =?us-ascii?Q?vlaqxofvex2MWshEkBdOokoYyJ8dVeFBV05NTVirI2bYjr1zp7FmHh39/TY/?=
 =?us-ascii?Q?IUPbib7PuLW74sUVhq+UsvpjxB4/QJ952Zv1adv+RRQjzJ4/o3TElMddVHHo?=
 =?us-ascii?Q?2PVZApdItbV1ABFrEzQS/qQKEdoinV3kP0eZxDOmhtSGNbcagyLQ?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf07033e-9629-4a38-38f6-08df2a703ba9
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB820914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:56:03.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkIL51mP7YKXmYFBYOlBxTEKwwOk0anEgiHdpNNbxUcRuCI3okVcxpxFnpj206tsh1Kbc9tfm1tVB/aKkrJ9Fe7L0ScdZX2VdrZc3DxRl2zj4oAzzEV0fyxsRlAhce7d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6627


Hi

> snd_pcm_hw_constraint_integer() is already called by
> snd_dmaengine_pcm_open(). Calling it again in msiof_open() is
> unnecessary, as the constraint is already applied and the second
> call returns 0.
> 
> Remove the redundant constraint call.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thank you for your help !!

Best regards
---
Kuninori Morimoto

