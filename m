Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3FF606A338
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lvYBQx/G
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR9FS3jbtz2xLr;
	Sat, 14 Nov 2026 08:22:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794604940;
	cv=pass; b=AhHHMN5cO3kwiJEkfysOR4MrjfoVbZ5tIMgSDKHPdo+SRrR8WjcIsOJ7Go7RecEi/mp0oVV6k2Cs/YonQuSqTMmtyYd7JXBqKefCyPv9wJNp3rbzlbcHsca3TbtSjGP3t+0AaXoDsvfF1fhy+l4GB50mvF2iF1A88CNXlfYLuBS6PvvIvnMLC5MQOYSqPmK5Ei1qKS2qd9Q3wDCql0eoIrL/dPRlE8jYc9mjHDkG73FTqdFdLCSjo5uuwjmpyxcnDw3tsWkNhxlTjacmLWvTn8xqTFC6s+oFCUr0jQoS3+44KLBMA0XVLsYfLsINBWaGaHirttqNyfA06JseMcj9VQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794604940; c=relaxed/relaxed;
	bh=AlcGlwkBiVUAXGj7rCYHCvZmAX27rkRQwICPHOA0InA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FcGr3ZRVoqsT03UCPowAsgt43UjZnSjE/EUzulJmM++zy8qXT9LJV0jScONGa1jhYHKiymw9xSvQSzY23dltZjuxAikcSbyOS+YtInWWJJCVvTP/K76PV886DDDqwP6le/5xWzYdJzTiJMOJTxqLg7C5VrsS/2hxhiqqWhO5nKYNZwJYVCtl2njYkbNoUFjS3G8a3m2W3Z4Nq5KgHAaNz/oQUiyI5BeCIN8uetxM5iCAb5DAHOYDA4mYYgE/30T3dY4djYrE0gaVqr2jP4/I/zbA9VcpFmXs0w0WPNuo0bjbVjBgP9IEz2aTVlkheEYWTLePfBQAquCS+Ms2lZngJw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lvYBQx/G; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lvYBQx/G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR9FR3d8mz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 08:22:19 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=triI2eBodkR5waZ5MklsU4aR/g+qb8wNaVu1kS+JFQU2ck78ACnW4ASUO/z5AM4NNfKIORaHfcK7doIDmvPwGEqUyznAlt7slAJUjBRP96nJtzVOIDKDMNllbLVf7kNdyTnQNufz3RAqJOznIvZFbJ22UZpNlKyRwn1P77GjaL/yXGzkv0GuN44E9mpCqBfq1RKo3wkhlru5DlAvSRnIFpc2NGBYYl51tNZFjO2sbaQe94fdoEa4dC+O+ypJ+1+7hSSUhrYfv9jOfzlPaiVw2Y6WO76ek5ZZB6TTifCqvdguz38wm8iPbOUPEVnlYacaYw4edEVfYjZvvoerjKLN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlcGlwkBiVUAXGj7rCYHCvZmAX27rkRQwICPHOA0InA=;
 b=X3I9M8PXxTihmCpsSnqF4BtElrJugiyXmIeJya0PaPmKXykzJjR1yyUty8gN0LJyoyCOQUHJ3GoM3bFSxLg8ID4L6dc2Xh3dpCeYWBWnr0js5m2oJjpOq+7Ag3HbsOUS60JXKUKrfYmRTjg98WsTnoBB8FuxCHvgHTH9Eb3e4sKTQYa0EDkN+VXUOTn908WDLpHEP749IesbZ4vmxfDczLDRYY+WcaTMWeP8H8dp/BOnqdilShb6UTyyCGxkac3GvGI/LTt3FHe9jQGdonU/ZlsK5hfdmTRlBt7JWJsWOOu/PAiqGQxNHlE3pC4lfq49oI7xS8ut+Exsrzbgf+6Wfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlcGlwkBiVUAXGj7rCYHCvZmAX27rkRQwICPHOA0InA=;
 b=lvYBQx/GgRnWwo6d24p4AZc5kfMfyo6jIrFKTX69sDgjbvUki4xLJsCP5tTkNmRGbwy1BZYs2vNJP3ige6nfKJ7j6v72Wt1josAecMBOyG79F1U7Hy4P8yEenVNtAUbsAXQZt0iUYBTZfaM496R71Lh6SLTHPjnmvhkFtKLOyWszROWIrFhxD27cFu5izOzYTzflWOa9IGVAmIl9YThi1iPBS1D375HfdUbGgD+eOUzGrV+zK7429BtG4C02UsYiSfaD/sEySNWfDyabCDEwrHvsS3fuCfFaIZR2WPvzDQNNxEEkLScySkPcj/aulKtEdj09TTu4wMgeSNg9UxAgcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AMBPR04MB335523.eurprd04.prod.outlook.com (2603:10a6:20b:7db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 21:22:03 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 21:22:03 +0000
Date: Fri, 13 Nov 2026 15:21:54 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: vjardin@free.fr
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v3 4/5] pinctrl: freescale: add the LX2160A RCW pad-mux
 driver
Message-ID: <avd_cinZZIXWZ5rZ@SMW015318>
References: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-0-5a0063f1da9e@free.fr>
 <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-4-5a0063f1da9e@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-4-5a0063f1da9e@free.fr>
X-ClientProxiedBy: DS7PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::15) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AMBPR04MB335523:EE_
X-MS-Office365-Filtering-Correlation-Id: 29993a8a-c214-41a3-cf50-08df41cc2966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|7416014|1800799024|18002099003|22082099003|6133799003|261009223027099003|3023799007|11063799006|56012099006|4143699003|10067099003|261102123227099003|261026140227099003|261022105027099003|261026121527099003|261022075727099003|261021121427099003|261028144727099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info:
	jjD2V3T6XbKFN7vV8EuEnzReCKAoBZi5GC9uXdEsoSojrxi30xHc08hDit7YP24JgEdtmD9VADETK29ggaOKVjB85voHtiWELHMd8eFPjGS3uShG8CemxciDIJ8C0+Z+p+7hsxvWyT+frGqgRJIAKodnbBmt+pEpObXl8kHVSKmgj+7Qy4Deqto8JR7rDr35PepGy9jXnkcidFZC5SAkw+Vt2AmuhSvqN5yoIk/2B5ripEuVHxVoo6vxfW8OpkaMnaAmiE2ucpL9FcQvpUMa1SvUXoP6KOvzQvN1fwyUYXpNNCLOJgIJQPQmmWwVYFNw49kKFIFWL6B1pD70ywM1amxcec35iI2abnSBDCQLZNoLNHEL0KkH2J+vNnIPKkgHYDJRAmstha/xbfRZ5bllR6uoU2tbnGodoJNS0Gq+rTSaGVvVCq7hKhv3jPpoZ6bO0BZk0tQ1AMxlApc6T4VogrsQQBTKKam7lq+DKYSSU+xACUJ+/rJgfv1nc2RIRfKsQnoZB6LM+dsfNXdYtj/NBeEC/rquAWEWIxYvvMN9pz1KAzUxmd0bT0e1Znu2ETjV4tZLK/z0Vniznsz03YqDw06GQKXtaP9RS8I9jkploOQgUmk0qdy2nptPVKtvIoH5e/aGiKY6NzXiEZJBmtk4vemhumCNYBNHJY3Uqdc3cWNEoXJayZkMZxL1q20LkHAiKUAzJApmXDR47DfCZi2YvOglL057LQfDYwywk9ia56e92GCf3XDx6Acg/w9m7UNb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(56012099006)(4143699003)(10067099003)(261102123227099003)(261026140227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261021121427099003)(261028144727099003)(15866825006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U27j1BSL86Fp8MPgueDRq8ywddWAw9a41rog1OqOqAvB6Fn70uSqTLo+yOAl?=
 =?us-ascii?Q?gFR7eQ+qUK0e/WFwEffRhU1dBC4coO9ZqIL6RWVWD8aONSCdXyRDa1TWkq9H?=
 =?us-ascii?Q?Nzckq9qJy/5fD384sUWrfsMqubkP7QJx3vhkvrjtqiCAt634fC2gsRC4FWvz?=
 =?us-ascii?Q?8zVFB8zIumx7Kav20NDnDyHtjvmuDJ3hSFDeUWdGbEAEHHBgReglgdfICTPI?=
 =?us-ascii?Q?vTo7tgO5+cTYNT2PAIaQ49tHQNbxKgWglVEOucF+QqOn7rHkm1JfRQFLn6FS?=
 =?us-ascii?Q?ts+5AxTY6TZr72HeiYut2r/YAtwhw3ktSQR5uOkFlG09PkbnhFE6rS0ZNJLB?=
 =?us-ascii?Q?wfkfNSzS3pHiv8cWSiUCWIRk84Uj7XDM77K/MJ8cvHlc8t8Z/XrOs/wXHar5?=
 =?us-ascii?Q?iECj+/1sPEVpXaUL/y16FNP0E+0PUIvVMMDBeQ98+Rm+ctPlbBWJmadDQluF?=
 =?us-ascii?Q?n6BFH3jqyu6W3oBmjpi08yvb6J0VEyQCOWQnswG0PJHxa2KMx/HKej2D7Apc?=
 =?us-ascii?Q?/rnFGg7f33kddOIC0NT17CWjG5V8m2+C3gHLEs2dyjCWmMEnBZJv8zfrq5yc?=
 =?us-ascii?Q?BR0TFffrLQaPYktA/D53vhKd3uDAGw/fjQdAYLW1h2LQiqnYzuMWU6J9TM4q?=
 =?us-ascii?Q?kIsRwMgXdOgQM+g7f7LEPKleFnVouL1RPk8Vs8Os3ICWGj8smVAp1wYLzJp3?=
 =?us-ascii?Q?LN+2qSLT39JxBfY1eKf3Cd3p4VqDKa8fOB7RL1JRQU1lS1w9mMM/w0pOCKvl?=
 =?us-ascii?Q?YAZBGFWSiHvEaX0sfwq9Ug29w7o1zY/RIMOWXKuCkMOFZ4Z5rUZd3C8IFC6z?=
 =?us-ascii?Q?+3778TM0vL+9W1p4/JxQNpjW6LT6jwWunPFSWmU5wLrOM8aDH52MvyaSxgP6?=
 =?us-ascii?Q?fP4e0lbe0ESmu0tPXCCgaEmm4tnqTrtHr4PksjMK4AUcDJ0MiVxF+MRzv2GO?=
 =?us-ascii?Q?7PYvycz4V1yfbOuIEGME7/pQo2AawJvpQjiYqOjPd466B9o+Sq8k7cx/ShmQ?=
 =?us-ascii?Q?xebkr72+CHSBGv8c2Cr9bAW1UNJ2/NeJrPC7RSjVvGx0m504IKbsnYtVSZc8?=
 =?us-ascii?Q?Nr2d7g0ha/UN1VpIlBstoAzDpxs/3d4IPmMQjKFKn24jyJUTYqdNZ5FY/r9d?=
 =?us-ascii?Q?q3Je4llJKbd7owQtpWwcsD1lp5fwI8UNmfXAGUy4GNlo82NUIW3aBSq9N4zA?=
 =?us-ascii?Q?ekxfgc4S2n6amsfH5D6rdoyuGawqp9ob6zJ2Gsq8PE9U4s5A/YHAAHaV/nQr?=
 =?us-ascii?Q?lJ8HP+HS+XPMnMUhX1cTJvR5svNed33Lfl5Ong7EqKP9EXSUiwi+EE5iTJBL?=
 =?us-ascii?Q?X8WVradk/jNNguSLbvn4kJgX7NYQ39jmUSlQTQm0lHeGvJEfHboE4gfaT+j9?=
 =?us-ascii?Q?uHTCi1oggB0XFMl2wSI+kcrtFX0OYG9RCJ+m/iOCV/Yx7xHgQ5utXKDqOYxT?=
 =?us-ascii?Q?E/hxSU3pYq6p8PmgU199RQZIcoL9c8sY7Uu3sxq9xc5/1Txvj7TG6m1Q7quy?=
 =?us-ascii?Q?akpWEYG/tUSNG256ONMuic5MHaV0AKhurxRqth5e3sdlHdyW/KCZ1dz589hw?=
 =?us-ascii?Q?dC8ObuAwRC8CoyAJuTHndvVFETkXyF3oTtGh1AXZIRrQMmJfrwxO9PPIMOwP?=
 =?us-ascii?Q?U1rbtP18VloJoxhG7rmw9a5v4yUkjunyEpJZVDziJtq7HhK0EdmOPCVxos9+?=
 =?us-ascii?Q?Q0cBUW3eTYPc5M6TK9CV3voXcQJU7WlGQPremSx4Y7RWaXOyu14dQgbPH45g?=
 =?us-ascii?Q?3awwInWG3iGFA3MGpyL02j44x3o/sfj28sOgOPEB7B5+S9vs93/c?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29993a8a-c214-41a3-cf50-08df41cc2966
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 21:22:03.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAKClC9a3syzRvwXQCxW08s1O0W+5T9eNXH9OS1ZAOi0rFY534rx2Wm16aMczkDk07348B2WAV+iHXxGp5BYB9Fh3TOpybbWVR5sAGBx1vPB7OeSRy02LNzrPBYW6jhD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB335523
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 08, 2026 at 11:06:52AM +0100, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
>
> The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads from
> fields of the RCW, read-only in RCWSR12..14 of DCFG and changed at
> runtime through the same fields of the override registers in its DCSR
> view, which read 0 until written.
>
> Since commit 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c
> gpio to support bus recovery") Linux drives them with pinctrl-single on
> the override registers, so its first pin state clears every other field
> of the word: a board whose RCW programs a non-zero pad mux loses those
> pads at the first I2C probe.
>
> Add a driver for the pad mux as a child of the DCFG node: the fields
> of RCWSR12..14 and their encoding.
> Then pin states select them with the generic function and groups
> properties, and every change goes through the RCW override
> of fsl-guts, which reads the status register, writes the override and
> waits for the status register to follow.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  MAINTAINERS                                 |   7 +
>  drivers/pinctrl/freescale/Kconfig           |  15 ++
>  drivers/pinctrl/freescale/Makefile          |   1 +
>  drivers/pinctrl/freescale/pinctrl-lx2160a.c | 355 ++++++++++++++++++++++++++++
>  4 files changed, 378 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93abbb315065..6c488605f5da 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20207,6 +20207,13 @@ F:	Documentation/devicetree/bindings/clock/*imx*
>  F:	drivers/clk/imx/
>  F:	include/dt-bindings/clock/*imx*
>
> +NXP LX2160A RCW PAD-MUX DRIVER
> +M:	Vincent Jardin <vjardin@free.fr>
> +L:	linux-gpio@vger.kernel.org

Add imx@lists.linux.dev

> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
> +F:	drivers/pinctrl/freescale/pinctrl-lx2160a.c
> +
>  NXP NETC ETHERNET SWITCH DRIVER
>  M:	Wei Fang <wei.fang@nxp.com>
>  R:	Clark Wang <xiaoning.wang@nxp.com>
> diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
> index fd53cf5bb843..a3222714c970 100644
> --- a/drivers/pinctrl/freescale/Kconfig
> +++ b/drivers/pinctrl/freescale/Kconfig
> @@ -283,3 +283,18 @@ config PINCTRL_IMXRT1170
>  	select PINCTRL_IMX
>  	help
>  	  Say Y here to enable the imxrt1170 pinctrl driver
> +
> +config PINCTRL_LX2160A
> +	bool "NXP LX2160A RCW pad-mux driver"
> +	depends on OF
> +	depends on ARCH_LAYERSCAPE || COMPILE_TEST
> +	default ARCH_LAYERSCAPE
> +	select FSL_GUTS
> +	select GENERIC_PINCTRL_GROUPS
> +	select GENERIC_PINMUX_FUNCTIONS
> +	select GENERIC_PINCONF
> +	help
> +	  Say Y here to mux the IIC, XSPI, SDHC, UART, IRQ and EVT pads of the
> +	  LX2160A at runtime. The pads are muxed by fields of the RCW:
> +	  the driver changes it in the DCSR view of the DCFG that fsl-guts
> +	  drives, and is what the I2C bus recovery of the LX2160A needs.
> diff --git a/drivers/pinctrl/freescale/Makefile b/drivers/pinctrl/freescale/Makefile
> index d27085c2b4c4..5ec0d1710ad5 100644
> --- a/drivers/pinctrl/freescale/Makefile
> +++ b/drivers/pinctrl/freescale/Makefile
> @@ -35,3 +35,4 @@ obj-$(CONFIG_PINCTRL_IMX25)	+= pinctrl-imx25.o
>  obj-$(CONFIG_PINCTRL_IMX28)	+= pinctrl-imx28.o
>  obj-$(CONFIG_PINCTRL_IMXRT1050)	+= pinctrl-imxrt1050.o
>  obj-$(CONFIG_PINCTRL_IMXRT1170)	+= pinctrl-imxrt1170.o
> +obj-$(CONFIG_PINCTRL_LX2160A)	+= pinctrl-lx2160a.o
> diff --git a/drivers/pinctrl/freescale/pinctrl-lx2160a.c b/drivers/pinctrl/freescale/pinctrl-lx2160a.c
> new file mode 100644
> index 000000000000..ba5bbcfab9fd
> --- /dev/null
> +++ b/drivers/pinctrl/freescale/pinctrl-lx2160a.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LX2160A pad muxes: fields of the RCW, changed at
> + * runtime.
> + *
> + * Copyright 2026 Free Mobile - Vincent Jardin
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/fsl/guts.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>
> +
> +#include "../core.h"
> +#include "../pinmux.h"
> +
> +struct lx2160a_pmux_func {
> +	const char *name;
> +	u8 val;
> +};
> +
> +struct lx2160a_pmux_group {
> +	const char *name;
> +	u8 rcwsr; /* 12..14 */
> +	u8 shift;
> +	u8 width;
> +	const struct lx2160a_pmux_func *funcs;
> +	u8 nfuncs;
> +};
> +
> +#define FUNC(_name, _val)	{ .name = _name, .val = _val }
> +#define GROUP(_name, _rcwsr, _shift, _width, _funcs)			\

The name is too common and short, easy happen name collision.

Frank

