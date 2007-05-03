Return-Path: <dgibson@ozlabs.org>
Date: Thu, 3 May 2007 10:17:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: RFC: new device types in the device tree (RE: [PATCH] powerpc:
	Add EDAC platform devices for 85xx)
Message-ID: <20070503001729.GB4331@localhost.localdomain>
References: <e359e43198096bc73cdac058c6e5ad6d@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5DC6F@az33exm25.fsl.freescale.net>
	<567cddf8855d809f2e0c5b4101c2c15a@kernel.crashing.org>
	<20070502011957.GA12876@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA302D5E1A9@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302D5E1A9@az33exm25.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 02, 2007 at 12:04:11PM -0700, Yoder Stuart-B08248 wrote:
>  
> 
> > -----Original Message-----
> > From: David Gibson [mailto:david@gibson.dropbear.id.au] 
> > Sent: Tuesday, May 01, 2007 8:20 PM
> > To: Segher Boessenkool
> > Cc: Yoder Stuart-B08248; linuxppc-dev@ozlabs.org; 
> > bluesmoke-devel@lists.sourceforge.net
> > Subject: Re: RFC: new device types in the device tree (RE: 
> > [PATCH] powerpc: Add EDAC platform devices for 85xx)
> > 
> > On Wed, May 02, 2007 at 02:34:45AM +0200, Segher Boessenkool wrote:
> > > >> "name" = "memory-controller"
> > > >> "compatible" = "fsl,85xx-memory-controller"
> > > >> (or a more specific 85xx model if the controller
> > > >> isn't identical across those chips)
> > > >> No "device_type" at all, since there is no binding
> > > >> for this kind of device.
> > > >
> > > > Is "no device_type" really the approach that should be
> > > > taken?
> > > 
> > > Yes.
> > > 
> > > > booting-without-of.txt currently reads:
> > > >
> > > >    Every node which actually represents an actual device
> > > >    (that is, a node which isn't only a virtual "container"
> > > >    for more nodes, like "/cpus" is) is also required to
> > > >    have a "device_type" property indicating the type of
> > > >    node
> > > 
> > > That is wrong, IMNSHO.
> > 
> > I tend to agree. Device drivers should generally be searching on the
> > "compatible" property, not "device_type".  Defining new device_type
> > values isn't really of any use to the kernel, so we should just avoid
> > it.
> 
> Right-- drivers search on "compatible".
> 
> But, don't we want to keep standardized sets of properties for
> certain classes/types of devices?  Defining a standardized,
> required set of properties for a "network", "rom", or "i2c"
> class of device is helpful.  Without a standardized 'template'
> of properties, developers may make up whatever properties they
> want and things will work fine as long as the device tree and
> driver are in sync.  It works, but you wind up with a plethora
> of properties each describing the same thing.

If there's an obvious new class, with common properties, then yes,
sure.  But I don't think we need to feel impelled to think up new
classes (and therefore a device_type value) for each new device.  

And even in the case of new classes, I think we might be best off
waiting for a few devices to appear so we can tell what's really
common information before we define the class's device_type and
required properties.

> If we do away with device_type,
> what is it that defines a particular node to be a certain class
> of device.

I'm not suggesting doing away with device_type, just making it
optional.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
