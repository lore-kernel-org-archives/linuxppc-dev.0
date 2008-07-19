Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB5E7DDEF8
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 13:59:26 +1000 (EST)
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
	variables
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <Pine.LNX.4.58.0807182123510.4932@gandalf.stny.rr.com>
References: <20080709160543.GG7101@linux.vnet.ibm.com>
	<1216085521.7740.37.camel@pasglop>
	<20080717125645.GN20277@linux.vnet.ibm.com>
	<1216325671.7740.359.camel@pasglop>
	<20080718101133.GO20277@linux.vnet.ibm.com>
	<1216418730.7740.451.camel@pasglop>
	<Pine.LNX.4.58.0807182123510.4932@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Sat, 19 Jul 2008 13:53:33 +1000
Message-Id: <1216439613.7740.470.camel@pasglop>
Mime-Version: 1.0
Cc: linux-rt-users@vger.kernel.org, Josh Triplett <josht@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, Nivedita Singhvi <niv@us.ibm.com>,
	Chirag Jog <chirag@linux.vnet.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
	linux.kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> There's lots of semantics that are changed with -rt that should make
> everything still work ;-)  Some spinlocks remain real spinlocks, but we
> shouldn't have a problem with most being mutexes.
> 
> There's some cases that uses per CPU variables or other per cpu actions
> that require a special CPU_LOCK that protects the data in a preemption
> mode. The slab.c code in -rt handles this.

Well, there is at least in my case a whole class of code that assumes
that because the whole thing happens within a spinlock section at the
toplevel, it could not only access per_cpu variables using the
__variants, that's easy, but it also assumes that it can add things bit
by bit as it gets called at the lower level to that per-cpu cache. It's
not actually prepared for possibly migrating to another CPU right in the
middle. 

I need to review that stuff a bit. I think we fixed some of that at one
point, and we made sure that the context switch itself would flush
pending MMU batches, so it -may- be fine in that specific case.

Cheers,
Ben. 
