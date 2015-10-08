Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 097071A0018
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 14:50:37 +1100 (AEDT)
Message-ID: <1444276236.9940.5.camel@ellerman.id.au>
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
From: Michael Ellerman <mpe@ellerman.id.au>
To: paulmck@linux.vnet.ibm.com
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra
 <peterz@infradead.org>,  linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, Anton
 Blanchard <anton@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Thu, 08 Oct 2015 14:50:36 +1100
In-Reply-To: <20151007152501.GI3910@linux.vnet.ibm.com>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com> <20151007152501.GI3910@linux.vnet.ibm.com>
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

On Wed, 2015-10-07 at 08:25 -0700, Paul E. McKenney wrote:
> On Wed, Oct 07, 2015 at 02:23:17PM +0100, Will Deacon wrote:
> > Hi Peter,
> > 
> > Thanks for the headache ;)
> > 
> > On Wed, Oct 07, 2015 at 01:19:15PM +0200, Peter Zijlstra wrote:
> > > On Wed, Oct 07, 2015 at 11:59:28AM +0100, Will Deacon wrote:
> > > > As much as we'd like to live in a world where RELEASE -> ACQUIRE is
> > > > always cheaply ordered and can be used to construct UNLOCK -> LOCK
> > > > definitions with similar guarantees, the grim reality is that this isn't
> > > > even possible on x86 (thanks to Paul for bringing us crashing down to
> > > > Earth).
> > > > 
> > > > This patch handles the issue by introducing a new barrier macro,
> > > > smp_mb__release_acquire, that can be placed between a RELEASE and a
> > > > subsequent ACQUIRE operation in order to upgrade them to a full memory
> > > > barrier. At the moment, it doesn't have any users, so its existence
> > > > serves mainly as a documentation aid.
> > > 
> > > Does we want to go revert 12d560f4ea87 ("rcu,locking: Privatize
> > > smp_mb__after_unlock_lock()") for that same reason?
> > 
> > I don't think we want a straight revert. smp_mb__after_unlock_lock could
> > largely die if PPC strengthened its locks, whereas smp_mb__release_acquire
> > is needed by quite a few architectures.
> 
> Currently, we do need smp_mb__after_unlock_lock() to be after the
> acquisition on PPC -- putting it between the unlock and the lock
> of course doesn't cut it for the cross-thread unlock/lock case.
> 
> I am with Peter -- we do need the benchmark results for PPC.

Urgh, sorry guys. I have been slowly doing some benchmarks, but time is not
plentiful at the moment.

If we do a straight lwsync -> sync conversion for unlock it looks like that
will cost us ~4.2% on Anton's standard context switch benchmark.

So that's not all that nice. But we also don't want to be the only arch that
has the weird lock semantics and has to find all the bugs.

cheers
