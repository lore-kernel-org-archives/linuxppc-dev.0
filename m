Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3855CC282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 14:47:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBC7222C8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 14:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNsDU3SU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBC7222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lzND0nw1zDqWC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 00:47:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=kernelfans@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oNsDU3SU"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lzL65GZyzDqTL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 00:45:50 +1000 (AEST)
Received: by mail-it1-x144.google.com with SMTP id y134so8545360itc.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1u4P30QW5skkaJsHDqOc8QtC53uRsJT/X9i8uTHPt3k=;
 b=oNsDU3SUvtMPq3wWJilxawt0TRthfdVa0auU66IxjEAAt/drJJeJ6i7t3XtSwQVWai
 852/2EwxxJaXrJmoN0JsG1Js2DfNZzmkVx6PEo/+HQOYp2tfaTo1XdtllidHV5O8jhMl
 pZZ/IKfBrmY+D7QOYBcbHJrI14Dizjt0iUNpNcm5ZtHYPtgWs7nIwdvbjCBoJdBqtEHq
 V6BppiqpvQsstYeIm1DL9XIsnFYsWF0rPVTXndRiE0/qtbjpH+P74XRrpMXzJ/jyIpOI
 vjpjvre1erpAUZ9+yeXVpByPwAVg4q4K8jD55jXo2ZjjifSms9j8UmX2WC+Lm5e6Wwhk
 c+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1u4P30QW5skkaJsHDqOc8QtC53uRsJT/X9i8uTHPt3k=;
 b=B5Fm8uEXiLBRXZXMY2itafAqxZt/Wk7pOpLH0L4pGH9gObuT9hJbFEeOi6bHMpjw+k
 g1r6VmX8+2Cx5a+a/vOXM/wPnDEC5tWIBjJESvFgZmBZvfGWJ0TL3MgtVHTpq2vfOQPV
 3MNUayPYdgJbwG32ZyPWnLXTIsXwPTBvzksFhXsqxNFB6eKeUv70quKXdQC21TFIQCf+
 /iouaJ1inPEKcvVGoB43xnDvJVybKCtvHDI3JkHDqzhn8/geIDjyZXzCVZNdout9eb21
 ERzMlJZ5V8h3bMPkyZF6V9J6Uu69VGhUeJ88Oc2JYmkjSAXJr1I/Kc5IdXjpkA0SR7m2
 Vdpg==
X-Gm-Message-State: APjAAAXkozBtdTfAgLOX/Xrci4XbRHdD9ZGmYUp4Zg//nDAgP15n26+B
 QxKLXc2t5rQ0IWqN6HLH/mGh8InuBwHGdhAoDQ==
X-Google-Smtp-Source: APXvYqzd/vOB2+p3xIauiqtMqq7JFZgz/Cp1XYULhBHhx/NPA18PAVgawPDXMDHQmNzSnEOPlPsL9TZ7P9GgAwAZw8o=
X-Received: by 2002:a02:cd02:: with SMTP id g2mr2939574jaq.70.1555685146976;
 Fri, 19 Apr 2019 07:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <1555660717-18731-1-git-send-email-kernelfans@gmail.com>
 <alpine.DEB.2.21.1904191009040.3174@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904191009040.3174@nanos.tec.linutronix.de>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Fri, 19 Apr 2019 22:45:35 +0800
Message-ID: <CAFgQCTtaP24gXUs_dh4h8qCsA-TKHc5A-vs5oiezfwuR_qjQvA@mail.gmail.com>
Subject: Re: [PATCH] kernel/crash: make parse_crashkernel()'s return value
 more indicant
To: Thomas Gleixner <tglx@linutronix.de>
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Julien Thierry <julien.thierry@arm.com>, Yangtao Li <tiny.windzz@gmail.com>,
 Palmer Dabbelt <palmer@sifive.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 x86@kernel.org, Stefan Agner <stefan@agner.ch>, linux-mips@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-s390@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Dave Young <dyoung@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>, linuxppc-dev@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Borislav Petkov <bp@alien8.de>, Hari Bathini <hbathini@linux.ibm.com>,
 Jens Axboe <axboe@kernel.dk>, Tony Luck <tony.luck@intel.com>,
 Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Thomas Bogendoerfer <tbogendoerfer@suse.de>,
 Paul Burton <paul.burton@mips.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Logan Gunthorpe <logang@deltatee.com>, Greg Hackmann <ghackmann@android.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 19, 2019 at 4:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 19 Apr 2019, Pingfan Liu wrote:
>
> > At present, both return and crash_size should be checked to guarantee the
> > success of parse_crashkernel().
> > Simplify the way by returning negative if fail, positive if success. In
> > case of failure, -EINVAL for bad syntax, -1 for the parsing results in
> > crash_size=0.
>
> I'm not entirely sure what you are trying to say here, but '-1' is not an
> improvement at all. We surely are not short of proper error codes, right?
>
The different negative return values are only used by x86. The option
"crashkernel=X,high", which is only used on x86, causes parse_kernel()
to return -EINVAL, then let parse_crashkernel_high() have a try.

When parsing crashkernel=size@offset and crashkernel=range1:size1,
there are other cases of failure, which is not worth to call
parse_crashkernel_high() to have a try. That is "-1" aiming for.

First, in parse_crashkernel_mem(), if demanded size is bigger than
system ram, this one looks like -ENOMEM, but -ENOMEM normally is used
for allocation. Second, in parse_crashkernel_mem(), if system ram is
not inside the range listed by "crashkernel=". Third, crashkernel=0MB
is given in the option (not in practice, but can not forbid user to do
so).

All of these cases can be treated as -EINVAL, but hard to define the
error codes.
> Also I don't see any positive return value > 0. So what is this about:
>
Yes. 0 is enough for success.  I had thought about returning 1 if
@offset is specified in crashkernel. But at present, no use case for
it.

> > --- a/arch/ia64/kernel/setup.c
> > +++ b/arch/ia64/kernel/setup.c
> > @@ -277,7 +277,7 @@ static void __init setup_crashkernel(unsigned long total, int *n)
> >
> >       ret = parse_crashkernel(boot_command_line, total,
> >                       &size, &base);
> > -     if (ret == 0 && size > 0) {
> > +     if (ret >= 0) {
>
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^  ????
>
> >       if (!memory_region_available(crash_base, crash_size)) {
> > diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> > index 45a8d0b..0b626e2 100644
> > --- a/arch/powerpc/kernel/fadump.c
> > +++ b/arch/powerpc/kernel/fadump.c
> > @@ -376,7 +376,7 @@ static inline unsigned long fadump_calculate_reserve_size(void)
> >        */
> >       ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> >                               &size, &base);
> > -     if (ret == 0 && size > 0) {
> > +     if (ret >= 0) {
>
> and this ?
>
> >               unsigned long max_size;
> >
> >               if (fw_dump.reserve_bootvar)
> > diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> > index 63f5a93..9f3e61a 100644
> > --- a/arch/powerpc/kernel/machine_kexec.c
> > +++ b/arch/powerpc/kernel/machine_kexec.c
> > @@ -122,7 +122,7 @@ void __init reserve_crashkernel(void)
> >       /* use common parsing */
> >       ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> >                       &crash_size, &crash_base);
> > -     if (ret == 0 && crash_size > 0) {
> > +     if (ret >= 0) {
>
> Again.
>
> >               crashk_res.start = crash_base;
> >               crashk_res.end = crash_base + crash_size - 1;
> >       }
> > --- a/arch/sh/kernel/machine_kexec.c
> > +++ b/arch/sh/kernel/machine_kexec.c
> > @@ -157,7 +157,7 @@ void __init reserve_crashkernel(void)
> >
> >       ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> >                       &crash_size, &crash_base);
> > -     if (ret == 0 && crash_size > 0) {
> > +     if (ret >= 0) {
>
> And some more.
>
> >               crashk_res.start = crash_base;
> >               crashk_res.end = crash_base + crash_size - 1;
> >       }
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 3d872a5..62d07d4 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -526,11 +526,11 @@ static void __init reserve_crashkernel(void)
> >
> >       /* crashkernel=XM */
> >       ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
> > -     if (ret != 0 || crash_size <= 0) {
> > +     if (ret == -EINVAL) {
>
> Without an explanation why this proceedes on error codes other than EINVAL
> this is uncomprehensible. Comments exist for a reason.
>
As explained above, deciding whether to let parse_crashkernel_high() try.

> >               /* crashkernel=X,high */
> >               ret = parse_crashkernel_high(boot_command_line, total_mem,
> >                                            &crash_size, &crash_base);
> > -             if (ret != 0 || crash_size <= 0)
> > +             if (ret < 0)
> >                       return;
> >               high = true;
>
> > @@ -87,7 +87,7 @@ static int __init parse_crashkernel_mem(char *cmdline,
> >               cur = tmp;
> >               if (size >= system_ram) {
> >                       pr_warn("crashkernel: invalid size\n");
> > -                     return -EINVAL;
> > +                     return -1;
>
> Well, this is incomprehensible as well. The pr_warn() says invalid and then
> you change the error code to something magic.
>
As explained above, want to know whether worth to let
parse_crashkernel_high() try.

What about the following alternative method? Treating crash_size=0 as
-EINVAL. Then on x86, just call parse_crashkernel_high() blindly to
have a try. Thanks for your review.

Regards,
Pingfan
