Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHMBy65DmzDqmS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 14:12:26 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6Q4AgN3062995
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 00:12:24 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bxgqff8a5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 00:12:24 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 26 Jul 2017 00:12:23 -0400
Date: Tue, 25 Jul 2017 21:12:17 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: David Miller <davem@davemloft.net>
Cc: Jonathan.Cameron@huawei.com, npiggin@gmail.com,
 linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
 akpm@linux-foundation.org, abdhalee@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, dzickus@redhat.com,
 sparclinux@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170725175207.000001cb@huawei.com>
 <20170725.141029.676882447882600000.davem@davemloft.net>
 <20170726035545.GG3730@linux.vnet.ibm.com>
 <20170725.210233.1441906980505926406.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170725.210233.1441906980505926406.davem@davemloft.net>
Message-Id: <20170726041217.GH3730@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 25, 2017 at 09:02:33PM -0700, David Miller wrote:
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Date: Tue, 25 Jul 2017 20:55:45 -0700
> 
> > On Tue, Jul 25, 2017 at 02:10:29PM -0700, David Miller wrote:
> >> Just to report, turning softlockup back on fixes things for me on
> >> sparc64 too.
> > 
> > Very good!
> > 
> >> The thing about softlockup is it runs an hrtimer, which seems to run
> >> about every 4 seconds.
> > 
> > I could see where that could shake things loose, but I am surprised that
> > it would be needed.  I ran a short run with CONFIG_SOFTLOCKUP_DETECTOR=y
> > with no trouble, but I will be running a longer test later on.
> > 
> >> So I wonder if this is a NO_HZ problem.
> > 
> > Might be.  My tests run with NO_HZ_FULL=n and NO_HZ_IDLE=y.  What are
> > you running?  (Again, my symptoms are slightly different, so I might
> > be seeing a different bug.)
> 
> I run with NO_HZ_FULL=n and NO_HZ_IDLE=y, just like you.
> 
> To clarify, the symptoms show up with SOFTLOCKUP_DETECTOR disabled.

Same here -- but my failure case happens fairly rarely, so it will take
some time to gain reasonable confidence that enabling SOFTLOCKUP_DETECTOR
had effect.

But you are right, might be interesting to try NO_HZ_PERIODIC=y
or NO_HZ_FULL=y.  So many possible tests, and so little time.  ;-)

							Thanx, Paul
