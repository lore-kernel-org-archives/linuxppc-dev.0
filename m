Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E09606D808
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 02:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=S5Z1xMAB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJX4j4rcJz3cN3;
	Tue, 03 Nov 2026 13:06:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793671605;
	cv=pass; b=dawqsQ9ODY4P7gAU8yhKgUX0TjzAKDvFxSyFKCfIXGhFnhsXD+Ct5J6eGsQR/pfjgVZ0XUcu+VoOTZ+befyHKRehyh+op4TSgGZjURxijQS8bMWmXSxHL6vdC/0BHulY/i4beb30ZnBYv/nmOZIHeSSV3UiCZ4YkPkZRpoVLU+kZo5HLBntzpvwH/PdIKVhEO0QD335zYgQk6wnyPs8fqpIb/dgiykygVVowvkJCfXXhusUtuPNQtcJJyyUZ605oPAiKwCpKwdv5i2zhhX+0vBW/n1F54uQ1C3rywRwHdsAAs4tr3x1KnkerViCVLrQCCR/QvXjNr8g+1SUIXKpDwQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793671605; c=relaxed/relaxed;
	bh=Cfm+/5l2YTvto48nZbQayyroUCV/4Ne8HyI0yPBcHeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H5F2+vyxhhnQ4HLkgMGjTBjNfs2S1S614IT6+G2BwcOXOuTQwWciz0MbGqm7pfEM8L2UwxK7URUDy/iuDfSnITQwqS186NTsH4ZMHQCxvkNY2KJaOnjQzjpNhESZXLasklnEbx5IjpkrrZcvHBDUtleO8TMUNtqtcYF+5ScrJoeHdTlmDesB8oRbCEGTyjcIUCyc8hgVe+UJ8P8F/qihrKKiP0B1K3BO6nayaOPcX7vyXoJOoqoPfvuyBzVZKWQOv0t++VYqV7ygcw0xC9sO4/6OGnKZD4a6kDP1CGhJfZo0mRHVXnkoJYthNtlTBjcetix9ef52vPCFkdmKUhmWVg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=S5Z1xMAB; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=S5Z1xMAB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJX4h6rFPz3cPK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 13:06:44 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxtI8EoSQO+P6cvEKLaOIwpHEOK6t1zvrgNeT/vIz5be1nyfcBQ/deEsmSXkkDawLvYhNt0rZXwDArCRN8ZAEA5MX5TLin/XjSCoftIGehKKkzfyQWQEAd83KL3245klf6sh7mPESJiOeXhuHntvIca++T7NYJ72aXgaz+mSVBzITn5H80XdY0PN/gtHSDSRo1PCk2Y69vMKAUhxqQe0dadtIju3EhW12Kuom6cSAdaI7wrAxBEFwghUusqDMc6kgYlXSWuHOJUo2KmzMaxoSXRbjOLZPlRl1g++MK1PMcES5TkpXZR3oD9NlLXCbaSz2tH1l9mkWKN/s2L/zw1FrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cfm+/5l2YTvto48nZbQayyroUCV/4Ne8HyI0yPBcHeI=;
 b=OaPWGU2tHZUBGEOLtKJE3s4CBS8L8kwPheZD+i7mDexp5Tak0ZCMGLYlXUF7ooqvBRq8pelxOks71LIUh9fjsXlJEoySWkvIoZsjuhQ+lJ1Zr07rrr+RJNeNPJwUxO0yso9qFP6tIUkErnBsABxGzM/+2Ae2QmypCZMbH82XKTqfSl22xEsHfbvBlLW9njT1OMLiffvDAlC7N+SdYXJR9KfjpEaPRke87W1dM3cSiS8DMYmiTGActRDwVY3/4HG5aA78Rx/KzHsUtYe+RzcdiEo3HXJgHoUiZWT11HTpGvkk6gazfJpzqbL6k8+QLy2zKkgDeazve59X5HE8BqsmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfm+/5l2YTvto48nZbQayyroUCV/4Ne8HyI0yPBcHeI=;
 b=S5Z1xMABNnThptah6tVVHpGvXSFl+4Z4ICLei8XA5EHVgMuzWSbACczAebd35gR2BQksRH+FNrFaLI4vDqoDipBpRbNyqaXyd5tZ5kWnd8jefdPQOTegPgKIeLiVrFSvZCpVY9C1zBJcsvYQhjLMUkuszh3dosbJ2Y03rfx7fkmm9+E2yZU/t8ZPcAdqVnGhM4MkVILzof3wsipijadlPO+Skm5gT0T7itMpNGEZf0H5VHwiLreyB/zvGBOHkeWk/uHfcgX1SP/c1FEz1y0oH1gfj/Dw0sqVihgpNwR/f95wsGIqfb2BiCuNqiLkskVlR4RJgJ2qJjEVafukMxzezA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM7PR04MB7094.eurprd04.prod.outlook.com (2603:10a6:20b:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:06:21 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:06:21 +0000
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
	linusw@kernel.org
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 net-next 5/9] net: dsa: netc: use entry ID instead of pointer to track host flood rule
Date: Tue,  3 Nov 2026 10:10:20 +0800
Message-Id: <20261103021024.3121936-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
References: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM7PR04MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bccebd-5109-428a-8a3e-08df394f0e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|19092799006|921020|261021123027099003|11063799006|56012099006|261009223027099003|261028144727099003|261026140227099003|261022075727099003|261026121527099003|261021121427099003|261022105027099003|10067099003|18002099003|22082099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	+QbYpOs5uXBZVT8VFpvMYnqJS8ShFvPH9LzWhNbSTYqWg2ogG77AOsQDe4jHNeEVzDqcTx3Nx/XoDJHKVT6wa1/eVL/iFVOm4H18douhH8fqCF4igicLl2RXkagi+Tw8o54m0PnZ3b0kgduVqPqzXchEogSKofbeP6LBQLx9/M/Eok9uWACRgumQSge+fvPVXfh1+iRhplsY8H7/Eo4N68hu367AfRoWKoM3uvvcJIJ9A/YfhNRG6CMvleffjfI+DWqPXvhAAOKDT68hqmRxDzPnQHgD8B24nMWj9gsO32y50BMiKCW5YmV/TFxC2t8tNS7ecT2xkACRqAw7xmUrP8uq2oXHXlhI3/gg9Gq7ueJuvGPZC6FLqxfHDf2APyKjvBjGZvzKSf12Poe6/T6mxbh2s4HNLpkUwr1gmjOwEFPoMf5czPIlgE4PqyOEIWuhqcQeLibsHgfRDns3oOtzrD9gHdNna/I3nwK1a0ljXh5aIJa/nO8p0N2UqwW2XUmweeX/6GMZcUz9RB+9mUoQGVNtMGkaxwAIXQUzDedureMITeZrtB4+CMjF7XiOZitj7e8Jv2a3JRQ2x7OYG03avi9GSUU+UgZ7U9eVbSQzOFjwzguNKCVfttvgruf8wS5ygdxYNiCIMyGVRFiob+Ty7MXMpqwYeo3SQ3irhkOVPIaRRHL5CIS8SZLmhDHacJ/9AEnRVbrF3c71J6j4A5UUKQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(19092799006)(921020)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NXIZ7VsJQx/zgraTiErrfqRgpApijS3HL+22xgXUA1gYUlxLZYf40celBDNX?=
 =?us-ascii?Q?ACz0M+0+1o2QFLgbIBWLchzmM/f6OYqkBfreBKNERIfbaLNwSBhK+Lk+gFLj?=
 =?us-ascii?Q?5C2Sz3GAEzLeq6b4/l9FkWjKoLst6VKeTrGvqhZOjE0bvPjrDsN0F6PjbXtA?=
 =?us-ascii?Q?quFNdOaJAMqEvLrGXjho546rIvlkcQ+NiBtttcSCwuVDZsDOx/yCsGT2aL/b?=
 =?us-ascii?Q?5Jrdb+KLdLQsjJCe4e+Nn+hyw+Zl5JwuzWH16ZBOCsB5Cwssj/7rl3aK7CVh?=
 =?us-ascii?Q?vf91+Xd6RWvcQooUC1N6qMHOyeQcD2Q+1ErMe8d34ReRBqGtHyQudv/lfn3U?=
 =?us-ascii?Q?h/X/Ddt61sz3cEQJsDb5CQrqds3n5PWzvbnFr/xAt7qROKv+A9Zk9PDqD6xN?=
 =?us-ascii?Q?QDl7ut1ns9Vuz6Uw2tXkxM7lGSUW2sTi5MKs/VCUJe2OSv5sjF99bF1WCfDm?=
 =?us-ascii?Q?Dv9gGNbHKl72hRA0A7tYcDtgWDjVdDnZNUIw8mjOqsSG2m6fZozzJkrzFGHl?=
 =?us-ascii?Q?1YA60Thn+VxlQGC3hr+OK53s9rgzUrWXHgwxtzOyXI1SeKG5w6c6u1ng3g2u?=
 =?us-ascii?Q?yYKqiv5Q56tSVlzswzKYr0eeTK4ZQyodHREH86GS3KPwI4LqoJQSqb5joSgb?=
 =?us-ascii?Q?jUrgllXgqxFdqfPyLVnfimQSrayArG7DTlA5vwn710RBxiduFeEpVdX4YURQ?=
 =?us-ascii?Q?4MuCMr3QnA/H/KtQA1I1rBdAmkF/0CpKa7EcyU+ASwJl+AGPgLMgk3iIzJ2P?=
 =?us-ascii?Q?j0bsxweb5GTc7SBSiGqZdqGIcRITFv/uhE6loGDEWwhA6swL4v/WMpKN96Ly?=
 =?us-ascii?Q?CafBzqoObudVQVcqC6lmcy+kTjzAOiKkjxoh1lj0/Im4KrjVH7uVSh5v9EfG?=
 =?us-ascii?Q?fyYEWtYieD49AgjaAEZonLSA/7QzvF6gXwfvv0I4nomPzBdZB9iWPWupZpqG?=
 =?us-ascii?Q?OseN7gpA+WtvhxpqDC8VwxOpLh9uZO+jBVsLtMNsJY1Xt3RzcdUXrVHh2IMF?=
 =?us-ascii?Q?6zg58pyGqCvMrLiOgfr+V1vFuO6vWo7QBMFxwt+KyyVRgfiw05pVDPeUXvi4?=
 =?us-ascii?Q?if0bP5/pPCOP0iSRUI00vU+ARtw3zFtU5EBN2h9Q+5wdKgbaA8wWYlxUTxkX?=
 =?us-ascii?Q?/C06BizmBh4Y+u78AyAEAoI2U67xRKOd+FivQtpFXtTz7kSMS3BidHAdZozs?=
 =?us-ascii?Q?Fkook8K/LmaRQes8yJ3Xu712OvTuEkumUevSu/0zsNvtAuSDRYuxZtQD5dEK?=
 =?us-ascii?Q?UVooMeX8yGDdFpVPpl7rp824PxtA1aMRlCuTUepJoHPk/FqSLGMpg5+QOb6S?=
 =?us-ascii?Q?/o8VEON2Fedea+G7MPgJVsmZTcv9O8UToLSwXPBbNdeRKcZBIfmFfqa1Uf8i?=
 =?us-ascii?Q?9m5BQoKgRl7299oO1YQKXfN+qn5wkdm8sDJEPmUw7NAddMJctTtx8bCEhcyg?=
 =?us-ascii?Q?MU1t2GSe7L6PP45dp2DE+uY6JGGjqmZXqPY+jL3vt72ArHBkI/br5eg13CiQ?=
 =?us-ascii?Q?kPjLsmqDAZDEzzIP3c6XTLLorWXmXoxEj00aBogxdf56hFFinskXZPWvboIx?=
 =?us-ascii?Q?qA/N1zLxiH7M4iAegw9iZizMCHJHTGYaneVdm38+VlPvHkNLYBg2bnCdsTes?=
 =?us-ascii?Q?IgqO+OedGPF+TWDvCj6uZu7h5TegkNZAbpjbeP4SMi/AYx722RpuQUy98ZHB?=
 =?us-ascii?Q?ZZv8bUynP9m690wHXl3lkD+u0+nyYw4OHHWbbT99R27KRSC0oZH0NjbGw/1z?=
 =?us-ascii?Q?i28YnqcZUcOrVmoq1spVjWwYh6oJgt0+W1Lb4NWWFX3eSF6CQR+4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bccebd-5109-428a-8a3e-08df394f0e29
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:06:21.3793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+sEpCCfbwoPg8KkTT/u9UcyQZj84X4XbhVhKG/mxR/5igpV9vcjcb0h6g1UkAiZXtswcR47vpBaXCy47qWev/U3UHhuWMhUBahLHrbCEs2aN4y6sv9n+bBwTI5xYWdg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

Replace the struct ipft_entry_data pointer in struct netc_port with a
plain u32 entry ID (ipft_hf_eid), using NTMP_NULL_ENTRY_ID as the
sentinel value. The ipft_entry_data allocation is now freed immediately
inside netc_port_add_host_flood_rule() after the hardware entry is
committed, so no heap memory survives beyond that function. As a result,
netc_free_host_flood_rules() is no longer needed and can be removed.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 62 +++++++++++-------------------
 drivers/net/dsa/netc/netc_switch.h |  2 +-
 2 files changed, 24 insertions(+), 40 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index ec0b5a731b28..c946a2b2674e 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -321,6 +321,11 @@ static int netc_init_all_ports(struct netc_switch *priv)
 
 		np->switch_priv = priv;
 		np->iobase = priv->regs.port + PORT_IOBASE(i);
+		/* The ipft_hf_eid is initialized to an invalid entry
+		 * ID because the host flood rule (IPFT entry) has not
+		 * been created.
+		 */
+		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
 		netc_port_get_capability(np);
 		priv->ports[i] = np;
 	}
@@ -1049,30 +1054,12 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
 	mutex_destroy(&priv->vft_lock);
 }
 
-static void netc_free_host_flood_rules(struct netc_switch *priv)
-{
-	struct dsa_port *dp;
-
-	dsa_switch_for_each_user_port(dp, priv->ds) {
-		struct netc_port *np = priv->ports[dp->index];
-
-		/* No need to clear the hardware IPFT entry. netc_setup()
-		 * resets the hardware via FLR, so the next setup starts
-		 * from a clean state. Only free the memory here to avoid
-		 * a leak.
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
 	netc_switch_free_bpt_list(priv);
 	netc_free_all_ports(priv);
@@ -1873,37 +1860,36 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
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
@@ -1914,7 +1900,7 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 				     bool uc, bool mc)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
-	struct ipft_entry_data *old_host_flood;
+	u32 old_entry_id;
 
 	/* Do not add host flood rule to ingress port filter table when
 	 * the port has joined a bridge. Otherwise, the ingress frames
@@ -1922,7 +1908,7 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	 * will be redirected directly to the CPU port.
 	 */
 	if (dsa_port_bridge_dev_get(np->dp)) {
-		netc_port_remove_host_flood(np, np->host_flood);
+		netc_port_remove_host_flood(np, np->ipft_hf_eid);
 
 		return;
 	}
@@ -1932,20 +1918,18 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 
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
@@ -2134,7 +2118,7 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, vlan_unaware_pvid);
 
 out:
-	netc_port_remove_host_flood(np, np->host_flood);
+	netc_port_remove_host_flood(np, np->ipft_hf_eid);
 
 	if (atomic_inc_return(&priv->br_cnt) == 1)
 		schedule_delayed_work(&priv->fdbt_ageing_work,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 4a8c5f9cde38..e7af30e5fe9a 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -84,7 +84,7 @@ struct netc_port {
 	u16 uc:1;
 	u16 mc:1;
 	u16 pvid;
-	struct ipft_entry_data *host_flood;
+	u32 ipft_hf_eid; /* Must be initialized to NTMP_NULL_ENTRY_ID */
 };
 
 struct netc_switch_regs {
-- 
2.34.1


