Return-Path: <linuxppc-dev+bounces-28669-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42B6CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 16:39:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwd0k1z1Lz2xwd;
	Fri, 02 Oct 2026 02:39:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790872758;
	cv=pass; b=EbYjnP4eB0Aa670stwysiCBjC+sDrm2MfiyZGtvmD+E+psDLoFkJKWRJGDn0Md7Y9eBBgmAoXMoJ09cKEGjgaCJAg3utrROW9k2i7Vt2zzAnsO8Pd9jYhN/Dru63kjzT2YxWlaRilTLlmIzu4QBqC5fNh+7J6nBNNriAeXYij0JX6jE5GeTTDsRcDIn4xm4J4rXhAFSI1493EVBKmlA+S0UkmdtWSFBYUHxwZ/aLnpvsKuY0jpwmIF9sqyG8WMBVsTZZ+G3ZRoSDcvu8w1DrsUHJ4PVIrJKE12c5VkT1g2ZUktTEIRwQsuF75wDmhBnFvMHvVVmXJZ4JOeja5VMBng==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790872758; c=relaxed/relaxed;
	bh=RBJy2i/9yHzIpaBvNvBsunSFE4MK+PW07Ms/iq+pt1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NR7uALRZEfqxvxjqEbLKTJy5R91qn6W4AFM6l7fCuqlNBce3qlSYq8tN2fJttT+PUCkcxmUwOZK9y7/DVuZVUXkh1FHVMUGiQ6y2rZ+yTJo30XeUin4MlWtBy4sA1BRC4Ni0ovl3sgleZfGbsB+okuajsvh0EqcBMYrTBkQvzDRMqBXXX6LLAbvexle+cE4p52+Hf3a09JXL+y8Jr8qLoofaovNU3yMV/syd+eJzH+MzzQPNZbU6BkVfn4kFu/pvooruOcNAsyshoKbsrWlnnx3SWrgVc+vviv7qX0mWtATXiifu62toJaYS/MrVgbV+Gb8mMQo/vigTgSqJjjjEag==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KtpSQIVT; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KtpSQIVT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwd0j1dxkz2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 02:39:16 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBSUFmWWatwamfwlQVNyoZMrQrvtYDq7XJSvCF3+90TEwZbB7k2zhVGQIpllNoQTRXpQHzOXxNxDsecQT3LsVoIFlsApt4hIWhtWQgGCfOPFgm8NgBeKjuus7z45iprRqio9lgziybOGWeewC5yhkMyDv5UIK0Bp9PRbJjR5vuL7Vk1KbiCCmrEJS2yjRRqeZ/Woc1/6SSS4dcA2nRlFELQ2nbsBB8YPCoqCJtlnhH57HwK3lweI3Y5LMkI4HyUm7zi9FVFIojlT2PvhwQ9jkO0Y3VlU/IpqCJI794YzpIcYFMjfyHnUqcg/U7UxNoex/0VxqDpEGSyC3rzzBJ/3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBJy2i/9yHzIpaBvNvBsunSFE4MK+PW07Ms/iq+pt1k=;
 b=EOHk5NCbF653ZNbXmh/rCeQGi1XreUkEi2Pk2ElrZSsjWrLxxaIOhv7Y+e7hBia0PXtYK5qFpKO41FvgY42EWu5NmCrS98UoOq7JoQKnv4kp2lByc8rjdUPusDD3NX0UydFhcA4z6qJFIkR0muGOmEhQIniI0Vn7FZROOYegzln9pgqTNpj9o2uzGKpijteCDF0CQHACRrqjsx2q+9c4OMs5N2mExHuthYxFDRUAiE2HF/4K1DLFpmdGa4JGuo8Q/FLK7kcoJkb7ksaOXNI4XfxFQLPzuOSuVCmkRgXa85FXd4T+IPEWta1WJ6PX9Fw5jV5mh5OKyzex35zIe4gDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBJy2i/9yHzIpaBvNvBsunSFE4MK+PW07Ms/iq+pt1k=;
 b=KtpSQIVT67fgN80SQ3VNvpNK6pbw2VK3NvRiMYqp9cDshmQpq76F93lqa71hYm0Z8zKprGfKWNivdVaa6tCyvMwmLmams/O2b7KDKQ7+t/Y1pMmTZTi3vq+PlSUTSuP/I5pUpRCxDRmRorytjPzwPTR7WtbMxx88nLvsJreP7EIin0j7f9xEcPkm77KTEK8hd+M94Iq1Ob47efFpC/ETeiwy/W6AU0bnHo8xCOpP/Xwy0wx2as5367lUNCg92FJjQHuNl4XSbYyew0V2JBY9JTsB4PuF0H7P2NdlMNAZxa9dmueh6BHL6wCy++HkcUwK+ov2S4+HrpQQVzYk/9CYaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MA6PR04MB189634.eurprd04.prod.outlook.com (2603:10a6:250:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 16:38:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 16:38:54 +0000
Date: Thu, 1 Oct 2026 11:38:44 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Jeff Barnes <jeffbarnes@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
	roy.zang@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Zhiqiang.Hou@nxp.com, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Revert "PCI: layerscape: Change default error
 response behavior"
Message-ID: <ar6MlDEnEh_76AQd@SMW015318>
References: <0FEA6868-5A7C-4955-9FBB-BE9A1AE8D3F7@getmailspring.com>
 <20261001153323.1965074-1-jeffbarnes@linux.microsoft.com>
 <ar6KqnfQ4S5jtqeI@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar6KqnfQ4S5jtqeI@SMW015318>
X-ClientProxiedBy: CYXPR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:930:d3::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MA6PR04MB189634:EE_
X-MS-Office365-Filtering-Correlation-Id: a1647f82-e099-4144-a918-08df1fda7b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|19092799006|366016|10067099003|11063799006|56012099006|4143699003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oDnGINETcwXLQa6vBj1lhdc+7Ww0auMd3V+O0VtdFrai8MWSy+rF9gw/f6yk4j1cfMraIbbrEIz2gJsiZthg7qRTm9LL9EKIEUyZHArzjSUn71amoH1R80rBYlFp0nyppOzAAGTRHsftFjdBVJuyjh/OMP61rj4pSkAVo03pK7CL6+GuRu7WnBEjVFICRTJH7gISFPo0RIQM9BKcVVls9UDuFt35psV62BVYL+iQ0VBCbrOM0j+4zyGJ5/KwBe7hDpyRiaFIjvaMrfXvF4IXRFu0M2HDF93JOS/F0Kqs5skDh8DbiKCxu66QMwMqCCZg7K7JJroFmdw5tR4n5lK06Zy0ZcW4Y2/3glCKbzuKeDSqkixHNTVKfWVp0oxqJ81Al1a1mMEPtZmmQJtVU0J8puLI1Czyb3wbun0h6WvDWuk+HCMi8e+K09TMHNUNdDN3UkugWU5l2OLWQ6LWagEjZUsPrOM3I+50YXDQAy48AInWZgPFHG3KO7GgeN4cg7RLLB+13hI9rCuf+dZqnfnZ4pN+L1Az2ZXeDkuHYY0tsgEgl6gTpjqxB6AjPZt69HyRzweIy65Erar3+WpYuaPhcJm6JwEvYD+/YohYxPBcv4lPuWw1v2D4anmYj9Xxj7WpmsaoBXucCZFGXXh651JL+1BRY4JTEF7R1Z8MoMz0g4U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(19092799006)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dNzWj2Y24iP+6YyysQfol8qXVLakAqlx+ySOcBWWSHsAJwc5qaLNheR4kSoM?=
 =?us-ascii?Q?Ipop1UsZT4Fgk/IcZcygkCASH0A6M9zRDPHgZMAr9mTd9iXOxSHxCixInkjv?=
 =?us-ascii?Q?dIPiTF+pxGirgw1+T59hd95WeneKgQBT6rl+fv5Dy21ExddgzT2Qkj+cw0k+?=
 =?us-ascii?Q?gB061AAogKLTg9zQoZ+xvzXkqEQ9G9Wo1p7DwsAQbeC77GSNifFwO51kQocF?=
 =?us-ascii?Q?n6VP9qFjiBiB1soqNWrgOtnsNdY8fXYEgjwSVafwrbkJi0BXiY4qgPZASQRE?=
 =?us-ascii?Q?d0acFaxeWKFzaB9nVnTlgyhggaB9f5cuEXwtZ5mujCt39pZLSZW5/E6NazgW?=
 =?us-ascii?Q?KGvRJ/rMI0rhbjYzRFOo3j0rpUBdbeDtmuMG+RSGeGD3+2Skbowi6bsUMaPx?=
 =?us-ascii?Q?l/HzjGHg3ZjgO256F5r12mn18UDO7b40q0pJs356M0AGv62KIaVjY1+7wIOR?=
 =?us-ascii?Q?q7kb4/nH0XWjFRtX2P+MekxVvKCqjRE6qRj12dwe3mbyl0JcC9r1Qox95aJi?=
 =?us-ascii?Q?Za4ajb54MlK27niDLRk1LCFJpJZ4OEn7IRU3tze5qN81ciHtLUJBeWsuq/6d?=
 =?us-ascii?Q?H1GItxTuVrTsdRPgBGCWai7zlVB+pSC26sQTqFUl18+5p8dDl+5EKpNEn76o?=
 =?us-ascii?Q?ANTqoMj7uDtR3/WK/Ed9M4OCONZLzkiMn8co+KzY0s630qbr5oJhFQiFC7BU?=
 =?us-ascii?Q?SxcSQOzMKl2+TnuWkOg0UfjquBS9JN3tVb71c5HU2ALoPeDM4w01qBm1gfLd?=
 =?us-ascii?Q?cFtLJt5YJrqmXmzapV8q59yEQp/YXxWGuHXSFYZ+/lltyDXZmTUbp3mFZjTc?=
 =?us-ascii?Q?ohF3OxVFp+PNbqlNIKloUCi2Q27jDCkNUUDHjSfu71/QOaknfkItrIR8365Q?=
 =?us-ascii?Q?fwQyACjJNPTQnf2eCKdpeCJyEvThI26fvCP5mms6ErCnaFhI0AgJ3MMgpHpL?=
 =?us-ascii?Q?q6ZqJK08LfsyRfVagJx3/oPiYC/QqFb/Q9aTTGbFWyzxWT5lbD2nZT2Dac1v?=
 =?us-ascii?Q?VacardD3A7IVtuHCRkOm6du0zIszZ1CM6/FaIZEQrjBeDWYjY4qKP566tbhv?=
 =?us-ascii?Q?V74844mO05oE7YZLtCxwluRA1XWyV6wIC/RWrBVU+zIbX2aDVUr6ejHif8L6?=
 =?us-ascii?Q?RX7iH3Kffg4yEvl7jbk2fvbGQJHhgSXhqgMQzOwZzrSRXJipQRhB4QDjqi/m?=
 =?us-ascii?Q?ioJ9bmy51iQ7hTqDRlB+NOXcZrrmWGbMS7SBnyQKwQzW893l/8kKIzPG/9AS?=
 =?us-ascii?Q?QsqWDKhN8vXRxIwtC+A4aacAnoNA0WqPy7h/RxE33Z6GuBL7quKdtoMHoK3f?=
 =?us-ascii?Q?T6/DDc6JQ7Mx2VXwbw+upjRzgzjKSSUnn4HTTePkSQ08zhCtLughW9T2kaDB?=
 =?us-ascii?Q?hLrsTsjaRXaqI7AEmUzfi1Y4fDyk4nZ+cm40Spv1s9qxw7rNDOM3gEEhvO2G?=
 =?us-ascii?Q?XV2piO/OcW8QrRkqxTvHJd6EJYJaRRw89Id29SLlJrfIzu2cwluBf2/OyYiV?=
 =?us-ascii?Q?fWkA8/kCJsLgHhK2yrsqQap8zHlusBbBqNMjIIFiOXUc7KcgnBxYBm/p1UWi?=
 =?us-ascii?Q?vJsM/CW3kR4o+KhtxkODySog/+E/OW6twK8Fyb4jqGE68wnCDJVk3RlnDmy2?=
 =?us-ascii?Q?sHGy3APoO4UanZKZbQEZzNDrwdhMfGB3YPSiBTGP7nLxLD5/9kf2HVDPJopO?=
 =?us-ascii?Q?50z+bgE9fJGPdj+q6uwfm6feRiiqmEOHTnbQ0Aiw9raBkqtxa45cKlCrflCe?=
 =?us-ascii?Q?dVOcix6e7VQxYr4m/MujSMay1J1/6FPfXjCxP2bPZmGz3kKyzfAG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1647f82-e099-4144-a918-08df1fda7b27
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:38:54.2617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNwxuROCdHIK5qq5+J+3P+jLqJz4gvmUdbMohFDIvqKAEDQISuzMT9tGvrJ5zOPMUH7BdESyg7VGrsPtB79bdpxEUssfLFrewOiu/qZWqzkuMXOKblb+/gF4lehn7wWc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA6PR04MB189634

On Thu, Oct 01, 2026 at 11:30:34AM -0500, Frank Li wrote:
> On Thu, Oct 01, 2026 at 11:33:23AM -0400, Jeff Barnes wrote:
> > [You don't often get email from jeffbarnes@linux.microsoft.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > This reverts commit 84d897d69938
> > ("PCI: layerscape: Change default error response behavior").
> >
> > The Layerscape PCIe driver programs the DesignWare
> > AMBA_ERROR_RESPONSE_DEFAULT register at offset 0x8d0 with 0x9401.
> >
> > For AXI, the documented default with AMBA_ERROR_RESPONSE_GLOBAL cleared
> > returns OKAY with all-ones data for errors on non-posted requests.
> > Setting AMBA_ERROR_RESPONSE_GLOBAL causes an AXI error response instead,
> > with AMBA_ERROR_RESPONSE_MAP selecting SLVERR or DECERR for individual
> > PCIe completion errors.
> >
> > The value 0x9401 sets AMBA_ERROR_RESPONSE_GLOBAL and maps Unsupported
> > Request, Completer Abort, and Completion Timeout to SLVERR.
> >
> > A PCI configuration access can race with the link going down after
> > dw_pcie_other_conf_map_bus() checks the link but before
> > pci_generic_config_read() performs the MMIO access. If the transaction
> > results in a Completion Timeout, the Layerscape error response setting
> > propagates it to AXI as SLVERR, resulting in an asynchronous SError and
> > kernel panic.
> >
> > Reproduce the race by obtaining the configuration-space mapping while
> > the link is up, then disabling the link from another CPU immediately
> > before performing the MMIO configuration read.
> >
> > With the error response override enabled, the overlapping configuration
> > read results in an asynchronous SError and kernel panic. With the
> > DesignWare default behavior restored, the same test returns 0xffffffff.
> > AER reports a non-fatal Completion Timeout, and no SError or kernel
> > panic occurs.
> >
> > Restore the documented DesignWare default error response behavior so a
> > failed non-posted PCIe transaction does not become a fatal AXI error.
> >
> > Fixes: 84d897d69938 ("PCI: layerscape: Change default error response behavior")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
> >
>
> ---
>
> should be here, maintainer should can handle this for you.

And avoid post new version at old thread, which will confuse patchwork and
other CI tools.

>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>.
>
> > Changes in v2:
> > - Change the subject to identify this as a revert, as requested by
> >   Frank Li.
> > - Document the DesignWare AMBA_ERROR_RESPONSE_DEFAULT behavior and
> >   decode the 0x9401 setting used by Layerscape.
> > - Clarify that the setting propagates Completion Timeout as AXI SLVERR
> >   rather than causing the underlying PCIe transaction failure.
> >
> > ---
> >  drivers/pci/controller/dwc/pci-layerscape.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> > index 14d6ac4fc53f..d333f1ae8a41 100644
> > --- a/drivers/pci/controller/dwc/pci-layerscape.c
> > +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> > @@ -28,8 +28,6 @@
> >
> >  /* PEX Internal Configuration Registers */
> >  #define PCIE_STRFMR1           0x71c /* Symbol Timer & Filter Mask Register1 */
> > -#define PCIE_ABSERR            0x8d0 /* Bridge Slave Error Response Register */
> > -#define PCIE_ABSERR_SETTING    0x9401 /* Forward error of non-posted request */
> >
> >  /* PF Message Command Register */
> >  #define LS_PCIE_PF_MCR         0x2c
> > @@ -103,14 +101,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
> >         iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
> >  }
> >
> > -/* Forward error response of outbound non-posted requests */
> > -static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
> > -{
> > -       struct dw_pcie *pci = pcie->pci;
> > -
> > -       iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
> > -}
> > -
> >  static u32 ls_pcie_pf_lut_readl(struct ls_pcie *pcie, u32 off)
> >  {
> >         if (pcie->big_endian)
> > @@ -180,8 +170,6 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
> >         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >         struct ls_pcie *pcie = to_ls_pcie(pci);
> >
> > -       ls_pcie_fix_error_response(pcie);
> > -
> >         dw_pcie_dbi_ro_wr_en(pci);
> >         ls_pcie_clear_multifunction(pcie);
> >         dw_pcie_dbi_ro_wr_dis(pci);
> > --
> > 2.43.0
> >
>

