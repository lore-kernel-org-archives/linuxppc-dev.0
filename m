Message-ID: <3E7FA758.20808@embeddededge.com>
Date: Mon, 24 Mar 2003 19:48:24 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc.  Org" <linuxppc-embedded@lists.linuxppc.org>,
	strauman@SLAC.Stanford.EDU
Subject: Re: dcbz works on 862 everywhere!
References: <IGEFJKJNHJDCBKALBJLLEEGBFLAA.joakim.tjernlund@lumentis.se> <20030324201543.GB14264@ip68-0-152-218.tc.ph.cox.net> <006601c2f256$e6ff5e80$020120b0@jockeXP> <3E7F9017.2000900@embeddededge.com> <000b01c2f261$292427a0$020120b0@jockeXP>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:


> Did you read my mails?

I did.  From this I gathered that you don't understand why some
of this code is there in the first place, you removed code that
would have guaranteed to cause an error if you would have run
the proper test, and you can't explain why the changes you made
cause the results you see.  Not something that instills much
confidence.

All of these MMU and cache control registers have effects on
one another.  Writing one register can have the side effect of
updating another.  The DAR must have valid addresses in order
to properly rfi, we know some cache operations may not set this
properly, and we also know that in these cases the MD_EPN is also
not set properly.  The reason it "works" for you is you found the
most likely case where you took a DTLB miss, followed by a DTLB Error
to the same page (or at least to valid pages).  If the miss/error
sequence was to the same page, it will likely work correctly.  If the
miss/error sequence is not to the same pages, it could appear
to "work" but chances are the dcbz was not executed properly and
you didn't notice the side effects of that.  If you happen to
find the case where you generate the DTLB miss/error/error with
intervening TLB exceptions for other pages (like when swapping)
and the instructions involved are cache instructions (like the
dcbi in the comment example), you will end up with a big mess.
It's really hard to generate all of these test cases, and you
can't always use Linux to do so, but eventually Linux will stumble
across them.

For a long time, we "solved" these problems on 8xx by not properly
implementing copy-on-write pages and always marking pages dirty.
It reduced the likelyhood of the problem, reduced the MMU overhead,
but cost lots more in memory and processing time during forks.
This still may not be a bad configuration option for selected
applications.

Like I said from the beginning, the 100% guaranteed working solution
is to not use dcbz/dcbt on the 8xx.  Anything else will eventually
stumble across the error conditions.  If I'm developing a product
that uses Linux (or any other OS that will dynamically update the MMU
and take DTLB exceptions) I won't take the risk of failure using
these instructions.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
