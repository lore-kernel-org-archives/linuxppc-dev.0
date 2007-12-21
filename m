Return-Path: <dgibson@ozlabs.org>
Date: Fri, 21 Dec 2007 11:00:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Message-ID: <20071221000053.GB2665@localhost.localdomain>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910712201429q5845e786yb2ecb3ce9c8b7871@mail.gmail.com>
	<476AED87.3090703@freescale.com>
	<9e4733910712201438u2165aa77t8eab91bccb4c5bda@mail.gmail.com>
	<476AEF47.8040802@freescale.com> <476AF061.1030605@freescale.com>
	<9e4733910712201513t329e2a49j420cb3b4ece5057@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910712201513t329e2a49j420cb3b4ece5057@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 20, 2007 at 06:13:31PM -0500, Jon Smirl wrote:
> On 12/20/07, Scott Wood <scottwood@freescale.com> wrote:
> > Timur Tabi wrote:
> > > Jon Smirl wrote:
> > >
> > >> mpc5200 does it like this:
> > >> of_platform_bus_probe(NULL, NULL, NULL);
> > >
> > > I think that tells the OF base code to probe everything in the device tree,
> > > which is probably overkill.  I think fsl_soc.c covers most of the device tree,
> > > but the SSI is not defined in fsl_soc.c.
> >
> > Not quite; it tells it to use a built-in list of bus matches.  Most of
> > which are device_type-based, FWIW.
> 
> Here's the default. Using NULL would work.

It might work, but using the default list is discouraged.  Pass an
explicit list of match ids for the buses you need to scan instead (and
use compatible to match them, not device_type).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
