Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87B9AB70A8
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 22:29:30 +1000 (EST)
Date: Thu, 5 Aug 2010 14:26:50 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
In-Reply-To: <20100805110625.GG3282@dirshya.in.ibm.com>
Message-ID: <alpine.LFD.2.00.1008051424130.3225@localhost.localdomain>
References: <4C488CCD.60004@us.ibm.com> <1279837509.1970.24.camel@pasglop>
	<4C48DADE.1050409@us.ibm.com> <4C491E14.9010100@us.ibm.com>
	<20100723050814.GA26162@dirshya.in.ibm.com>
	<1279861860.1970.74.camel@pasglop>
	<20100723070701.GC26162@dirshya.in.ibm.com>
	<4C5A41FF.3000605@us.ibm.com>
	<20100805110625.GG3282@dirshya.in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Darren Hart <dvhltc@us.ibm.com>,
	Gautham R Shenoy <ego@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 5 Aug 2010, Vaidyanathan Srinivasan wrote:

> * Darren Hart <dvhltc@us.ibm.com> [2010-08-04 21:45:51]:
> 
> > On 07/23/2010 12:07 AM, Vaidyanathan Srinivasan wrote:
> > >* Benjamin Herrenschmidt<benh@kernel.crashing.org>  [2010-07-23 15:11:00]:
> > >
> > >>On Fri, 2010-07-23 at 10:38 +0530, Vaidyanathan Srinivasan wrote:
> > >>>Yes.  extended_cede_processor() will return with interrupts enabled in
> > >>>the cpu. (This is done by the hypervisor).  Under normal cases we
> > >>>cannot be interrupted because no IO interrupts are routed to us after
> > >>>xics_teardown_cpu() and since the CPU is out of the map, nobody will
> > >>>send us IPIs.
> > >>
> > >>What about decrementer ?
> > >
> > >Decrementer expiry event handling is bit complex.  The event as such
> > >may not bring back the extended_cede_processor() cpu, but may be
> > >marked pending when we get out of this state eventually.  I will find
> > >more information on this event and update.
> > 
> > Hi Vaidy, have you been able to dig anything up about the
> > decrementer expiry?
> 
> Hi Darren,
> 
> Yes, it is possible that the cpu in extended_cede_processor() can be
> woken up by the decrementer.  But the expectation is that we will
> return back to this context since we will not have any pending timers.

The problem is that you might get woken _before_ the timers have been
migrated away. 
 
> Our stack should not change even if we get the decrementer interrupts.

But you should not execute kernel code when you got offlined either.

Thanks,

	tglx
