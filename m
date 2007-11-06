Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Nov 2007 09:20:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
Message-ID: <20071106222024.GA31367@localhost.localdomain>
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com>
	<fa686aa40711051446q1abe886dh6225fa1ec675ef9b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40711051446q1abe886dh6225fa1ec675ef9b@mail.gmail.com>
Cc: Tjernlund <tjernlund@tjernlund.se>, Jean Delvare <khali@linux-fr.org>,
	i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 05, 2007 at 03:46:45PM -0700, Grant Likely wrote:
> On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
> > Jon Smirl wrote:
> > > On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
> > >> Jon Smirl wrote:
> > >>> This is my first pass at reworking the Freescale i2c driver. It
> > >>> switches the driver from being a platform driver to an open firmware
> > >>> one. I've checked it out on my hardware and it is working.
> > >> We may want to hold off on this until arch/ppc goes away (or at least
> > >> all users of this driver in arch/ppc).
> > >
> > > How about renaming the old driver file and leaving it hooked to ppc?
> > > Then it would get deleted when ppc goes away. That would let work
> > > progress on the powerpc version.
> >
> > Or we could have one driver that has two probe methods.  I don't like
> > forking the driver.
> 
> I agree.  This driver can and should have multiple bus bindings.
> 
> > >>>       cell-index = <1>;
> > >> What is cell-index for?
> > >
> > > I was using it to control the bus number, is that the wrong attribute?
> >
> > It shouldn't be specified at all -- the hardware has no concept of a
> > device number.
> 
> cell-index is important.  It describes the hardware, or more
> specifically the layout of the SoC.  The SoC has 2 i2c busses which
> are numbered 0 and 1.  This property should stay for the 5200.
> However, that is the only purpose of it.  cell-index does *not*
> describe the system level bus number.

cell-index should *only* be used if it's used to index into SoC-shared
registers.  It should *never* be used for logical bus or device
numbering as it's being used here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
