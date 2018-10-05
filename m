Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AEDC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:26:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6892064E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcgOq583"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6892064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RYWg3DDszF3SM
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 01:26:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DcgOq583";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="DcgOq583"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RYSk6qPCzDqjy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 01:24:06 +1000 (AEST)
Received: by mail-io1-xd41.google.com with SMTP id z16-v6so10964832iol.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LX+2MI+hHYUm+bKmtAJeiUXyAPi3Ulw5YVzm3/GssU0=;
 b=DcgOq583cb1mX/Otso2cQlfpjY1bepjnzyun2QY6sz8Y/CNAwJq+ic036IDRhXsDJM
 5wPGox4R+fpwpJx0rqCvaBwMU3woOwzEVt4Ss5RmHusG0vbG4nzcf8X/Dc+Fq0GKDTQt
 guUBLUkEDEsQpEx+4NBJML53DzgOb+3q/zOpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LX+2MI+hHYUm+bKmtAJeiUXyAPi3Ulw5YVzm3/GssU0=;
 b=PO8e05I3gfumMUK4ka61qWziApgJ0h30dfn50PsZStNwY/skSQ/VSrK1S5oeLjyrTn
 LKkd6psDvDvRJB9A0D4jKUuh5uRB8p0/vY4YdCEZ9P9Grpk/YsxuVTse8QtjirWmXEY1
 i7u/6ztEvLnWFlpxThtSbP/Q8Gy/bmhPMf+H3g9q/B8r/kJW8pYbC5Fgxi5oDFUG85VA
 e002tS5aS5zl/91wHE+GqkbKrrWmaTeXOz0HFUz+6tdUZRzFepU+0E4k7xkqFO4I58UC
 rAjmmUhRX4iVjq1shBu4qdF5H272yUOwYB8yUJxLl55nmXZELC2PSFqQO1o7I3Mlk3QK
 +4UQ==
X-Gm-Message-State: ABuFfojmRF+uBNgTTpqEcAzvt1ZJ8f8AOzimsPZyXwYxcVjcCWEFh5dF
 GRovITiWdLXB8aJHSCFf2Wi2+/uTv1u6RqOEB5mLKw==
X-Google-Smtp-Source: ACcGV61H+r0byvXHjqqSSVHL0DSrdOHfNZWI5KXAhm0WzubTqAY62t3z9by+L6aq5atxmrK8iitpD33kqV/xwmNyptU=
X-Received: by 2002:a6b:be83:: with SMTP id
 o125-v6mr8136071iof.173.1538753044011; 
 Fri, 05 Oct 2018 08:24:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP;
 Fri, 5 Oct 2018 08:24:03 -0700 (PDT)
In-Reply-To: <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org>
 <20181005141433.GS19272@hirez.programming.kicks-ass.net>
 <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 5 Oct 2018 17:24:03 +0200
Message-ID: <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function
 pointers
To: Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Samuel Neves <sneves@dei.uc.pt>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Eric Biggers <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5 October 2018 at 17:08, Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>> On Oct 5, 2018, at 7:14 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
>>> diff --git a/include/linux/ffp.h b/include/linux/ffp.h
>>> new file mode 100644
>>> index 000000000000..8fc3b4c9b38f
>>> --- /dev/null
>>> +++ b/include/linux/ffp.h
>>> @@ -0,0 +1,43 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +
>>> +#ifndef __LINUX_FFP_H
>>> +#define __LINUX_FFP_H
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/compiler.h>
>>> +
>>> +#ifdef CONFIG_HAVE_ARCH_FFP
>>> +#include <asm/ffp.h>
>>> +#else
>>> +
>>> +struct ffp {
>>> +    void    (**fn)(void);
>>> +    void    (*default_fn)(void);
>>> +};
>>> +
>>> +#define DECLARE_FFP(_fn, _def)                        \
>>> +    extern typeof(_def) *_fn;                    \
>>> +    extern struct ffp const __ffp_ ## _fn
>>> +
>>> +#define DEFINE_FFP(_fn, _def)                        \
>>> +    typeof(_def) *_fn =3D &_def;                    \
>>> +    struct ffp const __ffp_ ## _fn                    \
>>> +        =3D { (void(**)(void))&_fn, (void(*)(void))&_def };    \
>>> +    EXPORT_SYMBOL(__ffp_ ## _fn)
>>> +
>>> +static inline void ffp_set_target(const struct ffp *m, void *new_fn)
>>> +{
>>> +    WRITE_ONCE(*m->fn, new_fn);
>>> +}
>>> +
>>> +static inline void ffp_reset_target(const struct ffp *m)
>>> +{
>>> +    WRITE_ONCE(*m->fn, m->default_fn);
>>> +}
>>> +
>>> +#endif
>>> +
>>> +#define SET_FFP(_fn, _new)    ffp_set_target(&__ffp_ ## _fn, _new)
>>> +#define RESET_FFP(_fn)        ffp_reset_target(&__ffp_ ## _fn)
>>> +
>>> +#endif
>>
>> I don't understand this interface. There is no wrapper for the call
>> site, so how are we going to patch all call-sites when you update the
>> target?
>
> I=E2=80=99m also confused.
>
> Anyway, we have patchable functions on x86. They=E2=80=99re called PVOPs,=
 and they=E2=80=99re way overcomplicated.
>
> I=E2=80=99ve proposed a better way that should generate better code, be m=
ore portable, and be more maintainable.  It goes like this.
>
> To call the function, you literally just call  the default implementation=
.  It *might* be necessary to call a nonexistent wrapper to avoid annoying =
optimizations. At build time, the kernel is built with relocations, so the =
object files contain relocation entries for the call. We collect these entr=
ies into a table. If we=E2=80=99re using the =E2=80=9Cnonexistent wrapper=
=E2=80=9D approach, we can link in a .S or linker script to alias them to t=
he default implementation.
>
> To patch them, we just patch them. It can=E2=80=99t necessarily be done c=
oncurrently because nothing forces the right alignment. But we can do it at=
 boot time and module load time. (Maybe we can patch at runtime on architec=
tures with appropriate instruction alignment.  Or we ask gcc for an extensi=
on to align calls to a function.)
>
> Most of the machinery already exists: this is roughly how the module load=
er resolves calls outside of a module.

Yeah nothing is ever simple on x86 :-(

So are you saying the approach i use in patch #2 (which would
translate to emitting a jmpq instruction pointing to the default
implementation, and patching it at runtime to point elsewhere) would
not fly on x86?
