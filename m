Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zzjjz5jVtzDrSf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 01:12:22 +1100 (AEDT)
Received: by mail-io0-x243.google.com with SMTP id v10so1824233iob.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 07:12:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180311123815.17916-4-ard.biesheuvel@linaro.org>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
 <20180311123815.17916-4-ard.biesheuvel@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 11 Mar 2018 14:12:19 +0000
Message-ID: <CAKv+Gu-TMT5bJ9V69sNK+8_aHeqz6EQ0ugTsjCPgDgfb6_=xqg@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] module: use relative references for __ksymtab
 entries
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Nicolas Pitre <nico@linaro.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "the arch/x86 maintainers" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11 March 2018 at 12:38, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> An ordinary arm64 defconfig build has ~64 KB worth of __ksymtab
> entries, each consisting of two 64-bit fields containing absolute
> references, to the symbol itself and to a char array containing
> its name, respectively.
>
> When we build the same configuration with KASLR enabled, we end
> up with an additional ~192 KB of relocations in the .init section,
> i.e., one 24 byte entry for each absolute reference, which all need
> to be processed at boot time.
>
> Given how the struct kernel_symbol that describes each entry is
> completely local to module.c (except for the references emitted
> by EXPORT_SYMBOL() itself), we can easily modify it to contain
> two 32-bit relative references instead. This reduces the size of
> the __ksymtab section by 50% for all 64-bit architectures, and
> gets rid of the runtime relocations entirely for architectures
> implementing KASLR, either via standard PIE linking (arm64) or
> using custom host tools (x86).
>
> Note that the binary search involving __ksymtab contents relies
> on each section being sorted by symbol name. This is implemented
> based on the input section names, not the names in the ksymtab
> entries, so this patch does not interfere with that.
>
> Given that the use of place-relative relocations requires support
> both in the toolchain and in the module loader, we cannot enable
> this feature for all architectures. So make it dependent on whether
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS is defined.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thomas Garnier <thgarnie@google.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Acked-by: Jessica Yu <jeyu@kernel.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/x86/include/asm/Kbuild   |  1 +
>  arch/x86/include/asm/export.h |  5 ---
>  include/asm-generic/export.h  | 12 ++++-
>  include/linux/compiler.h      | 19 ++++++++
>  include/linux/export.h        | 46 +++++++++++++++-----
>  kernel/module.c               | 32 +++++++++++---
>  6 files changed, 91 insertions(+), 24 deletions(-)
>
...
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index ab4711c63601..0a9328ea9dbd 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -280,6 +280,25 @@ unsigned long read_word_at_a_time(const void *addr)
>
>  #endif /* __KERNEL__ */
>
> +/*
> + * Force the compiler to emit 'sym' as a symbol, so that we can reference
> + * it from inline assembler. Necessary in case 'sym' could be inlined
> + * otherwise, or eliminated entirely due to lack of references that are
> + * visible to the compiler.
> + */
> +#define __ADDRESSABLE(sym) \
> +       static void * const __attribute__((section(".discard"), used))  \
> +               __PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
> +

kernelci.org tells me that I need to drop the 'const' here, or we may
end up with .discard sections with conflicting attributes (r/o vs r/w)
in some cases (CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y)
