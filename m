Return-Path: <linuxppc-dev+bounces-28034-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28855C98304
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 15:22:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqggG1k57z2xs1;
	Thu, 24 Sep 2026 01:22:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790176922;
	cv=pass; b=VlG7bWzxKy48JIP1Trmc/Ygv68wt6iDjIfF19E1xHZ9XPeNk++OdfH3/XPSq6ss2TYY/+PuIbdFKbcQeMeETw/VL2sSQH04lPGMmg7Vv62wjnWbsht76FvPudETzwBvcSqQUJTqsG1oM6McIOVDPRlMDMuOx88s6pp3P2DK3T9/5V8UXc1JBrvUAvezJ4Yvez6qDli3uFodiE7DB/vFr/IG9mxAHmXF/M6ENaEanINDHfNExSGO/D2YUH1GAcNoWtGCPoYUyJ9X74Pk8RBUaBDYbomjwptvnNiwGd/xgxoD2Ho/tpCyNySF+hY2mATDQy3rSHqBkru47V3H2GWXuyg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790176922; c=relaxed/relaxed;
	bh=lEmgZCdf52SYlFPO/oG2g9f9D2Z2mRnYhbLQXXH03bw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YmNbW478mrR9Y5WJ/1Z2WaCldCT/QUJhD7x/FU+DnDwRsppyqzv1w9/yyWYnLwcLgiM3f3ne4cAXIBOGihDmBcvNyCwikw+2kdhy/I2JztIfEY0xEKxkvL3Sv8tFjT9HyDCba/+XDwIqSHUzdBYecIv8eTYs1uDqerPSoMmkCFWZhybMr8K3hZjPlWTq8oXYrjmhOjwsnPivW5eGILOQlBIejJun62xn/RJb90jtgLvT/gNC3JGLcVJlQebTDJJcT/nhN9XQZbWGbOwjJ0rKVs8e7KQyWwlMXNFJA+oIkxTBIIC9tLKz/6bP/zW2WF+GkNamJl/qkPCWMkCEvMTIHA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ekM6ZswI; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=daniel.baluta@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ekM6ZswI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=daniel.baluta@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqggF1WXjz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 01:22:00 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltdAPtbH/sqguCRUMM0p+HLcxS3kpvJcxIAod2RRGatMonXOeJFz7+MfN/f+muf9TtkD/nGRWAwKGptefg4/CY5pRHfKRfRHspscbqwDDLUw6bLIJhmUCbtciiwOLfudQAHo6YcVk4vkO0Ij6muSKs1m8CnbGV+vwLyFKojxWF3xQLw43Gj0lX9MXasKwYNM25QHdZsCVSu0u8Jch0+LgmeJYe1tbBg2uo0Z8np7Ca4L+ARsJNTdW2KnKhAMZMsj20mqYXXU06uucdBecrmMVahtT8HntiuO95FVrF4gU+UlLR9B1i97jYjeoP2N2f/eSonC8gAKXvJAt3DKyI4fBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEmgZCdf52SYlFPO/oG2g9f9D2Z2mRnYhbLQXXH03bw=;
 b=MDIPlhUiJZrrPngHWy8VSCGXeatHLP5Oam9lXaIZ1Ha1F861h6v+r3Zwped4fF2khLLOBlFU4Ui4Vwvq248xZe3AibaDKV8LGlQ6PN8m0f+PmlUJ5/Q4+2CFxI4LIMNO+NpRwoiJIrFo0Q1+Qq65iDr2dJ565QI5WlCw/NR50sQDkPlBhZ7bd+Cv5GgGUxy71G1wdtYIEFEebjD7nQLHbMxcBkcKdZ816WdPX2zw79eCjomO+9ryDERi2uaxLF/a+YNKypcyKssOJrWedSdYSm+D7llv1lg9SkUvhgxMv8IQAq08WQtG0mqX8/sQWFSVu6f36ely7UpPrEEhs8eZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEmgZCdf52SYlFPO/oG2g9f9D2Z2mRnYhbLQXXH03bw=;
 b=ekM6ZswIAm5jOgA/G2O0yOwmlWI3riUsd/D34vXj09a3co/xAYCW3mks+FwyMsxYL/BhfsFAuSB1t0BDMtsKB1ZUY+jcmSrom3IoafxVlFoZFmuGarxxlmjcfb1DZyH6r7uvV1sCaCAPE9iAaCrh4e9UQddz2xOfXzusld9tnu8N8GrOCV7hTTCcnMK2lK5LnNlSZX79Lo33IGejCwMqt2bI3YWcAw1kFWdwWhh7krYQ8bgjWSWdK6nfPPmyWTIJneDHx9x3QJVdkauM0ApPRqz1skB+kVru2U/vu0eq7rb5t1BekbPtpUAcok1TvwmNZvpe2pjBuNA/vB0gwf8gPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by AMBPR04MB566113.eurprd04.prod.outlook.com (2603:10a6:20b:7ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 15:21:35 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 15:21:35 +0000
Message-ID: <76bf0509-14d5-4e8e-bc50-1e86532d2b38@oss.nxp.com>
Date: Wed, 23 Sep 2026 18:25:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v5 5/5] ASoC: fsl_easrc: expose individual DAIs per
 conversion path
To: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 shawnguo@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
 perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
References: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
 <20260922033428.1690822-6-shengjiu.wang@oss.nxp.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20260922033428.1690822-6-shengjiu.wang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
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
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|AMBPR04MB566113:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d30e58-69c9-4b40-c911-08df19865af6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|19092799006|366016|1800799024|921020|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Kw4HCzJfpwwnwqA/+W6j2h4TQoJ3ni7/SuEC85e6qb7En7sCA4bTTjUtPXvoa9eTSNMhjSeQNtRs2YCXLedyQpnX6R49pWj5+TAh2V3E6cVeXixMQpV8PzFL/JZ6bLwKxBbMORoIKhw81eeMHPGbZzyFLdtWbPOXhnYAT9RMBo7JOM5FUoahIZSEKGzfNgAFeoUF8fnljlw5N84k84aGZsgIUZvrS4N3kqU/5Qe2hxXYlg68Dil8HLp0Wc4Ryg1HP/bCE2LoNBxGX8pceJ0QoptGDZH+9qkGKntjzXVB1GtWEzaNcc8+VnkwAi9Nbdrs0q1Rg1mHMTaNTGgtaPC2SGtz/kMG7nPnx2dtqhWCIOW7fIL4MsUIaOU77Oo+J3PuRHhvATPH5KNMa02gq477zKIfEKvb450f9mYW8c9IKJTBvEJ00kwszSiQiG8cLt87pBaESEWTsoH4LHfbcu2fdbHrDy76elNkcBWw3p9TqkVVrZQ9T/u8+0NO3tIWPyC8mYBOt1tJJRYd4TPwoxHhAtYqY7cpBY5GYgB7R2uxjjFYD4BNkd0F8vcw1j22aTjebi6VvjssrLdJJYbM+OAix+cZK26CPyXZmBHMwu9hNF4GMwHJiYSWFBiXDKOup9M0t4+RLV56K/20yRZNFxPiCHnY/UxeCZemeSYnNDtTN+Ssyp8uQjpdmxMt2m+DLnP0/b1Yetlj6rOJE1yxtwvApg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(19092799006)(366016)(1800799024)(921020)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHRWVHZYdjl3clFNMHhmcnFvOHNmK09Rbk9CMFd5SXZ5ZjdLYXluRC9kN2o2?=
 =?utf-8?B?TVBHRHQrWVY0bGJWTzNiNC9QaFE2TmpmS0dWcGNMemhxUU40TEpaWXFWOU9n?=
 =?utf-8?B?cnMvZzBEUGxRSk5ldU91ckVoUFJHeDVKVHhZVE1PUlROZ3RRN1lLVWdxeVZj?=
 =?utf-8?B?ZU1qeVBTVXNWN1hrYnp6TzBpZE1xUjZtMmtPZGNPT2IveE94N3d6VGJxVnpt?=
 =?utf-8?B?N25DZXpIbnRpQ1JmNExVakVKMTBJTUJjYlZEb2Vyc1BIdE5JalMybFh1Yy9B?=
 =?utf-8?B?dnhLRi8zd3FncTZjWVJEV1Y1dTlEdVMwZElDcW4yd2FOeHc0OU4rTlZ4UXJz?=
 =?utf-8?B?bi91ZkF4dXlMbzN4YzdiVGR3S3djcHZhdDdlLzY2ZnVGQ1J0TGpydXIvNWZI?=
 =?utf-8?B?T2lZSWgrQlBvLzA1akpHTWVQNGZBQUdaMVlYYVZEL0IrYzZFSnhRajg1ZTZK?=
 =?utf-8?B?N3A1MjR2d0VZK1FXa2l5M2ExMVl2MzFkYmhoVTlNb3paaGtFeUZuUUpnT1RF?=
 =?utf-8?B?czdnL1pZaGZycWdGZUVBWkpLN1l3cnpJM3pTOTRkRXJzRGZrdlF5aVhyRHhy?=
 =?utf-8?B?Nzc2enRkVDVaQ0ppakVYWWVidTNmQXhka2RPOFg2RkdsTEF4VUlnNVNiWWo4?=
 =?utf-8?B?WGc2dUh2WnBvR25zOGFKa1ltbUlhdjlQQTBKVVlsSFVTU2FSMXJ2TXNyQmF6?=
 =?utf-8?B?MGNkZG1UUitPcnN5WkFjaWs5dkFFMWNodVF5NWowVG8vM0RXdXRseGovZzlv?=
 =?utf-8?B?ejdKZEs0WXBQMzBoUnMxZlgrbnFLM0N5MDZ0QXJuVjkyK2JUdVZjSVZCMTAz?=
 =?utf-8?B?aVd5UGszd2ZWU3NaNC9ZT0pkZXhOOVJwWC9wNGhKcWRFNjFtZlZIV0dnZTA4?=
 =?utf-8?B?OXp1MS9yK1JHaUdmVmlHZXdPZWRES1h1NmRUUERFRjN2ak9MVktIRHBVNTdw?=
 =?utf-8?B?QWhzMnJLRFQ3N3pFR3dLL3FJcTB5dDduSVFrY0lOOURIWnRPNGRhUzZCODhZ?=
 =?utf-8?B?OU5Sdkt1MHQ3dUszSDM5YXlWV09NTUtELytVWkh0QkYydzhNbGdjRHhxVCtw?=
 =?utf-8?B?QVN4OGdkVWNocXhLRXJNTitjdXAwTUdJNW83SnZoUlVxRDlvaTJka3VhOVZN?=
 =?utf-8?B?ZzFqbmRPQSt4VFA2L1hRZWZNcVozRGwyTytIMkZQSGoxbktPN25VbmJaV2xt?=
 =?utf-8?B?SE1IT0cvMVZHQlk3dVJYUDh4OENhaE5ldFhCVVFZVSt2NjdUNDlVSGR3eHVD?=
 =?utf-8?B?cFBzUzNuN04rL3lpdEdhbEVmNnBZM0lSUDdiQnJzWWduQmxKdnROTGF3YnUy?=
 =?utf-8?B?cmxnVGlOTE5lNXo4WUg0b01uRUZxc0Y5ZUs0UlNiU3FjUktPT3lQNEJkT1JN?=
 =?utf-8?B?bEFuUzRBUWcvbXAycXZ5TWsxWTFNMXgwckpBOGtZYlZuTTdsYWFLRFNSQW1V?=
 =?utf-8?B?bXprODhOeUxRbDE2aGhYNkZqSk9veERlY0t1ZURXbEZ5ZXNENS9RVVBJNGFC?=
 =?utf-8?B?TVNoRGhSVW9kdzFoTVlQL0g1WlRleEE5L3RHNTRWSy9sRXFKOVRJUVU1NVRS?=
 =?utf-8?B?ZUNOWVpPTzNWZDBQb0hoSjYwM1ZKRitXMVRuN3FRUVBHZWZ2aXVia01sNHhF?=
 =?utf-8?B?M2NTck14MUdTTlp2YzkxWkhMdWVxSWJBZ3U0MEtwWE42bU51L0pkZlpGNVN3?=
 =?utf-8?B?RE43T1lVa1lxb0FoR25UZEJoS2hRaUc3c2MvY3VIUFJEdFJWenQxR1BqWk5D?=
 =?utf-8?B?OXcyYVpUYTRYU1Bmcno3VHFMSjFrRWw5R2YvL0Z5VVdkREJ0eXNYcEZwaVZE?=
 =?utf-8?B?Sk1YRWttWi85bzZwUmdPSFNaSi8waXBMS0NQeHFpYU9aTzRsL2dlK2VtMXdY?=
 =?utf-8?B?Y2d3TlRsdWZkc3J2UXd2M2pTN08yOXhhSWlBTW9uUWo4UHY3NXduUVNTNUJG?=
 =?utf-8?B?RUZTeGUvbUs2dVZLZVRjT01GL25KU1A2MG02WE51QTArSjhVVW9HTVdnQ2RC?=
 =?utf-8?B?SWpCMHYxQVYvVmtmNTh6UTFmRFdrZzJlZk1YMkRYdm51R1U5elc4ZUwyTmhX?=
 =?utf-8?B?cFFMRTR0dlEzT1g2UHV4bnRxZHlxWmhIZUtkMTNxRzFoOVd4RUV4eVZURGJr?=
 =?utf-8?B?djdkVVdOb2l0L2QvVW54WklDVFVuSThyc2l6VWFiVXo0TzYzSnlNTU5DMDJo?=
 =?utf-8?B?ZmlOUTY4QUc1Z3pwOWNONmpXYVFRNEVNWlhCMG03WitydnFSbWZNSGNYM2xN?=
 =?utf-8?B?MTZycnlra3lLRzlncE5YcWFJY2RPTUxsdlV6eGNEQjNLS01QUFpERGtxNThh?=
 =?utf-8?B?WUlaUlFIeUNUU3I0bFdUeldpT1dZYTZwTXFSWTNVTEVjb01pM2x1QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d30e58-69c9-4b40-c911-08df19865af6
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:21:35.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mg9Dj3izloCCF3AckS+MkE1VCJ8O8heP+YZStpQ06eowN84jxZxR/fqH9sVwGrasy/yh+gshVPCqwId2Q8IK7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB566113

On 9/22/26 06:34, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> The i.MX EASRC hardware supports four independent conversion contexts
> (A, B, C, D). The driver previously registered a single DAI with generic
> stream names "ASRC-Playback" and "ASRC-Capture", which prevents
> multiple independent conversion paths from being used simultaneously.
> 
> Replace the single fsl_easrc_dai instance with an array of four DAI
> drivers to allow up to four independent conversion paths to be active
> at the same time:
> 
>   easrc-0 -- ASRC-Playback / ASRC-Capture (backward compatible)
>   easrc-1 -- ASRC1-Playback / ASRC1-Capture
>   easrc-2 -- ASRC2-Playback / ASRC2-Capture
>   easrc-3 -- ASRC3-Playback / ASRC3-Capture
> 
> easrc-0 retains the original generic stream names to preserve backward
> compatibility with existing machine drivers and board configurations.
> Each DAI retains the same channel, rate and format capabilities as the
> original, including IEC958 subframe support on the capture side. Update
> the devm_snd_soc_register_component() call to register all four DAIs.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>



