Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47EF01A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 02:46:44 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 18 Jan 2016 08:46:41 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 29F321FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 08:34:50 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u0IFkdo229818986
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 08:46:39 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0IFkSAX020908
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 08:46:39 -0700
Date: Mon, 18 Jan 2016 07:46:29 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Leonid.Yegoshin@imgtec.com, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, mst@redhat.com, peterz@infradead.org,
 will.deacon@arm.com, virtualization@lists.linux-foundation.org,
 hpa@zytor.com, sparclinux@vger.kernel.org, mingo@kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux@arm.linux.org.uk, user-mode-linux-devel@lists.sourceforge.net,
 linux-sh@vger.kernel.org, mpe@ellerman.id.au, x86@kernel.org,
 xen-devel@lists.xenproject.org, mingo@elte.hu,
 linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com, arnd@arndb.de,
 stefano.stabellini@eu.citrix.com,
 adi-buildroot-devel@lists.sourceforge.net, ddaney.cavm@gmail.com,
 tglx@linutronix.de, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, andrew.cooper3@citrix.com,
 linux-kernel@vger.kernel.org, ralf@linux-mips.org, joe@perches.com,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160118154629.GB3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160114204827.GE3818@linux.vnet.ibm.com>
 <20160118081929.GA30420@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160118081929.GA30420@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 18, 2016 at 04:19:29PM +0800, Herbert Xu wrote:
> Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> >
> > You could use SYNC_ACQUIRE() to implement read_barrier_depends() and
> > smp_read_barrier_depends(), but SYNC_RMB probably does not suffice.
> > The reason for this is that smp_read_barrier_depends() must order the
> > pointer load against any subsequent read or write through a dereference
> > of that pointer.  For example:
> > 
> >        p = READ_ONCE(gp);
> >        smp_rmb();
> >        r1 = p->a; /* ordered by smp_rmb(). */
> >        p->b = 42; /* NOT ordered by smp_rmb(), BUG!!! */
> >        r2 = x; /* ordered by smp_rmb(), but doesn't need to be. */
> > 
> > In contrast:
> > 
> >        p = READ_ONCE(gp);
> >        smp_read_barrier_depends();
> >        r1 = p->a; /* ordered by smp_read_barrier_depends(). */
> >        p->b = 42; /* ordered by smp_read_barrier_depends(). */
> >        r2 = x; /* not ordered by smp_read_barrier_depends(), which is OK. */
> > 
> > Again, if your hardware maintains local ordering for address
> > and data dependencies, you can have read_barrier_depends() and
> > smp_read_barrier_depends() be no-ops like they are for most
> > architectures.
> > 
> > Does that help?
> 
> This is crazy! smp_rmb started out being strictly stronger than
> smp_read_barrier_depends, when did this stop being the case?

Hello, Herbert!

It is true that most Linux kernel code relies only on the read-read
properties of dependencies, but the read-write properties are useful.
Admittedly relatively rarely, but useful.

The better comparison for smp_read_barrier_depends(), especially in
its rcu_dereference*() form, is smp_load_acquire().

							Thanx, Paul
