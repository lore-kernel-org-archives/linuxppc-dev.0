Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0270AECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 15:26:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5783720664
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 15:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bK+U340s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5783720664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lXHB6WkKzF3HL
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 02:26:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="bK+U340s";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.82; helo=conssluserg-03.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="bK+U340s"; 
 dkim-atps=neutral
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lXD33YbLzF318
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 02:23:30 +1100 (AEDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id w9VFMwwP027165
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Nov 2018 00:22:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9VFMwwP027165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1540999379;
 bh=/V70+fgEgC0ZBcK91HaOzpn4PVyRyLyCy+HFjvOlauw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bK+U340sU5gL7okxCsvL2b10TzAiWCeWEl7PaRQFJtRNvL/G9jEHYm1uoiKOmwCyb
 8fmsO5aLrFtzUKGauUJA8FMgDg2mURW7Zf8lPeG90Rh9RR3r0xTnnT3vb8xO59HDJZ
 fEG0SBTuqicDgTFl6Q4zlT11XM4VnsbFBikHPrC5klUsvIw/kzgUtv+poeMgtFsrZ1
 sYAke4Cgbd7KpHcPE+mEFNfuS57NmYbUFdWwBvkw/VsHufyecDK5JKYe4ih7tuMLmn
 /qyaAOpQCq3swbFaLw6SzPOxSk60ZLHYrFXHJFgFZE1hwVDkiMS36XXUfYTMq7L5uD
 eUI9w8kLz6u9g==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id h78so9181410vsi.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 08:22:59 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLnPxK61z2HewYF8fuMwatc70PMz9qzzdsM0ydmySTA4eumI14x
 /tEwhWyVqkcX+mxZ4XBfSdbsqa5ydxLu4I6dkLA=
X-Google-Smtp-Source: AJdET5eFhdyn2AImd7r47wGujbB+RkCQGuMqa5gJWjHWbG2z9QV8GNr3Au5tC9Z5ei7yzkLvc9f8ZR/Z36IOarwEmXY=
X-Received: by 2002:a67:385a:: with SMTP id f87mr1472529vsa.179.1540999377977; 
 Wed, 31 Oct 2018 08:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-2-hch@lst.de>
In-Reply-To: <20181019120952.32763-2-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Nov 2018 00:22:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASCtHqB8DiA8NSNYY4823NwcOMV-3sS4RLFc8pfgEQD4w@mail.gmail.com>
Message-ID: <CAK7LNASCtHqB8DiA8NSNYY4823NwcOMV-3sS4RLFc8pfgEQD4w@mail.gmail.com>
Subject: Re: [PATCH 1/9] aha152x: rename the PCMCIA define
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Oct 19, 2018 at 9:10 PM Christoph Hellwig <hch@lst.de> wrote:
>
> We plan to enable building the PCMCIA core and drivers, and the
> non-prefixed PCMCIA name clashes with some arch headers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> ---


Applied to linux-kbuild.




>  drivers/scsi/aha152x.c             | 14 +++++++-------
>  drivers/scsi/pcmcia/aha152x_core.c |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
> index 4d7b0e0adbf7..301b3cad15f8 100644
> --- a/drivers/scsi/aha152x.c
> +++ b/drivers/scsi/aha152x.c
> @@ -269,7 +269,7 @@ static LIST_HEAD(aha152x_host_list);
>  /* DEFINES */
>
>  /* For PCMCIA cards, always use AUTOCONF */
> -#if defined(PCMCIA) || defined(MODULE)
> +#if defined(AHA152X_PCMCIA) || defined(MODULE)
>  #if !defined(AUTOCONF)
>  #define AUTOCONF
>  #endif
> @@ -297,7 +297,7 @@ CMD_INC_RESID(struct scsi_cmnd *cmd, int inc)
>
>  #define DELAY_DEFAULT 1000
>
> -#if defined(PCMCIA)
> +#if defined(AHA152X_PCMCIA)
>  #define IRQ_MIN 0
>  #define IRQ_MAX 16
>  #else
> @@ -328,7 +328,7 @@ MODULE_AUTHOR("J=C3=BCrgen Fischer");
>  MODULE_DESCRIPTION(AHA152X_REVID);
>  MODULE_LICENSE("GPL");
>
> -#if !defined(PCMCIA)
> +#if !defined(AHA152X_PCMCIA)
>  #if defined(MODULE)
>  static int io[] =3D {0, 0};
>  module_param_hw_array(io, int, ioport, NULL, 0);
> @@ -391,7 +391,7 @@ static struct isapnp_device_id id_table[] =3D {
>  MODULE_DEVICE_TABLE(isapnp, id_table);
>  #endif /* ISAPNP */
>
> -#endif /* !PCMCIA */
> +#endif /* !AHA152X_PCMCIA */
>
>  static struct scsi_host_template aha152x_driver_template;
>
> @@ -863,7 +863,7 @@ void aha152x_release(struct Scsi_Host *shpnt)
>         if (shpnt->irq)
>                 free_irq(shpnt->irq, shpnt);
>
> -#if !defined(PCMCIA)
> +#if !defined(AHA152X_PCMCIA)
>         if (shpnt->io_port)
>                 release_region(shpnt->io_port, IO_RANGE);
>  #endif
> @@ -2924,7 +2924,7 @@ static struct scsi_host_template aha152x_driver_tem=
plate =3D {
>         .slave_alloc                    =3D aha152x_adjust_queue,
>  };
>
> -#if !defined(PCMCIA)
> +#if !defined(AHA152X_PCMCIA)
>  static int setup_count;
>  static struct aha152x_setup setup[2];
>
> @@ -3392,4 +3392,4 @@ static int __init aha152x_setup(char *str)
>  __setup("aha152x=3D", aha152x_setup);
>  #endif
>
> -#endif /* !PCMCIA */
> +#endif /* !AHA152X_PCMCIA */
> diff --git a/drivers/scsi/pcmcia/aha152x_core.c b/drivers/scsi/pcmcia/aha=
152x_core.c
> index dba3716511c5..24b89228b241 100644
> --- a/drivers/scsi/pcmcia/aha152x_core.c
> +++ b/drivers/scsi/pcmcia/aha152x_core.c
> @@ -1,3 +1,3 @@
> -#define PCMCIA 1
> +#define AHA152X_PCMCIA 1
>  #define AHA152X_STAT 1
>  #include "aha152x.c"
> --
> 2.19.1
>


--=20
Best Regards
Masahiro Yamada
