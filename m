Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76A2ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:56:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455732145D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qJfHf/u8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455732145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bttJ1m0QzF3Td
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 15:56:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="qJfHf/u8";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.91; helo=conssluserg-06.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="qJfHf/u8"; 
 dkim-atps=neutral
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42btqY4VchzDrMl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 15:54:16 +1100 (AEDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id w9J4s1Wk013942
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 13:54:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w9J4s1Wk013942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1539924842;
 bh=RNkLfLEq3b1sRQCAYs++9f55uIJFFKxyLPJfhC9T2Aw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qJfHf/u8FhXixU0ilqZedST8iJ1W1PIdeDL1fVUyIwzDJsg4Z5ST4R6yourONQzzN
 awVlWuWyA278Uu5nTn8Ft4nwOwS5MdGjDp3dYgnGmp7YAkcYiD+dhsuMwwJxB3Xtis
 klcQaBxGpMdretBm2+Ivzwcgly3vVlwpWrBmpGcLPLs75LevBw4ZrcwH2qZbJJEwvI
 JmlcX1XJ188AhD7vFeGA8R85efoQFRibx0ZLypIFSmiY8P7zJUSpOzNlhZRBw+o6d8
 Eno6aI1nR8+fx1jf9FkS9D1qyvUKgleiEw3S2k6tdqzNBOB9Fgy9a1MvWLQ1fLS64l
 tA47w20SAbyLw==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id w85so24540655vsa.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 21:54:01 -0700 (PDT)
X-Gm-Message-State: ABuFfojMpJBI8N9zsj4Nc92egXNe9zSl6pD0RUzmPiICI2Jx5HboR6aB
 FDjJP1n9FzrbbP3vCr9hh3Kpu3+fi44jbNXQDnc=
X-Google-Smtp-Source: ACcGV614NCU3U5tl4IH6UVmjLSYbhNBDCyShM6XvSrcxkB5ZyAbXiToqAFqwdzImaDPGXuq6OVnOPtfyUM9GhgoLfe8=
X-Received: by 2002:a67:65c3:: with SMTP id z186mr14242000vsb.54.1539924840809; 
 Thu, 18 Oct 2018 21:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de>
 <20181017080201.10866-7-hch@lst.de>
In-Reply-To: <20181017080201.10866-7-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 19 Oct 2018 13:53:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNASnVLk50oYjGSE0ir3SDja3acPq1=oLjzZCLoSNiUNVdQ@mail.gmail.com>
Message-ID: <CAK7LNASnVLk50oYjGSE0ir3SDja3acPq1=oLjzZCLoSNiUNVdQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] rapidio: consolidate RAPIDIO config entry in
 drivers/rapidio
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

On Wed, Oct 17, 2018 at 5:03 PM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no good reason to duplicate the RAPIDIO menu in various
> architectures.  Instead provide a selectable HAS_RAPIDIO symbol

Nit.

HAS_RAPIDIO -> HAVE_RAPIDIO.



> that indicates native availability of RAPIDIO support and the handle
> the rest in drivers/pci.

Copy-paste mistake?

drivers/pci -> drivers/rapidio



>  This also means we now provide support
> for PCI(e) to Rapidio bridges for every architecture instead of a
> limited subset.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>




-- 
Best Regards
Masahiro Yamada
