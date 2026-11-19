Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF760A3803
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ffarJKwT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVNWz6yxCz2ygd;
	Thu, 19 Nov 2026 14:01:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795057263;
	cv=pass; b=FeCLp7LyaroTLfB5FRJ1mSDiOy/nUsH8t/Fw7RAORzNcgVeO47IX0fhDw+Yf8e2bUw6Nwz+ntgAXiy7rQK7PvswzAACOy7VoRjpBu8jQbdzPSR7BL7alhAznjNWZ4xmsgG8XKwvrdGuUnB4c8LDjh3Qv1DTNfSG/17d7HzSWflG2iAlqVyA7M6oglzWYpQakPHAmSU4OJCe4igMyV9/44TcG1iCbt9Zs0O2H+JGK1yMrv8/tVVbVt+PgaUNIAeLwMbVes/UsWhNxs0QQlN4NBcjDKbfSjlsyLnZtCwuYAj4xv2VJlOGYPO2Tu/0rH1tOWhaOgjY1vwKfkNdDMXqTMw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795057263; c=relaxed/relaxed;
	bh=5UPgYpGLBhHqPakq85b13zcPfzngtzxoxGkKzdoC/FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ef+ovViRsP2CAi3otPCVjW9s3X0Dd5TICvuzwNqLmDVyKaYIkD/IlGX4QCrBkvcfNvZ/IKQelWLI8dgCZOgoLRR/fu4PcsbA6xF+joVnhz/gXbCwpxCh6667Sibx+Y91wdu8MzlxjGDIVySe6e+0ImNYyOy0T98X5PAsnPBoxdEGuZM75NbsT0+T9feyJoFP8oToL9vQLo42k/Mp2etxTvJpYPeF55UmI5tiaaCTMhK27TKLarFsCmlJG3tKAcFUUJ2pjfMSqmo1aOyINTb1o3F12v6cEDyJ4x/QJdPB2/SNWMsD3XSrRDIfdRhZdzu1EeuvtomRXKkF2dmy5SFpSQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ffarJKwT; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ffarJKwT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVNWy6v1Qz2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:01:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMRdiheVcSzWJy/cJ07j6fLwB3kAP6jDj8+wDrhDE1peAVNZVds2FIu+wBI7DPZgicZMoh5mhJ+rZxfNz0D4wdzqT8lGtin4Xr5hPn3oRoPxWKrIywHASUV7inJSsHaneNb6ApA6MpgxcsxNR/P29tvN0nos3QbO8kxpZGqizdJzT4X2Fty0H/gTFYvNm3a60Ul6PU7+aaSZQ5ba6rGQoOmzS+yAbnpWgX2+RFu7qnJZVm8iNCqDHM3acFhd6XAbLzhfUaWIa53+aTPPgfqHRJ9fh/+qx+m7EbntzC8R0NwH3n6WBWJArIVqWrZKtF+fPKHBnJxyfCotbA6K2P2hXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UPgYpGLBhHqPakq85b13zcPfzngtzxoxGkKzdoC/FQ=;
 b=WA84r53aB09TXjqxolVV+hg3I593ffTD4XW6+Gk96WZj7KlcBMD00i3M+ErYymgVrT/keMb2cMjihqZgFyvJ1udIM0VM1ypg0uFvm6sneCxq5jqRWicxpR7+1enTh7fg/Tp+RQM9Kk4EsCkPoyPrjoWTffs7G3NSW1faX6rv78dTk8YaAsesz5nSVVERFUcorvMp8xPLo3s48sFtpjEBPg+RleHMMhQPMrTkuW4CcKPdnsphptQSmNpFP8VB/XDZUQQxkqCA59rk3RsnAFKq4JMRdRQ5Xixu+qCdEbEE/Vnbwoq01XlIwnZWPBrULYJUnQ5kTcOQiLVTLS93IgBzGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UPgYpGLBhHqPakq85b13zcPfzngtzxoxGkKzdoC/FQ=;
 b=ffarJKwT8R60NEdnFYDeImVOjTzWmj5zbVjpLX+QR8CVQ+CYL8Kw9lPQ6dHHFnyZQXfY3hduy763x83IXv6ya9z7Zc7cJYaLAJpArSca5xnH9npy2ONMgnXd+hUG6urpO8HtR/F4qOk1POAdKxf3dYk316Zt9GK5j1mEJCiWXr9KI7Ji9NyJWL7646aDfDFfQ1zFxqj5rfr6sPFFX+r875va7i/KRfNigr4YQbtX5o+QlHvov+h/ORa4o1OlRDrLWVCuTbR7iFUB8g7EfAVdw9uMFxC1ToOxPGrpadQyNRBYuIaXhkF+nrI7IbNTIGF65C3f5HfVVCsfm/2O15qlWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM0PR04MB11880.eurprd04.prod.outlook.com (2603:10a6:20b:6fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Thu, 19 Nov
 2026 03:00:58 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 03:00:57 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	linusw@kernel.org,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 net-next 3/9] ptp: netc: export netc_timer_get_current_time() for cross-driver use
Date: Thu, 19 Nov 2026 11:05:28 +0800
Message-Id: <20261119030534.1892935-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
References: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM0PR04MB11880:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb6c6fd-8ad2-4150-8e59-08df45e9556b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|7416014|376014|1800799024|22082099003|18002099003|6133799003|261009223027099003|3023799007|921020|11063799006|56012099006|261102130727099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	83tNMO2Rx9y2NgzTXMigSEXeX/ar1ztnrGsVvJTm9h91WbxamKfttD1cXtv3INdFUaJ782HrFxbhIvZMp1oKW+uOkLI9uqTKSUBzI3C/2VQlUrdHlC8EswXQdc/hQthm2hiEErwo7MGMKNOr3Imtunj1zVJZTNNV+k7UZDBo+IzkhH6jq5aA9O8hDnXWg3b5Hg4xDUpRmquUTVfQ4mlWkBDNVS2wZugkMEVvoDavUoR8T02LxouSUJSpeG7FAcuqt3lJTcfTbE2lMLreB4bpy8ZsIyPGnFhC7rFCoZF2ngoS870SBcbrCYG00mOQUmy7NG+MFFCTr2Bn0ETXCdf0SpNWEambqvIzAPZvGloFqge7AHCWC4tHg7Y8IBKjHGH5rAuQFSAOlCZjM9TpRltLFx5f82IrAfmPDcb5nbskewy9IlnHv53xf4W16hpwcRihlFdfZc0kVjjIGW+XfoJg3ESr54vavkCovJRfNMQeh86Jus3ZhPKs3+CDVBjSkeTy1jePcEkzB89kDwUAS4ffFxpOO/F+rBikuSwJj1EDO6Gv2ODqkTl+Oxj9G7xUcTXBLH91o1RUSSPiXvhctu06QS/Noon6QmLJGK1wdjOPZiybsYhuO/Zwu8XUVGA+U02c8j21NnDhVvi6LBx4B4ndWy0u8ujS/m/7JJ9kb/A3E6sF9PQVQ9GcTY5BrpSHBrsGg0c7RIZfx/qUn32kcp1y+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(921020)(11063799006)(56012099006)(261102130727099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RnZGZWQY+Sg3TJgFS+zUXXmJedLczfksqH0AuNRGKz6lyxfiF7BIAzIaDZrh?=
 =?us-ascii?Q?lCWQUCjkyzn7b79aCFg2WWszWKE6SDNaGgypBayjjSxHaKW02if1LJksJnwE?=
 =?us-ascii?Q?RC3Z7CM5sU1GTPY0xu6DUzgCT35FQ72WQ/kQ5OA8+Fhrls0bF4y7CRU+JmRR?=
 =?us-ascii?Q?xZN7/3JeB3mSIaQvaC3+K4B14h50PIUwFNL75pmsfF0CkUzDH1E0gqeX7/F2?=
 =?us-ascii?Q?ND8Npo9YdXa8RU14F9T2A31p2SWiFO0uBTcuSXdUgbZubUYy4Kvjg7TfU6sm?=
 =?us-ascii?Q?TXcrzwuGAg8fqkukSuwo4BpGr2Bqrp+K/vSSEcYOEH3JHCzzK6OBQKbYQSbJ?=
 =?us-ascii?Q?lLWTcKOm5D+pvxWAhJ1/vxFS+Xv/on+fjj/fWzENfFUSItt28xjzlHYVn+Fe?=
 =?us-ascii?Q?1Dwnm2JSlZT/KlIBEisqXJyq8Gd5FdNX1isVsw19C7tfdjPr29RBbuFTrTFY?=
 =?us-ascii?Q?62K/FYTCAdCOTs4V5WqZQW3Edodd3pyftdoCYqIBMmN33ujJxVaDpB3LjPnu?=
 =?us-ascii?Q?mIhDOi6wZmd3eWAA6uhgYkZ+vqv0bI6YJxfu25i54WXWLaby4q0gZtHawMcm?=
 =?us-ascii?Q?CAldt8SEmEUSZFdhx05sAg4cAoN1h+xLpSsfgJNgEqgEwtLHt1LxKcSu/n9u?=
 =?us-ascii?Q?Zw5b6tytExPSnDjMv4LLn1vD1qBM33dda5/4s4eujTyhVOJcGl9d337wNiiC?=
 =?us-ascii?Q?ue/qsEuO23Bg6718DIU6ZN7g1Z5629HyB8OcFCd7I6hqWSsn3xUq4gOV/HMm?=
 =?us-ascii?Q?1YkBEScmSjVLzKYH2/BQlC1ex64B5n58Z47FGFYksUkSdu/D9Kbw3IDDRij9?=
 =?us-ascii?Q?YYixXXkjzi78DBuFLAhZrAnLDDABV4cCdnWqEzRlT1EU7v03//+nKxqwQeM4?=
 =?us-ascii?Q?RljFJhZzIea0dx/Wt4vUrjxTvfqnbm0GG/0tR5nuYkHL8CMDdT1LEU6Tg+1Y?=
 =?us-ascii?Q?PBsJ1TPWkJ8Z4jN1Is7+SXRolWdGQoHmy4++KeNzh+V8wiy84uptH/tRGbh5?=
 =?us-ascii?Q?4AicPcRV1842kpTcDR/aEx9pZexF0jf2tZd51ygPmakkLox62qReWm1cktx2?=
 =?us-ascii?Q?ymxUVuRkBXf6xDMMNGNulhMaRAaSc9srnyyxCp+aoVIDLItLPXrdlQ1jSn0Q?=
 =?us-ascii?Q?7yviWvGWV0971cj03KWa5sKQ/NTloXNjnhDwNf/s1FXP3WI91zfwDn/ju1eI?=
 =?us-ascii?Q?fNlJPe0Dr8BJK7pV6Jotj6vrVgGQuYl/J3WnKixr9kFfcb8z1RHroBDcWip5?=
 =?us-ascii?Q?/cRJojq0tTIWzZ7nrtbfTKvxre4YswB0e9zYHivaBOLzGj3vaRT7xpnoDwKp?=
 =?us-ascii?Q?p4+vIGsm05e4HeoFwNqkUYrRJnAg4/EqB41KdpvwkjVmXEarOSFYDvZz5mlX?=
 =?us-ascii?Q?5Uwh5uV3fSxVkOuO86e3/hXRsw4AsJLn+eY1kS1/mrvkza9ZAoMa+Zs9iQtl?=
 =?us-ascii?Q?POPOBWQBU1/CrlQRAEBM/gI2D++qjVveUmfGvPrlkG5L51wyJJmPv769H06e?=
 =?us-ascii?Q?jT/LUb9X285fmkEFlvKS7InEXDQM3ClzLJbBGKMsABWaZwoMfLDXtE/m0SKR?=
 =?us-ascii?Q?73JdbWBa9XaqH+Q7XnRG/Gux3o76tnCEATBsfxN8uB8nAMpg/tXSJgBSF/zV?=
 =?us-ascii?Q?eDPQ39i5VAr1nVVtTG0uPTUuK1RuOT4Q7XlHwky7sMRlGNIcw66YkDLd8Pdf?=
 =?us-ascii?Q?tgkFQAlh1C5xeMwPQM2GqJt+I2QnZvmFMuUQw0L5aXKY24UldTDOM4b188cM?=
 =?us-ascii?Q?I3LUnAhEdWvXvPSAOSwP6TeJ8z21+Ft2Y6L0dHOatiVV9xndwKmH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb6c6fd-8ad2-4150-8e59-08df45e9556b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 03:00:57.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4moESGgnaJ7z3Nrb4DHwR3I/oQPwhQyySrMtTgb/U7BuLTRyli2fIzO4VtZ9vwWrJADKHls/TbdHEQP5gDPJiSltZFRm58ux5JsNyg6k+gn7B1wyLPbkPNNJy6JtqH1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11880
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

The NETC Switch does not have its own time registers and must obtain
the current PTP time from the NETC Timer bound to it. As they are
separate PCIe functions with independent drivers, add
netc_timer_get_current_time() to the Timer driver and export it so the
Switch driver can call it. There is only one switch in the NETC IP,
and it is the sole caller of this function. ENETC driver will not
use this function as it has its own time registers.

The Timer may be unbound while the Switch is calling this function,
which would free priv and unmap the MMIO region under an in-flight
read. To keep priv valid for the whole read, track each probed Timer
in a module-private list keyed by its pci_dev, and protect the lookup
and the register read with a global spinlock. A list hit proves the
pci_dev is bound to this driver, so priv is valid. remove() deletes
the entry under the same lock before tearing the device down, so no
read can observe a stale priv.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c          | 63 ++++++++++++++++++++++++++++++++-
 include/linux/fsl/netc_global.h | 10 ++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 87cfea180e859..370f7ad43a0a8 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * NXP NETC V4 Timer driver
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <linux/bitfield.h>
@@ -123,8 +123,12 @@ struct netc_timer {
 	u8 fs_alarm_num;
 	u8 fs_alarm_bitmap;
 	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
+	struct list_head node;
 };
 
+static LIST_HEAD(netc_timer_list);
+static DEFINE_SPINLOCK(netc_timer_list_lock);
+
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
 #define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
 
@@ -985,6 +989,10 @@ static int netc_timer_probe(struct pci_dev *pdev,
 
 	enable_irq(priv->irq);
 
+	spin_lock_bh(&netc_timer_list_lock);
+	list_add(&priv->node, &netc_timer_list);
+	spin_unlock_bh(&netc_timer_list_lock);
+
 	return 0;
 
 free_msix_irq:
@@ -999,6 +1007,10 @@ static void netc_timer_remove(struct pci_dev *pdev)
 {
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
+	spin_lock_bh(&netc_timer_list_lock);
+	list_del(&priv->node);
+	spin_unlock_bh(&netc_timer_list_lock);
+
 	disable_irq(priv->irq);
 	ptp_clock_unregister(priv->clock);
 	netc_timer_wr(priv, NETC_TMR_TEMASK, 0);
@@ -1021,5 +1033,54 @@ static struct pci_driver netc_timer_driver = {
 };
 module_pci_driver(netc_timer_driver);
 
+/**
+ * netc_timer_get_current_time - read the current PTP time from the NETC Timer
+ * @pdev: PCI device of the NETC Timer
+ * @ns: Output, the current PTP clock time in nanoseconds
+ *
+ * Read TMR_CUR_TIME from the NETC Timer bound to @pdev. The lookup and read
+ * run under netc_timer_list_lock, so the Timer cannot be unbound and its priv
+ * freed during the read. The caller must hold a reference on @pdev.
+ *
+ * Context: Process or softirq context. Must not be called from hardirq.
+ *
+ * Return: 0 on success, -ENODEV if the Timer is not present (not yet probed
+ *         or already removed).
+ */
+int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns)
+{
+	struct netc_timer *priv = NULL;
+	struct netc_timer *tmp;
+	unsigned long flags;
+	int err = 0;
+
+	/* Serialize against driver unbind, so holding it here ensures that
+	 * priv remains valid for the entire duration of the register read.
+	 */
+	spin_lock_bh(&netc_timer_list_lock);
+
+	list_for_each_entry(tmp, &netc_timer_list, node) {
+		if (tmp->pdev == pdev) {
+			priv = tmp;
+			break;
+		}
+	}
+
+	if (!priv) {
+		err = -ENODEV;
+		goto netc_timer_list_unlock;
+	}
+
+	spin_lock_irqsave(&priv->lock, flags);
+	*ns = netc_timer_cur_time_read(priv);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+netc_timer_list_unlock:
+	spin_unlock_bh(&netc_timer_list_lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(netc_timer_get_current_time);
+
 MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
index 5b8ff528d3699..d4a26c17f99a4 100644
--- a/include/linux/fsl/netc_global.h
+++ b/include/linux/fsl/netc_global.h
@@ -6,6 +6,7 @@
 
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/pci.h>
 
 static inline u32 netc_read(void __iomem *reg)
 {
@@ -22,4 +23,13 @@ static inline u64 netc_read64(void __iomem *reg)
 	return ioread64(reg);
 }
 
+#if IS_REACHABLE(CONFIG_PTP_NETC_V4_TIMER)
+int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns);
+#else
+static inline int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif
-- 
2.34.1


