Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5C606A331
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DSj2pJOz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR9QW48Pxz2xLr;
	Sat, 14 Nov 2026 08:30:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794605411;
	cv=pass; b=VN6wyziESZCReZAR5q5Z1JEbpZ70/Df9L6+Bn8i2lUyzmS0TPKso5PF2J2pt8WoT79ckPGjITAVfOHmCA2rH9Lr/b5n09nDhrhbbdlejB6jO9oW+xFmVRZxA+NklxZ7HQPxoAg0Le661iHPDf5Coxrap6ZsPozANcSc324BWRnlRgxaLjAmepV37ZnEg9mmE/SKP7YaVzVU//7RX3JTmRlIbJkf1d837UaM2CVlwHjAlmuFp1ImmlI/2vBQJX90rbbf56+2QF90fskz7kEcjwddaODj/mr0Gbpx/5Eq+oVenzlG399nkg1nGO4RynJ8xHkzhja2lah4xE1rcfh1EZQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794605411; c=relaxed/relaxed;
	bh=UPLlBhEFkzCKdx/9gg1lylf9okJBK3VnemYGQ3dag7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RCxgSQkGpFx5SijCSvMjlCT6ogab/wkNjr/SP+PiDcKB/8VCSxT9/fB4mDU1/UxWZlA/QjAFpVwwsckB+XCEqGm5zgj9A3ZHGdeL1n/unZaRe25SF3t4DovK5DNobCGjUiA5Ewo5kG7KcVUfycW3tsaYxoPptZSkQrrKgb5m7K9PzdvFTYbiV26tX7C+SKflzP0m2K5ycLq6nvn3ZnvqOGPX4bybYXla18VFrhCvI2E7OViQeY2/xJGXzonbcvOlUDEKGfio91gqCTR4Pn0QOKLyTslTrC1JdoMSsI4Ftdc+BgshzLx4Do6nhDES1sGF/b8PEh2L3jJj6wJGkVnkWQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DSj2pJOz; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DSj2pJOz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR9QV0SBHz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 08:30:09 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tV7JdjmPpe+GSvEDPw6GinjJIwBZh/L6VsMNATUdR0ZrP79JMwGtCTQ0aLACWdtKGzqTQeqoOjz0wFGkNbzPCKIy2REs/4tBmL69ueui56E4ukcZloZVrBQ67ImpQ6rL9VhOwklew9/eTk40AwIsq3GjRAGPhtPSyOEXvXje5gkZPEkMIaL3P26CKaazWkiZ5Ga4BmRFfKOsZNJFsfa1gnjZ9ADPdrU3n849bair9uVFPo0k3N0Ex5P6JiOjec7M/AucU+yPdm+ckkS78GZXRyZWob8ivJzyRzN9vWdP6p8g+eXYx8wCiKdXO1iu4NArS6GPB8zuCL3d8PRgTuup8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPLlBhEFkzCKdx/9gg1lylf9okJBK3VnemYGQ3dag7k=;
 b=Vkfn/ywlksmikcgVaERM2DJ50szSVysejiR6w/s6O/l+M8bqrGf3bL4N0w0T+Wt+dx7b4Ir9Z1xUbcJycS5a2T1zgAdMVWue/N3ujt0HKqepCEBC8N0xgLM0KFCGJbaNw2ED6SRyzttqM5hard4qge1MfFo5jrsisbj3UfIQWz8Xrd/EjEkO1D7gzjDn0BqkqKQ/BHYyR/VRzUU5j9CQr3zcGj6RBgrFWVb/epnMGuhzrQZQhYpDzqJgpkHWJSfKMCKcXuSmlrP57yCt24FhmalMl6Y8jLZ78BE6Ul+oSM7oaY1dQd52nEt5OyWGTQEAXktdc1dahGalrrFGDAcNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPLlBhEFkzCKdx/9gg1lylf9okJBK3VnemYGQ3dag7k=;
 b=DSj2pJOz31PAWsWUbUYIsPBXghyZAZAvJpvktziniubiBQMEbVjR81SXyOobq+NpJLlzxBcFkAmH6L/dLGWRdH8slQgWzzMYYp5SQn9UeILF2CWjzhrLmrCHXB1Ch9D3ta+3ulQJk7lgE4XrRVBDOn/epNAkEjd74dxvHmXc37IE2mj0Iz9XWbIUCataAKSO5MO6VPuoTKFI45QXwtCndC4CQHCXWZzM0p066RHN8paVJnzla3CtU19H/CUWFSmuNUbqYZT8YpQGSV9kXFi2vulp9YYFGplhkYG4nXC7pERl8kpIHPiPJiYzckB9UKjMQ879A+1KLCBO2qrGNODhPw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 13 Nov
 2026 21:29:46 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 21:29:46 +0000
Date: Fri, 13 Nov 2026 15:29:36 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: vjardin@free.fr
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: pinctrl: add the NXP LX2160A RCW pad
 mux
Message-ID: <aveBQPeyjvHV98ZH@SMW015318>
References: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-0-5a0063f1da9e@free.fr>
 <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-1-5a0063f1da9e@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-1-5a0063f1da9e@free.fr>
X-ClientProxiedBy: DM6PR06CA0085.namprd06.prod.outlook.com
 (2603:10b6:5:336::18) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 3658702b-8c90-4f55-ba70-08df41cd3d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|23010399003|376014|6133799003|22082099003|10067099003|18002099003|3023799007|11063799006|261028144727099003|56012099006|4143699003|261021121427099003|261026140227099003|261026121527099003|261009223027099003|261022105027099003|261102123227099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	EojC4cjPh2TLQyVfDDukZvEhpr4THOOTIK3KrNxCw2Fo5Hvgtsv/6H22DYsDCB/DyMESUS0HrquFXATh4Re+rB7BW8ExyuTsyQrIxcKp/Jwpa3DCyMfNpLvtiEwFTZqxp49y8wK0IdFMvgQyHU2NuVF8IS9Nt59Gcbt9LYYk2fclKMdcb0q3yCHlPHdy2I95Mg12aQxoxIN/Ehyed6m4iOx4FbdVTO22sbR/ZwfJWbyVKFx2lzvGNwNhQeQcMcPUYuO9v2lm2BGpHQKOAB4kgaBqnnD4zPxScOl683tPZHC5BKAyqpJCKGj9rpDExl5hAwLwKaKN1Q/kxQghkDM8u/kDKn8Fzw7z5oFjm2kFZcE7SQeshNLqNSGyQ8hz06U4kIMXMO6KymUYsuUgbDtcQxLAAj0Aa/ZqwIp55iAzZglF2//QlOxCNHL44jfQh6fplpAUSci+rFD23I0XHMhBotKmOKOg2IzWIjamqNeRmiFY5/OalhbScLyzqFoYrm/tcZkhveZQL27b/DHM5BKXNvlJjXvc0w6hGudOgRmDv7MPqHbnzXlatfQZv+7D3otU8AppvA1GSdBjtMkrdvj0wkjbYXsP9bxjxZYWbnxOP1vCKfuwwmxj2QEF3GHqMAv0Kzx1rqkNDItUTiIANqAUqZnU4xKvr3QhrWCU78m6ltKW6rYWV08o3616IhOz7PYAa1HoP3aK1MWQ0gLW5olw9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(23010399003)(376014)(6133799003)(22082099003)(10067099003)(18002099003)(3023799007)(11063799006)(261028144727099003)(56012099006)(4143699003)(261021121427099003)(261026140227099003)(261026121527099003)(261009223027099003)(261022105027099003)(261102123227099003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sci7rZ5vLilHe1wVtn4M+a9gIIG8YA4jhlesdVzFfF/fJU+anEeijfiFX3gh?=
 =?us-ascii?Q?K3K4hxY/l7W+7GQcHF1AWqzP0ohmVlUoZwUvGzLoevdOyG3MyqB5TIzRNKsH?=
 =?us-ascii?Q?QK81RhxWusi+gPQ0fhY/5eXTaY/NLSu2GH0fUNYXrL4RdibJAHZ0Ok5v/d/B?=
 =?us-ascii?Q?FN6AtN3DF5SVWMzazUQBAFIpludm6Y7nGEAmEgvr2jDQuaGWMoBsoITkZM8m?=
 =?us-ascii?Q?aIxJjAjVtSmDRaJkVfkRtL8/lX0fRVYTSF0kid/fdvhWUPboshKhN9jvAFFV?=
 =?us-ascii?Q?Od9xV84Tewti4KR0ZWrPX+hiEYq+AV5s7tUFVxZKOuLbVt06N7dra/uBfBSF?=
 =?us-ascii?Q?8oKtysfP+Bf3HW9hHLGOT6hrwW2z6YSmWKnwUYJngp/lvj2lIDSGGZeLjRtk?=
 =?us-ascii?Q?GP4NMfIA9J4m7UNdzBXvVNguPko7gJXj/Tl4o8Zk+/62b9nGcwwO22UEFx+/?=
 =?us-ascii?Q?WD7ufGxxS1SL0ixntsbDXvsQbjV7nYUvVw2K2TrcV1DU95qcW7g/30ofC5VS?=
 =?us-ascii?Q?03HnX6Uq5U0zTHbm0I6SfWYHMVPI/hlQxpTt3m5071lk0sZ/HsFoOzZW4q0U?=
 =?us-ascii?Q?WpF7W7dO+lwYvHjeqtFZ2NvVlBgdwY/0sEx/EZI8XS3pClb/gsNKtuiULjEx?=
 =?us-ascii?Q?y+em92u4aPRRT9ic0z6+D9AdrJmGnLDiw0qtuhoUuYg5y2Lxt8t1LNuCBrdN?=
 =?us-ascii?Q?JXvGZkBw9JYc4C58dcZCS6y5YwVvvL64XXqHSgmhrnpwGsp34Xh58jo3Hepq?=
 =?us-ascii?Q?vLWuCnkU6b5fGYNstpjKbCv6gVdGg71HEYP94R5CbWEZgm63ZA77YpS/kDQi?=
 =?us-ascii?Q?gM7WI6JRJMidF+PLP2QFhbjccoeE7rF36J0oK223kw97EbwInpUfrxskmyj0?=
 =?us-ascii?Q?UfcMJ70l0VWU3xzxeiFU5r7wT9iUrX+PiAsm/QeTyCQx85U4P7NQWZYPjbS7?=
 =?us-ascii?Q?9477ZOPZqq8qSgn3+g8MhamU9OjP+uBPUXw7bsFHg5j5adVwReeK86PBtCsa?=
 =?us-ascii?Q?J1cySmwIFvoCRVi3IBvS5cho6wm1n2UmMMqhoJtQOeA+Il4nfiQvSsKdlKpP?=
 =?us-ascii?Q?/xAOss0M8wob8TgSdZuTE0wczzrXXJsJ1dJcGlZI/e2yduOfRUvih5Dbp3U/?=
 =?us-ascii?Q?oEReZH+aJVs/2Px0SFhicyQ97yt7Hg8VvKoqVLRSlWdzbTU5cD4sIa49cOqn?=
 =?us-ascii?Q?lkKS/ePMmRKEiYbwWPIj9DbBcruYvNghZKAnnLJ3+Dnxd1WG0P8mH1Wq2aZP?=
 =?us-ascii?Q?WmRGrRJKnJETqGiWZ77cgTUSXflGQivbTbBOs9fRrtBsF/hZxQTWUsmM+N9l?=
 =?us-ascii?Q?mnqRYTFpo7ABMIChdeXQrJTGOYLwjvs/+3lY6JvOiB4/MReOpUJrdk/8sDEE?=
 =?us-ascii?Q?bwAKu+8eNFBr5pPT8cJNFbk3hyHrbT7sbdScKFZLNc83Wxe2UF0Xz/5NlWAJ?=
 =?us-ascii?Q?itOrKMbI051SnV//HtngU8FOdC4HQbgK2nAyz7n0H7PqNO4JAc1IM9pPe7kG?=
 =?us-ascii?Q?ui+OKxWXUz0ioKw/XmL/h8BwkKmXTOgdWYqLSbH06DtqJemSafrspH1Cwhkd?=
 =?us-ascii?Q?Cg7eVeC3xSncGwLugsbDtm+PxD/y8L5YzlfdcUdueYdpTkfbUepZr57/qKgz?=
 =?us-ascii?Q?w2Z5JHY1sqEWtyR9YA3J9cVdWo2y8Zi1fmTA6G6S+LpR8VOoP/N4vBpNVyOD?=
 =?us-ascii?Q?q9ogXjGoXGkDkwAEx73YYLWB68tx5R108AypR/hjPogDXrWJawKU7hXh9ANQ?=
 =?us-ascii?Q?1kgoqZMmG+hBn/VlskJaX+AoGTc/jnQ4HnNgNaTVCTkyq86OmSMh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3658702b-8c90-4f55-ba70-08df41cd3d3a
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 21:29:46.2395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEK3vuuIBsqOHodsi/Rf2hkjTKVtACl70TjYJCd9oIbczDPaqtv49674tR37y+rxhQAL+zTRW/scBNE2FDt+AC6MqxgrCqh08fEnGf85QqrbTFmRHlJYtQx9l+mGHb/g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 08, 2026 at 11:06:49AM +0100, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
>
> The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads from
> fields of the RCW: read-only in RCWSR12..14 of DCFG, changed at runtime
> through the override registers of its DCSR view.
>
> Describe the pad mux as a child of DCFG at its RCWSR12 to RCWSR14
> window: the override registers are at the same offset of the DCSR view
> of the parent. One group per RCW field, one function per encoding.
>
> Each function lists the groups that take it, so a pair the driver
> would refuse, such as can on iic1, is refused by the schema.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml   | 264 +++++++++++++++++++++
>  1 file changed, 264 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
> new file mode 100644
> index 000000000000..6bd21c27a00c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
> @@ -0,0 +1,264 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/fsl,lx2160a-rcw-pinmux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP LX2160A RCW pad muxes
> +
> +maintainers:
> +  - Vincent Jardin <vjardin@free.fr>
> +
> +description:
> +  The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads based on its
> +  RCW. The related fields are from the read-only RCWSR12 to RCWSR14 registers
> +  of DCFG, and can be changed at runtime by writing the RCW override registers
> +  in the DCSR view of DCFG. The node is a child of the DCFG node, which owns
> +  both views. Its reg is the RCWSR12 to RCWSR14 window of the CCSR view, and
> +  the override registers are at the same offset of the DCSR view.
> +
> +properties:
> +  compatible:
> +    const: fsl,lx2160a-rcw-pinmux
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    $ref: pinmux-node.yaml#
> +    additionalProperties: false
> +
> +    properties:
> +      function:
> +        enum: [ asleep, can, evt, flexspi, flextimer, gpio, i2c, irq,
> +                reset-req, sdhc, sdhc-clk, sdhc-data, sdhc-data4, sdhc-spi,
> +                spi, uart, uart3, uart4 ]
> +
> +      groups:
> +        items:
> +          enum: [ iic1, iic2, iic3, iic4, iic5, iic6, xspi1-data74,
> +                  xspi1-data30, xspi1-base, sdhc1-base, sdhc1-dir,
> +                  sdhc2-data74, sdhc2-base, uart1-soutsin, uart1-rtscts,
> +                  uart2-soutsin, uart2-rtscts, irq11-8, irq7-4, irq3-0,
> +                  evt4-3, evt2-0, clk-out, asleep, reset-req ]
> +
> +    required:
> +      - function
> +      - groups
> +
> +    allOf:
> +      - if:
> +          properties:
> +            function:
> +              const: asleep
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ asleep ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: can
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic3, iic4 ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: evt
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic3, iic4, evt4-3, evt2-0, asleep ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: flexspi
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ xspi1-data74, xspi1-data30, xspi1-base,
> +                        sdhc2-data74, sdhc2-base ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: flextimer
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic2, irq7-4, irq3-0, evt4-3, evt2-0, clk-out ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: gpio
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic2, iic3, iic4, iic5, iic6, xspi1-data74,
> +                        xspi1-data30, xspi1-base, sdhc1-base, sdhc1-dir,
> +                        sdhc2-data74, sdhc2-base, uart1-soutsin,
> +                        uart1-rtscts, uart2-soutsin, uart2-rtscts,
> +                        irq11-8, irq7-4, irq3-0, evt4-3, evt2-0, clk-out,
> +                        asleep, reset-req, iic1 ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: i2c
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic2, iic3, iic4, iic5, iic6, sdhc2-data74, iic1 ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: irq
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ irq11-8, irq7-4, irq3-0 ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: reset-req
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ reset-req ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: sdhc
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic2, sdhc1-base, sdhc1-dir, sdhc2-data74,
> +                        sdhc2-base ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: sdhc-clk
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic5, iic6 ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: sdhc-data
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ sdhc1-dir ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: sdhc-data4
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ sdhc1-base ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: sdhc-spi
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ sdhc1-base ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: spi
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic5, sdhc1-base, sdhc1-dir, sdhc2-base ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: uart
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ uart1-soutsin, uart1-rtscts, uart2-soutsin,
> +                        uart2-rtscts ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: uart3
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ uart1-rtscts ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: uart4
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ uart2-rtscts ]
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pinctrl@12c {
> +        compatible = "fsl,lx2160a-rcw-pinmux";
> +        reg = <0x12c 0xc>;
> +
> +        iic3-i2c-pins {
> +            function = "i2c";
> +            groups = "iic3";
> +        };
> +
> +        iic3-gpio-pins {
> +            function = "gpio";
> +            groups = "iic3";
> +        };
> +    };
>
> --
> 2.43.0
>
>
>

