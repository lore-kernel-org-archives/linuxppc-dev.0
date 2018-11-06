Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FA2C0044C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 00:38:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E1E2083D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 00:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="RfA7r2/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E1E2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42prJW6PNpzF36p
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 11:38:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="RfA7r2/v";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="RfA7r2/v"; 
 dkim-atps=neutral
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42prFy5wFMzF35j
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 11:36:38 +1100 (AEDT)
Received: by mail-qt1-x842.google.com with SMTP id l9-v6so819784qtj.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 16:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=akTpZTBPAXL85p0vdHNPPTO7rOzjQoR6U5LUQJKn1MI=;
 b=RfA7r2/vEO7htlzv4TX/TPKT5VOahhWxZ/24AbrY2wZXuFNy0Z92iSX06CM4QvNSok
 hikpivth+IZu+ouQ+//kIflNHn+eSMSwj/iEc2PuSZfDRA9qDyKQXgwkD6yY3pxM5WI3
 GVr/7TqsRtcM2M1SzVF9OYKSPgFEBYNmdmYDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=akTpZTBPAXL85p0vdHNPPTO7rOzjQoR6U5LUQJKn1MI=;
 b=JFZ9K5WoKUq8tWvli0mOmFHLoziNjYXSUyyIv97eusEfw1kYOcCKnDQwBksJ7skhzJ
 jPQfgH6HnS/Bx8lWT3QGwlhIUPsyiGLCey+vPMKVYoYjsFKgV2PbVXCOASuExnA/K+zX
 FK6rBXL3DzHRq9dGF6bEzZw9+dJxAJMmsM0rJ+Iv2CI8ITglCtz+LnBghss/LXjEwZL1
 99I8lLCQwQ3Duq3lx9TiPaMQUdRyCKB2gujdIm8JJ17FU5Lh5jFvO0TSgEJsLQrnNCM+
 OcusKszV5cORgWeBO/+IvdJYDP0ubMBpOP4O0Kgp87LCAjCWOwn0/TSAYxXfWoqVJir4
 kgbQ==
X-Gm-Message-State: AGRZ1gIIEhWjPJrPqN9cuWTeoiwbS5zPXRW8Dre0UYXjwVRT3MVYPIOK
 KpHLwxehiMiNz2Tlr9zlJWRXyf2iEDtKACrAS3Y=
X-Google-Smtp-Source: AJdET5ce2zdHFhoWH1IuOJrVG9+R+YvIHaDiKffeGGN486EVZ6jUj3Go2Avkv1E/k77CkwjvKpJyRbE31fzXkxVcSBA=
X-Received: by 2002:ac8:2992:: with SMTP id
 18-v6mr23222098qts.266.1541464596135; 
 Mon, 05 Nov 2018 16:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20181104231133.30848-1-joel@jms.id.au>
 <CAKwvOdm8WZTeB_wxkO2nN7PW=v=2z7tdVapTq-TiB18nZZfS=A@mail.gmail.com>
In-Reply-To: <CAKwvOdm8WZTeB_wxkO2nN7PW=v=2z7tdVapTq-TiB18nZZfS=A@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 6 Nov 2018 11:06:24 +1030
Message-ID: <CACPK8XeoBufr6ScXcdESsZEg9LQBHyx5V1T2WKbTbSDCaqFYfA@mail.gmail.com>
Subject: Re: [PATCH 0/2] poewrpc/Boot: Fix cross compiling with clang
To: Nick Desaulniers <ndesaulniers@google.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-kbuild@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 6 Nov 2018 at 09:07, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Sun, Nov 4, 2018 at 3:11 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > Hello,
> >
> > These patches allow clang to cross-compile the powerpc boot wrapper.
> > The boot wrapper constructs it's own compiler flags as it may not be
> > built for the same arch as the kernel.
>
> Hi Joel, thanks for the series!  I'm just curious, how does the boot
> wrapper run on a different arch than the kernel?

The kernel can have a ppc32 boot wrapper for a ppc64 kernel. There's
some rationale in the boot wrapper's Makefile:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/boot/Makefile#n10

Cheers,

Joel
