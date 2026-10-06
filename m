Return-Path: <linuxppc-dev+bounces-28950-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7FBCA5FFC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 08:28:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzTsW1w8Rz30BJ;
	Tue, 06 Oct 2026 19:27:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791275279;
	cv=pass; b=DKDRAqNse64uNvZbIChJDt9C9mQUmvt3F+SvMv8+OgUrftc/xKgQF4TDlZAuHrpiVtSX/1sbJZ4SQDa9pFbA+o2Z8lsMCAuQIDj7dsWnmMXr79R9ls1sv+8K1wroHERx+XVQlZIXg6vrCv3weWFs3E4vq4yB5ntdmoeJzsl9Ud6OKIbUB6+wBLAdlW8GoZNO/uZBCg785QMQWz6asPDpoH4pNyzQBb4KGZKo9EXVFkBfGw0v2dW+eJrbVIAf29g0hFmp84ConWTFMrUfvsPkF1CGTyoTr/sD0L7mZuWiWWolNtcBp5CeGNu2RQexvLNmbYLDIyIi1xoiHdaWUMOjEQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791275279; c=relaxed/relaxed;
	bh=R6UX9FOCxnPERDtfE34v2HJ4irAhAvrxNHsdogmE14I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C0NSfm6CjCjRMp7W98aWhlG6xVcZz+wrYZHHvzsYdKDuVizLvp43P+8FYiBcPCcu8enu8Vcj08OG9YeOQUA7jun27HP7WLa6VNS5Rh89Ulvu7rR1LwVHXuFGQtmPNH1oRjwkAPgH0auJcgnnE5nir5TzNPOXNzL68yigmTgXZjlexequbhOV2260PUBgeB/DBHqdKy2iOnq9IL7uRld9YXQe8VJ9W2VyHfqQ5ioG9/Ot4IlZz56eWMJ7YsAiKPQcSZKZKCx4oCnT/KY6NH/NSfKV7jz/I1GQkA6Fc4tjqsL4K/Xo4Mn5t5P3KrX/IMlB3Ia33VLk/hpjTtAfjyHYxQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LJr3YWqv; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LJr3YWqv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzTsT3ptxz2xnv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 19:27:56 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u40mECQCARlWV5T2ljnlHRJK8JMB1kJR38Fure66RPjDhZUwFXfurAUiLTGeFQXO/amq6hjfGOSktdxFZ1fmlYzfuCi1TJBNa6DxgigE2uEPr0QfKk7M2X/nKXVsbDwhHdkG49QR2r6Qfj7d1Ugpco0vHF4zLEHwuHQlKYqUlyQfvYmm5+frwBsDntT9VhcjUqN6susbgscrWz0doF3oNg4lpWfF6BRuu04fSUjobVWXKA97oeyrKc2lsbgxxEvfx0hqmDYDceMhz5Snc8Xho1qwd2srjfpATgPyhb72C0iM0glwKAvX7p9PNX+GzmIWCKHLymmlQj6jsKglFMFzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6UX9FOCxnPERDtfE34v2HJ4irAhAvrxNHsdogmE14I=;
 b=vVlt4zmnKZ6GO4VUQtO6NzUZLqaOH17TX+arj56ZbnKDLc31Heb7DLM6WYy5P+3E9B7RFKMT1XwFKhPG7VM5OUQWSFs0SsmoL8jjnSccdYZ0k7f0TUPiIPA/pkRqS6hzG0fuL9shpK4xWsslUp1cJ+yNtL6B4R57HQssEaxCSflTfiVtO4+20z/phLLsEyI4DWyTlDkvhQUTTSw/KC3PV3N26rSdDuiLefNcFqvL1QzyLh1eFAfptAbAH8AstdvneqY5qi/py83ENb5GnkK6Kh6829OdWmIrV43Z3nWpc24RZSqoHKPA2IF8yxD4gxw/0FL7jti1Tj2FOWLXm3NHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6UX9FOCxnPERDtfE34v2HJ4irAhAvrxNHsdogmE14I=;
 b=LJr3YWqviBcfFWm9+qjTk50HmzcuxO51QzVeQn0WlUNBSeIJYA5y1X6Nl7o7TplonetUHTU1W1G33xINK5ojHPYS+S6UvE7n94l/KO0UfeIBHZq+p82pDAvDxYg1CMaOAXlpLJLEAl9OD/bUyEh9Axx4fUDrm5PzZsUwgfbICdxFEWwp+xtnRvCo7eY0mtNVHvvJngZKRsztn3PJs0Bv7MG69yglscogPHqYnMDrPbREbvWUeyanytHcRnJCWu+huDmGV6sityIO9U8J36wPcKkdbzDJ/kpbaCkWG3M/Xlr5POeKhpGfjQPUi+4Xb/GwGGoYtOCg+xrg2JimfxoDJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17) by AMZPR04MB185575.eurprd04.prod.outlook.com
 (2603:10a6:20b:7c2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:27:31 +0000
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8]) by MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8%5]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 08:27:30 +0000
Date: Tue, 6 Oct 2026 11:27:26 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Horia =?utf-8?B?R2VhbnTDhMKD?= <horia.geanta@nxp.com>, 
	Pankaj Gupta <pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Yazan Shhady <yazan.shhady@solid-run.com>, 
	Jon Nettleton <jon@solid-run.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/3] crypto: caam/qi2 - skip isolated CPUs
 when setting up queue pairs
Message-ID: <cozavqeupdtr7cyn33nvtfqoqkw3sop5tffou6753vwg63hgwf@jr6gx236yblx>
References: <20260930-dpaa2-isolcpus-v1-0-66c13f4fd75b@solid-run.com>
 <20260930-dpaa2-isolcpus-v1-2-66c13f4fd75b@solid-run.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-dpaa2-isolcpus-v1-2-66c13f4fd75b@solid-run.com>
X-ClientProxiedBy: AS4P190CA0052.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::24) To MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17)
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
X-MS-TrafficTypeDiagnostic: MI9PR04MB019273:EE_|AMZPR04MB185575:EE_
X-MS-Office365-Filtering-Correlation-Id: 64463fc6-f9e8-4958-e957-08df2383a9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|19092799006|23010399003|18002099003|22082099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	m4GUHkkBIP9YohXJmdxBqzoS3X8t25JI46U8XcE/IOQZoXXcImY65+FNQ29/dZhUDNbsCedZmVBIDO9UzvEPu4osjo+gH7y5p80tMS+RAkqxRDKnBMqPBrzcwDvhMvuwPaAKv/q4es6P0TjnVdXpbUd+kq5B8W/zd4cueGvxu7ZyqpA8TJRQOvQdSj5Kigal1DCqL2o82VeYYnM9KUx7nb4cKo/3rhN7RhUnR23toqhgcx/S1rfhgzfdpUffPHU4vtujmVNAh0WxXY8/BdeZJ1T7VSb4EqbX3khCYsMaXKVW/RUzGceUOumHXWpq6Kch3GqhmKoLj49HDspjpfqOGqx3/hXDk8QU7QvK9pvtyoD9p5t9YpQWqJZLcOR5DiVKHzlxxEdVvHb3Lu8n9cniQnbAEK2MCWrcyRPMg19oNvtubKvXbffaRapQIHymKRVZBhRezrT034X7xfmYnDyiuyPM82arVTgEP+SUto0Hsu/JgiqL8IUPRDPyBb3WDMF2emywWu1ulLDzxllAqxo+IjtOh7tldRDnOyHQW4qdlJ+LwO4Hy6UBz3WADv6m3032x8KsREAgbHlzB+omrgEVagXgiWayZ2lI9sFeiihupRK3cIMZ+YELtlUl3yXkJepdJUtxKzrSiJJxNdm89Pf5ZKAeWxIjw7ksHg9PD28G0q4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR04MB019273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p9CmlnwljFndTQy/nrWXa1Ic/wTmyOY57TNbYFABAGbmDWRANr0SbCTy1KlY?=
 =?us-ascii?Q?Ld04B6FfaCqidL521bOtmIOSf//d02D6FV7g6R7tZWpUzAyAncKqsmyndAZI?=
 =?us-ascii?Q?tcs+xMK6ABMgimIdPpdvVIIileJCKNzuZ0OTb+pRi13rVkTCHfBhbvSIepFA?=
 =?us-ascii?Q?zBIG7pTkwJeSTGGx72FX5zlBZkX3EI3OLVh7F6DUMWixpiKNEttNDL/jPwQK?=
 =?us-ascii?Q?eGwGntlVqXGLBN8vEKlgJFFEwctSudC4EQ2lRc3dhrt4PHiHD9JzeyTqX9GR?=
 =?us-ascii?Q?lIVl2rVHdhivsAEKPvpWsJHOcAMVj9tVSl7ks2e/IZOX6AKCw+oBfzCql4E5?=
 =?us-ascii?Q?DcqCTY5Zh1jmPm03naVJTpYgJD0ozNRquL2kFDn7NO6dNUdRTV1gVUHfjBuF?=
 =?us-ascii?Q?NCrO/1AZU8KvtdeXKfrVxseRZof5/uOgpUFtA4LnksNPWBaOw1qA8Jr0Vs16?=
 =?us-ascii?Q?M6SNPWh0Yex7K8qi5PeDuy2twnB9LzohTNgSXZqvvojQtHCZe2uZmqoPHfnd?=
 =?us-ascii?Q?/PKnp9aS5kFV/WbrP5C6F/uEsxnpmeON0XMwPidld9wDYhI3wGncWVRBvnpr?=
 =?us-ascii?Q?Rl/2bhD9TXZzSChGPTLcF2yyCCuffJK2cIeqOmNds+Xpcgw6tJOaNgNS8ucD?=
 =?us-ascii?Q?4Pe1UFMiYE4FHvy05gU4Fih1WBwxdQAD3BheUWJHhuAJlvz5E9gmX77ijcXI?=
 =?us-ascii?Q?3vyTDyYraWg4aHUPH4CpevL7aZXpjI/EUduPaO2WDh/OrBLmvgTWqMghC6uz?=
 =?us-ascii?Q?e1i6LjnkP5oe3bAytjCEAV4ZNXl4XUJpmoAYarN6aGisTwdVCy3Xxd+YEwBh?=
 =?us-ascii?Q?1WzGvytnXUfJbrx/RuovCPecwPSqmWv8xg8m8SmsRvw32ywRjyEnP9msghar?=
 =?us-ascii?Q?ndcaM5tZGfk0RYtVp+rQzowdLDeYJw5VAk9pOyw9xK7owLixyYvfLqoLy1Q1?=
 =?us-ascii?Q?zC81YCi2TadqSWltXvWizAz+AiB+GSsvNJTBM4zdEGU7pLNSNV2sJlSgtvno?=
 =?us-ascii?Q?jphYngcfmk0kjgMffzb9Y24CzzF7b0c7oEjQROpyvlEsXo7yAVxzCTEn0n+2?=
 =?us-ascii?Q?vvfyYDNcBH6L4M6YC1kIXAgbtbu1quMvjot0wj2LM8FLyX37UyAXI12rKQLQ?=
 =?us-ascii?Q?3NHsbeAucPyt22LN6BFX1R/45Og+rMOH5ZlQ74AcaDrzaOGTxavUBYyaBkz3?=
 =?us-ascii?Q?UyDzWixTEh/BdLXFnkZZR3IEsM2xHIOCjGEPsP9ibx+wIAgn8LquoCWg7qPE?=
 =?us-ascii?Q?QUeGNz5Vuez0rFISjlY8DVdrpY1vobx0YCfdyBpq0D+rxi8gJta1hVveC+1k?=
 =?us-ascii?Q?QlJXSeHDHLMLtDn2mSNTteHrVLVOo84HfZlDdgzN8iHMjydkvTVcTXO+BOyU?=
 =?us-ascii?Q?PVtVJCL8FpHMqS2pz9yklUW2i3FleS5AzALBK+fp6xDhALE+BT3s9UDGB4bJ?=
 =?us-ascii?Q?4AoGGciqenxF3NCIG1SSuh7TA0fr9YSwoU5bwVmsrwW4toHQvZQmvfvW4Lgo?=
 =?us-ascii?Q?1LeVM/iGp99h05JjCSS1zx9OQUb5Lrg7+UlVownkAVhy8Zgnb8d4HAMuTyDT?=
 =?us-ascii?Q?Wh7JiRMpg7sNj/rIGrFqTC3U0fL/0A16wbnnmx4WOVz8kgOfbl25IYoQo0Ro?=
 =?us-ascii?Q?qXiOk1t96QDS0W8WldXS5snai8KDprzQICy07FhzffU99QvBB1YbRYBlTqSR?=
 =?us-ascii?Q?I0bO8P58tF3QmGr0f7BKujpB9kn+0kaHqdzQzy4/ZhrcZzE5vPeU64wv7R3K?=
 =?us-ascii?Q?zU5vFrGf0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64463fc6-f9e8-4958-e957-08df2383a9e4
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB019273.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:27:30.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJNW3OjYa4HV4GvI93c7R41Nwx4jD2ZtqF/yyxlg6dLVx0vdTuF/8LLNONnTlV67XBddymI8nAqjVkvoBoG22w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMZPR04MB185575

On Wed, Sep 30, 2026 at 06:54:59PM +0200, Josua Mayer wrote:
> The driver looks up the affine DPIO and sets up one Rx/Tx queue pair for
> each online CPU, up to the number of queues. Response notifications and
> NAPI polling are handled on the DPIO object's assigned CPU. All online
> may enqueue requests.
> 
> When isolcpus=managed_irq is used to reserve CPUs for latency-sensitive
> applications, those CPUs are expected to be free of routine device
> interrupts.
> 
> The DPIO driver assigns affine CPUs only from the HK_TYPE_MANAGED_IRQ
> housekeeping mask, leaving isolated CPUs without an affine DPIO. This
> defers caam qi2 probe indefinitely once DPIO setup reaches an isolated
> CPU.
> 
> Restrict queue pairs, notifications and NAPI polling to the online CPUs
> in the HK_TYPE_MANAGED_IRQ housekeeping mask, so that isolated CPUs are
> skipped and don't defer probe. Isolated CPUs may still enqueue requests,
> with responses handled on housekeeping CPUs.


Don't you need to also change the for_each_online_cpu() from
dpaa2_dpseci_setup() to take into account only the housekeeping
managed_irq cores?


Something like:

--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -5101,7 +5101,7 @@ static int __cold dpaa2_dpseci_setup(struct fsl_mc_device *ls_dev)
        }

        i = 0;
-       for_each_online_cpu(cpu) {
+       for_each_cpu_and(cpu, cpu_online_mask, hk_mask) {
                u8 j;

                j = i % priv->num_pairs;


Ioana

