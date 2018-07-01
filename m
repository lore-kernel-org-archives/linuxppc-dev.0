Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Jd1Z64kPzF1Hj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 03:39:46 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id q19-v6so5415975ioh.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Jul 2018 10:39:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627151510.GE30631@arm.com>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
 <20180627151510.GE30631@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 1 Jul 2018 19:39:43 +0200
Message-ID: <CAKv+Gu-dkVEtRmvZwiAUpxPSHrkTVvzeGhCwczEmxRjcgfd+LQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] add support for relative references in special
 sections
To: Thomas Gleixner <tglx@linutronix.de>,
 "the arch/x86 maintainers" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>,
 James Morris <jmorris@namei.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nicolas Pitre <nico@linaro.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27 June 2018 at 17:15, Will Deacon <will.deacon@arm.com> wrote:
> Hi Ard,
>
> On Tue, Jun 26, 2018 at 08:27:55PM +0200, Ard Biesheuvel wrote:
>> This adds support for emitting special sections such as initcall arrays,
>> PCI fixups and tracepoints as relative references rather than absolute
>> references. This reduces the size by 50% on 64-bit architectures, but
>> more importantly, it removes the need for carrying relocation metadata
>> for these sections in relocatable kernels (e.g., for KASLR) that needs
>> to be fixed up at boot time. On arm64, this reduces the vmlinux footprint
>> of such a reference by 8x (8 byte absolute reference + 24 byte RELA entry
>> vs 4 byte relative reference)
>>
>> Patch #3 was sent out before as a single patch. This series supersedes
>> the previous submission. This version makes relative ksymtab entries
>> dependent on the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS rather
>> than trying to infer from kbuild test robot replies for which architectures
>> it should be blacklisted.
>>
>> Patch #1 introduces the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS,
>> and sets it for the main architectures that are expected to benefit the
>> most from this feature, i.e., 64-bit architectures or ones that use
>> runtime relocations.
>>
>> Patch #2 add support for #define'ing __DISABLE_EXPORTS to get rid of
>> ksymtab/kcrctab sections in decompressor and EFI stub objects when
>> rebuilding existing C files to run in a different context.
>
> I had a small question on patch 3, but it's really for my understanding.
> So, for patches 1-3:
>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
>

Thanks all.

Thomas, Ingo,

Except for the below tweak against patch #3 for powerpc, which may
apparently get confused by an input section called .discard without
any suffixes, this series is good to go, but requires your ack to
proceed, so I would like to ask you to share your comments and/or
objections. Also, any suggestions or recommendations regarding the
route these patches should take are highly appreciated.

Ard.


diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 2d9c63f41031..61c844d4ab48 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -287,7 +287,7 @@ unsigned long read_word_at_a_time(const void *addr)
  * visible to the compiler.
  */
 #define __ADDRESSABLE(sym) \
-       static void * __attribute__((section(".discard"), used))        \
+       static void * __attribute__((section(".discard.addressable"), used)) \
                __PASTE(__addressable_##sym, __LINE__) = (void *)&sym;

 /**
