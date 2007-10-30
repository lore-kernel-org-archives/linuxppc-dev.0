Return-Path: <dgibson@ozlabs.org>
Date: Wed, 31 Oct 2007 10:02:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: RFC:  replace device_type with new "class" property?
Message-ID: <20071030230241.GB2784@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<20071029212213.GA28073@lixom.net>
	<20071030005146.GF29263@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F278B@az33exm25.fsl.freescale.net>
	<20071030163343.GA4517@loki.buserror.net>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F2872@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA3035F2872@az33exm25.fsl.freescale.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 30, 2007 at 12:06:33PM -0700, Yoder Stuart-B08248 wrote:
>  
> 
> > -----Original Message-----
> > From: Wood Scott-B07421 
> > Sent: Tuesday, October 30, 2007 11:34 AM
> > To: Yoder Stuart-B08248
> > Cc: David Gibson; Olof Johansson; linuxppc-dev@ozlabs.org
> > Subject: Re: RFC: replace device_type with new "class" property?
> > 
> > On Tue, Oct 30, 2007 at 09:23:14AM -0700, Yoder Stuart-B08248 wrote:
> > >   mpic: pic@40000 {
> > >      clock-frequency = <0>;
> > >      interrupt-controller;
> > >      #address-cells = <0>;
> > >      #interrupt-cells = <2>;
> > >      reg = <40000 40000>;
> > >      compatible = "fsl,xyz";
> > >      big-endian;
> > > }
> > > 
> > > Note-- I removed the device_type property and changed
> > > compatible somewhat.  How are you going to find where
> > > the meaning interrupt controller's interrupt cells are
> > > defined?   What spec will you look at?
> > 
> > The binding for fsl,xyz.
> 
> Not every string listed in compatible has a spec 
> backing it (or should be required to).  You would
> have to go look at the source code and cross your
> fingers that the comments were sufficient.

But that's true in general.  open-pic is practically the only time
device_type will let you avoid that.

> Another good reason for device_type-- it helps 
> distinguish between two similar classes of devices.
> Both "open-pic" and "isa-pic" look very similar but
> have different encodings of their interrupt cells.
> Without a device_type it may be difficult or impossible
> to distinguish them unless the "name" and
> "compatible" are luckily clear enough.

This is a totally misleading argument.  There may be one or two cases
where the device_type is useful, but in most cases device_type will be
either not specific enough to give you the information you need, or it
we add lots of new device_type values, it will be so specific that it
suffers the same problem as looking at name or compatible - you have
to find the finding that goes with a particular device_type.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
