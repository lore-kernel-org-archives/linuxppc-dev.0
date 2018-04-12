Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40MZ7h4FKQzF1SF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2018 07:40:00 +1000 (AEST)
In-Reply-To: <20180412055352.21998-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: joel@jms.id.au, npiggin@gmail.com
Subject: Re: powerpc/mm/radix: Fix checkstops caused by invalid tlbiel
Message-Id: <40MZ7g6X79z9s2L@ozlabs.org>
Date: Fri, 13 Apr 2018 07:39:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-04-12 at 05:53:52 UTC, Michael Ellerman wrote:
> In tlbiel_radix_set_isa300() we use the PPC_TLBIEL() macro to
> construct tlbiel instructions. The instruction takes 5 fields, two of
> which are registers, and the others are constants. But because it's
> constructed with inline asm the compiler doesn't know that.
> 
> We got the constraint wrong on the 'r' field, using "r" tells the
> compiler to put the value in a register. The value we then get in the
> macro is the *register number*, not the value of the field.
> 
> That means when we mask the register number with 0x1 we get 0 or 1
> depending on which register the compiler happens to put the constant
> in, eg:
> 
>   li      r10,1
>   tlbiel  r8,r9,2,0,0
> 
>   li      r7,1
>   tlbiel  r10,r6,0,0,1
> 
> If we're unlucky we might generate an invalid instruction form, for
> example RIC=0, PRS=1 and R=0, tlbiel r8,r7,0,1,0, this has been
> observed to cause machine checks:
> 
>   Oops: Machine check, sig: 7 [#1]
>   CPU: 24 PID: 0 Comm: swapper
>   NIP:  00000000000385f4 LR: 000000000100ed00 CTR: 000000000000007f
>   REGS: c00000000110bb40 TRAP: 0200
>   MSR:  9000000000201003 <SF,HV,ME,RI,LE>  CR: 48002222  XER: 20040000
>   CFAR: 00000000000385d0 DAR: 0000000000001c00 DSISR: 00000200 SOFTE: 1
> 
> If the machine check happens early in boot while we have MSR_ME=0 it
> will escalate into a checkstop and kill the box entirely.
> 
> To fix it we could change the inline asm constraint to "i" which
> tells the compiler the value is a constant. But a better fix is to just
> pass a literal 1 into the macro, which bypasses any problems with inline
> asm constraints.
> 
> Fixes: d4748276ae14 ("powerpc/64s: Improve local TLB flush for boot and MCE on POWER9")
> Cc: stable@vger.kernel.org # v4.16+
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/2675c13b293a007b7b7f8229514126

cheers
