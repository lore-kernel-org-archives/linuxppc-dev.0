Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzl7V3Z5ZzDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jul 2017 04:15:17 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5UIE6Bc016962
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 14:15:14 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bdqvshcwy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 14:15:14 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 30 Jun 2017 14:15:13 -0400
Date: Fri, 30 Jun 2017 11:15:11 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Paul McKenney <Paul.McKenney@us.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>, paulus@samba.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [linux-next] cpus stalls detected few hours after booting next
 kernel
Reply-To: paulmck@linux.vnet.ibm.com
References: <1498728106.19484.21.camel@abdul>
 <20170629193614.376e27e6@roar.ozlabs.ibm.com>
 <20170629202305.6187367f@roar.ozlabs.ibm.com>
 <20170630004534.228f7c08@roar.ozlabs.ibm.com>
 <1498800138.19484.25.camel@abdul>
 <20170630172802.6d4ddca2@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170630172802.6d4ddca2@roar.ozlabs.ibm.com>
Message-Id: <20170630181511.GC2393@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 30, 2017 at 05:28:02PM +1000, Nicholas Piggin wrote:
> On Fri, 30 Jun 2017 10:52:18 +0530
> Abdul Haleem <abdhalee@linux.vnet.ibm.com> wrote:
> 
> > On Fri, 2017-06-30 at 00:45 +1000, Nicholas Piggin wrote:
> > > On Thu, 29 Jun 2017 20:23:05 +1000
> > > Nicholas Piggin <npiggin@gmail.com> wrote:
> > > 
> > > > On Thu, 29 Jun 2017 19:36:14 +1000
> > > > Nicholas Piggin <npiggin@gmail.com> wrote:
> > > 
> > > > > I don't *think* the replay-wakeup-interrupt patch is directly involved, but
> > > > > it's likely to be one of the idle patches.  
> > > 
> > > Okay this turned out to be misconfigured sleep states I added for the
> > > simulator, sorry for the false alarm.
> > > 
> > > > Although you have this in the backtrace. I wonder if that's a stuck
> > > > lock in rcu_process_callbacks?
> > > 
> > > So this spinlock becomes top of the list of suspects. Can you try
> > > enabling lockdep and try to reproduce it?
> > 
> > Yes, recreated again with CONFIG_LOCKDEP=y & CONFIG_DEBUG_LOCKDEP=y set.
> > I do not see any difference in trace messages with and without LOCKDEP
> > enabled.
> > 
> > Please find the attached log file.
> 
> Can you get an rcu_invoke_callback event trace that Paul suggested?
> 
> Does this bug show up with just the powerpc next branch?

And I must say that those RCU CPU stall warnings are spectacular!

Did you by chance boot with a small subset of the CPUs online, and
bring the rest online later on?

							Thanx, Paul
