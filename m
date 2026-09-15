Return-Path: <linuxppc-dev+bounces-27428-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DF9C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 14:04:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkkKH4rXmz2yln;
	Wed, 16 Sep 2026 00:04:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789481059;
	cv=pass; b=di0eVliPAHcoK/4v+C/46oV6qkogX01ayY/CnOJn0GcN3VKAq/cCv4G4YzCvulXpG6gTCDzA+SqEFbOfUvzHibg/lZv8cUX9Lue/tI+UNi28Wddea8KmXyEohJDyylfbWgjXMs8djGB4KDWvk0zJ0nGj4QuSkzAI6O6iPrbxUbxh2u+pySDB0ukfciktY32Xuz1BjxchSUKkKPfMb9fhUZOmZXwb7uiKn1ArQhUwpU43fOGjyKTo8cFh3cqRaCGXcrACZ0yBmsIT2SWVAXggtR1v2vPvZFh4HnMh9ZqsRRPtj/EsgKtfvyYbP8PMby1SlAqP8IxIyVgu+Wiu1k8azA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789481059; c=relaxed/relaxed;
	bh=3AoYDYQfWgV0a6n46AilCFtd7v355ddil7KDA13jwRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g0KUT4aYhXZPOe5ZgUG6ILjdJAueIgYLg8O+uXP6yQ/zXfSdDY15bBn7r55Ms5gDvcUVCjQzxaSYaBrCETQlta9czOn3YMXy0Lh08odM8M2HMMOOB8OYEFwVpDheCnGNM585+7QTNuiYeguF+MpdoAX8McsqrFPwTdoqGFWTdEpahWh+Z67jsxMxYUIDbtYPDtVUU5rFJVrgWpLaSO40JB6GP9q0hwjjQzBZbxa4cUKwP9hJnvu/krc8Lqcv7A0wI3ln9AA1OjwhcFZqaCIrKjDHy+RL86s+RmWhjTw2cHMI2HOUXSoFW19v3ppA+LT+Jbi9dqAFqiLVsTqOWy0dWw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=q5hfy7WA; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=q5hfy7WA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkkKF61P4z2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 00:04:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uF01hoDE15X+5r02aXcWmKedIXTfipRj1OT99xPNFaNn9GlkesUapXAXmMO4U38wCpmyJKJwGkpOIa/pj+AVakeBLU3YBPlJsI4iNK8oCAnhd3MrCBYCHlnA0kWWojlmsV+YKUBufdKxa+/F+wPdN2LVIOOHkK+GqsUvhVxBb5eIhY/0Ohr4dd3yO8j1haV5amYwaQVOdDmtVmndk8KMxF+qhqpXdo2TSagC0pQ+4/QiXv1F7RvxxEGt3MYTYpu9khNdLYPvNXXdSQHsqeiQDexhcKwO2SdXKJ/2GtUlW9pehrZItUrJktNvhElb73vl9hYxws7L6zE1PcjG5M4J0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AoYDYQfWgV0a6n46AilCFtd7v355ddil7KDA13jwRM=;
 b=KtR4RCf8y+ovqslfktergmvOvWCvedvn2h3kW8fcXPKb3/xhVwzUtwyTRiosVP7T0c2HmYLvUCpWfj+3t5PyWFDYQa6Ujh9WraDHfDBzrTqExcrHAP5t0Z5AcJ7DKI6gz3IO4YAWa5QsGjndDWlcz0aNdNZEH4fKZQRz3+d+HFgCTtfcFOudBO3tmdWu2QgVVKpx4qWzZuqn63tvZ0q+duNzVqUE04DhqkMnsc5fSRlDfbgCFXllY5vqrdSgRCFbvnpafS/SY9D1dxO55XvOZ7JTHhnkUezWzM+ezyg0fTRh5tv8nO7R5rVUQC59u3Jxh5K+1LQEGZVim7HDj83IaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AoYDYQfWgV0a6n46AilCFtd7v355ddil7KDA13jwRM=;
 b=q5hfy7WAXCXsk2cPD8P6pyKSc6m+/lfr5Ct89np903ux61ouYxufYnLU3J6irdhKGjUulPpnMIfDQYme+UtGeypdxu4x05DYHMuYSdtlJ+EkvyFi896QpPvJgqHE89wquFYpfloOUEcw2NZQ6PNk/HVH8fnoewbQ3rhmDkMmjn8nAZhmxNwFrwyzP9XIMLjzR/Msll1Vv5eug7lpVRMctsIPq+UoehoVxTm/1EcpAlmjfZUeNaf2+Jx40Ur7hFurUfPitPFBiGAIwsx9/Srl6L2s561DfVHFZDGno5hCdsKcpwrRO725vrrJ6/IlIGztI9EgVQoN5eZXFrsr5A6gYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBAPR04MB7384.eurprd04.prod.outlook.com (2603:10a6:10:1b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 14:03:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 14:03:54 +0000
Date: Tue, 15 Sep 2026 09:03:40 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Tianchu Chen <flynnnchen@tencent.com>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v1 7/7] dmaengine: Remove deprecated
 dma_request_slave_channel()
Message-ID: <aqlQPA8Bhf_F0ND2@SMW015318>
References: <20260915100931.3593242-1-andriy.shevchenko@linux.intel.com>
 <20260915100931.3593242-8-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915100931.3593242-8-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: PH8PR15CA0021.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBAPR04MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c37b006-4506-4b60-9704-08df13322d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|23010399003|1800799024|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	EsByQicsKzNVsyk8K8Qml7v7+2hwrXXVi1DzC6RbeRfRmJhBjLFRhx6JbtVuzdG6XDfDGXA3oisT/TjDGbi0GepA6ieC5rFh8WTti5AnKHgSDZA1TmPf87G8ylKgQEdR3FnqjD+kIp2l7Cxjc7jg/uyD7VQNhB1YvAYpuvRe0E2y26TZ/lGpq/GOv6usqSBE/MLnKzNOWnuhjkisCR2kzmqE1OHDnIAxf0OWyIQtQI16837nO3i1kqNHi86F+AzLyaJIsPYn3XNmfoByLER56B05yO3jyfzmrBUL51KJ+PhfkM/5XoJ932EB+7w1URYJHzbgn9R4X9H6jjJZlnAHgHpTX41pRdL9gJO3b0qlmwjBU4L0/1mrCNsCExLSrbyqe8N5a7Bqz3LZpm7PMbq3cYearUPJWX7R3eUPLyQuffE07ZcQMHl4hqGjp/CBpc6Hu9b8LHSplJuidwkGADSmVu1w4f9Q77JxWpDluphskA4dZNBycjtzS0birF1u7X3/w33TxikMthkeZWOLkCl3Ryx0HJaZzE9vkCz9XAmoWPL9v+N1qWT2RDX5kCuT2zCdy2ztzYpbxzMcd+YySxqye2g6e1zA0pZe5g8oApQJWcYSCFYXdr4pGGtZSJksoKiIpyFC8ezJLhBKpKQXhz6dqpQF6bJzdkmzfNMIZv3AccrtBPHxSsd7gsGDR6Pw1Vi3qIfncBWYiEVVPiRdmLHp7tBw6QB0ujhy+36XUQqRc+I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(23010399003)(1800799024)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5GEEVMySrd6/uViMQpOqbEUOJ1Hfx1K7ySC2NqQ3EhDT7oawPb7PXqeVvD03?=
 =?us-ascii?Q?XrKIz+8Q5ifHBL3wqPKzTsJDJ2OyMdPjt9zxWigwbzvAFKVpuuvpc5v31o9A?=
 =?us-ascii?Q?NgkwEVM+uNHgPi5hcwc1A7wP2Y4tBE+I57xzvg5zE5WXvxCCWr4Mi2UGioj0?=
 =?us-ascii?Q?DfgegMAazPQ5CGJWNcS+nTrQw4Y1ou+Jj+HplGbLUGx800wmfrxdteriaLgt?=
 =?us-ascii?Q?xMSljMVJtq8HoUL/26bYn1j6GpcHDnI5MjzkQ7KzyHt+AYzWuFUcbqMT5D1x?=
 =?us-ascii?Q?xrFPrTMYCkI/iXPVXR6NjffMyhmL64LOfLhPZDqCTnaci1A3OQbYTTj30IFT?=
 =?us-ascii?Q?uaDV+OJ9LWxYOE2lxwo5wBv5V4JG1o8aa4sAnUI6qGDDQxAV92ishgDpEgAZ?=
 =?us-ascii?Q?Jkp/EVkE/HWEaC/FKsPPypalJmTmYFG+J/lmHoBRvS1Pi7WsWujK9RArtQgP?=
 =?us-ascii?Q?0v5K3KzoPw+aNh9JSQELfzYGP6QwC7EzVyVmvclA0kJRQh+asb6627KBMPQk?=
 =?us-ascii?Q?gLqF8XD/D9/N/dsF/Cxp97EYdPKn3cGnme0QSEQQ6UwVsXfT8zDCFKb8YOwN?=
 =?us-ascii?Q?rfckl/5otsHDcZVWUXNYIbPA9VRoT7zsjvqLmyL6iBfmZaNeA6zZ8FkOKDe9?=
 =?us-ascii?Q?Wc2hk8gpiTCJPDY50cyQRz5aFWdB3/itzsOnzKtyhYocHHZw9j11oiavilUF?=
 =?us-ascii?Q?VVXJ5rfiuZp8onauUxb+1albTD3LRhxQT2iW6qiw+BKwVrTxO/dK5C2SY5Yy?=
 =?us-ascii?Q?Tf/Besu63P6PAhs8jfmeTq7BRktkHDtvN4aoBbHC/CWNpLYS7bfs4GKz1m79?=
 =?us-ascii?Q?A7T4jjFvshvFqM6umeJAoW1Rl6WX1G5coIlSydHy0D+XwPlvVij/AAI5bN3L?=
 =?us-ascii?Q?XdIR76YVlzo/y/gDSwUE0ai3PnK/QJtDBMaDunFfz2y+STaeLp5KL5AhHd9P?=
 =?us-ascii?Q?VcoJVMZg5z9oZiPp5zudP7yvbW2jYT3lZ1QMI/DammP9VPaITif/QUYi9He+?=
 =?us-ascii?Q?okDEV7sYaK85EVmzh4iao2jtRIvDu3jGPbXPPbCi9u4W4ijWt9nfaDUWA6bp?=
 =?us-ascii?Q?ecByb+u3qOPD1ZJn1AmDpGo6jrg5KW2ivurvvtf8KGZybWzlwWO1tCc6H2oU?=
 =?us-ascii?Q?4E9Mkc1IcfnwrT/sbIrwGo5vu7Yc+AIVuTgvBl0XwueOO+R+dBA8XFjdjs8q?=
 =?us-ascii?Q?1y+9N1fQu3xohClUn/jfA07+vdnl9B1T4Y3GralIOWKIaMgKmc6rYkOnrGr3?=
 =?us-ascii?Q?O1t4aYsGA8RF1sx0evefKDC4rgoORpSHUKfCA/nHSSKBjgPYBJKi/lrTHYKo?=
 =?us-ascii?Q?eldIzD9aZnFgG+aaR+5t5fOEGf8Qzik0PFkQoQAjncxL5KnrrvxG8MnzXncX?=
 =?us-ascii?Q?dE3r8Yee9W3THv5nJ8NzWeRyZe8FpkJUsrOjEN5muufH7Do1MOxu5pNcSawm?=
 =?us-ascii?Q?6Ea35zqIZzj0SLKz3Dc10jxJKz/l6nkP0Af9DPKlWw3n1xpULexeTJiQlos/?=
 =?us-ascii?Q?k4lMirPRZ8A/bPnE7wYEjjUz2Xwi5qoTSY4VfHcpL87ZH3Waan6HDio3rkEh?=
 =?us-ascii?Q?qEnznwi16R7D0+zgdgPY7xOFm0xvI0es2i/5P7vWO8Ka6yBTSwBf/JMl7mhj?=
 =?us-ascii?Q?lqOjOmh7ddfVq7nW6Et69PjY+AKA3VCD4+GOWCjfNzkWWZa+jO15nayCZY3Y?=
 =?us-ascii?Q?YQAQaK2ItnNwuvhUaYKomUKxpOzSPRc2UvfryFYbyIBJODWRTQwpdI8q/O4U?=
 =?us-ascii?Q?VY+EH6wvUSLBuKMMCUvX09DDmB9hHlt7VGCyCXJhc64HYSmaxI/A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c37b006-4506-4b60-9704-08df13322d35
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 14:03:54.0556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPNkjtAt33sciPwj4dj5hHP6afIGMb0p97hnqURMymzX6d4HwAJymqvasi7plW/zOamlofEE/LF9Di/jPvwGYDPaviK++r29IDBh/6g/evTB4+hLu0sJW0IVJtAjyVuX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7384

On Tue, Sep 15, 2026 at 12:04:28PM +0200, Andy Shevchenko wrote:
> No more users.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  include/linux/dmaengine.h | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index c50497ecd52d..7596ebdac466 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1763,15 +1763,6 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
>  #define dma_request_channel(mask, x, y) \
>  	__dma_request_channel(&(mask), x, y, NULL)
>
> -/* Deprecated, please use dma_request_chan() directly */
> -static inline struct dma_chan * __deprecated
> -dma_request_slave_channel(struct device *dev, const char *name)
> -{
> -	struct dma_chan *ch = dma_request_chan(dev, name);
> -
> -	return IS_ERR(ch) ? NULL : ch;
> -}
> -
>  static inline struct dma_chan
>  *dma_request_slave_channel_compat(const dma_cap_mask_t mask,
>  				  dma_filter_fn fn, void *fn_param,
> --
> 2.50.1
>

