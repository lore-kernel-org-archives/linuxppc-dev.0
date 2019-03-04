Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47E8C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 11:40:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA7520643
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 11:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjpSXJIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA7520643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CdPD5970zDqHY
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 22:40:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d43; helo=mail-io1-xd43.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UjpSXJIf"; 
 dkim-atps=neutral
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CdM41TTmzDqGQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 22:38:21 +1100 (AEDT)
Received: by mail-io1-xd43.google.com with SMTP id k21so3686421ior.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Mar 2019 03:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zXfSApzw86t9mnLh+zEicCpK42Ya6ndhFFb7mDCh0oo=;
 b=UjpSXJIfxbvJQFDU7ZF++t3grlaOlXmk62sbX4dz4fhYJp71TYDBNNJf2s6b8WYC7J
 8/mEux8Oco3XU8G3JCMdeOEQR9tVEg4F2IVwmc07WUKazPY/csyYM2GFcGcTqM0kgs2o
 pVr3jF/7wzpGyLkQn5sUAFAvv0JvkqTzRVa5TniIFAuha5TjoeQ/bSmV6LNrn/fS7Cld
 EJugn90WFGXq3xdb0qpBIKOmzJs/3ErTpG4mIaTAdRi9du/CLm4zKkGQ0DCOqcEt+a6a
 3RUOLNsV0NvWzDAQ/lRKvkPMxAlt336MSkvX3ZItH2VSidQ3x/iklUROygnkCgURDVP4
 431w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zXfSApzw86t9mnLh+zEicCpK42Ya6ndhFFb7mDCh0oo=;
 b=iREnveoBTQEM/lRJaIXk/CSvgGeCaHqUwj1E4zaJYMXcZ6cML3lgAis77HkSWy1S6F
 eTrvkGbJvS/SIFRpHAy0wEu9lxClGaSQesemxSROtoy2lHBbPbUtFFpV7k7H8/vkaFU8
 YYUyWCIudVrdfYbgo1BYvRJhuGUIfn0ud8a+e+8LPR8oTFOqrW+Swg7mJTAFKSDMjRl5
 kOcSg/0kt94bd7F2JAgrD8J2AXVsisyxUzJDwBsdCbI9jR6NO0W8ktGMBNILUkxL4JeL
 pQ2VsG4zzWCYbE8Ff2C38S6CHw5ObFZsB3zZxB7or/sZXPngXmiNSFAXeHkr/m0B0HLI
 6rCQ==
X-Gm-Message-State: APjAAAUTJYjhk7syUt/2/nxIpyo1bSlywbJmVc4nSNyxIboCgOUMH33j
 4tN66djT+sYa2qlQ4iY9zcIRuoS2hF/wKBOr5ZQ=
X-Google-Smtp-Source: APXvYqye19pk4abX9Fb1bjXIsaLYCGULn5Inhi+ZcPV8odUpVVz8rqnLOFQYRxQiZgbaBcvEdRovBkegecHUYottMz4=
X-Received: by 2002:a6b:7941:: with SMTP id j1mr9562624iop.262.1551699495070; 
 Mon, 04 Mar 2019 03:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20190301160440.26262-1-s.miroshnichenko@yadro.com>
In-Reply-To: <20190301160440.26262-1-s.miroshnichenko@yadro.com>
From: Oliver <oohall@gmail.com>
Date: Mon, 4 Mar 2019 22:38:03 +1100
Message-ID: <CAOSf1CFTU5TxDa94=O=cBZAYhL_Fi+Fgcvp69f6HLRz--=CPBg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 0/9] powerpc/powernv/pci: Make hotplug
 self-sufficient, independent of FW and DT
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
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
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux@yadro.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Mar 2, 2019 at 3:04 AM Sergey Miroshnichenko
<s.miroshnichenko@yadro.com> wrote:
>
> This patchset allows switching from the pnv_php module to the standard
> pciehp driver for PCIe hotplug functionality, if the platform supports it:
> PowerNV working on on top of the skiboot with the "core/pci: Sync VFs and
> the changes of bdfns between the firmware and the OS" patch serie applied.
>
> The feature is activated by the "pci=realloc" command line argument.
>
> The goal is ability to hotplug bridges full of devices in the future. The
> "Movable BARs" [1] is a platform-independent part of our work in this. The
> final part will be movable bus numbers to support inserting a bridge in the
> middle of an existing PCIe tree.
>
> Tested on POWER8 PowerNV+PHB3 ppc64le (our Vesnin server) with:
>  - the pciehp driver active;
>  - the pnv_php driver disabled;

Cool :)

I've had a brief look at this and it the approach seems reasonable.
I'll have a more detailed look and see how it fares on a P9 system
tomorrow.

>  - The "pci=realloc" argument is passed;
>  - surprise hotplug of an NVME disk works;
>  - controlled hotplug of a network card with SR-IOV works;
>  - activating of SR-IOV on a network card works;
>  - [with extra patches] manually initiated (via sysfs) rescan has found
>    and turned on a hotplugged bridge;
>  - Without "pci=realloc" works just as before.
>
> Changes since v3 [2]:
>  - Subject changed;
>  - Don't disable EEH during rescan anymore - instead just unfreeze the
>    target buses deliberately;
>  - Add synchronization with the firmware when changing the PCIe topology;
>  - Fixed for VFs;
>  - Code cleanup.
>
> Changes since v2:
>  - Don't reassign bus numbers on PowerNV by default (to retain the default
>    behavior), but only when pci=realloc is passed;
>  - Less code affected;
>  - pci_add_device_node_info is refactored with add_one_dev_pci_data;
>  - Minor code cleanup.
>
> Changes since v1:
>  - Fixed build for ppc64le and ppc64be when CONFIG_PCI_IOV is disabled;
>  - Fixed build for ppc64e when CONFIG_EEH is disabled;
>  - Fixed code style warnings.
>
> [1] https://www.spinics.net/lists/linux-pci/msg79995.html
> [2] https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-September/178053.html
>
> Sergey Miroshnichenko (9):
>   powerpc/pci: Access PCI config space directly w/o pci_dn
>   powerpc/powernv/pci: Suppress an EEH error when reading an empty slot
>   powerpc/pci: Create pci_dn on demand
>   powerpc/pci: Reduce code duplication in pci_add_device_node_info
>   powerpc/powernv/ioda: Fix using uninitialized IOMMU group
>   powerpc/pci/IOV: Add support for runtime enabling the VFs
>   powerpc/pci: Don't rely on DT is the PCI_REASSIGN_ALL_BUS is set
>   powerpc/powernv/pci: Hook up the writes to PCI_SECONDARY_BUS register
>   powerpc/powernv/pci: Enable reassigning the bus numbers
>
>  arch/powerpc/include/asm/pci-bridge.h        |   2 +-
>  arch/powerpc/include/asm/ppc-pci.h           |   1 +
>  arch/powerpc/kernel/pci_dn.c                 | 164 +++++++++++----
>  arch/powerpc/kernel/rtas_pci.c               |  97 ++++++---
>  arch/powerpc/platforms/powernv/eeh-powernv.c |   2 +-
>  arch/powerpc/platforms/powernv/pci-ioda.c    |   5 +-
>  arch/powerpc/platforms/powernv/pci.c         | 208 +++++++++++++++++--
>  arch/powerpc/platforms/pseries/pci.c         |   2 +-
>  8 files changed, 381 insertions(+), 100 deletions(-)
>
> --
> 2.20.1
>
