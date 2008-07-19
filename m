Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 84CB4DDDD8
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 13:16:45 +1000 (EST)
Date: Fri, 18 Jul 2008 21:26:00 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
	variables
In-Reply-To: <1216418730.7740.451.camel@pasglop>
Message-ID: <Pine.LNX.4.58.0807182123510.4932@gandalf.stny.rr.com>
References: <20080709160543.GG7101@linux.vnet.ibm.com>
	<1216085521.7740.37.camel@pasglop>
	<20080717125645.GN20277@linux.vnet.ibm.com>
	<1216325671.7740.359.camel@pasglop>
	<20080718101133.GO20277@linux.vnet.ibm.com>
	<1216418730.7740.451.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, Josh Triplett <josht@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, Nivedita Singhvi <niv@us.ibm.com>,
	Chirag Jog <chirag@linux.vnet.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
	linux.kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 19 Jul 2008, Benjamin Herrenschmidt wrote:
>
> > With the original patch, the pending batch does get flushed
> > in a non-preemptable region.
> > I am resending the original with just adding the necesary comments.
>
> Your comment isn't what I meant. What I meant is that if the process
> is context switched while walking the page tables, the low level powerpc
> context switch code should also perform a =EF=BB=BF__flush_tlb_pending.
>
> BTW. Is the pte_lock also not a real spinlock anymore ? That may break
> other assumptions the powerpc mm code is doing.
>
> This -rt stuff is just too scary, it changes some fundamental semantics
> of the spinlocks. yuck.

There's lots of semantics that are changed with -rt that should make
everything still work ;-)  Some spinlocks remain real spinlocks, but we
shouldn't have a problem with most being mutexes.

There's some cases that uses per CPU variables or other per cpu actions
that require a special CPU_LOCK that protects the data in a preemption
mode. The slab.c code in -rt handles this.

-- Steve
