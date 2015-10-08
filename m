Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27EE41A0297
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 08:44:44 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 15:44:42 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0685719D8042
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 15:32:51 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t98Lid8d1311154
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2015 14:44:39 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t98Licgp009524
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2015 15:44:39 -0600
Date: Thu, 8 Oct 2015 14:44:39 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151008214439.GE3910@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151008111638.GL3816@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 08, 2015 at 01:16:38PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 08, 2015 at 02:50:36PM +1100, Michael Ellerman wrote:
> > On Wed, 2015-10-07 at 08:25 -0700, Paul E. McKenney wrote:
> 
> > > Currently, we do need smp_mb__after_unlock_lock() to be after the
> > > acquisition on PPC -- putting it between the unlock and the lock
> > > of course doesn't cut it for the cross-thread unlock/lock case.
> 
> This ^, that makes me think I don't understand
> smp_mb__after_unlock_lock.
> 
> How is:
> 
> 	UNLOCK x
> 	smp_mb__after_unlock_lock()
> 	LOCK y
> 
> a problem? That's still a full barrier.

The problem is that I need smp_mb__after_unlock_lock() to give me
transitivity even if the UNLOCK happened on one CPU and the LOCK
on another.  For that to work, the smp_mb__after_unlock_lock() needs
to be either immediately after the acquire (the current choice) or
immediately before the release (which would also work from a purely
technical viewpoint, but I much prefer the current choice).

Or am I missing your point?

> > > I am with Peter -- we do need the benchmark results for PPC.
> > 
> > Urgh, sorry guys. I have been slowly doing some benchmarks, but time is not
> > plentiful at the moment.
> > 
> > If we do a straight lwsync -> sync conversion for unlock it looks like that
> > will cost us ~4.2% on Anton's standard context switch benchmark.
> 
> And that does not seem to agree with Paul's smp_mb__after_unlock_lock()
> usage and would not be sufficient for the same (as of yet unexplained)
> reason.
> 
> Why does it matter which of the LOCK or UNLOCK gets promoted to full
> barrier on PPC in order to become RCsc?

You could do either.  However, as I understand it, there is hardware for
which bc;isync is faster than lwsync.  For such hardware, it is cheaper
to upgrade the unlock from lwsync to sync than to upgrade the lock from
bc;isync to sync.  If I recall correctly, the kernel rewrites itself at
boot to select whichever of lwsync or bc;isync is better for the hardware
at hand.

							Thanx, Paul
