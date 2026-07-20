Return-Path: <linuxppc-dev+bounces-24489-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE63DC4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 13:37:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3hQS28JRz2y8F;
	Mon, 20 Jul 2026 23:37:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784554640;
	cv=pass; b=REvssrlmXCf48n+uv6X1gjkfL1xmA7kmXf/w+K8LHeq2TPqxEFlnCP+/5ggQEEw6pMgcoaD26WiRff0dTXk9Sgumlqq6mz+xNjYu0Yvi0PEJ/S4df46ec7sM5xtuFFNfZNzYkiK8pk68KeuGOW/58do0873xULNtJlq06/8GH6lrWK0VzwvSMOUpkHGgA5vOMduKhrv6KmYi9NdTejQo+m6X419iZpN56bHhUMWbEif4xY6cNherNf44RpI0TRcqugm4L2WApKUZnDgIiKGhe19AoKBXFpfqlG08JMvK9CTKfe0qKUl69JjvmH/FkiaQ3R/X5n6U1JpRzy9ee8xAaA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784554640; c=relaxed/relaxed;
	bh=Obh7R9qKC5V8H7mIMt7BCNgcA1CyEsysjPEQ+3GdH/8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OwpiToDHXSu2VaoorDsXt4KzEIuiOgIZKtZYVbtwY4H9GtZ5o42YYzsyP6E0Vj2aWUL3RTArqvT7a+eFwYSr2qdOMiSOynDsYVvyIoHldukvwn6s4RX3btwk+oPpVUKD7w0CuXnynbAsFbdnu/pvKJ74N7OlwHTSROzKftm06Tf6yZFjVRp671Y1AUELdYcRdQHquhIyLXPSIczsfVf6EAz9BB2OiZCUXHgPxNpn4eDIL6t6WH0VwSO4+0rnShNkwBc226U9Ampfpur7VzWHnurKK/wVTlPeR8/qcvSSuJHSQKDkHhQWqS6KFuflMm7e0OdNcYvzLFb5+SDVfVFZBg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=UYgtVTrC; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=UYgtVTrC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3hQQ1LSkz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 23:37:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqQAHL7GidNFJ6oGFHgX4n+3/EQTedRuI4F+UmWI1QzFFBQtQ0lelLxYUAAndUhYUHFTZNlyP4C8fujkYhF21VA0e912tfqYJblJxJlMZSFpSKNnDaJArEhit06juh3jcUjcbMPf3ASukoraDdyiX0z8nwzI0GvnUpaD4RxAD9WzMtQY6/ldcOzx2seernBPbJkGgnmHYDSAlHjAnh8i60y3oOBOdQAX7ifcRHneKj8o+PjdyCruVUnzdCh8xXDZ0i6P8lF/p5dp1XSv5QddknzJ2QX2h4jmS1GKVSN9j4wuujeAOjeX5O9IEDAsL7iYch9l/TqkzIEqCYattrv9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Obh7R9qKC5V8H7mIMt7BCNgcA1CyEsysjPEQ+3GdH/8=;
 b=rAJthG+94cWH9jJndb9AdMGp+vqs5IRwvtzSYQV4VEZ7K4sdDwXqrlW+vyG6dUFJdk2CrbCpxeEbEH7FQrf35JMccdFnaG/8eyn7tnvvRwRE/+I12USp0XmvgXmveCfplxQkTO2w0vXmz+38bcbXVZ0oSNs8r+KMSMvxs3+uq9DOOoAHMQuOj02uvcpVB0NNJ0qu125m0v8C4kcvX0kVcS9ssYojsQwm/f/KzDXsNK6Uiv966LdQqeUF3C9V3VuTjVc564xfy8dfm2yaSec9I0AYURBn0qIe7vxl5OieXeIAg6UOeKyu3odTRQkSMGYRsNwYVLQSOeIxx0jDrPQHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Obh7R9qKC5V8H7mIMt7BCNgcA1CyEsysjPEQ+3GdH/8=;
 b=UYgtVTrCHS3BmhiXp8OZLsAprTFbqqnKc/0tcDBetAo+cDpmWchiZtaJtFbNbLY66Gq5/1ndJff4Ij8KYP5PEbTUzQmsgx67EONiGuFe0JP0KXr3vdRGCkeL3X8i/UEzGkLDJ1TQDH9wE+RR2/8dbnAnw2ynoiu7B1HxHHGo8FNn7SikffmOlZqsnNwfp3J3PH4gLedCQ7gKNC0CDrlHydgVr0w4x/E0jodupWBaE9aVQmCWObTCDpcKuLFBp8ICpVXthkXt9Q9rEX27gp4JC+1Ptcag2886PJQ3PYKok9iac7VO1ymGCH1pQk/S6n+71uvuVA+42MDQgDWtUywcNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS8PR04MB8626.eurprd04.prod.outlook.com (2603:10a6:20b:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:36:51 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:36:51 +0000
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
Subject: [PATCH v3 phy-next 0/8] RCW override for 10G Lynx dynamic protocol reconfiguration
Date: Mon, 20 Jul 2026 16:36:34 +0300
Message-Id: <20260720133642.136324-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::11) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS8PR04MB8626:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b3d99d-8d46-4b3c-b32a-08dee663f4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|3023799007|18002099003|10067099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	+0lcyEp12ZZj9BZoCnnwP2bEh25tDDPzsm65TywJV0gPqgTYdXmFC6u45t0Jrgsx2uAJPgEX881kNNLEW15RqSJjRJHZgMBfj2l/vJDh785N7DWqZ1KVmK+jTcLkoz4mlhC4m/R7LiXmu7G/2X5cf+VuCVoOoy6l9++StO+KG/vyXfxnnLpv/OThxcyb45nl/l8M+Xx4IuwZcO3KM64vxD6PWpcgjUSZBeMOZQj5G1bAq7GhiicUTMEQz5fUTci/eNA2LgQX4MoyayDeZxk7EvJvjXpNsizum8993XVIO3qzaWtiHHvH6pHgnLzgOI8lyFga/WwRnNNs4D6CuBTXHRlKBJuokxDiYFmx37/K7ytpHzz9hioMNu66DHnJnvedihlpxCjQLL16LkDscbRDeMXTAiAGgKTbH+o792/7oMAv4/K/kYJzmUrBjqh8NSJqA2XzrLIuyuDp+hF07lDvAaTWdAObhPoMKTX5Z9oHaw6/iv8kkqfRr1NjeBoyIwOMaMf7UvEu2zW7RW9rqKcYtTx+RcpCKBDmxnzIBChLVONYr6m3k8Vs0OluOtOrVetjl25hbzOxw3ZubCarjyHihiHoqIaEMusNRVz9iM6jKJOD5ii7w6HQb+FzJxQhMz+iile4YATn2FBfOh/qdw/OVBJp/hiyzFhoMrXWv0IjIWU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(3023799007)(18002099003)(10067099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ByRBNIU3RCpB+qdBZz6oifcMJEkMXC4VRm43W/VtQkugTGuKhHpVCTlO+zMi?=
 =?us-ascii?Q?Lf7OxC0lmYRJinomI9N/0ghqP1xQVaZ0RkoAtYyX8JVH8CyTtDdwRYsH0+P3?=
 =?us-ascii?Q?NOXfTG+uthHXoI01yc0CcsrDrfPQ17xBq0vCyRTjj5ICTjScFQGBHvTONs1Q?=
 =?us-ascii?Q?EC0XvrXRoL3+M1Kc6t1KQzWqKwDZwFX/TLtdUHyxO3IPkqfGpcOmucO448/R?=
 =?us-ascii?Q?aIunfo7JH/P3ZtDcjdbqZUd8XSYFMVPRVHFQBjtUj4rBNn33jXnLsFEj1HKu?=
 =?us-ascii?Q?FQ0GyOxCmss1alAAIBl2wKT9jXi5Qp4i4um1vw1lrE2e5cpSWbMnbajgmtev?=
 =?us-ascii?Q?mLlcx9jd9EysYee6sVZurMGU2fyXKMI9mGDaRaMxIdu8jR27KVRxF0a7Qbsx?=
 =?us-ascii?Q?6PEV9e7lGfxtynk7ZjWOKEGy3f0gHEXI0VMra5ejNGsXV1Ahern8gNR8DcsH?=
 =?us-ascii?Q?ZE5Wo2WcAqe796kjH6sIhAP6nmhMV7CXL8GgnvRejDhA3rYpm6etKFv0BUV1?=
 =?us-ascii?Q?LSIXBYGe60QwwCBtIgFWcZvk5HtzkUmFaMO4W/tU/ZZSvAYAbErCAhtPs0uy?=
 =?us-ascii?Q?FeGqn7yrAtAHfReTkDe7f/PKBshetpaQb4WV3Evewuf0s2ERkmQ62iz/ZxH8?=
 =?us-ascii?Q?I7qRKZFqVaq2jN7ojpeHsHl38UWJpP0u3xChC5iTZ/2gqC0cEAAZr+SK9xtr?=
 =?us-ascii?Q?00hl7wyHTJKb80G0O+SecSXIENWeDBguWt+e08wbk6mt9GyhfCNPJdSPIwQI?=
 =?us-ascii?Q?wuPzcgJBgJ6H1FA9nH6phUQUqLo5twb7GqEwrxg4k2nZLRYhTKhdgj9oE4YZ?=
 =?us-ascii?Q?nJlV4yksfoh0xqztex0x4UAYqpAyn9Ake+iGEv7yi1A81qqV7kIT4X66rpid?=
 =?us-ascii?Q?274oE8IFnMhaOBieST6PENoKIbZ7oIs564d9IykHKIKOxOSbM0NG1oyLa378?=
 =?us-ascii?Q?PECl0Rk58IxRbem6kWkp7TLIP0zqcjpZ8KvYciHtuXRbBMXcQ7xpVMfNkyrh?=
 =?us-ascii?Q?6TKwQTaZTaDITdfiA7t8JQikAgTFJ1/yVj95kwRze75AinigapY71OBdLtwm?=
 =?us-ascii?Q?11UCiO6Za+NiED6DTNfENOSKDNjNz+r/+9VzIkjho8zxCV39F9sUBqom78xG?=
 =?us-ascii?Q?5aEc49m6TXQbG2JC37pglFWLkhm1IbTX7/b33Mixa/Yl/tqONwQ5mkukf6GA?=
 =?us-ascii?Q?dno0IDsCEbM4bqolOnVHZaGPa5xsrXrcF/EDcIJrjfN411+hp1cEAqArLta4?=
 =?us-ascii?Q?juXPKy81RXzqgBRSnEmhH7rUJRh/hDj+nMHLGvPTUyaM6YZK4QtZuXAFAnHT?=
 =?us-ascii?Q?phLVWYl+x/cEOfTBcz+IOphLTz0RQQXXvuktDCUoJuiRJaoFf/XoXaImXDtg?=
 =?us-ascii?Q?5HKLLEqc6Z4FuoVHNzuhhvyCZ1dGNO8uM3aoYkw8qti89rV0Z23L+A8sbhbp?=
 =?us-ascii?Q?hXM5fNQVw+ByjWcVxfdgNrD0crCO4sn+hTAIW1GgKCzHvqIsMdvyAcLSfmTd?=
 =?us-ascii?Q?dLVCAi/rbMyn1kaurKZ7kX+NG8tnqTEOAWGFZWgsByb9X57jy3BziMlzZpbr?=
 =?us-ascii?Q?NRNgS3KTNWgEr9x58dfNXhm1KndlvDrehtklOsT76vBovtZ8WKw7AKHaWN+I?=
 =?us-ascii?Q?2/MMu4AcvCuPyhAfeqbRtvC9974OKf8s57nttvboFc6c1rJqOj4StkAKPEHr?=
 =?us-ascii?Q?nHVOL81glBhRbvfWHqwe95JrdywyVBWa3AIF3f3/3OyPfUZkMmv+GVtqizai?=
 =?us-ascii?Q?ESYm44p/J3qF71Xuut0eZ7HRrOj69KA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b3d99d-8d46-4b3c-b32a-08dee663f4b0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 13:36:51.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ce42wKa9gz9Iucor6ag+v2AkBbKNJDEh4iZeQptzzkIxLZ7Uimp+bAW8lkC61itn4a8MYZEgJRBxqKPNiWyUuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8626

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
 drivers/soc/fsl/guts.c                        | 438 ++++++++++++++++--
 include/linux/fsl/guts.h                      |  20 +-
 5 files changed, 459 insertions(+), 39 deletions(-)

-- 
2.34.1


