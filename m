Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BD141A1715
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 09:00:02 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 26 Jan 2016 15:00:00 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 944BD3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 14:59:58 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u0QLxwYq25100484
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 14:59:58 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0QLxaLP008750
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 14:59:58 -0700
Date: Tue, 26 Jan 2016 12:10:37 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
 linux-mips <linux-mips@linux-mips.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Peter Anvin <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
 linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 the arch/x86 maintainers <x86@kernel.org>,
 xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>,
 linux-xtensa@linux-xtensa.org, James Hogan <james.hogan@imgtec.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 adi-buildroot-devel@lists.sourceforge.net,
 David Daney <ddaney.cavm@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Joe Perches <joe@perches.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, David Miller <davem@davemloft.net>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160126201037.GU4503@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160114204827.GE3818@linux.vnet.ibm.com>
 <20160118081929.GA30420@gondor.apana.org.au>
 <20160118154629.GB3818@linux.vnet.ibm.com>
 <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
 <20160126172227.GG6357@twins.programming.kicks-ass.net>
 <CA+55aFzcC6C8imPs5vk4yH1Y2YHjnAdFM9HCkVs04COxuDQH6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CA+55aFzcC6C8imPs5vk4yH1Y2YHjnAdFM9HCkVs04COxuDQH6w@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 26, 2016 at 11:44:46AM -0800, Linus Torvalds wrote:
> On Tue, Jan 26, 2016 at 9:22 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > This is distinct from:
> 
> That may be distinct, but:
> 
> >         struct foo *x = READ_ONCE(*ptr);
> >         smp_read_barrier_depends();
> >         x->bar = 5;
> 
> This case is complete BS. Stop perpetuating it. I already removed a
> number of bogus cases of it, and I removed the incorrect documentation
> that had this crap.

If I understand your objection correctly, you want the above pattern
expressed either like this:

	struct foo *x = rcu_dereference(*ptr);
	x->bar = 5;

Or like this:

	struct foo *x = lockless_dereference(*ptr);
	x->bar = 5;

Or am I missing your point?

> It's called "smp_READ_barrier_depends()" for a reason.
> 
> Alpha is the only one that needs it, and alpha needs it only for
> dependent READS.
> 
> It's not called smp_read_write_barrier_depends(). It's not called
> "smp_mb_depends()". It's a weaker form of "smp_rmb()", nothing else.
> 
> So alpha does have an implied dependency chain from a read to a
> subsequent dependent write, and does not need any extra barriers.
> 
> Alpha does *not* have a dependency chain from a read to a subsequent
> read, which is why we need that horrible crappy
> smp_read_barrier_depends(). But it's the only reason.
> 
> This is the alpha reference manual wrt read-to-write dependency:
> 
>   5.6.1.7 Definition of Dependence Constraint
> 
>     The depends relation (DP) is defined as follows. Given u and v
> issued by processor Pi, where u
>     is a read or an instruction fetch and v is a write, u precedes v
> in DP order (written u DP v, that
>     is, v depends on u) in either of the following situations:
> 
>      • u determines the execution of v, the location accessed by v, or
> the value written by v.
>      • u determines the execution or address or value of another
> memory access z that precedes
> 
>     v or might precede v (that is, would precede v in some execution
> path depending
>     on the value read by u) by processor issue constraint (see Section 5.6.1.3).
> 
> Note that the dependence barrier honors not only control flow, but
> address and data values too.  This is a different syntax than we use,
> but 'u' is the READ_ONCE, and 'v' is the write. Any data, address or
> conditional dependency between the two implies an ordering.
> 
> So no, "smp_read_barrier_depends()" is *ONLY* about two reads, where
> the second read is data-dependent on the first. Nothing else.
> 
> So if you _ever_ see a "smp_read_barrier_depends()" that isn't about a
> barrier between two reads, then that is a bug.

And the smp_read_barrier_depends() in both rcu_dereference() and
in lockless_dereference() is ordering the read-to-read case and the
underlying hardware is ordering the read-to-write case on weakly ordered
hardware.

Or, again, am I missing your point?

							Thanx, Paul

> The above code is crap.  It's exactly as much crap as
> 
>    a = READ_ONCE(x);
>    smp_rmb();
>    WRITE_ONCE(b, y);
> 
> because a "rmb()" simply doesn't have anything to do with
> read-vs-subsequent-write ordering.
> 
>                  Linus
> 
