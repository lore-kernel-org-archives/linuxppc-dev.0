Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFF9ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:51:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694022083E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694022083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42byly42jzzF3Ld
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 18:51:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.67; helo=mail-ua1-f67.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com
 [209.85.222.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42by6R3LGzzF39T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 18:22:23 +1100 (AEDT)
Received: by mail-ua1-f67.google.com with SMTP id i30so5608038uae.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 00:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j9M+23qGHXE/U2KlyBiQJk5FJr+RRde46uCiNZoKMKs=;
 b=O/jyYgSgHeiajtg+DLVMeIJOQD5ql0zHmrmju5cN3WskZpVymxudb52wpGFXINsSur
 BSMsqcq1kAyQAOCfJC0cGXH27pIycUHhyAeaDo8/RlGxHNV/1BTKqtIx3UxFlwG71Fwp
 2ZVclqxYwHbiqvX/1izSKlXDEVAqWEtr3vGIYtb9pzvsMSf3iXaON/dGYbtVdBwuNenE
 cim0cBEnYCffM+RtoCDfbOinBohgXa+ZDQ4EOKMTMLlb64ooBASXnEAGRawtHTCVIDD9
 nS+DG7ZQJPT/YLpmhENEeWqyNSpgdCE6ovvhyU8TfckoMe/iuCypDFDqeIOXkGTjzy0R
 YHTA==
X-Gm-Message-State: ABuFfojKE5JLsWBBX0zlpXbYsrjoC+zqeep0CdxFykLitKJc1qdFekQM
 ig7//zfA9q9IaDFvn+eDRP5e8apS8czU4dWzQ90=
X-Google-Smtp-Source: ACcGV629ggddtMEIiseKreDw2VqZ5fppJthrh/nXaz8t/qT25KuCsWCBbhQ+XNIjv0DaAIRtFmGlGIHhmY1yWYLd0EE=
X-Received: by 2002:a9f:308a:: with SMTP id j10mr4392208uab.28.1539933740665; 
 Fri, 19 Oct 2018 00:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de>
 <CAMuHMdWMtxxu8iivcnT=uWTMHsp=iSq_QzXqDWQut5OHwTU8Sg@mail.gmail.com>
 <20181019070001.GA30556@lst.de>
 <CAMuHMdXLug_T4onn23JormmYZXDWVnEFYaoMzA90bpGFvk6Eow@mail.gmail.com>
 <20181019071057.GA31656@lst.de>
In-Reply-To: <20181019071057.GA31656@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Oct 2018 09:22:08 +0200
Message-ID: <CAMuHMdXqPNOwcjWVmH08YSfZopc0pWLUj-r0s6g=q0oUdqWhWw@mail.gmail.com>
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

On Fri, Oct 19, 2018 at 9:10 AM Christoph Hellwig <hch@lst.de> wrote:
> On Fri, Oct 19, 2018 at 09:07:51AM +0200, Geert Uytterhoeven wrote:
> > Without this:
> >   - It's hard to visually match your untagged cover letter with the
> > actual patches,
> >   - Your individual patches lack the version info, so people cannot see which
> >     version review comments in an email reply apply to.
>
> All of that is trivially solved by mail threading.

You forgot to answer this question:

| Can you please clarify what exactly that would mess up?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
