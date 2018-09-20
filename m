Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3Sc3NfvzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:21:04 +1000 (AEST)
In-Reply-To: <20180914034004.GP3174@bubble.grove.modra.org>
To: Alan Modra <amodra@gmail.com>, Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: PowerPC/VDSO: Correct call frame information
Message-Id: <42G3Sc0Dw1z9sBv@ozlabs.org>
Date: Thu, 20 Sep 2018 14:21:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-09-14 at 03:40:04 UTC, Alan Modra wrote:
> Call Frame Information is used by gdb for back-traces and inserting
> breakpoints on function return for the "finish" command.  This failed
> when inside __kernel_clock_gettime.  More concerning than difficulty
> debugging is that CFI is also used by stack frame unwinding code to
> implement exceptions.  If you have an app that needs to handle
> asynchronous exceptions for some reason, and you are unlucky enough to
> get one inside the VDSO time functions, your app will crash.
> 
> What's wrong:  There is control flow in __kernel_clock_gettime that
> reaches label 99 without saving lr in r12.  CFI info however is
> interpreted by the unwinder without reference to control flow: It's a
> simple matter of "Execute all the CFI opcodes up to the current
> address".  That means the unwinder thinks r12 contains the return
> address at label 99.  Disabuse it of that notion by resetting CFI for
> the return address at label 99.
> 
> Note that the ".cfi_restore lr" could have gone anywhere from the
> "mtlr r12" a few instructions earlier to the instruction at label 99.
> I put the CFI as late as possible, because in general that's best
> practice (and if possible grouped with other CFI in order to reduce
> the number of CFI opcodes executed when unwinding).  Using r12 as the
> return address is perfectly fine after the "mtlr r12" since r12 on
> that code path still contains the return address.
> 
> __get_datapage also has a CFI error.  That function temporarily saves
> lr in r0, and reflects that fact with ".cfi_register lr,r0".  A later
> use of r0 means the CFI at that point isn't correct, as r0 no longer
> contains the return address.  Fix that too.
> 
> Signed-off-by: Alan Modra <amodra@gmail.com>
> Tested-by: Reza Arbab <arbab@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/56d20861c027498b5a1112b4f9f05b

cheers
