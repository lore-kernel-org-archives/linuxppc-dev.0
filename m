Return-Path: <linuxppc-dev+bounces-28032-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78A5C98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 15:10:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqgPk4BXYz2yqw;
	Thu, 24 Sep 2026 01:10:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790176218;
	cv=pass; b=Ac8FtkGqxsPGNMMsirCiqh/t5dK1l8Bm4ctk4RbUsiCjGVQ8xNyz/D6208mGHiCAC9ydeHBWDD79p2UwRvlarLsYBartOy2L+20HrJX+To+f06tJkCNwJDxfDnSSk7fk22YhGargSF4bQw2krdvmv9mt4NPaTJN4HQ+bGQYtvWYEUp66eIPHvd+M7Wco5jGYoYsfSvlFICiGcowPru33XswKKUG77lJH6BeApln3jsDTP3Z75Mk8L4HenM10XwVDinoXXf81JknvNHB531sdQz7fwPJg8Nxf08/iw8S6AS1O7oWEt8bKZ5zsXj99glChC9wO3ZiwKIpWtIDup2TYRQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790176218; c=relaxed/relaxed;
	bh=1Y8ZjxH2QS8Il7T7u2QklNAQFDGovakGfSPOZtOesvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TOj7ODS/3WRuvSE+xxnkQojN+bnBuLT4JwALN1H2PnnuIt43X2KInG1VVoXY+75ivWnac3V1HBkb0PIxQLL4K0FGb4+3lN/uAMKFu0CTRyo8A13zL+Ux1Aefzff9vs5NcjLPbgBL3/7TCjDiyJYbbvPuST8Kl8LVYAJ2mqOpdjWgRhVg6+VEBwZY87Kf6ufXeUb+TLUHTQcfABM0mupQUgcuZSubijae+xVZYSJ2wjkqjNaUy4RkccuGTToVlHPV9WWJcDQnl2sqt/PB6wlMHq5izTZdRgQgMNRFh9MZsDjgON65z4guQuTKeuTFdJBSkNEHIVPUsA4/IFYfz4nWIA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EqQmeTTj; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EqQmeTTj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqgPj4GWkz2yqq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 01:10:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l56gmFrrdqlGRqEdsdMX/HE+1z1M/UvVG/TdcMNhcUa0JH+hwz1pl/fPhE8qGBYhzGkLXdPEKV/WaMBLB3J7Jge0EUFYkHdryJ3acbZF8JA8Mv3Ydirq74l2aGbFntbiG5XAoDyNnB554IX1Y8gSlLtv4VVLJqsJsGCz7GMSi1fo1+eHYMyc84rhQPW0rgw/27Tdo/BtpNNEMh1qWGgm0Gzex8EXdh0lMTk6jz7ky1COPPeVBhQopK053xGc3w5AucXpk1zbEfI9auOT2i2Gr6EhD6n4m92Q8q2KPupZK1w3hVS2qb9VaoGJdW2G26t2zMHwd1WDQdjwf9oxXnRjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Y8ZjxH2QS8Il7T7u2QklNAQFDGovakGfSPOZtOesvg=;
 b=skvBA3qAhEgeURQ1b8BJOHsTVCah6cyEap0hey/Nqk4telL82YbyTB3jwmoQ3+G4+ZAAt6lBn1+JkLvaSFzLWSIH8EiDt6053VBqsuMHQsJ4XTTzovCcwCZMgBXemmIanocnK5UrUHQdehVOEC7I/su7gWWJ9oGCiQrNzt0YGd+gNaDSepMSOvsnGCE6wI0qs7gsdmYavKQUdhm5FKdUiNcDImJrrCMNAgx/aAMk5G0GYWXh9JA0Pxtk3yT57KTPyrIvI7XX30s8N7DwP9ed42G0NRhZwru02L2bTxUsEvA/SCrN2cgIBSTalwz6WZ7APCJVhBqnH3VbJceqQ/Zquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Y8ZjxH2QS8Il7T7u2QklNAQFDGovakGfSPOZtOesvg=;
 b=EqQmeTTjJn2VbOooK93XuCpuM/NtVSqELXVQdv74El0h/+k4F6XfqCRBtNlj0CCXlTMIEZ1AtWWYMp4oMmWAk1WwGOx5TgXUvf8EYpvp46OPxTKXaSS1UWCfxbaEyA9avoOMm5iADuABtU7syCY+39Tbc39oRbr/hfFv1F3hojg11Ng1w9ipGIJrj38YHqQXZPhxTZmXbz/vcNFiNjGR7HbA/J6IfCDk702Gt2KzEbkYMtd4xkz+Ad2HdeaZhvqN7ByDpJlhLicIgh9y+IBwmfonrV4ofbY6C4PKkDR2n9r3MChTt8vRpb8rJq2st0PwMQbkblHj1qHYKYe2nQaVIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB7962.eurprd04.prod.outlook.com (2603:10a6:10:1e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:09:52 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 15:09:52 +0000
Date: Wed, 23 Sep 2026 10:09:41 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: shengjiu.wang@oss.nxp.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	shawnguo@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [RESEND PATCH v5 4/5] ASoC: fsl_asrc: expose individual DAIs per
 conversion path
Message-ID: <arPrtTnF3XBxYcAf@SMW015318>
References: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
 <20260922033428.1690822-5-shengjiu.wang@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922033428.1690822-5-shengjiu.wang@oss.nxp.com>
X-ClientProxiedBy: CY5PR22CA0104.namprd22.prod.outlook.com
 (2603:10b6:930:65::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBBPR04MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 18970c45-d0e2-4c07-444f-08df1984b7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|23010399003|376014|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	MLcCHXHto+ou0d5HOiUSUKnrqGOBS3V6Z4Iw0Y+uH5MGluJMGRwHQx+6DGNkYN7o9bbBnYQG+aGZ66eimoyWGOuGqjtvqTSvwR1KMFLBPuCMc0SGO/LaExHBmhkfBN1ffg4NJf9IKVEMyADYU8s4PxOHVn3u9cmKh32DcnLGELSAxj7IlTxMYEN2ggu788z/mAhR8F3wguX2mFeaZinPCKDRAYPt6yVYxAMbOvVfmXvH9Cr+74bct838vFvRRfTjo3Thi1UHvXhnIFsZZbKa5sRsqur5hDr9FRegPbsa5X+mqtxytdfpgAvJxPaJmnwLaj4Oxl1dfbj5ugcd4Moh+ciecuPO2BxUlyfVoUADR4TBaOXkqgNtsBrVx9IfJDcq9cudjvoqH0sQzmOtMkMp2geXhDzq5U0z4BPRXXRubwlTF4BLZ3oUfgfg6uFNu1C30E8cTqF45AFvsnsWzapMZ5LcMm7nNncLmL4hEG5g4R9FJ7N4gbRnrHojZQyWUvi8WNWQQE3JUsog/WsjrZJEz0aCNWm36kKqPdipSj3yThIaDjthbtaZ27ZBcPJs+oG3FvXioh4v6vD2QnVoXN2yjSVRr0w52bfdgOHG3Bi4Q33L87id+vwG/BGZcVzbUgEi9SJgQ80YRfgsl8lXC2tntsZrCyvkbQHO+vK5SHaj+Ho=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L4pXHqDmYGc11QyGufQmjlaJ04R9ig4hfFFY5SuVjkmJBCzB5yKJGifsQr1S?=
 =?us-ascii?Q?+hvvNCCcCdlSbRmH5Fm94PDqgak65ZngSMUfCpTqo8e3CNfg0EYY78cEvkyT?=
 =?us-ascii?Q?oOrg2XlFclgd1xAl4mteqTRTYnEIB10wWgLW9F3ODZhn4fGLpycEr376ln8z?=
 =?us-ascii?Q?1cwgVtceH5a4P4cfi5s/YwsW3jKZEAHmbgqPq0yMFizL9XQqZYFjRanXuXd9?=
 =?us-ascii?Q?gvT7jnLbTsRtwrj5hYVAJNVrycuCOsV3FacXgkpJ0FQTYHzYixLet5Gj1alj?=
 =?us-ascii?Q?IALNdjNYDWAGnShnsIArutu3xqr67xnOoVYKirL7aaTckmONFPNcgi70rKbS?=
 =?us-ascii?Q?q67xZdMy63oiwbrsaRx3vJHR97jMbgouG7+ifMqu9KMN7eHSDLLwZCIqULn4?=
 =?us-ascii?Q?9+/Fd8jsY+/yIdktgxxkkgvRiyq5QxVNBe4Z/SNlvlKJHsE87n87sUqRZRZm?=
 =?us-ascii?Q?kYYb1nWXFRVJDmfJHhZg9mSc2MDuWHEOoXYy6Rd1eyFFLWyyfPo4mF3CKyW4?=
 =?us-ascii?Q?qSoo2TYRk/XG8mxC19sB1aVADj5zlPorjFgsP60gkQGmAgUgSXSePeQUXHX2?=
 =?us-ascii?Q?Eoj+f0LnKA32aqiKpXAzLZ7l2ZAl5LeO2tamTegpA/lO1FHst4DLHet66JwG?=
 =?us-ascii?Q?Njkj5w0XtzcF0PjZP4lPWDxTk0X/S6amG+npFE1Wi7t5T05I+Nf5ZDaUVPAW?=
 =?us-ascii?Q?/UGUTok35IHpEZsw0XWZJhYhTGZczMWFOGh1irWt8XeY+uBnmxzoRbogjx2E?=
 =?us-ascii?Q?zFerd3yahEav4FpUxeZBEBMDofsBXrCgnFVhmoIKBvQLG3Z8M1oZjDc5O64B?=
 =?us-ascii?Q?NbhRBJX4bFQHIi8uu8O6gQ/8/khMiNzDSSqr4WtQFzbG+9gxJMiurgjSSakW?=
 =?us-ascii?Q?Lk4vXlPXxjfY5EFkQXwfiXl7qXGlNPpM74jGaO6MkPrALbyNKzUySryPgtDy?=
 =?us-ascii?Q?FHUNRQMhf2fDlAIq7Xk1v0ONUzL0fB5BwiOT2iK5WaGn87nsMRloRQN8pTxY?=
 =?us-ascii?Q?akhWQr2R/gxs+tsaX8MjmUMU06Pjov60qV9OjLwqdzVtst43HN7hZwkAZCDU?=
 =?us-ascii?Q?GhbkfBeyQ3kYQ3/5968U3+eGbjf44hWXS4vmRTxpifDp/zbwkUDEpBBtCN/E?=
 =?us-ascii?Q?XE3eeBHnMo9UIUuCiOwWzSP8WPfgqJj42+N9ogPXTpGuDalsvjDeFxPlf66M?=
 =?us-ascii?Q?dmHm/cI2CKEyimsmXdXpLC+MqYN/tr6y3MlKS2hQy49MagDUSbCAxl4ZX5l3?=
 =?us-ascii?Q?seTFGybniPa6sjK0LwNm45HaTBBBMCYSVWg8h44AiVCx+ASqEMsj6sunuX9A?=
 =?us-ascii?Q?HYpwDUma/23RnHZo12o89rwcVKg1bWWBzTeFdZ4nCTwECJQ+zMiziQiRRWD8?=
 =?us-ascii?Q?GOjJNxqGZ7zKIXjooSDB92tVZcgvIouIhGcgRp11hWlj0oC3UQDm4QS6YE4d?=
 =?us-ascii?Q?mwYXrXmLV4vSY3GUPtFECehNqdpDMaaNuy3xZtdeKXaintJ9uUYzmPgUUNTT?=
 =?us-ascii?Q?sxEDYk5B6xg0RYhx0UVyBxzTnL/xJ6FRee2CHS7A8zFhGqplTs4GV3dP8Aas?=
 =?us-ascii?Q?tVGqITOxCLWVpY5m6qmd1c3LKAFJvNFrMZcJMc4Vm2D9+eGzGcT75rH+mrCp?=
 =?us-ascii?Q?SZDY+/abUvyojpNE+/kWHkNOpFOkof8Gvb6aOEjU5RI9ASLgHtBgeqs6Pjfc?=
 =?us-ascii?Q?wYHuVS+1A5vHJOSDUtfS/siOB/TvHYWsx5OY1kqBlAJ1vnZNISJ1mxBj1pSq?=
 =?us-ascii?Q?uC2WNy/THTt1twWuEf3+jA/ocHXaNo4wKQcTVFsZXArYocVDUBad?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18970c45-d0e2-4c07-444f-08df1984b7d8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:09:52.3678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIWI+x2KWcS/WgY0YN0++lcakc1whrJT77RDWVPYQ1iUpCN0LnMyptpUauqI8UOyXe1BbSQ9u8PYURxn8rhpv4wmfl6A+ixAVL7iWwlTp+siRNoyS5BKfetDWRkoAi5I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7962

On Tue, Sep 22, 2026 at 11:34:27AM +0800, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> The i.MX ASRC hardware supports three independent conversion pairs
> (A, B, C). The driver previously registered a single DAI with generic
> stream names "ASRC-Playback" and "ASRC-Capture", which prevents
> multiple independent conversion paths from being used simultaneously.
>
> Replace the single fsl_asrc_dai instance with an array of three DAI
> drivers to allow up to three independent conversion paths to be active
> at the same time:
>
>   asrc-0 -- ASRC-Playback / ASRC-Capture (backward compatible)
>   asrc-1 -- ASRC1-Playback / ASRC1-Capture
>   asrc-2 -- ASRC2-Playback / ASRC2-Capture
>
> asrc-0 retains the original generic stream names to preserve backward
> compatibility with existing machine drivers and board configurations.
> Each DAI retains the same channel, rate and format capabilities as the
> original. Update the devm_snd_soc_register_component() call to register
> all three DAIs.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  sound/soc/fsl/fsl_asrc.c | 89 +++++++++++++++++++++++++++++++---------
>  1 file changed, 69 insertions(+), 20 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 6007786aca66..56604fa1613a 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -792,27 +792,76 @@ static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
>  				 SNDRV_PCM_FMTBIT_S16_LE | \
>  				 SNDRV_PCM_FMTBIT_S24_3LE)
>
> -static struct snd_soc_dai_driver fsl_asrc_dai = {
> -	.playback = {
> -		.stream_name = "ASRC-Playback",
> -		.channels_min = 1,
> -		.channels_max = 10,
> -		.rate_min = 5512,
> -		.rate_max = 192000,
> -		.rates = SNDRV_PCM_RATE_KNOT,
> -		.formats = FSL_ASRC_FORMATS |
> -			   SNDRV_PCM_FMTBIT_S8,
> +static struct snd_soc_dai_driver fsl_asrc_dai[] = {
> +	{
> +		.name = "asrc-0",
> +		.playback = {
> +			.stream_name = "ASRC-Playback",
> +			.channels_min = 1,
> +			.channels_max = 10,
> +			.rate_min = 5512,
> +			.rate_max = 192000,
> +			.rates = SNDRV_PCM_RATE_KNOT,
> +			.formats = FSL_ASRC_FORMATS |
> +				   SNDRV_PCM_FMTBIT_S8,
> +		},
> +		.capture = {
> +			.stream_name = "ASRC-Capture",
> +			.channels_min = 1,
> +			.channels_max = 10,
> +			.rate_min = 5512,
> +			.rate_max = 192000,
> +			.rates = SNDRV_PCM_RATE_KNOT,
> +			.formats = FSL_ASRC_FORMATS,
> +		},
> +		.ops = &fsl_asrc_dai_ops,
> +	},
> +	{
> +		.name = "asrc-1",
> +		.playback = {
> +			.stream_name = "ASRC1-Playback",
> +			.channels_min = 1,
> +			.channels_max = 10,
> +			.rate_min = 5512,
> +			.rate_max = 192000,
> +			.rates = SNDRV_PCM_RATE_KNOT,
> +			.formats = FSL_ASRC_FORMATS |
> +				   SNDRV_PCM_FMTBIT_S8,
> +		},
> +		.capture = {
> +			.stream_name = "ASRC1-Capture",
> +			.channels_min = 1,
> +			.channels_max = 10,
> +			.rate_min = 5512,
> +			.rate_max = 192000,
> +			.rates = SNDRV_PCM_RATE_KNOT,
> +			.formats = FSL_ASRC_FORMATS,
> +		},
> +		.ops = &fsl_asrc_dai_ops,
>  	},
> -	.capture = {
> -		.stream_name = "ASRC-Capture",
> -		.channels_min = 1,
> -		.channels_max = 10,
> -		.rate_min = 5512,
> -		.rate_max = 192000,
> -		.rates = SNDRV_PCM_RATE_KNOT,
> -		.formats = FSL_ASRC_FORMATS,
> +	{
> +		.name = "asrc-2",
> +		.playback = {
> +			.stream_name = "ASRC2-Playback",
> +			.channels_min = 1,
> +			.channels_max = 10,
> +			.rate_min = 5512,
> +			.rate_max = 192000,
> +			.rates = SNDRV_PCM_RATE_KNOT,
> +			.formats = FSL_ASRC_FORMATS |
> +				   SNDRV_PCM_FMTBIT_S8,
> +		},
> +		.capture = {
> +			.stream_name = "ASRC2-Capture",
> +			.channels_min = 1,
> +			.channels_max = 10,
> +			.rate_min = 5512,
> +			.rate_max = 192000,
> +			.rates = SNDRV_PCM_RATE_KNOT,
> +			.formats = FSL_ASRC_FORMATS,
> +		},
> +		.ops = &fsl_asrc_dai_ops,
>  	},
> -	.ops = &fsl_asrc_dai_ops,
>  };
>
>  static bool fsl_asrc_readable_reg(struct device *dev, unsigned int reg)
> @@ -1393,7 +1442,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
>  		goto err_pm_get_sync;
>
>  	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_asrc_component,
> -					      &fsl_asrc_dai, 1);
> +					      fsl_asrc_dai, ARRAY_SIZE(fsl_asrc_dai));
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register ASoC DAI\n");
>  		goto err_pm_get_sync;
> --
> 2.34.1
>
>

