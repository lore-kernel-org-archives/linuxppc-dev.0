Return-Path: <linuxppc-dev+bounces-24496-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11113C4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 13:38:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3hQd1hLwz3bps;
	Mon, 20 Jul 2026 23:37:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784554649;
	cv=pass; b=jjHiSooXcWqH9BeJo1PzIC6uKhq0U17/Ot53RkqOfcgX0T/uO/OtfSrQV0dIWTFVosfyinmocJMyhvMoN4aWn0SufGI7Oj1NrJzrhorHCYW1Q3pgaX2UI/Z76V/vw7hReAhSS59MM2c8dXu5LPjMA8q8MnKu7DJ9R2Qs22hpZ6s2YOFoDeAgj3yNZA7AX1nj8Jm2cixRSl6AKL+RFXtQ4F0a9O+IBl8WklTRmTHAlf7FwGFzusyTNBT8wahMEft97i+TQukS1fPyVP9AMZq+4HP1fc+hZT1qxznuyoLjC92jhGbxJBe3NqoTFf9Nf6CVZkVA076GwmCMqrMGJsSRtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784554649; c=relaxed/relaxed;
	bh=mA0nRveog1qyyZLfvlwcHDdyGrC3b7/FKY4r+PiCLfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cGHEGjEIagCC1eo5/pKSevgg4+J3dsdNfO/6CbTF9zckU6T5eiaxpubSVYH7Kv4UTHEKLdSAdWQILHw3t5R/Vx2GFbeWnSFsd1VcmmLjD/0/kiT1kWlrZyMAKGezb/pQJRLwYiTgdp7YnuaMzje3YGWjVdCPHzj3Yn7IlZ9vtw4FRGdqAOQKCKJijgb0WrECpIJOv1BMh1jTDI4XXGNeBfk/YxZl0rfkwu27Q5JjzIR9CQ6Fm85Ho++bRxdKVPA2q08PC66utgK3QEyP1s8eHFgxxlKTDTtqhHXQA/kqTKaAqSpw5x0UZ6p+Q7zUG3bmnAVCfE3Q5W6kugtloMHcAQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TecSlU16; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TecSlU16;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3hQZ5qqbz3brv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 23:37:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcDGU6GdxCeXQSj4TSjhy/jnjOfYuVtXyFaA8LGcuFnhOjg4RCx/6XwxmnhkVQDzbUrd2WJFuLiRvb/lcEv1wLV4MfHN6+7IfmbimOGlJuNC0r/mkMku1EVDxAss1Lwonzo52KpWuFOfn3tTBLxxrxNS9sZIf8hHKnyWffd5DfdFQZmWS36VaK2OTnfcvonu/7sZVEnJskbmcN5IGbAtkEpYZNWZZLMBgjv0lV6uF0gXOIPDYL5XqooelqNLipMja1jmbVMcNNAx9Oq3IzKl1hCfpFbzg4SD+oo876zO0NQ0PHHAZmBohmxFawXnlAbc4U3qGf+j6gXc9JTP1+pEPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA0nRveog1qyyZLfvlwcHDdyGrC3b7/FKY4r+PiCLfE=;
 b=kwppLaa5WqQt02fwU2DT+eKbmDVwsDDIDYABMkGTdjQ2v51oVfIjri7SDgRLiCF46utmTxDoj7xd8NtaKGTSN+OStVpafnroHOLllwq3UFtzl21952JK0gsdhjAGGnZX7hWKZtQu4F76E3S+aOKKdLvEHKhhn3rdajm+R3MaBEUhbXzYBsSu6OiKUNpX30wAP6IEh7ptWgqQgE2jhvKSQ0S/3wflZxig3hEtTcsrotKilJ9qwH71U6tohIdb7tSeteazTPvUaLgaI4unbC2pBho0vZY8+5v43RbuTa0Cd2uDQMZUtm1hLl7ZwpFztQZipiRdjWubqw7i0n740OlX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA0nRveog1qyyZLfvlwcHDdyGrC3b7/FKY4r+PiCLfE=;
 b=TecSlU16YpDt7xz4tRN9b4SmNQfsUIVdpYjKOwF1GwhfQ8qB9Vd0CxGVx+66oVX9TwvioDFTa7Qu5GZnSMotRMvJiWeUOS/6F5WHSG/pH5i0xLQYxOSBqk5Za5bZ8z1OGR5MigwPxoRRT3cY/LLjgyPzClH9qgd2nMStzwSDU856qcHs2LwS3wsfuGHi6KUVVsG+esWgI7N05COZrMEtNhr/SswQGMqWlPC2MOEqx3dTzOFBQHNrCXVknEWVIdnp3xaGBN68ZeosPdUOQFwBiIghQ4liv4ZhHZKZU4EoZ+dyUE17wNP87W+/CGLNImY7pObR309goPTRgOy3YBbFKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:37:07 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:37:05 +0000
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
Subject: [PATCH v3 phy-next 7/8] soc: fsl: guts: implement the RCW override procedure
Date: Mon, 20 Jul 2026 16:36:41 +0300
Message-Id: <20260720133642.136324-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720133642.136324-1-vladimir.oltean@nxp.com>
References: <20260720133642.136324-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::17) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|PR3PR04MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 153cb9ce-37bb-42cf-f88a-08dee663fd32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|7416014|376014|1800799024|3023799007|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pxGL7g2p0qbq2YR0sT1YUBUevoXyUIJ/sTV25npf0ws+dri6coh+7K0d83XWxES1GNFu5JolvVNIBhJOiEbdT0WNH8yMlhU7r1mJXXtbpWArsiyuQ/Zhquau4cfnTosgEUx6lQP/OEwuJ4j/JszhmQty79wWIWWlwYcD1cB/ayW23SVFq5wBGPIJ/MnEPbVLZvkVEqylL3BatpwuEmJ0TXcWySFz7BxD0fWbqUGRmXU63GEmPyw/K8ZbuWS2qN6vPlailQ+pzoCTz2ap4edAxhiM2sKovOKfGk6HRWh7QMPh9BFrxR8/7M+5fA97+3uZ01LETY4KAlYc62/D80SarhpnfV6pkyCjVQLgiBI046lRpaVp4vrK+eDE80nRlCZoZo8FVnFqTUplTbvljyMypEnTrNeXVGO4AJI9MTtyC9Gbzb762MVa641qUPLQyFbuFyWGHfx0wFJOxVaJm2gwH5LuOjRoyfsJxvNTAlb4gA0IEwKPvZTmbXI64/48q6kh7tPYkRLaQQRxsSRfcq1xdpmUhvEIV8/Qjd4M3KJinfnMlE4AxKpAJ8AD/AXu8YSqzigPeft5KnrNuhf0UZ6hCYZExbAPYEqLcMMyN4saSxuIrdivV+CqFJ8oUUne+ngBhyz4jYnrFH/hSQLhAlkQvgw/YfE7tCSIqRb5D/IPW9I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(7416014)(376014)(1800799024)(3023799007)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HI5uqGlQSbSydQTbxroyIMxUd3g2sQYTlPh/qCErRiPhe3z1syAOddEY4W7g?=
 =?us-ascii?Q?9yUJVnXLEcNb4jeZRpACc0+eEuHPVoczKJgIIuqLDhUPbPP4GG31l12Z+iOe?=
 =?us-ascii?Q?bLq0vjkUl5A6YhzQ3q4KNXJ0SGombgXlRoRQIntDewOb265xo6g0D+4ESAAV?=
 =?us-ascii?Q?FAvo0j/UmcDHHePlQn72/sCIAKdVeJStGw8x3vuJfwNSCDfaJAGul6ivnJ07?=
 =?us-ascii?Q?Msb8IpGMCy1j1v4tTWlGJdTghnaKL4HJa9ApPZnvxlh3dEX1F+tkswWXKA8L?=
 =?us-ascii?Q?Auqs/UB8+Kfc2Qwg63EfnsbeJfmzA9+l0jxwGkGXR91y0c8uRS1sLGw84cjH?=
 =?us-ascii?Q?5EbLyszoHEE4WtMDJ/xPGlfBhCo8T/AYWlWhdm0zIScs4/6N4RBShI6fNZpw?=
 =?us-ascii?Q?KT8jox6OBwyLF3SJPWX4b+03AYzDpCSNAp2zd2shQWRUuXm4PjE6mXrGOnbo?=
 =?us-ascii?Q?pkLZEcRSoeQ8h8/3yD71wv/xqJyqmCmlYz4DEUmO9dD8rlvrh2ZPA4xp5eL7?=
 =?us-ascii?Q?mcNUqwOAN8inkwTrdg8blB1DU/Y3yJans8bbX+T8mFLBiZA6upbiS8y62xPx?=
 =?us-ascii?Q?PouF5WACgDPbtFW48jYhXp+vDSCR5w4InhxCrkBAKEIpoVIO3uPjLfP9vB6X?=
 =?us-ascii?Q?cDfceT/LL8la0Q+akbHtnE0n3NuO8NI9H7B7VWpJylZ7SyPbBYJtqiXN3Z+o?=
 =?us-ascii?Q?oZjEudoN1TXLE1tA94Z0Z0M5iYnL0Y7m6Wj/b7VPlhQIE0p2h80Rg9rp1Fp2?=
 =?us-ascii?Q?yNFX4jg//oy8KmqVry1+R7XU4R74BwwPnxTP34B74mdsQQ8JqVWCxCaXdEnp?=
 =?us-ascii?Q?eExeSvk6karUSU0zvt2/DTo9Nau1vgdya1zbdO7J3EHMI4KbBF0RbIjKQqhd?=
 =?us-ascii?Q?pQGAxYBVxNV0N/kwsTCodiaJWbAJewYpxS+lTzbXILXt34MIEyv1jHMOAoaM?=
 =?us-ascii?Q?AYNX3eWLtFF2UJwiExC4dMXcQrY/R8eA6CtWROgpxiM3aihtmgHikA0bi8Ab?=
 =?us-ascii?Q?5RlA7Uajc9Nx73X9caGvStwgZneOcPwDGPf4PVhKguax+5g9YOaQFVTudCzB?=
 =?us-ascii?Q?oCDUelDvWmZ5HwPTVv+sxfdjjhQWaicqEKLBon0w3oWNMLbys9GPbnzQ1Tco?=
 =?us-ascii?Q?uCJ17kx5TKCRfXacHiRt/GPFkQ1b9699OvLXfjZVXqP1Fj6xmXgEyeOB3ZCH?=
 =?us-ascii?Q?HCjbB0bdUqLQ25l9tKWM+nalADZAsAB44f+5vhn7BtkrgX9Psg2Bl6Ejoopq?=
 =?us-ascii?Q?8/XVb/eqVfBGY7vSR2VtDeM6FcOp4CuZG8yLyKLkblsEQoSQ+YCIXPh8iGrx?=
 =?us-ascii?Q?6rxSNYN39CM4qyDAPkj2LroKKeSCE3oPaIQenS759lU6n3UynMg7Rn6SxNeF?=
 =?us-ascii?Q?mlpMbp9O/rX660Julu9ByStzOI9t7FWDtCcR/AOvgVX2sfgbQlJL4DTRqvQ6?=
 =?us-ascii?Q?A8RacFkeZYJTG85qM+s2vzh/xgyFbCeqYzCQYebf6mZyHVV5Xg1WL6R8Pdk7?=
 =?us-ascii?Q?ksd2KlRU8VTpi6dY7asjRF2fR1SDV8CBi23eila+SHEO45FdoItAVEfZM00C?=
 =?us-ascii?Q?oEe1ginhIcSvr3gkhkbqvIWRl8QbTZPqB451mHvotyssks1fUDfQy0tgCWvD?=
 =?us-ascii?Q?sFfeTIhq219VdIkNKY5ttMcA4Lt8hDP2/p/Drw9eYAzGtNPWs3W4VyQEP0N6?=
 =?us-ascii?Q?N95mZXs9DfzRLh4VxUtb7yF3i5USI0CE3ZpdKmK884tHicEh1yzz4fAHD+k+?=
 =?us-ascii?Q?qK/l0cQQzQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153cb9ce-37bb-42cf-f88a-08dee663fd32
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 13:37:05.8329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFwsCWqCoGKn9FZNA7Gi0nEbKTn/DdpjBQe906R+cr8FQpCVOE7BoIyaIVFTmqE7Ow4UDCcDtN4s5Ll/HQAbuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

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
 drivers/soc/fsl/guts.c   | 343 ++++++++++++++++++++++++++++++++++++++-
 include/linux/fsl/guts.h |  20 ++-
 2 files changed, 357 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index b9973ca3a440..4d49d1b95300 100644
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
@@ -15,6 +18,30 @@
 #include <linux/fsl/guts.h>
 
 #define DCFG_CCSR	0
+#define DCFG_DCSR	1
+
+#define MAX_NUM_LANES	8
+#define MAX_NUM_SERDES	2
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
+#define LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1	BIT(14)
+#define LS2088A_RCWSR30_SRDS_CLK_SEL_XGMII_Ln_S1(lane)	BIT(6 + (7 - (lane)))
+#define LS2088A_RCWSR30_SRDS_CLK_SEL_MSK		GENMASK(13, 6)
+#define LS2088A_SRDS_CLK_SEL_XGMII			1
+#define LS2088A_SRDS_CLK_SEL_GMII			0
 
 struct fsl_soc_die_attr {
 	char	*die;
@@ -22,9 +49,20 @@ struct fsl_soc_die_attr {
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
+	int num_serdes;
+	int (*serdes_get_rcw_override)(int index, int lane,
+				       enum lynx_lane_mode lane_mode,
+				       struct fsl_soc_serdes_rcw_override *override);
+	int (*serdes_init_rcwcr)(int index);
 };
 
 enum qoriq_die {
@@ -138,9 +176,14 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 
 static struct fsl_soc_guts {
 	struct ccsr_guts __iomem *dcfg_ccsr;
+	struct ccsr_guts __iomem *dcfg_dcsr;
 	const struct fsl_soc_data *data;
 	bool little_endian;
 	u32 svr;
+	enum lynx_lane_mode lane_mode[MAX_NUM_SERDES][MAX_NUM_LANES];
+	unsigned long lanes_initialized[MAX_NUM_SERDES];
+	bool rcwcr_init_done;
+	spinlock_t rcwcr_lock; /* serializes concurrent writes to the RCWCR */
 } soc;
 
 static unsigned int fsl_guts_read(const void __iomem *reg)
@@ -151,6 +194,33 @@ static unsigned int fsl_guts_read(const void __iomem *reg)
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
+	/* Updates to RCWCR should be visible back in RCWSR */
+	return read_poll_timeout_atomic(fsl_guts_read, rcwsr, rcwsr == rcwcr,
+					0, RCW_TIMEOUT_US, false,
+					&soc.dcfg_ccsr->rcwsr[offset]);
+}
+
 static bool fsl_soc_die_match_one(u32 svr, const struct fsl_soc_die_attr *match)
 {
 	return match->svr == (svr & match->mask);
@@ -167,6 +237,131 @@ static const struct fsl_soc_die_attr *fsl_soc_die_match(
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
+	if (serdes_idx >= soc_data->num_serdes || serdes_idx <= 0)
+		return -ERANGE;
+
+	if (lane >= MAX_NUM_LANES || lane < 0)
+		return -ERANGE;
+
+	if ((!fsl_soc_die_match_one(soc.svr, &fsl_soc_die[DIE_LS1088A]) &&
+	     !fsl_soc_die_match_one(soc.svr, &fsl_soc_die[DIE_LS2088A]) &&
+	     !fsl_soc_die_match_one(soc.svr, &fsl_soc_die[DIE_LS1046A])) ||
+	    !soc_data->serdes_get_rcw_override) {
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
+ * fsl_guts_lane_init() - Notify guts module of current SerDes lane configuration
+ * @serdes_idx: one-based SerDes block index
+ * @lane: zero-based lane index within SerDes
+ * @lane_mode: initial / boot time SerDes protocol for lane
+ *
+ * On the LS208xA SoC, the RCW override procedure needs to be aware of all link
+ * modes which are configured on a SerDes block.
+ *
+ * Return: 0 if passed parameters are known to driver, negative error otherwise
+ */
+int fsl_guts_lane_init(int serdes_idx, int lane, enum lynx_lane_mode lane_mode)
+{
+	int err;
+
+	err = fsl_guts_lane_validate(serdes_idx, lane, lane_mode);
+	if (err)
+		return err;
+
+	soc.lane_mode[serdes_idx - 1][lane] = lane_mode;
+	soc.lanes_initialized[serdes_idx - 1] |= BIT(lane);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_init, "FSL_GUTS");
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
+	/* Ensure fsl_guts_lane_init() was previously called */
+	if (!(soc.lanes_initialized[serdes_idx - 1] & BIT(lane)))
+		return -EINVAL;
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
+	else
+		soc.lane_mode[serdes_idx - 1][lane] = lane_mode;
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
@@ -193,9 +388,143 @@ static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
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
+static int ls2088a_serdes_init_rcwcr(int serdes_idx)
+{
+	int i, err;
+	u32 reg;
+
+	/* SerDes 2 supports only SGMII for networking. There should be
+	 * no need for RCW override
+	 */
+	if (serdes_idx != 1)
+		return -EINVAL;
+
+	if (soc.rcwcr_init_done)
+		return 0;
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
+	for_each_set_bit(i, &soc.lanes_initialized[serdes_idx - 1], MAX_NUM_LANES)
+		if (lynx_lane_mode_uses_xgmii_mac(soc.lane_mode[serdes_idx - 1][i]))
+			reg |= LS2088A_RCWSR30_SRDS_CLK_SEL_XGMII_Ln_S1(i);
+
+	err = fsl_guts_rcw_rmw(29, reg,
+			       LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1 |
+			       LS2088A_RCWSR30_SRDS_CLK_SEL_MSK);
+	if (err)
+		return err;
+
+	soc.rcwcr_init_done = true;
+
+	return 0;
+}
+
+static const struct fsl_soc_data ls1088a_data = {
+	.serdes_get_rcw_override = ls1088a_serdes_get_rcw_override,
+	.num_serdes = 2,
+};
+
+static const struct fsl_soc_data ls1046a_data = {
+	.serdes_get_rcw_override = ls1046a_serdes_get_rcw_override,
+	.num_serdes = 2,
+};
+
+static const struct fsl_soc_data ls2088a_data = {
+	.serdes_get_rcw_override = ls2088a_serdes_get_rcw_override,
+	.serdes_init_rcwcr = ls2088a_serdes_init_rcwcr,
+	.num_serdes = 2,
+};
+
 static const struct fsl_soc_data ls1028a_data = {
 	.sfp_compat = "fsl,ls1028a-sfp",
 	.uid_offset = 0x21c,
+	.num_serdes = 1,
 };
 
 /*
@@ -221,10 +550,10 @@ static const struct of_device_id fsl_guts_of_match[] = {
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
@@ -250,6 +579,8 @@ static int __init fsl_guts_init(void)
 		of_node_put(np);
 		goto err_nomem;
 	}
+	/* DCFG_DCSR is optional */
+	soc.dcfg_dcsr = of_iomap(np, DCFG_DCSR);
 
 	soc.little_endian = of_property_read_bool(np, "little-endian");
 	soc.svr = fsl_guts_read(&soc.dcfg_ccsr->svr);
@@ -296,6 +627,8 @@ static int __init fsl_guts_init(void)
 		goto err;
 	}
 
+	spin_lock_init(&soc.rcwcr_lock);
+
 	pr_info("Machine: %s\n", soc_dev_attr->machine);
 	pr_info("SoC family: %s\n", soc_dev_attr->family);
 	pr_info("SoC ID: %s, Revision: %s\n",
@@ -311,6 +644,10 @@ static int __init fsl_guts_init(void)
 	kfree(soc_dev_attr->revision);
 	kfree(soc_dev_attr->serial_number);
 	kfree(soc_dev_attr);
+	if (soc.dcfg_dcsr) {
+		iounmap(soc.dcfg_dcsr);
+		soc.dcfg_dcsr = NULL;
+	}
 	if (soc.dcfg_ccsr) {
 		iounmap(soc.dcfg_ccsr);
 		soc.dcfg_ccsr = NULL;
diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
index fdb55ca47a4f..605300908a35 100644
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
 
+int fsl_guts_lane_init(int serdes_idx, int lane,
+		       enum lynx_lane_mode lane_mode);
+int fsl_guts_lane_validate(int serdes_idx, int lane,
+			   enum lynx_lane_mode lane_mode);
+int fsl_guts_lane_set_mode(int serdes_idx, int lane,
+			   enum lynx_lane_mode lane_mode);
+
 /* Alternate function signal multiplex control */
 #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
 
-- 
2.34.1


