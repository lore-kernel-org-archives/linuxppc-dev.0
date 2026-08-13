Return-Path: <linuxppc-dev+bounces-25831-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BA8C5CFDB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:49:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLZCy0QRLz2yf0;
	Fri, 14 Aug 2026 04:49:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786646989;
	cv=pass; b=m9U/s7njI/IIsLAhHtCJPr/kywJSS/Y7mrt3AhF6K8BAxGBLyoo1xHQopXUDqVW0g+5VBrc8TTZCy+gzWOUGe131QYmUxadmg8uWlO/isp+IE0Bk9NBZl0w4828CQS9rlBiW0MawNY9if1kJaw3SgHRckg9tgsivqqALfrcwtUBZx4U88PxfzlEQmJBGh+8tZlqEoYnz27BNsx+IP2fIhUTbrWvaVlc5Jv8jvjd1m6d52/L+9RZ0jzD6z4EY5pJRHUAMNiVH+nMOMz98hrHD0ZQttIIne/iWU18af0KaUUKz2eLcdZv0FQlBzaXNWxfh9C/HebXZukQZF/9EjW+QnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786646989; c=relaxed/relaxed;
	bh=RJoXzZLaV9CrWqVMRDQ7ngwc3lK41lX6j2Op+4khpZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=asxpZiyS40qhHour7Ofw12TnjvCob0WUE4af4SkZH8LknULtOP0Qn8fp+o5I4tAxh27HAwk847vZTIywTvNIpBNbo2UuVtSOtfH7Jrv+eSaF2h+RtWB9zrbHifwLDZB/1JvxCr/6E3D1+y+DRHkkiiLG0XBHmO1z4io35yUKfSFaXj/tTnpmygu5PlahucseYWWqwAxdy86vqwmQaVoy4lfee2PFOlHvUeeHaofC/A6AD1IZ+ug7DphkyAW56pYSCBIsXO8XvQMqR+wjQg3B5eVxyoeZAObdyHGcHkiJ0wvgiL4uhygV2Orx8zYjn77TNi20/pB+m3qy+qcK/Al9ag==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WZ7XnN64; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WZ7XnN64;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLZCx0lHMz2yRZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 04:49:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLJ0A65DXq/5P6NrA2jFyC+9SyRMOprNid9JfHJXGjh+qoM+4llT+RVk9j4kME4ki3cUpCD/XwD+QX6SSRB3yPIkufuvmXZM0ZYtXL3Xnj7P0zElu5yFMz0TTRwzsebEA1+yyMIGCZkNnz4JACd8ixikSc59Gm16qsToK0/XgeVIhhBdPq4MAyzvwvA/ovBHTjH3Kj7k9Ghy9rWwZXSmcFn8E25K0UJMWJfg5pEKWd6mQ4c1k1pJUtnmE92BGVaJFIPd0KcdeIo9tVqNEEsllluH4JQyhNEppGOKlM4R8o3KQRMfcnyjlW2EeADBXueu2YaI5uTPNti1HluEC8kAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJoXzZLaV9CrWqVMRDQ7ngwc3lK41lX6j2Op+4khpZY=;
 b=fs/NFYvw0qSzx8hIopeYKGNXzGCAiFRb9EaKU/ozLrLMX7NYpmU/K2Synrxv+eewA+fw0nbSgsbBeufIHRz+2mLH/3n3IDEgbUAXOCxPF0H2RpuOOnE0Mf00BEi30DRyIEeIZiW7eTgP1i2I+smAujyU+CxiJFb+QmNDSITd/VBRXO6Ylx3LF5o67zo/lg2AxHtyb3q4Rbo3j774qg11p92Ka65mV3cYlqpeL6c+KsABsGnTTaZ/XPcKz/vSorcbTljVo9/EVMHg5MOBrAJJDueh6DUlXt9wB4ZZEOghNPtAWod5FN3n2orywTwNkzWo9Q/agFKFWa+FdOVLuGzERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJoXzZLaV9CrWqVMRDQ7ngwc3lK41lX6j2Op+4khpZY=;
 b=WZ7XnN647b/6QPYLJVQxEYx+syzOkffBeUBB6dz2oQbKTri0GjCdEb3vn1ZwK3arm6QrSY0WORIfPHo/1DaFCgokhjm4sQ1dKBJqCTGld3tRE2eD9F6+8dyP44nzhzlhgQosXwQKUzcBcS35NQZo7/r2eWv5CRrY4EiKZxVqJuXRWbFLBux6kJMPIjj8hk3jvdB/DgL85/yW0iCKpR+w6SQddFDrMQljyXoCJ83gzK4lH5CTLjKt89+deOy9j6snKsS5hHq767wCQcQ56FIMvKfnRToe8UMvh8YEY7JBfnkBxV5uphFQaHCYu7F/Po0ks5zH2AKS22cl2EUUxyb03A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS5PR04MB10060.eurprd04.prod.outlook.com (2603:10a6:20b:676::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 18:49:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 18:49:24 +0000
Date: Thu, 13 Aug 2026 13:49:16 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, jingoohan1@gmail.com, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/16] PCI: dwc: layerscape-ep: Use cached PCIe
 capability offset
Message-ID: <an4RrIcV2Q6NtQ1X@SMW015318>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-5-18255117159@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720150619.24733-5-18255117159@163.com>
X-ClientProxiedBy: SA9PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:806:28::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS5PR04MB10060:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca7d326-1ca7-4cff-d591-08def96b97bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|19092799006|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wcJvH7zpJFzrE1i9zqbBU1P9ATnBOB39jgkZ+Mr48gdLyySS2SJLyRG08czl17pOfAmA7OhGo7ydbjCbXfAoQcdceJyD7NfAMqon9BJxpKtsovALGpaFvedDyGu18QhIz0DR7fR6z/MCJ8bKxAF55zoFb9qBfigdq6+Zkm/wfcW8Pd+LZVDRCj8H9JjhpK/IV9KjzKRdfwuygcf09u8DbVfsaOScdZDpdTXnOWoFl7Ort5knb0AiZEA/OyZeCi0g3Z56+2UmxvhzEHLDxkehNPi+2+zoj2q2dRIHZL47FZ7wqDhgYgE24jZZq9kV+cMU7wYenJ5Bncr+RNlbKfinGRUk70IX7at6zA3qcehEw0Wl9/vTycDuMzhg7J8Wz7F3yle8JF5VFHRw+foVmhtmt6hFTD7MlBrkbda1X5mKfpdij7B/6EDzfkNH7tyJV2dr3JqxGIEZJU4WXQVn2FVj54VZv8c3thiLh4+mMQS/aGyNAHAxpycroT48e/fUNzzZ32B+Drj/BMV6kBqu49ViRCvAHQm3whetErPvOZloXbZiwTTdwYyxARtNA/uIb4cEObYa+wfNVdIlLkVsof6lrnraXxtJ8oC6jKM0K4jddJ2Nc4WCvEeXRmmXJoaIWqsw/WoLFWX2JKcyoEOXBe/5fHUr90cDigyhER3NOrriTvk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(19092799006)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7S4KOFeu+bq1Jsj4N5leCG2q6tO9QWExUi0FsFauCSp47qD4ysbWzNbnD5Al?=
 =?us-ascii?Q?Iw0Aq5DX2tB4yOh6aRWbbzojrBAHGTO/gXpMF9lZzkpgssMgwGQfJS/HmCgN?=
 =?us-ascii?Q?KDbHrFPvDVh8ctAtOF8Fho+ATaPrWRIRnycx0FnDtZwaKkm7acjdai+wYmRo?=
 =?us-ascii?Q?41I7+xw6l7gFDNTGaiZjmgGUVCIG9Y18NknjkcO0q7iKI1+/hsuni7KvbMW8?=
 =?us-ascii?Q?If/E465RcuSDlir5Lu8ZNa9oT8OSRuV+PUxUlIQ5kz1SMNmjDcDPU5wwm+uK?=
 =?us-ascii?Q?B29xKf/QnwasvL3IZfZhfqIQc2hfJkLS2phRmUyupK7RuXnmqQPP/IAXVlvB?=
 =?us-ascii?Q?83ifPQScCAk9Ftvl1O4/U32DKrlmsjpwVTl/vjguOouXbwcqxUq/gakc4xTf?=
 =?us-ascii?Q?gwDlV1NgI3YzZEkzjJJpQeSQcjUTV8cxHosO16yL+RMFgen3sS4HpAqitQOd?=
 =?us-ascii?Q?h9efQ+Ti7Kz/aJ5J+WvHmlvQvx1nrHqfdIb/8PgKh2pai9c2ylEwHF3+nOJI?=
 =?us-ascii?Q?xI/meyt9dAmwCyEVQ/9JTyYCxMomhCKCSa6eGuDeE/Dj64/d2azQnV4nAC3u?=
 =?us-ascii?Q?50A39Sn7MuuenwFa+ZjLj56Rzs36kDhb9RrD6IPSCFpundSvE0KI8PNwr3Ov?=
 =?us-ascii?Q?ipkaDVtyL8xeJda4Fq6xLuWiKtJ0A68WTu3A3HhK9G7lzE6Zl+gWjJPG2t2+?=
 =?us-ascii?Q?TG+i81LSdh7NisGWHQtriSC1M445e2fP5QDPdPs7YvFhV0a+qXDCbRMOZWvW?=
 =?us-ascii?Q?WtS3szbRveenCh2kChSChz4HEQM36qdjaMLfpZlZjX4i0vOqYHQicKfvfluc?=
 =?us-ascii?Q?fMwalbVbPZloKPwnE6PyetYIjYk58tXPQwNwBewaaFhcuOvlAPs5bJU4GV5b?=
 =?us-ascii?Q?EOC9omX1W4KyGVsZOqVIbaKeLSQMZk/OgbWGsnAZMUzGl6iQAGCY9FJ8CcNK?=
 =?us-ascii?Q?KpR6+0zTWNgpd3bcbVaiVqoiEaqENV/BSFr2Fs00fYI96c970utVDDz0v1bR?=
 =?us-ascii?Q?e7O4F1sFrBY/XI3aoCLn6+i9UUXeJRHVdnSShELDtkxm0MBGLEtyJIKhsVBY?=
 =?us-ascii?Q?25zKXSVWbC1ZZqsQN4WOTtHYMAByJpD1EhkqtL5kxQqrHuBf1+es38U0wB6K?=
 =?us-ascii?Q?/+KdHcZfcR3EFkamXOjqbOy7hP/nV5++hqWtNreXBr8lXogvDvIgfY3ZlxxX?=
 =?us-ascii?Q?ni2gul0jTB6Uoa0rSBMCjnSfkupxXRPJyVH5mmPAZ4OoVr0MGatmvHwSqwX1?=
 =?us-ascii?Q?Z4PASfk/0avQPCDBwtk7OMQMyDZD4puqkTWcn7Dz8dlIWLpX50SjqDkBxjN+?=
 =?us-ascii?Q?Wnr5Qo/726p9B+8HR+2NjK3ss4aVHK+mPhb8NFmtP9QYnWrKblphPA6+HN7m?=
 =?us-ascii?Q?EEdcwvmEXrxSnfBk2DjPXpFJKKktG9cL4GGdbUkup7j9HaPwLLeXn6WqUKN7?=
 =?us-ascii?Q?omKcrmoAjaaQpnajalYz0bBztGxoK1BAXssan+55NLRvxp3zNXhSVVgMVFh1?=
 =?us-ascii?Q?fgY/DRgw0i8Ug+rqUYyjE6/7gSMrf+HTpQyF9XtY8SkJoq1DwEBPfcbq1XAS?=
 =?us-ascii?Q?MRkFpmcpfOui4QIykejWUwnQ2+2TsBMrXkzlFmkxHmPHXVMXB5CmSSk2RnsU?=
 =?us-ascii?Q?rBRIK9j8dIJYhroGPEifiz6CpiijiyAYSIvNfClVbsNCsTCgW117oqb4H7js?=
 =?us-ascii?Q?8QkERrzJ7AdLQNc4lZ1oQjwjStPcsF0LYPExCyj+BH6xIA9inD0ov5L96FS6?=
 =?us-ascii?Q?9pcK30ldnmFQjwyIia42eGv+Nql5G3hsiZ4iEBBNZAxk7p312Urs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca7d326-1ca7-4cff-d591-08def96b97bf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 18:49:23.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9Dv8/Lv1MQBrrKRUB3oxVsDeFhkGqNyt0J2YNDwcPjbhzccbl5p8PwwNhxPXF0gmhcVP+HJpqvcCEkVB6cEsmUhWD1smqXV06myv5Z3AkOY34rfrDH+C2cRWryOsdaI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10060

On Mon, Jul 20, 2026 at 11:06:07PM +0800, Hans Zhang wrote:
> [You don't often get email from 18255117159@163.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Replace these with dw_pcie_get_pcie_cap(). The hardware is already enabled
> by the driver before ls_pcie_ep_probe() and before the interrupt handler
> runs. dw_pcie_get_pcie_cap() will cache the offset on first call, and
> subsequent calls (including inside dw_pcie_ep_init) will use the cached
> value without re-searching.
>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> In pci-layerscape-ep, dw_pcie_find_capability() is called in:
>
>   ls_pcie_ep_probe()
>     -> offset = dw_pcie_find_capability()
>     -> pcie->lnkcap = dw_pcie_readl_dbi(offset + PCI_EXP_LNKCAP)
>     -> dw_pcie_ep_init()
>     -> ls_pcie_ep_interrupt_init()
>         -> devm_request_irq(..., ls_pcie_ep_event_handler)
>           -> ls_pcie_ep_event_handler()
>             -> dw_pcie_find_capability()
> ---
>  drivers/pci/controller/dwc/pci-layerscape-ep.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index 8936975ff104..b2d0b51df3c5 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -74,7 +74,6 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
>         struct ls_pcie_ep *pcie = dev_id;
>         struct dw_pcie *pci = pcie->pci;
>         u32 val, cfg;
> -       u8 offset;
>
>         val = ls_pcie_pf_lut_readl(pcie, PEX_PF0_PME_MES_DR);
>         ls_pcie_pf_lut_writel(pcie, PEX_PF0_PME_MES_DR, val);
> @@ -83,9 +82,6 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
>                 return IRQ_NONE;
>
>         if (val & PEX_PF0_PME_MES_DR_LUD) {
> -
> -               offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -
>                 /*
>                  * The values of the Maximum Link Width and Supported Link
>                  * Speed from the Link Capabilities Register will be lost
> @@ -93,7 +89,8 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
>                  * that configured by the Reset Configuration Word (RCW).
>                  */
>                 dw_pcie_dbi_ro_wr_en(pci);
> -               dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, pcie->lnkcap);
> +               dw_pcie_writel_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP,
> +                                  pcie->lnkcap);
>                 dw_pcie_dbi_ro_wr_dis(pci);
>
>                 cfg = ls_pcie_pf_lut_readl(pcie, PEX_PF0_CONFIG);
> @@ -266,7 +263,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, pcie);
>
> -       offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +       offset = dw_pcie_get_pcie_cap(pci);
>         pcie->lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>
>         ret = dw_pcie_ep_init(&pci->ep);
> --
> 2.34.1
>
>

