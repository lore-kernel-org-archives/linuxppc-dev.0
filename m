Return-Path: <linuxppc-dev+bounces-22293-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DDACD6E79
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 22:18:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ5zD1Knxz2xdb;
	Tue, 09 Jun 2026 08:18:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780957112;
	cv=pass; b=fg1kCT4ibSi9t25D8omE9ToZ+CssjoAf48HH1nQNuRK95CWo+sPrLvREGe/lQzvQoPs/Xr9uaYTddcrw6Ljc6mXIYmL5Ba27jKcLnRexSeCfvC/PbSaGVOsTmY8hK2270hXgtorUXw5KG7Mf42/TjMhDesacouJ0iSpWZFgM2qfpNaHhmTVuq/4iRoc++0sl+I/Q/cBeT7iKoKwsgm1EX0FE9xDKA/YLhfGRbDoKUcx/z1oVg3B3YhVdtbZyxvFBSnCkw7NgFktFyPEwhBE8kcelDhA7SyNoDk3MTJesWkYlVfXTnRvZ3SM0cutui9asfn+ETMXqyfGLdF7h60BsAg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780957112; c=relaxed/relaxed;
	bh=OzzDmX0mVNaHIB0PDn9zn9O9FBk65ypEWvPsLAejKek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ib/Iy63Eiva1qo4x3cp7w4vcLilGxdBtVziQVcik4vQ8LQHgbU5Zfe05wfsd8uMNlCVmNAHMt7JEggBxa/xKArKRNyGF5UNjemOd1YFiVnBZxay7GEzKENh6h+vp12k6KUhDOvUVnByJ1ftf/8Ow43YFH/kp3MAnzGRYNhSe6HOZDz+2cli61Ba1u3LchZqLkLM7y71K4ZGup6NP6pBH0MQzWa2//FZLrWrqO4+qyeaYtRpYJ3NALm1KERrhFWOPBUY2s1Eu+ErKxMUhgmDK1yaB5JW6SmcgYoVTjqDqU50vgmRZnLzg8xiT7o/v54TLCExZbx3d0+CRdO5u41W+lw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=RTx3zrEN; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=RTx3zrEN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZ5z86grhz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 08:18:28 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6ie2y+aGA2UFQY4PmJFccQcNrubplyqfD4cLdnYr2yP0j5YUePQGqsnbRorN4pVufqNnUQ8w8NszRtjlpJVtLAfuE00hNzcBdtTpmKQ8B9+R7lN7ZeAEy/vE29PQblWrAdNU73b9FILXvWbJ8PoOgTdGsgz5LKzeeWmM6unc+9Mi9zqXrp5G3vHl84fI4uQWySp6Fq99oGsna0xdenAxM+nEkYYlgI+fhngw4se40/VaJgj3PoWuHlLMgSQuumKAhOqsOAaJ8GblgVSKjMkHSQKebG7WFqw+9FzorO0aFZxcpj/7inM56Cusi71l0IyBEpHaTVvv7gLX0/9jHdv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzzDmX0mVNaHIB0PDn9zn9O9FBk65ypEWvPsLAejKek=;
 b=jnU5GE526qBhjr1Dx6ccnntzc6gXpB19+HM+2a+13dH9S9AbONyO+X8mPzVyANDtozgCCO16m0yoK9EpY74EQC/mnCGyuFUlICtSPnbm7LZAKd5uaz9pe1YbAisTsXkXq8egQB7MZSl+EiSlFTSBLuyO/RNMihl9Zuq/E1aInDQJSzN7Sv8kWIIbGPWQ4h/YBIXqBGFWIvUHlDChtvwdcFB1nObPOwjc4nXDyGCYg9qwK3amw5Xe9ZZN5jEoN7dGohrp+6QhdvNOIkUQRJI5M2CXdRu7lqjzeOQLQP//eY5mv6dVcvNF2rWCtHf77Wendiu1MoOttIc93e9VBtOHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzzDmX0mVNaHIB0PDn9zn9O9FBk65ypEWvPsLAejKek=;
 b=RTx3zrENQ7df2onUF/ciThLd8o/MV/D0hIXfzA1a++0zy0NO/bFYdOx/JaA4GvUDSU1vOb3cU1FWUy1Ea9xGgTkC4CV6TdnU/H0vEdS0LvG4AggdZrmfS45Dhsvd80uojymYXpFyGtGN/VnbblL/ya5Iga5rRXYiMFocg7IFXYQE7wUX98b1lmtSQnRKHnAohPVWNLB3gs2IZfIl/TqdG5EiJJnPuIz12x8vBT7IPJNmfyN67uZHNV+YiH7k+Ogj7R6ZAYsbBssbpBwT7Ubpczd1uUQ4SR8u7GQt97uHMHWSdkhuF9IGn23BuRZFLGrfnzHmYSeHzNra4uiNpGN0uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by MRWPR04MB12070.eurprd04.prod.outlook.com (2603:10a6:501:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 22:17:56 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 22:17:56 +0000
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
Subject: [PATCH v4 phy-next 15/16] phy: lynx-10g: new driver
Date: Tue,  9 Jun 2026 01:17:09 +0300
Message-Id: <20260608221710.1572971-16-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608221710.1572971-1-vladimir.oltean@nxp.com>
References: <20260608221710.1572971-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0209.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::30) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|MRWPR04MB12070:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb6ab53-4215-4498-20e8-08dec5abca93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|10070799003|366016|7416014|376014|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	4hut3x0Vn4mldZTgyfddhKCaTvBSW9DFeh7g3pLmuWXwTmM/RsOr/uy2i0FcRjrVVHlE8Qz80yQX/8eJuIgKanxGjFV2014pLC1Kf48o6di5F7PVMKvIcHI1dkY//qlWHujkMFohJ1bctu6CKHXEqQIKkSVXsWbstQuIiEr3vT2A5oxD7gNS4xYBzYdBxQipHZpdjSxcFxNM0LpLSqCT971CiXCT3lJGJkMkZeEcj7JKxSMa82e4jRC98knlZnu5G5pqOjCdSIOJKWdiCc9BDbd2QJhXj/oS2qLzL8ZU9oBajNnGpMY04OE03Gn5KEvbhFlSV/95oY8vZRTkwJy6c6yjC5cbMLH8Igr3u8ievWGM31sfkrRlH+NtE+fS2nxwQ98i0xhQEhcOoB542P4wzj2c4Za+8CsxxndrzIIOFN2TFa+JO2MSBmvBLJH8hDt26P8CrGJXaawXYnKCNBPc7vMu1JesnuKw1Lm80C4tdQycGWRc1dq5CESNCwkTzoVBiRLcStsK/uNg37Wo0NaEUEmIoRxiPVBrqo4PcNT2lIvrPx7kEC/QK4iu2orKZjnSk+rzsZ5e6lbP5cSafwv5n4j/L74M4mEhJ8+HrEOxaHbCnZDl6NVKwCZNJVQveoTh0hxUjELjMgpbLjzL6wRDUTQDShpA4mi8sAU0E9OiUv4EHoXXuNe4M9qkZqD/8OMf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(10070799003)(366016)(7416014)(376014)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nYwH5iUvoNvTDbJERbpxPwKsZqYSZ2Nq5UO4rX5M2iI3RZ1rWFkxEPWgOKlh?=
 =?us-ascii?Q?FvEt9keK+gmCq9g1eFYWDPpNtIBzeShDSElzzKzaTGMcQaQqlB+8Rzr2HvHl?=
 =?us-ascii?Q?ZDfSWJjjJXRMxFB/jRtv8qyiBilYGFeSztlPD3R7dRPOwsd07L2MFqI07T23?=
 =?us-ascii?Q?jcO0+E0nddWpV8kup2aWWSz0mdbihJYM4nMzFI6QHpp6GOpBu0t/7TUhrCgi?=
 =?us-ascii?Q?5DG+82bFVMrDVPHVBIaZPX54yySdAHBmkVkeGTh6Ld0IFc9viA8iH0sIjYKj?=
 =?us-ascii?Q?ArFmzNMf5FgLTQVfmVcV67yg3gkuDhLzK4XpXAG8vzy0DBqk+EmM+cK0aC6o?=
 =?us-ascii?Q?8wOABfbw9jXFrYOWZ/mapzpdJY6tn6GZ2fEG8V1cLuYUwCCT25/VC2ITlM21?=
 =?us-ascii?Q?7UQOJqxS5s/OPE/eviheyiB+FfCVHizQHhGnPwBd/SniVh5CJ0JEI4O1ePHd?=
 =?us-ascii?Q?/57gc2UVqO6oIlh/HYaZuxvod59QjaS1dhgC/FOxV96KSES72pyhzk5vikq2?=
 =?us-ascii?Q?dRrvrkSa7/HO8iV7GM7vB/VRSf9xmLSbCAjFabhi7cDzz1DB9r+JZzESYpUS?=
 =?us-ascii?Q?FaYtvEb2q0M+MQ54Nz8CmO6U4YrAM9zvtQjFhIJKyaX6QwI4hC+Mf3Jcc8Rf?=
 =?us-ascii?Q?26nUVIqyY8c+i9XgzdZgWOxjYziG1sd4pxLn/K3IQFvLGm7tyx8kRS3zu30r?=
 =?us-ascii?Q?jtn82zXT2TBfFO+Z3JHGClFjbnnskdHZtOQPjR2y+yzUQJ2YHaySnBrnSawW?=
 =?us-ascii?Q?UKer2xaGfI3dlUGODHNpMxhgOM+oup7Zue21Q+VciTDDE9GPNCkQuAD0XoYq?=
 =?us-ascii?Q?Bsde1X7pBJkZESpOo05Mf3IHH77rd8vvRcRejQ7aW5KXO3+AUQwjB1A8cBUL?=
 =?us-ascii?Q?fFiQyEO6sH3MPaoObBJzxzxsDyDFd/TxCmy4b6vsPdnip8+HSPPOeqPKVPZz?=
 =?us-ascii?Q?rUKcpVsuIfO+53Y9G1fH202P+J/5YwBXbgyw/OGsfBJpVgY239u7qlosryOS?=
 =?us-ascii?Q?22Voyww+sAk3dJ76gaDVcdt/xRob/AdmG+5eC8i36djfiPqdLdkCuwyOrUvY?=
 =?us-ascii?Q?AJwLRGqjF2ofsjnpalSpI3QKrFGm08CZEQZViwBPo0eMoYjdurGF5yMPPfVQ?=
 =?us-ascii?Q?bcG5Y/1QB5Vc0+123hBx9ryrpF0vRc62fXphG1FLGoLfpDHzaSzH4cHfaAtC?=
 =?us-ascii?Q?+NBWc16515HaPV3wfVk2wIMEBlMKzHlzTQ9jyyPs6aNp7yUatAL6rrwOadV+?=
 =?us-ascii?Q?JM/SwScxzfkwaySPdzzczwjGMBSphAZssQmu/Q/UTuvyVLkGddQOG0Ub1xu5?=
 =?us-ascii?Q?t7SBow4KZ/WlsCEOUlfQoiqI6O9RrXBQnsreNJ67Gh/Z4GwD/8EmWl9yaFaB?=
 =?us-ascii?Q?CH9+G1giyqmOJe/3vXi+2vDswDB8HuBj+wgTe8Uhinc75xIU0OQ1DHhCbcKJ?=
 =?us-ascii?Q?4LgOqvRkakEP5Ni+9zLufh1TcZMk/a0b81lAAmx6pPPUoYX3468VGyvc2+bq?=
 =?us-ascii?Q?kq4y/eJHs3f4t47Q1du84Q556AUC8tHEwdSrKFs12qOwT0bFwtfsJsl+cxqq?=
 =?us-ascii?Q?Sb3873IVchXOoP9zgumunMSnf94tzEDYFYjsM1NGnOmoc9LDIXpt+pAyg4sX?=
 =?us-ascii?Q?XXyr0dnIhs5Bmk5x3ty+MnMRY+Jit9GFqJ1pe/6rnWGADRnxbYgrXZCUBfBG?=
 =?us-ascii?Q?AGZHQL3Aw2WYhJqvKRi5gw6sqaKmjWNAHDr7UydRPpwJgmOaLSOyFrHPyI0J?=
 =?us-ascii?Q?67cUAV4mkomx7p+LIt69nSFMG/dWBooVypej6XDO8KSQHMiW3lHf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb6ab53-4215-4498-20e8-08dec5abca93
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 22:17:56.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q57Bh0jL4feBGTLkokg1RTEKfUFX95iwirZ0F6gQ4JhdJUcqN86E2E/V6oM4DeRx1ZgBAFvJ7QdZ1utpVfLsHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12070

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

v3->v4: none
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
 drivers/phy/freescale/phy-fsl-lynx-10g.c  | 1278 +++++++++++++++++++++
 drivers/phy/freescale/phy-fsl-lynx-core.c |   38 +
 drivers/phy/freescale/phy-fsl-lynx-core.h |    4 +
 include/soc/fsl/phy-fsl-lynx.h            |   27 +
 6 files changed, 1358 insertions(+)
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
index 000000000000..7dd5d94b51cf
--- /dev/null
+++ b/drivers/phy/freescale/phy-fsl-lynx-10g.c
@@ -0,0 +1,1278 @@
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
+#define PCCR8_SGMIIa_CFG		BIT(0)
+
+#define PCCR9				0x224
+#define PCCR9_QSGMIIa_CFG		BIT(0)
+#define PCCR9_QXGMIIa_CFG		BIT(0)
+
+#define PCCRB				0x22c
+#define PCCRB_XFIa_CFG			BIT(0)
+#define PCCRB_SXGMIIa_CFG		BIT(0)
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
+ * ability to map either an ENETC PCS or a Felix switch PCS to the same lane.
+ * The PHY API lacks the capability to distinguish between one consumer and
+ * another, so we don't support changing the initial muxing done by the RCW.
+ * However, when disabling a PCS through PCCR8, we need to properly restore
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
+	if (lane->default_pccr[mode]) {
+		err = lynx_pccr_write(lane, mode, lane->default_pccr[mode]);
+		goto out;
+	}
+
+	val = 0;
+
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_2500BASEX:
+		val |= PCCR8_SGMIIa_CFG;
+		break;
+	case LANE_MODE_QSGMII:
+		val |= PCCR9_QSGMIIa_CFG;
+		break;
+	case LANE_MODE_10G_QXGMII:
+		val |= PCCR9_QXGMIIa_CFG;
+		break;
+	case LANE_MODE_10GBASER:
+		val |= PCCRB_XFIa_CFG;
+		break;
+	case LANE_MODE_USXGMII:
+		val |= PCCRB_SXGMIIa_CFG;
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


