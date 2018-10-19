Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BCAECDE44
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:47:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445272083E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445272083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bygR2jHqzF0gv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 18:47:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.68; helo=mail-vs1-f68.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com
 [209.85.217.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bxnx5GBBzF3ZF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 18:08:05 +1100 (AEDT)
Received: by mail-vs1-f68.google.com with SMTP id q15so10401753vso.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 00:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OLmNJ36LwWMMqsWlkLCeV/YPO9vavlldT3NFPf3a7Oo=;
 b=COYzGzXNvXggSUb6kHB2YSesJ2LSr61YsLN0rLpQxcOQf49UutC2kCQwywnyCilWK9
 1xTWxtZ9o6R4TOPSoDJ10SdGjkXEYiZ4stYn6yO5Pzn7iAnsNsVsYvbRPI77uZFR+9Mm
 F+jHBgjRcCrWNRai+qCExeGuvRopGW7wNvi6g1nb+srrfa/FYoecUV2Dvc0UlymStbap
 U5OZm0WyNyJ/uO5qmQHlAosJNIA0IedVRQSEJaAqshAHBKVl34BYyiMzDojXRe0Yq/z8
 Z2m2bp/fO0pWpvDjZymUThLEBty/vK++oq+Nsjx+iPOWkLrO+BwgpJbi98aZPyT+0v2a
 7S5A==
X-Gm-Message-State: ABuFfojkMVotYA31S+k79WFIPdSrnwMMbwyAm3/3sUPEgo1alO/wSl7M
 QpRmk6fQbsZDX903T00wzj1pNcbiJiXTf/PyiMc=
X-Google-Smtp-Source: ACcGV63MZWH9kgfSRarxsGHQippQr9x3U34azOeqL/0fDkSg3YuBDZAUiWZsHYJl0HSyGNXWbm4+scC8JisJDruGpnk=
X-Received: by 2002:a67:7b56:: with SMTP id w83mr14117399vsc.152.1539932883023; 
 Fri, 19 Oct 2018 00:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de>
 <CAMuHMdWMtxxu8iivcnT=uWTMHsp=iSq_QzXqDWQut5OHwTU8Sg@mail.gmail.com>
 <20181019070001.GA30556@lst.de>
In-Reply-To: <20181019070001.GA30556@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Oct 2018 09:07:51 +0200
Message-ID: <CAMuHMdXLug_T4onn23JormmYZXDWVnEFYaoMzA90bpGFvk6Eow@mail.gmail.com>
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

On Fri, Oct 19, 2018 at 9:00 AM Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Oct 17, 2018 at 10:30:49AM +0200, Geert Uytterhoeven wrote:
> > Please use "git format-patch -v<N> --cover" to prepare patch series
> > for sending with git-send-email.
> >
> >   "-v<N>" to prefix all patches with version number <N>,
> >   "--cover" to have a "[PATCH 0/<M>]" prefix in the cover letter.
>
> We had that discussion before and I strongly disagree with messing
> up the subject lines like that.  The git-send-email defaults are
> perfectly fine.

Can you please clarify what exactly that would mess up?
Documentation/process/submitting-patches.rst even mentions the tags
to put in "[PATCH <tag>]"?

Without this:
  - It's hard to visually match your untagged cover letter with the
actual patches,
  - Your individual patches lack the version info, so people cannot see which
    version review comments in an email reply apply to.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
