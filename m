Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EC7C7112A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 06:43:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07D02086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 06:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YIT2tug1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07D02086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YTRl1GtMzF3F2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 17:43:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="YIT2tug1";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.82; helo=conssluserg-03.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="YIT2tug1"; 
 dkim-atps=neutral
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YTK73V0RzF0PT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 17:38:02 +1100 (AEDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id w9F6bgUF007281
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:37:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9F6bgUF007281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1539585463;
 bh=1AMjU1A6/uICsHilAFIoOIpHvInEhbWkBwxYmpRFp1Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YIT2tug1GR0Mfp9osYA8vylx5Jo21YJwqIZBPc0W8ePyG4j2TRktS1dOB5BKtReAF
 ZO4dVJWXCAQr2O45MTpNdJBoWd+ft/avpbgRy0tfrzrv8r8+OYHT9ACfR+NMQIpx4X
 uawHGdoZzdrFF5C+B1hDpQ6qamFU5nco5Zcoz9WVniFh2S8YWcwBH/4L01yI1XMiGO
 EsiG142QLMwi7D23sWGWt8FKqb+Hg8qn7TS37XkdzCnwVPDIOD0AHRQqfwCF2Xbsw5
 hav1t0ZuZ9QYiM0Yo1bOTer0u0pBeGB5qMw+zFMQy3/AZShYBpX9kKwu/iJzmlb2ly
 BDpaChKHTFqxw==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id c10so15629711vsk.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 23:37:42 -0700 (PDT)
X-Gm-Message-State: ABuFfogvCtZc2xxL18opL5ZUcn8MnIXnM3fOS+J1kfllVyZ6WfvEDHcx
 LRFy6Xq9DvLFT0C1FDPfALRJB61XL6wTUpbsniE=
X-Google-Smtp-Source: ACcGV60Ueo0wYOOiysuClAVTt0oCDdBckmM7hkj3VFb7XIu/mRmOAMyXSDxls3MtLn70/osDPK8vRmHL7j2+IKLLF54=
X-Received: by 2002:a67:5fc7:: with SMTP id t190mr6266579vsb.155.1539585461532; 
 Sun, 14 Oct 2018 23:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151016.31674-1-hch@lst.de>
 <20181013151016.31674-5-hch@lst.de>
In-Reply-To: <20181013151016.31674-5-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 15 Oct 2018 15:37:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQy_NTu5=8R6C3Xc2VLrJo7tKOz-u1=3JfGtBa3Z+ZD9g@mail.gmail.com>
Message-ID: <CAK7LNAQy_NTu5=8R6C3Xc2VLrJo7tKOz-u1=3JfGtBa3Z+ZD9g@mail.gmail.com>
Subject: Re: [PATCH 4/8] pci: consolidate PCI config entry in drivers/pci
To: Christoph Hellwig <hch@lst.de>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>, alex.bou9@gmail.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Oct 14, 2018 at 12:11 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no good reason to duplicate the PCI menu in every architecture.
> Instead provide a selectable HAS_PCI symbol that indicates availability
> of PCI support and the handle the rest in drivers/pci.


I think HAVE_ is a preferred prefix in this case according to this doc:
https://github.com/masahir0y/linux/blob/v4.19-rc4/Documentation/kbuild/kconfig-language.txt#L448


It is true we have some options with HAS_ prefix,
but the majority is HAVE_.

masahiro@pug:~/ref/linux$ find . -name 'Kconfig*' | xargs grep 'config
HAS_' | wc
      9      18     355
masahiro@pug:~/ref/linux$ find . -name 'Kconfig*' | xargs grep 'config
HAVE_' | wc
    177     354    8182





> Note that for powerpc we now select HAS_PCI globally instead of the
> convoluted mess of conditional or or non-conditional support per board,
> similar to what we do e.g. on x86.  For alpha PCI is selected for the
> non-jensen configs as it was the default before, and a lot of code does
> not compile without PCI enabled.  On other architectures with limited
> PCI support that wasn't as complicated I've left the selection as-is.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---



> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 6fa6f92edb7f..0713375e1127 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -168,10 +168,16 @@ config PPC
>         select GENERIC_CPU_VULNERABILITIES      if PPC_BARRIER_NOSPEC
>         select GENERIC_IRQ_SHOW
>         select GENERIC_IRQ_SHOW_LEVEL
> +       select GENERIC_PCI_IOMAP                if PCI
>         select GENERIC_SMP_IDLE_THREAD
>         select GENERIC_STRNCPY_FROM_USER
>         select GENERIC_STRNLEN_USER
>         select GENERIC_TIME_VSYSCALL
> +       # Platforms that what PCI turned unconditionally just do select PCI
> +       # in their config node, otherwise allow the user to enable it.
> +       # This means we can enable PCI even on platforms that don't support
> +       # it, which is harmless except for wasted memory.
> +       select HAS_PCI


If you do this for entire powerpc,
the other 'select HAS_PCI' addtions to
arch/powerpc/platforms/*/Kconfig look redundant.





> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a344980287a5..6eb31a0698ac 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -38,6 +38,7 @@ config RISCV
>         select RISCV_ISA_A if SMP
>         select SPARSE_IRQ
>         select SYSCTL_EXCEPTION_TRACE
> +       select HAS_PCI
>         select HAVE_ARCH_TRACEHOOK
>         select MODULES_USE_ELF_RELA if MODULES
>         select THREAD_INFO_IN_TASK
> @@ -216,28 +217,12 @@ source "kernel/Kconfig.hz"
>
>  endmenu
>
> -menu "Bus support"
> -
> -config PCI
> -       bool "PCI support"
> -       select PCI_MSI


I think this 'select PCI_MSI' for riscv was lost.




> -       help
> -         This feature enables support for PCI bus system. If you say Y
> -         here, the kernel will include drivers and infrastructure code
> -         to support PCI bus devices.
> -
> -         If you don't know what to do here, say Y.
> -
>  config PCI_DOMAINS
>         def_bool PCI
>
>  config PCI_DOMAINS_GENERIC
>         def_bool PCI
>
> -source "drivers/pci/Kconfig"
> -
> -endmenu
> -
>  menu "Power management options"
>
>  source kernel/power/Kconfig



> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1a0be022f91d..7cbc656f47e7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -113,6 +113,7 @@ config X86
>         select GENERIC_STRNLEN_USER
>         select GENERIC_TIME_VSYSCALL
>         select HARDLOCKUP_CHECK_TIMESTAMP       if X86_64
> +       select HAS_PCI
>         select HAVE_ACPI_APEI                   if ACPI
>         select HAVE_ACPI_APEI_NMI               if ACPI
>         select HAVE_ALIGNED_STRUCT_PAGE         if SLUB
> @@ -2567,15 +2568,6 @@ endmenu
>
>  menu "Bus options (PCI etc.)"
>
> -config PCI
> -       bool "PCI support"
> -       default y


The default is y for x86 (and xtensa as well).

With this patch, the default will be flipped.

I think most of people want to use PCI for x86,
and this change will make people upset.

Will you update arch/{x86,xtensa}/configs/*_defconfig?






> -       ---help---
> -         Find out whether you have a PCI motherboard. PCI is the name of a
> -         bus system, i.e. the way the CPU talks to the other stuff inside
> -         your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
> -         VESA. If you have PCI, say Y, otherwise N.
> -
>  choice
>         prompt "PCI access mode"
>         depends on X86_32 && PCI
> @@ -2658,8 +2650,6 @@ config PCI_CNB20LE_QUIRK
>
>           You should say N unless you know you need this.
>
> -source "drivers/pci/Kconfig"
> -
>  config ISA_BUS
>         bool "ISA bus support on modern systems" if EXPERT
>         help
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index b9ad83a0ee5d..22abeb236863 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -20,6 +20,7 @@ config XTENSA
>         select GENERIC_PCI_IOMAP
>         select GENERIC_SCHED_CLOCK
>         select GENERIC_STRNCPY_FROM_USER if KASAN
> +       select HAS_PCI
>         select HAVE_ARCH_KASAN if MMU
>         select HAVE_DEBUG_KMEMLEAK
>         select HAVE_DMA_CONTIGUOUS
> @@ -384,21 +385,6 @@ config XTENSA_CALIBRATE_CCOUNT
>  config SERIAL_CONSOLE
>         def_bool n
>
> -menu "Bus options"
> -
> -config PCI
> -       bool "PCI support"
> -       default y
> -       help
> -         Find out whether you have a PCI motherboard. PCI is the name of a
> -         bus system, i.e. the way the CPU talks to the other stuff inside
> -         your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
> -         VESA. If you have PCI, say Y, otherwise N.
> -
> -source "drivers/pci/Kconfig"
> -
> -endmenu
> -
>  menu "Platform options"
>
>  choice
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index ab4d43923c4d..059573823387 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -1,7 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0
>  menu "Device Drivers"
>
> +# Keep I/O buses first
> +
>  source "drivers/amba/Kconfig"
> +source "drivers/pci/Kconfig"
> +
>
>  source "drivers/base/Kconfig"
>
> diff --git a/drivers/parisc/Kconfig b/drivers/parisc/Kconfig
> index 5a48b5606110..5bbfea1a019c 100644
> --- a/drivers/parisc/Kconfig
> +++ b/drivers/parisc/Kconfig
> @@ -63,17 +63,6 @@ config ISA
>           If you want to plug an ISA card into your EISA bus, say Y here.
>           Most people should say N.
>
> -config PCI
> -       bool "PCI support"
> -       help
> -         All recent HP machines have PCI slots, and you should say Y here
> -         if you have a recent machine.  If you are convinced you do not have
> -         PCI slots in your machine (eg a 712), then you may say "N" here.
> -         Beware that some GSC cards have a Dino onboard and PCI inside them,
> -         so it may be safest to say "Y" anyway.
> -
> -source "drivers/pci/Kconfig"
> -
>  config GSC_DINO
>         bool "GSCtoPCI/Dino PCI support"
>         depends on PCI && GSC
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 56ff8f6d31fc..229a518b68cd 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -3,6 +3,18 @@
>  # PCI configuration
>  #
>
> +config HAS_PCI
> +       bool
> +
> +menuconfig PCI
> +       bool "PCI support"
> +       depends on HAS_PCI
> +
> +       help
> +         This option enables support for the PCI local bus, including
> +         support for PCI-X and the fundations for PCI Express support.
> +         Say 'Y' here unless you know what you are doing.
> +
>  source "drivers/pci/pcie/Kconfig"
>
>  config PCI_MSI
> --
> 2.19.1
>


--
Best Regards
Masahiro Yamada
