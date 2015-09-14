Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0138.outbound.protection.outlook.com [65.55.169.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54D741A2BFD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 01:21:08 +1000 (AEST)
Message-ID: <1442244054.2909.66.camel@freescale.com>
Subject: Re: [PATCH v3] powerpc32: memset: only use dcbz once cache is enabled
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <sojkam1@fel.cvut.cz>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 14 Sep 2015 10:20:54 -0500
In-Reply-To: <20150914062159.353701A2413@localhost.localdomain>
References: <20150914062159.353701A2413@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-14 at 08:21 +0200, Christophe Leroy wrote:
> memset() uses instruction dcbz to speed up clearing by not wasting time
> loading cache line with data that will be overwritten.
> Some platform like mpc52xx do no have cache active at startup and
> can therefore not use memset(). Allthough no part of the code
> explicitly uses memset(), GCC may makes calls to it.
> 
> This patch modifies memset() such that at startup, memset()
> unconditionally jumps to simple_memset() which doesn't use
> the dcbz instruction.
> 
> Once the initial MMU is set up, in machine_init() we patch memset()
> by replacing this inconditional jump by a NOP
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> This patch goes on to of [v3] powerpc32: memcpy: only use dcbz once cache 
> is enabled
> 
> Changes in v2:
>    was part of [v2] powerpc32: memcpy/memset: only use dcbz once cache is 
> enabled
> changes in v3:
>   Not using anymore feature-fixups
>   Handling of memcpy() and memset() split in two patches
>   
>  arch/powerpc/kernel/setup_32.c |  1 +
>  arch/powerpc/lib/copy_32.S     | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index 362495f..345ec3a 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -124,6 +124,7 @@ notrace void __init machine_init(u64 dt_ptr)
>       udbg_early_init();
>  
>       patch_instruction((unsigned int *)&memcpy, PPC_INST_NOP);
> +     patch_instruction((unsigned int *)&memset, PPC_INST_NOP);
>  
>       /* Do some early initialization based on the flat device tree */
>       early_init_devtree(__va(dt_ptr));
> diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
> index da5847d..68a59d4 100644
> --- a/arch/powerpc/lib/copy_32.S
> +++ b/arch/powerpc/lib/copy_32.S
> @@ -73,8 +73,13 @@ CACHELINE_MASK = (L1_CACHE_BYTES-1)
>   * Use dcbz on the complete cache lines in the destination
>   * to set them to zero.  This requires that the destination
>   * area is cacheable.  -- paulus
> + *
> + * During early init, cache might not be active yet, so dcbz cannot be 
> used.
> + * We therefore jump to simple_memset which doesn't use dcbz. This jump is
> + * replaced by a nop once cache is active. This is done in machine_init()
>   */
>  _GLOBAL(memset)
> +     b       simple_memset
>       rlwimi  r4,r4,8,16,23
>       rlwimi  r4,r4,16,0,15
>  
> @@ -122,6 +127,16 @@ _GLOBAL(memset)
>       bdnz    8b
>       blr
>  
> +/* Simple version of memset used during early boot until cache is enabled 
> */
> +simple_memset:
> +     cmplwi  cr0,r5,0
> +     addi    r6,r3,-1
> +     beqlr
> +     mtctr   r5
> +1:   stbu    r4,1(r6)
> +     bdnz    1b
> +     blr

Instead couldn't you use the generic memset at label 2: and patch the "bne 
2f"?

-Scott
