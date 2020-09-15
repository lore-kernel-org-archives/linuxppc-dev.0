Return-Path: <SRS0=6Pj3=CY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2479AC433E2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 11:27:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EF720872
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 11:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EF720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BrLZ05jqGzDqRY
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 21:27:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=ard.biesheuvel@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BrLBF6T4nzDqHb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2020 21:10:37 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD00D101E;
 Tue, 15 Sep 2020 04:10:35 -0700 (PDT)
Received: from [192.168.1.205] (unknown [10.37.8.121])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3847B3F718;
 Tue, 15 Sep 2020 04:10:31 -0700 (PDT)
Subject: Re: [PATCH v1] soc: fsl: rcpm: Add ACPI support
To: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
 Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200915110647.846-1-kuldip.dwivedi@puresoftware.com>
From: Ard Biesheuvel <ard.biesheuvel@arm.com>
Message-ID: <4e008f0a-69da-d5c2-4dfc-ef8695e17f47@arm.com>
Date: Tue, 15 Sep 2020 14:10:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200915110647.846-1-kuldip.dwivedi@puresoftware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 15 Sep 2020 21:24:02 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Biwen Li <biwen.li@nxp.com>,
 Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
 Ran Wang <ran.wang_1@nxp.com>, Paul Yang <Paul.Yang@arm.com>,
 Varun Sethi <V.Sethi@nxp.com>, tanveer <tanveer.alam@puresoftware.com>,
 Arokia Samy <arokia.samy@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 9/15/20 1:06 PM, kuldip dwivedi wrote:
> Add ACPI support in fsl RCPM driver. This is required
> to support ACPI S3 state. S3 is the ACPI sleep state
> that is known as "sleep" or "suspend to RAM".
> It essentially turns off most power of the system but
> keeps memory powered.
> 
> Signed-off-by: tanveer <tanveer.alam@puresoftware.com>
> Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>

Why does the OS need to program this device? Can't this be done by firmware?

> ---
> 
> Notes:
>      1. Add ACPI match table
>      2. NXP team members are added for confirming HID changes
>      3. There is only one node in ACPI so no need to check for
>         current device explicitly
>      4. These changes are tested on LX2160A and LS1046A platforms
> 
>   drivers/soc/fsl/rcpm.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
> index a093dbe6d2cb..e75a436fb159 100644
> --- a/drivers/soc/fsl/rcpm.c
> +++ b/drivers/soc/fsl/rcpm.c
> @@ -2,10 +2,12 @@
>   //
>   // rcpm.c - Freescale QorIQ RCPM driver
>   //
> -// Copyright 2019 NXP
> +// Copyright 2019-2020 NXP
> +// Copyright 2020 Puresoftware Ltd.
>   //
>   // Author: Ran Wang <ran.wang_1@nxp.com>
>   
> +#include <linux/acpi.h>
>   #include <linux/init.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> @@ -57,8 +59,13 @@ static int rcpm_pm_prepare(struct device *dev)
>   				rcpm->wakeup_cells + 1);
>   
>   		/*  Wakeup source should refer to current rcpm device */
> -		if (ret || (np->phandle != value[0]))
> -			continue;
> +		if (is_acpi_node(dev->fwnode)) {
> +			if (ret)
> +				continue;
> +		} else {
> +			if (ret || (np->phandle != value[0]))
> +				continue;
> +		}
>   
>   		/* Property "#fsl,rcpm-wakeup-cells" of rcpm node defines the
>   		 * number of IPPDEXPCR register cells, and "fsl,rcpm-wakeup"
> @@ -139,10 +146,19 @@ static const struct of_device_id rcpm_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, rcpm_of_match);
>   
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id rcpm_acpi_match[] = {
> +	{ "NXP0015", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, rcpm_acpi_match);
> +#endif
> +
>   static struct platform_driver rcpm_driver = {
>   	.driver = {
>   		.name = "rcpm",
>   		.of_match_table = rcpm_of_match,
> +		.acpi_match_table = ACPI_PTR(rcpm_acpi_match),
>   		.pm	= &rcpm_pm_ops,
>   	},
>   	.probe = rcpm_probe,
> 

