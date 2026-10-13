Return-Path: <linuxppc-dev+bounces-29338-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B89CA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 00:03:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3ZKd5j3Rz2yD8;
	Tue, 13 Oct 2026 11:03:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c407::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791849781;
	cv=pass; b=P7ywJP+BAatZkKqG+dsAvPCK8HRgkl+0P2ZkkJJyrXpHc51sj+ZEptimIa/WR7NjpXdZBWsvya/Ge/qAGCkF8ZvEEWj3ZBvcBPGoTgZuzGb46TKpGDn+689nW7XLNuGt04TKRCq1ofXNNC76NpknQpgI8+JyMQSUPoxQQJArs2luVChP1yF+yhBP2byre21DJuInbmDmlY9P5GzPUOWw9wkplR7wR16i3SfFLvgEBrleZ/PlT17Hx2pmYfguAD+HcXO48pe4CzZcUa4EpGZEz+oeXw7876R7Gis2hdXbNEzz6mvH6MphMxLrlORn4AxMcP/brAbRCZpp6mf8AYIq5g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791849781; c=relaxed/relaxed;
	bh=jxgaGAP8pLC+BmI8ukX1jfb5CQ/im84yKraARY1OSWo=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=BVmk9r/RC1Z00sD35UzDIfT0QhSIfEC+tCjVV46nVVoBI77Adv/TkPzLHS5LJFcQ6PKFzaOCBRsmlkRvd5sYwVcdcNJcI/fHVSSDFlQUkTOz+Gz+XC/jiaaO/JhQdt/tBGRNz+4htfr/n99m7TbyLJsNxhVYX8QXYeIWSEp7VpZY1BPHuVcfITyD0HZv1Gsugqh6YLgvneJo+3tup2FQuWnTT4Xl7RCAYnh/93353ilL9QNvjlEL4D3Mx64igElyRRWO6cCt+Dosf1dtZ8nvKyIQb0Oqv0+wShQ3pIGzHcKudXhKSRUjqCPdY4GBuBTnu+MG21Lu0SrTpj3SCj/J9g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=renesas.com; dkim=pass (1024-bit key; unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=QUeSO+NF; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c407::1; helo=os0p286cu010.outbound.protection.outlook.com; envelope-from=kuninori.morimoto.gx@renesas.com; receiver=lists.ozlabs.org) smtp.mailfrom=renesas.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=QUeSO+NF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=renesas.com (client-ip=2a01:111:f403:c407::1; helo=os0p286cu010.outbound.protection.outlook.com; envelope-from=kuninori.morimoto.gx@renesas.com; receiver=lists.ozlabs.org)
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazlp170110001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c407::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3ZKc4Ny4z2y8r
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 11:02:59 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rV1ttbA/Ye+3cQEEMo0qFGR+VZiXn2uJ4efKTNY0sta60hCkYUVFjdEMjuP7BigObFdU9lEOk0UpxJGIGPIJrz2qiSsNFuy5rPB1bEAvFIRibNpHdyvhSGIrvEZbJyDufYrZZsGZo1tavfEKRdI2tEF3zUavFG2nuZhxh8YPUEs9R1Dham72rh8+speKc9v3TuAYuvR+8EcTpR6VMF+0mCpfGJmZCWSe+6Alcqe6qaKwSRs+JSGVRpq8uJh7ahGlbVNE9PgqvVDZ2/3lSLNO9+8bB+sPEGagvthljuB2l9BR8VsmuMwgfl6ANlrjrG0lz5C+F0czztRXOyJKuHmZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxgaGAP8pLC+BmI8ukX1jfb5CQ/im84yKraARY1OSWo=;
 b=i72icGRLi/dkoFimUmnTPOaLV1IwSMeMVCtt+lSBQsR52VL+IztFlvN/87aYlD7D50Bn79tMK2B0/exmI8Liy3yDCy8pxSyPQj2vGZfjmmg9KrQq9QfLg+mFgyWjqpJntsCgsfBzZdHVZGFnmH4zQRtAExkpFTqcg0xy/BTZbE1CSFa4BwuFxxQVduVtTNiZmOrRlDakIai1IGqXFwBGMvbm9P0Om6Cuoqt5QFiAIXr2QxlfqhhRidggq3Sll8amzX9LKKf5zCfAy39pxNxsKxBJFegtejMvfepVICh67WS6jdWVI98YxIZe2RncBDx+mGweLTxtYBllBI/ZIWiFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxgaGAP8pLC+BmI8ukX1jfb5CQ/im84yKraARY1OSWo=;
 b=QUeSO+NF6/jDw9ndhS9J1qhcNkezwyUkzBzeqfVOewms5Vy1S4IKQibaQtnDKSvjshgD9kTLzw5KNl83fiNanZfrJSzlIRllnfvu7QYl5stihHTbgrZxWXochJ55gRUS6w96/FJDz5aAo9dV3Iu1y1geyyMs+MSIKTLMc4BDsJ4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS9PR01MB820914.jpnprd01.prod.outlook.com
 (2603:1096:604:50f::14) by TYCPR01MB11460.jpnprd01.prod.outlook.com
 (2603:1096:400:388::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 00:02:35 +0000
Received: from OS9PR01MB820914.jpnprd01.prod.outlook.com
 ([fe80::12e4:c507:3730:2294]) by OS9PR01MB820914.jpnprd01.prod.outlook.com
 ([fe80::12e4:c507:3730:2294%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 00:02:35 +0000
Message-ID: <87o6cyxyau.wl-kuninori.morimoto.gx@renesas.com>
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
	Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
	Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
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
Subject: Re: [PATCH 21/24] ASoC: renesas: msiof: Fix msiof_close() being skipped on rollback
In-Reply-To: <20261008103831.542533-22-phucduc.bui@gmail.com>
References: <20261008103831.542533-1-phucduc.bui@gmail.com>
	<20261008103831.542533-22-phucduc.bui@gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/30.2 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 13 Oct 2026 00:02:33 +0000
X-ClientProxiedBy: TYCP301CA0082.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::20) To OS9PR01MB820914.jpnprd01.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB820914:EE_|TYCPR01MB11460:EE_
X-MS-Office365-Filtering-Correlation-Id: 6478e393-ee5b-4890-17b6-08df28bd4913
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|52116014|7416014|366016|18002099003|22082099003|10067099003|11063799006|4143699003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	B6U3afTkf7VLXQKinV3m/9XC8elWhApxBH+FQzvshZe4INQHXDLCl5gxgqNcoA9Msw/YE3kbENXU+LEsdKoofIF56H7qV0nR5zI05gaIWPcGFaDL5MR/VR2I4g5rQP2dZprVME79f849Y9REscwVwAqWoAhgat9GQ8r1iKLNJwWVMDi0oltFZoKq1MaFscgTlk1nZWb5Narvcr35VoZWDnQKWyfXcYPDBEtroEInlyUfHIBpsjKuPhC5IY9GnXFclWBWIcptSGWTWrceYVthuUA0mijs5EKVwC3vHPXcaJYQ5AHESdQdFI40DshLh4jAD7DP8kegJBOgak5Xn6kqAu90f6G2/rmwYOT4yrq49CijemiOlv1Ps1ZmQkSW+veCFot6MXMf6ombY6/23YNk8w98FrrjgTW/MWuZRRoBaJyfp1D+pT2hcWQgcV8PuLonF1KNRKhfLLdphVgYv/OKo0+Ge4GP5HiEEW3nVi8b5lwB73jsGjCesgiRm932Spph8ZFce2Ab20tCruw80z/9gzE9nJI+dJBs69lstHtQNXowtkR9IEedl9H44GSZGFj8sdeb2gssT6IEs4uCcH6U1IL3JGb0i4I2sEc6IPp3G3eVWC1WS/7BvQb70eTWRd2xpVtRGeMM1qgBWSCfJRqFRNNgciMV96vouyxnYEZj94YsrN3CU7CJGbO01z/7K3hKD3nuoi9qTGTCakY3sWhRkj9dsSEfrDSPDlzK/94hP3A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB820914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(52116014)(7416014)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Y0MHFmRQVecE6UWj4+qneyKAKTfupSRmsdcjbsldQpxWBwR8g/Gbmc7Tfun?=
 =?us-ascii?Q?02+Xgy7BowWAcG4EEkiugsbJHHNEDcRjjVrbfWUsXflQCsp0UAh63d/2bOMb?=
 =?us-ascii?Q?wkz1G5i4CR3kmYEVPUOJnesW4jQgaYzzlGUf0Q0zeXfjt9j3IxeUcP0xWwD4?=
 =?us-ascii?Q?/jgwlU2luJDfDcyT3m+U582/5y8P1c7O/FBYLm7eaypblUy0V6jAKHSRvr8j?=
 =?us-ascii?Q?4xVmusNL9nuWNyJhvrQKD8r8hjMUUbK1rYa4hGutmZ5ftEFvJyzf8sFsDbzw?=
 =?us-ascii?Q?reQxmSqsKakR3a9ZA2VQcjy3XLGuRP1rygXZBXcl4btz6Tu0o19/vkIQVA6q?=
 =?us-ascii?Q?INwGLU+VV7SZ+QB9nXmg2Werp0BbDdiDdRsFD68so/jgGL5YUyzpawock0tL?=
 =?us-ascii?Q?o1UW8E6BZw4TP8VxCaxo3eP1SWsd2gxizASb4cuuXlGdFp0AG0UuD1LjxX5R?=
 =?us-ascii?Q?vhJIFpGa+lw95jckCPj5FBU0dA3ndVRj9WJVS+WXPYegOpCrBs+8kkBVv/Ei?=
 =?us-ascii?Q?U8qAc6DR2fgFraMhUKnnhCOGuNGPdb/O07cQSFO666IFz++7XkoYL9ImTVxD?=
 =?us-ascii?Q?lOCkFtt2nm+Yfl6jtTFaDg4FCsM2s/KTByyqPb3D+RG1zghEsjTQ3T8m5Lk5?=
 =?us-ascii?Q?EBJuMVCDf/DhqpuLEXmrcmRQCb0kAC0MH27WXMiIrWeNyAbC08u5maDGPTel?=
 =?us-ascii?Q?g5ZWDKs6TyZSQyTfhVVyESQV6uzGtgaw5sNn5vLGVxGau3urv+a0tS5dovJe?=
 =?us-ascii?Q?Ob66Ac/ct4dVGViS/gTQXl99cce5snc9QbrtMO8/Ctu8P81zSGSnCQLQmoff?=
 =?us-ascii?Q?1n6yNTVQxGeRvarOMH7GZZhthrXWyJxFC6ODn4g9OQ+c45gLlfUUE1QH11AE?=
 =?us-ascii?Q?KHKh2aehY3ALtoZchKX5Tam0q1S6XM4rlOKsVo6Emb9lrHAXmbhvh21QRe7N?=
 =?us-ascii?Q?qZP878bBuO+0x8yIjKebbaDp8V6P/lB0PXvVqGonPS8A7AS9P6tbl0punLUE?=
 =?us-ascii?Q?2Pu+meKMXBFQzdmG9qe9hi0gvITtwgEux2JpOv11sq3DOdvweX/Mfb8PVABC?=
 =?us-ascii?Q?GfpQGMxVGDIubdoEmB0YuBQBQBX1OhnaFp6JDv7QX1ZpEkwKuKnehlNuvqf4?=
 =?us-ascii?Q?0+wH8IdDtGsDVUawvi//fg56C+qtC4Ee+MINcbk7y51XcBhrZDh/2C70cIy2?=
 =?us-ascii?Q?VbU1sjtqs4KiuxhSsP6RWpE566DEf7guGOatHg4gR/W5F9YAUBcU3TlseaGs?=
 =?us-ascii?Q?VXtnkbBPpFc0Okxnsf3KdZuXS0y7I5klfDJhTxfDxR/DSw1RtXOmkTJXYol2?=
 =?us-ascii?Q?17oJ6E9CZxaTqQSXP0dSm84qeqVIHNXV68cCmj1mcilkOXfpQscQyOtpH5q5?=
 =?us-ascii?Q?hCy3vfjl4m8o2bceO4yX3ImLCu6/R0xuSgAvlXsQNrBkRAUkUNmsqFX2FIt2?=
 =?us-ascii?Q?jwOdtogQ/mf19kyXfw4/TxCTm/zrDWYPGnhkCP3gW/DOiDmiByI5lZ1xmAFG?=
 =?us-ascii?Q?8jjjIklLz+8ZU2JcA04Yx6NX+RNXpo5NQXVqo4+27APVc/PDEL8X9o908wJE?=
 =?us-ascii?Q?TGNG84phtWmZM3oRwyHpxiMGPeiwzv2sBye+t5ihCbTnhR88wKlWhTm03hUG?=
 =?us-ascii?Q?BQxl5DbNpMoPJ8Xn26FtjogiZOf7wpOgT2TYJgHvnS5tAsEgPBn6G3OtWyH3?=
 =?us-ascii?Q?MZt2tc/VB/7A4m+Y3b+MQmsJQ+quQEZi7OmV4d8Aj2Hi1O3NdFZLe0EM6OeF?=
 =?us-ascii?Q?sYhwevaKCofcyToBLApqNLv8flc2Jxc=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6478e393-ee5b-4890-17b6-08df28bd4913
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB820914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 00:02:35.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPXbv9+4JIq43tVogX7MCApz4tHDqhyI12nJcIfpeTvwrnUfuP5qGbKcyB4uZ0UcTM4xDazKMtHd6Xzh8jX989H8ZmLhH2qaHyjRVXmgNA1BjHKziYyZq090ZFn2PsfA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11460


Hi

> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> snd_pcm_hw_constraint_integer() may return 1, which is then returned
> from msiof_open(). ASoC only marks the component as opened
> when .open() returns 0, so .close() can be skipped on rollback.
> 
> Return 0 explicitly on success.
> 
> Fixes: c61caec22820 ("ASoC: renesas: add MSIOF sound support")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

If so, we would like to have such comment to indicate such background,
because it is not intuitive for people.
Otherwise, someone (maybe me :) will return to the original code.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

