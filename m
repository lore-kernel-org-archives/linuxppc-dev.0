Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 63144DDECF
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 22:05:18 +1100 (EST)
Date: Mon, 15 Jan 2007 12:05:09 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Discussion on SOC device tree bindings
Message-ID: <20070115110509.GA25974@localhost.localdomain>
References: <528646bc0701131555n3249b503i3b6e8c37db41dd52@mail.gmail.com>
	<528646bc0701141429q577f87f1oe65aa7033c09b62b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0701141429q577f87f1oe65aa7033c09b62b@mail.gmail.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sven Luther <sven@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Sun, Jan 14, 2007 at 03:29:24PM -0700, Grant Likely wrote:
> >
> > So, the following changes are proposed:
> > 1. "mpc52xx-*" items will be dropped from the compatible property
> > because they are premature.  Unless the 5200B device is incompatible
> > with the 5200, then the 5200B will specify "mpc5200b-*\0mpc5200-*".
> > (strong recommendation, but not required; if a 5200b board just has
> > "mpc5200-*", in most cases it won't cause breakage).

How about always specifying the exact name and only the exact name
in the device tree, i.e. mpc5200-fec on mpc5200, mpc5200b-fec on
mpc5200b and so on. This way the driver can decide whether or not it's
compatible to a device and we can be sure not to overlook any
incompatibilities. We could even decide in later kernel versions that
two devices are too incompatible and split the driver into two.

> > 2. known quirks/extra features will be reported with additional
> > properties to the device.  ie. gpt0 will add a 'has-wdt' empty
> > property
> > 3. an /soc5200/model property will be added for last resort
> > determination of chip version (The soc5200 node is called 'builtin' on
> > the efika)
> > 4. most of the 5200 drivers will be changed to bind on 5200-* instead
> > of 52xx-*.  Drivers will not bind on 5200b-* unless truly incompatible
> > with the 5200.

There may be incompatibilities between 5200 and 5200b which we simply did
not discover yet. 


  Sascha

-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
