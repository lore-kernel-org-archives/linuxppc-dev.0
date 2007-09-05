Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 540CEDDDF9
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 12:38:28 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id l852cRnh009561
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 12:38:27 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l852cRs94358360
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 12:38:27 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l852cRqL016839
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 12:38:27 +1000
Date: Wed, 5 Sep 2007 12:36:12 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 3/6] Walnut DTS
Message-ID: <20070905023612.GD17189@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>
	<20070831200643.202414000@linux.vnet.ibm.com>
	<20070903010859.GD31499@localhost.localdomain>
	<1188741584.3772.7.camel@localhost.localdomain>
	<20070904074203.748030c7@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070904074203.748030c7@weaponx.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 04, 2007 at 07:42:03AM -0500, Josh Boyer wrote:
> On Sun, 02 Sep 2007 08:59:44 -0500
> Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
[snip]
> > > > +		POB0: opb {
> > > > +			compatible = "ibm,opb";
> > > 
> > > Need an opb-405gp here, too.
> > 
> > Yep.
> 
> Fixed.
> 
> > > > +			#address-cells = <1>;
> > > > +			#size-cells = <1>;
> > > > +			ranges = <0 ef600000 a00000>;
> > > 
> > > Hrm... something we ought to clarify is the interpretation of the
> > > POB0_BEAR register with respect to the bridge's ranges property.  For
> > > 440 I think the BEAR will need to be interpreted as an OPB address,
> > > rather than a PLB address, but I'm not sure if that will work here
> > > with the limited ranges property you have.
> > 
> > Ok, I'll look at this.
> 
> The BEAR will still be interpreted as a PLB address here as far as I
> can see.  The ranges spans the entire OPB space.  Am I missing
> something?

Ah, sorry, my mistake.  I thought the BEAR register would encode an
OPB address rather than a PLB address (and thus, be only 32-bits wide
on 440).  In fact it appears it does encode a PLB address (and is
split into BEARH and BEARL registers on 440).

Hrm.. I'm still slightly uneasy though.  In my Ebony device tree, the
POB's ranges exists to embed the 32-bit OPB space into the 64-bit PLB
space by tacking on a 0x1 in bits 32:35.  In your 405gp ranges, you're
describing just the address range used by OPB peripherals
(0xef600000-0xf0000000) as residing at address 0 in OPB-space.

Since the ranges will still generate the right physical addresses, I
guess it doesn't matter.  But I'm not sure it meets the principle of
least surprise - since I think the documentation generally talks as
though addresses on the 405 OPB bus are identical to addreses on the
PLB.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
