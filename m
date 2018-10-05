Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848C9C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:27:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3EDB2084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImiaXwot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EDB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RdX16sgLzF3cK
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 04:27:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ImiaXwot";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="ImiaXwot"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Rc6P580yzF3Sb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 03:23:25 +1000 (AEST)
Received: by mail-it1-x142.google.com with SMTP id 134-v6so3586080itz.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nKIcHcj4VLihwnehuDMa/7jLvdFNBm7BBQ9E0Fn1km0=;
 b=ImiaXwothBeNxt0ytccOnoa6aVzfwERiZ9ea/DUhg4tEOpsvNdBJos9DYv8lzwy74s
 HnDWqqi3dBr+Zkc6mzKbK3r7bC2YbXSAxA/fU2R1GMI0U5c7Yf6yYeZxqAM0qfD2Nv2G
 QznafJPRqshALmXd0o7qdTR2uqc2zJwcpc4aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nKIcHcj4VLihwnehuDMa/7jLvdFNBm7BBQ9E0Fn1km0=;
 b=fDHZb8RNdw4ORy0X3rHSGvTAzc8ksSo+hMxegR/tJc0lR3k/4GcT/xXjwiTN48ZN48
 Ucu60PAZCL5omABnB1Wq3Bf+xL9wHSRtSB978pctn5ZnsXP6LGn1b5YYU+OOnZnJQlPo
 xmhMhHvf73IS5ero4KNRywXix0kVGpHjylx12TD+Z1+IDTulLMgvuAXNrmeiKYi3b72o
 ANZutFH2w+QXbpiyb1aGzExZbdlyVH4O3+qB4blzgw7+h+jNS3Roe+h2VLkFesozR7bp
 ubojmYZRVkzt/FHEEQ6dXtzxFuY0XaOSouShLweyf3952fTcYt8Wlh/NE+jaxRgpD/Ok
 KwVw==
X-Gm-Message-State: ABuFfoh7OgXs0tuxhFbkSZcVOszIqtwYFmR47J4+E3jemzQdK6OWDOJJ
 N+xMOQt47XX8BDTexFeGZOsVShK592A28z6wZiSPJg==
X-Google-Smtp-Source: ACcGV62iTEx3KMnRbakLtt+hprzaBCa/Pt4RA6C9OG7HjGikt3PY/6J2hFlEWtZjx3dF0D9ECIYaAUPdpwjEHMrEN4c=
X-Received: by 2002:a24:a10b:: with SMTP id
 y11-v6mr5195415ite.148.1538760203373; 
 Fri, 05 Oct 2018 10:23:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP;
 Fri, 5 Oct 2018 10:23:22 -0700 (PDT)
In-Reply-To: <CALCETrU=fm+ZG4WZJfG-5GwL7kv5_GS1aZYu=L42d5BuSbhJDQ@mail.gmail.com>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org>
 <20181005141433.GS19272@hirez.programming.kicks-ass.net>
 <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net>
 <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com>
 <CALCETrWaewXsdJsf3SocgZ0ggnvZk86L+5-LWPRbjdnG2mB7jw@mail.gmail.com>
 <CAKv+Gu-oHBtgGbWXJu6+z4+BNhBZyY5VvF_v6cJJUGk_5YX1eQ@mail.gmail.com>
 <CALCETrU=fm+ZG4WZJfG-5GwL7kv5_GS1aZYu=L42d5BuSbhJDQ@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 5 Oct 2018 19:23:22 +0200
Message-ID: <CAKv+Gu8eHPEsUbkhN=61z9FvhdCo2e3VOdemp4g0bzdO1EJFYQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function
 pointers
To: Andy Lutomirski <luto@kernel.org>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Samuel Neves <sneves@dei.uc.pt>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Eric Biggers <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5 October 2018 at 19:20, Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Oct 5, 2018 at 10:11 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>>
>> On 5 October 2018 at 18:58, Andy Lutomirski <luto@kernel.org> wrote:
>> > On Fri, Oct 5, 2018 at 8:24 AM Ard Biesheuvel <ard.biesheuvel@linaro.o=
rg> wrote:
>> >>
>> >> On 5 October 2018 at 17:08, Andy Lutomirski <luto@amacapital.net> wro=
te:
>> >> >
>> >> >
>> >> >> On Oct 5, 2018, at 7:14 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>> >> >>
>> >> >>> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
>> >> >>> diff --git a/include/linux/ffp.h b/include/linux/ffp.h
>> >> >>> new file mode 100644
>> >> >>> index 000000000000..8fc3b4c9b38f
>> >> >>> --- /dev/null
>> >> >>> +++ b/include/linux/ffp.h
>> >> >>> @@ -0,0 +1,43 @@
>> >> >>> +/* SPDX-License-Identifier: GPL-2.0 */
>> >> >>> +
>> >> >>> +#ifndef __LINUX_FFP_H
>> >> >>> +#define __LINUX_FFP_H
>> >> >>> +
>> >> >>> +#include <linux/types.h>
>> >> >>> +#include <linux/compiler.h>
>> >> >>> +
>> >> >>> +#ifdef CONFIG_HAVE_ARCH_FFP
>> >> >>> +#include <asm/ffp.h>
>> >> >>> +#else
>> >> >>> +
>> >> >>> +struct ffp {
>> >> >>> +    void    (**fn)(void);
>> >> >>> +    void    (*default_fn)(void);
>> >> >>> +};
>> >> >>> +
>> >> >>> +#define DECLARE_FFP(_fn, _def)                        \
>> >> >>> +    extern typeof(_def) *_fn;                    \
>> >> >>> +    extern struct ffp const __ffp_ ## _fn
>> >> >>> +
>> >> >>> +#define DEFINE_FFP(_fn, _def)                        \
>> >> >>> +    typeof(_def) *_fn =3D &_def;                    \
>> >> >>> +    struct ffp const __ffp_ ## _fn                    \
>> >> >>> +        =3D { (void(**)(void))&_fn, (void(*)(void))&_def };    \
>> >> >>> +    EXPORT_SYMBOL(__ffp_ ## _fn)
>> >> >>> +
>> >> >>> +static inline void ffp_set_target(const struct ffp *m, void *new=
_fn)
>> >> >>> +{
>> >> >>> +    WRITE_ONCE(*m->fn, new_fn);
>> >> >>> +}
>> >> >>> +
>> >> >>> +static inline void ffp_reset_target(const struct ffp *m)
>> >> >>> +{
>> >> >>> +    WRITE_ONCE(*m->fn, m->default_fn);
>> >> >>> +}
>> >> >>> +
>> >> >>> +#endif
>> >> >>> +
>> >> >>> +#define SET_FFP(_fn, _new)    ffp_set_target(&__ffp_ ## _fn, _ne=
w)
>> >> >>> +#define RESET_FFP(_fn)        ffp_reset_target(&__ffp_ ## _fn)
>> >> >>> +
>> >> >>> +#endif
>> >> >>
>> >> >> I don't understand this interface. There is no wrapper for the cal=
l
>> >> >> site, so how are we going to patch all call-sites when you update =
the
>> >> >> target?
>> >> >
>> >> > I=E2=80=99m also confused.
>> >> >
>> >> > Anyway, we have patchable functions on x86. They=E2=80=99re called =
PVOPs, and they=E2=80=99re way overcomplicated.
>> >> >
>> >> > I=E2=80=99ve proposed a better way that should generate better code=
, be more portable, and be more maintainable.  It goes like this.
>> >> >
>> >> > To call the function, you literally just call  the default implemen=
tation.  It *might* be necessary to call a nonexistent wrapper to avoid ann=
oying optimizations. At build time, the kernel is built with relocations, s=
o the object files contain relocation entries for the call. We collect thes=
e entries into a table. If we=E2=80=99re using the =E2=80=9Cnonexistent wra=
pper=E2=80=9D approach, we can link in a .S or linker script to alias them =
to the default implementation.
>> >> >
>> >> > To patch them, we just patch them. It can=E2=80=99t necessarily be =
done concurrently because nothing forces the right alignment. But we can do=
 it at boot time and module load time. (Maybe we can patch at runtime on ar=
chitectures with appropriate instruction alignment.  Or we ask gcc for an e=
xtension to align calls to a function.)
>> >> >
>> >> > Most of the machinery already exists: this is roughly how the modul=
e loader resolves calls outside of a module.
>> >>
>> >> Yeah nothing is ever simple on x86 :-(
>> >>
>> >> So are you saying the approach i use in patch #2 (which would
>> >> translate to emitting a jmpq instruction pointing to the default
>> >> implementation, and patching it at runtime to point elsewhere) would
>> >> not fly on x86?
>> >
>> > After getting some more sleep, I'm obviously wrong.  The
>> > text_poke_bp() mechanism will work.  It's just really slow.
>> >
>>
>> OK
>>
>> > Let me try to summarize some of the issues.  First, when emitting
>> > jumps and calls from inline asm on x86, there are a few considerations
>> > that are annoying:
>> >
>> > 1. Following the x86_64 ABI calling conventions is basically
>> > impossible.  x86_64 requires a 128-byte redzone and 16-byte stack
>> > alignment.  After much discussion a while back, we decided that it was
>> > flat-out impossible on current gcc to get the stack pointer aligned in
>> > a known manner in an inline asm statement.  Instead, if we actually
>> > need alignment, we need to align manually.  Fortunately, the kernel is
>> > built with an override that forces only 8-byte alignment (on *most*
>> > GCC versions).  But for crypto in particular, it sucks extra, since
>> > the crypto code is basically the only thing in the kernel that
>> > actually wants 16-byte alignment.  I don't think this is a huge
>> > problem in practice, but it's annoying.  And the kernel is built
>> > without a redzone.
>> >
>> > 2. On x86_64, depending on config, we either need frame pointers or
>> > ORC.  ORC is no big deal -- it Just Works (tm).  Frame pointers need
>> > extra asm hackery.  It's doable, but it's still annoying.
>> >
>> > 3. Actually getting the asm constraints right to do what a C
>> > programmer expects is distinctly nontrivial.  I just fixed an
>> > extremely longstanding bug in the vDSO code in which the asm
>> > constraints for the syscall fallback were wrong in such a way that GCC
>> > didn't notice that the fallback wrote to its output parameter.
>> > Whoops.
>> >
>>
>> OK, so the thing I am missing is why this all matters.
>>
>> Note that the compiler should take care of all of this. It emits a
>> call a function with external linkage having prototype X, and all the
>> inline asm does is emit a jmp to some function having that same
>> prototype, either the default one or the one we patched in.
>>
>> Apologies if I am missing something obvious here: as you know, x86 is
>> not my focus in general.
>
> The big issue that bothers me isn't the x86-ism so much as the nasty
> interactions with the optimizer.  On x86, we have all of this working.
> It's in arch/x86/include/asm/paravirt_types.h, and it looks roughly
> like:
>
>                         asm volatile(pre                                \
>                                      paravirt_alt(PARAVIRT_CALL)        \
>                                      post                               \
>                                      : call_clbr, ASM_CALL_CONSTRAINT   \
>                                      : paravirt_type(op),               \
>                                        paravirt_clobber(clbr),          \
>                                        ##__VA_ARGS__                    \
>                                      : "memory", "cc" extra_clbr);      \
>
> With some extra magic for the constraints.  And I don't even think
> this is strictly correct -- from very recent experience, telling the
> compiler that "memory" is clobbered and that a bunch of arguments are
> used as numeric inputs may not actually imply that the asm modifies
> the target of pointer arguments.  Checks this lovely bug out:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=
=3Dx86/vdso-tglx&id=3D715bd9d12f84d8f5cc8ad21d888f9bc304a8eb0b
>
> As far as I can tell, the whole PVOP infrastructure has the same bug.
> And I don't see how to avoid it generically on x86 or any other
> architecture.  (PeterZ, am I wrong?  Are we really just getting lucky
> that x86 pvop calls actually work?  Or do we not have enough of them
> that take pointers as arguments for this to matter?)
>
> Plus, asm volatile ( ..., "memory" ) is a barrier and makes code
> generation suck.
>
> Whereas, if we use my suggestion the semantics are precisely those of
> any other C function call because, as far as GCC is concerned, it *is*
> a C function call.  So the generated code *is* a function call.
>

But it is the *compiler* that actually emits the call.

Only, the target of that call is a jmpq to another location where some
version of the routine lives, and all have the same prototype.

How is that any different from PLTs in shared libraries?
