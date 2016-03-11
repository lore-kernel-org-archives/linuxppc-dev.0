Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 50A361A004B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Mar 2016 09:52:12 +1100 (AEDT)
Date: Fri, 11 Mar 2016 16:51:54 -0600
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20160311225154.GA30872@home.buserror.net>
References: <3c627354c920c564c01cbdb1f960f3e2ed9eac10.1455032446.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3c627354c920c564c01cbdb1f960f3e2ed9eac10.1455032446.git.christophe.leroy@c-s.fr>
Subject: Re: [v8,07/23] powerpc/8xx: Fix vaddr for IMMR early remap
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 09, 2016 at 05:08:00PM +0100, Christophe Leroy wrote:
> Memory: 124428K/131072K available (3748K kernel code, 188K rwdata,
> 648K rodata, 508K init, 290K bss, 6644K reserved)
> Kernel virtual memory layout:
>   * 0xfffdf000..0xfffff000  : fixmap
>   * 0xfde00000..0xfe000000  : consistent mem
>   * 0xfddf6000..0xfde00000  : early ioremap
>   * 0xc9000000..0xfddf6000  : vmalloc & ioremap
> SLUB: HWalign=16, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> 
> Today, IMMR is mapped 1:1 at startup
> 
> Mapping IMMR 1:1 is just wrong because it may overlap with another
> area. On most mpc8xx boards it is OK as IMMR is set to 0xff000000
> but for instance on EP88xC board, IMMR is at 0xfa200000 which
> overlaps with VM ioremap area
> 
> This patch fixes the virtual address for remapping IMMR with the fixmap
> regardless of the value of IMMR.
> 
> The size of IMMR area is 256kbytes (CPM at offset 0, security engine
> at offset 128k) so a 512k page is enough
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> v2: no change
> v3: Using fixmap instead of fixed address
> v4: Fix a wrong #if notified by kbuild robot
> v5: no change
> v6: no change
> v8: no change
> 
>  arch/powerpc/include/asm/fixmap.h |  7 +++++++
>  arch/powerpc/kernel/asm-offsets.c |  8 ++++++++
>  arch/powerpc/kernel/head_8xx.S    | 11 ++++++-----
>  arch/powerpc/mm/mmu_decl.h        |  7 +++++++
>  arch/powerpc/sysdev/cpm_common.c  | 15 ++++++++++++---
>  5 files changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
> index 90f604b..d7dd8fb 100644
> --- a/arch/powerpc/include/asm/fixmap.h
> +++ b/arch/powerpc/include/asm/fixmap.h
> @@ -51,6 +51,13 @@ enum fixed_addresses {
>  	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
>  	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
>  #endif
> +#ifdef CONFIG_PPC_8xx
> +	/* For IMMR we need an aligned 512K area */
> +	FIX_IMMR_START,
> +	FIX_IMMR_TOP = (FIX_IMMR_START - 1 + ((512 * 1024) / PAGE_SIZE)) &
> +		       ~(((512 * 1024) / PAGE_SIZE) - 1),
> +	FIX_IMMR_BASE = FIX_IMMR_TOP - 1 + ((512 * 1024) / PAGE_SIZE),
> +#endif
>  	/* FIX_PCIE_MCFG, */
>  	__end_of_fixed_addresses
>  };

This doesn't look correct -- shouldn't the last thing in the 8xx ifdef be the
last byte of the IMMR, so that any subsequent fixmap entry would start at
the correct location?

Also, can standard alignment macros be used?

-Scott
