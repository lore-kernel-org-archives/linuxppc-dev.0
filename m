Return-Path: <arjan@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id B734FB6FEB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 08:03:21 +1100 (EST)
Message-ID: <4F3ACC02.9020003@linux.intel.com>
Date: Tue, 14 Feb 2012 13:02:58 -0800
From: Arjan van de Ven <arjan@linux.intel.com>
MIME-Version: 1.0
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: smp: Start up non-boot CPUs asynchronously
References: <20120130205444.22f5e26a@infradead.org>
 <20120131125232.GD4408@elte.hu>	<20120131054155.371e8307@infradead.org>
 <20120131143130.GF13676@elte.hu>	<20120131072216.1ce78e50@infradead.org>
 <20120131161207.GA18357@elte.hu>	<20120131082439.575978c0@infradead.org>
 <4F3A1891.8060001@linux.vnet.ibm.com>	<4F3A2DFB.5000209@linux.vnet.ibm.com>
 <CADyApD0o4UYsTkqf2H2yJZ-d05NAyRAEc6z+m1gJEogc=cZLqQ@mail.gmail.com>
 <4F3ABCC1.5020000@linux.vnet.ibm.com>
In-Reply-To: <4F3ABCC1.5020000@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, mikey@neuling.org,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, gregkh@linuxfoundation.org,
 Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjanvandeven@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/14/2012 11:57 AM, Srivatsa S. Bhat wrote:

>> In addition to this, the reality is that the whole "bring cpus up"
>> sequence needs to be changed; the current one is very messy and requires
>> the hotplug lock for the whole bring up of each individual cpu... which
>> is a very unfortunate design; a much better design would be to only take
>> the lock for the actual registration of the newly brought up CPU to the
>> kernel, while running the physical bringup without the global lock.
>> If/when that change gets made, we can do the physical bring up in
>> parallel (with each other, but also with the rest of the kernel boot),
>> and do the registration en-mass at some convenient time in the boot,
>> potentially late.
>>
> 
> 
> Sounds like a good idea, but how will we take care of CPU_UP_PREPARE and
> CPU_STARTING callbacks then? Because, CPU_UP_PREPARE callbacks are run
> before bringing up the cpu and CPU_STARTING is called from the cpu that is
> coming up. Also, CPU_UP_PREPARE callbacks can be failed, which can lead
> to that particular cpu boot getting aborted. With the "late commissioning
> of CPUs" idea you proposed above, retaining such semantics could become
> very challenging.

some of these callbacks may need to be redesigned as well; or at least,
we may need to decouple the "physical" state of the CPU that's getting
brought up from the "logical" OS visible one.
