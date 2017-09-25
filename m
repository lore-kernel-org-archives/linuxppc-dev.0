Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y0vXz0bjxzDsPx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 16:38:10 +1000 (AEST)
Subject: Re: [PATCH] powerpc/mm: Call flush_tlb_kernel_range with interrupts
 enabled
To: Guenter Roeck <linux@roeck-us.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1506274243-28540-1-git-send-email-linux@roeck-us.net>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7a7a2277-7b7f-a706-7507-5fa03b02f8a5@c-s.fr>
Date: Mon, 25 Sep 2017 08:38:06 +0200
MIME-Version: 1.0
In-Reply-To: <1506274243-28540-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 24/09/2017 à 19:30, Guenter Roeck a écrit :
> flush_tlb_kernel_range() may call smp_call_function_many() which expects
> interrupts to be enabled. This results in a traceback.
> 
> WARNING: CPU: 0 PID: 1 at kernel/smp.c:416 smp_call_function_many+0xcc/0x2fc
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.0-rc1-00009-g0666f56 #1
> task: cf830000 task.stack: cf82e000
> NIP:  c00a93c8 LR: c00a9634 CTR: 00000001
> REGS: cf82fde0 TRAP: 0700   Not tainted  (4.14.0-rc1-00009-g0666f56)
> MSR:  00021000 <CE,ME>  CR: 24000082  XER: 00000000
> 
> GPR00: c00a9634 cf82fe90 cf830000 c050ad3c c0015a54 00000000 00000001 00000001
> GPR08: 00000001 00000000 00000000 cf82e000 24000084 00000000 c0003150 00000000
> GPR16: 00000000 00000000 00000000 00000000 00000000 00000001 00000000 c0510000
> GPR24: 00000000 c0015a54 00000000 c050ad3c c051823c c050ad3c 00000025 00000000
> NIP [c00a93c8] smp_call_function_many+0xcc/0x2fc
> LR [c00a9634] smp_call_function+0x3c/0x50
> Call Trace:
> [cf82fe90] [00000010] 0x10 (unreliable)
> [cf82fed0] [c00a9634] smp_call_function+0x3c/0x50
> [cf82fee0] [c0015d2c] flush_tlb_kernel_range+0x20/0x38
> [cf82fef0] [c001524c] mark_initmem_nx+0x154/0x16c
> [cf82ff20] [c001484c] free_initmem+0x20/0x4c
> [cf82ff30] [c000316c] kernel_init+0x1c/0x108
> [cf82ff40] [c000f3a8] ret_from_kernel_thread+0x5c/0x64
> Instruction dump:
> 7c0803a6 7d808120 38210040 4e800020 3d20c052 812981a0 2f890000 40beffac
> 3d20c051 8929ac64 2f890000 40beff9c <0fe00000> 4bffff94 7fc3f378 7f64db78
> 
> Fixes: 3184cc4b6f6a ("powerpc/mm: Fix kernel RAM protection after freeing ...")
> Fixes: e611939fc8ec ("powerpc/mm: Ensure change_page_attr() doesn't ...")
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/mm/pgtable_32.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 65eda1997c3f..f6c7f54c0515 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -361,9 +361,9 @@ static int change_page_attr(struct page *page, int numpages, pgprot_t prot)
>   			break;
>   	}
>   	wmb();
> +	local_irq_restore(flags);
>   	flush_tlb_kernel_range((unsigned long)page_address(start),
>   			       (unsigned long)page_address(page));
> -	local_irq_restore(flags);
>   	return err;
>   }
>   
> 
