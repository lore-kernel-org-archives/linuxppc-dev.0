Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62024606A32D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 06:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nGRWTQPY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPYP91pqBz30Vv;
	Wed, 11 Nov 2026 17:23:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794378205;
	cv=pass; b=OC8LaivmkDj0vufiO8j5xdHSAFBKV0rFUKe5E3RA32zbqN/oJ2r2gFEmkwhgf4ks/cZZ2n9fbTi2+3xeSSTGSQQoxKgTlJARcPe/ILRi2cXJGehBDrrAz4NRAzW9iYeeQGqhCRGyBFOtjFOJtmh0emUA8dS9HUuXfZJYzV82TDaSCySfS19UfIxe7iszm75W10yQ+Av2dh4Wm6+GZ44LpWk4UI1XhRfk5ceUvDQP0p6hYhaTLCqVNL+rBPlt5Tbaz4bNh253Sc1QDFp7/D0t4SLzd23FNDS7czi2NsYndmqDHeRRQ2zehF4WinztaOYuMza+Ilh43l6sAnRZYfTDPg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794378205; c=relaxed/relaxed;
	bh=H+s8BkOyNSHuRie2fC01Wy19tDVhaca9HVahGR1s/5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBRaDjx3k7JFUjG5pC7/qWROvrbLko0ztnYevlKbN/OxlUHqaJt05Cu01njAYqe+u9CZaT9GAil2QGCbxf/e4x/aMrjQOlXmgggt4HlwbGpenlsN/NwkYtKEiYtV8X540EMtKlUmg4knmYOmAXfoWj/L29m1He8zaeNgXKkBRBwLy5HFgfwNvs7kxQQ+UwJIkOapJATwKT1EB2KTfMyg8Br42iYS0/qBpz8BfWQr3U+s8OFxddBWSqvJLtjwKeTfVrWmGCkFJIFKPjlR96CHikMh7QG6tX8QsZhfBObmbsPqnmDOJWrs/B94V1HCUeOOWkweIARmu1NkRtoEZ84rAA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nGRWTQPY; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nGRWTQPY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPYP83lYjz30C6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 17:23:24 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWx2h4wYVu3B8El4fTijH9IpfYMDag12akANmy2E2JnTMi2YmroJ7e9v/O3fpicYD04z8axj7kHwFIdZt89zqxWwhOwa7Rf19SKvKedAAurett/G16f0CltUWxlsubKMiQ0B7nc5y1tVUFyVSOBfvsc5tIlpfeqc71gFKf6yOU4z9e6tlRC7vZ3uchTwmd9jr6rBxQ+KVM+404tA3BU50VYP7liJgKWjq7xQCRZwA2N13hr3GX+J+/7wLRw+1OHr47aDz1jZXPId4DVrBeeKM2B84nNei8wa9eSTAN7Zgdt4cveEWXBcIxsTwMjaH8qj9NLvYXPlVR+/DA5DBIg0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+s8BkOyNSHuRie2fC01Wy19tDVhaca9HVahGR1s/5k=;
 b=ITdU7mM09LgMqhx4nO0Ay85t4AkZmoADNHuL5W6z//MvNBwxOdSeYb6olkmEhE0k652Tl80bpKJdh0LXoWuaW0iAVlviot646HxWfkWGJaGVrL/eMKzVcvVJBRrFaPzBY8GJCPi585JV/g4yLpgU1qJO+I4IcLZXSPWHkKtvS4rpLCNhhOfvA9hnzaGTFQ8IgFgKFRCzQRuIcXbktr3bHVougtyLgS2ICb4a5ID8/ORLSRRIF3N/49XCigJoJf70pCuQIE+gSAzLCPXpgd8Z16Q2quQcs4TmQrEQh0ieWwJzkqO9mpXuNHAmK6Zy3VGVDdhg7PsFnEDnFVOOFp8C4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+s8BkOyNSHuRie2fC01Wy19tDVhaca9HVahGR1s/5k=;
 b=nGRWTQPYBG+YC3YBp3bngVo+Wo++kQ9C5d2QW26ZRqVK6eqROG/YYtPr0FKTE1AMUOBC0XMtkGMiN4VpQD0j6+ioIzHHMqCXzrYvIVsqp6Rdz77k+8p2urpAHO6hu5pPbyXt/1Gcj1GQsmM15mdkcg4H9GKT9AYtAFkkKGIj/DaWLmMAx78x/EqW9HE2u1gJ/hWCbSguHMUhN8yRAoEiBOV595gFNWq9qv0B31CpKEmreHEwUrIRE99jUKigvgsJPCNe22yMBJwkuAORraow+2cuIo73fdfr2lihoKSXY6Z7gVZPfribdfoDRnGEkdwbnNHBs1aVoelJWB97f0OGTA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:23:13 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:23:13 +0000
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
Subject: [PATCH v7 net-next 2/9] ptp: netc: remove unnecessary pcie_flr() call in probe
Date: Wed, 11 Nov 2026 14:27:46 +0800
Message-Id: <20261111062753.1397582-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
References: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI0PR04MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: e7455019-fd19-42b6-dccb-08df3fbc4391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|921020|11063799006|261026140227099003|261021123027099003|261022105027099003|261028144727099003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	V5XEkgX+nQMIAxqqlOjz4klgnTvouI7yPmKkX+z0YqHGFiY8T2cBOsxC0XTwUjLedW5p8Pe6yZlGtXvdXZqrv+75f4xfYYHCJlHA88xxjxr3joU+lZHmuJcaBa8e5WPnB6EbCsG0AAXE6KpYay5BLzpmYoNdz4KK521b666AlOox5aaSvJ6i4OIXam7RgXs+uNsYxCSm1GHNcKH+seqdgymR4W3vTCAOIB0EM7SsUCmsT+ld9fzC6R4PP4XAgkYvBBAD5KKfKGz4uhP5HaUmJ5CG9DEo7yTCLGgjXzGxicsw6nwuFi7RTe8tfSrHDEOApZwNxtlIJjJROxF+8n0MvZAV0emxnGGJ+mMs2CXpZWKRJuikq49Ld7mS3l8yPXt3cAmJ5O2bUHfk+bFVFr9nJLoIMKWj/7fjA9ebhZuLQpplnf2mtTMg9MLqOBOOLZ0cuaL9b5AoBFy3tvFRNvmEsl0ZrZVJ8hJhu6YP86gQYsiJDwbvPkkDacSkKQ9SmQ/nxxUjHL8ZscsSY/x7uowgk6wF3nWkHKNIo148QKf4zyZbxN2ZhAGi6GtKEYl0aJbrqNRH7SXsFjsF3RM5aePlnSqDZ0ThtsZ+kGM4gvfQxzwXsdINnLEfw52xqLFPaZQ4HFNBUCzXyGMXW7twnNJHs/PbJ2WsEmQ06g4VZwcYPfzEzuYYaKpMaqQjaROmTMKshW4Tc6509Rd25uRLriBvuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(11063799006)(261026140227099003)(261021123027099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yv5bprZygjOYUhRW+7oCFkJ5AxtJUHiSZCVMjZTS2hbQV5GDzQQCghA1UCbS?=
 =?us-ascii?Q?Diz1kgVRYt/w5PtnHzYC2+/LSLQGMeDgVboS+rz3EUZtsgqlYBs2f8xPjIEV?=
 =?us-ascii?Q?T5wkNZ0IIHjhWJonNYOFyERWeBwSBsqzcj7iTs8JVEiFAmjRYswF6F0HfMZt?=
 =?us-ascii?Q?Bb0ckJ15G1POEveKv1BrLp7d1p+NIVShH0cbM17E0NQkWZyfPzaF9rXYJNzB?=
 =?us-ascii?Q?4JLQ8C9Q2Sas0q360MUp/jlTbu/1MSIfGWcZWLeb/MuaZ0Z2qxzkigaXsMBq?=
 =?us-ascii?Q?4D6Lj45zRvvvNlI2n1Tt+hvqdH5hZv8vHMU4CGmWQcVoSbzlCUtkHNtlgWBg?=
 =?us-ascii?Q?c5EXxzdPPPzUqyFK5S+iNIkKD0KEw10o7FqhNCQMtX1NnTff7AzsYhKc06jP?=
 =?us-ascii?Q?345V+/+oTFfLMoDdUAMp3wLGCsDwLDnxSDEH3vrHHDWyQXyTwTruGyT3NKS/?=
 =?us-ascii?Q?tdq2XeWvBI2TkAPyGpOrzVp2Jv6z/kJgImvjzwBPxVt82u+NmaPlKJRZMgcs?=
 =?us-ascii?Q?hGizJ5hPb0O+dO1tjfnzrTAyO+NEfM7waJUp1xk1ivjj+Pni4xsHSxA4M6VS?=
 =?us-ascii?Q?LymmHj9RklpjiNuGNZJ92uG7Fl40vopAy6GCVhtPwi9FP4Hk0s8FMHzQQ5eC?=
 =?us-ascii?Q?0e5GSs5xCzO3k5xMPdqqmVK24kaYsHgYKzZjEiP6fbatydHMGlWzu8QOrgOY?=
 =?us-ascii?Q?mVjlo5nYjxnY1pqWvfaOw0MpdlqHv8ng+dgFnWtNO+unxcor3nXKM7uXxh7F?=
 =?us-ascii?Q?b44SK+TAOGMLT74MQJE/Tjb1niGHJTxzvMq5X++A4xyy9JMwHqSLY4oeqt0N?=
 =?us-ascii?Q?P9JUiwOGBezSHjc1rrRswmpGo/XJWlifJOPlvyGEaZ026D/wwGc+M2Ecc2ib?=
 =?us-ascii?Q?700lJ3lD/CLWLpe3VBh1fL7LID8EWvB+lF3BUvOGFaTsCWU+RgxnetuR8RUa?=
 =?us-ascii?Q?oPbMX7Ir3fKF6GJRO+0H8Mn/3PDAUkCv0Q1kUzuEyAaMfUnI4czC6R4Rcb5e?=
 =?us-ascii?Q?k9a5DOl1SsMFaOCYKT7lgnrzoNXDPhfZOTzh3+nupDIQ27NJCr4rmJq2QpBq?=
 =?us-ascii?Q?FdZGXFcm947j1mGcabwvwsWGt+PTV2H+k0xqI6WHcfMi57v/cx3ZNeD7QjyH?=
 =?us-ascii?Q?DAD62pPHa51QZD1rALgrifBjInJE4SRLbG+1yMS7c4bRKLt3BdnZGg40H20F?=
 =?us-ascii?Q?1H/XBAqmGhBxA5zwstU1/9imaKNjfycW9LoaZDDUHsenx+p1HVXolTfnDUvH?=
 =?us-ascii?Q?80n7IgDP/H8qA//9Hu0OPJBaZ6vTkwIOnWbjZ5MVmNt88AE9EtE1W3o/fJ11?=
 =?us-ascii?Q?grrgfYsGsjhZOcGQCQjI+1R52O0oBxodnfoZ2Ee5F0vgwfRpZeI9MWDU80fh?=
 =?us-ascii?Q?rh+Wsc+Rd+3LGpKpRnG+Nw9mSLOaXmk+m7oJST2e1102q/fopnzTYAZdITkG?=
 =?us-ascii?Q?WvmVE3ZVjh9tQEnhJS+RqocZoxTnGZgfAt9cpPoPV4ezTlhhQjxlE3WockHY?=
 =?us-ascii?Q?i+YrLfz2+Z3Hy1f9AtQMBYehGA2Hv/56Ia58xWLmmCXo8/bZrKnwYtgDTMGq?=
 =?us-ascii?Q?ztU0U2fqqfhsBEEtmZmbsO7hKjY4/mpJHesLKHRDNSMRO4BJaVPaqg8W8yZU?=
 =?us-ascii?Q?uchoAbRictM5GIlFLWn4zHQ43ljmmWUCL+57vA2NfCyvU4+cUF5K2Nn9mErB?=
 =?us-ascii?Q?NU+Mbf7gqBdLXrYu05iG1jyRC7yFirrapWuNnZjTAzEJDqKi2fuS5PT1TzuX?=
 =?us-ascii?Q?FW1kt27vf2hLiThc96QdG0yLXfKChmYgjz8jGJF8i0Ex+vipM/qM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7455019-fd19-42b6-dccb-08df3fbc4391
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:23:13.1084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbn1F/OGFfbHEIbBEuPS7k1Q5V6oe4cFjdT/hs7ppvTs0BFu1Zp/M4vA2grmrJ7N331wcD7voqysM9Qnw7tg2vCfZFKWFurHDnkqP9NqWetjChddwaz1a7ugj1YIINui
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

According to the NETC reference manual, function level reset is not
applicable to the timer as a supporting function. Remove the pcie_flr()
call from netc_timer_pci_probe() as it has no effect.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 376b3b0d1a38..aa9be8e2a630 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -777,7 +777,6 @@ static int netc_timer_pci_probe(struct pci_dev *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	pcie_flr(pdev);
 	err = pci_enable_device_mem(pdev);
 	if (err)
 		return dev_err_probe(dev, err, "Failed to enable device\n");
-- 
2.34.1


