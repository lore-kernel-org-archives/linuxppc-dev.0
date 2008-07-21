Return-Path: <chirag@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 453A0DDF0E
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 20:26:32 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6LAPXd0016033
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 20:25:33 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6LAO1tV059628
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 20:24:01 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6LAO0aw031019
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 20:24:00 +1000
Date: Mon, 21 Jul 2008 15:53:39 +0530
From: Chirag Jog <chirag@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
	variables
Message-ID: <20080721102339.GR20277@linux.vnet.ibm.com>
References: <20080709160543.GG7101@linux.vnet.ibm.com>
	<1216085521.7740.37.camel@pasglop>
	<20080717125645.GN20277@linux.vnet.ibm.com>
	<1216325671.7740.359.camel@pasglop>
	<20080718101133.GO20277@linux.vnet.ibm.com>
	<1216418730.7740.451.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1216418730.7740.451.camel@pasglop>
Cc: linux-rt-users@vger.kernel.org, Josh Triplett <josht@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Nivedita Singhvi <niv@us.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
	linux.kernel@vger.kernel.org
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Benjamin

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2008-07-19 08:05:30]:

> 
> > With the original patch, the pending batch does get flushed 
> > in a non-preemptable region. 
> > I am resending the original with just adding the necesary comments.
> 
> Your comment isn't what I meant. What I meant is that if the process
> is context switched while walking the page tables, the low level powerpc
> context switch code should also perform a ???__flush_tlb_pending.
Sorry, I misunderstood.
The powerpc context switch code does perform a __flush_tlb_pending.
Here is the patch 
http://marc.info/?l=linux-kernel&m=119752629222720&w=2
> BTW. Is the pte_lock also not a real spinlock anymore ? That may break
> other assumptions the powerpc mm code is doing.
pte_lock is a not a real spinlock anymore.

> This -rt stuff is just too scary, it changes some fundamental semantics
> of the spinlocks. yuck.
> 
> Ben.
> 
> 
