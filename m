Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 83E2B2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 12:27:36 +1100 (EST)
Date: Tue, 14 Jan 2014 19:27:13 -0600
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [v6,2/5] powerpc/book3e: store crit/mc/dbg exception thread info
Message-ID: <20140115012121.GA11229@home.buserror.net>
References: <1382520685-11609-3-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1382520685-11609-3-git-send-email-tiejun.chen@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 23, 2013 at 05:31:22PM +0800, Tiejun Chen wrote:
> We need to store thread info to these exception thread info like something
> we already did for PPC32.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> 
> ---
> arch/powerpc/kernel/exceptions-64e.S |   22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 68d74b4..a55cf62 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -36,6 +36,19 @@
>   */
>  #define	SPECIAL_EXC_FRAME_SIZE	INT_FRAME_SIZE
>  
> +/* Now we only store something to exception thread info */

Now as opposed to when?  Only as opposed to what else?

> +#define	EXC_LEVEL_EXCEPTION_PROLOG(type)				\

I'd prefer .macro over #define.

> +	ld	r14,PACAKSAVE(r13);					\
> +	CURRENT_THREAD_INFO(r14, r14);					\
> +	CURRENT_THREAD_INFO(r15, r1);					\
> +	ld	r10,TI_FLAGS(r14);		     			\
> +	std	r10,TI_FLAGS(r15);			     		\
> +	ld	r10,TI_PREEMPT(r14);		     			\
> +	std	r10,TI_PREEMPT(r15);		     			\
> +	ld	r10,TI_TASK(r14);			     		\
> +	std	r10,TI_TASK(r15);

This is a start, but we'll also need to save some more context to allow
TLB misses from within the exception (e.g. if a machine check handler or
GDB stub writes to a serial port, and the I/O registers aren't in the
TLB).  At a minimum I think we need to save SRR0, SRR1,
SPRN_SPRG_GEN_SCRATCH, SPRN_SPRG_TLB_SCRATCH, and the MAS registers. 
We'll also need to make the bolted TLB miss handlers capable of pointing
to different extables (though they won't need to auto-advance as the
original TLB miss handlers do -- we would advance SPRN_SPRG_TLB_EXFRAME
from this code), and the original TLB miss handlers will now need to
support more than 3 levels of nesting.

For the e6500 tablewalk TLB miss handler, we'll need to do something
special if we interrupt it when the lock is held, to revoke the lock and
return to code that retries.

Is there anything else I'm missing?

-Scott
