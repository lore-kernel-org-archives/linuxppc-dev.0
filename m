Return-Path: <linuxppc-dev+bounces-24939-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1E4C53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 13:48:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8cHP5GSCz2xyh;
	Tue, 28 Jul 2026 23:48:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785246497;
	cv=pass; b=Yl9L4CWiz4Xfj05alXFgusJ34Snq0VIWBe3FJHFzHy+dNTNX9yQNuNKVJsriVt4mqtSVYAwzUJyseNRLDvyJGawmDlK+XbhVkZODaShpT4zZTVsEZR8JAiLiUKpa1UnX/yL5ECRAvsuyHA5Iv4WPUBh826lyKrusn8ppXov9XM1iov6hyNEQd9dsy0P3WGo+R3tpFtJm99pEvW36yc7tnMJSFdE2uxt0o5dcGmVYuWEmUgCuClBZa7inAP88x2j1+AGyN6hbIwy/1I5XWzTJQ+S3lJDloL2QACeYqXKEcnvDAVsbn3qtahHUat+nGbp3fZJS1H1+o09EStS1HdBD5w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785246497; c=relaxed/relaxed;
	bh=JlU3GC/lZWKWvY0pjhRkOV34jKOVc8c3N92R/QR+uY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LKH0FwZszMmwjMjPUNWyT5DFoRc6JQuR6ueZGu7vT/gYR/wl3s9TMqgQE8QIVl+Bt5nMFAnxXFaJQI8GsNIFVYdbetmDqQltjrt3YuBSEdklhAytBHhvHNcVawUJ7gcDUXvnvIw5PA9mI3hrr7JVVuASZQmt35RN9ZVj12CQ5TYBFON54SXUmJ/j/d38O1Ba1lximtZ+QcgRYcdtO/fgD7D4u+agr522gYrXQdfUpNjcAZbhZiHuOhUSy20bc5sIXG99Up+sta0rLgPU6lJJhoTCAO8Ja0IdPGw7T31QGY/tOZbidvk1ZdOg5lKzxRsEUBmxtVlH6Nx2qm3ZDn3UGg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=KZQCYhJx; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=KZQCYhJx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8cHN0k9qz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 23:48:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIjm/P9mt/IkI3g0KaT2J9wTTN8ZaOQBl+DAo271yOPGGQqg9U3qBkIvNr/JdUh12i3L0vik/B0wOlggM13PeJtwXEv4CSNYLZbAVm3mKrikp9qa3QxpS2l64BrGWzNpyDGOXatjzZpfkjU7/4rGZMZRz9lPIAsjMNWRLQE6w0mznGzeDr+rBkBZrTWWfJlRrVnLTYoVbiJLJZBuCmBHiglUTQkLtuA2BGuU0hoaFMKWhQOvz7lzoRMtpRK836JOtaL9whtb03xn67UMScNcSwHFBcMYyQr1sPJrAqqZ6g+cJI1mO5lTsWtGPPs6AejauRt9yFec5pBbux48hDJuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlU3GC/lZWKWvY0pjhRkOV34jKOVc8c3N92R/QR+uY8=;
 b=HO2g+z1KpbnSePcDO0ZNKdPzOsy1n66vhEzvT5WziiCdc9tZRDILrf/wsE5J1JuvjRHxZdyer41CsxMyHiItJCMKzuWoLO5eVvMkWqDVfWurUTMvxv8KAwWKHsaN/4knA6Qx+DLCSNWYhowyCTtQm/eqoDx4x1Xg6+0+5k/TPtMEQLXLSv911SLH+MO2yN1LXcxJWhrt/D7Fjg+3zH2C4b9eQT6oNfr9qdJaQLuHWMKWT4ityMl1UEBQlh5dy3Sh988Ec95BSau/KbR5vXljReBS5cA/jXlSsxqrbN8MOzbiPhmQeJYynj0vyMeeUZ1ZuBAniJx4CFNaeZAaJFTFYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlU3GC/lZWKWvY0pjhRkOV34jKOVc8c3N92R/QR+uY8=;
 b=KZQCYhJxM+RCOlCWPP+8yIewbcejbNOr2plDurDXtoGKDMma+/1yE3GH2yBRSNTBiMNWy4s8POEnbRoRd8Sq/ekRUEtkCkX3fpCTFKHFXkNt3m2JR46A0jsOHSfzxRzKv4cGfQF5+Wt9XQ7pQB/Jw8cBI+OeJKHZrgoJvrZsSJYnpsjT0yWUJ/CtJZGErzVUtQBhm9Flu0e+HAkIgcJn8VGd97fPe6QTU12FrdWZUPqm91LXIDyzAQRGMUmnZjivK75bpLZwKOrF+14smUhxHJdpfUTBkQqzd+lBAv1bsF/0y/ZA414e/Y5Oaua+Pq+SuE2c13cka5O9RpZO9n4qSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM9PR04MB8666.eurprd04.prod.outlook.com (2603:10a6:20b:43d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 13:47:50 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 13:47:50 +0000
Date: Tue, 28 Jul 2026 16:47:46 +0300
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
Message-ID: <20260728134746.p7zqstau6376xifj@skbuf>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
 <20260723150105.da2cqgtb7t5vw2d3@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723150105.da2cqgtb7t5vw2d3@skbuf>
X-ClientProxiedBy: WA1PEPF00005B89.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::637) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AM9PR04MB8666:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e3ebdd-efba-42fe-6056-08deecaed0d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|19092799006|366016|1800799024|18002099003|22082099003|3023799007|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	BWGoUu3W1r4cDYJbnzfdzwTwsNcb+lVoLDR+30DgfKpFQIqFvlbkuztPONQa8WmtdS5J0N4GmyC3vnGuVuANmaU7do7Bs1DqPCLu6GzNl8tKUGcOjz+WMx21b2QK1uB+QiFWtmgM4nS8xS69dY37hvqgVxYav2fPs9smGpTCjsrlAc0C17mAM57ysvoabRyMyd243IyAJrSfesUV7K+r7Y3f6TkkEzR8SFj6QdSOauGKNAhmmKRGgDq7cZIxf56ZJI7EPHEE2tDBKewrauKYdbdlnLAcy/DpxXrXBEVAmAkV20MXAaxf4NzUw+3B3bAc/3MNZkx3cC+ZsBRh7kfAZ1EIQLW0du2KbQlREZj5QX+dln1VfeFZbWJb6ETTmSiaO0We7J8aUG+xhv1NvnO4MC62Hsncg8VOD/JTv3bSUOO8ULrrKptdBjFAWdTUIzATNjbMmgcuYCdrDXh9MIl5kkvgsc7Wsc0Rd6560xlc6S003iaVLtuyFWQWijoUSyeCNyfr6GiOqEi9GHlVIC7JuKbNES1ld6agjLWZU3D2hL4dngkxV1sHMMYBTzRiRGIQ1Cu7jOrKyEU+lQopKm1V2bWv8tMrdYvdzM1khEi+dQwWm2PShbQZaY1mwZok/rRBQjEfaXLg2eDPbLgrfXUDJ2zpEFwyOFPEGNs9kF7yUu0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(19092799006)(366016)(1800799024)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/6nah6eYhYNIrWqDv/jLMRpM8EgfUP/rk2yy1jssModKUOFbKJ6F3GjWmiPc?=
 =?us-ascii?Q?e3+tkeWUoGHoc8zm6w2M0/fgNnjyGJsV0/RAHA8K5dGRvQfKV55oC0VyewVA?=
 =?us-ascii?Q?IiXpuFUEAe1MXktLS/PCGW7T5MMm1ocwhDICk2VTpCvxqcFEx5sGiiDYWJe4?=
 =?us-ascii?Q?Vendp5M1nTuWHrWx0KDNaxNDjSkc35hXtDIYe9Bh/YcrejcK0ZgsDewh1wrn?=
 =?us-ascii?Q?0cQwSt3z7qAlXtS4pQR+NDoPE63I1s4tg5DkEeTMa4aBl5B1bl1WZON7J8w4?=
 =?us-ascii?Q?8QmUxsh45DOrsdXyssIa6nkEFyiW+oB2E8WYcObrORTuq4FQJJs+gOH2uUtr?=
 =?us-ascii?Q?/XdiyBflnh2NSolovwNJuygXXTPUm0mdEkbMeEqrF9EEZYFJvoGsgIKaoo5J?=
 =?us-ascii?Q?Nqw5OTklAJGYkotyFcSWP9ZmVLD/Tsxnd6efIF+UGrRL1isXLo/YHzTjxwgX?=
 =?us-ascii?Q?nWNqAQmywl7IbwR86n5qLIkQ2wPOOh5ra4fSz/ppFlingk6QxTzr/1Qj7b1O?=
 =?us-ascii?Q?XyFZV54WU5rDh9gVGT/Y0p0U1M8pqIXQySNkxvG4p3cJqKfStvOgdw4go4MA?=
 =?us-ascii?Q?LctRDBCVxWmxbJcuZVnP60S1zVx5EAFASsFFpy6rNgZfclOJZkfI9F5qIlCQ?=
 =?us-ascii?Q?w15LRdMEvvtrExeT7tdqI3qeX6GyLNQtk4b4mK02pFEzYqSUXL/N+THsa2k6?=
 =?us-ascii?Q?JxyHVuZYhZBU42pze+myy3IslE+biAUC1aGxuZfTLqh3+P5j2/G08udUO1K2?=
 =?us-ascii?Q?oJ3GQC3RW0kuGiL4gGC/ghglXJYnulCzJMU4d+vFL1J2wCWcs0Qvx74cvH6n?=
 =?us-ascii?Q?byOB2QuAnuVbxWtb3HSx6ykknBQSwryfNE0MsNAB6Rc64iVOKTQ2JPpucXo6?=
 =?us-ascii?Q?5+P2ML0DvIQg1UFzQ1BGbXLDdkc/5u9e9FLKMfp8gUN6YKLv64ohYvAHkIYq?=
 =?us-ascii?Q?j91/TtaXf4qJHvwkmYNjdQdeq1OzZq13o8cM5nCJkz3W7mHjtO/odfIunqhP?=
 =?us-ascii?Q?aBUS+hdEO0wVJbDacWx9JIqh5dAx2AJTKqMiNAO/DzaRz91VvMXPBLt1OzXJ?=
 =?us-ascii?Q?EcF3UepFDY1p0vp4PrJb/pUVsDlLYEcnq49N1vq7jXWf3LFu+LYAP7GPNqhO?=
 =?us-ascii?Q?pfugO3US5WOfm5pvXY7LO4UqRUL9hVQd9NGXZf5UDiLFNVl1NW2poACxMi+N?=
 =?us-ascii?Q?F+yEjeMQ7jHlJn8tU7RIPOt/HIW6109opSWki95wLt3GaBYLJFrbfsE3Ba7t?=
 =?us-ascii?Q?xNkZOjClK30X+GIpc5mfPSl/wAXD1ceboDRoxo7X7RZ/2Lh4h1TVWHxei1bk?=
 =?us-ascii?Q?YobUptAOFFMeJZGvuFUW71MGoiS8j0aCQtbyNXulmitk2eRO+i8oeh5DzI00?=
 =?us-ascii?Q?LQqbELhWrcQ2y0XJZFrUMRlX9fYs1Wmc1XBh6tAaZhUNyh3P9pIWedG+L1Dt?=
 =?us-ascii?Q?KxZowZGZplhSOhL4X1TGl2YRWB7GvDlJvN3zp430A7noIOda8si1Lf6er7cx?=
 =?us-ascii?Q?BCRrlB6DfL4GwrM1/YC6Rjy4NLRHmdZ5+ms0+Qqtj1M1XmO85Xezo7L4dGZC?=
 =?us-ascii?Q?uv2bHy3XW/365nCnnQk2hw7PQ1NcdG3Zsnjpo/IMLkK3/xDksRF80tRXQfuk?=
 =?us-ascii?Q?XmtS1XXBe4Ne2Ppcj7pBocCq3OHIUrTYD3KXGtWK5G33Mqc1RUoXsPuJ4Ze7?=
 =?us-ascii?Q?STTO/JSIoQBpVsZsBIAuHjA4IzBQVEQndgU7aBX8dqaCMxr8PB70W0vOomY5?=
 =?us-ascii?Q?VD6CtJlWPWb4L8sa6U1vpJSYNK75rdYhVs7LW5FSRQabXJdvWXVrlZyzUV55?=
X-MS-Exchange-AntiSpam-MessageData-1: fHFVlo7oXjLr/UKcSFHsTvp1BZQ8XjrT/Uc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e3ebdd-efba-42fe-6056-08deecaed0d0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 13:47:50.7745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBK2+LKgIryy3D459e7eQSgd8UhZIBc0lKKqiuG80LzOdjG10a5AnVMAJB1dU6wbhlDItK+8hRhoaJDDcTQrxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8666

Hi Christophe,

On Thu, Jul 23, 2026 at 06:01:05PM +0300, Vladimir Oltean wrote:
> On Wed, Jul 22, 2026 at 02:15:54AM +0300, Vladimir Oltean wrote:
> > Ioana Ciornei (4):
> >   soc: fsl: guts: use a macro to encode the DCFG CCSR space
> >   soc: fsl: guts: add a global structure to hold state
> >   soc: fsl: guts: add a central fsl_guts_read() function
> >   soc: fsl: guts: make it easier to determine on which SoC we are
> >     running
> > 
> > Vladimir Oltean (5):
> >   soc: fsl: guts: perform fsl_guts_init() error teardown in reverse
> >     order of setup
> >   soc: fsl: guts: make fsl_soc_data available after fsl_guts_init()
> >   dt-bindings: fsl: layerscape-dcfg: define DCFG_DCSR region
> >   soc: fsl: guts: implement the RCW override procedure
> >   phy: lynx-10g: use RCW override procedure for dynamic protocol change
> 
> Even though I intended these changes for linux-phy (they are also
> build-tested there), I'm fine either with these changes taken through
> Vinod's tree with Christophe's ACK for patches 1-8, or through
> Christophe's tree with Vinod's ACK for patch 9, really.
> 
> I see on Patchwork there's a minor issue in the commit message of patch 3/9:
> https://patchwork.kernel.org/project/linux-phy/patch/20260721231603.67865-4-vladimir.oltean@nxp.com/
> "WARNING: 'struture' may be misspelled - perhaps 'structure'?"
> 
> Could this be fixed up while applying, if there is no other feedback?

Do you have feedback/a preference for how these patches should be handled?

I see Vinod acked patch 9, so I guess that means his preference would be
for you to pick up the entire series (which is indivisible).

I checked that the patches apply to your soc_fsl branch:
https://git.kernel.org/pub/scm/linux/kernel/git/chleroy/linux.git/?h=soc_fsl

Thanks!
Vladimir

