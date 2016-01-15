Return-Path: <Leonid.Yegoshin@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 1906F1A08A6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2016 05:54:37 +1100 (AEDT)
Message-ID: <56994068.4050402@imgtec.com>
Date: Fri, 15 Jan 2016 10:54:32 -0800
From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
MIME-Version: 1.0
To: Will Deacon <will.deacon@arm.com>, "Paul E. McKenney"
 <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, <linux-kernel@vger.kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, <linux-arch@vger.kernel.org>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Russell King - ARM Linux
 <linux@arm.linux.org.uk>, <virtualization@lists.linux-foundation.org>,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin"
 <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller
 <davem@davemloft.net>, <linux-ia64@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
 <sparclinux@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-metag@vger.kernel.org>, <linux-mips@linux-mips.org>, <x86@kernel.org>,
 <user-mode-linux-devel@lists.sourceforge.net>,
 <adi-buildroot-devel@lists.sourceforge.net>, <linux-sh@vger.kernel.org>,
 <linux-xtensa@linux-xtensa.org>, <xen-devel@lists.xenproject.org>, "Ralf
 Baechle" <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>,
 <ddaney.cavm@gmail.com>, <james.hogan@imgtec.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
References: <569565DA.2010903@imgtec.com> <20160113104516.GE25458@arm.com>
 <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com>
 <56980145.5030901@imgtec.com> <20160114204827.GE3818@linux.vnet.ibm.com>
 <56981212.7050301@imgtec.com> <20160114222046.GH3818@linux.vnet.ibm.com>
 <20160115095756.GA2131@arm.com>
In-Reply-To: <20160115095756.GA2131@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/15/2016 01:57 AM, Will Deacon wrote:
> Paul,
>
>
> I think you figured this out while I was sleeping, but just to confirm:
>
>   1. The MIPS64 ISA doc [1] talks about SYNC in a way that applies only
>      to memory accesses appearing in *program-order* before the SYNC
>
>   2. We need WRC+sync+addr to work, which means that the SYNC in P1 must
>      also capture the store in P0 as being "before" the barrier. Leonid
>      reckons it works, but his explanation [2] focussed on the address
>      dependency in P2 as to why this works. If that is the case (i.e.
>      address dependency provides global transitivity), then WRC+addr+addr
>      should also work (even though its not required).

No, it is not correct. There is one old design which provides access to 
core (thread0 + thread1) write-buffers for threads load in advance of it 
is visible to other cores. It means, that WRC+sync+addr passes because 
of SYNC in write thread and register dependency inside other thread but 
WRC+addr+addr may fail because other core may get a stale data.

>
>   3. It seems that WRC+addr+addr doesn't work, so I'm still suspicious
>      about WRC+sync+addr, because neither the architecture document or
>      Leonid's explanation tell me that it should be forbidden.
>
> Will
>
> [1] https://imgtec.com/?do-download=4302
> [2] http://lkml.kernel.org/r/569565DA.2010903@imgtec.com (scroll to the end)
