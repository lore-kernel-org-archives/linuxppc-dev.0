Return-Path: <linuxppc-dev+bounces-18580-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09EDD58CDF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 06:08:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffN4m2cJGz2yhZ;
	Mon, 23 Mar 2026 17:07:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774246072;
	cv=pass; b=jp1FaKfQKgdkdotzHJO8CW8zy0iX8TovPcM1i12CBXYeVfoE7ZpVehVwM46vTT0qoVg4lpJY5t/pANo5J07pwkdWrHb+y0G8pUhKZU2iPQg8nToIspm6EzL20TM/V/Fz1XUL564kcYvFfoftEd8WkTpAnfRwxpKEOmxsvDyNhie8VlDa8Cfr8xVwEYvLhNdBE7XyhUe02dMvcCebubg1MThnJkfanSFMV1jIni0RGa6Bs/8FqP8wt9iq8INmrr3hqtgTYq3u0XLXLJZKI+cpwVUdNmcbP+Qljn1YA1r4ujizQiz3PiAwt8hv4Gudq9Y/vjpfMTL1JixCxeBLeTp77g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774246072; c=relaxed/relaxed;
	bh=NAC4xtqRJtSJEvLw4i4SbkINmBP5U253ETRDdZrubno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kURNsFJGPaFBXKGMKai1a/z21ExM9JtIacPYhiYxfI0rljcl5q0vz+xjvcSN5G4uddlFo8yYin4Y9d+TD8w+XBIe+CPoBuYKozGyv2Wt2D/JW+SAY4I3Pe1k83ATsl9rywqCQJ7XZ/gwoNi4z1hmB9i2VEUhkr+LWQn4jb8SVneccOOeMBHZDo0g+R8ItW1N5mFIbWH8AoVACjjM6rOwhCOXUMsaijGLypUjKDzCfjc+7cn14nOo0VyVBTcLm8O8Cn2iNwnNMrvO6qlJ8jJSfWwZ0bZJLzS3WybnRnNh213Xw4rXsxFR6fUuCsAf/jyphcYVP2xt5a4n7cwqBHdtsA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LVJail1n; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LVJail1n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffN4l1Sn4z2ygf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 17:07:51 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6OPqnmX4VVuUWoOFh6OIehP6m4lEhiyt4AmJ0YbhIRcDBfSqtPRltiY59nsYIb/tRmNP3oJD6V2zZGLaPacUvk7pjgYsqcjpoisVxWEDhY2r3Jh5VnzcudGPiWRNaDWUko8TICeUxZb+h2OIfJOsCGPA6PhKOFpk8m3a03ZwvAGpV5D+WR316waK3JMOvCX75AEhNEIa9ejX5bui2bYLwtzAkco8nNVTdbdG/B7/vgpKjO+7bAxPaWqkwqHw9wG56SzAfxrTppDZfJ3w9d+ws29+JluEjfpDfKPtUKV2oAalKHdcnGcYK+yFL7b+wC8DqCHHnGqTBP+5a0Ds5vMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAC4xtqRJtSJEvLw4i4SbkINmBP5U253ETRDdZrubno=;
 b=LjeCiOlWbliGo4LBdP49D0uGCsMGYbq8/E7zlvKsWHuTmCVkdqb9Zx/8TFAeJrpi7QpJgAetM5CvoEp0fCrMzDYVJVAST6LjdU9XVuT6NR79U1yRSPsgWPU5HAtLs151vqvLpNtMoun/rUuAnbURMfH6GkfG2/Gi/gFLuzRRJyYmbTTpRi/JK3WUChOvidA1JCTvQ0DVTOJtWeY1Rkw89eNY7HFrYsTHXfYTD93aNOKz51b9nAFKtEq1M7UPyTk6iiGsDhXhsjjtegBrugs/PUusEnBc3vCIW82RY8yh5ImnfTS3B0aYgHffihJ51o3+R9WWxhTPmg4kRk9qc2oCGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAC4xtqRJtSJEvLw4i4SbkINmBP5U253ETRDdZrubno=;
 b=LVJail1nHG8cYHPop+EPXg+op4a5D7YnGy4HiGsha0pl305Sq7UZRIi7q3i28ygRQ2bQDzTbLwQ7EeGJ+6adF4uSViDlfSri7lKH2jlm0FUnVvEFPY30/k4hTdAipuqyQFpJxcbYw+XL+QZngA9GjhPv1wXRc6NKLi0/+IAePRjLnGJPZwtXKNJK7qJ6nckEzlFkSOH7wO1tRbKh8EZIi7/lqi+q9A5Fa8pnj97fP4uzDCHW8Zv9FGCaMoV3dwYWPe0Ar1tqCoqHIZaUtHjKf6oDZJQk5yXKg9UHEjhCZj2WzBKv/i2lDGDJBlYNUixkigCC3R/OX8//PE6KsX4Zew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 06:07:06 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 06:07:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 11/14] net: dsa: netc: add phylink MAC operations
Date: Mon, 23 Mar 2026 14:07:49 +0800
Message-Id: <20260323060752.1157031-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323060752.1157031-1-wei.fang@nxp.com>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|PAXPR04MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: a6174400-83a8-42b6-5c14-08de88a2767e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gavuJq1gFlgQlfM6y8pWPb62kPTtxYH7d12bIcVrRhjAZ7rzT3XZoZtjoId5JxEvYcwlBcb1H/ah3WlhwMGcYDczJOWCoA/AsmBZXigoU4AWwECnp2IYUmNSGht8M0Mrn6MVQDDvnAYVULpgS/VFrZMhc1s6hXkAtieRkWTeZ8IP/lp0FZEAMb2vpWURBIurICfLJNh9pjgoO+C5o9zK9pqXfs7XDov65oYDBw5V8fUocJOWhHcTD7V5KNepyUtFVdIGW2VOHWB1d1beofDt5fQJwmkx3Mo9jqJGbvrKIg2sArSVkQ3kLLbfl2P9K/7cotdsLpX2kJWSndN6Dax6QlkD15nMEFbpJC9G+1HYe2CszRenIbXjpLTGH4Ds0IGEp7i6R/T4RNkCNohhVAOIxBp3epsfTXXoRULnAbfk7Q+YHaCKylakZzUkZLP/AR52tXkZR6XvonDg6RyvdczK+ySncOt6cepK4pesJQPDFxGk1v2cYM6gkjt7OvY7SeWumnLh07JV25N30Xsc8rFeGRG1+KKgDkFI3eWAWrIUvUvyjHEB2Hy9fY3fkoPkoFFvtjeuFx7QhEph4JcqznsvQWvwLUQ6XAIM11vyICW5kxZ/iHhRAadtUTYBEHl+ROkMF/mhJfMt8Z3pJy8JKBG3H4pRGBaFk5Pog8PiR5k8ENhbaSj9pvMynEMhd9We9cZKO9JFRtL+tQtwKU/BJDU9ryiy3Ys4p53xWK23TkuYSEyTKGGjfSKwyfyryxAYgRGz3kACxsTPTwrcmbGQ9bNoK7vAgO4i6cQGxGcDiw3ZJj48hF/Kdu2wcM07C0oCmk8R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qfBqShHNt9ZcpYJc6W1Hi3+mge088SizqjTuBgK5ZLRcX030FxYG6XvKoRU3?=
 =?us-ascii?Q?/554XMaRDbnDcMmMDYXuT5fUTg2tN12GWQSCTbvwovAgbheku/7MP6jl/Bly?=
 =?us-ascii?Q?vw+kLAkm3x+nVMt4DC1JlytZoZv4jD44wp/WVu6ay65lVZhL3RSbRWiTnkiy?=
 =?us-ascii?Q?towxuDy+3G0trONL3VyjzyubDyq6Dnnm+Tdfm2nFGaD3YlO0FCI/ydDtwjBD?=
 =?us-ascii?Q?AQYG7+hn3Dx5FhGnJc9rNaog16G2Z0vphEFQ2+mmR/chM9wGFE/utegvi4Cp?=
 =?us-ascii?Q?V9pjCKjQb8onbmSAPgjtA8iw+V4Uj/675aCocUCmqbigUm0ncuAkod/Eb8fD?=
 =?us-ascii?Q?tM49ggcd0Miy8zfHze9lAoDw5ioCdmQ70mgQWZLLbpVHB19Jz4m7VZza/8Rn?=
 =?us-ascii?Q?h+2kkIA2n4ctWsGMkjHLjfsc9jA+K657wsDj525hfEWJJPnJnbCB9H48L/XE?=
 =?us-ascii?Q?Vs3n0uf3iv8p3M4w+NXYl7fPzpHzdyjzKIxplL+KE5kL7CacsB1MC2GJdHiQ?=
 =?us-ascii?Q?2gomt1SXKZ3wSAoevtTelSmSCTpMWFioBt6Tjj3G1qW/VcK+or0RO3RMUfFj?=
 =?us-ascii?Q?0I9NWbxWRbVtX8IFODvvnu2Yqdtm5srmqZ0TTCHm2sOeBTeWJFZwfwwcq2ba?=
 =?us-ascii?Q?wzmzBJEz1mUcCq4FTLHXuDtBiJqQdFnWQ4rZmID1gBMpokDMpf0ZuIiT15tQ?=
 =?us-ascii?Q?cKcJZs0eS5LUKJoDGzKYcWnSLwfDmtoY9x8s1HWZl+LfSN3hzzppC6d5rRjc?=
 =?us-ascii?Q?AQ6FrGgJV2znXDR2jMQSEVHegnAMxWT67WQIXcJxQMcyHgDrIlrn9UiIYrM0?=
 =?us-ascii?Q?lCoTFptGCowsUKPBBUUIhuiM08HBLEItkuHdxQ3IezDSwRmfLYHr/6318xwG?=
 =?us-ascii?Q?eC7ftkbUOQ+QlPBVJbaiST9cO7q6NnfJvS875JBROR+5qzD93e0S7BpbWWPu?=
 =?us-ascii?Q?KwLSXIsN9MvgwzXHYZ73RS4yMDviVQK7+RuRk+66tTyPihOd8WbI4o7p+L6S?=
 =?us-ascii?Q?FYzg5iNP3nro33tpPj8GIg6wSfTUpFT3SvxucKoSrfbMTMm1haH7a7yqDO0+?=
 =?us-ascii?Q?wHGBCEahewS9nlMyG4bBPJ5HbJac56C1Ey4ftIlgEz2D0WzBjH5ekJCXj73X?=
 =?us-ascii?Q?Pr27Gabw1MqP9A8kRf+B1+1wRmK0cGsoIh/PS0Dpea8S4pbg03UWdnEqEFoi?=
 =?us-ascii?Q?dQ5oyOFATAbMxitq3BUSv9SJXA57D2Ygf5l0DAuS5Y3xBy8qqv5KNwXfIVGK?=
 =?us-ascii?Q?3/2VvSA+t7VvHenlel9Xkwt16AXESOSWrho9s/7nmxhx18lK/XB9zP76Z+1J?=
 =?us-ascii?Q?pXKftxNWYVE1xv2cN/spvx9dLIRRbr4CIWZ9QZiSqxpfH5NzurU8/BP1DSGW?=
 =?us-ascii?Q?DAwzdnE6ubISW0zXhH5lZS2csQrCzLTeKbfUSSYBl0uhHcMlNqSKXIutR0Y+?=
 =?us-ascii?Q?g/RSXb1HL1txmP6NatgXpdeQoyFc+vCxR23W09oEEUpibxw5NqRzspRN7C6C?=
 =?us-ascii?Q?YNNMYlJu8zNEs7cupOV6onuZirvLlUkxyO9vh49oQt31jJ9rb5WpccRWl1gR?=
 =?us-ascii?Q?Yr9K6yyyfNxy2LgO9gvrae+xix15DAsVeSCCbkZJN0oY+2N4EYVb9ESWt4Lw?=
 =?us-ascii?Q?bDvO+cG6MLOx7FqBnOOJ5QHy2/xeXLes4Na7TQAXG4b9AVhBWXJv2kxH4vkk?=
 =?us-ascii?Q?HLcrTWtWeBFnT8DAfTgLutp9RsNGOGNhXEgoJYOg4mT61vqOybW7sAZPOIMl?=
 =?us-ascii?Q?WMHuX4NWEQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6174400-83a8-42b6-5c14-08de88a2767e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:07:30.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vrjiqx3lebbHkgzEmX9olA+AgNjN6n4G3nqxcNYm4efapLOJT/7N9st829VLzY8VOszrGr9pjWeHKS2WEMPx1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911

Different versions of NETC switches have different numbers of ports and
MAC capabilities, so add .phylink_get_caps() to struct netc_switch_info,
so that each version of the NETC switch can implement its own callback
to obtain MAC capabilities. In addition, related interfaces of struct
phylink_mac_ops are added, such as .mac_config(), .mac_link_up(), and
.mac_link_down().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 212 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c  |  40 +++++
 drivers/net/dsa/netc/netc_switch.h    |   4 +
 drivers/net/dsa/netc/netc_switch_hw.h |  25 +++
 4 files changed, 281 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 5828fd3e342e..e2d88496f5f3 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -569,10 +569,221 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
 	priv->revision = val & IPBRR0_IP_REV;
 }
 
+static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
+				  struct phylink_config *config)
+{
+	struct netc_switch *priv = ds->priv;
+
+	priv->info->phylink_get_caps(port, config);
+}
+
+static void netc_port_set_mac_mode(struct netc_port *np,
+				   unsigned int mode,
+				   phy_interface_t phy_mode)
+{
+	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII | PM_IF_MODE_ENA;
+	u32 val = 0;
+
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val |= IFMODE_RGMII;
+		/* Enable auto-negotiation for the MAC if its
+		 * RGMII interface supports In-Band status.
+		 */
+		if (phylink_autoneg_inband(mode))
+			val |= PM_IF_MODE_ENA;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		val |= IFMODE_RMII;
+		break;
+	case PHY_INTERFACE_MODE_REVMII:
+		val |= PM_IF_MODE_REVMII;
+		fallthrough;
+	case PHY_INTERFACE_MODE_MII:
+		val |= IFMODE_MII;
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		val |= IFMODE_SGMII;
+		break;
+	default:
+		break;
+	}
+
+	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
+}
+
+static void netc_mac_config(struct phylink_config *config, unsigned int mode,
+			    const struct phylink_link_state *state)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+
+	netc_port_set_mac_mode(NETC_PORT(dp->ds, dp->index), mode,
+			       state->interface);
+}
+
+static void netc_port_set_speed(struct netc_port *np, int speed)
+{
+	netc_port_rmw(np, NETC_PCR, PCR_PSPEED, PSPEED_SET_VAL(speed));
+}
+
+/* If the RGMII device does not support the In-Band Status (IBS), we need
+ * the MAC driver to get the link speed and duplex mode from the PHY driver.
+ * The MAC driver then sets the MAC for the correct speed and duplex mode
+ * to match the PHY. The PHY driver gets the link status and speed and duplex
+ * information from the PHY via the MDIO/MDC interface.
+ */
+static void netc_port_force_set_rgmii_mac(struct netc_port *np,
+					  int speed, int duplex)
+{
+	u32 mask, val;
+
+	mask = PM_IF_MODE_ENA | PM_IF_MODE_SSP | PM_IF_MODE_HD |
+	       PM_IF_MODE_M10 | PM_IF_MODE_REVMII;
+
+	switch (speed) {
+	default:
+	case SPEED_1000:
+		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_1G);
+		break;
+	case SPEED_100:
+		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_100M);
+		break;
+	case SPEED_10:
+		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_10M);
+		break;
+	}
+
+	if (duplex != DUPLEX_FULL)
+		val |= PM_IF_MODE_HD;
+
+	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
+}
+
+static void netc_port_set_rmii_mii_mac(struct netc_port *np,
+				       int speed, int duplex)
+{
+	u32 mask, val = 0;
+
+	mask = PM_IF_MODE_ENA | PM_IF_MODE_SSP | PM_IF_MODE_HD |
+	       PM_IF_MODE_M10;
+
+	if (speed == SPEED_10)
+		val |= PM_IF_MODE_M10;
+
+	if (duplex != DUPLEX_FULL)
+		val |= PM_IF_MODE_HD;
+
+	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
+}
+
+static void netc_port_set_hd_flow_control(struct netc_port *np, bool en)
+{
+	if (!np->caps.half_duplex)
+		return;
+
+	/* The HD_FCEN is used in conjunction with the PM_HD_FLOW_CTRL
+	 * register, which has a default value, so currently we do not
+	 * set it in the driver. The half duplex flow control works by
+	 * the backpressure, and the backpressure is essentially just
+	 * a long preamble transmitted on the link intended to create
+	 * a collision and get the half duplex link partner to defer.
+	 */
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_HD_FCEN,
+			  en ? PM_CMD_CFG_HD_FCEN : 0);
+}
+
+static void netc_port_mac_rx_enable(struct netc_port *np)
+{
+	netc_port_rmw(np, NETC_POR, PCR_RXDIS, 0);
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN,
+			  PM_CMD_CFG_RX_EN);
+}
+
+static void netc_port_wait_rx_empty(struct netc_port *np, int mac)
+{
+	u32 val;
+
+	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_RX_EMPTY,
+			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
+		dev_warn(np->switch_priv->dev,
+			 "MAC %d of swp%d RX is not empty\n", mac,
+			 np->dp->index);
+}
+
+static void netc_port_mac_rx_graceful_stop(struct netc_port *np)
+{
+	u32 val;
+
+	if (is_netc_pseudo_port(np))
+		goto check_rx_busy;
+
+	if (np->caps.pmac) {
+		netc_port_rmw(np, NETC_PM_CMD_CFG(1), PM_CMD_CFG_RX_EN, 0);
+		netc_port_wait_rx_empty(np, 1);
+	}
+
+	netc_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN, 0);
+	netc_port_wait_rx_empty(np, 0);
+
+check_rx_busy:
+	if (read_poll_timeout(netc_port_rd, val, !(val & PSR_RX_BUSY),
+			      100, 10000, false, np, NETC_PSR))
+		dev_warn(np->switch_priv->dev, "swp%d RX is busy\n",
+			 np->dp->index);
+
+	netc_port_rmw(np, NETC_POR, PCR_RXDIS, PCR_RXDIS);
+}
+
+static void netc_mac_link_up(struct phylink_config *config,
+			     struct phy_device *phy, unsigned int mode,
+			     phy_interface_t interface, int speed,
+			     int duplex, bool tx_pause, bool rx_pause)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct netc_port *np;
+
+	np = NETC_PORT(dp->ds, dp->index);
+	netc_port_set_speed(np, speed);
+
+	if (phy_interface_mode_is_rgmii(interface) &&
+	    !phylink_autoneg_inband(mode)) {
+		netc_port_force_set_rgmii_mac(np, speed, duplex);
+	}
+
+	if (interface == PHY_INTERFACE_MODE_RMII ||
+	    interface == PHY_INTERFACE_MODE_REVMII ||
+	    interface == PHY_INTERFACE_MODE_MII) {
+		netc_port_set_rmii_mii_mac(np, speed, duplex);
+	}
+
+	netc_port_set_hd_flow_control(np, duplex == DUPLEX_HALF);
+	netc_port_mac_rx_enable(np);
+}
+
+static void netc_mac_link_down(struct phylink_config *config,
+			       unsigned int mode,
+			       phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+
+	netc_port_mac_rx_graceful_stop(NETC_PORT(dp->ds, dp->index));
+}
+
+static const struct phylink_mac_ops netc_phylink_mac_ops = {
+	.mac_config		= netc_mac_config,
+	.mac_link_up		= netc_mac_link_up,
+	.mac_link_down		= netc_mac_link_down,
+};
+
 static const struct dsa_switch_ops netc_switch_ops = {
 	.get_tag_protocol		= netc_get_tag_protocol,
 	.setup				= netc_setup,
 	.teardown			= netc_teardown,
+	.phylink_get_caps		= netc_phylink_get_caps,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
@@ -613,6 +824,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->num_ports = priv->info->num_ports;
 	ds->num_tx_queues = NETC_TC_NUM;
 	ds->ops = &netc_switch_ops;
+	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->priv = priv;
 
 	priv->ds = ds;
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
index abd599ea9c8d..8d3fb5151902 100644
--- a/drivers/net/dsa/netc/netc_platform.c
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -11,8 +11,48 @@ struct netc_switch_platform {
 	const struct netc_switch_info *info;
 };
 
+static void imx94_switch_phylink_get_caps(int port,
+					  struct phylink_config *config)
+{
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+				   MAC_1000FD;
+
+	switch (port) {
+	case 0 ... 1:
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  config->supported_interfaces);
+		config->mac_capabilities |= MAC_2500FD;
+		fallthrough;
+	case 2:
+		config->mac_capabilities |= MAC_10 | MAC_100;
+		__set_bit(PHY_INTERFACE_MODE_MII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_RMII,
+			  config->supported_interfaces);
+		if (port == 2)
+			__set_bit(PHY_INTERFACE_MODE_REVMII,
+				  config->supported_interfaces);
+
+		phy_interface_set_rgmii(config->supported_interfaces);
+		break;
+	case 3: /* CPU port */
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+		config->mac_capabilities |= MAC_10FD | MAC_100FD |
+					    MAC_2500FD;
+		break;
+	default:
+		break;
+	}
+}
+
 static const struct netc_switch_info imx94_info = {
 	.num_ports = 4,
+	.phylink_get_caps = imx94_switch_phylink_get_caps,
 };
 
 static const struct netc_switch_platform netc_platforms[] = {
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index dac19bfba02b..eb65c36ecead 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -34,6 +34,7 @@ struct netc_switch;
 
 struct netc_switch_info {
 	u32 num_ports;
+	void (*phylink_get_caps)(int port, struct phylink_config *config);
 };
 
 struct netc_port_caps {
@@ -70,6 +71,9 @@ struct netc_switch {
 	struct ntmp_user ntmp;
 };
 
+#define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
+#define NETC_PORT(ds, port_id)		(NETC_PRIV(ds)->ports[(port_id)])
+
 /* Write/Read Switch base registers */
 #define netc_base_rd(r, o)		netc_read((r)->base + (o))
 #define netc_base_wr(r, o, v)		netc_write((r)->base + (o), v)
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 03b49857c854..6d7758631e61 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -71,6 +71,10 @@
 #define  PCR_TXDIS			BIT(0)
 #define  PCR_RXDIS			BIT(1)
 
+#define NETC_PSR			0x104
+#define  PSR_TX_BUSY			BIT(0)
+#define  PSR_RX_BUSY			BIT(1)
+
 #define NETC_PTCTMSDUR(a)		(0x208 + (a) * 0x20)
 #define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
 #define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
@@ -145,6 +149,27 @@ enum netc_mfo {
 #define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
 #define  PM_MAXFRAM			GENMASK(15, 0)
 
+#define NETC_PM_IEVENT(a)		(0x1040 + (a) * 0x400)
+#define  PM_IEVENT_RX_EMPTY		BIT(6)
+
+#define NETC_PM_IF_MODE(a)		(0x1300 + (a) * 0x400)
+#define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
+#define   IFMODE_MII			1
+#define   IFMODE_RMII			3
+#define   IFMODE_RGMII			4
+#define   IFMODE_SGMII			5
+#define  PM_IF_MODE_REVMII		BIT(3)
+#define  PM_IF_MODE_M10			BIT(4)
+#define  PM_IF_MODE_HD			BIT(6)
+#define  PM_IF_MODE_RGMII_RX_SKW	BIT(10)
+#define  PM_IF_MODE_RGMII_TX_SKW	BIT(11)
+#define  PM_IF_MODE_CLK_STOP		BIT(12)
+#define  PM_IF_MODE_SSP			GENMASK(14, 13)
+#define   SSP_100M			0
+#define   SSP_10M			1
+#define   SSP_1G			2
+#define  PM_IF_MODE_ENA			BIT(15)
+
 #define NETC_PEMDIOCR			0x1c00
 #define NETC_EMDIO_BASE			NETC_PEMDIOCR
 
-- 
2.34.1


