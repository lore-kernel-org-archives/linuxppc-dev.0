Return-Path: <srs0=sbps=hb=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40MB6f3428zDqZH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 16:37:46 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40MB6f2Sggz8svR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 16:37:46 +1000 (AEST)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40MB6d3rRwz9s1s
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2018 16:37:45 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y66so2807217pfi.7
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2018 23:37:44 -0700 (PDT)
Date: Thu, 12 Apr 2018 16:37:27 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, joel@jms.id.au
Subject: Re: [PATCH] powerpc/mm/radix: Fix checkstops caused by invalid tlbiel
Message-ID: <20180412163727.429e134a@roar.ozlabs.ibm.com>
In-Reply-To: <20180412055352.21998-1-mpe@ellerman.id.au>
References: <20180412055352.21998-1-mpe@ellerman.id.au>
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

On Thu, 12 Apr 2018 15:53:52 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

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

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Fixes: d4748276ae14 ("powerpc/64s: Improve local TLB flush for boot and MCE on POWER9")
> Cc: stable@vger.kernel.org # v4.16+
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/mm/tlb-radix.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 2fba6170ab3f..a5d7309c2d05 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -33,13 +33,12 @@ static inline void tlbiel_radix_set_isa300(unsigned int set, unsigned int is,
>  {
>  	unsigned long rb;
>  	unsigned long rs;
> -	unsigned int r = 1; /* radix format */
>  
>  	rb = (set << PPC_BITLSHIFT(51)) | (is << PPC_BITLSHIFT(53));
>  	rs = ((unsigned long)pid << PPC_BITLSHIFT(31));
>  
> -	asm volatile(PPC_TLBIEL(%0, %1, %2, %3, %4)
> -		     : : "r"(rb), "r"(rs), "i"(ric), "i"(prs), "r"(r)
> +	asm volatile(PPC_TLBIEL(%0, %1, %2, %3, 1)
> +		     : : "r"(rb), "r"(rs), "i"(ric), "i"(prs)
>  		     : "memory");
>  }
>  
