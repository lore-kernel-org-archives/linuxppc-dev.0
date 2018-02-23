Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znkF15v7yzF1km
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 19:01:07 +1100 (AEDT)
Subject: Re: [PATCH 0/5] PPC32/ioremap: Use memblock API to check for RAM
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>
References: <20180222121516.23415-1-j.neuschaefer@gmx.net>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <ca471c17-d2a7-e8e6-2d5a-a5a534e7e6d9@c-s.fr>
Date: Fri, 23 Feb 2018 09:01:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180222121516.23415-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/02/2018 à 13:15, Jonathan Neuschäfer a écrit :
> This patchset solves the same problem as my previous one[1] but follows
> a rather different approach. Instead of implementing DISCONTIGMEM for
> PowerPC32, I simply switched the "is this RAM" check in __ioremap_caller
> to the existing page_is_ram function, and unified page_is_ram to search
> memblock.memory on PPC64 and PPC32.
> 
> The intended result is, as before, that my Wii can allocate the MMIO
> range of its GPIO controller, which was previously not possible, because
> the reserved memory hack (__allow_ioremap_reserved) didn't affect the
> API in kernel/resource.c.
> 
> Thanks to Christophe Leroy for reviewing the previous patchset.

I tested your new serie, it doesn't break my 8xx so it is OK for me.

Christophe

> 
> [1]: https://www.spinics.net/lists/kernel/msg2726786.html
> 
> Jonathan Neuschäfer (5):
>    powerpc: mm: Simplify page_is_ram by using memblock_is_memory
>    powerpc: mm: Use memblock API for PPC32 page_is_ram
>    powerpc/mm/32: Use page_is_ram to check for RAM
>    powerpc: wii: Don't rely on the reserved memory hack
>    powerpc/mm/32: Remove the reserved memory hack
> 
>   arch/powerpc/mm/init_32.c                |  5 -----
>   arch/powerpc/mm/mem.c                    | 12 +-----------
>   arch/powerpc/mm/mmu_decl.h               |  1 -
>   arch/powerpc/mm/pgtable_32.c             |  4 +---
>   arch/powerpc/platforms/embedded6xx/wii.c | 14 +-------------
>   5 files changed, 3 insertions(+), 33 deletions(-)
> 
