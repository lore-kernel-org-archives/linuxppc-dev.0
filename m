Date: Tue, 25 Mar 2003 15:02:28 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: dcbz works on 862 everywhere!
In-reply-to: <3E7FAF6E.1060509@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>,
	strauman@SLAC.Stanford.EDU
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLGEHAFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> After reading this I guess I need to further clarify what happens.....
>
> Dan Malek wrote:
>
> > ... The reason it "works" for you is you found the
> > most likely case where you took a DTLB miss, followed by a DTLB Error
> > to the same page...
>
> What happens in these cases (which occurs like almost all of the time),
> is there is "leftover" information in the control/status registers from
> previous exceptions that causes the fault processing to take place
> properly.  In some error conditions, the leftover information isn't
> exactly correct, causing the page fault handler to look up wrong
> information or the dcbz/dcbt to do their thing on the wrong address.
> If you are not running a specific test case and precisely testing
> for the results of the operation, you may not notice this or at some
> time in the future notice erratic system behavior that is impossible
> to explain.  The "normal" instructions have exactly one well documented
> failure case, in the case of DTLBError, the MD_EPN sometimes doesn't
> get the proper status, but we know the DAR does, so we can copy the
> bits we need from the DAR to the EPN to properly process the fault.
> The cache instructions have never been normal instructions.  In some
> versions of silicon they won't generate a fault, some will allow cache
> operations to uncached spaces, some will fault but not provide the
> proper status in any MMU register.  Sometimes they work, it all depends
> upon the state of the cache line and TLB.  The cases most likely to
> fail are the ones that are the hardest to create.

So maybe there still is silicon bugs which is visible in the DTLB Error handler.
Is there a problem with MD_EPN in DTLB Miss context?
We do know that the dcxx instructions (including those that are used by
xxx_dcache_range functions) does not update the DAR register. You say that
the rfi depends on DAR(I would like to know in what way, I can't find any info
about that) so should we not try to make sure that DAR contains a valid address
by copying the EPN from MD_EPN?

I have another idea: If you get a DTLB Error direcly after DTLB Miss for the
same page, DAR will NOT be updated(at least in some cases) and you "inherit"
the DAR from the preceeding DTLB Miss. I have tried to verify that but I have
not been able to construct a test case that will prove this. Any ideas on that one?

Either way the patch makes it possible to use dcbz in user space, I can remove
the "copy DAR to MD_EPN" part in the DTLB Error handler, restore the Change bit in
the pte for kernel space and still have a usable system, wheras doing any one of
these modifications without my patch resulted in hard lookups during boot.

That suggests to me that the DTLB Miss patch does some good.
Can you present a case where will be worse off with the DTLB Miss part of
my patch applied?

> I've spent way too much time working on this on many versions of
> silicon with the assistance of people from Motorola.  It isn't a trivial
> problem to detect, quantify and document so someone else can repeat
> the exercise.  Through the first four major versions of 860 silicon
> (and countless minor versions) the wrong behavior I discussed was
> fixed in the next release, only to have something else unexpected appear.
> Since I didn't want a career in cache instruction debugging (and I had
> products to get to market), the solution was to simply not use these
> instructions.

I do understand your position, but please consider that the current impl.
may still have bugs or can be improved upon so please don't dismiss any
attempt to make the 8xx CPUs perform better under linux.

Again, you don't have to enable the use of dcbz(yet :-). The DTLB Miss modification
should IMHO go in regardless, unless you find a case were it does not work.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
