Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF908DDE2E
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 00:05:49 +1000 (EST)
Date: Wed, 29 Aug 2007 08:58:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] Introduce new CPM device bindings.
Message-ID: <20070829135806.GB30184@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201619.GB24210@ld0162-tx32.am.freescale.net>
	<20070829053941.GC3206@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070829053941.GC3206@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2007 at 03:39:41PM +1000, David Gibson wrote:
> On Tue, Aug 28, 2007 at 03:16:19PM -0500, Scott Wood wrote:
> > Boards that do not require the legacy bindings should select
> > CONFIG_PPC_CPM_NEW_BINDING to enable the of_platform CPM devices. Once
> > all existing boards are converted and tested, the config option can
> > become default y to prevent new boards from using the old model.  Once
> > arch/ppc is gone, the config option can be removed altogether.
> 
> I think it would be better to change the name and reverse the sense of
> this config option, since what it actually does is disable the old
> binding, not enable the new one.

But then boards would have to deselect rather than select the option...
can kconfig do that?

> Your example has bus-frequency, but lacks fsl,brg-frequency, in
> contrast to the description above.

Oops...

> Since you have a separate brg node defined below, maybe
> fsl,brg-frequency should just be replaced with a 'clock-frequency'
> property in that subnode.

Sounds good.

> > +   ii) Properties common to mulitple CPM/QE devices
> > +
> > +   - fsl,cpm-command : This value is ORed with the opcode and command flag
> > +                       to specify the device on which a CPM command operates.
> > +
> > +   - fsl,cpm-brg : Indicates which baud rate generator the device
> > +                   is associated with.  If absent, an unused BRG
> > +                   should be dynamically allocated.
> 
> Maybe a property with the brg node's phandle could be included as
> well, to avoid having to hop up to the CPM node, then back down to the
> brg-compatible node to find it?

Enh... it doesn't convey any new information, and in practice, it's done
by common CPM code that doesn't know about the individual device's node
anyway.

> Or maybe even have a separate subnode for each brg, and just have a
> phandle to reference it from the other devices, rather than using this
> index.

Seems a little complex relative to the gain.

> > +   Example:
> > +
> > +	ethernet@11300 {
> > +		device_type = "network";
> > +		compatible = "fsl,mpc8272-fcc-enet",
> > +		             "fsl,cpm2-fcc-enet";
> > +		reg = <11300 20 8400 100 11390 1>;
> > +		local-mac-address = [ 00 00 00 00 00 00 ];
> > +		interrupts = <20 8>;
> > +		interrupt-parent = <&PIC>;
> > +		phy-handle = <&PHY0>;
> > +		linux,network-index = <0>;
> > +		fsl,cpm-command = <12000300>;
> > +	};
> 
> Should this also have a phandle pointer to the mdio node?

It has a phandle to the phy node...  if you mean the mdio bus node, why?

-Scott
