Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 9B0F2DDDED
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 21:06:24 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <1227122070-6835-1-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <00e4dc93772a5517c4ac98d974d166ed@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: Better setup of boot page TLB entry
Date: Sat, 22 Nov 2008 04:04:49 -0600
To: Trent Piepho <tpiepho@freescale.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu Nov 20 at 06:14:30 EST in 2008, Trent Piepho wrote:
> The initial TLB mapping for the kernel boot didn't set the memory 
> coherent
> attribute, MAS2[M], in SMP mode.


> Also, from the MPC8572 manual section 6.12.5.3, "Bits that represent
> offsets within a page are ignored and should be cleared." Existing code
> didn't clear them, this code does.
>
> The same when the page of KERNELBASE is found; we don't need to use 
> asm to
> mask the lower 12 bits off.
>
> In the code that computes the address to rfi from, don't hard code the
> offset to 24 bytes, but have the assembler figure that out for us.

The expressions are still overly complex.

...
> -       li      r7,0
> -       lis     r6,PAGE_OFFSET at h
> -       ori     r6,r6,PAGE_OFFSET at l
> -       rlwimi  r6,r7,0,20,31
> +       lis     r6,MAS2_VAL(PAGE_OFFSET, BOOKE_PAGESZ_64M, M_IF_SMP)@h
> +       ori     r6,r6,MAS2_VAL(PAGE_OFFSET, BOOKE_PAGESZ_64M, 
> M_IF_SMP)@l

I'm fine with this part, even if the expression is a bit long.  You 
might consider using LOAD_REG_IMMEDIATE from asm/ppc_asm.h to avoid 
duplicating the expression.

>         mtspr   SPRN_MAS2,r6
>         mtspr   SPRN_MAS3,r8
>         tlbwe
>
>  /* 7. Jump to KERNELBASE mapping */
> -       lis     r6,KERNELBASE at h
> -       ori     r6,r6,KERNELBASE at l
> -       rlwimi  r6,r7,0,20,31
> +       lis     r6,(KERNELBASE & ~0xfff)@h
> +       ori     r6,r6,(KERNELBASE & ~0xfff)@l

Why do you need to mask off the bottom bits of KERNEL_BASE?  Just 
trying to keep the instruction effect identical?

First of all, if its not aligned, then its likely other parts of the 
kernel will break.  We could put a BUILD_BUG_ON somewhere (in c) if 
that check is required.

Second, it makes the expression longer and more complex (requiring 
parenthesis).

>         lis     r7,MSR_KERNEL at h
>         ori     r7,r7,MSR_KERNEL at l
>         bl      1f                      /* Find our address */
>  1:     mflr    r9
>         rlwimi  r6,r9,0,20,31

Third, this just inserted the offset into those bits, overwriting any 
previous value they had.

> -       addi    r6,r6,24
> +       addi    r6,r6,(2f - 1b)

and while doing assembler math is better than the hand computed 24, how 
about doing li r9,2f@l and just inserting that into r6?  Unless you 
expect step 8 to cross a page from the 1b label above.  But if you are 
that close to a page boundary than assuming 1b is in the page at 
KERNEL_BASE would seem to be suspect.

For that matter, just do LOAD_ADDR(2f) or LOAD_REG_IMMEDIATE(2f), which 
would give the same result, as KERNEL_BASE should be reflected the 
linked address of the kernel (I assume that you are not doing dynamic 
runtime relocation like ppc64 on the code up to here, otherwise the 
previous suggestion still works).

>         mtspr   SPRN_SRR0,r6
>         mtspr   SPRN_SRR1,r7
>         rfi                             /* start execution out of 
> TLB1[0] entry */
>
>  /* 8. Clear out the temp mapping */
> -       lis     r7,0x1000       /* Set MAS0(TLBSEL) = 1 */
> +2:     lis     r7,0x1000       /* Set MAS0(TLBSEL) = 1 */
>         rlwimi  r7,r5,16,4,15   /* Setup MAS0 = TLBSEL | ESEL(r5) */
>         mtspr   SPRN_MAS0,r7
>         tlbre

milton
