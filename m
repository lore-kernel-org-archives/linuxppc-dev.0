Return-Path: <hollisb@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36B38DDDF5
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 08:11:21 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78MBIZo024424
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 18:11:18 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78MBIm2524488
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 18:11:18 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78MBIN8013117
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 18:11:18 -0400
Subject: Re: Fix small race in 44x tlbie function
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20070808162951.46491bc7@weaponx.rchland.ibm.com>
References: <20070807042050.GJ13522@localhost.localdomain>
	<f9d9td$nov$1@sea.gmane.org>
	<20070808162951.46491bc7@weaponx.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 08 Aug 2007 17:11:09 -0500
Message-Id: <1186611069.765.13.camel@basalt>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: Hollis Blanchard <hollisb@us.ibm.com>
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

By "causes a tlb miss", you mean the interrupt handler associated with
the critical-priority UIC interrupt performs MMIO which causes a TLB
miss? Regular code couldn't cause a TLB miss AFAICS, since the kernel is
always mapped, and an interrupt handler doesn't access userspace.

-- 
Hollis Blanchard
IBM Linux Technology Center
