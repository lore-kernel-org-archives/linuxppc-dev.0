Return-Path: <linuxppc-dev+bounces-18579-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93825D58CDD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 06:07:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffN4k6RQtz2ySb;
	Mon, 23 Mar 2026 17:07:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774246070;
	cv=pass; b=L6vxZSmJV4yxR2wr+J8ZVHGPde0IVvXeIjOdbcyE2bh0O/c3mtN+44Wm0apE2IfOBh2bW3dCeObYSEmrO36pizrcKTwVHrULIImb7CN3y7T68NWtPIM4QAbwxLyxrDk6d4xJmZGiqb0x2TYBv66fWAHixGZKogYqIroTIybsAOpeTIqT1iBf185BT0myb0l/XUxlvfZryhFIR4iFIUx0YAGWSRTU7s/QtP51KbKCq4d78eVNiFhz8KshrBqx5hzBEvj5oj6CAAMfb+dhdgRfGn2zPFjkAcN0BBdn8PmnsB2TG092NVP09i1SrwRweGI13PH4h+TfZIpSAc7rCAMimQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774246070; c=relaxed/relaxed;
	bh=aSaP1/q19mRhO/3R7P741OuRJNfYl9qsUiOp0NZqoEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bWinUmtJ8Laq1oJrRKy83qV2aekgkfcKKwSQ82ep8yhaSBF4WcRtHMcgBJDUeXMuaDIoGcnicTOep+4D/zCUJeOS7/nbMj2gvHtxP0dDeNJ984mya8rhUTA7ePLAa84iA/Iycibb+wHuL7BdtBgoWBgSVIX9DehTf4ue7BO9rsz2Q6revz8dmhuIRVRUxArhrKIra5Y5WnBrnhs7qLz++Ob34Lz2klM1VDNFIUs266DkszWpcmycNgAQCKlr1BAfvO8Y3dEQrSVBU8gzv3XGCcDejV21EUqVYI8jAXxXbGNB3Zm232r0ysTCEgLzO3H/Tq76URdEZD/5Ab8sNZv8cw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FdfSBcKI; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FdfSBcKI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffN4j0ynzz2xd6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 17:07:49 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zT45I/NdxShKWzI6qh8QBfljz3Oxw+10EParhRvQKVhvAWrolR3L/rMyvvyQBAd4GUQkJZ+uzT7jXqz6ehyIZ8NvN+1icHoLnonyLOzAK2rWL9uWzxXtvY4QPIhnzR94fWI2KYVzt89dfJc3c199vqYORAlzy9hgVckn5GzKmXYC1K1ZnvBbssmz6QIq4LcozLxeoA0a9UnKNRHfPolfRgOir5+ohPc8VaAskOcDgkEhbb9TY6cUlbrQnGezNiG+i4XE8MIppxKK7afCjKbmzgHuI9mvlV3B5gTJE18XVoIlZ03QD8098bMs2SK3AQf+bKkAzcR/t0mKiZNh/fFIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSaP1/q19mRhO/3R7P741OuRJNfYl9qsUiOp0NZqoEM=;
 b=EoAJa7s/4ITpW8guQWHktKd0eTHgTwU9fsf1BPQSjMKuwEHEZyVEi4CbGHEOxIy8Yh1DiQUVXS2Fifa7+t2W4n04bcO2EvFtlm1jrr0w4Wlmkn7h7iEQ5I9cw7K95ZHWTumHt+vuor6A0kv4aKU7TMjEVGIHb90QuzXHQt1yac9mGQBEGoRwPtZyTMq72pPTVbEcvrAMwtRkqC962oUiotoVpkYTC3XUWT5c1Z24Q1bfSLbWOSpsiMoJBEvn7mr+dwzCmZJbrVcQpAg9FOwfwZo0HmRQ6KsnuLZ+iwm1bLHk11Y5+o+rAJiBmcFOp5vmv51bVzQNsBs9fuOaf5zMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSaP1/q19mRhO/3R7P741OuRJNfYl9qsUiOp0NZqoEM=;
 b=FdfSBcKIni4trSW0ZyEQWugqM52kRYknz1+AViQsmVVQYenvlzJUuFO4Cqp5KgwbRCc9/qcjMMxs9y4axBSbZ6KwjX9Z7gnmPGxfIhyllmZBhwJBQZvfaGoqPXLm8fBwRRf5ZJRChg4+BBn2YeyvoNAvO0DVUslVuipu7bLNBFBE67ruTOoFYUjhIeNeEYHBdL5zAjh/NIsnHzD9THlqTDfGQPx45SvQQOfLn2+/EfNsCzeSIwvFUY3yp8Qo1TBVMJmSclVlX/CtyUThf0rxYBwPhC9+/LNommp1pu5SKtx5N/FZ/pG5J/MKeVccI2Ps5/90Z/LKsigQMN0DZlP/Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 06:06:57 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 06:07:21 +0000
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
Subject: [PATCH v2 net-next 10/14] net: dsa: netc: introduce NXP NETC switch driver for i.MX94
Date: Mon, 23 Mar 2026 14:07:48 +0800
Message-Id: <20260323060752.1157031-11-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 231bc105-ce1b-4b6c-0ea5-08de88a27073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XMSb+F9disAbVbx/ShVkI0NDiN1c6AI54pSgLUlJ1PfQehAaeNGFJKX0C9mnlaoxje0C42P3LbvfaCtnesEdaLu8AXnsYzh3tpUT9qkis/PDT1wHLZFxEIW0qhmV5Vnmru0HqZgdrdMId+e/3DTHIm9asJX/LetWPMW6VZpmVO/bHM/Kanq+ys9AnKkQowjHI2h2uj4C8gQn9rQz9VwrKRB7Sr12ldl2L4LaihpxyXdo6IfWIjgrups5NWCoLxx/LiMyXUexZGjL1bCxlUf/ZIPMILVMgMbWUfoX/AV7MNOs0e4kjGsGE/S74J7AWf2078/Y6hGzY8VkdVN5br8BrV8Zceh1+BJZPljoiM26T4m/zGhErfQJ97/o9iC0BWxCclnxeS1ZVpHLm9F2bTMSg1j8pyN43RjvbUFGUpra0ICE6jBlhUecROnA+8L4D3ZKu7rUeVeyIQEynPIsLIqsmzOKKlOiun48z6FG6Pls6MWB4cmUVwKXPY7qK0XH13zjsBvg15pUBbJs9EfruMPKcQagIDKtd0VLMs7lxCSYVcp93ZELw3CLF5kMtd85UV3OmzHkuyKakBDEqGHHWaOkt3PHDGR+Ix30JuIA/gaGRqIDDkmjXmy+WNtfhfnA8z57Zm4xSgtnMV8Uzy4kiWg6+AkwqoQlhm8Ip3M55fgjmZidG3KBSW1aetzXOZjMZcqFwxibvMLGfIlb+mTIqy34pRm0g8OYSCWUOT9iFqUmiwg4sH+vjMmbX8j4qKgZNxxqjLzNB4qFm2skOndD47cmnyl088rAB6Aw8X+I98OXiMS9IFvKz35yKnh15nH+BK2J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?avrkUV/DrxITcRRlCr11+ZKu8zBmdMYf5OCkUjO8pFzMhirxc00kajyJE2xb?=
 =?us-ascii?Q?8qdZciQxQwsqknTCS0NpgdINdw2cdgYJQeic8nbhmuvA8mphBLU+Swro/Qoq?=
 =?us-ascii?Q?5H+5Qg+orUOtjsx2xtXso2FDdX8F5MUNJv+2VpXT8q/MIn4OwzjtB2CGegYJ?=
 =?us-ascii?Q?uxjemdxHIWq+U4vcqqYhbPYAzMp/F9FuHI+awReDCOYp06YI+c/cidqm0vbT?=
 =?us-ascii?Q?WR39vwK/00TuEu8sQBQ31BPn9b8LH5Vhx1EYjtYwfoZoHS71Aqr/Hd6WOMd4?=
 =?us-ascii?Q?kTGsQDkZShvlAMVy+h246roDTTN1sXLg+p/cEWLA79WpKhpWG9Bdue+8cdn4?=
 =?us-ascii?Q?BDQx2RefBN+eQVRXnQ7fiQDWipaFnT+a2WIJlQuTddOd7DRYVtJioFQCiITU?=
 =?us-ascii?Q?iT1fGPejc51rz41EbL+Unc8IVhl5D5MgaMNmuaF6nLqEmTbBqbuPfk8giPRe?=
 =?us-ascii?Q?UiYT3un1C1btUssdqN2Va+f6e4YgTkdPNk8ezOfGm+pfMJBy99ZIhfakGPg6?=
 =?us-ascii?Q?XE24+YsiB/ycvsWY8lKus6+04doT8ZMcOwsKv/UUvYSGO/5x1x/VyTwL9dt1?=
 =?us-ascii?Q?uuAnADaxqnoqZ+GrL65eoo0Z1ZJwZs+I7LufAK8mFoLcMwXBWYHDo2EROIwh?=
 =?us-ascii?Q?hB4B2M/50PXwaRzSZbtXauuHOQOyia1f1Xb0Glil3zwf2cwQrmk+kj93dtYl?=
 =?us-ascii?Q?IKCMU9Hx2TBFYOjFwafjvxRaeC000P/2b2L36rVklEsCzc+PcLi8AWG2Moxw?=
 =?us-ascii?Q?qnbpzh2liTsBNKktEnlKTc8aKoW+zzqltMHJGZ1Lec76//sY+VM1yGzSGmIy?=
 =?us-ascii?Q?p23RLLogTc5qB40xAb/kASQKgg2Dd2PfEk0bpouTiiz7dZck+3RhttlTFblV?=
 =?us-ascii?Q?SUuI3zanKNPk5uPzfq708mEF2ejaSVmVqHhlE4qmN5827wyVxR+p520zKOMY?=
 =?us-ascii?Q?4boUQ1+cFS5mNfOZFv69a58lz5NY8khArWZAqk1LtxOvIfckddLVoiS0lgLZ?=
 =?us-ascii?Q?4mZXQ4ZJwBFHaqNEmsu8ZcFGABge7PN9K7SL82qgzWaI5HwySsH66eZWvHlN?=
 =?us-ascii?Q?xYdq1Akpck+JcRTsPOE/051M5EhjF2IPGCvHKLkkZDUAZFHxL5YCk2+QqvpS?=
 =?us-ascii?Q?+ce4IaOdFEgxvxgOs8nmy5ynaB0936cn12jPAmYF+IoT4muBhg1E42aOjx7Q?=
 =?us-ascii?Q?sxjONo5YAGUaEcNUx5E8filt+ibT3pp+Pq1ano92IldI4HoxHMeBfTyyhHkj?=
 =?us-ascii?Q?0xmaJJ7gRAXcjJayHhuUjZ+aHX3GY4LBt0/jv5B9BEuAZMdHf/6j4j+Ft8oV?=
 =?us-ascii?Q?r9h/T8XQSnJflwKdaL33LQDBDl/T7t105H5k83qu774TU0SNIEUyUI6c32ao?=
 =?us-ascii?Q?RYIoIr6RFtg+rtd5Zo7TSY406pKpgYynQvw/FJBuFgQSmdtbfjL03LxXrNjD?=
 =?us-ascii?Q?5G59XuzX0eEliPR5uWR6LtYbAJtdeu4IrITN6Pt5+qrvR9X0XVnTr+uG4lBa?=
 =?us-ascii?Q?7iA2lJJ1Al0Ef0SDlDo779NqNK0cE35BU7H02WAYzjK6/x11e1M2kCb/YqTc?=
 =?us-ascii?Q?4lwwz9tL6rhPwp5OKeX9puCzzfYhy79yB11sAN87LTjtC6uqs6SxmnMsMgMY?=
 =?us-ascii?Q?QELRrWOtuRAYfNYyeZQGS0ihfeNMr6CtAGA8DHpCtZGz2hzJ56off6hq08ZY?=
 =?us-ascii?Q?4xnjr3F7awjsKN7spPn3xOjEMaa6kBd99pIyvX6bt4Mqck2pl0bXFZntrNgZ?=
 =?us-ascii?Q?ZJQ0/V1Ijg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231bc105-ce1b-4b6c-0ea5-08de88a27073
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:07:21.4111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rExjlvJX4mcPQXuyiWdOKcF7BI+AJuLHHyjP2LOhVqkL/3rVlhaOVQfinRFzTk0VswQmlMBUbVORFeRhpE95oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911

For i.MX94 series, the NETC IP provides full 802.1Q Ethernet switch
functionality, advanced QoS with 8 traffic classes, and a full range of
TSN standards capabilities. The switch has 3 user ports and 1 CPU port,
the CPU port is connected to an internal ENETC. Since the switch and the
internal ENETC are fully integrated within the NETC IP, no back-to-back
MAC connection is required. Instead, a light-weight "pseudo MAC" is used
between the switch and the ENETC. This translates to lower power (less
logic and memory) and lower delay (as there is no serialization delay
across this link).

This patch introduces the initial NETC switch driver. At this stage,
only basic probe and remove functionality is supported. More features
will be supported in the subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 MAINTAINERS                           |  11 +
 drivers/net/dsa/Kconfig               |   3 +
 drivers/net/dsa/Makefile              |   1 +
 drivers/net/dsa/netc/Kconfig          |  14 +
 drivers/net/dsa/netc/Makefile         |   3 +
 drivers/net/dsa/netc/netc_main.c      | 672 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c  |  49 ++
 drivers/net/dsa/netc/netc_switch.h    |  92 ++++
 drivers/net/dsa/netc/netc_switch_hw.h | 155 ++++++
 9 files changed, 1000 insertions(+)
 create mode 100644 drivers/net/dsa/netc/Kconfig
 create mode 100644 drivers/net/dsa/netc/Makefile
 create mode 100644 drivers/net/dsa/netc/netc_main.c
 create mode 100644 drivers/net/dsa/netc/netc_platform.c
 create mode 100644 drivers/net/dsa/netc/netc_switch.h
 create mode 100644 drivers/net/dsa/netc/netc_switch_hw.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a09bf30a057d..fe744320b1e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19083,6 +19083,17 @@ F:	Documentation/devicetree/bindings/clock/*imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/*imx*
 
+NXP NETC ETHERNET SWITCH DRIVER
+M:	Wei Fang <wei.fang@nxp.com>
+R:	Clark Wang <xiaoning.wang@nxp.com>
+L:	imx@lists.linux.dev
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
+F:	drivers/net/dsa/netc/
+F:	include/linux/dsa/tag_netc.h
+F:	net/dsa/tag_netc.c
+
 NXP NETC TIMER PTP CLOCK DRIVER
 M:	Wei Fang <wei.fang@nxp.com>
 M:	Clark Wang <xiaoning.wang@nxp.com>
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 39fb8ead16b5..e9c7a6874791 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -74,8 +74,11 @@ source "drivers/net/dsa/microchip/Kconfig"
 
 source "drivers/net/dsa/mv88e6xxx/Kconfig"
 
+
 source "drivers/net/dsa/mxl862xx/Kconfig"
 
+source "drivers/net/dsa/netc/Kconfig"
+
 source "drivers/net/dsa/ocelot/Kconfig"
 
 source "drivers/net/dsa/qca/Kconfig"
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index f5a463b87ec2..d2975badffc0 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -21,6 +21,7 @@ obj-y				+= lantiq/
 obj-y				+= microchip/
 obj-y				+= mv88e6xxx/
 obj-y				+= mxl862xx/
+obj-y				+= netc/
 obj-y				+= ocelot/
 obj-y				+= qca/
 obj-y				+= realtek/
diff --git a/drivers/net/dsa/netc/Kconfig b/drivers/net/dsa/netc/Kconfig
new file mode 100644
index 000000000000..8824d30ed3ea
--- /dev/null
+++ b/drivers/net/dsa/netc/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NET_DSA_NETC_SWITCH
+	tristate "NXP NETC Ethernet switch support"
+	depends on NET_DSA && PCI
+	select NET_DSA_TAG_NETC
+	select FSL_ENETC_MDIO
+	select NXP_NTMP
+	select NXP_NETC_LIB
+	help
+	  This driver supports the NXP NETC Ethernet switch, which is embedded
+	  as a PCIe function of the NXP NETC IP. But note that this driver does
+	  only support switch versions greater than or equal to NETC v4.3.
+
+	  If compiled as module (M), the module name is nxp-netc-switch.
diff --git a/drivers/net/dsa/netc/Makefile b/drivers/net/dsa/netc/Makefile
new file mode 100644
index 000000000000..4a5767562574
--- /dev/null
+++ b/drivers/net/dsa/netc/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_NET_DSA_NETC_SWITCH) += nxp-netc-switch.o
+nxp-netc-switch-objs := netc_main.o netc_platform.o
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
new file mode 100644
index 000000000000..5828fd3e342e
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -0,0 +1,672 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC switch driver
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/clk.h>
+#include <linux/etherdevice.h>
+#include <linux/fsl/enetc_mdio.h>
+#include <linux/if_vlan.h>
+#include <linux/of_mdio.h>
+
+#include "netc_switch.h"
+
+static enum dsa_tag_protocol
+netc_get_tag_protocol(struct dsa_switch *ds, int port,
+		      enum dsa_tag_protocol mprot)
+{
+	return DSA_TAG_PROTO_NETC;
+}
+
+static void netc_port_rmw(struct netc_port *np, u32 reg,
+			  u32 mask, u32 val)
+{
+	u32 old, new;
+
+	WARN_ON((mask | val) != mask);
+
+	old = netc_port_rd(np, reg);
+	new = (old & ~mask) | val;
+	if (new == old)
+		return;
+
+	netc_port_wr(np, reg, new);
+}
+
+static void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
+{
+	if (is_netc_pseudo_port(np))
+		return;
+
+	netc_port_wr(np, reg, val);
+	if (np->caps.pmac)
+		netc_port_wr(np, reg + NETC_PMAC_OFFSET, val);
+}
+
+static void netc_mac_port_rmw(struct netc_port *np, u32 reg,
+			      u32 mask, u32 val)
+{
+	u32 old, new;
+
+	if (is_netc_pseudo_port(np))
+		return;
+
+	WARN_ON((mask | val) != mask);
+
+	old = netc_port_rd(np, reg);
+	new = (old & ~mask) | val;
+	if (new == old)
+		return;
+
+	netc_port_wr(np, reg, new);
+	if (np->caps.pmac)
+		netc_port_wr(np, reg + NETC_PMAC_OFFSET, new);
+}
+
+static void netc_port_get_capability(struct netc_port *np)
+{
+	u32 val;
+
+	val = netc_port_rd(np, NETC_PMCAPR);
+	if (val & PMCAPR_HD)
+		np->caps.half_duplex = true;
+
+	if (FIELD_GET(PMCAPR_FP, val) == FP_SUPPORT)
+		np->caps.pmac = true;
+
+	val = netc_port_rd(np, NETC_PCAPR);
+	if (val & PCAPR_LINK_TYPE)
+		np->caps.pseudo_link = true;
+}
+
+static int netc_port_get_info_from_dt(struct netc_port *np,
+				      struct device_node *node,
+				      struct device *dev)
+{
+	if (of_find_property(node, "clock-names", NULL)) {
+		np->ref_clk = devm_get_clk_from_child(dev, node, "ref");
+		if (IS_ERR(np->ref_clk)) {
+			dev_err(dev, "Port %d cannot get reference clock\n",
+				np->dp->index);
+			return PTR_ERR(np->ref_clk);
+		}
+	}
+
+	return 0;
+}
+
+static int netc_port_create_emdio_bus(struct netc_port *np,
+				      struct device_node *node)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct enetc_mdio_priv *mdio_priv;
+	struct device *dev = priv->dev;
+	struct enetc_hw *hw;
+	struct mii_bus *bus;
+	int err;
+
+	hw = enetc_hw_alloc(dev, np->iobase);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw),
+				     "Failed to allocate enetc_hw\n");
+
+	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "NXP NETC switch external MDIO Bus";
+	bus->read = enetc_mdio_read_c22;
+	bus->write = enetc_mdio_write_c22;
+	bus->read_c45 = enetc_mdio_read_c45;
+	bus->write_c45 = enetc_mdio_write_c45;
+	bus->parent = dev;
+	mdio_priv = bus->priv;
+	mdio_priv->hw = hw;
+	mdio_priv->mdio_base = NETC_EMDIO_BASE;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-p%d-emdio",
+		 dev_name(dev), np->dp->index);
+
+	err = devm_of_mdiobus_register(dev, bus, node);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "Cannot register EMDIO bus\n");
+
+	np->emdio = bus;
+
+	return 0;
+}
+
+static int netc_port_create_mdio_bus(struct netc_port *np,
+				     struct device_node *node)
+{
+	struct device_node *mdio_node;
+	int err;
+
+	mdio_node = of_get_child_by_name(node, "mdio");
+	if (mdio_node) {
+		err = netc_port_create_emdio_bus(np, mdio_node);
+		of_node_put(mdio_node);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int netc_init_switch_id(struct netc_switch *priv)
+{
+	struct netc_switch_regs *regs = &priv->regs;
+	struct dsa_switch *ds = priv->ds;
+
+	/* The value of 0 is reserved for the VEPA switch and cannot
+	 * be used.
+	 */
+	if (ds->index > SWCR_SWID || !ds->index) {
+		dev_err(priv->dev, "Switch index %d out of range\n",
+			ds->index);
+		return -ERANGE;
+	}
+
+	netc_base_wr(regs, NETC_SWCR, ds->index);
+
+	return 0;
+}
+
+static int netc_init_all_ports(struct netc_switch *priv)
+{
+	struct device *dev = priv->dev;
+	struct netc_port *np;
+	struct dsa_port *dp;
+	int err;
+
+	priv->ports = devm_kcalloc(dev, priv->info->num_ports,
+				   sizeof(struct netc_port *),
+				   GFP_KERNEL);
+	if (!priv->ports)
+		return -ENOMEM;
+
+	/* Some DSA interfaces may set the port even it is disabled, such
+	 * as .port_disable(), .port_stp_state_set() and so on. To avoid
+	 * crash caused by accessing NULL port pointer, each port is
+	 * allocated its own memory. Otherwise, we need to check whether
+	 * the port pointer is NULL in these interfaces. The latter is
+	 * difficult for us to cover.
+	 */
+	for (int i = 0; i < priv->info->num_ports; i++) {
+		np = devm_kzalloc(dev, sizeof(*np), GFP_KERNEL);
+		if (!np)
+			return -ENOMEM;
+
+		np->switch_priv = priv;
+		np->iobase = priv->regs.port + PORT_IOBASE(i);
+		netc_port_get_capability(np);
+		priv->ports[i] = np;
+	}
+
+	dsa_switch_for_each_available_port(dp, priv->ds) {
+		np = priv->ports[dp->index];
+		np->dp = dp;
+		err = netc_port_get_info_from_dt(np, dp->dn, dev);
+		if (err)
+			return err;
+
+		if (dsa_port_is_user(dp)) {
+			err = netc_port_create_mdio_bus(np, dp->dn);
+			if (err) {
+				dev_err(dev, "Failed to create MDIO bus\n");
+				return err;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void netc_init_ntmp_tbl_versions(struct netc_switch *priv)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+
+	/* All tables default to version 0 */
+	memset(&ntmp->tbl, 0, sizeof(ntmp->tbl));
+}
+
+static int netc_init_all_cbdrs(struct netc_switch *priv)
+{
+	struct netc_switch_regs *regs = &priv->regs;
+	struct ntmp_user *ntmp = &priv->ntmp;
+	int i, err;
+
+	ntmp->cbdr_num = NETC_CBDR_NUM;
+	ntmp->dev = priv->dev;
+	ntmp->ring = devm_kcalloc(ntmp->dev, ntmp->cbdr_num,
+				  sizeof(struct netc_cbdr),
+				  GFP_KERNEL);
+	if (!ntmp->ring)
+		return -ENOMEM;
+
+	for (i = 0; i < ntmp->cbdr_num; i++) {
+		struct netc_cbdr *cbdr = &ntmp->ring[i];
+		struct netc_cbdr_regs cbdr_regs;
+
+		cbdr_regs.pir = regs->base + NETC_CBDRPIR(i);
+		cbdr_regs.cir = regs->base + NETC_CBDRCIR(i);
+		cbdr_regs.mr = regs->base + NETC_CBDRMR(i);
+		cbdr_regs.bar0 = regs->base + NETC_CBDRBAR0(i);
+		cbdr_regs.bar1 = regs->base + NETC_CBDRBAR1(i);
+		cbdr_regs.lenr = regs->base + NETC_CBDRLENR(i);
+
+		err = ntmp_init_cbdr(cbdr, ntmp->dev, &cbdr_regs);
+		if (err)
+			goto free_cbdrs;
+	}
+
+	return 0;
+
+free_cbdrs:
+	for (i--; i >= 0; i--)
+		ntmp_free_cbdr(&ntmp->ring[i]);
+
+	return err;
+}
+
+static void netc_remove_all_cbdrs(struct netc_switch *priv)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+
+	for (int i = 0; i < NETC_CBDR_NUM; i++)
+		ntmp_free_cbdr(&ntmp->ring[i]);
+}
+
+static int netc_init_ntmp_user(struct netc_switch *priv)
+{
+	netc_init_ntmp_tbl_versions(priv);
+
+	return netc_init_all_cbdrs(priv);
+}
+
+static void netc_free_ntmp_user(struct netc_switch *priv)
+{
+	netc_remove_all_cbdrs(priv);
+}
+
+static void netc_switch_dos_default_config(struct netc_switch *priv)
+{
+	struct netc_switch_regs *regs = &priv->regs;
+	u32 val;
+
+	val = DOSL2CR_SAMEADDR | DOSL2CR_MSAMCC;
+	netc_base_wr(regs, NETC_DOSL2CR, val);
+
+	val = DOSL3CR_SAMEADDR | DOSL3CR_IPSAMCC;
+	netc_base_wr(regs, NETC_DOSL3CR, val);
+}
+
+static void netc_switch_vfht_default_config(struct netc_switch *priv)
+{
+	struct netc_switch_regs *regs = &priv->regs;
+	u32 val;
+
+	val = netc_base_rd(regs, NETC_VFHTDECR2);
+
+	/* if no match is found in the VLAN Filter table, then VFHTDECR2[MLO]
+	 * will take effect. VFHTDECR2[MLO] is set to "Software MAC learning
+	 * secure" by default. Notice BPCR[MLO] will override VFHTDECR2[MLO]
+	 * if its value is not zero.
+	 */
+	val = u32_replace_bits(val, MLO_SW_SEC, VFHTDECR2_MLO);
+	val = u32_replace_bits(val, MFO_NO_MATCH_DISCARD, VFHTDECR2_MFO);
+	netc_base_wr(regs, NETC_VFHTDECR2, val);
+}
+
+static void netc_port_set_max_frame_size(struct netc_port *np,
+					 u32 max_frame_size)
+{
+	netc_mac_port_wr(np, NETC_PM_MAXFRM(0),
+			 PM_MAXFRAM & max_frame_size);
+}
+
+static void netc_switch_fixed_config(struct netc_switch *priv)
+{
+	netc_switch_dos_default_config(priv);
+	netc_switch_vfht_default_config(priv);
+}
+
+static void netc_port_set_tc_max_sdu(struct netc_port *np,
+				     int tc, u32 max_sdu)
+{
+	u32 val = max_sdu & PTCTMSDUR_MAXSDU;
+
+	val |= FIELD_PREP(PTCTMSDUR_SDU_TYPE, SDU_TYPE_MPDU);
+	netc_port_wr(np, NETC_PTCTMSDUR(tc), val);
+}
+
+static void netc_port_set_all_tc_msdu(struct netc_port *np)
+{
+	for (int tc = 0; tc < NETC_TC_NUM; tc++)
+		netc_port_set_tc_max_sdu(np, tc, NETC_MAX_FRAME_LEN);
+}
+
+static void netc_port_set_mlo(struct netc_port *np, enum netc_mlo mlo)
+{
+	netc_port_rmw(np, NETC_BPCR, BPCR_MLO, FIELD_PREP(BPCR_MLO, mlo));
+}
+
+static void netc_port_fixed_config(struct netc_port *np)
+{
+	/* Default IPV and DR setting */
+	netc_port_rmw(np, NETC_PQOSMR, PQOSMR_VS | PQOSMR_VE,
+		      PQOSMR_VS | PQOSMR_VE);
+
+	/* Enable L2 and L3 DOS */
+	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
+		      PCR_L2DOSE | PCR_L3DOSE);
+}
+
+static void netc_port_default_config(struct netc_port *np)
+{
+	netc_port_fixed_config(np);
+
+	/* Default VLAN unaware */
+	netc_port_rmw(np, NETC_BPDVR, BPDVR_RXVAM, BPDVR_RXVAM);
+
+	if (dsa_port_is_cpu(np->dp))
+		/* For CPU port, source port pruning is disabled and
+		 * hardware MAC learning is enabled by default.
+		 */
+		netc_port_rmw(np, NETC_BPCR, BPCR_SRCPRND | BPCR_MLO,
+			      BPCR_SRCPRND | FIELD_PREP(BPCR_MLO, MLO_HW));
+	else
+		netc_port_set_mlo(np, MLO_DISABLE);
+
+	netc_port_set_max_frame_size(np, NETC_MAX_FRAME_LEN);
+	netc_port_set_all_tc_msdu(np);
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_TX_EN,
+			  PM_CMD_CFG_TX_EN);
+	netc_port_rmw(np, NETC_POR, PCR_TXDIS, 0);
+}
+
+static int netc_setup(struct dsa_switch *ds)
+{
+	struct netc_switch *priv = ds->priv;
+	struct dsa_port *dp;
+	int err;
+
+	err = netc_init_switch_id(priv);
+	if (err)
+		return err;
+
+	err = netc_init_all_ports(priv);
+	if (err)
+		return err;
+
+	err = netc_init_ntmp_user(priv);
+	if (err)
+		return err;
+
+	netc_switch_fixed_config(priv);
+
+	/* default setting for ports */
+	dsa_switch_for_each_available_port(dp, ds)
+		netc_port_default_config(priv->ports[dp->index]);
+
+	return 0;
+}
+
+static void netc_teardown(struct dsa_switch *ds)
+{
+	struct netc_switch *priv = ds->priv;
+
+	netc_free_ntmp_user(priv);
+}
+
+static struct device_node *netc_get_switch_ports(struct device_node *node)
+{
+	struct device_node *ports;
+
+	ports = of_get_child_by_name(node, "ports");
+	if (!ports)
+		ports = of_get_child_by_name(node, "ethernet-ports");
+
+	return ports;
+}
+
+static bool netc_port_is_emdio_consumer(struct device_node *node)
+{
+	struct device_node *mdio_node;
+
+	/* If the port node has phy-handle property and it does
+	 * not contain a mdio child node, then the port is the
+	 * EMDIO consumer.
+	 */
+	mdio_node = of_get_child_by_name(node, "mdio");
+	if (!mdio_node)
+		return true;
+
+	of_node_put(mdio_node);
+
+	return false;
+}
+
+/* Currently, phylink_of_phy_connect() is called by dsa_user_create(),
+ * so if the switch uses the external MDIO controller (like the EMDIO
+ * function) to manage the external PHYs. The MDIO bus may not be
+ * created when phylink_of_phy_connect() is called, so it will return
+ * an error and cause the switch driver to fail to probe.
+ * This workaround can be removed when DSA phylink_of_phy_connect()
+ * calls are moved from probe() to ndo_open().
+ */
+static int netc_switch_check_emdio_is_ready(struct device *dev)
+{
+	struct device_node *ports, *phy_node;
+	struct phy_device *phydev;
+	int err = 0;
+
+	ports = netc_get_switch_ports(dev->of_node);
+	if (!ports)
+		return 0;
+
+	for_each_available_child_of_node_scoped(ports, child) {
+		/* If the node does not have phy-handle property, then
+		 * the port does not connect to a PHY, so the port is
+		 * not the EMDIO consumer.
+		 */
+		phy_node = of_parse_phandle(child, "phy-handle", 0);
+		if (!phy_node)
+			continue;
+
+		if (!netc_port_is_emdio_consumer(child)) {
+			of_node_put(phy_node);
+			continue;
+		}
+
+		phydev = of_phy_find_device(phy_node);
+		of_node_put(phy_node);
+		if (!phydev) {
+			err = -EPROBE_DEFER;
+			goto out;
+		}
+
+		put_device(&phydev->mdio.dev);
+	}
+
+out:
+	of_node_put(ports);
+
+	return err;
+}
+
+static int netc_switch_pci_init(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_switch_regs *regs;
+	struct netc_switch *priv;
+	int err;
+
+	pcie_flr(pdev);
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable device\n");
+
+	/* The command BD rings and NTMP tables need DMA. No need to check
+	 * the return value, because it never returns fail when the mask is
+	 * DMA_BIT_MASK(64), see dma-api-howto.rst.
+	 */
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
+	if (err) {
+		dev_err(dev, "Failed to request memory regions, err: %pe\n",
+			ERR_PTR(err));
+		goto disable_pci_device;
+	}
+
+	pci_set_master(pdev);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		err = -ENOMEM;
+		goto release_mem_regions;
+	}
+
+	priv->pdev = pdev;
+	priv->dev = dev;
+
+	regs = &priv->regs;
+	regs->base = pci_ioremap_bar(pdev, NETC_REGS_BAR);
+	if (!regs->base) {
+		err = -ENXIO;
+		dev_err(dev, "pci_ioremap_bar() failed\n");
+		goto release_mem_regions;
+	}
+
+	regs->port = regs->base + NETC_REGS_PORT_BASE;
+	regs->global = regs->base + NETC_REGS_GLOBAL_BASE;
+	pci_set_drvdata(pdev, priv);
+
+	return 0;
+
+release_mem_regions:
+	pci_release_mem_regions(pdev);
+disable_pci_device:
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static void netc_switch_pci_destroy(struct pci_dev *pdev)
+{
+	struct netc_switch *priv = pci_get_drvdata(pdev);
+
+	iounmap(priv->regs.base);
+	pci_release_mem_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static void netc_switch_get_ip_revision(struct netc_switch *priv)
+{
+	struct netc_switch_regs *regs = &priv->regs;
+	u32 val = netc_glb_rd(regs, NETC_IPBRR0);
+
+	priv->revision = val & IPBRR0_IP_REV;
+}
+
+static const struct dsa_switch_ops netc_switch_ops = {
+	.get_tag_protocol		= netc_get_tag_protocol,
+	.setup				= netc_setup,
+	.teardown			= netc_teardown,
+};
+
+static int netc_switch_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *id)
+{
+	struct device_node *node = dev_of_node(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct netc_switch *priv;
+	struct dsa_switch *ds;
+	int err;
+
+	if (!node)
+		return dev_err_probe(dev, -ENODEV,
+				     "No DT bindings, skipping\n");
+
+	err = netc_switch_check_emdio_is_ready(dev);
+	if (err)
+		return err;
+
+	err = netc_switch_pci_init(pdev);
+	if (err)
+		return err;
+
+	priv = pci_get_drvdata(pdev);
+	netc_switch_get_ip_revision(priv);
+
+	err = netc_switch_platform_probe(priv);
+	if (err)
+		goto destroy_netc_switch;
+
+	ds = devm_kzalloc(dev, sizeof(*ds), GFP_KERNEL);
+	if (!ds) {
+		err = -ENOMEM;
+		goto destroy_netc_switch;
+	}
+
+	ds->dev = dev;
+	ds->num_ports = priv->info->num_ports;
+	ds->num_tx_queues = NETC_TC_NUM;
+	ds->ops = &netc_switch_ops;
+	ds->priv = priv;
+
+	priv->ds = ds;
+
+	err = dsa_register_switch(ds);
+	if (err) {
+		dev_err_probe(dev, err, "Failed to register DSA switch\n");
+		goto destroy_netc_switch;
+	}
+
+	return 0;
+
+destroy_netc_switch:
+	netc_switch_pci_destroy(pdev);
+
+	return err;
+}
+
+static void netc_switch_remove(struct pci_dev *pdev)
+{
+	struct netc_switch *priv = pci_get_drvdata(pdev);
+
+	if (!priv)
+		return;
+
+	dsa_unregister_switch(priv->ds);
+	netc_switch_pci_destroy(pdev);
+}
+
+static void netc_switch_shutdown(struct pci_dev *pdev)
+{
+	struct netc_switch *priv = pci_get_drvdata(pdev);
+
+	if (!priv)
+		return;
+
+	dsa_switch_shutdown(priv->ds);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static const struct pci_device_id netc_switch_ids[] = {
+	{ PCI_DEVICE(NETC_SWITCH_VENDOR_ID, NETC_SWITCH_DEVICE_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, netc_switch_ids);
+
+static struct pci_driver netc_switch_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= netc_switch_ids,
+	.probe		= netc_switch_probe,
+	.remove		= netc_switch_remove,
+	.shutdown	= netc_switch_shutdown,
+};
+module_pci_driver(netc_switch_driver);
+
+MODULE_DESCRIPTION("NXP NETC Switch driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
new file mode 100644
index 000000000000..abd599ea9c8d
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC switch driver
+ * Copyright 2025-2026 NXP
+ */
+
+#include "netc_switch.h"
+
+struct netc_switch_platform {
+	u16 revision;
+	const struct netc_switch_info *info;
+};
+
+static const struct netc_switch_info imx94_info = {
+	.num_ports = 4,
+};
+
+static const struct netc_switch_platform netc_platforms[] = {
+	{ .revision = NETC_SWITCH_REV_4_3, .info = &imx94_info, },
+	{ }
+};
+
+static const struct netc_switch_info *
+netc_switch_get_info(struct netc_switch *priv)
+{
+	int i;
+
+	/* Matching based on IP revision */
+	for (i = 0; i < ARRAY_SIZE(netc_platforms); i++) {
+		if (priv->revision == netc_platforms[i].revision)
+			return netc_platforms[i].info;
+	}
+
+	return NULL;
+}
+
+int netc_switch_platform_probe(struct netc_switch *priv)
+{
+	const struct netc_switch_info *info = netc_switch_get_info(priv);
+
+	if (!info) {
+		dev_err(priv->dev, "Cannot find switch platform info\n");
+		return -EINVAL;
+	}
+
+	priv->info = info;
+
+	return 0;
+}
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
new file mode 100644
index 000000000000..dac19bfba02b
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#ifndef _NETC_SWITCH_H
+#define _NETC_SWITCH_H
+
+#include <linux/dsa/tag_netc.h>
+#include <linux/fsl/netc_global.h>
+#include <linux/fsl/ntmp.h>
+#include <linux/of_device.h>
+#include <linux/of_net.h>
+#include <linux/pci.h>
+
+#include "netc_switch_hw.h"
+
+#define NETC_REGS_BAR			0
+#define NETC_MSIX_TBL_BAR		2
+#define NETC_REGS_PORT_BASE		0x4000
+/* register block size per port  */
+#define NETC_REGS_PORT_SIZE		0x4000
+#define PORT_IOBASE(p)			(NETC_REGS_PORT_SIZE * (p))
+#define NETC_REGS_GLOBAL_BASE		0x70000
+
+#define NETC_SWITCH_REV_4_3		0x0403
+
+#define NETC_TC_NUM			8
+#define NETC_CBDR_NUM			2
+
+#define NETC_MAX_FRAME_LEN		9600
+
+struct netc_switch;
+
+struct netc_switch_info {
+	u32 num_ports;
+};
+
+struct netc_port_caps {
+	u32 half_duplex:1; /* indicates whether the port support half-duplex */
+	u32 pmac:1;	  /* indicates whether the port has preemption MAC */
+	u32 pseudo_link:1;
+};
+
+struct netc_port {
+	void __iomem *iobase;
+	struct netc_switch *switch_priv;
+	struct netc_port_caps caps;
+	struct dsa_port *dp;
+	struct clk *ref_clk; /* RGMII/RMII reference clock */
+	struct mii_bus *emdio;
+};
+
+struct netc_switch_regs {
+	void __iomem *base;
+	void __iomem *port;
+	void __iomem *global;
+};
+
+struct netc_switch {
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct dsa_switch *ds;
+	u16 revision;
+
+	const struct netc_switch_info *info;
+	struct netc_switch_regs regs;
+	struct netc_port **ports;
+
+	struct ntmp_user ntmp;
+};
+
+/* Write/Read Switch base registers */
+#define netc_base_rd(r, o)		netc_read((r)->base + (o))
+#define netc_base_wr(r, o, v)		netc_write((r)->base + (o), v)
+
+/* Write/Read registers of Switch Port (including pseudo MAC port) */
+#define netc_port_rd(p, o)		netc_read((p)->iobase + (o))
+#define netc_port_wr(p, o, v)		netc_write((p)->iobase + (o), v)
+
+/* Write/Read Switch global registers */
+#define netc_glb_rd(r, o)		netc_read((r)->global + (o))
+#define netc_glb_wr(r, o, v)		netc_write((r)->global + (o), v)
+
+static inline bool is_netc_pseudo_port(struct netc_port *np)
+{
+	return np->caps.pseudo_link;
+}
+
+int netc_switch_platform_probe(struct netc_switch *priv);
+
+#endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
new file mode 100644
index 000000000000..03b49857c854
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#ifndef _NETC_SWITCH_HW_H
+#define _NETC_SWITCH_HW_H
+
+#include <linux/bitops.h>
+
+#define NETC_SWITCH_VENDOR_ID		0x1131
+#define NETC_SWITCH_DEVICE_ID		0xeef2
+
+/* Definition of Switch base registers */
+#define NETC_CBDRMR(a)			(0x0800 + (a) * 0x30)
+#define NETC_CBDRBAR0(a)		(0x0810 + (a) * 0x30)
+#define NETC_CBDRBAR1(a)		(0x0814 + (a) * 0x30)
+#define NETC_CBDRPIR(a)			(0x0818 + (a) * 0x30)
+#define NETC_CBDRCIR(a)			(0x081c + (a) * 0x30)
+#define NETC_CBDRLENR(a)		(0x0820 + (a) * 0x30)
+
+#define NETC_SWCR			0x1018
+#define  SWCR_SWID			GENMASK(2, 0)
+
+#define NETC_DOSL2CR			0x1220
+#define  DOSL2CR_SAMEADDR		BIT(0)
+#define  DOSL2CR_MSAMCC			BIT(1)
+
+#define NETC_DOSL3CR			0x1224
+#define  DOSL3CR_SAMEADDR		BIT(0)
+#define  DOSL3CR_IPSAMCC		BIT(1)
+
+#define NETC_VFHTDECR1			0x2014
+#define NETC_VFHTDECR2			0x2018
+#define  VFHTDECR2_ET_PORT(a)		BIT((a))
+#define  VFHTDECR2_MLO			GENMASK(26, 24)
+#define  VFHTDECR2_MFO			GENMASK(28, 27)
+
+/* Definition of Switch port registers */
+#define NETC_PCAPR			0x0000
+#define  PCAPR_LINK_TYPE		BIT(4)
+#define  PCAPR_NUM_TC			GENMASK(15, 12)
+#define  PCAPR_NUM_Q			GENMASK(19, 16)
+#define  PCAPR_NUM_CG			GENMASK(27, 24)
+#define  PCAPR_TGS			BIT(28)
+#define  PCAPR_CBS			BIT(29)
+
+#define NETC_PMCAPR			0x0004
+#define  PMCAPR_HD			BIT(8)
+#define  PMCAPR_FP			GENMASK(10, 9)
+#define   FP_SUPPORT			2
+
+#define NETC_PCR			0x0010
+#define  PCR_HDR_FMT			BIT(0)
+#define  PCR_NS_TAG_PORT		BIT(3)
+#define  PCR_L2DOSE			BIT(4)
+#define  PCR_L3DOSE			BIT(5)
+#define  PCR_TIMER_CS			BIT(8)
+#define  PCR_PSPEED			GENMASK(29, 16)
+#define   PSPEED_SET_VAL(s)		FIELD_PREP(PCR_PSPEED, ((s) / 10 - 1))
+
+#define NETC_PQOSMR			0x0054
+#define  PQOSMR_VS			BIT(0)
+#define  PQOSMR_VE			BIT(1)
+#define  PQOSMR_DDR			GENMASK(3, 2)
+#define  PQOSMR_DIPV			GENMASK(6, 4)
+#define  PQOSMR_VQMP			GENMASK(19, 16)
+#define  PQOSMR_QVMP			GENMASK(23, 20)
+
+#define NETC_POR			0x100
+#define  PCR_TXDIS			BIT(0)
+#define  PCR_RXDIS			BIT(1)
+
+#define NETC_PTCTMSDUR(a)		(0x208 + (a) * 0x20)
+#define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
+#define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
+#define   SDU_TYPE_PPDU			0
+#define   SDU_TYPE_MPDU			1
+#define   SDU_TYPE_MSDU			2
+
+#define NETC_BPCR			0x500
+#define  BPCR_DYN_LIMIT			GENMASK(15, 0)
+#define  BPCR_MLO			GENMASK(22, 20)
+#define  BPCR_UUCASTE			BIT(24)
+#define  BPCR_UMCASTE			BIT(25)
+#define  BPCR_MCASTE			BIT(26)
+#define  BPCR_BCASTE			BIT(27)
+#define  BPCR_STAMVD			BIT(28)
+#define  BPCR_SRCPRND			BIT(29)
+
+/* MAC learning options, see BPCR[MLO], VFHTDECR2[MLO] and
+ * VLAN Filter Table CFGE_DATA[MLO]
+ */
+enum netc_mlo {
+	MLO_NOT_OVERRIDE = 0,
+	MLO_DISABLE,
+	MLO_HW,
+	MLO_SW_SEC,
+	MLO_SW_UNSEC,
+	MLO_DISABLE_SMAC,
+};
+
+/* MAC forwarding options, see VFHTDECR2[MFO] and VLAN
+ * Filter Table CFGE_DATA[MFO]
+ */
+enum netc_mfo {
+	MFO_NO_FDB_LOOKUP = 1,
+	MFO_NO_MATCH_FLOOD,
+	MFO_NO_MATCH_DISCARD,
+};
+
+#define NETC_BPDVR			0x510
+#define  BPDVR_VID			GENMASK(11, 0)
+#define  BPDVR_DEI			BIT(12)
+#define  BPDVR_PCP			GENMASK(15, 13)
+#define  BPDVR_TPID			BIT(16)
+#define  BPDVR_RXTAGA			GENMASK(23, 20)
+#define  BPDVR_RXVAM			BIT(24)
+#define  BPDVR_TXTAGA			GENMASK(26, 25)
+
+/* Definition of Switch ethernet MAC port registers */
+#define NETC_PMAC_OFFSET		0x400
+#define NETC_PM_CMD_CFG(a)		(0x1008 + (a) * 0x400)
+#define  PM_CMD_CFG_TX_EN		BIT(0)
+#define  PM_CMD_CFG_RX_EN		BIT(1)
+#define  PM_CMD_CFG_PAUSE_FWD		BIT(7)
+#define  PM_CMD_CFG_PAUSE_IGN		BIT(8)
+#define  PM_CMD_CFG_LOOP_EN		BIT(10)
+#define  PM_CMD_CFG_LPBK_MODE		GENMASK(12, 11)
+#define  PM_CMD_CFG_CNT_FRM_EN		BIT(13)
+#define  PM_CMD_CFG_TS_PNT		BIT(14)
+#define  PM_CMD_CFG_TXP			BIT(15)
+#define  PM_CMD_CFG_SEND_IDLE		BIT(16)
+#define  PM_CMD_CFG_HD_FCEN		BIT(18)
+#define  PM_CMD_CFG_SFD			BIT(21)
+#define  PM_CMD_CFG_TX_FLUSH		BIT(22)
+#define  PM_CMD_CFG_LOWP_EN		BIT(23)
+#define  PM_CMD_CFG_RX_LOWP_ETY		BIT(24)
+#define  PM_CMD_CFG_SWR			BIT(26)
+#define  PM_CMD_CFG_RX_FLUSH		BIT(28)
+#define  PM_CMD_CFG_RXSTP		BIT(29)
+#define  PM_CMD_CFG_TS_MODE		BIT(30)
+#define  PM_CMD_CFG_MG			BIT(31)
+
+#define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
+#define  PM_MAXFRAM			GENMASK(15, 0)
+
+#define NETC_PEMDIOCR			0x1c00
+#define NETC_EMDIO_BASE			NETC_PEMDIOCR
+
+/* Definition of global registers (read only) */
+#define NETC_IPBRR0			0x0bf8
+#define  IPBRR0_IP_REV			GENMASK(15, 0)
+
+#endif
-- 
2.34.1


