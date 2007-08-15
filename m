Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89E8ADDEB7
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 04:44:31 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7FIiR7k017952
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 14:44:27 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7FIiRPb549706
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 14:44:27 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7FIiQAl025086
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 14:44:27 -0400
Date: Wed, 15 Aug 2007 13:43:09 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 4/4] PowerPC 440EPx: Sequoia board support
Message-ID: <20070815134309.169dffe8@zod.rchland.ibm.com>
In-Reply-To: <46C3053C.10108@ru.mvista.com>
References: <20070814184107.GA6696@ru.mvista.com>
	<20070814190409.GA12520@ru.mvista.com>
	<20070815034808.GC22849@localhost.localdomain>
	<46C3053C.10108@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 15 Aug 2007 17:53:00 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> David Gibson wrote:
> >> diff -ruN linux-2.6.orig/arch/powerpc/kernel/head_44x.S linux-2.6/arch/powerpc/kernel/head_44x.S
> >> --- linux-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-08-14 17:11:19.000000000 +0400
> >> +++ linux-2.6/arch/powerpc/kernel/head_44x.S	2007-08-14 17:18:43.000000000 +0400
> >> @@ -217,7 +217,7 @@
> >>  	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
> >>  	mtspr	SPRN_IVPR,r4
> >>  
> >> -#ifdef CONFIG_440EP
> >> +#if defined(CONFIG_440EP) || defined(CONFIG_440EPX)
> > 
> > Since we should now be able to support both 440GP and 440EP boards in
> > the same kernel, this probably needs to become a feature section.
> > 
> 
> Thanks for pointing that out.
> Talking about this, there appears to be more stuff that would need to 
> become feature sections. There're lots of other ifdefs in 
> arch/powerpc/kernel/head_44x.S, like ifdef CONFIG_PPC_FPU or ifdef 
> CONFIG_440A
> Looks like all these things have to be detected dynamically and 
> configured properly at runtime since we tend to support more than one 
> CPU in the same kernel.

Yes, definitely.  It's on my TODO list.  The "multiplatformness" of 44x
at the moment needs work.

> I think this should come as a separate patch, that replaces all these 
> ifdefs with the FTR_SECTION stuff.

I agree.  I'd like to do this as a separate patch later rather than hold
up Sequoia at the moment.

josh
