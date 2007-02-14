Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070214002210.GE11491@localhost.localdomain>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 12:51:06 +1100
Message-Id: <1171417866.20192.126.camel@localhost.localdomain>
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


> > > +	UIC0: interrupt-controller { /* UIC0 */
> > 
> > > +		#address-cells = <0>;
> > > +		#size-cells = <0>;
> > 
> > #address-cells = 0 never makes sense.
> 
> Why not?  Children of this node have and need no reg property, and no
> meaningful address.  Sounds like #address-cells = 0 to me.

In fact, not only it does make perfect sense but it's also routinely
used for ... interrupt controllers :-) That's among others why the
interrupt map entries "second" part usually doesn't contain the address
cells.

> > > +	plb {
> > > +		device_type = "soc";
> > > +		compatible = "ibm,plb-440gp", "ibm,plb4";
> > > +		ranges;
> > 
> > You need a #address-cells, #size-cells here.
> 
> Why?  The values inherited from the root node are perfectly ok here.

Inheriting values is out of spec. The kernel somewhat does it but that's
a bad habit, we should always have them explicit.

Ben.
