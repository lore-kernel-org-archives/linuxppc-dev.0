Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6245C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:20:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49FA52064E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YgX3hHlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FA52064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YXwd1kyHzF3Fd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:20:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="YgX3hHlu";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.81; helo=conssluserg-02.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="YgX3hHlu"; 
 dkim-atps=neutral
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YXsx5skVzF39m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:18:13 +1100 (AEDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id w9F9HnVq017375
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 18:17:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w9F9HnVq017375
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1539595070;
 bh=uoMJsd1TMhHqhCJuIipgIP5V4I4WH9bU9cBtVDfn1UI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YgX3hHluNuwc6jTTHdl3sEasM7tU7RVHr2WudA8kFor3oiwdccdtsXgzrhvRjurIm
 qUXu9g71bEfoJhuz6NPJBxm7EBSpuR28bYwoxZtx4lmPc3+k6q9oq5hBYGwGsR05Oe
 KaToXmsGF+hpX0a7/eS7zgt88aMAUp37LBPKWAXbSaBaEtHE95Gl1Pyforb3aog+rN
 bjyxK9WOgCE5zaA/X3EE3hbu5KNORCXDRdGxuhEH7HoI++SV2z0PM7JqcYVswb0RDa
 dLHHRZvBv8KAxIPkOT0ce7+cyRpwSTS3leEVpZ8qsxlLbtI7XhV75LMU2a92+NGdva
 ZpVJbahpbhtUw==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id w194so15819749vsc.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 02:17:50 -0700 (PDT)
X-Gm-Message-State: ABuFfog/rUfKr0arU0T5DNsv7FibQFdZP1l2etNghCLB8OHcx8wIELo3
 fxXYD2YcvK8nsJ9bvmerAb+1LNOUFy97xmVq08A=
X-Google-Smtp-Source: ACcGV62sbBk1X3cOASnSTccR6Hp7nPkhT2EGMVkrmWla4johvZoop9rlDs1h4E7d2rMwg39fAEqefKOk/faVZO0ESks=
X-Received: by 2002:a67:5fc7:: with SMTP id t190mr6437461vsb.155.1539595069491; 
 Mon, 15 Oct 2018 02:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151016.31674-1-hch@lst.de>
 <20181013151016.31674-5-hch@lst.de>
 <CAK7LNAQy_NTu5=8R6C3Xc2VLrJo7tKOz-u1=3JfGtBa3Z+ZD9g@mail.gmail.com>
 <20181015085737.GC27159@lst.de>
In-Reply-To: <20181015085737.GC27159@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 15 Oct 2018 18:17:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbkmZ-Lq7W1R6r21dw0RTTyfGYNr5MLuufOVB2rqy2uQ@mail.gmail.com>
Message-ID: <CAK7LNARbkmZ-Lq7W1R6r21dw0RTTyfGYNr5MLuufOVB2rqy2uQ@mail.gmail.com>
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
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Alex Bounine <alex.bou9@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 15, 2018 at 5:57 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Oct 15, 2018 at 03:37:05PM +0900, Masahiro Yamada wrote:
> > I think HAVE_ is a preferred prefix in this case according to this doc:
> > https://github.com/masahir0y/linux/blob/v4.19-rc4/Documentation/kbuild/kconfig-language.txt#L448
>
> Ok, I'll switch everything to HAVE_*
>
> > If you do this for entire powerpc,
> > the other 'select HAS_PCI' addtions to
> > arch/powerpc/platforms/*/Kconfig look redundant.
>
> I'll drop them.
>
> > > -config PCI
> > > -       bool "PCI support"
> > > -       select PCI_MSI
> >
> >
> > I think this 'select PCI_MSI' for riscv was lost.
>
> Indeed, fixed.
>
> > >  menu "Bus options (PCI etc.)"
> > >
> > > -config PCI
> > > -       bool "PCI support"
> > > -       default y
> >
> >
> > The default is y for x86 (and xtensa as well).
> >
> > With this patch, the default will be flipped.
> >
> > I think most of people want to use PCI for x86,
> > and this change will make people upset.
> >
> > Will you update arch/{x86,xtensa}/configs/*_defconfig?
>
> Yes.  Alternatively we could add a new ARCH_PCI_DEFAULT symbol,
> that architectures could select if they want PCI by default.  Does
> anyone thing this is a good idea?


No, I do not want to see such an ugly config option.

Instead, you can use 'imply' keyword to set the default y.

config X86
       ...
       imply    PCI



But, personally, I'd like the defconfig files updated.



-- 
Best Regards
Masahiro Yamada
