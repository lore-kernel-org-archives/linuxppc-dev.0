Message-ID: <3E7FAF6E.1060509@embeddededge.com>
Date: Mon, 24 Mar 2003 20:22:54 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>,
	strauman@SLAC.Stanford.EDU
Subject: Re: dcbz works on 862 everywhere!
References: <IGEFJKJNHJDCBKALBJLLEEGBFLAA.joakim.tjernlund@lumentis.se> <20030324201543.GB14264@ip68-0-152-218.tc.ph.cox.net> <006601c2f256$e6ff5e80$020120b0@jockeXP> <3E7F9017.2000900@embeddededge.com> <000b01c2f261$292427a0$020120b0@jockeXP> <3E7FA758.20808@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


After reading this I guess I need to further clarify what happens.....

Dan Malek wrote:

> ... The reason it "works" for you is you found the
> most likely case where you took a DTLB miss, followed by a DTLB Error
> to the same page...

What happens in these cases (which occurs like almost all of the time),
is there is "leftover" information in the control/status registers from
previous exceptions that causes the fault processing to take place
properly.  In some error conditions, the leftover information isn't
exactly correct, causing the page fault handler to look up wrong
information or the dcbz/dcbt to do their thing on the wrong address.
If you are not running a specific test case and precisely testing
for the results of the operation, you may not notice this or at some
time in the future notice erratic system behavior that is impossible
to explain.  The "normal" instructions have exactly one well documented
failure case, in the case of DTLBError, the MD_EPN sometimes doesn't
get the proper status, but we know the DAR does, so we can copy the
bits we need from the DAR to the EPN to properly process the fault.
The cache instructions have never been normal instructions.  In some
versions of silicon they won't generate a fault, some will allow cache
operations to uncached spaces, some will fault but not provide the
proper status in any MMU register.  Sometimes they work, it all depends
upon the state of the cache line and TLB.  The cases most likely to
fail are the ones that are the hardest to create.

I've spent way too much time working on this on many versions of
silicon with the assistance of people from Motorola.  It isn't a trivial
problem to detect, quantify and document so someone else can repeat
the exercise.  Through the first four major versions of 860 silicon
(and countless minor versions) the wrong behavior I discussed was
fixed in the next release, only to have something else unexpected appear.
Since I didn't want a career in cache instruction debugging (and I had
products to get to market), the solution was to simply not use these
instructions.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
