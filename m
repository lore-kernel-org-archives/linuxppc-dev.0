Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86629C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:19:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E929C2054F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8KocMer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E929C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RdMT4s3BzF3bW
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 04:19:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R8KocMer";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::d44; helo=mail-io1-xd44.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="R8KocMer"; 
 dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Rbs50mcGzF3cX
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 03:11:52 +1000 (AEST)
Received: by mail-io1-xd44.google.com with SMTP id w11-v6so11223928iob.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SUr6zJI2whow9x9OpfHeIW8md/b4SvoCH3/Fc0VhBmQ=;
 b=R8KocMernaUgA69CSl7qi7imAZ/PnvUkkkfoaBsvsyjzPPtfOdE5cMFNngiEAtE/8I
 1gLVxXorDnxPeEj2uFZoVuGIAC1NY//ifOWIFo/d7hcd8OGw+9pHPeQ9hOzwYTm6pin4
 4DrTwSeGDEIZ2K55goesymYKpRFvz2A6RvC/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SUr6zJI2whow9x9OpfHeIW8md/b4SvoCH3/Fc0VhBmQ=;
 b=h7XCpvKK2+n98SyxWs+sglTIqVtJkbwId5AondOVZyawy68ew6btjPJnpn+ydYf9MT
 BTAQKodju52GHUYMm54jvZcbOxkCTEX6K3DskFJMIw4FZM/ASI/7Atz/AascwerCaSQN
 KGHRam1YcoyV6pyraJeaiwigyWOMwS+oIReM02ZF5OpkEl1j31+QqY01iRE+aKSyNB51
 RjAkj0Ae0njhiA1fbawXwfbcpQ3KwS779XfYUrRDTqmMAUNNabGoa0GJMhp7/29K+9RA
 V+ajdJsGA+7TA3jJAAdSGUfJPVOlR4Pr/lKH7DFxe6Cw+3ljn3Q9NLEU2ivESTzHkdHy
 Wa4Q==
X-Gm-Message-State: ABuFfoiEozYjqGoP34M2Jux9ka8U2R3dlNuRRWY4Zsg/zxwa9BxdkUXq
 EBj64XpbQFV2JdB3yod19nzf9CzPY/0We6ExsN9SIQ==
X-Google-Smtp-Source: ACcGV62Ohy9AkvBD8HNOxWTgfhC9qm/SZXxzbjciaPgMyHsIOiSZJIq7pDu9YI3s9Su2J0V82w4I+ekrPio0M3URhwo=
X-Received: by 2002:a6b:5d12:: with SMTP id
 r18-v6mr8485187iob.170.1538759510568; 
 Fri, 05 Oct 2018 10:11:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP;
 Fri, 5 Oct 2018 10:11:49 -0700 (PDT)
In-Reply-To: <CALCETrWaewXsdJsf3SocgZ0ggnvZk86L+5-LWPRbjdnG2mB7jw@mail.gmail.com>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org>
 <20181005141433.GS19272@hirez.programming.kicks-ass.net>
 <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net>
 <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com>
 <CALCETrWaewXsdJsf3SocgZ0ggnvZk86L+5-LWPRbjdnG2mB7jw@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 5 Oct 2018 19:11:49 +0200
Message-ID: <CAKv+Gu-oHBtgGbWXJu6+z4+BNhBZyY5VvF_v6cJJUGk_5YX1eQ@mail.gmail.com>
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

On 5 October 2018 at 18:58, Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Oct 5, 2018 at 8:24 AM Ard Biesheuvel <ard.biesheuvel@linaro.org>=
 wrote:
>>
>> On 5 October 2018 at 17:08, Andy Lutomirski <luto@amacapital.net> wrote:
>> >
>> >
>> >> On Oct 5, 2018, at 7:14 AM, Peter Zijlstra <peterz@infradead.org> wro=
te:
>> >>
>> >>> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
>> >>> diff --git a/include/linux/ffp.h b/include/linux/ffp.h
>> >>> new file mode 100644
>> >>> index 000000000000..8fc3b4c9b38f
>> >>> --- /dev/null
>> >>> +++ b/include/linux/ffp.h
>> >>> @@ -0,0 +1,43 @@
>> >>> +/* SPDX-License-Identifier: GPL-2.0 */
>> >>> +
>> >>> +#ifndef __LINUX_FFP_H
>> >>> +#define __LINUX_FFP_H
>> >>> +
>> >>> +#include <linux/types.h>
>> >>> +#include <linux/compiler.h>
>> >>> +
>> >>> +#ifdef CONFIG_HAVE_ARCH_FFP
>> >>> +#include <asm/ffp.h>
>> >>> +#else
>> >>> +
>> >>> +struct ffp {
>> >>> +    void    (**fn)(void);
>> >>> +    void    (*default_fn)(void);
>> >>> +};
>> >>> +
>> >>> +#define DECLARE_FFP(_fn, _def)                        \
>> >>> +    extern typeof(_def) *_fn;                    \
>> >>> +    extern struct ffp const __ffp_ ## _fn
>> >>> +
>> >>> +#define DEFINE_FFP(_fn, _def)                        \
>> >>> +    typeof(_def) *_fn =3D &_def;                    \
>> >>> +    struct ffp const __ffp_ ## _fn                    \
>> >>> +        =3D { (void(**)(void))&_fn, (void(*)(void))&_def };    \
>> >>> +    EXPORT_SYMBOL(__ffp_ ## _fn)
>> >>> +
>> >>> +static inline void ffp_set_target(const struct ffp *m, void *new_fn=
)
>> >>> +{
>> >>> +    WRITE_ONCE(*m->fn, new_fn);
>> >>> +}
>> >>> +
>> >>> +static inline void ffp_reset_target(const struct ffp *m)
>> >>> +{
>> >>> +    WRITE_ONCE(*m->fn, m->default_fn);
>> >>> +}
>> >>> +
>> >>> +#endif
>> >>> +
>> >>> +#define SET_FFP(_fn, _new)    ffp_set_target(&__ffp_ ## _fn, _new)
>> >>> +#define RESET_FFP(_fn)        ffp_reset_target(&__ffp_ ## _fn)
>> >>> +
>> >>> +#endif
>> >>
>> >> I don't understand this interface. There is no wrapper for the call
>> >> site, so how are we going to patch all call-sites when you update the
>> >> target?
>> >
>> > I=E2=80=99m also confused.
>> >
>> > Anyway, we have patchable functions on x86. They=E2=80=99re called PVO=
Ps, and they=E2=80=99re way overcomplicated.
>> >
>> > I=E2=80=99ve proposed a better way that should generate better code, b=
e more portable, and be more maintainable.  It goes like this.
>> >
>> > To call the function, you literally just call  the default implementat=
ion.  It *might* be necessary to call a nonexistent wrapper to avoid annoyi=
ng optimizations. At build time, the kernel is built with relocations, so t=
he object files contain relocation entries for the call. We collect these e=
ntries into a table. If we=E2=80=99re using the =E2=80=9Cnonexistent wrappe=
r=E2=80=9D approach, we can link in a .S or linker script to alias them to =
the default implementation.
>> >
>> > To patch them, we just patch them. It can=E2=80=99t necessarily be don=
e concurrently because nothing forces the right alignment. But we can do it=
 at boot time and module load time. (Maybe we can patch at runtime on archi=
tectures with appropriate instruction alignment.  Or we ask gcc for an exte=
nsion to align calls to a function.)
>> >
>> > Most of the machinery already exists: this is roughly how the module l=
oader resolves calls outside of a module.
>>
>> Yeah nothing is ever simple on x86 :-(
>>
>> So are you saying the approach i use in patch #2 (which would
>> translate to emitting a jmpq instruction pointing to the default
>> implementation, and patching it at runtime to point elsewhere) would
>> not fly on x86?
>
> After getting some more sleep, I'm obviously wrong.  The
> text_poke_bp() mechanism will work.  It's just really slow.
>

OK

> Let me try to summarize some of the issues.  First, when emitting
> jumps and calls from inline asm on x86, there are a few considerations
> that are annoying:
>
> 1. Following the x86_64 ABI calling conventions is basically
> impossible.  x86_64 requires a 128-byte redzone and 16-byte stack
> alignment.  After much discussion a while back, we decided that it was
> flat-out impossible on current gcc to get the stack pointer aligned in
> a known manner in an inline asm statement.  Instead, if we actually
> need alignment, we need to align manually.  Fortunately, the kernel is
> built with an override that forces only 8-byte alignment (on *most*
> GCC versions).  But for crypto in particular, it sucks extra, since
> the crypto code is basically the only thing in the kernel that
> actually wants 16-byte alignment.  I don't think this is a huge
> problem in practice, but it's annoying.  And the kernel is built
> without a redzone.
>
> 2. On x86_64, depending on config, we either need frame pointers or
> ORC.  ORC is no big deal -- it Just Works (tm).  Frame pointers need
> extra asm hackery.  It's doable, but it's still annoying.
>
> 3. Actually getting the asm constraints right to do what a C
> programmer expects is distinctly nontrivial.  I just fixed an
> extremely longstanding bug in the vDSO code in which the asm
> constraints for the syscall fallback were wrong in such a way that GCC
> didn't notice that the fallback wrote to its output parameter.
> Whoops.
>

OK, so the thing I am missing is why this all matters.

Note that the compiler should take care of all of this. It emits a
call a function with external linkage having prototype X, and all the
inline asm does is emit a jmp to some function having that same
prototype, either the default one or the one we patched in.

Apologies if I am missing something obvious here: as you know, x86 is
not my focus in general.

So in the arm64 case, we have

    " .globl " #_fn " \n" \
    #_fn " : \n" \
    " b " #_def " \n" \
    " nop \n" \
    " nop \n" \
    " nop \n" \
    " nop \n" \

and all the patching does is replace the target of that branch (the
NOPs are there for jumps that are more then 128 MB away, which require
a indirect jump on arm64)

> And having all this asm hackery per architecture is ugly and annoying.
>

True. But note that only the architectures that cannot tolerate the
default instantiation using function pointers will require a special
implementation.

> So my suggestion is to do it like a regular relocation.  Call a
> function the normal way (make it literally be a C function and call
> it), and rig up the noinline and noclone attributes and whatever else
> is needed to make sure that it's a *relocatable* call.  Then the
> toolchain emits ELF relocations saying exactly what part of the text
> needs patching, and we can patch it at runtime.  On x86, this is a bit
> extra annoying because we can't fully reliably parse backwards to find
> the beginning of the instruction, but objtool could doit.
>
> And then we get something that is mostly arch-neutral!  Because surely
> ARM can also use a relocation-based mechanism.
>

Not really. We don't have any build time tooling for this, and
CONFIG_RELOCATABLE only produces R_AARCH64_RELATIVE relocations for
absolute quantities.

So it would mean we'd have to start building vmlinux with
--emit-relocs, add tooling to parse all of that etc etc.

> I will generally object to x86 containing more than one
> inline-asm-hackery-based patchable call mechanism, which your series
> will add.  I would *love* to see a non-inline-asm one, and then we
> could move most of the x86 paravirt crap over to use it for a big win
> in readability and maintainability.
>

Fair enough.
