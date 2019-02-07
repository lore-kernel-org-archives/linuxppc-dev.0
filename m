Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B44C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 08:20:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B482175B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 08:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B482175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wB7d1dd1zDqR0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 19:19:57 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wB5j12lczDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 19:18:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43wB5h6fpyz8tRw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 19:18:16 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43wB5h6FqYz9sMM; Thu,  7 Feb 2019 19:18:16 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.221.193; helo=mail-vk1-f193.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com
 [209.85.221.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43wB5h053zz9s3x
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2019 19:18:15 +1100 (AEDT)
Received: by mail-vk1-f193.google.com with SMTP id 197so2307612vkf.4
 for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2019 00:18:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RE2NrBLoIBPxGIojYlK/FQqfGn+cjMC73A6it+hiZjg=;
 b=rFyXI5zgmuJyKG+3JqCVrA+yAFKLDvekqb026DYqZPw1IfxlG4a8lWpgUvn/YWb0aN
 bpAKWq9M15NfqWxlW+U9j8EvakeOYxS2wjcY03gaUdcUwngv9R9eLcfJchIU4Ef1Ir/A
 Wk8/GhN245BVvJvBFq5+9y8N45px0w84HCWqfWEeONcUOzfyzRXjbsXkDQ6MkqK1efYT
 XHQ/U5Qm/Odz6FIXQo1pKykI4BZvJtezirk4u3PNmJ5EE0oo8WblO03hoeAOZXYse3/e
 ngSa9R/XIo7zqBMNLpDir2gCMuwfwJnwiLeaIkXK5QML0IOkKyiOhlP4XfeInkYmDwX6
 NSmA==
X-Gm-Message-State: AHQUAubSAERWHWXMZfT71INP8yXdjIF3O64emnDcxF0v+0L+ObjrPd5X
 qYdUHCKNu829MMw3htlTKS3LCtax9rbG5WrkNfc=
X-Google-Smtp-Source: AHgI3IZEcydXU8VTYkXmT7ncEh9R12gJ4Y2LxHI09ab3Pgi5w5NXRnxQKMKe4RkFCGVVvou1wpYBZIbV723ggYm1EO8=
X-Received: by 2002:a1f:8614:: with SMTP id i20mr2705605vkd.74.1549527493836; 
 Thu, 07 Feb 2019 00:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20190207024935.30456-1-mpe@ellerman.id.au>
In-Reply-To: <20190207024935.30456-1-mpe@ellerman.id.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Feb 2019 09:18:02 +0100
Message-ID: <CAMuHMdUzhG4_eXn3xrzrDKHJcvZmhe9QNCue0x+GuE3SauwOqg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/44x: Force PCI on for CURRITUCK
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: Bjorn Helgaas <bhelgaas@google.com>, Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Randy Dunlap <rdunlap@infradead.org>, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

On Thu, Feb 7, 2019 at 3:49 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> The recent rework of PCI kconfig symbols exposed an existing bug in
> the CURRITUCK kconfig logic.
>
> It selects PPC4xx_PCI_EXPRESS which depends on PCI, but PCI is user
> selectable and might be disabled, leading to a warning:
>
>   WARNING: unmet direct dependencies detected for PPC4xx_PCI_EXPRESS
>     Depends on [n]: PCI [=n] && 4xx [=y]
>     Selected by [y]:
>     - CURRITUCK [=y] && PPC_47x [=y]
>
> Prior to commit eb01d42a7778 ("PCI: consolidate PCI config entry in
> drivers/pci") PCI was enabled by default for currituck_defconfig so we
> didn't see the warning. The bad logic was still there, it just
> required someone disabling PCI in their .config to hit it.
>
> Fix it by forcing PCI on for CURRITUCK, which seems was always the
> expectation anyway.
>
> Fixes: eb01d42a7778 ("PCI: consolidate PCI config entry in drivers/pci")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/platforms/44x/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
> index 4a9a72d01c3c..35be81fd2dc2 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -180,6 +180,7 @@ config CURRITUCK
>         depends on PPC_47x
>         select SWIOTLB
>         select 476FPE
> +       select FORCE_PCI
>         select PPC4xx_PCI_EXPRESS

Would "select PPC4xx_PCI_EXPRESS if PCI" be a suitable alternative?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
