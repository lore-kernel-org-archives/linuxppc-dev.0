Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B6EA1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2015 04:44:23 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 9 Oct 2015 11:44:20 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DE5941FF0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 11:31:37 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t99HeDRE10420704
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2015 10:40:13 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t99HhOXm014095
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2015 11:43:25 -0600
Date: Fri, 9 Oct 2015 10:43:27 -0700
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
Message-ID: <20151009174327.GV3910@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008125937.GH16807@arm.com>
 <20151008221716.GF3910@linux.vnet.ibm.com>
 <20151009095129.GF26278@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151009095129.GF26278@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 09, 2015 at 10:51:29AM +0100, Will Deacon wrote:
> Hi Paul,
> 
> On Thu, Oct 08, 2015 at 03:17:16PM -0700, Paul E. McKenney wrote:
> > On Thu, Oct 08, 2015 at 01:59:38PM +0100, Will Deacon wrote:
> > > I thought Paul was talking about something like this case:
> > > 
> > > CPU A     CPU B              CPU C
> > > foo = 1
> > > UNLOCK x
> > >           LOCK x
> > >           (RELEASE) bar = 1
> > >                              ACQUIRE bar = 1
> > >                              READ_ONCE foo = 0
> > 
> > More like this:
> > 
> > CPU A			CPU B			CPU C
> > WRITE_ONCE(foo, 1);
> > UNLOCK x
> > 			LOCK x
> > 			r1 = READ_ONCE(bar);
> > 						WRITE_ONCE(bar, 1);
> > 						smp_mb();
> > 						r2 = READ_ONCE(foo);
> > 
> > This can result in r1==0 && r2==0.
> 
> Thank you, that is extremely enlightening :)
> 
> > > I think we need a PPC litmus test illustrating the inter-thread, same
> > > lock failure case when smp_mb__after_unlock_lock is not present so that
> > > we can reason about this properly. Paul?
> > 
> > Please see above.  ;-)
> > 
> > The corresponding litmus tests are below.
> 
> How do people feel about including these in memory-barriers.txt? I find
> them considerably easier to read than our current kernel code + list of
> possible orderings + wall of text, but there's a good chance that my
> brain has been corrupted from staring at this stuff for too long.
> 
> The only snag is the ppc assembly code, but it's not *too* horrific ;)

Maybe we should include them as separate files in Documentation/litmus
or some such.  We could then use a litmus-test style with Linux-kernel
C code, and reference litmus tests for various architectures.  Maybe
Documentation/litmus/{arm,arm64,powerpc,x86}/ and so on.

For example, the first example in memory-barriers.txt is this:

------------------------------------------------------------------------
	CPU 1		CPU 2
	===============	===============
	{ A == 1; B == 2 }
	A = 3;		x = B;
	B = 4;		y = A;

The set of accesses as seen by the memory system in the middle can be arranged
in 24 different combinations:

	STORE A=3,	STORE B=4,	y=LOAD A->3,	x=LOAD B->4
	STORE A=3,	STORE B=4,	x=LOAD B->4,	y=LOAD A->3
	STORE A=3,	y=LOAD A->3,	STORE B=4,	x=LOAD B->4
	STORE A=3,	y=LOAD A->3,	x=LOAD B->2,	STORE B=4
	STORE A=3,	x=LOAD B->2,	STORE B=4,	y=LOAD A->3
	STORE A=3,	x=LOAD B->2,	y=LOAD A->3,	STORE B=4
	STORE B=4,	STORE A=3,	y=LOAD A->3,	x=LOAD B->4
	STORE B=4, ...
	...

and can thus result in four different combinations of values:

	x == 2, y == 1
	x == 2, y == 3
	x == 4, y == 1
	x == 4, y == 3
------------------------------------------------------------------------

Maybe this changes to:

------------------------------------------------------------------------
Linux MP
""
{
a=1; b=2;
}
 P0               | P1                ;
 WRITE_ONCE(a, 3) | r1 = READ_ONCE(b) ;
 WRITE_ONCE(b, 4) | r2 = READ_ONCE(a) ;

exists (2:r1=4 /\ 2:r2=3)
------------------------------------------------------------------------

We can then state that this assertion can fail.  We could include
either ppcmem or herd output along with the litmus tests, which would
allow the curious to see a full list of the possible outcomes.

> > PPC lock-2thread-WR-barrier.litmus
> > ""
> > (*
> >  * Does 3.0 Linux-kernel Power lock-unlock provide local 
> >  * barrier that orders prior stores against subsequent loads,
> >  * if the unlock and lock happen on different threads?
> >  * This version uses lwsync instead of isync.
> >  *)
> > (* 23-July-2013: ppcmem says "Sometimes" *)
> > {
> > l=1;
> > 0:r1=1;          0:r4=x;         0:r10=0;          0:r12=l;
> > 1:r1=1; 1:r3=42; 1:r4=x; 1:r5=y; 1:r10=0; 1:r11=0; 1:r12=l;
> > 2:r1=1;          2:r4=x; 2:r5=y;
> > }
> >  P0             | P1                 | P2;
> >  stw r1,0(r4)   | lwarx r11,r10,r12  | stw r1,0(r5) ;
> >  lwsync         | cmpwi r11,0        | lwsync       ;
> >  stw r10,0(r12) | bne Fail1          | lwz r7,0(r4) ;
> >                 | stwcx. r1,r10,r12  | ;
> >                 | bne Fail1          | ;
> >                 | isync              | ;
> >                 | lwz r3,0(r5)       | ;
> >                 | Fail1:             | ;
> > 
> > 
> > exists
> > (1:r3=0 /\ 2:r7=0)
> 
> We could also include a link to the ppcmem/herd web frontends and your
> lwn.net article. (ppcmem is already linked, but it's not obvious that
> you can run litmus tests in your browser).

I bet that the URLs for the web frontends are not stable long term.
Don't get me wrong, PPCMEM/ARMMEM has been there for me for a goodly
number of years, but professors do occasionally move from one institution
to another.  For but one example, Susmit Sarkar is now at University
of St. Andrews rather than at Cambridge.

So to make this work, we probably need to be thinking in terms of
asking the researchers for permission to include their ocaml code in the
Linux-kernel source tree.  I would be strongly in favor of this, actually.

Thoughts?

							Thanx, Paul
