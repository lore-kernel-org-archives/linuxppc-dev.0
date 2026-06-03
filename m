Return-Path: <linuxppc-dev+bounces-21977-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474CDCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 13:21:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVpJ35DcMz2ySJ;
	Wed, 03 Jun 2026 23:21:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780492899;
	cv=pass; b=JTfHQ7dXNnMbRTwc7WCfhZOCyYY7DXrF33zGWEcINsvVeXdAIEYqZOMxHtbJERDF6eKltQbe93Q/OVWfpf9WXCEtGYnE750IgtgIPA5aQq0CT9sFsW+PfnjK2DcA4CkHKpa8YAzL5J5F12gZFNDndEM6wsOpT5qccZr0pEO8UC1ypp/yXEIt+Z9Pk9i10scq+rOMZEE5DTBd5DcH23WgGnmIxvg0tZp6TgZntdgpc5SVwJ4RIi97xlsRBul1Gzof0l4g1jghNzqQLkjKlbXhj+paznCbOLX/pBOb37yqt7a0QoL7nrVGrm1/kNEsGHmg4VNMZKSvfmXGAycsj1F+BQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780492899; c=relaxed/relaxed;
	bh=nCiLIMYwVITCutKqX+HBBG8x8FzlZVj/BFI1px7/lpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fcn24+l7eDQgFQ+0ibyZ7UCYdQc2WXQWHbROaWsl9WpUn/0Ld0aBDexkWKJZJUqo92FTtKUPgPfJ5mVv5X6/vpU8WzCcYrE1XMDyeDYorEidGPBqB3HHNNSqNou7GICbo3/72rxBQSc2DN9xCLabTPnpKtQpBlyWvFUuzRtIVsVE6Tu7TSTUCPmOni6wRkpqDqfqjEEGXJWfOWODQc+tUgVbcn5q97a4J9D8wu5NsOPxy7EEycc09Zbu9bC2bvUn4XOwhXRMxTHbDpXpAX/cma1wDoyG4MiIXjcK12P7OT/auo2q0kuyqF6orP2noi1lESQQJPlDWW0df9LGGGAOFw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=hQIvGpdj; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=hQIvGpdj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVpJ04vzvz2xMQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 23:21:36 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/Z0rooicLNuwoeZn0PZ3N8WXfkc8EaduVB8mOF5Ffvw/Th1+6NZvLCweehOzLs4StS3f2XR+V4UrT6zbBtwpc8UiMacX0DVnw19KL5GGKIYZkuLvYGfK9OQem29lOlW0QaFs9xmaGtq5mIDJKlVoeYEs6TwXw9nBfLT+bPoosOdy0wa/WaEypkDu8UUG79rofwTQ58R9a4tFhR8EHxK9ICQo1l+ySI5VzurD595RNu3APHJIHL9XUcmCbcHgtwo5avICJqC3MgwuZ98b4vQGZ04Z8JaaEhj6UPLf0p3imB6BL5NO8uyNXKvAQ72PRDXMH0fZdu4nbhn1wbLLKFcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCiLIMYwVITCutKqX+HBBG8x8FzlZVj/BFI1px7/lpE=;
 b=wE0GdEO9lDldS3Vj4IN1b3ijzVc6an330QUJdFXaM/cTlYXs/K5eiCJ/iVgmhv5HFnQUl8MCpkZ5i73oTgWevDU0GkSdlK+C/73MIMkwkAwI3I1X+foojJMxVJh4bborsd/X3n6DC73IoJhhfkcrOBBWR7M/Khzi+hr0FlGfJoImIYBLI0CDekpHWldSSlujtW6/Xve5QQzPyb7PEwRi0QDgTJLy8rvSgewgJmG65OfwSCh5a5/W3fB5vasOMyZAiFJFCMSEx1zxH6IdSiyyTYibChx2H8JI45c+ijZGzQWvIBXW7Bexv2hshJPGIghALt2I30ZgZx8O5MyYwI7LZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCiLIMYwVITCutKqX+HBBG8x8FzlZVj/BFI1px7/lpE=;
 b=hQIvGpdjLnFJvPOHj/Hv1BvrB9+DEQhaRatSU0lSnYPdxKO63DNgVFFKRVIFcQ1NGv2pKAQAlCNKTy8yVkilExocEujeSCLextT+skm/74sBZl8bKT4TSuOE5Bd1wQZf2bH0EihWWJjlIGC/eT46Bz3uWfr4X3z4Wqgxw+cy2OfKHoypnVi+OoOZMtH2BXImnNoyCP/T3SxnrZcbNFKpOIav91UqGZbMGEX6mSxvRU7Bn3tx+pjEJt2kWaYQixI33/M4TQfkfC/DDjCzR97F2B04NsX53ym3NqMDJOQRUqDj26HnsWme/LmLvdhIWY9m5uNAgdZabKgLwSgRozFjLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS8PR04MB8658.eurprd04.prod.outlook.com (2603:10a6:20b:429::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 13:21:11 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 13:21:11 +0000
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
Subject: [PATCH v3 phy-next 15/16] phy: lynx-10g: new driver
Date: Wed,  3 Jun 2026 16:21:07 +0300
Message-Id: <20260603132107.503575-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603131914.503053-1-vladimir.oltean@nxp.com>
References: <20260603131914.503053-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0044.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::8) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS8PR04MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 6743f487-31a1-4605-3efc-08dec172fa82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|6133799003|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	o6ZTRM+z4kN2XE8q7iVjxVf+FoE78pGLAxX+YoLHD2V8U6BAikvOfyHdOBTo4pNXVpVNGCUOoCvAMGoLzkAhLJ8kdZLuqbAwTIkA08MdjHGmJJOFp5ORCgZF6aMsRZIuwzzEe+wysT4uRcMmcf5C2qItK6CeJrCMdaqU14lSMuZpD686XcZlhwjBjYlpu6kMYBPY8PPXGPKdxuPkdShtVMa/Em9rEfSnXSDhg3C0om1zWtPL5tO3MFTrixY99SKTzt5ORkn0tO6h0Kl9sWzlZ0MlysaVa9UoCNgq86qct4GM8N9Z1tTyISYA7jDz13wPaRgmrROOyvHEjRDSyOttDXj4gGrh4MfcJZDjhVYG1y5aen3CjQVmzNHn0OCV1pEQL/TVmdtdn8RzoqdAxvNRf8wft3XfMhgz8KfSdgt+87KG4r67usZyj/zz8wH/SpdvmLaUJ4Ti9y4YWtnqWC95BcyoV2/sArLdTQ1tIMIYXhZfKVjfk16MhZwA4nE/X7IuaS2kRBn6Jiajv1ZijCwdH4dALn+/4qyZozyL7pqWcZ2OOI7Qhz930niG50MC3aucu32MdxF4PCANqKkKhPSAGL3fIhaWFbkqO+TMMMFd7XtBq2Fwii60VSIgXaisZOiN5kAA5bels/Apq/v6vYj3Cn4exqo2Wa8mZZZ5S9gwcK++s+34UH6HpbSJenwpzPac
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(6133799003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n/f6gVP4DpVZIU6e1XUTT3r11BiT7blxXYgJ5sRwjrP4B0eCimBDSiBANdP5?=
 =?us-ascii?Q?Rv5q5fL7Vp5f3UcffA/eQ+aO6l/UzdeRmLNB2YNEXtyz8gQgxvhj+lmkjXAT?=
 =?us-ascii?Q?5a/QTzWQ217vAFmNSqI+7SHDtVMlsYN3yAvy+YL+BWVbk0oLo/my8mqZJnvM?=
 =?us-ascii?Q?QDqoIgSLU2zfN7SEnJiLoEKndQHtAP0q7+ett6o2IbFdopmxFT6OP4p5aOhH?=
 =?us-ascii?Q?e6Wydkc5YkDifskxx6EjRC481CoDinpSn47xIrMhylbjt5VJMcAOFqbvR2um?=
 =?us-ascii?Q?rTEtqQoWl1pyFLc4KkAftni6GXPhV1oLn8HM4OlKczikM+PtTYvqytG2IGgZ?=
 =?us-ascii?Q?jHkoWXhFT2M8t3z3AopVl5WOJuTlIGuZcgoTnEscm/ShFowgkuscbjuip2vz?=
 =?us-ascii?Q?nKpsBPkv4yvjKCDqRL1rJI5WaXNOUCAusbM9XmjR/bAZpS826cGwkd0lGdO0?=
 =?us-ascii?Q?vbnLCja7pQy5o2ATG4dp3gfYdxY5u5jScMuGqFyVlXDrEevlpPke4Je4O4w/?=
 =?us-ascii?Q?j718iIp34q0VIzFz8RWxFVtzjfDA/z07XyzCwHWAxT0fYiUIKvFqVTgM7NGr?=
 =?us-ascii?Q?UI2GSikjRMX0uXVsHgx75qgcGp8EVAC4rXIhUV1X1cypumJ3jD5pDgOPrpTP?=
 =?us-ascii?Q?8e31ocNzMPHUsYL+rYxBOvb/GdtKGdc4iPTqgAk8Ac4UJkk8lK7rSRWg4CId?=
 =?us-ascii?Q?WYiVfW6zX8rk15Ypwk1p4MWRhhafJied+veTLDk9n5MfwZggs3HrYWE0wfWq?=
 =?us-ascii?Q?9NnysTaGBctXZLb0CSORXwFypqa1osYy9hk9VNay2EjafczmYgbTk+1Kv4UH?=
 =?us-ascii?Q?TuFSqz7umxKEoXRCD+O1oRG9NhYAEDJxdRflZDJcicwgGywXKo7ldS+V6tYm?=
 =?us-ascii?Q?OKnsT+5aYjSYPvUlWAPeyalx04qeznJdIVVQdjC1QaC76c3hvnJu37w/6Iup?=
 =?us-ascii?Q?u//yipLhDW3CU8Up8SsIO/AA2YFS/ht6bPhlDR8Z1Uq61d87XHwnzhaVg4OA?=
 =?us-ascii?Q?1rBSenBhMumvMadIWWu+62AnUp65/0vuR3+pMi9wFpnrearrkvYFxoNh8dlD?=
 =?us-ascii?Q?z4863fM8PjFXbk5TcSK/cp/7zCbxKco4rgkPw7kxfb+rw0O8x+6n7r9tJLvM?=
 =?us-ascii?Q?qBanaf/VsJXwDvLdH0xJFX1CWuMi0F2J8XNRkja50qRCI27PFc7uWV2v2NkE?=
 =?us-ascii?Q?tz8+RG9RxCAoTRck8T8TAy9C3Pl3yFVRrJFjM9hG4/SCou7dW3ICql0+EjFf?=
 =?us-ascii?Q?6FQziyX/iWjOgg6mtZYE5sxAXdfnLHGsCcmrzuS2dRP9YLL50/eRWHp+0F2o?=
 =?us-ascii?Q?atyCbmA0F4knlUZ+lMBh8DZMWg0Jk2zn1YE15chIv1K+N9ayU0S8qpLNbck6?=
 =?us-ascii?Q?Axi0w8F1sUuq9Y/ULkcwYJgP6vpdKUtMpPYUYADHX/EbwEQ0tQ7qx2N3fbLk?=
 =?us-ascii?Q?CZO6XHvoxUW9SxNUVdUo8Bzmn6IthUkX0UkN23RCDmb0CsaxXdmCMxxm1hru?=
 =?us-ascii?Q?L9agO/AilgCZTFlpsEMUn6Lch68jTJAx3iX4LBUc2fIcSvtHMHT/hqTlYTRA?=
 =?us-ascii?Q?ym8gw/kQdsYYpdxSH7eDslR14XKtTOZ5+jcop1EvTNBuiW0UnK97stCrhJxE?=
 =?us-ascii?Q?0oiXWrXf6TRldNNXN7v9xs/r/S4X1OVJD8iaL8wg4lE3RfZeh9u+qm4A+hIP?=
 =?us-ascii?Q?NMwqxjp82okDLTuj6oAS7+096AJMevhqzd+nZo8C2igio0TmNOkSecCIo7jk?=
 =?us-ascii?Q?OGwncSVggg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6743f487-31a1-4605-3efc-08dec172fa82
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 13:21:10.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2W0KTMXHWD4OmE5Xlc48o8AZxbh2AupX9hjJpn3zto95gjJNy2mrhIoTSFv7gSY9qGmhFeNtJsxqkzvTzL3AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8658

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


