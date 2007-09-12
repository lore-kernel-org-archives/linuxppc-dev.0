Return-Path: <dgibson@ozlabs.org>
Date: Wed, 12 Sep 2007 13:53:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Message-ID: <20070912035351.GF20218@localhost.localdomain>
References: <Pine.LNX.4.64.0709111436290.14121@blarg.am.freescale.net>
	<20070912031132.GC20218@localhost.localdomain>
	<AC5C6EF4-EE8E-487F-BF45-3653A5C2617D@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AC5C6EF4-EE8E-487F-BF45-3653A5C2617D@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 10:33:20PM -0500, Kumar Gala wrote:
> 
> On Sep 11, 2007, at 10:11 PM, David Gibson wrote:
> 
> > On Tue, Sep 11, 2007 at 02:37:56PM -0500, Kumar Gala wrote:
> >> Added basic board port for MPC8572 DS reference platform that is
> >> similiar to the MPC8544/33 DS reference platform in uniprocessor  
> >> mode.
> >>
> >> ---
> >>
> >> Rev 3 -- updates to the device tree based on discussion on how we  
> >> want
> >> to handle memory busses going forward.
> >
> > [snip]
> >> +		mdio@24520 {
> >> +			#address-cells = <1>;
> >> +			#size-cells = <0>;
> >> +			device_type = "mdio";
> >
> > I don't think we actually have an mdio device_type binding defined.
> 
> We've had this on 83xx/85xx/86xx device trees for a far amount of  
> time now.  Look at section 2a in booting-without-of.txt

Ah, so we have; sorry.  Although the binding as it is currently
written is pretty much pointless - it should actually define some
mappings between dt properties / addresses and the standards defining
the MDIO bus.x

> >
> >> +			compatible = "gianfar";
> >
> > This needs to be more specific.  And it certainly shouldn't be the
> > same compatible string as the ethernet MACs have.
> 
> Why not its the same controller?  Again, we've been doing this for  
> some period of time already.

Yes you have, but it's still crap.  'compatible' should be sufficient
to distinguish the driver needed for device nodes, but the MACs and
MDIO should clearly have different drivers (or at least, different
parts of a driver).

> >> +			reg = <24520 20>;
> >> +			phy0: ethernet-phy@0 {
> >> +				interrupt-parent = <&mpic>;
> >> +				interrupts = <a 1>;
> >> +				reg = <0>;
> >> +				device_type = "ethernet-phy";
> >
> > Do we actually have an ethernet-phy device_type binding?  If not, we
> > should kill this.  'compatible' properties for phys would probably be
> > a good idea, though (giving the actual phy model).
> 
> Look section 2c in booting-without-of.txt

Ah, yes.  That one's a rather less redeemable pointless device_type
binding.  We should kill it from booting-without-of.txt.

> >> +			reg = <e0000 1000>;
> >> +			fsl,has-rstcr;
> >> +		};
> >> +
> >> +		mpic: pic@40000 {
> >> +			clock-frequency = <0>;
> >> +			interrupt-controller;
> >> +			#address-cells = <0>;
> >> +			#interrupt-cells = <2>;
> >> +			reg = <40000 40000>;
> >> +			compatible = "chrp,open-pic";
> >> +			device_type = "open-pic";
> >> +			big-endian;
> >> +		};
> >> +	};
> >> +
> >> +	pcie@ffe08000 {
> >> +		compatible = "fsl,mpc8548-pcie";
> >
> > And again, "fsl,mpc8572-pcie", "fsl,mpc8548-pcie".
> 
> But why?  there is no difference between the PCIe controller in  
> mpc8548 and mpc8572?

As far as you've yet discovered...

> >> +		uli1575@0 {
> >> +			reg = <0 0 0 0 0>;
> >
> > This looks kind of bogus...
> 
> Its a PCIe to PCI bridge that is transparent.

Right.... if it has no control registers, I think it should just lack
'reg', not define a zero-length register block.

> >> +			#size-cells = <2>;
> >> +			#address-cells = <3>;
> >> +			ranges = <02000000 0 80000000
> >> +				  02000000 0 80000000
> >> +				  0 20000000
> >> +				  01000000 0 00000000
> >> +				  01000000 0 00000000
> >> +				  0 00100000>;

And if truly transparent, it should perhaps have just ranges;
indicating that child addresses are identity mapped to parent
addresses.

> >> +
> >> +			pci_bridge@0 {
> >
> > Ok.. why is pci_bridge nested within uli1575 - with the matching reg
> > and ranges, it looks like they ought to be one device.  Also if this
> > is a PCI<->PCI bridge, I believe it shold have device_type = "pci".
> 
> We've been using this as it stands for a while.  If there are some  
> changes here that make sense I'm willing to make them.

Right, at present I don't see why you couldn't just ditch the
pci_bridge node, and drop its contents straight into the uli1575 node.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
