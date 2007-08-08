Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C7D5DDEB6
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 09:01:35 +1000 (EST)
Subject: Re: Fix small race in 44x tlbie function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20070808162951.46491bc7@weaponx.rchland.ibm.com>
References: <20070807042050.GJ13522@localhost.localdomain>
	<f9d9td$nov$1@sea.gmane.org>
	<20070808162951.46491bc7@weaponx.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 09:01:29 +1000
Message-Id: <1186614089.938.207.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-08-08 at 16:29 -0500, Josh Boyer wrote:
> On Wed, 8 Aug 2007 20:43:25 +0000 (UTC)
> Hollis Blanchard <hollisb@us.ibm.com> wrote:
> 
> > On Tue, 07 Aug 2007 14:20:50 +1000, David Gibson wrote:
> > > 
> > > This patch fixes the problem in both arch/ppc and arch/powerpc by
> > > inhibiting interrupts (even critical and debug interrupts) across the
> > > relevant instructions.
> > 
> > How could a critical or debug interrupt modify the contents of MMUCR?
> 
> Interrupts from UICs can be configured as critical.  If one of those
> triggers, (or any other CE triggers) and causes a tlb miss, you have a
> race.  The watchdog timer interrupt also is a CE IIRC.
> 
> CE and DE are admittedly a much smaller race, but still possible.
> Masking EE off is the largest one.

There is a much bigger problem if CEs can do tlb misses though... they
can interrupt the tlb miss handler itself, either between the two halves
of a tlb write, or between the write to MMUCR and the write to the tlb,
and I suspect both cases will cause trouble.

We might want to check if we were in the TLB miss handler upon return
from the CE and MCE handlers, and in this case, restart them (just
return to the faulting instruction, that is use srr0 instead of
csrr0/mcsrr0).

Ben.
