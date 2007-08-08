Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AB61DDDE1B
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 09:27:57 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78NRpOE010158
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 19:27:51 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78NRpF0218116
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 17:27:51 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78NRoGI017595
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 17:27:50 -0600
Date: Wed, 8 Aug 2007 18:41:36 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: Fix small race in 44x tlbie function
Message-ID: <20070808234136.GC3925@crusty.rchland.ibm.com>
References: <20070807042050.GJ13522@localhost.localdomain>
	<f9d9td$nov$1@sea.gmane.org>
	<20070808162951.46491bc7@weaponx.rchland.ibm.com>
	<1186611069.765.13.camel@basalt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1186611069.765.13.camel@basalt>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 08, 2007 at 05:11:09PM -0500, Hollis Blanchard wrote:
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

Yes.

josh
