Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F22ECDE30
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 08:33:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A9221523
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 08:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A9221523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Zlmr07XJzF3Lp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 19:33:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.67; helo=mail-vs1-f67.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com
 [209.85.217.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Zlkc285pzF3LS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 19:31:03 +1100 (AEDT)
Received: by mail-vs1-f67.google.com with SMTP id m5so20227505vsk.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 01:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nbgd8scfCvhY6jmG199ZNUqhpVDts12fW1AAxoxPxmI=;
 b=TeGn0+gSPJtw2y/kRc8rYYjV6n05Yn8wuomOpT1vVlYNR0j8eqU/FhpCzK9LnNYHcA
 A8qhNvvubV+isWTwA5GsFR82a8G8Xj9jMIAevg8h1KHhocVjtGMu7mxtb7zyPfeoeUcG
 yJ5JckJuw4sAtlW2fOaI4pDFrW3qN2ZLm3UxYr2+C8LKydaBc4INSJuI98OJD7DR/THo
 B+CEQXKs+Txfay3Y0+kxga7Hw/6WyVYuHKTZZBFK0K88CwA8AfCwtPGx6Ow3JFVZvGIO
 zpLxCNUyYsdHDbtqgYd1CsApq2aKrhy4SPH55t/7bO++AJ0BVDs0jrdolIUwXp6V7VoG
 E9qw==
X-Gm-Message-State: ABuFfojAPM5EIh03KJ/QnnfDOhC5q2L5ylda7BoBDA5uyh3novMrWZKp
 preD4ab1M+IjQkbxz59Hinc+nAbjFJaWtNttv6I=
X-Google-Smtp-Source: ACcGV6273LL+JTUOtmfdqAmVO+8UCsjrLVNOvZEMtmS9Vt2WV6JXoIZjMmugHwndwVBvraDokh3c/RzyRUPLyAWwMIc=
X-Received: by 2002:a67:843:: with SMTP id 64mr10052717vsi.166.1539765061626; 
 Wed, 17 Oct 2018 01:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de>
In-Reply-To: <20181017080201.10866-1-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Oct 2018 10:30:49 +0200
Message-ID: <CAMuHMdWMtxxu8iivcnT=uWTMHsp=iSq_QzXqDWQut5OHwTU8Sg@mail.gmail.com>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v2
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Alex Bounine <alex.bou9@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christoph,

On Wed, Oct 17, 2018 at 10:03 AM Christoph Hellwig <hch@lst.de> wrote:
> currently every architecture that wants to provide on of the common
> periphal busses needs to add some boilerplate code and include the
> right Kconfig files.   This series instead just selects the presence
> (when needed) and then handles everything in the bus-specific
> Kconfig file under drivers/.
>
> Changes since v1:
>  - rename all HAS_* Kconfig symbols to HAVE_*
>  - drop the CONFIG_PCI_QSPAN option entirely
>  - drop duplicate select from powerpc
>  - restore missing selection of PCI_MSI for riscv
>  - update x86 and riscv defconfigs to include PCI
>  - actually inclue drivers/eisa/Kconfig
>  - adjust some captilizations

Thanks for the update!

Please use "git format-patch -v<N> --cover" to prepare patch series
for sending with git-send-email.

  "-v<N>" to prefix all patches with version number <N>,
  "--cover" to have a "[PATCH 0/<M>]" prefix in the cover letter.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
