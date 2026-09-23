Return-Path: <linuxppc-dev+bounces-28033-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91A3C98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 15:11:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqgQb3N3Fz2yqw;
	Thu, 24 Sep 2026 01:11:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790176263;
	cv=pass; b=F1UjiVED8wiS6UtpbvJOH8sIm3pqIXNmzFR670DnxraSoVliLcq496Znvj+lxP7m4eMeecG8B6n0ADzVwbkiXiMG9FBElLam+EDVZB7qc7pgOdk7QdRSoIHq1SXAda6o63RH43TGfnzoAEJZSuD2jdsUH424/2a4dkcsWL7x4TSPIVROzPODvBNBnhW8EeByjDbJsJVX+EHgppW7VXfC1SyKCEWP1ye9r9C7+KGAaU5Em6rt0fMNqIXDNghlfTo8IufcWDrZETB6akDSaAAmjCG9JGfYfOU/xPOyLjCa5Vsn/5Wlh6LmtDcaZH8mixLI4o/7g61RQaK2WHpIzSRnPg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790176263; c=relaxed/relaxed;
	bh=szuavJgdiAHXIZylIJ7/GuO29imw5mxqqNiL18haC0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ta/VCEaLA16A4fBurpcwaariyEyB3OeLjfqVhlnpXcR7fDB68jMmfnYowQ8JCFTYGn/IB3SpxLxO0W8yRH6iEhlngGmVcHoVjsF9QEycmD+tS5glxAgx2Ma8sG5v7OTEEaO0lKP8qCaC8/RceW3bEASou1vjll1HL8QzK0sYVf18IOS6tJ6wp4ZDNGS1cJGWQCPVvHEaidmKg6CNAVikDDUe0PNLv94GCKL0PSbAJrFIF+d9/XwsAWc5INBCUmGZGDoqNEqevkekQOG25D5PXRYLzbruJdjtvxWI8/eqWgvke5TCBO6/jujfB5qmnKcwd6PLopW254VolRDsYwbIrQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nTrtQf5E; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nTrtQf5E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqgQZ4wL2z2yqq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 01:11:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WV+Acti90leYTR3ti5lWYOqqNovkHWImBYcrqPu8znoBwrjCVy9Nl4QzWc0fe7HPHz6L8evSMqSSM011xXbP8sUyLDIsGpx2nfoWj4LQMVNLmQKkZUpJRjbFOuCa6PesktNFbulIH8eiQt+fyaKKpK2Ui0JO8AalpCZ1+zyWO9F0D8vAZhCBep2+a+PAR1IsxUApT5yCBFwDKfhHW1baIv4NfiwBEQaxcntfFtC7WK8OiWAXzd2xbhDK30N9fsIvD9Lv+ouEN7N1f4q/48qVJuWRSh6JIsuCnlQqn+n2XUr5xir4gRduWZoHnN4mgfEUiB+hAkkRiJ4RHoQzxdK9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szuavJgdiAHXIZylIJ7/GuO29imw5mxqqNiL18haC0k=;
 b=wp1lBkYF+ZL304Ee4NeOb6P8NBr+14jasM9nlffpDg3BJN/PESSRO4dsYq2GyEqNoqIlIN7PZsUlGkmdnzvjPm00urJKLJ2+1kYJh6F5ekifckTIyQU2szMI84LtK/zgsFI13TQO2CX3GoHZ6+Kcz3npyF85YTV17vBYjkvHBLXeZuoMwXtirruyg/NmO8eN3NJka31mlBwydoA8+qwNfHEKYvXj7m1D2V69H5g6XHltqHRhCU5xUegWisZMszevZS2xZT6yILX+mm9CQ43ntnUV4ITzQuGKiQXNjUaP7nO3QcdM8FuoF+E574rLuLDnLSH9HoTv4uYrCMyYSWoUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szuavJgdiAHXIZylIJ7/GuO29imw5mxqqNiL18haC0k=;
 b=nTrtQf5EkHijqxW6Iwv0HbomyccUpyjvRBLGyegUly9eNnfMRR84g/MMlsrdeXVNfqYbXec/+gwi1shoooxrXctiApfn02ZKvQtK4bL/Z8fat+OEEMgLcJeTSS52UQyouFxUib1oq3qczyJYSJkfOxtgoOsaB0KQH6NZFqe8R/GJwmvuA+ak8JRlnBv6bnNP7oFqKgc1l943kUqEKA8X3jXp0igGD69POd3lOrms9cw4frhIUKuy9dVaXRSTTpRFTjoz2ro2MvSkZGl+lOqZ0aezgls1tpYX/+M6A18bCS3INq6CEYMx+KXg2UBpN96SNfeotik4O2f0QXLvT+ErBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB7962.eurprd04.prod.outlook.com (2603:10a6:10:1e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:10:37 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 15:10:36 +0000
Date: Wed, 23 Sep 2026 10:10:25 -0500
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
Subject: Re: [RESEND PATCH v5 5/5] ASoC: fsl_easrc: expose individual DAIs
 per conversion path
Message-ID: <arPr4ftU4XuYUzDi@SMW015318>
References: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
 <20260922033428.1690822-6-shengjiu.wang@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922033428.1690822-6-shengjiu.wang@oss.nxp.com>
X-ClientProxiedBy: CY5PR15CA0118.namprd15.prod.outlook.com
 (2603:10b6:930:68::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 9a8f7ba0-c064-4a9a-d506-08df1984d236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|23010399003|376014|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	1P4Pe0OpYdVhGmdrxWS5o4H5zhZOsvlvveUwYOnMnELALkfnx/ZCv1Pa8J562UHG171d2gk6ACr0cP1v8goj/8oZmOEMSaneevwrwqGEL4hgwYQGsCIZE9U21U+LOJn2MT78jaodcFx2h6ag5L8O0EldvfI4e6sZ58kMwRhAuyVrlfBc0VBTRo73CpmcJIswhxkLeOEu7xxNGKZLpyJyzWrDYpEicsnWyjMYQzbJzAWvnTOxu/eF4J8bWXWifXR9hiUpr1uXUCFZl4YN2iEkmioCjq4ZMk6amdD57QuzxRvt9F0+cZEnTPwlh6tHNiEjiYuG3wcxnMw5Y+SoDv1aZAaBG5+nHQy2j4MLaJR6vMAht/01BJOSh6D4VfuaKeUBeI+2dp/pyCYejFnmxgScpZ2rqOy0cJ3EDlerIaw0xN81O41tcF96Aeslup6mcshS0d+HbflnSY1Nu3Eb3Nl6JGECZ1YWnAxjJaRA7bG18TYaTLjJ9egdK2ojrVxbUj01gd8NSUE5k0fLMi7FWTqdxaidwPnoxmZasPu6hWrUCzZbmyjfTp5eCqEcokvfcQ8nVsyAiVCCBh98mq3pm4lA+AHjvrXogO8QJv7k9capWkpjQv7DEIw8EpfwX8Mrf76fBPt1WD/z2GOI0hWNPa7snirvHGdyXLYGE83JNnDSbM8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nyh3VrFdcyx4EPS4dpM+ls+yFAiYs4wrtv4t0j+F69MJSJCX0A4teqHDunRq?=
 =?us-ascii?Q?/Y0ukZLf4/d8lV+aiye54rD/s3y4np0gGbAp1dQPo4zhcuUk2XWnQx1DfPik?=
 =?us-ascii?Q?PBJ5I1SeD0SWB6Q3DBBEqB/dCsIdY0QWHb+F0KvpZpgMvYgiqUZLnu1VQcsc?=
 =?us-ascii?Q?7qMOjTlcEVIxwISoDKopDDgUilhu2De3+ZMz6xM4HSpY3qNt/f6yDQFsKj+1?=
 =?us-ascii?Q?NJOjP4OZpmE6xdSrdnWSmFWR2V6zmlOo3s7W0myyXV+s+8DemXE5Y+xKUZkl?=
 =?us-ascii?Q?oM5heWKGVXVD82z/5G9xskxYtuRoVPO+HQMF7IShiTt1KHE/eWmMuoGz5WtJ?=
 =?us-ascii?Q?jnOXKmdp0h1eB4XriZbjyuchc84ZMDGoLzs5g5CyNfm9qJ4cof97rfmnFv0H?=
 =?us-ascii?Q?pXJyDhrwwGsGJDzk+jNJaoeupefRDGKj775LYuQevMePziHuu5FcbJFyTFFU?=
 =?us-ascii?Q?7I15eenLEwVxQqZyGwgDu+l3xOwE6EXY5ViCIbkHtA7G9aT/hLsMz7FRVI02?=
 =?us-ascii?Q?16EbhGxZ8ywGIvr851uyeRiRkg/MbsjBrVnW1LdEf9acobNve4tUTtlwu8L0?=
 =?us-ascii?Q?H2K+LS1Kmf1aofJG7HD6uFGyhhZRrFjFMA+U/BDAB2nNty9wOSLYUN9yvmnb?=
 =?us-ascii?Q?hEiK0GeOhzKl8dnzjpZonV7h3FmWRjTYyaQ+P2I1tTYC6Q6mshyWI5OTAd4n?=
 =?us-ascii?Q?cHcU3/QD3+aaJZWUHFgg8K09I/ZcEiakjfA2sxyVYsD6k8RuxvN7Hqj3Rh0Q?=
 =?us-ascii?Q?BQJ1wSATtmPKhVhFu/IqU9Q57t6xQi3itz3YZ9G5CfPW6lgnDyUVDThSzwDw?=
 =?us-ascii?Q?wo4SZ2FwZ7WeSzs6EWw5Tmp+h78P8avjk1S7vJaQrZ3iffkkqeSJHrwteQ/U?=
 =?us-ascii?Q?/2jUw7WqRkofhr5U7RYV+s8Q6H8uNffi+P3KC5obkL/vz1IwkQnpsAkzQTyj?=
 =?us-ascii?Q?TTCaUeQLe0xys8pPQIWB48KNLg4gPSve3knalyQurSFvjNZU8VmbP0+QnQfY?=
 =?us-ascii?Q?J54fQFNp7qaE1VitlV6o+8NP9DR43mG1zik8dgFYsWGHQGMJjQtmjjUzpjbT?=
 =?us-ascii?Q?fYC0iEkQ/GHVH6LulAJMa3qy1EvLmkBe4FhtckfzWvjRgB8tzVB5C0gBPle2?=
 =?us-ascii?Q?Q9dJVpFqmealdIS2l5pGlSMWbEDiJwl9hqnxuxFSsF21b/cwWtnpI3CFngaD?=
 =?us-ascii?Q?FsZiFeqIhC1VBG3J7TPtB9msyBURh4Va9AsuKtFDKQug8sxt/u7vm5DkLhfo?=
 =?us-ascii?Q?dpPxtRV+c9AyREfp4KLhmMlnDDdyckiMi0CobqVaKAiEz/ZeDf8bFiTWbYPD?=
 =?us-ascii?Q?pog6PgDylBxFwqdPUIKVYSa9piZDcODhsyDmC/PnkHQqNu1VpCC8vQWP551M?=
 =?us-ascii?Q?tDgRWa9iZy82xF24XNX+N8AOQMf4qrwfRDuhlrb+XXDrdIDOuMyGyQQRlLOr?=
 =?us-ascii?Q?ABTA7koOOzZRSCe8xqBKPex4guznQlDyDnL6wo1lK8K/Gl7ZY1FwbFS249E3?=
 =?us-ascii?Q?Jnt7RLoRJyHzAxMBezJ8eS17bhEL7JDVxDRVAkQ/IbRCo2rVIhqgtIBdtTBi?=
 =?us-ascii?Q?9dlGX0REIHV20O/20Y+oI6UsmuH7R8SABawqKHsHZpt5mY70BM6f1swcy37r?=
 =?us-ascii?Q?oFuGLZ5ekyP1o6Rw1dqvEMrkbKdbO6NmMrIRQCqP21sNsYmVzSMaJrxkW/Av?=
 =?us-ascii?Q?Syc3bLdX+3+GRWtRczS22KYjvdWfFLZHi1e2OuT4JhymrJiL9h+ZGnL3Oc4j?=
 =?us-ascii?Q?CxnScsa6stK96zXjZRe5gubLnawlkV+MAwX34ZocAt/v9k1OIotl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8f7ba0-c064-4a9a-d506-08df1984d236
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:10:36.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbevDbFGivY3pOVf0L0yxRe5VYV8QLJlem9+6DwND3rTN84Dzk8XB/5sIerlSrMyYNyGFtANdqEFmYupPj3VhF7qPtGvbbNVcq4zV+ncSJuzaDrMLerGUHfvpKh5EPQm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7962

On Tue, Sep 22, 2026 at 11:34:28AM +0800, shengjiu.wang@oss.nxp.com wrote:
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
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  sound/soc/fsl/fsl_easrc.c | 112 +++++++++++++++++++++++++++++++-------
>  1 file changed, 92 insertions(+), 20 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index a6ac94055b17..cd22ea3e03bc 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -1589,27 +1589,99 @@ static const struct snd_soc_dai_ops fsl_easrc_dai_ops = {
>  	.hw_free	= fsl_easrc_hw_free,
>  };
>
> -static struct snd_soc_dai_driver fsl_easrc_dai = {
> -	.playback = {
> -		.stream_name = "ASRC-Playback",
> -		.channels_min = 1,
> -		.channels_max = 32,
> -		.rate_min = 8000,
> -		.rate_max = 768000,
> -		.rates = SNDRV_PCM_RATE_KNOT,
> -		.formats = FSL_EASRC_FORMATS,
> +static struct snd_soc_dai_driver fsl_easrc_dai[] = {
> +	{
> +		.name = "easrc-0",
> +		.playback = {
> +			.stream_name = "ASRC-Playback",
> +			.channels_min = 1,
> +			.channels_max = 32,
> +			.rate_min = 8000,
> +			.rate_max = 768000,
> +			.rates = SNDRV_PCM_RATE_KNOT,
> +			.formats = FSL_EASRC_FORMATS,
> +		},
> +		.capture = {
> +			.stream_name = "ASRC-Capture",
> +			.channels_min = 1,
> +			.channels_max = 32,
> +			.rate_min = 8000,
> +			.rate_max = 768000,
> +			.rates = SNDRV_PCM_RATE_KNOT,
> +			.formats = FSL_EASRC_FORMATS |
> +				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
> +		},
> +		.ops = &fsl_easrc_dai_ops,
>  	},
> -	.capture = {
> -		.stream_name = "ASRC-Capture",
> -		.channels_min = 1,
> -		.channels_max = 32,
> -		.rate_min = 8000,
> -		.rate_max = 768000,
> -		.rates = SNDRV_PCM_RATE_KNOT,
> -		.formats = FSL_EASRC_FORMATS |
> -			   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
> +	{
> +		.name = "easrc-1",
> +		.playback = {
> +			.stream_name = "ASRC1-Playback",
> +			.channels_min = 1,
> +			.channels_max = 32,
> +			.rate_min = 8000,
> +			.rate_max = 768000,
> +			.rates = SNDRV_PCM_RATE_KNOT,
> +			.formats = FSL_EASRC_FORMATS,
> +		},
> +		.capture = {
> +			.stream_name = "ASRC1-Capture",
> +			.channels_min = 1,
> +			.channels_max = 32,
> +			.rate_min = 8000,
> +			.rate_max = 768000,
> +			.rates = SNDRV_PCM_RATE_KNOT,
> +			.formats = FSL_EASRC_FORMATS |
> +				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
> +		},
> +		.ops = &fsl_easrc_dai_ops,
> +	},
> +	{
> +		.name = "easrc-2",
> +		.playback = {
> +			.stream_name = "ASRC2-Playback",
> +			.channels_min = 1,
> +			.channels_max = 32,
> +			.rate_min = 8000,
> +			.rate_max = 768000,
> +			.rates = SNDRV_PCM_RATE_KNOT,
> +			.formats = FSL_EASRC_FORMATS,
> +		},
> +		.capture = {
> +			.stream_name = "ASRC2-Capture",
> +			.channels_min = 1,
> +			.channels_max = 32,
> +			.rate_min = 8000,
> +			.rate_max = 768000,
> +			.rates = SNDRV_PCM_RATE_KNOT,
> +			.formats = FSL_EASRC_FORMATS |
> +				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
> +		},
> +		.ops = &fsl_easrc_dai_ops,
> +	},
> +	{
> +		.name = "easrc-3",
> +		.playback = {
> +			.stream_name = "ASRC3-Playback",
> +			.channels_min = 1,
> +			.channels_max = 32,
> +			.rate_min = 8000,
> +			.rate_max = 768000,
> +			.rates = SNDRV_PCM_RATE_KNOT,
> +			.formats = FSL_EASRC_FORMATS,
> +		},
> +		.capture = {
> +			.stream_name = "ASRC3-Capture",
> +			.channels_min = 1,
> +			.channels_max = 32,
> +			.rate_min = 8000,
> +			.rate_max = 768000,
> +			.rates = SNDRV_PCM_RATE_KNOT,
> +			.formats = FSL_EASRC_FORMATS |
> +				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
> +		},
> +		.ops = &fsl_easrc_dai_ops,
>  	},
> -	.ops = &fsl_easrc_dai_ops,
>  };
>
>  static const struct snd_soc_component_driver fsl_easrc_component = {
> @@ -2234,7 +2306,7 @@ static int fsl_easrc_probe(struct platform_device *pdev)
>  	regcache_cache_only(easrc->regmap, true);
>
>  	ret = devm_snd_soc_register_component(dev, &fsl_easrc_component,
> -					      &fsl_easrc_dai, 1);
> +					      fsl_easrc_dai, ARRAY_SIZE(fsl_easrc_dai));
>  	if (ret) {
>  		dev_err(dev, "failed to register ASoC DAI\n");
>  		goto err_pm_disable;
> --
> 2.34.1
>
>

