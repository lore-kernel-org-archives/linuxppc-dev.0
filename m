Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA0BC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 21:23:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B162184C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 21:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B162184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44WF824cZyzDqYX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 08:22:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WF0m6KrlzDqXC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 08:16:37 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id u15so3303589otq.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 14:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JaV0olP+PRVr93TPoHK2LvE8ZTF6aplfAuvUXORDfRg=;
 b=QgbvpvM6Z+11mbKdkEkKCmB+klZ3NzE7AL2gZzh+ixY8VauuweuFi9vRcfOFVxsuT5
 nKMryomjxtw2pje+iUAhsyTGpm8Ukm4JQx7X6x31L978bGugWJxeZjqpDaDvYUmoPM9A
 EQ6h0OeARO0NYnwHZjeXzcBxlPx5lRMEWheaCW8AUAgqraihLmmzFRlchnO3+EoKgPQW
 Et8LzsW+RW4qY3skcN1cvK8bLtESoGL9eyB+rfwG6B2WeEDoX53pXUzFD6FbK6UtoMA1
 zdULk8TCqqDYIdURGme+vlo8OXh8paUPEJUjH/KidlFvKE/N0s156stARV8FM0kY5m0F
 bhlw==
X-Gm-Message-State: APjAAAUqLcpK8zX4TheRaL4534bcIXR3VE+otYEGBWhvlQYTjqn8u5of
 puJbfaK1ib/BnAquE1/79T39r8ABgLc=
X-Google-Smtp-Source: APXvYqzTiCJEzyRTE3Ntt1O4C7O/Y2KpdDBmpCL5/q14H5glry7WkkX0pdkFn6DZNnDAfYDh5jm80Q==
X-Received: by 2002:a9d:745a:: with SMTP id p26mr5431219otk.136.1553894192753; 
 Fri, 29 Mar 2019 14:16:32 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com.
 [209.85.210.52])
 by smtp.gmail.com with ESMTPSA id s73sm1228032oie.53.2019.03.29.14.16.31
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Mar 2019 14:16:31 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id t8so3320243otp.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 14:16:31 -0700 (PDT)
X-Received: by 2002:a9d:30d1:: with SMTP id r17mr34948159otg.331.1553894191481; 
 Fri, 29 Mar 2019 14:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
 <20190329140014.8126-3-laurentiu.tudor@nxp.com>
In-Reply-To: <20190329140014.8126-3-laurentiu.tudor@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 29 Mar 2019 16:16:20 -0500
X-Gmail-Original-Message-ID: <CADRPPNTPZ1xhYr_YKZvrXVJhVqhV9RNAu6ekVHDeOudXTZx3=g@mail.gmail.com>
Message-ID: <CADRPPNTPZ1xhYr_YKZvrXVJhVqhV9RNAu6ekVHDeOudXTZx3=g@mail.gmail.com>
Subject: Re: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: madalin.bucur@nxp.com, Netdev <netdev@vger.kernel.org>,
 Roy Pledge <roy.pledge@nxp.com>, lkml <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, camelia.groza@nxp.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 29, 2019 at 9:03 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Add a one-to-one iommu mapping for bman private data memory (FBPR).
> This is required for BMAN to work without faults behind an iommu.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/soc/fsl/qbman/bman_ccsr.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
> index 7c3cc968053c..b209c79511bb 100644
> --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
> @@ -29,6 +29,7 @@
>   */
>
>  #include "bman_priv.h"
> +#include <linux/iommu.h>
>
>  u16 bman_ip_rev;
>  EXPORT_SYMBOL(bman_ip_rev);
> @@ -178,6 +179,7 @@ static int fsl_bman_probe(struct platform_device *pdev)
>         int ret, err_irq;
>         struct device *dev = &pdev->dev;
>         struct device_node *node = dev->of_node;
> +       struct iommu_domain *domain;
>         struct resource *res;
>         u16 id, bm_pool_cnt;
>         u8 major, minor;
> @@ -225,6 +227,15 @@ static int fsl_bman_probe(struct platform_device *pdev)
>
>         dev_dbg(dev, "Allocated FBPR 0x%llx 0x%zx\n", fbpr_a, fbpr_sz);
>
> +       /* Create an 1-to-1 iommu mapping for FBPR area */
> +       domain = iommu_get_domain_for_dev(dev);
> +       if (domain) {
> +               ret = iommu_map(domain, fbpr_a, fbpr_a, fbpr_sz,
> +                               IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
> +               if (ret)
> +                       dev_warn(dev, "failed to iommu_map() %d\n", ret);
> +       }

Like Robin has pointed out, could you explain why the mapping in this
patch and other similar patches cannot be dealt with the dma APIs
automatically?  If the current bqman driver doesn't use the dma APIs
correctly, we need to fix that instead of doing the mapping
explicitly.

> +
>         bm_set_memory(fbpr_a, fbpr_sz);
>
>         err_irq = platform_get_irq(pdev, 0);
> --
> 2.17.1
>
