Return-Path: <linuxppc-dev+bounces-29248-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4657DCA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 09:56:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3CWx4nSRz3c05;
	Mon, 12 Oct 2026 20:55:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791798941;
	cv=pass; b=dvxnhogBnZE9vwZiUq/ay7fyBEvYRARsmY5778VD8bq1Bm1EVvIVc6jOfYoMGTRSae9IkKEdEDmeQPgvvWnpynC4AYdw8hU3bd5HXUfNbtFzbGZQpAL3V83dXRexx5q8NqWujqc1zgKl9OXyThw8pWTzJP4xjtKZnBfmimZEcrKYWycggAOVEsVJZg+V9rnha64s6ZOWVgWl4GLv20gWm1uqL/tWZe8dtO0wl43bj9Bi3QHNbnB9KrrMAwM32x0jTkOhMtW/8kmWfzdjG7CxHlxyZshgbWIQUDOcjNsnfCYIp2nHfFaonTgHr6/FB7jGlYynluJjqvsDqQ1emW3Fog==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791798941; c=relaxed/relaxed;
	bh=L0F0QjttyZlHhRAtGQC2YktqWCxPsmAJKy7kq6eDQ5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FEjPzm+CT4ljzSMv8A3Dlgc7aeLx1ixzB2tmjy4GSAgI1VfrtJyUhFXn9A2dC3NwLiugZ+J5BVbhnqj+PtE8pj0tCRZTnu6o3OEssJaboG4aJOibEuGUfrZBSExDh4+ZEIG09aMZpJsUYPj0cPMIKQBwDE3bVBpf27oEo8XEFlWudTwX53tw8nzCritAd5IgH+I+7xioMCj81fodvfolxTOAexrTzq+vzaWKEVEBBivzxaHtXqEohxaQ+mTipNcZxKdctPVV3wGF/yTQRebM2jxUFk7j2+N8lghoZMyNER2uYLJ7sm0iKK0l6WkqjkK1sUo0CgbiGBdDjDVtGCjDRg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VNLrZqeO; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VNLrZqeO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3CWw5w6Pz3c2C
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 20:55:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTbJzSla5IjBGypbyHwbRRgh0NgazJRHurn7vgScuoU/IglYUUbltWSxfRv90GcIaiEkhBCP2BRSi4rhLn8n4hNKA4l2qofKxvVzMrI1gDPKsXzEvN+FdGe4qQbqCqhdURfSIyQ7Ora4BxItWHGtWrsEdz4G579XYaWfKseWw5ah22/nzQ0ppSOZqAv1aL7CczPSeZMl3pFqzchpQFRJD0vtpjEZwcrPRsgRsY2IoBjMQx9PBaopIhk2DGFrBQifX3+1Oh3FSY0SXDINMoEler9fQu11aptOmFi6qjQ2IDMOdBfyqXc14+vyuc9EL2R9ooAidk/w8FXciUY+gBzjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0F0QjttyZlHhRAtGQC2YktqWCxPsmAJKy7kq6eDQ5A=;
 b=bFHAgRnSNZMAg0X6jMKtX25nR+rMWeKrv2Jc/KClxfPTa/mstMLnKWOfssG7CRtWBB6GEJLBgi1hISWhshV13Zo/fbcX+MEyfy52m6CDAwW4Cm3Ffem9raqbizf/sWNrb7T4fr8CKCotWIwgGW3cq6DUKXM+mDB6S1afL6g+mrvoFWiwf/UAsOKYO+ypWz6o+/hyH1GxXfhi+IW9pnehskP3s+nXT2bcCw77P3zM7Fe3FCMIbbFEaZTKuj9RjPlBpdRGQT2YsGS0/Xu5CdrYvqn2dN6r1UAbJwFkkFi9VKRnCl+JV2ZwYnrz8JfrSEUVTH1NLlMawn5qwSEZO6IMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0F0QjttyZlHhRAtGQC2YktqWCxPsmAJKy7kq6eDQ5A=;
 b=VNLrZqeObCdjqpMyYrFdtktONuDbTOXLJgVnY+KZYlxTwN57xs60yu3UFmieqS+Dy0BBYanTjmEbDTIb6C1FS1Ey3bi4vAnXDTDuUsdbgajqYcIfAmUDSJ7FZUMcU3UOFWVn3HQjUxysACcXZFbfHx9KRtrdSmXdIlxXzt5l5PU5e6It5rVw7viuVVlRPo0AHtHm+aJWbZcXPICOJ5uvi/D56hpzopPsQTbkx2i9+3NqBIlTd4KLgYdf4sLztohjYCvV/wAWB74EEfTNhCiwlf9/5zLQq1WyBt1mD9I6u0Poj8LWtbltmscXXD95J3Sx2+l6UG1U4athv99JMEWDcQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VE1PR04MB7248.eurprd04.prod.outlook.com (2603:10a6:800:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 09:55:32 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0496.018; Mon, 12 Oct 2026
 09:55:32 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	linusw@kernel.org
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 6/9] net: dsa: netc: check return value of ntmp_ipft_delete_entry()
Date: Mon, 12 Oct 2026 17:59:21 +0800
Message-Id: <20261012095924.1129312-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
References: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0061.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VE1PR04MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 93662662-778c-4c74-289a-08df2846f443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|19092799006|376014|7416014|10067099003|3023799007|261009223027099003|921020|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HJTGCHFlJGGm8y9Wah/d9dzFlWfDXsS4MAiA8379x9/Ex92NLfxDjtACqoNzYRBE5vBw4S0bHiaYTMCP25OJgA/IkQMccitgoKs2SbpYw9BZrUm3VcR6r8IVIIrkRhTE9w+EIYo39SHsu6fuEqKXtjSqu7GtQmFnVGaACZn31SAFVrUx16W/4JZysNV2/pp+27DxofBVTWQjzVHMEPrDfRqjkf2DbRLyTGq1pkYSMEiacFExZZyEIenkdDUMMpkmA6Q2E477Httd/TPgfEFWAUmkfOij55DlV7+vt3GLD2MG/Zt9pA7tOXJvaqy0ZtuChzQW/bYFMgYdotfRHEQgzTisWMkMUC6oLUZoIXjYQbmm9UFihhR0vJbtU5oj9NpFKev4h5VZe2VyTj1ksWnbnh/KaaMVUUIkCj/18Uz5oujUIjiON9v6dfUw6+3mcjeJaUV1vhETgLpdd5sFz0qVqK2B3ri3Php0wZ1RTGQ7S7DIZeYx6zF+x0HL2aqCtXBxXEiN53p6DLIgBI9iVrywJCLPHVuKQrbSXC5DggrCdXT7CiG/c9RJAGjZ2vHlpawqwqTHLWEJjT/jlYFf1ly4t6P87eM3NpHRAM3n8SU0vvA20/7qjyckGn4HLiuScJSdKu9ZMbyUSNzksLxSVCUgCbkS+hBp6iJ/osB/iQc1wgcF7Tm0b8L//jq8WVKRurcUDIAuFOS5WeolOoVsWBhsHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(19092799006)(376014)(7416014)(10067099003)(3023799007)(261009223027099003)(921020)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G9IHunokbommfCld6/bX+zlLkuGVyM7XqlLpyw27Sd1c0mJ27LEdRTQTXjyY?=
 =?us-ascii?Q?7fSIsy9OKlrd3U12hROkCxF4vx69yLr+vwjfX0URbEYUXK1MjDNNOpNOxkCG?=
 =?us-ascii?Q?J0EFAZXPS6orMLULNkNJLLt+ObtKiJPpk4xIiJM2O+yXbq75kRr+x4IZgEUu?=
 =?us-ascii?Q?9IhthdkLCwz796NK9BgcYuD2gnpPdYaotb34S3fTCKPoRogPzvDcbicl1XlE?=
 =?us-ascii?Q?+yyyF1cPNKX2xqXo/YLfuiqi7hKeYEAB12+7BR+Am0EKwnrzyIbiirfHV1wo?=
 =?us-ascii?Q?2v52CdiEJh3ZCIxYUdYMguuff+JOimvG9rWXOHcTlWNGKHdPN1BksVNExs9g?=
 =?us-ascii?Q?cHOy/OwbMlVRfEtb3xPdHHfxcJuro6no1/fqoP9ypw7OFPvlkW3o52Due5YY?=
 =?us-ascii?Q?zcGORUX8iqQpVvg3b8cZtDUbhsJ/M5SVNOA4znBuc2wXv4vCCIAPptI/bU65?=
 =?us-ascii?Q?F3ND5ocfZGolV+zOrwh5Xl6xpandZr6da9TyWQZQObecdQMPvzO6gzRNIHzH?=
 =?us-ascii?Q?vmYMp7omIz5dnzUHO13xfMFI0rGZy3MX1Nq+2QsUtBqSuTlX3zHR5WVV0Ww2?=
 =?us-ascii?Q?g92MZ7zBaugTKV8x1Grzcmy5e4D5pxfXwbYsL+8PLTXbggjP5GuHTApds0wq?=
 =?us-ascii?Q?fTnaGmZ4DSyLOnrNzc9kAbd70o+lOscRI4ZBawU8NiBNRUhAra+ThVeEaXXK?=
 =?us-ascii?Q?cnpfny9yCqSaEzG74ujqeNSkjK2TYEHFXdFtLx8DgysBO/VlyZ15vYEC/nN6?=
 =?us-ascii?Q?Wpk1dSTSvI0NKRVMyTyH+bDaHr5GzX10oNHVuaPltJg5iYH2rsgk2NZz6C7M?=
 =?us-ascii?Q?77CtGGfSEe8Dfd9S6WnQfhtLO4KCS6pCmOr2zSrcP1lRVU5WOgnfANnBtdYD?=
 =?us-ascii?Q?fB5QNBGAhlSyEnEefoyfSGynjR5wLKmA8xrjCKlE7aPH+DaYNNEM4n55SZp1?=
 =?us-ascii?Q?Yr/uy2aUDZQ2b+/94h2MJEUCd3jM7l+a3UbvDMZPbImKtYGNEZgZ6jwmVcME?=
 =?us-ascii?Q?22WOtVct8biMmkdYkb4M3bRnZiJGLAlU0LubFoCgKzzK11gdKYc38DoIvDwc?=
 =?us-ascii?Q?eim6AexGnkA2UY/EI4BlYyucmjbexjujH1ao7iTLjBSvo4dscTqzz9b/KGOL?=
 =?us-ascii?Q?rxpC62nOk0hDm711CGsQCHR+bWInIGK1dob0rijRYboqNKpLMTMdzqwAaXxK?=
 =?us-ascii?Q?YPvpynyGeyihCFf8ZkIyRSHsKDbe/lvG6qBvMufsu4crvsPlAP+xNW9vLUoE?=
 =?us-ascii?Q?HZSn4U392l6LHA5TBRztV/L8/VrnIR/mm8EHaoRI++zdpJuDTfOQDN1FEsig?=
 =?us-ascii?Q?9Ad/fDZzil9LHaby0fmu177Phj3khYj1feno63xsWT8+ifk1U6s2GN7n4TiN?=
 =?us-ascii?Q?7DqQUn2jM3sZBqTi7iWpVXpt4Iq8Arpx63lq76YuKjMxqRbMX4UXcmfTo3on?=
 =?us-ascii?Q?fcqVdsTEb/bePf6z/QcOZY9u02WhCCMuzzMtOLezXbvYaN4EhRFTgIN4ClHV?=
 =?us-ascii?Q?Rdong0rIRxd/Kb2vH7DsE0AXL0ZOzOQLcix7TknTRvdPCDo0g/fswa6N2VDJ?=
 =?us-ascii?Q?lwfMgjI754o8l7SHm22lkrFHYJrnIQDgFqmC2yBX/PXg+OtnePax5bVruA03?=
 =?us-ascii?Q?kM7ETVloUXYpjtB72NtQIqj3Hn6QjFBqnV5VwgGBf4Gh4mIQAxTg2puxZp+h?=
 =?us-ascii?Q?C90mMc2oXbxzeKK8jtsObsYn84dlXpGCHPIdzJ7vZKsK6SZO63cz3HZGtWvS?=
 =?us-ascii?Q?0tnHz80IJ7p1mgtS2u9eulPOXrQ5/h09jnF2myPnAIdOMA7jsW7X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93662662-778c-4c74-289a-08df2846f443
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:55:32.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9m4lqApF4UylvbAewHt79dQNlfxiFx70iClLXzehRO9ugNiOk2o2J2ijxidMvKlw4eg+KBRHBpNxMtozq5qfUkLVKa+FoTUGYeNv927B5+diIT0VN96ypilLTj9x5nn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7248

From: Wei Fang <wei.fang@nxp.com>

The driver ignored the return value of ntmp_ipft_delete_entry(), so a
failed deletion left the IPFT entry untracked and impossible to clean
up later. IPFT is going to serve more features, such as trapping PTP
packets and flow policing, so make the deletion path robust to prepare
for these future uses.

To this end, propagate the error to the callers and update the driver
state only after the entry has really been deleted, so that the
software state always stays consistent with the hardware.

Once the deletion can fail, the order in which a rule is replaced also
needs to change. Since IPFT does not support in-place updates to the
KEYE element, replacing an existing rule requires deleting the old
entry and then adding the new one. Keeping the previous add-then-delete
order means that if the delete fails, a port would have to track two or
more stale host flood rules, which needlessly complicates the driver.
So switch to a delete-then-add order instead. This order is not
perfect: between the delete and the add there is a brief window in
which packets that would have matched the rule find no match and are
dropped. The window is very short and its impact is acceptable, so this
is a deliberate trade-off in favour of simpler software.

Note that, a delete failure has never been observed in practice and
is highly unlikely to happen, so this patch is an improvement over the
previous approach rather than a fix for an issue seen in the field.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c | 86 ++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index e33a184fd005..09154781df7a 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1796,14 +1796,8 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	u32 cfg;
 	int err;
 
-	if (!uc && !mc) {
-		/* Disable ingress port filter table lookup */
-		netc_port_wr(np, NETC_PIPFCR, 0);
-		np->uc = false;
-		np->mc = false;
-
+	if (!uc && !mc)
 		return 0;
-	}
 
 	host_flood = kzalloc_obj(*host_flood);
 	if (!host_flood)
@@ -1851,32 +1845,32 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	return err;
 }
 
-static void netc_port_remove_host_flood(struct netc_port *np, u32 entry_id)
+static int netc_port_remove_host_flood(struct netc_port *np)
 {
 	struct netc_switch *priv = np->switch_priv;
-	bool disable_host_flood = false;
+	u32 entry_id = np->ipft_hf_eid;
+	int err;
 
 	if (entry_id == NTMP_NULL_ENTRY_ID)
-		return;
+		return 0;
 
-	if (np->ipft_hf_eid == entry_id)
-		disable_host_flood = true;
+	err = ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
+	if (err)
+		return err;
 
-	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
+	np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
+	np->uc = false;
+	np->mc = false;
+	netc_port_wr(np, NETC_PIPFCR, 0);
 
-	if (disable_host_flood) {
-		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
-		np->uc = false;
-		np->mc = false;
-		netc_port_wr(np, NETC_PIPFCR, 0);
-	}
+	return 0;
 }
 
 static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 				     bool uc, bool mc)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
-	u32 old_entry_id;
+	int retry_num = 0;
 
 	/* Do not add host flood rule to ingress port filter table when
 	 * the port has joined a bridge. Otherwise, the ingress frames
@@ -1884,7 +1878,12 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	 * will be redirected directly to the CPU port.
 	 */
 	if (dsa_port_bridge_dev_get(np->dp)) {
-		netc_port_remove_host_flood(np, np->ipft_hf_eid);
+		if (!netc_port_remove_host_flood(np))
+			return;
+
+		dev_err(ds->dev,
+			"Failed to delete host flood rule on bridge port %d\n",
+			port);
 
 		return;
 	}
@@ -1893,19 +1892,33 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 		return;
 
 	/* IPFT does not support in-place updates to the KEYE element,
-	 * we need to add a new entry and then delete the old one. So
-	 * save the old entry ID first.
+	 * we need to delete the old one and then add the new rule. If
+	 * the deletion fails, return immediately.
 	 */
-	old_entry_id = np->ipft_hf_eid;
-
-	if (netc_port_add_host_flood_rule(np, uc, mc)) {
-		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
+	if (netc_port_remove_host_flood(np)) {
+		dev_err(ds->dev,
+			"Failed to delete old host flood rule on port %d\n",
 			port);
+
 		return;
 	}
 
-	/* Remove the old host flood entry */
-	netc_port_remove_host_flood(np, old_entry_id);
+	/* Restoring the previous configuration is pointless because
+	 * .port_set_host_flood() returns void, so the upper layer cannot
+	 * detect the error and the RX flags have changed. Furthermore, we
+	 * cannot guarantee that we can successfully restore the previous
+	 * state.
+	 */
+retry:
+	if (netc_port_add_host_flood_rule(np, uc, mc)) {
+		if (retry_num++ < 2) {
+			usleep_range(100, 110);
+			goto retry;
+		}
+
+		dev_err(ds->dev,
+			"Failed to add host flood rule on port %d\n", port);
+	}
 }
 
 static int netc_single_vlan_aware_bridge(struct dsa_switch *ds,
@@ -2070,6 +2083,8 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
+	bool uc = np->uc;
+	bool mc = np->mc;
 	int err;
 
 	if (!bridge.num) {
@@ -2081,6 +2096,12 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	if (err)
 		return err;
 
+	err = netc_port_remove_host_flood(np);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to delete host flood rule");
+		return err;
+	}
+
 	netc_port_set_mlo(np, MLO_NOT_OVERRIDE);
 
 	if (br_vlan_enabled(bridge.dev))
@@ -2094,8 +2115,6 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, vlan_unaware_pvid);
 
 out:
-	netc_port_remove_host_flood(np, np->ipft_hf_eid);
-
 	if (atomic_inc_return(&priv->br_cnt) == 1)
 		schedule_delayed_work(&priv->fdbt_ageing_work,
 				      READ_ONCE(priv->fdbt_ageing_delay));
@@ -2105,6 +2124,11 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 disable_mlo:
 	netc_port_set_mlo(np, MLO_DISABLE);
 
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_err(ds->dev,
+			"Failed to restore host flood rule on port %d\n",
+			port);
+
 	return err;
 }
 
-- 
2.34.1


