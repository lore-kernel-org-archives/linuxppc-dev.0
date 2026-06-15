Return-Path: <linuxppc-dev+bounces-22646-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1707CD98CF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 14:27:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfCB42cfHz3bxH;
	Tue, 16 Jun 2026 00:27:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781533628;
	cv=pass; b=aorSShplK4+Oip0BxcEonyfD4WoPT/ygYHQVlh0l7BSKcGvGV2ojuNfFoNWQg+zWmSYhgQGAbsQTaNpvFviabzI8cs9Kzz7nZtDUkc2VJXgxAp5QitfIA+ADiN7/C/58BXLiDZcr1UCAbFgerYUjacQAIzA27k/EHpZultE8UbE2qdXzZLniXQEi07c2x8Yb0iuypET2QxHc/X4wAwZNTphYrXs7gD8gtQcZbzKIO1UN3t4Qo9gk993cNllEbyhcez6rCjHqHe46YMNCSSK/lHqanVY4tsa8DIjISZhNfD2jmN7GqC4Zoa8xCaUT1D5FNxQx15kX33KZ6sCibUN0Lg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781533628; c=relaxed/relaxed;
	bh=diedGpgXBO3/Nomfv6HhOvP+J3ht93XW1VbsNjgTbUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=knBjIMmQwaPFILydxaab0fdithHPctccG/+Qn2nfXBNSPGD8QDE6DGx5M6GATd+j98Z6pOOKSXIToPC/IX9qTAoOFVyyDmt+y6ArRuoUeE8ug1XNFFuWsB3DeuB9tL9rZ/Q89dv1fvL2guPYmZD/kbOBcmuOjgzxK4LN9CBuiQ/5vCvSrIuKU7oduxBZHt89FVxEh8kxN+asck8rRSOB1qvO1cUbzej8sOKTVR+yA0fwieDSLCYCjpEeGSsB45Q/oczLNaDivwdSTzJ4ZXPTwQ0vLMCTx+H1Vqei0gCYnQI96QH1lsVY7FgOzIsJsaW58C3DcuOuVY950vNzEF8KpQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=f3F7Mwke; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=f3F7Mwke;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfCB339Dgz3btl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 00:27:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xA4tBpdCeoLX3efxW4mrZgGaEBrkye3atVLPmMVXM3YLLELHb8BnwMD6I4Ck8956EBiAmL+5ZFGhvC/K5L9sNlZMqF7zZpcV5jHhq07BRzEhGw3rHNueH/12BZtGDoK2ELdyWGWanbJDwvHwALfcSvG8TAT1m2hfy2EKJ2RTGsxglxTJuiEiDKARIo1YMfAIw52duaD0RFKgIFrFdTGYAW8sZ5DOUJFicPBnDVzrp2Jm+ONdog1ANZwcBcaIT2bNJ5zgx5ESE7MVIn/4xLC/oxxd7fE71AxS0t8dIMCAJ5sF38dvckm+7YLzZPW+F3xnzAmzEjN6oe6H9dYwxIMyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diedGpgXBO3/Nomfv6HhOvP+J3ht93XW1VbsNjgTbUg=;
 b=wvZKAwpatDQaxZZnuhkahVhPcFerTLRAaGkXp3bXNRuBoLFDXJJkVSX55oau7aOxh3RulQYgAi4Rh2plA6tK4rnj44z8Q9BnQEHPZ4rx1K/UVjEMom8WYJBx/N9gtL5PtaFPD66saMEkDuksEum56sAjOJztbzRpQ1yMXEPx4K2biYOBt33U4Mr+zHXH/Jt0VU4q/mh7INYTXTPqdwyo/Ho26dXG2Kf8gke2coKkoW11AwkvnZVJsUowUlc4CoXvh6V4H3zXrIi9z438OOqKzD9n8NsmTdQjQQJTCiJMczH4EuKcH2+OYspxdKW/LlS6DuK6hDF129JCelw9BaVuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diedGpgXBO3/Nomfv6HhOvP+J3ht93XW1VbsNjgTbUg=;
 b=f3F7MwkeCMlC662+1x8SW1JCQl8494Gtj1KSzina/BaYFeSmaHH44vTwLfev/gp/R8NjO5XDLpFbBU5hmZbWp1BIhPjC2TGONgbkc5HBkseTY9CKXp3LpB2SPyf97jLQbArIVUwnvB3caHEBrWb738CWrbqpSVhGwtGTWPQS5YBC8iJ4Bqe/XelocPhx7+NPWraXNlbe7M2rP8VeYlarg/zI7zAMR+kJe6rFnZ0lGXcsV4lxG/7NzqBHU9B657aQ2h26wayOX747iRLYuuaQxDdOmOfI2rowPNI8/Ko2jD64IbXZsJWj4F3DaIsRxbqtGUrZA6MLJoSIRmunn7Wjpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS5PR04MB9828.eurprd04.prod.outlook.com (2603:10a6:20b:678::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:26:43 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:26:43 +0000
Date: Mon, 15 Jun 2026 09:26:32 -0500
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
Subject: Re: [PATCH v2 11/11] ASoC: fsl: mpc5200_psc_ac97: Use guard() for
 mutex locks
Message-ID: <ajALmPI3hqt07hPt@SMW015318>
References: <20260615093824.115751-1-phucduc.bui@gmail.com>
 <20260615093824.115751-12-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615093824.115751-12-phucduc.bui@gmail.com>
X-ClientProxiedBy: SN7PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:806:125::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS5PR04MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: b54edad5-1c8a-412d-7708-08decaea1f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	x+iUw3MSELJp0UDV39XOzDI99jEpIoBWm6X2ZmLNZakyGKLr7TRTy8cqbhiMRgF57ZAXWdhE61qTBRuJ9cGXtFyasEbILRKWG2GOpPlysEZi2BV/O/ocOTW7ljdO8I/rII13y4EScWQ6E8AFrbACtbALpXd5FDC1996x7YPHXkJkvawqwqP+5rLFfqVmlqh6rp2NPqopZi4Mf+huFeW/hglphnx0UGtZ+Iy05LIfe17pP4NYtoYTQFWlGIpxJ64XXziTcOrUFPbGX/KdEaWLwbO86xUbcNtOaIDcZbIY2sPLMu46ZuhjGuowj1NX3EDsGy8pRDyZ6RFmRfRp7qPS7e2kPhnSwuciAjQM2RWFfKXW/GxUoQ4XDnXD9bkqcMW+0NywazechaijHOlUkBHYsuvcvjtuxtrEl+vjNIO8dyny53ZsHsmUfELTb4JJvVcSef8R0bi0FIok3MA+GVF0abkAA/lW7EjDpiI6gLWny2kxopXPdXjaf2kA01I5qzihpFj/WXxB2iykSSsbc7NthW9OvuPIjrcXM3YjPLAhG7cA9yW848tAdwexE1VxtwofsybqPxnHNgIaaaPVKNiXDKYICOgPBqT4D7cLOVO4QvGQEl1YYwAaMe3sjsuvxhOM98PCJpmK3OZYCrb3RjrUJIWdqOBV5SOhLf6En97Wvfc/af9dI9nIGbMHii5I5o7H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WWFkF2mc2zu/XNik3/8qprUbyZqNXhzHGEJxEcf6y2hvgIQblw9i5P1OGsf6?=
 =?us-ascii?Q?4WpgdsWAkNc2f61uYPHZGSTuWByVLEbJP93OLn+JLQDPGJ8wj72g5OFyY89q?=
 =?us-ascii?Q?wGTU2xCPiFbzw9fbe7G7iJ/frLF/5X8ExrWrilPyXpA45ADhiFNRyr1HWb1P?=
 =?us-ascii?Q?9XprPdVUug6kBjqVIdg5AjeN0H+UOG2bJjXyfnzzzpr4pXXqcFroVAkrRj9A?=
 =?us-ascii?Q?TPqkPoV0jdhfCXMy3dfoNSCOsj74iqFUPlUyE291gu0byRG8c0Uf1C5jTByg?=
 =?us-ascii?Q?vTPFfjRTQRJokCmj3G//K/WmViwFL0fDaXzwoTHsHSwAyaFYp4ATijFpTSmt?=
 =?us-ascii?Q?WR1PUq6tchTmTfcLLU/8P0O/eK3Hx6yNt2yNN/IyN5Xih2Sez/cBnPI3andY?=
 =?us-ascii?Q?Hl/FeBYuPkBoCzeJallMvR06TsVDSbYMcenWotDbXy7Ql/CZdR4IE86GRkOE?=
 =?us-ascii?Q?wcK7G9p/3UBLbi2CYK0WULshsKl+bLy07nKuDT6YyggQoawI73VlbrHmhHy8?=
 =?us-ascii?Q?l89rp95npWIaqt/BvsDAbJHPbLb3u05iv/2yiy4TQY0p5AwZPYqCGENCMMx1?=
 =?us-ascii?Q?UdeAfx9r+qKR6rF/OTbCAZIAEBOEvPfns9xLX0I76XaFfx0puIHrKiX0Asy4?=
 =?us-ascii?Q?jKdNLq9bijSVHvgGGo2JHk15mgr6bkdcszCNPjSfAIT8omcMZSWRy4jFm9xC?=
 =?us-ascii?Q?R1kMTQMlNLIURhLrRww310H8nTe/sRH06/lZ7yh9wEc5pmTexSjVf1wL8Mk/?=
 =?us-ascii?Q?3EA3B6Y/sVAFDRoYdPXuxUkBg2aw4NwkuiNLIQrLG41mSxS56YlGXG46Z8ew?=
 =?us-ascii?Q?PAV7D+vIWhFWwketCfgsF38f9SIjsLolaXMz1eFqG3eYD7V/uP1L3DiyrfDg?=
 =?us-ascii?Q?wbmQVS3GRhVpevkGZIncaiOeIUUR2mpfwyYqHQUfThjtaiVyGcs7NCJfZnMi?=
 =?us-ascii?Q?TJhCXJKgnoforR/PCTU0L0DbOW7DWmIAAJgxiCdX44AesMI7CWiPCZrZZ2Sv?=
 =?us-ascii?Q?dZ08jl1PKzmenOMqHlFbrZiWyL4QSimGyzoIxaK1HD2LZA6v9BMS2HuBQN/O?=
 =?us-ascii?Q?o6q/1GMSdtjKGkalrmPcIXELdWsUfSLK9ipZik7dcawftVWWuGURyMsOHfIu?=
 =?us-ascii?Q?4odRKvvC1SBXD32XdZn27bVNBtuY2g1t0k6mmfBwsrGIzJ3a1Yxy5P+aHSZP?=
 =?us-ascii?Q?MiDIkhSkjnZvz9j37s5hrsDo4WWeDy8e71YrNHmP5vwddvoo/P83tUCXCz22?=
 =?us-ascii?Q?nmkCuBXA2mjzkcJ3ql3+ZGHNDXcyCmoeXmbWMr741Kmk7+/rj8LN6JHoKleg?=
 =?us-ascii?Q?ELJ/+Hy1zsojccx3yxpXPNKJzU+5aw39yeE2Nw70FUmuYfTmIyF5XYiAAaIn?=
 =?us-ascii?Q?D8Cw37ZFGWSp4WFEbwDCy3BPxFCJoG3/mqP0pQ2OUeIlWwsGYOrHuy3PmtYy?=
 =?us-ascii?Q?eVNjeAEC2JSRO4s1Zmoe2RTuZpBUOjuLLEUySABQrH0YkEtIm3D4Gf/lTuTh?=
 =?us-ascii?Q?3SDgp2FDFQ7cNOAft5t4DfBDSENtbnFlxa+vmywoh7uY2hLe8esVPkptzL5h?=
 =?us-ascii?Q?03IAObRny897A1mpBuCCsbUTE7e7h1jrk46qEfgPVxd0u+GcpuV7L13JlDJW?=
 =?us-ascii?Q?96ijBl0jAvWV9nQ3nTzAVHm++YbHTKlnZ7aJ8fIZnWJrw3BYE307+s2fRxF6?=
 =?us-ascii?Q?TyqOZieXpHGnZuo8zcfeOs52+wnfwokX9XaRyhDpApIxjK6/jVD1CvbhU6e6?=
 =?us-ascii?Q?lQjN4Dlx0kZGYISXbZIJc2xCCmN2uuc8BF7Yczr0cli/+Jl0x2VO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54edad5-1c8a-412d-7708-08decaea1f90
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:26:43.6964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oX0/4iRw0s+wNDU8GBFyantLp3x3W9DZaZhUPAwAWEqy9DTsAVeZM+UtYV5NFlfrbUhLwjMjJVR2DKhp+YCP/PqcZQT8PFueD/soPob6lXjjKeBmEaBljenJobTXvFeA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9828

On Mon, Jun 15, 2026 at 04:38:24PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Clean up the code using guard() for mutex locks.
> Merely code refactoring, and no behavior change.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Changes in v2:
>  - psc_ac97_cold_reset(): Fix scoped_guard() usage by replacing
>    scoped_guard(mutex_lock, ...) with scoped_guard(mutex, ...).
>
>  sound/soc/fsl/mpc5200_psc_ac97.c | 34 +++++++++++---------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
>
> diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
> index 8554fb690772..d4d9f5b6bc07 100644
> --- a/sound/soc/fsl/mpc5200_psc_ac97.c
> +++ b/sound/soc/fsl/mpc5200_psc_ac97.c
> @@ -31,14 +31,13 @@ static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
>  	int status;
>  	unsigned int val;
>
> -	mutex_lock(&psc_dma->mutex);
> +	guard(mutex)(&psc_dma->mutex);
>
>  	/* Wait for command send status zero = ready */
>  	status = spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
>  				MPC52xx_PSC_SR_CMDSEND), 100, 0);
>  	if (status == 0) {
>  		pr_err("timeout on ac97 bus (rdy)\n");
> -		mutex_unlock(&psc_dma->mutex);
>  		return -ENODEV;
>  	}
>
> @@ -54,19 +53,16 @@ static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
>  	if (status == 0) {
>  		pr_err("timeout on ac97 read (val) %x\n",
>  				in_be16(&psc_dma->psc_regs->sr_csr.status));
> -		mutex_unlock(&psc_dma->mutex);
>  		return -ENODEV;
>  	}
>  	/* Get the data */
>  	val = in_be32(&psc_dma->psc_regs->ac97_data);
>  	if (((val >> 24) & 0x7f) != reg) {
>  		pr_err("reg echo error on ac97 read\n");
> -		mutex_unlock(&psc_dma->mutex);
>  		return -ENODEV;
>  	}
>  	val = (val >> 8) & 0xffff;
>
> -	mutex_unlock(&psc_dma->mutex);
>  	return (unsigned short) val;
>  }
>
> @@ -75,52 +71,46 @@ static void psc_ac97_write(struct snd_ac97 *ac97,
>  {
>  	int status;
>
> -	mutex_lock(&psc_dma->mutex);
> +	guard(mutex)(&psc_dma->mutex);
>
>  	/* Wait for command status zero = ready */
>  	status = spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
>  				MPC52xx_PSC_SR_CMDSEND), 100, 0);
>  	if (status == 0) {
>  		pr_err("timeout on ac97 bus (write)\n");
> -		goto out;
> +		return;
>  	}
>  	/* Write data */
>  	out_be32(&psc_dma->psc_regs->ac97_cmd,
>  			((reg & 0x7f) << 24) | (val << 8));
> -
> - out:
> -	mutex_unlock(&psc_dma->mutex);
>  }
>
>  static void psc_ac97_warm_reset(struct snd_ac97 *ac97)
>  {
>  	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
>
> -	mutex_lock(&psc_dma->mutex);
> +	guard(mutex)(&psc_dma->mutex);
>
>  	out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_AWR);
>  	udelay(3);
>  	out_be32(&regs->sicr, psc_dma->sicr);
> -
> -	mutex_unlock(&psc_dma->mutex);
>  }
>
>  static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
>  {
>  	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
>
> -	mutex_lock(&psc_dma->mutex);
> -	dev_dbg(psc_dma->dev, "cold reset\n");
> +	scoped_guard(mutex, &psc_dma->mutex) {
> +		dev_dbg(psc_dma->dev, "cold reset\n");
>
> -	mpc5200_psc_ac97_gpio_reset(psc_dma->id);
> +		mpc5200_psc_ac97_gpio_reset(psc_dma->id);
>
> -	/* Notify the PSC that a reset has occurred */
> -	out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_ACRB);
> +		/* Notify the PSC that a reset has occurred */
> +		out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_ACRB);
>
> -	/* Re-enable RX and TX */
> -	out_8(&regs->command, MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
> -
> -	mutex_unlock(&psc_dma->mutex);
> +		/* Re-enable RX and TX */
> +		out_8(&regs->command, MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
> +	}
>
>  	usleep_range(1000, 2000);
>  	psc_ac97_warm_reset(ac97);
> --
> 2.43.0
>
>

