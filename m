Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHrjT2xwHzDrCv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 09:22:03 +1000 (AEST)
Date: Wed, 26 Jul 2017 16:22:00 -0700 (PDT)
Message-Id: <20170726.162200.1904949371593276937.davem@davemloft.net>
To: paulmck@linux.vnet.ibm.com
Cc: Jonathan.Cameron@huawei.com, dzickus@redhat.com, sfr@canb.auug.org.au,
 linuxarm@huawei.com, npiggin@gmail.com, abdhalee@linux.vnet.ibm.com,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170726231505.GG3730@linux.vnet.ibm.com>
References: <20170726223658.GA27617@linux.vnet.ibm.com>
 <20170726.154540.150558937277891719.davem@davemloft.net>
 <20170726231505.GG3730@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 16:15:05 -0700

> On Wed, Jul 26, 2017 at 03:45:40PM -0700, David Miller wrote:
>> Just out of curiousity, what x86 idle method is your machine using?
>> The mwait one or the one which simply uses 'halt'?  The mwait variant
>> might mask this bug, and halt would be a lot closer to how sparc64 and
>> Jonathan's system operates.
> 
> My kernel builds with CONFIG_INTEL_IDLE=n, which I believe means that
> I am not using the mwait one.  Here is a grep for IDLE in my .config:
> 
> 	CONFIG_NO_HZ_IDLE=y
> 	CONFIG_GENERIC_SMP_IDLE_THREAD=y
> 	# CONFIG_IDLE_PAGE_TRACKING is not set
> 	CONFIG_ACPI_PROCESSOR_IDLE=y
> 	CONFIG_CPU_IDLE=y
> 	# CONFIG_CPU_IDLE_GOV_LADDER is not set
> 	CONFIG_CPU_IDLE_GOV_MENU=y
> 	# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
> 	# CONFIG_INTEL_IDLE is not set

No, that doesn't influence it.  It is determined by cpu features at
run time.

If you are using mwait, it'll say so in your kernel log like this:

	using mwait in idle threads

>> On sparc64 the cpu yield we do in the idle loop sleeps the cpu.  It's
>> local TICK register keeps advancing, and the local timer therefore
>> will still trigger.  Also, any externally generated interrupts
>> (including cross calls) will wake up the cpu as well.
>> 
>> The tick-sched code is really tricky wrt. NO_HZ even in the NO_HZ_IDLE
>> case.  One of my running theories is that we miss scheduling a tick
>> due to a race.  That would be consistent with the behavior we see
>> in the RCU dumps, I think.
> 
> But wouldn't you have to miss a -lot- of ticks to get an RCU CPU stall
> warning?  By default, your grace period needs to extend for more than
> 21 seconds (more than one-third of a -minute-) to get one.  Or do
> you mean that the ticks get shut off now and forever, as opposed to
> just losing one of them?

Hmmm, good point.  And I was talking about simply missing one tick.

Indeed, that really wouldn't explain how we end up with a RCU stall
dump listing almost all of the cpus as having missed a grace period.
