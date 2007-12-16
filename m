Return-Path: <dgibson@ozlabs.org>
Date: Sun, 16 Dec 2007 17:40:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
Message-ID: <20071216064056.GH21311@localhost.localdomain>
References: <20071129150726.GA13751@ru.mvista.com>
	<20071129152836.GB13751@ru.mvista.com>
	<20071210211816.4657.qmail@farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071210211816.4657.qmail@farnsworth.org>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 02:18:16PM -0700, Dale Farnsworth wrote:
> David Gibson wrote:
> > On Thu, Nov 29, 2007 at 06:28:36PM +0300, Andrei Dolnikov wrote:
> > > Device tree source file for the Emerson Katana Qp board
> 
> [snip]
> 
> > > +	mv64x60@f8100000 { /* Marvell Discovery */
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +		model = "mv64460";			/* Default */
> > > +		compatible = "marvell,mv64x60";
> 
> [snip]
> 
> > > +		mdio {
> > 
> > There must be some way of actuall accessing the mdio bus, so this node
> > ought to have a 'reg' property and unit address.
> 
> There is no way for the cpu to directly access the mdio bus.  The
> mdio bus is internally accessed by the ethernet MAC.  That being the
> case, maybe it makes more sense to move the mdio node inside of the
> multiethernet node, as follows, but I don't see how we can give it
> a reg property or a unit address.

Ah, I see.  If the mdio interface isn't distinct from the other
pieces, then it probably shouldn't get a device node at all.  Having
an explicit mdio bus with the phys hanging off it is convenient for
hardware which actually works that way, but it doesn't have to be done
like that.

Of course, then the question is where to hang the phy nodes, which
look like they have information you need.  Since you already have a
local addressing scheme for the MACs under the multiethernet, what
probably makes sense would be to hang the phys directly under the
multiethernet, using an encoding scheme for the reg properties so that
the MACs and PHYs aren't confused (say, MACs are 0x0, 0x1, 0x2, PHYs
are 0x80000000, 0x80000001, 0x80000002).

Incidentally, although I suggested it, I'm not all that fond of the
"multiethernet" name, it was just the first thing that occurred to me.

> 
> 		multiethernet@2000 {
> 			reg = <0x2000 0x2000>;
> 			ethernet@0 {
> 				device_type = "network";
> 				compatible = "marvell,mv64360-eth";
> 				reg = <0>;
> 				interrupts = <32>;
> 				interrupt-parent = <&PIC>;
> 				phy = <&PHY0>;
> 				local-mac-address = [ 00 00 00 00 00 00 ];
> 			};
> 			ethernet@1 {
> 				device_type = "network";
> 				compatible = "marvell,mv64360-eth";
> 				reg = <1>;
> 				interrupts = <33>;
> 				interrupt-parent = <&PIC>;
> 				phy = <&PHY1>;
> 				local-mac-address = [ 00 00 00 00 00 00 ];
> 			};
> 			mdio {
> 				#address-cells = <1>;
> 				#size-cells = <0>;
> 				device_type = "mdio";
> 				compatible = "marvell,mv64360-mdio";
> 				PHY0: ethernet-phy@1 {
> 					device_type = "ethernet-phy";
> 					compatible = "broadcom,bcm5421";
> 					interrupts = <76>;	/* GPP 12 */
> 					interrupt-parent = <&PIC>;
> 					reg = <1>;
> 				};
> 				PHY1: ethernet-phy@3 {
> 					device_type = "ethernet-phy";
> 					compatible = "broadcom,bcm5421";
> 					interrupts = <76>;	/* GPP 12 */
> 					interrupt-parent = <&PIC>;
> 					reg = <3>;
> 				};
> 			};
> 		};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
