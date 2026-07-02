Return-Path: <linuxppc-dev+bounces-23344-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E29CC43602
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 03:25:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grMj31V9Fz2ygW;
	Thu, 02 Jul 2026 13:25:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782962743;
	cv=pass; b=KNNCEMqqQ3gYjm/+Vt7Hn+3fXOYsRLwMXLKZU0ZE9Jr4g8FNqghJC+/ZE6Px83PML7Bw0LRx/godlrhGL+yrNphasFgPJ/eePmF18HO7B39gP+XSXCsCVJqtyVEnxzU07q2obgXPstECENYG4Rt0I4iPRdHyheVTqf8hupgKUOFrw+B42pBPIz/7cok/yiB0ewxOMAZWn78M8Lr9Rtm3b5OiCZ9x4rDAdw9y5xmCQIk+hg5qFdSFHlZyl0gPP2Oojcl7wjBsgEmpaIL58O52/4jSqY4jZH42r9wgMr+4PLmukwnSPBv8a3+sowTgChiTQIgCu+KQ0/nV/PnTlM3GTA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782962743; c=relaxed/relaxed;
	bh=uf7R3hDgk51Q5WBhT1WZQt5pblRb/WvzPKESaRYdXgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=etIKAuLney/eXbJLOfz+Pni7QoxRMAZMvjH1DB0xcgb98DSDKhOIaxMCcq8+HmCn9QqjSruvzKY8FKpQwwAMoinXrcZ1YzVUU/2p8ll3vZzkkTeB+3GiR/HpGSqX5meUcFJUsfqVr0D6D7uvEcTrbw4S+pORGXY3wJd8ATMfXiwzli9azHYRH9Wbayy+S3Jv/wcQ8wfeToC7gXvI3nZK1NpJl6QmUoVw1JTfNv+EyhShea4fjtyYtzZxi3dBR2leojerAs3fxo+pEa2Zahr+zdbv3u9tkiMmqd7quLPjbz6tWwmHy15qXN7+/5pL9fMdKSf5NPJypXmrKEgxHwpIyA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZvhKhggk; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZvhKhggk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grMj15PTwz2yjR
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 13:25:41 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeBXk8FNqDzWF1wU+9Zw8Z2SxCmtQbld/A1AlWdcYR9xzwon4ZOdLwWDGzZfVvl2zbQrM5GLLjHk7ycH4+HNlvl4+HFkkiY7uwqK+XDKJahwFCY/TVfhYu2w+fGhFKJ+sX0/5ZNGd6ao5HYy6XCg77jix3cisU8t6u6qcvE/dZfIMHEq2EshKzkLXMu3BNhOWxuo/LIJezZs15omHea4y7KSDhK4tu82XPxokmLuBYT2mWDV5/DoDfXWNKFiJQd+YQkmGq1jciaSUYWnUUcbgOBBRm2PFGLTK8mmpUZXn9P7tmlYzYO7aMbJLqB8HUt766+t+FgL8bNDiW9mMSZmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf7R3hDgk51Q5WBhT1WZQt5pblRb/WvzPKESaRYdXgs=;
 b=YNpDRp6UEIjkH5K7igDtQhDg8anG6ZA0RUMEfuyLJQ/8UnmdYXzuav5oKaCq3gRfdGuvkOCTxkBi2NtpI9uKetH5m0Db1V8lHc4gmd4qzChXTpFV17SJ2fnYfm9HcmT+XWEq+Q+Wawi8iyT4+z+2W5D5YJL8PjRibKY/9GwY1Ur6DKn4Aw0fpXP/n8K3VptR4/KPlWryJtyUH/nJwB3IJq8rFNfQPAlcjWzCVDnLJsdDVzvDxL3VkDAjy2VeR0+vtUZc5ZBHbwSOpVDG4/m6VVSA+fRY6ZcyGJKOSYIO/eJh3XB2+X4KwKfJnAO4LASFg+XdFi8caZ3+VYxUNHfEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf7R3hDgk51Q5WBhT1WZQt5pblRb/WvzPKESaRYdXgs=;
 b=ZvhKhggkgIU2ju7/D4VI3Nlh68NU4VPgh77uR/wcFnTHql6h5skHvaw7Gds2f4Vu1HkHIz6UMuB2Re7gIDboWZgt1fDP29O/7MSEPmnqvuooWSpqpiSFqHcu6AIXP9hYzrYaWAHZXygNA9xz6Tu372jbIvbagGjwmYG9kC/7NwFJBK0BG2ZdPCgQVb6g8PgmNh40osdz8TtSTTosVC4GOZ38FgnCbmJJJaX09zNXo9vV05vZm3OD23cy0lccfCNXR+GGiOFkrlHxYqwAcvw+EkGtCbd433SGX+pnRU1B07xVJge8/IJuuIY0YgwXOLkE/CZwhE0WzXHC6DE4bmQo3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:25:24 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:25:23 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 02/14] net: enetc: extract common helpers for MAC hash filter configuration
Date: Thu,  2 Jul 2026 10:57:02 +0800
Message-Id: <20260702025714.456233-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702025714.456233-1-wei.fang@oss.nxp.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0253.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::7) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GVXPR04MB10248:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbfaab2-320c-4587-1b88-08ded7e98dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jsOAWxhP6wR0xb6SEESJikay4O4NsJ1p6i6s1UFKwUFPT34kzgbaBkYAAurd6g6KmucLPofJhrKEmrDXoIuJoiwp7YNmNIA+S6tdwptARD09igM58mQG72yURPvCt+z+kd20Fm8v5iI/b4pYiv4Uag8xDrBGkoPCiMGs2NWw6q9m8x2D3tSlixjTCDjCgpZHK3k5rEhGPswpOxeOF9LU1sVveMNcFIbAdJUv4DrnqibWfzspnY5cUdcVqk4/FNh9ImKxxvuUfHtseJHQ4UorYbCPblnjalnjyJJ7kDR1+Vh9s2+QzCr2oC6bzstryw+3Vy40boS0nMqbWUrvGUtEbMaDT1gTZ+Oyvf9AEW/rRpND+nKHPNA5QNChZPO/YWzX83PBrEQNAEIa6cKprENcb5a+IaLxiPVfHgsbx9am/OswsmIVsi9krHKfDVoJnYq4lfMXJCaGkPsGbuxKxTf1fh+KqcIXr07csKyB67rlwLr0838SMolT8H5UHs5m6N33NdQIqf9+d2VS8nVvKYWEoY456qPVHtp4YRoRAGSlSs0hxGE3S9DwFUAF3UeGHJQ1zo0GB06txbBKmzct93ebsgsjquGHzVsG3Gj4PuSNCXivejlq81+OoRtgKF/8B8DpPWgFNHy9ENaPBf/TVHcLBtzzrCh+YED+P42gsjL23E2oXkpwDCvdnDoiYKFbdWQ3tH97jW7wKboUHKLy2R4B6Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2QvbdksSSaoMtBOggW71IXhlgvvObty9qTB0g9bUGPNSEmjMGBGZar02sZBL?=
 =?us-ascii?Q?rtzG8Coo3eEcDoVRnFzADoVPOq6CwIl6PunMhbEo56TjrTpRqfA5a+RgBqX8?=
 =?us-ascii?Q?M+OC7dnxKEmOmHnGAPUJcybmOLMj7lUrZx/cDGtAp5EjsGhOiAGxIYlb3KO7?=
 =?us-ascii?Q?zYloMuJVJAnLmiytNi0VV/lC86/YvmItD5B8896cuND3XaBe/4w5y30c4lUp?=
 =?us-ascii?Q?ufn0IIpJGGZP04qecQhbhrxKiBDomN1VX36ID2YG9YQA0z4H5rlWZJF11KBf?=
 =?us-ascii?Q?E72xg5349dtAotifK4Atrhuoj3+u2NY0HpT7KWVc7XxFT0rNwhUgxQJkIOGu?=
 =?us-ascii?Q?8SqoquMt1w8zbceHj2xWskaZpDPg+zBUEFbLnVNG6CxJZSU+b3Yskih0wDha?=
 =?us-ascii?Q?KwUDVYvoFoNA0SHXFmR+ZYHCqe7ssfddZYObOGkHHn9KGRrF0qH+Sg/jKWFl?=
 =?us-ascii?Q?FYwj56GgWbPDWIMJygoOMklsyut/OtSLuHKFG6jWwu9uIbxhQB0aJJgXVttT?=
 =?us-ascii?Q?Gxyx+abeezs6dR/H8xdMIaBaZbqr7WjwlgVMp9LsbuhisTJowCrJr+hRiRbI?=
 =?us-ascii?Q?IimVhfGH3TJBYQ249Zy1KBNtf8H9uIe6WZtaSzmOL0nr8y13fmhPvS9t4YtC?=
 =?us-ascii?Q?jR4QzXfq91futopBgBhWT9QbbosK1H8dygtkrzFGLnWbaEvaYq/6uvkt+8ny?=
 =?us-ascii?Q?3STR/ZIEu5dV8Amop05vkjBQcMiiitaCdBM16WcDocB/oMtGA1UoFlXwR4mv?=
 =?us-ascii?Q?JosMyM6Bdp1/440XqI2GpurXMIzXBRvHRDw1FpNVJg34mzhuaO6zfW3btcFe?=
 =?us-ascii?Q?ofzO6tBwMzB/5agw8bSR6iuuHEnvxtpz4scEqnhcbAW1hTpI4wYbd7Wl8Lgx?=
 =?us-ascii?Q?y4cLGLKfW0EbdH+Zi3RgWlxkEtEUNkGuJnPqsx098OnL2IOjyz6//YjxfNFZ?=
 =?us-ascii?Q?yu2M2P+gynHiAbPfqDHQChke3yP5GhzdsFxN3jkFkkPFmWGO+NiHurOwvd1Q?=
 =?us-ascii?Q?B+JAy8K8OaHJf20ntiB+ak99jp0DtwKVV6mFcT9BM89ZFBOCoqvYt6ha8ezj?=
 =?us-ascii?Q?9/MorscQCwgwMH6R9lErxzQOgNm4p17GJgOpQzvjPBxwYU8Dt4BXTrGw9DvE?=
 =?us-ascii?Q?CTi4LrT6dAW0OYF2TgbuGXONTKZaIz/UY8qBSscITWiZ6++LXuiTMzwKNuJe?=
 =?us-ascii?Q?swLVd6Uk4QGv6JVuy6v0P1m8vVejke5i+rV6z5w6qS/982+11jxjbZs30qU2?=
 =?us-ascii?Q?V4kWtlLrFxRcCwphKfCjGHlqVt3EQZmgNSXQHSQdqma2b5sH+qMxg3xr9khE?=
 =?us-ascii?Q?Bd9bVWPdRPmQhTOaCpJpjj3bOn60Y/a8bcZt9xsDsd7kPOuWCBMplB4Gqrgt?=
 =?us-ascii?Q?IQjrp8eEav5JAGzNUW0ftP7VM56Ker+AOnXbfHTPrpkkw0X8zVzOZBqPOIyV?=
 =?us-ascii?Q?F5T+wtm0yOX65vbWt/76fyI8LiYikjWaJmAS0nPqvdRKLUvt/fMlK/tvYg8T?=
 =?us-ascii?Q?EsSL43LQVS6FCbG3B6jMEgGl6YpeEHUmUUUM3OK6538pF4h7CpVLZT9SG3eg?=
 =?us-ascii?Q?yxAYEEJUrjm79+UR2fO6qkrj7rn7HjPM6s6ft7gSFV7AlOA/nSlPHHgicj2A?=
 =?us-ascii?Q?1orjkmtM2FGwQ3opAe4CDW3KnwONS2tlaslhWe5JWkJQk0+rlOJh13LvRoQy?=
 =?us-ascii?Q?D3uO8L7kKYDsJFEtJzPnooCy+9jKhSoNTLtlBprdypxCVEqKiHqaZD/zjtOO?=
 =?us-ascii?Q?P016PWyDncZbCU4SQV5B8jK5Ch3XrW7QhSp/wMA5BW1XmMUg5IiJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbfaab2-320c-4587-1b88-08ded7e98dac
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:25:23.9112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P68DURSfqJmzpUvHRIsQkcTbLppp0fscXbwMBMR7tgCStv8ng1LrDG8FoH1UpqzwHEZjml7F32l8wfXB/dH15PdAeFFIAuaBUXeXZXnT7lYDvr0krdkUnSu0Nfhu1WEd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248

From: Wei Fang <wei.fang@nxp.com>

The PSIUMHFR and PSIMMHFR registers in ENETC v4 have the same bit layout
as in ENETC v1. The only difference between the two hardware generations
is the register address offsets.

Since the register functionality is identical, the MAC hash filter
configuration code can be shared between the ENETC v1 and v4 drivers.
Extract two new common helper functions, enetc_set_si_uc_hash_filter()
and enetc_set_si_mc_hash_filter(), into enetc_pf_common.c. These helpers
select the correct register offset based on the hardware revision via
is_enetc_rev1().

Remove v1-specific enetc_clear_mac_ht_flt() and enetc_set_mac_ht_flt()
from enetc_pf.c, and v4-specific enetc4_pf_set_si_uc_hash_filter() and
enetc4_pf_set_si_mc_hash_filter() from enetc4_pf.c, as they are now
superseded by the shared implementations.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 43 +++++++---------
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 51 +++++--------------
 .../freescale/enetc/enetc_pf_common.c         | 40 +++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 +
 4 files changed, 73 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 304ec069654d..48a74db90ed5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -75,20 +75,6 @@ static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
 	put_unaligned_le16(lower, addr + 4);
 }
 
-static void enetc4_pf_set_si_uc_hash_filter(struct enetc_hw *hw, int si,
-					    u64 hash)
-{
-	enetc_port_wr(hw, ENETC4_PSIUMHFR0(si), lower_32_bits(hash));
-	enetc_port_wr(hw, ENETC4_PSIUMHFR1(si), upper_32_bits(hash));
-}
-
-static void enetc4_pf_set_si_mc_hash_filter(struct enetc_hw *hw, int si,
-					    u64 hash)
-{
-	enetc_port_wr(hw, ENETC4_PSIMMHFR0(si), lower_32_bits(hash));
-	enetc_port_wr(hw, ENETC4_PSIMMHFR1(si), upper_32_bits(hash));
-}
-
 static void enetc4_pf_set_loopback(struct net_device *ndev, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
@@ -147,11 +133,12 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	int max_num_mfe = pf->caps.mac_filter_num;
 	struct enetc_mac_filter mac_filter = {};
 	struct net_device *ndev = pf->si->ndev;
-	struct enetc_hw *hw = &pf->si->hw;
 	struct enetc_mac_addr *mac_tbl;
+	struct enetc_si *si = pf->si;
 	struct netdev_hw_addr *ha;
 	int i = 0, err;
 	int mac_cnt;
+	u64 hash;
 
 	netif_addr_lock_bh(ndev);
 
@@ -159,7 +146,7 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	if (!mac_cnt) {
 		netif_addr_unlock_bh(ndev);
 		/* clear both MAC hash and exact filters */
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
 
 		return 0;
@@ -186,11 +173,13 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	/* Set temporary unicast hash filters in case of Rx loss when
 	 * updating MAC address filter table
 	 */
-	enetc4_pf_set_si_uc_hash_filter(hw, 0, *mac_filter.mac_hash_table);
+	bitmap_to_arr64(&hash, mac_filter.mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_uc_hash_filter(si, 0, hash);
 	enetc4_pf_clear_maft_entries(pf);
 
 	if (!enetc4_pf_add_maft_entries(pf, mac_tbl, i))
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 
 	kfree(mac_tbl);
 
@@ -206,8 +195,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 {
 	struct net_device *ndev = pf->si->ndev;
 	struct enetc_mac_filter *mac_filter;
-	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
 	struct netdev_hw_addr *ha;
+	u64 hash;
 
 	netif_addr_lock_bh(ndev);
 	if (type & ENETC_MAC_FILTER_TYPE_UC) {
@@ -216,8 +206,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 		netdev_for_each_uc_addr(ha, ndev)
 			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-		enetc4_pf_set_si_uc_hash_filter(hw, 0,
-						*mac_filter->mac_hash_table);
+		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
+		enetc_set_si_uc_hash_filter(si, 0, hash);
 	}
 
 	if (type & ENETC_MAC_FILTER_TYPE_MC) {
@@ -226,8 +217,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 		netdev_for_each_mc_addr(ha, ndev)
 			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-		enetc4_pf_set_si_mc_hash_filter(hw, 0,
-						*mac_filter->mac_hash_table);
+		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
+		enetc_set_si_mc_hash_filter(si, 0, hash);
 	}
 	netif_addr_unlock_bh(ndev);
 }
@@ -480,7 +472,6 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 	struct enetc_si *si = container_of(work, struct enetc_si, rx_mode_task);
 	struct enetc_pf *pf = enetc_si_priv(si);
 	struct net_device *ndev = si->ndev;
-	struct enetc_hw *hw = &si->hw;
 	bool uc_promisc = false;
 	bool mc_promisc = false;
 	int type = 0;
@@ -501,12 +492,12 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 	enetc_set_si_mc_promisc(si, 0, mc_promisc);
 
 	if (uc_promisc) {
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
 	}
 
 	if (mc_promisc)
-		enetc4_pf_set_si_mc_hash_filter(hw, 0, 0);
+		enetc_set_si_mc_hash_filter(si, 0, 0);
 
 	/* Set new MAC filter */
 	enetc4_pf_set_mac_filter(pf, type);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index a97d2e2dd07b..db2a800a7aaf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -80,37 +80,6 @@ static void enetc_add_mac_addr_em_filter(struct enetc_mac_filter *filter,
 	filter->mac_addr_cnt++;
 }
 
-static void enetc_clear_mac_ht_flt(struct enetc_si *si, int si_idx, int type)
-{
-	bool err = si->errata & ENETC_ERR_UCMCSWP;
-
-	if (type == UC) {
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR0(si_idx, err), 0);
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR1(si_idx), 0);
-	} else { /* MC */
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR0(si_idx, err), 0);
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR1(si_idx), 0);
-	}
-}
-
-static void enetc_set_mac_ht_flt(struct enetc_si *si, int si_idx, int type,
-				 unsigned long hash)
-{
-	bool err = si->errata & ENETC_ERR_UCMCSWP;
-
-	if (type == UC) {
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR0(si_idx, err),
-			      lower_32_bits(hash));
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR1(si_idx),
-			      upper_32_bits(hash));
-	} else { /* MC */
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR0(si_idx, err),
-			      lower_32_bits(hash));
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR1(si_idx),
-			      upper_32_bits(hash));
-	}
-}
-
 static void enetc_sync_mac_filters(struct enetc_pf *pf)
 {
 	struct enetc_mac_filter *f = pf->mac_filter;
@@ -122,12 +91,16 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 	for (i = 0; i < MADDR_TYPE; i++, f++) {
 		bool em = (f->mac_addr_cnt == 1) && (i == UC);
 		bool clear = !f->mac_addr_cnt;
+		u64 hash;
 
 		if (clear) {
-			if (i == UC)
+			if (i == UC) {
 				enetc_clear_mac_flt_entry(si, pos);
+				enetc_set_si_uc_hash_filter(si, 0, 0);
+			} else {
+				enetc_set_si_mc_hash_filter(si, 0, 0);
+			}
 
-			enetc_clear_mac_ht_flt(si, 0, i);
 			continue;
 		}
 
@@ -135,7 +108,7 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 		if (em) {
 			int err;
 
-			enetc_clear_mac_ht_flt(si, 0, UC);
+			enetc_set_si_uc_hash_filter(si, 0, 0);
 
 			err = enetc_set_mac_flt_entry(si, pos, f->mac_addr,
 						      BIT(0));
@@ -147,11 +120,15 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 				 err);
 		}
 
+		bitmap_to_arr64(&hash, f->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
 		/* hash table filter, clear EM filter for UC entries */
-		if (i == UC)
+		if (i == UC) {
 			enetc_clear_mac_flt_entry(si, pos);
-
-		enetc_set_mac_ht_flt(si, 0, i, *f->mac_hash_table);
+			enetc_set_si_uc_hash_filter(si, 0, hash);
+		} else {
+			enetc_set_si_mc_hash_filter(si, 0, hash);
+		}
 	}
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index b0c0dc668e34..3597cb81a7cc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -131,6 +131,46 @@ void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc)
 }
 EXPORT_SYMBOL_GPL(enetc_set_si_mc_promisc);
 
+void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
+{
+	int psiumhfr0_off, psiumhfr1_off;
+	struct enetc_hw *hw = &si->hw;
+
+	if (is_enetc_rev1(si)) {
+		bool err = si->errata & ENETC_ERR_UCMCSWP;
+
+		psiumhfr0_off = ENETC_PSIUMHFR0(si_id, err);
+		psiumhfr1_off = ENETC_PSIUMHFR1(si_id);
+	} else {
+		psiumhfr0_off = ENETC4_PSIUMHFR0(si_id);
+		psiumhfr1_off = ENETC4_PSIUMHFR1(si_id);
+	}
+
+	enetc_port_wr(hw, psiumhfr0_off, lower_32_bits(hash));
+	enetc_port_wr(hw, psiumhfr1_off, upper_32_bits(hash));
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_uc_hash_filter);
+
+void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
+{
+	int psimmhfr0_off, psimmhfr1_off;
+	struct enetc_hw *hw = &si->hw;
+
+	if (is_enetc_rev1(si)) {
+		bool err = si->errata & ENETC_ERR_UCMCSWP;
+
+		psimmhfr0_off = ENETC_PSIMMHFR0(si_id, err);
+		psimmhfr1_off = ENETC_PSIMMHFR1(si_id);
+	} else {
+		psimmhfr0_off = ENETC4_PSIMMHFR0(si_id);
+		psimmhfr1_off = ENETC4_PSIMMHFR1(si_id);
+	}
+
+	enetc_port_wr(hw, psimmhfr0_off, lower_32_bits(hash));
+	enetc_port_wr(hw, psimmhfr1_off, upper_32_bits(hash));
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_mc_hash_filter);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index a619fb8fed9c..bf9029b0a017 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -19,6 +19,8 @@ int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
 void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
+void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
+void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


