Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1734B1A067F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 17:46:35 +1100 (AEDT)
Date: Mon, 12 Oct 2015 08:46:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 5/7] powerpc: atomic: Implement cmpxchg{,64}_* and
 atomic{,64}_cmpxchg_* variants
Message-ID: <20151012064621.GL3604@twins.programming.kicks-ass.net>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-6-git-send-email-boqun.feng@gmail.com>
 <20151001122715.GQ2881@worktop.programming.kicks-ass.net>
 <20151010015805.GA946@fixme-laptop.cn.ibm.com>
 <20151011102520.GB27351@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151011102520.GB27351@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 11, 2015 at 06:25:20PM +0800, Boqun Feng wrote:
> On Sat, Oct 10, 2015 at 09:58:05AM +0800, Boqun Feng wrote:
> > Hi Peter,
> > 
> > Sorry for replying late.
> > 
> > On Thu, Oct 01, 2015 at 02:27:16PM +0200, Peter Zijlstra wrote:
> > > On Wed, Sep 16, 2015 at 11:49:33PM +0800, Boqun Feng wrote:
> > > > Unlike other atomic operation variants, cmpxchg{,64}_acquire and
> > > > atomic{,64}_cmpxchg_acquire don't have acquire semantics if the cmp part
> > > > fails, so we need to implement these using assembly.
> > > 
> > > I think that is actually expected and documented. That is, a cmpxchg
> > > only implies barriers on success. See:
> > > 
> > >   ed2de9f74ecb ("locking/Documentation: Clarify failed cmpxchg() memory ordering semantics")
> > 
> > I probably didn't make myself clear here, my point is that if we use
> > __atomic_op_acquire() to built *_cmpchg_acquire(For ARM and PowerPC),
> > the barrier will be implied _unconditionally_, meaning no matter cmp
> > fails or not, there will be a barrier after the cmpxchg operation.
> > Therefore we have to use assembly to implement the operations right now.

See later, but no, you don't _have_ to.

> Or let me try another way to explain this. What I wanted to say here is
> that unlike the implementation of xchg family, which needs only to
> implement _relaxed version and *remove* the fully ordered version, the
> implementation of cmpxchg family needs to *remain* the fully ordered
> version and implement the _acquire version in assembly. Because if we
> use __atomic_op_*(), the barriers in the cmpxchg family will be implied
> *unconditionally*, for example:

So the point that confused me, and which is still valid for the above,
is your use of 'need'.

You don't need to omit the barrier at all. Its perfectly valid to issue
too many barriers (pointless and a waste of time, yes; incorrect, no).

So what you want to say is: "Optimize cmpxchg_acquire() to avoid
superfluous barrier".
