Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zB9sm6qj2zDqpb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 10:55:08 +1100 (AEDT)
Received: by mail-it0-x241.google.com with SMTP id b5so1688itc.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jan 2018 15:55:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1801021841410.8567@knanqh.ubzr>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-3-ard.biesheuvel@linaro.org>
 <nycvar.YSQ.7.76.1801021841410.8567@knanqh.ubzr>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 2 Jan 2018 23:55:05 +0000
Message-ID: <CAKv+Gu9x+DeOdMn1CuEDNHtLSi1_cFpx7ZyxMYVGht0qBastmw@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] module: allow symbol exports to be disabled
To: Nicolas Pitre <nicolas.pitre@linaro.org>
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
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mips <linux-mips@linux-mips.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 sparclinux@vger.kernel.org, "the arch/x86 maintainers" <x86@kernel.org>,
 Matt Fleming <matt@codeblueprint.co.uk>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2 January 2018 at 23:47, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 2 Jan 2018, Ard Biesheuvel wrote:
>
>> To allow existing C code to be incorporated into the decompressor or
>> the UEFI stub, introduce a CPP macro that turns all EXPORT_SYMBOL_xxx
>> declarations into nops, and #define it in places where such exports
>> are undesirable. Note that this gets rid of a rather dodgy redefine
>> of linux/export.h's header guard.
> [...]
>
>> --- a/include/linux/export.h
>> +++ b/include/linux/export.h
>> @@ -83,6 +83,15 @@ extern struct module __this_module;
>>   */
>>  #define __EXPORT_SYMBOL(sym, sec)    === __KSYM_##sym ===
>>
>> +#elif defined(__DISABLE_EXPORTS)
>> +
>> +/*
>> + * Allow symbol exports to be disabled completely so that C code may
>> + * be reused in other execution contexts such as the UEFI stub or the
>> + * decompressor.
>> + */
>> +#define __EXPORT_SYMBOL(sym, sec)
>> +
>
> I think you should rather put this first thing in the #if sequence so to
> override the defined(__KSYM_DEPS__) case too.  No need to create build
> dependencies for module symbols that you're going to stub out
> afterwards anyway.
>

I wasn't sure, so thanks for clearing that up.
