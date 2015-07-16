Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B5E991A075F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 08:40:57 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0C40D1402A9
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2015 08:40:56 +1000 (AEST)
Message-ID: <1437086432.28088.46.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 01/12] powerpc/kernel: Get pt_regs from r9 before
 calling do_syscall_trace_enter()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, wad@chromium.org, keescook@chromium.org,
 linux-kernel@vger.kernel.org, luto@amacapital.net,
 strosake@linux.vnet.ibm.com, bogdan.purcareata@freescale.com
Date: Fri, 17 Jul 2015 08:40:32 +1000
In-Reply-To: <1436945834-26660-1-git-send-email-mpe@ellerman.id.au>
References: <1436945834-26660-1-git-send-email-mpe@ellerman.id.au>
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

On Wed, 2015-07-15 at 17:37 +1000, Michael Ellerman wrote:
> To call do_syscall_trace_enter() we need pt_regs in r3, but we don't need
> to recalculate it based on r1, it's already in r9.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Is there any performance difference ?

I find the addi a bit more robust in case the code gets moved around or
the "previous" code gets changed to either not use r9 or clobber it,
which would have the potential to
introduce a subtle bug ...

Ben.

> ---
>  arch/powerpc/kernel/entry_64.S | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 579e0f9a2d57..0796c487d3db 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -243,7 +243,9 @@ syscall_error:
>  /* Traced system call support */
>  syscall_dotrace:
>  	bl	save_nvgprs
> -	addi	r3,r1,STACK_FRAME_OVERHEAD
> +
> +	/* Get pt_regs into r3 */
> +	mr	r3, r9
>  	bl	do_syscall_trace_enter
>  	/*
>  	 * Restore argument registers possibly just changed.
