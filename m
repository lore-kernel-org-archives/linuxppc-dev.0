Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3mgS70ftzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 02:38:12 +1000 (AEST)
Date: Thu, 13 Apr 2017 18:37:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
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
Message-ID: <20170413163757.wwhttkpm3v7emz33@hirez.programming.kicks-ass.net>
References: <20170412174003.GA23207@linux.vnet.ibm.com>
 <1492018825-25634-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170413092418.a2rudzukbgookior@hirez.programming.kicks-ass.net>
 <20170413162651.GD3956@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170413162651.GD3956@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 13, 2017 at 09:26:51AM -0700, Paul E. McKenney wrote:

> ARCH_WEAK_RELEASE_ACQUIRE actually works both ways.
> 
> To see this, imagine some strange alternate universe in which the Power
> hardware guys actually did decide to switch PPC to doing RCsc as you
> suggest.  There would still be a lot of Power hardware out there that
> still does RCpc.  Therefore, powerpc builds that needed to run on old
> Power hardware would select ARCH_WEAK_RELEASE_ACQUIRE, while kernels
> built to run only on the shiny new (but mythical) alternate-universe
> Power hardware would avoid selecting this Kconfig option.

Ah, but Power software guys could do it today by replacing an LWSYNC
with a SYNC in say arch_spin_unlock().

And yes, I know this isn't a popular suggestion, but it would do the
trick.

Its just that since there's one (PPC) we can sort of pressure them with
the pain of being the only ones to hit all the bugs. But the moment more
appear (and I'm afraid it'll be MIPS, with the excuse that PPC already
does this) it will be ever so much harder to get rid of it.

Then again, maybe I should just give up and accept the Linux kernel has
RCpc locks..
