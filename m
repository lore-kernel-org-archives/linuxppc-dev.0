Return-Path: <jonathan.cameron@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJ3q91Pt4zDqmW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 17:42:44 +1000 (AEST)
Date: Thu, 27 Jul 2017 08:41:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Miller <davem@davemloft.net>
CC: <dzickus@redhat.com>, <sfr@canb.auug.org.au>, <linuxarm@huawei.com>,
 <npiggin@gmail.com>, <abdhalee@linux.vnet.ibm.com>,
 <sparclinux@vger.kernel.org>, <akpm@linux-foundation.org>,
 <paulmck@linux.vnet.ibm.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Message-ID: <20170727084156.000055d2@huawei.com>
In-Reply-To: <20170726181312.0000040d@huawei.com>
References: <20170726152315.00003d61@huawei.com>
 <20170726163340.0000014f@huawei.com>
 <20170726154900.GQ3730@linux.vnet.ibm.com>
 <20170726.095432.169004918437663011.davem@davemloft.net>
 <20170726181312.0000040d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 26 Jul 2017 18:13:12 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Wed, 26 Jul 2017 09:54:32 -0700
> David Miller <davem@davemloft.net> wrote:
> 
> > From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Date: Wed, 26 Jul 2017 08:49:00 -0700
> >   
> > > On Wed, Jul 26, 2017 at 04:33:40PM +0100, Jonathan Cameron wrote:    
> > >> Didn't leave it long enough. Still bad on 4.10-rc7 just took over
> > >> an hour to occur.    
> > > 
> > > And it is quite possible that SOFTLOCKUP_DETECTOR=y and HZ_PERIODIC=y
> > > are just greatly reducing the probability of the problem rather than
> > > completely preventing it.
> > > 
> > > Still, hopefully useful information, thank you for the testing!    
> 
> Not sure it actually gives us much information, but no issues yet
> with a simple program running every cpu that wakes up every 3 seconds.
> 
> Will leave it running overnight and report back in the morning.
Perhaps unsurprisingly the above test didn't show any splats.

So it appears a userspace wakeup is enough to stop the issue happening
(or at least make it a lot less likely).

Jonathan
> 
> > 
> > I guess that invalidates my idea to test reverting recent changes to
> > the tick-sched.c code... :-/
> > 
> > In NO_HZ_IDLE mode, what is really supposed to happen on a completely
> > idle system?
> > 
> > All the cpus enter the idle loop, have no timers programmed, and they
> > all just go to sleep until an external event happens.
> > 
> > What ensures that grace periods get processed in this regime?  
> _______________________________________________
> linuxarm mailing list
> linuxarm@huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
