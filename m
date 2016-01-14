Return-Path: <Leonid.Yegoshin@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 886F41A009A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 10:04:24 +1100 (AEDT)
Message-ID: <56982972.7050609@imgtec.com>
Date: Thu, 14 Jan 2016 15:04:18 -0800
From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
MIME-Version: 1.0
To: <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, <linux-kernel@vger.kernel.org>,
 "Arnd
 Bergmann" <arnd@arndb.de>, <linux-arch@vger.kernel.org>, Andrew Cooper
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
References: <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com>
 <20160114161604.GT3818@linux.vnet.ibm.com> <5697FA0A.6040601@imgtec.com>
 <20160114201513.GI6357@twins.programming.kicks-ass.net>
 <56980933.2020801@imgtec.com> <20160114213440.GG3818@linux.vnet.ibm.com>
 <56981708.4000007@imgtec.com> <20160114222433.GI3818@linux.vnet.ibm.com>
In-Reply-To: <20160114222433.GI3818@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/14/2016 02:24 PM, Paul E. McKenney wrote:
> Actually, the Linux kernel doesn't have an acquire barrier, just an 
> smp_load_acquire(). Or did someone sneak one in while I wasn't looking?
That was an exactly starting point for this discussion. This patch just 
pulls out from MIPS files smp_load_acquire() and smp_store_release(). 
However, I put into LMO half year ago the patch 
http://patchwork.linux-mips.org/patch/10506/ which replaces a generic 
smp_mb with MIPS specific smp_release/acquire in that functions. This 
patch also fixes use of SYNCs barriers in spin_locks/atomics/bitops for 
Imagination MIPS CPUs too - it is just absent now for any Imagination 
MIPS CPUs!

Michael later pointed me that it can be returned back with his series of 
patches but discussion was already here.

- Leonid.
