Return-Path: <david-b@pacbell.net>
Received: from smtp123.sbc.mail.sp1.yahoo.com (smtp123.sbc.mail.sp1.yahoo.com
	[69.147.64.96]) by ozlabs.org (Postfix) with SMTP id D03D8DE2D1
	for <linuxppc-dev@ozlabs.org>; Sun, 25 May 2008 03:43:46 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
Date: Sat, 24 May 2008 10:43:43 -0700
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<fa686aa40805232326w35f455d1s274899160d47eccb@mail.gmail.com>
	<fa686aa40805240950ocd16b97y308a54c68efa28ef@mail.gmail.com>
In-Reply-To: <fa686aa40805240950ocd16b97y308a54c68efa28ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200805241043.43711.david-b@pacbell.net>
Cc: fabrizio.garetto@gmail.com, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 24 May 2008, Grant Likely wrote:
> >>> > +++ b/drivers/spi/spi_of.c
> >>>
> >>> I think better placement for this is drivers/of, no?
> >>
> >> Yes please.
> >
> > Okay, I wasn't sure.  Will do.
> 
> I'm having second thoughts about this.  I think this code is more SPI
> centric than it is OF centric.  ie. it is usable by all spi masters in
> an OF enabled system, but it is not usable by all OF devices in an SPI
> enabled system. 

It's not usable by *any* SPI master on a non-OF system though.
So in that sense it's far more about OF setup than it is about SPI.


> Or, in other words; it adds OF support to SPI, not 
> the other way around.  I think drivers/spi is the right place for this
> to live.

I'd still rather see such translations in the OF-specific part of
the source tree.  Like drivers/acpi/pci_*.c code, this has more to
do with the firmware interface than with bus (SPI) interface.

Arguments could be made both ways here, but for the moment it makes
more sense to me to keep this type of platform glue (be it OF, ACPI,
arch-specific setup code, or whatever) together in the source tree
and apart from the bus-specific code.

Where do the proposed patches gluing OF to I2C live, or has that
been settled yet?

- Dave
