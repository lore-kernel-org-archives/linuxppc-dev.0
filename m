Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Feb 2007 12:18:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Message-ID: <20070222011811.GA18364@localhost.localdomain>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
Cc: Stuart Yoder <b08248@freescale.com>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 21, 2007 at 06:29:22PM -0600, Kumar Gala wrote:
> 
> On Feb 21, 2007, at 5:25 PM, Stuart Yoder wrote:
> 
> >
> > Added description of an interrupt-array property. This
> > is needed to cleanly describe the interrupt properties
> > of devices with interrupts routed to multiple
> > interrupt controllers.
> >
> > Created a new section VII to describe interrupt
> > representation in general and moved Section VI #2
> > ('Specifiying interrupt information for SOC devices')
> > to this new section.
> >
> > Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> > ---
> 
> what problem is this trying to solve?

As he says, it's for devices with interrupts routed to multiple
controllers.  The normal interrupts property assumes a single
interrupt parent for a device.  This is needed on most 4xx boards,
where the MAL has 5 interrupts, some of which are on UIC0 and some of
which are on UIC1.  At the moment the Ebony port deals with this using
an "interesting" hack, treating the MAL as an interrupt nexus for
itself, using an interrupt-map to remap its interrupts to the two
controllers.  The interrupt-array proposal does the same thing much
more neatly and compactly.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
