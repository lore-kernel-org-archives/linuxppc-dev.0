Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE3F606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=UDLssbJO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTcks0mYpz2xRm;
	Wed, 18 Nov 2026 08:07:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794949669;
	cv=pass; b=AhIEhGk0neuVWU2bm2ASadjp7yadgYyaiExLetCcx6XTwsqaIvVkucC1EWn9Hl4mBU20Pgoa1BXnWUOaRBT8/44tsdeNpByFjjC2+iQI6tyZ24K2npGN9JELmnamLt1R8ntz/UZLgmAaMTDPIHuOmlXAxt0A6QsNaVmTfww9SxzsBFEnrRo+hNNgYNNqCjrpZPe4J1C1n+yMm7kYs3CFLIbGGTfmTbaQFei2nDXjcxdXILE3/xBi+NzsvgV5Y/CMOy5x7gYWTZLeWJJRENqu/M71adq7s4deQUngIXi+i2QaLhTQmhb3p1IW7DHXtZZbXV8z+YEHC4L39KcgDvTNlQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794949669; c=relaxed/relaxed;
	bh=1/SewMH1WpRsm5/XJDgcR07cRKgzvhZWY4IcYzb3tn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Shx0kkp8Xl18V1noNDCPwHuLX5oXSeiSvS/CYIik/OWqVgr4W0S71xpZqenfO/Uqw53LPsg6QzrlvTiCK8Ckcihj0rSkFpEJvWX42zCjgFd1cWxicQIrcL4jCT13qorKey4F4YPpWp0a37EJTbqpJaHU4yL0cbbat96sIgV4HgnslciCUvUc8K/NI6GuJl69WtEQJTMsnpzTKZQDiMErPy6vmOBzmsQmZYictOoIVVlBiVUldiiQZAZ0Gg2KR9eVK5JpgZMtUT7TDW6Y+pGUEGXJTSkTBI3mxXKQwSWqUf9x9QFzi0Zp/bGRndOjcanG3QzhJP0Ul1Fia7Nsa6ePDA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=UDLssbJO; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=UDLssbJO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTckr14J1z2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 08:07:48 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMY28xN60ziEFvZqJsEn1gytlhfUHBbTkpYUSpj89dQbw745MDsP1W2bcTp9fF2EefAUfDhXihlGHsUAmplhcfw0XCmihvNT7gF2ev3oDvqfPoL2cfThT7juqptiqGyEDDxkZKFyHqxyrINqNXf0rX8FiY9AGkzBmpEFKe52MlGh8HyPeoHUPsViz8DDouvjxZL4uhLB+NX7WGv0+WtxYajSZXGKeNKBeq/BlfaZDPeW9wIB2XCjX3xp4MCt01mpLh2ntjif4/WpK7SJp8oUzYfMoXUCp+MrUxGrHF2MAhJO60caIGTGJ2LCWfYBgTx3tprYICylXjXTdXU8j5Yf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/SewMH1WpRsm5/XJDgcR07cRKgzvhZWY4IcYzb3tn0=;
 b=EgsON6A5Y7AmnOaH/bp7PSI1Urz1+VPSb1Z8WdaN3JgdIR0BgXmsiZYjbOgP4rX0WnkCVnnGUJmhgwWKjDrwbX4ZTEzy520xO+QG0auw7kZHwZuFrtHq+iJ33jNkCKCplT6z5uX1qaCqoL3eRPo2bASAqibK9Pv48TCSuvZ/lNmgDev6+tZnLJXBKIKzkz3ka8VdE3IBp6oyySLc2evFK8DFeFx0RFJNuLHq9DZciFe0hjVfzOUHfKO6vw2QyxCxQqCnrkd0zwMUu7QAIvttjqtTtUnv+2KfZiYP3jCPoFIgWpPbjUyuPuXUfIXWqalr/oAtxGO4wDMClnhaK3EIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/SewMH1WpRsm5/XJDgcR07cRKgzvhZWY4IcYzb3tn0=;
 b=UDLssbJOdfR1SwqYlMn8MlzhWbf4D8S+XfeeqvjdrxNH1SOjuLHngMM0u4u4I8n6noGY0IY1lNG+3txAQQI74TaNaQIUxiXxZ0j92Mon+Zb9gcCDMEVIRP28KqXYVROhcSSN63eTN2mMHaCEBIYCMzZBCsZTdsB4sM/Ste2JrQ8sC/EiUPDqM1WxiHou2WNkzdTwChSbbo+nZciVLK5Sirb80P7vK9Rk0tsW5kd7TFkcby1Ir1Q78nEL0PXayhDCUtWJpF8qS+Qqe64lL/zhPr+8E0Z8eWiACuCvbkmMfvs829t19t8EFSVtd9GRzUGLQqv4y0cy2hZXhiMXLnWHFw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS8PR04MB8915.eurprd04.prod.outlook.com (2603:10a6:20b:42e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Tue, 17 Nov
 2026 21:07:24 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 21:07:24 +0000
Date: Tue, 17 Nov 2026 23:07:20 +0200
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
Subject: Re: [PATCH v7 1/6] dt-bindings: pinctrl: add the NXP LX2160A RCW pad
 mux
Message-ID: <avzBgDksGfXb-MxZ@lxl00025.wbi.nxp.com>
References: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-1-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-1-5d7201970629@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-1-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-1-5d7201970629@free.fr>
X-ClientProxiedBy: AM0PR02CA0119.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::16) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS8PR04MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 9324a5ae-ac94-48ed-0a64-08df44eec6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|1800799024|376014|23010399003|10070799003|22082099003|6133799003|18002099003|3023799007|10067099003|11063799006|261026121527099003|261022105027099003|56012099006|261021121427099003|261026140227099003|261102123227099003|4143699003|261028144727099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	z0VF0PMhEYDLaRY4WZGWIU9Jj0vS/m4bbEv1DpSVxEk5YtBBZqb/psWkCM5akIZFG8mvnApKGqOyxMdUffuXzwXvsUj3u63Yb7Roq1CuhiClux5XtF2PQpuXgNj5JGo4LsiZELMD5x246GbQzbEATM8FdXvpUqeOsDjD6RvLmkFAZXDIcb2XW11WPZL1xegkLAWj+evDVpUH7/ElouMPJaHlOSQg8bIQxhnZIQhY3u/Wk1qmrZg8bnoAQWZIWQqg/xawg5lTmCT9cuvYrE+1i1hT7QPcwprZqh3RBjqweVAMGhDnAuWoP+fEayYFW/dAoTsavFlcYXq0fe/6c3pGvVeo4L2S0qJLpAHux9SGviVNbIe9iiVfnD2lzsmIdd6y/P6sRVCyUFiderZVEzjfnF6TAmsU3llPKZQ3HfrYrUQ9BhewB7UoJlPmeudsRLsbE2WQHw+TmYFH3CnuhstAKrHtIhQn3qLULSVSv4XWwBHzq/oen2HxtJPV4oA3hPxbe00L37kL49wxAaA9JeCWjbc7nGcWm0zDW/XYwez2BtHmZsqruRhDgeRZRllLKnYqumBDiqVZiZEssbrjwddbDz3SFQpmlIpOmslR0Okkmecq8fh/Pq6wjWPDkDcNHqHk9aOeSDMgGw1FsD/ZvUX11smUHoX0xuEa633nUywfcGL7tupzwIPcTf9v3EPpGUoNdUJro983x3X2EsfwegIVsnaUktQFXrVFe9u+3JY0NpMWtvxpXt93glGfm2WsYU8D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(1800799024)(376014)(23010399003)(10070799003)(22082099003)(6133799003)(18002099003)(3023799007)(10067099003)(11063799006)(261026121527099003)(261022105027099003)(56012099006)(261021121427099003)(261026140227099003)(261102123227099003)(4143699003)(261028144727099003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9VWshaCeqA7TykiihhKKL1kacFAi597eXMHkTV2qZXtM00uvzMDhR3/zlMsP?=
 =?us-ascii?Q?vKxSdkSCIMaIiEGRiuUCyxbLJRPVAm6MVuHSLKNE6ACiNfZwCaP+s9RTwXae?=
 =?us-ascii?Q?uu9u2k+ZF5G/IgieZlbVU/2Lv+ucFnE/6ZAHdxhM7aSmwb1Nd3JDimNCtvCW?=
 =?us-ascii?Q?WQ62Td0shnHlI8Zwsatq7u1/Af9sMuzHkuUQ8a4J4+Oug5KZ3868L1LJj2Eg?=
 =?us-ascii?Q?QtCBoIstCLUVFv6eqjCk8aBaa83znR1mLiUVioMxT+sxj+maDLamSq//K9mN?=
 =?us-ascii?Q?nzx5M+AkDfjCr1oe3eTxcrHi9HfThUehCzZetvk9Ai7bzbMhaqnbLgNfp7M2?=
 =?us-ascii?Q?/opI/kg1PHmIVje3tWYFlJ+K4dsOfW6LeBN4PrXqOytxPzuQie56NMSP3pm5?=
 =?us-ascii?Q?3I3bGerTozGxxTJYv0RR+Ccg/UbKTERxLfk6WR10+RsYJ+SEwk0u4c7STgG+?=
 =?us-ascii?Q?MQ6NpC2KpZDerGDFBQ5nY5k7z5CHdJ1qd9l8p81i4Lm/yb4I0J+M/5232dux?=
 =?us-ascii?Q?U4pKmX4jLaRnwD1e9WeEW97o0lMO3gm7G5IO9vGdY/5tu5H2mPRxYbuI8W3N?=
 =?us-ascii?Q?YURlAerJt2LiI2CbaK0mimmjUuI8R/YezaVUjCsLKCK/hTPoDJ8NL5duj1FL?=
 =?us-ascii?Q?AWYntf+uDMkxOFHSc/3CqNfxiw/hpCx+gE2KlOkbbK3BnV60y1PnvmG/4sIq?=
 =?us-ascii?Q?8Ei7spsFzAIdCn6McKdwL6NMXKoX5dP1IlW53jdrpv1IsFb4YEn+cyfmwxO7?=
 =?us-ascii?Q?rALQLldIxCyoDWWl1iI6OAI6SmusFfZDnigSQor7y7zrrFSsHcrhCNHxlxyo?=
 =?us-ascii?Q?lX91QAXO0sAKCvsEfyG2i+4TMVqML1fTLvXhM/tolLWtTyk9jpPlpHDkYixz?=
 =?us-ascii?Q?VcSc+b0dIXgrKQ6HgCvP9Lx+WwRhgUwKWiMEWuHVJe5Kf7LC51VW+ZE2outH?=
 =?us-ascii?Q?i8ZLrVG1FkXYKQhSIOfKY2GwvMDXI51PpqY0/3XTkj1rDtSmvm4j58YBIng5?=
 =?us-ascii?Q?wO3xK1FjIRBaepi+MlVwGIvKJ2t0jkwbrtGQ9UaZ4oun06DI3LkA2OQ2e68z?=
 =?us-ascii?Q?51A7dRAMViSos7yf3LQRJVgfikulhypKJ3unLQ6dcEItd26M56S6DFS4eNZm?=
 =?us-ascii?Q?MvSUCgAGSm8VNYpXtE/SVcfISeDwHdYeXTBIQsJ5IjiKfQKiyMEaDRNzR8CX?=
 =?us-ascii?Q?//gOZb/hloqUGI2ouhFWXOkOPAc5uQZZibG4g6lf+arBvUFo3iBtgLa9clMc?=
 =?us-ascii?Q?Z0S0/9no7BEshvuc+URzyp7rFhA7AbQCAVLmO4OVoYzzNRpW5Vuf8OoXiGAY?=
 =?us-ascii?Q?exxQzWQWKnG0y4de4UUew5xTIUbn78ogQlPbG9uqMNdsfnExeIK8tApa8dXT?=
 =?us-ascii?Q?vwczAbxwn7GKVF8OK2nNoYxUaHwbQrhoYCidbQhyN8lNwjqb9POvi+6Kod4R?=
 =?us-ascii?Q?aYkl1uGRQ2VcwAeBtbD+P3eUOj+/8vp/Fj1ltGDVLT3znDjmt01PbvtmW404?=
 =?us-ascii?Q?QXToFysx2lbwsQoWN7Gg+kA4SrsYcuzSObOnDWQxvTEa9ZM31AdgXgiUTGWh?=
 =?us-ascii?Q?eRFBisgS5qERd+Oa6mWMxUJ3v6FGL6xZVjKav8LiZv6M12Fe7IUFTsOggHaE?=
 =?us-ascii?Q?1wNuEak8FS09SDdl8dpSVEqQAouG/RIAToWE8O2kPbmngY9qdHfEM+MtU2zF?=
 =?us-ascii?Q?Dvq7/WpyA4i7JIvMQHipoiCEUc0pEUGR3pbGY//khTFSJS61hepZI/mqCyqT?=
 =?us-ascii?Q?FWJAnkKascAx1dUYz7NQyTcGQGlAYHJJzVihNRdGXxN3UG2H+D/1YLervpFd?=
X-MS-Exchange-AntiSpam-MessageData-1: kAFEvp7+WYAu7Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9324a5ae-ac94-48ed-0a64-08df44eec6d1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:07:23.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJTAtvsq8/EvuUbZxPKPKheusevsFkyQ/pwhhCD2c3D+yQ429R9fucIYJgQ49CdagahW24qBJJ398Vtgm18MBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8915
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 03:53:11PM +0100, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ, EVT, EC and USB pads
> from fields of the RCW: read-only in RCWSR12..14 and RCWSR27 of DCFG,
> changed at runtime through the override registers of its DCSR view.
> 
> Describe the pad mux as a child of DCFG at its RCWSR12 to RCWSR14 and
> RCWSR27 windows: the override registers are at the same offsets of the
> DCSR view of the parent. One group per RCW field, one function per
> encoding.
> 
> Each function lists the groups that take it, so a pair the driver
> would refuse, such as can on iic1, is refused by the schema.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

It's a bit difficult to manually follow all the constraints, which are
listed in the opposite way as the RM would have them (function -> valid pads
rather than pad -> valid functions), but AI says it's OK and I'm not
spotting any obvious problems either.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

