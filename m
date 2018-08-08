Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lnlC2XfyzDqhV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 20:32:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 npiggin@gmail.com <npiggin@gmail.com>
Subject: Re: Build regressions/improvements in v4.17-rc1
In-Reply-To: <20180806155440.9dcb271a3b075bd964aec60f@linux-foundation.org>
References: <1523884165-17044-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXxV1nWGWAAXSkBWm-9VWHVc57nhFLfQ4BijbKGh-vaUQ@mail.gmail.com>
 <20180806155440.9dcb271a3b075bd964aec60f@linux-foundation.org>
Date: Wed, 08 Aug 2018 20:32:37 +1000
Message-ID: <87lg9hb12y.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton <akpm@linux-foundation.org> writes:
> On Mon, 6 Aug 2018 12:39:21 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>> CC Dan, Michael, AKPM, powerpc
>> 
>> On Mon, Apr 16, 2018 at 3:10 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > Below is the list of build error/warning regressions/improvements in
>> > v4.17-rc1[1] compared to v4.16[2].
>> 
>> I'd like to point your attention to:
>> 
>> >   + warning: vmlinux.o(.text+0x376518): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
>> >   + warning: vmlinux.o(.text+0x376d64): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
>
> hm.  Dan isn't around at present so we're on our own with this one.
>
> x86 doesn't put arch_add_memory and arch_remove_memory into __meminit. 
> x86 does
>
> #ifdef CONFIG_MEMORY_HOTPLUG
> int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
> 		bool want_memblock)
> {
> 	...
>
>
> So I guess powerpc should do that as well?

But we only recently added it to fix a section mismatch warning:

  WARNING: vmlinux.o(.text+0x6da88): Section mismatch in reference from the function .arch_add_memory() to the function .meminit.text:.create_section_mapping()
  The function .arch_add_memory() references
  the function __meminit .create_section_mapping().
  This is often because .arch_add_memory lacks a __meminit 
  annotation or the annotation of .create_section_mapping is wrong.


I think the problem is that the section mismatch logic isn't able to
cope with __meminit's changing semantics.

When CONFIG_MEMORY_HOTPLUG=y references from .text to .meminit.text
should be allowed, because they're just folded in together in the linker
script.

When CONFIG_MEMORY_HOTPLUG=n references from .text to .meminit.text
should NOT be allowed, because .meminit.text becomes .init.text and will
be freed.

I don't see anything in the section mismatch logic to cope with that
difference.

It looks like __meminit is saving us about 1K on powerpc, so I'm
strongly inclined to just remove it entirely from arch/powerpc.

Also I haven't been seeing this in my local builds because I have:

CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y

So I guess we need to work out why that's interfering with section
mismatch analysis.

cheers
