Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4DB606A886
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AVGeU+VS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jT0JF2K9kz2y2B;
	Tue, 17 Nov 2026 07:46:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794861965;
	cv=pass; b=lP2qlR7g3TISU8NtwX4uAitA4Lfxl7zjaBN3BpqmapmG5V48i8v/dYct9qaRiAuxCFNfK6nHSLB9k/J7TodDC9o3kMwIetFmMTfWxThy44+bleaqnQ/6izBilWk8XI+RT13MxgI2iUoYw3a0fVNbDXSNRtqiXguiZZCCaJxwtcqR/eMk8a+ZO+w29EcqcSV+wh5pvv+R5LhpXNNmiQVWGqC0uS336/RjO9gAj3SHGpb4EkRXflKcvcchFDM6cy9jJpnmhomzZG7bLyn1bK3wcZZ8Gk75IavgG84u27CUwKAdQVpDXXJc59V9aEeh03/96PZdiX1bpasNCclm00l7IQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794861965; c=relaxed/relaxed;
	bh=A6eUvdWrOJtAXLzQ7JXMmfTAfulo5mHHDws+euUwL8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TrRIJITm+2CQsjUpuCfNYwEmrCamuK3SHvADZPoF3DI+BHsc/hoD5Am2gdgkvfrb760EPiLSKfXnYCtYxgo8wEErGUrv0qdDBN9/ITp9M3+WU9q/yKkarAWYDVal8OxVD+yKbE1Mzfr2wkQaIlPiy66XE9HxUpgMY4LjO3YQMDMwgwW1jYzhkWszja/+f5qFVtz2lYPrtfTuyTICbLQxMvH2fsTrbZ9V3/VnszRI00qMYaKoFfKAvPYO7IR6s32HeXyxY5DG5Sk6GH0AqoTm/tTWwkkS+iiyNhc3Ti/R+XPdoW8huqOsfzmcVASzREuXwwjOpqkQ6x0+uw1lhkBPHQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AVGeU+VS; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AVGeU+VS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jT0JD4bC6z2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 07:46:04 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVwrwInJFgz/KVaVg1OnoeECGuLS39vJbIkFqcNPlJCznkWXzCKFsnLTDeztmp48pQ9eEsZ72Os2yRrOTvs0XlTa2t7TS5UkpAzvi/Me+BArV5QdiPGRXQy8/3jSSxmjTWx1//naLTRQLRk2YV6aOG14gC8CDkkWUxmKNuZhUJi57GUSJ/3PQes8/G7hSHdgBnZ+O+7SvVAgh4kq0sBlFuSxZcgyy770VfYc8TAlDbxvm8ifxY9Dwf57e4upREe3JneJEiGfilqrKH4XL4SzcInNTFysEVut8gO11TZTcx0faU/XQ5IFVOct4TNxNQYNo/Iiyc6k1LMzGKUwccQCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6eUvdWrOJtAXLzQ7JXMmfTAfulo5mHHDws+euUwL8o=;
 b=I2hLUcCoJXcKTyw0vNcLFnWI8o8OeuKzXe7y7uLLGpKafrca9zn8f8VdaVDacgMgIt0h/Hcb4jsuhqyw786z+h0irRYJsSuVC+WDMvPjSkXc1w7S163d96xP8MA/sAf+zix2PhFpEiHZdecNSvhFcs/DPv3rDIN+wag4KrYrlQlZeSGWAMCYjOW36YI6Hgc272MjNW070yMEQ6yxmsvlYzPZgr0XBOsvyp5qfNbwZAZajAtCVaxat68UHnjoAP+tKi2GfDUU8ygUHDE/oJMarf0fy9LjoWhpaRC352UQjRUjgJAtNoxPp7+Qw1q0Y09dYqZwwcdUfhNgR72HwubehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6eUvdWrOJtAXLzQ7JXMmfTAfulo5mHHDws+euUwL8o=;
 b=AVGeU+VSOUBRx/9iYc007YhFQnRZCePdXk0TpE5zzDn5roLwdRXRt6ApMl5yVM7FjDsUfGqhqX3TP2LiDjl6OmK+tQMGrRsX8qQs7vfZlsNrgpv7t1aOVzOlU3uoIiNZ9aAn3naThO3+JVUdOi5iATQ5U+vh+dNOU3kzi0aUxVSdohj7qh1vZpRfUQzdXy0QNi0gftJMej2HmQvQ6z8XbkWLsXJcAG9QaOo7aMWNO/KuM2cMC8JVX0f+LcLJvJhqmnFdYXLcx6Cm98lDKAoAi5dm2s2x0c3+TAluVLAD1++yPLpIg17mtn81rIrgA/yRDkXWDd9TGBXKp60Bps+voQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI2PR04MB10859.eurprd04.prod.outlook.com (2603:10a6:800:278::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 20:45:39 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 20:45:39 +0000
Date: Mon, 16 Nov 2026 14:45:25 -0600
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
Subject: Re: [PATCH 3/3] dmaengine: fsldma: convert to
 subsys_platform_driver()
Message-ID: <avtrZb9RoVIPOzbv@SMW015318>
References: <20261106-dmaengine-subsys-v1-0-780eeddbf3ef@redhat.com>
 <20261106-dmaengine-subsys-v1-3-780eeddbf3ef@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-dmaengine-subsys-v1-3-780eeddbf3ef@redhat.com>
X-ClientProxiedBy: PH8PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::20) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 99a37920-b2fa-4b77-e594-08df442292ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|23010399003|7416014|18002099003|22082099003|11063799006|4143699003|10067099003|261021121427099003|56012099006|261009223027099003|261102123227099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	HfirkIH1op8dnt4h1vN5F8yffDJOrMokk2F6rRIFz67wiDP3OIsa4K2/I3pbNUrZWC3x2q9zGFnq3VVeCbYw2J2F+FKf1iAWkbCC2cGXHhqd2Mtr5Z/hCEyU4BrHqAVmynmw5MJ7qmvRMLsKdOKMk5nZe99LDWg7FpCCOy4qjWUVhiJWvNwUdJAFA5a0LA/9DGAPs7mgMeoLXyB9NdE029qf01BIyJ1eA6ZDD9Yp0dXZq0+wUK+OxgiLFrTF6Lx2qJoRurQ0JstFf5qudv9p4gSM6H1xD4yAdPWuAsvD8kTVYbBBM/kn2hPA8tdzvsBWfYRnBB8HeUx8Hui6FekTCrDjto3S88WToExq4o7NXZozpxhnrqU1aBJ70z/kCFLcNJMYKxG9crjhTphXzQgkU2qvSvUD28cNlIRs4eoY3bAIDz0oDeGIll89Jv197dxKGOcOe56Z3CgXizM/F5OmB3ZSBneD3TCzyauckwesLxiMIQ7OMctC4EaASu565eCCyeYep6tudKf/PcdbtIwuQiQ1LEbqUlL+kEqu6v5lnFkNNjPUjDGh+UvhrG5K/EwejE3OPHUa3nDuGOYFwn/SN3k5VCnv2B38W5Dbz3d51rKGWC1/AoBePojUdbQ7vLAzsiLktHbHBM3V1vuZgjwuXlHpxcZB+sLYsmKSABfERTM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(7416014)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003)(261021123027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SmiS9mmz5m2r5Yku2gjtD0wAUYigUC3zpTlqCySeSFg0xNHLLX+5CRZwfw3b?=
 =?us-ascii?Q?OgQrSeKzrypAHnN4YIX1Ncf5Jxms1yoiumGO3M2dxTMnuUAJagCs6wL45HBL?=
 =?us-ascii?Q?QrMUWOZ0pF/LpEv9eCSpCLC7r7MOaL7HRqNYvAu3OSeCvVPTXr2CorVCpdco?=
 =?us-ascii?Q?Sg+1ZLwBJjayVLMB9neyOHXEVJUTItWvDOjN2JbAgpGPY5GkfEFgI6LdmDlN?=
 =?us-ascii?Q?gxotS/yDnMZVSIfFjBU6uAzqiBer1L8F4LE9luTUGuJYgdkPAT7IckXRjbJf?=
 =?us-ascii?Q?TU9LmSGpSx4dLH1AY89AfPU/BynQlmoAgLkvAXkP4HsiUoKL8BYO3qqUAxDW?=
 =?us-ascii?Q?cOjtS7hYZoR/31Fov3DlWN0/YQtL03xnVaTecMDtns7A56vCf2iPPUjcMydI?=
 =?us-ascii?Q?WFIwV8DglA/fy/DpCapOx8WTcLzL42aqhlFq/PM9S+Wzs2UcLFtawZOFHQp0?=
 =?us-ascii?Q?MDoo6ZXhK4EcuFMvQES78ABBLh2ICZZXwcsF0cDZvGiGUw88zU6AwcEPQkeR?=
 =?us-ascii?Q?GJ0F5EhKdA92Q2XSOd9tv5bCkVar1I6xt15TBoAxpMRvZlyzSo2eBNin1NUv?=
 =?us-ascii?Q?S5mvCi7U/n1J+4BvWo5pK9dXqWu1kslwpWfonsuw/+LSpWINYXRs//x4NTie?=
 =?us-ascii?Q?HY+z9avSfz7OKpmq8sMRCdg56hAMa1AXoWFy1HQx1RaKDs6xHl70N7A7AH65?=
 =?us-ascii?Q?2/e7aM3WE66U1T4us6w+ChdHVAg0rBkqgzeH+cLrlewArLCvnk7lK75dAhst?=
 =?us-ascii?Q?SW4qw9KEWP9JG9YRi8eESNooxNKnRpVkf9RD9QUmFZU5Z4+OWFaZue6ddZqM?=
 =?us-ascii?Q?l4V7NAvuBVJDmnU5HZv+FIISHp97TQC7BNaGEFqzks+lkoh3bxErCgFNw8gq?=
 =?us-ascii?Q?hQ3deb07+YgtCsxaTa4UkQmGzMKpOfeUztAUIpMMFmZup0solbbLK6lSHDEY?=
 =?us-ascii?Q?UqO5DqRJEdqEYw2rnBl9fkSTKzzgLlHOOy4i8hiu7WtF8PISeybk2FUEgkzl?=
 =?us-ascii?Q?iSIgQyzqXtJ/iCOM8lc6d3jPyqxxXIc2b3Bzwh0/j9//rqr436o1kDd2BuPQ?=
 =?us-ascii?Q?uRuI1RpezHRsxPaKPdo5RG8aqWI8oIRJq7KU4Asoc4YS8WbJ/pVb8o4qAYcC?=
 =?us-ascii?Q?3U5KvG6LRzy+Py1fBHu5MKjgZCKWerBWz0k1eZGcuwWGWOm2KOAyfNojFNQx?=
 =?us-ascii?Q?IRD0Jyw2RGVmRX98Q0bxkYB9kzAx/S3W6li9GdVNeDLSbOZxUEmkkzdpS0B5?=
 =?us-ascii?Q?6hRmDk3SWkD7yqWI4ak1IL7Ix6ytqXvsd3pyvdUhTc+dedul2aWA8s5Wvyll?=
 =?us-ascii?Q?7FY/yTD/tzoT5IytcmG6Yl9T7v++/4tN5tnSt5gvPi05px4qgLzzIdN1U3sp?=
 =?us-ascii?Q?AGtAp5nvV4FeLT9ySwtj3gBf5Bf/f0nGED8W25ml8uqDqY6H3+s6huq7VoQy?=
 =?us-ascii?Q?VWPrEU6Bw6oLLzWu6J4c3mtjdkfFu0r442JQIrk98rl3/PHWm83AhRpRZDTs?=
 =?us-ascii?Q?wVbUGjuZG5BOeqsl2hzpEaEfzE2U91WUaQyOsR7LF6aRzDI2GYAByZbcMdDP?=
 =?us-ascii?Q?ve/dvlywbq8k0iNDtprnBlrE2YpnUWzUX8rfIHRQyM8n3SVp27A7rKwbJqXm?=
 =?us-ascii?Q?Bds8K2+Tt3MduQRaJzPc9qJ+YckFHpixZjHaDCTLXjfW82Q0EwhkRj/F73TY?=
 =?us-ascii?Q?FrsCfkArYYCh7oN71ChsFOBGkTBjhrq/9GhIPOP2DePrBNr7sunQMNDpU737?=
 =?us-ascii?Q?PVYNbfcVv2FGV3XTgl1Ry02R/PKxdX7IhC9Tp+p3VHR8M0VivZRT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a37920-b2fa-4b77-e594-08df442292ca
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 20:45:39.4188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2EqTE/rYUcmYpEh5rUGUV/cFqN/xJKfAZYs7BKy1+DmTBtCGI5kzoMSURpMfibi4rVtm/63zlITTvAAhHdahWmoSw5vWMG8Ny2OvlswOa5KctLGywvhsERL/8zYwgTj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10859
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 07:06:10PM -0500, Brian Masney wrote:
> Reduce boilerplate code in this driver and convert it over to use
> the macro subsys_platform_driver().
>
> Note that this driver previously displayed a log message during init
> time, and this change drops that message.
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsldma.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 99a878ed1444..fd3dca7616a8 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1431,19 +1431,7 @@ static struct platform_driver fsldma_of_driver = {
>  /* Module Init / Exit                                                         */
>  /*----------------------------------------------------------------------------*/
>
> -static __init int fsldma_init(void)
> -{
> -	pr_info("Freescale Elo series DMA driver\n");
> -	return platform_driver_register(&fsldma_of_driver);
> -}
> -
> -static void __exit fsldma_exit(void)
> -{
> -	platform_driver_unregister(&fsldma_of_driver);
> -}
> -
> -subsys_initcall(fsldma_init);
> -module_exit(fsldma_exit);
> +subsys_platform_driver(fsldma_of_driver);
>
>  MODULE_DESCRIPTION("Freescale Elo series DMA driver");
>  MODULE_LICENSE("GPL");
>
> --
> 2.56.0
>

