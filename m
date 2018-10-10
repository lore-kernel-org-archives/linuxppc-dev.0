Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BE1C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 21:55:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982812082B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 21:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="gBNdLKh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982812082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Vnw24KhnzF1Ph
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 08:55:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="gBNdLKh8";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="gBNdLKh8"; 
 dkim-atps=neutral
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VnsK4gWCzF14b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 08:53:09 +1100 (AEDT)
Received: by mail-qt1-x842.google.com with SMTP id d14-v6so7581400qto.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wgblG3aXJkWEwRbvlmAO5pm6SBb54sTe09fUe+psMnM=;
 b=gBNdLKh8QzVOodjST5fNdH9t5TgsEDdrDxbbqFntDzNkhrejxQBhmzXXqSC7ZoAVXJ
 lvrlSl27Rixj/bNgA0kopiquABlmhrmVGeLUNRBQGoYXFNcA0G9JgMryBJdh6DEJfJLc
 FiOIFtc+algVgQgwD5hvg19MOTxWRL4FICe7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wgblG3aXJkWEwRbvlmAO5pm6SBb54sTe09fUe+psMnM=;
 b=azx30vD45Wr06mwsN7e+IUGyKRC3uGuP4QzPOUwocbiBUJ7jMl2wxWevuIwj3u9zbB
 Q8HBZRF2xKcBZ9cmdcibduj6eMxBi/uFsqH5W+EeEC8uJZ+sR9+JbsmTna4xvc2msRzq
 +I0GeWkhKZmAaJYatIoSQG0iG35Dh1ITarWgohuZnBu7inJjD31+XNXvNpTeqIG6g7Bp
 yEw22g/Aj9aWtP0fwDC2YtAL/9iHEZ/Cnau8Q8UPofPvrn9hLPBWUfK7YlNAFksmVH8I
 4R1p93ymxWj3I8/vgPUT35Qygtw3GYghUYzs7RlQXzgicrv0GvjnMNIU1vDseWn0J6fq
 65zw==
X-Gm-Message-State: ABuFfohCopZwZRryJEtjSLCrMU9cNCz3yfg2WKFBFQneSP8xIDmL74j0
 ESOvCj5IxRSPslpnjyIosMqblpTeQeVipr4FLs0=
X-Google-Smtp-Source: ACcGV626+sz4fRibo8806FFuwDls1F4rHdBWBiCJ8ryTyU9Z6ueyIUXPAjTYEOEvSbNGOl7FfMkv/od26AoTJIV2DE8=
X-Received: by 2002:a05:6214:18d:: with SMTP id
 q13mr29837422qvr.51.1539208386911; 
 Wed, 10 Oct 2018 14:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181010024523.4921-1-joel@jms.id.au>
 <20181010024523.4921-2-joel@jms.id.au>
 <87lg762e94.fsf@concordia.ellerman.id.au>
In-Reply-To: <87lg762e94.fsf@concordia.ellerman.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 11 Oct 2018 08:22:54 +1030
Message-ID: <CACPK8Xf+vF_87Ji+2XKzOM8HN6R8e+wKVYPZgQva9KwFSZDvJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/boot: Disable vector instructions
To: Michael Ellerman <mpe@ellerman.id.au>,
 Segher Boessenkool <segher@kernel.crashing.org>
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

On Wed, 10 Oct 2018 at 22:41, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Joel Stanley <joel@jms.id.au> writes:
>
> > This will avoid auto-vectorisation when building with higher
> > optimisation levels.
> >
> > We don't know if the machine can support VSX and even if it's present
> > it's probably not going to be enabled at this point in boot.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  arch/powerpc/boot/Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> > index 0fb96c26136f..739ef8d43b91 100644
> > --- a/arch/powerpc/boot/Makefile
> > +++ b/arch/powerpc/boot/Makefile
> > @@ -32,8 +32,8 @@ else
> >  endif
> >
> >  BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> > -              -fno-strict-aliasing -Os -msoft-float -pipe \
> > -              -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
> > +              -fno-strict-aliasing -Os -msoft-float -mno-altivec -mno-vsx \
>
> That's going to break if the compiler doesn't understand -mno-vsx isn't it?
>
> I'm not sure if "support" a compiler that old though.

Segher, the kernel mandates 4.6 as the minimum. Do we need to worry
about the compiler not supporting  -mno-altivec -mno-vsx?
