Return-Path: <linuxppc-dev+bounces-24619-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6E8C4452D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 23:16:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4YDd2Hvnz2yd7;
	Wed, 22 Jul 2026 09:16:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784675809;
	cv=pass; b=B1h+oBzQfpI7Cn1UsVQ7/zPeoV1PTy6Nmqo1a9MOmPF4Kxtya6Di3bwxXN0LFqf0oXo2zKb6lxkqGJRka5jayr7Q52vdeyJcZTBbCd4yXMFhNGiMyLrM6YgBmJDvK9AxkN2BfwtaGHBFYjgKQ5OqYCrzXoSFXHkIe99VfKsYzxcjPwyysFEgAsSop/l5dpL7bgcBYF4SIG3/aohwYDnDMRzinjQnGsxF88t7mQKUJZzQYITelNFxa2N3mqH0pHJ5V+mKNa+oFO14uHeODMcjEJ8S6U/nNkjEUb+L0UcA8JrNhByutK3xTwYctLCcJwnJt9DFxrJaAdYb67rbpUZIfw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784675809; c=relaxed/relaxed;
	bh=D+dy2LCpY1cXSyUlnbm+ofF3kWY9ivvko5g07pydvew=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c9sCIXGlP24dFqurEd2Q1P/0IS2jvZhCEWmhbYutY6KRHwdhWDUz+KkH1bP1Y6TtxfvNkZtDXdohiepsyP2PwwgS7XuJ2jAUEQ1ebpG0JvlY/4LL1dBcinUR16genRdhhlfWy7NubJRTgihgtoFryyXhyFF/H6rwAlp15cfLZYLdr6idCTIM1GPvSCRCVndG4ha744dKloph7ugNnu/vacfeZMKEN9Patt/KGWMRPWfUZtPDtOPay/8QIyh/QIO/BOFjdcuxwUYW4JP5VpM7WP8VLVA5/Sx1VfJQZt/Kt9z0PTreB3roIH0FTA9WOouLYWmMaNT10XEa9aV4CY9QLQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HRhAVSHn; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HRhAVSHn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4YDY5gkTz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 09:16:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5gwybVSUOdERTZiOQJy9A/R4KIi7N+WzBx/TVLYhTkM3wYGIAcp2jRSE2WtxIsgrUC+Ql8mYFyQ+Jwt7d+nklpRnnmYpM402zKbU9rfKGkg6qqMbPyMoVEc1nWcp5b3RqP/D4ABN94B0WAP02Erm5jc1W2aHXo3rhumcew/cj79Uf/VkowW2EYITdfLPoI8j51mbMijrH2t9uQE8jl3UvpdNmdAxgeqcCgI5x6fps/PMRVo4tQmR1Xi88ZYreKU5tMlKG9v5Mv1xNomhzJUh9JSoTA8nu6dRQ5Yw7XCcYGiYWG7XDGLny78ig188WOQs5SfvVE6pn9mxe0xFpdMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+dy2LCpY1cXSyUlnbm+ofF3kWY9ivvko5g07pydvew=;
 b=pLtKN0nscW1HODUR2G+4CUDPTsiBCovaGyY1DssS2V4uzsWf1B6AwDnDm44jFgDcN7w08Ej9E5TCHjEF9iI+raJPO18ABqksBjfiPVKG+HTJ5CIlSajBGhe6RAB1SXUYBGeOGdLYG1IStBsFL/VhVTRsVsPdbp/8XlJahtvN1jMEnFMx4UwSSpC2S7ql3clM3KnwFLaYt3B8gO3S9DkAwukWr4mqfcl0d0sDKw3uLvEcnyHM5H31+otNKgma9gV8LIMxVA3XnaxjT4VfWvzyNGIHSJoJk1rWkZSYEh6OmBYs9FCM/+rD0biPU+szH0F2bWcZcFQMeFBfcBSxJLIRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+dy2LCpY1cXSyUlnbm+ofF3kWY9ivvko5g07pydvew=;
 b=HRhAVSHntKFgBOUhYzmPzjV2QEJx0RSo8kVSPgJXUv10zMvc/Sk06p4V2QCCyOK1f5RGGhb8Rejqheb0KJnFbUr8tqoEQBXZ1uh3GR2BVWM/UFmjUx6FrEbDvekcXk+z8+ngNEOxarO/agbcA4FmqSDrXv8lUAnkia6Z8SSw/yVXxWKxqvOzSPQqeVTltcVMU1e7Dje074TDYFCq2ynMMUfiuH8StF7Xu5TI6brfDFdCvUMfp1AIBNWyFjA78XdEHQC0DRIWgmOBhHYI7gHCTOo845PkP5N4sTPhJpmPVaSGe7X34Jh9U8YoN3cO/vBQLYmUBV2Psx3PDC/Ee3L2sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB11817.eurprd04.prod.outlook.com (2603:10a6:800:2ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 23:16:13 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 23:16:13 +0000
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
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 phy-next 0/9] RCW override for 10G Lynx dynamic protocol reconfiguration
Date: Wed, 22 Jul 2026 02:15:54 +0300
Message-Id: <20260721231603.67865-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::6) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB11817:EE_
X-MS-Office365-Filtering-Correlation-Id: ef634280-b85f-4dfe-c15a-08dee77e0ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|6133799003|11063799006|10067099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Q/r9LfrwwZyC/CiQY42zCAqUIfJgFAwxgVP7Vt2eV+mzJ5UQi4sMXO0v/waVFQyW2H6nx4M14hH1YLkJO6BctV3mMkwLR1ch8BlC9AdBiB31rP5V7yqa0Ip/SiNUXuhGcUsPRFEp6CKgk4QB7QhCwKuIN5mfmGdZ50/BcsDVBH2c0Zv+qv+LsFS8ir6k4pDhtfrkjJg6hZ+eqMiBvxQZyLaNf5OtF0aYvDLphzheqINy1CpTF6uh0rLc3o6YxXDCJtyuG2wp2Iy4W3IqW2XTACAUMA48IvwAYTh1LpvNwiE0JoleArqN9GDmKUidSlqd2jOrNLJCXGLJAz94EqZGIcEDHdmZI0ukk7iYeBNaqvHWmCUMDbtPlN7OAt6ofy2IQVLMs8CO9PN1z25SoeHdG6LmeXvTVl0kcdRSNTwYBXHWI2sFUq/jcdqppVpQedEJY+8AaWbYFK87flhxWBcFOb1aW257D1dXf5eCqkLTs8Qwu9TLfBxsrsIC4XPHOoPKYDPXi018n+n55rlskD734NZmaU0QCgbYPb2HBjgPPWVYJl3kK2pAuu35L4fT3tJDF6g10fSMtAipK5BvhZNMY4Yuyl1/PLcx50TL/3fVmR6qoB66g435pFQvan+gagZq3HzQckn9RCAFiie+ccoJ9j7FHErVHvuWuf6VEv587yw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+5+feLVrzwlI/0Y/zBGoljiSiDgVc8eKfZsUqxbKZRk1EoyXHk0oL5ATMOoX?=
 =?us-ascii?Q?xxNS4mIb1fWY+s0fS/FowAThmOA2dGNBfaDYcFQahB8cOTaJ65r86Wg7j/+F?=
 =?us-ascii?Q?JLEtKA7y/6eTVTrxbXVYLsE/z2A7mh0zjUlf1Dj0bGeNgQs+Dh+o4jN8+Dgn?=
 =?us-ascii?Q?haho3A6qBsAVRK8dZnRF2RUfT5niBGMS1iNUxdXMZbuBxDAr5034yTbSJ697?=
 =?us-ascii?Q?qf+VtkCxLYy8Lx67XTPjAuddaO8yVOkrvHztzKd52knIqksV8wpYQW/O4hhu?=
 =?us-ascii?Q?5vKPgpltQEI52xBp2Z1zVd/T7emj5/f9sTuUOudlVNRHjbI7q5GmEeurmVdy?=
 =?us-ascii?Q?C0OxSQimlWXjkshdvFMwn/APEcqPtELuv15xTWtpQ+ucJuzHs2S0dhRN0sBh?=
 =?us-ascii?Q?2nkBhw6UstgnlkdKMaONRszORRbzD+Ur4llbQuY1AD9QNJHNZfEhyQ16Fb5m?=
 =?us-ascii?Q?xlVnckDZqUanDhQNrcEY+bZkjt/jdfD5Dj6nP+btbNCPyR9C+RW4cQ75UV3U?=
 =?us-ascii?Q?frcJ9zKzg273xub1TQ44Q5zMoAKBnfZEJ55cT6dgRgxSzHcQKm33J02T7oA0?=
 =?us-ascii?Q?gpv89hYq+xhCdLnQWTrgXs2QkXNuI9Fq/HPv3OKLP2MWQ29kxXZzvkPoEnWn?=
 =?us-ascii?Q?fs+J7I85DnHMHFDfaP4mAhQ4MgfV6GiyAa2nUUZV0C4VzKyU1vZtEoZDwJ3P?=
 =?us-ascii?Q?DnObyO85KhGc1J3Ag4v0YyKop2j3ah/PdhqjD3bMLrG3vdqQPs5RUy4M4t8K?=
 =?us-ascii?Q?gHc0W14XiZYXut4GvDTKpiYJzg4xTkj2xr7J6jvCT/TGnx7rqCD6kYShLCD3?=
 =?us-ascii?Q?UGKsWftjX7neLSKtboOmHoc36L1EEA0HAyGX4Zx7ypfyLo+SUBD/wvmwuWSZ?=
 =?us-ascii?Q?iX8ShkEKHQniN/3xZ+MEK3oNxrGH+tk+SclBgUTVhfz1A4G2gCm/H0CAzCuX?=
 =?us-ascii?Q?0ayhy8ZJiTwyLfjnZs7Aru+mcAkx6MH67YRejVgpwIJ35ESdVXmL082xaMbl?=
 =?us-ascii?Q?tzh/eQjEbZfsFW7yA3JuqtPmW8XFOwepemUx9sHG81Sk4JWQ5omj+NmzzDmz?=
 =?us-ascii?Q?D2oXQUdbVv3T/qhXLrd4MbWRUFAilYFfEq5xC2Lt/ij4m5MhNyb6jU3ZKpEL?=
 =?us-ascii?Q?BvmvSfowLuwBJXZR6A+E/PssFR3A7jFoL/3OyHbRJob+b1yjWyGy5zgl+/Fy?=
 =?us-ascii?Q?DFyGiUIU0E0wT7jSO6jVjQSUqQgtkHLBR6DKkA1n8yAtx7tMH3De/aaGBy34?=
 =?us-ascii?Q?YzZQKr9qJCBiwIqwNUXymWUlZv98O2XPpNDstCY0nIlunfDdRgnYgzw+Uaep?=
 =?us-ascii?Q?iSY2tfWvFwnY+DldfLSlH5gAKl97+kjxGkDE5qA4j5O5MKuJFCplx1MB/8WB?=
 =?us-ascii?Q?b+pJKlgovluzO1TqrOelU6ku0ek/PI/uJObsHdFd1kHgHGND/eg9sZKGwShd?=
 =?us-ascii?Q?0wXkFmMuxlcyXaUofJGUWL1a6uoY/Tb4ALI+TPUieJzukAqB41C4dJyAF5/R?=
 =?us-ascii?Q?Gw2wymVU+NaQ9SIQfqy4YmMIthEv1O+7qp+KLKpxuDaAYkK1fIJEcPa6/VDr?=
 =?us-ascii?Q?ZeuyJOzjuPmKvDVl0UOnlLOHHOq/HpXXTBlAPFqVReWrNsYmsomQ/jqkw5Cr?=
 =?us-ascii?Q?8cL3dVm/0dXla3tSTEHz9ePbWINSDeGzvQEd8ZVUIANJgdinQW4L2F0BHM7P?=
 =?us-ascii?Q?128OeSFFRuF9CeDqbAeZu9JE6Vm81K7f9BWrt0fwplXpW0voo431VhAe3aQQ?=
 =?us-ascii?Q?Hq61OSHkPA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef634280-b85f-4dfe-c15a-08dee77e0ec1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 23:16:13.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZK18PlktwgCok4aFma7D5DVAT6xBbhTYrozQzxbivrdl5xabPtgrj3JT8qXyR3cNZlx0bwB3xnMLDuH90hLkIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11817

Previous set "New Generic PHY driver for Lynx 10G SerDes":
https://lore.kernel.org/linux-phy/20260610151952.2141019-1-vladimir.oltean@nxp.com/
introduced the 10G Lynx SerDes driver with a reduced functionality set.
Namely, only minor protocol changes are supported (1GbE <-> 2.5GbE).
The major protocol changes need a procedure named RCW override,
explained in more detail in commits 6/8 and 7/8.

This series adds kernel and device tree binding support for RCW
override, completing the SerDes PHY driver functionality.

Two components are involved:
- drivers/soc/fsl/guts.c (binding is fsl,layerscape-dcfg.yaml) - Device
  Configuration Unit, this is API provider for the SerDes driver to
  request RCW override depending on SoC
- drivers/phy/freescale/phy-fsl-lynx-10g.c - SerDes PHY driver, this is
  API consumer

The guts driver probes on DCFG blocks from multiple Freescale SoC
generations:
- MPC85xx, BSC and QorIQ (PowerPC) are all covered by the
  Documentation/devicetree/bindings/soc/fsl/guts.txt schema
- Layerscape (Arm) is covered by
  Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml

It is ultimately the same hardware block, just that (from what I can
tell) the Layerscape nodes are also compatible with syscon, and PowerPC
aren't.

RCW override has only been validated on select Layerscape SoCs, so
converting guts.txt to a PowerPC schema is out of scope for this
series - we don't even touch that (just in case it gets asked).

Using syscon to map the DCFG_DCSR register block in the Lynx SerDes
driver instead of creating this guts <-> lynx API was considered, but
because the RCW procedure is SoC-specific, it was ruled out for
polluting the SerDes driver. The guts driver is all about SoC awareness
anyway, and it offers some abstraction of all the gory details.

Changes since v3:
- new patch (1/9) to improve the fsl_guts_init() error path. The entire
  patch set is adapted to use the new convention.
- patch 8/9: avoid accessing an invalid soc.rcwcr_lock if
  fsl_guts_lane_set_mode() would be called too early
- patch 8/9: fix serdes block and lane count bounds
- patch 8/9 and 9/9: reimplement LS2088A RCW override in a way that is
  self-contained within the guts driver (based on reading and decoding
  RCWSR29[SRDS_PRTCL_S1]). Only a subset of SRDS_PRTCL_S1 values is
  supported for RCW override, due to availabilty of hardware to test on
  my side. Notably, protocols with XAUI and QSGMII are deliberately
  omitted from the SerDes table because only testing can show whether
  these protocols require RCWSR30_SRDS_CLK_SEL set to GMII or XGMII.
  This new method completely replaces fsl_guts_lane_init(), and has the
  advantage of also figuring out the initial protocol of unmanaged lanes,
  thereby not breaking them on RCW overrides.

v3 at:
https://lore.kernel.org/linux-phy/20260720133642.136324-1-vladimir.oltean@nxp.com/

Changes since v2:
- fix error handling in fsl_guts_init() and make sure that all newly
  introduced RCW override API functions fail if fsl_guts_init() failed.
- replace __bf_shf() use with __ffs()
- use read_poll_timeout_atomic() in fsl_guts_rcw_rmw() to clarify that
  DCFG_DCSR writes are supposed to reflect back in DCFG_CCSR
- only operate on lanes on which fsl_guts_lane_init() was called in
  ls2088a_serdes_init_rcwcr()
- put parentheses around (lane) in LS1088A_RCWSR29_SRDS_PRTCL_S1_LNn()
  and LS1088A_RCWSR30_SRDS_PRTCL_S2_LNn() macro expressions

v2 at:
https://lore.kernel.org/linux-phy/20260612210859.266759-8-vladimir.oltean@nxp.com/

Changes since v1:
- add Conor's review tag on 6/8
- update email addresses of DT maintainers
- drop DT maintainers from explicit CC on patch 7/8
- keep devicetree@vger.kernel.org CCed on entire series
- include missing <linux/bitfield.h> in patch 7/8
- namespace SRDS_PRTCL values for LS1046A and LS1088A, even if they are
  the same. For LS1028A (not covered here) they are not.
- prefix SRDS_CLK_SEL_{GMII,XGMII} with LS2088A_
- reorder alphanumerically (LS1046A should come before LS1088A)

Change logs also in individual patches.

v1 at:
https://lore.kernel.org/linux-phy/20260611193940.44416-1-vladimir.oltean@nxp.com/

Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>

Ioana Ciornei (4):
  soc: fsl: guts: use a macro to encode the DCFG CCSR space
  soc: fsl: guts: add a global structure to hold state
  soc: fsl: guts: add a central fsl_guts_read() function
  soc: fsl: guts: make it easier to determine on which SoC we are
    running

Vladimir Oltean (5):
  soc: fsl: guts: perform fsl_guts_init() error teardown in reverse
    order of setup
  soc: fsl: guts: make fsl_soc_data available after fsl_guts_init()
  dt-bindings: fsl: layerscape-dcfg: define DCFG_DCSR region
  soc: fsl: guts: implement the RCW override procedure
  phy: lynx-10g: use RCW override procedure for dynamic protocol change

 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml |  15 +-
 drivers/phy/freescale/Kconfig                 |   1 +
 drivers/phy/freescale/phy-fsl-lynx-10g.c      |  23 +-
 drivers/soc/fsl/guts.c                        | 528 ++++++++++++++++--
 include/linux/fsl/guts.h                      |  18 +-
 5 files changed, 532 insertions(+), 53 deletions(-)

-- 
2.34.1


