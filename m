Return-Path: <linuxppc-dev+bounces-22594-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EADCD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 21:10:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcXFv3ZNNz3byt;
	Sat, 13 Jun 2026 07:09:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781298579;
	cv=pass; b=DJd5sAUHcR7x+v81NUg+UNwh2Fe0SmwPKZyI4BVUsISzwX7hhQZT/G+CHAxeZvnaGP6ZtgQChSi+6n7voQtJZsgkpH5XAiwck3lFROp+vADueJA/kJcoU/Cz3B5XnDdHg03cZcjqqehPe+wH8QIHphDDHg8x08rPlwVnhUbMYsS4oBQhAqUrtv4LWQUsF6JcRGVZV1r5Nqr2x4mgb0lEYqc/XEouAbUMubRE9OpuyIFCcMKctzfewRAgExT9WbrTqU7l9/TPufwLJEwtQ4AwpSVwUYVto375TkWMajoY0gCbf3vcKxPvY52OFXq9FbvQFXRxAXPQ7cntTsKX/TssQg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781298579; c=relaxed/relaxed;
	bh=DIa34YuU0nWNs4TJA608MkYEcod2miG5Uw+BczN0oUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XxzTO/esy1jY2qe06vq16uS3Ney6tWKiQhrqy+vtL2JBXEQG/fi1X7X4/4CgiogrIO/8882fvGKeRLLKKsI2l7nN3UYFns0PF7KhoLPwW0tGcLo+mIQuYd0TV+aMpF41mAUSE+tT+qb2W7VKAzlrB28wL8mbTn8T6EMP2frgzi6bbIdj6tYiP609dwLLRRdC0csaZlGS55xRFC+o2cIvksII+eDBMJ/w3HkmWKoxdclRclsaOC/2CXX379nLAqF7nm/bSUYThvZ8osItPuKy08IpldCnXxbDp3tn2V3InoFt3n49uCj29nYL6hWr0vGBbL8TyFlAp9rtpbB181pY0w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=K4Snf234; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=K4Snf234;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcXFs333Hz3c1w
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 07:09:37 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfD8Tw0NcuyPAKM6/4yacYbTIbh4CRDWvd/Xswl9TiexqGwnpSvD0H168ydPOlWMNv3FoFL/oiVd0Ggjb5Pg2Jk2IyFT25sSj/LD1gDdKe/hOikbpxi5bt216p/mI23+CJafX2R+5cbsdme8u1g5vFZHCuij6vgBrzmd/kJlHAu93KiDJiSG80QdRDGXDyPSUbNP9CGM3/Jlk5QD7nSLsQgQNmnGchxvXXYfmbUs+czW3m9AYs9nN94RcvZ90ReSwCt1bkVBBvMhZRXkoWjoEUaLnOWLSqYeW/3Ep+SG9Y6afL7d7+Dd/ZqgpKsYKYXpFUAi5+TGXmsrxrhBrIiHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIa34YuU0nWNs4TJA608MkYEcod2miG5Uw+BczN0oUw=;
 b=MemDtJ3c09kEqQtqHwJ1JxmFhlWX09dZ3hBBfB2cGIsSLPi2hMKmIruTVAEXY4mha4SeVlRSl++e1TkG9wCcDk89+ye3OMhjUeLLo7tW3Mdo45ALDhAwAcm8AKHlU9fpRwzW1a3JBR3beJR5DgrT+Uk/+yLZilHCg8Zbp/ujtVAmKGKoBQG5q5dXAzJqwm52DbbchLsVhNTKUBvkEp+ceuu7oCyc+KtfgQ1spgpo7xo9ltk2OmPMPRk7aLlsgvw0Nonc/z3krwqNJO7pnh7Z4NcAozs9j8muLXuteanHSiosPH6P+mdyU/KS2hnOOfwH/VvRkbQWr+0gS9Uclv5suA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIa34YuU0nWNs4TJA608MkYEcod2miG5Uw+BczN0oUw=;
 b=K4Snf2341uYiXx2X7yjr2UyooJcfmdZvYvHYEv+8qDpSxWacWfRvZfWPmqPt6W7ZPtI225FSvrJlWd6pCXxyX1iPjLD0KtBRu+ZWTybYqjmQnYUtzqQnNpIJ15vMeMokUDH5xMidwmcbMVx3Pu6oDa2VUcKTij4kvQHKztliIVN2nrolZKDmLMWXqwsfykOsHM78CQQK2tp2kn338tzVdc3vzCH2RKlqkKf0JrTUwfi+HLyk2W+9Sr8fo1SyLIhRTilhFnYBjvKpU04nP7a0rT6lAjxgVEDxz033dGCn5nHv1Leus4cxFqTfs1gzc+Hp8uDUr4gIL4+moGDhZORm9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB10969.eurprd04.prod.outlook.com (2603:10a6:150:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 21:09:20 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Fri, 12 Jun 2026
 21:09:19 +0000
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
Subject: [PATCH v2 phy-next 7/8] soc: fsl: guts: implement the RCW override procedure
Date: Sat, 13 Jun 2026 00:08:58 +0300
Message-Id: <20260612210859.266759-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612210859.266759-1-vladimir.oltean@nxp.com>
References: <20260612210859.266759-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0031.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::11) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 9dae5b8a-3ea5-4dfa-4ee0-08dec8c6dea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|10070799003|1800799024|366016|7416014|376014|56012099006|3023799007|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5VfRiZf6uX64UsOW2E4Fk75TILwNE0Bx8fdpdFoHvfLz/y/EtrGmy4S2qTzhnl9CEn0UUHc8SIXEBi/UvjGY/M7nDmt8X2BrBH6MJeKCVYZbG6klA+uiUmmUpqXaT1272Y2BgJMC8SWc0JBHjZUdsUWEA2XuZhEEaJwxRZHmoRJkvFaltBQG3Pn9q9AreaTiYrVq9QnFvR56Nq7PX2hRj8cq6pTx9Etqtvl1B1a6cUWi1V+usHyn5N4CCyYn1e0Ql1g57KfdFCtqud/h/mVmie5KUNH2vJkVUHnj0qZAa0f8WXgI7Dpu8I4hvhAs9q8sfCS8B1pKxZI5+BC9H6+KfhhTWzaCDHxvfqRUET9CXHDcEnXpck185f5NXdg9bnAPB7aPFAs8xDc5oF8iHctUgqW0J42H/dtPYuhtkFsUZWBv/Y8Jwrpz3OxbRWxmJsOUVsC71xVueot58xtmpCT6AtJkteHRpAuQIzw0IW/7UHTXNgQsbgcE9sjnIqWzOwSguOAtjAFzyjCMmgrsmHHxzV4Us/PzfG+oDw8oo+Ib2lOATatqzIR1n2HPIaYCtbuUzMo6VCZiacHPDZm2HAnWO/AAmAMz3emEfeMWQ2aBlMubScskB3/gXSbN3kSbWQrMbHzkYggV8flv+VEFcPQY7fNY8ePa4jy2Cl5aYUxQWkKohfZ3sldnhTTZMr8XP6wb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(10070799003)(1800799024)(366016)(7416014)(376014)(56012099006)(3023799007)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nFf5tnLHSVD4ipi9KZLjAAYyZ93+Pvik1i6tf9sicsgoJdwBgodF8J8xjC3T?=
 =?us-ascii?Q?eXsxNwmYp2CwI8WBMl54/60FuVWfXu4MJJgV+WzhTBV64+WPJ2+HNtEL0zty?=
 =?us-ascii?Q?XLroXZnyDiyMgRcA7cSlsUY5SXKKWSyrY5E914NGhELIebbxzQRVB1nSTPaV?=
 =?us-ascii?Q?Gn6H4U3ObwK+Gjs/y5hzR70Ew+9XM0IfJ90+/Gjd9wORm5KjTGs0vBrtrSmh?=
 =?us-ascii?Q?/nyoC9c/r9YC+HCATtg1a1K2zrCVnn60mUReUuafW+IxK/Aw0P9Gu3Av1F6R?=
 =?us-ascii?Q?503Vt2X864orYIHYkTQJkzQVuHjgEJURaY9zPPEFw4H/Wjj7u5vpqgDwmW3+?=
 =?us-ascii?Q?KPJ2gLIGGgcBzZVcFlbyhER5wgPudZvl3rq1dXGYoZXOY0KCBY6C1zvHDvWb?=
 =?us-ascii?Q?enYSIghhhhY6LEjwiS3KbGElvhYedWe75l2uqQt+CusORIob2vGXsqt/GWef?=
 =?us-ascii?Q?Zg5PUo3atAm/XJrOOhdyGDBZiJHN4GTiL8eS2FUdSGrratyymLzn/vuPpnZD?=
 =?us-ascii?Q?MTwt/khqtygIfPF6UMZL0Asc4yFB0kTMgD0jyuhm2tpiD8I671+8uuHzlHVc?=
 =?us-ascii?Q?vK+CgIZ86P7TRXjM7+/pu0d3agZYosufD8N4mJb+WRg8KMuylCSt2yBWNB/g?=
 =?us-ascii?Q?XyTkSEJOYIwuxRmShlEqVFBaYfjwZFlARD6V4wXfvfmq2iOXYPPcoO/2PXDM?=
 =?us-ascii?Q?ocCi8xp0Co06SgNecXzGOp/OHglUBGjjl1F87tGV5C8VV69edbIpFq8JqmZq?=
 =?us-ascii?Q?HoskgYKAw06EJiA8Xj2J91WvK+lIIGSLegAdXJmIbUdAbXglv56xx70raufd?=
 =?us-ascii?Q?QdMbJktff0CGjCwBnWW1OyjoOzddqoOk5j9kBx45dYb1sHK6abJnj+S0ZBFI?=
 =?us-ascii?Q?X1g6c+ApAr+hKyHBa9e5jujnTSwWBxfaLC67a7N98CrRanaA49paPWTLMRAV?=
 =?us-ascii?Q?HDXHSmDgGrxHWzH5zR4+as06hiC0IpaPFwTvnjk5dCrKdN3LTvw3Rd+IA0CT?=
 =?us-ascii?Q?ZSLWaFWcjI/yfF/DN9vHd7q8+42T67YOP+GeBKwjporxp1MfxbICweDQHqow?=
 =?us-ascii?Q?ssZp5q81oY2ckfFoxQGdQz6I1MxXXHJ2dOw7aNGZCcea6TkgBat27a7j2xup?=
 =?us-ascii?Q?q/lh0SGomuE5DphAsqKYezzc1I34sdb5wSGZ9SIHUAl7N+T8bdFmTL9SpFiJ?=
 =?us-ascii?Q?wkyXfPDykTAC0x72nGI2o0hFR0zdaZMnSllo1/zfYFBdjApGKpjpek3RlIg+?=
 =?us-ascii?Q?xso7aySxJl/Ta4TQI3H9TFUuKzQHDi1mLEYvzbdsStnRkeMssugk3vixaiuT?=
 =?us-ascii?Q?JqAN9AQmFgBtOmZsiMBgTMmgtJN15MLdh6/D9VH+jNzyUv8tnKuYdOx+yhIK?=
 =?us-ascii?Q?mU5JZ1zRXMmuc5yjc+nuT2suZP/tDgW8VHRYZd6sy5ia20aAqCAh+CnBq85T?=
 =?us-ascii?Q?+NwkJT6mFd/PcVl0Nvx7swoOPjk5aIRT6wF2ED5TGoEkbXDE5Gq7V5iWR2fo?=
 =?us-ascii?Q?IUCV2t33vWY5/U9rGNDZ2t85pn64smKtR9ORvGjBzZ/w4bCaf2Ib5kBV6t52?=
 =?us-ascii?Q?ZqwXm6ZvuO+IRh6392uXTdYkl09hphCd0YkJcjctVgyAsyaFeBWKXwi5kHuW?=
 =?us-ascii?Q?bwP0yHMJTgmzrzN0blYiPNA4hripVvNl481r5Bbbv12jykb4rTxHcB1jD8EF?=
 =?us-ascii?Q?4evFB9OwBEofdGJnBeZ2yJP4uJfLnyXptrIjs3XZvGp0M9PHoioN6g1o84pQ?=
 =?us-ascii?Q?Zph61wpNbK1vEgO3yB65uosv5lXZUJM/omPUWNiHMUoU1okN7JQh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dae5b8a-3ea5-4dfa-4ee0-08dec8c6dea9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 21:09:19.9207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeQQW+mLYT6m5Mec2tonoofQKqpFdKHj7ZdMkhUncedGtZuFyx9rTvdM5PAiuqiJ5NkjhrCDpOd4vBv7SkpUDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10969

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add support for the RCW override procedure which enables runtime
reconfiguration of the protocol running on a SerDes lane. The procedure
is done through the DCFG DCSR space which now can be defined as the
second memory region of the guts DT node.
Support is added on the following SoCs: LS1046A, LS1088A, LS2088A.

The procedure is exported to the "client" driver - the Lynx10G SerDes
PHY driver - through the following functions:
- fsl_guts_lane_init() used to notify the initial / boot time lane mode
  running on a SerDes lane.
- fsl_guts_lane_validate() used to validate that changing the protocol
  on a specific lane is supported.
- fsl_guts_lane_set_mode() which can be used to request the RCW
  procedure be executed for a specific lane.

Since the RCW override procedure is different depending on the SoC, the
private fsl_soc_data structure is updated with two new per SoC callbacks
(.serdes_get_rcw_override() and .serdes_init_rcwcr()) which get used
from the generic fsl_guts_lane_set_mode() function. These two callbacks
hide all the SoC specific register offsets, masks and values so that the
_set_mode() procedure is straightforward.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- drop DT maintainers from explicit CC
- keep devicetree@vger.kernel.org CCed on entire series
- include missing <linux/bitfield.h>
- namespace SRDS_PRTCL values for LS1046A and LS1088A, even if they are
  the same. For LS1028A (not covered here) they are not.
- prefix SRDS_CLK_SEL_{GMII,XGMII} with LS2088A_
- reorder alphanumerically (LS1046A should come before LS1088A)
---
 drivers/soc/fsl/guts.c   | 285 ++++++++++++++++++++++++++++++++++++++-
 include/linux/fsl/guts.h |  20 ++-
 2 files changed, 298 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 9f2aff07a274..0fa2bd99d3c1 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -15,6 +16,28 @@
 #include <linux/fsl/guts.h>
 
 #define DCFG_CCSR	0
+#define DCFG_DCSR	1
+
+#define MAX_NUM_LANES	8
+#define MAX_NUM_SERDES	2
+
+#define LS1046A_RCWSR5_SRDS_PRTCL_S1(lane)	\
+	GENMASK(19 + 4 * (lane), 16 + 4 * (lane))
+#define LS1046A_SRDS_PRTCL_XFI				1
+#define LS1046A_SRDS_PRTCL_100BASEX_SGMII		3
+
+#define LS1088A_RCWSR29_SRDS_PRTCL_S1_LNn(lane)	\
+	GENMASK(19 + 4 * (3 - lane), 16 + 4 * (3 - lane))
+#define LS1088A_RCWSR30_SRDS_PRTCL_S2_LNn(lane)	\
+	GENMASK(3 + 4 * (3 - lane), 4 * (3 - lane))
+#define LS1088A_SRDS_PRTCL_XFI				1
+#define LS1088A_SRDS_PRTCL_100BASEX_SGMII		3
+
+#define LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1	BIT(14)
+#define LS2088A_RCWSR30_SRDS_CLK_SEL_XGMII_Ln_S1(lane)	BIT(6 + (7 - (lane)))
+#define LS2088A_RCWSR30_SRDS_CLK_SEL_MSK		GENMASK(13, 6)
+#define LS2088A_SRDS_CLK_SEL_XGMII			1
+#define LS2088A_SRDS_CLK_SEL_GMII			0
 
 struct fsl_soc_die_attr {
 	char	*die;
@@ -22,9 +45,19 @@ struct fsl_soc_die_attr {
 	u32	mask;
 };
 
+struct fsl_soc_serdes_rcw_override {
+	int offset;
+	int mask;
+	int val;
+};
+
 struct fsl_soc_data {
 	const char *sfp_compat;
 	u32 uid_offset;
+	int (*serdes_get_rcw_override)(int index, int lane,
+				       enum lynx_lane_mode lane_mode,
+				       struct fsl_soc_serdes_rcw_override *override);
+	void (*serdes_init_rcwcr)(int index);
 };
 
 enum qoriq_die {
@@ -138,9 +171,13 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 
 static struct fsl_soc_guts {
 	struct ccsr_guts __iomem *dcfg_ccsr;
+	struct ccsr_guts __iomem *dcfg_dcsr;
 	const struct fsl_soc_data *data;
 	bool little_endian;
 	u32 svr;
+	enum lynx_lane_mode lane_mode[MAX_NUM_SERDES][MAX_NUM_LANES];
+	bool rcwcr_init_done;
+	spinlock_t rcwcr_lock; /* serializes concurrent writes to the RCWCR */
 } soc;
 
 static unsigned int fsl_guts_read(const void __iomem *reg)
@@ -151,6 +188,28 @@ static unsigned int fsl_guts_read(const void __iomem *reg)
 	return ioread32be(reg);
 }
 
+static void fsl_guts_write(void __iomem *reg, u32 val)
+{
+	if (soc.little_endian)
+		iowrite32(val, reg);
+	else
+		iowrite32be(val, reg);
+}
+
+/* Some fields of the Reset Configuration Word (RCW) can be overridden at
+ * runtime by writing to the RCWCRn registers contained within the DCSR space
+ * of the Device Configuration (DCFG) block. The layout of the RCWCRn registers
+ * is identical with the read-only RCWSRn from the CCSR space.
+ */
+static void fsl_guts_rmw(int offset, u32 val, u32 mask)
+{
+	u32 tmp = fsl_guts_read(&soc.dcfg_ccsr->rcwsr[offset]);
+
+	tmp &= ~mask;
+	tmp |= val;
+	fsl_guts_write(&soc.dcfg_dcsr->rcwcr[offset], tmp);
+}
+
 static bool fsl_soc_die_match_one(u32 svr, const struct fsl_soc_die_attr *match)
 {
 	return match->svr == (svr & match->mask);
@@ -167,6 +226,97 @@ static const struct fsl_soc_die_attr *fsl_soc_die_match(
 	return NULL;
 }
 
+static int
+fsl_guts_serdes_get_rcw_override(int serdes_idx, int lane,
+				 enum lynx_lane_mode lane_mode,
+				 struct fsl_soc_serdes_rcw_override *override)
+{
+	if ((!fsl_soc_die_match_one(soc.svr, &fsl_soc_die[DIE_LS1088A]) &&
+	     !fsl_soc_die_match_one(soc.svr, &fsl_soc_die[DIE_LS2088A]) &&
+	     !fsl_soc_die_match_one(soc.svr, &fsl_soc_die[DIE_LS1046A])) ||
+	    !soc.data || !soc.data->serdes_get_rcw_override) {
+		pr_debug("RCW override not implemented for SoC\n");
+		return -EINVAL;
+	}
+
+	if (!soc.dcfg_dcsr) {
+		pr_debug("Device tree does not define DCFG_DCSR region necessary for RCW override\n");
+		return -EINVAL;
+	}
+
+	return soc.data->serdes_get_rcw_override(serdes_idx, lane, lane_mode,
+						 override);
+}
+
+/**
+ * fsl_guts_lane_init() - Notify guts module of SerDes lane configuration
+ * @serdes_idx: zero-based SerDes block index
+ * @lane: zero-based lane index within SerDes
+ * @lane_mode: initial / boot time SerDes protocol for lane
+ *
+ * On the LS208xA SoC, the RCW override procedure needs to be aware of all link
+ * modes which are configured on a SerDes block.
+ */
+void fsl_guts_lane_init(int serdes_idx, int lane, enum lynx_lane_mode lane_mode)
+{
+	soc.lane_mode[serdes_idx - 1][lane] = lane_mode;
+}
+EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_init, "FSL_GUTS");
+
+/**
+ * fsl_guts_lane_validate() - Validate that SerDes protocol is implemented and
+ *	supported on current SoC
+ * @serdes_idx: zero-based SerDes block index
+ * @lane: zero-based lane index within SerDes
+ * @lane_mode: requested SerDes protocol
+ *
+ * Should be called before actually requesting the RCW override procedure to be
+ * applied using %fsl_guts_lane_set_mode()
+ *
+ * Return: 0 if RCW override to protocol is possible, negative error otherwise
+ */
+int fsl_guts_lane_validate(int serdes_idx, int lane, enum lynx_lane_mode lane_mode)
+{
+	struct fsl_soc_serdes_rcw_override override;
+
+	return fsl_guts_serdes_get_rcw_override(serdes_idx, lane, lane_mode,
+						&override);
+}
+EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_validate, "FSL_GUTS");
+
+/**
+ * fsl_guts_lane_set_mode() - apply RCW override procedure for SerDes lane
+ * @serdes_idx: zero-based SerDes block index
+ * @lane: zero-based lane index within SerDes
+ * @lane_mode: requested SerDes protocol
+ *
+ * Return: 0 on success, negative error otherwise
+ */
+int fsl_guts_lane_set_mode(int serdes_idx, int lane, enum lynx_lane_mode lane_mode)
+{
+	struct fsl_soc_serdes_rcw_override override;
+	int err;
+
+	err = fsl_guts_serdes_get_rcw_override(serdes_idx, lane, lane_mode,
+					       &override);
+	if (err)
+		return err;
+
+	spin_lock(&soc.rcwcr_lock);
+
+	if (soc.data->serdes_init_rcwcr)
+		soc.data->serdes_init_rcwcr(serdes_idx);
+
+	fsl_guts_rmw(override.offset, override.val << __bf_shf(override.mask),
+		     override.mask);
+	soc.lane_mode[serdes_idx - 1][lane] = lane_mode;
+
+	spin_unlock(&soc.rcwcr_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_set_mode, "FSL_GUTS");
+
 static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
 {
 	struct device_node *np;
@@ -193,6 +343,128 @@ static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
 	return uid;
 }
 
+static int ls1046a_serdes_get_rcw_override(int index, int lane,
+					   enum lynx_lane_mode lane_mode,
+					   struct fsl_soc_serdes_rcw_override *override)
+{
+	/* The RCW override procedure has to write to different registers
+	 * depending on the SerDes block index.
+	 */
+	switch (index) {
+	case 1:
+		override->offset = 4;
+		override->mask = LS1046A_RCWSR5_SRDS_PRTCL_S1(lane);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (lynx_lane_mode_uses_xgmii_mac(lane_mode))
+		override->val = LS1046A_SRDS_PRTCL_XFI;
+	else if (lynx_lane_mode_uses_gmii_mac(lane_mode))
+		override->val = LS1046A_SRDS_PRTCL_100BASEX_SGMII;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ls1088a_serdes_get_rcw_override(int index, int lane,
+					   enum lynx_lane_mode lane_mode,
+					   struct fsl_soc_serdes_rcw_override *override)
+{
+	/* The RCW override procedure has to write to different registers
+	 * depending on the SerDes block index.
+	 */
+	switch (index) {
+	case 1:
+		override->offset = 28;
+		override->mask = LS1088A_RCWSR29_SRDS_PRTCL_S1_LNn(lane);
+		break;
+	case 2:
+		override->offset = 29;
+		override->mask = LS1088A_RCWSR30_SRDS_PRTCL_S2_LNn(lane);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (lynx_lane_mode_uses_xgmii_mac(lane_mode))
+		override->val = LS1088A_SRDS_PRTCL_XFI;
+	else if (lynx_lane_mode_uses_gmii_mac(lane_mode))
+		override->val = LS1088A_SRDS_PRTCL_100BASEX_SGMII;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ls2088a_serdes_get_rcw_override(int index, int lane,
+					   enum lynx_lane_mode lane_mode,
+					   struct fsl_soc_serdes_rcw_override *override)
+{
+	switch (index) {
+	case 1:
+		override->offset = 29;
+		override->mask = LS2088A_RCWSR30_SRDS_CLK_SEL_XGMII_Ln_S1(lane);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (lynx_lane_mode_uses_xgmii_mac(lane_mode))
+		override->val = LS2088A_SRDS_CLK_SEL_XGMII;
+	else if (lynx_lane_mode_uses_gmii_mac(lane_mode))
+		override->val = LS2088A_SRDS_CLK_SEL_GMII;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static void ls2088a_serdes_init_rcwcr(int serdes_idx)
+{
+	u32 reg;
+	int i;
+
+	if (serdes_idx != 1)
+		return;
+	if (soc.rcwcr_init_done)
+		return;
+
+	/* SRDS_CLK_EN_SEL_XGMII_S1: SerDes Clock Enable Select XGMII Serdes 1:
+	 * Enables to select GMII/XGMII clock according to
+	 * SRDS_CLK_SEL_XGMII_Ln_S1
+	 */
+	reg = LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1;
+
+	/* We need to configure the initial state of all lanes for
+	 * the SerDes block #1
+	 */
+	for (i = 0; i < MAX_NUM_LANES; i++)
+		if (lynx_lane_mode_uses_xgmii_mac(soc.lane_mode[serdes_idx - 1][i]))
+			reg |= LS2088A_RCWSR30_SRDS_CLK_SEL_XGMII_Ln_S1(i);
+
+	fsl_guts_rmw(29, reg,
+		     LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1 |
+		     LS2088A_RCWSR30_SRDS_CLK_SEL_MSK);
+
+	soc.rcwcr_init_done = true;
+}
+
+static const struct fsl_soc_data ls1088a_data = {
+	.serdes_get_rcw_override = ls1088a_serdes_get_rcw_override,
+};
+
+static const struct fsl_soc_data ls1046a_data = {
+	.serdes_get_rcw_override = ls1046a_serdes_get_rcw_override,
+};
+
+static const struct fsl_soc_data ls2088a_data = {
+	.serdes_get_rcw_override = ls2088a_serdes_get_rcw_override,
+	.serdes_init_rcwcr = ls2088a_serdes_init_rcwcr,
+};
+
 static const struct fsl_soc_data ls1028a_data = {
 	.sfp_compat = "fsl,ls1028a-sfp",
 	.uid_offset = 0x21c,
@@ -221,10 +493,10 @@ static const struct of_device_id fsl_guts_of_match[] = {
 	{ .compatible = "fsl,mpc8572-guts", },
 	{ .compatible = "fsl,ls1021a-dcfg", },
 	{ .compatible = "fsl,ls1043a-dcfg", },
-	{ .compatible = "fsl,ls2080a-dcfg", },
-	{ .compatible = "fsl,ls1088a-dcfg", },
+	{ .compatible = "fsl,ls2080a-dcfg", .data = &ls2088a_data},
+	{ .compatible = "fsl,ls1088a-dcfg", .data = &ls1088a_data},
 	{ .compatible = "fsl,ls1012a-dcfg", },
-	{ .compatible = "fsl,ls1046a-dcfg", },
+	{ .compatible = "fsl,ls1046a-dcfg", .data = &ls1046a_data},
 	{ .compatible = "fsl,lx2160a-dcfg", },
 	{ .compatible = "fsl,ls1028a-dcfg", .data = &ls1028a_data},
 	{}
@@ -250,6 +522,8 @@ static int __init fsl_guts_init(void)
 		of_node_put(np);
 		return -ENOMEM;
 	}
+	/* DCFG_DCSR is optional */
+	soc.dcfg_dcsr = of_iomap(np, DCFG_DCSR);
 
 	soc.little_endian = of_property_read_bool(np, "little-endian");
 	soc.svr = fsl_guts_read(&soc.dcfg_ccsr->svr);
@@ -296,6 +570,8 @@ static int __init fsl_guts_init(void)
 		goto err;
 	}
 
+	spin_lock_init(&soc.rcwcr_lock);
+
 	pr_info("Machine: %s\n", soc_dev_attr->machine);
 	pr_info("SoC family: %s\n", soc_dev_attr->family);
 	pr_info("SoC ID: %s, Revision: %s\n",
@@ -305,7 +581,8 @@ static int __init fsl_guts_init(void)
 
 err_nomem:
 	ret = -ENOMEM;
-
+	if (soc.dcfg_dcsr)
+		iounmap(soc.dcfg_dcsr);
 	iounmap(soc.dcfg_ccsr);
 err:
 	kfree(soc_dev_attr->family);
diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
index fdb55ca47a4f..176842531241 100644
--- a/include/linux/fsl/guts.h
+++ b/include/linux/fsl/guts.h
@@ -13,6 +13,7 @@
 
 #include <linux/types.h>
 #include <linux/io.h>
+#include <soc/fsl/phy-fsl-lynx.h>
 
 /*
  * Global Utility Registers.
@@ -91,9 +92,15 @@ struct ccsr_guts {
 	u32	iovselsr;	/* 0x.00c0 - I/O voltage select status register
 					     Called 'elbcvselcr' on 86xx SOCs */
 	u8	res0c4[0x100 - 0xc4];
-	u32	rcwsr[16];	/* 0x.0100 - Reset Control Word Status registers
-					     There are 16 registers */
-	u8	res140[0x224 - 0x140];
+	/* 0x.0100 - read-only Reset Configuration Word Status registers in
+	 * CCSR, or write-only Reset Configuration Word Control registers in
+	 * DCSR. In both cases there are 32 registers.
+	 */
+	union {
+		u32	rcwsr[32];
+		u32	rcwcr[32];
+	};
+	u8	res180[0x224 - 0x180];
 	u32	iodelay1;	/* 0x.0224 - IO delay control register 1 */
 	u32	iodelay2;	/* 0x.0228 - IO delay control register 2 */
 	u8	res22c[0x604 - 0x22c];
@@ -131,6 +138,13 @@ struct ccsr_guts {
 	u32	srds2cr1;	/* 0x.0f44 - SerDes2 Control Register 0 */
 } __attribute__ ((packed));
 
+void fsl_guts_lane_init(int serdes_idx, int lane,
+			enum lynx_lane_mode lane_mode);
+int fsl_guts_lane_validate(int serdes_idx, int lane,
+			   enum lynx_lane_mode lane_mode);
+int fsl_guts_lane_set_mode(int serdes_idx, int lane,
+			   enum lynx_lane_mode lane_mode);
+
 /* Alternate function signal multiplex control */
 #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
 
-- 
2.34.1


