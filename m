Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B927FC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 00:08:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57AF20870
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 00:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="iEVGpdf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57AF20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Vrst6W3TzF1cK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 11:08:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="iEVGpdf4";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::844; helo=mail-qt1-x844.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="iEVGpdf4"; 
 dkim-atps=neutral
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VrqM25KgzDrMC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 11:06:39 +1100 (AEDT)
Received: by mail-qt1-x844.google.com with SMTP id e10-v6so7878250qtq.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 17:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hIhFswnue5bMYBmy87XaDRgWO/cecpUCl6Uzd8VJ4y4=;
 b=iEVGpdf4bWRygL6pBpvNY1MUy/kkXdIf+RfyQAD7O0U+3jlu26+4frv/jy7YBlUKhs
 PE3ntnDZWlI+T4N3V/0DBvfGNQ03VcZaPEOXifQfMuxA+dyVvsztBnVqyoMkEIcO8O/E
 5qscPywvCi0aOedAJYQfpxm4wnB+rLTpXExwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hIhFswnue5bMYBmy87XaDRgWO/cecpUCl6Uzd8VJ4y4=;
 b=S/IWdN1p0IQuXNFdtHezSgJ/UHO54IJYGnBCM4oKGaaigrrnwSIPu8Lsgy8cGMVgoF
 Zqp10tWkVETsZODYmHD+KTuStVhv6W1Vau/6LUeAdRNEa0B3jvT0zNyURZRrPBmZvZHl
 fzkOy7yz2momD+/bVfxnFtIX8hirtoAfPTgt8xZ4tuT3186bD8xnKjbAvn/ZUtYiLIB6
 05XucG2wBzVyXpiiBXoDOp7Zis+Wn6AfTePXuiFTpVRPFbK343FjJW8p6IZxavqqCgqs
 0puNd8a8Rpgx2r7QtuhCbmOC2v4z2I0XOX5/oKWqL7Bj1SLAQGJjogH1PAq5vtQPud0e
 XIeA==
X-Gm-Message-State: ABuFfoiPW1JvzouwsvluZbfsUxDhK6CL4+l+gDW7r6LtQioKK/k+tVA0
 AFV+3kr9g/QyTwowUnxqSjNMo5bovmiBfZkNqAM=
X-Google-Smtp-Source: ACcGV61rmuZ0CZ1fPci6uU64nN/Yc7T/U0qxLX/+YDiAx4RwiHegQAqV3SGnoVocZbV6Q7Sjnj3fm7hTmcQjP2nZpwo=
X-Received: by 2002:ac8:d84:: with SMTP id
 s4-v6mr29311266qti.284.1539216396760; 
 Wed, 10 Oct 2018 17:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181009232803.15072-1-joel@jms.id.au>
 <20181009232803.15072-2-joel@jms.id.au>
 <87in2a2dgh.fsf@concordia.ellerman.id.au>
 <87a7nl2vv6.fsf@concordia.ellerman.id.au>
In-Reply-To: <87a7nl2vv6.fsf@concordia.ellerman.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 11 Oct 2018 10:36:24 +1030
Message-ID: <CACPK8XdxdzMnXLnjan+vH1a_Zcu27Soj6Z3o2BvDH6bfvS3QMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/boot: Expose Kconfig symbols to wrapper
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 11 Oct 2018 at 10:32, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Joel Stanley <joel@jms.id.au> writes:
> >> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> >> index 0fb96c26136f..eeed74e0dfca 100644
> >> --- a/arch/powerpc/boot/Makefile
> >> +++ b/arch/powerpc/boot/Makefile
> >> @@ -197,9 +197,14 @@ $(obj)/empty.c:
> >>  $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
> >>      $(Q)cp $< $@
> >>
> >> +$(obj)/serial.c: $(obj)/autoconf.h
> >> +
> >> +$(obj)/autoconf.h: $(obj)/%: $(srctree)/include/generated/%
> >> +    $(Q)cp $< $@
> >> +
> >
> > This gives me:
> >   make[2]: *** No rule to make target '../include/generated/autoconf.h', needed by 'arch/powerpc/boot/autoconf.h'.  Stop.
> >
> > The ../ is $(srctree).
>
> Seems autoconf.h is in objtree:
>
>   ~/linux$ make O=build prepare
>   ...
>   ~/linux$ find . -name autoconf.h
>   ./drivers/staging/rtl8723bs/include/autoconf.h
>   ./tools/testing/radix-tree/generated/autoconf.h
>   ./build/include/generated/autoconf.h

Ah. That's obvious now that you point it out. Obviously myself and
0day do in-tree builds.

> So I'll fix that up.

Thanks!
