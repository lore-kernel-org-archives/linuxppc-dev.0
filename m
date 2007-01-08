Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1876DDDF4
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 10:02:26 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.6) with ESMTP id l09B3xlb7618718
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 10:03:59 -0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l08N5Ldb143794
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 10:05:21 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l08N1qXU002549
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 10:01:52 +1100
Date: Tue, 9 Jan 2007 09:12:19 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: EMAC OF binding....
Message-ID: <20070108221219.GA20375@localhost.localdomain>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
	<8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
	<1168288352.22458.198.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1168288352.22458.198.camel@localhost.localdomain>
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
	Murali N Iyer <mniyer@us.ibm.com>, Hartmut Penner <HPENNER@de.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 09, 2007 at 07:32:32AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2007-01-08 at 07:38 +0100, Segher Boessenkool wrote:
> > >  - compatible        : compatible list, contains 2 entries, first is 
> > > "emac-CHIP" where
> > >                        CHIP is the host ASIC (440gx, 405gp, axon) and 
> > > second is either
> > >                        "emac" or "emac4".
> > >                        For axon, thus, we have: "emac-axon","emac4"
> > 
> > "ibm,emac-axon" etc. please.
> 
> Why ? In the -content- of a compatible property ? haven't seen that much
> before.

I tend to agree with Segher.  "emac" is a bit too generic - no doubt
some company either already has, or will later decide that "emac" is
an obvious name for their Ethernet MAC.  We want something to specify
that we're talking about IBM Microelectronics notion of "emac".

> > >  - local-mac-address : 6 bytes, MAC address
> > 
> > Don't forget "mac-address", if the device is opened
> > in OF; and "max-frame-size" please.
> 
> Yeah well, doesn't need to specify that, it's already specified :-) I'm
> talking about what the driver wants.
> 
> > >  - cell-index        : 1 cell, hardware index of the EMAC cell on a 
> > > given ASIC (typically
> > >                        0x00000000 and 0x00000001 for EMAC-0 and EMAC-1 
> > > on each Axon chip)
> > 
> > Can you find a better name?  What is this used for, anyway?
> 
> Propose one :-) There are various bits here or there where you have to
> know which EMAC in a chip you are talking about (clock control bits,
> that sort of thing).
> 
> > >  - max-mtu           : 1 cell, maximum MTU supported in bytes
> > 
> > See "max-frame-size", MTU is on a higher level than device
> > level and as such shouldn't be here; the OF networking layer
> > can set something like this if it wants.
> 
> Except that I don't want OF to set anything dynamically here. This is a
> way to prevent EMAC to do jumbo frames in fact.
> 
> > >  - mal-burst-size    : 1 cell, MAL burst size (used to calculate 
> > > thresholds)
> > 
> > In bytes?
> 
> Yup.

We should really set up a central place to record all these device
tree nodes and properties we're defining.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
