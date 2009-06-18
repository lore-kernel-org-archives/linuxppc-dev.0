Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3F186B7274
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 03:56:33 +1000 (EST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3B3CDDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 03:56:32 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5J3rdh2002783
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 13:53:39 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5IHuVh6888946
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 03:56:31 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5IHuVwd001164
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 03:56:31 +1000
Date: Thu, 18 Jun 2009 23:26:23 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [Patch 4/6] Modify process and processor handling code to
	recognise hardware debug registers
Message-ID: <20090618175623.GB4590@in.ibm.com>
References: <20090610090316.898961359@prasadkr_t60p.in.ibm.com>
	<20090610090818.GE14478@in.ibm.com>
	<20090617041420.GK486@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090617041420.GK486@yookeroo.seuss>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 17, 2009 at 02:14:20PM +1000, David Gibson wrote:
> On Wed, Jun 10, 2009 at 02:38:18PM +0530, K.Prasad wrote:
> > Modify process handling code to recognise hardware debug registers during copy
> > and flush operations. Introduce a new TIF_DEBUG task flag to indicate a
> > process's use of debug register. Load the debug register values into a
> > new CPU during initialisation.
> > 
> > Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/process.c |   15 +++++++++++++++
> >  arch/powerpc/kernel/smp.c     |    2 ++
> >  2 files changed, 17 insertions(+)
> > 
> > Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/process.c
> > ===================================================================
> > --- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/process.c
> > +++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/process.c
> > @@ -50,6 +50,7 @@
> >  #include <asm/syscalls.h>
> >  #ifdef CONFIG_PPC64
> >  #include <asm/firmware.h>
> > +#include <asm/hw_breakpoint.h>
> >  #endif
> >  #include <linux/kprobes.h>
> >  #include <linux/kdebug.h>
> > @@ -254,8 +255,10 @@ void do_dabr(struct pt_regs *regs, unsig
> >  			11, SIGSEGV) == NOTIFY_STOP)
> >  		return;
> >  
> > +#ifndef CONFIG_PPC64
> >  	if (debugger_dabr_match(regs))
> >  		return;
> > +#endif
> 
> Won't this disable the check for breakpoints set by xmon - but I don't
> see anything in this patch series to convert xmon to use the new
> breakpoint interface instead.
> 

As noted by me here:
http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-May/071832.html the
Xmon integration is pending. When I tried to study and integrate Xmon, I
found that the HW Breakpoint triggering was broken as of 2.6.29 kernel
(tested on a Power5 box).

This would mean that if Xmon's hardware breakpoint infrastructure is
used in tandem with the given breakpoint interfaces, they would conflict
with each other resulting in difficult-to-predict behaviour (the last to
grab the register will use it).

I think that tidying up do_dabr() is best done along with Xmon
integration.

> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson

Thanks,
K.Prasad
