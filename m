Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCtVV1wC8zDqhB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jan 2018 05:29:12 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id 87so6654695ior.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jan 2018 10:29:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180105182229.pjnlq3l5hzfac4na@armageddon.cambridge.arm.com>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-8-ard.biesheuvel@linaro.org>
 <20180105175834.vqgpsme7itsdg54u@armageddon.cambridge.arm.com>
 <CAKv+Gu8zROE-TDpfbbVi3RPOr8BNcsN_s27Gr-VvMN+-eMU+Hg@mail.gmail.com>
 <20180105182229.pjnlq3l5hzfac4na@armageddon.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 5 Jan 2018 18:29:09 +0000
Message-ID: <CAKv+Gu9R=Dmog+omP0xAGmsBiH0rseHAVjob4VA5P3c7i4++hQ@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] kernel/jump_label: abstract jump_entry member
 accessors
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mips <linux-mips@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>, Nicolas Pitre <nico@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Petr Mladek <pmladek@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>, James Morris <james.l.morris@oracle.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 "David S. Miller" <davem@davemloft.net>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Jessica Yu <jeyu@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Thomas Garnier <thgarnie@google.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 5 January 2018 at 18:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Jan 05, 2018 at 06:01:33PM +0000, Ard Biesheuvel wrote:
>> On 5 January 2018 at 17:58, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Tue, Jan 02, 2018 at 08:05:46PM +0000, Ard Biesheuvel wrote:
>> >> diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
>> >> index e12d7d096fc0..7b05b404063a 100644
>> >> --- a/arch/arm/include/asm/jump_label.h
>> >> +++ b/arch/arm/include/asm/jump_label.h
>> >> @@ -45,5 +45,32 @@ struct jump_entry {
>> >>       jump_label_t key;
>> >>  };
>> >>
>> >> +static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
>> >> +{
>> >> +     return entry->code;
>> >> +}
>> >> +
>> >> +static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
>> >> +{
>> >> +     return (struct static_key *)((unsigned long)entry->key & ~1UL);
>> >> +}
>> >> +
>> >> +static inline bool jump_entry_is_branch(const struct jump_entry *entry)
>> >> +{
>> >> +     return (unsigned long)entry->key & 1UL;
>> >> +}
>> >> +
>> >> +static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
>> >> +{
>> >> +     return entry->code == 0;
>> >> +}
>> >> +
>> >> +static inline void jump_entry_set_module_init(struct jump_entry *entry)
>> >> +{
>> >> +     entry->code = 0;
>> >> +}
>> >> +
>> >> +#define jump_label_swap              NULL
>> >
>> > Is there any difference between these functions on any of the
>> > architectures touched? Even with the relative offset, arm64 and x86
>> > looked the same to me (well, I may have missed some detail).
>>
>> No, the latter two are identical everywhere, and the others are the
>> same modulo absolute vs relative.
>>
>> The issue is that the struct definition is per-arch so the accessors
>> should be as well.
>
> Up to this patch, even the jump_entry structure is the same on all
> architectures (the jump_label_t type differs).
>
> With relative offset, can you not just define jump_label_t to s32? At a
> quick grep in mainline, it doesn't seem to be used outside the structure
> definition.
>

I think we can just remove jump_label_t entirely, and replace it with
unsigned long for absolute, and s32 for relative. Maybe I am missing
something, but things like

#ifdef CONFIG_X86_64
typedef u64 jump_label_t;
#else
typedef u32 jump_label_t;
#endif

seem a bit pointless to me anyway.


>> Perhaps I should introduce two variants two asm-generic, similar to
>> how we have different flavors of unaligned accessors.
>
> You could as well define them directly in kernel/jump_label.h or, if
> used outside this file, include/linux/jump_label.h.
>

Perhaps I should define a Kconfig symbol after all for relative jump
labels, and just keep everything in the same file. The question is
whether I should use CONFIG_HAVE_ARCH_PREL32_RELOCATIONS for this as
well.
