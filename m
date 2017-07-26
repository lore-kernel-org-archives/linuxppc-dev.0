Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHLzh30FMzDqmS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 14:02:37 +1000 (AEST)
Date: Tue, 25 Jul 2017 21:02:33 -0700 (PDT)
Message-Id: <20170725.210233.1441906980505926406.davem@davemloft.net>
To: paulmck@linux.vnet.ibm.com
Cc: Jonathan.Cameron@huawei.com, npiggin@gmail.com,
 linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
 akpm@linux-foundation.org, abdhalee@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, dzickus@redhat.com,
 sparclinux@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170726035545.GG3730@linux.vnet.ibm.com>
References: <20170725175207.000001cb@huawei.com>
 <20170725.141029.676882447882600000.davem@davemloft.net>
 <20170726035545.GG3730@linux.vnet.ibm.com>
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
Date: Tue, 25 Jul 2017 20:55:45 -0700

> On Tue, Jul 25, 2017 at 02:10:29PM -0700, David Miller wrote:
>> Just to report, turning softlockup back on fixes things for me on
>> sparc64 too.
> 
> Very good!
> 
>> The thing about softlockup is it runs an hrtimer, which seems to run
>> about every 4 seconds.
> 
> I could see where that could shake things loose, but I am surprised that
> it would be needed.  I ran a short run with CONFIG_SOFTLOCKUP_DETECTOR=y
> with no trouble, but I will be running a longer test later on.
> 
>> So I wonder if this is a NO_HZ problem.
> 
> Might be.  My tests run with NO_HZ_FULL=n and NO_HZ_IDLE=y.  What are
> you running?  (Again, my symptoms are slightly different, so I might
> be seeing a different bug.)

I run with NO_HZ_FULL=n and NO_HZ_IDLE=y, just like you.

To clarify, the symptoms show up with SOFTLOCKUP_DETECTOR disabled.
