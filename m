Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63A5A1A009D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Dec 2015 18:53:46 +1100 (AEDT)
Message-ID: <1451202819.29722.1.camel@ellerman.id.au>
Subject: Re: [PATCH powerpc/next v6 0/4] atomics: powerpc: Implement
 relaxed/acquire/release variants
From: Michael Ellerman <mpe@ellerman.id.au>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon
 <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>
Date: Sun, 27 Dec 2015 18:53:39 +1100
In-Reply-To: <20151223105410.GA18401@fixme-laptop.cn.ibm.com>
References: <1450189457-10589-1-git-send-email-boqun.feng@gmail.com>
 <1450838405.5036.6.camel@ellerman.id.au>
 <20151223105410.GA18401@fixme-laptop.cn.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-12-23 at 18:54 +0800, Boqun Feng wrote:
> On Wed, Dec 23, 2015 at 01:40:05PM +1100, Michael Ellerman wrote:
> > On Tue, 2015-12-15 at 22:24 +0800, Boqun Feng wrote:
> > > Hi all,
> > > 
> > > This is v6 of the series.
> > > 
> > > Link for v1: https://lkml.org/lkml/2015/8/27/798
> > > Link for v2: https://lkml.org/lkml/2015/9/16/527
> > > Link for v3: https://lkml.org/lkml/2015/10/12/368
> > > Link for v4: https://lkml.org/lkml/2015/10/14/670
> > > Link for v5: https://lkml.org/lkml/2015/10/26/141
> > > 
> > > 
> > > Changes since v5:
> > > 
> > > *	rebase on the next branch of powerpc.
> > > 
> > > *	pull two fix and one testcase patches out, which are already
> > > 	sent separately
> > > 
> > > *	some clean up or code format fixing.
> > > 
> > > 
> > > Paul, Peter and Will, thank you for your comments and suggestions in the review
> > > of previous versions. From this version on, This series is against the next
> > > branch of powerpc tree, because most of the code touch arch/powerpc/*.
> > 
> > 
> > Sorry if we already discussed this, but did we decide how we were going to
> > merge this? There's the one patch to generic code and then three powerpc
> > patches.
> > 
> > It'd make most sense for it to go via powerpc I think. Given that the change to
> > generic code is relatively trivial I'll plan to merge this unless someone
> > objects.
> > 
> > Also it is pretty late in the -next cycle for something like this. But AFAICS
> > there are no users of these "atomic*relaxed" variants yet other than arm64 code
> > and qspinlocks, neither of which are used on powerpc. So adding them should be
> > pretty harmless.
> > 
> 
> There is one thing we should be aware of, that is the bug:
> 
> http://lkml.kernel.org/r/5669D5F2.5050004@caviumnetworks.com
> 
> which though has been fixed by:
> 
> http://lkml.kernel.org/r/20151217160549.GH6344@twins.programming.kicks-ass.net
> 
> but the fix is not in powerpc/next right now. As this patchset makes
> atomic_xchg_acquire a real ACQUIRE, so we will also trigger that bug if
> this series gets merged in the next branch of powerpc tree, though
> that's not the problem of this patchset.
> 
> Not sure whether this is a problem for your maintence, but just think
> it's better to make you aware of this ;-)

Yes that's pretty important thank you :)

It's not so much that bug that's important, but the fact that I completely
forget about the acquire/release implementations. Those are used already in
mainline and so we don't want to add implementations this late in the cycle
without wider testing.

So I'll have to push this series until 4.6 so it can get some time in -next.
Sorry!

cheers
