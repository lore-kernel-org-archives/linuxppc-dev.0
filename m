Return-Path: <linuxppc-dev+bounces-22524-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB90ACD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 19:41:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbtKy2nv1z3c01;
	Fri, 12 Jun 2026 05:40:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781206854;
	cv=pass; b=R4o2Foy4Jtr6+/whGvQT+NBsNfJxFAp5NUEAwL9MV6CZvwxnCIYMNq0a0ug0w+DC4u0Ore2WU54n+osWUXabHrSEwvFKbQU0t1ZdLm7kFuPFhSfu0WS0Z9e5gq0aWW5e8bi0T564ATmj7i17qEoRr+/ajF5GiY68KZv4Dbyh/PPkAnsmLZhgB6DDX0u00kk5iUpaUGq4hHgPbPcSRpohU4zr7n5SWwJV1/u2dvVnphSIWg6atOPH43E8ZaRoMZ4vQk2ii7Vl2XCtyz3ddrmCZH5G90mCwk6xdB5tP0Z+Mvx+znZmq38IUuAD/sUntDh6U1NsEky0i68pHD/c99GlQg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781206854; c=relaxed/relaxed;
	bh=nfzh8MPOHVuA7O+zV5cy3e/Itp+7SK1V+lQVwwlmRpo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Jm65BxPF3dehMX+zOlhV2ii5eQ8toT2db5X+DyyG8wg76mGVH+aC/7Df3Usf7F+Fiqfmu/CgrS7kD4+tkGlG/UHeCDk7kXF635GzU0zkAjI9m8t9IufH4aqH0dj2MuK/DZKBL3adDlauuQkuwmFHP5luCKkYIwPQzLacY4JZ4QpyeADl5cx//UWo8FlaGtepmXaMya12IhMHR1+9MmuPsIdqQEA068pxDbM2+jDhK787bHS8mgIXV7rp8XiVDuOWXQxRcBTV/skPtBlhIrfvA13b7rcMdgI8yl2aBuMKu553EZiTdXYXd5z7AMKAkPbCxII8rA3J4KvTAdHvxTNIYA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PkHggRGD; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PkHggRGD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbtKw3mZ7z3bxH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 05:40:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmuvqG06M84pJ/ldAVoT0nvaI7yZwt1U5u2QpC74RW+JCtYYxsThBlR5wtuuN0ISqz707REFMtocha2Le8wLVS8XZVXpuo+5b53BVtdxU3gLbZquaWZuSKCR3ZRr429kzMyEbYcaBaV4+R2lLUygdrgCz1Hqd5YLTugSgtq1JZYeqhLoLL/DQYSl7OlGArFY3f7Y3T61PMzeENEIANEqxClYqK48QakgVMktI/FURfTv9Ofpfx0uROKW2J7y0JtrUG5AZStcpbYFXh7BkbOtjqxmB8jnrNoLlAwMaGdwvkfUI7qsO6a4UF5RcOep+XVFwQaPDCw3r/O12UYnAnbQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfzh8MPOHVuA7O+zV5cy3e/Itp+7SK1V+lQVwwlmRpo=;
 b=FMw8IuXBEkge3poMpeJwnNbDmRxi4hkw/9mXG6Q9MuIljEo/f3kF3scV5N2KW6ul07eE2eA052AOgrBNFp6EYKJshk2UxJvHpH2Pw4vzWkVo28qZrGKA2X5M639ewKx0j0hmxtHWWppr3n//ITpYCILxo0cuFkaLucJdSwqwRQugl78a9zSLd3l8hAwfVkhFMQMasHR8fSw95czq6Pa/rfK9HyTgsD6l64W/1/axBWbUcwj5kr94GPNrd7Kbcs9/Shl+m7FUIZL/RdM6GZolW1FZ6iZM3IKm5AzA0VDN0nmcb/aCIg/CXkReQxycN2bt7cPGqgFlO/U4KiCUFJIP8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfzh8MPOHVuA7O+zV5cy3e/Itp+7SK1V+lQVwwlmRpo=;
 b=PkHggRGDoHUNhPrnTFZm32chGJr7t0zO84qpwiCMk6BqDJBwJ+IOHntA+rwmv0k0HKDvAaH0h/rAOMA1nFdncLPpL9fiDi0ynd5pvzPRYNQC2njg0qySMblRfEYfMt2/mv0YBmU025wfywl4Phlb+5MBIQzo50FwIaR6ttGfdNPzXOsOEwoBHF43U50VGloHBZFEmDmaDSGXke43Phb92L6DgxOBlREd5NiYQP5hSeM/4jjvecg5SVoBU56wTyDJsXw6LMNq+gnvueO/C6pu5jkCY8BMzaeck/1p6EtcfFBnIRHhp4aEXJCpmjvAXf6r6bl+vRO0INchCivlMlknxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 19:40:18 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 19:40:18 +0000
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
	Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v1 phy-next 0/8] RCW override for 10G Lynx dynamic protocol reconfiguration
Date: Thu, 11 Jun 2026 22:39:32 +0300
Message-Id: <20260611193940.44416-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::10) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: 885e5366-8a0a-4637-044f-08dec7f1444c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|19092799006|366016|7416014|23010399003|1800799024|18002099003|6133799003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	qq4sFL1426Lop0S+tkKOzq/nO4tBJMFe44W/CQcCGXZlN+fMQJZVGBMnIYZA6JYmXJG5wqpB995/8bKQhRJGwssL+IqMOehf+gIxOdra706QaJGiXjmUApnOfvg/tFOP9ROyqQk0vHgvRFo0IrPDw6BOCkXO/QFybyH36pZE5jSGYwwXYgJY+yqFWurRYAORU5t1i+a/AKsWgnyH2BRg+vbr0RDaA+ZZrbtMxKT2hlktBToHwoQeHWO6gg6LFINdvFwehwtjRPV2VZ5nxUxcsYEcofoqjrA9qPgrnx/VTOmFvhwbW4SCsKUtpO7T01bDX2KfhxdFZS4vh+HZrsSLZZ6CtYLJNse43rkIN44G7yuJCNHIzIVtghnAsIiIedIVj6/bbHIrXpDys6LzKdK87vVhGV0SItWSoYsZVIHArGpqpkLCklUHUNxUO/Dj+ly7Z2zLrBab/pMFQGHZy+GdFmJZ8RI7u+oESklXntnnN3OtQb5EmF9EiYZRAN7wO6mCzWLHcShY7sVEBj1T183Z9xbcBNEu0nSnT3fj6/ygNlwB9s30OwKGn90RQYgf9oGWbdiiSOle7AVuzhsfLiuUGviY1VY0Fj0pqq5HomLwwz+653MTMc5Lj3pfetBau5y5a/YQIakAtq47wFb1cGLtQLH1opD852sgSBOVT7iHhMvCjHGMLOgILDicQqiNmzvi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(19092799006)(366016)(7416014)(23010399003)(1800799024)(18002099003)(6133799003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IaAFD6fYTemaOi3o7Wbjc3zMJM2m96PoAyu2coikW5BM1pFv049EBBRko/re?=
 =?us-ascii?Q?/aKzRtRBESVFKlXwQbdL2NFq60hed/7Ir0nS0/LzG1iP1oSCLuvasTbaSNP7?=
 =?us-ascii?Q?WwNtgKevN/3J56NGjVyvr9f4Th65Mgtgw3LGya5ReqpoVsVPvGITgmhf7MZn?=
 =?us-ascii?Q?dZWSUtggd4eQ0TmM5Yq12Hhc/jhuOjN1C1l9KWLf5q9VrdIg3W6nBQQ6hZer?=
 =?us-ascii?Q?0nSRFelYd6PVX/uoW+xuVcFYGOAwzOZ5DmYwG31PLFlIDB7lWQtvF0iosK9n?=
 =?us-ascii?Q?xZMm+c8jvnugCzHoY6Ig2rmZ1E76xrpz5N5OzeWRjY2jIn2UAOXR9PnVSmqP?=
 =?us-ascii?Q?k/zMtoGquFRS1sqgMmTl0xj7O5zQ2h7lFY48ospazio4bOLXgsocNZrmd2Qu?=
 =?us-ascii?Q?7o+PKn3BeR6xZPxMw5XoMsiKRL5B2pGTUEn5bvtlNF97dVF2dCsw5V1Epa4c?=
 =?us-ascii?Q?ISS7acbs+cncdAkXlOnSlzuhAMQtKvXsT1luFZisx4QSxvhdxyAmZAqpb3/Y?=
 =?us-ascii?Q?Q6xLt39HA1Ev8Ap/BqGryv920QjuIVnA31kLpBwwO/2sYs6tLNoNHCmdUVto?=
 =?us-ascii?Q?+vj2YimLGj/RsrUbTOMJXiAmeMpfLsxuWKu6FUCHh42U0B2f8Tx36aVsd+6p?=
 =?us-ascii?Q?7cSi0U+FNIdgPS8D5Ux/5KdPg6h6xtTGiZC6i7mymTWMIlz7VjEpf4IHpXLU?=
 =?us-ascii?Q?Z2lWLUJcsbMMAnUUjm/SH9gGhflu86cz3SeJM3PdDcxN9I9MvvkDVcvtzCS1?=
 =?us-ascii?Q?O+8eJgggndJnJtjfK5V1lG1ozWGoC78w+drZp+SYCioAGkWyRJlLGdj4iDWW?=
 =?us-ascii?Q?eTErIQejcnIlyHD38zrv/Zd3rIPD7wY+EB0s9mWe14WS6J3rm3Laa3yBeT8e?=
 =?us-ascii?Q?ik4V1OShDBCRnVuWjwKQ8MSl6aeHa4fhcs6r+3e4fvAc9we7GyIaiAkb8UzU?=
 =?us-ascii?Q?ZVTisw9ntft6SRv4LUT3F+Y9sr+JU0Jzb52opxfwmrlO5ZRPz8nIrGLFtCUn?=
 =?us-ascii?Q?gNjlRNuFHtNdCJWF4D4cu1WW9QX8yuJcKL50yKjIE1mFHeDy3KH51qapLmax?=
 =?us-ascii?Q?Yi683ggnkjL1gznpaGrAQyLej/Fumb/a9/8AxcW0qsTLWB3q/fz9M/aAZsqu?=
 =?us-ascii?Q?/7rBC5GAgkZMYDyRVV8n9imtWX7xsP/ZthkBuph9+vjntq9NdHF1NM3nhsle?=
 =?us-ascii?Q?oVDxasp7r4QvmRiY6DawkormPappluagfbnRZSRU+FhBxw1u6sL1w0vhgunC?=
 =?us-ascii?Q?NRwskAjClQicrVOUrgE18xUY6VyaKXCYIrFX3WhW87uPrpo9kXRL2atwBxwU?=
 =?us-ascii?Q?dwH5KJTrDS2TpVcK7EYvaIbcMYusp9OAqJGsbyeUrxHGoIr2LueqBeLCRsWW?=
 =?us-ascii?Q?Ig3x4/ts2ih1VHNpZ7hjlL9cGBJLZMU4iFNezPNYDmSfBJS9xGa9aS5z1y9P?=
 =?us-ascii?Q?xarRKmIX5lcAMXe1SiEIyHQdhzavzwdiyuaxpovGp+fnJdJGR0zaB11zIbL7?=
 =?us-ascii?Q?OyoZ8AxIMhU1ggraZlK42VGCfkCaM43rDMCdUo5qBt1ZhikgDuQ9cG/Uf9X7?=
 =?us-ascii?Q?BBaSuN8j7vwlEjpPo0vTjMaUA6j2TQ5RHIkWndfzoRxi74TpjkLq4unPfdY6?=
 =?us-ascii?Q?Lx35FIcvDHmavtPo87bh7MM65kXt1xGp3wI4j6kuAZSpxxE2fNsG7M3CUAUZ?=
 =?us-ascii?Q?W1Tge2FVPqCyvH7HFKwSoeAR0/UgGrtcmL66eRzbC5KATY6vgxhHrtbpcnKd?=
 =?us-ascii?Q?1oFGqxlMikMC5j8/4AZ78uMvDvPInJFHX1sselANn+AOD1vRYdTT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885e5366-8a0a-4637-044f-08dec7f1444c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:40:18.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iG7FKa7IpEvyZS9XshEU8uifnf/l0PEQsQp6i1E3hn9NXIT4LMWR252kgf+DiW+O9sy1PSmv7P7lS0COGni9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

Previous set "New Generic PHY driver for Lynx 10G SerDes":
https://lore.kernel.org/linux-phy/20260610151952.2141019-1-vladimir.oltean@nxp.com/
introduced the 10G Lynx SerDes driver with a reduced functionality set.
Namely, only minor protocol changes are supported (1GbE <-> 2.5GbE).
The major protocol changes need a procedure named RCW override,
explained in more detail in commits 6/8 and 7/8.

To keep the ball roling, this series adds kernel and device tree binding
support for RCW override. (being so close to the merge window, I don't
really expect this series to be merged, just want to get an initial
feedback so I can keep working on it)

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

Cc: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Rob Herring <robh@kernel.org>

Ioana Ciornei (5):
  soc: fsl: guts: use a macro to encode the DCFG CCSR space
  soc: fsl: guts: add a global structure to hold state
  soc: fsl: guts: add a central fsl_guts_read() function
  soc: fsl: guts: make it easier to determine on which SoC we are
    running
  soc: fsl: guts: implement the RCW override procedure

Vladimir Oltean (3):
  soc: fsl: guts: make fsl_soc_data available after fsl_guts_init()
  dt-bindings: fsl: layerscape-dcfg: define DCFG_DCSR region
  phy: lynx-10g: use RCW override procedure for dynamic protocol change

 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml |  15 +-
 drivers/phy/freescale/Kconfig                 |   1 +
 drivers/phy/freescale/phy-fsl-lynx-10g.c      |  24 +-
 drivers/soc/fsl/guts.c                        | 370 ++++++++++++++++--
 include/linux/fsl/guts.h                      |  20 +-
 5 files changed, 394 insertions(+), 36 deletions(-)

-- 
2.34.1


