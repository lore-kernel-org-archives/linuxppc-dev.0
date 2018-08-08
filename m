Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltxK59mqzDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:26:45 +1000 (AEST)
In-Reply-To: <1533291186-5374-2-git-send-email-paulus@ozlabs.org>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v3, 1/4] powerpc/64: Make exception table clearer in
 __copy_tofrom_user_base
Message-Id: <41ltxF0G4hz9ryt@ozlabs.org>
Date: Thu,  9 Aug 2018 00:26:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-03 at 10:13:03 UTC, Paul Mackerras wrote:
> This aims to make the generation of exception table entries for the
> loads and stores in __copy_tofrom_user_base clearer and easier to
> verify.  Instead of having a series of local labels on the loads and
> stores, with a series of corresponding labels later for the exception
> handlers, we now use macros to generate exception table entries at the
> point of each load and store that could potentially trap.  We do this
> with the macros lex (load exception) and stex (store exception).
> These macros are used right before the load or store to which they
> apply.
> 
> Some complexity is introduced by the fact that we have some more work
> to do after hitting an exception, because we need to calculate and
> return the number of bytes not copied.  The code uses r3 as the
> current pointer into the destination buffer, that is, the address of
> the first byte of the destination that has not been modified.
> However, at various points in the copy loops, r3 can be 4, 8, 16 or 24
> bytes behind that point.
> 
> To express this offset in an understandable way, we define a symbol
> r3_offset which is updated at various points so that it equal to the
> difference between the address of the first unmodified byte of the
> destination and the value in r3.  (In fact it only needs to be
> accurate at the point of each lex or stex macro invocation.)
> 
> The rules for updating r3_offset are as follows:
> 
> * It starts out at 0
> * An addi r3,r3,N instruction decreases r3_offset by N
> * A store instruction (stb, sth, stw, std) to N(r3)
>   increases r3_offset by the width of the store (1, 2, 4, 8)
> * A store with update instruction (stbu, sthu, stwu, stdu) to N(r3)
>   sets r3_offset to the width of the store.
> 
> There is some trickiness to the way that the lex and stex macros and
> the associated exception handlers work.  I would have liked to use
> the current value of r3_offset in the name of the symbol used as
> the exception handler, as in ".Lld_exc_$(r3_offset)" and then
> have symbols .Lld_exc_0, .Lld_exc_8, .Lld_exc_16 etc. corresponding
> to the offsets that needed to be added to r3.  However, I couldn't
> see a way to do that with gas.
> 
> Instead, the exception handler address is .Lld_exc - r3_offset or
> .Lst_exc - r3_offset, that is, the distance ahead of .Lld_exc/.Lst_exc
> that we start executing is equal to the amount that we need to add to
> r3.  This works because r3_offset is always a small multiple of 4,
> and our instructions are 4 bytes long.  This means that before
> .Lld_exc and .Lst_exc, we have a sequence of instructions that
> increments r3 by 4, 8, 16 or 24 depending on where we start.  The
> sequence increments r3 by 4 per instruction (on average).
> 
> We also replace the exception table for the 4k copy loop by a
> macro per load or store.  These loads and stores all use exactly
> the same exception handler, which simply resets the argument registers
> r3, r4 and r5 to there original values and re-does the whole copy
> using the slower loop.
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a7c81ce398e2ad304f61d6167155f3

cheers
