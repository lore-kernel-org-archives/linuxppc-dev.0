Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 094252C00DC
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Nov 2013 01:40:25 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sun, 3 Nov 2013 07:40:24 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id AD9C238C8042
 for <linuxppc-dev@ozlabs.org>; Sun,  3 Nov 2013 09:40:19 -0500 (EST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA3EeKtG4456840
 for <linuxppc-dev@ozlabs.org>; Sun, 3 Nov 2013 14:40:20 GMT
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rA3EhB9V019558
 for <linuxppc-dev@ozlabs.org>; Sun, 3 Nov 2013 07:43:11 -0700
Date: Sun, 3 Nov 2013 06:40:17 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131103144017.GA25118@linux.vnet.ibm.com>
References: <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <20131030112526.GI16117@laptop.programming.kicks-ass.net>
 <20131031064015.GV4126@linux.vnet.ibm.com>
 <20131101145634.GH19466@laptop.lan>
 <20131102173239.GB3947@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131102173239.GB3947@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 02, 2013 at 10:32:39AM -0700, Paul E. McKenney wrote:
> On Fri, Nov 01, 2013 at 03:56:34PM +0100, Peter Zijlstra wrote:
> > On Wed, Oct 30, 2013 at 11:40:15PM -0700, Paul E. McKenney wrote:
> > > > Now the whole crux of the question is if we need barrier A at all, since
> > > > the STORES issued by the @buf writes are dependent on the ubuf->tail
> > > > read.
> > > 
> > > The dependency you are talking about is via the "if" statement?
> > > Even C/C++11 is not required to respect control dependencies.
> > > 
> > > This one is a bit annoying.  The x86 TSO means that you really only
> > > need barrier(), ARM (recent ARM, anyway) and Power could use a weaker
> > > barrier, and so on -- but smp_mb() emits a full barrier.
> > > 
> > > Perhaps a new smp_tmb() for TSO semantics, where reads are ordered
> > > before reads, writes before writes, and reads before writes, but not
> > > writes before reads?  Another approach would be to define a per-arch
> > > barrier for this particular case.
> > 
> > I suppose we can only introduce new barrier primitives if there's more
> > than 1 use-case.
> 
> There probably are others.

If there was an smp_tmb(), I would likely use it in rcu_assign_pointer().
There are some corner cases that can happen with the current smp_wmb()
that would be prevented by smp_tmb().  These corner cases are a bit
strange, as follows:

	struct foo gp;

	void P0(void)
	{
		struct foo *p = kmalloc(sizeof(*p);

		if (!p)
			return;
		ACCESS_ONCE(p->a) = 0;
		BUG_ON(ACCESS_ONCE(p->a));
		rcu_assign_pointer(gp, p);
	}

	void P1(void)
	{
		struct foo *p = rcu_dereference(gp);

		if (!p)
			return;
		ACCESS_ONCE(p->a) = 1;
	}

With smp_wmb(), the BUG_ON() can occur because smp_wmb() does
not prevent CPU from reordering the read in the BUG_ON() with the
rcu_assign_pointer().  With smp_tmb(), it could not.

Now, I am not too worried about this because I cannot think of any use
for code like that in P0() and P1().  But if there was an smp_tmb(),
it would be cleaner to make the BUG_ON() impossible.

							Thanx, Paul

> > > > If the read shows no available space, we simply will not issue those
> > > > writes -- therefore we could argue we can avoid the memory barrier.
> > > 
> > > Proving that means iterating through the permitted combinations of
> > > compilers and architectures...  There is always hand-coded assembly
> > > language, I suppose.
> > 
> > I'm starting to think that while the C/C++ language spec says they can
> > wreck the world by doing these silly optimization, real world users will
> > push back for breaking their existing code.
> > 
> > I'm fairly sure the GCC people _will_ get shouted at _loudly_ when they
> > break the kernel by doing crazy shit like that.
> > 
> > Given its near impossible to write a correct program in C/C++ and
> > tagging the entire kernel with __atomic is equally not going to happen,
> > I think we must find a practical solution.
> > 
> > Either that, or we really need to consider forking the language and
> > compiler :-(
> 
> Depends on how much benefit the optimizations provide.  If they provide
> little or no benefit, I am with you, otherwise we will need to bit some
> bullet or another.  Keep in mind that there is a lot of code in the
> kernel that runs sequentially (e.g., due to being fully protected by
> locks), and aggressive optimizations for that sort of code are harmless.
> 
> Can't say I know the answer at the moment, though.
> 
> 							Thanx, Paul
