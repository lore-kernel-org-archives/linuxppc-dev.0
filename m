Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 171CB1A1D9D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:55:10 +1000 (AEST)
Message-ID: <1439794492.2416.8.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH V1 0/8] KASAN ppc64 support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Aug 2015 16:54:52 +1000
In-Reply-To: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-08-17 at 12:06 +0530, Aneesh Kumar K.V wrote:
> Hi,
> 
> This patchset implements kernel address sanitizer for ppc64.
> Since ppc64 virtual address range is divided into different regions,
> we can't have one contigous area for the kasan shadow range. Hence
> we don't support the INLINE kasan instrumentation. With Outline
> instrumentation, we override the shadow_to_mem and mem_to_shadow
> callbacks, so that we map only the kernel linear range (ie,
> region with ID 0xc). For region with ID 0xd and 0xf (vmalloc
> and vmemmap ) we return the address of the zero page. This
> works because kasan doesn't track both vmemmap and vmalloc address.
So bear with me, I don't know anything about KASAN, but if you want a
shadow, can't you just add a fixed offset to the address and thus
effectively shadow each region independently while keeping the inline
helpers ?

Cheers,
Ben.

> Aneesh Kumar K.V (8):
>   powerpc/mm: Add virt_to_pfn and use this instead of opencoding
>   kasan: MODULE_VADDR is not available on all archs
>   kasan: Rename kasan_enabled to kasan_report_enabled
>   kasan: Don't use kasan shadow pointer in generic functions
>   kasan: Enable arch to hook into kasan callbacks.
>   kasan: Allow arch to overrride kasan shadow offsets
>   powerpc/mm: kasan: Add kasan support for ppc64
>   powerpc: Disable kasan for kernel/ and mm/ directory
> 
> -aneesh
> 
>  arch/powerpc/include/asm/kasan.h         | 74 
> ++++++++++++++++++++++++++++++++
>  arch/powerpc/include/asm/page.h          |  5 ++-
>  arch/powerpc/include/asm/pgtable-ppc64.h |  1 +
>  arch/powerpc/include/asm/ppc_asm.h       | 10 +++++
>  arch/powerpc/include/asm/string.h        | 13 ++++++
>  arch/powerpc/kernel/Makefile             |  2 +
>  arch/powerpc/kernel/prom_init_check.sh   |  2 +-
>  arch/powerpc/kernel/setup_64.c           |  3 ++
>  arch/powerpc/lib/mem_64.S                |  6 ++-
>  arch/powerpc/lib/memcpy_64.S             |  3 +-
>  arch/powerpc/lib/ppc_ksyms.c             | 10 +++++
>  arch/powerpc/mm/Makefile                 |  4 ++
>  arch/powerpc/mm/kasan_init.c             | 44 +++++++++++++++++++
>  arch/powerpc/mm/slb_low.S                |  4 ++
>  arch/powerpc/platforms/Kconfig.cputype   |  1 +
>  include/linux/kasan.h                    |  3 ++
>  mm/kasan/kasan.c                         |  9 ++++
>  mm/kasan/kasan.h                         | 20 ++++++++-
>  mm/kasan/report.c                        | 19 ++++----
>  19 files changed, 216 insertions(+), 17 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/kasan.h
>  create mode 100644 arch/powerpc/mm/kasan_init.c
> 
