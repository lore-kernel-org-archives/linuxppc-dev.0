Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C90606A88B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YcNK3ANr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jT0Fw2cp1z2xwP;
	Tue, 17 Nov 2026 07:44:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794861844;
	cv=pass; b=bW49wA2Nt7vbf8eNehMfpg7gOdtbP6Yzwf65o8T0FJ5WKRxTAnNCrs6FQ8DNABWKF70watahmnUVntSRMiF4DLl+O8x5qBbKB9ZSR1qjAKqsaxqlfquAA3CdDflxOdd4/VPwgAVp3ec+E9lpFr14iGSRxgKRCQwzGjTPSHTIBol1HqfyYCvJS01vfLz/tmV84zFWHA/0kqFmCy7P/SD9vB13yaB/xpOmT10jmHPnjbsgWRbr7wgXQexDZ8hojmyK/0QaBs7beQyPdenZ8NtO+PUCTzOZFZBCsT+Fgyq0tCk47Wzhc+LJ6RJO5KV+GCURFjDnMuW4taBR5WeTZq2YZg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794861844; c=relaxed/relaxed;
	bh=jj+oTcIhetRsCo6MEOnhJo2HLd2L3SxsIJcgmOuhRJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jv0qqzzoh6oTGzvGTDhnhuIqUl7GC0KlTjLA47NdwGxRHbfkSqXnZ8UG6e/g2P0uFAZTJlqbj7yNKTXib9fLZ/z8311E1hKNc6kqdoqfLOHSMckWCokg23hv5eiDIckQNzmZUt97GxAN3gth2rU1GPNEmJXixFgbtOqXNadTfJNsbwztLt65+8gQZ1a6xAaYxCr662HHo/q/7fxNIJ7cpvCDc7I3hbXGsbpnOGAo+JQhkj7sEoZhOVA+Vg00JJLRK1GKxQv/xaujtauBMbnw7hoV7fvnewyYC2n9aXbVBEVrp4NYYP1g07ooy7eJaBzQ4XLDqHLmu1fUedgcuSo4ow==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YcNK3ANr; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YcNK3ANr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jT0Ft6wQqz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 07:44:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvE8wdEwZH0j18TxjbwDYLCjagq/ZQxic41uKPtO3jRrByyuOmSoqtQzt3IhZN8MsgKEb7QxWtPTOHZsWXPoItPM9HwsgQHAWIBHGOjqmYUeTtUQuZ3eb8WTP432eu+XEAHU5eUSjhY4YeiNM7CQnaompV0TSeZ5RpDtF/O3VqBxdivvGRn4BS2mnq8TF++hTOFUhLYx7bAYh1OlyQQfylJ8o9dWxFDjzRQSRCR85WOe/Okt1vzUqeOleQli9DSQgJi2EyhgF+if9FE4+WKfy1BIGZMqccHqywi2LnvXyLCHDthYmvB+XECo4xMYo8nqWrNWHcDQH0QrRPiqWW+8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jj+oTcIhetRsCo6MEOnhJo2HLd2L3SxsIJcgmOuhRJ4=;
 b=tw92cPbxAq7i8agh5q4o25ktcFXzPntHfGD5mDt1orTwUa+PgnOFb3f50JYM4vhK0qBbOoV61PrSYdIPcwzRV5ZwoCr4PwSG0Dwm5Z6RtbElW/8ub5gc5fHqUsYJrmyr1SMDqElHgncNBfxEy8OQqLCDbQWa7Ch4igJy8bB4BKNf3ogGiGghNINDH+jKzZhMk/xDX3vPBB1vIDPyCwinI1cZicBoYB4P2X520hGavfd/asaruzt0GQBq/mUD8LEMvhA1LYNGqBjXekyoVKZpFvJtGuTmw/gN8wLMfmjaMiHG5tv7vcGFWTunVNVa9+bwrElJK8LhWY9prMq1XK0aYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jj+oTcIhetRsCo6MEOnhJo2HLd2L3SxsIJcgmOuhRJ4=;
 b=YcNK3ANrlYP5yjsSYBzabSOXZa21daAXygueMJYb1mX1HvnfuKipyhLiUekHcqqG6aSmdiYilvwR+WzV7AC4d4Xp1/u24DhgoCVb/4SLXQVWjR0oReInVWncyLwIFgJ6NwzrDqNF6bAppV5cZyns65W+KPbPWGWDmcwWm2yzeKWdTzb/3C7htR79r3U5vqb3nKUAIqSWhsN+1SqjjAJWVa6ktLJJpuswvHFkhjTv8KS77lJKFbIhzAFKa9y0jKjcQiAbf8jYRes5C+2eUSAo8/RFDaZ6v75nhntKgfWfNS15jgvJfq5T6ZVMR8Z6pqXPqgrAAghctuNm/LqSiJgS9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI2PR04MB10859.eurprd04.prod.outlook.com (2603:10a6:800:278::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 20:43:39 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 20:43:39 +0000
Date: Mon, 16 Nov 2026 14:43:26 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Linus Walleij <linusw@kernel.org>, Zhang Wei <zw@zh-kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	imx@lists.linux.dev, linux-actions@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] dmaengine: convert to subsys_platform_driver()
Message-ID: <avtq7mK482R72JE1@SMW015318>
References: <20261106-dmaengine-subsys-v1-0-780eeddbf3ef@redhat.com>
 <20261106-dmaengine-subsys-v1-1-780eeddbf3ef@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-dmaengine-subsys-v1-1-780eeddbf3ef@redhat.com>
X-ClientProxiedBy: PH8P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI2PR04MB10859:EE_
X-MS-Office365-Filtering-Correlation-Id: ac885d40-3464-4b3a-be07-08df44224b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|19092799006|261022075727099003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261021135927099003|261009223027099003|261102123227099003|261102130727099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	cEah6W4kaqsrEptZeKKmQAwFBE6FClpKdcT1UleWaDTwVs0i0FWDFfBf+mVoowtagO0Ly83L/njeu24WkwDaDplrQe1xmjn+0vSy3YUV9LPWhsR071cANljya/IXDl0C4fgex+v0cCyVXoysjiil1RjTTmzPA+AJZ4JVajDnYXcVoiq4H058yiM1no2Wqqf+55K/PGy/QgtGeiJThTPl+TEHUgzT0N+ir3d+u8B7tSz1OjjTUO7JYdpm2MS5zqM6Sq5ofxFN5gl1RQmpjJnTpwhkuiMXJYVHU8kOSVHgzyg0B17CIma+Sd3Mkr/AGs2gKY0yaBPDJU6bt+FaYXr4JqZkv8ozV12CUp5SJ/fA5MNC4d5Aqfbr7MYNJQ6NMm/nP9VTLxiT3ljmkkvNGLmMeReA4TrSNALuGqbleB0vhJnPv5WIrkxBrf9RIumZoffNcvmRseRLgfbR+7xjnUAHtuW6as5npElauEEgJmtYQmzTAn/1f7w3sUY4eYpuVPSESLzs2sfkvCxQkqlkD5EES2kzRXqd+zHEC0coGtcFxhebtnxBO0sUlFhOZXMF9ylZsWkF4rJgwrGhAdzFk185we1soL1fKvXbeiPwqoNmRhb3qD9i2Av7e2jcH7z1HnNN85mXYA0tS6tIdYAauyyhdYBSx2V3UqP8AEQtxyBKsdk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(19092799006)(261022075727099003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261021135927099003)(261009223027099003)(261102123227099003)(261102130727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Ii1HAc9J7lISRuYdO2xdGxU6xlcLCCM+6jKGzb6WJzUF5R5v7J5FV6uAaW5?=
 =?us-ascii?Q?U3n+49BRQrp2W2j3O43jrdRU3CVQoIxG2Zt0Zve2DKdMBepZhpoAaBxBg09W?=
 =?us-ascii?Q?cpM5nnZak3fk3SxqSVIDF6ADtprn/nnPnngYh9VDRHLVipPSYgboAGcAxq93?=
 =?us-ascii?Q?qoZBX7zBqnPoB+JrG0It3wbx6m38F1DlJ3JGMlpqOnBhTrY/6HyNnD9eiT9+?=
 =?us-ascii?Q?C5CcyR1rVo0dNvJIwIn71bRWO5jtmu+XqZb6JDNcHiBV9rLlIbYgpKN9PYYG?=
 =?us-ascii?Q?8BzOoRnTiFCvf5CQxQsmYTnmmDnuIaCwpDnOiC4dB/fpzOAkjB7FvuJtCDz9?=
 =?us-ascii?Q?PvgTQ6sJl0IMr75iUC+iFDYfQbrogiVUE3TnoHzgdWSJ/SdZBRL82S+dpks/?=
 =?us-ascii?Q?RVm0vNJxSe3UIo/DAuYmab8+qcpXYOzfkLfRqzIAyK0N5gxdrQVwqkVGfRtT?=
 =?us-ascii?Q?1ZS8FjPsKJDPxjiMooPB0txsm8qvpLryGkDvYz9g6zIrB0l9w6WPiT9freeq?=
 =?us-ascii?Q?KnBSn+KBS1Hehk6C8K0ZiyZcH3Q4r23VIXcLRx37z76rm7OVg7oscc6CQrUm?=
 =?us-ascii?Q?hv+mlYmZ9vHiMN0El6FIKEAWHVum6uLoZzQgmHsgPm0BxUvFtCcxyk2ioLo9?=
 =?us-ascii?Q?FgKzMZauO70htbpMY975LtuutFlmUNB7I4GsMjxgiDmjK6S9cIJ2H5NAAJTu?=
 =?us-ascii?Q?lVBTY34+VBUuanP/m4NL9pxpof28LtgF2DSuIkEldlFb9F1SXVLcqYhg6ZjN?=
 =?us-ascii?Q?Z2OwL357fixm4xRpTbmUqV3BjDEEyj5E9WIIfJ8YTNuM7uUyKWGdy/fQi9O8?=
 =?us-ascii?Q?xa8QIsVQXM3juZ0mN6z2BcpM4Mv0/OVnFkxsuLlrW3T+aoywYiKyNjms+mdN?=
 =?us-ascii?Q?5btTr1K4V1dOKMBAcUtB3TrNNPk7N/kZR7pXOyb19lZpE9JdOH/SQQG5feLs?=
 =?us-ascii?Q?glN6LubyzuuguUwTMBlb9RhISKaQqDPuw+tJ0cJUd9uxFK/9SSJaH+Gi9U4x?=
 =?us-ascii?Q?kWOj1G01Ba+rZPM5ftK0QZ9ZdJBn3GAgzfHQXBIWIWYJlujpxJdR9l51Pn2z?=
 =?us-ascii?Q?aP1uqNQuNF88dCb1jFS3/1sITqNg0MX1zjYJ3OyL8OCtv7IH8V4+G/TqOyy3?=
 =?us-ascii?Q?ZDQvreGvim7Gw3fBSWQ7ktt+cXAZWr8Ekgn3kztTs4i2exGfa+RG1Xsge8R/?=
 =?us-ascii?Q?gyuvm6Lpxx/sciuXkHREToQ78NbjJSFGvo1NzvX6oRACbDFgvkC2RIWKPKer?=
 =?us-ascii?Q?6yGV22FFECRi1k1mwgxv86LMy7CQKyDNoFuZI1v1EtR6HVod/Ni15XZ9yyUm?=
 =?us-ascii?Q?dCxD1wDpNeIfwbYfuKgD1g5eL2gfyTfkXcH+5sunjrGyaDle0P1TSStZ+IqC?=
 =?us-ascii?Q?U58D067N3PhxBx5vSUMbOOUkNKE5bLYY4Hzr9sHewW79L+AV/HWv2xe0oEXq?=
 =?us-ascii?Q?YaApVh283a0QTZrmuzPHcjTkeKpuCtav14vBRsMHrpPJFQMKalHaY5+hqp5s?=
 =?us-ascii?Q?Rx6oqCFMhvdNLmxHKxpEKFCOIxL9jb6NR/LQk8VQ+uzkNua+nIqUECsVUO8U?=
 =?us-ascii?Q?MKzvs8w10/YTwmYpVMIpjPa52iQh36z4can7zarPm5KCUBL9vjk13JdeO/VS?=
 =?us-ascii?Q?w/Dubx9yeosIjtCl0w4JldoElODzf2jRPVV3y1QuFzd48R9O1sffJdywiouO?=
 =?us-ascii?Q?Bc4JGHgImoDhyXKoaTptPlZ+N7rK+3juJL8F03HRolsM2hqF6FqdO3T94BBg?=
 =?us-ascii?Q?Y6MqsJ3nj0Pbmuuvsql2Itt6BmlNiSoGB0yNuy9QbujCsXiEnh4e?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac885d40-3464-4b3a-be07-08df44224b55
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 20:43:39.5486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XebeE2WWj7gXcdJDKjnh9EbiwVyE+ExfnGjA09QR32LT47gpr1PTZIotdBV3/k7YD1z5wCxzFwPVyjYNbf02NztRbpxQux0ZyKVLMTL953wSsfRj94T99w0iMES77RDH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10859
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 07:06:08PM -0500, Brian Masney wrote:
> Reduce boilerplate code in these drivers and convert them over to use
> the macro subsys_platform_driver().
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/at_xdmac.c          | 12 +-----------
>  drivers/dma/bestcomm/bestcomm.c | 18 +-----------------
>  drivers/dma/dma-jz4780.c        | 12 +-----------
>  drivers/dma/dw/platform.c       | 12 +-----------
>  drivers/dma/fsl-edma-main.c     | 12 +-----------
>  drivers/dma/mcf-edma-main.c     | 12 +-----------
>  drivers/dma/moxart-dma.c        | 12 +-----------
>  drivers/dma/owl-dma.c           | 12 +-----------
>  drivers/dma/sa11x0-dma.c        | 12 +-----------
>  drivers/dma/sf-pdma/sf-pdma.c   | 14 +-------------
>  drivers/dma/ti/omap-dma.c       | 12 +-----------
>  11 files changed, 11 insertions(+), 129 deletions(-)
>
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index d40a8b40dddc..8b19d46ac812 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -2488,17 +2488,7 @@ static struct platform_driver at_xdmac_driver = {
>  	}
>  };
>
> -static int __init at_xdmac_init(void)
> -{
> -	return platform_driver_register(&at_xdmac_driver);
> -}
> -subsys_initcall(at_xdmac_init);
> -
> -static void __exit at_xdmac_exit(void)
> -{
> -	platform_driver_unregister(&at_xdmac_driver);
> -}
> -module_exit(at_xdmac_exit);
> +subsys_platform_driver(at_xdmac_driver);
>
>  MODULE_DESCRIPTION("Atmel Extended DMA Controller driver");
>  MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches@atmel.com>");
> diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
> index 241a91936fe8..1dadcc259382 100644
> --- a/drivers/dma/bestcomm/bestcomm.c
> +++ b/drivers/dma/bestcomm/bestcomm.c
> @@ -474,23 +474,7 @@ static struct platform_driver mpc52xx_bcom_of_platform_driver = {
>  /* Module                                                                   */
>  /* ======================================================================== */
>
> -static int __init
> -mpc52xx_bcom_init(void)
> -{
> -	return platform_driver_register(&mpc52xx_bcom_of_platform_driver);
> -}
> -
> -static void __exit
> -mpc52xx_bcom_exit(void)
> -{
> -	platform_driver_unregister(&mpc52xx_bcom_of_platform_driver);
> -}
> -
> -/* If we're not a module, we must make sure everything is setup before  */
> -/* anyone tries to use us ... that's why we use subsys_initcall instead */
> -/* of module_init. */
> -subsys_initcall(mpc52xx_bcom_init);
> -module_exit(mpc52xx_bcom_exit);
> +subsys_platform_driver(mpc52xx_bcom_of_platform_driver);
>
>  MODULE_DESCRIPTION("Freescale MPC52xx BestComm DMA");
>  MODULE_AUTHOR("Sylvain Munaut <tnt@246tNt.com>");
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index ac2094e65ecf..32a40c17e0cd 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -1129,17 +1129,7 @@ static struct platform_driver jz4780_dma_driver = {
>  	},
>  };
>
> -static int __init jz4780_dma_init(void)
> -{
> -	return platform_driver_register(&jz4780_dma_driver);
> -}
> -subsys_initcall(jz4780_dma_init);
> -
> -static void __exit jz4780_dma_exit(void)
> -{
> -	platform_driver_unregister(&jz4780_dma_driver);
> -}
> -module_exit(jz4780_dma_exit);
> +subsys_platform_driver(jz4780_dma_driver);
>
>  MODULE_AUTHOR("Alex Smith <alex@alex-smith.me.uk>");
>  MODULE_DESCRIPTION("Ingenic JZ4780 DMA controller driver");
> diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
> index 5c1c97eb28a4..7576ad255343 100644
> --- a/drivers/dma/dw/platform.c
> +++ b/drivers/dma/dw/platform.c
> @@ -195,17 +195,7 @@ static struct platform_driver dw_driver = {
>  	},
>  };
>
> -static int __init dw_init(void)
> -{
> -	return platform_driver_register(&dw_driver);
> -}
> -subsys_initcall(dw_init);
> -
> -static void __exit dw_exit(void)
> -{
> -	platform_driver_unregister(&dw_driver);
> -}
> -module_exit(dw_exit);
> +subsys_platform_driver(dw_driver);
>
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Synopsys DesignWare DMA Controller platform driver");
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 630285c85482..c731104c3306 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -978,17 +978,7 @@ static struct platform_driver fsl_edma_driver = {
>  	.remove		= fsl_edma_remove,
>  };
>
> -static int __init fsl_edma_init(void)
> -{
> -	return platform_driver_register(&fsl_edma_driver);
> -}
> -subsys_initcall(fsl_edma_init);
> -
> -static void __exit fsl_edma_exit(void)
> -{
> -	platform_driver_unregister(&fsl_edma_driver);
> -}
> -module_exit(fsl_edma_exit);
> +subsys_platform_driver(fsl_edma_driver);
>
>  MODULE_DESCRIPTION("Freescale eDMA engine driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index 9e1c6400c77b..fb6c06d4a8d1 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -282,17 +282,7 @@ bool mcf_edma_filter_fn(struct dma_chan *chan, void *param)
>  }
>  EXPORT_SYMBOL(mcf_edma_filter_fn);
>
> -static int __init mcf_edma_init(void)
> -{
> -	return platform_driver_register(&mcf_edma_driver);
> -}
> -subsys_initcall(mcf_edma_init);
> -
> -static void __exit mcf_edma_exit(void)
> -{
> -	platform_driver_unregister(&mcf_edma_driver);
> -}
> -module_exit(mcf_edma_exit);
> +subsys_platform_driver(mcf_edma_driver);
>
>  MODULE_ALIAS("platform:mcf-edma");
>  MODULE_DESCRIPTION("Freescale eDMA engine driver, ColdFire family");
> diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
> index 28be93eed4cc..d33733afce9d 100644
> --- a/drivers/dma/moxart-dma.c
> +++ b/drivers/dma/moxart-dma.c
> @@ -646,17 +646,7 @@ static struct platform_driver moxart_driver = {
>  	},
>  };
>
> -static int moxart_init(void)
> -{
> -	return platform_driver_register(&moxart_driver);
> -}
> -subsys_initcall(moxart_init);
> -
> -static void __exit moxart_exit(void)
> -{
> -	platform_driver_unregister(&moxart_driver);
> -}
> -module_exit(moxart_exit);
> +subsys_platform_driver(moxart_driver);
>
>  MODULE_AUTHOR("Jonas Jensen <jonas.jensen@gmail.com>");
>  MODULE_DESCRIPTION("MOXART DMA engine driver");
> diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> index 9dc88d804a2e..c13c449ad05b 100644
> --- a/drivers/dma/owl-dma.c
> +++ b/drivers/dma/owl-dma.c
> @@ -1254,17 +1254,7 @@ static struct platform_driver owl_dma_driver = {
>  	},
>  };
>
> -static int owl_dma_init(void)
> -{
> -	return platform_driver_register(&owl_dma_driver);
> -}
> -subsys_initcall(owl_dma_init);
> -
> -static void __exit owl_dma_exit(void)
> -{
> -	platform_driver_unregister(&owl_dma_driver);
> -}
> -module_exit(owl_dma_exit);
> +subsys_platform_driver(owl_dma_driver);
>
>  MODULE_AUTHOR("David Liu <liuwei@actions-semi.com>");
>  MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
> diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
> index a6fa431530e3..70b191519053 100644
> --- a/drivers/dma/sa11x0-dma.c
> +++ b/drivers/dma/sa11x0-dma.c
> @@ -1080,17 +1080,7 @@ static struct platform_driver sa11x0_dma_driver = {
>  	.remove		= sa11x0_dma_remove,
>  };
>
> -static int __init sa11x0_dma_init(void)
> -{
> -	return platform_driver_register(&sa11x0_dma_driver);
> -}
> -subsys_initcall(sa11x0_dma_init);
> -
> -static void __exit sa11x0_dma_exit(void)
> -{
> -	platform_driver_unregister(&sa11x0_dma_driver);
> -}
> -module_exit(sa11x0_dma_exit);
> +subsys_platform_driver(sa11x0_dma_driver);
>
>  MODULE_AUTHOR("Russell King");
>  MODULE_DESCRIPTION("SA-11x0 DMA driver");
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index 6f79cc28703e..d62563f6c7f0 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -639,19 +639,7 @@ static struct platform_driver sf_pdma_driver = {
>  	},
>  };
>
> -static int __init sf_pdma_init(void)
> -{
> -	return platform_driver_register(&sf_pdma_driver);
> -}
> -
> -static void __exit sf_pdma_exit(void)
> -{
> -	platform_driver_unregister(&sf_pdma_driver);
> -}
> -
> -/* do early init */
> -subsys_initcall(sf_pdma_init);
> -module_exit(sf_pdma_exit);
> +subsys_platform_driver(sf_pdma_driver);
>
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("SiFive Platform DMA driver");
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 55ece7fd0d99..da1f4eec9eb2 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1941,17 +1941,7 @@ static bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
>  	return false;
>  }
>
> -static int omap_dma_init(void)
> -{
> -	return platform_driver_register(&omap_dma_driver);
> -}
> -subsys_initcall(omap_dma_init);
> -
> -static void __exit omap_dma_exit(void)
> -{
> -	platform_driver_unregister(&omap_dma_driver);
> -}
> -module_exit(omap_dma_exit);
> +subsys_platform_driver(omap_dma_driver);
>
>  MODULE_AUTHOR("Russell King");
>  MODULE_DESCRIPTION("Texas Instruments sDMA DMAengine support");
>
> --
> 2.56.0
>
>

