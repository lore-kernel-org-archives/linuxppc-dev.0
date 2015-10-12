Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 683B51A0889
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 10:30:45 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 12 Oct 2015 17:30:43 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 00BB419D803E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 17:18:52 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9CNTOT910879330
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 16:29:24 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9CNUdkq029188
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 17:30:40 -0600
Date: Mon, 12 Oct 2015 16:30:48 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151012233048.GK3910@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008125937.GH16807@arm.com>
 <20151008221716.GF3910@linux.vnet.ibm.com>
 <20151009095129.GF26278@arm.com>
 <20151009174327.GV3910@linux.vnet.ibm.com>
 <20151009183328.GV26278@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151009183328.GV26278@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 09, 2015 at 07:33:28PM +0100, Will Deacon wrote:
> On Fri, Oct 09, 2015 at 10:43:27AM -0700, Paul E. McKenney wrote:
> > On Fri, Oct 09, 2015 at 10:51:29AM +0100, Will Deacon wrote:
> > > How do people feel about including these in memory-barriers.txt? I find
> > > them considerably easier to read than our current kernel code + list of
> > > possible orderings + wall of text, but there's a good chance that my
> > > brain has been corrupted from staring at this stuff for too long.
> > > 
> > > The only snag is the ppc assembly code, but it's not *too* horrific ;)
> > 
> > Maybe we should include them as separate files in Documentation/litmus
> > or some such.  We could then use a litmus-test style with Linux-kernel
> > C code, and reference litmus tests for various architectures.  Maybe
> > Documentation/litmus/{arm,arm64,powerpc,x86}/ and so on.
> 
> I think that would be useful, particularly if we had a way to "compile"
> a kernel litmus test into one for a particular architecture.

Very useful!  Probably some limitations, especially for loops and lock
acquisition, but what else is new?

> > For example, the first example in memory-barriers.txt is this:
> > 
> > ------------------------------------------------------------------------
> > 	CPU 1		CPU 2
> > 	===============	===============
> > 	{ A == 1; B == 2 }
> > 	A = 3;		x = B;
> > 	B = 4;		y = A;
> > 
> > The set of accesses as seen by the memory system in the middle can be arranged
> > in 24 different combinations:
> > 
> > 	STORE A=3,	STORE B=4,	y=LOAD A->3,	x=LOAD B->4
> > 	STORE A=3,	STORE B=4,	x=LOAD B->4,	y=LOAD A->3
> > 	STORE A=3,	y=LOAD A->3,	STORE B=4,	x=LOAD B->4
> > 	STORE A=3,	y=LOAD A->3,	x=LOAD B->2,	STORE B=4
> > 	STORE A=3,	x=LOAD B->2,	STORE B=4,	y=LOAD A->3
> > 	STORE A=3,	x=LOAD B->2,	y=LOAD A->3,	STORE B=4
> > 	STORE B=4,	STORE A=3,	y=LOAD A->3,	x=LOAD B->4
> > 	STORE B=4, ...
> > 	...
> > 
> > and can thus result in four different combinations of values:
> > 
> > 	x == 2, y == 1
> > 	x == 2, y == 3
> > 	x == 4, y == 1
> > 	x == 4, y == 3
> > ------------------------------------------------------------------------
> > > > Maybe this changes to:
> > 
> > ------------------------------------------------------------------------
> > Linux MP
> > ""
> > {
> > a=1; b=2;
> > }
> >  P0               | P1                ;
> >  WRITE_ONCE(a, 3) | r1 = READ_ONCE(b) ;
> >  WRITE_ONCE(b, 4) | r2 = READ_ONCE(a) ;
> > 
> > exists (2:r1=4 /\ 2:r2=3)
> > ------------------------------------------------------------------------
> > 
> > We can then state that this assertion can fail.  We could include
> > either ppcmem or herd output along with the litmus tests, which would
> > allow the curious to see a full list of the possible outcomes.
> 
> More importantly, it would allow them to make small changes to the test
> and see what the outcome is, without us having to spawn another
> thread-of-death on LKML :)

Or perhaps we could at least hope for thread-of-tool-supported-death
on LKML.  ;-)

> > > We could also include a link to the ppcmem/herd web frontends and your
> > > lwn.net article. (ppcmem is already linked, but it's not obvious that
> > > you can run litmus tests in your browser).
> > 
> > I bet that the URLs for the web frontends are not stable long term.
> > Don't get me wrong, PPCMEM/ARMMEM has been there for me for a goodly
> > number of years, but professors do occasionally move from one institution
> > to another.  For but one example, Susmit Sarkar is now at University
> > of St. Andrews rather than at Cambridge.
> > 
> > So to make this work, we probably need to be thinking in terms of
> > asking the researchers for permission to include their ocaml code in the
> > Linux-kernel source tree.  I would be strongly in favor of this, actually.
> > 
> > Thoughts?
> 
> I'm extremely hesitant to import a bunch of dubiously licensed, academic
> ocaml code into the kernel. Even if we did, who would maintain it?
> 
> A better solution might be to host a mirror of the code on kernel.org,
> along with a web front-end for people to play with (the tests we're talking
> about here do seem to run ok in my browser).

I am not too worried about how this happens, but we should avoid
constraining the work of our academic partners.  The reason I was thinking
in terms of in the kernel was to avoid version-synchronization issues.
"Wait, this is Linux kernel v4.17, which means that you need to use
version 8.3.5.1 of the tooling...  And with these four patches as well."

							Thanx, Paul
