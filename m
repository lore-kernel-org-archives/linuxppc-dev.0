Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s07l95TtBzDrMM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 07:43:01 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s07l90W88z9t0q
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jul 2016 07:43:00 +1000 (AEST)
Message-ID: <1469655767.5978.164.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 12/21] powerpc/mm: Convert early cpu/mmu feature
 check to use the new helpers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Date: Thu, 28 Jul 2016 07:42:47 +1000
In-Reply-To: <1469629097-30859-12-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-12-git-send-email-mpe@ellerman.id.au>
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

On Thu, 2016-07-28 at 00:18 +1000, Michael Ellerman wrote:
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -530,7 +530,7 @@ static bool might_have_hea(void)
>          * we will never see an HEA ethernet device.
>          */
>  #ifdef CONFIG_IBMEBUS
> -       return !cpu_has_feature(CPU_FTR_ARCH_207S) &&
> +       return !__cpu_has_feature(CPU_FTR_ARCH_207S) &&
>                 !firmware_has_feature(FW_FEATURE_SPLPAR);
>  #else

All these could go if that function was split. The part that reads the
DT stays in early_init_mmu_devtree (bastically up to "found:" and then
the bit at the end that scans the huge pages).

The rest, which just assigns the various mmu_*_psize can go into
eary_init_mmu(). That means the only conversion needed is the one
below:

>         return false;
> @@ -561,7 +561,7 @@ static void __init htab_init_page_sizes(void)
>          * Not in the device-tree, let's fallback on known size
>          * list for 16M capable GP & GR
>          */
> -       if (mmu_has_feature(MMU_FTR_16M_PAGE))
> +       if (__mmu_has_feature(MMU_FTR_16M_PAGE))
>                 memcpy(mmu_psize_defs, mmu_psize_defaults_gp,
>                        sizeof(mmu_psize_defaults_gp));
>  found:

And the rest can remain.

> @@ -591,7 +591,7 @@ found:
>                 mmu_vmalloc_psize = MMU_PAGE_64K;
>                 if (mmu_linear_psize == MMU_PAGE_4K)
>                         mmu_linear_psize = MMU_PAGE_64K;
> -               if (mmu_has_feature(MMU_FTR_CI_LARGE_PAGE)) {
> +               if (__mmu_has_feature(MMU_FTR_CI_LARGE_PAGE)) {
>                         /*
>                          * When running on pSeries using 64k pages
> for ioremap
>                          * would stop us accessing the HEA ethernet.
> So if we
