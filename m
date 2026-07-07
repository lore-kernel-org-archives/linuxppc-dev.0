Return-Path: <linuxppc-dev+bounces-23690-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE994C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:48:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvZcZ4n1sz3c5h;
	Tue, 07 Jul 2026 18:47:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783414078;
	cv=pass; b=HBZc+B9qZMVejNSyBxdm+ZckhL6L+fv80XlG6K0pi0V8v41RyWzSgQ9n8pm3LVDa2L74LhgsABXQWadj2yeMrJIjtnIr/NYSdLi6tlsFO+qTJdINoWC9On04xH7BIFOTwmQ5nFrx6sXIcgzEGO93yXz16oy94AnSA0RNj8+rIVi87seC3AymiFPYTOrxcnwUuhgU65ZFmK7xXNo4VaIXQzOZESVZ3c4D/PG6k2hX/o/xb4m4+4ISai9ff1GuygqIqPD8uZOFqxfXE8oiOOnNbhkvdSArUpWb3Q1aBcBSDhlP8XqLBjeikFaNKwtgVony4leJ54wIi4+ft/hLOvL2kg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783414078; c=relaxed/relaxed;
	bh=inQ3ZI5MR1NIw05ZhIFaYKjrAJlJ+Efmiu4/L2Xnz1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HtCrkmjHXzD6QrWvTVXPRscQwdd5PDIERxEywM8yN1KmAYH/tRzja+UEWQLPJguw60Th1swdvXmzWheqAvFFuJjrxOhcKnDtLvYsgsUPzRQpuzq7EvujzMjNaiqZ1sxXZZNcnr7JA0CG6gtbnkbIGMj6mTWvi/4gDTGZV/BmGCpHewBlijpFTQyq/K1Xjdd+VkxlAaaBN61l/WeMT4zYp+FLtkD1YItmXdryfumjosoVoJm9ZiDB4amDn/ZmfRD8+FhR4LMpZ1iMzat+mRAN2dyByuTcXrg9jyy4bapMNT5UAI3Ew02CpfAklWoHVvExjYXMXVTJAHCbfFjJyWirxQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Q19T5qLt; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Q19T5qLt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvZcZ09b9z3c3l
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:47:58 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4KWc7C7ZGz7azsGQKB21JSU9XNygY/A1raUUT/aZLed4bKpGlyQsIlKDixakzQg0VSSXtY4R59Mxb5WhD6BYeY7vDY1hp9F/OdVZ8a9Ejrpi3RnFtUI5/t0ZdxPwKh8WphTBqOcWKJNOsh2hWCYSVOkLsvSw39vqlpxn/XUy9g6kOVxRcYG90blGxHFAFtw/wyHbjWIZ/KbqqUVze+0/dgVEhMr6wGQ0Dr+aDgYVzGBi+45Nztq46iZe9r1ns9BKdp8sJIK6RgyYIBinrBFdTUobPJBNSE/oabPyaXV30gI7YozfKcdh+cQp/nusCHrPRSFz+dhDyYS06v8T0Rm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inQ3ZI5MR1NIw05ZhIFaYKjrAJlJ+Efmiu4/L2Xnz1A=;
 b=QR64K2N5s2bETBC8MyE6HCnc7dkRFwZVyaHj1Bubbt2Lf4E+gadQZUbZLWSSSzhsdJUu3tSQXVac2Pb9mClLQ8HeE8hIusgbWPUPmpKx2xCqijes0ckojuZ33cyfX2jUliVnkkT1HUQuCem2nJUK2fCnfx5xCzmxu/Xoei3Vl8HI/7DCwLtjnCyaP4M8xYLwPDAL0uWKrAzSsT8f2rmzQF4WqbsbNYRTs748DGS+7lxXMTwDU9r7oz96xIxEK5BHYFoAVSvkixyhn/j63ipAniuES6lxQXC2HxtZDPOwbDg4IgnGbl61NlzjRyBcQGzc1Vb2c+Y/R39Z/7y9D/BbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inQ3ZI5MR1NIw05ZhIFaYKjrAJlJ+Efmiu4/L2Xnz1A=;
 b=Q19T5qLtOsZLsc8uF9L+YNRcFGcoaj7oAyqmjUGgiE74xVX8XCnRlUAPyq+h0iUCLBER8hg+0iboSe3e7zy2nb8SJjtSwCMkIID4asCT0eD1tVesuR54vaI+twKiogfG7coRMnwfmHXvCEP9/rv/Qe2MHhAjethVUnj5T1BIy2mu6qODbmJFCFa07+/3b+2TaLx5O8W1YAYwmSQYrbDTxGL8WaTiZKzR6mxgogfUx0jDheGZPxCg6l/BDN+Jw16JYIvKhnldU6WNNqswB9A52tesfzbDKc4GIAlAPwR8jFCWJdlOi2QnM/iPb63cTtjbWJIggApaIYNe3gjxrI38ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:47:35 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:47:34 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 07/14] net: enetc: differentiate phylink capabilities for pseudo-MAC and standalone MAC
Date: Tue,  7 Jul 2026 16:18:27 +0800
Message-Id: <20260707081834.710730-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd281af-8901-483a-109b-08dedc0463ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|19092799006|56012099006|6133799003|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	wl0k5sgnl1n1MSQTTgXCEBfA3s7CxN7QqljEqA+5+9oqaq19CZm1N8nhLaCT3minKeAWZBKlDmwVWAerlQxVlfZ6b6B2zWPUWNlXBRwvGIzuEk6SCWShwJIIvWuC5BHvU+QrN8v/PZXMtQH1Ml/f9+1/jUQcQz8M33s4L21nMtRa3OaiMEM8MbZcPEhI+3puO0Z40RA581g0wmUu9B+X0BJ0w5DcRwlmZhrHfxwwDbYNOwexQbigeMIkOv5j5wZgOkI/Sgu30rUpZTe2Z42zh/NUX6JEnkEUKI0YGKC6EjOi3MRNOrrxdrNj+tfyG/I1kZ3Hvi4q/BGwYBlYporcOjrqrFj4nAQ+zzWnOST+YnkGwojlJ2B1ju6LZz38kFfmwo2w9OdnZOciBOrFd5BEnpiG5NMbOMp3gJHIMfuoLD63GrUkC9HTaOQXIYMpX2sV56gF8Xr3Jrr0qm9h8WbB9ImtqJBpRQDUp7TO9MCKRW3/BI2ba+iVP7pEosq2Dp+YD77naBZvROiGRBE7/m+ulpAdEkRzAsSqIiatjvi21EjCDZFB7LDHSCF6PkieMBk3vby5q87IYVMWeJdtE5NrP/5V5VcjD3AGELcoNHyQ5QJNv/VkdD3jfLKe0apW73aTjwKLDBFXnpnnnSl6W17kf9T+f53BiAAMoCUCoqZV2vAFP4tb3r0jDox7EJe7LtOG33YUz5rD8Rg+6imlbnF56g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(19092799006)(56012099006)(6133799003)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rsx0HTbmn2jLyBlq3Wr1gLJgrzZ5tvzc6TEi4PT2xvl/ogrN8rNM+kOlhqza?=
 =?us-ascii?Q?YU5IZac2UsTbL47/wO50Ot1X6KKneKe1Hu/CUsV5xUdpyw2M1a12FPuMBDGJ?=
 =?us-ascii?Q?tCNDwcfssfyoXLB/QyXLrG86tAGmf5uPR9ylUg60E9rTBgBMraykTWGJ8Zer?=
 =?us-ascii?Q?j5scw90WcNsl5Qe3JLw3esoATRn8e6uS4mLOiW0lP/6+tgqI2zRfNiiL61U3?=
 =?us-ascii?Q?kRdnHiEchZZ/Q3OcogwHstQDENUDVZTqT5yS9PKfNYYt7PTdjz32R3IOtJLS?=
 =?us-ascii?Q?Ec2ugCQnIJd5p3/gjic8n5Y4ZEsQY5uKkzE1aIQsOUxGtbIQTCfMqBHX5khT?=
 =?us-ascii?Q?tfwyvirgmgeBWG7Z9kdzqvQLp7KU7xWKMnQwJMcGd0v1qcfdapbfxsDTXyxw?=
 =?us-ascii?Q?pSaN19hQ7QfR1ZPPfwvmqmC2OoDUlqAeknAYrj2IRC2Dus/gxZ4L80nAFHef?=
 =?us-ascii?Q?oS+78YqSgPta3ZxdxAyR8V1g6LdFMggIMl8wBrgjyzzElgUwp4vaLWMz9b4L?=
 =?us-ascii?Q?mFKpTPKzJvI2xIHqOEI182HxIK/LgZOAzkVwMtILEsA1mDums4CeJH8lrHco?=
 =?us-ascii?Q?FIm3IKQmQR15NeNqmhdGc0rFPFc0epaRzUjXKjYuVgcjBe54X79ZnMr/2Oht?=
 =?us-ascii?Q?MePcAR7MbQ+tRoy2ypSMSlk5LwJ5SH0iNSggwu9ae8XQ5sDq43yQD3gWpjsy?=
 =?us-ascii?Q?jWRetskzN0VF5LCUGheBuCWLH7Qf/bQ6MxExNNYnAm2G/5nxuMi5ziCwszfY?=
 =?us-ascii?Q?B150Gbi3nyWTnSYRuWcpAg02XsRzY4eE3vM3MlOORmwnkztUPyXByrvSXM56?=
 =?us-ascii?Q?K8SI1XQR/HiQ1e/SjziwW037OfrQrS6EWsudXh7JG83PD5CfaTAuTo7+veut?=
 =?us-ascii?Q?i2YmrBNu3LC2USGmGZ0sXMRsq4aDHB1q6SX68gBClCgLti9rMWBgrpwcCSyO?=
 =?us-ascii?Q?Kk4UNRcmJ1ws8MkRi6N32ZwzUr2XTLBraNeV2g3ch2aTzFCBoCt4tIpA4heT?=
 =?us-ascii?Q?MLvfLcry8tl5q/PY9VzyCRKfp+2lDEYWof47VIdNpYhnmG6EsU1lb/syhzL/?=
 =?us-ascii?Q?vUmuFSn/gYl2Nba1ZWhE5SmFdMoHi0B7F+dLqUpFk0rQbmO8XpZcKVHRrEU3?=
 =?us-ascii?Q?FCnnEAxoFzuLjd7ayaORn9gCRsoSUlj+xC2dR0UNDaT4afSnM2A1iTik5zyl?=
 =?us-ascii?Q?UTWi40Pv/qXfDsDSo/MMKEqtU3QkFha2jIR0O6X/CIl+5L8hUCmOLeKk4E7B?=
 =?us-ascii?Q?+zC+oAZGPVXtaL/jsG7P6UCSltArPnoorymmzEA0dgtDvmjyMlv83Rck6jY1?=
 =?us-ascii?Q?VS5Jp2R/rr3eghBXjiuSsVrdVYGyS5aspmLXxlGjRAr+IZs1m22eDZOfsqoZ?=
 =?us-ascii?Q?y21chmQjtuGYGKIS9EdBGg3CS5XJg+/eyHf50eUaLOfFLnvFh9P1HrdtoUzs?=
 =?us-ascii?Q?uelNNFwylDntcWioddFjte2HQkg68xeROMIEJPo0zDj5+HPkpG26Gm5emv8Z?=
 =?us-ascii?Q?RkNhrfFjPnC1yMbiThQSYzmg4UzgrS+v1h9YeV59JoFs1x1CKy9jGDpOaOKo?=
 =?us-ascii?Q?yVuRp9TH+95vM6WYz4U/Er2T9/G0/9cPx4E9X1HPYGtnkg9s1yuwg+Aukekx?=
 =?us-ascii?Q?NUI3zRxi6yj/xD+ETLK+hSE8TOnjMlKnVgfz5ino85EPYia3iYDyQnkxDene?=
 =?us-ascii?Q?Kg4iakDj3q9CbCvMNs6CJhKWjr4Z3aUAkabcuBMYooe9NjeqEBiYo/r/1lQD?=
 =?us-ascii?Q?5WnnyvOlvjCESub18mT+BNgPvydj/2KT/Lef2KUqZ+j64L+4FQ/r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd281af-8901-483a-109b-08dedc0463ea
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:47:34.8992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2PPA+tdbwfIctDu1VDo8IaoTXWhMn5iSRywQ4D6gbFVvGd6Ub28QHr5VF0FcX/TVZhOAGZBsxFQcXmxJs09xarjGrwVmTcvMjVGDPLJsllLLRC4dyDgKd33EnHiymKM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182

From: Claudiu Manoil <claudiu.manoil@nxp.com>

The ENETC pseudo-MACs are proprietary internal links that do not
implement any standard MII interface, so restrict their supported PHY
interface modes to PHY_INTERFACE_MODE_INTERNAL only.

Since pseudo-MACs can operate at any speed between 10Mbps and 25Gbps
in multiples of 10Mbps, set their MAC capabilities to cover the full
range of standard full-duplex speeds: 10/100/1000/2500/5000/10000/
20000/25000 Mbps.

For standalone ENETC (v4), expand the supported interface modes to
include 10GBASER in addition to the existing RGMII, SGMII, 1000BASEX,
2500BASEX and USXGMII modes, with MAC capabilities up to 10G. MAC_1000
is replaced with MAC_1000FD to explicitly exclude 1000M half-duplex,
which is not supported.

Note that 10GBASE-R mode of ENETC v4 has not supported yet, the current
patch adds PHY_INTERFACE_MODE_10GBASER simply as preparation for the
upcoming support of the 10GBASE-R mode.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  1 -
 .../freescale/enetc/enetc_pf_common.c         | 44 +++++++++++++------
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 06a9f1ee0970..8839cfb49bcf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2017-2019 NXP */
+/* Copyright 2017-2019, 2025-2026 NXP */
 
 #include <linux/timer.h>
 #include <linux/pci.h>
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index f24269a48c26..75ee117e9b1d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -602,7 +602,6 @@ static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
 		val |= IFMODE_SGMII;
 		break;
 	case PHY_INTERFACE_MODE_10GBASER:
-	case PHY_INTERFACE_MODE_XGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
 		val |= IFMODE_XGMII;
 		break;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 3597cb81a7cc..781b22198ca8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2024 NXP */
+/* Copyright 2024-2026 NXP */
 
 #include <linux/fsl/enetc_mdio.h>
 #include <linux/of_mdio.h>
@@ -359,7 +359,8 @@ static bool enetc_port_has_pcs(struct enetc_pf *pf)
 	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
 		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
 		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
-		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
+		pf->if_mode == PHY_INTERFACE_MODE_USXGMII ||
+		pf->if_mode == PHY_INTERFACE_MODE_10GBASER);
 }
 
 int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
@@ -400,25 +401,42 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 {
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct phylink *phylink;
+	unsigned long mac_caps;
 	int err;
 
 	pf->phylink_config.dev = &priv->ndev->dev;
 	pf->phylink_config.type = PHYLINK_NETDEV;
-	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
 
 	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_SGMII,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_USXGMII,
-		  pf->phylink_config.supported_interfaces);
-	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
 
+	mac_caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
+	if (!enetc_is_pseudo_mac(priv->si)) {
+		mac_caps |= MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD;
+
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_USXGMII,
+			  pf->phylink_config.supported_interfaces);
+
+		if (!is_enetc_rev1(priv->si)) {
+			mac_caps |= MAC_5000FD | MAC_10000FD;
+			__set_bit(PHY_INTERFACE_MODE_10GBASER,
+				  pf->phylink_config.supported_interfaces);
+		}
+
+		phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
+	} else {
+		mac_caps |= MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD |
+			    MAC_5000FD | MAC_10000FD | MAC_20000FD |
+			    MAC_25000FD;
+	}
+
+	pf->phylink_config.mac_capabilities = mac_caps;
 	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
 				 pf->if_mode, ops);
 	if (IS_ERR(phylink)) {
-- 
2.34.1


