Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHh6L71B8zDqpT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 02:54:34 +1000 (AEST)
Date: Wed, 26 Jul 2017 09:54:32 -0700 (PDT)
Message-Id: <20170726.095432.169004918437663011.davem@davemloft.net>
To: paulmck@linux.vnet.ibm.com
Cc: Jonathan.Cameron@huawei.com, dzickus@redhat.com, sfr@canb.auug.org.au,
 linuxarm@huawei.com, npiggin@gmail.com, abdhalee@linux.vnet.ibm.com,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170726154900.GQ3730@linux.vnet.ibm.com>
References: <20170726152315.00003d61@huawei.com>
 <20170726163340.0000014f@huawei.com>
 <20170726154900.GQ3730@linux.vnet.ibm.com>
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
Date: Wed, 26 Jul 2017 08:49:00 -0700

> On Wed, Jul 26, 2017 at 04:33:40PM +0100, Jonathan Cameron wrote:
>> Didn't leave it long enough. Still bad on 4.10-rc7 just took over
>> an hour to occur.
> 
> And it is quite possible that SOFTLOCKUP_DETECTOR=y and HZ_PERIODIC=y
> are just greatly reducing the probability of the problem rather than
> completely preventing it.
> 
> Still, hopefully useful information, thank you for the testing!

I guess that invalidates my idea to test reverting recent changes to
the tick-sched.c code... :-/

In NO_HZ_IDLE mode, what is really supposed to happen on a completely
idle system?

All the cpus enter the idle loop, have no timers programmed, and they
all just go to sleep until an external event happens.

What ensures that grace periods get processed in this regime?
