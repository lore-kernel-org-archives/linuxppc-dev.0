Return-Path: <linuxppc-dev+bounces-24627-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090D7C44532
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 23:17:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4YDm4xg6z2yvX;
	Wed, 22 Jul 2026 09:16:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784675816;
	cv=pass; b=LKu6FXXgPL+aLwPfBz9kG+gWbmFFqPpdaVQVDDjli70pqG+QkEqO+f+5ByIyavVn0MlbDgsYyGeYEI1Rh2Mxuos3uHv/J5c0CN52BW0iKx0Vr4d8OLg9s1CTp/FttenZ7N4kVhNbMbfSRRMWCDBMhX734TgbbWwKdo98YqiTZpIs7N2ycdN7MhG/whUtURiXij6lP8cCXHrDTjkLO1DrjVSBrf+XEFxLmNG3bTKgYsU+HiZ15Y6ZsNAZNDilsorJ9PUlr/aj0p/DhQour0vL5Ra4SoezvLVutA7K7TIcuF9TwkWMydmvd3qbP351JCnTznpyYjyLfqZ10Wme/pT7HQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784675816; c=relaxed/relaxed;
	bh=K6zr0PJgH9vc2maNc0jrHeCEELjjNSCTI14uHDR1lSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WOdxPSo2KfPp+oCLPSbwIZQnJ92+WS3Q4xEXru4bNQtryiXEd+bp8sX9BrQfTg8T3Jt5BWrtfN3xW9akus+bS6AcjkogQb5zaiPWPi+P3+bseOB5tWo/ze/jZcvgElW3nEVhDC7rVuz3dAsubLlgwXk4TybY7UyyKGzLEKvmewpfNglVyMot5u3VhKKIhwqtCsvpLDpi8SWsu5C8jNU4xlcYi0oIVmN965R7J9ABiFvUK81iISby9hviLA6cRnqc65840P4UbhEsKPG1tY1OXC3AkapfMoexFqasq3MITWDCe39JnyL0j3mh6wy5eePbkpmUoApE0CTP0U8ChDsg8w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=E7cLqQ5Z; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=E7cLqQ5Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4YDj3gGSz2yrC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 09:16:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wA0Ycq3e3P2d5d88viUdEfCATVxhWH/hCG9apQP92qiz5YrN9TB3ZAsX4PLgO8epYc6AYTys/9NZfA0t13QoFTvJiaV/iTqiY0r+DM1idzmnS1S8ULGuwxhEMINbJfyI++uNSmSpqka/mUwuBLFyqHzc1ATSGIZXhqKQs16o4EPTxA2B0Qo1rJ96Rytg1bV4PmICKrZS0rJlU/ooX8ZfpXy8+2Q2rUKE4vAI+s30gKwPr5i0OEWUYeDmKplcuAjrhb0ToSKuYLcCA/l5WE4g/UveRk/9YpNJPNj0GPbIEwoMi9i+LAscW4awiu0jbXUu5aSTR8SfbZmQw6yVKWe8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6zr0PJgH9vc2maNc0jrHeCEELjjNSCTI14uHDR1lSY=;
 b=QaYGx7KEB6WPq0bliiDzLOg3nvTHnCw6uY5XdzivvQFOrQrlqGh68/e1NyWDdo0FlsqL+veUxFszUuBdPC1k2LPd1B46vFWajwW/hjwpCunIn/m3oMjimgngIJI4EZz/BQ52AVnOtDYml7ZPDpojS+4WB+nC6mZ0Px4sI9lQyUwZoKmsAIlfb3e6xWHDSCSHqq9DmnvcoDDqD26bNRA2T20zv38V3/nMCErt0m/bK+upVLTOiunw35v4cS7LhVZIRpebLDyIGhQi6WatpW8GS8bq3btUM97HXg5MBZ4OQUDh7S2cfwlym0LrQbJG+K16XHuJABMQbx9oCC7vAMC9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6zr0PJgH9vc2maNc0jrHeCEELjjNSCTI14uHDR1lSY=;
 b=E7cLqQ5ZMSXRoJ/GFLrHHOU1/t+EM2hXR7Nao/Fhyk/j6/Rj/RpkIl0eWgL6r4tdQEl+j20lX2LIg6yWYr+L4N0Pxov/H7OSv+fkr50GNNgvxBO/9FuvGYsmPq9TAFOjz+ifXMzFvu97NaicFoecCYVa1j+12SFAJbdx7YVkQN7iZLru9nozDrf50cwtXbruds/0ujbNh6t7R2iEXXvWUyGT30L/qQk8ojarN3bIOwwf1KJLg81Q/1A4O2E0XGq7/qs1YkuRy859AAxPwpZMj2xLDibRN+Hk9e8cC6QLBKzGL0okQz3XD/h/vLZkXIcB8scegIEN0SU436p+y9TbGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB11817.eurprd04.prod.outlook.com (2603:10a6:800:2ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 23:16:27 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 23:16:27 +0000
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
Subject: [PATCH v4 phy-next 8/9] soc: fsl: guts: implement the RCW override procedure
Date: Wed, 22 Jul 2026 02:16:02 +0300
Message-Id: <20260721231603.67865-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721231603.67865-1-vladimir.oltean@nxp.com>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::13) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 91ab6ee0-871e-4b90-4ee0-08dee77e16fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	LLFL3L028viGDZqMucEn0RcN0WZobxiZgT9pMmzQry57YxguLOaujPefbFKAUVqkndi7VX50F9dRwy+umKaENO+ApoWo/yqNNeowOKVivrBR/cSPYiQRhabdZPjQrpz36EBx/MVh5tLteTVpuv42nrcQlZF+z0d+nprQoAtOC5FCwXqt1x8NOL7O5uJKXtSNw1nXJdi8PprOugN7xyG2Xxn+V/lPPf87iuFyNWTxfwQc4+R3gQoDBASElNVXsX5Ac76msrWoz8EHQzRN1G+eO7PK8V4D9/2LqGQ75tO9XQsFUvdSGFn03jKwCZZukjAuQNAU9h3TXcwj6M0tiN/4OTfiLtmSZM8lJ8J23//KfTw7IxpOhGU08q5kDeNIMgIJYvXM9/h0liJ7lTPjWwon7M/Lf8FhFGlgS/M/KjKB04ZCFUxasrLnf+40eki2uSse+dJYQE3eMnl/rk+mhcAbpSunxVK50bhhb1+GQyHVD67Lov6AtQElBBK7czYODinlSXA7gWctES28fKY9zcV003G4EPe5NZp4b/aYtE9cxX2gwGaoKji6HRdpsyGNfXmxBOsjVuNiZAnMTXsGzWHqkWyOCmqkgFbAfsdQbWDVmkwRuq/evuwo+zH1m3dZstcv8fn34gWdNJ8a0yHjGto1S6IYGEQx3m+yF/Nm/FBzGNQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UjC4gO6YeXHC/mmLMzKK8zY3rIUfRQG/FGwzZTY+TIGwxIuW8IGV74FPoirO?=
 =?us-ascii?Q?+u9cO3LAWGJIixKoXHugJIz1532h91bfxMHirNzNj81zV9s19kXhHaCyZKQO?=
 =?us-ascii?Q?35i0SZudYtkGVNe2R8gB4wBztX6XP0mCztz6JMyUUKCG94VnUJ8KOe7msXzU?=
 =?us-ascii?Q?I+k/R1zhEVh3a8aW8cumhoTYzppeYaiR7fuJtrlCuuCYYXKuiTFEofgFSca9?=
 =?us-ascii?Q?KWZA4S42ToSBf+hKKjMwwVeuGTDvmkLQ7MfvCPnpRz4g79qKuRQIOyr3OPpc?=
 =?us-ascii?Q?KUevk8qgsFbfvIRyG6M6cfdXAIHpphlLhNddWRhKhMqXxkTDCBYl4At35o6P?=
 =?us-ascii?Q?kWYS/c/JqBEQ4ioW+O3+QOgKLaUjKBX2rIf5fL8keYcXp286bV4pFXv6KI7k?=
 =?us-ascii?Q?Wui2wUzTAvYUjIp4T8zRP1fc26y987NbZX7fgQ/2cm/ws8OTR+KglPiXQwaK?=
 =?us-ascii?Q?U2rbt57qKljVp4S+uRpNHeMNXGCXbbZheYgdgyJQZFZOJ1fo7L5NNP6H0hR/?=
 =?us-ascii?Q?zIM2PivHy2x/AeQPkW8BN53Iel2TSqJwbuej+TsFLUM2D07D8zxiwmN21Yju?=
 =?us-ascii?Q?dmf0rKhRZVWqOmMusCW03glC4sIqQ42nMTEv7G63Hy7JvOem+0Gad9LjS+FZ?=
 =?us-ascii?Q?/oObPHe5HuP98zJX3SKWrVTqUgcBkV9tihr9WRpfcMs42I9BLrY9LAneL1m/?=
 =?us-ascii?Q?scZFEdfuD34BUXiu08eJkBkW9dBsq/YB2xsB2swpYiAABA1Wh0820d+jYI8f?=
 =?us-ascii?Q?czHr4byIwh7oOO7B+4wJ73O9OFiIP642WIx2U7bHGJq1pXYtSEwZ/+9ImrKb?=
 =?us-ascii?Q?AJ9FHXC90UQJWh6M0fPL9oPzgrqS9p/1B34XpwFrmzPtmP3BIvg3mhIkIPtN?=
 =?us-ascii?Q?Qf+YbweRu4Hun+PH80p1O+lfOQmK5zyVDyBdYzV7+V//0KnyfRm3cigCCVVx?=
 =?us-ascii?Q?X+4cOZW1kF5ZC969Mz5ayuwVisHXOaAi33PECyicEZxMeF+Qsrz/sK3nBeCU?=
 =?us-ascii?Q?d0GP1POeemqrav4uTVyeceVK/3UmZgQaSJu1gCSJLInVrBTE8A47oFy7LF6K?=
 =?us-ascii?Q?f/SjIJYqI6+quvlDhAZSkt84a+ZCS8BqNYRwtqM1bUMKqUXt5HlTQZV20eD0?=
 =?us-ascii?Q?kXyDMg8gqp9yoIbyOPgLCp4vhhR5atOd5LZv6SPHY7AbEaZ/zBPHfYX/hoPn?=
 =?us-ascii?Q?HboTZWxkjH+RPqMoRw93eh7PAjGd2QhoZqyIZ/nFFKEqaLAnxGpRgiSmUFOz?=
 =?us-ascii?Q?o7XloGdllrp3zHmESFYz3h+dTxG0rId3FaXaGCY4A4HYODZrPug7uhiO4Zt4?=
 =?us-ascii?Q?jNkYKE60WQFy9D80FNCvIBOHtJk54dvtWG+qdneaXb78KyHZZboNujcxSur5?=
 =?us-ascii?Q?9yWBcXXuo8aZvBX5Fo7hrPEsWCdk5+ClThk7yiBW8V57YtURu5JdAjFTiwPV?=
 =?us-ascii?Q?1sKYTpXYNC0bESSTb7cSlpRKXGYYYs2Pp6imr8uDkLJHnHphq9wk0u8ro9h0?=
 =?us-ascii?Q?30iBDdXz0l4I/7GkKXDdxKVPiM3W3zCcwxFqKWyxEScnTOqLgATyMA4N43Np?=
 =?us-ascii?Q?NpR5KK2IAEd6Hye5ggc5Gouyj8zzPfxa5kQsIsonZF055gn25VhnpKurndAO?=
 =?us-ascii?Q?LlWE0wX2z44C8K2t9Ux2xXINbrzcOqcfeIJP11ubFRiReskPa88hBlfdkSwy?=
 =?us-ascii?Q?+VooquwQR3oEEjsywg1gTyOiDUU4IvA/+WgEBu2JjYvVoNGM4VpALYda6mO2?=
 =?us-ascii?Q?cCUr+cYm6w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ab6ee0-871e-4b90-4ee0-08dee77e16fb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 23:16:27.1781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iZIMf8YPd/F8N+oRxbIdWULySTkN8W56hZrV8PRI0KxTKm3BpIanQ8y9w+qgkVhevCLY2Rx/UFppq4W8iGBmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11817

Add support for the RCW override procedure which enables runtime
reconfiguration of the protocol running on a SerDes lane. The procedure
is done through the DCFG DCSR space which now can be defined as the
second memory region of the guts DT node.
Support is added on the following SoCs: LS1046A, LS1088A, LS2088A.

The procedure is exported to the "client" driver - the Lynx10G SerDes
PHY driver - through the following functions:
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
v3->v4:
- move spin_lock_init(&soc.rcwcr_lock) before the of_iomap(np, DCFG_DCSR)
  assignment, so that fsl_guts_lane_set_mode() has no chance of using
  uninitialized resources, but will fail cleanly
- adapt to new error handling scheme in fsl_guts_init()
- add comments and a print in fsl_guts_rcw_rmw()
- remove fsl_soc_die_match_one() from fsl_guts_serdes_get_rcw_override().
  Shouldn't be necessary; implicit from presence of
  soc_data->serdes_get_rcw_override() method.
- fix serdes block and lane count bounds
- replace fsl_guts_lane_init() with SRDS_PRTCL_S1 decoding
v2->v3:
- move iounmap() of dcfg_dcsr area on the 'err' label
- use __ffs() (standard API which also works on armv7) instead of
  __bf_shf() (an internal helper meant for compile-time constants in
  bitfield.h)
- only operate on lanes on which fsl_guts_lane_init() was called in
  ls2088a_serdes_init_rcwcr()
- use read_poll_timeout_atomic() in fsl_guts_rcw_rmw() to clarify that
  DCFG_DCSR writes are supposed to reflect back in DCFG_CCSR
- check soc.data in fsl_guts_serdes_get_rcw_override() to ensure
  fsl_guts_init() succeeded
- put parentheses around (lane) in LS1088A_RCWSR29_SRDS_PRTCL_S1_LNn()
  and LS1088A_RCWSR30_SRDS_PRTCL_S2_LNn() macro expressions

v1->v2:
- drop DT maintainers from explicit CC
- keep devicetree@vger.kernel.org CCed on entire series
- include missing <linux/bitfield.h>
- namespace SRDS_PRTCL values for LS1046A and LS1088A, even if they are
  the same. For LS1028A (not covered here) they are not.
- prefix SRDS_CLK_SEL_{GMII,XGMII} with LS2088A_
- reorder alphanumerically (LS1046A should come before LS1088A)
---
 drivers/soc/fsl/guts.c   | 399 ++++++++++++++++++++++++++++++++++++++-
 include/linux/fsl/guts.h |  18 +-
 2 files changed, 409 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index c283d44b68a3..28361c63e26c 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -5,7 +5,10 @@
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
  */
 
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/of_fdt.h>
@@ -15,6 +18,28 @@
 #include <linux/fsl/guts.h>
 
 #define DCFG_CCSR	0
+#define DCFG_DCSR	1
+
+#define RCW_TIMEOUT_US	1
+
+#define LS1046A_RCWSR5_SRDS_PRTCL_S1(lane)	\
+	GENMASK(19 + 4 * (lane), 16 + 4 * (lane))
+#define LS1046A_SRDS_PRTCL_XFI				1
+#define LS1046A_SRDS_PRTCL_100BASEX_SGMII		3
+
+#define LS1088A_RCWSR29_SRDS_PRTCL_S1_LNn(lane)	\
+	GENMASK(19 + 4 * (3 - (lane)), 16 + 4 * (3 - (lane)))
+#define LS1088A_RCWSR30_SRDS_PRTCL_S2_LNn(lane)	\
+	GENMASK(3 + 4 * (3 - (lane)), 4 * (3 - (lane)))
+#define LS1088A_SRDS_PRTCL_XFI				1
+#define LS1088A_SRDS_PRTCL_100BASEX_SGMII		3
+
+#define LS2088A_RCWSR29_SRDS_PRTCL_S1			GENMASK(23, 16)
+#define LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1	BIT(14)
+#define LS2088A_RCWSR30_SRDS_CLK_SEL_XGMII_Ln_S1(lane)	BIT(6 + (7 - (lane)))
+#define LS2088A_RCWSR30_SRDS_CLK_SEL_MSK		GENMASK(13, 6)
+#define LS2088A_SRDS_CLK_SEL_XGMII			1
+#define LS2088A_SRDS_CLK_SEL_GMII			0
 
 struct fsl_soc_die_attr {
 	char	*die;
@@ -22,9 +47,21 @@ struct fsl_soc_die_attr {
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
+	int num_serdes_blocks;
+	int num_serdes_lanes;
+	int (*serdes_init_rcwcr)(int index);
+	int (*serdes_get_rcw_override)(int index, int lane,
+				       enum lynx_lane_mode lane_mode,
+				       struct fsl_soc_serdes_rcw_override *override);
 };
 
 enum qoriq_die {
@@ -44,6 +81,48 @@ enum qoriq_die {
 	DIE_MAX,
 };
 
+struct rcw_full_srds_proto {
+	int srds_proto_val;
+	unsigned long xgmii_lanes;
+};
+
+static const struct rcw_full_srds_proto ls2088a_rcw_full_srds1_protos[] = {
+	{ 0x05, 0 },
+	{ 0x07, 0 },
+	{ 0x09, 0 },
+	{ 0x0a, 0 },
+	{ 0x0c, 0 },
+	{ 0x0e, 0 },
+	{ 0x10, 0 },
+	{ 0x12, 0 },
+	{ 0x14, 0 },
+	{ 0x16, 0 },
+	{ 0x18, 0 },
+	{ 0x1a, 0 },
+	{ 0x1c, 0 },
+	{ 0x1e, 0 },
+	{ 0x20, 0 },
+	{ 0x22, 0 },
+	{ 0x24, 0 },
+	{ 0x26, GENMASK(7, 6) },
+	{ 0x28, GENMASK(7, 4) },
+	{ 0x2a, GENMASK(7, 0) },
+	/* 0x2b: unimplemented because of XAUI1 (lanes E-H) */
+	/* 0x2d: unimplemented because of XAUI1 (lanes E-H) */
+	/* 0x2e: unimplemented because of XAUI1 (lanes E-H) */
+	/* 0x30: unimplemented because of XAUI1 (lanes E-H) */
+	/* 0x32: unimplemented because of XAUI1 (lanes E-H) and XAUI2 (A-D) */
+	/* 0x33: unimplemented because of QSGMII (lanes E-H) */
+	/* 0x35: unimplemented because of QSGMII (lanes A-C) */
+	/* 0x37: unimplemented because of QSGMII (lanes E-F) */
+	{ 0x39, 0 },
+	{ 0x3b, GENMASK(6, 4) | GENMASK(2, 0) },
+	{ 0x4b, GENMASK(7, 4) },
+	{ 0x4c, GENMASK(3, 0) },
+	{ 0x4d, 0 },
+	{ 0x58, 0 },
+};
+
 /* SoC die attribute definition for QorIQ platform */
 static const struct fsl_soc_die_attr fsl_soc_die[] = {
 	/*
@@ -138,9 +217,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 
 static struct fsl_soc_guts {
 	struct ccsr_guts __iomem *dcfg_ccsr;
+	struct ccsr_guts __iomem *dcfg_dcsr;
 	const struct fsl_soc_data *data;
 	bool little_endian;
 	u32 svr;
+	spinlock_t rcwcr_lock; /* serializes concurrent writes to the RCWCR */
 } soc;
 
 static unsigned int fsl_guts_read(const void __iomem *reg)
@@ -151,6 +232,36 @@ static unsigned int fsl_guts_read(const void __iomem *reg)
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
+static int fsl_guts_rcw_rmw(int offset, u32 val, u32 mask)
+{
+	u32 rcwcr, rcwsr = fsl_guts_read(&soc.dcfg_ccsr->rcwsr[offset]);
+
+	rcwcr = rcwsr & ~mask;
+	rcwcr |= val;
+	fsl_guts_write(&soc.dcfg_dcsr->rcwcr[offset], rcwcr);
+
+	pr_debug("RCW override: RCWSR%d 0x%x -> RCWCR%d 0x%x\n",
+		 offset + 1, rcwsr, offset + 1, rcwcr);
+
+	/* Updates to RCWCR should be visible back in RCWSR immediately */
+	return read_poll_timeout_atomic(fsl_guts_read, rcwsr, rcwsr == rcwcr,
+					0, RCW_TIMEOUT_US, false,
+					&soc.dcfg_ccsr->rcwsr[offset]);
+}
+
 static bool fsl_soc_die_match_one(u32 svr, const struct fsl_soc_die_attr *match)
 {
 	return match->svr == (svr & match->mask);
@@ -167,6 +278,97 @@ static const struct fsl_soc_die_attr *fsl_soc_die_match(
 	return NULL;
 }
 
+static int
+fsl_guts_serdes_get_rcw_override(int serdes_idx, int lane,
+				 enum lynx_lane_mode lane_mode,
+				 struct fsl_soc_serdes_rcw_override *override)
+{
+	const struct fsl_soc_data *soc_data = soc.data;
+
+	if (!soc_data)
+		return -ENODEV;
+
+	/* serdes_idx is one-based */
+	if (serdes_idx > soc_data->num_serdes_blocks || serdes_idx <= 0)
+		return -ERANGE;
+
+	if (lane >= soc_data->num_serdes_lanes || lane < 0)
+		return -ERANGE;
+
+	if (!soc_data->serdes_get_rcw_override) {
+		pr_debug("RCW override not implemented for SoC\n");
+		return -EINVAL;
+	}
+
+	if (!soc.dcfg_dcsr) {
+		pr_debug("Device tree does not define DCFG_DCSR region necessary for RCW override\n");
+		return -EINVAL;
+	}
+
+	return soc_data->serdes_get_rcw_override(serdes_idx, lane, lane_mode,
+						 override);
+}
+
+/**
+ * fsl_guts_lane_validate() - Validate that SerDes protocol is implemented and
+ *	supported on current SoC
+ * @serdes_idx: one-based SerDes block index
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
+ * @serdes_idx: one-based SerDes block index
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
+	if (soc.data->serdes_init_rcwcr) {
+		err = soc.data->serdes_init_rcwcr(serdes_idx);
+		if (err)
+			goto out_unlock;
+	}
+
+	err = fsl_guts_rcw_rmw(override.offset,
+			       override.val << __ffs(override.mask),
+			       override.mask);
+	if (err)
+		pr_err("RCW override failed: %pe\n", ERR_PTR(err));
+
+out_unlock:
+	spin_unlock(&soc.rcwcr_lock);
+
+	return err;
+}
+EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_set_mode, "FSL_GUTS");
+
 static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
 {
 	struct device_node *np;
@@ -193,9 +395,188 @@ static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
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
+static const struct rcw_full_srds_proto *ls2088a_get_full_serdes1_proto(void)
+{
+	u32 rcwsr29 = fsl_guts_read(&soc.dcfg_ccsr->rcwsr[28]);
+	u32 srds_prtcl_s1 = FIELD_GET(LS2088A_RCWSR29_SRDS_PRTCL_S1, rcwsr29);
+
+	for (int i = 0; i < ARRAY_SIZE(ls2088a_rcw_full_srds1_protos); i++) {
+		const struct rcw_full_srds_proto *proto;
+
+		proto = &ls2088a_rcw_full_srds1_protos[i];
+		if (proto->srds_proto_val == srds_prtcl_s1)
+			return proto;
+	}
+
+	return NULL;
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
+	/* RCW override only supported if we know how to handle the initial
+	 * RCWSR29[SRDS_PRTCL_S1] value and turn it into an override.
+	 */
+	if (!ls2088a_get_full_serdes1_proto()) {
+		u32 rcwsr30 = fsl_guts_read(&soc.dcfg_ccsr->rcwsr[29]);
+
+		/* If a SerDes-level override is already in place (probably
+		 * left there by a previous boot stage), use it.
+		 */
+		if (!(rcwsr30 & LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1))
+			return -EINVAL;
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
+static int ls2088a_serdes_init_rcwcr(int serdes_idx)
+{
+	const struct rcw_full_srds_proto *srds_prtcl_s1;
+	const struct fsl_soc_data *soc_data = soc.data;
+	u32 rcwsr30;
+	int i, err;
+
+	/* SerDes 2 supports only SGMII for networking. There should be
+	 * no need for RCW override
+	 */
+	if (serdes_idx != 1)
+		return -EINVAL;
+
+	/* SRDS_CLK_EN_SEL_XGMII_S1: SerDes Clock Enable Select XGMII Serdes 1:
+	 * Enables to select GMII/XGMII clock according to
+	 * SRDS_CLK_SEL_XGMII_Ln_S1.
+	 * If the GMII/XGMII select override has already been set, use it.
+	 * Otherwise, derive an initial override for all lanes based on the
+	 * full SerDes protocol table.
+	 */
+	rcwsr30 = fsl_guts_read(&soc.dcfg_ccsr->rcwsr[29]);
+	if (rcwsr30 & LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1) {
+		pr_debug("RCWSR30 = 0x%x, using this.\n", rcwsr30);
+		return 0;
+	}
+
+	srds_prtcl_s1 = ls2088a_get_full_serdes1_proto();
+
+	rcwsr30 = LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1;
+
+	/* We need to configure the initial state of all lanes for
+	 * the SerDes block #1
+	 */
+	for_each_set_bit(i, &srds_prtcl_s1->xgmii_lanes, soc_data->num_serdes_lanes)
+		rcwsr30 |= LS2088A_RCWSR30_SRDS_CLK_SEL_XGMII_Ln_S1(i);
+
+	pr_debug("Setting initial RCWSR30 = 0x%x based on SRDS_PRTCL_S1 = 0x%x\n",
+		 rcwsr30, srds_prtcl_s1->srds_proto_val);
+
+	err = fsl_guts_rcw_rmw(29, rcwsr30,
+			       LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1 |
+			       LS2088A_RCWSR30_SRDS_CLK_SEL_MSK);
+	if (err) {
+		pr_err("Setting up initial RCWCR failed: %pe\n", ERR_PTR(err));
+		return err;
+	}
+
+	return 0;
+}
+
+static const struct fsl_soc_data ls1088a_data = {
+	.serdes_get_rcw_override = ls1088a_serdes_get_rcw_override,
+	.num_serdes_blocks = 2,
+	.num_serdes_lanes = 4,
+};
+
+static const struct fsl_soc_data ls1046a_data = {
+	.serdes_get_rcw_override = ls1046a_serdes_get_rcw_override,
+	.num_serdes_blocks = 2,
+	.num_serdes_lanes = 4,
+};
+
+static const struct fsl_soc_data ls2088a_data = {
+	.serdes_get_rcw_override = ls2088a_serdes_get_rcw_override,
+	.serdes_init_rcwcr = ls2088a_serdes_init_rcwcr,
+	.num_serdes_blocks = 2,
+	.num_serdes_lanes = 8,
+};
+
 static const struct fsl_soc_data ls1028a_data = {
 	.sfp_compat = "fsl,ls1028a-sfp",
 	.uid_offset = 0x21c,
+	.num_serdes_blocks = 1,
+	.num_serdes_lanes = 4,
 };
 
 /*
@@ -221,10 +602,10 @@ static const struct of_device_id fsl_guts_of_match[] = {
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
@@ -240,6 +621,8 @@ static int __init fsl_guts_init(void)
 	u64 soc_uid = 0;
 	int ret;
 
+	spin_lock_init(&soc.rcwcr_lock);
+
 	np = of_find_matching_node_and_match(NULL, fsl_guts_of_match, &match);
 	if (!np)
 		return 0;
@@ -251,6 +634,8 @@ static int __init fsl_guts_init(void)
 		ret = -ENOMEM;
 		goto err_clear_soc_data;
 	}
+	/* DCFG_DCSR is optional */
+	soc.dcfg_dcsr = of_iomap(np, DCFG_DCSR);
 
 	soc.little_endian = of_property_read_bool(np, "little-endian");
 	soc.svr = fsl_guts_read(&soc.dcfg_ccsr->svr);
@@ -260,7 +645,7 @@ static int __init fsl_guts_init(void)
 	soc_dev_attr = kzalloc_obj(*soc_dev_attr);
 	if (!soc_dev_attr) {
 		ret = -ENOMEM;
-		goto err_unmap_dcfg_ccsr;
+		goto err_unmap_dcfg_ccsr_dcsr;
 	}
 
 	ret = soc_attr_read_machine(soc_dev_attr);
@@ -321,7 +706,11 @@ static int __init fsl_guts_init(void)
 	kfree(soc_dev_attr->family);
 err_free_soc_dev_attr:
 	kfree(soc_dev_attr);
-err_unmap_dcfg_ccsr:
+err_unmap_dcfg_ccsr_dcsr:
+	if (soc.dcfg_dcsr) {
+		iounmap(soc.dcfg_dcsr);
+		soc.dcfg_dcsr = NULL;
+	}
 	iounmap(soc.dcfg_ccsr);
 	soc.dcfg_ccsr = NULL;
 err_clear_soc_data:
diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
index fdb55ca47a4f..8d5ffb985fee 100644
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
@@ -131,6 +138,11 @@ struct ccsr_guts {
 	u32	srds2cr1;	/* 0x.0f44 - SerDes2 Control Register 0 */
 } __attribute__ ((packed));
 
+int fsl_guts_lane_validate(int serdes_idx, int lane,
+			   enum lynx_lane_mode lane_mode);
+int fsl_guts_lane_set_mode(int serdes_idx, int lane,
+			   enum lynx_lane_mode lane_mode);
+
 /* Alternate function signal multiplex control */
 #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
 
-- 
2.34.1


