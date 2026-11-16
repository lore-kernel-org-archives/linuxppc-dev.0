Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D49606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fE1TKMwN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSvZN5QTXz2xnn;
	Tue, 17 Nov 2026 04:13:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794849180;
	cv=pass; b=knMI5zk1Nimu0ldix/gP+K50v6/cJ/RkKOQ8AKCf4krmjf+gh9mj4tbRAexgLpaNn0jE7TO7FkuPyGfYIXdzh3eXApoEnF1sfp+eI27bsyD9vD2Zc3foUxJZ16ocpCP8AdRHJ3cA6gH3kTBzEIqdhi7kzH/2oIhd5Az5dQdMwbFW2SUVC4A0li1o2PgE+iPMqjHteUEPjYRw2UsS/ylqhwUzFd9ZFfICe9Rf6H5q8fEfnXODdekoHm13tF7VVPo0HSJtnN3xVxH1j2NDYfk+JWCQf5lH+ULyzOIqMb0F7z54gWAHRTtEMyb/Bb52vQxxlGzgck/PIEagnwTFuKYAKw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794849180; c=relaxed/relaxed;
	bh=Aamj86dzv2Ke/HgO9XDLo88lwbPM6q/7WVEi7BQ5bY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JkUM5oSca/fHpMnVVVJsKIi/Dw+NF+YhATtnQcgDKFCJasZ/EFJfUthMB6QzCf0I6rpWjT7lgveSALTpmuMzM0/Nd9eZk62rts+WcQ1YhaNwlSP+sSmFGEcRxBik7joO/rjfcPPkfQ0KWKEJ2rxxZJql6zj4S6+IhadasRlJWT0KTjFuVZX3ztWgJfaE9V4OJShBRoKiTwEx9XIzfuvFIBODWbiA0F34HAWMhPBa/VR3Gn2Qjh3vp1PX6cguprryBukqZuiYExEQXoQAp6+OdRCUhpXc7JcbBB7RyMrSEfZuSIrIIMe3mj1WOyDZdn2mSlhh4zUEnl6euhkOf29Rqw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fE1TKMwN; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fE1TKMwN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSvZM21pMz2xdR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 04:12:58 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Io2PkWtPxGfsEn4BxVxdyuzrp7pj9A/u2u7B8/EV0jhRO6dLP0NwXoipokWJfYqnCoXftr37mGAECLBDFoFiGy8UwbHnJrbGIVfE0O+wYL1F5CqeHfVRZivWe9NdTMAPZnkWA1NnsPlH3ZN4eCS4v2HC0gclA4su85w9edg6o+7On/LWVmeyfohfqqP9dOkYQjj2w5dY6yAuHolYP1NJ8u3Z5ZTdZY9hRIpgbFciL2HuhTitcMahHCw233FBF3adtZ4xpp4jm/aenGGchCbnbzxuiG5T2tEanLiqt4MdwU0slIZSGtaJNg12SZvk/hzGM8X+U592Xa18JIMQkBMejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aamj86dzv2Ke/HgO9XDLo88lwbPM6q/7WVEi7BQ5bY8=;
 b=B0RwoWUYkp6feo5x5WlyuaieOob/qjO4BGmebftn2NIAoomHBv08B7pvN7YB0cNmUwPc5+LgJyK3ztrKq5oeeSk8x6W8VMGMz8+qsH5v4sOjpMAPqRiXdgTgS84Qm3b6C6b1/mzgNDIrdkPhh1YVblYqGDmnSZiv/O33x1JMeZ7VjLquzAWngErBosVfl2I272e8cPPmknno3FWT8hBX3NCfyAbLQv/byNauHhbtf01VhjFw1bIt/DLbYYys4nvel8hST+hiZhe7WnFbtfegbMLA19ncjPyi4KlIRv95E6TfIXLEpBGGQq0S3fhd97DTIykxhChLVikKSjW+9gN3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aamj86dzv2Ke/HgO9XDLo88lwbPM6q/7WVEi7BQ5bY8=;
 b=fE1TKMwNfsIDK4AeahuojwkSR5Jwwr4lXKyWDymt/DSu/NyKORE2r7GUgmEJvAMVn7GXQBpqr12qeVRXtuUyNe0P70Dm1KKTO8vxM1nhGEUQIgCck9IBCeWoNgpLwRvTbuBablvE/zohK/D9mcpiyW7c/pC6pvev93m6wxAqVWYrBa3jQ5pDF2dcHeyKVZzZM9IgktQaQs4CQUWAbzvaiValAfNS3gloji5VD8w2dpmDNiCXPQpK4FmPus9A7KTXislMmVUi2iDJ+gf1scXJKwrAXdR2Ha6yqQ/hHNuioyc/GtawBIQe9Ci9EiYX+tWdNhPDPt2jjZxvvj61m38t1w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV4PR04MB668163.eurprd04.prod.outlook.com (2603:10a6:150:40f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 17:12:35 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 17:12:35 +0000
Date: Mon, 16 Nov 2026 11:12:22 -0600
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
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v6 4/5] pinctrl: freescale: add the Layerscape RCW
 pad-mux driver
Message-ID: <avs5doXCSvucsOdR@SMW015318>
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
 <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-4-fbdce4565a5c@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-4-fbdce4565a5c@free.fr>
X-ClientProxiedBy: PH7PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:510:324::7) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV4PR04MB668163:EE_
X-MS-Office365-Filtering-Correlation-Id: fa79aa52-a0b1-42e5-3b55-08df4404cee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|3023799007|4143699003|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261022075727099003|10067099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info:
	EvOjHFTxUR1L566e8t5fFTadV/l7+M37j0G60CYtKgV5qevvwYWgafNy4UDVXe9L5U+Ir4m3UcGGgrTYyIylz7wJhlxRo6NFmR02mdUq5miM0zxvSK5RE77VrAscAx4eePcfnhWlfMZSZjdhOFKnsKWr9/+eP+5C2g+jlOGPmw0xlyHMxHFrwF+Q/Q+4mRFYaI9pfde392RElG0BqR9888HjsP+JFSu8idozOwdNksOaJurNCQEYppM/qKSXjZK4DnTmsNskOB724VD8FRBnxz78RTR0IqiypigGWjZ0a880HB7k5fkniLpfriBL7ROYckMSsSNbPJkOOCFG1EJvIi1wKTGaDpUID+XmTJdZAyB6zexPGQ+z2SOqxrAISgac/wwKl+JyEq0if0zkIUqYkZf70DU60aQJ0zuoCIp9wuiGhMY1tjKh7GQXfrAoT0/Le6XeRipcRJIXDMAczxApo61aB3EBts8XmXeCdI/GXBLPIarVb+j6w0iUnD9hB/+Xh9HbgkrF2n59i7YRLkvNH9qIq5IPvuonLgzCdL1q2Xkr+bQc2f69lGfn7BeXTtemvFTSc5hDGyoRn5fr12cMiw+wdFvIevG/3bBZrlCf98Eh7DpPhQYOhQF4nsB2bY/za+N4Gefap5cWeWKQ6IiPK7KLh9uvDV/vN9fs+CUXaK1AMK4Xgwbw3HXvpFLai9/Ui2Qisu8tkiAIkDItqoqqQLuo/rMGdo/j5DNvsl3cj/3l0m/ww9tf29bOtrMAY/mJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(4143699003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003)(15866825006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kx3RysL710ipzPzIFQaoi3MuI06iRu4Z/w7IMBiA3ektVUvoME6iUIO94L20?=
 =?us-ascii?Q?nYPhgqFr0CnJnFfoKQp0bsSSTYoUf88puue6aCZr/Nu7cRgYRwC5bjqU3GE+?=
 =?us-ascii?Q?Y8fjEZ0d2wTaxg3mkc4bR/SvJZKAW18/FrRKAC0meL0kIM6anu4Q22OnBsmX?=
 =?us-ascii?Q?G2QfTobZpTueoNsT4LYMi52X7SAyD9BClNWcPYB9Zr5tOwkiM4KNUbqjQ1tK?=
 =?us-ascii?Q?B6ZCB0I4toKPqq9MQ4SDL9wZ2nV2owOfvYKFXcTxYpKY5SfXuUk60EFwKVUv?=
 =?us-ascii?Q?2c47JzUZd4fzu08gWNOlJZVrSNFeKbop0lbdcjBeE1bltxV8yZdXyNeoUE7S?=
 =?us-ascii?Q?HUFlLLQK15KlyW3wXLeuFrdOXyOo34PhIilNqVDHD6ELB0cTJWNNs29RB1mX?=
 =?us-ascii?Q?mq+eP/Fr8xBnCeV4wgt5Tbj3QJxVQNsgBSk7PDTiadTel0KReBQa+E/CG+ja?=
 =?us-ascii?Q?At6SMhL9TkKNnmCfdvWCMbAosmQBEZT5ZfheV5rSTr32keLeZxvO2kahm42b?=
 =?us-ascii?Q?Ee9Yih5vm2uoMFP1ivD8i3n+PhQwm+LuH6vx/EjeasH3U61b21/Rxq19pBZ2?=
 =?us-ascii?Q?k27Zle7ivJqG8QlBPNskFo4zYZj/yH9Rgh6G9e8vQHbC7AsjCsdVEZ51v1Di?=
 =?us-ascii?Q?ZoOLmH3FNdMYtdYDiIjXaLm2i84lwHNwg4Q9D0OZLOUGdkffM7akedLHgmVa?=
 =?us-ascii?Q?WgyoKzoSsxtn8AaK0ey7CnsowVY3sc6pr7WOEGFFlXXO/WvRC5ewUJzkFUim?=
 =?us-ascii?Q?61j7j17JBg1Ww/CtksZdDbfS9HYkD/IOv9uaZk8lWgGscYycZ7o3oFDBCjY3?=
 =?us-ascii?Q?xfrpZrMdQ+wJatLtwWguCjxM5nq03/EnPKZ5j3P9ydBDUJUj18XIvRXGEnRD?=
 =?us-ascii?Q?hxgvlgAujZGKKh6W/K3Lc0PmrWLjYYBesC0YqQO4RZxMSTEMPrW6F73NSzDg?=
 =?us-ascii?Q?dO78g+VOF01mwl4G6s/AC5/LTOTfwr+kUoZBTvzyjbSd/oC5e8fp4tfiUxyC?=
 =?us-ascii?Q?xwnISNCoYwAXm071QDFi0o5XlzO84xlfvu3UM4L+9Dr12lcm6vD58AaAzu2y?=
 =?us-ascii?Q?08YTQbm01feVtSybPfRrZLatlkrnXJSDMFgf4FMOHcsvYxcPuqWYz575S3Qh?=
 =?us-ascii?Q?W/RnybKZvS0FD2UFLBOSkzaYUKRLD2bG3+PDLyhIMsddH7Mf4tFZjkxsSFpM?=
 =?us-ascii?Q?mkBMGV8ApNosv1Reld0UK18LuRR9rK6I7/gHcdvTdltMtorsCr8RG8YvkIu2?=
 =?us-ascii?Q?V40iPhKquejOnCSRvClrntQ9rRImFDpqQ2SORoqacIQfD8TdVWy/AK460H2h?=
 =?us-ascii?Q?boadoAMLuo25rizAhzM0fzDCWUZ4yA4p4FrTGvYuaOOKZTSB9kOAUAlHSEoW?=
 =?us-ascii?Q?bDAQTxOccYse0VOXhSLMLGWcXq7SggYZpABEfsWDtQK2aYbun734pVsqjJJj?=
 =?us-ascii?Q?ibCR+w2s3PAoWQgFyS2mU5XurP+azJTm984jS1ZtgWZBFXiSRLKbG+pRIZJi?=
 =?us-ascii?Q?n407xP3X/h5Ty9cHIhnOhApAdEW4lhJdExVpNoEb760ZoDOH6pEQ7DNYAEds?=
 =?us-ascii?Q?MWkN6w9F+d5HTpAw8+W5Xc6O9rJ7dyIbIl4XtHlMGt/z/+nzTgZzazzlFu4s?=
 =?us-ascii?Q?Lkpd6+wqf+sukCUjTxiGA0dydksCS9Idu2DrkeEm0/VvIvDln0fSxkSorSK+?=
 =?us-ascii?Q?PlJ94n+DVcxTxSt0giXUX9mcxUNEu7OMH8JdBbW+e7bAf5o7VWNdevAVhaAg?=
 =?us-ascii?Q?3dts3XLOgRkNNNjmKJx3uizY/ZRCyBZVje6nX8Aedza0KDBThGVC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa79aa52-a0b1-42e5-3b55-08df4404cee6
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 17:12:35.3849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yl3ewwPtD43taPMsXgYdwKjKO2bwl5bSzfiYohQcyCp5YfiNuzjN4UDq/yMQeXpzJLkufmc17OgrgZI1fUx3/RXvbWEkII08ySV0e9Z1QL8nS5+0HasbhqUCZJgKw+kg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB668163
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 02:27:34PM +0100, Vincent Jardin via B4 Relay wrote:
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
> Add a generic Layerscape driver for the pad mux as a child of the DCFG
> node. The fields and their encoding are per-SoC tables selected by
> the compatible, so that other Layerscape SoCs can be added to it.
>
> Only the LX2160A is done: the fields of RCWSR12..14 and the EC1, EC2,
> USB_EXT, GTX_CLK and SDHC1_DS ones of RCWSR27.
>
> Then pin states select them with the generic function and groups
> properties, and every change goes through the RCW override
> of fsl-guts, which reads the status register, writes the override and
> waits for the status register to follow.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  MAINTAINERS                                        |   8 +
>  drivers/pinctrl/freescale/Kconfig                  |  15 +
>  drivers/pinctrl/freescale/Makefile                 |   1 +
>  drivers/pinctrl/freescale/pinctrl-layerscape-rcw.c | 427 +++++++++++++++++++++
>  4 files changed, 451 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93abbb315065..2df4866d37bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20207,6 +20207,14 @@ F:	Documentation/devicetree/bindings/clock/*imx*
>  F:	drivers/clk/imx/
>  F:	include/dt-bindings/clock/*imx*
>
> +NXP LAYERSCAPE RCW PAD-MUX DRIVER
> +M:	Vincent Jardin <vjardin@free.fr>
> +L:	linux-gpio@vger.kernel.org
> +L:	imx@lists.linux.dev
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
> +F:	drivers/pinctrl/freescale/pinctrl-layerscape-rcw.c
> +
>  NXP NETC ETHERNET SWITCH DRIVER
>  M:	Wei Fang <wei.fang@nxp.com>
>  R:	Clark Wang <xiaoning.wang@nxp.com>
> diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
> index fd53cf5bb843..8e964cf620b0 100644
> --- a/drivers/pinctrl/freescale/Kconfig
> +++ b/drivers/pinctrl/freescale/Kconfig
> @@ -283,3 +283,18 @@ config PINCTRL_IMXRT1170
>  	select PINCTRL_IMX
>  	help
>  	  Say Y here to enable the imxrt1170 pinctrl driver
> +
> +config PINCTRL_LAYERSCAPE_RCW
> +	bool "NXP Layerscape RCW pad-mux driver"
> +	depends on OF
> +	depends on ARCH_LAYERSCAPE || COMPILE_TEST
> +	default ARCH_LAYERSCAPE
> +	select FSL_GUTS
> +	select GENERIC_PINCTRL_GROUPS
> +	select GENERIC_PINMUX_FUNCTIONS
> +	select GENERIC_PINCONF
> +	help
> +	  Say Y here to mux the pads of the Layerscape SoCs at runtime. The
> +	  pads are muxed by fields of the RCW: the driver changes it in the
> +	  DCSR view of the DCFG that fsl-guts drives.
> +	  The I2C bus recovery needs it to switch the pads of a bus to GPIO.
> diff --git a/drivers/pinctrl/freescale/Makefile b/drivers/pinctrl/freescale/Makefile
> index d27085c2b4c4..34309ac7411d 100644
> --- a/drivers/pinctrl/freescale/Makefile
> +++ b/drivers/pinctrl/freescale/Makefile
> @@ -35,3 +35,4 @@ obj-$(CONFIG_PINCTRL_IMX25)	+= pinctrl-imx25.o
>  obj-$(CONFIG_PINCTRL_IMX28)	+= pinctrl-imx28.o
>  obj-$(CONFIG_PINCTRL_IMXRT1050)	+= pinctrl-imxrt1050.o
>  obj-$(CONFIG_PINCTRL_IMXRT1170)	+= pinctrl-imxrt1170.o
> +obj-$(CONFIG_PINCTRL_LAYERSCAPE_RCW)	+= pinctrl-layerscape-rcw.o
> diff --git a/drivers/pinctrl/freescale/pinctrl-layerscape-rcw.c b/drivers/pinctrl/freescale/pinctrl-layerscape-rcw.c
> new file mode 100644
> index 000000000000..46686c6923c3
> --- /dev/null
> +++ b/drivers/pinctrl/freescale/pinctrl-layerscape-rcw.c
> @@ -0,0 +1,427 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Layerscape pad muxes: fields of the RCW, changed at runtime.
> + *
> + * Copyright 2026 Free Mobile - Vincent Jardin
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/fsl/guts.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/seq_file.h>
> +
> +#include "../core.h"
> +#include "../pinmux.h"
> +
> +struct rcw_pmux_func {
> +	const char *name;
> +	u8 val;
> +};
> +
> +struct rcw_pmux_group {
> +	const char *name;
> +	u8 rcwsr; /* one-based, as in RCWSR12 */
> +	u8 shift;
> +	u8 width;
> +	const struct rcw_pmux_func *funcs;
> +	u8 nfuncs;
> +};
> +
> +/* The pad-mux groups of a SoC, one per field of its RCW */
> +struct rcw_pmux_soc {
> +	const struct rcw_pmux_group *groups;
> +	unsigned int ngroups;
> +};
> +
> +#define RCW_PMUX_FUNC(_name, _val)	{ .name = _name, .val = _val }
> +#define RCW_PMUX_GROUP(_name, _rcwsr, _shift, _width, _funcs)		\
> +	{								\
> +		.name = _name, .rcwsr = _rcwsr,				\
> +		.shift = _shift, .width = _width,			\
> +		.funcs = _funcs, .nfuncs = ARRAY_SIZE(_funcs),		\
> +	}
> +
> +/* LX2160A: RCWSR12..14 and RCWSR27 */
> +static const struct rcw_pmux_func lx2160a_iic2_funcs[] = {
> +	RCW_PMUX_FUNC("i2c", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("flextimer", 2), RCW_PMUX_FUNC("sdhc", 6),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_iic3_funcs[] = {
> +	RCW_PMUX_FUNC("i2c", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("can", 2), RCW_PMUX_FUNC("evt", 6),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_iic5_funcs[] = {
> +	RCW_PMUX_FUNC("i2c", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("sdhc-clk", 2), RCW_PMUX_FUNC("spi", 3),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_iic6_funcs[] = {
> +	RCW_PMUX_FUNC("i2c", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("sdhc-clk", 2),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_xspi1_funcs[] = {
> +	RCW_PMUX_FUNC("flexspi", 0), RCW_PMUX_FUNC("gpio", 1),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_sdhc1_base_funcs[] = {
> +	RCW_PMUX_FUNC("sdhc", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("spi", 2), RCW_PMUX_FUNC("sdhc-spi", 3),
> +	RCW_PMUX_FUNC("sdhc-data4", 4),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_sdhc1_dir_funcs[] = {
> +	RCW_PMUX_FUNC("sdhc", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("spi", 3), RCW_PMUX_FUNC("sdhc-data", 4),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_sdhc2_data74_funcs[] = {
> +	RCW_PMUX_FUNC("sdhc", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("i2c", 2), RCW_PMUX_FUNC("flexspi", 6),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_sdhc2_base_funcs[] = {
> +	RCW_PMUX_FUNC("sdhc", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("spi", 2), RCW_PMUX_FUNC("flexspi", 6),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_uart_funcs[] = {
> +	RCW_PMUX_FUNC("uart", 0), RCW_PMUX_FUNC("gpio", 1),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_uart1_rtscts_funcs[] = {
> +	RCW_PMUX_FUNC("uart", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("uart3", 2),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_uart2_rtscts_funcs[] = {
> +	RCW_PMUX_FUNC("uart", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("uart4", 2),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_irq_funcs[] = {
> +	RCW_PMUX_FUNC("irq", 0), RCW_PMUX_FUNC("gpio", 1),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_irq_flextimer_funcs[] = {
> +	RCW_PMUX_FUNC("irq", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("flextimer", 2),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_evt_funcs[] = {
> +	RCW_PMUX_FUNC("evt", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("flextimer", 2),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_clk_out_funcs[] = {
> +	RCW_PMUX_FUNC("gpio", 1), RCW_PMUX_FUNC("flextimer", 2),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_asleep_funcs[] = {
> +	RCW_PMUX_FUNC("asleep", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("evt", 2),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_reset_req_funcs[] = {
> +	RCW_PMUX_FUNC("reset-req", 0), RCW_PMUX_FUNC("gpio", 1),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_iic1_funcs[] = {
> +	RCW_PMUX_FUNC("i2c", 0), RCW_PMUX_FUNC("gpio", 1),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_ec1_funcs[] = {
> +	RCW_PMUX_FUNC("rgmii", 0), RCW_PMUX_FUNC("gpio", 1),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_ec2_funcs[] = {
> +	RCW_PMUX_FUNC("rgmii", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("tsec-1588", 2),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_usb_ext_funcs[] = {
> +	RCW_PMUX_FUNC("usb", 0), RCW_PMUX_FUNC("gpio", 1),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_gtx_clk_funcs[] = {
> +	RCW_PMUX_FUNC("gtx-clk", 0), RCW_PMUX_FUNC("gpio", 1),
> +};
> +
> +static const struct rcw_pmux_func lx2160a_sdhc1_ds_funcs[] = {
> +	RCW_PMUX_FUNC("sdhc", 0), RCW_PMUX_FUNC("gpio", 1),
> +	RCW_PMUX_FUNC("spi", 2),
> +};
> +
> +static const struct rcw_pmux_group lx2160a_groups[] = {
> +	/* RCWSR12 */
> +	RCW_PMUX_GROUP("iic2", 12, 0, 3, lx2160a_iic2_funcs),
> +	RCW_PMUX_GROUP("iic3", 12, 3, 3, lx2160a_iic3_funcs),
> +	RCW_PMUX_GROUP("iic4", 12, 6, 3, lx2160a_iic3_funcs),
> +	RCW_PMUX_GROUP("iic5", 12, 9, 3, lx2160a_iic5_funcs),
> +	RCW_PMUX_GROUP("iic6", 12, 12, 3, lx2160a_iic6_funcs),
> +	RCW_PMUX_GROUP("xspi1-data74", 12, 15, 3, lx2160a_xspi1_funcs),
> +	RCW_PMUX_GROUP("xspi1-data30", 12, 18, 3, lx2160a_xspi1_funcs),
> +	RCW_PMUX_GROUP("xspi1-base", 12, 21, 3, lx2160a_xspi1_funcs),
> +	RCW_PMUX_GROUP("sdhc1-base", 12, 24, 3, lx2160a_sdhc1_base_funcs),
> +	RCW_PMUX_GROUP("sdhc1-dir", 12, 27, 3, lx2160a_sdhc1_dir_funcs),
> +	/* RCWSR13 */
> +	RCW_PMUX_GROUP("sdhc2-data74", 13, 0, 3, lx2160a_sdhc2_data74_funcs),
> +	RCW_PMUX_GROUP("sdhc2-base", 13, 3, 3, lx2160a_sdhc2_base_funcs),
> +	RCW_PMUX_GROUP("uart1-soutsin", 13, 6, 3, lx2160a_uart_funcs),
> +	RCW_PMUX_GROUP("uart1-rtscts", 13, 9, 3, lx2160a_uart1_rtscts_funcs),
> +	RCW_PMUX_GROUP("uart2-soutsin", 13, 12, 3, lx2160a_uart_funcs),
> +	RCW_PMUX_GROUP("uart2-rtscts", 13, 15, 3, lx2160a_uart2_rtscts_funcs),
> +	RCW_PMUX_GROUP("irq11-8", 13, 18, 3, lx2160a_irq_funcs),
> +	RCW_PMUX_GROUP("irq7-4", 13, 21, 3, lx2160a_irq_flextimer_funcs),
> +	RCW_PMUX_GROUP("irq3-0", 13, 24, 3, lx2160a_irq_flextimer_funcs),
> +	RCW_PMUX_GROUP("evt4-3", 13, 27, 3, lx2160a_evt_funcs),
> +	/* RCWSR14 */
> +	RCW_PMUX_GROUP("evt2-0", 14, 0, 3, lx2160a_evt_funcs),
> +	RCW_PMUX_GROUP("clk-out", 14, 3, 3, lx2160a_clk_out_funcs),
> +	RCW_PMUX_GROUP("asleep", 14, 6, 3, lx2160a_asleep_funcs),
> +	RCW_PMUX_GROUP("reset-req", 14, 9, 1, lx2160a_reset_req_funcs),
> +	RCW_PMUX_GROUP("iic1", 14, 10, 1, lx2160a_iic1_funcs),
> +	/* RCWSR27 */
> +	RCW_PMUX_GROUP("ec1", 27, 0, 2, lx2160a_ec1_funcs),
> +	RCW_PMUX_GROUP("ec2", 27, 2, 2, lx2160a_ec2_funcs),
> +	RCW_PMUX_GROUP("usb-ext", 27, 4, 1, lx2160a_usb_ext_funcs),
> +	RCW_PMUX_GROUP("gtx-clk", 27, 5, 1, lx2160a_gtx_clk_funcs),
> +	RCW_PMUX_GROUP("sdhc1-ds", 27, 6, 2, lx2160a_sdhc1_ds_funcs),
> +};
> +
> +static const struct rcw_pmux_soc lx2160a_soc = {
> +	.groups = lx2160a_groups,
> +	.ngroups = ARRAY_SIZE(lx2160a_groups),
> +};
> +
> +struct rcw_pmux {
> +	struct device *dev;
> +	struct pinctrl_dev *pctl;
> +	struct pinctrl_desc desc;
> +	const struct rcw_pmux_soc *soc;
> +	struct pinctrl_pin_desc *pins;
> +};
> +
> +static u32 rcw_pmux_group_mask(const struct rcw_pmux_group *group)
> +{
> +	return GENMASK(group->shift + group->width - 1, group->shift);
> +}
> +
> +static const struct rcw_pmux_func *
> +rcw_pmux_find_func(const struct rcw_pmux_group *group, const char *name)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < group->nfuncs; i++) {
> +		if (!strcmp(group->funcs[i].name, name))
> +			return &group->funcs[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static void rcw_pmux_pin_dbg_show(struct pinctrl_dev *pctldev,
> +				  struct seq_file *s, unsigned int pin)
> +{
> +	struct rcw_pmux *pmux = pinctrl_dev_get_drvdata(pctldev);
> +	const struct rcw_pmux_group *group = &pmux->soc->groups[pin];
> +	unsigned int i;
> +	u32 val;
> +
> +	if (fsl_guts_pmux_read(group->rcwsr, &val))
> +		return;
> +
> +	val = field_get(rcw_pmux_group_mask(group), val);
> +	for (i = 0; i < group->nfuncs; i++) {
> +		if (group->funcs[i].val == val) {
> +			seq_puts(s, group->funcs[i].name);
> +			return;
> +		}
> +	}
> +	seq_printf(s, "0x%x", val);
> +}
> +
> +static const struct pinctrl_ops rcw_pmux_pctlops = {
> +	.get_groups_count = pinctrl_generic_get_group_count,
> +	.get_group_name = pinctrl_generic_get_group_name,
> +	.get_group_pins = pinctrl_generic_get_group_pins,
> +	.pin_dbg_show = rcw_pmux_pin_dbg_show,
> +	.dt_node_to_map = pinconf_generic_dt_node_to_map_group,
> +	.dt_free_map = pinconf_generic_dt_free_map,
> +};
> +
> +static int rcw_pmux_set_mux(struct pinctrl_dev *pctldev,
> +			    unsigned int fsel, unsigned int gsel)
> +{
> +	struct rcw_pmux *pmux = pinctrl_dev_get_drvdata(pctldev);
> +	const struct function_desc *func;
> +	const struct rcw_pmux_group *group;
> +	const struct rcw_pmux_func *mux;
> +	const struct group_desc *grp;
> +	u32 mask;
> +
> +	func = pinmux_generic_get_function(pctldev, fsel);
> +	grp = pinctrl_generic_get_group(pctldev, gsel);
> +	if (!func || !grp)
> +		return -EINVAL;
> +	group = grp->data;
> +
> +	mux = rcw_pmux_find_func(group, func->func->name);
> +	if (!mux) {
> +		dev_err(pmux->dev, "%s has no %s function\n",
> +			group->name, func->func->name);
> +		return -EINVAL;
> +	}
> +
> +	mask = rcw_pmux_group_mask(group);
> +
> +	return fsl_guts_pmux_override(group->rcwsr, field_prep(mask, mux->val),
> +				      mask);
> +}
> +
> +static const struct pinmux_ops rcw_pmux_pmxops = {
> +	.get_functions_count = pinmux_generic_get_function_count,
> +	.get_function_name = pinmux_generic_get_function_name,
> +	.get_function_groups = pinmux_generic_get_function_groups,
> +	.set_mux = rcw_pmux_set_mux,
> +	.strict = true,
> +};
> +
> +static int rcw_pmux_add_functions(struct rcw_pmux *pmux)
> +{
> +	const struct rcw_pmux_soc *soc = pmux->soc;
> +	const struct rcw_pmux_group *group;
> +	const char **groups;
> +	unsigned int i, j, k, n;
> +	int ret;
> +
> +	for (i = 0; i < soc->ngroups; i++) {
> +		group = &soc->groups[i];
> +		for (j = 0; j < group->nfuncs; j++) {
> +			const char *name = group->funcs[j].name;
> +
> +			/* already added from an earlier group? */
> +			for (k = 0; k < i; k++) {
> +				if (rcw_pmux_find_func(&soc->groups[k], name))
> +					break;
> +			}
> +			if (k < i)
> +				continue;
> +
> +			groups = devm_kcalloc(pmux->dev, soc->ngroups,
> +					      sizeof(*groups), GFP_KERNEL);
> +			if (!groups)
> +				return -ENOMEM;
> +			n = 0;
> +			for (k = i; k < soc->ngroups; k++) {
> +				if (rcw_pmux_find_func(&soc->groups[k], name))
> +					groups[n++] = soc->groups[k].name;
> +			}
> +			ret = pinmux_generic_add_function(pmux->pctl, name,
> +							  groups, n, NULL);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int rcw_pmux_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct rcw_pmux_soc *soc;
> +	struct rcw_pmux *pmux;
> +	unsigned int i;
> +	u32 val;
> +	int ret;
> +
> +	/* The override needs the DCSR view of DCFG, mapped by fsl-guts */
> +	if (!fsl_guts_pmux_override_supported())
> +		return dev_err_probe(dev, -ENODEV,
> +				     "no RCW override through fsl-guts: the dcfg node needs its DCSR reg\n");
> +
> +	soc = device_get_match_data(dev);
> +	if (!soc)
> +		return -ENODEV;
> +
> +	pmux = devm_kzalloc(dev, sizeof(*pmux), GFP_KERNEL);
> +	if (!pmux)
> +		return -ENOMEM;
> +	pmux->dev = dev;
> +	pmux->soc = soc;
> +
> +	pmux->pins = devm_kcalloc(dev, soc->ngroups, sizeof(*pmux->pins),
> +				  GFP_KERNEL);
> +	if (!pmux->pins)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < soc->ngroups; i++) {
> +		pmux->pins[i].number = i;
> +		pmux->pins[i].name = soc->groups[i].name;
> +	}
> +	pmux->desc.name = dev_name(dev);
> +	pmux->desc.pins = pmux->pins;
> +	pmux->desc.npins = soc->ngroups;
> +	pmux->desc.pctlops = &rcw_pmux_pctlops;
> +	pmux->desc.pmxops = &rcw_pmux_pmxops;
> +	pmux->desc.owner = THIS_MODULE;
> +
> +	ret = devm_pinctrl_register_and_init(dev, &pmux->desc, pmux,
> +					     &pmux->pctl);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "pinctrl registration failed\n");
> +
> +	for (i = 0; i < soc->ngroups; i++) {
> +		ret = pinctrl_generic_add_group(pmux->pctl, soc->groups[i].name,
> +						&pmux->pins[i].number, 1,
> +						(void *)&soc->groups[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = rcw_pmux_add_functions(pmux);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < soc->ngroups; i++) {
> +		u8 rcwsr = soc->groups[i].rcwsr;
> +
> +		if (i && rcwsr == soc->groups[i - 1].rcwsr)
> +			continue;
> +		if (!fsl_guts_pmux_read(rcwsr, &val))
> +			dev_dbg(dev, "pad muxes of RCWSR%u = 0x%08x\n", rcwsr,
> +				val);
> +	}
> +
> +	return pinctrl_enable(pmux->pctl);
> +}
> +
> +static const struct of_device_id rcw_pmux_of_match[] = {
> +	{ .compatible = "fsl,lx2160a-rcw-pinmux", .data = &lx2160a_soc },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rcw_pmux_of_match);
> +
> +static struct platform_driver rcw_pmux_driver = {
> +	.driver = {
> +		.name = "layerscape-rcw-pinmux",
> +		.of_match_table = rcw_pmux_of_match,
> +	},
> +	.probe = rcw_pmux_probe,
> +};
> +module_platform_driver(rcw_pmux_driver);
> +
> +MODULE_AUTHOR("Vincent Jardin <vjardin@free.fr>");
> +MODULE_DESCRIPTION("NXP Layerscape RCW pad-mux driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("FSL_GUTS");
>
> --
> 2.43.0
>
>
>

