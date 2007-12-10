Return-Path: <dale@farnsworth.org>
Date: 10 Dec 2007 14:18:16 -0700
Message-ID: <20071210211816.4657.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: Linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
In-Reply-To: <20071203015018.GC26919@localhost.localdomain>
References: <20071129150726.GA13751@ru.mvista.com>
	<20071129152836.GB13751@ru.mvista.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Thu, Nov 29, 2007 at 06:28:36PM +0300, Andrei Dolnikov wrote:
> > Device tree source file for the Emerson Katana Qp board

[snip]

> > +	mv64x60@f8100000 { /* Marvell Discovery */
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		model = "mv64460";			/* Default */
> > +		compatible = "marvell,mv64x60";

[snip]

> > +		mdio {
> 
> There must be some way of actuall accessing the mdio bus, so this node
> ought to have a 'reg' property and unit address.

There is no way for the cpu to directly access the mdio bus.  The
mdio bus is internally accessed by the ethernet MAC.  That being the
case, maybe it makes more sense to move the mdio node inside of the
multiethernet node, as follows, but I don't see how we can give it
a reg property or a unit address.

		multiethernet@2000 {
			reg = <0x2000 0x2000>;
			ethernet@0 {
				device_type = "network";
				compatible = "marvell,mv64360-eth";
				reg = <0>;
				interrupts = <32>;
				interrupt-parent = <&PIC>;
				phy = <&PHY0>;
				local-mac-address = [ 00 00 00 00 00 00 ];
			};
			ethernet@1 {
				device_type = "network";
				compatible = "marvell,mv64360-eth";
				reg = <1>;
				interrupts = <33>;
				interrupt-parent = <&PIC>;
				phy = <&PHY1>;
				local-mac-address = [ 00 00 00 00 00 00 ];
			};
			mdio {
				#address-cells = <1>;
				#size-cells = <0>;
				device_type = "mdio";
				compatible = "marvell,mv64360-mdio";
				PHY0: ethernet-phy@1 {
					device_type = "ethernet-phy";
					compatible = "broadcom,bcm5421";
					interrupts = <76>;	/* GPP 12 */
					interrupt-parent = <&PIC>;
					reg = <1>;
				};
				PHY1: ethernet-phy@3 {
					device_type = "ethernet-phy";
					compatible = "broadcom,bcm5421";
					interrupts = <76>;	/* GPP 12 */
					interrupt-parent = <&PIC>;
					reg = <3>;
				};
			};
		};

Look OK?

-Dale
