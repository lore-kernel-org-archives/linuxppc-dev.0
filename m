Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id 15D9A1A0012
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 23:56:19 +1000 (EST)
In-Reply-To: <20140829091437.B3FE71ABD63@localhost.localdomain>
References: <20140829091437.B3FE71ABD63@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
Subject: Re: [PATCH v2 03/19] powerpc/8xx: exception InstructionAccess does not
 exist on MPC8xx
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OFBEBB868D.99139E7F-ONC1257D43.004BF814-C1257D43.004C8EB9@transmode.se>
Date: Fri, 29 Aug 2014 15:56:12 +0200
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

Christophe Leroy <christophe.leroy@c-s.fr> wrote on 2014/08/29 11:14:37:
> 
> Exception InstructionAccess does not exist on MPC8xx. No need to branch 
there from somewhere else. 
> Handling can be done directly in InstructionTLBError Exception.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> ---
>  arch/powerpc/kernel/head_8xx.S |   17 +++++++----------
>  1 files changed, 7 insertions(+), 10 deletions(-)
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

This changes trap nr from 0x400 to 0x1300 for InstuctionAccess which I 
think bad as
Linux uses the trap nr in arch/powerpc/mm/fault.c

Same comment for patch 7

 Jocke
