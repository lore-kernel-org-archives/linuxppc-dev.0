Return-Path: <dwg@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CB644B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 13:31:04 +1000 (EST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C394DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 13:31:04 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id n753Skga007108
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 13:28:46 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n753V1oL978950
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 13:31:01 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n753V0AE022910
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 13:31:01 +1000
Date: Wed, 5 Aug 2009 12:55:32 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 2/6] Introduce PPC64 specific Hardware Breakpoint
	interfaces
Message-ID: <20090805025532.GA5358@yookeroo.seuss>
References: <20090726235854.574539012@prasadkr_t60p.in.ibm.com>
	<20090727001317.GC13562@in.ibm.com>
	<20090731061646.GH3950@yookeroo.seuss>
	<20090803205938.GB3914@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090803205938.GB3914@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 04, 2009 at 02:29:38AM +0530, K.Prasad wrote:
> On Fri, Jul 31, 2009 at 04:16:46PM +1000, David Gibson wrote:
> > On Mon, Jul 27, 2009 at 05:43:17AM +0530, K.Prasad wrote:
[snip]
> > > +	/* Verify if dar lies within the address range occupied by the symbol
> > > +	 * being watched. Since we cannot get the symbol size for
> > > +	 * user-space requests we skip this check in that case
> > > +	 */
> > > +	if (is_kernel &&
> > > +	    !((bp->info.address <= dar) &&
> > > +	     (dar <= (bp->info.address + bp->info.symbolsize))))
> > > +		/*
> > > +		 * This exception is triggered not because of a memory access on
> > > +		 * the monitored variable but in the double-word address range
> > > +		 * in which it is contained. We will consume this exception,
> > > +		 * considering it as 'noise'.
> > > +		 */
> > > +		goto out;
> > > +
> > > +	(bp->triggered)(bp, regs);
> > 
> > It bothers me that the trigger function is executed before the
> > trapping instruction, but the SIGTRAP occurs afterwards.  Since
> > they're both responses to the trap, it seems logical to me that they
> > should occur at the same time (from the trapping program's point of
> > view, at least).
> > 
> 
> How about moving the triggered function to the single-step handler code
> for both kernel- and user-space?
> 
> That would make it behave like a trigger-after-execute (and synchronised
> with the signal-delivery timing).

I think that would be an improvement, yes.  I definitely think the
SIGTRAP and the callback function should happen at the same time in
all cases.  Possibly even have the callback function issue the SIGTRAP
rather than special casing that.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
