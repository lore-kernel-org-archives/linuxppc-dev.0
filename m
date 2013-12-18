Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1F54F2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 14:40:03 +1100 (EST)
Message-ID: <1387337985.3140.35.camel@snotra.buserror.net>
Subject: Re: [v3][PATCH 4/8] book3e/kexec/kdump: create a 1:1 TLB mapping
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Tue, 17 Dec 2013 21:39:45 -0600
In-Reply-To: <1373357007-30785-5-git-send-email-tiejun.chen@windriver.com>
References: <1373357007-30785-1-git-send-email-tiejun.chen@windriver.com>
 <1373357007-30785-5-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-09 at 16:03 +0800, Tiejun Chen wrote:
> book3e have no real MMU mode so we have to create a 1:1 TLB
> mapping to make sure we can access the real physical address.
> And correct something to support this pseudo real mode on book3e.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>

Why do we need to be able to directly access physical addresses?

> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> index f1a7ce7..20cbb98 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -460,6 +460,49 @@ kexec_flag:
>  
> 
>  #ifdef CONFIG_KEXEC
> +#ifdef CONFIG_PPC_BOOK3E
> +/* BOOK3E have no a real MMU mode so we have to setup the initial TLB
> + * for a core to map v:0 to p:0 as 1:1. This current implementation
> + * assume that 1G is enough for kexec.
> + */
> +#include <asm/mmu.h>

#includes go at the top of the file.

> +kexec_create_tlb:
> +	/* Invalidate all TLBs to avoid any TLB conflict. */
> +	PPC_TLBILX_ALL(0,R0)
> +	sync
> +	isync
> +
> +	mfspr	r10,SPRN_TLB1CFG
> +	andi.	r10,r10,TLBnCFG_N_ENTRY	/* Extract # entries */
> +	subi	r10,r10,1		/* Often its always safe to use last */
> +	lis	r9,MAS0_TLBSEL(1)@h
> +	rlwimi	r9,r10,16,4,15		/* Setup MAS0 = TLBSEL | ESEL(r9) */

Hardcoding TLB1 makes this FSL-specific code, but you've put it in a
non-FSL-specific place.

> +/* Setup a temp mapping v:0 to p:0 as 1:1 and return to it.
> + */
> +#ifdef CONFIG_SMP
> +#define M_IF_SMP	MAS2_M
> +#else
> +#define M_IF_SMP	0
> +#endif
> +	mtspr	SPRN_MAS0,r9
> +
> +	lis	r9,(MAS1_VALID|MAS1_IPROT)@h
> +	ori	r9,r9,(MAS1_TSIZE(BOOK3E_PAGESZ_1GB))@l
> +	mtspr	SPRN_MAS1,r9

What if the machine has less than 1 GiB of RAM?  We could get
speculative accesses to non-present addresses.

Though it looks like the normal 64-bit init sequence has the same
problem...

-Scott
