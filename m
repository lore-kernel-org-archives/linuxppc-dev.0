Return-Path: <SRS0=mPqZ=A4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2221C433E1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2020 10:12:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15ED420768
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2020 10:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHGsF97w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15ED420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B7RkL1HfzzDrPg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2020 20:12:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::143;
 helo=mail-lf1-x143.google.com; envelope-from=cyrozap@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=rHGsF97w; dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B7RhT6kFLzDrMW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2020 20:10:33 +1000 (AEST)
Received: by mail-lf1-x143.google.com with SMTP id y18so5699428lfh.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2020 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jfWY5jjkwOivxzVlYNxSL/wnM+Xe26stMAR5QfxU8lI=;
 b=rHGsF97wKV2dZ9VAw1cxfr2qcURcDnvZuxzYHcMQ9zN4JSARjf7t3kQs+TNjjzBM0d
 wywss8b5HPMRXwUCSnq36xEJgIM+W94O66fo2szJBz1kiBkizB1WO1pW8RYSqzTlyk0x
 HUPluuyxrooAgQx0J1xr+ogM00ZBRNH5yRELD27Yqv7OeO7qhuY5adHeHwmTl6/DDOrj
 eoua2n0KqjrTuvZslcJ4ujgX1Qgk/TNvYW14B4EGnwgjJRvxvOzBPDWPez7xfNfBQB7N
 MW26w0NZ0BpM5wHBEhR5DckDjZ9Cgayu2J8Ah/kBAjoDR8GI+PCa+LpcrSGSK5L1O1Bw
 zTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jfWY5jjkwOivxzVlYNxSL/wnM+Xe26stMAR5QfxU8lI=;
 b=fO0sG7XIoMv5PP4MrMYsBOstSCzSoVrsMY/Q+I5Yur2giaiVeyWCkB9XZ8q4KbPEeV
 pq/hEMwjS9nrajWd2NaiMQKdQBMMXVi6Q3i/PQrCtEDc5n0syEdYGKyxIqzmKE/aegYS
 MFIJvovoydoReBL27SWs8gZ0otpl5XFCjGnAfwPu5mCNIhdrZ2vFJnRCINHd42T6Z+11
 WI6VhkvJ1GtkZbcy620kvxBKmBqkV4QaQUrJotmxoD7Io/3EFDAQwt07ZU4ZhgVXGvCw
 Ds9GrSgscHFqakWE/wnbCoMcr0igCxF6Ka7IX1aWkbubY3wJvGSrptf4iCefemALm8U+
 0keQ==
X-Gm-Message-State: AOAM531lrtJZYp2Ntf/4HXL/9sYh1kvo1bFvEo2XFwA+yXURepKQrEIS
 Q2VFzD8UVQhv37jj+AqNUpOXvMMLvjXX7UflB1s=
X-Google-Smtp-Source: ABdhPJxPBxHhz4fylBNxu3Ww6ZGTMTiva9W+pOXNqRslqU3UCWrS8ol488xCldxHTdn/S2wx+aKyA2tku+kbLJXnJns=
X-Received: by 2002:ac2:4183:: with SMTP id z3mr1505854lfh.3.1594980627061;
 Fri, 17 Jul 2020 03:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAO3ALPy8_pxVyFROZUWNafEH1vUCP6LVpNmBBuMDSewGitzdLw@mail.gmail.com>
 <CAOSf1CEOu5jX6KXKWiConBf=TDwF3qdASMxtfDjqSR6vOKN4XA@mail.gmail.com>
In-Reply-To: <CAOSf1CEOu5jX6KXKWiConBf=TDwF3qdASMxtfDjqSR6vOKN4XA@mail.gmail.com>
From: Forest Crossman <cyrozap@gmail.com>
Date: Fri, 17 Jul 2020 05:10:15 -0500
Message-ID: <CAO3ALPwZPN1vdqHaFsuSpgj63o6Z69VUg0LngmCSnvESrO4kNg@mail.gmail.com>
Subject: Re: ASMedia USB 3.x host controllers triggering EEH on POWER9
To: "Oliver O'Halloran" <oohall@gmail.com>
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
Cc: linux-pci <linux-pci@vger.kernel.org>, linux-usb@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> In the future you can use this script to automate some of the tedium
> of parsing the eeh dumps:
> https://patchwork.ozlabs.org/project/skiboot/patch/20200717044243.1195833-1-oohall@gmail.com/

Ah, nice, thanks for showing me this! I had written my own parser that
just dumped a few register names and what bits were set in each, but
your script seems much more feature-complete.

> Anyway, for background the way PHB3 and PHB4 handle incoming DMAs goes
> as follows:
>
> 1. Map the 16bit <bus><devfn> number to an IOMMU context, we call
> those PEs. PE means "partitionable endpoint", but for the purpose of
> processing DMAs you can ignore that and just treat it as an IOMMU
> context ID.
> 2. Use the PE number and some of the upper bits of the DMA address to
> form the index into the Translation Validation Table.
> 3. Use the table entry to validate the DMA address is within bounds
> and whether it should be translated by the IOMMU or used as-is.
>
> If the table entry says the DMA needs to be translated by the IOMMU we'll also:
> 4. Walk the IOMMU table to get the relevant IOMMU table entry.
> 5. Validate the device has permission to read/write to that address.
>
> The "TVT Address Range Error" you're seeing means that the bounds
> checks done in 3) is failing. OPAL configures the PHB so there's two
> TVT entries (TVEs for short) assigned to each PE. Bit 59 of the DMA
> address is used to select which TVE to use. We typically configure
> TVE#0 to map 0x0...0x8000_0000 so there's a 2GB 32bit DMA window.
> TVE#1 is configured for no-translate (bypass) mode so you can convert
> from a system physical address to a DMA address by ORing in bit 59.

Thanks for the in-depth explanation, I find these low-level details
really fascinating.

> From word 2 of the PEST entry the faulting DMA address is:
> 0x0000203974c00000. That address is interesting since it looks a lot
> like a memory address on the 2nd chip, but it doesn't have bit 59 set
> so TVE#0 is used to validate it. Obviously that address is above 2GB
> so we get the error.

Ah, I see. Do you know if the information on the PEST registers is
documented publicly somewhere? I tried searching for what those
registers meant in the PHB4 spec but it basically just said, "the PEST
registers contain PEST data," which isn't particularly helpful.

> What's probably happening is that the ASmedia controller doesn't
> actually implement all 64 address bits and truncates the upper bits of
> the DMA address. Doing that is a blatant violation of the PCIe (and
> probably the xHCI) spec, but it's also pretty common since "it works
> on x86." Something to try would be booting with the iommu=nobypass in
> the kernel command line. That'll disable TVE#1 and force all DMAs to
> go through TVE#0.

Thanks, iommu=nobypass fixed it! Plugging in one or more USB devices
no longer triggers any EEH errors.

> Assuming the nobypass trick above works, what you really need to do is
> have the driver report that it can't address all 64bits by setting its
> DMA mask accordingly. For the xhci driver it looks like this is done
> in xhci_gen_setup(), there might be a quirks-style interface for
> working around bugs in specific controllers that you can use. Have a
> poke around and see what you can find :)

Yup, the xhci driver has a quirks system, and conveniently one of
those is XHCI_NO_64BIT_SUPPORT. After making a 3-line patch to
xhci-pci.c to add that quirk for this chip, the host controller is now
able to work without setting iommu=nobypass in the kernel arguments.

Thank you so much for your help! You've likely saved me several hours
of reading documentation, as well as several more hours of fiddling
around with the xhci driver. I'm almost disappointed the fix was so
simple, but the time savings alone more than makes up for it. I'll
submit the patch to the USB ML shortly.

Thanks again!

Forest
