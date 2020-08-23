Return-Path: <SRS0=/FMb=CB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95062C433E1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Aug 2020 00:34:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0918820738
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Aug 2020 00:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prB0m3ov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0918820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BYx8W1hDwzDqty
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Aug 2020 10:34:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d41;
 helo=mail-io1-xd41.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=prB0m3ov; dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BYx6x0PJpzDqPm
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Aug 2020 10:32:56 +1000 (AEST)
Received: by mail-io1-xd41.google.com with SMTP id m23so4660506iol.8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2020 17:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SsZoxPoLhqbUeZj/RqXQMzdgBATwQI9M/taaTrFxrcI=;
 b=prB0m3ovlX+Tt7YUwdPANWpMeqw7MuVw7bYlxs+v5vW/Pqq3Y3oq/jsjGzDlefrxBd
 /forhKz6f3SZcNq0UOnmXJIOA1chkAe+tRp5n+fxP8sG/qX8DYITd6APtOEQfz4mpvTg
 hTXD8W6T3p3au+XfWxGcGs2/WEriqH+Bh6Drk/Tf3FecbPfXKcmC9HCfHK0NQW61KG+7
 8yPonEh8UTLOvY3AuEW/VnYHMpyQ3uP/DLpifZ9BMhrB1fFD3TpkYIWeeubcPbLkCixG
 DFAxS6S6fCBMWWgJaK+6UQjb/tBy/YcU0dkCAfu71XwRA7ptg+JO0ximpkpevMGF2ZDc
 gUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SsZoxPoLhqbUeZj/RqXQMzdgBATwQI9M/taaTrFxrcI=;
 b=i3+NMYcHV5mdvw9OjJu5YTgPcSrbdFJat032xJ9/K2Hxl0XksRaDc5e1u7Y66zX4zd
 Yani0DghRP1SS+B90Xn8C9nwLZAgSzysR4wBxxuuhd0njhBsGpLj9ByOMdsTY0swqLhR
 UEWyV8Xep9UxluAryg0ZcwqBK4yw2OrHm4p+bpWbRAQjt1cgB252kposihBbTJXc9whC
 WvxVRzQHmF7f34vN4jo+OWQ+cZYe4oQNY4d3WcJbE2TVoR6o7XkIapqPhERgoCcYL5w5
 M8JE5rG4hfgWOO+Bgqr/AupzB38YxUxYGBBzCVSewJ1NP00MEHqzwI9MKeG6W9oLwcFc
 pYkA==
X-Gm-Message-State: AOAM533vVYYucRvBPJPucG0m6SDk2yXjFclwhe9VXWO6itZJuvTArnVn
 leHmQKIgZfLVXusvHonfKzdLjOZyZ85bpL/va94=
X-Google-Smtp-Source: ABdhPJzzwaYlNUJ0FlaOId7Z0x9I2Pa+zPa/qWXmbhq/hdzbTohApMlq8N0UjiDH/QXpAExGFsND/3crvlUdV6wZ9Cw=
X-Received: by 2002:a6b:b292:: with SMTP id b140mr5342260iof.87.1598142773579; 
 Sat, 22 Aug 2020 17:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200821205115.50333-1-shawn@anastas.io>
In-Reply-To: <20200821205115.50333-1-shawn@anastas.io>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Sun, 23 Aug 2020 10:32:42 +1000
Message-ID: <CAOSf1CGjm576cj3mqAqhp0xGE4P5F0ULNBPWxN44kmBLgUh4_A@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pseries: Add pcibios_default_alignment
 implementation
To: Shawn Anastasio <shawn@anastas.io>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Aug 22, 2020 at 6:51 AM Shawn Anastasio <shawn@anastas.io> wrote:
>
> Implement pcibios_default_alignment for pseries so that
> resources are page-aligned. The main benefit of this is being
> able to map any resource from userspace via mechanisms like VFIO.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>

That said, there's nothing power specific about this so we should
probably drop the pcibios hacks and fix the default alignment in the
PCI core.

> This is identical to powernv's implementation.
>
> Signed-off-by: Shawn Anastasio <shawn@anastas.io>
> ---
>  arch/powerpc/platforms/pseries/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 911534b89c85..6d922c096354 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -210,6 +210,11 @@ int pseries_pcibios_sriov_disable(struct pci_dev *pdev)
>  }
>  #endif
>
> +static resource_size_t pseries_pcibios_default_alignment(void)
> +{
> +       return PAGE_SIZE;
> +}
> +
>  static void __init pSeries_request_regions(void)
>  {
>         if (!isa_io_base)
> @@ -231,6 +236,8 @@ void __init pSeries_final_fixup(void)
>
>         eeh_show_enabled();
>
> +       ppc_md.pcibios_default_alignment = pseries_pcibios_default_alignment;
> +
>  #ifdef CONFIG_PCI_IOV
>         ppc_md.pcibios_sriov_enable = pseries_pcibios_sriov_enable;
>         ppc_md.pcibios_sriov_disable = pseries_pcibios_sriov_disable;
> --
> 2.28.0
>
