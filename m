Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32652606A320
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=I6UXkWQ5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTyPN6ndXz2y2B;
	Wed, 18 Nov 2026 21:23:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794997432;
	cv=pass; b=JZ2eugVKcPJnOVL9xOyktWyi4yAnv2SN7nKISnZpWaVXYycuKEZ99xMXshP/fVfoI44gYxjbnuXtMcOp/bpLhT2leehcVB2FTfrqodqA1atX8xWbuA+A2KLyNt1CC5VmyhbDdHdQwkIU68S80xIVauOz+37D2Wxz8kRfpJrJjEVcWavK5HPxfhDEYUwb7jZDCRjRJR16puYsK7yKHN6FGtgoTURjiYCRpLk6ZFXDEvB6pV016xJGxxI/YBxtt9N9Omgmrlttb/NY7m87jt2lxZtfSwE1BHRQ7Tdf/ImTZk1lnm/K5OlRpI8ZDQ3fN0pFz9uF/36RDDAwgzIevM3Y6g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794997432; c=relaxed/relaxed;
	bh=kOjwt34NHmodrfdsvdjqxDdfAB4m9Px3jjTXOf1Z3C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NXemRx57ooomseA81CHux3AF8jWo3JslmVLwN9isY0fuarhmn8QH11MFQ34Qw7WGCwMNs5rUpYHs6JQ+mJaTA4QGXjKiSVeNgiJBITxUDCs1JH/NvuEoFsuNZSxndK+hUXptKw4Ge77Skda9uIlIB3H2wAwj1lJxkUuWvVqMtoB9Ptxq814b0oq+gmqStOgBN8ukERvOzFiVJh0ymqjSeF4tronalTF4xJ24/iYR0oknhFI3qNTIL9XejhIBjg+k3mlTRBDUaIFgUIHusLI7WHMTlVzfCiCc8mRXs298R9ky++rcL5/n9ggAcMhEYIQ01JqCR5cqvqz9/ejJsKWr0w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=I6UXkWQ5; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=I6UXkWQ5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTyPM69K8z2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:23:51 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtZ8rtuZhxFScnMGpbrLR+w9r6bWQqMPlovKUfMY+2KNIOF2mz7w+7hhYGPb6a3TLIdoSkT+WzIVUtJeOe+EtbA59UDJs3lbqP7f8QOyOdW0g01Fz9EwjpSW18JKQTFLNPxGSz1n71dbiT+ZEy3ZKuj2Z2IFOP/XytbDoIVcez3d5w7KmD2pAStvAjbwkCYzsd4fJGch+0/G2NzmpFqfQoGJ/XURkrmMsTZK304I35Ope4p3rr4sdd18j2vJBk4i+wRANHJf9pk4yFxJAp4QTJ9eN1IShD0igRJJqVrnMu5HZ40rLx1RGIpVmsetwQZI65DBlDIylFU9rE6rX9oR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOjwt34NHmodrfdsvdjqxDdfAB4m9Px3jjTXOf1Z3C8=;
 b=aa/WeFHV2sslk9C981AD/mvydylXkVydwKXNKUA+Nzml/rr92b/R7LgA4xbBqtb4JWqc0SBffkXcym2gXGO+qhJzNW6Ypp0bF9oCQyBp/tcckp+3E4NH3THWVNsQGakCUkII8ETE5sMni14CyCSaXpagDghaa/freJpztECW/yxJjKaCvuRZypi1t4Lnyc1dPfWhbQzW+8Oue2Fqby22h3LtKS94YJ+29vI+/mRdrUP0YTA3439hWbMie455jXSmkDZkUs0B7Uz+vZs7/aplqevt/0U5JeOzX9+33TyQiFX6USwhChZ18SRh7bjBwJlWxxQv5F2IucnOyUxXOzc+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOjwt34NHmodrfdsvdjqxDdfAB4m9Px3jjTXOf1Z3C8=;
 b=I6UXkWQ5XuELUvoHseGyjHxfo2dOU/z9Am4b6HSnBWPDn0iua7U/XGwgS3WPpUiEcD19YrVfYDhkd8koq5ivS6WbHmgWukuMWT7rZXZuVLkZd1CP2R5LPBU/XMonhtxo5dwD+gq4afyXi2j81etfM9VNkRAxahrBHaRctx+IqdnYhs16WlxR2S7cF5cPh7QNURKBRk19kdKLENnkyEq8HK2+mx8PoDVNd8qXbv/ybIPomUffrGoT1zgbX5NL6OGaUXvwtIEDeVLan3I9DkTm5EE9DA2FqLn8LDFsPNO0hQDvlFaL25gZHd4UNe0fQpinRfw2DyOfBALfy00wDoXvtA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB10974.eurprd04.prod.outlook.com (2603:10a6:800:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 10:23:29 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 10:23:28 +0000
Date: Wed, 18 Nov 2026 12:23:24 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: pinctrl: add the NXP LX2160A RCW pad
 mux
Message-ID: <av18VNI7IjVFO-JF@lxl00025.wbi.nxp.com>
References: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-1-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-1-5d7201970629@free.fr>
 <avzBgDksGfXb-MxZ@lxl00025.wbi.nxp.com>
 <av120SMcb31YLAWK@L30177.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av120SMcb31YLAWK@L30177.local>
X-ClientProxiedBy: AS4P192CA0002.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::9) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB10974:EE_
X-MS-Office365-Filtering-Correlation-Id: fbef2509-01a8-4f3f-8290-08df455dfc8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|19092799006|23010399003|10067099003|4143699003|56012099006|261026140227099003|11063799006|261028144727099003|261021121427099003|261022105027099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007|41080700001;
X-Microsoft-Antispam-Message-Info:
	//K7K+UWez+5itQXRLPGcJ/CrwJIGN1hH2M7d6v7dsZ8xcv7Cf/a+zRiFDdOkVv1WykoUe7/EvxZOxUd/VZTizA2DdWLywdQ+hyP1pz8KaummygFxAfoDmZjvcmxeR0xw1wN9rNnHD7iAQYyj7Dp5TjuWwO/tqItuE4/K05pGLjeQQYkNC4tK+UBMCtdjZwn4p8imTX6whOHjgNysM6Bynkyou84TI6sL/5T6qyick3/aajCNnPmkhK9Tulgp4S6quLeP7ma/rvYH6xZGBmSxgPURAx47eqiyWw6i+Bb+jDu/iCydNjM1om5oaQULm/aoiIXYZun+dvcCe3jv/O9Ony/0qa+NrMRu2npPGoj5VXtjA1b7fCXnao+chLpQUdQaN9QvWMTaGeltkmjvuKnRxAzjwP4iBD3xmK2BoSEeKr5yHyx7yi7RVtAYZosgZe2i5wll53tmmxqFM/zA7GwLHR+2P1vCJJqPs/zmfc1oot0ua1zHQd796691qCOEvEz3n26tt46JQXKZJGZT+hT/MK1U9mSizZJc+3Lz/Urau3k1NVEUYRMtW2+QMMnIVJIgzHSD5kV+fZ1pHUgQuz4B4U3QT1P0UHNzMtZ5Vxzt/zHQcCof14gKw13lGjjxdBf+EpqTPKevFt7KW17nc89REBkomqbJHuWyy2JV1qvO9qbhs9Uddv0di0T5bmURHd4GN9dzmKVsHiCiSL8Ja9wWMHib8YI9Z7I3r7GMmyDoME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(23010399003)(10067099003)(4143699003)(56012099006)(261026140227099003)(11063799006)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LTCkoT3BFJW0jqXNITeNVYaVGFa/vnFF4bX+0+b4iM1nEm3jJo4lGsPqjj3+?=
 =?us-ascii?Q?KDKngqC/iAC4g9ksNXcwenUPNinYNlvGaCV961cwiqYo7u10sDirK3gWBsHk?=
 =?us-ascii?Q?eSKZW9BnAy7yoqFE75bl6HwAJEOq2Mdqp1uumCTJxVPEN/epP/pVFq1JPIRW?=
 =?us-ascii?Q?6X2Emdeb6+xm0YJ0gcnqYoYox/QYnvMmbI7NEj4sVWfSys4sr7HEZxE0VJUf?=
 =?us-ascii?Q?gs2nxY8A+3+gDdVm26t03OQzFg+BYROxhhtQ7SmXaDwGgp3Z9ZiY7J6g9NaI?=
 =?us-ascii?Q?1G0e52bDV2oiRCh09PLs0NB/8mWBvtWUhdpmFji3ZLrEZqMaS+SQ5teygLMb?=
 =?us-ascii?Q?PdGwweWreU0G7qwr9uYWtDmz6DwHGd/3tYRQCLZOtFFJM39MARD6THj0MPmG?=
 =?us-ascii?Q?rVaClTjWV+kQdpMxwZq9Fm/zGOgsYxQ8FywTooyao/+VCdyjgDfbKDHYBf6J?=
 =?us-ascii?Q?whe+bK+xrJn1tAkqvhVDip0cUpiXKRwSFiK6j4/OJtoYu0KGpGOgXPrwQLg5?=
 =?us-ascii?Q?APFR220bRblDZ/Udv/Xwbob4A88/iyx3ZE6U3uzu85i6zAg5F/ELXXtD4/Gl?=
 =?us-ascii?Q?eEgBUADkzZfWivPBqQBfcFS86iIG1mvnD0KO2bm9AjYFBVph09KQf+U9GWYm?=
 =?us-ascii?Q?+toXwzil4iE3NekLCCrzN++sFdhPee8fwpB9dWafVTGyVNkyubf/w9lICLkO?=
 =?us-ascii?Q?J3WjHIw98MlcdvfP9NDkTAVetSSZotn0z+rds92XdqfruE0Z/+9HuleAO6Ov?=
 =?us-ascii?Q?Ugf1XF7UdSt77ztJgDTlhd8XsCXJebLoo0AiZ4ImcHleLmDUd0ZibgZ/iOEJ?=
 =?us-ascii?Q?Gebpamo/degRlOfgoxt0Tgg5/iJCXj+Qf2OU3NU8SMfKbVHDrPUWwGwKE2vp?=
 =?us-ascii?Q?kZhnTjXjs+OimfKVkn9WjaNKtrLKlu3FN9gBf3X8yL7xFliwdkTuNYTBSN9F?=
 =?us-ascii?Q?dH+EUHx/OTrvdf9TMunnGT9y1SrxtjHxJoq+P1hSPDhBC2Ozy26RauJMPDfT?=
 =?us-ascii?Q?cmF/V/dX0fXYGgMmqWJW1wXYM1WMapO+EDTVA/w558p/3JVG2i0Zw/t7dyaE?=
 =?us-ascii?Q?wIaCqa77Ljn/OgVCv1F4x4dM3YzOFqNEFbV4Xvec5HpX+RFQ61VgZrUsi/sy?=
 =?us-ascii?Q?I5KTa64LTXb05xJTvK7dw+rFjZWBSc3NRI4oE/vG1XqZDz84TkZUhk4RSxm1?=
 =?us-ascii?Q?DlrFzEhaWA2TEbGNTYSIUvM4HbXt0Y+hACOc3YVQVYzaDs8p8oRF7dXOocJh?=
 =?us-ascii?Q?22Fk8vcXGMXAmscw0ci86Mnu8zZTSaaBTV0eSygQD8/+2csNM/9puQxaQWG7?=
 =?us-ascii?Q?bgSx5+hOd2eltsRZH64oGWipoTbIzRzlZZl4jwO9yuTp5wZ0c/C1meDo9P9l?=
 =?us-ascii?Q?LfT5337qmyOFhH05KUERYH7kZdhWm2wDSVv/6lRUmClDLNAJmsiQrbVNcbCo?=
 =?us-ascii?Q?0sMwZgQiuDhBdIknrVKOS+p7COwC03fjKDl5OA4nUEm4NIUG+FO+XS7XWX7H?=
 =?us-ascii?Q?aBE1ry8s1pnO3vB3jip1g5zGOI7KkmsEw/Vhxy3LDZdbSTLBYpk2bRky9F/+?=
 =?us-ascii?Q?mTypDxyVrnNVAyhxJS8eRe8HWnOB2vfx1N2dXqnpyjsvO8ef+6gQEHkxr2OI?=
 =?us-ascii?Q?23O72s6YPzNI0gwDwfzBC4XFi8kB7xNq2E7yIZnqVp0mUnOYSbSyfdg9hphV?=
 =?us-ascii?Q?qszwha6HCUbHGZsqSkbkBey8g0gdXsdTC0HvQRWWunF6pHloHpDuPqcnMXYe?=
 =?us-ascii?Q?G15Aony2fQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbef2509-01a8-4f3f-8290-08df455dfc8f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 10:23:28.2712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ou2iT56u8X+U8z10yiaen7qGi/gAlLR4q1Yj4WGeCF/8dNeuTftUWULtdAY5u3dvZG5DTButY6Oa10XslmzsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10974
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 10:58:41AM +0100, Vincent Jardin wrote:
> Hi Vladimir,
> 
> > It's a bit difficult to manually follow all the constraints, which are
> > listed in the opposite way as the RM would have them (function -> valid pads
> > rather than pad -> valid functions), but AI says it's OK and I'm not
> > spotting any obvious problems either.
> 
> I am trying a small update into the yaml file, that should be easier to
> follow. You are right that this serie is having an heritage that
> should be simplified to ease the maintenance. I'd prefer to improve
> it before merging it.
> 
> I'll send the update later today.
> 
> best regards,
>   Vincent

Please be aware of the fact that I started copying this model for the
bindings of other SoCs as well.
https://github.com/vladimiroltean/linux/tree/layerscape-pinctrl-v7

