Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com
 [IPv6:2a00:1450:400c:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BB3F1A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 22:16:32 +1000 (AEST)
Received: by wicgk12 with SMTP id gk12so7426001wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 05:16:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1440577578-15813-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1440577578-15813-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 27 Aug 2015 15:16:28 +0300
Message-ID: <CAPAsAGz0ccS49MgVm0D9kG3YkmFv-re5h50uBG6R=AmMU1invQ@mail.gmail.com>
Subject: Re: [PATCH V2 10/10] powerpc/mm: kasan: Add kasan support for ppc64
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2015-08-26 11:26 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> +               k_start = (unsigned long)kasan_mem_to_shadow(start);
> +               k_end = (unsigned long)kasan_mem_to_shadow(end);
> +               for (; k_start < k_end; k_start += page_size) {
> +                       p = vmemmap_alloc_block(page_size, node);
> +                       if (!p) {
> +                               pr_info("Disabled Kasan, for lack of free mem\n");
> +                               /* Free the stuff or panic ? */

vmemmap_alloc_block() panics on allocation failure, so you don't need
this if block.
You could replace this with memblock_virt_alloc_try_nid_nopanic(), but
note that if/when
we will have working asan-stack=1 there will be no way for fallback.

> +                               return;
> +                       }
> +                       htab_bolt_mapping(k_start, k_start + page_size,
> +                                         __pa(p), pgprot_val(PAGE_KERNEL),
> +                                         mmu_vmemmap_psize, mmu_kernel_ssize);
> +               }
> +       }
> +       /*
> +        * At this point kasan is fully initialized. Enable error messages
> +        */
> +       init_task.kasan_depth = 0;
> +       __kasan_enabled = true;
> +       pr_info("Kernel address sanitizer initialized\n");
> +}
> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
> index 736d18b3cefd..154bd8a0b437 100644
> --- a/arch/powerpc/mm/slb_low.S
> +++ b/arch/powerpc/mm/slb_low.S
> @@ -80,11 +80,15 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>         /* Check virtual memmap region. To be patches at kernel boot */
>         cmpldi  cr0,r9,0xf
>         bne     1f
> +2:
>  .globl slb_miss_kernel_load_vmemmap
>  slb_miss_kernel_load_vmemmap:
>         li      r11,0
>         b       6f
>  1:
> +       /* Kasan region same as vmemmap mapping */
> +       cmpldi  cr0,r9,0xe
> +       beq     2b
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>
>         /* vmalloc mapping gets the encoding from the PACA as the mapping
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index c140e94c7c72..7a7c9d54f80e 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -75,6 +75,7 @@ config PPC_BOOK3S_64
>         select HAVE_ARCH_TRANSPARENT_HUGEPAGE if PPC_64K_PAGES
>         select ARCH_SUPPORTS_NUMA_BALANCING
>         select IRQ_WORK
> +       select HAVE_ARCH_KASAN if SPARSEMEM_VMEMMAP
>
>  config PPC_BOOK3E_64
>         bool "Embedded processors"
> --
> 2.5.0
>
