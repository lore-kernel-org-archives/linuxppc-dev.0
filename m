Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B096F1A02A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 09:17:20 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 16:17:18 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 5D6AA1FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 16:05:28 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t98MGHNG1573174
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2015 15:16:17 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t98MHFSf025476
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2015 16:17:15 -0600
Date: Thu, 8 Oct 2015 15:17:16 -0700
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
Message-ID: <20151008221716.GF3910@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008125937.GH16807@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151008125937.GH16807@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 08, 2015 at 01:59:38PM +0100, Will Deacon wrote:
> On Thu, Oct 08, 2015 at 01:16:38PM +0200, Peter Zijlstra wrote:
> > On Thu, Oct 08, 2015 at 02:50:36PM +1100, Michael Ellerman wrote:
> > > On Wed, 2015-10-07 at 08:25 -0700, Paul E. McKenney wrote:
> > 
> > > > Currently, we do need smp_mb__after_unlock_lock() to be after the
> > > > acquisition on PPC -- putting it between the unlock and the lock
> > > > of course doesn't cut it for the cross-thread unlock/lock case.
> > 
> > This ^, that makes me think I don't understand
> > smp_mb__after_unlock_lock.
> > 
> > How is:
> > 
> > 	UNLOCK x
> > 	smp_mb__after_unlock_lock()
> > 	LOCK y
> > 
> > a problem? That's still a full barrier.
> 
> I thought Paul was talking about something like this case:
> 
> CPU A     CPU B              CPU C
> foo = 1
> UNLOCK x
>           LOCK x
>           (RELEASE) bar = 1
>                              ACQUIRE bar = 1
>                              READ_ONCE foo = 0

More like this:

CPU A			CPU B			CPU C
WRITE_ONCE(foo, 1);
UNLOCK x
			LOCK x
			r1 = READ_ONCE(bar);
						WRITE_ONCE(bar, 1);
						smp_mb();
						r2 = READ_ONCE(foo);

This can result in r1==0 && r2==0.

> but this looks the same as ISA2+lwsyncs/ISA2+lwsync+ctrlisync+lwsync,
> which are both forbidden on PPC, so now I'm also confused.
> 
> The different-lock, same thread case is more straight-forward, I think.

Indeed it is:

CPU A			CPU B
WRITE_ONCE(foo, 1);
UNLOCK x
LOCK x
r1 = READ_ONCE(bar);
			WRITE_ONCE(bar, 1);
			smp_mb();
			r2 = READ_ONCE(foo);

This also can result in r1==0 && r2==0.

> > > > I am with Peter -- we do need the benchmark results for PPC.
> > > 
> > > Urgh, sorry guys. I have been slowly doing some benchmarks, but time is not
> > > plentiful at the moment.
> > > 
> > > If we do a straight lwsync -> sync conversion for unlock it looks like that
> > > will cost us ~4.2% on Anton's standard context switch benchmark.
> 
> Thanks Michael!
> 
> > And that does not seem to agree with Paul's smp_mb__after_unlock_lock()
> > usage and would not be sufficient for the same (as of yet unexplained)
> > reason.
> > 
> > Why does it matter which of the LOCK or UNLOCK gets promoted to full
> > barrier on PPC in order to become RCsc?
> 
> I think we need a PPC litmus test illustrating the inter-thread, same
> lock failure case when smp_mb__after_unlock_lock is not present so that
> we can reason about this properly. Paul?

Please see above.  ;-)

The corresponding litmus tests are below.

							Thanx, Paul

------------------------------------------------------------------------

PPC lock-2thread-WR-barrier.litmus
""
(*
 * Does 3.0 Linux-kernel Power lock-unlock provide local 
 * barrier that orders prior stores against subsequent loads,
 * if the unlock and lock happen on different threads?
 * This version uses lwsync instead of isync.
 *)
(* 23-July-2013: ppcmem says "Sometimes" *)
{
l=1;
0:r1=1;          0:r4=x;         0:r10=0;          0:r12=l;
1:r1=1; 1:r3=42; 1:r4=x; 1:r5=y; 1:r10=0; 1:r11=0; 1:r12=l;
2:r1=1;          2:r4=x; 2:r5=y;
}
 P0             | P1                 | P2;
 stw r1,0(r4)   | lwarx r11,r10,r12  | stw r1,0(r5) ;
 lwsync         | cmpwi r11,0        | lwsync       ;
 stw r10,0(r12) | bne Fail1          | lwz r7,0(r4) ;
                | stwcx. r1,r10,r12  | ;
                | bne Fail1          | ;
                | isync              | ;
                | lwz r3,0(r5)       | ;
                | Fail1:             | ;


exists
(1:r3=0 /\ 2:r7=0)

------------------------------------------------------------------------

PPC lock-1thread-WR-barrier.litmus
""
(*
 * Does 3.0 Linux-kernel Power lock-unlock provide local 
 * barrier that orders prior stores against subsequent loads,
 * if the unlock and lock happen in the same thread?
 * This version uses lwsync instead of isync.
 *)
(* 8-Oct-2015: ppcmem says "Sometimes" *)
{
l=1;
0:r1=1; 0:r3=42; 0:r4=x; 0:r5=y; 0:r10=0; 0:r11=0; 0:r12=l;
1:r1=1;          1:r4=x; 1:r5=y;
}
 P0                | P1           ;
 stw r1,0(r4)      | stw r1,0(r5) ;
 lwsync            | lwsync       ;
 stw r10,0(r12)    | lwz r7,0(r4) ;
 lwarx r11,r10,r12 |              ;
 cmpwi r11,0       |              ;
 bne Fail1         |              ;
 stwcx. r1,r10,r12 |              ;
 bne Fail1         |              ;
 isync             |              ;
 lwz r3,0(r5)      |              ;
 Fail1:            |              ;


exists
(0:r3=0 /\ 1:r7=0)
