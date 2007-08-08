Return-Path: <dgibson@ozlabs.org>
Date: Wed, 8 Aug 2007 15:09:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: Device tree aware EMAC driver
Message-ID: <20070808050937.GF20482@localhost.localdomain>
References: <20070807062231.GB8351@localhost.localdomain>
	<20070808031643.GK10345@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070808031643.GK10345@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 08, 2007 at 01:16:43PM +1000, Tony Breeds wrote:
> On Tue, Aug 07, 2007 at 04:22:31PM +1000, David Gibson wrote:
> > Based on BenH's earlier work, this is a new version of the EMAC driver
> > for the built-in ethernet found on PowerPC 4xx embedded CPUs.  The
> > same ASIC is also found in the Axon bridge chip.  This new version is
> > designed to work in the arch/powerpc tree, using the device tree to
> > probe the device, rather than the old and ugly arch/ppc OCP layer.
> 
> <snip>
> 
> Hi David,
> 	I had a look over the patch FWIW, asside from the points below
> looks good.
> 
> Minor nits:
>  * Shouldn't ndev->priv accesses, use netdev_priv() ?  if not a comment
>    somewhere about why not will keep the janators off your back.

netdev_priv() hey?  Hadn't heard of that before.  I guess
so... Changed.

>  * c++ style comments

Eh, all the c++ comments are FIXMEs anyway.  I'm inclined to leave
them.

>  * in emac_probe():
> 	+	/* Wait for dependent devices */
> 	+	err = -ENODEV;
> 	+	err = emac_wait_deps(dev);
>     The initialisation to -ENODEV is pointless right?

Yes, I think so.  Removed.

>  * s/get_property/of_get_property/g  or you'll make sfr grumpy ;P

Oops, yes.

>  * In drivers/net/ibm_newemac/Makefile, I think the preferred method is
>    to use ibm_newemac-y rather than ibm_newemac-objs.
> 
> Is there any reason to leave config IBM_NEW_EMAC (and IBM_EMAC) in
> drivers/net/Kconfig ?  It seems to me they'd be nicer to in the
> appropriate drivers/net/*Kconfig.

Yes, and that also seems to be how it's done for tulip.  Moved.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
