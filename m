Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA03F1A0456
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 06:48:26 +1100 (AEDT)
Date: Wed, 21 Oct 2015 21:48:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151021194825.GH2508@worktop.programming.kicks-ass.net>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
 <20151020092147.GX17308@twins.programming.kicks-ass.net>
 <20151020212835.GH5105@linux.vnet.ibm.com>
 <20151021084503.GE17714@fixme-laptop.cn.ibm.com>
 <20151021193523.GT5105@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151021193523.GT5105@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 21, 2015 at 12:35:23PM -0700, Paul E. McKenney wrote:
> > > > > I ask this because I recall Peter once bought up a discussion:
> > > > > 
> > > > > https://lkml.org/lkml/2015/8/26/596

> > So a full barrier on one side of these operations is enough, I think.
> > IOW, there is no need to strengthen these operations.
> 
> Do we need to also worry about other futex use cases?

Worry, always!

But yes, there is one more specific usecase, which is that of a
condition variable.

When we go sleep on a futex, we might want to assume visibility of the
stores done by the thread that woke us by the time we wake up.



And.. aside from the thoughts I outlined in the email referenced above,
there is always the chance people accidentally rely on the strong
ordering on their x86 CPU and find things come apart when ran on their
ARM/MIPS/etc..

There are a fair number of people who use the raw futex call and we have
0 visibility into many of them. The assumed and accidental ordering
guarantees will forever remain a mystery.
