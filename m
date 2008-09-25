Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 943F0DDE21
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 17:31:29 +1000 (EST)
Date: Thu, 25 Sep 2008 09:31:19 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH HACK] powerpc: quick hack to get a functional eHEA with
	hardirq preemption
Message-ID: <20080925093119.5dd4df4c@bull.net>
In-Reply-To: <1222290847.8277.81.camel@pasglop>
References: <200809231743.23828.ossthema@de.ibm.com>
	<20080915100406.342e027a@bull.net>
	<200809240958.m8O9wM7k010996@sullivan.realtime.net>
	<1222251467.8277.73.camel@pasglop>
	<f30d1d832fd4ad096afccf198c14a7bb@bga.com>
	<1222290847.8277.81.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Jan-Bernd Themann <ossthema@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Christoph Raisch <RAISCH@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 25 Sep 2008 07:14:07 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > There may be some implicit assumption in that we expect the cpu 
> > priority to be returned to normal by the EOI, but there is nothing in 
> > the hardware that requires the EOI to come from the same cpu as 
> > accepted the interrupt for processing, with the exception of the IPI 
> > which is per-cpu (and the only interrupt that is per-cpu).
> 
> Well, there is one fundamental one: The XIRR register we access is
> per-CPU, so if we are to return the right processor priority, we must
> make sure we write the right XIRR.

  That's already the case as the irq fetch (xx_xirr_info_get()) and
eoi (xx_xirr_info_set()) are both done in interrupt context, therefore on
the same cpu.

> 
> Same with Cell, MPIC, actually and a few others. In general I'd say most
> fast_eoi type PICs have this requirement.
> 
> > It would probably mean adding the concept of the current cpu priority 
> > vs interrupts and making sure we write it to hardware at irq_exit() 
> > time when deferring the actual irq handlers.
> 
> I think we need something like a special -rt variant of the fast_eoi
> handler that masks & eoi's in ack() before the thread is spun off, and
> unmasks instead of eoi() when the irq processing is complete.

  This is what is already done in the threaded case:

    - fetch + mask + eoi  in interrupt context

    - unmask in the thread when processing is complete.


  Sebastien.
