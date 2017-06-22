Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtRk10FQkzDt6V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 13:23:21 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id e187so723533pgc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 20:23:20 -0700 (PDT)
Date: Thu, 22 Jun 2017 13:23:10 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/6] powerpc/64s: Convert .L__replay_interrupt_return
 to a local label
Message-ID: <20170622132310.263b1419@roar.ozlabs.ibm.com>
In-Reply-To: <e1a688655f74052b98ae9eed8cad864b4e8c8183.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <e1a688655f74052b98ae9eed8cad864b4e8c8183.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Jun 2017 00:08:38 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Commit b48bbb82e2b835 ("powerpc/64s: Don't unbalance the return branch
> predictor in __replay_interrupt()") introduced __replay_interrupt_return
> symbol with '.L' prefix in hopes of keeping it private. However, due to
> the use of LOAD_REG_ADDR(), the assembler kept this symbol visible. Fix
> the same by instead using the local label '1'.
> 
> Fixes: Commit b48bbb82e2b835 ("powerpc/64s: Don't unbalance the return branch
> predictor in __replay_interrupt()")
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>

Thanks, good catch.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 07b79c2c70f8..2df6d7b3070f 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1629,7 +1629,7 @@ _GLOBAL(__replay_interrupt)
>  	 * we don't give a damn about, so we don't bother storing them.
>  	 */
>  	mfmsr	r12
> -	LOAD_REG_ADDR(r11, .L__replay_interrupt_return)
> +	LOAD_REG_ADDR(r11, 1f)
>  	mfcr	r9
>  	ori	r12,r12,MSR_EE
>  	cmpwi	r3,0x900
> @@ -1647,6 +1647,6 @@ FTR_SECTION_ELSE
>  	cmpwi	r3,0xa00
>  	beq	doorbell_super_common_msgclr
>  ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
> -.L__replay_interrupt_return:
> +1:
>  	blr
>  
