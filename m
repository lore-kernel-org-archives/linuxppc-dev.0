Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F52F1A0FDD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 08:59:52 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 26 Jan 2016 14:59:50 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id BF1471FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 14:47:57 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u0QLxlsY29491244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 14:59:47 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0QLxVDp008353
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 14:59:47 -0700
Date: Tue, 26 Jan 2016 11:58:20 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
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
Message-ID: <20160126195820.GS4503@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <20160115085554.GF3421@worktop> <20160115091348.GA27936@worktop>
 <20160115174612.GV3818@linux.vnet.ibm.com>
 <20160115212714.GM3421@worktop>
 <20160115215853.GC3818@linux.vnet.ibm.com>
 <20160125164242.GF22927@arm.com>
 <20160126060322.GJ4503@linux.vnet.ibm.com>
 <20160126121608.GE21553@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160126121608.GE21553@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 26, 2016 at 12:16:09PM +0000, Will Deacon wrote:
> On Mon, Jan 25, 2016 at 10:03:22PM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 25, 2016 at 04:42:43PM +0000, Will Deacon wrote:
> > > On Fri, Jan 15, 2016 at 01:58:53PM -0800, Paul E. McKenney wrote:
> > > > PPC Overlapping Group-B sets version 4
> > > > ""
> > > > (* When the Group-B sets from two different barriers involve instructions in
> > > >    the same thread, within that thread one set must contain the other.
> > > > 
> > > > 	P0	P1	P2
> > > > 	Rx=1	Wy=1	Wz=2
> > > > 	dep.	lwsync	lwsync
> > > > 	Ry=0	Wz=1	Wx=1
> > > > 	Rz=1
> > > > 
> > > > 	assert(!(z=2))
> > > > 
> > > >    Forbidden by ppcmem, allowed by herd.
> > > > *)
> > > > {
> > > > 0:r1=x; 0:r2=y; 0:r3=z;
> > > > 1:r1=x; 1:r2=y; 1:r3=z; 1:r4=1;
> > > > 2:r1=x; 2:r2=y; 2:r3=z; 2:r4=1; 2:r5=2;
> > > > }
> > > >  P0		| P1		| P2		;
> > > >  lwz r6,0(r1)	| stw r4,0(r2)	| stw r5,0(r3)	;
> > > >  xor r7,r6,r6	| lwsync	| lwsync	;
> > > >  lwzx r7,r7,r2	| stw r4,0(r3)	| stw r4,0(r1)	;
> > > >  lwz r8,0(r3)	|		|		;
> > > > 
> > > > exists
> > > > (z=2 /\ 0:r6=1 /\ 0:r7=0 /\ 0:r8=1)
> > > 
> > > That really hurts. Assuming that the "assert(!(z=2))" is actually there
> > > to constrain the coherence order of z to be {0->1->2}, then I think that
> > > this test is forbidden on arm using dmb instead of lwsync. That said, I
> > > also don't think the Rz=1 in P0 changes anything.
> > 
> > What about the smp_wmb() variant of dmb that orders only stores?
> 
> Tricky, but I think it still works out if the coherence order of z is as
> I described above. The line of reasoning is weird though -- I ended up
> considering the two cases where P0 reads z before and after it reads x
> and what that means for the read of y.

By "works out" you mean that ARM prohibits the outcome?

BTW, I never have seen a real-world use for this case.  At the moment
it is mostly a cautionary tale about memory-model corner cases and
tools.

							Thanx, Paul
