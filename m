Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BB6C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 15:35:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF4620664
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 15:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2Iac1IMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF4620664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lXTN6ms2zF3NF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 02:35:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="2Iac1IMO";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.83; helo=conssluserg-04.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="2Iac1IMO"; 
 dkim-atps=neutral
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lXQf5TDYzDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 02:32:42 +1100 (AEDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id w9VFW4ig004870
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Nov 2018 00:32:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w9VFW4ig004870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1540999925;
 bh=07s5qVlFf5CFxCuPhatWQ5nOszbFSlj1AR7fmT3wgxE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=2Iac1IMOJ03M5i6zNXU51op5Kt83bUT9SD6UoRGpoNKu8wCfLiOQMS/uXk8Dfkyfl
 dqVaiXQ7nPpPWRniokNaPJxhHkBzwi/8kod9R8SBOY8rUL9Ka6QGZeME79487MHUbo
 KsGh5/KOqLWNQflUR7Ul56C4hWaq6H6DpTRUntqOpZPbs2EJ6Z3FYxzuqaEfFPuXxx
 RQ8GGN7ufSa5AYGZ1/J/oLzpkaP4fhp4zwEJep9R68tFs4hNKVwmJs2QgDqvp/54iN
 N5zpAz+G+ZRe5Xqs7eu6ThTwHlzvw3jYbZxL09Dqv1jqZ1JtFWlQlgf3fwK6NXQt7u
 ap9QGkPMJ+Prw==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id p74so3276577vsc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 08:32:04 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKpBOBSxV9mvCQy7FbWoY/RqbOD3llnU/+X9eI1FHaoZ6I4AFp6
 /vjB1GTJRaB7XhrAGiKXCpNdgm6Upom7rdMc9V4=
X-Google-Smtp-Source: AJdET5e1R3V1R5oNYg8AjXwbFZyc/SSr/BQ1Hht1wcuXq9OQOcH0pfyo0NYyfNeiEWgTbAkK7g5sbnsjNk2SmNe/qdw=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr1509356vsb.155.1540999923821; 
 Wed, 31 Oct 2018 08:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-5-hch@lst.de>
In-Reply-To: <20181019120952.32763-5-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Nov 2018 00:31:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQb3PkB_z6-3D=qotWExHGAedA5i-_ZNr83=mC6q1JtwQ@mail.gmail.com>
Message-ID: <CAK7LNAQb3PkB_z6-3D=qotWExHGAedA5i-_ZNr83=mC6q1JtwQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] powerpc: remove CONFIG_MCA leftovers
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
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Alex Bounine <alex.bou9@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 19, 2018 at 9:12 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Applied to linux-kbuild.



>  arch/powerpc/Kconfig | 4 ----
>  drivers/scsi/Kconfig | 6 +++---
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index e8c8970248bc..d4e97469a5f0 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -941,10 +941,6 @@ config FSL_GTM
>         help
>           Freescale General-purpose Timers support
>
> -# Yes MCA RS/6000s exist but Linux-PPC does not currently support any
> -config MCA
> -       bool
> -
>  # Platforms that what PCI turned unconditionally just do select PCI
>  # in their config node.  Platforms that want to choose at config
>  # time should select PPC_PCI_CHOICE
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 7c097006c54d..d3734c54aec9 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -535,7 +535,7 @@ config SCSI_HPTIOP
>
>  config SCSI_BUSLOGIC
>         tristate "BusLogic SCSI support"
> -       depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API && VIRT_TO_BUS
> +       depends on (PCI || ISA) && SCSI && ISA_DMA_API && VIRT_TO_BUS
>         ---help---
>           This is support for BusLogic MultiMaster and FlashPoint SCSI Host
>           Adapters. Consult the SCSI-HOWTO, available from
> @@ -1142,12 +1142,12 @@ config SCSI_LPFC_DEBUG_FS
>
>  config SCSI_SIM710
>         tristate "Simple 53c710 SCSI support (Compaq, NCR machines)"
> -       depends on (EISA || MCA) && SCSI
> +       depends on EISA && SCSI
>         select SCSI_SPI_ATTRS
>         ---help---
>           This driver is for NCR53c710 based SCSI host adapters.
>
> -         It currently supports Compaq EISA cards and NCR MCA cards
> +         It currently supports Compaq EISA cards.
>
>  config SCSI_DC395x
>         tristate "Tekram DC395(U/UW/F) and DC315(U) SCSI support"
> --
> 2.19.1
>


-- 
Best Regards
Masahiro Yamada
