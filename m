Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A99D1A003F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2016 09:08:29 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 15 Jan 2016 15:08:27 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 09E0D19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 14:56:26 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u0FM8OOq22347998
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 15:08:24 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0FM8AOV020880
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 15:08:24 -0700
Date: Fri, 15 Jan 2016 14:01:47 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
 Will Deacon <will.deacon@arm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 virtualization@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
 "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>,
 David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org,
 Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>,
 ddaney.cavm@gmail.com, james.hogan@imgtec.com,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160115220147.GD3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160113104516.GE25458@arm.com> <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com> <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <20160115085554.GF3421@worktop>
 <20160115173912.GU3818@linux.vnet.ibm.com>
 <20160115212912.GN3421@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160115212912.GN3421@worktop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 15, 2016 at 10:29:12PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 15, 2016 at 09:39:12AM -0800, Paul E. McKenney wrote:
> > Should we start putting litmus tests for the various examples
> > somewhere, perhaps in a litmus-tests directory within each participating
> > architecture?  I have a pile of powerpc-related litmus tests on my laptop,
> > but they probably aren't doing all that much good there.
> 
> Yeah, or a version of them in C that we can 'compile'?

That would be good as well.  I am guessing that architecture-specific
litmus tests will also be needed, but you are right that
architecture-independent versions are higher priority.

> > commit 2cb4e83a1b5c89c8e39b8a64bd89269d05913e41
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Fri Jan 15 09:30:42 2016 -0800
> > 
> >     documentation: Distinguish between local and global transitivity
> >     
> >     The introduction of smp_load_acquire() and smp_store_release() had
> >     the side effect of introducing a weaker notion of transitivity:
> >     The transitivity of full smp_mb() barriers is global, but that
> >     of smp_store_release()/smp_load_acquire() chains is local.  This
> >     commit therefore introduces the notion of local transitivity and
> >     gives an example.
> >     
> >     Reported-by: Peter Zijlstra <peterz@infradead.org>
> >     Reported-by: Will Deacon <will.deacon@arm.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> I think it fails to mention smp_mb__after_release_acquire(), although I
> suspect we didn't actually introduce the primitive yet, which raises the
> point, do we want to?

Well, it is not in v4.4.  I believe that we need good use cases before
we add it.

							Thanx, Paul
