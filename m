Return-Path: <dgibson@ozlabs.org>
Date: Mon, 19 May 2008 10:57:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Remi Machet <rmachet@slac.stanford.edu>, Paul Mackerras <paulus@samba.org>,
	Linux PPC <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 1/5 v2] powerpc: DTS file for the C2K
Message-ID: <20080519005758.GC24125@yookeroo.seuss>
References: <1210966129.14883.1.camel@pcds-ts102.slac.stanford.edu>
	<20080519005342.GB24125@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080519005342.GB24125@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 19, 2008 at 10:53:42AM +1000, David Gibson wrote:
> On Fri, May 16, 2008 at 12:28:48PM -0700, Remi Machet wrote:
> > Support for the C2K cPCI Single Board Computer from GEFanuc

[snip]
> [snip]
> > +		/* Devices attached to the device controller */
> > +		devicebus {
> > +			compatible = "marvell,mv64306-devctrl";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> 
> This looks like it needs either a "reg" or a "ranges" property.  If
> the address space of this "devicebus" is the same as the parent bus
> you need an empty "ranges" property.  *No* ranges property means the
> subordinate devices can't be directly accessed at all from the parent
> bus.

Oh, one other comment here.  Is this another of these random
peripheral busses with a bunch of registers controlling which chip
selects appear at which address offsets and so forth (like ebc on 4xx
or localbus on freescale)?  If so, the normal convention to describe
such busses is *not* to have a 1:1 address mapping, but actually
encode the addresses of the subordinate devices as <chipselect
offset>, then have an appropriate "ranges" property to map those into
the addresses on the parent bus (the ranges property can be filled in
by the bootwrapper from the actual bridge configuration registers, if
necessary).  The rationale is again to have the device tree describe
hardware, not configuration as much as possible.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
