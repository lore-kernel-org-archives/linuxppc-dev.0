Return-Path: <linuxppc-dev+bounces-22587-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F046CD98D8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 21:09:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcXFk68Hsz2yd7;
	Sat, 13 Jun 2026 07:09:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781298570;
	cv=pass; b=aFUcdmjw0SVwIfHMPgbvA93aUGmm43w8/buZ1RXRZXWUDK1zsUgrB5UyAwcMzoSphX2yEU8BWEloNNFp6m+RpKFOjpbIW7H5JMjaWor28uWHlKdmI/6/cWkb1u47SMwKAPZcl8pBtt8jt+OpUsui4O/uWAxa+955NCHmybjKy9bqlOlCWG/m3Yeig+Ns041LzDb+Ns9O6ilzxRFWJKmo+lhKbdxHq+lh9ljSHPreYMok0I+0ABxi6PdM0iqKb+h5iYn7vc9FSVIS5KhegKejksAEtLwa7HQ2aO+63RAU6G3UFZYki6YeDgPZv8KYilf7PabtV45C6boe71RCIYU18A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781298570; c=relaxed/relaxed;
	bh=NVyQNRw9ksSrl8J2wEydSxjUoafIll294orIK59SxhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HI0pZj/KEToz3QMPib4M2//RbWvx0L1QaiXQJZo0eYjUkupiQrx2MPG+eHyx8I7RLvph36QrACSqOWwvXZZSTcbm9hO4p5SkRA0zlBcAPVEpe++dw70HVHbu39XYuvdviJIpJGY5rppYSJbxDFm5QtD6zoS0A+BQFTGYPIkoNd/jeLaHA1dbtywl8S33m5XOCaBDP5IT/uWz7LEClW0S2PYdHtb/JuXDu81fE84vl6s9qjSCq4MjanLZQ0TAYvDejYYg4gEjM7UAVO2ly/0IMKtShUE3RAm1OZv540M9k5cMWVHhuPkHZ2BQ3WQbVMWf3Gm56Ut6W1uh3AQwVzgYfw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=A/uIK27k; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=A/uIK27k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcXFj64t3z2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 07:09:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSfddlFAfQAfKFLUtjTCHP6cNU3WRM2df1qtu4neIo5IVm6KeWNnp5I6SFAiOtvtqmM+vV6I/i3fGErZy/hP2/T/vvwCuTIB4EbI0BVsKyYtemyrtbuleJh297HoegKadbdVtxJmB6RqowoI+vrdGmeINkTBywR9KJVtp8tIQv4Dmn1qGO9hZwAYKk70RlN1kb3uMwZCzpy214/oNskwtfExnU4JNg8XOPpVlBIs6tNTteI4FIAv0NKjMghUrmvnysr5MT5sq1+RU85lKKYGCsR+Es+4ORN9L84q86d2JHPlF0xJspl7eYJN0Fa79WKN3nkuftXHCfALEMrugUspSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVyQNRw9ksSrl8J2wEydSxjUoafIll294orIK59SxhU=;
 b=C4lnLElr6Tj74xUKZBC7mKSWZBhZw9EkYpjMljf0EMJKfeGXNZ9hFWW8Zz8eu8nvZcKc7bbEvuwO7D/z7FlpEo44E7dqQrfWWd4htiaD8OEGAkQqmDQqCruRsaJWdlUNlKrN3J/3GztlIL+DdABUt7XNClBKtMrxGJVlMlLnT73meF1viQSKFaJMxjgOvO3ZIawRv2swNmW/uRIFFBOiB4ArMQpOXPLZo8W4sZ99DiwgOw5JBWLKq1fD7lwjTL4tjiQuPp1q/6tHQfGbz5FcZMVcbztPyGXnDkrvke284iu2Ppda/TVuls4nW3b3k2lrL+lqqMMn7tDu+EqHXe8JLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVyQNRw9ksSrl8J2wEydSxjUoafIll294orIK59SxhU=;
 b=A/uIK27kmNjrlwCcezzPkqXIEnFHTjaGwn5rwuYtm3/eLlV9pz7nD4ERy6E2tw/UnfnNPN2R8xqC87x5Br92un30b6Al7eelb0aBiNMCwfYfwOiQbItdp3/jXdRQ7gys7p1Z9SERYA861z8kIXR7QmvyTOJobEo8yTmxcYqKsouH1knGSG7yDt7L2izDrbSsxIKJ29cPinDSdT86DZSuOl+8NtKQ1GTk0X2GvkBWMMFx9uvTaMVTz2c4+tv08O9W/QQQ5/8CKyY6XKbV13OWt6s9dt5IRgRxKjrnpk1NUcbuoRzO22P5RSFcjbn38BprC/lksOAEIY2qsXOrTjt9Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB10969.eurprd04.prod.outlook.com (2603:10a6:150:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 21:09:05 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Fri, 12 Jun 2026
 21:09:05 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 phy-next 1/8] soc: fsl: guts: use a macro to encode the DCFG CCSR space
Date: Sat, 13 Jun 2026 00:08:52 +0300
Message-Id: <20260612210859.266759-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612210859.266759-1-vladimir.oltean@nxp.com>
References: <20260612210859.266759-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0002.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::9) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB10969:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b9d0a8-4f17-417d-8130-08dec8c6d5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|10070799003|1800799024|366016|7416014|376014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5UKT8ghsLEZmH44rGCgTWwfT/coOIOfG55MDutRGUT3FGl6V1WF/IX9Q33wwyCGNUxVB/vkPZs/uqLZ5IfCiZWFe9BUFNNtJT8Z3IYXyW7cRTPe6spM6k7o2t/4RlWv0ZDNYnL+VV0G+Gwaub0CcxXjbK4CDYGMywXtutuBHJuzrgiB6+vRN5DBseIimJyH2FSsgFfHTFwZoPrUb3PKoZ0eqbxh3CcxwxtP0sLkoir0IYT42JIneccFogGwBRhXZDUJ4KklDLQinTSjSnaruv5H7h8ZGy0IJBpj/9zYjHBMlEO//25IEvhRit8HoxSgpZhuBD2kjbz8DZHN0xxinDeY5G1J3VoOXNAfs0bfMyho/lGCO7TIeWoMCMvso1s9GrVg4+0JRDFmuRmkgyaniubyibgLW4m7P/Qrwzf+cSFSnwTu3n6Btczu3qmqkSUlU7lZP575fDzwlZlGh4tA55Fv6N4se8bjJA+ZJ8c6Gfv5iCaBZcUhJQAjVSQCMkimOKtOwgJE0I10W/9CAVb+sgw36D07/uRvP1GReRqIQSYN9pRUGHzpCWDaKYnUcDJfJo7R1puGw3cAWx+CdKVKfpRw+cGv1Rh93MPzKbXbC3AsNqF9klVwBfVUhMzNMmroJkQZFJVOyZRF54EN/cgagKYZmUMMM3crMjdHhpgQRI+v1UUU94S75SpDTnprFJV5N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(10070799003)(1800799024)(366016)(7416014)(376014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sdm+FdeLWyAAzh5XENIyRGpGxJOkAYedqtn5wZ5qEQ3c0977Fc6DPh3+zhjw?=
 =?us-ascii?Q?fNeqlkepGgupjBXnmEAIec0zfC5RpXpSG1+QvbYfY/OwyuXruQJ/j4FJBCQ1?=
 =?us-ascii?Q?3yesZeQzQG8+vNFhaP8EeAvg1SoPg/EHjRnukK5RN4d/kMosyHI8F+DGnpVn?=
 =?us-ascii?Q?CmA1MEgoc9lMY7D17YzkuSA/odC1piGTF8Xux9cl1g5Mo3czLfVu7BAH+NcJ?=
 =?us-ascii?Q?5m1nsv5o3WI2awU9qtk608AAne7ec9VmOjO7utLKAeDtSfVbS1jOFMbdAHJ5?=
 =?us-ascii?Q?S93gjmxOkQOnJRMqWoWCwZo9N2WQB8uxoDkeUFtS7LOn2TnJRqP2RAMoLR73?=
 =?us-ascii?Q?ZOzhuqsGNmzXFnVLGoe30fqzxMDx491U8WxSZofNjelPfJuVbAR2uBY/5uRO?=
 =?us-ascii?Q?gHsz3NV/a4SSlex2BGg1a2ABJTAjNW/e/HB6SekU+709Ktm6J5KxXG7EXAjA?=
 =?us-ascii?Q?dc1wVR8MMORqDCAQ4hEtLAlEfZoRniX1KcxOd7Ynllo1U7Ejs00Rcpno0cLJ?=
 =?us-ascii?Q?QQ1PrgqeQBlrPEl8ll/vjmV4wmSSkn0dwkUE5ZA2EDErK0RdShj+Mue5Xsjv?=
 =?us-ascii?Q?5XEK3198SjpVxFHtrIaSMcMCdMayg2NPooxhIzmoabs17e0pqv2z3EfVyQOW?=
 =?us-ascii?Q?44qSvAIR5nhjCj+0Eo7TWTpCUYUijMWkAuqzuY1XBNpoRRPahH21vi5Wmmb0?=
 =?us-ascii?Q?2k1ZDDHW9470fd+mzYijuWATf2gm+OQlmdvc70ocnHguEmt0dPT0paGf1gFg?=
 =?us-ascii?Q?WkC8ByHc0TmQxJrK5AiRVDiExRy7Itjl5+oySw3tvffc/4kWE6p+eIDUKvWi?=
 =?us-ascii?Q?2J3hKCYWTuN8HRIeqn9KN0evQig2fqEAbicEHQA7/uz6kfq1sjvngCtK8G9b?=
 =?us-ascii?Q?7rjGA0fk4n3eLG2wm7X77ogixl7u62p4Ttog8Kj7dugM9AEiHONyL8M/Ohxo?=
 =?us-ascii?Q?4FwCCv9TshAGopuylgYMfIV7aQPy0lrJliJj2M7H2WHx5Z9MNJi2YisIcRxx?=
 =?us-ascii?Q?LDDrXv5ZQziwlmKQ9OS7Smv6hYapsw5bI0E9bsobFO3BiPrnmay0wQrHSWZs?=
 =?us-ascii?Q?akg+q6277wGVpl3HVQQ5OLwdsbQPGjmtX1IQsZzXUg/fDaGv9FlEG7lBY7rC?=
 =?us-ascii?Q?8w3GazkD6l/1u6upqxrhgxKU+sOTj0Tseoi19mb8xVko9UT3NYWhN6GQzCLk?=
 =?us-ascii?Q?C2HPJNoq8Nrns7EUdlT3BSlf7HaiolFTUyKGXCr9l0VwnPTj+z7GxvlKCtQx?=
 =?us-ascii?Q?h/G9zShaftvuPUd0m6ftzFdnVeiQ+8hU1gH5Ihs+mn2ZoJCKlglmWjTJ9T01?=
 =?us-ascii?Q?ndWats9gG/+kUtndekXhTXz9zMsUZnXXAD4KQoK1HAX1MmWRK7iYVInNTz5O?=
 =?us-ascii?Q?y+hy3xKPHAhZihBonorgrqlof5vy5m2NPA9L4B5UH/upA6VbK+eSWqHLaz78?=
 =?us-ascii?Q?y/MqFBRdCnndPftPylPG4H/S+bIGlZeGoZiAt57bnUv0PTyeo6Jpemnmmh5D?=
 =?us-ascii?Q?ePTuOAVZcxAbwZLvQyZuXk7Gy78EqJmqGxihfDJv+Td6kOxKgTDxUBBmx3iM?=
 =?us-ascii?Q?mZJiCZaWddGscjnYyuTLu0Gcu00fOWp3cGHe3UpLdzV219ZsWN+kTqG4+tw8?=
 =?us-ascii?Q?/raB9oQiJfKcs3WLRofFL8O+Ckz5vNP/sw5sItdWQaCfGHVGZRGh8Rk3wpZ5?=
 =?us-ascii?Q?Wcim0kpyxuFtXw3dBUoLjq4N0WbRinx/J3K3q2v8yZknm0q3fm1wxcljnnd8?=
 =?us-ascii?Q?HOA+d0QIdYOFSY/ArL7yGlDqql+qlMgAlQRoYyOT0OVAuD++pjgR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b9d0a8-4f17-417d-8130-08dec8c6d5d2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 21:09:05.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lI1lXC2Qvba8cTQg3etSEYe2bz97LR7tkLG5GxgjmPaUVhE+a0NEciO/K0WxRCYs0J7q3RXrxF1MXCNAmkvO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10969

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Instead of using a hardcoded value when iomapping the DCFG CCSR space,
add a new macro for it. The code will be easier to follow this way,
especially when we add support for the DCFG DCSR space as well.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none
---
 drivers/soc/fsl/guts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 9bee7baec2b9..f87ee47c1503 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -14,6 +14,8 @@
 #include <linux/platform_device.h>
 #include <linux/fsl/guts.h>
 
+#define DCFG_CCSR	0
+
 struct fsl_soc_die_attr {
 	char	*die;
 	u32	svr;
@@ -197,7 +199,7 @@ static int __init fsl_guts_init(void)
 		return 0;
 	soc_data = match->data;
 
-	regs = of_iomap(np, 0);
+	regs = of_iomap(np, DCFG_CCSR);
 	if (!regs) {
 		of_node_put(np);
 		return -ENOMEM;
-- 
2.34.1


