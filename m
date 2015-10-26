Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E67C61A03EF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 13:20:08 +1100 (AEDT)
Message-ID: <1445826001.27249.2.camel@ellerman.id.au>
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
From: Michael Ellerman <mpe@ellerman.id.au>
To: paulmck@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon
 <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>, Davidlohr Bueso
 <dave@stgolabs.net>,  stable@vger.kernel.org
Date: Mon, 26 Oct 2015 11:20:01 +0900
In-Reply-To: <20151021193638.GU5105@linux.vnet.ibm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
 <20151020092147.GX17308@twins.programming.kicks-ass.net>
 <20151020212835.GH5105@linux.vnet.ibm.com>
 <20151021081833.GB2881@worktop.programming.kicks-ass.net>
 <20151021193638.GU5105@linux.vnet.ibm.com>
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

On Wed, 2015-10-21 at 12:36 -0700, Paul E. McKenney wrote:

> On Wed, Oct 21, 2015 at 10:18:33AM +0200, Peter Zijlstra wrote:

> > On Tue, Oct 20, 2015 at 02:28:35PM -0700, Paul E. McKenney wrote:

> > > I am not seeing a sync there, but I really have to defer to the
> > > maintainers on this one.  I could easily have missed one.
> > 
> > So x86 implies a full barrier for everything that changes the CPL; and
> > some form of implied ordering seems a must if you change the privilege
> > level unless you tag every single load/store with the priv level at that
> > time, which seems the more expensive option.
> 
> And it is entirely possible that there is some similar operation
> somewhere in the powerpc entry/exit code.  I would not trust myself
> to recognize it, though.

> > So I suspect the typical implementation will flush all load/stores,
> > change the effective priv level and continue.
> > 
> > This can of course be implemented at a pure per CPU ordering (RCpc),
> > which would be in line with the rest of Power, in which case you do
> > indeed need an explicit sync to make it visible to other CPUs.
> > 
> > But yes, if Michael or Ben could clarify this it would be good.
> 
> :-) ;-) ;-)

Sorry guys, these threads are so long I tend not to read them very actively :}

Looking at the system call path, the straight line path does not include any
barriers. I can't see any hidden in macros either.

We also have an explicit sync in the switch_to() path, which suggests that we
know system call is not a full barrier.

Also looking at the architecture, section 1.5 which talks about the
synchronisation that occurs on system calls, defines nothing in terms of
memory ordering, and includes a programming note which says "Unlike the
Synchronize instruction, a context synchronizing operation does not affect the
order in which storage accesses are performed.".

Whether that's actually how it's implemented I don't know, I'll see if I can
find out.

cheers
