Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 77D1DDDED7
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 15:39:30 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l795fPMr4706444
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 15:41:25 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l795fam6004174
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 15:41:37 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l795c2uS018355
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 15:38:03 +1000
Date: Thu, 9 Aug 2007 15:34:23 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Fix small race in 44x tlbie function
Message-ID: <20070809053423.GJ8261@localhost.localdomain>
References: <20070807042050.GJ13522@localhost.localdomain>
	<BDA0DE7D-8AD8-4116-ABE0-2DF6AE72A516@kernel.crashing.org>
	<20070808110029.43c110ef@weaponx.rchland.ibm.com>
	<57F869A4-38DE-4CC9-A07D-C3A873CE9268@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57F869A4-38DE-4CC9-A07D-C3A873CE9268@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Volkmar Uhlig <vuhlig@us.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Todd Inglett <tinglett@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 09, 2007 at 12:28:20AM -0500, Kumar Gala wrote:
> 
> On Aug 8, 2007, at 11:00 AM, Josh Boyer wrote:
> 
> > On Wed, 8 Aug 2007 10:20:45 -0500
> > Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> >>
> >> On Aug 6, 2007, at 11:20 PM, David Gibson wrote:
> >>
> >>> The 440 family of processors don't have a tlbie instruction.  So, we
> >>> implement TLB invalidates by explicitly searching the TLB with  
> >>> tlbsx.,
> >>> then clobbering the relevant entry, if any.  Unfortunately the  
> >>> PID for
> >>> the search needs to be stored in the MMUCR register, which is also
> >>> used by the TLB miss handler.  Interrupts were enabled in _tlbie 
> >>> (), so
> >>> an interrupt between loading the MMUCR and the tlbsx could cause
> >>> incorrect search results, and thus a failure to invalide TLB entries
> >>> which needed to be invalidated.
> >>>
> >>> This patch fixes the problem in both arch/ppc and arch/powerpc by
> >>> inhibiting interrupts (even critical and debug interrupts) across  
> >>> the
> >>> relevant instructions.
> >>>
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>> ---
> >>> Paul, this one's a bugfix, which I think should go into 2.6.23.
> >>
> >> Did you actually see this happen?
> >
> > Yes.
> 
> When?
> 
> We don't have critical wired to anything, I don't expect watchdog to  
> cause another fault.. so just wondering.

On debug (trace) interrupts on blue gene.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
