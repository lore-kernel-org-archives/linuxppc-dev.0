Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp01.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B5211007D6
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 17:07:19 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp01.in.ibm.com (8.14.4/8.13.1) with ESMTP id o6N77FvF029729
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 12:37:15 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6N77Fem3539138
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 12:37:15 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6N77ELw020561
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 12:37:15 +0530
Date: Fri, 23 Jul 2010 12:37:01 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
Message-ID: <20100723070701.GC26162@dirshya.in.ibm.com>
References: <4C488CCD.60004@us.ibm.com> <1279837509.1970.24.camel@pasglop>
	<4C48DADE.1050409@us.ibm.com> <4C491E14.9010100@us.ibm.com>
	<20100723050814.GA26162@dirshya.in.ibm.com>
	<1279861860.1970.74.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1279861860.1970.74.camel@pasglop>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Darren Hart <dvhltc@us.ibm.com>,
	Gautham R Shenoy <ego@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2010-07-23 15:11:00]:

> On Fri, 2010-07-23 at 10:38 +0530, Vaidyanathan Srinivasan wrote:
> > Yes.  extended_cede_processor() will return with interrupts enabled in
> > the cpu. (This is done by the hypervisor).  Under normal cases we
> > cannot be interrupted because no IO interrupts are routed to us after
> > xics_teardown_cpu() and since the CPU is out of the map, nobody will
> > send us IPIs.
> 
> What about decrementer ?

Decrementer expiry event handling is bit complex.  The event as such
may not bring back the extended_cede_processor() cpu, but may be
marked pending when we get out of this state eventually.  I will find
more information on this event and update.

> > Though H_CEDE will return with interrupts enabled, it is unlikely that
> > an interrupt can be delivered in this context. 
> 
> Well, if interrupts are soft-disabled, even if one occurs, we will just
> mask and return, so that at least should be ok.

Yes.  We will immediately return to the extended_cede_processor() in
the while loop until the preferred_offline_state is changed.

--Vaidy
