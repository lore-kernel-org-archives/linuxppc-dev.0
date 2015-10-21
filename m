Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 165A51A0AE6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 06:36:49 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 13:36:47 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D455619D803E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 13:24:44 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9LJaY7f2884032
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 12:36:34 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9LJaWOi023579
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 13:36:34 -0600
Date: Wed, 21 Oct 2015 12:36:38 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151021193638.GU5105@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
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

And it is entirely possible that there is some similar operation
somewhere in the powerpc entry/exit code.  I would not trust myself
to recognize it, though.

> So I suspect the typical implementation will flush all load/stores,
> change the effective priv level and continue.
> 
> This can of course be implemented at a pure per CPU ordering (RCpc),
> which would be in line with the rest of Power, in which case you do
> indeed need an explicit sync to make it visible to other CPUs.
> 
> But yes, if Michael or Ben could clarify this it would be good.
> 
> Back then I talked to Ralf about what MIPS says on this, and MIPS arch
> spec is entirely quiet on this, it allows implementations full freedom
> IIRC.

:-) ;-) ;-)

> </ramble>

							Thanx, Paul
