Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33BC60A261B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 06:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QvmqV+Om
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPYPg1VcLz2y2h;
	Wed, 11 Nov 2026 17:23:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794378231;
	cv=pass; b=SzaW3ohFMsYWgVzEJww+240l8t3bfl3Hz+/20jelQeVs66xa9B2Spslz/JVuaPCOeGyKiPMlqzhYbFMYTwLdU0hocqjvg9iBjGCqwP+BnJf8gIJ4YersX/CE0XUam/30EmI5YL/XlGTQMe042DGBPU29p4c5yO3P6IyT/vX9YuWwGuNcHwhP71MQ/VCLXeR5RBwLAARf6RRLLFiudkPmFVEITdr3DawJ6oUOpCTiPl4F5Z8jPRD83G6nuyHO+eTf99RCvjJESmLRyJftwe4ZntBHVXoRPqqCWugfcUM4m37XYbBLyTxIiMqsljpaFZXuPlJOChj+uCZKA+ZVckbdvw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794378231; c=relaxed/relaxed;
	bh=N8na+18KrK2ttOVNhKpTlfydv/D+3rwQvsgvmKljp6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lws1YPOXs8vGC+H+RTjOEdtYGAQJqZDUpVpLo9WCoiNIoB5CwkKurHI6Ak5BtdMg68heDI3I/cF0cqByg0J1uumnXbKoyzBQ9yqpWA9iQXg5znmLwZxu5MtEipWvQrZLk4qhuKDF8QBTacKC2Qor9GZFA0ZnB/5ZpZYbAewWc46u/Wyd2b8mvPWAP2/kzy6lCnVpMGKRBNdPRWQKEOrxOUBuyJSCnQYd2B/kmlKThwSJO7rVfITBuxXXjKp/ExfvZF1MzC/lqCPYZH92qld6CyN+6/2E1JEn1oe8K/4TCqwbLrf+0FaHLjfg+y30AQSEt9SGStR/pvBg0vEomNW3jw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QvmqV+Om; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QvmqV+Om;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPYPf2JV2z2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 17:23:50 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ65jXstDBl1mkSiSdoydKN+CbQjMw37kBk8JV8YsaiCazi6pBVVIJMh67aSJaRLzVmw33EWKMOcqNTUOsyq9yVMVfAAMI1uSvnr1ERcXBVsgrAqTROnQYIBwvstKqVxaryBkp5PKpvlpdC23N1ze0Hmo3BXj+woaJ62hqlbVscxVZ9fYYBD1SG8h48Oj6EzPVWXSX2sJqI6j+Sgmh4AKwYON9Uj5jFWsrPvqtmV2MbeN7hEiwMNxSVmyZ0T1aEPFbjiMYExcnuYA00hKTxwgmXHPCifWDCJYRdFCJ1Lli7zaCDqAqAJFAbsMzu6Yny96hsZnAPvl1V/GOPGNaEauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8na+18KrK2ttOVNhKpTlfydv/D+3rwQvsgvmKljp6c=;
 b=mzvbglTrwdDuMFvvt8buqXFiMbgRXbc6264A1Y4rzxTfGnb9DtE22/cIzfmAysApXaRyvNmWkwIszFVSZ9neyr25sh/pEgCRPb8ufCiNdsrTEz0ms0YriwSXT7W74vrb7nCW0oYFx+hsVnLifMLwg17mk55k8TGZ/2g67jZU2IsAnqsDAypLBoB0z6xkE+OpGU5H18CZihYKoG5Ts1iAzlZ1VQGqsNB06SI7ncwpoobQvITluNDA6F6UgJW8FBxANIB2SDeax7cM16ngwRVLUqXuYtRKG8DlvfcO2RagSf3K0YOCIx4SCHuEX1Pklj+cu5xHNPzhXc8bMBagYPnKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8na+18KrK2ttOVNhKpTlfydv/D+3rwQvsgvmKljp6c=;
 b=QvmqV+Omt5LnQFt5vrwelge0pBOSwwKr/nTZbuAIFdRe2Go9HZsVa0YAz23C8q0tS5MUesJI0P4iHqZbVj6hDa3bP4tYa8vnZ7H92ucGtvkDcX32KsKNGocD4T/sEvLX9XmL6IEXHyyPe0Bkm616U8itQBC4VZ/XMF57s8XE6e1tCIV+JaRBAnZbbam56FSvT2GvtyYpOldD5Qa3MmfVhhGHJ18yeSxyalIRfZ7dMttHSbntk9Q6bkxw6mPqdpbBu43koJMpkqyk4hitvrzjnHGkWnv2pJ8vBpbhmSkkeh5w9yivlEaCKpQxQkHVqHZvmQCo3YqkactoAldk86BEvQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:23:31 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:23:31 +0000
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
Subject: [PATCH v7 net-next 5/9] net: dsa: netc: use entry ID instead of pointer to track host flood rule
Date: Wed, 11 Nov 2026 14:27:49 +0800
Message-Id: <20261111062753.1397582-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
References: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 0187a1b6-ae13-42e3-3465-08df3fbc4e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|921020|261026121527099003|11063799006|261026140227099003|261102123227099003|261021123027099003|261009223027099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uOFMq7ZEA2BqwbLfwXtkCBhtAOrcCYjHjIT7ORhW9d3h1xLVoEeG14hV7tzOLtxgXuyWdE4DUs8pGDCz7YQdGq2KHpwenErnOa0qtYgQnGyKP163o0SioYRh9NSbH2j6mZafZU3qTMY2ZdouVa6sDjIASxm1Eakvsv1vzMMbXLVW5k9+PVKoPwGpQ8GSDzSfq9XtC/LeqU7e1eEX7cXu0c11A8SVvTUlMmrZC06jJB5x2rHg41ChEtf08FoaHRRvz0bD+T0fZzhg9YTnNI8mBnWimsP3DVdRKkm1FIOOLm7rUvjTmIhf0s5XlvhDgDPbpXpK6zw9cpzhoPivAtn5qoDyT7nefYoNVdlCKzj0X6Sndtj3P1PQpJtAelYlenr0LRRo8AVwzlouZ9kS3LzXrY9Phu8MGtrSqU7hExuH+zYxrJZyQD2Jylb2amO9nYznkOJ2/0E3xRM6B/1FFZaAgCV6WbL0ZP7vAfxkXre44mWj+EzJ8zC4Seq6lkfEG3+8fOEZe4EebPZs1/gSAtacOsPFdYT9lNQH9naqt8uPFWMRxTZqoPDwPvWJvBWRjL6pVr+wkr2Kbcs4Zzqe2aT2EBWjtpqfiz/k+V6lGr+YI/7ByhegiE8M66yLbxPezA+k2hMfU9uvSyw0rxqBXMKJCX3ONOXfUC98hD0dnhZTJpA0Kg8LrrwUP8xIqPPyQQ+mY7VdsrZPlxVp+gK9LZ7W0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(261026121527099003)(11063799006)(261026140227099003)(261102123227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yni+kAeTeROVaWA1k1JmTWejig7bVDjmSU2LO28/mwHvtI0wWEJIgrx+7Hjp?=
 =?us-ascii?Q?4K7RqBJWAKYppHHpPA4cEbf/slN9pImzXS8tXwFcNzlfL2otQHG7SY+LjsW1?=
 =?us-ascii?Q?HrRtrMbSnR3asVkJVbdHGGSn66s9tpXqmTfSrQtixO57YykWGcEl5sXQQ0KH?=
 =?us-ascii?Q?wwu1xJnBmmaCNrz373NzxrzN2U2LGhlJz/07TXd/+PuFVsKBdiWvCzX+vsaH?=
 =?us-ascii?Q?gCF8EbSWua0zmefE52h4ljkh++uDpW2fg3w5PzmXkpxlmbepsISsdu4uJVvw?=
 =?us-ascii?Q?EuycIFZyh7fpZgDu7uRzyLCikYl1HYk+qndCNcL7bUOV4etMQ44YxzBATSQO?=
 =?us-ascii?Q?WxWV9e5ChwgdqsLnDGn8rEIEHGdlFXXqXVwFwbcAUxPPIbB2QiuHrk7JTp2s?=
 =?us-ascii?Q?iFl5sLLw1p1Os3cVSusCHMK/L9zLKLBA5exB0WUgDHox/MFAQELgJoTaFl4t?=
 =?us-ascii?Q?QLEvWxFr9vV8zQNCSFxPRc+1PVkMV8C508KTrt9CLr+aynTL/XfuY3ByBftR?=
 =?us-ascii?Q?IwAGEDIKQr+kGiqzeFLbJmLbL84IS8u76nC9WRA0J69HeSgJwZTfPhCYffVa?=
 =?us-ascii?Q?YzV5SN5Phaf0wM1BfeMfhfuXxwen5103g6dXzhf7q25twf6gRQgmN3pLrnWU?=
 =?us-ascii?Q?a2e7Fu1H1AHDNlurNjru8a3PgsK1xnrYMAfNCbh78QMH5u1PYB1XJHNkyZYy?=
 =?us-ascii?Q?In2HaBU51skz+/LJOIkQts6zH7bnIt6DMJANU7/tqtZv1311oGJkOmH039iw?=
 =?us-ascii?Q?S+WvAswrE0s6oJnVXWyT0ZVnhpZ0b57dPuvEev18tzIyNHGTUhETBj6PPIQl?=
 =?us-ascii?Q?qmt7XvhXF4UPHOMtySr1ddPIg6f97oLy74a7iuQ36gpTg+Rf3vYVKzV+PxO4?=
 =?us-ascii?Q?S1QrE9Ey91w9VAB8D848a+rGrPsGjji9aFfNG5wo8hMxqGft5YFRmjoymA9i?=
 =?us-ascii?Q?Fn7abtruc0H45hkZImVJgfyQIwaNOe1FJOIr6ctMl7Cpx39sOOYTvOFSc2LZ?=
 =?us-ascii?Q?fXuVzQK0S65b4oSrEZsLx+ZPhzFD25xNTIOvv9lXd/u30xU8iXaYXZsBHuAF?=
 =?us-ascii?Q?05+QI4OO8V5ZOiw+SeITvDGvFlSdU95YtBelbHEU3kmWDsmo+HwWx8Kemn8q?=
 =?us-ascii?Q?qaogmhLDQ53kcHyZjxJYGSJuHHNqecnHJhV7qxTLyFntm1tbVZTIjWwVK5PM?=
 =?us-ascii?Q?/Uq0ZcPWZml5teLbHGogCJL8Yox2VHf7s31HjDakl3y6cr7hKep5VI7OL8r5?=
 =?us-ascii?Q?ZrMjmRHQeQfnH3m0yXIgZX9j5hJmzxK4EIxnnHrU05OiXXEdJmlyr8FN8lKK?=
 =?us-ascii?Q?nxjbhWmxUjv//tnzkTWWU5mil/Hvipj3bIu0l90c14ky+w3EqBdASAoQfqJc?=
 =?us-ascii?Q?8hqVPaCypjc1pSdo/TOK73Yhi9EhxtDqDpbqd6eqB1IRKUKTiDRdWzDGRzYO?=
 =?us-ascii?Q?oBAotxOa1c3v1e1dzOuOsU7cXgwj6U/8DjmCVtX9Xp98dpG95J52vYD+Te5w?=
 =?us-ascii?Q?NR8Ufw5fKPv/gQXhvupnWmwpyho68AVOvqQQL5efVGDZA5jBs7kbM+1PAQ9l?=
 =?us-ascii?Q?ESfdxKmisDBXCHze7v3xHFgylZUO+j563hR9PXTZWCwulzh6NWvv5WrPMJMc?=
 =?us-ascii?Q?lsMDgPyBRJNlSBRzBLZ5LdQ1PtwzY5uX9C3tjR05H01xeE3AG0SDtct9lHbm?=
 =?us-ascii?Q?zijVFOF/84nj7NiGrmQolESA2GZuSkII9ivH4dI7iFR6yPEzjcYqPf4iksAc?=
 =?us-ascii?Q?aZGF/hgZLcIsKYuytgB/H6l8Xbc55GRIPPipJFN79eoQ05Fy54Hr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0187a1b6-ae13-42e3-3465-08df3fbc4e17
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:23:30.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQk44+1a+f0RlsHLySGGFuNVOS1UlVlNUo1TU8+1CLzQNZiZKQkrISTIHgBV0ocuyWcxYIJ8/QooM6nUf9zF7rin2l8/m99g3YJLzISTIytE3R3rPlMe+1egMBT5RvD4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543
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
index c291123f5317..d23cfa076e84 100644
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
@@ -1052,30 +1057,12 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
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
@@ -1875,37 +1862,36 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
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
@@ -1916,7 +1902,7 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 				     bool uc, bool mc)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
-	struct ipft_entry_data *old_host_flood;
+	u32 old_entry_id;
 
 	/* Do not add host flood rule to ingress port filter table when
 	 * the port has joined a bridge. Otherwise, the ingress frames
@@ -1924,7 +1910,7 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	 * will be redirected directly to the CPU port.
 	 */
 	if (dsa_port_bridge_dev_get(np->dp)) {
-		netc_port_remove_host_flood(np, np->host_flood);
+		netc_port_remove_host_flood(np, np->ipft_hf_eid);
 
 		return;
 	}
@@ -1934,20 +1920,18 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 
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
@@ -2136,7 +2120,7 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, vlan_unaware_pvid);
 
 out:
-	netc_port_remove_host_flood(np, np->host_flood);
+	netc_port_remove_host_flood(np, np->ipft_hf_eid);
 
 	if (atomic_inc_return(&priv->br_cnt) == 1)
 		schedule_delayed_work(&priv->fdbt_ageing_work,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index de2af536c594..b0e1eb462153 100644
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


