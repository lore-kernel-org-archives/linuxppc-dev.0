Return-Path: <glikely@secretlab.ca>
Date: Thu, 31 Jul 2008 12:28:10 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
Message-ID: <20080731182810.GB29097@secretlab.ca>
References: <4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <489200B6.9060906@freescale.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 01:13:10PM -0500, Timur Tabi wrote:
> Grant Likely wrote:
> 
> > This is a solved problem.  The device tree simple claims compatibility
> > with an older part that has the identical register-level interface.
> 
> That would assume that the clock frequency is the only thing that decides
> compatibility, which may technically be true now, but I don't think it's a good
> idea.

No it doesn't, it depends on the register interface to decide
compatibility.  Clock interface is part of that.  I suggested encoding
the clock divider directly in compatible (implicit in the SoC version),
but it doesn't have to be that way.  If clock freq is obtained from
another property or some other method then that is okay too.

What is important is that if compatibility is claimed, then it must
really be compatible!  If some new part appears in the future that
breaks our assumptions, then we'll need to rework the driver anyway and
the new part will *not* claim compatibility with the old.

> I don't understand what's wrong with simply specifying the actual clock
> frequency that the device uses?  It varies from SOC to SOC, but U-Boot
> calculates today already:

There is nothing wrong with it (as long as we agree and it gets
documented).  I certainly don't have a problem with doing it this way.

g.
