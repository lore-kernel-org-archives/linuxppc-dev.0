Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 39D351A1E05
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 05:00:34 +1000 (AEST)
Date: Tue, 1 Sep 2015 20:00:27 +0100
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC 3/5] powerpc: atomic: implement
 atomic{,64}_{add,sub}_return_* variants
Message-ID: <20150901190027.GP1612@arm.com>
References: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
 <1440730099-29133-4-git-send-email-boqun.feng@gmail.com>
 <20150828104854.GB16853@twins.programming.kicks-ass.net>
 <20150828120614.GC29325@fixme-laptop.cn.ibm.com>
 <20150828141602.GA924@fixme-laptop.cn.ibm.com>
 <20150828153921.GF19282@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150828153921.GF19282@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 28, 2015 at 04:39:21PM +0100, Peter Zijlstra wrote:
> On Fri, Aug 28, 2015 at 10:16:02PM +0800, Boqun Feng wrote:
> > Ah.. just read through the thread you mentioned, I might misunderstand
> > you, probably because I didn't understand RCpc well..
> > 
> > You are saying that in a RELEASE we -might- switch from smp_lwsync() to
> > smp_mb() semantically, right? I guess this means we -might- switch from
> > RCpc to RCsc, right?
> > 
> > If so, I think I'd better to wait until we have a conclusion for this.
> 
> Yes, the difference between RCpc and RCsc is in the meaning of RELEASE +
> ACQUIRE. With RCsc that implies a full memory barrier, with RCpc it does
> not.

We've discussed this before, but for the sake of completeness, I don't
think we're fully RCsc either because we don't order the actual RELEASE
operation again a subsequent ACQUIRE operation:


P0
smp_store_release(&x, 1);
foo = smp_load_acquire(&y);

P1
smp_store_release(&y, 1);
bar = smp_load_acquire(&x);

We allow foo == bar == 0, which is prohibited by SC.


However, we *do* enforce ordering on any prior or subsequent accesses
for the code snippet above (the release and acquire combine to give a
full barrier), which makes these primitives well suited to things like
message passing.

Will
