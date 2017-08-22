Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcDtV16RvzDqY1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 01:26:41 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7MFQAtT077728
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 11:26:40 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cgj1c0fvd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 11:26:39 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 22 Aug 2017 11:26:38 -0400
Date: Tue, 22 Aug 2017 08:26:37 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 David Miller <davem@davemloft.net>, npiggin@gmail.com,
 mpe@ellerman.id.au, dzickus@redhat.com, sfr@canb.auug.org.au,
 linuxarm@huawei.com, tglx@linutronix.de, sparclinux@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, john.stultz@linaro.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170821160605.5b1cc019@roar.ozlabs.ibm.com>
 <20170821111833.00006753@huawei.com>
 <20170822001928.74f01322@roar.ozlabs.ibm.com>
 <20170821.135504.1392954698746959868.davem@davemloft.net>
 <20170822084911.00000c23@huawei.com>
 <1503391892.3629.28.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503391892.3629.28.camel@abdul.in.ibm.com>
Message-Id: <20170822152637.GA11320@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 22, 2017 at 02:21:32PM +0530, Abdul Haleem wrote:
> On Tue, 2017-08-22 at 08:49 +0100, Jonathan Cameron wrote:
> > On Mon, 21 Aug 2017 13:55:04 -0700
> > David Miller <davem@davemloft.net> wrote:
> > 
> > > From: Nicholas Piggin <npiggin@gmail.com>
> > > Date: Tue, 22 Aug 2017 00:19:28 +1000
> > > 
> > > > Thanks here's an updated version with a couple more bugs fixed. If
> > > > you could try testing, that would be much appreciated.  
> > > 
> > > I'm not getting RCU stalls on sparc64 any longer with this patch.
> > > 
> > > I'm really happy you guys were able to figure out what was going
> > > wrong. :-)
> > > 
> > > Feel free to add my Tested-by:
> > > 
> > 
> > Like wise - 16 hours of clean run with the latest
> > 
> > Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Thanks for all the hard work everyone put into this one, great to
> > cross it off the list!
> > 
> > Jonathan
> > 
> 
> No more RCU stalls on PowerPC, system is clean when idle or with some
> test runs.
> 
> Thank you all for your time and efforts in fixing this.
> 
> Reported-and-Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

I am still seeing failures, but then again I am running rcutorture with
lots of CPU hotplug activity.  So I am probably seeing some other bug,
though it still looks a lot like a lost timer.

							Thanx, Paul
