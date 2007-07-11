Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B2CFDDDEFE
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 03:55:39 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l6BHo7qw021039
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 13:50:07 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6BHtXjN225486
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 11:55:34 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6BHtWI9031998
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 11:55:32 -0600
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 11 Jul 2007 12:55:31 -0500
Message-Id: <1184176531.32199.81.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-11 at 19:49 +0200, Segher Boessenkool wrote:
> > +	UIC0: interrupt-controller0 {
> 
> Why not just "interrupt-controller"?

Copy/paste error from Ebony DTS, which has multiple UICs.  Will fix.

> 
> > +		#address-cells = <0>;
> > +		#size-cells = <0>;
> 
> No need for these.

Ok.

> >
> > +	plb {
> > +		ranges;
> 
> Please make the valid address ranges explicit here.

Meaning what exactly?  I thought just specifying "ranges;" simply said
"the addresses from this node don't have any translation from the parent
node" (or something like that).

> 
> > +		SDRAM0: memory-controller {
> > +			compatible = "ibm,sdram-405gp", "ibm,sdram-440gp";
> 
> It's a bit weird to mention 440 here, since 405 is older.
> Not a real problem, but if you still can change all relevant
> OS code and device trees, I'd swap it around (make 440 trees
> include the 405 "compatible" value).  Can you still do that
> or is there a too big installed base already?

The installed base for 440 exists of exactly 1 completely non-functional
board ;).  I can change it.

> 
> > +		POB0: opb {
> > +			ranges;
> 
> Similar question as for PLB here.
> 
> > +			UART0: serial@ef600300 {
> > +				current-speed = <2580>;
> 
> Write this in decimal?

In a comment?  Or?

> Quite a nice tree btw :-)

Thanks!  Easy to do when there's nothing in it ;)

josh
