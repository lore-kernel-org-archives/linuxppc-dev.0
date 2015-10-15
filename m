Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BDB11A0681
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 03:29:49 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 15 Oct 2015 10:29:47 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id AA7503E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 10:29:42 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9FGQRYm5570940
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 09:26:27 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9FGTeLt027930
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 10:29:42 -0600
Date: Thu, 15 Oct 2015 09:29:42 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151015162942.GI3910@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151014210419.GY3604@twins.programming.kicks-ass.net>
 <20151014214453.GC3910@linux.vnet.ibm.com>
 <20151015103510.GA27524@arm.com> <20151015145044.GG29301@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151015145044.GG29301@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 15, 2015 at 03:50:44PM +0100, Will Deacon wrote:
> On Thu, Oct 15, 2015 at 11:35:10AM +0100, Will Deacon wrote:
> > Dammit guys, it's never simple is it?
> 
> I re-read this and it's even more confusing than I first thought.
> 
> > On Wed, Oct 14, 2015 at 02:44:53PM -0700, Paul E. McKenney wrote:
> > > To that end, the herd tool can make a diagram of what it thought
> > > happened, and I have attached it.  I used this diagram to try and force
> > > this scenario at https://www.cl.cam.ac.uk/~pes20/ppcmem/index.html#PPC,
> > > and succeeded.  Here is the sequence of events:
> > > 
> > > o	Commit P0's write.  The model offers to propagate this write
> > > 	to the coherence point and to P1, but don't do so yet.
> > > 
> > > o	Commit P1's write.  Similar offers, but don't take them up yet.
> > > 
> > > o	Commit P0's lwsync.
> > > 
> > > o	Execute P0's lwarx, which reads a=0.  Then commit it.
> > > 
> > > o	Commit P0's stwcx. as successful.  This stores a=1.
> > 
> > On arm64, this is a conditional-store-*release* and therefore cannot be
> > observed before the initial write to x...
> > 
> > > o	Commit P0's branch (not taken).
> > > 
> > > o	Commit P0's final register-to-register move.
> > > 
> > > o	Commit P1's sync instruction.
> > > 
> > > o	There is now nothing that can happen in either processor.
> > > 	P0 is done, and P1 is waiting for its sync.  Therefore,
> > > 	propagate P1's a=2 write to the coherence point and to
> > > 	the other thread.
> > 
> > ... therefore this is illegal, because you haven't yet propagated that
> > prior write...
> 
> I misread this as a propagation of PO's conditional store. What actually
> happens on arm64, is that the early conditional store can only succeed
> once it is placed into the coherence order of the location which it is
> updating (but note that this is subtly different from multi-copy
> atomicity!).
> 
> So, given that the previous conditional store succeeded, the coherence
> order on A must be either {0, 1, 2} or {0, 2, 1}.
> 
> If it's {0, 1, 2} (as required by your complete example), that means
> P1's a=2 write "observes" the conditional store by P0, and therefore
> (because the conditional store has release semantics), also observes
> P0's x=1 write.
> 
> On the other hand, if P1's a=2 write propagates first and we have a
> coherence order of {0, 2, 1}, then P0 must have r3=2, because an
> exclusive load returning zero would have led to a failed conditional
> store thanks to the intervening write by P1.
> 
> I find it pretty weird if PPC allows the conditional store to succeed in
> this way, as I think that would break simple cases like two threads
> incrementing a shared variable in parallel:
> 
> 
> ""
> {
> 0:r1=1; 0:r3=3; 0:r10=0 ; 0:r11=0; 0:r12=a;
> 1:r1=1; 1:r3=3; 1:r10=0 ; 1:r11=0; 1:r12=a;
> }
> P0                 | P1                 ;
> lwarx  r11,r10,r12 | lwarx  r11,r10,r12 ;
> add r11,r1,r11     | add r11,r1,r11     ;
> stwcx. r11,r10,r12 | stwcx. r11,r10,r12 ;
> bne Fail0          | bne Fail1          ;
> mr r3,r1           | mr r3,r1           ;
> Fail0:             | Fail1:             ;
> exists
> (0:r3=1 /\ a=1 /\ 1:r3=1)
> 
> 
> Is also allowed by herd and forbidden by ppcmem, for example.

I had no idea that either herd or ppcmem knew about the add instruction.
It looks like they at least try to understand.  Needless to say, in this
case I agree with ppcmem.

							Thanx, Paul
