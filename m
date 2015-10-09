Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 411D71A038D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 20:51:33 +1100 (AEDT)
Date: Fri, 9 Oct 2015 10:51:29 +0100
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
Message-ID: <20151009095129.GF26278@arm.com>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008125937.GH16807@arm.com>
 <20151008221716.GF3910@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151008221716.GF3910@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

On Thu, Oct 08, 2015 at 03:17:16PM -0700, Paul E. McKenney wrote:
> On Thu, Oct 08, 2015 at 01:59:38PM +0100, Will Deacon wrote:
> > I thought Paul was talking about something like this case:
> > 
> > CPU A     CPU B              CPU C
> > foo = 1
> > UNLOCK x
> >           LOCK x
> >           (RELEASE) bar = 1
> >                              ACQUIRE bar = 1
> >                              READ_ONCE foo = 0
> 
> More like this:
> 
> CPU A			CPU B			CPU C
> WRITE_ONCE(foo, 1);
> UNLOCK x
> 			LOCK x
> 			r1 = READ_ONCE(bar);
> 						WRITE_ONCE(bar, 1);
> 						smp_mb();
> 						r2 = READ_ONCE(foo);
> 
> This can result in r1==0 && r2==0.

Thank you, that is extremely enlightening :)

> > I think we need a PPC litmus test illustrating the inter-thread, same
> > lock failure case when smp_mb__after_unlock_lock is not present so that
> > we can reason about this properly. Paul?
> 
> Please see above.  ;-)
> 
> The corresponding litmus tests are below.

How do people feel about including these in memory-barriers.txt? I find
them considerably easier to read than our current kernel code + list of
possible orderings + wall of text, but there's a good chance that my
brain has been corrupted from staring at this stuff for too long.

The only snag is the ppc assembly code, but it's not *too* horrific ;)

> PPC lock-2thread-WR-barrier.litmus
> ""
> (*
>  * Does 3.0 Linux-kernel Power lock-unlock provide local 
>  * barrier that orders prior stores against subsequent loads,
>  * if the unlock and lock happen on different threads?
>  * This version uses lwsync instead of isync.
>  *)
> (* 23-July-2013: ppcmem says "Sometimes" *)
> {
> l=1;
> 0:r1=1;          0:r4=x;         0:r10=0;          0:r12=l;
> 1:r1=1; 1:r3=42; 1:r4=x; 1:r5=y; 1:r10=0; 1:r11=0; 1:r12=l;
> 2:r1=1;          2:r4=x; 2:r5=y;
> }
>  P0             | P1                 | P2;
>  stw r1,0(r4)   | lwarx r11,r10,r12  | stw r1,0(r5) ;
>  lwsync         | cmpwi r11,0        | lwsync       ;
>  stw r10,0(r12) | bne Fail1          | lwz r7,0(r4) ;
>                 | stwcx. r1,r10,r12  | ;
>                 | bne Fail1          | ;
>                 | isync              | ;
>                 | lwz r3,0(r5)       | ;
>                 | Fail1:             | ;
> 
> 
> exists
> (1:r3=0 /\ 2:r7=0)

We could also include a link to the ppcmem/herd web frontends and your
lwn.net article. (ppcmem is already linked, but it's not obvious that
you can run litmus tests in your browser).

Will
