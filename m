Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3BB591A023F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 08:24:31 +1000 (AEST)
Date: Mon, 21 Sep 2015 23:24:27 +0100
From: Will Deacon <will.deacon@arm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 3/7] powerpc: atomic: Implement
 atomic{,64}_{add,sub}_return_* variants
Message-ID: <20150921222427.GG7356@arm.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-4-git-send-email-boqun.feng@gmail.com>
 <20150918165902.GF12837@arm.com>
 <20150919153310.GB20458@fixme-laptop.cn.ibm.com>
 <20150920082303.GA1166@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150920082303.GA1166@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Boqun,

On Sun, Sep 20, 2015 at 09:23:03AM +0100, Boqun Feng wrote:
> On Sat, Sep 19, 2015 at 11:33:10PM +0800, Boqun Feng wrote:
> > On Fri, Sep 18, 2015 at 05:59:02PM +0100, Will Deacon wrote:
> > > On Wed, Sep 16, 2015 at 04:49:31PM +0100, Boqun Feng wrote:
> > > > On powerpc, we don't need a general memory barrier to achieve acquire and
> > > > release semantics, so __atomic_op_{acquire,release} can be implemented
> > > > using "lwsync" and "isync".
> > > 
> > > I'm assuming isync+ctrl isn't transitive, so we need to get to the bottom
> > 
> > Actually the transitivity is still guaranteed here, I think ;-)

The litmus test I'm thinking of is:


{
0:r2=x;
1:r2=x; 1:r5=z;
2:r2=z; 2:r4=x;
}
 P0           | P1            | P2           ;
 li r1,1      | lwz r1,0(r2)  | lwz r1,0(r2) ;
 stw r1,0(r2) | cmpw r1,r1    | cmpw r1,r1   ;
              | beq LC00      | beq  LC01    ;
              | LC00:         | LC01:        ;
              | isync         | isync        ;
              | li r4,1       | lwz r3,0(r4) ;
              | stw r4,0(r5)  |              ;
exists
(1:r1=1 /\ 2:r1=1 /\ 2:r3=0)


Which appears to be allowed. I don't think you need to worry about backwards
branches for the ctrl+isync construction (none of the current example do,
afaict).

Anyway, all the problematic cases seem to arise when we start mixing
ACQUIRE/RELEASE accesses with relaxed accesses (i.e. where an access from
one group reads from an access in the other group). It would be simplest
to say that this doesn't provide any transitivity guarantees, and that
an ACQUIRE must always read from a RELEASE if transitivity is required.

Will
