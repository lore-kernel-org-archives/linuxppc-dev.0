Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z6PBL0zn6zDqGw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Dec 2017 07:11:21 +1100 (AEDT)
Received: by mail-it0-x243.google.com with SMTP id d16so26652485itj.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Dec 2017 12:11:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-3-ard.biesheuvel@linaro.org>
 <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 27 Dec 2017 20:11:19 +0000
Message-ID: <CAKv+Gu-2NUzsakN2rcM_5fqD0ubr+6ZXSc+5sjZZPbU3wj_Xsg@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] module: use relative references for __ksymtab
 entries
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
 sparclinux@vger.kernel.org, "the arch/x86 maintainers" <x86@kernel.org>,
 Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27 December 2017 at 20:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Dec 27, 2017 at 12:50 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>> index 52e611ab9a6c..fe752d365334 100644
>> --- a/include/linux/compiler.h
>> +++ b/include/linux/compiler.h
>> @@ -327,4 +327,15 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
>>         compiletime_assert(__native_word(t),                            \
>>                 "Need native word sized stores/loads for atomicity.")
>>
>> +/*
>> + * Force the compiler to emit 'sym' as a symbol, so that we can reference
>> + * it from inline assembler. Necessary in case 'sym' could be inlined
>> + * otherwise, or eliminated entirely due to lack of references that are
>> + * visibile to the compiler.
>> + */
>> +#define __ADDRESSABLE(sym) \
>> +       static void *__attribute__((section(".discard.text"), used))    \
>> +               __PASTE(__discard_##sym, __LINE__)(void)                \
>> +                       { return (void *)&sym; }                        \
>> +
>>  #endif /* __LINUX_COMPILER_H */
>
> Isn't this logically the point where you should add the arm64
> vmlinux.lds.S change, and explain how ".discard.text" turns into
> ".init.discard.text" for some odd arm64 reason?
>

I tried to keep the generic patches generic, so perhaps I should just
put the arm64 vmlinux.lds.S change in a patch on its own?
