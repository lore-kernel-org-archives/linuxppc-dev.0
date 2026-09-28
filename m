Return-Path: <linuxppc-dev+bounces-28372-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E1EC98328
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 06:07:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htW7P4M1Cz30hq;
	Mon, 28 Sep 2026 16:07:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790575665;
	cv=pass; b=hEsjpXkmv0lOHsab8j3BnuFt1G697ebKAJUMA4UbxGjASCI5tG0cM29hRREEudByE3bkqSLv9wK9RoO4QyhGF+Q0robV5NFjAB7Ol0LkknuIR2LRuLo/oFDdgjUy/6FGceAOIgt+V4webwWkSrfLX3FVAajlDc9f3EZ6JNIlQGw7vHiGPw/4gG9R2FpWx9pik04MUIiadexk3pGnCAuD4DbUnpGDLEp9wiGMZlfm+T5GNq0ymyK5i7dhshGpI//dw67OnS1Cue9+e571HHwP9WPUnDfMx+OO4t9ZcPy87f2/G0npLW9TohZwaskvrvgHkuKTNMo0FapTe+4ahBC4iw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790575665; c=relaxed/relaxed;
	bh=Xqoslq9+UXKbgYbbpzruPuNUbkPeE6MWTCD6fTdZ6rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dhw5fT7yNt3+uGb85sy1VaZBVe/t6vVTtfcx7ebehxbkkmtoBPNSgOSgkabzUbuFe627Nj+pyXnUZIvk9oElug6y7FDaZNdfxfCkehCRMrs4285HozvSidiaDgpW5z519xyNdH42TeAwnSWmQ7U3BmUTeghP1xh6Xrh8GBKje9a5TKMKyGltXsfxIXCMtd7twm1+vZ/UcZiEaNAOre7000Eq5WTu6s52bYkblMWc088BLJFkZN61pKT4IZH7K0aknwrJEyA6YOVnmHj7V5L/66Hjjev5A3LA2p19yWYAQrRhm4YiRqnlXYbJ8keR2KJO24dvZeivHzcf9oCHoQXWug==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=V4JOK0kP; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=V4JOK0kP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htW7N570nz30dj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 16:07:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMolstFfMCt/vXEF+Kpj0YOT1yt9VLddGWpMf3tYCPAS4iS6/A5gdBUTG809TqH60S1FNdAJ6orR4ND+6uZ7iJQdk8pCs+ioL0swVMGGssJ7dEVShKZeZw1X3FwfBPRwMxvTrzMc/2uBv/7Je0UC7GU6d4rjP3Af+XXfv6XaZ4X6nDmntI+M1y5ZAiAOxeW9NhtJxFu8ne+XNwiaUkFEi5Zh5MRE4jZD912hk8KpHlcWH1p+/APd5lVw1+NmnnYc3l+2PFh/jGFW1sHALs+3RN5pPLBBSGpR4x+bhacoHBrCshJo/4S8sQ/KYauehEMDnP18rXQAwViRxngpZdVGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xqoslq9+UXKbgYbbpzruPuNUbkPeE6MWTCD6fTdZ6rk=;
 b=hcVW48XY4ucW8ZkUMRCX6iVthsqMXhx7zZ9ccSrJA2hWoGX3JU2Qiez78uBBiplN5hNi0G3YmPwTYKCUWdQZPJCL1Jgq9Ghg6SJIXzzelsCq4dDTyVnGlJ24f+0l7xLzMJxT1RYoiHynknJa1KXLdabUskFwYc8Ci9K5/YJbYHL49B0eUCaExLgGNDV9O5YnthjofMX8hHwgF6SVfKF6d6VhjOMi7T9qm/VVBfCLcgAppfTfuj5rZGPVqQxjVNc/AHxTvwouohMBByown6g5WIPHd2l56gvp+YqQ6abTALZ8nYcEoNjKz0K4WFndsmg7C2nc11mVJBU/AV128/Nngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xqoslq9+UXKbgYbbpzruPuNUbkPeE6MWTCD6fTdZ6rk=;
 b=V4JOK0kPGnkcE9qRo0pRR10ubjM9fUL1M843gfol32hOppCYFsvFQi+rVVGpH9qkMIj/TAFMKcurmSkN397cPbxv8kiVxn4B6GbsRhX3C0LdPfjV+RW+Og3SuQ9DjciakfhHB88VuqqoBco/7iw/CM6OPea9EmUnXNI0f8m+E7Kn3wMBwVbKCiGryM1pk8OmrsPKvEw47+DGrwVBvqVugmOeA2y33yH12FDSzeS+IJhxLG4ryAzyXJHuFfZ5sHSzww7g4cnPO3t4sgMexBytRwMKCgvBp+dEMygyuce0FPsduOKzHoHsUVKG9C/dJf4YdKSwQjO6T48Yu3ydlrk7Jw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by PA1PR04MB10721.eurprd04.prod.outlook.com (2603:10a6:102:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 06:07:34 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 06:07:34 +0000
From: shengjiu.wang@oss.nxp.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shawnguo@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 2/5] ASoC: dt-bindings: fsl,easrc: add ports binding for multiple conversion paths
Date: Mon, 28 Sep 2026 14:11:46 +0800
Message-Id: <20260928061149.1844121-3-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928061149.1844121-1-shengjiu.wang@oss.nxp.com>
References: <20260928061149.1844121-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0311.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::6) To PAXPR04MB9351.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::17)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|PA1PR04MB10721:EE_
X-MS-Office365-Filtering-Correlation-Id: ec504afa-d178-421a-5e1a-08df1d26c9fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|23010399003|921020|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IHvG/CYSLKRkB5g8v8WbdqexSCKJRW4Q0P/mg5CbGZ2eEMQAibMC2Ze0vFxmaJt4M0BbkG4ceiRa5MIGZ+mIIF+6rkZE0PFuFsaQBodo3G+Hfaj0VLBUYWkCyzS+YpOrVAgsliID+ym87K7XGSejDfcl1QEeRGTnJkhQAusnFT++zfQj3iuJK6MxjdsvL20+TJBi5kguCB0c8jUUAeYNKD87cAyQbglTxELCz6SINPHqxO5pqux+tvsKYGocDWeh/lYjadRXVsXlay/OO0voLKxOt+moPFGIck7woq4wLQp20hxaRHNK2BqwJ2fPJLt448YB5DQIYYxOnlKI4s2Qqn1lPp+iEo9NXH1ja5sYsA7e5uvxiCM1LxU87RYDwVUs0aNmfu0Qj4oftWVm1QoVVK5ri8iKJ+dNacJuKiXYAiEKi/3iRmeURxnPOKJ0k1ZEQ2cnY3QFZHtcTFLQy0K8O8Lbfy8CO7UO/V/uP48SfZjhlLAfRUlCXjVAS7W0Cx80/asqLKOOewPwW7ONx5F1Ob+AC72Y3vvWr81JRVte+rfc8xo8vUiOTvAOZwH3QFADwQRUUOuZ0ZmbVHBSGrgggsSIBpaB2Wj5Vhn1G5aMQ38kAm5rPUnQCurxfcexFLEQ+Y8oPjSdnMcu8P37NPbOxkJVuatHwYcFV2SU7SMNfrQCJ4EHAKkHEzBoRiPcWK9aoLlsLtWxmHu+D7NirAnTiQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(23010399003)(921020)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aAk5h+fBz6aO1p0L0MAu17SQMGZJfJmwKsrT4vyRI83AQvp4ZYY4jJaJRCm8?=
 =?us-ascii?Q?6OiqIYQuScKxJI44XmQwPDFDLiPHl28K1vaWvJL46B3MRHSi6OP49XakBCCD?=
 =?us-ascii?Q?mZ01XzLfaTj6wZSpznveJM/9XXevvf6/uhsHkx75W+ERe3bMX49H4jE+UZ4P?=
 =?us-ascii?Q?6XchjG8kWQItEfgCAteSBKfufYTtR9wHZdKnXRqJk8Q8joBBUI7p78TJbCXI?=
 =?us-ascii?Q?3KoisP1enApLTtLsrhsH4/xepy5i0mR8l0SFz7HtCzV7t8QMDp6IkDZgWyTu?=
 =?us-ascii?Q?h7cDmSaODLICTh8it6wJR23IBjABto7fzzn+ebHCdtx5uO0ZliRuY2qFS/QP?=
 =?us-ascii?Q?U0Bzd6XXITO1+AlHERop5Epnc6oLsTLjEnEpC8V3jhfHNE3SH5ja1L5ANhRk?=
 =?us-ascii?Q?6hMPFw9y4jIl0C/la6KKu4d3SdUSHTdureFTECS2YJOtHspiTt2xfGM2sE9R?=
 =?us-ascii?Q?O+g/6q0cpL0FvMDLxSQE43eppbZ+x2IgCS+Pkxqz7lLT+TWKptS3msfuewJs?=
 =?us-ascii?Q?n267V0m9imEAiG6XK1AwiJHt/BG959nqnU2HZNQRTzZyTw3bas9/KBnL1T4E?=
 =?us-ascii?Q?mW8wQMs1KNWL7fNsY53rcIciebMCg/kA8mY0mDk4w2naJ5B/iMJZkza9y8Up?=
 =?us-ascii?Q?ez9huAfANmVo4yyWLzsJIu1a4qAAs9cpRROapmbMta9WMR10IMFNg09h6/bB?=
 =?us-ascii?Q?Q9tpZBOl01j7liWQUTDjn7hIO+TPiBm+afPPXPc0m1IfJr0R6mPRDMtj7//q?=
 =?us-ascii?Q?2r95Ihidk24Av8GEpCcGP3N7PPD5k4/BCAhkybpE1ibgKDrytHh7iJUpJZ1x?=
 =?us-ascii?Q?LO2qlGTrvsa2AFtWWdvNH6JOx8+whesdpSD9bWUDDL9YUwURwdOZhbokyUDl?=
 =?us-ascii?Q?yVWdZ/Ez05lFalJmk4BBn6mF0yAnfUCDpy7Ie4BX26gCeFnp2LJKoDMr6Mqw?=
 =?us-ascii?Q?E5D9Tc4ZmeyWlZovbHNaD3rc3HoMO/DR+OyL+G2QaYgxogsOLqE70r00PT57?=
 =?us-ascii?Q?Wm2+No8gBomcbGph36iEgfNym9dL4gWNlF/iVtbpTiBo2BSNavKO0QFY312L?=
 =?us-ascii?Q?ejUusD6P6/PDbh2RLa5z6yNz1J1su2mSSg+1LopDUz6MKBdelkUEGVV260rn?=
 =?us-ascii?Q?hLvMMPuJnCZD1DvtygUcUeDYs4+3m60NZktJXjWibRnkmXsq6MIXn+GzO0xU?=
 =?us-ascii?Q?Xof1afTxqujID7/dROtSMKBEFMzBU9WFhbIncRmedwAcW8jKE/kpLwiAih7w?=
 =?us-ascii?Q?WgkZ5+oVdmWiYQ7RbDzULCZnksyotmENk6U7eITFsOD0XeEjZQMF7TFxe3iZ?=
 =?us-ascii?Q?N+DEdZUQs4GvA3So3SB+IzCPO6YDaGwLSclZyXEvUuUfrgPmS/gdxp9ovLub?=
 =?us-ascii?Q?TRL3Cx/oz6u51fa2LjtVGo0RvNYXAPX9nF5C9dXL4wYW+KyDFco27TzULFan?=
 =?us-ascii?Q?2oTJfNG+T064WEiFKMLWOtK7SsPz1GuAnyjQzT1PWeyMuCT+PuG9qLg8xMpo?=
 =?us-ascii?Q?JW6Lt4a5rGR9wtLhKPZfUIHVWfVhYG/xWICC4Aq3MjIzeGqBugh6xwZFdSEp?=
 =?us-ascii?Q?HhC+Ke4tyEeY51vTOAq8anKmCbyCBMxKOs+dKxP0qE0v9z9R1+Z0FbCxsNgi?=
 =?us-ascii?Q?LNCbigN3nS+fNRj0vR5xEHNcFvaEHph6uFYokINs/bceLvKpWwX7oOBBhtDq?=
 =?us-ascii?Q?YIef95a9cp7vKN3ZVxgR7vj+pBhRcXHtKgWXRoZ2ipcb9lPNMnXmhLK82Bsa?=
 =?us-ascii?Q?Ro7M+EQ5ggQ1tH4/KiWwUZFIEPPGWevK77SyORO5QjY6uc24eUn5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec504afa-d178-421a-5e1a-08df1d26c9fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 06:07:34.5755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLYts2FwqIgKcqGvH/Py3YcfNIyNOK+l8uppMVwAwiCEfVQUx3OxVV4qzTBU5Zzeu7XmmvGMx8Pv3UtrJgby7csLY32l4UJopblo2vvNZitz7fYOgp0M1/eLkCXHazFv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10721

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX EASRC hardware supports up to four conversion contexts
(A, B, C, D). Add a ports container property to the binding to allow
each independent conversion path to be represented as an individual
audio-graph port:

  port@0 -- conversion path 0
  port@1 -- conversion path 1
  port@2 -- conversion path 2
  port@3 -- conversion path 3

Each sub-port references audio-graph-port.yaml and follows the standard
audio-graph binding conventions. Contexts are allocated dynamically at
stream open time; each active stream direction (playback or capture) on
a port consumes one hardware context.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/sound/fsl,easrc.yaml  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
index d5727f8bfb0b..a53ec4f6f1c0 100644
--- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
@@ -55,6 +55,14 @@ properties:
       - const: imx/easrc/easrc-imx8mn.bin
     description: The coefficient table for the filters
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    patternProperties:
+      "^port@[0-3]$":
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: port for an independent conversion path
+
   fsl,asrc-rate:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 8000
@@ -106,4 +114,41 @@ examples:
         firmware-name = "imx/easrc/easrc-imx8mn.bin";
         fsl,asrc-rate = <8000>;
         fsl,asrc-format = <2>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                playback-only;
+                endpoint {
+                    remote-endpoint = <&fe00_ep>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                playback-only;
+                endpoint {
+                    remote-endpoint = <&fe01_ep>;
+                };
+            };
+
+            port@2 {
+                reg = <2>;
+                capture-only;
+                endpoint {
+                    remote-endpoint = <&fe02_ep>;
+                };
+            };
+
+            port@3 {
+                reg = <3>;
+                capture-only;
+                endpoint {
+                    remote-endpoint = <&fe03_ep>;
+                };
+            };
+        };
     };
-- 
2.34.1


