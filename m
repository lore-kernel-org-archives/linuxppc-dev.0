Return-Path: <SRS0=Kv2y=OJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9D4C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 11:47:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296FB2082F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 11:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWxaXWCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296FB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435t1453KGzDr68
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 22:47:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SWxaXWCf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::e43; helo=mail-vs1-xe43.google.com;
 envelope-from=rsalvaterra@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SWxaXWCf"; 
 dkim-atps=neutral
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com
 [IPv6:2607:f8b0:4864:20::e43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435sy02cz1zDrRY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 22:44:55 +1100 (AEDT)
Received: by mail-vs1-xe43.google.com with SMTP id v205so3154849vsc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 03:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NfGBLwjoprYk9UKLztyEYMY3kS/F2jQg2rNXpAjWL0c=;
 b=SWxaXWCf90RC/viOeI8KLUnANscg8zyNRAF4DNDeI2aRRhgW/bjaAVO0yYK+kPYndQ
 FwumgLU1JctR6jZayR4v38oyETvM7YcEKkYpKgBkXN9XeWP0OYf6rF9Xf/Rbt2fJHxAu
 ey/CTbzSxeUHtKVf+jJsmhuPiReBbxihRKUwz4efq+9MsxKdlsF+4Rlm0zODqNSkzp/7
 1V+DKALTN5n8cixAUIDUkWI1C8I+vSdG3jQnxynTDd48uYvKYZslkzErkRih7NoE4Hnu
 hU9EWUSEl+o5ClYlRfE2uNWxL+MeBjnVIIMYvN9JfXwHK3IYtkk4UAosl5JcFT8dFHwH
 NOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NfGBLwjoprYk9UKLztyEYMY3kS/F2jQg2rNXpAjWL0c=;
 b=R1BSBHFrIfbbJ8gJMv+LrU1KAHEPRVYAWWuIqst2mjZFeaexie2IoCja74hi1wimMJ
 cM/TK+dC5ieyiF84VR0zxeRQh9bkxJiBUi+WUjlRpk+e+VABkefZnu1JQzqF5XDrABCk
 aFjjwjfAW/iriTzPk5RI6pcYZzqozZW+bqVE0nZSB78axWH7EtxkmftkSlH2trUwp7QM
 u+J2bY0cKYK1Y2x+JRduul84PnQGNMfgiWeV7eZtHczUUiICXNpKpBs0cMUkHlIDnR4G
 Slu+tHx/pA5G/w4mZLFKNhyfouFiic59wxmMPtnIN0d6TKFiYIineeYwIGzgZLSKxKX4
 sndA==
X-Gm-Message-State: AA+aEWb2Jss5ysp4MIXK7ATyrPXLQrlD6ggadMjTHiab7PE72DGGY6MN
 KWD5mOw+boaLTIx74ZMVtJHkb22FHI33DQ8ozA==
X-Google-Smtp-Source: AFSGD/UXdTJx7sh2NfJG7XBJXLmAn7HdewZ7ZKdKEcvvI9nbKaRrW4Gi0vfsyUWs2URKCtox8w4Xm2a/mSSkwIBI9HU=
X-Received: by 2002:a67:2a83:: with SMTP id q125mr2350849vsq.230.1543578292331; 
 Fri, 30 Nov 2018 03:44:52 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
 <20181130103222.GA23393@lst.de>
In-Reply-To: <20181130103222.GA23393@lst.de>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Fri, 30 Nov 2018 11:44:41 +0000
Message-ID: <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
Subject: Re: use generic DMA mapping code in powerpc V4
To: hch@lst.de
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 30 Nov 2018 at 10:32, Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Rui,
>
> can you check if the patch below fixes the issue for you?
>
> diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
> index 2e24fc87ed84..809797dbe169 100644
> --- a/arch/powerpc/sysdev/dart_iommu.c
> +++ b/arch/powerpc/sysdev/dart_iommu.c
> @@ -392,7 +392,9 @@ static void pci_dma_dev_setup_dart(struct pci_dev *dev)
>
>  static bool iommu_bypass_supported_dart(struct pci_dev *dev, u64 mask)
>  {
> -       return dart_is_u4 && dart_device_on_pcie(&dev->dev);
> +       return dart_is_u4 &&
> +               dart_device_on_pcie(&dev->dev) &&
> +               mask >= DMA_BIT_MASK(40);
>  }
>
>  void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)

Hi, Christoph,

Thanks for the quick response! I applied it on top of your
powerpc-dma.4 branch and retested.
I'm not seeing nouveau complaining anymore (I'm not using X11 or any
DE, though).
In any case and FWIW, this series is

Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>

Thanks,
Rui
