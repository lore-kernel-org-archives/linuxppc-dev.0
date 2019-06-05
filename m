Return-Path: <SRS0=mj2b=UE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6DCC282DE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Jun 2019 05:25:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9B52075C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Jun 2019 05:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKkNcxsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9B52075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Jcgq0LbmzDqcD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Jun 2019 15:25:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VKkNcxsx"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45JcfT2xlRzDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2019 15:24:17 +1000 (AEST)
Received: by mail-it1-x142.google.com with SMTP id j204so1684966ite.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jun 2019 22:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/Y7D47X9/ZL/hMysvyizdxmDRjUTupUrqUifjjtc3jM=;
 b=VKkNcxsxFCwe94LqkMPeJjc4dy55uhRzLVXCyXH9Yi/QWr2DnZcIYfpiZ3kWlMTGVH
 zQepTs2WlaCsuXj7kEeIW5N8nEN+WqhaUhIPb9QcCTIS/6C78mZiEL+1E42my5q44vFw
 pZIJ7qYVWUwPgeEU1Yp+SOOsNJV4ORf0BuKCqACyMakV/GgGfAEd37fB7fQV2olzLHrw
 43RbVvixcU0V7EL/2wXwUZvO9e59WfjdqIhyvuYBFYfamFGwV1hyvHCQJfuvFfl+2iqL
 NN8KAZ62OcwhMYFvRCKR8PApTY2aIlzz1bfrRreBK8Oek1n+4e3fAU3+eZNzvJSc6t1w
 oCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/Y7D47X9/ZL/hMysvyizdxmDRjUTupUrqUifjjtc3jM=;
 b=ADLXkCEfy6MA1V6PCQysxZgtk2AiplNvSLM4lXadjFb1qwWaQN2pa59zOz8W0gBkkK
 DLHNb3j1tH7q4sItkRdjagc8u9Za8k0v7rMRR6KC0jQk9/5Z9+crNDWp6St9llbeAVf6
 4S7a5MGtb45kaXnP/VoMho5omZ/ZpOhRBYAqonQCuxMDRObWQQdQf5w6Ujt6BCM88lbC
 1SHk7G/B7uouYY7uYI6WUIk+pfkSeDQbBD7HZ6PXM6Jzy65blnJ1DijlQIg91iTyLzAl
 2Xn3mQN4FbWyr1pKiSRTzPjqq9VQQUfrZuwtG68e8n+AHdiUIV0Z6N57GudDZm4Dxv0+
 RgMw==
X-Gm-Message-State: APjAAAVj2hq9N5HL7xZSMrbMuX9x7fMgoRw1IGG3y+Oyf+LtphGu8cWa
 qbl7PFnC3We8gzdv/8N+JXiWkVwCdShOqO0VHks=
X-Google-Smtp-Source: APXvYqwqXIgv4wUFenB9COpE9ZYREN4fOxV821LmMA9TcSodsUYgSa0ookfxQman5zCK8sPXq84Fnb20ySB7KeOsio0=
X-Received: by 2002:a02:c918:: with SMTP id t24mr25031329jao.111.1559712253837; 
 Tue, 04 Jun 2019 22:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190605033814.127962-1-aik@ozlabs.ru>
In-Reply-To: <20190605033814.127962-1-aik@ozlabs.ru>
From: Oliver <oohall@gmail.com>
Date: Wed, 5 Jun 2019 15:24:02 +1000
Message-ID: <CAOSf1CG0cTatNED4-OGL2PMabWrH_z-NHuRu-7FMO4V2fTe3Lg@mail.gmail.com>
Subject: Re: [PATCH kernel] powerpc/pci/of: Fix OF flags parsing for 64bit BARs
To: Alexey Kardashevskiy <aik@ozlabs.ru>
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
Cc: Shawn Anastasio <shawn@anastas.io>, Sam Bobroff <sbobroff@linux.ibm.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jun 5, 2019 at 1:38 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> When the firmware does PCI BAR resource allocation, it passes the assigned
> addresses and flags (prefetch/64bit/...) via the "reg" property of
> a PCI device device tree node so the kernel does not need to do
> resource allocation.
>
> The flags are stored in resource::flags - the lower byte stores
> PCI_BASE_ADDRESS_SPACE/etc bits and the other bytes are IORESOURCE_IO/etc.
> Some flags from PCI_BASE_ADDRESS_xxx and IORESOURCE_xxx are duplicated,
> such as PCI_BASE_ADDRESS_MEM_PREFETCH/PCI_BASE_ADDRESS_MEM_TYPE_64/etc.
> When parsing the "reg" property, we copy the prefetch flag but we skip
> on PCI_BASE_ADDRESS_MEM_TYPE_64 which leaves the flags out of sync.
>
> The missing IORESOURCE_MEM_64 flag comes into play under 2 conditions:
> 1. we remove PCI_PROBE_ONLY for pseries (by hacking pSeries_setup_arch()
> or by passing "/chosen/linux,pci-probe-only");
> 2. we request resource alignment (by passing pci=resource_alignment=
> via the kernel cmd line to request PAGE_SIZE alignment or defining
> ppc_md.pcibios_default_alignment which returns anything but 0). Note that
> the alignment requests are ignored if PCI_PROBE_ONLY is enabled.
>
> With 1) and 2), the generic PCI code in the kernel unconditionally
> decides to:
> - reassign the BARs in pci_specified_resource_alignment() (works fine)
> - write new BARs to the device - this fails for 64bit BARs as the generic
> code looks at IORESOURCE_MEM_64 (not set) and writes only lower 32bits
> of the BAR and leaves the upper 32bit unmodified which breaks BAR mapping
> in the hypervisor.
>
> This fixes the issue by copying the flag. This is useful if we want to
> enforce certain BAR alignment per platform as handling subpage sized BARs
> is proven to cause problems with hotplug (SLOF already aligns BARs to 64k).
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
> This code is there for ages (from 200x) hence no "Fixes:".
>
> Ideally I want to enforce /chosen/linux,pci-probe-only in QEMU as
> at the moment:
> - pci=resource_alignment= alone does not do anything;
> - /chosen/linux,pci-probe-only alone does not cause the kernel to
> reassign resources;
> - pci=resource_alignment= with /chosen/linux,pci-probe-only is broken
> anyway.
>
> ---
>  arch/powerpc/kernel/pci_of_scan.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index 24191ea2d9a7..64ad92016b63 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -45,6 +45,8 @@ unsigned int pci_parse_of_flags(u32 addr0, int bridge)
>         if (addr0 & 0x02000000) {
>                 flags = IORESOURCE_MEM | PCI_BASE_ADDRESS_SPACE_MEMORY;
>                 flags |= (addr0 >> 22) & PCI_BASE_ADDRESS_MEM_TYPE_64;
> +               if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
> +                       flags |= IORESOURCE_MEM_64;
>                 flags |= (addr0 >> 28) & PCI_BASE_ADDRESS_MEM_TYPE_1M;
>                 if (addr0 & 0x40000000)
>                         flags |= IORESOURCE_PREFETCH
> --
> 2.17.1

Seems like an oversight that PROBE_ONLY has been papering over for years.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
