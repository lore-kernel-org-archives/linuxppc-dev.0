Return-Path: <linuxppc-dev+bounces-22586-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01731CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 20:25:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcWHF4TNwz2yS0;
	Sat, 13 Jun 2026 06:25:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781295945;
	cv=pass; b=PuRXtQn4KyyNWt8bYGl24f2RdMqIH7hTTlqWQFSShhurm8QK3dEu0/ClfHptkNrQt397UYht4DfIZ9RQmtEzw+e7sIbcs6OfyVMh0JxEwqogYHDa4gf6S3gLt64Vrd9DRuMZqJ/WujUcHxaolFGzvxwLLPuiqAEDggliI9jRb5a8lewc3TRGeNKXSNEiUv7PY+x9wrv6UM5NjMcekMfH8P5YYaxbhLDYt8MhYMtIUlj7D4JG2OCX0oaM2B6kuoRd50F8qnfEn2fDAsOEakBu+LGqzecc/NALtsDnGte16bALh9lvsApDDA4mw0JPQlgAAuEi8to93E29iIHbGDDVtw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781295945; c=relaxed/relaxed;
	bh=EO4V5ByzoOUfUOvtGGnQNrCFUcLhqCo3frLlVqTdmm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T3cnGpk2Ww+jFmCqGZrftLMCVKJmMg9ls7XjkIQhLkmaeVTNDZ5WTrqoX6ydlXsS6cyLhKdgS6tw19Ayi0/k6QPc+IUaVPQeenvCW1ffT8LzHWu60+3+WHNmPcHYAJvYWE9qTs5+0Sde0BocHGUgvlF5d9QJEK1UmdkZu+4Gr1A2aTH2RoY2tEBnHYP3XmVyA8wQnvb7Rlj6JpJEVzaimbTa8BqFsDWYXJL4xsH9Viq//pQheD4kESm1AT9VWxz3sOPKihzf5MOkLknV++2VtYsN4dJKL18DO3OFjPty9LYL42EEopvySJjQCMc3f5PILljRr2Pgvf3GnOa/WTGRjw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=nkKp88Lo; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=nkKp88Lo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcWHD5tbSz2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 06:25:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3S8ANY/ob//8h1OXWJOpKOMvhUgaYJj1fVhXBKQz/x46+iqLrE6ejct4z3G1s1iAEbs76kf0XXFpiTXM61E3oHfODV/ZdjgjR3VAJnZz1joxByDqXCeIm9OYxdAD5/3354qIp0RQVFsTYM2I6gubt6UzW/NbX4s/jXEaOulBuOpOsq02zQFyHw2mcJhsHzyarqCF4MS4kmRi69e1mDBE1XxdjXTErkFVVxtIqFvUHBi1xn3nHSWVHjWnXq2vqTVqGAcoMgyi9or9BgpsGiyj6nInXGipQvCFNep3h1h+sPFHi2T2zFHcqjLmdh0nexkHK7rVBustE1Qpl9f6OFPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EO4V5ByzoOUfUOvtGGnQNrCFUcLhqCo3frLlVqTdmm0=;
 b=wwYuxG5dFodFoCm6E4sQI0D5fk0koLJp4Fqj9vqoPlOOsczM+JUVwN6PL5CKKy4w+Z0VQCNL5Y8pkikA0SfXHy+MWw2jJYFwdz4g/qfGiU0HSH6yww2SI60XgppWzh6OMp7H+M+gzcsNxS6qIerf9qhfcu+GG86hiqCvfhLBhfemWoEUl2tIAC+4Rrabr4xbaJ0T8bF8SCa7+lXoTsPjDaTbJysxTN8Ge0egycok6ZnajgEud049SWnyIiR0MgBAfvwCVWTiVmyQ2SAhLii2t96hjODO9A9bNAfv55Vq0eg0uoukswy1Riu/wyZnx3eiv4Q8xLP8Lr/DhGHgMfxR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO4V5ByzoOUfUOvtGGnQNrCFUcLhqCo3frLlVqTdmm0=;
 b=nkKp88Lo6UPxyB94zmI3p2Thy/MMUjzxXG5mt9/f1qO9OWWNAFM8tETIHT2KxqQtg6++2HjZ4p8Bmsz/gO/ycs1XTRGqkTUM91Lu6gLAFruJDWWoSVTsMTPK+7TBrzmPlr/a2FO3Vu67pWbeN0chdVvIHDOGipUcpcMDHtx+sR0oIKvW2JJI5U0E81NfQTOSYxhxtGoYNn81qxBrxMs5kEHcUU7qSC/IRAzmOZlpHdMQ1klalHUMT9Ig6BXkWUfFBhXqAKj/GbrKW5dIl6QGD2F0Q1PA374OLiqwYehqQ2RRgD7kZvydgvbKf9c1ZIsnHkJ3o0fViEmwLy92dIdoJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DBBPR04MB7802.eurprd04.prod.outlook.com (2603:10a6:10:1f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 20:25:21 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Fri, 12 Jun 2026
 20:25:21 +0000
Date: Fri, 12 Jun 2026 23:25:17 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 phy-next 7/8] soc: fsl: guts: implement the RCW
 override procedure
Message-ID: <20260612202517.tyxmohxy5lyn3zbq@skbuf>
References: <20260611193940.44416-1-vladimir.oltean@nxp.com>
 <20260611193940.44416-8-vladimir.oltean@nxp.com>
 <20260612-twenty-diary-4aab5327f9c2@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-twenty-diary-4aab5327f9c2@spud>
X-ClientProxiedBy: WA2P291CA0035.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::11) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DBBPR04MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 90fd379e-25a8-48fa-b589-08dec8c0ba06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|10070799003|376014|7416014|56012099006|4143699003|11063799006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6jLB3c86VLBy2AqshfHIqSAbHuKg3GCy3uBs1hs6Ygmk0WMzm1SokrK3MDKNT7p9ZF11iR+JRzi95oIKic/mDkuWtxbpQ3Moq5RalRBzDOdMaKdTFBhFtFyIc41Tn3Nt9+xAoeLlukZxyuPqIFcMe0bzAMqkzsBTzGJzzfLviyQeJwRem6sHfUBEfqBajwVGksHsd0K2W1JJCGPHJF1YSCmwmMIG5ctLHchWVsWu1i1an+Tgb7hhjQdx9ERAcYr+q0tWxbNCo2UfOAmLgYtiJMwRiyTuKO+g96RCqs1nRabBE7IvzQ8jK42fPU5L7dDUkyKXr2JaRjo7bHLyvdEncsY0JQIT1tA8EWImnQ9lL1b5V+2hjTsJtEbKmNUjkcw8a9IzDWkqtAt66xjH1iK8MfK8CMQ3sUt99znJNo+6FkgG077s7iqwlfKmliYF0FHZV1ghAp+pbdLdd/NJu5FC9vFEJMuKO90cos4lGFi6uGaRW/KADTzCLw87sOSVoqLbt/W4udrK0832Cc63i1AcBHYqIQOT7TlrVZaq22v+Nhg4doOUNgZAOX+oqOYfjzo63w024GurTkr7a+zuCVlupItULVCt3lSnm/MMTEmKCyGN1jhORfPWTbwkDmkjW27OCvS0YMzVUzHjOfomcMg608OEmQO0ImYx3EnQJQj4sbqhvx6UaWFnCX/phl3tDYgB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(10070799003)(376014)(7416014)(56012099006)(4143699003)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3hMPJlDPMfSzCPqI31eVaNG+k33mShsOaHVqNireeVRLEptM5q+g66d9vRyt?=
 =?us-ascii?Q?MLO7ITXIyzg03UFFBpIK4CyGVoAOt65TC3X7yNOxmUpdM9x98kZLqRLNNdfG?=
 =?us-ascii?Q?fb+oc5ti/jNTwAwG8Vr/aHYMs2kXV14K2G41vYjCXu0T5kGZqgmHtaK4Dd0X?=
 =?us-ascii?Q?xjYBvStHDdFAZ0tyP/jMYWCcAZqsf7ffYH0Wtx8ue6eqtD9TkasKQbeXbIL2?=
 =?us-ascii?Q?Fv6mu6b8md+QZf35+JH2P85yLpSVATT0ecUayCRzzy4sZpWT/qF3TaqgwMas?=
 =?us-ascii?Q?TS1NpLutMSq810qFnXDdGHxLQDqbruIJqdLtnD/VzSPX6xOf1nSgocDY8j4M?=
 =?us-ascii?Q?mA/tFNxpHMifyaOMMf6VJGOe5P82NFHr1UaeIAXpM5egOp18dYjPMRH4XNRu?=
 =?us-ascii?Q?/Rchp2nC1jYn4nKkB8XWmaL91gkddWAq3/3An0nXq9/OgW0QXrrkM0WHDj/z?=
 =?us-ascii?Q?FSKQibMZ6kUJ8oyPn3XyXleP+s7EprDI1Q3Pv+k/O+srkopWWxywihAfu7x/?=
 =?us-ascii?Q?U6bjV+SkRe13aH+5BSpuiU4dVu7/clCoNSY7ZSirxoqj/tIvrTC5Jb6mtqmC?=
 =?us-ascii?Q?OwXCd/H6EXFfpG7XGIFGEK7uRYjkUzAsevSglzXFXTyfJMFtLZKpRzNtLSw7?=
 =?us-ascii?Q?a2Dl1sHCLsCBu2vWCDdgBjrh7zYXMaknmqvtEfxr9rI+ACHa9Vwyw99qgToi?=
 =?us-ascii?Q?CWTuE7wOl4cbVz/mFirTo7Dc+FCrU2hfx2bI6qA+gbtEolfYPRtTR5Dz8KHJ?=
 =?us-ascii?Q?C/MtCAb9NWOBL9FXNblrtCy6xmAgHaU0lHqjFtX5uNGjmJpDTX+1rbn14zXZ?=
 =?us-ascii?Q?yNuny69pnZqSG2dJUaJVgccV9Oo165MxZfjGy4UBzGmTozkySgCKIbiVlMIP?=
 =?us-ascii?Q?R8UTj4NLlWMhI/bbF8HFXK60Y/9ol/ISY5Kty8pjqsW8ebBSDRP4oPm10mtx?=
 =?us-ascii?Q?Gatd8AFPJm1vMcZt9ljkNP8hPKayIWj6LEayPLIob9udhH+STowv33O9myrI?=
 =?us-ascii?Q?cE8qHE6FVYWSmrYCKHkREjiMdpz0GdISwxESA50tohJBi/rehktyyzcOjm8L?=
 =?us-ascii?Q?qyvJ/6XtpYa9cbNN+Dn87rTs0sx6OZMmOtKC7E38yQLrScxFRhMjzCrzlRG0?=
 =?us-ascii?Q?YL1mWrPZVbCkvx57a4TWzqK5o8pt6Oc1KoNUZzlxzXGbRTuLj+KB695SGUyj?=
 =?us-ascii?Q?MUMAcg5Zr48yvwn5Uf0FQjPYae6Dzp3U75CViltBVxAPxRpEjc+FaVt3vk0x?=
 =?us-ascii?Q?dp2aZ+48U2uRcUO2+Tt+w3nHgrB6+MLLUzLg1wxU0t/xzSxUKvucjI6qNcj4?=
 =?us-ascii?Q?pIGAAdlojIw8PacSt20LzO+KWVgcHShUyqQNJ22JzZzLmhB8QXPBurAuaSs5?=
 =?us-ascii?Q?LgWKj0RacT9GV27AFgWLxMsqHAuZKxksDyecIYd8OaCwUM3LfdvIliblkvi+?=
 =?us-ascii?Q?NpzogoWoSx5VPSlYVnc1DhsDtVsWAeEJYUUcjupTkUFYepOi134v2P4sTi0t?=
 =?us-ascii?Q?/cZYpVsij6ZQpyjK+rryqJ1OpkbavAgYPCLGxmDUGBGXrJJXe63Jvtgje/QK?=
 =?us-ascii?Q?JWwf4kIeNIz7pLgkKvOrkpbQ1zRG/DPRY0TSxZwetFslXEU3N5PID85TTEK9?=
 =?us-ascii?Q?3wmm9QQ/Pu6OCmWM0X8TljwblfS72sTIwa5YwB04jhC2PFVR49WYWlO4QUOW?=
 =?us-ascii?Q?bsTLE21uJz4XZ8G/QJgIOXg846fGdrF3po8S76C+8WvR55IgcLTL4T3+u/2Q?=
 =?us-ascii?Q?IWfBE5KudC0NG+jUA07o5/OldMz+Ydc8PwWyPJs8QHgzbgc1qZaD4DMLCZCl?=
X-MS-Exchange-AntiSpam-MessageData-1: sxNAIOqcBKIuSg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fd379e-25a8-48fa-b589-08dec8c0ba06
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 20:25:21.5105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r29ESwO5G3hmVSd5IU4EIugIkE0q5yAWEL9Uuo1P10mZxciA7b+DS83uoXKq3GkQdQ49C0DRcWITaUW5fmITTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7802

On Fri, Jun 12, 2026 at 04:44:30PM +0100, Conor Dooley wrote:
> On Thu, Jun 11, 2026 at 10:39:39PM +0300, Vladimir Oltean wrote:
> > From: Ioana Ciornei <ioana.ciornei@nxp.com>
> > 
> > Add support for the RCW override procedure which enables runtime
> > reconfiguration of the protocol running on a SerDes lane. The procedure
> > is done through the DCFG DCSR space which now can be defined as the
> > second memory region of the guts DT node.
> > Support is added on the following SoCs: LS1046A, LS1088A, LS2088A.
> > 
> > The procedure is exported to the "client" driver - the Lynx10G SerDes
> > PHY driver - through the following functions:
> > - fsl_guts_lane_init() used to notify the initial / boot time lane mode
> >   running on a SerDes lane.
> > - fsl_guts_lane_validate() used to validate that changing the protocol
> >   on a specific lane is supported.
> > - fsl_guts_lane_set_mode() which can be used to request the RCW
> >   procedure be executed for a specific lane.
> > 
> > Since the RCW override procedure is different depending on the SoC, the
> > private fsl_soc_data structure is updated with two new per SoC callbacks
> > (.serdes_get_rcw_override() and .serdes_init_rcwcr()) which get used
> > from the generic fsl_guts_lane_set_mode() function. These two callbacks
> > hide all the SoC specific register offsets, masks and values so that the
> > _set_mode() procedure is straightforward.
> > 
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> > Cc: Conor Dooley <conor@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: devicetree@vger.kernel.org
> 
> Wrong CC list for this specific patch?

No, it was intentional. Provided for context, so DT reviewers can check
that extra properties not defined in the schema aren't being used.

