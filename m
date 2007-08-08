Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E15ADDE0F
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 09:30:22 +1000 (EST)
Subject: Re: Fix small race in 44x tlbie function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <1186611069.765.13.camel@basalt>
References: <20070807042050.GJ13522@localhost.localdomain>
	<f9d9td$nov$1@sea.gmane.org>
	<20070808162951.46491bc7@weaponx.rchland.ibm.com>
	<1186611069.765.13.camel@basalt>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 09:30:08 +1000
Message-Id: <1186615808.938.209.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-08-08 at 17:11 -0500, Hollis Blanchard wrote:
> On Wed, 2007-08-08 at 16:29 -0500, Josh Boyer wrote:
> > On Wed, 8 Aug 2007 20:43:25 +0000 (UTC)
> > Hollis Blanchard <hollisb@us.ibm.com> wrote:
> > 
> > > On Tue, 07 Aug 2007 14:20:50 +1000, David Gibson wrote:
> > > > 
> > > > This patch fixes the problem in both arch/ppc and arch/powerpc by
> > > > inhibiting interrupts (even critical and debug interrupts) across the
> > > > relevant instructions.
> > > 
> > > How could a critical or debug interrupt modify the contents of MMUCR?
> > 
> > Interrupts from UICs can be configured as critical.  If one of those
> > triggers, (or any other CE triggers) and causes a tlb miss, you have a
> > race.  The watchdog timer interrupt also is a CE IIRC.
> 
> By "causes a tlb miss", you mean the interrupt handler associated with
> the critical-priority UIC interrupt performs MMIO which causes a TLB
> miss? Regular code couldn't cause a TLB miss AFAICS, since the kernel is
> always mapped, and an interrupt handler doesn't access userspace.

ioremap is an example, vmalloc space is another...

Ben.
