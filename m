Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Feb 2007 15:46:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Message-ID: <20070214044641.GB12402@localhost.localdomain>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
	<1171417866.20192.126.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171417866.20192.126.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 12:51:06PM +1100, Benjamin Herrenschmidt wrote:
> 
> > > > +	UIC0: interrupt-controller { /* UIC0 */
> > > 
> > > > +		#address-cells = <0>;
> > > > +		#size-cells = <0>;
> > > 
> > > #address-cells = 0 never makes sense.
> > 
> > Why not?  Children of this node have and need no reg property, and no
> > meaningful address.  Sounds like #address-cells = 0 to me.
> 
> In fact, not only it does make perfect sense but it's also routinely
> used for ... interrupt controllers :-) That's among others why the
> interrupt map entries "second" part usually doesn't contain the address
> cells.

Oh, btw, I take it you didn't think my method of placing the secondary
UICs under the node for UIC0 was insane.

> > > > +	plb {
> > > > +		device_type = "soc";
> > > > +		compatible = "ibm,plb-440gp", "ibm,plb4";
> > > > +		ranges;
> > > 
> > > You need a #address-cells, #size-cells here.
> > 
> > Why?  The values inherited from the root node are perfectly ok here.
> 
> Inheriting values is out of spec. The kernel somewhat does it but that's
> a bad habit, we should always have them explicit.

Ah, ok.  Values added.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
