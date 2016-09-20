Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdjhs5zJ1zDsfv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 23:07:25 +1000 (AEST)
In-Reply-To: <1473916319-27736-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anton@samba.org
Subject: Re: powerpc: Ensure .mem(init|exit).text are within _stext/_etext
Message-Id: <3sdjhs3wQFz9t0t@ozlabs.org>
Date: Tue, 20 Sep 2016 23:07:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-15-09 at 05:11:59 UTC, Michael Ellerman wrote:
> In our linker script we open code the list of text sections, because we
> need to include the __ftr_alt sections, which are arch-specific.
> 
> This means we can't use TEXT_TEXT as defined in vmlinux.lds.h, and so we
> don't have the MEM_KEEP() logic for memory hotplug sections.
> 
> If we build the kernel with the gold linker, and with CONFIG_MEMORY_HOTPLUG=y,
> we see that functions marked __meminit can end up outside of the
> _stext/_etext range, and also outside of _sinittext/_einittext, eg:
> 
>     c000000000000000 T _stext
>     c0000000009e0000 A _etext
>     c0000000009e3f18 T hash__vmemmap_create_mapping
>     c000000000ca0000 T _sinittext
>     c000000000d00844 T _einittext
> 
> This causes them to not be recognised as text by is_kernel_text(), and
> prevents them being patched by jump_label (and presumably ftrace/kprobes
> etc.).
> 
> Fix it by adding MEM_KEEP() directives, mirroring what TEXT_TEXT does.
> 
> This isn't a problem when CONFIG_MEMORY_HOTPLUG=n, because we use the
> standard INIT_TEXT_SECTION() and EXIT_TEXT macros from vmlinux.lds.h.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Tested-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/7de3b27bac47da9de08409df1d

cheers
