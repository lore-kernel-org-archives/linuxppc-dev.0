Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346D606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=J10K4ifF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPLrF2MStz2yCr;
	Wed, 11 Nov 2026 09:27:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794312497;
	cv=pass; b=bdpRcpNCHDiJgKkGpPlRM8Kzog5xNJBU8jJaHpAbJp5XHfHx3wmGT7vHpdw8onWSfQfWGf3mzke/67N/Jy7Hx5VUidrXSPmZZsaga8o7D+bTkbZm0ThRv3OPoE3eMvTzr+UEd8g1bpMxu2Assy2cDikAf3g/cJ0KvQWqS9O5lN4nQ7fSKXKcU7N2ZrJLm56L70kiSAJUk2F0ip9rEPVlmh03YcPvivLVqcm6pgKFCI3kqSucTOa/b1RXBEPAARxkYqh1euU1a9YnvdA4T/8MZe3I5YcXsAw5huzW8lKkTypJ0D1+5e2GtPeT893/e2f3vKC8lNozv+at2XMPDZtAjw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794312497; c=relaxed/relaxed;
	bh=H0BnVVUB2UQVgPq4nyQKswVBjrN1NxYLO3kMYGXW+wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/eBh072zclEW+H6/uw7xc5GjBJ12JVZStf86veJPXmd79I5Y+YWb3NRQStGCsPcWbBLmbVxzI7VHti1gbi0rQWLD6Bi+WaMlyUv+cNymf4l+OJTWm90XeIkXzckt4BHwf7bhT1TlkbhwrKZ49gkD5YgHw+lgrSJ9ycC6mYc5CStzfQVWIrKTl/dzJV8kafK5+d6bqrnVMt6fw88s2o6feia9HYRKZXGH3wCiXSSMqw4C9Flklj3OfCOZJp2ejZCrgyFl4+GIILp9phi6bdXDIshvQgpYUu0zsmvf/y8JIE/ruQD+fnO/Tc9flk+r+eIdNSXj5KTZOFaM1y5ivGIdw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=J10K4ifF; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=stefan.ghetu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=J10K4ifF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=stefan.ghetu@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP55X5b7rz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 23:08:16 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHprMaKoN7S5lr5UdY7xDSs7XG3dwYY5oaZsTLSW34Lvw8CxG4fukHEyqJVCIjFk34xqjrDoEl4482355tguJRmlsmYdcVhrCGaPAofr/vVoILfMNYd+3u8K4vJfbN3iF5mbu9S3P4S4aSb35p6ekuSPgRM2zypSD7Dp3Br7Urg45oM8c++9vu/lD+e0jIfSsYLPxb3+wZczYYr2K70IkHr3VmMO+St6FqMSEC06l+oRx0Tbo4q7WlIHhl19rt7mWse55n7fg6StlDNXwsUDx03/NiuKtzLdFg82RnzebAZ6DjfxkYopwxCWHGdqTVuqCGPZs+rcygKsDKFQEC2SzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0BnVVUB2UQVgPq4nyQKswVBjrN1NxYLO3kMYGXW+wQ=;
 b=wC2kxSRHRUEmsWUVfN0xNoWmmvfNCHXgPFV8ALcu0kJVQ5Ewy/QBPxIkJedqeexD/3VVLSyczNr+FtG9ZJVZS4LeN9yVE/uhDZybapNYsMG7+T5tV47erULQ7LaKgCdPRCxSy0vL6xdVhhkCguRTwey6KUtl+28QPhMUGJhFxUxVuuelye84PDfWZV/1FV+Lvl+tQKH6BepiXxYf9/fwO28WVXGOPhO1IL7aNbpNqbW3TF5Cl5lgqyznvNSezBpjZgRoBEgzmZbYi4Z3/0Y+OrQyuR+CskdDI/OOTv9w5JGWGjyXFIUqkv8laaCI2zQrglREJ0X1ZTU3bpzkbeaaBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0BnVVUB2UQVgPq4nyQKswVBjrN1NxYLO3kMYGXW+wQ=;
 b=J10K4ifFBc9Vw0cldHPrrMdcOzxn4H5htvdB2ZF4FB7zU/ERJKNg34DZLkcs5fjokz0wjQNNCk6MEsflr1tJrFd7pi7J+s8QmP649hGA2ZNlwZLhr3jFksGQ1CVwF2WgBcMSaqGDhCO9HCWaSumQa/qmsxHig3K5v87ubLMHz6/f8AKhCNbjIGwg5chTnPSUKhoEi1LryUMp3letO1oRd4H/mw77i2azOnroyAmWE9hez8CsjnhZfC6hlMNwgTgMkoBO2isIm3UY51bhBBb1INtn8rkEiQFhbdf6NSlwu3mKNhnaNlLDMxVVfkY6tT3KH7ZE1TBh14/aCiIxwEnXNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com (2603:10a6:20b:23::20)
 by PA6PR04MB11832.eurprd04.prod.outlook.com (2603:10a6:102:520::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 12:07:59 +0000
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0]) by AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 12:07:59 +0000
From: Stefan Ghetu <stefan.ghetu@nxp.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org
Cc: daniel.baluta@nxp.com,
	Stefan Ghetu <stefan.ghetu@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ASoC: fsl_asrc: fix pair ownership on repeated or failed
Date: Tue, 10 Nov 2026 14:07:40 +0200
Message-Id: <20261110120743.6301-3-stefan.ghetu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110120743.6301-1-stefan.ghetu@nxp.com>
References: <20261110120743.6301-1-stefan.ghetu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To AM6PR04MB4472.eurprd04.prod.outlook.com
 (2603:10a6:20b:23::20)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4472:EE_|PA6PR04MB11832:EE_
X-MS-Office365-Filtering-Correlation-Id: be9db546-2ca3-494d-e4d7-08df3f23435c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|23010399003|56012099006|5023799004|11063799006|22082099003|18002099003|10067099003|261009223027099003|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	vsKw4NxKooHDWcNIPi/LPFQpr69e2BBqx+5qDw1ZUV8wU6Vu2eYrHQPRbJnfTdf0m1MQBELaRtkOZmdbF2/eqT7P4WWfwRJd7/nChN4XjyrsBbHUaK3pg47qZo7EmGioLs1remOBx/6vZLHM/+gTDCkrGrpmeTbvEELGyWIkwDVE0OWUQ6LYIEYl1NDzoPB/GVDnRCY5muYLaChafeXyEI0lGr6v52qUj9uaUctkA7KomeuXKBO/m4TSAR/wE6LxZXi95MR2AfAQwOaICuZFDZpLTb+4i/wh6SgXiJ5HI+1xw/Xubxhhvi6cGa+10RFTUTRXr8gaAlzvdJi7b6hxT8KD5bgFWMkPHuU1qocsl60id9DwOjr6lcpSUPlwSL6mkkpMXRK/8Bl5NrD+Ir6sOHVRBV21ZgkL7up9S/DVdKpjgmVDX8aHNsZWfyJ4y2A6VgSuw29Vl/Jl+N4yOGWs4DjT3k17bRyfKIzDZncgecsTu29O6p/qfwsK7wzGibcK+PGxiv5yUZAE7/z0twFyAHhcwaDKGqnDpL7jdKE2otv63nuu81LmhMjjVBZqYUpQ3G49UAqYrh467/YvbfO6jJzC4efP13fBAkgYzJ09eqED2oELXBD/W32LIU6lid4n1uEUgDzmSW31btDLN2nnWBpd/4XnddQe2J7oMB0yl90=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4472.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(23010399003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(10067099003)(261009223027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/p9sPN8blh13pAiltMf5C/keb8TMxZyotIKpHoM+YuQTs2ijV93Tb4MJnYg6?=
 =?us-ascii?Q?RGmzKnWYHRF2NOWFcH9+quBBGTNJc441tca3VPu1xSVwsP97erxa6F/aLkhb?=
 =?us-ascii?Q?PO/op1D9HG6H5vpwQ4JVJ+Wq2DALI+7tgkIDuEt8TR9ONe32IpERl/psgrqm?=
 =?us-ascii?Q?Wan2GBh6uOGdttA7hZ3dniPRgXpQap6lbyuuUIyB0Q+vegfurIPRdw+TE00y?=
 =?us-ascii?Q?L+30otp0K5gvItFREcd/+UJbI95akk45VYKEUHJnp+Ih3h3NI9I/S2K0rKG8?=
 =?us-ascii?Q?x+ylkYLTrGhYfonCXbawk6YdlET60KSWMEGXE8PiEd7ObjI8l4mjM6+uSj5A?=
 =?us-ascii?Q?bPiGS81zwMzj8fkJPEfMQnUlUIiWtyQspK2YnOWeUeqaZGw3ZMaFzeVLfM+Q?=
 =?us-ascii?Q?/oLGHKYXCbOTOHZbhkAU83+XIxbn664bwwnhktUYT1QMkKx37oCOtnpx3KM2?=
 =?us-ascii?Q?ha/3bsMdu9RkfuR3IyPq/KxMykTXtVLuDQTDnL95kBwnKCmq3g3W/iyE6gKI?=
 =?us-ascii?Q?Lk0qF+WV8S8tcuGxVfIglc+CpjfBrlzOI0aKzAbE4x0bquOUa1zFcNgSd3zN?=
 =?us-ascii?Q?BbReOatevO5CSajVz5T3duJ4M4X3leZvnqYAkNgKymaeOCPTgfi7LMrsmdkd?=
 =?us-ascii?Q?tC1pWTjeNMFOZPTaZ89qKM/qz8Q+IZ6WBtydMd+fMPyv46y4o/FO/woxgDak?=
 =?us-ascii?Q?dsKo0pbnH134I1Y7TthaDGFT8dycJ5o0cESy+yb2I4oKaVjb2Pvb8YoAjZXC?=
 =?us-ascii?Q?a+T3tSQkpDCdaFAJctbS2HMGnoXW7qZiNj3EYyCY0m95es1rWU3Yt/ABM7vB?=
 =?us-ascii?Q?M8td+V1lbX/8q8iEUFClFT8XcRp97JCLt9rZpmJoFGkShX8WTlbfGzg4qP1h?=
 =?us-ascii?Q?saAFgJ3waffeTNR53iziTJmIJcN/mryTtrDi3bKgQzNk0mYMPGMuW6UO6Cgv?=
 =?us-ascii?Q?HoefYuFwcMkd/Q2YiA3DVhm+oR2WPfnCP1x0+3EsrM5jzOAQ5YTweX+0lMYn?=
 =?us-ascii?Q?W23XWfWWkADJmUzhlW+AhJBidj5tnCTsj1Bb9ooAzoo3rxtp3cxcJf+xMVcg?=
 =?us-ascii?Q?v8wIXPiJZOTftm4RGTdNH0pijpZ69UQDXVfmBCIReN0PrVqgZgOwCgS4sOPK?=
 =?us-ascii?Q?qx+p3ig89Z4du/evJadiem7FQNmAm55NLOaYF9K15/x/DijvvfhoiJ5dVCks?=
 =?us-ascii?Q?eMADnbwfAVnQmWFGIF2DahaNdOTz8yHT+vTxMMB//7KXWkBPCAL5MhMLVDnf?=
 =?us-ascii?Q?3WTuvNtoG1FQ29IYJNkDp2wLB5j5YgEURPS3Hs4CIWbFuqvwPAKS5hLk4k78?=
 =?us-ascii?Q?CmoHcHLSxd2XMJ4jHxz0mcPDStml18KJN9BQJ2SZGrZDPP1wW8AMfFPNgXhR?=
 =?us-ascii?Q?p7L8a+3+R3TKSpp65zsbmOJo5Uv5UbSEQLCz05oF6GedEx1BBSWIMqS2u1hM?=
 =?us-ascii?Q?8i4ynfRy9fE6IqJbdHz1XiIBSimkhUeiJ7JgcTSlGSBeIlsAFO/vnxAZFPEb?=
 =?us-ascii?Q?IKMWrXlnfayg6nDbkn7Nk46D9q17FlVQCBS4/4syealUZpc2IXHmENX0POeg?=
 =?us-ascii?Q?Ay9h5YwJLqRjtcb1pcEGp4+bfeM6t9pEfBvmRGigZQaFyJAU0UVuj73AKQlA?=
 =?us-ascii?Q?EyNckGAN6CLneABDciTnNgltp7G9aru3MN7VIK5ix8YzxxiCgu62qU2P3/09?=
 =?us-ascii?Q?oktDTT+aPVW07QcPxDHROHU6Nrhb1t5JfBhSeLjD7/sZQ9dvuHSAt0pIUjf8?=
 =?us-ascii?Q?JYqbUw9Y4g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9db546-2ca3-494d-e4d7-08df3f23435c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 12:07:59.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1q7Ntb0WRZ5yBHhuDKhROvPiErwpJYz8lFs6KAoJw1FenOLxwAPDQ2+0qJgcw/uPzqKzLFNH9r0xdwWvc+v0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11832
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

hw_params() can be called again without hw_free() in between, and
hw_free() is also called after a failed hw_params().

fsl_asrc_request_pair() always takes a new pair, so a second hw_params()
leaves the stream in two asrc->pair[] entries. Only one is released, and
after close the other points to freed memory, which is dereferenced by
fsl_asrc_isr() and fsl_asrc_m2m_suspend(). After a failed hw_params(),
fsl_asrc_release_pair() releases a stale index that may belong to
another running stream.

Keep the owned pair and only update its channels when it is requested
again, and ignore a pair the stream does not own on release.

Fixes: 3117bb3109dc ("ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform drivers")
Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index faf348dd582d..5d97789b5c36 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -216,6 +216,8 @@ static void fsl_asrc_sel_proc(int inrate, int outrate,
  * It assigns pair by the order of A->C->B because allocation of pair B,
  * within range [ANCA, ANCA+ANCB-1], depends on the channels of pair A
  * while pair A and pair C are comparatively independent.
+ *
+ * If @pair already owns a pair, it is kept and only its channels are updated.
  */
 static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
 {
@@ -226,6 +228,19 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
 
 	guard(spinlock_irqsave)(&asrc->lock);
 
+	if (asrc->pair[pair->index] == pair) {
+		if (asrc->channel_avail + pair->channels < channels) {
+			dev_err(dev, "can't afford required channels: %d\n", channels);
+			return -EINVAL;
+		}
+
+		asrc->channel_avail += pair->channels;
+		asrc->channel_avail -= channels;
+		pair->channels = channels;
+
+		return 0;
+	}
+
 	for (i = ASRC_PAIR_A; i < ASRC_PAIR_MAX_NUM; i++) {
 		if (asrc->pair[i] != NULL)
 			continue;
@@ -257,12 +272,19 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
  * @pair: pair to release
  *
  * It clears the resource from asrc and releases the occupied channels.
+ * Nothing is done if @pair does not own a pair.
  */
 static void fsl_asrc_release_pair(struct fsl_asrc_pair *pair)
 {
 	struct fsl_asrc *asrc = pair->asrc;
 	enum asrc_pair_index index = pair->index;
 
+	/* Only the owner clears its entry, so it cannot change after this check */
+	scoped_guard(spinlock_irqsave, &asrc->lock) {
+		if (asrc->pair[index] != pair)
+			return;
+	}
+
 	/* Make sure the pair is disabled */
 	regmap_update_bits(asrc->regmap, REG_ASRCTR,
 			   ASRCTR_ASRCEi_MASK(index), 0);
-- 
2.53.0


