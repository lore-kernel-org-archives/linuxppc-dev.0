Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC32ADDE1C
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 09:53:08 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78Nr56m021399
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 19:53:05 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78Nr4RU527392
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 19:53:04 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78Nr4PO005199
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 19:53:04 -0400
Date: Wed, 8 Aug 2007 19:06:46 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fix small race in 44x tlbie function
Message-ID: <20070809000646.GD3925@crusty.rchland.ibm.com>
References: <20070807042050.GJ13522@localhost.localdomain>
	<f9d9td$nov$1@sea.gmane.org>
	<20070808162951.46491bc7@weaponx.rchland.ibm.com>
	<1186614089.938.207.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1186614089.938.207.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 09, 2007 at 09:01:29AM +1000, Benjamin Herrenschmidt wrote:
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
> > 
> > CE and DE are admittedly a much smaller race, but still possible.
> > Masking EE off is the largest one.
> 
> There is a much bigger problem if CEs can do tlb misses though... they
> can interrupt the tlb miss handler itself, either between the two halves
> of a tlb write, or between the write to MMUCR and the write to the tlb,
> and I suspect both cases will cause trouble.

Yes.

> We might want to check if we were in the TLB miss handler upon return
> from the CE and MCE handlers, and in this case, restart them (just
> return to the faulting instruction, that is use srr0 instead of
> csrr0/mcsrr0).

Something should be looked at, yeah.  

josh
