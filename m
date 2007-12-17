Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D01C2DDE03
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 04:03:51 +1100 (EST)
Date: Mon, 17 Dec 2007 11:03:04 -0600
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071217170303.GA4303@loki.buserror.net>
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
	<20071215162331.GA24999@localhost.localdomain>
	<20071217051403.GB3477@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071217051403.GB3477@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 17, 2007 at 04:14:03PM +1100, David Gibson wrote:
> > +		crypto@30000 {
> > +			device_type = "crypto";
> > +			model = "SEC2";
> > +			compatible = "talitos";
> 
> This device_type/compatible/model stuff is also crap, although I
> suspect it needs to be fixed in the driver, as gianfar (finally) was.

The driver doesn't seem to be in-tree... Kim, what do(es) the external
driver(s) look like?  Do they use OF at all yet?

> > +		ranges = <0 0xe0100000 0x00100000>;
> > +		reg = <0xe0100000 0x480>;
> > +		/* filled by u-boot */
> > +		brg-frequency = <0>;
> > +		bus-frequency = <0>;
> 
> This should probably be clock-frequency, not bus-frequency.  After
> all, it's a bus node, what other sort of frequency would it be.

Actually, it should probably be dropped altogether.

> > +		muram@10000 {
> > +			device_type = "muram";
> 
> And this device_type needs to go, too.

Yes, replace it with compatible = "fsl,cpm-muram".

> > +			ranges = <0 0x00010000 0x0000c000>;
> > +
> > +			data-only@0 {
> > +				reg = <0 0xc000>;

compatible = "fsl,cpm-muram-data".

> > +			phy1: ethernet-phy@1 {
> > +				reg = <1>;
> > +				device_type = "ethernet-phy";
> > +			};
> 
> These phy nodes have basically no information in them.  PHY nodes are
> optional -

If they are truly optional, then several Linux drivers (including ucc_geth,
which this board uses) are broken, as they'll error out if there's no
phy-handle (gianfar is even worse -- it looks like the fsl_soc code will
crash in that case).  But what do you propose they do in the absence of a
phy-handle?  Hope that probing only finds one phy?

> only include them if they actually have something useful to say (which
> would mean at least a compatible property).

They *do* have useful information -- reg and phandle.  The type of phy can
be probed, but which phy corresponds to which ethernet can't.

-Scott
