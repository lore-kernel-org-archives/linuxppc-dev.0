Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id 027201A0707
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 01:15:20 +1000 (EST)
In-Reply-To: <20140917163657.7737D1AB032@localhost.localdomain>
References: <20140917163657.7737D1AB032@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
Subject: Re: [PATCH v3 03/21] powerpc/8xx: exception InstructionAccess does not
 exist on MPC8xx
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OF3CC96BF2.DF7CB060-ONC1257D57.00533ED7-C1257D57.0053CADF@transmode.se>
Date: Thu, 18 Sep 2014 17:15:13 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> wrote on 2014/09/17 18:36:57:
> 
> Exception InstructionAccess does not exist on MPC8xx. No need to branch 
there from somewhere else. 
> Handling can be done directly in InstructionTLBError Exception.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> ---
> Changes in v2:
> - None
> 
> Changes in v3:
> - arch/powerpc/mm/fault.c uses the vector number, so make sure it 
understand
> the new ones.
> 
>  arch/powerpc/kernel/head_8xx.S | 17 +++++++----------
>  arch/powerpc/mm/fault.c        |  1 +
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_8xx.S 
b/arch/powerpc/kernel/head_8xx.S
> index 3af6db1..fbe5d10 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -234,15 +234,9 @@ DataAccess:
>     EXC_XFER_LITE(0x300, handle_page_fault)
> 
>  /* Instruction access exception.
> - * This is "never generated" by the MPC8xx.  We jump to it for other
> - * translation errors.
> + * This is "never generated" by the MPC8xx.
>   */
> -   . = 0x400
> -InstructionAccess:
> -   EXCEPTION_PROLOG
> -   mr   r4,r12
> -   mr   r5,r9
> -   EXC_XFER_LITE(0x400, handle_page_fault)
> +   EXCEPTION(0x400, InstructionAccess, unknown_exception, EXC_XFER_STD)
> 
>  /* External interrupt */
>     EXCEPTION(0x500, HardwareInterrupt, do_IRQ, EXC_XFER_LITE)
> @@ -382,7 +376,7 @@ InstructionTLBMiss:
>  #endif
>     mfspr   r10, SPRN_SPRG_SCRATCH2
>     EXCEPTION_EPILOG_0
> -   b   InstructionAccess
> +   b   InstructionTLBError
> 
>     . = 0x1200
>  DataStoreTLBMiss:
> @@ -477,7 +471,10 @@ DataStoreTLBMiss:
>   */
>     . = 0x1300
>  InstructionTLBError:
> -   b   InstructionAccess
> +   EXCEPTION_PROLOG
> +   mr   r4,r12
> +   mr   r5,r9
> +   EXC_XFER_LITE(0x1300, handle_page_fault)

Still don't like that you change the vector number, every other ppc uses 
the
standard number.

Can you not just lie here(EXC_XFER_LITE(0x400, handle_page_fault))?
Move the code to InstructionAccess too and let TLBError branch there.

If not I think you should keep the old/current way?

Same for DataTLB Miss/Error

> 
>  /* This is the data TLB error on the MPC8xx.  This could be due to
>   * many reasons, including a dirty update to a pte.  We can catch that
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 51ab9e7..4d63c96 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -526,6 +526,7 @@ void bad_page_fault(struct pt_regs *regs, unsigned 
long address, int sig)
>        break;
>     case 0x400:
>     case 0x480:
> +   case 0x1300:
>        printk(KERN_ALERT "Unable to handle kernel paging request for "
>           "instruction fetch\n");
>        break;
> -- 
> 2.1.0
> 
