Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBD9C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 06:49:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970082086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 06:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GyLZ+46i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970082086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YTYr3TqyzF3F1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 17:49:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="GyLZ+46i";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.83; helo=conssluserg-04.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="GyLZ+46i"; 
 dkim-atps=neutral
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YTLV3ThJzF3DZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 17:39:14 +1100 (AEDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id w9F6ctJU009676
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:38:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w9F6ctJU009676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1539585536;
 bh=FYdlgiyhR1emINlVOJJ7iG9fxuZSD3FtlSJJ8ALoZNU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=GyLZ+46iwH58pJJ9dZBfBo8O5ZR3Qcof4bp1jimBMk1j24qPE5O5PllVNUuoJNlSo
 kVNBk/bXs+Y6UrPJtC8i8Nb3TZY+jqdo+JJqJyAjeOOaHfy+DVDTTJHwcPwkmfXqyU
 07L887dEMPMhDzfjC9hRW5TmI9sEIsobXU/EkltwyG0CDdThQuBPaqaGHF6wQ9F14X
 UJKHNqeiu2bDZTdzUnbslyduAqHG6Jx8SFWDihmr31vps6IUBArmWoVp0ZTbjPPFZD
 BV0jUIeixJQh/hAEaw35ZVEJUTqsiksYhGfdFOE11fGdD+N2VceeuNhrfVQjZ+wDIr
 iCyYGEuFwM8OA==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id g201so15591230vsd.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 23:38:55 -0700 (PDT)
X-Gm-Message-State: ABuFfojOfa0PsWVCHNdNk8iFeVD8IFv6wvxaK1E4nPK2xD/fOQtu2JW+
 tFWfCCueEzuBO+Vt4NoLnfs6ejG119QZISL0In8=
X-Google-Smtp-Source: ACcGV61s6G43qzxF+3g7ymfJAzcYzoexaIe7pUXSgcq/yzNXU3xzYFOQWFpatejDM62wd4WC7af4ZLpHLdSEPMIxqqM=
X-Received: by 2002:a67:61c1:: with SMTP id v184mr6208631vsb.179.1539585535007; 
 Sun, 14 Oct 2018 23:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151016.31674-1-hch@lst.de>
In-Reply-To: <20181013151016.31674-1-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 15 Oct 2018 15:38:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ3SNStaA6-tOWhm0QHWpNczO07x9T2F7gMcusduMS7GA@mail.gmail.com>
Message-ID: <CAK7LNAQ3SNStaA6-tOWhm0QHWpNczO07x9T2F7gMcusduMS7GA@mail.gmail.com>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/
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

On Sun, Oct 14, 2018 at 12:10 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> currently every architecture that wants to provide on of the common
> periphal busses needs to add some boilerplate code and include the
> right Kconfig files.   This series instead just selects the presence
> (when needed) and then handles everything in the bus-specific
> Kconfig file under drivers/.
>

Thanks for great work again.

However, I suspect some breakages
(not testing yet, just quick review by my eyes.)

I left some comments in individual patches.



--
Best Regards
Masahiro Yamada
