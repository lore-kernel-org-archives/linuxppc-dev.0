Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJBfG3XCRzDrKM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 22:50:30 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6RCoIXR044927
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 08:50:27 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bydde8u5n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 08:50:24 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 08:49:18 -0400
Date: Thu, 27 Jul 2017 05:49:13 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: David Miller <davem@davemloft.net>, Jonathan.Cameron@huawei.com,
 dzickus@redhat.com, sfr@canb.auug.org.au, linuxarm@huawei.com,
 abdhalee@linux.vnet.ibm.com, sparclinux@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170726223658.GA27617@linux.vnet.ibm.com>
 <20170726.154540.150558937277891719.davem@davemloft.net>
 <20170726231505.GG3730@linux.vnet.ibm.com>
 <20170726.162200.1904949371593276937.davem@davemloft.net>
 <20170727014214.GH3730@linux.vnet.ibm.com>
 <20170727143400.23e4d2b2@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170727143400.23e4d2b2@roar.ozlabs.ibm.com>
Message-Id: <20170727124913.GL3730@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 27, 2017 at 02:34:00PM +1000, Nicholas Piggin wrote:
> On Wed, 26 Jul 2017 18:42:14 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Wed, Jul 26, 2017 at 04:22:00PM -0700, David Miller wrote:
> 
> > > Indeed, that really wouldn't explain how we end up with a RCU stall
> > > dump listing almost all of the cpus as having missed a grace period.  
> > 
> > I have seen stranger things, but admittedly not often.
> 
> So the backtraces show the RCU gp thread in schedule_timeout.
> 
> Are you sure that it's timeout has expired and it's not being scheduled,
> or could it be a bad (large) timeout (looks unlikely) or that it's being
> scheduled but not correctly noting gps on other CPUs?
> 
> It's not in R state, so if it's not being scheduled at all, then it's
> because the timer has not fired:

Good point, Nick!

Jonathan, could you please reproduce collecting timer event tracing?

							Thanx, Paul

> [ 1984.628602] rcu_preempt kthread starved for 5663 jiffies! g1566 c1565 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
> [ 1984.638153] rcu_preempt     S    0     9      2 0x00000000
> [ 1984.643626] Call trace:
> [ 1984.646059] [<ffff000008084fb0>] __switch_to+0x90/0xa8
> [ 1984.651189] [<ffff000008962274>] __schedule+0x19c/0x5d8
> [ 1984.656400] [<ffff0000089626e8>] schedule+0x38/0xa0
> [ 1984.661266] [<ffff000008965844>] schedule_timeout+0x124/0x218
> [ 1984.667002] [<ffff000008121424>] rcu_gp_kthread+0x4fc/0x748
> [ 1984.672564] [<ffff0000080df0b4>] kthread+0xfc/0x128
> [ 1984.677429] [<ffff000008082ec0>] ret_from_fork+0x10/0x50
> 
