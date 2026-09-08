Return-Path: <linuxppc-dev+bounces-26760-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A74DC79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 08:17:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfGy05RlYz2xqp;
	Tue, 08 Sep 2026 18:17:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788855432;
	cv=pass; b=onnsEW8SQIta/c5tlywwt2xPURvqu9ODOcd2UYIQjM5pzF5jJovOAV0wGBMFQBic2KjNlRucGLoIVtlYqt9WN0YHA+VHTXayC/R1hAKgrUztZmB7o2i6CTdaav9FgOCizZaoUq1PzFAgZBIGyJ4+NIcMWVtQa3k5zxidINXCiwv4Dh8nRYY2cr3/57yVhFSLq/RFZFKnPeRG4+2vvHwLLcbOUtndTzgvtDbxjT2WKDvVkgjMDwwTu3eiA1+SoRhGwZxiJoab8IpQIH/HPFPPZoWHmiNmKou2/vdGataqZVgDGQaoAb47yNLRdXpnDioXwMYp6cfja8D3UD4YtWb1Ig==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788855432; c=relaxed/relaxed;
	bh=huVaasvJgksaeis3D7Ko8VTikwI7/CoEtSa9ZgJUozs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RCCLAP+AUa0jPruIatgCBBnttBcot/Ortd4Qd4MMCNfQ5EQMlmy6NXdnmk2SonFeKQylBVVwQml86zx/udDro1Brj4oqDx9jRHe7/vQ7fqzvDoxawhkc09fP6t9r7kQBzrwQMm7OiryoSiE2ggIV2XLAf/m+tATvepNPm1kRESdqnHQ74QH0gLjdZRMAkdOAli6nNY/bgYExT+uhQbpwDCRj5kBM2qcQFZyS6QcUJf+SYxrDUQuq8U/IYZBw3cNK1yrEEiokgaxIZY9acAzGKpZZJyANm2+s40KpG152qZQT6jtj1LVJuNmUjd0KS0MTC4dVwMImmYeTyJbh1T06Jw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=myCHf3TQ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=myCHf3TQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfGxz42gKz2xlJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 18:17:11 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGcRrY/hTWd7BPzxp4AHM9ajMo0sxpqOzgczZA08ETcUc0saZMJaXS9ocW9BbvL3PK0BvOtX/mIJzFCbFTbqJKgnCfyZSXl0AaG1dtkdrY7ylk2QEdOaJkbjvbxQNpyphklEq6HWDlWv3Z9CYp71PZCwNAtNfxGGVN48tbb0I8qQPHtWYDb8CdFGzLwoGdL0i/zE2CvyY3dWfCwZBOQ1DejtIRlB2hUyq/exBRdm+K+g0GBD2iWu5p07bZTtE3+dDST32lj+Vfd1t1LLFfoHgiZXfLMSJdRORgRjyNf2kAJ5SfKL/6SsnaZeFrXG+3zD1aIBntztoUNIAuM4XWggKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huVaasvJgksaeis3D7Ko8VTikwI7/CoEtSa9ZgJUozs=;
 b=YVsjuQsM0gkM8A+t6MqdXDCykMyRom81vsSu2IpC7GjW+UlsZz5t3Vp748/aaGCI3+fL+oaZWHK+exe3OzGDAQGEEilXrEnNe36Z4C7wsoR5Nr7oh9JNg3UMPGRZ0pEEwWTRlvGH/IIR4sCYYK7f6CZ3O9JY+m3Mf9ilFj56bg6eTi5RHl3F8/yWEOs4ZxpgPetMex4bXbAnq4UwtQSxwe4OADU5frY7pyVQAZVAJf7ZmmTDPDZRIFtXnWIJafz1ZMSGDz8d4nw4nXzaDL0yVUtTVlb8JCTgdFwBy2UskJnwo0lBZ7myHpcSUwOAxd7oGou8oY+1u0JJ96UFtGf0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huVaasvJgksaeis3D7Ko8VTikwI7/CoEtSa9ZgJUozs=;
 b=myCHf3TQOc7iuhfd1Hs315Z7AV9aJ0cD34uM0Gvv8sSrcRUfz8CYuOOzNenPQ1eobJMcHAuWYVfQw1XjaP22mbPGri5eulZvgMmUIz3NEbQlZ9U/Z34pM90ysI8BczGSDC9qmxQc+UwWeBdwoB4C5rLcyp5hUPNKILuudscJBYeMmG1QP0fs1M/XEwI4/U+uensrZcfEbAG5D8pRti4b9zkmRHMQZZUn83PiaM6u3DhvEhEmhvDssiBfxZPWTXD+NcUEv998937sPkRao7f1QRDCSGiolLYJVkQMcgo1/PqPYxSX11bqTYssTrwNFen+mX33A8rYXaXnTAAnSw2HLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by VI0PR04MB754002.eurprd04.prod.outlook.com (2603:10a6:800:364::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 08:16:45 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 08:16:45 +0000
From: shengjiu.wang@oss.nxp.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shawnguo@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH v5 0/5] ASoC: fsl_asrc/fsl_easrc: expose per-pair/context DAIs and fix DMA race
Date: Tue,  8 Sep 2026 16:21:35 +0800
Message-Id: <20260908082140.1316872-1-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0262.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::18) To PAXPR04MB9351.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::17)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|VI0PR04MB754002:EE_
X-MS-Office365-Filtering-Correlation-Id: 292a86dd-cc41-4429-143a-08df0d81853d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	m7WwR1uFR/wxCeGcCYZJGu6US4DzP+mZKPswYe2eXAwlNzeAnCMEq+KOCCVyelkY43BeQcZ/iOhczbK6KCCYFs7Z5Ixh8x0b0m3tmrJcUkwaJK9pXKII4nO5o40rclMH3h9Nmq//GquLzQSnOErHPipkzpmEcESgUCdNgKXT6eLNjfmrb7o05uueHzdkUm47MDpCwV9RMbeQCyhLbcMC9WH05RBXukx+79mT+g7lhdgzDqiUPYaPfEPT2RV34o1ZiW9G38Xi49qGJDL3u2F9+reQ1f/GhGJ8kYxkp+HgCo1Eqgb3Xxj3vIce4R7yk1tcTmt4MfIg98XuR1R/CX4v1uTx+eKwEuN0V85PHhuqaazVi1GetQ2x3XkfwRgNUfyeYAuZkD9VwVOynxZb0glwUxCmZCeMsXSE0r1tUb5Fm0uFpl3/pFDEz8i3Ttl2Abevt1xJJWWrWPrD5vB600uvbuXri6BP5BiSm0EeHRAjbX5hQv653E++Oo7yzLIeMnRczucZ11T+ophtFB2kzjxVBKlyrrOMyuU1aNQPwegI7FQg/xj3Xf5BBUrg/Rg2/pCVwNEMgIJKfXz0K2gXmvq1JSDA8aS605CKan7hdw94rOqovWVl/LZ0BBbi79VK6D9v5j2DNx2xT1h1S0viwiRkYUrdmvIdkdLyjNXjfx6Rzowna1TtjDPGb//dK3uGAxeYVU4yy6NveOjUAjNAm2CY8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+yzl/wyYwFSTdXCntpoVHRmow9IAF6kgC3IYndV3wZalRmt8qW79R/XTDXyW?=
 =?us-ascii?Q?GoUqLsjkOAfoLVy2pJRnOx+ywJ7U5ZHheWpMJMVpTlf5sAK756B1F8VqYJ2l?=
 =?us-ascii?Q?HSOThV37hw1Om1d4MiWxglRXl5SQZE2ITCfXw9LIx1oOe91z4nMU6YbGtxnW?=
 =?us-ascii?Q?iX3vVE5RfJc5mx5PPneBgzAuzi3wV7M/kHRx3eEZD1Q9Ao2qc8tksMts0NvZ?=
 =?us-ascii?Q?opNUcEhN5QmTVQSpHHnHOfd3hJ908CD+yA4mv6/jkrG5rsXjESnKukyuMWvz?=
 =?us-ascii?Q?vQRSJ/0na4YIQquQA9PQ85dlAR5C8E7s5SoqQi6DAvYU4jav971yrSyQvW2S?=
 =?us-ascii?Q?+U/DpAeX8GENe+Lv5eLDcOWQKyZj5JfFXFtryAstVpIgQh//rRzZ//Cm+W5y?=
 =?us-ascii?Q?UnIgER6Mqk19QqQkvm57bgtrZ/3Jt9z+2zJqHe+5GG6zmIkERVVA8ESFSaZZ?=
 =?us-ascii?Q?6E3t7zcMOZKYGlGYK4pY5tpR4K6iZFFpXu8vfqa4mZdWdTdyGRSGuFe/c6t2?=
 =?us-ascii?Q?5fSxyEcXc/9ySyY8drp32eZQLJG7jhobcwi5tpdVHltvIkJY3pa/d89EHN7F?=
 =?us-ascii?Q?8n0kpCwovU9ODvltQJhq5uFlmatdxKrm1fd8SPSK4qQkZkdTBtn/0Qnc5ukW?=
 =?us-ascii?Q?DelhTEhIyYsADgETtc9DF9XZ8CRMU8STv4X0M4JTVQZs/vsc8tCA5qGb6BVi?=
 =?us-ascii?Q?C5mK0n1+TyagKYJ8y/YiDYYICp9O3NQ3VN9H8bbm/nx/q7YivyDLqsx25o/a?=
 =?us-ascii?Q?JjXnoY+X1oszk48IqM6jWzzKsvo6t2gQD0FjIhkb7YjH2T+//2zVP/1oje3Y?=
 =?us-ascii?Q?9d1FwwyDDA0JF8CLjZvcNcST9KUezsQsTOJl3y6wFPEO3hsBoK/7kCgR4omL?=
 =?us-ascii?Q?7SFX1XluGJmqZhpDRaxif2xr6AM1RWBTNAHMZiGuPkY8/4MViHhfTVci+PAF?=
 =?us-ascii?Q?Ox7vEIK9P4IVCu+mY0GJaiy55dc9+9cE1MhK4IFhw+fdV4AxUjg04xKr0Ccl?=
 =?us-ascii?Q?4N34OqqFrC1ITX7qRXZ5JwQqJnXIF8LCJQjyRS/8vzaPOpegL0NmIPml7nJo?=
 =?us-ascii?Q?2lWVo68fLC/9+nSEGHpqe5h+FmIMeGLW6H4RTV4eyu72t1Y3kxSfKqL43EWR?=
 =?us-ascii?Q?hFujSR1/rFB0dfefXJG2XKKqKf9Z9rAPWA2XoqltGOwTorg58lZ9k/WHT5FW?=
 =?us-ascii?Q?1kQgtjoGlvkFzZBJQ93Y4gPhxZfyUwM79xBgXvKvvA9lvu4UbsjWZsyJtj5j?=
 =?us-ascii?Q?NqgYVgInQqiQBfOg5GKIToZyx0FDI4YKkhyJpzv8jR58XecwppFoSKFcVn8Y?=
 =?us-ascii?Q?tNlH3RntKTGY5c9+2vRpldiprx8V1cFLZvw9/wXEKG6cdKhPvSRicPfePPl8?=
 =?us-ascii?Q?gWTFNZNQnG+2rSjyfLcXPrnjHPU7a2iG6fxdCd7jGfsZkox8WLE0xWOv9T8o?=
 =?us-ascii?Q?3kBW55inhC6SOP+8PRQeyfejTvZUEZhOCZjGhyg9E3g32L3OGEcyW+mCpoLp?=
 =?us-ascii?Q?BwnSej3OYYDbsEB4hu8PqF2iOiv56zgeULRIQSlTW+pIT/VoapvxaJux4PZl?=
 =?us-ascii?Q?ziX+qwzkUGfSuNHoHrw67yo1TxVysEV2xwb3tjb0Ym9a2UNgUq3WCty4pER3?=
 =?us-ascii?Q?zf136VhTH+lTNLdhZSlLn0stRbih9zOKd/Dkjqky8TfpMH96Up81eAvgr1ny?=
 =?us-ascii?Q?n+j99wYE7m/46KReGRBRcy116qjMkMpI/zHLSNFIiDEA8k6rWkkceXVNvkEK?=
 =?us-ascii?Q?p+qKXM4vmBsMo22ZfY7Y0LrrvEhZZqxg5RZZHqCxM8Zlnz9dNNtt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292a86dd-cc41-4429-143a-08df0d81853d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 08:16:45.2379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJVgp88yHa+46Nw9tfwk43RAcSWg9L0EiBcZil6jdoypnycT5V8Gx/d/noTg9c4Guy79kbxWCQHMdlFwtB7rWFwMvYAv6l46mAGGpHGgCvmQeIlgyI3E84GwoIU34u5D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB754002

From: Shengjiu Wang <shengjiu.wang@nxp.com>

This series extends the i.MX ASRC and EASRC drivers to expose one DAI
per hardware conversion pair/context, allowing multiple independent
conversion paths to be active simultaneously.

Patches 1-2 update the DT bindings to add a ports container so each
conversion path can be wired independently in the audio graph.  The old
single port property is kept but marked deprecated.
	
Patch 3 moves dma_params into struct fsl_asrc_pair so each pair owns its
own copy, and registers it with the cpu DAI using per-direction setters in
fsl_asrc_dma_startup().  This removes the per-DAI probe callbacks from
fsl_asrc.c and fsl_easrc.c, which are no longer needed.

Patches 4-5 expose the individual DAIs: fsl_asrc registers three DAIs
(asrc-0/1/2) and fsl_easrc registers four (easrc-0/1/2/3).  The first
DAI in each driver retains the original generic stream names for
backward compatibility with existing machine drivers.

Changes since v4:
- update commit message of Patch 1/5 to add all variants
- add Frank's review tag in Patch 3/5
- add Krzysztof's review tag in Patch 2/5

Changes since v3:
- Update commit message of Patch 1/5 to remove reduntant sentence.
- add Frank's review tag in Patch 2/5

Changes since v2:
- add ports example to original example case in yaml file as port is
  deprecated
- remove the label in example.

Changes since v1:
- Patch 3 is new: moves dma_params into struct fsl_asrc_pair (one per pair)
- Per-direction snd_soc_dai_dma_data_set_playback/capture used instead
  of snd_soc_dai_init_dma_data to avoid clearing the other direction
- dma_params_tx/rx removed from struct fsl_asrc; single dma_params per
  pair suffices because each pair is unidirectional
- per-DAI probe callbacks removed (startup now sets dma_data)
- Cover letter and commit messages updated to reflect the above
- DAI names changed: paira/pairb/pairc -> asrc-0/asrc-1/asrc-2,
  ctxa/ctxb/ctxc/ctxd -> easrc-0/easrc-1/easrc-2/easrc-3; use index-based
  naming consistent with port@N in the DT binding
- Stream names changed: ASRCB/ASRCC/ASRCD -> ASRC1/ASRC2/ASRC3; align with
  the index-based DAI names above
- Binding port descriptions updated: pair A/B/C -> conversion path 0/1/2;
  hardware-agnostic wording to match port@N numbering

Shengjiu Wang (5):
  ASoC: dt-bindings: fsl,imx-asrc: update port binding to support
    multiple paths
  ASoC: dt-bindings: fsl,easrc: add ports binding for multiple
    conversion paths
  ASoC: fsl_asrc/fsl_easrc: move DMA params into pair/context struct
  ASoC: fsl_asrc: expose individual DAIs per conversion path
  ASoC: fsl_easrc: expose individual DAIs per conversion path

 .../devicetree/bindings/sound/fsl,easrc.yaml  |  45 +++++++
 .../bindings/sound/fsl,imx-asrc.yaml          |  45 ++++++-
 sound/soc/fsl/fsl_asrc.c                      | 100 +++++++++-----
 sound/soc/fsl/fsl_asrc_common.h               |   7 +-
 sound/soc/fsl/fsl_asrc_dma.c                  |  14 ++
 sound/soc/fsl/fsl_easrc.c                     | 123 +++++++++++++-----
 6 files changed, 263 insertions(+), 71 deletions(-)

-- 
2.34.1


