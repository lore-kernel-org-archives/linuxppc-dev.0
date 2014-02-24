Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C24BB2C0212
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 22:32:49 +1100 (EST)
Date: Mon, 24 Feb 2014 12:32:46 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [patch 03/26] powerpc: eeh: Kill another abuse of irq_desc
In-Reply-To: <20140224075607.GA20727@shangw.(null)>
Message-ID: <alpine.DEB.2.02.1402241232030.21251@ionos.tec.linutronix.de>
References: <20140223212703.511977310@linutronix.de>
 <20140223212736.562906212@linutronix.de>
 <20140224075607.GA20727@shangw.(null)>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
 ppc <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 24 Feb 2014, Gavin Shan wrote:
> On Sun, Feb 23, 2014 at 09:40:09PM -0000, Thomas Gleixner wrote:
> >commit 91150af3a (powerpc/eeh: Fix unbalanced enable for IRQ) is
> >another brilliant example of trainwreck engineering.
> >
> >The patch "fixes" the issue of an unbalanced call to irq_enable()
> >which causes a prominent warning by checking the disabled state of the
> >interrupt line and call conditionally into the core code.
> >
> >This is wrong in two aspects:
> >
> >1) The warning is there to tell users, that they need to fix their
> >   asymetric enable/disable patterns by finding the root cause and
> >   solving it there.
> >
> >   It's definitely not meant to work around it by conditionally
> >   calling into the core code depending on the random state of the irq
> >   line.
> >
> >   Asymetric irq_disable/enable calls are a clear sign of wrong usage
> >   of the interfaces which have to be cured at the root and not by
> >   somehow hacking around it.
> >
> >2) The abuse of core internal data structure instead of using the
> >   proper interfaces for retrieving the information for the 'hack
> >   around'
> >
> >   irq_desc is core internal and it's clear enough stated.
> >
> >Replace at least the irq_desc abuse with the proper functions and add
> >a big fat comment why this is absurd and completely wrong.
> >
> 
> Thanks for pointing it out. I think we might have this patch for now
> and I'll look into individual drivers to fix the unbalanced function
> calls later one by one.

Fine with me. You wont escape my scan scripts :)

Thanks,

	tglx
