Return-Path: <linuxppc-dev+bounces-20809-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912FACD37AC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:04:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdZg0S10z2ykc;
	Wed, 13 May 2026 13:03:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641419;
	cv=pass; b=OIpiBiPgD7MLcR0C5fzw1FpoSfKElGxspCrOKe3bZ1ToB3D3nRb8wiRESJGkpquRC/2SFj6+0pnmdVoVX97wD1YJ22ffKpZV9B1GkMHmROOP0rnxJKr2VLK5F/awy3Cxef+kO/6+HPO00Z/ll+LpcJGjvevUCzGjY+isxLyXLgLDBb5lb7UCMqvlaFf0DGNTkRXn1YRgSTkuBig8VGMxJnQFyge7jI3FOUMVFVZ4P2BU+dFg2eP0m2YThQn6CGi0PSLcMbPYGTCXpFq0dOR4vvUoK6eZq+03R5PvO0Fv+DJwPhIyWgfQLspP2iIO3iNgIFOs+O+fc0ZxuguY6QLndg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641419; c=relaxed/relaxed;
	bh=irsH3/6S1dvhTXA2nLyw4lOUkP4Nt4gsfXtfZVu/MO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kWU80KxXtJU8muOwVQh65wzB1ANeHL98jyNR2/ZVhkm6dhPIddF0O0mGLlGhxsGqnFEdAeTZUc+D3l8GVbl3Aj4kDbQGn6tVJCX0LUKE487PgVaY1JkypfPJR0PZjGqAZgG50bWAgNb+RA6AKkiLfP8a2uN5fQgPmB6Q6XuaQC3rs8diO1LSJ7Tjp9qt7wE0BLpvaOIl4Kpl3nL7n+ejK8tm8PjAySbDLuVA0CEZAicGGToxgOejoJXhLD2Ollu70jJAWTb2/EUGmW4LmJtwj7XiB7+Bvl2QNP6DNCqrjXHG3o5Sqb7tIOtz82mSNuWMqOlOeLoZR0q/zU4wBoCgOw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=azbUh0qe; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=azbUh0qe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdZf2NfYz2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:03:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFoZexlPDNbJbk9sjazDZVKTCIDn/1ntS4hDEsqkPDha9xEOzDdFMBthvZerGtf+xdPv+9hJhVJabo+FWQKoQczhZCwguUL1LkFwdBzNdUIvoV1j7HzrbYt2JpDIgy26gkwwYBNCoKusXGHJnFmICf70nhIZV/NBZwWeItZN86JZhKSPy6g9NKQox6t7r5dhDghiz4W+3uSsQ6xCwrG0hQ6p8WHXuMP2DohlgrSIViwUspdxAFt1FrVdwrXOCJwVEaFr9W0wlAz7+4BhMmgzcNAZ1on7TwXijsnwn2xoxgNy0UfCtxdsbOBMrF0/DHxcIrjlGYeL0hmicqRLaWqFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irsH3/6S1dvhTXA2nLyw4lOUkP4Nt4gsfXtfZVu/MO8=;
 b=ct3Fye5hNr2fomaPGHoBoXmMD5N0Kv6MCil82foBhYKZoTiVzuxPjESjegI4BX0T8Pz+V+r1O3KxQQnNf7CcfsJgQM06g3xc6FwFtOZTWT9lLgbyQMRuhfLj/IfWgBiy3oAKBDq/5o8FtuaZUFUyctuOhWBUNeHPvDwii7WNA42m+DzNJQJEmsu4yVQ0swEE9/Oz9FnHTskStMiKjSXcN7GtgDZi8wEvtfuWU7AEcCgpMamBpX/K1oq2278p1TY/SktDSlLSwy9jg2MJrMlLIgVKYTM2IiCuZ9yXLkdEkEkCaE+I9T2G3zMoscJfx18PBn2O4Kl7LjEsP37Pc37UBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irsH3/6S1dvhTXA2nLyw4lOUkP4Nt4gsfXtfZVu/MO8=;
 b=azbUh0qeIJK0GgeJZrxaiP/bIWeiez/GIUcnWUX3JDihlvovWhFX34TNzePJRczZNj2rA4r42y2bv0g0EKbr2zsPUhcBf2Q2lRwYKIcMweWuW8ArUyY0EglqIdh6e3SsqjSm8FNYHNrlofYEu5ug4I6/Or/Xlptmr66hTgZz47qV0velU4tOzB6SCPsmMm9zHczQgAY8WJtf5eZzyHFf2Eg7sM8sbEqBHfgFbFCiJjgJL/tCFvEcXq9RI2YEDpyw0lV2uUuElGzDRrbrWzNkLELGCJv6t0x7Nhyn5Eo0Ynp8/AgG39K2XoRLluscognEq01REVqUw3+HErOlN1L2Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:03:25 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:03:25 +0000
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
Subject: [PATCH v7 net-next 08/15] net: enetc: add multiple command BD rings support
Date: Wed, 13 May 2026 11:04:47 +0800
Message-Id: <20260513030454.1666570-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513030454.1666570-1-wei.fang@nxp.com>
References: <20260513030454.1666570-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GV1PR04MB11525:EE_
X-MS-Office365-Filtering-Correlation-Id: 42828b7a-6c92-45fa-a76e-08deb09c32ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|22082099003|11063799003|20052099010|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	mCsXO0Ko4VDrXf1+2Ob9/f3eWY5FpAUQQIC1NqcBUy3EgXI2uqyh2LH0P/xG8WxObGRX+rSAjMU9wvhxGijVoEI+t6Zx+Wl5xVcs2w6MZRVWAden2F2qAuM68epebar0cxcB7l0rGAM8mkBWzJfprcIFs6AEyORy+iGygVhkRU906O8kzeVahmxUoQmwcP7vFQq74O0bT4tI95Ih1C8sNnhQNJmql5Q3zXJV5wV31rQ/I57erZZGAUCh6k2Abj/unsCU6SCKK9O4Yt/ThTBZ3qfx8VFPHsEsS91hdcecULyLaUd+AntI0Z8RDtb3b314bUIKXcJ+oQZiQZmpWDX/EMT0pnYHxBCBfvrSUjpYTkIfYokLEHuoKqUvuLIlxt5RVyfnKaR9BO9P983B3+AXl+SJFyMtPdmH4CdRsPkGGPgGygz3yMlw6seUbqtdoEi3o3VAxdcsWRS8sV42F3tcY4W5DYgG+ckB56y36ieBBxIfOeThmowfvV8vj0znAKNVM4+kbMOQnuH+AsMBLUxf1SLAqYYyQEOVH7TaYZPnw9roCZ2wjVu+nKujaDdQAvkhXkp4pp2bhB7xTpxtJLYWdhZRY0SL++MB2PyMUd+61Ht3Y3j9by6Q4ehgJUtw2tZIr5vck6LVINDPs6r8/WVbmEw0GL1ykpo94Iv2XtmWAxivW1EC3ZtGwm2nHR1aJp8+Xt8q+sov7S5Od08YG18EcCUTWtLLEvgVUslEQxaYgZmK1s9zwSRsLDG2SVq0XBhvPKe82urKMqH3Nqe0MzlgeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(11063799003)(20052099010)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h8CWYIqRh5Po5Vsy9W/ICYvhsaKU6pR4aGjs5UngfX9htw5rNzzs3geLFX6h?=
 =?us-ascii?Q?FOHXIGDyk5WSKfbSRSZ9gxCQGoYewTeS0TA65VaEuWtopyQgqqoDoXwQpRAC?=
 =?us-ascii?Q?hj7cRGP/hnSmU5AZKly0gywGhNRk8LTHiTq1/Haev+3gsraCCK2XlhLqzqhX?=
 =?us-ascii?Q?v+1tgFUODiI56BMcQuaH1EB+ftVwbbZptEsmVWQx0tZohTyzSs1l1s95r1JC?=
 =?us-ascii?Q?CkNBXKsYsvY1kbWb8R6m6aB+GW78tXx4SYOmWucK8oc+VS0peWTf04KUTBaT?=
 =?us-ascii?Q?TroDLOsuqeOoMXOcAGZvQAEprGoiWZ+M0f38+U7JRCYufA2zez418gv7qxjG?=
 =?us-ascii?Q?GFMtQqVEfSbg/8dNgtZocVIdH+JAXbO287tcjRm5TyjPXMcsuGTrEPxiL8lI?=
 =?us-ascii?Q?Sorsg14YcRqEHn2D8twEuVVEZgTpWg35+VtR9nPB/fd4X/uDeIFoIOla5avo?=
 =?us-ascii?Q?5rSgvxmS8k05og7jq3jCV8H5q7pvzYv229YfgHdfXgAq/DRjFIH0GVwtGjg3?=
 =?us-ascii?Q?YJG0lT82rPEbanlJizB45yep3mCholdX15Gmn+GIwRpqbyC2rk2HZhTDxa0j?=
 =?us-ascii?Q?KjahCRNj2bciodbzHkv+b9Qe78BPbCBs/aJOX2s5Gwtpw8P+DC7K4M/VgXyd?=
 =?us-ascii?Q?ylMgcKIg7hpcsTsSyjssL3Cyzpvqkq5AO79aY2YCQyFTS8yi2/9Y+fKXvElo?=
 =?us-ascii?Q?mwUZnyDPYPZQjgTkNQ+SutG/K8hBVIiDkLtIIUz0ILIdiaxLA2fZWt75cQHM?=
 =?us-ascii?Q?/c9xBFVhOWJxg7DyJBKjsEGQKEvKnR/0GWUwe+aMU+if1ibbOgvEVH5qy784?=
 =?us-ascii?Q?cvhOcDRcJ3Kc2yB+ZtLIWaelLWJVZVH9MZyc7ExAoDW3ocrpp05wSRnbtO/l?=
 =?us-ascii?Q?betFEPdL0Fb9jnhwl9E4otXxFZuhirLZ7TN4HH5NB6fkedGvD/6hf4X2leOb?=
 =?us-ascii?Q?eESFyDyfL83wkzYe5kexfEeVKXCT5Q1xN60XT4PGDFeOvfitujJijQ79sXzw?=
 =?us-ascii?Q?59rTgBC3Gewo8RHCxy0IYr8AXEeo5koiFHyjvC6uUsDj3xYvlb8k/c9lHrsy?=
 =?us-ascii?Q?smYyrIOCcaECkb/0b1frxUZVzCDrU7W+lH7CRW2h7PdFBpXx8dS559tKiseI?=
 =?us-ascii?Q?vIlVpnkal0gZ6xeH/c8nUxDrd1DxP306CIp3IXWEkn5PWy+E4KtmGTeGtZrk?=
 =?us-ascii?Q?UAMtbbffRufDVkbqrn869StTrQtxcnOWhpv2S/GuHRjJKobOc5Zi4m24T1vn?=
 =?us-ascii?Q?KSFPeA8fg1UuWLfNNuOo1daDDNZ3IOuVxIqCY3kjU284kMv+7ocji1ipAhE+?=
 =?us-ascii?Q?p5nQsqx+ud85g7JYbAbdvphxFn+d/pdVKpADjttc6lDdBUmEoIDAqTPLGRYs?=
 =?us-ascii?Q?/mEtj1igG/yJUODv8FsvnTqKYmra0XRsTY1O3WKkxVPrTPPRfdI4ga6Wg/VL?=
 =?us-ascii?Q?E4c5k2V6qKpGj9JIfDNkuOEhj5t2lZTz2raPAFimEaPyqVvOY+iYyS3Q1DzQ?=
 =?us-ascii?Q?DI7JImMpaykMIxmmcKPHhytafAj8mcDxxlwYREkZibTHNbjTqYqhRUH0JAfl?=
 =?us-ascii?Q?IUQhfv+o1vnkyP3zztnyZ5iSS1yq1DJtxAs6rGBj0koQD9ErzON0pcS+Qjhx?=
 =?us-ascii?Q?JsvVgB9icZQDa7EPjzjKB5UqD2OCZwLh1ey4cZMh6dUY+PIgaZNBIxaM9GGf?=
 =?us-ascii?Q?yz1yX1iC+us3H6YBbh9UsMeWYrFd0+gjhroJNs4MHzWzD3+T?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42828b7a-6c92-45fa-a76e-08deb09c32ef
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:03:25.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+fADRHZIWYaY19YNmIl1xlJLU5eeAXpFAg9o7jQ7iDf/HVmVFM2NKHaNKfoDBgovxAmafGN+a/HvhmeV8U50w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525

All the tables of NETC switch are managed through the command BD ring,
but unlike ENETC, the switch has two command BD rings, if the current
ring is busy, the switch driver can switch to another ring to manage
the table. Currently, the NTMP driver does not support multiple rings.
Therefore, update ntmp_select_and_lock_cbdr() to select a appropriate
ring to execute the command for the switch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 635032d24dc7..f71cad943424 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -146,11 +146,16 @@ static void ntmp_clean_cbdr(struct netc_cbdr *cbdr)
 static void ntmp_select_and_lock_cbdr(struct ntmp_user *user,
 				      struct netc_cbdr **cbdr)
 {
-	/* Currently only ENETC is supported, and it has only one command
-	 * BD ring.
-	 */
-	*cbdr = &user->ring[0];
+	for (int i = 0; i < user->cbdr_num; i++) {
+		*cbdr = &user->ring[i];
+		if (mutex_trylock(&(*cbdr)->ring_lock))
+			return;
+	}
 
+	/* If all command BD rings are locked, we need to select one of
+	 * them and wait for it.
+	 */
+	*cbdr = &user->ring[raw_smp_processor_id() % user->cbdr_num];
 	mutex_lock(&(*cbdr)->ring_lock);
 }
 
-- 
2.34.1


