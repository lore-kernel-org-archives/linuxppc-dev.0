Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B594606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=IgvcejVP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTd9Q0hbnz2xPb;
	Wed, 18 Nov 2026 08:27:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794950842;
	cv=pass; b=M1/iZMvhUZo/58qsa3H5Y3LR3kdUyWIBnUUrpSVxBX1BA0xtzgQmdXol77dEbkrXeHCUOcp2jvbLnAUAZ29vjtb1R7UjWudn2QSEmAoHiKd3qM09lAUSOO4+oW2Pk7Dhn35G8B+qGJBTT1PyHCthvHfXxdWgpEVFksUmbtqAsuLBUQ/0n7zj13MKz4Bxg8pzyvuldYTDGwUWcbaIQ0WMV/IXx2kZiJQvfMqGGo/Ahx8XE2qw1OWQbS6Vtvc8Gu78g/iwOIjptPZUz6jcc2NjeTAF3UkPqwBxJUIqKonfKLpKiMsfP791ICvxgdDTSQ+RAMnCMbLX2PYi1fBI6MVkEA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794950842; c=relaxed/relaxed;
	bh=d1fXAJ/C3j+HZbD62s0P3FAMtkAwER4hhXiDRqWQ8m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ebjvm4CvINpJpHiAgLq+T+Rgr1PQOpOrSEf4iwHivXUk31k5ZceDEljbPXi6gg3OgQiK+ZNgAi1DU2MzOVRf+sLLKqnStHt6lWWkVBmBN7WpeE9xHi2x5yNW1ZCLkvak/JjLo2jKPKbCu5Bs8Y8J6A00cJPAgGps+ZBJ45oRhHV1UyMgtf/fPEFSWZyaKEAn0HrywlVgvOrwQI/b5c7EweySKm/Fp2rzqubCuqNlh6yeSNaAu7oeQ4hjV2DWEElmSN1c3VQKnNkglqLyIqEGKY5sXGrnsPOhSEzRX+RiZtKSWHz6h/Eno4qtUm5LCOybx72hQmK+Oaj85jwwTiDVww==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=IgvcejVP; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=IgvcejVP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTd9P31XDz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 08:27:21 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpjbEz90HhBbt1SHbXvxWv1klRaA6AuuFSanmAs7Dgm+d+G4wTrOVQwwhl9d7s/GLO7B3+a+UKeVzNuipsguVxMacYewE51C9tgtKMMQmVgaYTJ9v1T8hhZJXLtH8GVkfIQjpPrD5+Z/L2LLZZ8fEbz4hMKZwNItqjb/Xrfxy9wA9cYoZJmG8OII/kbGPfSos819+Vc/MtqR2CuIQ1OVX0fg0FAXx49G+Jy9+3/aaftYcdLFcxu8lp3mWqntLUryBt1MKYmKfNdpIABbTJ4L3+Wlr5/dRsfHSr2MadlWKJkoqww2Lwy75N5pAH47s6/bbBO43OUNEdUi1yfKXszgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1fXAJ/C3j+HZbD62s0P3FAMtkAwER4hhXiDRqWQ8m0=;
 b=N4a6+jh9hafFyh+aOpaaUus5NnZp/AVVAwtIjfxmOES97UjyBK1e54EWZPzLyB5gegiFqYjvVzkNeLm7H0m9+KEp+Cu0ZLDFncEI0gHc2aG7Kw07mqw9rg8qL/3YXzw5nLv/ZD7VSULmnCKTmlR0AINNtWTEkRScrYOmPBXc0cCzi8tUtw7iXLYimwcFkt0Scs+2GJ8NWiWTEByXnwsL4Tquz4M4X4BBEv7e0480ilhVcaSN378qHDNjbZYpNVlTjHSVi4DiT+XckUz9ZWJTcdKNPmSQ1s3n8LRPUIbE0AxhZrswlW6w5D+BlQfYnPPBTdaBqJb4XVV+P/vA6xd+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1fXAJ/C3j+HZbD62s0P3FAMtkAwER4hhXiDRqWQ8m0=;
 b=IgvcejVPOGIvcZHW6MFnPFb/kmS9/y7GH1sV44cF/+sdkPBdodoWgUHEK85/u92fQhwaYJ47lFSgtBKi9pFd6nzqP/DkOyvSYbdYD+0R8BiUa2ZQkt9GYb/OePH7Xrgj6SVBRP45HSDLbRazGtrxxd1JLZYmTXlvyQRwwd95SmK5Wbm/D2guBoj5KmlzOqmG52mrJnukCj1O/v06vuLboZGcB0SmtBPMYHQDn0XbJZnRWo/9BitU74aa2H27Hb1pi5twZRBry6368RdS0gOAoNfPIg57KWqQrOVGygug5TOvmShGy6GWQhEzm05Ucujy1ecNs4SKSe6u9vVb/t8eUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by MA8PR04MB391102.eurprd04.prod.outlook.com (2603:10a6:250:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 21:26:58 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 21:26:57 +0000
Date: Tue, 17 Nov 2026 23:26:54 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: vjardin@free.fr
Cc: Dong Aisheng <aisheng.dong@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v7 5/6] arm64: dts: lx2160a: describe the pad muxes as
 the DCFG RCW override
Message-ID: <avzGjhMNV2pRRoDO@lxl00025.wbi.nxp.com>
References: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-5-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-5-5d7201970629@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-5-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-5-5d7201970629@free.fr>
X-ClientProxiedBy: AS4P192CA0049.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::22) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|MA8PR04MB391102:EE_
X-MS-Office365-Filtering-Correlation-Id: e3402584-0873-43c4-5dd3-08df44f1827f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|19092799006|366016|376014|1800799024|7416014|18002099003|6133799003|22082099003|3023799007|11063799006|4143699003|56012099006|261028144727099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|10067099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info:
	Qs0VmnYLj0OvAGfxHJoG38Hp7z0mmUqkjNQbHK3GaEnJlou7iWHnrCUoGpd88KR7G/Q8ru32ffoX2ni/aOBzqBliQfwe+Sk/C6hMulHhnnm7wG+9urwBo7eSMaeFRUSjwLOgecVH6rusRuDQtok/awTLiG+JLJR4an/+HXPUtgKXScOq70sDbbE5oNazW3jJhL1651S0iwgCWZIJnI+jYrXrmtvVVuBtQyV/A2ng0F4ZXdsM04rP3oiXg9Wf6Fc1txyng5uLyNVATx3HOy024hRJ1d96MVqD/7Oc12+tXw6lObfXdqWcn2ecprHFpzEBEBXuRYXpzbwEDzNYWyxNlhHXEsP6oP0gNcJVXDRH2PxYYOmF5a28z0TlZZ6FH3Eb6+SdBpZXtJ9TY4ERfi41s1C/zU1V3XhEGV+I2uhrtUOWSmr6IK8vPTNtOWLrPj+7qZbJldImSV0a388CZbYpkX1/gBzzb9CBts+KPj5s4B6Q4GqU6RyXvzLCaDvyr1xX42m6g3hIoAUboipcyo50nbv9rUECGWDD3MgEXcuWQH4LCDSqYWEAgaZoOnduCrkezwuc2VocRFClou++xtYw06ksnyEUBuHomTJKd+IKAMtp5Sb7GJgVktRlu9Uudodw51nSIaF3sLbgjBvil7JSXP2T0JlQ7UrKDLwvoQbDdGeKoLY8zmxsdk7vS9q/nWLywxkB4WKe9n37YcmLrk0E7meKmI1viyI/91cCj2mheh6NPSA4rpsW6tbFucFlsNzH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(19092799006)(366016)(376014)(1800799024)(7416014)(18002099003)(6133799003)(22082099003)(3023799007)(11063799006)(4143699003)(56012099006)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(10067099003)(15866825006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9cQWKULhSpUwkkZSNHNYzEsEy43ucnLd2eicZ06FqEgFJEO9G16ZpqSQr53l?=
 =?us-ascii?Q?SDKGrEqt4AiMCPfRFgRrhxAkuNINyhzQ8qSPG1/FeNT06xyS7UPgY8Csryur?=
 =?us-ascii?Q?RWraC0aHAP3DpGS1GiDmHWxypXpeXhfJgTd71S9tdgvLeCddezfim329rmLq?=
 =?us-ascii?Q?N5SNY2Mm0dLDCtkAQyftGLTnlSuFn0kERgj4vfSjGVWjB0Oh+PRYFbYiGcKo?=
 =?us-ascii?Q?dRHUREZUxqXPWfV8vK6NvVuB3IYO3lLO+GNY0FsLnXbyNpIW3J+p+HFzLttS?=
 =?us-ascii?Q?g6/XFweDLLe1SVKwDIIgeQe9MVBJw/Wqtji5+Uu83g5SdeZV68GxVJvn3/mq?=
 =?us-ascii?Q?5D4J8n1enEGBz9ibiwPjOr9oPxqDMn3Ss+idGJOTXkqgCIVioVMxKdldafc+?=
 =?us-ascii?Q?ipvBf/8n9kE78nBw0huQcGsl7J+8tJu+z63vsjbksMs1wi1bddGkbgWpDR1I?=
 =?us-ascii?Q?Fv5JBCjJM45W00x6NHEcvZl0v0pR0CgdleOqB5VQrojme7dvW+aspjMv98p/?=
 =?us-ascii?Q?eCt7K7HEhvMtP7OWlLmB85EyrORbAj92a1a/kMPJCkHKtll4ZqwUfLE2gy/y?=
 =?us-ascii?Q?DuLbJhK6q993x7afsrwxmJ4CacYdvzeVZN1tlijYYauvjn+U+PhkPJihRF6Y?=
 =?us-ascii?Q?vjAprG33Afu067CfQqIi//NIUiFD/nBLnU6jpDHgESVVeK4Fk31bnidSLmVA?=
 =?us-ascii?Q?yYKCJC+u25Fi0DDzfRZ7mhlwbh+GiQfdKYdWwsWGymBnmqjT0os8g9lMi/8u?=
 =?us-ascii?Q?1ZWkWvIXI0YN2+SfDDjqwj4NyPiY5ipb5Q+D15j0XVhLCFrtkJqwEpsXQSeQ?=
 =?us-ascii?Q?yBwqKNmUdfqNb/aAjs0R7z9HI/lUP6Njj1iHOPFYmob9c8bR6KDiiGT+QJdr?=
 =?us-ascii?Q?8W/jnZ5TW5MQfSvr1+PA8GSnb8GM20HAHGzuM9Is/Acqse7MKoVhSW2jkmka?=
 =?us-ascii?Q?puQcU9MShis+Lyf1FQ/6zqyQYyhXrp59OzDgLCIMwrC+/3X72zZAnYhgY+2Y?=
 =?us-ascii?Q?TLAj5azs8ytkumKzrR7PPSxdogm0x6Tvho0n5pu6wfrK2g4YCxfRyISV0f6V?=
 =?us-ascii?Q?2Lsxtwv2wH/2Zbxwh00iruwdEcWPaM1l6XtC5mEFSui9R5+DFhLhhhpv0Ns+?=
 =?us-ascii?Q?fQo/p5sP+HfkQXcf2WKOvMZif7yoPsNVfRDJLjXjbm0xekaVSCjq7f1dmheX?=
 =?us-ascii?Q?KucpD/+YsKIxuiXo872ycsw3zSMIvc2yoDtPqHjOjHHyZ2qBjoevmuQ819l4?=
 =?us-ascii?Q?Ap5FgjM1XZxhloMF4QvN4/PoARJiIO7LRkPNUqYGDBB5xof6LxlNLmtMHu3n?=
 =?us-ascii?Q?CIZe96pdvoEtFCAoB9tEG1UTSeO6ZArdMrPD/dch3909k2y3GQMkbZ7LzYF3?=
 =?us-ascii?Q?1/23BsC+BHPMa0E2kwc37C1ikOG/vr7LCWKR0jm8+Oic9ZjPTvBH6WCnpRIq?=
 =?us-ascii?Q?9laiViAWRvNGXhfRmhn1hFWRiyCpTv9bTtMeryB6IXZU/SkMy5Xki9oFvSjc?=
 =?us-ascii?Q?YKMd441ApSnC6u61uk4A4+dgFFogAkqgw6YLCmQkisf7jsfi9i9CZ51PsrSp?=
 =?us-ascii?Q?cQI6i6WqWzbSX7hOtwFh1GyQ3dD5q3g0yAmAq4mQUstXpp0vWGOa7wqctCwZ?=
 =?us-ascii?Q?0cQUAII/xkJAX+AfcOzeTyA4Tv5hV/hg3H3pWDtPxp9LT8ewt+2KMSPJC/X6?=
 =?us-ascii?Q?Uy+zwUsjCa17dO+6NiKXppWs8lfodySaN8AQer4TxupaAoDGiaXiSbPx2qJY?=
 =?us-ascii?Q?n54KE8MKUm97u78DE+IUiuxYcnshkgsGC/+F/05yJ49N2YrrNVGufrHVTEVD?=
X-MS-Exchange-AntiSpam-MessageData-1: x7U6TOUqO0xmeg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3402584-0873-43c4-5dd3-08df44f1827f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:26:57.8340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Txkn4mxQH+e07CLS5lKWUTwmNf5FQLETKJuUtHtIiFE4WeH93Hmf6+VNVOKgwjD3yC7T0XTgZFKJCLgtJHpCjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA8PR04MB391102
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 03:53:15PM +0100, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> The pad muxes are fields of the RCW: read-only in RCWSR12..14, changed
> at runtime through the override registers in the DCSR view of DCFG,
> which read 0 until written.
> 
> pinctrl-single on those registers, since commit 8a1365c7bbc1
> ("arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery"),
> clears every other field of the word with its first pin state:
> a board whose RCW programs a non-zero pad mux loses those pads at the
> first I2C probe.
> 
> Describe the pad mux as a child of the dcfg node, which gains its DCSR
> view and, as on the LS1028A, the addressing of its children:
> the child is at its RCWSR12 to RCWSR14 and RCWSR27 windows, one group
> per RCW field, one function per encoding, driven by
> fsl,lx2160a-rcw-pinmux using fsl-guts. Labels and pin node names stay,
> so no consumer changes.
> The pinctrl-single node goes.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

