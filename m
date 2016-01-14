Return-Path: <Leonid.Yegoshin@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id A96671A0036
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 06:42:10 +1100 (AEDT)
Message-ID: <5697FA0A.6040601@imgtec.com>
Date: Thu, 14 Jan 2016 11:42:02 -0800
From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
MIME-Version: 1.0
To: <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>
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
References: <20160112092711.GP6344@twins.programming.kicks-ass.net>
 <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com> <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com>
 <20160114161604.GT3818@linux.vnet.ibm.com>
In-Reply-To: <20160114161604.GT3818@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/14/2016 08:16 AM, Paul E. McKenney wrote:
> On Thu, Jan 14, 2016 at 12:04:45PM +0000, Will Deacon wrote:
>> On Wed, Jan 13, 2016 at 12:58:22PM -0800, Leonid Yegoshin wrote:
>>> On 01/13/2016 12:48 PM, Peter Zijlstra wrote:
>>>> On Wed, Jan 13, 2016 at 11:02:35AM -0800, Leonid Yegoshin wrote:
>>>>
>>>>> I ask HW team about it but I have a question - has it any relationship with
>>>>> replacing MIPS SYNC with lightweight SYNCs (SYNC_WMB etc)?
>>>> Of course. If you cannot explain the semantics of the primitives you
>>>> introduce, how can we judge the patch.
>>>>
>>>>
>>> You missed a point - it is a question about replacement of SYNC with
>>> lightweight primitives. It is NOT a question about multithread system
>>> behavior without any SYNC. The answer on a latest Will's question lies in
>>> different area.
> What Will said!
>
> Yes, you can cut corners within MIPS architecture-specific code,
> but primitives that are used in the core kernel really do need to
> work as expected.
>
> 							Thanx, Paul
>
>
Absolutelly! Please use SYNC - right now it is not.

An the only point - please use an appropriate SYNC_* barriers instead of 
heavy bold hammer. That stuff was design explicitly to support the 
requirements of Documentation/memory-barriers.txt

It is easy - just use smp_acquire instead of plain smp_mb 
insmp_load_acquire, at least for MIPS.

- Leonid.
- Leonid.
