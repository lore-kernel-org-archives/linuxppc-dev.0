Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Feb 2007 11:22:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Message-ID: <20070214002210.GE11491@localhost.localdomain>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2007 at 09:08:52PM +0100, Segher Boessenkool wrote:
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		PowerPC,440GP {
> 
> PowerPC,440GP@0

Hmm.. yeah, I'll fix that.

> > +			clock-frequency = <5F5E100>; /* 100MHz FIXME: poke in zImage */
> > +			timebase-frequency = <5F5E100>; /* 100MHz FIXME: wrong, poke in 
> > zImage */
> 
> Can't you use decimal for these?

dtc doesn't support decimal cells at present.  Suggest a good syntax
for doing it, and I'll add the feature.

> > +	UIC0: interrupt-controller { /* UIC0 */
> 
> > +		#address-cells = <0>;
> > +		#size-cells = <0>;
> 
> #address-cells = 0 never makes sense.

Why not?  Children of this node have and need no reg property, and no
meaningful address.  Sounds like #address-cells = 0 to me.

> > +	plb {
> > +		device_type = "soc";
> > +		compatible = "ibm,plb-440gp", "ibm,plb4";
> > +		ranges;
> 
> You need a #address-cells, #size-cells here.

Why?  The values inherited from the root node are perfectly ok here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
