Return-Path: <srs0=k9ms=5l=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whh2d0VdQzDqL1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 16:03:53 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3whh2c6rfzz8t8v
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 16:03:52 +1000 (AEST)
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3whh2b6PfBz9s0Z
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Jun 2017 16:03:51 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id x58so13980295qtc.2
 for <linuxppc-dev@ozlabs.org>; Mon, 05 Jun 2017 23:03:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496728137-19655-1-git-send-email-mpe@ellerman.id.au>
References: <1496728137-19655-1-git-send-email-mpe@ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 6 Jun 2017 16:03:49 +1000
Message-ID: <CAKTCnzmUPUBP_NQjzcUO_z+iVtn_ArwHpzWToGYvQVV-zjoB7w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm/radix: Only add X for pages overlapping kernel
 text
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 6, 2017 at 3:48 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Currently we map the whole linear mapping with PAGE_KERNEL_X. Instead we
> should check if the page overlaps the kernel text and only then add
> PAGE_KERNEL_X.
>
> Note that we still use 1G pages if they're available, so this will
> typically still result in a 1G executable page at KERNELBASE. So this fix is
> primarily useful for catching stray branches to high linear mapping addresses.
>
> Without this patch, we can execute at 1G in xmon using:
>
>   0:mon> m c000000040000000
>   c000000040000000  00 l
>   c000000040000000  00000000 01006038
>   c000000040000004  00000000 2000804e
>   c000000040000008  00000000 x
>   0:mon> di c000000040000000
>   c000000040000000  38600001      li      r3,1
>   c000000040000004  4e800020      blr
>   0:mon> p c000000040000000
>   return value is 0x1
>
> After we get a 400 as expected:
>
>   0:mon> p c000000040000000
>   *** 400 exception occurred
>
> Fixes: 2bfd65e45e87 ("powerpc/mm/radix: Add radix callbacks for early init routines")
> Cc: stable@vger.kernel.org # v4.7+
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index c28165d8970b..6c062f92b9e4 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -19,6 +19,7 @@
>  #include <asm/mmu.h>
>  #include <asm/firmware.h>
>  #include <asm/powernv.h>
> +#include <asm/sections.h>
>
>  #include <trace/events/thp.h>
>
> @@ -121,7 +122,8 @@ static inline void __meminit print_mapping(unsigned long start,
>  static int __meminit create_physical_mapping(unsigned long start,
>                                              unsigned long end)
>  {
> -       unsigned long addr, mapping_size = 0;
> +       unsigned long vaddr, addr, mapping_size = 0;
> +       pgprot_t prot;
>
>         start = _ALIGN_UP(start, PAGE_SIZE);
>         for (addr = start; addr < end; addr += mapping_size) {
> @@ -145,8 +147,14 @@ static int __meminit create_physical_mapping(unsigned long start,
>                         start = addr;
>                 }
>
> -               rc = radix__map_kernel_page((unsigned long)__va(addr), addr,
> -                                           PAGE_KERNEL_X, mapping_size);
> +               vaddr = (unsigned long)__va(addr);
> +
> +               if (overlaps_kernel_text(vaddr, vaddr + mapping_size))
> +                       prot = PAGE_KERNEL_X;
> +               else
> +                       prot = PAGE_KERNEL;

Do we need the kvm tmp/trampoline bits like hash?

Balbir Singh.
