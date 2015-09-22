Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BEE131A060E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 01:25:55 +1000 (AEST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 22 Sep 2015 09:25:53 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D96E53E40044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 09:25:50 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8MFOdXd64815132
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 08:24:39 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8MFPlwg010797
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 09:25:49 -0600
Date: Tue, 22 Sep 2015 08:25:40 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 3/7] powerpc: atomic: Implement
 atomic{,64}_{add,sub}_return_* variants
Message-ID: <20150922152540.GO4029@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-4-git-send-email-boqun.feng@gmail.com>
 <20150918165902.GF12837@arm.com>
 <20150919153310.GB20458@fixme-laptop.cn.ibm.com>
 <20150920082303.GA1166@fixme-laptop.cn.ibm.com>
 <20150921222427.GG7356@arm.com>
 <20150921232656.GC970@fixme-laptop.cn.ibm.com>
 <20150921233704.GD970@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150921233704.GD970@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2015 at 07:37:04AM +0800, Boqun Feng wrote:
> On Tue, Sep 22, 2015 at 07:26:56AM +0800, Boqun Feng wrote:
> > On Mon, Sep 21, 2015 at 11:24:27PM +0100, Will Deacon wrote:
> > > Hi Boqun,
> > > 
> > > On Sun, Sep 20, 2015 at 09:23:03AM +0100, Boqun Feng wrote:
> > > > On Sat, Sep 19, 2015 at 11:33:10PM +0800, Boqun Feng wrote:
> > > > > On Fri, Sep 18, 2015 at 05:59:02PM +0100, Will Deacon wrote:
> > > > > > On Wed, Sep 16, 2015 at 04:49:31PM +0100, Boqun Feng wrote:
> > > > > > > On powerpc, we don't need a general memory barrier to achieve acquire and
> > > > > > > release semantics, so __atomic_op_{acquire,release} can be implemented
> > > > > > > using "lwsync" and "isync".
> > > > > > 
> > > > > > I'm assuming isync+ctrl isn't transitive, so we need to get to the bottom
> > > > > 
> > > > > Actually the transitivity is still guaranteed here, I think ;-)
> > > 
> > > The litmus test I'm thinking of is:
> > > 
> > > 
> > > {
> > > 0:r2=x;
> > > 1:r2=x; 1:r5=z;
> > > 2:r2=z; 2:r4=x;
> > > }
> > >  P0           | P1            | P2           ;
> > >  li r1,1      | lwz r1,0(r2)  | lwz r1,0(r2) ;
> > >  stw r1,0(r2) | cmpw r1,r1    | cmpw r1,r1   ;
> > >               | beq LC00      | beq  LC01    ;
> > >               | LC00:         | LC01:        ;
> > >               | isync         | isync        ;
> > >               | li r4,1       | lwz r3,0(r4) ;
> > >               | stw r4,0(r5)  |              ;
> > > exists
> > > (1:r1=1 /\ 2:r1=1 /\ 2:r3=0)
> > > 
> > > 
> > > Which appears to be allowed. I don't think you need to worry about backwards
> > > branches for the ctrl+isync construction (none of the current example do,
> > > afaict).
> > > 
> > 
> > Yes.. my care of backwards branches is not quite related to the topic, I
> > concerned that mostly because my test is using atomic operation, and I
> > just want to test the exact asm code.
> > 
> > > Anyway, all the problematic cases seem to arise when we start mixing
> > > ACQUIRE/RELEASE accesses with relaxed accesses (i.e. where an access from
> > > one group reads from an access in the other group). It would be simplest
> > > to say that this doesn't provide any transitivity guarantees, and that
> > > an ACQUIRE must always read from a RELEASE if transitivity is required.
> > > 
> > 
> > Agreed. RELEASE alone doesn't provide transitivity and transitivity is
>           ^^^^^^^
> This should be ACQUIRE...
> 
> > guaranteed only if an ACQUIRE read from a RELEASE. That's exactly the
> > direction which the link (https://lkml.org/lkml/2015/9/15/836) is
> > heading to. So I think we are fine here to use ctrl+isync here, right?

We are going to have to err on the side of strictness, that is, having
the documentation place more requirements on the developer than the union
of the hardware does.  Besides, I haven't heard any recent complaints
that memory-barriers.txt is too simple.  ;-)

							Thanx, Paul
