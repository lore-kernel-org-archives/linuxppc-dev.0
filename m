Message-ID: <39813520.673CF3E0@lightning.ch>
Date: Fri, 28 Jul 2000 09:24:16 +0200
From: Daniel Marmier <daniel.marmier@lightning.ch>
Reply-To: daniel.marmier@lightning.ch
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Altivec on 2.4.xx?
References: <3980DEAF.ACFB0C43@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
> Right now, I am just removing this as part of the exception handler,
> so this function never finds this bit set for instruction faults.
> Anyone else?

Well, I don't use Altivec, but the exception handlers's behaviour
wrt to do_page_fault makes me feel uncomfortable too. It would be
nice to have something like do_page_fault(regs, addr, code, srr1)
instead of do_page_fault(regs, addr, code) without knowing if code
comes from DSISR or SRR1. And simply pass code=0 if DSISR is not
valid for a given exception.

If my understanding of Motorola's docs is correct, the only MPC8xx
exception that has a valid DSISR setting is the implementation
specific data TLB error interrupt (apart of course from Machine
Check and Alignment, but those do not call do_page_fault).

As both TLB miss and TLB error handlers can jump to DataAccess,
there is a risk that we call do_page_fault with a previous value
of DSISR from there. So the TLB handlers should pass the code
parameter to DataAccess, too.


				Daniel Marmier

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
