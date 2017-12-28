Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z6q6p1m46zDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Dec 2017 23:39:42 +1100 (AEDT)
Received: by mail-io0-x242.google.com with SMTP id x67so32092733ioi.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Dec 2017 04:39:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228120531.xhcb4dg2qu2z5ssp@gmail.com>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-3-ard.biesheuvel@linaro.org>
 <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
 <CAKv+Gu-2NUzsakN2rcM_5fqD0ubr+6ZXSc+5sjZZPbU3wj_Xsg@mail.gmail.com>
 <CA+55aFzygF6P3v5VxyBucZfn-tg58jeV6qwt0y7QGmmNiKYghQ@mail.gmail.com>
 <CAKv+Gu-wRtfnGfrEjuxR5YkCpZM-nQHZShROEdbcEh=fSiWf5A@mail.gmail.com>
 <20171228120531.xhcb4dg2qu2z5ssp@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 28 Dec 2017 12:39:39 +0000
Message-ID: <CAKv+Gu_D+eYoFCuEt=boim=kdVd2WGcBsC-3nSZawwFp-gqKKQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] module: use relative references for __ksymtab
 entries
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>,
 Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>,
 Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nicolas Pitre <nico@linaro.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Jessica Yu <jeyu@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mips <linux-mips@linux-mips.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 sparclinux@vger.kernel.org, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28 December 2017 at 12:05, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> Annoyingly, we need this because there is a single instance of a
>> special section that ends up in the EFI stub code: we build lib/sort.c
>> again as a EFI libstub object, and given that sort() is exported, we
>> end up with a ksymtab section in the EFI stub. The sort() thing has
>> caused issues before [0], so perhaps I should just clone sort.c into
>> drivers/firmware/efi/libstub and get rid of that hack.
>>
>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29f9007b3182ab3f328a31da13e6b1c9072f7a95
>
> If the root problem is early bootstrap code randomly using generic facility that
> isn't __init, then we should definitely improve tooling to at least detect these
> problems.
>
> As bootstrap code gets improved (KASLR, more complex decompression, etc. etc.) we
> keep using new bits of generic facilities...
>
> So this should definitely not be hidden by open coding that function (which has
> various other disadvantages as well), but should be turned from silent breakage
> either into non-breakage (and do so not only for sort() but for other generic
> functions as well), or should be turned into a build failure.
>

We already have safeguards in place to ensure that the arm64 EFI stub
(which is essentially the same executable as the kernel proper) only
pulls in code that has been made available to it explicitly. That is
why sort.c is recompiled for the EFI stub, as well as all other C code
that is shared between the stub and the kernel. We also have a build
time check to ensure that the resulting code does not rely on absolute
symbol references, which will be invalid in the UEFI execution
context.

So the only problem is that unneeded ksymtab/kcrctab sections, which
affected ARM for obscure reasons; typically, they just take up some
space. On x86, the kaslr code deals with a similar issue by
#define'ing _LINUX_EXPORT_H before including linux/export.h, which
also gets rid of these sections, but I was a bit reluctant to copy
that pattern. Perhaps we should enhance linux/export.h for reasons
such as these by adding a macro that nops out EXPORT_SYMBOL()
declarations?
