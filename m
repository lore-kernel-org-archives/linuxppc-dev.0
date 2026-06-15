Return-Path: <linuxppc-dev+bounces-22647-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9CECD98CF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 14:31:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfCH723zVz3c05;
	Tue, 16 Jun 2026 00:31:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781533891;
	cv=pass; b=UAqlV28b9Z63gSgyl3amPHvLqrvb3GRNpbL/r7txUpQ0jxyHY6Y5p6rzfMsrAjYHEZMpUhqydGJ/H2bKBpcuRfVOxY++zllKvQDMSusld3AIFfcA+IWiyjnK3YhOxqqeM/Pk2tCOnRNiQufcEut392rT6c/u5ma3UA02WvChx+/EOATRdzoVMcMwVetMPpEFho34z4KCsOpaMFllIEHpSm1qzKh1RrdwJH/D4uNNJBhQSwmO+aGpCEZaVqPKg7PjikzTLn45kFy+UNrJliqn2z9wy7mTt4MJKM9N6reiD+rk9njt/LsG5lZq9iIy8qstUr+mWrtIfUyNMAYw/xX67w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781533891; c=relaxed/relaxed;
	bh=KX6V6rSl3K3kiRjJ4KBXWZ5lhaebbXpOGSHK9UQLM8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=orx67FoFLcnq8OjwVIuXGO7YJX8+08SvPJeD/FULQoN7VQ6Cx0cT25mNqgivq1IqdbBSHBL1ije4PZoyC/pYdl3Ujdh4BiIiuRE/Ac/zTjd1aY/8rkkW12DIzK57v5+fAoAFaUxCSZhIRRfScPFaFQr/zDeUPAKuZjs1fEp5luEvnk34GfPmil8LArTmC+m9benWKTFb3OWCO72CVGVd2YPP6l29yMgD9TQZNH/3IgePk0OTGH5QU61/XXxBJb9t/yg8DwiPi9E9v8jNGfeZDwdlBStIspZPyYJCHRA/5hb3jvfNWzCyzq4jb2JV2dW2bXf8PXH2RJ3hL0rmB/r6Yw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vFEH6/Gm; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vFEH6/Gm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfCH62HCkz3bxp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 00:31:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQkUiFB8A1bTvo2v1958quG3Ufe8fXxsP4TRW4WiP54gg2zxdYAljtA2lK4SX6shlO8ulbjxGzf9ZHWHcvqXO57V4Uda0dRUALiY84Ofv4Pfe87GSoB6oUXEnkY1KqKIR3lNBHuub5IlG+IjMnS3vuKewh1fdYX57nfkYL/0wOTymaXhRsbh/wqEGiarmwVnFhTLb2CfYP9P5YXRXWpFdkdt9XVyNzQYoHe4fOmzE3op5/RnfSPdY5dOqbN6aRy4zw1/pqYnDWJVE5A+as4pddiEEAYm2bOXKArMtA3UAIE67qusa4q9sAPOC12wblt6h+WJIt2eWCMy/cy7ril/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX6V6rSl3K3kiRjJ4KBXWZ5lhaebbXpOGSHK9UQLM8Q=;
 b=ljO+y3shYmk2q1LuVtxeBcUrv4j0CfF2v0wB4tettDdhjUB1rBMtYaTKW5SPDhDb7mBkQUKWkz1BlsjD1vyY3M3MfYPSb2y/PoXU6Kv0J8nwqCMGsjtugeQf6lPnPWao2vRk30oQaTgkJp8SiUPYLeFygyY4HRY49on/RW9v8rEMNq58+4l1wdnKrI/3STifOAK/QTZsotiTqi2QG54P4jHNF2aXLqDy2wlwKpKrfyHKQIG0kWiBLRnrKMsyJ4dpQQ6R1DFLQ6E27+47ycl9zADfmLhBcZr6X7x5GDn40e7G3jeXa6h7XPHLTaI99WeRH7E1cCWAaEf8PkWzZYPJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX6V6rSl3K3kiRjJ4KBXWZ5lhaebbXpOGSHK9UQLM8Q=;
 b=vFEH6/GmBX31yXHTjYyQKQCR76cg4Watqpuv+tZTcVhcz5D8+ntOA6YytVWNIuUkvEO1qfynYOucarxXIG9V3HBoNM7ptvyzQzS0AJxEqnOmUAqcDsHrAwPO4wjgnuXyN/1fGMOZKsf54p57+qIvbAdB+BHi+JiOvFGI1OU77WJ13YM7biE3ZPC8JiPvipxtJs4O6QW85cnya9cJIOJC05F9TfZ/dBrh2MHBypM9B1DOduA2VObC7X5zjFjI0xLJGEtMOulTnzbBmm7+W4SYZBZBpWGHKbKVI/cm4c/6D7DWF0tPG51TEb+c2hEP3ADt89pUEMuR6Z9kfOKljnkbBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB9144.eurprd04.prod.outlook.com (2603:10a6:20b:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:31:07 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:31:07 +0000
Date: Mon, 15 Jun 2026 09:30:56 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: phucduc.bui@gmail.com
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 02/11] ASoC: fsl_audmix: Use guard() for spin locks
Message-ID: <ajAMoIwRSnfJtH6J@SMW015318>
References: <20260615093824.115751-1-phucduc.bui@gmail.com>
 <20260615093824.115751-3-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615093824.115751-3-phucduc.bui@gmail.com>
X-ClientProxiedBy: SN7PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:806:127::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f86213e-bbd6-4150-735f-08decaeabca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	zPV/FFQ8oMQ3ryolE7FDhdG816Lq8hlSn55edYbTLkMyJdsq6DKrsztRAg0EJtywLnKg9EXAYuOysgvN3xsNlBnI7cbsmZXHB0hVUASUcPPPtH+UEYw26rd0IqLWW9A5IjrsxRQ3+14HGpPEYnGEiTqDOS5tZjE2ohD21s9dDy4T6ntTwE8A7BhUDXBj8MSJS0KUB995cE4QiHzTuW8SbAJtNT9b3w9MgIBM7/rBXrJt+st9iyQWEhPoekG//2vOd4d1LASpcNrws6qTKLRNJOTLNvzch6/dyKmdNL2XqgmYYdcT75cUhzuukFhDDY6GrgAY14G7duYri1ImbJ/a5LcHpgejn98Pjn5QXKd0aRIiitkKPZX7mOFztPnklsS9Uq72oJc1by9nrQRV78jONPKs/0iFiobi/KiAc926WbnkskEM7R3zWACvld3WuT19rCoUHKDtyQ+sbZV65bCmVUEQmlekSxtqBfAZIL9xoAtA0lXls/ug5u75FzRky/gUB6G36TzxrDCeUiA90Iiy8g2/f+Gr5Z4BzVVCsl6zHkxFCEDk/fiC12lJKAGDBNunkBwVflEUMe4YMV8A2ZjgWRg54EV18iws2P/QwoMV2QJtfrea46oMZ7P6yDb/vKOawRAfy+Mcx6C0Cw6ubS8ncnQZVg5kIXTQoc8Jml1g/gMr/QuhLh6GEq/pev0R1bgG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9uyZH/8qKJgMmmGuGCvymmKIMZlYyfboqGD52127aB+gRZINz+ByyKSe4mPU?=
 =?us-ascii?Q?cxInPMVryvTyHe8S67VNR7s3SvRnVUSgArqyQavrKJ1U5UuyQhju+JOYL4lb?=
 =?us-ascii?Q?FWxUHCwQTr4hVpESQNSOapfMIpFYgCkd+DPg7HLlkmkwDP/CzrJ3GeKeikOK?=
 =?us-ascii?Q?FT0jXfFFFQvd0cVCBzsJ3d67WbqOYNmwvc13Y6m7nBR18txaAu4J9SeuwcS9?=
 =?us-ascii?Q?a37PLhtfeHMeirjqQskecYcvX951izoOCtfaY226vFijWhL1Uk/39+Dpj3UE?=
 =?us-ascii?Q?9+FwH0JxnLb6lUnb4xtFvsmplQOF9H1K/c4cZk2N5Pe5/4i6dWp8Zaop1oGg?=
 =?us-ascii?Q?4zQwRFIwxnofYUopngdo58Y3CdewkNysOe2h43fv8rRkk3xRsuUB1N18S8CF?=
 =?us-ascii?Q?e+PRAANfdP02Ghe/wfKSMy6zHLW0JKE18D3RPOCh+umZaX2lefo8O/VN7tIP?=
 =?us-ascii?Q?dkHCQt2mphkn5e9bQMlRUbI/wFM5iwy11819LcWI2rI6fRHBXVOQQ56Er5Nf?=
 =?us-ascii?Q?+tx6qY821c2TBvFZyUKrxWvu6dychW8UU04U1IJsJl+z/JQY7Kp1DIwAnMqK?=
 =?us-ascii?Q?JXe9TgSKGxIHBayTpF7RCAeVEFKEOAGHAzbkftDtER+nTEsXsDhQON1FMH9L?=
 =?us-ascii?Q?CryNgYZPkk50OijZfpppwqMxkt+SVoOa2wwlHJBrbsrrKIdUfIncN+krklYq?=
 =?us-ascii?Q?v1gnPIGchL/m9pF4m+1wvul2LaBVaiishTStsoBYAcry1RLltlZ6FHLf2o2l?=
 =?us-ascii?Q?f+8gC9OqdNC3Gth2ZTkSydOmaGQ6pmW8fQBrx06j6bFZr4rroJ0zvoQuUEhV?=
 =?us-ascii?Q?mfTZHaS06+G6JmNeJZ6/r3xD0GjpUTPxYUolIR2z1pn978SDoSCU+bghiVBv?=
 =?us-ascii?Q?RKmYhIooq4EA6N3+Ahdppc0Xb6sDePPLsYeZDy3S+1veQ5HfM1Xo03GYhwJd?=
 =?us-ascii?Q?+sK8/yqPRn+7L5AHJPACHi6Fy7xpg9zooF/erA6PSccKbRRYWvzKzxYFOXCG?=
 =?us-ascii?Q?fu+4fDh/nJr4gl3yKcTmWl1c77KPrtdSQ2i6IfYn8wQ1EvGc5I07eSVkPbTN?=
 =?us-ascii?Q?J8TP6Ofvme2Kg0+8A8maRwKsT3P3QwHcItK9xMfFwN9ICSbLzuShCHdA07Yb?=
 =?us-ascii?Q?KiHmPSInEu+MPncwk2vQO574J2QF2K3kaZGglW3sqagTcYnngPCguTnTM/me?=
 =?us-ascii?Q?c7M8gS5mCh83ZCRx94WqIEeTYr3nwrSyLwdiVT7s9w12N3ESfn6dGl+EPRo1?=
 =?us-ascii?Q?r1FBueFbYOseMouM1T3jRHM8gXVmmXAVJN9tMe0ZSVYM7WN4sZnTqMgMkZrV?=
 =?us-ascii?Q?eB9VQ6/BUvdqndnAKbregSFDzy7H+LX3iCeApABl44T11TTt8HTuIU/ZSQ2t?=
 =?us-ascii?Q?VbGjgS19CEDW8u04O+Grq3eoo55nIpKNYOExmvx72XUV1KgNSnYd5/Oa3HeD?=
 =?us-ascii?Q?sfIC93WM7rePrZgGBo8jqOyKI+k5zU5+arKivoNTSzQXVtIYkFm2Yss7O5tK?=
 =?us-ascii?Q?747qdd3fxIWffDDEKqhnu7NXRzprRaDlIRvRdAG3YB9IbWORk2GMjUMpVcuw?=
 =?us-ascii?Q?oRwziIbYuOxP3JZ2hEq9ld610MUmA3eACmaIjxKY56ww+qSS1vRG6OiLxOo2?=
 =?us-ascii?Q?Ikjo3GM9SyqSxIZy6QKaWR8C0SHPY7ZwKq+yUEipWQ6hMg2GQGG7pJrLO4hn?=
 =?us-ascii?Q?8L10n92xqvwbEGKL656ONs1OFo+srUVGlkhHQygPlJrCgh93UIFvmmS91xKo?=
 =?us-ascii?Q?a/x5v8o535IbPrFSre6Pfc0XGkOXRkMEfXQZKT8WPkGF5lHCLF9p?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f86213e-bbd6-4150-735f-08decaeabca0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:31:07.2089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ic2MKIYZ106b9iRCOQqBPQ7+KEoqGsG/PpboUmu2LCoxcoZHcFFDmiHM/8DcSIyYyVW0R/g5eFzLNY7VnSQg3+Lp/iQ1el3D6Hte1OdN5nwWjChSgIRDJtaaByBbvylG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9144

On Mon, Jun 15, 2026 at 04:38:15PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Clean up the code using guard() for spin locks.
> Merely code refactoring, and no behavior change.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  sound/soc/fsl/fsl_audmix.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
> index 40a3b7432174..066239c64037 100644
> --- a/sound/soc/fsl/fsl_audmix.c
> +++ b/sound/soc/fsl/fsl_audmix.c
> @@ -280,7 +280,6 @@ static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
>  				  struct snd_soc_dai *dai)
>  {
>  	struct fsl_audmix *priv = snd_soc_dai_get_drvdata(dai);
> -	unsigned long lock_flags;
>
>  	/* Capture stream shall not be handled */
>  	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> @@ -290,16 +289,14 @@ static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> -		spin_lock_irqsave(&priv->lock, lock_flags);
> -		priv->tdms |= BIT(dai->driver->id);
> -		spin_unlock_irqrestore(&priv->lock, lock_flags);
> +		scoped_guard(spinlock_irqsave, &priv->lock)
> +			priv->tdms |= BIT(dai->driver->id);
>  		break;
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> -		spin_lock_irqsave(&priv->lock, lock_flags);
> -		priv->tdms &= ~BIT(dai->driver->id);
> -		spin_unlock_irqrestore(&priv->lock, lock_flags);
> +		scoped_guard(spinlock_irqsave, &priv->lock)
> +			priv->tdms &= ~BIT(dai->driver->id);
>  		break;
>  	default:
>  		return -EINVAL;
> --
> 2.43.0
>
>

