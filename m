Return-Path: <Leonid.Yegoshin@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 4E7301A0C99
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 07:46:49 +1100 (AEDT)
Message-ID: <56980933.2020801@imgtec.com>
Date: Thu, 14 Jan 2016 12:46:43 -0800
From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
CC: <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, <linux-kernel@vger.kernel.org>, Arnd Bergmann
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
References: <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com> <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com>
 <20160114161604.GT3818@linux.vnet.ibm.com> <5697FA0A.6040601@imgtec.com>
 <20160114201513.GI6357@twins.programming.kicks-ass.net>
In-Reply-To: <20160114201513.GI6357@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/14/2016 12:15 PM, Peter Zijlstra wrote:
> On Thu, Jan 14, 2016 at 11:42:02AM -0800, Leonid Yegoshin wrote:
>> An the only point - please use an appropriate SYNC_* barriers instead of
>> heavy bold hammer. That stuff was design explicitly to support the
>> requirements of Documentation/memory-barriers.txt
> That's madness. That document changes from version to version as to what
> we _think_ the actual hardware does. It is _NOT_ a specification.
>
> You cannot design hardware from that. Its incomplete and fails to
> specify a bunch of things. It not a mathematically sound definition of a
> memory model.
>
> Please stop referring to that document for what a particular barrier
> _should_ do.  Explain what MIPS does, so we can attempt to integrate
> this knowledge with our knowledge of PPC/ARM/Alpha/x86/etc. and improve
> upon our understanding of hardware and improve the Linux memory model.

I am afraid I can't help you here. It is very complicated stuff and a 
model is actually doesn't fit your assumptions about CPUs well without 
some simplifications which are based on what you want to have.

I say that SYNC_ACQUIRE/etc follows what you expect for smp_acquire etc 
(basing on that document). And at least two CPU models were tested with 
my patches (see it in LMO) for that last year and that instructions are 
implemented now in engineering kernel.

If you have something else in mind, you can ask me. But I prefer to do 
not deviate too much from Documentation/memory-barriers.txt, for exam - 
if it asks to have memory barrier somewhere, then I assume the code 
should have it, and please - don't ask me a test which violates the 
current version of document recommendations.

For a moment I don't see a significant changes in this document for MIPS 
Arch at least 1.5 year, and the only significant point is that MIPS CPU 
Arch doesn't have yet smp_read_barrier_depends() and smp_rmb() should be 
used instead.

- Leonid.
