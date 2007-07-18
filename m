Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F1ABDDE22
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 10:47:04 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l6N1ANWo225944
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 11:10:23 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6N0oZDc173626
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 10:50:35 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6N0l2jf024136
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 10:47:02 +1000
Date: Wed, 18 Jul 2007 11:02:21 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
Message-ID: <20070718010221.GA21877@localhost.localdomain>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<1184176531.32199.81.camel@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1184176531.32199.81.camel@weaponx.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 11, 2007 at 12:55:31PM -0500, Josh Boyer wrote:
> On Wed, 2007-07-11 at 19:49 +0200, Segher Boessenkool wrote:
> > > +	UIC0: interrupt-controller0 {
> > 
> > Why not just "interrupt-controller"?
> 
> Copy/paste error from Ebony DTS, which has multiple UICs.  Will fix.
> 
> > 
> > > +		#address-cells = <0>;
> > > +		#size-cells = <0>;
> > 
> > No need for these.
> 
> Ok.
> 
> > >
> > > +	plb {
> > > +		ranges;
> > 
> > Please make the valid address ranges explicit here.
> 
> Meaning what exactly?  I thought just specifying "ranges;" simply said
> "the addresses from this node don't have any translation from the parent
> node" (or something like that).
> 
> > 
> > > +		SDRAM0: memory-controller {
> > > +			compatible = "ibm,sdram-405gp", "ibm,sdram-440gp";
> > 
> > It's a bit weird to mention 440 here, since 405 is older.
> > Not a real problem, but if you still can change all relevant
> > OS code and device trees, I'd swap it around (make 440 trees
> > include the 405 "compatible" value).  Can you still do that
> > or is there a too big installed base already?
> 
> The installed base for 440 exists of exactly 1 completely non-functional
> board ;).  I can change it.

And I don't think we even actually look at this compatible property in
practice.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
