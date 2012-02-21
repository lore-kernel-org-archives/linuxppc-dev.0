Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 65098B6FA2
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2012 19:20:04 +1100 (EST)
Message-ID: <1329812389.3980.51.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix program check handling when lockdep is
 enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 21 Feb 2012 19:19:49 +1100
In-Reply-To: <1329809550-29336-1-git-send-email-michael@ellerman.id.au>
References: <1329809550-29336-1-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-02-21 at 18:32 +1100, Michael Ellerman wrote:
> In commit 54321242afe ("Disable interrupts early in Program Check"), we
> switched from enabling to disabling interrupts in program_check_common.
> 
> Whereas ENABLE_INTS leaves r3 untouched, if lockdep is enabled DISABLE_INTS
> calls into lockdep code and will clobber r3. That means we pass a bogus
> struct pt_regs* into program_check_exception() and all hell breaks loose.
> 
> So load our regs pointer into r3 after we call DISABLE_INTS.

Ah nice catch, thanks !

Cheers,
Ben.

> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/kernel/exceptions-64s.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 3844ca7..15c5a4f 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -774,8 +774,8 @@ alignment_common:
>  program_check_common:
>  	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
>  	bl	.save_nvgprs
> -	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	DISABLE_INTS
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	bl	.program_check_exception
>  	b	.ret_from_except
>  
