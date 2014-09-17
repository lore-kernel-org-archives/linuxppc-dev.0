Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0113.outbound.protection.outlook.com [157.56.111.113])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 07ACD1A00F9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 19:05:50 +1000 (EST)
Message-ID: <54194B21.6050105@Freescale.com>
Date: Wed, 17 Sep 2014 03:49:37 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/5] powerpc: Remove superfluous bootmem includes
References: <1410933504-28564-1-git-send-email-anton@samba.org>
 <1410933504-28564-3-git-send-email-anton@samba.org>
In-Reply-To: <1410933504-28564-3-git-send-email-anton@samba.org>
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Anton,


On 09/17/2014 12:58 AM, Anton Blanchard wrote:
> Lots of places included bootmem.h even when not using bootmem.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/kernel/crash_dump.c               | 1 -
>  arch/powerpc/kernel/irq.c                      | 1 -
>  arch/powerpc/kernel/pci_64.c                   | 1 -
>  arch/powerpc/kernel/rtas_pci.c                 | 1 -
>  arch/powerpc/kernel/setup_32.c                 | 1 -
>  arch/powerpc/kernel/vdso.c                     | 1 -
>  arch/powerpc/kvm/book3s_hv_builtin.c           | 1 -
>  arch/powerpc/mm/init_32.c                      | 1 -
>  arch/powerpc/mm/init_64.c                      | 1 -
>  arch/powerpc/mm/pgtable_64.c                   | 1 -
>  arch/powerpc/platforms/cell/celleb_scc_epci.c  | 1 -
>  arch/powerpc/platforms/cell/celleb_scc_pciex.c | 1 -
>  arch/powerpc/platforms/maple/pci.c             | 1 -
>  arch/powerpc/platforms/powermac/pci.c          | 1 -
>  arch/powerpc/platforms/powernv/eeh-ioda.c      | 1 -
>  arch/powerpc/platforms/powernv/pci.c           | 1 -
>  arch/powerpc/sysdev/fsl_msi.c                  | 1 -
>  arch/powerpc/sysdev/ipic.c                     | 1 -
>  arch/powerpc/sysdev/mpic.c                     | 1 -
>  arch/powerpc/sysdev/mpic_pasemi_msi.c          | 1 -
>  arch/powerpc/sysdev/mpic_u3msi.c               | 1 -
>  arch/powerpc/sysdev/ppc4xx_msi.c               | 1 -
>  arch/powerpc/sysdev/ppc4xx_pci.c               | 1 -
>  arch/powerpc/sysdev/qe_lib/qe.c                | 1 -
>  arch/powerpc/sysdev/qe_lib/qe_ic.c             | 1 -
>  arch/powerpc/sysdev/uic.c                      | 1 -
>  26 files changed, 26 deletions(-)
> ...
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index aa91737..feed47c 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -33,7 +33,6 @@
>  #include <linux/swap.h>
>  #include <linux/stddef.h>
>  #include <linux/vmalloc.h>
> -#include <linux/bootmem.h>
>  #include <linux/memblock.h>
>  #include <linux/slab.h>

While building corenet64_smp I get this:

> ../arch/powerpc/mm/pgtable_64.c: In function 'early_alloc_pgtable':
> ../arch/powerpc/mm/pgtable_64.c:77:95: error: 'MAX_DMA_ADDRESS' undeclared (first use in this function)
> ../arch/powerpc/mm/pgtable_64.c:77:95: note: each undeclared identifier is reported only once for each function it appears in

Adding '#include <asm/dma.h>' seems to fix it

Other than that, for the entire set:

Tested-by: Emil Medve <Emilian.Medve@Freescale.com>


Cheers,
