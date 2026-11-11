Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC060A260A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tBv9t1qh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPYPj2mZYz3bdq;
	Wed, 11 Nov 2026 17:23:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794378233;
	cv=pass; b=FWGjBtgkF4j8bMzMdk1KQmUuH2lr/At/RmEHLCrqjigEjQzfSAdrpXXLgIqpAzkR29h6l/qzNTXj7Vn+cLlH/I1CgVXtaUOQFLwEZ6e52T75PvfsqZdIuaEoU2oYNqx8hoyPFMJmkGly3XJ5F1fIIEyRlQs+Z+oCRYDX87uuk8vVY53ssfHwwOna6s9+fuMu1LHBTWKcyVguPFIERv5ofktyAp6A7UfRm5uOyauykkr2lMRO/xK1V0WSW7wwAd0E+GnGAnV4rLHGdD0tiJDPRnwc1SljbLI2srtfDKayj55I4DDXweAdl1wnelrAhLPUn28DIHtXmLS84CBqUUX5zg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794378233; c=relaxed/relaxed;
	bh=ZN5MyPo/7h+S+i545LlZliEyja99/UonJbhLJbHTjLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJLdGYEGuOgqt1AKDqEynuODBej6MMRVjSq8dYvEUlgceLeKuZtKI6HosyZTASt4ksDkUqwGRe+FMsS0/QPDL2j7tR50ww1JqA/VICU/Q5dYdb8lC2dkmOZKMKcvRbXTPLsJpr9uADiiNNXtlBHUIARWxsmpVJ484LxMLHFdq4l0Y/hcp7s7fdONiXxBHoy8rsrT5fjblJJWZtdFxQSn16BB60iM8FA0lJzz+BElGGJvMgiuLNF1O3C6TdLXJAej3Mp+AjL9BEu9ldfav1SQqMORwrpuEwTI8PcJauCzJ8VzCnSO8VxrYgmVL8hsU+t9KhVMETPG7RnAqnMPsQWo/g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tBv9t1qh; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tBv9t1qh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPYPh4sqLz3bcJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 17:23:52 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2oXu1mGcbPpJSQKXvjQsejGlrEfWuw9cVyAYwzHejhitzXT9Y6nqst5C6wI9USYNdl2KXLtMivpOuoRc6ITA5r1SKoDj41gZVIMqZXHOLbKM1lK9LMftxsFjJAIlRgmCWg1EvQ+K6DyE3IodCzY5CT8ydAl9wr8xbbHkRlJeyOwOXlRfWKiw+2Bnck4xxpxlam+VTXskQnx/UP3GKCusO6ePfK05AMjSxkJcDTipKZQl4fiSjrAHYvr3WGmNJppBbD7ENgJxYaGIlXaGObgV5QCIef3Lk6/7bfePJniJ/tjwZTp59oM31SGofp8LOE/VrwYes6LmnqsRw6tbVS2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZN5MyPo/7h+S+i545LlZliEyja99/UonJbhLJbHTjLw=;
 b=IlGP0npzuC+RFygdAalUqzTQ634UKT/ZFfH+WWPoKOuPmGEFAbTBoCR+qOWUNLOOPzrVCcIUOpp5K8No3WNaPwaB8PXsJgtI6Npg+OgOv15UmjE8NdmW43vqpxii68CCObnbXg6zj2YWQamFYaO3kbaT+NnvRxbDn0R2+efEOLb8/6pkCxvnOO+kHCbszF7PKgth3JtBjpjv/BcVzMrIilNqKxU2/i9b5HOAN9Zj46XCz3njcDx4C+hahm8UZXsSsRx+Tk0tJJj3Z+ALeMtZ65aX0SdBiJYQxavxYS75V//KGhiYxd7Dtc7CRq1xqMsRaYuoHGUCA+plFNqBHH/KyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN5MyPo/7h+S+i545LlZliEyja99/UonJbhLJbHTjLw=;
 b=tBv9t1qh3OpHg+o/GguFjwq90AdcmAPwyYp0WgmzyJqTc3ToGtS/OBz17xBJpPXPAO6YTkw/I5S40RuOs4p+xSjZ11fGr1CMKCMEJEBje1qTBoS64ZjimaECbIycUqhegCbS7/lRZ6dIJWK1c7niyvfTZUNFp08BVqojD6Q3B6LLfP0ayl9CUOfD4N23MPxSbmmosY1fti9aKUYPEeGpxco8bLTfyLu3pxGrTFgyGZvt1+6xZdHbkD7fpVH8Rnqz1jckXrw/M/+nsbMAA3hYEEO1ayx30z72L5DFY6a2rJWGfd+ddPgpILylo0rek+aH3HwwMUYISQrfwGpWN7AzcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:23:43 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:23:43 +0000
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
Subject: [PATCH v7 net-next 7/9] net: dsa: netc: enable ingress port filtering lookup by default
Date: Wed, 11 Nov 2026 14:27:51 +0800
Message-Id: <20261111062753.1397582-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
References: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 67dbb4b3-0c76-4626-3d01-08df3fbc55ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|921020|261026121527099003|11063799006|261026140227099003|261102123227099003|261021123027099003|261009223027099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003|56012099006|10067099003|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	+082SK7GwaK/KC9cF0AlzDBqOHdJefw1JQb6c0qpPA/trB8b9tzE7tLMPT6fFAOX2t7rWC0vB53cQs14zpXGeSmmQhtm6eDEokisHw4DKAlfUKniNSttl59SeIPFeznn+b4LtdFU+00zYYea7mA12a6vtNapqpNGIlA+vXzJ+Vs8LtC0I6F8ZEv7kUkx5nTZguoSkRPismwZSpLGWuTZW7pXGw857oA/RCs5dQ9PqwRtqLfVJ/TcYdVGsHB0rIJt8X6wI3txvwt2nAk0hf9lmDJ0QTLHWQ6krHPPI1TbsKLqiDPxoRTXgr8hqPWqTca3oAm7vpeWwYESNgXBq9I2Ubk2Hy3/sK64vxFpsDyxaXa2gxWIkq8jOSTXuKxwVlwfhPGkdhgTO6EANOPGFHjixUMJDoam/qB/nWK8REpvlyLdHsUD9JeY3qC5Jj6YIWkpjI32f4vybXZevvPX1bzjX40kXmVAmmaYmlIk6r9Dt6kOMUrmDK8KTB095qb4scsmvB+R4EQ74UqM/3S4QsrAL9fJRJ3v1GOyXlTBxPK+jayXL16mMu/VjD5LdpEX5yt+HYGTPQ3biHFrmb2ubfELuKzwSExFU/8OSfCtxC2kHYy8SGgDG1fggpxTSuksAr0oWYDPofpGpm9KauMrHGfVdQOFTqebqk3CgzxijfgWpCqQQiH1S3HpdG6AmVlTShrVeLtPHT+O2xTucvlgCSELYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(261026121527099003)(11063799006)(261026140227099003)(261102123227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hoHHlkrSPO8ethTVYKhsoMnr+opLyQdjDvlbNBBjzOFVycv4uqumuhT1Kl2B?=
 =?us-ascii?Q?ONQDp1stJb02zCUQxp/Wv/Dr9wX89P6ohZtR9TS7w3EW9aBk2odzu3U2B7sW?=
 =?us-ascii?Q?fYfbGhsMA//ikABbDh7s+ek1Nev7XYdwwQKlozrvVWKrPVoX8+wZ0r7nGCIL?=
 =?us-ascii?Q?xMl19oYeouEdCgtiU7a3+kGisJ3TZS/ktqkdZEXLzQq7K20C9TOPCmU8OcHa?=
 =?us-ascii?Q?azIP/hTNZCfQuqVwTkC9AIKrmNQ6OsM1e3bedTtnWmtXClFW3EbCiPCkLxvk?=
 =?us-ascii?Q?dXG0FUS24tZv7p9CzQyHeYoWpJ5vnCuAreCchlwbsumkTIJU4a0gcN0dyD6h?=
 =?us-ascii?Q?pY5I03t7oqG8G/6Q1k7OCk2onFV7RMYP6FBk5zkx9Vyq7MZx1UwrbmcyYjff?=
 =?us-ascii?Q?YXc/Gs73vCaFgcfoovsfqznnG15Y1amBNXCMKGUoDFkr0fxDPOBoQBi9U5aq?=
 =?us-ascii?Q?OcGVaNytTuSyvrix9MeI9lUspqFaVXJsz/UtE8scbL3/J/dwI0f9AaQ9RAaJ?=
 =?us-ascii?Q?AHfeGvcbR1rU2rLGDHs3UScOYha7KgeqDCbPTDlDAXujEPYD0kE9q1J/NAPf?=
 =?us-ascii?Q?mf74RiH9f3qII2RxKYaqcCTQc7Z8TLOxy7tnIld10fpawIka17Rue5NUKmJQ?=
 =?us-ascii?Q?6qlaNZlNR81/0yJhSQG/0fV6NNn+3e1iOV7XKTY03Afw2/BSNBF9Z27h+GND?=
 =?us-ascii?Q?4QqXYKCfTQK5JIJI1jVDUs6bK1WAaLQcK2tg1AxXExwZV8539wdyqRN7ZV0d?=
 =?us-ascii?Q?tSHmlhvd7W63t5XRARmCjFURDjy/lLt2jGTJmc3J8BFuwZdEAIELXSrWCA5K?=
 =?us-ascii?Q?PN16+AorguPewlKE1eaHHKKvqanoc82KHSAraH0h8SwSw6ObKDtRPP+cbspY?=
 =?us-ascii?Q?4jAWTt4dieFTUig1dyqkqpMBP3VDaPPSjYuFGAS16+GuonCKy80n2uw6VdBR?=
 =?us-ascii?Q?H7MBhor6JcVz4e2nYofsdaloYqquWo+bm+Bz1YnncDf5cZgm5u3nAT3bb3HB?=
 =?us-ascii?Q?EC7be9wgkKOQSzpYG97J0/v5InDca0wQR7qINyefquWsLrMJImXBr1TqEdC8?=
 =?us-ascii?Q?VNjtr+AHaXjdZYOX2ZuLQGviwnmNimyJulxq5XdXk+YG6+TWraP5PkJvBP1n?=
 =?us-ascii?Q?z3wLPL63CNOURjj1b4FNqGRn4aOILo/e/skAedM+T5s6RJibXYOh+NaEHK3l?=
 =?us-ascii?Q?+lUnCFq7h5z2Bjsu3xmRJGTvU6/Am/FzF5o1x/rg6WW5ZcnRlidHzqpC/WF1?=
 =?us-ascii?Q?ihAdZ7Ap1+dfhGr8oqs/eqa9mxi3AYwf6sm2TntIodU8FII1769oDxxV1AnN?=
 =?us-ascii?Q?U2j44kTwSIiiNScDUMcv5NgJlaO6aK+qUsU237nJiN/EyJmpV+2Yl/cdpbT7?=
 =?us-ascii?Q?WdDSxuIBLOB46JySXXlzOjB88yaqlhe+HuXuh27MJIhU4Kw7GWX6OISvIogP?=
 =?us-ascii?Q?EdqQEsIiG2ym5y238SCjLFuwhGqKs64Kvy4lpQ7PQISZMhd7gjmXhQQVolsb?=
 =?us-ascii?Q?6CKaDsl7QagGO9yTFtQKWG9hLCvOQXtac2NXGIK/8NNGM01kqqKeAvVlgJgi?=
 =?us-ascii?Q?ow+eGTivOvuOsqIIP6yOBlhAAbYlJVgcxDBaz6cd9egW15BvNbWxKo3ukacr?=
 =?us-ascii?Q?73RlDTpSC/yfynSCZL2dj3OYklZ+ldb+veknlvw9F/Hl6Cx7VY6zPtM6aKAU?=
 =?us-ascii?Q?uWkkPnIKt/mPmoQrDsmYrwW2BnQHx+TNlKzDk5EuGP3pfY6iv/5R7MfTVAFP?=
 =?us-ascii?Q?qS1RVLbF0KoK4Hwnh0LMuL9N4vw7Nx1FlpNBkNt8TPT55Ya6okgi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dbb4b3-0c76-4626-3d01-08df3fbc55ca
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:23:43.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ym46niwKHD2IR7TpVutd6WUBbQOTMNqVJwX/sqOrWStF7OpL2lE0cw6quQw+OwN2b63q2x1oSIiZjVWlKFOWGMHFI56Z6/RMMNiPIhvb37+4wlLhNkOWszFJKOm40tpj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

The ingress port filtering lookup function involves performing a lookup
against the ingress port filter table (IPFT). If the frame matches an
entry, subsequent frame processing functions will perform corresponding
operations based on the parameters specified in that entry. If no entry
matches the frame, the frame is allowed in, and passed to the next frame
processing function.

In the future, the IPFT will be used to filter PTP frames and support tc
flower. Tracking in software whether any IPFT entry exists for a port in
order to decide whether to enable the ingress port filtering lookup would
increase code complexity unnecessarily. Since enabling the lookup when
the IPFT is empty has no effect on RX frames, enable the ingress port
filtering lookup unconditionally during driver initialization to simplify
code logic.

The only concern is that when deleting an IPFT entry fails, the hardware
will continue filtering RX frames based on that entry. However, we have
no choice. We cannot disable ingress port filter lookup because this
would deactivate other IPFT entries, which is obviously not what we want.
Moreover, deletion failures are almost impossible under normal
circumstances, and we don't need to be bothered by this minor issue.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 6756bf9edfdb..430bd4e2a5a8 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -618,6 +618,12 @@ static void netc_port_fixed_config(struct netc_port *np)
 	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
 		      PCR_L2DOSE | PCR_L3DOSE);
 
+	/* Enable ingress port filter table lookup, if no match is found,
+	 * the frame is allowed and passed to the next frame processing
+	 * function.
+	 */
+	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
+
 	/* Set the quanta value of TX PAUSE frame */
 	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), NETC_PAUSE_QUANTA);
 
@@ -1862,8 +1868,6 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	np->uc = uc;
 	np->mc = mc;
 	np->ipft_hf_eid = host_flood->entry_id;
-	/* Enable ingress port filter table lookup */
-	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
 
 free_host_flood:
 	kfree(host_flood);
@@ -1892,7 +1896,6 @@ static int netc_port_remove_host_flood(struct netc_port *np)
 	np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
 	np->uc = false;
 	np->mc = false;
-	netc_port_wr(np, NETC_PIPFCR, 0);
 
 	return 0;
 }
-- 
2.34.1


