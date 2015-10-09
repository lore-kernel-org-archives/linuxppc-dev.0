Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 088C61A0394
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2015 05:33:32 +1100 (AEDT)
Date: Fri, 9 Oct 2015 19:33:28 +0100
From: Will Deacon <will.deacon@arm.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151009183328.GV26278@arm.com>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008125937.GH16807@arm.com>
 <20151008221716.GF3910@linux.vnet.ibm.com>
 <20151009095129.GF26278@arm.com>
 <20151009174327.GV3910@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151009174327.GV3910@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 09, 2015 at 10:43:27AM -0700, Paul E. McKenney wrote:
> On Fri, Oct 09, 2015 at 10:51:29AM +0100, Will Deacon wrote:
> > How do people feel about including these in memory-barriers.txt? I find
> > them considerably easier to read than our current kernel code + list of
> > possible orderings + wall of text, but there's a good chance that my
> > brain has been corrupted from staring at this stuff for too long.
> > 
> > The only snag is the ppc assembly code, but it's not *too* horrific ;)
> 
> Maybe we should include them as separate files in Documentation/litmus
> or some such.  We could then use a litmus-test style with Linux-kernel
> C code, and reference litmus tests for various architectures.  Maybe
> Documentation/litmus/{arm,arm64,powerpc,x86}/ and so on.

I think that would be useful, particularly if we had a way to "compile"
a kernel litmus test into one for a particular architecture.

> For example, the first example in memory-barriers.txt is this:
> 
> ------------------------------------------------------------------------
> 	CPU 1		CPU 2
> 	===============	===============
> 	{ A == 1; B == 2 }
> 	A = 3;		x = B;
> 	B = 4;		y = A;
> 
> The set of accesses as seen by the memory system in the middle can be arranged
> in 24 different combinations:
> 
> 	STORE A=3,	STORE B=4,	y=LOAD A->3,	x=LOAD B->4
> 	STORE A=3,	STORE B=4,	x=LOAD B->4,	y=LOAD A->3
> 	STORE A=3,	y=LOAD A->3,	STORE B=4,	x=LOAD B->4
> 	STORE A=3,	y=LOAD A->3,	x=LOAD B->2,	STORE B=4
> 	STORE A=3,	x=LOAD B->2,	STORE B=4,	y=LOAD A->3
> 	STORE A=3,	x=LOAD B->2,	y=LOAD A->3,	STORE B=4
> 	STORE B=4,	STORE A=3,	y=LOAD A->3,	x=LOAD B->4
> 	STORE B=4, ...
> 	...
> 
> and can thus result in four different combinations of values:
> 
> 	x == 2, y == 1
> 	x == 2, y == 3
> 	x == 4, y == 1
> 	x == 4, y == 3
> ------------------------------------------------------------------------
> 
> Maybe this changes to:
> 
> ------------------------------------------------------------------------
> Linux MP
> ""
> {
> a=1; b=2;
> }
>  P0               | P1                ;
>  WRITE_ONCE(a, 3) | r1 = READ_ONCE(b) ;
>  WRITE_ONCE(b, 4) | r2 = READ_ONCE(a) ;
> 
> exists (2:r1=4 /\ 2:r2=3)
> ------------------------------------------------------------------------
> 
> We can then state that this assertion can fail.  We could include
> either ppcmem or herd output along with the litmus tests, which would
> allow the curious to see a full list of the possible outcomes.

More importantly, it would allow them to make small changes to the test
and see what the outcome is, without us having to spawn another
thread-of-death on LKML :)

> > We could also include a link to the ppcmem/herd web frontends and your
> > lwn.net article. (ppcmem is already linked, but it's not obvious that
> > you can run litmus tests in your browser).
> 
> I bet that the URLs for the web frontends are not stable long term.
> Don't get me wrong, PPCMEM/ARMMEM has been there for me for a goodly
> number of years, but professors do occasionally move from one institution
> to another.  For but one example, Susmit Sarkar is now at University
> of St. Andrews rather than at Cambridge.
> 
> So to make this work, we probably need to be thinking in terms of
> asking the researchers for permission to include their ocaml code in the
> Linux-kernel source tree.  I would be strongly in favor of this, actually.
> 
> Thoughts?

I'm extremely hesitant to import a bunch of dubiously licensed, academic
ocaml code into the kernel. Even if we did, who would maintain it?

A better solution might be to host a mirror of the code on kernel.org,
along with a web front-end for people to play with (the tests we're talking
about here do seem to run ok in my browser).

Will
