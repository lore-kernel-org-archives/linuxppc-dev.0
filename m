Return-Path: <keescook@google.com>
Received: from mail-vc0-x22b.google.com (mail-vc0-x22b.google.com
 [IPv6:2607:f8b0:400c:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C6191A0279
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 05:03:26 +1100 (AEDT)
Received: by mail-vc0-f171.google.com with SMTP id hy10so4480905vcb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2015 10:03:23 -0800 (PST)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20150303073132.GA30602@gmail.com>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <20150303073132.GA30602@gmail.com>
Date: Tue, 3 Mar 2015 10:03:22 -0800
Message-ID: <CAGXu5j+qJLeRx2xx=890OxHp8kjd=ws8zg3_JYPNJd_6p2xoYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] split ET_DYN ASLR from mmap ASLR
From: Kees Cook <keescook@chromium.org>
To: Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Arun Chandran <achandran@mvista.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Yann Droneaud <ydroneaud@opteya.com>,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>, "x86@kernel.org" <x86@kernel.org>,
 Hector Marco-Gisbert <hecmargi@upv.es>, "David A. Long" <dave.long@linaro.org>,
 Borislav Petkov <bp@suse.de>, Ben Hutchings <ben@decadent.org.uk>,
 Will Deacon <will.deacon@arm.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jeff Bailey <jeffbailey@google.com>, Paul Burton <paul.burton@imgtec.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 Andy Lutomirski <luto@amacapital.net>, Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Alex Smith <alex@alex-smith.me.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 2, 2015 at 11:31 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kees Cook <keescook@chromium.org> wrote:
>
>> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
>> ASLR from mmap ASLR, as already done on s390. The architectures
>> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
>> and x86), have their various forms of arch_mmap_rnd() made available
>> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
>> arch_randomize_brk() is collapsed as well.
>>
>> This is an alternative to the solutions in:
>> https://lkml.org/lkml/2015/2/23/442
>
> Looks good so far:
>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
>
> While reviewing this series I also noticed that the following code
> could be factored out from architecture mmap code as well:
>
>   - arch_pick_mmap_layout() uses very similar patterns across the
>     platforms, with only few variations. Many architectures use
>     the same duplicated mmap_is_legacy() helper as well. There's
>     usually just trivial differences between mmap_legacy_base()
>     approaches as well.

I was nervous to start refactoring this code, but it's true: most of
it is the same.

>   - arch_mmap_rnd(): the PF_RANDOMIZE checks are needlessly
>     exposed to the arch routine - the arch routine should only
>     concentrate on arch details, not generic flags like
>     PF_RANDOMIZE.

Yeah, excellent point. I will send a follow-up patch to move this into
binfmt_elf instead. I'd like to avoid removing it in any of the other
patches since each was attempting a single step in the refactoring.

> In theory the mmap layout could be fully parametrized as well: i.e. no
> callback functions to architectures by default at all: just
> declarations of bits of randomization desired (or, available address
> space bits), and perhaps an arch helper to allow 32-bit vs. 64-bit
> address space distinctions.

Yeah, I was considering that too, since each architecture has a nearly
identical arch_mmap_rnd() at this point. Only the size of the entropy
was changing.

> 'Weird' architectures could provide special routines, but only by
> overriding the default behavior, which should be generic, safe and
> robust.

Yeah, quite true. Should entropy size be a #define like
ELF_ET_DYN_BASE? Something like ASLR_MMAP_ENTROPY and
ASLR_MMAP_ENTROPY_32? Is there a common function for determining a
compat task? That seemed to be per-arch too. Maybe
arch_mmap_entropy()?

-Kees

-- 
Kees Cook
Chrome OS Security
