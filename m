Message-ID: <3E81C4B3.2080006@embeddededge.com>
Date: Wed, 26 Mar 2003 10:18:11 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Till Straumann <strauman@SLAC.Stanford.EDU>
Cc: joakim.tjernlund@lumentis.se,
	Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: dcbz works on 862 everywhere!
References: <IGEFJKJNHJDCBKALBJLLGEHAFLAA.joakim.tjernlund@lumentis.se> <3E810DA7.1060605@slac.stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Till Straumann wrote:

> I found that 'dcbz' (while failing to set DAR)
> indeed sets MD_EPN correctly. Hence, Jocke's fix
> (copy EPN[0:19]->DAR) would handle that.


After sleeping for a couple of days and consuming large
amounts of medicine to cure a cold, I think I understand
why copying these bits around seems to "fix" problems.

It's all related to the sequence of TLB miss/error exceptions
that I had been describing all along.  The first thing that
is going to most likely happen is you will get a TLB miss to
load a PTE  into the TLB.  It will be marked valid but not
dirty (not writable).  Immediately upon performing the rfi
you will get a TLB Error to handle the dirty PTE update.
By copying the bits from MD_EPN to the DAR in the miss handler,
the Error handler will have at least a 4K boundary aligned DAR
and it will execute correctly to update the dirty state.  At
this point, it will appear to "work" properly (even though
it is likely the dcbz didn't execute) because the system will
at least keep running (for a while).

If you have a situation where you get a TLB Error without
a matching TLB miss (very rare, but they can happen as the
result of swapping, copy on write, certain other page table
updates), then you are hosed.  The DAR will contain some information
from a previous exception, we will likely end up on a "hung"
system continually taking TLB Error exceptions because we
can't fix them properly.  This is basically what happens
without the bit copying "fix".


> My older idea (fixing up MD_EPN and DAR based
> on the faulting instruction opcode and the involved
> GPR contents) should work even if we have neither
> a valid MD_EPN nor DAR.

All of the TLB exception handlers must have minimal instructions.
The ones in Linux are too big already.  The very little you would
gain from making a dcbz/dcbt work correctly would be lost many,
many, many times over in a more complex TLB exception handler.

Copying bits from MD_EPN to DAR doesn't set the DAR "correctly",
it only gives you the page boundary.  This is going to further
confuse debuggers or signal handlers if you actually have an
addressing bug that is detected by one of these instructions.

The only update I would like to see to TLB exception handlers is
the removal of code due to streamlining of the page table organization.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
