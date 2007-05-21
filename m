Return-Path: <dgibson@ozlabs.org>
Date: Mon, 21 May 2007 15:06:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: New version of the device tree aware EMAC driver
Message-ID: <20070521050632.GA7778@localhost.localdomain>
References: <20070516032630.GC19127@localhost.localdomain>
	<464B38A9.9000402@ru.mvista.com> <464B475A.4090808@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <464B475A.4090808@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 16, 2007 at 10:03:06PM +0400, Valentine Barshak wrote:
> Valentine Barshak wrote:
> > David Gibson wrote:
> >   
> >> I've made a few more tiny tweaks to BenH's rewritten device-tree based
> >> 4xx EMAC driver.  The main change is that it now no longer requires
> >> 'device_type', just 'compatible' to be set in the ZMII and MAL device
> >> nodes when probing.  This works better with current thinking on
> >> flattened device trees which discourages creating new device_type
> >> values unless there is a clear use for a new device class binding.
> >>
> >> The patch can be obtained from:
> >>
> >> http://ozlabs.org/~dgibson/home/emac/powerpc-emac-new-20070516.patch
> >>
> >>   
> >>     
> > In __emac_mdio_read and __emac_mdio_write functions:
> >
> > +    if (!emac_has_feature(dev, EMAC_FTR_STACR_OC_INVERT))
> > +        r |= EMAC_STACR_OC;
> >
> > should be
> >
> > +    if (emac_has_feature(dev, EMAC_FTR_STACR_OC_INVERT))
> > +        r |= EMAC_STACR_OC;
> >
> > Thanks.
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >   
> With the above 2 fixes (and Marvell 88E1111 Ethernet PHY support added) 
> seems to work fine on Sequoia PPC440EPx,
> thanks.

Ok, I've merged those fixes.  New version of the driver coming soon.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
