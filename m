Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3nFM6dzSzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 03:04:07 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DH40OK183659
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 13:04:01 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29t1rk04w4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 13:04:00 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 13:03:55 -0400
Date: Thu, 13 Apr 2017 10:03:49 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
 dipankar@in.ibm.com, akpm@linux-foundation.org,
 mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
 tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
 edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
 bobby.prani@gmail.com, Will Deacon <will.deacon@arm.com>,
 Boqun Feng <boqun.feng@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH tip/core/rcu 02/40] rcu: Make arch select
 smp_mb__after_unlock_lock() strength
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170412174003.GA23207@linux.vnet.ibm.com>
 <1492018825-25634-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170413092418.a2rudzukbgookior@hirez.programming.kicks-ass.net>
 <20170413162651.GD3956@linux.vnet.ibm.com>
 <20170413163757.wwhttkpm3v7emz33@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170413163757.wwhttkpm3v7emz33@hirez.programming.kicks-ass.net>
Message-Id: <20170413170349.GK3956@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 13, 2017 at 06:37:57PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 13, 2017 at 09:26:51AM -0700, Paul E. McKenney wrote:
> 
> > ARCH_WEAK_RELEASE_ACQUIRE actually works both ways.
> > 
> > To see this, imagine some strange alternate universe in which the Power
> > hardware guys actually did decide to switch PPC to doing RCsc as you
> > suggest.  There would still be a lot of Power hardware out there that
> > still does RCpc.  Therefore, powerpc builds that needed to run on old
> > Power hardware would select ARCH_WEAK_RELEASE_ACQUIRE, while kernels
> > built to run only on the shiny new (but mythical) alternate-universe
> > Power hardware would avoid selecting this Kconfig option.
> 
> Ah, but Power software guys could do it today by replacing an LWSYNC
> with a SYNC in say arch_spin_unlock().
> 
> And yes, I know this isn't a popular suggestion, but it would do the
> trick.

Indeed, there is a fine line between motivating people to move to new
hardware on the one hand and terminally annoying existing users on
the other.  ;-)

> Its just that since there's one (PPC) we can sort of pressure them with
> the pain of being the only ones to hit all the bugs. But the moment more
> appear (and I'm afraid it'll be MIPS, with the excuse that PPC already
> does this) it will be ever so much harder to get rid of it.
> 
> Then again, maybe I should just give up and accept the Linux kernel has
> RCpc locks..

As usual, I must defer to the powerpc maintainers on this one.

							Thanx, Paul
