Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552C0C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 14:46:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC1D2075D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 14:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="eNpv9upD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC1D2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fbmk1wyRzF35p
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 01:46:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=globallogic.com header.i=@globallogic.com header.b="eNpv9upD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=globallogic.com
 (client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com;
 envelope-from=maksym.kokhan@globallogic.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none)
 header.from=globallogic.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=globallogic.com header.i=@globallogic.com
 header.b="eNpv9upD"; dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fbjd0lFfzF322
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 01:43:32 +1100 (AEDT)
Received: by mail-qk1-x743.google.com with SMTP id a193-v6so947549qkc.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=globallogic.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=754/5ITZBbZDoTPrVkDyPmFe8QdpzTTFJC5+mfnnMVk=;
 b=eNpv9upDCPWwr/SKhtZ55Alah6gVZ7N6JRwxmdP7/RhzV8+/fQP5TE4yr+v2XL08xX
 xwnLJqzAtanbDbpfes+mxNPdb3JjscIPZap6r0IwF8s0OTCF/keP/fvjNvMge5oVlm65
 TJzQVDNu/ycG4oFJ9pyfz3HsE89onZ5RWfsis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=754/5ITZBbZDoTPrVkDyPmFe8QdpzTTFJC5+mfnnMVk=;
 b=LyDLfjJdpZ6uAJvfSUVVJXLHM184AowLdb/TXBJY++/EAV9Ri+RWTrLepvIELkZfMJ
 upOgKiM6XPPheIay4JcW4AUGJMxoSXmLUEOedIHi9bC39KxknvN50i6ywrWdV4vxvf8J
 5f/slMZZ6dVn1jxc7ZTY9lXeWx4KCB92YMNq7gbagwMkJrJc0/3uK391fvLzQPqd9ZX8
 ldnSieMs0LzMsNn8JlfoBWbuocqZpyFiXm9ygKWVJxMbw+v6tEhilYKpLW8t7yq6Eccj
 VNZhISfGrH9FakM21KA9b3m23hzqQfe/8eY+ZEwAomeVq/9ghxEnljvMBoeQjxwC8axS
 WZ4A==
X-Gm-Message-State: ABuFfoho3qkUSKsvV/1Yg/XgGUhgSLJC6yV6M2zG671EXAw45v2TLwrn
 zTJoXXLsligWoj3LWPa5ESwbX6WTiGMd5SAy2vP48w==
X-Google-Smtp-Source: ACcGV60mj9wurBJz3bhIb7CXEE5cVoMC8I4YpO1rO32fmjizO3YKseTNm+HxvJZwnpF+By6X/1KXIU5Lar3v4kFL3w4=
X-Received: by 2002:a37:5288:: with SMTP id
 g130-v6mr48964538qkb.124.1540305810040; 
 Tue, 23 Oct 2018 07:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
 <20180929181725.GB27441@fifo99.com>
 <CAMT6-xiQ0vGcKpA+SiWHQWQFwU9Oo9j=Zin+UXDoPqKTz5fbeA@mail.gmail.com>
In-Reply-To: <CAMT6-xiQ0vGcKpA+SiWHQWQFwU9Oo9j=Zin+UXDoPqKTz5fbeA@mail.gmail.com>
From: Maksym Kokhan <maksym.kokhan@globallogic.com>
Date: Tue, 23 Oct 2018 17:43:18 +0300
Message-ID: <CAMT6-xj1rjVAy1AWFiMHc5wH36eu=TUSMtdKU=-qRtUbwr9bkg@mail.gmail.com>
Subject: Re: [PATCH 0/8] add generic builtin command line
To: Daniel Walker <dwalker@fifo99.com>
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
Cc: linux-mips@linux-mips.org, linux-efi@vger.kernel.org,
 Ruslan Bilovol <rbilovol@cisco.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Frank Rowand <frowand.list@gmail.com>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Daniel Walker <danielwa@cisco.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Bordunov <aborduno@cisco.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 8, 2018 at 9:01 PM Maksym Kokhan
<maksym.kokhan@globallogic.com> wrote:
>
> Hi, Daniel
>
> On Sat, Sep 29, 2018 at 9:17 PM <dwalker@fifo99.com> wrote:
> >
> > On Thu, Sep 27, 2018 at 07:55:08PM +0300, Maksym Kokhan wrote:
> > > Daniel Walker (7):
> > >   add generic builtin command line
> > >   drivers: of: ifdef out cmdline section
> > >   x86: convert to generic builtin command line
> > >   arm: convert to generic builtin command line
> > >   arm64: convert to generic builtin command line
> > >   mips: convert to generic builtin command line
> > >   powerpc: convert to generic builtin command line
> > >
> >
> > When I originally submitted these I had a very good conversion with Rob Herring
> > on the device tree changes. It seemed fairly clear that my approach in these
> > changes could be done better. It effected specifically arm64, but a lot of other
> > platforms use the device tree integrally. With arm64 you can reduce the changes
> > down to only Kconfig changes, and that would likely be the case for many of the
> > other architecture. I made patches to do this a while back, but have not had
> > time to test them and push them out.
>
> Can you please share this patches? I could test them and use to improve this
> generic command line implementation.
>
> > In terms of mips I think there's a fair amount of work needed to pull out their
> > architecture specific mangling into something generic. Part of my motivation for
> > these was to take the architecture specific feature and open that up for all the
> > architecture. So it makes sense that the mips changes should become part of
> > that.
>
> This is really makes sense, and we have intentions to implement it
> afterward. It would be easier to initially merge this simple
> implementation and then develop it step by step.
>
> > The only changes which have no comments are the generic changes, x86, and
> > powerpc. Those patches have been used at Cisco for years with no issues.
> > I added those changes into my -next tree for a round of testing. Assuming there
> > are no issues I can work out the merging with the architecture maintainers.
> > As for the other changes I think they can be done in time, as long as the
> > generic parts of upstream the rest can be worked on by any of the architecture
> > developers.
>
> Thanks,
> Maksym

We still have no response to patches for x86, arm, arm64 and powerpc.
Is current generic command line implementation appropriate for these
architectures?
Is it possible to merge these patches in the current form (for x86,
arm, arm64 and powerpc)?

Thanks,
Maksym
