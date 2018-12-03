Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9E6C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:59:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADDB2064A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="C7GjDYxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADDB2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4380mV6XrJzDqT4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:59:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="C7GjDYxf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::742; helo=mail-qk1-x742.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="C7GjDYxf"; 
 dkim-atps=neutral
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437zmT6yjPzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 09:14:01 +1100 (AEDT)
Received: by mail-qk1-x742.google.com with SMTP id 189so8393901qkj.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 14:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4tQRj7YtxJOLI8Nz3X9VVhFqSK8FkIZrTx2UbmzwihE=;
 b=C7GjDYxfLh2Ob9D56uUowuyLO8W0DY+VN4ISVR/GArE/4dA45oc+I4KFmQz7Klvm6m
 1rzcJqN/EZCtVWkNHbwIku91WkzttPj0oQnXSgwCjQtJsChsz39MTR0XfOOwr5mAsa76
 n3EhstuTziWg+N8s6iLR300efG4E/1IVrKD7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4tQRj7YtxJOLI8Nz3X9VVhFqSK8FkIZrTx2UbmzwihE=;
 b=WHMN1TjsqSmMfMwqLWdM6+uC9ymT7iRGx7qVQAP7U/QxlmrmoholowcZo0+8VALiqq
 rzWs/vhcpRfNgTz7/Dvd9eyo/E7qm4jGV3tgRWLluJrSVjCXpQixr7IKoNk2DKKAYUZc
 ELrLVCFT4s75Ua3bXHIBXg67hjBTB1yh3YsZhfOXTW6cSW/BGe+AVgRVDbLzbB4O7ZO0
 9ejEObAQMJoQbuMazg8C5LU3LihDYbzPKkbkRvcOweHSSPlAtabsAQ+DsVmM4/vtG8M0
 CwjsQInHVbiPQItGEk2DimTX3wS1f/I7Q5a9rQfgBTD/FV74Xpyg1ud93IXPIbFIezha
 1DJw==
X-Gm-Message-State: AA+aEWbp9j+aZ71v5dJE4QTjBD3uANkUWfIBE34G4HF16wDT7lNUAZ7a
 Hj3F9QbpbUgdRkVKrp1DM/hoOlghv6WXpDPz/qM=
X-Google-Smtp-Source: AFSGD/VOPJfpW1K8PArA2x7433o4go/0YHLtInmxXWri+wIbqOZ9BOYZcfNZYL5wRAcdSCEqMRMFuKR3zoc35aysQhs=
X-Received: by 2002:a37:781:: with SMTP id 123mr16494465qkh.231.1543875239356; 
 Mon, 03 Dec 2018 14:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20181102004455.10157-1-joel@jms.id.au>
 <CAKwvOdni_iJ4beAWYkUUpZss_PYZezMGR7hN9k1rm9J0iB0gHQ@mail.gmail.com>
 <CACPK8XdbWzb=52iFV_fj0Y5KMWPgsRv_A8PZgfKn9vm96y3LOw@mail.gmail.com>
 <CAKwvOdndyeRZApOqbp-6evEpYgzHyGo4qqaMKd_DQ4U9x8_5wA@mail.gmail.com>
In-Reply-To: <CAKwvOdndyeRZApOqbp-6evEpYgzHyGo4qqaMKd_DQ4U9x8_5wA@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 4 Dec 2018 08:43:47 +1030
Message-ID: <CACPK8Xcz4YzfnFAHGOcJZkt0UFfQ02YabtEQDHXdSFsH57xRiQ@mail.gmail.com>
Subject: Re: [PATCH v2] raid6/ppc: Fix build for clang
To: Nick Desaulniers <ndesaulniers@google.com>
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Jinsong Ji <jji@us.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 4 Dec 2018 at 05:15, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > +ifdef CONFIG_CC_IS_CLANG
> > > > +# clang ppc port does not yet support -maltivec when -msoft-float is
> > > > +# enabled. A future release of clang will resolve this
> > > > +# https://bugs.llvm.org/show_bug.cgi?id=31177
> > > > +CFLAGS_REMOVE_altivec1.o  += -msoft-float
> > > > +CFLAGS_REMOVE_altivec2.o  += -msoft-float
> > > > +CFLAGS_REMOVE_altivec4.o  += -msoft-float
> > > > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > > > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > > > +CFLAGS_REMOVE_vpermxor1.o += -msoft-float
> > > > +CFLAGS_REMOVE_vpermxor2.o += -msoft-float
> > > > +CFLAGS_REMOVE_vpermxor4.o += -msoft-float
> > > > +CFLAGS_REMOVE_vpermxor8.o += -msoft-float
> > > > +endif
> > >
> > > Hi Joel, thanks for this patch!  My same thoughts about
> > > CONFIG_CC_IS_CLANG vs cc-option from
> > > https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/180939.html
> > > apply here as well.  I don't feel strongly about either though.  What
> > > are your thoughts?
> >
> > I'm not sure that we can test for this one with cc-option. The result
> > of having -maltivec with -msoft-float is a error about the internals
> > of clang, which isn't something that kbuild is set up to test for.
>
> As in clang itself crashes, and cc-option/kbuild can't handle that gracefully?

The developer gets something like this:

SplitVectorResult #0: t196: v16i8 = llvm.ppc.altivec.vcmpgtsb
TargetConstant:i64<4823>, t146, t195
fatal error: error in backend: Do not know how to split the result of
this operator!
clang-8: error: clang frontend command failed with exit code 70 (use
-v to see invocation)

>
> >
> > When clang is fixed to allow this combination we will still build this
> > code in the same way, so in that sense it fails "open".
> >
