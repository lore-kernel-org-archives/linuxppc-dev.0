Date: Wed, 26 Mar 2003 18:04:00 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: dcbz works on 862 everywhere!
In-reply-to: <3E81C4B3.2080006@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>,
	Till Straumann <strauman@SLAC.Stanford.EDU>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLIEHKFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Till Straumann wrote:
>
> > I found that 'dcbz' (while failing to set DAR)
> > indeed sets MD_EPN correctly. Hence, Jocke's fix
> > (copy EPN[0:19]->DAR) would handle that.
>
>
> After sleeping for a couple of days and consuming large
> amounts of medicine to cure a cold, I think I understand
> why copying these bits around seems to "fix" problems.

Sleeping is also good, I wish I got some more of that too :-)

>
> It's all related to the sequence of TLB miss/error exceptions
> that I had been describing all along.  The first thing that
> is going to most likely happen is you will get a TLB miss to
> load a PTE  into the TLB.  It will be marked valid but not
> dirty (not writable).  Immediately upon performing the rfi
> you will get a TLB Error to handle the dirty PTE update.
> By copying the bits from MD_EPN to the DAR in the miss handler,
> the Error handler will have at least a 4K boundary aligned DAR
> and it will execute correctly to update the dirty state.

Yes, that's the conclusion I came to too.

> At this point, it will appear to "work" properly (even though
> it is likely the dcbz didn't execute)

hmm, why would not dcbz execute properly? Surely the instruction is restarted
when the DTLB Miss/Error handler return?

> because the system will
> at least keep running (for a while).
>
> If you have a situation where you get a TLB Error without
> a matching TLB miss (very rare, but they can happen as the
> result of swapping, copy on write, certain other page table
> updates), then you are hosed.  The DAR will contain some information
> from a previous exception, we will likely end up on a "hung"
> system continually taking TLB Error exceptions because we
> can't fix them properly.  This is basically what happens
> without the bit copying "fix".

In a earlier mail you said the there was a case where the "normal" instructions
would not set MD_EPN in the DTLB Error handler and that it was documented.
What case is this and where can I find this documentation?

What this boils down to is that you don't known what register, DAR or MD_EPN to
trust in the DTLB Error handler, right?

Maybe Till Straumann's suggestion to set the DAR register to a known "bad" address
when leaving an exception. Then test for this bad address in the DTLB error handler
to decide what register to trust?

Note that the other dcxx instructions(according to Till) does not set DAR either
so if a dcbi ever causes a
 1) DTLB Miss followed by a DTLB Error
 2) DTLB Miss taking the DataAccess path
 3) DTLB Error taking the DataAccess path*
 4) DTLB Error not the DataAccess path*
* = I assume that these does not update DAR either, can anyone confirm this?
then you are also hosed. My patch will at least fix 1 and 2.

  Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
