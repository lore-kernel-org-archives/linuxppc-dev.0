Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0675C1A0CBE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 14:20:24 +1100 (AEDT)
Date: Mon, 26 Oct 2015 14:20:21 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151026032021.GA5420@iris.ozlabs.ibm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
 <20151020092147.GX17308@twins.programming.kicks-ass.net>
 <20151020212835.GH5105@linux.vnet.ibm.com>
 <20151021081833.GB2881@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151021081833.GB2881@worktop.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 21, 2015 at 10:18:33AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 20, 2015 at 02:28:35PM -0700, Paul E. McKenney wrote:
> > I am not seeing a sync there, but I really have to defer to the
> > maintainers on this one.  I could easily have missed one.
> 
> So x86 implies a full barrier for everything that changes the CPL; and
> some form of implied ordering seems a must if you change the privilege
> level unless you tag every single load/store with the priv level at that
> time, which seems the more expensive option.
> 
> So I suspect the typical implementation will flush all load/stores,
> change the effective priv level and continue.
> 
> This can of course be implemented at a pure per CPU ordering (RCpc),
> which would be in line with the rest of Power, in which case you do
> indeed need an explicit sync to make it visible to other CPUs.

Right - interrupts and returns from interrupt are context
synchronizing operations, which means they wait until all outstanding
instructions have got to the point where they have reported any
exceptions they're going to report, which means in turn that loads and
stores have completed address translation.  But all of that doesn't
imply anything about the visibility of the loads and stores.

There is a full barrier in the context switch path, but not in the
system call entry/exit path.

Paul.
