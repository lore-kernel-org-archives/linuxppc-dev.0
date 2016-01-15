Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E6401A08A6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2016 04:53:23 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 15 Jan 2016 10:53:21 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 080403E40066
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 10:53:20 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u0FHrJT018153504
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 10:53:19 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0FHr60F008460
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 10:53:19 -0700
Date: Fri, 15 Jan 2016 09:46:12 -0800
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
Message-ID: <20160115174612.GV3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <569565DA.2010903@imgtec.com> <20160113104516.GE25458@arm.com>
 <5696CF08.8080700@imgtec.com> <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <20160115085554.GF3421@worktop> <20160115091348.GA27936@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160115091348.GA27936@worktop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 15, 2016 at 10:13:48AM +0100, Peter Zijlstra wrote:
> On Fri, Jan 15, 2016 at 09:55:54AM +0100, Peter Zijlstra wrote:
> > On Thu, Jan 14, 2016 at 01:29:13PM -0800, Paul E. McKenney wrote:
> > > So smp_mb() provides transitivity, as do pairs of smp_store_release()
> > > and smp_read_acquire(), 
> > 
> > But they provide different grades of transitivity, which is where all
> > the confusion lays.
> > 
> > smp_mb() is strongly/globally transitive, all CPUs will agree on the order.
> > 
> > Whereas the RCpc release+acquire is weakly so, only the two cpus
> > involved in the handover will agree on the order.
> 
> And the stuff we're confused about is how best to express the difference
> and guarantees of these two forms of transitivity and how exactly they
> interact.

Hoping my memory-barrier.txt patch helps here...

> And smp_load_acquire()/smp_store_release() are RCpc because TSO archs
> and PPC. the atomic*_{acquire,release}() are RCpc because PPC and
> LOCK,UNLOCK are similarly RCpc because of PPC.
> 
> Now we'd like PPC to stick a SYNC in either LOCK or UNLOCK so at least
> the locks are RCsc again, but they resist for performance reasons but
> waver because they don't want to be the ones finding all the nasty bugs
> because they're the only one.

I believe that the relevant proverb said something about starving to
death between two bales of hay...  ;-)

> Now the thing I worry about, and still have not had an answer to is if
> weakly ordered MIPS will end up being RCsc or RCpc for their locks if
> they get implemented with SYNC_ACQUIRE and SYNC_RELEASE instead of the
> current SYNC.

It would be good to have better clarity on this, no two ways about it.

							Thanx, Paul
