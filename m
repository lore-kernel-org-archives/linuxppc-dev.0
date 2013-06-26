Return-Path: <michael@ellerman.id.au>
Date: Wed, 26 Jun 2013 18:10:58 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Regression in RCU subsystem in latest mainline kernel
Message-ID: <20130626081057.GB10796@concordia>
References: <1626500.7WAVXjfS9F@pcimr>
 <20130614122800.GL5146@linux.vnet.ibm.com>
 <1645938.As0LR1yeVd@pcimr>
 <1371243967.9844.338.camel@gandalf.local.home>
 <1371261741.21896.20.camel@pasglop>
 <20130617074213.GA3589@concordia>
 <20130619040906.GA5146@linux.vnet.ibm.com>
 <20130625071914.GA29957@concordia>
 <20130625074422.GB29957@concordia>
 <20130625160332.GA3828@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130625160332.GA3828@linux.vnet.ibm.com>
Cc: Rojhalat Ibrahim <imr@rtschenk.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 25, 2013 at 09:03:32AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 25, 2013 at 05:44:23PM +1000, Michael Ellerman wrote:
> > On Tue, Jun 25, 2013 at 05:19:14PM +1000, Michael Ellerman wrote:
> > > 
> > > Here's another trace from 3.10-rc7 plus a few local patches.
> > 
> > And here's another with CONFIG_RCU_CPU_STALL_INFO=y in case that's useful:
> > 
> > PASS running test_pmc5_6_overuse()
> > INFO: rcu_sched self-detected stall on CPU
> > 	8: (1 GPs behind) idle=8eb/140000000000002/0 softirq=215/220 
> 
> So this CPU has been out of action since before the beginning of the
> current grace period ("1 GPs behind").  It is not idle, having taken
> a pair of nested interrupts from process context (matching the stack
> below).  This CPU has take five softirqs since the last grace period
> that it noticed, which makes it likely that the loop is within the
> softirq handler.
> 
> > 	 (t=2100 jiffies g=18446744073709551583 c=18446744073709551582 q=13)
> 
> Assuming HZ=100, this stall has been going on  for 21 seconds.  There
> is a grace period in progress according to RCU's global state (which
> this CPU is not yet aware of).  There are a total of 13 RCU callbacks
> queued across the entire system.
> 
> If the system is at all responsive, I suggest using ftrace (either from
> the boot command line or at runtime) to trace __do_softirq() and
> hrtimer_interrupt().

Thanks for decoding it Paul.

I've narrowed down the test case and I think this is probably just a
case of too many perf interrupts. If I reduce the sampling period by
half the test runs fine.

There is logic in perf to detect an interrupt storm, but for some reason
it's not saving us. I'll dig in there, but I don't think it's an RCU
problem.

cheers
