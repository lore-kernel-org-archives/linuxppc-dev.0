Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 65C262C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 00:22:58 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 08:22:52 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 323AD19D803E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 08:16:20 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5QEGSAu231290
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 08:16:28 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5QEIkOP030760
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 08:18:47 -0600
Date: Wed, 26 Jun 2013 07:16:17 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: Regression in RCU subsystem in latest mainline kernel
Message-ID: <20130626141617.GJ3828@linux.vnet.ibm.com>
References: <20130614122800.GL5146@linux.vnet.ibm.com>
 <1645938.As0LR1yeVd@pcimr>
 <1371243967.9844.338.camel@gandalf.local.home>
 <1371261741.21896.20.camel@pasglop>
 <20130617074213.GA3589@concordia>
 <20130619040906.GA5146@linux.vnet.ibm.com>
 <20130625071914.GA29957@concordia>
 <20130625074422.GB29957@concordia>
 <20130625160332.GA3828@linux.vnet.ibm.com>
 <20130626081057.GB10796@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130626081057.GB10796@concordia>
Cc: Rojhalat Ibrahim <imr@rtschenk.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 26, 2013 at 06:10:58PM +1000, Michael Ellerman wrote:
> On Tue, Jun 25, 2013 at 09:03:32AM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 25, 2013 at 05:44:23PM +1000, Michael Ellerman wrote:
> > > On Tue, Jun 25, 2013 at 05:19:14PM +1000, Michael Ellerman wrote:
> > > > 
> > > > Here's another trace from 3.10-rc7 plus a few local patches.
> > > 
> > > And here's another with CONFIG_RCU_CPU_STALL_INFO=y in case that's useful:
> > > 
> > > PASS running test_pmc5_6_overuse()
> > > INFO: rcu_sched self-detected stall on CPU
> > > 	8: (1 GPs behind) idle=8eb/140000000000002/0 softirq=215/220 
> > 
> > So this CPU has been out of action since before the beginning of the
> > current grace period ("1 GPs behind").  It is not idle, having taken
> > a pair of nested interrupts from process context (matching the stack
> > below).  This CPU has take five softirqs since the last grace period
> > that it noticed, which makes it likely that the loop is within the
> > softirq handler.
> > 
> > > 	 (t=2100 jiffies g=18446744073709551583 c=18446744073709551582 q=13)
> > 
> > Assuming HZ=100, this stall has been going on  for 21 seconds.  There
> > is a grace period in progress according to RCU's global state (which
> > this CPU is not yet aware of).  There are a total of 13 RCU callbacks
> > queued across the entire system.
> > 
> > If the system is at all responsive, I suggest using ftrace (either from
> > the boot command line or at runtime) to trace __do_softirq() and
> > hrtimer_interrupt().
> 
> Thanks for decoding it Paul.
> 
> I've narrowed down the test case and I think this is probably just a
> case of too many perf interrupts. If I reduce the sampling period by
> half the test runs fine.
> 
> There is logic in perf to detect an interrupt storm, but for some reason
> it's not saving us. I'll dig in there, but I don't think it's an RCU
> problem.

Whew!  ;-)

							Thanx, Paul
