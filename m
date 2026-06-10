Return-Path: <linuxppc-dev+bounces-22417-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FFBCD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 15:20:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb8cL33rvz2yfD;
	Thu, 11 Jun 2026 01:20:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781104850;
	cv=pass; b=mqFZQQa1juh7xMNyCzfTPgcdYhMbKDrWBgHM//ejEFslrY1QhC7k0Xykn35FV5+j+D4TT/9w1u9WLWFNqCKbGpbf9/I6zy7o8PnWnJ+O23Znsm6wAF331UPz3RepnkHx9PxYo9NWUlDrokYQmBcusMTEKicgP5oGL5PKWsskG8uCFDTFpk8z0cWGpvvTFWynqTaUevoHXoXImvs089xchQnYgaMmfrrUXZC4Vm3CKEDb/KVQgLIPxBMDNJHxQy0r3knSkkdHJEZ5K1Ybz5pJ/WC+FxtB5JgaXkXEKf5U0qOCKc0xlRyk47pbMUONDazzkVVjUl1bM1iw82APzjnA9A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781104850; c=relaxed/relaxed;
	bh=ijymU1cfqhty+fnmmXpwPYlVBUJ7XIEMdWW8YMLalo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nPBo/oRmBhlgeCwahYi5bJu4bK0rds5brEePXas4xi7GebjYrAEhjm7aqIV/1Rsj7Vg2ZtCkwwaRAx572TmKJmdbVOdgcCEP9HEgbjPidw54zkvC6T6MTPNJASkn8iPrijNMiDS//WLlcjnCCE5IpVi9INenUI07s+00gKFN0gRH9L6ScPOJ4BKyR1lv1p5231wi7PI7PAw7tfoX7sCdSLWlzvUbpwwo1fhgcRp9+fIqqYpkW7sou1ng/S9d85NE9h8DWMNAC6egep8/cQxwzNz0ERd7PwO9d1N55dB10FYbAshgnXP9o5SnSmL0jp3HhoO3I4JLpQWBT31PmCLJbA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Ud/7LSNQ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Ud/7LSNQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb8cH1zySz2yNn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 01:20:46 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xO4+tKTCJ1mp+6InuOSTwvi43GFyUqjiTo4S+kxPNQwEpiISjxPb/qe6RSJp/gwAlWIibfyNOOZwVB66j40E6JcpQ+zlEqMStcegefRTAilHv0aXCPmL1UeMKifk6xTdmkcChERliB4pr2EZUNXH6u/BuGgSJaXnxzthv2P3GiOWSAmNHel/ZGgk/XFq6kmKOU9y+TOjf8DEkOuUfEaH8U+FVEp9emccVjSGhxTqQscv2L7sAd7rKh0xvc5ibn5lIz8Y6p2EhYwN6aoWDKobMq/3ketWUoTZ5JdOJSvPwWXH2UVtJCZGTnmJr8daKZHTH7iJX9gbrdb78dSCZDkuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijymU1cfqhty+fnmmXpwPYlVBUJ7XIEMdWW8YMLalo0=;
 b=Vw5e7A6Qg+N0FeAO1m2kRuTsMVZoVHg8qbBsf4XG3M+dHp1KbmhK8D+/MnRkn9ESifHqAo5yWp5mf6Jd6NZZWFGXBxB81vXJ03cnBNXA5nw9cMG5oYLQCHIFBMRo5PcRvy5K9QhQkY0KXN8ZPzSQZOrVsBskq1YxWM8B2DuAbljzGzE++I9j8P4ZsFdKW4xPycsz+f4wu3i1TZ9cEJhkWUEEV/lcZEGp9yo5YRTcph4RKOxSSw2JKVNP0owbPh/HecPucMvSievtgh0bT0kpOsEgS/3X5pcrvy2PGmRWAOuVjOsQiEJOOsf+qvL+fy49pwqftJbeFMpu0nNz1nyqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijymU1cfqhty+fnmmXpwPYlVBUJ7XIEMdWW8YMLalo0=;
 b=Ud/7LSNQ3ga2NLf1hqSXCEwzJtKSML/eZca+h9N4sXs/Ns16BH1IAN15JQbZdL7WLU3M+NrTBXixt4EjtCqmuEnUTPbp5qyY/ytiOtNMgNw+WFgFjnIAuBsy5vPf+B5GiD1OxqqKGaTmps37y3V59pH+yzzElZoCdEMYC81OfZAA5OkjojXwJbF5J9xynHaphlGuv9wPwdm7Lqdd5NrLaTM1+gQLMW4z+UTB5vvzwPVJmiVQKbz5kzoUfhMe5uJnE3OfxjSHJ7A4iBXWmM8YPK6e+X3scqGOnGFS01hOc3OVXa9ebiSp/xUrpuv5d4Tr0KFX/Qb1zJgaYnZ71WI3QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM9PR04MB8844.eurprd04.prod.outlook.com (2603:10a6:20b:40b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 10 Jun
 2026 15:20:24 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 15:20:23 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 phy-next 15/16] phy: lynx-10g: new driver
Date: Wed, 10 Jun 2026 18:19:51 +0300
Message-Id: <20260610151952.2141019-16-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610151952.2141019-1-vladimir.oltean@nxp.com>
References: <20260610151952.2141019-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0005.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::14) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AM9PR04MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: e99fe6f6-2365-4c24-e4e1-08dec703caf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|7416014|56012099006|3023799007|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ueTIypyvFoqh71dyo/leTPRF3t803nuM8YegOBpbQPyESsa+V8B+hKNeVyxEqB45Ij0VEF08omRuwP8Jz9fWI/17OaBN8NVOmObZId2dR3L8XlC1mKon5/85xiGhZ3d6TucWkwihJP+TzC+UxK5VrdEKj9FuMFnHfFGC9ejSxVYj+W3HkpJFo2701+R2MuBxBgxpPt7dHj/5JGxvLJe91c7zbBYH5ReP/LzuP5LRpiB+Od9oSgwmgQfVb1nyXwIxLCWLvvioYH8rf2R5Ik9uFLx/8/UCnmmwtTyCrb23HLsS+GJbMgcI9wvs8vS3dJuAvGJmxPMNeiyiMH9/I4JSqY9uMbG+/zgsph+NJwTW1ejMBV5YhEVYX4bdylD2z3s48IQnpeyorZJQWfjLwfucROw/rykbtuulDKCXRs2oZlCeZYZF1f9zM228j5V3YHq1WC2BQ9W6l+0RT23OlAZCylWciIt46XgKZg3A4VH3Mg+Gc+t4Iz3QsVrhzlxyr4lszKsk5XU+x2/mY4py4T4ZlLhUULWrhDVNmlcLtWRi8FXoTGH4OYR9FcNoXmULAUi1BI8N90BJ1kKZLz2Ra73AwyDbdd2vqKyGu3uIH77m1f3DLNvSLE85TkAk2xhhvnoGDXOudcj63V6eM0dSdps/k8pet3CDWBY8t1V3cYIEhyhb4I7ggYBzVPo2m5oPzpP3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(7416014)(56012099006)(3023799007)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VZkylbvuwGHJffA2kEL5ln/dmXYokyJA4JGP5XYYlWN/0rboUGC2WSuCZTYA?=
 =?us-ascii?Q?9ZMs2IixkfDqzc2+HDOJSj8NxyitDRFkBwKX1eiH2XIKuhUtQFVcOWAMTKGy?=
 =?us-ascii?Q?AEjYujwU4s6ABrzEsBxI0puR8BUBXfzU62no/HSQQWTCeAoZx4ZRcizWmeHl?=
 =?us-ascii?Q?3s37+1tpXXlWWfnP80pcDPv2vfTdJCWw4OBr7JEVD8S+HEIAxPec1/kwAQ7B?=
 =?us-ascii?Q?klQfWuj/yTfwvWC2rtxAZwws4M0/xNa+9PJ0TvyPD0OVfcaPq0Ld9qUUI5X/?=
 =?us-ascii?Q?ivA+xEFapDxAXGrWT3zKKeLy6iWva2ITUZnCntT6UVApj7S2WIv3SB7JjNt/?=
 =?us-ascii?Q?xOMGeHJYBHXQbSHVNXd4n+2/VebE5Wfa5OcaK1EVmKAoI4ZFMy+7gQn2SDk4?=
 =?us-ascii?Q?lcAr2hXAY+hdvExZ2SMCZbAHmWrIsVbJPnp1rz+kN50C+m8QKZvfVEDLEtyg?=
 =?us-ascii?Q?yaaCGLLaoGbmmeqMg/hjjx9DgSN4zPJRG5mw31cOUuIm59R8q9KLtRnbEuCm?=
 =?us-ascii?Q?8ui7RgGLd4cE+n7RIXJnoMNTg1ho92kuukJBsc1Jiu+2pA6ZhlfoOM2EK8On?=
 =?us-ascii?Q?4Z682uJ0+LUGi3mgaeBdfxdz+3D9d44GvqlevaTQx1r6FXaVXtCRalEO5NS1?=
 =?us-ascii?Q?JqlDA5cpwSIFOiMaH8gjPnxbLyjtVBDUrwTV1dmy32EAnOQ9L9vT+3Rw/61n?=
 =?us-ascii?Q?4bhPfU+J8AJ6fQ9G/MuZa8SYK+fW7z39gltVCkyEZfHmDvuLMoMAPoauOKpN?=
 =?us-ascii?Q?CDwYp2gpFNwwP1Vt//gkh2Km5eFH1xcF6iSb8cDhepq+VfK29HX2MetCziFV?=
 =?us-ascii?Q?eq5Vg+rX+WQesWS8axBsFPAXQJ/SeY/FSy8uLJ+TD7o5+Y+flHFBZmBHKZAb?=
 =?us-ascii?Q?zUfF8XtkruETbRKu9kmC9iDSCRosDNztAG40Gw4DyzXkpeDG8f2eOnSsFEk1?=
 =?us-ascii?Q?CSa7FzzJlfGGxEZBj79b9JKmJhOb7TcZKpXYq2R0sZxz307M0or/GKIhnzJX?=
 =?us-ascii?Q?PScnouHerH7jwSZCnGPqbtCCiLmkezRGsSYG7ukScHEd/02sAPuz2tj1kJrx?=
 =?us-ascii?Q?v30/Z8zU17sAGjl63PO6ZnDFqCbNnQ8f+R4iuF00zg+2sNzzeeVD1zkP1oJM?=
 =?us-ascii?Q?oRHr6t5UEiHwAkruGVIue3e5R5rdX5AIBHpJSz847PqRFBlmoqo2yLhW8GUl?=
 =?us-ascii?Q?jhRCUpvAzX89WWdTwzKAJFf40h1u1VfsnR/dGQCcSNliDap8q2gZuQYuGM7W?=
 =?us-ascii?Q?/IeTAhwqMevJjN1pj83OFz18r4GYyCW9Cjkvmps9oFFZWINN6385VAZcuAuz?=
 =?us-ascii?Q?WaAA77RqLeGdnoThiBq4Qcp478VQhbui1PRuS7OY5GCVqa91io9RVzUcEmuB?=
 =?us-ascii?Q?kUlZ1Z5SB+1MWdT71uP5TEtEb4EwFhw4hDtDaYTbpJ2H8CjJ05vZ7MlpUJ4/?=
 =?us-ascii?Q?hxGQePVEZIUpdVPdTt/gvuEMow161koAvewVnTtLEvR4GMiNquiGAQOgSQ/b?=
 =?us-ascii?Q?/DD3P21VXfYuM7Ax1DXq0CkBzOzm4IkDw6hwm0U2W/w7Y9zqmgyYs28PRIcI?=
 =?us-ascii?Q?0p8yEQa0nJTHuaXpS0upLipdT61mQXNyu8jYNARr3fAql5iei9wlY6JzhZB6?=
 =?us-ascii?Q?+QRNeviRM6LzbN+t3tkp2ghYm7N/HJtI3cFaxF7INZn2cjzHIZTQTXp03KEj?=
 =?us-ascii?Q?sqrQCb6OdeFi7AH393z/gSg8WVgjBpcVb06Pzyo8adL7vd1zVLdnlEJdDgb5?=
 =?us-ascii?Q?FBOnu8EdkA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99fe6f6-2365-4c24-e4e1-08dec703caf5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:20:23.9504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvuHEVw1lswtsdND8y6dakuhD7cGM0XM/Ks3aZyV5dSwgTWNc+3OaSJPNHHIzhka4kByUl/XWRowIINZgZhK0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8844

Introduce a driver for the networking lanes of the 10G Lynx SerDes
block, present on the majority of Layerscape and QorIQ (Freescale/NXP)
SoCs.

As with the 28G Lynx, the SerDes lanes come pre-initialized out of
reset and the consumers use them that way outside the Generic PHY
framework (for networking, the static configuration remains for the
entire SoC lifetime, whereas for SATA and PCIe, the hardware
reconfigures itself automatically for other link speeds).

The need for the Generic PHY framework comes specifically for networking
use cases where a static lane configuration is not sufficient. For
example a network MAC is connected to an SFP cage, where various SFP or
SFP+ modules can be connected. Each of them may require a different
SerDes protocol (SGMII, 1000Base-X, 10GBase-R), which phylink + sfp-bus
are responsible of figuring out. The phylink drivers are:
- enetc
- felix
- dpaa_eth (fman_memac)
- dpaa2-eth
- dpaa2-switch

and they all need to reconfigure the SerDes for the requested link mode,
using phy_set_mode_ext() (and phy_validate() to see if it is supported
in the first place).

Note that SerDes 2 on LS1088A is exclusively non-networking, so there is
currently no need for this driver. Therefore we skip matching on its
compatible string and do not probe on that device.

Co-developed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: devicetree@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: chleroy@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org

v4->v5:
- add comments around default_pccr so that Sashiko understands what is
  the idea and why the code is correct (and the assumptions being made)
- replace testing of the non-zero quality of lane->default_pccr[mode]
  with the lynx_10g_pccr_val_enabled() helper which ignores the KX bit.
  A lane starting with PCCR8_SGMIIa_KX=1 and PCCR8_SGMIIa_CFG=0 is
  disabled, not enabled (although this is unusual and never a hardware
  reset value).
- express PCCR8_SGMIIa_CFG(), PCCR9_QSGMIIa_CFG(), PCCR9_QXGMIIa_CFG(),
  PCCRB_XFIa_CFG(), PCCRB_SXGMIIa_CFG() using GENMASK(2, 0) to make it
  clear that the field width is not 1
v3->v4:
- none
v2->v3:
- fix lynx_10g_power_on() procedure
- include <linux/of.h> instead of <linux/of_device.h>
- fix build warning introduced in v2 in lynx_10g_lane_set_nrate()
v1->v2:
- move lynx_lane_restrict_fixed_mode_change() to lynx-core, even though
  the 28G Lynx as instantiated in LX2 does not have QSGMII.
- lynx_10g_validate() now calls the new lynx_phy_mode_to_lane_mode()
  which does verify that the current lane mode is supported
- avoid line size checkpatch warnings in lynx_10g_lane_set_nrate() by
  saving the nrate to a variable and calling lynx_lane_rmw() only once
- remove redundant "if (!lane->powered_up)" checks from
  lynx_10g_lane_halt() and lynx_10g_lane_reset() - also checked at
  the only call site, lynx_10g_set_mode(), as in lynx-28g
- expand CC list (flagged by Patchwork)
---
 drivers/phy/freescale/Kconfig             |   10 +
 drivers/phy/freescale/Makefile            |    1 +
 drivers/phy/freescale/phy-fsl-lynx-10g.c  | 1321 +++++++++++++++++++++
 drivers/phy/freescale/phy-fsl-lynx-core.c |   38 +
 drivers/phy/freescale/phy-fsl-lynx-core.h |    4 +
 include/soc/fsl/phy-fsl-lynx.h            |   27 +
 6 files changed, 1401 insertions(+)
 create mode 100644 drivers/phy/freescale/phy-fsl-lynx-10g.c

diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
index ac575d531db7..5bf3864fbe64 100644
--- a/drivers/phy/freescale/Kconfig
+++ b/drivers/phy/freescale/Kconfig
@@ -54,6 +54,16 @@ endif
 config PHY_FSL_LYNX_CORE
 	tristate
 
+config PHY_FSL_LYNX_10G
+	tristate "Freescale Layerscape Lynx 10G SerDes PHY support"
+	depends on OF
+	depends on ARCH_LAYERSCAPE || COMPILE_TEST
+	select GENERIC_PHY
+	select PHY_FSL_LYNX_CORE
+	help
+	  Enable this to add support for the Lynx 10G SerDes PHY as found on
+	  NXP's Layerscape platform such as LS1088A or LS1028A.
+
 config PHY_FSL_LYNX_28G
 	tristate "Freescale Layerscape Lynx 28G SerDes PHY support"
 	depends on OF
diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makefile
index d7aa62cdeb39..5b0e180d6972 100644
--- a/drivers/phy/freescale/Makefile
+++ b/drivers/phy/freescale/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)	+= phy-fsl-imx8-mipi-dphy.o
 obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)	+= phy-fsl-imx8m-pcie.o
 obj-$(CONFIG_PHY_FSL_IMX8QM_HSIO)	+= phy-fsl-imx8qm-hsio.o
 obj-$(CONFIG_PHY_FSL_LYNX_CORE)		+= phy-fsl-lynx-core.o
+obj-$(CONFIG_PHY_FSL_LYNX_10G)		+= phy-fsl-lynx-10g.o
 obj-$(CONFIG_PHY_FSL_LYNX_28G)		+= phy-fsl-lynx-28g.o
 obj-$(CONFIG_PHY_FSL_SAMSUNG_HDMI_PHY)	+= phy-fsl-samsung-hdmi.o
diff --git a/drivers/phy/freescale/phy-fsl-lynx-10g.c b/drivers/phy/freescale/phy-fsl-lynx-10g.c
new file mode 100644
index 000000000000..38def160ef1a
--- /dev/null
+++ b/drivers/phy/freescale/phy-fsl-lynx-10g.c
@@ -0,0 +1,1321 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2021-2026 NXP */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+
+#include "phy-fsl-lynx-core.h"
+
+/* SoC IP wrapper for protocol converters */
+#define PCCR8				0x220
+#define PCCR8_SGMIIa_KX			BIT(3)
+#define PCCR8_SGMIIa_CFG		GENMASK(2, 0)
+
+#define PCCR9				0x224
+#define PCCR9_QSGMIIa_CFG		GENMASK(2, 0)
+#define PCCR9_QXGMIIa_CFG		GENMASK(2, 0)
+
+#define PCCRB				0x22c
+#define PCCRB_XFIa_CFG			GENMASK(2, 0)
+#define PCCRB_SXGMIIa_CFG		GENMASK(2, 0)
+
+#define SGMII_CFG(id)			(28 - (id) * 4)
+#define QSGMII_CFG(id)			(28 - (id) * 4)
+#define SXGMII_CFG(id)			(28 - (id) * 4)
+#define QXGMII_CFG(id)			(12 - (id) * 4)
+#define XFI_CFG(id)			(28 - (id) * 4)
+
+#define CR(x)				((x) * 4)
+
+#define A				0
+#define B				1
+#define C				2
+#define D				3
+#define E				4
+#define F				5
+#define G				6
+#define H				7
+
+#define SGMIIaCR0(id)			(0x1800 + (id) * 0x10)
+#define QSGMIIaCR0(id)			(0x1880 + (id) * 0x10)
+#define XAUIaCR0(id)			(0x1900 + (id) * 0x10)
+#define XFIaCR0(id)			(0x1980 + (id) * 0x10)
+#define SXGMIIaCR0(id)			(0x1a80 + (id) * 0x10)
+#define QXGMIIaCR0(id)			(0x1b00 + (id) * 0x20)
+
+#define SGMIIaCR0_RST_SGM		BIT(31)
+#define SGMIIaCR0_RST_SGM_OFF		SGMIIaCR0_RST_SGM
+#define SGMIIaCR0_RST_SGM_ON		0
+#define SGMIIaCR0_PD_SGM		BIT(30)
+#define SGMIIaCR1_SGPCS_EN		BIT(11)
+#define SGMIIaCR1_SGPCS_DIS		0x0
+
+#define QSGMIIaCR0_RST_QSGM		BIT(31)
+#define QSGMIIaCR0_RST_QSGM_OFF		QSGMIIaCR0_RST_QSGM
+#define QSGMIIaCR0_RST_QSGM_ON		0
+#define QSGMIIaCR0_PD_QSGM		BIT(30)
+
+/* Per PLL registers */
+#define PLLnCR0(pll)			((pll) * 0x20 + 0x4)
+
+#define PLLnCR0_POFF			BIT(31)
+
+#define PLLnCR0_REFCLK_SEL		GENMASK(30, 28)
+#define PLLnCR0_REFCLK_SEL_100MHZ	0x0
+#define PLLnCR0_REFCLK_SEL_125MHZ	0x1
+#define PLLnCR0_REFCLK_SEL_156MHZ	0x2
+#define PLLnCR0_REFCLK_SEL_150MHZ	0x3
+#define PLLnCR0_REFCLK_SEL_161MHZ	0x4
+#define PLLnCR0_PLL_LCK			BIT(23)
+#define PLLnCR0_FRATE_SEL		GENMASK(19, 16)
+#define PLLnCR0_FRATE_5G		0x0
+#define PLLnCR0_FRATE_5_15625G		0x6
+#define PLLnCR0_FRATE_4G		0x7
+#define PLLnCR0_FRATE_3_125G		0x9
+#define PLLnCR0_FRATE_3G		0xa
+
+/* Per SerDes lane registers */
+
+/* Lane a Protocol Select status register */
+#define LNaPSSR0(lane)			(0x100 + (lane) * 0x20)
+#define LNaPSSR0_TYPE			GENMASK(30, 26)
+#define LNaPSSR0_IS_QUAD		GENMASK(25, 24)
+#define LNaPSSR0_MAC			GENMASK(19, 16)
+#define LNaPSSR0_PCS			GENMASK(10, 8)
+#define LNaPSSR0_LANE			GENMASK(2, 0)
+
+/* Lane a General Control Register */
+#define LNaGCR0(lane)			(0x800 + (lane) * 0x40 + 0x0)
+#define LNaGCR0_RPLL_PLLF		BIT(31)
+#define LNaGCR0_RPLL_PLLS		0x0
+#define LNaGCR0_RPLL_MSK		BIT(31)
+#define LNaGCR0_RRAT_SEL		GENMASK(29, 28)
+#define LNaGCR0_TRAT_SEL		GENMASK(25, 24)
+#define LNaGCR0_TPLL_PLLF		BIT(27)
+#define LNaGCR0_TPLL_PLLS		0x0
+#define LNaGCR0_TPLL_MSK		BIT(27)
+#define LNaGCR0_RRST_OFF		LNaGCR0_RRST
+#define LNaGCR0_TRST_OFF		LNaGCR0_TRST
+#define LNaGCR0_RRST_ON			0x0
+#define LNaGCR0_TRST_ON			0x0
+#define LNaGCR0_RRST			BIT(22)
+#define LNaGCR0_TRST			BIT(21)
+#define LNaGCR0_RX_PD			BIT(20)
+#define LNaGCR0_TX_PD			BIT(19)
+#define LNaGCR0_IF20BIT_EN		BIT(18)
+#define LNaGCR0_PROTS			GENMASK(11, 7)
+
+#define LNaGCR1(lane)			(0x800 + (lane) * 0x40 + 0x4)
+#define LNaGCR1_RDAT_INV		BIT(31)
+#define LNaGCR1_TDAT_INV		BIT(30)
+#define LNaGCR1_OPAD_CTL		BIT(26)
+#define LNaGCR1_REIDL_TH		GENMASK(22, 20)
+#define LNaGCR1_REIDL_EX_SEL		GENMASK(19, 18)
+#define LNaGCR1_REIDL_ET_SEL		GENMASK(17, 16)
+#define LNaGCR1_REIDL_EX_MSB		BIT(15)
+#define LNaGCR1_REIDL_ET_MSB		BIT(14)
+#define LNaGCR1_REQ_CTL_SNP		BIT(13)
+#define LNaGCR1_REQ_CDR_SNP		BIT(12)
+#define LNaGCR1_TRSTDIR			BIT(7)
+#define LNaGCR1_REQ_BIN_SNP		BIT(6)
+#define LNaGCR1_ISLEW_RCTL		GENMASK(5, 4)
+#define LNaGCR1_OSLEW_RCTL		GENMASK(1, 0)
+
+#define LNaRECR0(lane)			(0x800 + (lane) * 0x40 + 0x10)
+#define LNaRECR0_RXEQ_BST		BIT(28)
+#define LNaRECR0_GK2OVD			GENMASK(27, 24)
+#define LNaRECR0_GK3OVD			GENMASK(19, 16)
+#define LNaRECR0_GK2OVD_EN		BIT(15)
+#define LNaRECR0_GK3OVD_EN		BIT(14)
+#define LNaRECR0_OSETOVD_EN		BIT(13)
+#define LNaRECR0_BASE_WAND		GENMASK(11, 10)
+#define LNaRECR0_OSETOVD		GENMASK(6, 0)
+
+#define LNaTECR0(lane)			(0x800 + (lane) * 0x40 + 0x18)
+#define LNaTECR0_TEQ_TYPE		GENMASK(29, 28)
+#define LNaTECR0_SGN_PREQ		BIT(26)
+#define LNaTECR0_RATIO_PREQ		GENMASK(25, 22)
+#define LNaTECR0_SGN_POST1Q		BIT(21)
+#define LNaTECR0_RATIO_PST1Q		GENMASK(20, 16)
+#define LNaTECR0_ADPT_EQ		GENMASK(13, 8)
+#define LNaTECR0_AMP_RED		GENMASK(5, 0)
+
+#define LNaTTLCR0(lane)			(0x800 + (lane) * 0x40 + 0x20)
+#define LNaTTLCR1(lane)			(0x800 + (lane) * 0x40 + 0x24)
+#define LNaTTLCR2(lane)			(0x800 + (lane) * 0x40 + 0x28)
+
+#define LNaTCSR3(lane)			(0x800 + (lane) * 0x40 + 0x3C)
+#define LNaTCSR3_CDR_LCK		BIT(27)
+
+enum lynx_10g_rat_sel {
+	RAT_SEL_FULL = 0x0,
+	RAT_SEL_HALF = 0x1,
+	RAT_SEL_QUARTER = 0x2,
+	RAT_SEL_DOUBLE = 0x3,
+};
+
+enum lynx_10g_eq_type {
+	EQ_TYPE_NO_EQ = 0,
+	EQ_TYPE_2TAP = 1,
+	EQ_TYPE_3TAP = 2,
+};
+
+enum lynx_10g_proto_sel {
+	PROTO_SEL_PCIE = 0,
+	PROTO_SEL_SGMII_BASEX_KX_QSGMII = 1,
+	PROTO_SEL_SATA = 2,
+	PROTO_SEL_XAUI = 4,
+	PROTO_SEL_XFI_10GBASER_KR_SXGMII = 0xa,
+};
+
+struct lynx_10g_proto_conf {
+	int proto_sel;
+	int if20bit_en;
+	int reidl_th;
+	int reidl_et_msb;
+	int reidl_et_sel;
+	int reidl_ex_msb;
+	int reidl_ex_sel;
+	int islew_rctl;
+	int oslew_rctl;
+	int rxeq_bst;
+	int gk2ovd;
+	int gk3ovd;
+	int gk2ovd_en;
+	int gk3ovd_en;
+	int base_wand;
+	int teq_type;
+	int sgn_preq;
+	int ratio_preq;
+	int sgn_post1q;
+	int ratio_post1q;
+	int adpt_eq;
+	int amp_red;
+	int ttlcr0;
+};
+
+static const struct lynx_10g_proto_conf lynx_10g_proto_conf[LANE_MODE_MAX] = {
+	[LANE_MODE_1000BASEX_SGMII] = {
+		.proto_sel = PROTO_SEL_SGMII_BASEX_KX_QSGMII,
+		.reidl_th = 1,
+		.reidl_ex_sel = 3,
+		.reidl_et_msb = 1,
+		.islew_rctl = 1,
+		.oslew_rctl = 1,
+		.gk2ovd = 15,
+		.gk3ovd = 15,
+		.gk2ovd_en = 1,
+		.gk3ovd_en = 1,
+		.teq_type = EQ_TYPE_NO_EQ,
+		.adpt_eq = 48,
+		.amp_red = 6,
+		.ttlcr0 = 0x39000400,
+	},
+	[LANE_MODE_2500BASEX] = {
+		.proto_sel = PROTO_SEL_SGMII_BASEX_KX_QSGMII,
+		.islew_rctl = 2,
+		.oslew_rctl = 2,
+		.teq_type = EQ_TYPE_2TAP,
+		.sgn_post1q = 1,
+		.ratio_post1q = 6,
+		.adpt_eq = 48,
+		.ttlcr0 = 0x00000400,
+	},
+	[LANE_MODE_QSGMII] = {
+		.proto_sel = PROTO_SEL_SGMII_BASEX_KX_QSGMII,
+		.islew_rctl = 1,
+		.oslew_rctl = 1,
+		.teq_type = EQ_TYPE_2TAP,
+		.sgn_post1q = 1,
+		.ratio_post1q = 6,
+		.adpt_eq = 48,
+		.amp_red = 2,
+		.ttlcr0 = 0x00000400,
+	},
+	[LANE_MODE_10G_QXGMII] = {
+		.proto_sel = PROTO_SEL_XFI_10GBASER_KR_SXGMII,
+		.if20bit_en = 1,
+		.islew_rctl = 1,
+		.oslew_rctl = 1,
+		.base_wand = 1,
+		.teq_type = EQ_TYPE_NO_EQ,
+		.adpt_eq = 48,
+		.ttlcr0 = 0x00000400,
+	},
+	[LANE_MODE_USXGMII] = {
+		.proto_sel = PROTO_SEL_XFI_10GBASER_KR_SXGMII,
+		.if20bit_en = 1,
+		.islew_rctl = 1,
+		.oslew_rctl = 1,
+		.base_wand = 1,
+		.teq_type = EQ_TYPE_NO_EQ,
+		.sgn_post1q = 1,
+		.adpt_eq = 48,
+		.ttlcr0 = 0x00000400,
+	},
+	[LANE_MODE_10GBASER] = {
+		.proto_sel = PROTO_SEL_XFI_10GBASER_KR_SXGMII,
+		.if20bit_en = 1,
+		.islew_rctl = 2,
+		.oslew_rctl = 2,
+		.rxeq_bst = 1,
+		.base_wand = 1,
+		.teq_type = EQ_TYPE_2TAP,
+		.sgn_post1q = 1,
+		.ratio_post1q = 3,
+		.adpt_eq = 48,
+		.amp_red = 7,
+		.ttlcr0 = 0x00000400,
+	},
+};
+
+static void lynx_10g_cdr_lock_check(struct lynx_lane *lane)
+{
+	u32 tcsr3 = lynx_lane_read(lane, LNaTCSR3);
+
+	if (tcsr3 & LNaTCSR3_CDR_LCK)
+		return;
+
+	dev_dbg(&lane->phy->dev,
+		"Lane %c CDR unlocked, resetting receiver...\n",
+		'A' + lane->id);
+
+	lynx_lane_rmw(lane, LNaGCR0, LNaGCR0_RRST_ON, LNaGCR0_RRST);
+	usleep_range(1, 2);
+	lynx_lane_rmw(lane, LNaGCR0, LNaGCR0_RRST_OFF, LNaGCR0_RRST);
+
+	usleep_range(1, 2);
+}
+
+static void lynx_10g_pll_read_configuration(struct lynx_pll *pll)
+{
+	u32 val;
+
+	val = lynx_pll_read(pll, PLLnCR0);
+	pll->frate_sel = FIELD_GET(PLLnCR0_FRATE_SEL, val);
+	pll->refclk_sel = FIELD_GET(PLLnCR0_REFCLK_SEL, val);
+	pll->enabled = !(val & PLLnCR0_POFF);
+	pll->locked = !!(val & PLLnCR0_PLL_LCK);
+
+	if (!pll->enabled)
+		return;
+
+	switch (pll->frate_sel) {
+	case PLLnCR0_FRATE_5G:
+		/* 5GHz clock net */
+		__set_bit(LANE_MODE_1000BASEX_SGMII, pll->supported);
+		__set_bit(LANE_MODE_QSGMII, pll->supported);
+		break;
+	case PLLnCR0_FRATE_3_125G:
+		__set_bit(LANE_MODE_2500BASEX, pll->supported);
+		break;
+	case PLLnCR0_FRATE_5_15625G:
+		/* 10.3125GHz clock net */
+		__set_bit(LANE_MODE_10GBASER, pll->supported);
+		__set_bit(LANE_MODE_USXGMII, pll->supported);
+		__set_bit(LANE_MODE_10G_QXGMII, pll->supported);
+		break;
+	default:
+		break;
+	}
+}
+
+/* On LS1028A, SGMIIA_CFG, SGMIIB_CFG, and SGMIIC_CFG from PCCR8 have the
+ * ability to map either an ENETC PCS (PCCR8_SGMIIa_CFG=2) or a Felix switch
+ * PCS (PCCR8_SGMIIa_CFG=1) to the same lane.
+ *
+ * On LS1088A, the same QSGMII PCS B can be connected to SerDes lane 1
+ * (PCCR9_QSGMIIa_CFG=1) or to lane 3 (PCCR9_QSGMIIa_CFG=2).
+ *
+ * The PHY API lacks the capability to distinguish anything about the consumer,
+ * so we don't support changing the initial muxing done by the RCW.
+ *
+ * However, after disabling a PCS through PCCR8, we need to properly restore
+ * the original value to keep the same muxing, and for that we need to back
+ * it up (here).
+ */
+static void lynx_10g_backup_pccr_val(struct lynx_lane *lane)
+{
+	u32 val;
+	int err;
+
+	if (lane->mode == LANE_MODE_UNKNOWN)
+		return;
+
+	err = lynx_pccr_read(lane, lane->mode, &val);
+	if (err) {
+		dev_warn(&lane->phy->dev,
+			 "The driver doesn't know how to access the PCCR for lane mode %s\n",
+			 lynx_lane_mode_str(lane->mode));
+		lane->mode = LANE_MODE_UNKNOWN;
+		return;
+	}
+
+	lane->default_pccr[lane->mode] = val;
+
+	/* 1000Base-X, 1000Base-KX, 2500Base-KX and SGMII use the same PCCR8.
+	 * Only the KX bit differs (set for 1000Base-KX). Since we back up PCCR
+	 * values per lane mode, make sure to not back up the PCCR8 value with
+	 * the KX bit set for the non-KX modes, if the lane was in KX mode at
+	 * boot time. Just preserve bits 2:0, which tell whether the (and
+	 * which) 1G PCS was enabled.
+	 */
+	switch (lane->mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		lane->default_pccr[LANE_MODE_1000BASEX_SGMII] = val & ~PCCR8_SGMIIa_KX;
+		lane->default_pccr[LANE_MODE_2500BASEX] = val & ~PCCR8_SGMIIa_KX;
+		break;
+	default:
+		break;
+	}
+}
+
+/* Is the PCS enabled, according to the value backed up from the PCCR register
+ * for this lane mode?
+ *
+ * Normally we'd need to ask "what lane mode are we talking about?", but the
+ * answer is invariably the same regardless - PCCR8_SGMIIa_CFG has the same
+ * layout as PCCR9_QSGMIIa_CFG, PCCRB_XFIa_CFG etc etc, and the value 0
+ * universally means "PCS disabled". So this is just a shorthand answer.
+ */
+static bool lynx_10g_pccr_val_enabled(u32 pccr)
+{
+	return FIELD_PREP(PCCR8_SGMIIa_CFG, pccr) != 0;
+}
+
+static bool lynx_10g_lane_is_3_125g(struct lynx_lane *lane)
+{
+	struct lynx_priv *priv = lane->priv;
+	struct lynx_pll *pll;
+	u32 gcr0;
+
+	gcr0 = lynx_lane_read(lane, LNaGCR0);
+
+	if (gcr0 & LNaGCR0_TPLL_PLLF)
+		pll = &priv->pll[0];
+	else
+		pll = &priv->pll[1];
+
+	if (pll->frate_sel != PLLnCR0_FRATE_3_125G)
+		return false;
+
+	if (FIELD_GET(LNaGCR0_TRAT_SEL, gcr0) != RAT_SEL_FULL ||
+	    FIELD_GET(LNaGCR0_RRAT_SEL, gcr0) != RAT_SEL_FULL)
+		return false;
+
+	return true;
+}
+
+static void lynx_10g_lane_read_configuration(struct lynx_lane *lane)
+{
+	u32 pssr0 = lynx_lane_read(lane, LNaPSSR0);
+	struct lynx_priv *priv = lane->priv;
+	int proto;
+
+	proto = FIELD_GET(LNaPSSR0_TYPE, pssr0);
+	switch (proto) {
+	case PROTO_SEL_SGMII_BASEX_KX_QSGMII:
+		if (lynx_10g_lane_is_3_125g(lane))
+			lane->mode = LANE_MODE_2500BASEX;
+		else if (FIELD_GET(LNaPSSR0_IS_QUAD, pssr0))
+			lane->mode = LANE_MODE_QSGMII;
+		else
+			lane->mode = LANE_MODE_1000BASEX_SGMII;
+		break;
+	case PROTO_SEL_XFI_10GBASER_KR_SXGMII:
+		if (FIELD_GET(LNaPSSR0_IS_QUAD, pssr0))
+			lane->mode = LANE_MODE_10G_QXGMII;
+		else if (priv->info->quirks & LYNX_QUIRK_HAS_HARDCODED_USXGMII)
+			lane->mode = LANE_MODE_USXGMII;
+		else
+			lane->mode = LANE_MODE_10GBASER;
+		break;
+	case PROTO_SEL_PCIE:
+	case PROTO_SEL_SATA:
+	case PROTO_SEL_XAUI:
+		break;
+	default:
+		dev_warn(&lane->phy->dev, "Unknown lane protocol 0x%x\n",
+			 proto);
+	}
+
+	lynx_10g_backup_pccr_val(lane);
+}
+
+static int ls1028a_get_pccr(enum lynx_lane_mode lane_mode, int lane,
+			    struct lynx_pccr *pccr)
+{
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		pccr->offset = PCCR8;
+		pccr->width = 4;
+		pccr->shift = SGMII_CFG(lane);
+		break;
+	case LANE_MODE_QSGMII:
+		if (lane != 1)
+			return -EINVAL;
+
+		pccr->offset = PCCR9;
+		pccr->width = 3;
+		pccr->shift = QSGMII_CFG(A);
+		break;
+	case LANE_MODE_10G_QXGMII:
+		if (lane != 1)
+			return -EINVAL;
+
+		pccr->offset = PCCR9;
+		pccr->width = 3;
+		pccr->shift = QXGMII_CFG(A);
+		break;
+	case LANE_MODE_USXGMII:
+		if (lane != 0)
+			return -EINVAL;
+
+		pccr->offset = PCCRB;
+		pccr->width = 3;
+		pccr->shift = SXGMII_CFG(A);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ls1028a_get_pcvt_offset(int lane, enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		return SGMIIaCR0(lane);
+	case LANE_MODE_QSGMII:
+		return lane == 1 ? QSGMIIaCR0(A) : -EINVAL;
+	case LANE_MODE_USXGMII:
+		return lane == 0 ? SXGMIIaCR0(A) : -EINVAL;
+	case LANE_MODE_10G_QXGMII:
+		return lane == 1 ? QXGMIIaCR0(A) : -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct lynx_info lynx_info_ls1028a = {
+	.get_pccr = ls1028a_get_pccr,
+	.get_pcvt_offset = ls1028a_get_pcvt_offset,
+	.pll_read_configuration = lynx_10g_pll_read_configuration,
+	.lane_read_configuration = lynx_10g_lane_read_configuration,
+	.cdr_lock_check = lynx_10g_cdr_lock_check,
+	.num_lanes = 4,
+	.index = 1,
+	.quirks = LYNX_QUIRK_HAS_HARDCODED_USXGMII,
+};
+
+static int ls1046a_serdes1_get_pccr(enum lynx_lane_mode lane_mode, int lane,
+				    struct lynx_pccr *pccr)
+{
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		pccr->offset = PCCR8;
+		pccr->width = 4;
+		pccr->shift = SGMII_CFG(lane);
+		break;
+	case LANE_MODE_QSGMII:
+		if (lane != 1)
+			return -EINVAL;
+
+		pccr->offset = PCCR9;
+		pccr->width = 3;
+		pccr->shift = QSGMII_CFG(B);
+		break;
+	case LANE_MODE_10GBASER:
+		switch (lane) {
+		case 2:
+			pccr->shift = XFI_CFG(A);
+			break;
+		case 3:
+			pccr->shift = XFI_CFG(B);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		pccr->offset = PCCRB;
+		pccr->width = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ls1046a_serdes1_get_pcvt_offset(int lane, enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		return SGMIIaCR0(lane);
+	case LANE_MODE_QSGMII:
+		if (lane != 1)
+			return -EINVAL;
+
+		return QSGMIIaCR0(B);
+	case LANE_MODE_10GBASER:
+		switch (lane) {
+		case 2:
+			return XFIaCR0(A);
+		case 3:
+			return XFIaCR0(B);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct lynx_info lynx_info_ls1046a_serdes1 = {
+	.get_pccr = ls1046a_serdes1_get_pccr,
+	.get_pcvt_offset = ls1046a_serdes1_get_pcvt_offset,
+	.pll_read_configuration = lynx_10g_pll_read_configuration,
+	.lane_read_configuration = lynx_10g_lane_read_configuration,
+	.cdr_lock_check = lynx_10g_cdr_lock_check,
+	.num_lanes = 4,
+	.index = 1,
+};
+
+static int ls1046a_serdes2_get_pccr(enum lynx_lane_mode lane_mode, int lane,
+				    struct lynx_pccr *pccr)
+{
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		if (lane != 1)
+			return -EINVAL;
+
+		pccr->offset = PCCR8;
+		pccr->width = 4;
+		pccr->shift = SGMII_CFG(B);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ls1046a_serdes2_get_pcvt_offset(int lane, enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		if (lane != 1)
+			return -EINVAL;
+
+		return SGMIIaCR0(B);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct lynx_info lynx_info_ls1046a_serdes2 = {
+	.get_pccr = ls1046a_serdes2_get_pccr,
+	.get_pcvt_offset = ls1046a_serdes2_get_pcvt_offset,
+	.pll_read_configuration = lynx_10g_pll_read_configuration,
+	.lane_read_configuration = lynx_10g_lane_read_configuration,
+	.cdr_lock_check = lynx_10g_cdr_lock_check,
+	.num_lanes = 4,
+	.index = 2,
+};
+
+static int ls1088a_serdes1_get_pccr(enum lynx_lane_mode lane_mode, int lane,
+				    struct lynx_pccr *pccr)
+{
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		pccr->offset = PCCR8;
+		pccr->width = 4;
+		pccr->shift = SGMII_CFG(lane);
+		break;
+	case LANE_MODE_QSGMII:
+		switch (lane) {
+		case 0:
+			pccr->shift = QSGMII_CFG(A);
+			break;
+		case 1:
+		case 3:
+			pccr->shift = QSGMII_CFG(B);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		pccr->offset = PCCR9;
+		pccr->width = 3;
+		break;
+	case LANE_MODE_10GBASER:
+		switch (lane) {
+		case 2:
+			pccr->shift = XFI_CFG(A);
+			break;
+		case 3:
+			pccr->shift = XFI_CFG(B);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		pccr->offset = PCCRB;
+		pccr->width = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ls1088a_serdes1_get_pcvt_offset(int lane, enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		return SGMIIaCR0(lane);
+	case LANE_MODE_QSGMII:
+		switch (lane) {
+		case 0:
+			return QSGMIIaCR0(A);
+		case 1:
+		case 3:
+			return QSGMIIaCR0(B);
+		default:
+			return -EINVAL;
+		}
+	case LANE_MODE_10GBASER:
+		switch (lane) {
+		case 2:
+			return XFIaCR0(A);
+		case 3:
+			return XFIaCR0(B);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct lynx_info lynx_info_ls1088a_serdes1 = {
+	.get_pccr = ls1088a_serdes1_get_pccr,
+	.get_pcvt_offset = ls1088a_serdes1_get_pcvt_offset,
+	.pll_read_configuration = lynx_10g_pll_read_configuration,
+	.lane_read_configuration = lynx_10g_lane_read_configuration,
+	.cdr_lock_check = lynx_10g_cdr_lock_check,
+	.num_lanes = 4,
+	.index = 1,
+};
+
+static int ls2088a_serdes1_get_pccr(enum lynx_lane_mode lane_mode, int lane,
+				    struct lynx_pccr *pccr)
+{
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		pccr->offset = PCCR8;
+		pccr->width = 4;
+		pccr->shift = SGMII_CFG(lane);
+		break;
+	case LANE_MODE_QSGMII:
+		switch (lane) {
+		case 2:
+		case 6:
+			pccr->shift = QSGMII_CFG(A);
+			break;
+		case 7:
+			pccr->shift = QSGMII_CFG(B);
+			break;
+		case 0:
+		case 4:
+			pccr->shift = QSGMII_CFG(C);
+			break;
+		case 1:
+		case 5:
+			pccr->shift = QSGMII_CFG(D);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		pccr->offset = PCCR9;
+		pccr->width = 3;
+		break;
+	case LANE_MODE_10GBASER:
+		pccr->offset = PCCRB;
+		pccr->width = 3;
+		pccr->shift = XFI_CFG(lane);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ls2088a_serdes1_get_pcvt_offset(int lane, enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		return SGMIIaCR0(lane);
+	case LANE_MODE_QSGMII:
+		switch (lane) {
+		case 2:
+		case 6:
+			return QSGMIIaCR0(A);
+		case 7:
+			return QSGMIIaCR0(B);
+		case 0:
+		case 4:
+			return QSGMIIaCR0(C);
+		case 1:
+		case 5:
+			return QSGMIIaCR0(D);
+		default:
+			return -EINVAL;
+		}
+	case LANE_MODE_10GBASER:
+		return XFIaCR0(lane);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct lynx_info lynx_info_ls2088a_serdes1 = {
+	.get_pccr = ls2088a_serdes1_get_pccr,
+	.get_pcvt_offset = ls2088a_serdes1_get_pcvt_offset,
+	.pll_read_configuration = lynx_10g_pll_read_configuration,
+	.lane_read_configuration = lynx_10g_lane_read_configuration,
+	.cdr_lock_check = lynx_10g_cdr_lock_check,
+	.num_lanes = 8,
+	.index = 1,
+};
+
+static int ls2088a_serdes2_get_pccr(enum lynx_lane_mode lane_mode, int lane,
+				    struct lynx_pccr *pccr)
+{
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		pccr->offset = PCCR8;
+		pccr->width = 4;
+		pccr->shift = SGMII_CFG(lane);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ls2088a_serdes2_get_pcvt_offset(int lane, enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		return SGMIIaCR0(lane);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct lynx_info lynx_info_ls2088a_serdes2 = {
+	.get_pccr = ls2088a_serdes2_get_pccr,
+	.get_pcvt_offset = ls2088a_serdes2_get_pcvt_offset,
+	.pll_read_configuration = lynx_10g_pll_read_configuration,
+	.lane_read_configuration = lynx_10g_lane_read_configuration,
+	.cdr_lock_check = lynx_10g_cdr_lock_check,
+	.num_lanes = 8,
+	.index = 2,
+};
+
+/* Halting puts the lane in a mode in which it can be reconfigured */
+static void lynx_10g_lane_halt(struct phy *phy)
+{
+	struct lynx_lane *lane = phy_get_drvdata(phy);
+
+	/* Issue a reset request */
+	lynx_lane_rmw(lane, LNaGCR0,
+		      LNaGCR0_RRST_ON | LNaGCR0_TRST_ON,
+		      LNaGCR0_RRST | LNaGCR0_TRST);
+
+	/* The RM says to wait for at least 50ns */
+	usleep_range(1, 2);
+}
+
+static void lynx_10g_lane_reset(struct phy *phy)
+{
+	struct lynx_lane *lane = phy_get_drvdata(phy);
+
+	/* Finalize the reset request */
+	lynx_lane_rmw(lane, LNaGCR0,
+		      LNaGCR0_RRST_OFF | LNaGCR0_TRST_OFF,
+		      LNaGCR0_RRST | LNaGCR0_TRST);
+}
+
+static int lynx_10g_power_off(struct phy *phy)
+{
+	struct lynx_lane *lane = phy_get_drvdata(phy);
+
+	if (!lane->powered_up)
+		return 0;
+
+	/* Issue a reset request with the power down bits set */
+	lynx_lane_rmw(lane, LNaGCR0,
+		      LNaGCR0_RRST_ON | LNaGCR0_TRST_ON |
+		      LNaGCR0_RX_PD | LNaGCR0_TX_PD,
+		      LNaGCR0_RRST | LNaGCR0_TRST |
+		      LNaGCR0_RX_PD | LNaGCR0_TX_PD);
+
+	/* The RM says to wait for at least 50ns */
+	usleep_range(1, 2);
+
+	lane->powered_up = false;
+
+	return 0;
+}
+
+static int lynx_10g_power_on(struct phy *phy)
+{
+	struct lynx_lane *lane = phy_get_drvdata(phy);
+
+	if (lane->powered_up)
+		return 0;
+
+	/* RM says that to enable a previously powered down lane, set
+	 * LNmGCR0[{R,T}X_PD]=0, wait 15 us, then set LNmGCR0[{R,T}RST]=1.
+	 */
+	lynx_lane_rmw(lane, LNaGCR0, 0, LNaGCR0_RX_PD | LNaGCR0_TX_PD);
+	usleep_range(150, 300);
+	lynx_10g_lane_reset(phy);
+
+	lane->powered_up = true;
+
+	return 0;
+}
+
+static void lynx_10g_lane_set_nrate(struct lynx_lane *lane,
+				    struct lynx_pll *pll,
+				    enum lynx_lane_mode mode)
+{
+	enum lynx_10g_rat_sel nrate;
+
+	switch (pll->frate_sel) {
+	case PLLnCR0_FRATE_5G:
+		switch (mode) {
+		case LANE_MODE_1000BASEX_SGMII:
+			nrate = RAT_SEL_QUARTER;
+			break;
+		case LANE_MODE_QSGMII:
+			nrate = RAT_SEL_FULL;
+			break;
+		default:
+			return;
+		}
+		break;
+	case PLLnCR0_FRATE_3_125G:
+		switch (mode) {
+		case LANE_MODE_2500BASEX:
+			nrate = RAT_SEL_FULL;
+			break;
+		default:
+			return;
+		}
+		break;
+	case PLLnCR0_FRATE_5_15625G:
+		switch (mode) {
+		case LANE_MODE_10GBASER:
+		case LANE_MODE_USXGMII:
+		case LANE_MODE_10G_QXGMII:
+			nrate = RAT_SEL_DOUBLE;
+			break;
+		default:
+			return;
+		}
+		break;
+	default:
+		return;
+	}
+
+	lynx_lane_rmw(lane, LNaGCR0,
+		      FIELD_PREP(LNaGCR0_TRAT_SEL, nrate) |
+		      FIELD_PREP(LNaGCR0_RRAT_SEL, nrate),
+		      LNaGCR0_RRAT_SEL | LNaGCR0_TRAT_SEL);
+}
+
+static void lynx_10g_lane_set_pll(struct lynx_lane *lane,
+				  struct lynx_pll *pll)
+{
+	if (pll->id == 0) {
+		lynx_lane_rmw(lane, LNaGCR0,
+			      LNaGCR0_RPLL_PLLF | LNaGCR0_TPLL_PLLF,
+			      LNaGCR0_RPLL_MSK | LNaGCR0_TPLL_MSK);
+	} else {
+		lynx_lane_rmw(lane, LNaGCR0,
+			      LNaGCR0_RPLL_PLLS | LNaGCR0_TPLL_PLLS,
+			      LNaGCR0_RPLL_MSK | LNaGCR0_TPLL_MSK);
+	}
+}
+
+static void lynx_10g_lane_remap_pll(struct lynx_lane *lane,
+				    enum lynx_lane_mode lane_mode)
+{
+	struct lynx_priv *priv = lane->priv;
+	struct lynx_pll *pll;
+
+	/* Switch to the PLL that works with this interface type */
+	pll = lynx_pll_get(priv, lane_mode);
+	if (unlikely(!pll))
+		return;
+
+	lynx_10g_lane_set_pll(lane, pll);
+
+	/* Choose the portion of clock net to be used on this lane */
+	lynx_10g_lane_set_nrate(lane, pll, lane_mode);
+}
+
+static void lynx_10g_lane_change_proto_conf(struct lynx_lane *lane,
+					    enum lynx_lane_mode mode)
+{
+	const struct lynx_10g_proto_conf *conf = &lynx_10g_proto_conf[mode];
+
+	lynx_lane_rmw(lane, LNaGCR0,
+		      FIELD_PREP(LNaGCR0_PROTS, conf->proto_sel) |
+		      FIELD_PREP(LNaGCR0_IF20BIT_EN, conf->if20bit_en),
+		      LNaGCR0_PROTS | LNaGCR0_IF20BIT_EN);
+	lynx_lane_rmw(lane, LNaGCR1,
+		      FIELD_PREP(LNaGCR1_REIDL_TH, conf->reidl_th) |
+		      FIELD_PREP(LNaGCR1_REIDL_ET_MSB, conf->reidl_et_msb) |
+		      FIELD_PREP(LNaGCR1_REIDL_ET_SEL, conf->reidl_et_sel) |
+		      FIELD_PREP(LNaGCR1_REIDL_EX_MSB, conf->reidl_ex_msb) |
+		      FIELD_PREP(LNaGCR1_REIDL_EX_SEL, conf->reidl_ex_sel) |
+		      FIELD_PREP(LNaGCR1_ISLEW_RCTL, conf->islew_rctl) |
+		      FIELD_PREP(LNaGCR1_OSLEW_RCTL, conf->oslew_rctl),
+		      LNaGCR1_REIDL_TH |
+		      LNaGCR1_REIDL_ET_MSB | LNaGCR1_REIDL_ET_SEL |
+		      LNaGCR1_REIDL_EX_MSB | LNaGCR1_REIDL_EX_SEL |
+		      LNaGCR1_ISLEW_RCTL | LNaGCR1_OSLEW_RCTL);
+	lynx_lane_rmw(lane, LNaRECR0,
+		      FIELD_PREP(LNaRECR0_RXEQ_BST, conf->rxeq_bst) |
+		      FIELD_PREP(LNaRECR0_GK2OVD, conf->gk2ovd) |
+		      FIELD_PREP(LNaRECR0_GK3OVD, conf->gk3ovd) |
+		      FIELD_PREP(LNaRECR0_GK2OVD_EN, conf->gk2ovd_en) |
+		      FIELD_PREP(LNaRECR0_GK3OVD_EN, conf->gk3ovd_en) |
+		      FIELD_PREP(LNaRECR0_BASE_WAND, conf->base_wand),
+		      LNaRECR0_RXEQ_BST | LNaRECR0_GK2OVD | LNaRECR0_GK3OVD |
+		      LNaRECR0_GK2OVD_EN | LNaRECR0_GK3OVD_EN |
+		      LNaRECR0_BASE_WAND);
+	lynx_lane_rmw(lane, LNaTECR0,
+		      FIELD_PREP(LNaTECR0_TEQ_TYPE, conf->teq_type) |
+		      FIELD_PREP(LNaTECR0_SGN_PREQ, conf->sgn_preq) |
+		      FIELD_PREP(LNaTECR0_RATIO_PREQ, conf->ratio_preq) |
+		      FIELD_PREP(LNaTECR0_SGN_POST1Q, conf->sgn_post1q) |
+		      FIELD_PREP(LNaTECR0_RATIO_PST1Q, conf->ratio_post1q) |
+		      FIELD_PREP(LNaTECR0_ADPT_EQ, conf->adpt_eq) |
+		      FIELD_PREP(LNaTECR0_AMP_RED, conf->amp_red),
+		      LNaTECR0_TEQ_TYPE | LNaTECR0_SGN_PREQ |
+		      LNaTECR0_RATIO_PREQ | LNaTECR0_SGN_POST1Q |
+		      LNaTECR0_RATIO_PST1Q | LNaTECR0_ADPT_EQ |
+		      LNaTECR0_AMP_RED);
+	lynx_lane_write(lane, LNaTTLCR0, conf->ttlcr0);
+}
+
+static int lynx_10g_lane_disable_pcvt(struct lynx_lane *lane,
+				      enum lynx_lane_mode mode)
+{
+	struct lynx_priv *priv = lane->priv;
+	int err;
+
+	spin_lock(&priv->pcc_lock);
+
+	err = lynx_pccr_write(lane, mode, 0);
+	if (err)
+		goto out;
+
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		err = lynx_pcvt_rmw(lane, mode, CR(1), SGMIIaCR1_SGPCS_DIS,
+				    SGMIIaCR1_SGPCS_EN);
+		if (err)
+			goto out;
+
+		lynx_pcvt_rmw(lane, mode, CR(0),
+			      SGMIIaCR0_RST_SGM_ON | SGMIIaCR0_PD_SGM,
+			      SGMIIaCR0_RST_SGM | SGMIIaCR0_PD_SGM);
+		break;
+	case LANE_MODE_QSGMII:
+		err = lynx_pcvt_rmw(lane, mode, CR(0),
+				    QSGMIIaCR0_RST_QSGM_ON | QSGMIIaCR0_PD_QSGM,
+				    QSGMIIaCR0_RST_QSGM | QSGMIIaCR0_PD_QSGM);
+		if (err)
+			goto out;
+		break;
+	default:
+		err = 0;
+	}
+
+out:
+	spin_unlock(&priv->pcc_lock);
+
+	return err;
+}
+
+static int lynx_10g_lane_enable_pcvt(struct lynx_lane *lane,
+				     enum lynx_lane_mode mode)
+{
+	struct lynx_priv *priv = lane->priv;
+	u32 val;
+	int err;
+
+	spin_lock(&priv->pcc_lock);
+
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		err = lynx_pcvt_rmw(lane, mode, CR(1), SGMIIaCR1_SGPCS_EN,
+				    SGMIIaCR1_SGPCS_EN);
+		if (err)
+			goto out;
+
+		lynx_pcvt_rmw(lane, mode, CR(0), SGMIIaCR0_RST_SGM_OFF,
+			      SGMIIaCR0_RST_SGM | SGMIIaCR0_PD_SGM);
+		break;
+	case LANE_MODE_QSGMII:
+		err = lynx_pcvt_rmw(lane, mode, CR(0), QSGMIIaCR0_RST_QSGM_OFF,
+				    QSGMIIaCR0_RST_QSGM | QSGMIIaCR0_PD_QSGM);
+		if (err)
+			goto out;
+		break;
+	default:
+		err = 0;
+	}
+
+	/* If the PCS was enabled at boot time, use the backed up PCCR value to
+	 * re-enable it here, to preserve the muxing.
+	 */
+	if (lynx_10g_pccr_val_enabled(lane->default_pccr[mode])) {
+		err = lynx_pccr_write(lane, mode, lane->default_pccr[mode]);
+		goto out;
+	}
+
+	/* If the PCS was not enabled, set the PCCR to a default value which
+	 * enables it (1). The assumption is that this is the only PCS <->
+	 * SerDes lane muxing value possible.
+	 *
+	 * This is mostly useful for SGMII <-> 10GBase-R major protocol
+	 * reconfiguration, where at boot time, either the SGMII or the
+	 * 10GBase-R PCS is enabled for the lane, but not both.
+	 *
+	 * In fact, if there are multiple lane muxing options, this function
+	 * will most likely not choose the right one. For correct functionality
+	 * there, we assume that the PCS we are enabling here was found enabled
+	 * at boot time (reset default, or through PBL, or...), and we preserve
+	 * its muxing through the default_pccr branch above.
+	 */
+	val = 0;
+
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		val |= FIELD_PREP(PCCR8_SGMIIa_CFG, 1);
+		break;
+	case LANE_MODE_QSGMII:
+		val |= FIELD_PREP(PCCR9_QSGMIIa_CFG, 1);
+		break;
+	case LANE_MODE_10G_QXGMII:
+		val |= FIELD_PREP(PCCR9_QXGMIIa_CFG, 1);
+		break;
+	case LANE_MODE_10GBASER:
+		val |= FIELD_PREP(PCCRB_XFIa_CFG, 1);
+		break;
+	case LANE_MODE_USXGMII:
+		val |= FIELD_PREP(PCCRB_SXGMIIa_CFG, 1);
+		break;
+	default:
+		err = 0;
+		goto out;
+	}
+
+	err = lynx_pccr_write(lane, mode, val);
+out:
+	spin_unlock(&priv->pcc_lock);
+
+	return err;
+}
+
+static bool lynx_10g_lane_mode_needs_rcw_override(struct lynx_lane *lane,
+						  enum lynx_lane_mode new)
+{
+	enum lynx_lane_mode curr = lane->mode;
+
+	/* Major protocol changes, which involve changing the PCS connection to
+	 * the GMII MAC with the one to the XGMII MAC, require an RCW override
+	 * procedure to reconfigure an internal mux, as documented here:
+	 * https://lore.kernel.org/linux-phy/20230810102631.bvozjer3t67r67iy@skbuf/
+	 * This is SoC-specific, and not yet implemented in drivers/soc/fsl/guts.c.
+	 *
+	 * So the supported set of protocols depends on the initial lane mode.
+	 *
+	 * Minor protocol changes (SGMII <-> 1000Base-X <-> 2500Base-X or
+	 * 10GBase-R <-> USXGMII) are supported.
+	 */
+	if ((lynx_lane_mode_uses_gmii_mac(curr) &&
+	     lynx_lane_mode_uses_xgmii_mac(new)) ||
+	    (lynx_lane_mode_uses_xgmii_mac(curr) &&
+	     lynx_lane_mode_uses_gmii_mac(new)))
+		return true;
+
+	return false;
+}
+
+static int lynx_10g_validate(struct phy *phy, enum phy_mode mode, int submode,
+			     union phy_configure_opts *opts)
+{
+	struct lynx_lane *lane = phy_get_drvdata(phy);
+	enum lynx_lane_mode lane_mode;
+	int err;
+
+	err = lynx_phy_mode_to_lane_mode(phy, mode, submode, &lane_mode);
+	if (err)
+		return err;
+
+	if (lynx_10g_lane_mode_needs_rcw_override(lane, lane_mode))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int lynx_10g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct lynx_lane *lane = phy_get_drvdata(phy);
+	bool powered_up = lane->powered_up;
+	enum lynx_lane_mode lane_mode;
+	int err;
+
+	err = lynx_10g_validate(phy, mode, submode, NULL);
+	if (err)
+		return err;
+
+	lane_mode = phy_interface_to_lane_mode(submode);
+	/* lynx_10g_validate() already made sure the lane_mode is supported */
+
+	if (lane_mode == lane->mode)
+		return 0;
+
+	/* If the lane is powered up, put the lane into the halt state while
+	 * the reconfiguration is being done.
+	 */
+	if (powered_up)
+		lynx_10g_lane_halt(phy);
+
+	err = lynx_10g_lane_disable_pcvt(lane, lane->mode);
+	if (err)
+		goto out;
+
+	lynx_10g_lane_change_proto_conf(lane, lane_mode);
+	lynx_10g_lane_remap_pll(lane, lane_mode);
+	WARN_ON(lynx_10g_lane_enable_pcvt(lane, lane_mode));
+
+	lane->mode = lane_mode;
+
+out:
+	if (powered_up) {
+		/* The RM says to wait for at least 120 ns */
+		usleep_range(1, 2);
+		lynx_10g_lane_reset(phy);
+	}
+
+	return err;
+}
+
+static int lynx_10g_init(struct phy *phy)
+{
+	struct lynx_lane *lane = phy_get_drvdata(phy);
+
+	/* Mark the fact that the lane was init */
+	lane->init = true;
+
+	/* SerDes lanes are powered on at boot time. Any lane that is
+	 * managed by this driver will get powered off when its consumer
+	 * calls phy_init().
+	 */
+	lane->powered_up = true;
+	lynx_10g_power_off(phy);
+
+	return 0;
+}
+
+static int lynx_10g_exit(struct phy *phy)
+{
+	struct lynx_lane *lane = phy_get_drvdata(phy);
+
+	/* The lane returns to the state where it isn't managed by the
+	 * consumer, so we must treat is as if it isn't initialized, and always
+	 * powered on.
+	 */
+	lane->init = false;
+	lane->powered_up = false;
+	lynx_10g_power_on(phy);
+
+	return 0;
+}
+
+static const struct phy_ops lynx_10g_ops = {
+	.init		= lynx_10g_init,
+	.exit		= lynx_10g_exit,
+	.power_on	= lynx_10g_power_on,
+	.power_off	= lynx_10g_power_off,
+	.set_mode	= lynx_10g_set_mode,
+	.validate	= lynx_10g_validate,
+	.owner		= THIS_MODULE,
+};
+
+static int lynx_10g_probe(struct platform_device *pdev)
+{
+	return lynx_probe(pdev, of_device_get_match_data(&pdev->dev),
+			  &lynx_10g_ops);
+}
+
+static const struct of_device_id lynx_10g_of_match_table[] = {
+	{ .compatible = "fsl,ls1028a-serdes", .data = &lynx_info_ls1028a },
+	{ .compatible = "fsl,ls1046a-serdes1", .data = &lynx_info_ls1046a_serdes1 },
+	{ .compatible = "fsl,ls1046a-serdes2", .data = &lynx_info_ls1046a_serdes2 },
+	{ .compatible = "fsl,ls1088a-serdes1", .data = &lynx_info_ls1088a_serdes1 },
+	{ .compatible = "fsl,ls2088a-serdes1", .data = &lynx_info_ls2088a_serdes1 },
+	{ .compatible = "fsl,ls2088a-serdes2", .data = &lynx_info_ls2088a_serdes2 },
+	{}
+};
+MODULE_DEVICE_TABLE(of, lynx_10g_of_match_table);
+
+static struct platform_driver lynx_10g_driver = {
+	.probe	= lynx_10g_probe,
+	.remove	= lynx_remove,
+	.driver	= {
+		.name = "lynx-10g",
+		.of_match_table = lynx_10g_of_match_table,
+	},
+};
+module_platform_driver(lynx_10g_driver);
+
+MODULE_IMPORT_NS("PHY_FSL_LYNX");
+MODULE_AUTHOR("Ioana Ciornei <ioana.ciornei@nxp.com>");
+MODULE_AUTHOR("Vladimir Oltean <vladimir.oltean@nxp.com>");
+MODULE_DESCRIPTION("Lynx 10G SerDes PHY driver for Layerscape SoCs");
+MODULE_LICENSE("GPL");
diff --git a/drivers/phy/freescale/phy-fsl-lynx-core.c b/drivers/phy/freescale/phy-fsl-lynx-core.c
index 1e411bfab404..2cfe9236ffc5 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-core.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-core.c
@@ -11,6 +11,12 @@ const char *lynx_lane_mode_str(enum lynx_lane_mode lane_mode)
 	switch (lane_mode) {
 	case LANE_MODE_1000BASEX_SGMII:
 		return "1000Base-X/SGMII";
+	case LANE_MODE_2500BASEX:
+		return "2500Base-X";
+	case LANE_MODE_QSGMII:
+		return "QSGMII";
+	case LANE_MODE_10G_QXGMII:
+		return "10G-QXGMII";
 	case LANE_MODE_10GBASER:
 		return "10GBase-R";
 	case LANE_MODE_USXGMII:
@@ -29,6 +35,12 @@ enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
 		return LANE_MODE_1000BASEX_SGMII;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		return LANE_MODE_2500BASEX;
+	case PHY_INTERFACE_MODE_QSGMII:
+		return LANE_MODE_QSGMII;
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+		return LANE_MODE_10G_QXGMII;
 	case PHY_INTERFACE_MODE_10GBASER:
 		return LANE_MODE_10GBASER;
 	case PHY_INTERFACE_MODE_USXGMII:
@@ -89,6 +101,29 @@ bool lynx_lane_supports_mode(struct lynx_lane *lane, enum lynx_lane_mode mode)
 }
 EXPORT_SYMBOL_NS_GPL(lynx_lane_supports_mode, "PHY_FSL_LYNX");
 
+/* The quad protocols are fixed because the lane has multiple consumers, and
+ * one phy_set_mode_ext() affects the other consumers as well. We have no use
+ * case for dynamic protocol changing here, so disallow it.
+ */
+static enum lynx_lane_mode lynx_fixed_protocols[] = {
+	LANE_MODE_QSGMII,
+	LANE_MODE_10G_QXGMII,
+};
+
+static bool lynx_lane_restrict_fixed_mode_change(struct lynx_lane *lane,
+						 enum lynx_lane_mode new)
+{
+	enum lynx_lane_mode curr = lane->mode;
+
+	for (int i = 0; i < ARRAY_SIZE(lynx_fixed_protocols); i++)
+		if ((curr == lynx_fixed_protocols[i] ||
+		     new == lynx_fixed_protocols[i]) &&
+		     curr != new)
+			return true;
+
+	return false;
+}
+
 /* Translate the mode/submode from phy_validate() and phy_set_mode_ext() to a
  * lane_mode and return 0 if it is supported and we can transition to it from
  * the current lane mode, or return negative error otherwise.
@@ -112,6 +147,9 @@ int lynx_phy_mode_to_lane_mode(struct phy *phy, enum phy_mode mode,
 	if (!lynx_lane_supports_mode(lane, tmp_lane_mode))
 		return -EINVAL;
 
+	if (lynx_lane_restrict_fixed_mode_change(lane, tmp_lane_mode))
+		return -EINVAL;
+
 	if (lane_mode)
 		*lane_mode = tmp_lane_mode;
 
diff --git a/drivers/phy/freescale/phy-fsl-lynx-core.h b/drivers/phy/freescale/phy-fsl-lynx-core.h
index 37fa4b544faa..a60429ba9324 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-core.h
+++ b/drivers/phy/freescale/phy-fsl-lynx-core.h
@@ -9,6 +9,7 @@
 #include <soc/fsl/phy-fsl-lynx.h>
 
 #define LYNX_NUM_PLL				2
+#define LYNX_QUIRK_HAS_HARDCODED_USXGMII	BIT(0)
 
 struct lynx_priv;
 struct lynx_lane;
@@ -36,6 +37,7 @@ struct lynx_lane {
 	bool init;
 	unsigned int id;
 	enum lynx_lane_mode mode;
+	u32 default_pccr[LANE_MODE_MAX];
 };
 
 struct lynx_info {
@@ -48,6 +50,8 @@ struct lynx_info {
 	void (*cdr_lock_check)(struct lynx_lane *lane);
 	int first_lane;
 	int num_lanes;
+	int index;
+	unsigned long quirks;
 };
 
 struct lynx_priv {
diff --git a/include/soc/fsl/phy-fsl-lynx.h b/include/soc/fsl/phy-fsl-lynx.h
index 92e8272d5ae1..ff5a7d1835b5 100644
--- a/include/soc/fsl/phy-fsl-lynx.h
+++ b/include/soc/fsl/phy-fsl-lynx.h
@@ -7,10 +7,37 @@
 enum lynx_lane_mode {
 	LANE_MODE_UNKNOWN,
 	LANE_MODE_1000BASEX_SGMII,
+	LANE_MODE_2500BASEX,
+	LANE_MODE_QSGMII,
+	LANE_MODE_10G_QXGMII,
 	LANE_MODE_10GBASER,
 	LANE_MODE_USXGMII,
 	LANE_MODE_25GBASER,
 	LANE_MODE_MAX,
 };
 
+static inline bool lynx_lane_mode_uses_gmii_mac(enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+	case LANE_MODE_QSGMII:
+	case LANE_MODE_10G_QXGMII:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool lynx_lane_mode_uses_xgmii_mac(enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_10GBASER:
+	case LANE_MODE_USXGMII:
+		return true;
+	default:
+		return false;
+	}
+}
+
 #endif /* __PHY_FSL_LYNX_H_ */
-- 
2.34.1


