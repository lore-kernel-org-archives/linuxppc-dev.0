Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 70C87DDE9D
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 15:52:47 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l7G5tEh61917148
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 15:55:14 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7G5pw8h4231388
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 15:51:58 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7G5pwcS012436
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 15:51:58 +1000
Date: Thu, 16 Aug 2007 15:48:02 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] PowerPC 440EPx: Sequoia board support
Message-ID: <20070816054802.GG3540@localhost.localdomain>
References: <20070814184107.GA6696@ru.mvista.com>
	<20070814190409.GA12520@ru.mvista.com>
	<20070815034808.GC22849@localhost.localdomain>
	<46C3053C.10108@ru.mvista.com>
	<20070815134309.169dffe8@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070815134309.169dffe8@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 15, 2007 at 01:43:09PM -0500, Josh Boyer wrote:
> On Wed, 15 Aug 2007 17:53:00 +0400
> Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> 
> > David Gibson wrote:
> > >> diff -ruN linux-2.6.orig/arch/powerpc/kernel/head_44x.S linux-2.6/arch/powerpc/kernel/head_44x.S
> > >> --- linux-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-08-14 17:11:19.000000000 +0400
> > >> +++ linux-2.6/arch/powerpc/kernel/head_44x.S	2007-08-14 17:18:43.000000000 +0400
> > >> @@ -217,7 +217,7 @@
> > >>  	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
> > >>  	mtspr	SPRN_IVPR,r4
> > >>  
> > >> -#ifdef CONFIG_440EP
> > >> +#if defined(CONFIG_440EP) || defined(CONFIG_440EPX)
> > > 
> > > Since we should now be able to support both 440GP and 440EP boards in
> > > the same kernel, this probably needs to become a feature section.
> > > 
> > 
> > Thanks for pointing that out.
> > Talking about this, there appears to be more stuff that would need to 
> > become feature sections. There're lots of other ifdefs in 
> > arch/powerpc/kernel/head_44x.S, like ifdef CONFIG_PPC_FPU or ifdef 
> > CONFIG_440A
> > Looks like all these things have to be detected dynamically and 
> > configured properly at runtime since we tend to support more than one 
> > CPU in the same kernel.
> 
> Yes, definitely.  It's on my TODO list.  The "multiplatformness" of 44x
> at the moment needs work.

True.  Note that not all of them necessarily need to change to feature
sections, though most of them probably do:  if the code inside is
harmless, just useless for other platforms it can remain an #ifdef -
the code will run on any kernel with the relevant platform configured.

> > I think this should come as a separate patch, that replaces all these 
> > ifdefs with the FTR_SECTION stuff.
> 
> I agree.  I'd like to do this as a separate patch later rather than hold
> up Sequoia at the moment.

Fair enough.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
