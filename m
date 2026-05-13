Return-Path: <linuxppc-dev+bounces-20812-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5039CCD37AC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:04:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdbC0Fxqz2yqx;
	Wed, 13 May 2026 13:04:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641446;
	cv=pass; b=PyWefhVkn9Nzqz2P+u9V6Ni/6m4jpWFJlNYzhKItby96UUqdnYim8K8V04f1nkncMCtFg5IK49ASNYsWmk2cQzCPz70g36PuH9YyY4/JGKNqxs0PENCu3MRPKS98r/Ke1oW8fahA1pK4RQCfH++bn58gpQ8VlRJLV5uezfApxuPOh/PUh6G2bxPJLDnTmFseVRc/wPTj4uEua4Luipca9PexatfN1UdD99nITNWFeXstMWO2cUIVOQZcThzqMekkhNYe0Mrv1Jv2e+/hoFFPtKu/x5lohektYSPaeEYfP52gFeDTfayEWMgtwo4GwQZahTpniTs6wVVFwz0r/8cTLg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641446; c=relaxed/relaxed;
	bh=DVjCB/sve+5iQSof275/7DdimURZhltIc6Gxwubhw+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Azq0bk2gQ3UoxP0cf8OQCfYFGrzqj7VoLnoXDDaTmuMttBgbznnvsffSINzCYlO1DQ7dXkQn/MLCMEhOPGOGVhtOwV1QdW4FNlOZS5snmlAc/jJQ+rixHVw3BWP0X9Lqfuy4ai9YEipaimHuMSimUWXvuuqdb6kdpvW9njpfVVWtMxe77oL8YLowBJWizYOj4IPHQ1V1nnbdQMOhrz9h88jqdexX9qqhm15i5Q+zmqL2gFSyI7y8o7EXKWl0fyphrhZG0pc3nCB4mizT3W7nu8DMqNhS9D5ti5O3IT5K1WIAPWH0LrrJBAhbOu7ZBHSFVKaoypXnUyiTzcmmTARNhA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PK3NlgDy; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PK3NlgDy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdb95dQ8z2yLB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:04:05 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpgeLA2vRwGQUY6j4XUwNBAV5Zna+gkvYc9tLs1bLNrCUDeq1QB5GCuqNMEDqzeih3vp/kPLwcS2qOQt+CbKo8NHmPMxaWuhOayuf/Hww5khPo3fdNEQECTOnv/FVfruZ5LLZkx59mPDzV5ttsJIb9NNseX4f6f+uEIjgiaJhHzy71aHgVkDWZL6ZKernItfhIJ6H27g8dPrGIPYl3UOP7xJkpQ8C1ljENj46iHGPsROpqjyglKqwHx0j7YKGnWy0A+6sYMhIF1Sd7It9nk7PKe/uegN0drgvIFKq5jhJK2AFtTowe0CQjptCh7dRjz3IaQxQnq/3koILdF0MxA2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVjCB/sve+5iQSof275/7DdimURZhltIc6Gxwubhw+A=;
 b=dhtGIppIi6X5T5KmO6cL/CJWDXeswjy9hPtW1tf94RkexmeE9NHRlvo8tweoA9TR7YCfFYLxhXguLAQRESW7xJ44uCoQeZTMwRMQqVf9y4GODTDhDnX0boFqWiCRdqZfiDGTuY/8qOe2gMU5gMXAJtJsRsftauCpSBtpWvzXrsGPycZ2aXBUXoC8FgO2ojRigM8bKp4lG9bfK21zgrg9/CgIONwOS2tPgmUuHt93YoDefq53/wYcGzfQGZOZVFMlZQixuDoiq8yFGSmkY1Z+XcN4cMwejhbf+vsLKshekaJmnS3pHc8hxjq8X4yD+PTccPxQwNtNKYskB1kyRSmbxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVjCB/sve+5iQSof275/7DdimURZhltIc6Gxwubhw+A=;
 b=PK3NlgDyc9MYO9DWoCSHg5Qh4uLp5o5+o/kBwjAlQqtOGa54dXeMG+MG1n4C8gQZ3v0W+gSMio+O4z3HdINe5jwWEkZBctaAztr4l37LilwZqqvE7z67vxUSAovent9pQkThmXzGZStGtDUcAqDpEg09+NeMRvNTLp3xvhSLecSF1I1N9v5ZfwZkQGirssZH0LRoJBuSm9BLN7BfRrZmZGhbVIlpSkBRvEtl/JrVe9WepeGSkjnkQuWg9Ykccj5wDdcs41CHE+w9V4cbKvCadfj2zs7IarX1UktgiKPkDlRp3IV4Nlv1pFsR2EcAoLDD+Mu/QH3dfKybJJ5yVCGu1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:03:47 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:03:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 11/15] net: dsa: netc: add phylink MAC operations
Date: Wed, 13 May 2026 11:04:50 +0800
Message-Id: <20260513030454.1666570-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513030454.1666570-1-wei.fang@nxp.com>
References: <20260513030454.1666570-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GV1PR04MB11525:EE_
X-MS-Office365-Filtering-Correlation-Id: 82bdfefc-c837-4697-3999-08deb09c4068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|22082099003|3023799003|11063799003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	zKlxHPvdHHFfrx4aYxiL2JBxNKm/PaeIpIg4obwMY9MhQWVCMh/f8jxobpm2TEe+EXQYoGfHq2LbGrH8o/nXvd5rLFV3n5uDIayUEnnG8khVDGbv1DHw7bbeJ1IYroO6Quvwr/C63j6usZpCOYf35uHKwXlkFFiIZw+QDyPb16ynirMjArPLMwo+L5wNm/1EyRgPFxushJJXqhFFSnwA6Fydp3TBdDIetGoxUp7PNqiJOI2Id9o6HrZM67QWOruBswAU6B+t6WHk6sdhFsl7kdK6C8PV+F0JWp0IG+ungmCk2BMyT9hsBmQ1VzZZKmXLH+Q8zOhGYw9zXyDySPaThlrQ/Tm0T8cLOjkRH43UyD7KRvHAxdxWwkfA2+ER3HiCC7afUzMlCmCH3hYRpv5RMJlzp5mjoo+gUVQCMcIywuK5XswFR6NEC0oLPLuI/pCb+JfpH7+Rj9bkv3RnNHAP39qCgcsyL+6tt+hm42nv/PuMkXO53YWdsp8Z4DsRopvw0zyYlB+iEI68zqYP805YASSMaaHdaEBLzgVDSBE7rKC813If099Q8GFSkGHJpAIsJA8ulh1TJS8dkgBmmIs6jdsJ44rvoHBLwvbYVXwUlIpIf79awehXkjgReJbtestEUjAuW5D78AB9cVgAV6B5KN1Rt1+BsDH1GiCSkxBIacYxkaRcsF5FfVnYmaNCC2hXESKUG5iXe1o/FA55/UEiZkQrg032TiHBPpcOR5GqnsRst5yeAupGQdljUriyN4TfIEGd5lDx1M5deuDeOScnGg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(3023799003)(11063799003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZymMa9VJirv1DT2r9PQ22Rcx9fltIH99Q3UoQ0eg2mc62T1nzoEsFMIjhTms?=
 =?us-ascii?Q?8NzFbQtK2Ka0Z7bDWzhIVS6WFEu8xbfkM8TOMGwqnM5reMNd4Z4WGqr61o4A?=
 =?us-ascii?Q?MN0U58xyzMHCeW5KvU82aYXw5Kr7TCNs0Q1dP0KMW6tvu3m+sMomAk2XEAEU?=
 =?us-ascii?Q?Tli+xZXOBpqt3AfKrxsYvKu1z5OrG+0PhCtkuK2ExUcp/RoSM9gUokiU67sT?=
 =?us-ascii?Q?KxjMC0FnhWyq7I/pryzsVpaSaXkRvCAke6CvW33t5+oX7xxgy+QwVBWZLYoi?=
 =?us-ascii?Q?2oAnwIvuC/gaXPfCb/76Kmu7I7gI0rsa3vfOEXFZZx1+7EwWpnpEYT3MWg7q?=
 =?us-ascii?Q?3h2n8rCnukHCUBmNa/vLM+e5YexqgB8JMY2/s62C319OlcrLvH1m4yrcLM3U?=
 =?us-ascii?Q?v7LwiD60EegwZwKFb8HjDy/jZkX5/x8cFcHb911p0L8cQB4Yv0RcgGgHTbzr?=
 =?us-ascii?Q?I0LgwC6rBgiLLQgs9Cyoh06lHlCbBIVtv23wR31tQVVOWjtVLfV4jtR7tfW5?=
 =?us-ascii?Q?SkizPl4KaAKdLJ0pmfoKC9D2IHsmE8IuOcgLvSCQvVdGLxCuRn8YjPrQrz/v?=
 =?us-ascii?Q?WLmtdj3A5fdyc3TaCQRgX3je91So1wNF9p/RWR65BNgP1uBwtlBfpryuxyFk?=
 =?us-ascii?Q?z3ZMT/aVavAiZUAffVN8vS8h/Gj+zVcwcDolVIT5IbINcMyPhB0BI47LnwAM?=
 =?us-ascii?Q?6peHpXIZn6pm5z1ZDbm4rQ8jalTbZPw7FY3X8U6yldw+rtmoFm60qu7VIECv?=
 =?us-ascii?Q?4vtqo4Pd74BPTporTUQsyCyDQVbtIMY0KeNEE8os5XMlaVlR+/J+aH9oG7j9?=
 =?us-ascii?Q?ymjBtFEUcYBBhR14fUlEGzzYLrHbTNSQmAzlbUcf9Q7vdE2SJm1Ke7oLr4O1?=
 =?us-ascii?Q?vfxGiNb6pAj+EUf2AQ2vLbrXrLcpLFjGspwGJ2h6jYz6mmP/1YuCIBdVE0nu?=
 =?us-ascii?Q?rS9qmqUxXTcOHe1kY1KaBf3ttl+8Gxe7vJlkePN01TdnNTAl3VrDuCHoUf/0?=
 =?us-ascii?Q?et9QCai/hQLLIXhEN5gtqo9/2u0c6zKM37n8MJTxSh86hehayoAidSaBvhQF?=
 =?us-ascii?Q?goxhxztagaBBN0UXjIUqVxiobNcSwyjH1RXBZLynmRE/a3T1LLGZoAJ0lIQg?=
 =?us-ascii?Q?DCYcDh9iwJJb/+MZO0ccFxVkfqlyHHyWVqWS3PE5v/21/64I1cSqrdvKWytS?=
 =?us-ascii?Q?ynIJirgwh7EeMDSOHfBxMxo7+AGtw6hbIOGlG9yjZjujqvrvHT4lVe5enh/7?=
 =?us-ascii?Q?T7Ax7amcbPbUw1ih7RcWuYZxhxFYwtM2wWadjkdUcED/aCgtT1LQ6dAdxieS?=
 =?us-ascii?Q?9ZVOj+h6dz4hGYyuJcIjcDPBlHThAOxNUv4E2GF3IaDy/o/FmhwkfC2StAXO?=
 =?us-ascii?Q?YZ2IWidOQh6tjPoQw19OOFOzBZeWwYCa3GOfiOJASJEfK42RXgIZm3JZeYlR?=
 =?us-ascii?Q?6Z1ZF9DMqgy4NgnimY9NYghSJlJhKVCkp/RdXWQbqxxRqeePVtRBS7hE/i3G?=
 =?us-ascii?Q?vCyrIIaaWvETO6+Zb03z3pjrECnOtJKwx29paSq2beUdhMZGkeCr9dcQoOv7?=
 =?us-ascii?Q?3/S2doOXPFprF/lmXbeBxqC6ei1+YENtWlo4EdUNHn7lv2mQxB+XjQHoSRew?=
 =?us-ascii?Q?m9JcGS5ip0qKX/uit+scWT/Lb7nT2VBzDDwaGSWcH6+xBVfSZEHg8jxSZj7e?=
 =?us-ascii?Q?xXW6GATtNKGbMmFVA1phB60M8DYv+8sBFvUSwh5NOJzwmzkm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bdfefc-c837-4697-3999-08deb09c4068
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:03:47.6106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFLM5ORCKqw9MZiS2m9IWM/C43N3eIvFC3jI/CoZnW/NQPT9/OXYaBj198vxuqmD+n5gVCCH+Z/OF5DhaCocew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525

Different versions of NETC switches have different numbers of ports and
MAC capabilities. Add .phylink_get_caps() to struct netc_switch_info,
allowing each NETC switch version to implement its own callback for
obtaining MAC capabilities.

Implement the phylink_mac_ops callbacks: .mac_config(), .mac_link_up(),
and .mac_link_down(). Note that flow-control configuration is not yet
supported in .mac_link_up(), but will be implemented in a subsequent
patch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/dsa/netc/netc_main.c      | 247 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c  |  38 ++++
 drivers/net/dsa/netc/netc_switch.h    |   4 +
 drivers/net/dsa/netc/netc_switch_hw.h |  26 +++
 4 files changed, 315 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 8e3a3230226c..2141b3aa96b7 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -43,6 +43,30 @@ static void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
 		netc_port_wr(np, reg + NETC_PMAC_OFFSET, val);
 }
 
+/* netc_mac_port_rmw() is used to synchronize the configurations of eMAC
+ * and pMAC to maintain consistency. This function should not be used if
+ * differentiated settings are required.
+ */
+static void netc_mac_port_rmw(struct netc_port *np, u32 reg,
+			      u32 mask, u32 val)
+{
+	u32 old, new;
+
+	if (is_netc_pseudo_port(np))
+		return;
+
+	WARN_ON((mask | val) != mask);
+
+	old = netc_port_rd(np, reg);
+	new = (old & ~mask) | val;
+	if (new == old)
+		return;
+
+	netc_port_wr(np, reg, new);
+	if (np->caps.pmac)
+		netc_port_wr(np, reg + NETC_PMAC_OFFSET, new);
+}
+
 static void netc_port_get_capability(struct netc_port *np)
 {
 	u32 val;
@@ -507,10 +531,232 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
 	priv->revision = FIELD_GET(IPBRR0_IP_REV, val);
 }
 
+static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
+				  struct phylink_config *config)
+{
+	struct netc_switch *priv = ds->priv;
+
+	priv->info->phylink_get_caps(port, config);
+}
+
+static void netc_port_set_mac_mode(struct netc_port *np,
+				   unsigned int mode,
+				   phy_interface_t phy_mode)
+{
+	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII;
+	u32 val = 0;
+
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val |= IFMODE_RGMII;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		val |= IFMODE_RMII;
+		break;
+	case PHY_INTERFACE_MODE_REVMII:
+		val |= PM_IF_MODE_REVMII;
+		fallthrough;
+	case PHY_INTERFACE_MODE_MII:
+		val |= IFMODE_MII;
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		val |= IFMODE_SGMII;
+		break;
+	default:
+		break;
+	}
+
+	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
+}
+
+static void netc_mac_config(struct phylink_config *config, unsigned int mode,
+			    const struct phylink_link_state *state)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+
+	netc_port_set_mac_mode(NETC_PORT(dp->ds, dp->index), mode,
+			       state->interface);
+}
+
+static void netc_port_set_speed(struct netc_port *np, int speed)
+{
+	netc_port_rmw(np, NETC_PCR, PCR_PSPEED, PSPEED_SET_VAL(speed));
+}
+
+static void netc_port_set_rgmii_mac(struct netc_port *np,
+				    int speed, int duplex)
+{
+	u32 mask, val;
+
+	mask = PM_IF_MODE_SSP | PM_IF_MODE_HD | PM_IF_MODE_M10;
+
+	switch (speed) {
+	default:
+	case SPEED_1000:
+		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_1G);
+		break;
+	case SPEED_100:
+		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_100M);
+		break;
+	case SPEED_10:
+		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_10M);
+		break;
+	}
+
+	if (duplex != DUPLEX_FULL)
+		val |= PM_IF_MODE_HD;
+
+	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
+}
+
+static void netc_port_set_rmii_mii_mac(struct netc_port *np,
+				       int speed, int duplex)
+{
+	u32 mask, val = 0;
+
+	mask = PM_IF_MODE_SSP | PM_IF_MODE_HD | PM_IF_MODE_M10;
+
+	if (speed == SPEED_10)
+		val |= PM_IF_MODE_M10;
+
+	if (duplex != DUPLEX_FULL)
+		val |= PM_IF_MODE_HD;
+
+	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
+}
+
+static void netc_port_mac_rx_enable(struct netc_port *np)
+{
+	netc_port_rmw(np, NETC_POR, POR_RXDIS, 0);
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN,
+			  PM_CMD_CFG_RX_EN);
+}
+
+static void netc_port_wait_rx_empty(struct netc_port *np, int mac)
+{
+	u32 val;
+
+	/* PM_IEVENT_RX_EMPTY is a read-only bit, it is automatically set by
+	 * hardware if RX FIFO is empty and no RX packet receive in process.
+	 * And it is automatically cleared if RX FIFO is not empty or RX
+	 * packet receive in process.
+	 */
+	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_RX_EMPTY,
+			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
+		dev_warn(np->switch_priv->dev,
+			 "swp%d MAC%d: RX is not idle\n", np->dp->index, mac);
+}
+
+static void netc_port_mac_rx_graceful_stop(struct netc_port *np)
+{
+	u32 val;
+
+	if (is_netc_pseudo_port(np))
+		goto rx_disable;
+
+	if (np->caps.pmac) {
+		netc_port_rmw(np, NETC_PM_CMD_CFG(1), PM_CMD_CFG_RX_EN, 0);
+		netc_port_wait_rx_empty(np, 1);
+	}
+
+	netc_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN, 0);
+	netc_port_wait_rx_empty(np, 0);
+
+	if (read_poll_timeout(netc_port_rd, val, !(val & PSR_RX_BUSY),
+			      100, 10000, false, np, NETC_PSR))
+		dev_warn(np->switch_priv->dev, "swp%d RX is busy\n",
+			 np->dp->index);
+
+rx_disable:
+	netc_port_rmw(np, NETC_POR, POR_RXDIS, POR_RXDIS);
+}
+
+static void netc_port_mac_tx_enable(struct netc_port *np)
+{
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_TX_EN,
+			  PM_CMD_CFG_TX_EN);
+	netc_port_rmw(np, NETC_POR, POR_TXDIS, 0);
+}
+
+static void netc_port_wait_tx_empty(struct netc_port *np, int mac)
+{
+	u32 val;
+
+	/* PM_IEVENT_TX_EMPTY is a read-only bit, it is automatically set by
+	 * hardware if TX FIFO is empty. And it is automatically cleared if
+	 * TX FIFO is not empty.
+	 */
+	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_TX_EMPTY,
+			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
+		dev_warn(np->switch_priv->dev,
+			 "swp%d MAC%d: TX FIFO is not empty\n",
+			 np->dp->index, mac);
+}
+
+static void netc_port_mac_tx_graceful_stop(struct netc_port *np)
+{
+	netc_port_rmw(np, NETC_POR, POR_TXDIS, POR_TXDIS);
+
+	if (is_netc_pseudo_port(np))
+		return;
+
+	netc_port_wait_tx_empty(np, 0);
+	if (np->caps.pmac)
+		netc_port_wait_tx_empty(np, 1);
+
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_TX_EN, 0);
+}
+
+static void netc_mac_link_up(struct phylink_config *config,
+			     struct phy_device *phy, unsigned int mode,
+			     phy_interface_t interface, int speed,
+			     int duplex, bool tx_pause, bool rx_pause)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct netc_port *np;
+
+	np = NETC_PORT(dp->ds, dp->index);
+	netc_port_set_speed(np, speed);
+
+	if (phy_interface_mode_is_rgmii(interface))
+		netc_port_set_rgmii_mac(np, speed, duplex);
+
+	if (interface == PHY_INTERFACE_MODE_RMII ||
+	    interface == PHY_INTERFACE_MODE_REVMII ||
+	    interface == PHY_INTERFACE_MODE_MII)
+		netc_port_set_rmii_mii_mac(np, speed, duplex);
+
+	netc_port_mac_tx_enable(np);
+	netc_port_mac_rx_enable(np);
+}
+
+static void netc_mac_link_down(struct phylink_config *config,
+			       unsigned int mode,
+			       phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct netc_port *np;
+
+	np = NETC_PORT(dp->ds, dp->index);
+	netc_port_mac_rx_graceful_stop(np);
+	netc_port_mac_tx_graceful_stop(np);
+}
+
+static const struct phylink_mac_ops netc_phylink_mac_ops = {
+	.mac_config		= netc_mac_config,
+	.mac_link_up		= netc_mac_link_up,
+	.mac_link_down		= netc_mac_link_down,
+};
+
 static const struct dsa_switch_ops netc_switch_ops = {
 	.get_tag_protocol		= netc_get_tag_protocol,
 	.setup				= netc_setup,
 	.teardown			= netc_teardown,
+	.phylink_get_caps		= netc_phylink_get_caps,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
@@ -549,6 +795,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->num_ports = priv->info->num_ports;
 	ds->num_tx_queues = NETC_TC_NUM;
 	ds->ops = &netc_switch_ops;
+	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->priv = priv;
 	priv->ds = ds;
 
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
index abd599ea9c8d..bb4f92d238cb 100644
--- a/drivers/net/dsa/netc/netc_platform.c
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -11,8 +11,46 @@ struct netc_switch_platform {
 	const struct netc_switch_info *info;
 };
 
+static void imx94_switch_phylink_get_caps(int port,
+					  struct phylink_config *config)
+{
+	config->mac_capabilities = MAC_1000FD;
+
+	switch (port) {
+	case 0 ... 1:
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  config->supported_interfaces);
+		config->mac_capabilities |= MAC_2500FD;
+		fallthrough;
+	case 2:
+		config->mac_capabilities |= MAC_10 | MAC_100;
+		__set_bit(PHY_INTERFACE_MODE_MII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_RMII,
+			  config->supported_interfaces);
+		/* Port 0 and 1 do not support REVMII */
+		if (port == 2)
+			__set_bit(PHY_INTERFACE_MODE_REVMII,
+				  config->supported_interfaces);
+
+		phy_interface_set_rgmii(config->supported_interfaces);
+		break;
+	case 3: /* CPU port */
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+		config->mac_capabilities |= MAC_10FD | MAC_100FD |
+					    MAC_2500FD;
+		break;
+	default:
+		break;
+	}
+}
+
 static const struct netc_switch_info imx94_info = {
 	.num_ports = 4,
+	.phylink_get_caps = imx94_switch_phylink_get_caps,
 };
 
 static const struct netc_switch_platform netc_platforms[] = {
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index a6d36dcebc6d..ac9743da2a1e 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -35,6 +35,7 @@ struct netc_switch;
 
 struct netc_switch_info {
 	u32 num_ports;
+	void (*phylink_get_caps)(int port, struct phylink_config *config);
 };
 
 struct netc_port_caps {
@@ -70,6 +71,9 @@ struct netc_switch {
 	struct ntmp_user ntmp;
 };
 
+#define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
+#define NETC_PORT(ds, port_id)		(NETC_PRIV(ds)->ports[(port_id)])
+
 /* Write/Read Switch base registers */
 #define netc_base_rd(r, o)		netc_read((r)->base + (o))
 #define netc_base_wr(r, o, v)		netc_write((r)->base + (o), v)
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 0419f7f9207e..7d9afb493053 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -67,6 +67,14 @@
 #define  PQOSMR_VQMP			GENMASK(19, 16)
 #define  PQOSMR_QVMP			GENMASK(23, 20)
 
+#define NETC_POR			0x100
+#define  POR_TXDIS			BIT(0)
+#define  POR_RXDIS			BIT(1)
+
+#define NETC_PSR			0x104
+#define  PSR_TX_BUSY			BIT(0)
+#define  PSR_RX_BUSY			BIT(1)
+
 #define NETC_PTCTMSDUR(a)		(0x208 + (a) * 0x20)
 #define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
 #define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
@@ -123,6 +131,24 @@ enum netc_mfo {
 #define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
 #define  PM_MAXFRAM			GENMASK(15, 0)
 
+#define NETC_PM_IEVENT(a)		(0x1040 + (a) * 0x400)
+#define  PM_IEVENT_TX_EMPTY		BIT(5)
+#define  PM_IEVENT_RX_EMPTY		BIT(6)
+
+#define NETC_PM_IF_MODE(a)		(0x1300 + (a) * 0x400)
+#define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
+#define   IFMODE_MII			1
+#define   IFMODE_RMII			3
+#define   IFMODE_RGMII			4
+#define   IFMODE_SGMII			5
+#define  PM_IF_MODE_REVMII		BIT(3)
+#define  PM_IF_MODE_M10			BIT(4)
+#define  PM_IF_MODE_HD			BIT(6)
+#define  PM_IF_MODE_SSP			GENMASK(14, 13)
+#define   SSP_100M			0
+#define   SSP_10M			1
+#define   SSP_1G			2
+
 #define NETC_PEMDIOCR			0x1c00
 #define NETC_EMDIO_BASE			NETC_PEMDIOCR
 
-- 
2.34.1


