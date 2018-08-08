Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lqNK1hclzDqhV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 21:46:25 +1000 (AEST)
Received: by mail-oi0-f54.google.com with SMTP id m11-v6so3209152oic.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Aug 2018 04:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <1523884165-17044-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXxV1nWGWAAXSkBWm-9VWHVc57nhFLfQ4BijbKGh-vaUQ@mail.gmail.com>
 <20180806155440.9dcb271a3b075bd964aec60f@linux-foundation.org>
 <87lg9hb12y.fsf@concordia.ellerman.id.au>
In-Reply-To: <87lg9hb12y.fsf@concordia.ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 8 Aug 2018 13:46:10 +0200
Message-ID: <CA+7wUszFS8n+TBs54ez_5hhESN1J0DS0x200Qp7zYtheWMO34g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.17-rc1
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 8, 2018 at 12:34 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Andrew Morton <akpm@linux-foundation.org> writes:
> > On Mon, 6 Aug 2018 12:39:21 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> >> CC Dan, Michael, AKPM, powerpc
> >>
> >> On Mon, Apr 16, 2018 at 3:10 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> > Below is the list of build error/warning regressions/improvements in
> >> > v4.17-rc1[1] compared to v4.16[2].
> >>
> >> I'd like to point your attention to:
> >>
> >> >   + warning: vmlinux.o(.text+0x376518): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
> >> >   + warning: vmlinux.o(.text+0x376d64): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
> >
> > hm.  Dan isn't around at present so we're on our own with this one.
> >
> > x86 doesn't put arch_add_memory and arch_remove_memory into __meminit.
> > x86 does
> >
> > #ifdef CONFIG_MEMORY_HOTPLUG
> > int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
> >               bool want_memblock)
> > {
> >       ...
> >
> >
> > So I guess powerpc should do that as well?
>
> But we only recently added it to fix a section mismatch warning:
>
>   WARNING: vmlinux.o(.text+0x6da88): Section mismatch in reference from the function .arch_add_memory() to the function .meminit.text:.create_section_mapping()
>   The function .arch_add_memory() references
>   the function __meminit .create_section_mapping().
>   This is often because .arch_add_memory lacks a __meminit
>   annotation or the annotation of .create_section_mapping is wrong.
>
>
> I think the problem is that the section mismatch logic isn't able to
> cope with __meminit's changing semantics.
>
> When CONFIG_MEMORY_HOTPLUG=y references from .text to .meminit.text
> should be allowed, because they're just folded in together in the linker
> script.
>
> When CONFIG_MEMORY_HOTPLUG=n references from .text to .meminit.text
> should NOT be allowed, because .meminit.text becomes .init.text and will
> be freed.
>
> I don't see anything in the section mismatch logic to cope with that
> difference.
>
> It looks like __meminit is saving us about 1K on powerpc, so I'm
> strongly inclined to just remove it entirely from arch/powerpc.
>
> Also I haven't been seeing this in my local builds because I have:
>
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y
>
> So I guess we need to work out why that's interfering with section
> mismatch analysis.

...

Well that's a good question actually. Section mismatch
analysis is done on the throwaway vmlinux.o which is not linked
with --gc-sections (and is not a final link), so the via_pmu_driver
symbol should exist and be picked up.

I wonder if something about the  -ffunction-sections is breaking
the reference detection.
...



ref:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg135431.html

>
> cheers
