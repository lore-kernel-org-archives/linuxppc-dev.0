Return-Path: <linuxppc-dev+bounces-21091-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7238ACD4F49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:24:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrT51Jk8z3c1D;
	Mon, 18 May 2026 18:24:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092697;
	cv=pass; b=hvo7ei28wytsExkiUlNduSQGoo1xGiR+Fu4wwkGRpS/vH+5bfki101dy2W55k34f1+gn6sIcaBFsN6p+0k38DsicpVb7UL3kpTMHyCXEahopggXxBrSt5AQa9YKLDx8Ax8m4GE/PjIsQvYeAKaDDHTwwWSGkkPtMTQpGNA/gzMlTLLK9Dkgr+vnhgO2pabmlbKgfFaoJkX3aJYF+eN1bcH6Hx6VaXPqLAnqcho/lrEFwOipBkrqoMtdffxxmDpjh7k632lLHRBAonE8abGMq0iam0Tc2Hb6PZocDtUYDC20tUIw0Sxus/k1HXJ10+m2v5sO+pVJZwQYo787IgMCVhQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092697; c=relaxed/relaxed;
	bh=DVjCB/sve+5iQSof275/7DdimURZhltIc6Gxwubhw+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mJpW9GcoBURHMmt0Uc/G7Y9LBRS5Jj9dFO4c5bhoLafkrurVCNuO0IO3PI7SvFqs9mOPl8ZxbpQELjj95/UqwlI1IBMxPv1ioEPZ3NGWW8MqepWS3Uz4RWHRTpOHdW08/Q2JxL9Q2laYSh/hqnaVVWyy84o4Q+5k7ghTHX68WN1rwC2zOW9Bf8xZDJsrgJpP42RHgNuYn17CXsrLuD2ouaoEUYfirGJ4MYMpSAEuPsVWGUY6MuknRRoeFKlWk4yHo4SNICi6T7wMW7abUYdtXUnSaFDCGFDQ+cptdAE5wHWo1MxGb2CYPFZzDxggz5TApWzIh4WtY66fDgkK0Gb0eg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=RAcT8nKp; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=RAcT8nKp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrT40Dv9z3c0H
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:24:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5ZKJAy8xS8FHKvwW+wXcNsteFpi/ACVOyaBMLdlkZ6vgMKypCzn5NN9602KWeatL3kA+dnYD+oKE7merp+dlVYDpmKoas9EciNR2tWpGcKJcoUXRYmOwFqUUlDFlS7WVFrgyshhRIsyulvQXZW9NmcuiCGWtuPogzjBbUBnucGC8zNBDApI4uFV5utOnvrfmmvnNNsXqmhdh4JtJynTyL6PZZmzf25DT+EbBBKBtqcpvMXEVr9PiZ2qPxvdK4uiYc/deC9inyBNbwsUzmDYiTFvtK/47paDC2ekUbRO+S2jQfb2/25BslWSPbmlwPtnX3G6mkG0KATlGbJOSkDpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVjCB/sve+5iQSof275/7DdimURZhltIc6Gxwubhw+A=;
 b=lOo65gWbk4TJ5Urw8VKznD5Qw5CZHgSBslGUGtv/JsOcE8FyoPUURN7AqkuPegND/2xuEYBFMN/S105712vXtcOwboLqEg/4UYvvEs1ubgAhbm5eiza8qZGbJhxUHPGe+dxtWFbAor+WFc5HW1VhTZ4kw26aByh0Y5U9NYbxOpXfZCJl2Uyjauu6YifSW7Z3KW4Q0QNgiIuTzIOkHBYgcv3ejoPdLsv4Tw92X7K4OCJqbYBtjUWWWlCAdD6X3tl6xmDCz1rjSwaK/1QbvikL9kAdTgcWZSOF0Rd/3fQFe7rbbNESc1VAUYO+umr9iSbCFEiQKaexUUUHN/8tzJZLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVjCB/sve+5iQSof275/7DdimURZhltIc6Gxwubhw+A=;
 b=RAcT8nKpXaYfvFNHSLDyorRyxolUc5R400xaxpVuodMsZs9hRzEi/VY9n4pUlmhA8rWauy0hosZuilOXTztMCZSJmk8VkUXUNFkKBi8uVxWVv1c8rWQgwFXMuKcNDHJDVbQnloVA+ZODhpKmf7bNA0PuYL90eQYlSialSagJURmDI0XVbNgplYxz48Doh50ybw4gqSYgCzo4VWx21EHPmRwf16T4jZxre9h1vZItTNdSwxHzrJio1brB/XRiZKkqEuiOOu8gS/YVOMyQNCi8X8v9nKTK/vbC7IprewnvAltSr5pOP/kG8WeW/ig1aL5+aHDJP/m8LoYtXbyN2yAu9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 18 May
 2026 08:24:31 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:24:31 +0000
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
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v8 net-next 11/15] net: dsa: netc: add phylink MAC operations
Date: Mon, 18 May 2026 16:25:02 +0800
Message-Id: <20260518082506.1318236-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518082506.1318236-1-wei.fang@nxp.com>
References: <20260518082506.1318236-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM9PR04MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cbc21b1-a5dd-4823-261c-08deb4b6e2bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020|22082099003|3023799003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	u8NNQXKMzs1ms7rCDuTltf8erR1bNAlzhPt6x1mbX8gNDE71kF1IXaAE5t6BJDIak03zKj62gYQDPeyhn6WrYqz9tMzMMP3j2xH1vWl+vjbMg3AjHeg3m+KWniIwkdMvB/MqGMj/CM/7abGHrv6DRAlOhDbbnG+Gj4NQROSBFbKlPZtjTvM0fRUWcfqkFtyR6WjPbk3Nj8jsGHFuNQ2xM/6mxREGaAUWpPlTPEgrOntNEKfnxyjRyume+vpdyAdvHh2MqXs7qlonK16sg6bfSap5U2fVhp1v1HiKrnz2Lvh3HQooa2mUPGjJGUUOJj89/kRPHovOAno+CRWgq7aoWFVH0v8Myog3DUiZRxqCuhgxBbli2/t7Qsky7TXbYwjP+rPd1gS230FmsYA3XQ9LPG9of/08fNql2h6kDZ3poOB4rpCxQXCih13HaAlgJQo0i2yl6QeTrw8MxIHTXMKVSFKZLK8mDmRZgwRH0DREcunnYbwpLm2gVSXkBZ9PgDGjnoJZT4p+dBcb8i7b5ynbAOyEPhfmdB0pYFwElO8KGYIVt2yzrnw9mBnKVCuLvrxUPVXXVn8t4qPCIkAlM2E2dp+vy/wxMeHIFBgjgkGNUDX2oZOpeQcwBlyHhOQZMOdRpUy/HMeSd8kFZM2C43hobnjF0/NqXvCBvtlo/4Xygb3w+Tqo6Xdzp0gUQQWEF/7ygdoB8PXyp8NM534wnjpXSC7Yk6c+S62X0CkJtLxuIDu67d9MUP2p1iUNK7UqIwU9g7SyraiqN0FAGfXsz+drLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020)(22082099003)(3023799003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gX03F3HCmFajBWSqIFs557oCQQW21o7K+jvpZ1Rxc9idemVr2DfafiBEMFsy?=
 =?us-ascii?Q?W1ZEI+JDl+4ywpgaeVlb3I0fryTZpDBvNuFzsMe/BsjdyzJq16Fac+1BgLYB?=
 =?us-ascii?Q?KUp51uoNFZw/R5AtcbEMdR6JNoxC7Wex4G2ed+LjZKXnUQ1lEE+WkUTwlq5q?=
 =?us-ascii?Q?w5md0JxUlS3whrZTD98xRgzq+0NA2VPeCbyuB3FM+woMKoGUgB9ad7dPKrgZ?=
 =?us-ascii?Q?fYEWocJXs2iMfEiX8i0/RAkVqyBS1QIOXNb1auVtFeoy5NKSWBCluSdqvcSn?=
 =?us-ascii?Q?jAs4SF9DVOxWzQkP23CEpKkjdOm8HWvfzs2i5b3XT+tij1XtO5s1GSf23GVs?=
 =?us-ascii?Q?L1f36lsjnEnDzPbs70+nwN6Nnagmmf4w5LQiCQmyHENo+i+Td4teRehQpYlD?=
 =?us-ascii?Q?o2j1lPjiGMSozrwo22dvg5nndQKbRg0KfGN2yb6zGH7wLjwVRJ4ooHu5gxYC?=
 =?us-ascii?Q?KJycG3pmLzXyCWMSXPyn9CEVNxPlkUBkcTtQExgYIS+f43huRpl6WRm8xahi?=
 =?us-ascii?Q?EJ48Du5y7eaYqfSt60KglDy3iyT8An19GQMYcZlka6RWj0aZDde2GYZWFDcS?=
 =?us-ascii?Q?JXYH2stYcVpEtYZOIwdZKkeeNE3yHh7ICBRYhgKNLiI6rMCy/D2F2GW7d24F?=
 =?us-ascii?Q?y74I85BK2gKCm6k2SAp5/mImUtc3Fzv8QsMlBvao5CUWu7X026EP19yEXZym?=
 =?us-ascii?Q?wUgH5vaNZ3g6qKt3ZmVl6Qlg7t3Z7FguBymeUnMYTdb0myypmh/M4aRf098C?=
 =?us-ascii?Q?WDGWArua/l8M4roycmTsYnTSsdMzkGos6MVbHktEsqNwnQQjHYtOnvznEkIJ?=
 =?us-ascii?Q?sNbSCObF2X1r6GQCfCuT8qd8hmOEZCKZBnHPjiwDY2LbPxq1/vOFAlt+kf4C?=
 =?us-ascii?Q?jMNB5r5CxgvAEGvbIQRI7lMuPlaYhPS7f6pLEREj7b33klT8VD2naPvX7SqB?=
 =?us-ascii?Q?aKIjoFAYUnDwR77VpZ/KPF4RgS7ECWO0y6J+iwfukUQE88LtXktUgEQiwiQp?=
 =?us-ascii?Q?5txVMXfuaTGIhYJgYPm8KHdEXjxltQXGB0+cMd1Mea7YzcpwaufmmSfZ80UT?=
 =?us-ascii?Q?rz2QsXkChLG8a993VTwyeaSIYmiBCi3b/jJu/7GbxwMZFaas9xRKO1Tg282W?=
 =?us-ascii?Q?Y91zKTqFipCeUDqyJ3ytNkCGSyFWoFffO+nB7qUv1d+ShYUDm7BtMPs6daGI?=
 =?us-ascii?Q?xNFoLD4q0S4kKHOpUf25zgFHGSZ55HUVsrQpRGSZU6FYATwl/Kd3DMJ40gVa?=
 =?us-ascii?Q?IhCsLpmnwpfoZcve8LC1rWU1qdZU5rZhtqNNO1v/7OsrVu9RyGgGe845b/lo?=
 =?us-ascii?Q?Fnq1mbhttzoWvIPCabqGTSH11tFphvRl0gcUWggh3+G5CRsoT6+QMhTlXTMp?=
 =?us-ascii?Q?Qh1VNiJgM8FC/3LXFl7ou6ovEGaXGsPF3p3z486JEsm0J4m9rn4w0EU2lPAs?=
 =?us-ascii?Q?ysDmxdR9HmST6G9idxVEanS0CdFpjsaUuDSkVPYgYur+y0ba3tB1SwiMknLb?=
 =?us-ascii?Q?7Y2WYptPsllQdBeZ3LnlJLwTd2fqsnULSxU86/LygbIcFRlHiNKa5tb2keHQ?=
 =?us-ascii?Q?6Bcm6LOLttLBisaBOL4F+qJNiGZN1CP3cdgr9I4gjQ6ClbBQPaf+FydUma9c?=
 =?us-ascii?Q?F+d+xkx8xwc0pBbhJ75iD/LsrdJJWXITnPhsdv2ZBh6ZgcBqPWzp+cZiUCDl?=
 =?us-ascii?Q?TyoMjdzy/02dEbpy7mRhPXREB0tN3lMusUdgcTPTLmP50JPS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbc21b1-a5dd-4823-261c-08deb4b6e2bc
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:24:31.7420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NT89D8nSygE9xJ24oEDt+tctkwqLjBGcBJGoQ14b81+fTiTko83H9nG4ubbRvy9W5RmyGQ0AxcSD7bVx47TIDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8938

Different versions of NETC switches have different numbers of ports and
MAC capabilities. Add .phylink_get_caps() to struct netc_switch_info,
allowing each NETC switch version to implement its own callback for
obtaining MAC capabilities.

Implement the phylink_mac_ops callbacks: .mac_config(), .mac_link_up(),
and .mac_link_down(). Note that flow-control configuration is not yet
supported in .mac_link_up(), but will be implemented in a subsequent
patch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/dsa/netc/netc_main.c      | 247 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c  |  38 ++++
 drivers/net/dsa/netc/netc_switch.h    |   4 +
 drivers/net/dsa/netc/netc_switch_hw.h |  26 +++
 4 files changed, 315 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 8e3a3230226c..2141b3aa96b7 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -43,6 +43,30 @@ static void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
 		netc_port_wr(np, reg + NETC_PMAC_OFFSET, val);
 }
 
+/* netc_mac_port_rmw() is used to synchronize the configurations of eMAC
+ * and pMAC to maintain consistency. This function should not be used if
+ * differentiated settings are required.
+ */
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
 static void netc_port_get_capability(struct netc_port *np)
 {
 	u32 val;
@@ -507,10 +531,232 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
 	priv->revision = FIELD_GET(IPBRR0_IP_REV, val);
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
+	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII;
+	u32 val = 0;
+
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val |= IFMODE_RGMII;
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
+static void netc_port_set_rgmii_mac(struct netc_port *np,
+				    int speed, int duplex)
+{
+	u32 mask, val;
+
+	mask = PM_IF_MODE_SSP | PM_IF_MODE_HD | PM_IF_MODE_M10;
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
+	mask = PM_IF_MODE_SSP | PM_IF_MODE_HD | PM_IF_MODE_M10;
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
+static void netc_port_mac_rx_enable(struct netc_port *np)
+{
+	netc_port_rmw(np, NETC_POR, POR_RXDIS, 0);
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN,
+			  PM_CMD_CFG_RX_EN);
+}
+
+static void netc_port_wait_rx_empty(struct netc_port *np, int mac)
+{
+	u32 val;
+
+	/* PM_IEVENT_RX_EMPTY is a read-only bit, it is automatically set by
+	 * hardware if RX FIFO is empty and no RX packet receive in process.
+	 * And it is automatically cleared if RX FIFO is not empty or RX
+	 * packet receive in process.
+	 */
+	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_RX_EMPTY,
+			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
+		dev_warn(np->switch_priv->dev,
+			 "swp%d MAC%d: RX is not idle\n", np->dp->index, mac);
+}
+
+static void netc_port_mac_rx_graceful_stop(struct netc_port *np)
+{
+	u32 val;
+
+	if (is_netc_pseudo_port(np))
+		goto rx_disable;
+
+	if (np->caps.pmac) {
+		netc_port_rmw(np, NETC_PM_CMD_CFG(1), PM_CMD_CFG_RX_EN, 0);
+		netc_port_wait_rx_empty(np, 1);
+	}
+
+	netc_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN, 0);
+	netc_port_wait_rx_empty(np, 0);
+
+	if (read_poll_timeout(netc_port_rd, val, !(val & PSR_RX_BUSY),
+			      100, 10000, false, np, NETC_PSR))
+		dev_warn(np->switch_priv->dev, "swp%d RX is busy\n",
+			 np->dp->index);
+
+rx_disable:
+	netc_port_rmw(np, NETC_POR, POR_RXDIS, POR_RXDIS);
+}
+
+static void netc_port_mac_tx_enable(struct netc_port *np)
+{
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_TX_EN,
+			  PM_CMD_CFG_TX_EN);
+	netc_port_rmw(np, NETC_POR, POR_TXDIS, 0);
+}
+
+static void netc_port_wait_tx_empty(struct netc_port *np, int mac)
+{
+	u32 val;
+
+	/* PM_IEVENT_TX_EMPTY is a read-only bit, it is automatically set by
+	 * hardware if TX FIFO is empty. And it is automatically cleared if
+	 * TX FIFO is not empty.
+	 */
+	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_TX_EMPTY,
+			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
+		dev_warn(np->switch_priv->dev,
+			 "swp%d MAC%d: TX FIFO is not empty\n",
+			 np->dp->index, mac);
+}
+
+static void netc_port_mac_tx_graceful_stop(struct netc_port *np)
+{
+	netc_port_rmw(np, NETC_POR, POR_TXDIS, POR_TXDIS);
+
+	if (is_netc_pseudo_port(np))
+		return;
+
+	netc_port_wait_tx_empty(np, 0);
+	if (np->caps.pmac)
+		netc_port_wait_tx_empty(np, 1);
+
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_TX_EN, 0);
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
+	if (phy_interface_mode_is_rgmii(interface))
+		netc_port_set_rgmii_mac(np, speed, duplex);
+
+	if (interface == PHY_INTERFACE_MODE_RMII ||
+	    interface == PHY_INTERFACE_MODE_REVMII ||
+	    interface == PHY_INTERFACE_MODE_MII)
+		netc_port_set_rmii_mii_mac(np, speed, duplex);
+
+	netc_port_mac_tx_enable(np);
+	netc_port_mac_rx_enable(np);
+}
+
+static void netc_mac_link_down(struct phylink_config *config,
+			       unsigned int mode,
+			       phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct netc_port *np;
+
+	np = NETC_PORT(dp->ds, dp->index);
+	netc_port_mac_rx_graceful_stop(np);
+	netc_port_mac_tx_graceful_stop(np);
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
@@ -549,6 +795,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->num_ports = priv->info->num_ports;
 	ds->num_tx_queues = NETC_TC_NUM;
 	ds->ops = &netc_switch_ops;
+	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->priv = priv;
 	priv->ds = ds;
 
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
index abd599ea9c8d..bb4f92d238cb 100644
--- a/drivers/net/dsa/netc/netc_platform.c
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -11,8 +11,46 @@ struct netc_switch_platform {
 	const struct netc_switch_info *info;
 };
 
+static void imx94_switch_phylink_get_caps(int port,
+					  struct phylink_config *config)
+{
+	config->mac_capabilities = MAC_1000FD;
+
+	switch (port) {
+	case 0 ... 1:
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
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
+		/* Port 0 and 1 do not support REVMII */
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
index a6d36dcebc6d..ac9743da2a1e 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -35,6 +35,7 @@ struct netc_switch;
 
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
index 0419f7f9207e..7d9afb493053 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -67,6 +67,14 @@
 #define  PQOSMR_VQMP			GENMASK(19, 16)
 #define  PQOSMR_QVMP			GENMASK(23, 20)
 
+#define NETC_POR			0x100
+#define  POR_TXDIS			BIT(0)
+#define  POR_RXDIS			BIT(1)
+
+#define NETC_PSR			0x104
+#define  PSR_TX_BUSY			BIT(0)
+#define  PSR_RX_BUSY			BIT(1)
+
 #define NETC_PTCTMSDUR(a)		(0x208 + (a) * 0x20)
 #define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
 #define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
@@ -123,6 +131,24 @@ enum netc_mfo {
 #define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
 #define  PM_MAXFRAM			GENMASK(15, 0)
 
+#define NETC_PM_IEVENT(a)		(0x1040 + (a) * 0x400)
+#define  PM_IEVENT_TX_EMPTY		BIT(5)
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
+#define  PM_IF_MODE_SSP			GENMASK(14, 13)
+#define   SSP_100M			0
+#define   SSP_10M			1
+#define   SSP_1G			2
+
 #define NETC_PEMDIOCR			0x1c00
 #define NETC_EMDIO_BASE			NETC_PEMDIOCR
 
-- 
2.34.1


