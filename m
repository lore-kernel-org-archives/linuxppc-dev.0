Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0390C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 22:08:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3F5F2184D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 22:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F5F2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44WG8g2sKpzDqQV
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 09:08:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WG6s0lgVzDqQ9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 09:07:00 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id e5so3392632otk.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 15:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xMejZq18/+Wxs5n8oH4gqh9wWmcSonpiJfOlZddBtnY=;
 b=smKBQJcmckr63ysbPssIO2dZgggKkZ2sVlEa3PhW74HN7LY25M03e4GWfKHtM394ol
 +l6iL3p6m2ywBHj5RGsJGxOfPnpLOETBMwQcfeghSr3+IpKAPuJ2OmvY0jxv+xhOLuE2
 o21lF2jyRYA/NeJEOLAkZdQblk3/pOnaTuM4293/9cDjJUmEb7oFqtYDlPfk3DN6WrMC
 n9Ws34cZysPQQ6xIPb+MsRzMqs9XMxaXwp3evObL9rODwupkHsxdGayyULo8dXnqmWjo
 9v5JOLLSeZXvZfA5QFuZlcF9h/hLSk6kzyE/U8TWRPy5pDTcav+C5ooTERITX40+kUBh
 5LAA==
X-Gm-Message-State: APjAAAU+NN8OguvZM6Jlf3CPIP1zziRULYPXiCcuK1iZgzpTndaUvPXO
 C9lYE0r4ensEiRxkyU+zluNDgSj9D5M=
X-Google-Smtp-Source: APXvYqy8Umu1rHUnRnIw3MAKPYMQ+x5JQCTTqnMGOurIltryIXqVtlq5Vz2kdM71I0zM2xiqhGuMNA==
X-Received: by 2002:a9d:7e91:: with SMTP id m17mr10273219otp.78.1553897218458; 
 Fri, 29 Mar 2019 15:06:58 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com.
 [209.85.210.47])
 by smtp.gmail.com with ESMTPSA id l63sm1269589oia.47.2019.03.29.15.06.57
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Mar 2019 15:06:57 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id e80so3427933ote.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 15:06:57 -0700 (PDT)
X-Received: by 2002:a9d:6a47:: with SMTP id h7mr3522537otn.158.1553897217564; 
 Fri, 29 Mar 2019 15:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
 <20190329140014.8126-6-laurentiu.tudor@nxp.com>
In-Reply-To: <20190329140014.8126-6-laurentiu.tudor@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 29 Mar 2019 17:06:45 -0500
X-Gmail-Original-Message-ID: <CADRPPNTh65rwPVVzJBWt-cNrbQWAoo0FeTGnCHDiqSxvARa_5g@mail.gmail.com>
Message-ID: <CADRPPNTh65rwPVVzJBWt-cNrbQWAoo0FeTGnCHDiqSxvARa_5g@mail.gmail.com>
Subject: Re: [PATCH 05/13] soc/fsl/bqman: page align iommu mapping sizes
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

On Fri, Mar 29, 2019 at 9:01 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Prior to calling iommu_map()/iommu_unmap() page align the size or
> failures such as below could happen:
>
> iommu: unaligned: iova 0x... pa 0x... size 0x4000 min_pagesz 0x10000
> qman_portal 500000000.qman-portal: failed to iommu_map() -22
>
> Seen when booted a kernel compiled with 64K page size support.

This will silently incease the actual space mapped to 64K when the
driver is actually trying to map 4K.  Will this potentially cause
security breaches?  If it is really safe to map 64K, probably the
better way is to increase the region size to 64k in the device tree
explicitly.

>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/soc/fsl/qbman/bman_ccsr.c   | 2 +-
>  drivers/soc/fsl/qbman/qman_ccsr.c   | 4 ++--
>  drivers/soc/fsl/qbman/qman_portal.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
> index b209c79511bb..3a6e01bde32d 100644
> --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
> @@ -230,7 +230,7 @@ static int fsl_bman_probe(struct platform_device *pdev)
>         /* Create an 1-to-1 iommu mapping for FBPR area */
>         domain = iommu_get_domain_for_dev(dev);
>         if (domain) {
> -               ret = iommu_map(domain, fbpr_a, fbpr_a, fbpr_sz,
> +               ret = iommu_map(domain, fbpr_a, fbpr_a, PAGE_ALIGN(fbpr_sz),
>                                 IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
>                 if (ret)
>                         dev_warn(dev, "failed to iommu_map() %d\n", ret);
> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
> index eec7700507e1..8d3c950ce52d 100644
> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> @@ -783,11 +783,11 @@ static int fsl_qman_probe(struct platform_device *pdev)
>         /* Create an 1-to-1 iommu mapping for fqd and pfdr areas */
>         domain = iommu_get_domain_for_dev(dev);
>         if (domain) {
> -               ret = iommu_map(domain, fqd_a, fqd_a, fqd_sz,
> +               ret = iommu_map(domain, fqd_a, fqd_a, PAGE_ALIGN(fqd_sz),
>                                 IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
>                 if (ret)
>                         dev_warn(dev, "iommu_map(fqd) failed %d\n", ret);
> -               ret = iommu_map(domain, pfdr_a, pfdr_a, pfdr_sz,
> +               ret = iommu_map(domain, pfdr_a, pfdr_a, PAGE_ALIGN(pfdr_sz),
>                                 IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
>                 if (ret)
>                         dev_warn(dev, "iommu_map(pfdr) failed %d\n", ret);
> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> index dfb62f9815e9..bce56da2b01f 100644
> --- a/drivers/soc/fsl/qbman/qman_portal.c
> +++ b/drivers/soc/fsl/qbman/qman_portal.c
> @@ -297,7 +297,7 @@ static int qman_portal_probe(struct platform_device *pdev)
>                  */
>                 err = iommu_map(domain,
>                                 addr_phys[0]->start, addr_phys[0]->start,
> -                               resource_size(addr_phys[0]),
> +                               PAGE_ALIGN(resource_size(addr_phys[0])),
>                                 IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
>                 if (err)
>                         dev_warn(dev, "failed to iommu_map() %d\n", err);
> --
> 2.17.1
>
