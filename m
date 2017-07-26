Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHqvZ6prnzDrD0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 08:45:46 +1000 (AEST)
Date: Wed, 26 Jul 2017 15:45:40 -0700 (PDT)
Message-Id: <20170726.154540.150558937277891719.davem@davemloft.net>
To: paulmck@linux.vnet.ibm.com
Cc: Jonathan.Cameron@huawei.com, dzickus@redhat.com, sfr@canb.auug.org.au,
 linuxarm@huawei.com, npiggin@gmail.com, abdhalee@linux.vnet.ibm.com,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170726223658.GA27617@linux.vnet.ibm.com>
References: <20170726.095432.169004918437663011.davem@davemloft.net>
 <20170726175013.GT3730@linux.vnet.ibm.com>
 <20170726223658.GA27617@linux.vnet.ibm.com>
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
Date: Wed, 26 Jul 2017 15:36:58 -0700

> And without CONFIG_SOFTLOCKUP_DETECTOR, I see five runs of 24 with RCU
> CPU stall warnings.  So it seems likely that CONFIG_SOFTLOCKUP_DETECTOR
> really is having an effect.

Thanks for all of the info Paul, I'll digest this and scan over the
code myself.

Just out of curiousity, what x86 idle method is your machine using?
The mwait one or the one which simply uses 'halt'?  The mwait variant
might mask this bug, and halt would be a lot closer to how sparc64 and
Jonathan's system operates.

On sparc64 the cpu yield we do in the idle loop sleeps the cpu.  It's
local TICK register keeps advancing, and the local timer therefore
will still trigger.  Also, any externally generated interrupts
(including cross calls) will wake up the cpu as well.

The tick-sched code is really tricky wrt. NO_HZ even in the NO_HZ_IDLE
case.  One of my running theories is that we miss scheduling a tick
due to a race.  That would be consistent with the behavior we see
in the RCU dumps, I think.

Anyways, just a theory, and that's why I keep mentioning that commit
about the revert of the revert (specifically
411fe24e6b7c283c3a1911450cdba6dd3aaea56e).

:-)
