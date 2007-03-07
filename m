Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C9E3DDF97
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 01:43:30 +1100 (EST)
Subject: Re: [patch 2/6 -rt] powerpc 2.6.20-rt8: to convert spinlocks to
	raw ones.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <45EECE5C.6030100@ru.mvista.com>
References: <yyi8xe925vg.wl@toshiba.co.jp> <yyi649d25qz.wl@toshiba.co.jp>
	<45EECE5C.6030100@ru.mvista.com>
Content-Type: text/plain
Date: Wed, 07 Mar 2007 15:43:09 +0100
Message-Id: <1173278589.8635.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-07 at 17:38 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> Tsutomu OWA wrote:
> 
> > --- linux-rt8/arch/powerpc/kernel/irq.c	2007-02-20 14:30:38.000000000 +0900
> > +++ rt/arch/powerpc/kernel/irq.c	2007-03-05 18:54:34.000000000 +0900
> > @@ -392,7 +392,7 @@ EXPORT_SYMBOL(do_softirq);
> >  #ifdef CONFIG_PPC_MERGE
> >  
> >  static LIST_HEAD(irq_hosts);
> > -static spinlock_t irq_big_lock = SPIN_LOCK_UNLOCKED;
> > +static DEFINE_RAW_SPINLOCK(irq_big_lock);
> >  static DEFINE_PER_CPU(unsigned int, irq_radix_reader);
> >  static unsigned int irq_radix_writer;
> >  struct irq_map_entry irq_map[NR_IRQS];
> 
>     I've already sent a patch fixing this one (along with many others) a month 
> ago:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031164.html
> 
>     I wonder iof it was ever considered... :-/

It was but not for 2.6.21 timeframe due to people lack of time/bandwidth
among others :-)

I intend to try to spend some time before the 2.6.22 merge window to
gather those -rt related patches that can be merged already and push
them to powerpc.git.

(Note to mingo: that means that we might end up with patches both in
your tree and being push via powerpc, I hope that's not too much of a
problem).

I can't promise I'll have time to do much, but I'd like to do it, so
find me on irc every now and then to "poke" if you don't see anything
happening...

Cheers,
Ben.
