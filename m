Return-Path: <linuxppc-dev+bounces-22637-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFE6CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 14:13:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfBsv2s4Rz3btX;
	Tue, 16 Jun 2026 00:13:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781532787;
	cv=pass; b=ouD4/sJFO4BPzYOROk+K3lgcwuhImQASc+x14kGRqoZay6CaGg6CdQs1BAfUh+So+oYPLmINoxAjwPlYj2YAu+BuDU5HM8Y/X1HF5khaW95L50jYlGkxHypFm3HY6EjKQ+7xGtRSts+JHGdrE6TtJ7Q23mTQXPBqTdfItPvf86t48hBp8mmA0ZcQoj9IoLJYklMvI9Xr3NF8tTGinuMkd6ECWh8QwXRXQLV2y0TOMjAwdYIab5yUWnTwvRueSFH7iwJEv/AQ4NGv/x0F/NVhxLwItCUjs9DNzg6SjJ8fIqfzUU0my8CKDisCj9wJIGNj7rbhsmPPhp/rgwzeR8njbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781532787; c=relaxed/relaxed;
	bh=Z1NDKA3jUcCwR08SohW76QoktiW7yDfkNTkQyZBLomQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N5HzEtIaE9Abyb5u/Npi9BK2JnV5UtHd6tIs8vJG9LHgJg3PtInd8it2vl4uou7CpQfb/XfrXVflHCrP74FPO39SPwZZEpBmjMc5i/KUTF3UhXApTVrow7krsJkfSbmj83sjoqNIQK66zHxJn+cFLsiQSYuseYPqm9XqI0WzUNpSQhKj8V/Y9zUbHDmX0uvIDtnWvQwWZgn/wHoNGCn+he5d4rY70TinTeIrX5rsie2yEO/LaDzVTKfJ+r/HDyFdP03vEJsX7tyiTBf77+WBeQPBCZErkYWJDFGAODPZOKm9vylZUbcfHksY+Ne8tavhCBzdGU7EWpwzHjccQxYhfg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=q3e6DRcW; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=q3e6DRcW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfBss1467z3btJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 00:13:04 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEdg+xWr7I7tGXYBy0kV8aopDB0KP7zUY6jiQ4H85/FCY4bYuFm821hOZoUKhZeeDJ7l/u+GJWYSRd3GTM9f4T2ixmbSD/xkzDMXwF+hjuWTMSj37N4QufUNEJLsirIiUyuRiraOADsvDLQLD/zhPYV7nlr1zRLuZV7dR1USwLz4k/O2KoWf6Z69+H0NBBV/oLv98dR08WazWiNmwLc4c7LoTMWG2OD6/0vYtc33Qgou4kQf0jS3nP+e4pbGIltqTM4yljM3KadCElIVs8Q3WdvikbOFsn1LohK+IpylQKp/79YAcOGiSkpLYia3Wg2tN4+s9kqzoGre8JGQRIopJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1NDKA3jUcCwR08SohW76QoktiW7yDfkNTkQyZBLomQ=;
 b=O9xy9sf+P38NOxfl8Avp5cZe9/Ws2RXyOo7/2VLC1OAh4zOrisHzn7mN8q5qQ3d9CUN48MIcend1iKACf3vfM0ahZQOx4V+iPVD5GKOTO0uI2CUzuJTcQz/qdSNu/ww3yD52TFcVLeyhtLhC1i+2zlw7TfJLZsjqe3rnw0Rgq2CiRyREdiCtll0FQAYKL+1eknmSj2JQNKOBjRZnRcpmDz/Ri1Oh1NQ8I9kDHtAxMngKJ8/zNnCSfdyO8lCNa77qN0/VQ7R/W/H//UoG1y2wkLSb5A3g1wbVf6b/W88lScYpUnCw2osZ/GDo66EFOu92myA0HeEc3T98sEBfIAE4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1NDKA3jUcCwR08SohW76QoktiW7yDfkNTkQyZBLomQ=;
 b=q3e6DRcWefQYMy2h+8ycoVSNJYC3fR6xUjY9C9sUUJhx6oGIsn9kE3jlg/1ZOQGXCr/7v+yIRdtazeQD1cIB9l588eD6rdGhORjsv4VUx07X84xmDrnA+zkNNAsnReS2LyYvepeYZPS9h4CUsVkjjv33UPnkZIR1DRUPkqBPy6yfDDat8OPvKYsiJ5veUP/JILSGPQajyUzoL4kjfLfSSBYFE7xLUT3bS8VhrFbOnPKojY5JIZcFFW9r0QO1GoJfxld/7buyiqEzIsRN5avXwsnU+1KI/TRsux+cvpH/E0JwmWReQtyKHhi8QNxwjzXJmCC1ryXX2pRexlQNRuMwQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM8PR04MB7459.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:12:37 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:12:37 +0000
Date: Mon, 15 Jun 2026 09:12:25 -0500
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
Subject: Re: [PATCH v2 09/11] ASoC: fsl_rpmsg: Use guard() for mutex & spin
 locks
Message-ID: <ajAISbgHDbQB7-cK@SMW015318>
References: <20260615093824.115751-1-phucduc.bui@gmail.com>
 <20260615093824.115751-10-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615093824.115751-10-phucduc.bui@gmail.com>
X-ClientProxiedBy: SN7PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:806:127::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM8PR04MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2f6ba2-d5b3-43e1-aa8f-08decae826e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|376014|1800799024|366016|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	bVTYyBPTUWP6bOlxReN5i9QsBh5EwkfYj4woeTxkr85azVwR5U7iku0HDVj73bHM2CtqJHTGYvVTtjRSYxYFryEI6oKxdVEP/699oHXkMqlwf7Gw+G9YHadQS0VuutqJaLNNd5lhxtO6VjYSljiQkxRv3tffhghHqNYoInjZs6bKpNMIKVCreUTUrbirAdXIz26dFl9UrFn4/7IfN5DYbvRFx9Fvjh1cH4lMrcVYSUaweqtC4XPhjUm1uuFZZrGVXGshXGGUQ6JebCsG6XGsHZ0QMaNWnIaB25X93guNxi9xgQEdK+wgfSlIMlUIxuvmgesiHJ9zu7wVlX2wdU//4DijtXz/1t1c7XXu/LKQvYE7d4HKdQaisdE1bqV6knhSu+sdBwlx4Kc6H+iS3vT5HCij87crwPpzLfrHo5bLE791vMCIzNaRQa3gmjUn2Zg4vm45wtw3Zw5liak4k90YPHJEVmLGma/OBTd26Uxsex0p24FAjUW2ZwujhuDBT4yT1jrfRq51D5GpQsEq7GRyTCNWhP/FeHgGv8biyjSmwGgrPcuOaXJ0YP9N144e5jdYHFdXlGpHTcvJS5Fj7R2wsPVlnFD2kIsf/BpM7EDZII0og6E+9WnikBqPW0NB3NKUvlhKtsjIjrcivASqmkUXogyGpTsyBUsqAumeGZSF38idC6fQLeW3Q6IurqLv++K1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C1P29ox21Spu/RZwc5M+ClmxnZ1OpHq0svsSKp1p8ghlz0iVW47RYlDygY+M?=
 =?us-ascii?Q?yDhKrjz4V1gqVF2mJjHct3lomwxGlMb415ZkXg9lHgQr4weLUTOHsO34Xvvy?=
 =?us-ascii?Q?K+Hj3mAfWaftHmXc/hjObQrRuvyg8s8eEKShBvCsPHfiGoR0V8pUnMEHXYUA?=
 =?us-ascii?Q?GBiUuI2wH/BwErdL+gzxR1ov828VIMSybsOPoQC2W+8PBBmMlcTfH7uf7G/r?=
 =?us-ascii?Q?S9xo30EEmlwUK4QiKA6upd693Yo47MNRf6n/MnF1+WyUo79J5Z3mcMMUxrwf?=
 =?us-ascii?Q?+B9t4DQtKj/9ONg+Vux3flmf70woRzQgW8evSKJSpGzapbIvJ264MlutuQK2?=
 =?us-ascii?Q?M5feJHhYgO/9yl7blsX9oGUqv6/96KH1Y8hWnZU/8bhmhU7MBdvPDJidpgp/?=
 =?us-ascii?Q?+rhH2u0HaF9+CboVoDD7oi66H+cKdE8RbOcrjVTWQiFJCwJ+4urm50ybHePm?=
 =?us-ascii?Q?kNkFNRSl5FGl77577wUeoh0D5M/H3eHNLmStj2IdMIRNPHOAU4W/FqVbDidb?=
 =?us-ascii?Q?x1lE/htrrg1JebiIDqNk+AOvR6v1YQrsgqz+5Jza0MkLVRFo8hmOOeH+WJ/b?=
 =?us-ascii?Q?5F3r9wYyi6LuHewNfzQn0qNr+IHBZuCRadVGe2XSrwyf6PlUN9wiwnCFByJO?=
 =?us-ascii?Q?nnHtrJIl6HRDve6RvYTdgBXpa7/+LBV99OUMSiqCHjZCx3+WXPki9tAc0HpN?=
 =?us-ascii?Q?dhAqBDMlMNWvuiFEQWJEIZz96hIF2m72y6IHnKEbShqGEbRDyP23ZA1FfIeJ?=
 =?us-ascii?Q?msu/x1LO+SKdKuMnrAgvLvzp3jrUWwqwOJYrOGG+YCDbdbsOHmcd7N693RdK?=
 =?us-ascii?Q?XO+HVoDddDO1oO9tCp8CVEyy+CB9CmOhOoShBEh5zMZjPVOWfrg75PkDaeR3?=
 =?us-ascii?Q?dLyG4rj513SiYKxG/DAnzhyK9BwKGdXrY3qMXZcjdOfa/G7KOiWeWlyLiMa3?=
 =?us-ascii?Q?5h9ryfAK/znfj+LWP46zRXW7ohucb9ohWV5ZF4jLpKhTOb2UO61Q5eCTz1lb?=
 =?us-ascii?Q?2c98m854C5RpJ9xLdP9fsd6rWHIpGFVtREPMZm/hrX+Gs5SKQS9RWGDBZ7zi?=
 =?us-ascii?Q?RCkMFwKaqXxzSA9yOK5CL8hKkYLhOlw5keZneW7oDyf6RKMlBEZGFkndae/+?=
 =?us-ascii?Q?ybptYtd6IIR4MgONfxYAgaU2teOFPhi8V1K0/aHlpHTMC/BTTp7hIpHYYBYk?=
 =?us-ascii?Q?1h+kYzuTgRHsrzipWQmCGl9xLP8qBO2cXnMYy8VaTfzHPlkl6FQ2UNbBc6gH?=
 =?us-ascii?Q?jnyf/vZBG6anr7SRy3w7jE6fenwbVYnE6WrAfopNmEIpHRfmy4qi7CiBseeL?=
 =?us-ascii?Q?Q/a/vvwVoKhqQ/Ld13ethAzZutz0nPt9v8n9b28VL/ZoPf9HY0hyf73XsBZH?=
 =?us-ascii?Q?zUEW/FfXL9olA/5SHPUGi680PvrAHzCvFMGF//NVNd2GdKO1PbsDgEknuQDy?=
 =?us-ascii?Q?30JZAQidzuzeMEU46hBXv8Hbo5vDjqRJtT1p8s9TOv/TpTACnCe1iaEpjjbD?=
 =?us-ascii?Q?5R4VenRYnFO3+O1k5JTZnQqYM+RWfL56m7NP8reM+aOJQkWVErhtoQ4RQ6UT?=
 =?us-ascii?Q?P3artZpu9RPLOa0XTjA0JwytIZDtgITKGUyk29HIbm9d24nZXJlAFoJr1aph?=
 =?us-ascii?Q?Z0EGJxZP5NUKwr6CP9hkLOaSD6nwOl9NcmRAgj8sFNKW4QsURmIbQsftOygS?=
 =?us-ascii?Q?bAhOZzVdRtEyTzG6cDHKQYb9KCRFgeP5E9aJaPmWFfBQwmYqCHAOg99JUmuq?=
 =?us-ascii?Q?5DhX5JgqezMAWbe8FGA5UzTMlLv874ssuVPVH83CXCzRJ+JvBoqB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2f6ba2-d5b3-43e1-aa8f-08decae826e2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:12:36.9851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIR52jUCqw9HpFJFuVR6Bvj8Bpt4zazcvZHJ0amxeGYeEj/LW+OVwVjeTyB9mHV3XOr9xF6xp3lrmzBZB6qO+fGFfcS9mPszdlZjXMxrgaSSThx/QHVT9ecmvUijGRMM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7459

On Mon, Jun 15, 2026 at 04:38:22PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Clean up the code using guard() for mutex & spin locks.
> Merely code refactoring, and no behavior change.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  sound/soc/fsl/imx-pcm-rpmsg.c | 69 +++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 39 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
> index 031e5272215d..7210393dfa5d 100644
> --- a/sound/soc/fsl/imx-pcm-rpmsg.c
> +++ b/sound/soc/fsl/imx-pcm-rpmsg.c
> @@ -39,10 +39,9 @@ static int imx_rpmsg_pcm_send_message(struct rpmsg_msg *msg,
>  	struct rpmsg_device *rpdev = info->rpdev;
>  	int ret = 0;
>
> -	mutex_lock(&info->msg_lock);
> +	guard(mutex)(&info->msg_lock);
>  	if (!rpdev) {
>  		dev_err(info->dev, "rpmsg channel not ready\n");
> -		mutex_unlock(&info->msg_lock);
>  		return -EINVAL;
>  	}
>
> @@ -55,15 +54,12 @@ static int imx_rpmsg_pcm_send_message(struct rpmsg_msg *msg,
>  			 sizeof(struct rpmsg_s_msg));
>  	if (ret) {
>  		dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
> -		mutex_unlock(&info->msg_lock);
>  		return ret;
>  	}
>
>  	/* No receive msg for TYPE_C command */
> -	if (msg->s_msg.header.type == MSG_TYPE_C) {
> -		mutex_unlock(&info->msg_lock);
> +	if (msg->s_msg.header.type == MSG_TYPE_C)
>  		return 0;
> -	}
>
>  	/* wait response from rpmsg */
>  	ret = wait_for_completion_timeout(&info->cmd_complete,
> @@ -71,7 +67,6 @@ static int imx_rpmsg_pcm_send_message(struct rpmsg_msg *msg,
>  	if (!ret) {
>  		dev_err(&rpdev->dev, "rpmsg_send cmd %d timeout!\n",
>  			msg->s_msg.header.cmd);
> -		mutex_unlock(&info->msg_lock);
>  		return -ETIMEDOUT;
>  	}
>
> @@ -100,8 +95,6 @@ static int imx_rpmsg_pcm_send_message(struct rpmsg_msg *msg,
>  	dev_dbg(&rpdev->dev, "cmd:%d, resp %d\n", msg->s_msg.header.cmd,
>  		info->r_msg.param.resp);
>
> -	mutex_unlock(&info->msg_lock);
> -
>  	return 0;
>  }
>
> @@ -109,14 +102,13 @@ static int imx_rpmsg_insert_workqueue(struct snd_pcm_substream *substream,
>  				      struct rpmsg_msg *msg,
>  				      struct rpmsg_info *info)
>  {
> -	unsigned long flags;
>  	int ret = 0;
>
>  	/*
>  	 * Queue the work to workqueue.
>  	 * If the queue is full, drop the message.
>  	 */
> -	spin_lock_irqsave(&info->wq_lock, flags);
> +	guard(spinlock_irqsave)(&info->wq_lock);
>  	if (info->work_write_index != info->work_read_index) {
>  		int index = info->work_write_index;
>
> @@ -130,7 +122,6 @@ static int imx_rpmsg_insert_workqueue(struct snd_pcm_substream *substream,
>  		info->msg_drop_count[substream->stream]++;
>  		ret = -EPIPE;
>  	}
> -	spin_unlock_irqrestore(&info->wq_lock, flags);
>
>  	return ret;
>  }
> @@ -523,7 +514,6 @@ static int imx_rpmsg_pcm_ack(struct snd_soc_component *component,
>  	snd_pcm_sframes_t avail;
>  	struct timer_list *timer;
>  	struct rpmsg_msg *msg;
> -	unsigned long flags;
>  	int buffer_tail = 0;
>  	int written_num;
>
> @@ -553,11 +543,11 @@ static int imx_rpmsg_pcm_ack(struct snd_soc_component *component,
>  		msg->s_msg.param.buffer_tail = buffer_tail;
>
>  		/* The notification message is updated to latest */
> -		spin_lock_irqsave(&info->lock[substream->stream], flags);
> -		memcpy(&info->notify[substream->stream], msg,
> -		       sizeof(struct rpmsg_s_msg));
> -		info->notify_updated[substream->stream] = true;
> -		spin_unlock_irqrestore(&info->lock[substream->stream], flags);
> +		scoped_guard(spinlock_irqsave, &info->lock[substream->stream]) {
> +			memcpy(&info->notify[substream->stream], msg,
> +			       sizeof(struct rpmsg_s_msg));
> +			info->notify_updated[substream->stream] = true;
> +		}
>
>  		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>  			avail = snd_pcm_playback_hw_avail(runtime);
> @@ -640,7 +630,7 @@ static void imx_rpmsg_pcm_work(struct work_struct *work)
>  	bool is_notification = false;
>  	struct rpmsg_info *info;
>  	struct rpmsg_msg msg;
> -	unsigned long flags;
> +	bool updated;
>
>  	work_of_rpmsg = container_of(work, struct work_of_rpmsg, work);
>  	info = work_of_rpmsg->info;
> @@ -651,25 +641,26 @@ static void imx_rpmsg_pcm_work(struct work_struct *work)
>  	 * enough data in M core side, need to let M core know
>  	 * data is updated immediately.
>  	 */
> -	spin_lock_irqsave(&info->lock[TX], flags);
> -	if (info->notify_updated[TX]) {
> -		memcpy(&msg, &info->notify[TX], sizeof(struct rpmsg_s_msg));
> -		info->notify_updated[TX] = false;
> -		spin_unlock_irqrestore(&info->lock[TX], flags);
> -		info->send_message(&msg, info);
> -	} else {
> -		spin_unlock_irqrestore(&info->lock[TX], flags);
> +	scoped_guard(spinlock_irqsave, &info->lock[TX]) {
> +		updated = info->notify_updated[TX];
> +		if (updated) {
> +			memcpy(&msg, &info->notify[TX], sizeof(struct rpmsg_s_msg));
> +			info->notify_updated[TX] = false;
> +		}
>  	}
> -
> -	spin_lock_irqsave(&info->lock[RX], flags);
> -	if (info->notify_updated[RX]) {
> -		memcpy(&msg, &info->notify[RX], sizeof(struct rpmsg_s_msg));
> -		info->notify_updated[RX] = false;
> -		spin_unlock_irqrestore(&info->lock[RX], flags);
> +	if (updated)
>  		info->send_message(&msg, info);
> -	} else {
> -		spin_unlock_irqrestore(&info->lock[RX], flags);
> +
> +	scoped_guard(spinlock_irqsave, &info->lock[RX]) {
> +		updated = info->notify_updated[RX];
> +		if (updated) {
> +			memcpy(&msg, &info->notify[RX], sizeof(struct rpmsg_s_msg));
> +			info->notify_updated[RX] = false;
> +		}
>  	}
> +	if (updated)
> +		info->send_message(&msg, info);
> +
>
>  	/* Skip the notification message for it has been processed above */
>  	if (work_of_rpmsg->msg.s_msg.header.type == MSG_TYPE_C &&
> @@ -681,10 +672,10 @@ static void imx_rpmsg_pcm_work(struct work_struct *work)
>  		info->send_message(&work_of_rpmsg->msg, info);
>
>  	/* update read index */
> -	spin_lock_irqsave(&info->wq_lock, flags);
> -	info->work_read_index++;
> -	info->work_read_index %= WORK_MAX_NUM;
> -	spin_unlock_irqrestore(&info->wq_lock, flags);
> +	scoped_guard(spinlock_irqsave, &info->wq_lock) {
> +		info->work_read_index++;
> +		info->work_read_index %= WORK_MAX_NUM;
> +	}
>  }
>
>  static int imx_rpmsg_pcm_probe(struct platform_device *pdev)
> --
> 2.43.0
>
>

