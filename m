Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 484E41A0727
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 14:41:06 +1000 (AEST)
Message-ID: <1437108065.29389.6.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 01/12] powerpc/kernel: Get pt_regs from r9 before
 calling do_syscall_trace_enter()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, wad@chromium.org, keescook@chromium.org,
 linux-kernel@vger.kernel.org, luto@amacapital.net,
 strosake@linux.vnet.ibm.com,  bogdan.purcareata@freescale.com
Date: Fri, 17 Jul 2015 14:41:05 +1000
In-Reply-To: <1437086432.28088.46.camel@kernel.crashing.org>
References: <1436945834-26660-1-git-send-email-mpe@ellerman.id.au>
 <1437086432.28088.46.camel@kernel.crashing.org>
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

On Fri, 2015-07-17 at 08:40 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2015-07-15 at 17:37 +1000, Michael Ellerman wrote:
> > To call do_syscall_trace_enter() we need pt_regs in r3, but we don't need
> > to recalculate it based on r1, it's already in r9.
> > 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Is there any performance difference ?

No.

I'm not going to bother measuring it :)

> I find the addi a bit more robust in case the code gets moved around or
> the "previous" code gets changed to either not use r9 or clobber it,
> which would have the potential to
> introduce a subtle bug ...

Yeah true.

There is an "invariant" in that entry code that r9 contains pt_regs, you can
see for example the DTL code goes to pains to ensure it puts pt_regs back in r9
after it clobbers it. As does the current syscall_dotrace.

But looking closer I don't see where we actually use that (prior to this
patch).

So yeah I'll drop this and send a clean up to just get rid of all the r9
reloading.

cheers
