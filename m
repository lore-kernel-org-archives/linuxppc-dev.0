Message-ID: <3E81F6FD.2000407@embeddededge.com>
Date: Wed, 26 Mar 2003 13:52:45 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Till Straumann <strauman@SLAC.Stanford.EDU>,
	Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: dcbz works on 862 everywhere!
References: <IGEFJKJNHJDCBKALBJLLIEHKFLAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> hmm, why would not dcbz execute properly? Surely the instruction is restarted
> when the DTLB Miss/Error handler return?

Write a test to verify it.  I know there were cases in the past when
it didn't work.  You would notice it when you expected to have some
zero initialized spaces that weren't.

> In a earlier mail you said the there was a case where the "normal" instructions
> would not set MD_EPN in the DTLB Error handler and that it was documented.
> What case is this and where can I find this documentation?

Well, it's more of an interpretation of the documentation and discussions
with Motorola engineers.

> What this boils down to is that you don't known what register, DAR or MD_EPN to
> trust in the DTLB Error handler, right?

The registers we are discussing belong to two distinct functional areas.
The Mx_xxx registers are all part of the mmu functional unit and can serve
to be hardware assist to the software TLB management.  The DAR, DSISR, SRRx
and so on are part of the PowerPC core, set during exceptions and used by
fault handlers to determine the course of action for fault repair.  The
latter function is PowerPC generic, the former is unique to the 8xx
implementation.

I do not know why DAR is sometimes not set properly during some types
cache operation exceptions.  In general, cache operation exceptions
have been unpredictable in various ways across all of the different
silicon revisions.  Sometimes a dcbz to uncached space was ignored,
sometimes it generated an alignment exception (which is the correct
behavior), sometimes it generated tlb error exceptions, for example.

In all cases except some cache instructions, the DAR is properly set
for tlb error exceptions.  It has to be or the system won't function
properly, so there isn't any question as to whether we can trust it.

For TLB miss exceptions, the Mx_xxx hardware assist registers work
properly, as documented, to minimize the number of instructions needed
to determine what PTE to load.  The TLB miss exception has exactly
one function, to as quickly as possible locate the PTE from the table
hierarchy and stuff the bits into the MMU.  That's it and it should
really be implemented in five lines of code.

The interpretation of the value of the Mx_xxx registers during TLB Error
exceptions has always been under discussion.  Sometimes you can read they
should work like the TLB miss case, but since we aren't processing a
TLB miss exception, perhaps they aren't set.  Perhaps when it appears to
work it is the result of residual information from a previous TLB miss,
other times we know it has been set as the result of the exception.  In
any case, we know if we copy the bits from the DAR into the MD_EPN, we
can then use the hardware assist of these registers to perform the PTE
lookup just like the TLB miss function.

We optimize the update of the usage and dirty indicators in the PTE
right in the TLB Error exception function to more closely emulate "real"
PPC processors.  This way, we can use the same fault processing functions.
If we didn't wish to do this, we could simply call an 8xx specific version
of do_fault, in which case it doesn't matter what is in the Mx_xxx registers
because we would do a software lookup using DAR.  It wouldn't be as efficient
and we couldn't use a common PPC function, but we wouldn't have to question
the workings of the silicon in this case.

So, we can always trust DAR, it's just that MD_EPN is left to your interpretation
of the documentation and depends upon the implementation of the functions.

> Maybe Till Straumann's suggestion to set the DAR register to a known "bad" address
> when leaving an exception. Then test for this bad address in the DTLB error handler
> to decide what register to trust?

Not necessary.

By not "correctly" tracking usage and dirty pages, as we did in the past,
it caused us to never generate DTLB Error exceptions unless it was truly
an access to a non-recoverable bad address or if the page was swapped out.
I would just set 'used' on every instruction page and 'used + dirty' on
every data page allocation.  A static embedded system would just converge on
this point anyway, but in more dynamic systems it cost more real memory.

Of course, the 8xx has custom cache management/control functions that
have always seemed to work properly.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
