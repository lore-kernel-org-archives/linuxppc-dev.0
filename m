Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7QTz5WVXzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 01:12:39 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JF9giw122998
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 11:12:35 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29x75njgnc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 11:12:34 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 11:12:33 -0400
Date: Wed, 19 Apr 2017 08:09:33 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@linux.vnet.ibm.com>, tglx@linutronix.de,
 bobby.prani@gmail.com, fweisbec@gmail.com, jiangshanlai@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 josh@joshtriplett.org, dhowells@redhat.com, edumazet@google.com,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, dipankar@in.ibm.com,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Subject: Re: [PATCH tip/core/rcu 02/40] rcu: Make arch select
 smp_mb__after_unlock_lock() strength
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170412174003.GA23207@linux.vnet.ibm.com>
 <1492018825-25634-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170413092418.a2rudzukbgookior@hirez.programming.kicks-ass.net>
 <20170413162651.GD3956@linux.vnet.ibm.com>
 <20170413163757.wwhttkpm3v7emz33@hirez.programming.kicks-ass.net>
 <20170413170349.GK3956@linux.vnet.ibm.com>
 <87o9vs5xgx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87o9vs5xgx.fsf@concordia.ellerman.id.au>
Message-Id: <20170419150933.GM3956@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 19, 2017 at 11:38:22PM +1000, Michael Ellerman wrote:
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> 
> > On Thu, Apr 13, 2017 at 06:37:57PM +0200, Peter Zijlstra wrote:
> >> On Thu, Apr 13, 2017 at 09:26:51AM -0700, Paul E. McKenney wrote:
> >> 
> >> > ARCH_WEAK_RELEASE_ACQUIRE actually works both ways.
> >> > 
> >> > To see this, imagine some strange alternate universe in which the Power
> >> > hardware guys actually did decide to switch PPC to doing RCsc as you
> >> > suggest.  There would still be a lot of Power hardware out there that
> >> > still does RCpc.  Therefore, powerpc builds that needed to run on old
> >> > Power hardware would select ARCH_WEAK_RELEASE_ACQUIRE, while kernels
> >> > built to run only on the shiny new (but mythical) alternate-universe
> >> > Power hardware would avoid selecting this Kconfig option.
> >> 
> >> Ah, but Power software guys could do it today by replacing an LWSYNC
> >> with a SYNC in say arch_spin_unlock().
> >> 
> >> And yes, I know this isn't a popular suggestion, but it would do the
> >> trick.
> >
> > Indeed, there is a fine line between motivating people to move to new
> > hardware on the one hand and terminally annoying existing users on
> > the other.  ;-)
> >
> >> Its just that since there's one (PPC) we can sort of pressure them with
> >> the pain of being the only ones to hit all the bugs. But the moment more
> >> appear (and I'm afraid it'll be MIPS, with the excuse that PPC already
> >> does this) it will be ever so much harder to get rid of it.
> >> 
> >> Then again, maybe I should just give up and accept the Linux kernel has
> >> RCpc locks..
> >
> > As usual, I must defer to the powerpc maintainers on this one.
> 
> I reworked my locking tests a bit, to run longer, disable ASLR and a few
> other things, and ran them again. They just bang repeatedly on an
> uncontended lock, so nothing fancy at all.
> 
> Switching the release barrier to sync (from lwsync) slows it down by
> about 18%.

Ouch!!!

> So I think that pretty much rules it out, at least on current CPUs.
> 
> I'll try and get some more time to make sure I didn't do something
> stupid in the test, and maybe do a version that includes some
> contention.

Looking forward to seeing what you come up with...

							Thanx, Paul
