Return-Path: <dgibson@ozlabs.org>
Date: Thu, 30 Aug 2007 10:55:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] Introduce new CPM device bindings.
Message-ID: <20070830005559.GB22844@localhost.localdomain>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201619.GB24210@ld0162-tx32.am.freescale.net>
	<20070829053941.GC3206@localhost.localdomain>
	<20070829135806.GB30184@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070829135806.GB30184@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2007 at 08:58:06AM -0500, Scott Wood wrote:
> On Wed, Aug 29, 2007 at 03:39:41PM +1000, David Gibson wrote:
> > On Tue, Aug 28, 2007 at 03:16:19PM -0500, Scott Wood wrote:
> > > Boards that do not require the legacy bindings should select
> > > CONFIG_PPC_CPM_NEW_BINDING to enable the of_platform CPM devices. Once
> > > all existing boards are converted and tested, the config option can
> > > become default y to prevent new boards from using the old model.  Once
> > > arch/ppc is gone, the config option can be removed altogether.
> > 
> > I think it would be better to change the name and reverse the sense of
> > this config option, since what it actually does is disable the old
> > binding, not enable the new one.
> 
> But then boards would have to deselect rather than select the option...
> can kconfig do that?

Sorry, as I read later patches in the series, I realised your config
option didn't do what I thought it did when I said that.

Am I correct in thinking that it's basically an arch/ppc versus
arch/powerpc thing.  In which case couldn't you use CONFIG_PPC_MERGE
instead?

[snip]
> > > +   ii) Properties common to mulitple CPM/QE devices
> > > +
> > > +   - fsl,cpm-command : This value is ORed with the opcode and command flag
> > > +                       to specify the device on which a CPM command operates.
> > > +
> > > +   - fsl,cpm-brg : Indicates which baud rate generator the device
> > > +                   is associated with.  If absent, an unused BRG
> > > +                   should be dynamically allocated.
> > 
> > Maybe a property with the brg node's phandle could be included as
> > well, to avoid having to hop up to the CPM node, then back down to the
> > brg-compatible node to find it?
> 
> Enh... it doesn't convey any new information, and in practice, it's done
> by common CPM code that doesn't know about the individual device's node
> anyway.


> > Or maybe even have a separate subnode for each brg, and just have a
> > phandle to reference it from the other devices, rather than using this
> > index.
> 
> Seems a little complex relative to the gain.

Hrm, I guess.  I just have a dislike for random indices into things.

> > > +   Example:
> > > +
> > > +	ethernet@11300 {
> > > +		device_type = "network";
> > > +		compatible = "fsl,mpc8272-fcc-enet",
> > > +		             "fsl,cpm2-fcc-enet";
> > > +		reg = <11300 20 8400 100 11390 1>;
> > > +		local-mac-address = [ 00 00 00 00 00 00 ];
> > > +		interrupts = <20 8>;
> > > +		interrupt-parent = <&PIC>;
> > > +		phy-handle = <&PHY0>;
> > > +		linux,network-index = <0>;
> > > +		fsl,cpm-command = <12000300>;
> > > +	};
> > 
> > Should this also have a phandle pointer to the mdio node?
> 
> It has a phandle to the phy node...  if you mean the mdio bus node, why?

Well, I'm just working of the example of 4xx EMAC.  The way it does
mdio, it wants a handle on the mdio bus to perform various operations
there as well on the phy to tell it how to address them.  fsl-enet may
do things differently and have no particular need for such a handle.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
