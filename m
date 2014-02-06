Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7FE362C0374
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 07:20:05 +1100 (EST)
Message-ID: <1391717992.6733.232.camel@snotra.buserror.net>
Subject: Re: [PATCH] Convert powerpc simple spinlocks into ticket locks
From: Scott Wood <scottwood@freescale.com>
To: Torsten Duwe <duwe@lst.de>
Date: Thu, 6 Feb 2014 14:19:52 -0600
In-Reply-To: <20140206173727.GA13048@lst.de>
References: <20140206103736.GA18054@lst.de>
 <20140206163837.GT2936@laptop.programming.kicks-ass.net>
 <20140206173727.GA13048@lst.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>, "Paul
 E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-02-06 at 18:37 +0100, Torsten Duwe wrote:
> On Thu, Feb 06, 2014 at 05:38:37PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 06, 2014 at 11:37:37AM +0100, Torsten Duwe wrote:
> > > x86 has them, MIPS has them, ARM has them, even ia64 has them:
> > > ticket locks. They reduce memory bus and cache pressure especially
> > > for contended spinlocks, increasing performance.
> > > 
> > > This patch is a port of the x86 spin locks, mostly written in C,
> > > to the powerpc, introducing inline asm where needed. The pSeries
> > > directed yield for vCPUs is taken care of by an additional "holder"
> > > field in the lock.
> > > 
> > 
> > A few questions; what's with the ppc64 holder thing? Not having a 32bit
> > spinlock_t is sad.
> 
> I must admit that I haven't tested the patch on non-pseries ppc64 nor on
> ppc32. Only ppc64 has the ldarx and I tried to atomically replace the 
> holder along with the locks. That might prove unneccessary.

Why is the functionality of holder only required on 64-bit?  We have too
many 32/64 differences as is.  Perhaps on 32-bit a lower max number of
CPUs could be assumed, to make it fit in one word.

> > Can you pair lwarx with sthcx ? I couldn't immediately find the answer
> > in the PowerISA doc. If so I think you can do better by being able to
> > atomically load both tickets but only storing the head without affecting
> > the tail.
> 
> V2.06b, Book II, Chapter 3, "sthcx" says:
> | If a reservation exists and the length associated [...] is not 2 bytes,
> | it is undefined whether (RS)_48:63 are stored [...]
> 
> That doesn't make me feel comfortable :(

Plus, sthcx doesn't exist on all PPC chips.

-Scott
