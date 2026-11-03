Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E83606A31B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=IlxFFahJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK55D36gjz2xKQ;
	Wed, 04 Nov 2026 10:54:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c407::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793750048;
	cv=pass; b=JDZeBfT5sI9tlD7qzm6g8Eg6t72M0ySfdbyddn2B05Txl/zaNMcCGqrERpg2h4DnHh0AK2I3tlk4/XiY5Afrw6zpBG/3C3AG6yfLiu2IGmujy2lwmLhd+V6qh09YEOJ+edidNBfF4YZT9OhmG0LBKrQayAGQas9LXcy0o95zxXn5/xXyYXFv0DUuMjDPYWpEloN+l0NhwUEmAdX4rRH/epXPgYJwS5sPKRAinPRrI6DzGHYSNxBNMueU6oM5bP6HAYv1LRsdygTOfAHrliK1JZpcSeJ9wMEJNdVkUEpxxlYK1F3niUFRd/ryn2ZaqJtz44hjDJqr8inK1ImL+aNcLA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793750048; c=relaxed/relaxed;
	bh=nX80z1l6oUMRrfePQs074KTjVnoEZIh6/eoNAzQTRDs=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=DJbVREEoKQQFedCltzfHdXMYpEZdGRZ3qIjtk0ZhFQ477UMFo63DE2JM/jKfCnR/5ss0vo9LPnNqkd2jWFp4ZMP6OuBi2tOvE5LboQwQfBbPefp7NiA5E6TsTOtp7AloE49KRMW3BG699C2z2jPfqxO2DTBw2uodZ7PWB64LAe//3LYbTLDc9HdVeidPsR0YPTu2EuWO4PGgI7dYD5EehzuRV+rKaQFD79lTj6B4s8g3+i2Qi9o4v34hijeALn7IDx+7Lqfr7IFvFLf7hT0FBXS2mB3fB7SU70EdFtwv30RDlpUoN9hQ3AhPDUlozJ4RqgyhaqMQvugWd9V57IMkDQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=renesas.com; dkim=pass (1024-bit key; unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=IlxFFahJ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c407::1; helo=os0p286cu010.outbound.protection.outlook.com; envelope-from=kuninori.morimoto.gx@renesas.com; receiver=lists.ozlabs.org) smtp.mailfrom=renesas.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=IlxFFahJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=renesas.com (client-ip=2a01:111:f403:c407::1; helo=os0p286cu010.outbound.protection.outlook.com; envelope-from=kuninori.morimoto.gx@renesas.com; receiver=lists.ozlabs.org)
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazlp170110001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c407::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK55C0hjwz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 10:54:05 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZklXvAZdnokOG9ci6Wq1gmpZ45DMUT2nSvnxrUIdVPrBIVeeECaP91/7eMBjimFOCT8y9m4jCHTevOQmONEm7m3wzolpDWmdXGS6cxYxvibvzKAPceQ3lpjy4Je8YezK+id11ig4AFeh/pgm9/PAm2ReEEcMVXQ3bEBLsaIpLQP3o0c2rrthY5GZvg96nYmsMNyy23I4z7v6ua4PScNIpegYnWYF8bijHkx52yG4Bx1SMzp9R0NTI7PMMXN8cNWsmaWJkyRxHq94/jotlBFK/u3tq97lXFffgPwZh+ir2nBnebynWqVTaQjY4RF+YBiQ1xMqWc+Rf50zJjrCkehZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX80z1l6oUMRrfePQs074KTjVnoEZIh6/eoNAzQTRDs=;
 b=wAu4XJ3FPzj0Xii109Oatx4G1fW8IrQi3lbgdJ8q/mQ+u4/L/Nww2rJL8GjZ7o0AEqwgk2n1EBKUEmxs44MjE1dxhYHmITj7+ZioeteDaBMVnLsjqizpDu/GHSLka5h7DlsmJtix5jehowuHeAGaIva/PjBGKVtCsHGTgLKaaA4HjMgPsMXojnNdwG5AVudCzNgQyBO71Wj7S5KsxpOEUB9vUzKoUBdLzc/MKLf0wEagpvZO55NQIOslAgDzwaSTgfUQVV1vPCRt67d1akVW5Qw59P/lORnmvy4quxJg8grV0vuSPvwBbMOVij4VGeVIecvdrKC+mlmnH1+svuaPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX80z1l6oUMRrfePQs074KTjVnoEZIh6/eoNAzQTRDs=;
 b=IlxFFahJRV+NqVk3IsdlkQ82uVhEa1NIwjzHxFAZvOzfuW8mssrTZKNGEErhmNhBrVYQ6foiIPZKTJynL+qaeuiJdCkjDnkaEbju9+u4wWlJewhsAL6dNcLu4O3GBRhhtHNbYuZs3V6+lIi7rtMRyM4lvXrzwMwnUWUocX+Bl4E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYYPR01MB15175.jpnprd01.prod.outlook.com (2603:1096:405:27d::8)
 by TYCPR01MB18334.jpnprd01.prod.outlook.com (2603:1096:405:3ed::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 23:53:41 +0000
Received: from TYYPR01MB15175.jpnprd01.prod.outlook.com
 ([fe80::9bfd:a110:68f1:134d]) by TYYPR01MB15175.jpnprd01.prod.outlook.com
 ([fe80::9bfd:a110:68f1:134d%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 23:53:41 +0000
Message-ID: <87y0b9320s.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Frank.Li@oss.nxp.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Frank Li <Frank.Li@nxp.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tianchu Chen <flynnnchen@tencent.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	linux-sound@vger.kernel.org (open list:SOUND),
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS),
	linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR & FSI AUDIO (ASoC) DRIVERS),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	imx@lists.linux.dev,
	vkoul@kernel.org
Subject: Re: [PATCH 1/1] ASoC/sound: use dmaengine_desc_set_callback()
In-Reply-To: <20261102180915.3981805-1-Frank.Li@oss.nxp.com>
References: <20261102180915.3981805-1-Frank.Li@oss.nxp.com>
User-Agent: Wanderlust/2.15.9 Emacs/30.2 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 3 Nov 2026 23:53:40 +0000
X-ClientProxiedBy: OS7PR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:604:257::18) To TYYPR01MB15175.jpnprd01.prod.outlook.com
 (2603:1096:405:27d::8)
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
X-MS-TrafficTypeDiagnostic: TYYPR01MB15175:EE_|TYCPR01MB18334:EE_
X-MS-Office365-Filtering-Correlation-Id: 4223f1e7-c029-4356-4dbf-08df3a05afdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|52116014|7416014|376014|38350700014|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aJmDod4h5rvdbXxxt9DpBE3vBb6on6smk2a5Gurm2WeVbwciEfjLPTkuVIu8i9swqFbg8kNFsyqZWmSFmSlwwF63kkWWW9qXkaJIxYFOneemNXs7uFllaGFxWE85bjvUPH84Xqqhs9YevnI+rx+GfJEqvfcbi2A30lfnLnxPkrhOjjrH6wYlFgPVDlSsfbPKS9Wdn0yuzzzIkJP0GzSZX2ZTVCxn68CgA4Ud9wicKCbpGkxr2/Plg6oSC6aYn92ne+Z4rQWqSsBUu88+XC9VYGtcGg1KzhctOYcEocVsPECSCVXGzQbM1SfLYOtEARHOEIJX9aW4+soljni9jZRL8pGwrSMm/+Gt2IcVgMnkXb6yPcSJCpb4j68pckx7VIDrW40n46PbRPpvPKqHDi9zL6t2QG8ghCAcTqYZOFzTQuWlemwenHTBuwbHOIBT1JOhlZ17WkfJinDWU2xIqgbUqxV+r2a/498BlBZHoDflPS2L6fUfkCtemSHSwRlxSn1Asyr9V+eqdjrr2g4Iw3dta01wutGVL8fD8vrekJyOc6DMO0BkMWHJuTd/uuTMWyzq4X9xuaO6R38teMY3ZXk7qsDoJx7tYaCdwX7Oy+2FnS80JibdmxfGcePjhWpbOqdz4c/vtik4QjoNXItmsGs8Pnxf6zSsXbfP8a9GPUfg/LEwQJVJ/mHN6AAMbigzg/HQFtwZOJMYpRTxr/gs0IaZ1VbyFerYzbCvg++6J9a/C6Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15175.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(52116014)(7416014)(376014)(38350700014)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0hu4O+BSxUIhm/8pYiKx3LEikF1g3RxEbtrWhWteb+qkeS1Bi0jr3zST9ufY?=
 =?us-ascii?Q?n7uD/xCLy1YixKAZfgaPkkvQK5bT8YzO4OsJXooq22XUlbj897aTwd0unOEQ?=
 =?us-ascii?Q?AmAERuHPZsJrJO3rmNBzrP0nujE1JXDS8EHM0cunMNHILoz+Q4QVzV+SKQGi?=
 =?us-ascii?Q?zXXn0NpgLzjg3hNZgRACFBEU9lXJ2wDy2JHwyOPxZlImLMzFSOtWsz0FcT7n?=
 =?us-ascii?Q?Ntd52lojNYT99qkuUZwdAt+mnrTvmdsP/Giv+I3LFCIyELyBADBn2ZR7tkUN?=
 =?us-ascii?Q?KeERs8qw1QiEqD40+mKoBw13zrqjIIQe31YGf9TevtAH3UBw9ySXs0MhB2nc?=
 =?us-ascii?Q?0/yLD3NlZPK8J7XiPOVvE7Ia2+pQDApnr1zpUCHVIjLRM1fj7Tzoms47cEHq?=
 =?us-ascii?Q?cdww3BC+b9t+8P+Kr3O9jtGcBQu4xjQVCB9KXSJriyL1kdnBLD1GrxkFajQ4?=
 =?us-ascii?Q?8NCtzpLgYKD5pdT0RYyhY6M84BKlwRGMsbKCoLkwCmLlsFR6BmWRLOI1yRxA?=
 =?us-ascii?Q?tFq9deAK1U192d+Ua5dd+mX+pscHCR1a15MSOvw8WEjc0rM7FJ3jSS01qz2G?=
 =?us-ascii?Q?3esdAOaSfmswgX99DgU4kxMgYD/sSSNF+Sn9FnDy8Q5cInb6jiGd8PvREnNY?=
 =?us-ascii?Q?XSBCHFIfjUUVnkt0wOBhT0Dd/5e8KD5pBV6w9Fezm5LPsbSNDGqUOU/ZWl0d?=
 =?us-ascii?Q?ApGAY39jUhtkQ9CEMFoKDi01CONbXDL1iJ+pA7IRrErQGaRPZki+bcsCMwoT?=
 =?us-ascii?Q?m365h1ZA6erSDfY7PD3d0lUWcAPfT1+dcXscGynFHBjgzY27qXc+yL8QLeMR?=
 =?us-ascii?Q?UUwhWzL1FTskL8B9fbWl64sGf0OdlzQ36e+VaUzslrKbYfT5PPfq+UNdl+aR?=
 =?us-ascii?Q?gLGPwgVMsOwJnygwI7AZXQBP5lvD/s8QFZuKOozSuKSPfFFNgbTJdOKn75Ty?=
 =?us-ascii?Q?ILbV2zAAvvmBTewhsrGS6EA0jCiDJbY7JxTbkWluvyCixgvRTI79BIt0d0Bh?=
 =?us-ascii?Q?kml6we94yKQfkJto7J4atyPIwmaGfOBxXURxpc4xz5d7Ox8xPBNLjE2QzVKr?=
 =?us-ascii?Q?mvTuNfU0KUTdmqdQ33NCC+wKNPTqi6q6naIS1tX5464NUlqjRdulnYpAgZxQ?=
 =?us-ascii?Q?hATuDJmb4lt7PeR45FcfWU8IvAiONMtY5tfkxlY4lvaJWlW2fYCVP9nkAysB?=
 =?us-ascii?Q?WLXOkVUVl6TGgEw4xhTmobAB9DZ/RjycM8QkxOMIQ3VQnzr8fzGrQowJhVfh?=
 =?us-ascii?Q?kY4ODdpo0SYbsj3QKzprDU9J/Tl5fedljzZ6kH6z12stPlYsGZbB5bIHGXxg?=
 =?us-ascii?Q?WF3PiTKtJF8PegyJpegKvv4T0eyEa8kw2YPfqO9G9YZw1PwxdO7K8LF2/ePw?=
 =?us-ascii?Q?OnMBJtDtpCsXKmOFEIRy5qeSF55kTkMbf5DAN/qXxP1XknhiTaSi18PEvxbq?=
 =?us-ascii?Q?gb3DIJBkcAOuN/z5IHdwBivAi0FwDyhPF139GnHoW9SinPUfdH2Ygc3HkLka?=
 =?us-ascii?Q?IoGHHfJNwB4EWsqyj02qH5of/BDZ4dQo+0nrpghnaot33RX1zmzHrwbGGeqA?=
 =?us-ascii?Q?5CY06On0+dCKkJjgAru+qqpJPeDbqiDBe8EhnjUs9WVSMahf+rrywz8QDbpX?=
 =?us-ascii?Q?FXtqxac5w8JUrQ2cfVwqyE4tDAj1neRBGYehFODznt3aDtAPzmzdJ/FT/MO3?=
 =?us-ascii?Q?IZo6IuMhlvo4sNjrXMOTGUKPwzeNEFaORfbTtiHcTfsyYe4n03SJaRvQIDNu?=
 =?us-ascii?Q?qOb5Yw+ghNblllGZ9YE3HfzHCw+Xhsg=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4223f1e7-c029-4356-4dbf-08df3a05afdf
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15175.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 23:53:41.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJ5rbMIXgxtb2klT4zrE7gBX/FSPSn1lpkXP7iJDuouE9TGkLOE14o0v3pJ83Fe88wruINh7ZZPyMtN+gMMFmd5bbN2jVJJt+L4mgMz3z8RLki7td8BNU2lAE9VheYmd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB18334
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi

> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across sound drivers.
> 
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

For Renesas part
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thank you for your help !!

Best regards
---
Kuninori Morimoto

