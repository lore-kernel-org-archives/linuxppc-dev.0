Return-Path: <linuxppc-dev+bounces-24929-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320FFC531F9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 10:43:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8X9b5dl0z2yjN;
	Tue, 28 Jul 2026 20:42:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785235379;
	cv=pass; b=mhGYfYCF1YiCa2qdSUpCzpPuNuRPwWuZ0h1LytZfyEb4sI+Kk2wzo+O1UWJJSqGvb2ZbwKXbcUXc5mGCSdfk+XEuzHcC3xlONkOKNNqiXElYSLXUbgS0Rk97t//aswWz8u7PRw2ktahXSd2mOzGRR3Wfjn6BHyOuhJZGkx+P1pe7TV3Jl9oberC4JH/x8eamFII/330v45ClhZs6GpKePE5r1DHfo/2XurdhjkTqKnWvI+09/W6oWVn87dBXZGqFHkaRINqhnYJFF55Wn5muzxCd4Pl0Ja3+kT1+5TqR5zjNS8zDinYWGj72eajJZO+yNgOkQwnwlkl6Nr2WDjnNDQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785235379; c=relaxed/relaxed;
	bh=qzTEWsz6mTiJEpDFM7RYmrYxGYIR+itE5YjSuQo2gBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f5cE1Q7VukC2qQUhpOeP5IywFMOEvRzD8/VPzHgi3XlgvTidVnj5MByXO/jZyc9X91mkGiTbtXa75IzJZMyvXqL0cVTBC+jFKNn9m6u/fSMmRBspAciMndoA1Xln10CxvNXksDZYpnqsgBo+C9gpEEVbfRTdE8b8M9Hcq9J2WqgzSD7GX7bPWNoO1SQPBFe+Of4b5RZHTvZK5eSDNFBMVURdm7oQ3MMHuat5/wlqMouCeneyLp/AtJtHyBKHGw2f6QpghKv5qvH7KNk6Ekeb1uDi+00qZ9B518gLsYEF57e6kSyQD3uTMGSfgaMDdnvk+0qYcr0dpTa2Vp6VOIY3sg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=foaXXbeA; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=foaXXbeA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8X9b038pz2yjR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 20:42:58 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzYUMaDHBXuscAxfD8TUq88tl7aUA/6mLvcU3NxKo3xECXIWJy2CJf0HFx/uOlh7XRauBopjrZmBdwma9qiYpxf+M6wBHJNF/1Ae7t5kQtf2Lhdg678m+hiL/JfJHDk9cNP2sZIRJLdqVuV2cRFeZD3dKI0oUhYEqUwMnLd1cMB994kMkwFEs6xv/dO+Tb9VAxHy9aTjDGVDI0JEJ+fB/bKPB2fceFWv0+q6Rea1IziDn4MfGo4yoMFwDPEN8BuXCTwSj1KuARYVCXI5Dk8izhKEBAfr52Nzlc60fv8GEptZSwi5Qbflz7z/GUCjYqnCfV5STT3JKLMffrbuZpXIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzTEWsz6mTiJEpDFM7RYmrYxGYIR+itE5YjSuQo2gBE=;
 b=cSWGTwX47DEd2FRW7uWKh1O2CUpmqLJBT0le7oS5KD1SnsEiw43h+RiBbmVxh4lcZuf9JEFP5xU2UaU7VfPbRi3LqzdQPBkDNR9sRQvx+6jR9jaDDjdg+svuvIVHGIB5v+gRmPReFVioYLjP2KPQUvD09lC8eZ6JunG5Q1DZRUkpfaIGozWvcnz433aJgc3TfuwMOR+Ivcu6K6SOOwE6JIxH7Etijl4N+WZpC01yyqY7XbtSINtcagGydknpq7XYkfZRCIxy9eF+dilUFRngLZn3jjtNBiVDqX9dUTj2pC9ZoVxmihIcR8DaJiFzfgQQNiOQgS0sDgDrwU2BVoT0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzTEWsz6mTiJEpDFM7RYmrYxGYIR+itE5YjSuQo2gBE=;
 b=foaXXbeAu7naVJagJMW2x9Sc/uJI06RY5wQYwk+xTX6Li+SMGfE0Jh6b3FH3UUaULKxGi2/+NtyoiYPsBjbyki/BNuRfNWckbveFuZjgsWeLhmkeChvoYnivcMEgAXlH3VbmX74ODeUX4j98iqe1ChO7tLwCVAncllCFAAKwfwEBw+So9+32bI+ZqoJxGK628Xlj9Obvrm72yJT+19COBV8EvIdD7Xrfq7CuXzi5KMfbMIjNWurvVIjqWYPdKTPbhUbA+in7gBrZrOOZMww0/o7V3bSZ+moclut18YukOUfthqxUSMOkEa2fdry3HOUMfPf2Fn8u5H86zK5orR70Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV2PR04MB11835.eurprd04.prod.outlook.com (2603:10a6:150:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 10:42:27 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 10:42:27 +0000
From: wei.fang@oss.nxp.com
To: richardcochran@gmail.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: wei.fang@nxp.com,
	chleroy@kernel.org,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 4/7] net: dsa: netc: use entry ID instead of pointer to track host flood rule
Date: Tue, 28 Jul 2026 18:45:45 +0800
Message-Id: <20260728104548.3301214-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
References: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
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
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV2PR04MB11835:EE_
X-MS-Office365-Filtering-Correlation-Id: 9081860f-3d7e-43ac-a892-08deec94ead0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	uBHxEz/ymy4KcrPQDZALFTaVIMKOuEW+TwZr/PksVO328T2eFi/V5BNWOhlGUomY2wgHsNaL+2F88yRS8nf5O2i3ju56I5J9xKkjMm6dx88ksZOCiLDP3N8z+6POkKHrlaY3hKFYE8VYy/xBvDJlhSH/9zHswDBVXKJHSNDlgmeOjJtKGXV7iBe5O4Vg5BETsQQw3bJdq2jYxA2QhnrTliGUTSAeQdFlb7dZMr4u6OSPAVeMKF+gSrc1AMqWpLY5iwQeFR76XJRHNP5O3F0EyRMOrpkOgQ/DLenJSs0Mt4CZaFKJVZEoVwMXRkvZbhacNxEWq6T1GzQWibJkGRkSh+jcJKMAMSlBLog2qRH9ATUf4KDuoAwCx5nsbfskOaWZa9sl15vsqoYx0C43z1CxQqNThkJgOU5O0WK1W1Mh+uGmIn1dkdI2SfYUNLTGPecZvs6/dmHFWBFJyjGNj633y6A0nfp33cp+CmaOSL3ha/0v8Jhw8i11IQqwB1L3o8t3etdeTAtqTjP84+8gslKi29X6XsO/LXtsTYGH7965U3N/TsilfSvS1li6gCjjkWUs2vr1eh8l3ApmatDyYFpPJGE6Rvl+ncXeDBt8DPaR/9f0ChUvJjzh/WSa0FmUaCxB6D/8WlcXTjj15xk4UuidYb6+bD+3n080AbRxwrZdBBbONkXu7aDfs4IoZIQO01YTyE8Lo3H7X8g8x4ZyMrBGlw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?164bM/0srI6TWUtUCdzy2/2QnFfIS3utpx1581VIxOgtzoHq7dKFTxFyK55h?=
 =?us-ascii?Q?CW/0iRde5tI/BIMubnslxNQvCepxYVrE+6S3JOsGRLD6vm/C00SoZXkNkOZw?=
 =?us-ascii?Q?i7IvsRn8EgqWUsrOnpNnisfSRBgzbikX2DDff2YmynPJQacCRP61ONk1bK4e?=
 =?us-ascii?Q?lNfkDOi9XFu5ow43pMlTmGPWmzG2UFG8/BpVbOy3d2iEtRngTfCYc8MTvAZs?=
 =?us-ascii?Q?qda5m85MeKqjyWuIpf+jJrt1XuyVCaloU+umVvPizi0Vffa8Hh0+oohiJZ0/?=
 =?us-ascii?Q?5obzSwZghbDPj1dK33kxHuCsgHHfM0dIpxopkT1eipf8c6YTxWMiLuCoxmdR?=
 =?us-ascii?Q?1L/m19SX87VSvFcTCSClsB+bbAjLtfapIHf0Rs21rFC4YUW2XdWR+uMphC9v?=
 =?us-ascii?Q?thHBgXzv1kSmZnV1SVlPKTvPDTWcwXWrWH/vpsEVGiFZZZexpzJNR6iEwukX?=
 =?us-ascii?Q?kU9J3wMOc13gMrWQpjQa+Yf6DPlNljknaQNYewXndwgROFDBUWQpU9Lrpiu1?=
 =?us-ascii?Q?8YI9Kylb3T62YEefpcfpU7m0Gg5CpH4i7y9iJQew9+lSpEFDc71F4OHhrpSt?=
 =?us-ascii?Q?3peGXSgmD79tB6VeGN5HfZTW9Gg7HC0lb3ayrYoi0Nhx+Bt+ZOi4z4aySHFq?=
 =?us-ascii?Q?O8ASeckBBIriZvYmlFZean/bm3qeetwGZ350C3WcSulECovUQR21bGtZ67oq?=
 =?us-ascii?Q?eBUT4RVhsWcFie1T3VDP0x5q7Npq+e5V2CXyF5KFwaL/SCmHUHlm3ThCxOIh?=
 =?us-ascii?Q?8Njhwa+gXp9ThGJzryI55RPbI3AZSv5d2CvWb8iI4QOBALK8seCCSZi6MZY6?=
 =?us-ascii?Q?c3PNM7whImHTJUF/OmcM4SPkGwk2sn/t08jAph4HXoNoX+REJ4ML++o8FhkR?=
 =?us-ascii?Q?OL8Jc/9Vnt6Q0y0rFqgTxucPgAriRg/FNzHK8jKp54uLlyU20z4wkS5FjVXV?=
 =?us-ascii?Q?+7TdLNQNdrlLEpOhb/cDP/N+KjtapyV3o28ipcZcOQFzQdXMVgVkoEqbAy0J?=
 =?us-ascii?Q?sAc2534LFDDYTfD5Cy2L1pq8m4++uj+JMG36zFn+16CZN9PXmPxU4HYHkegp?=
 =?us-ascii?Q?9NdBtpVeEwTnsJLmXztu1WpNZPYZ2MK40d8XrU6Kxtb+dPypHB4JkisB9be1?=
 =?us-ascii?Q?W6z+BJxj53RpVZ7AgPE51SQPyMhyj2cpfniBTONfk7rUD4BaMBGudvYcMBen?=
 =?us-ascii?Q?HkoPHMkW58472lbuAzTczmJk8ibL5IEJQ9iuWsQNPQfRgnEmLEDgXQKQUbpA?=
 =?us-ascii?Q?8Dw7Z+iItNmPCdNrQCd0L8Y/k9woPHSW/M6i2wq2TVlYmJS0KF3Kx93Ny4KC?=
 =?us-ascii?Q?JL36uJJwjAhxJfc1iv15IjVJr72gblIXBLdvb9M1Hyt9IrfUZHkI4p5Lwp/x?=
 =?us-ascii?Q?hQoCGcR4nu2nJYKS8eqWRqdEmT+x+WIE80vAzD2AbCANp6l2U/Ld+cpTi3CH?=
 =?us-ascii?Q?ZDKWgnYcD97Ifskj56mXr+rY9C0zOArMha2wirmFIQ8EMHzFOn6N/iVv2eSU?=
 =?us-ascii?Q?aM3QDFAueWHQULOIsFj1liNaQTO0/BEemWVwUZk2VEv08QvWRT/pw8laLcsf?=
 =?us-ascii?Q?EEW85/VgQWww/rNXbU1ADgR6JWzUw8LbkwU+4O6owRR4CJkKO9lEDBWUupQA?=
 =?us-ascii?Q?V3AvG6vK3q2xTA26vuvT+92j764XkSTjliiqQl/fNRggWI/xotGcjBnSB91H?=
 =?us-ascii?Q?NdgzGFqo0M0k9c58UFs6OldbbdNJqIVynVRTO173KEsd6IbcoIHA0489Mx7F?=
 =?us-ascii?Q?u3v5SRnX4SdNCumjwapKz/MZ7ENGqPzM7fU9zyu5AtyrEDLCMdKK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9081860f-3d7e-43ac-a892-08deec94ead0
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:42:27.4712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/V8JfhsFMYbVLcbZYia5+UTn4VTRkKMeq/8QNzij7BAYUGi6zXoMuTb05yQ0NzaPNKsGv2kIW4gnwwwi9mwxdx9D58PYdU3na1YfLclHABHUqaCoAtPLnPG03WbDJoi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11835

From: Wei Fang <wei.fang@nxp.com>

Replace the struct ipft_entry_data pointer in struct netc_port with a
plain u32 entry ID (ipft_hf_eid), using NTMP_NULL_ENTRY_ID as the
sentinel value. The ipft_entry_data allocation is now freed immediately
inside netc_port_add_host_flood_rule() after the hardware entry is
committed, so no heap memory survives beyond that function. As a result,
netc_free_host_flood_rules() is no longer needed and can be removed.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 63 ++++++++++++------------------
 drivers/net/dsa/netc/netc_switch.h |  2 +-
 2 files changed, 25 insertions(+), 40 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 77077352c1a5..d326a00104e1 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -286,6 +286,12 @@ static int netc_init_all_ports(struct netc_switch *priv)
 				dev_err(dev, "Failed to create MDIO bus\n");
 				return err;
 			}
+
+			/* The ipft_hf_eid is initialized to an invalid entry
+			 * ID because the host flood rule (IPFT entry) has not
+			 * been created.
+			 */
+			np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
 		}
 	}
 
@@ -938,30 +944,12 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
 	mutex_destroy(&priv->vft_lock);
 }
 
-static void netc_free_host_flood_rules(struct netc_switch *priv)
-{
-	struct dsa_port *dp;
-
-	dsa_switch_for_each_user_port(dp, priv->ds) {
-		struct netc_port *np = priv->ports[dp->index];
-
-		/* No need to clear the hardware IPFT entry. Because PCIe
-		 * FLR will be performed when the switch is re-registered,
-		 * it will reset hardware state. So only need to free the
-		 * memory to avoid memory leak.
-		 */
-		kfree(np->host_flood);
-		np->host_flood = NULL;
-	}
-}
-
 static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
 
 	disable_delayed_work_sync(&priv->fdbt_ageing_work);
 	netc_destroy_all_lists(priv);
-	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
 }
 
@@ -1759,37 +1747,36 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	cfge->cfg = cpu_to_le32(cfg);
 
 	err = ntmp_ipft_add_entry(&priv->ntmp, host_flood);
-	if (err) {
-		kfree(host_flood);
-		return err;
-	}
+	if (err)
+		goto free_host_flood;
 
 	np->uc = uc;
 	np->mc = mc;
-	np->host_flood = host_flood;
+	np->ipft_hf_eid = host_flood->entry_id;
 	/* Enable ingress port filter table lookup */
 	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
 
-	return 0;
+free_host_flood:
+	kfree(host_flood);
+
+	return err;
 }
 
-static void netc_port_remove_host_flood(struct netc_port *np,
-					struct ipft_entry_data *host_flood)
+static void netc_port_remove_host_flood(struct netc_port *np, u32 entry_id)
 {
 	struct netc_switch *priv = np->switch_priv;
 	bool disable_host_flood = false;
 
-	if (!host_flood)
+	if (entry_id == NTMP_NULL_ENTRY_ID)
 		return;
 
-	if (np->host_flood == host_flood)
+	if (np->ipft_hf_eid == entry_id)
 		disable_host_flood = true;
 
-	ntmp_ipft_delete_entry(&priv->ntmp, host_flood->entry_id);
-	kfree(host_flood);
+	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
 
 	if (disable_host_flood) {
-		np->host_flood = NULL;
+		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
 		np->uc = false;
 		np->mc = false;
 		netc_port_wr(np, NETC_PIPFCR, 0);
@@ -1800,7 +1787,7 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 				     bool uc, bool mc)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
-	struct ipft_entry_data *old_host_flood;
+	u32 old_entry_id;
 
 	/* Do not add host flood rule to ingress port filter table when
 	 * the port has joined a bridge. Otherwise, the ingress frames
@@ -1808,7 +1795,7 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	 * will be redirected directly to the CPU port.
 	 */
 	if (dsa_port_bridge_dev_get(np->dp)) {
-		netc_port_remove_host_flood(np, np->host_flood);
+		netc_port_remove_host_flood(np, np->ipft_hf_eid);
 
 		return;
 	}
@@ -1818,20 +1805,18 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 
 	/* IPFT does not support in-place updates to the KEYE element,
 	 * we need to add a new entry and then delete the old one. So
-	 * save the old entry first.
+	 * save the old entry ID first.
 	 */
-	old_host_flood = np->host_flood;
-	np->host_flood = NULL;
+	old_entry_id = np->ipft_hf_eid;
 
 	if (netc_port_add_host_flood_rule(np, uc, mc)) {
-		np->host_flood = old_host_flood;
 		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
 			port);
 		return;
 	}
 
 	/* Remove the old host flood entry */
-	netc_port_remove_host_flood(np, old_host_flood);
+	netc_port_remove_host_flood(np, old_entry_id);
 }
 
 static int netc_single_vlan_aware_bridge(struct dsa_switch *ds,
@@ -2020,7 +2005,7 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, vlan_unaware_pvid);
 
 out:
-	netc_port_remove_host_flood(np, np->host_flood);
+	netc_port_remove_host_flood(np, np->ipft_hf_eid);
 
 	if (atomic_inc_return(&priv->br_cnt) == 1)
 		schedule_delayed_work(&priv->fdbt_ageing_work,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 305f2a92e2f9..fd36ec2d0e90 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -84,7 +84,7 @@ struct netc_port {
 	u16 uc:1;
 	u16 mc:1;
 	u16 pvid;
-	struct ipft_entry_data *host_flood;
+	u32 ipft_hf_eid;
 };
 
 struct netc_switch_regs {
-- 
2.34.1


