Return-Path: <broonie@sirena.org.uk>
Date: Wed, 17 Jul 2013 13:07:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>, David Woodhouse <dwmw2@infradead.org>,
 devicetree-discuss@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
Message-ID: <20130717120758.GR22506@sirena.org.uk>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-2-git-send-email-gsi@denx.de>
 <20130715201734.GF11538@sirena.org.uk>
 <20130717112229.GK7080@book.gsilab.sittig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cW27jhpBl+zg4ncD"
In-Reply-To: <20130717112229.GK7080@book.gsilab.sittig.org>
Subject: Re: [PATCH v1 01/24] spi: mpc512x: prepare clocks before enabling them
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cW27jhpBl+zg4ncD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 17, 2013 at 01:22:29PM +0200, Gerhard Sittig wrote:
> On Mon, Jul 15, 2013 at 21:17 +0100, Mark Brown wrote:
> > On Mon, Jul 15, 2013 at 08:47:30PM +0200, Gerhard Sittig wrote:

> > >   sprintf(name, "psc%d_mclk", master->bus_num);
> > >  	spiclk = clk_get(&master->dev, name);
> > > -	clk_enable(spiclk);
> > > +	clk_prepare_enable(spiclk);
> > >  	mps->mclk = clk_get_rate(spiclk);
> > >  	clk_put(spiclk);

> > This code is *clearly* buggy and should be fixed rather than papered
> > over.  Not only is there no matching put the driver is also dropping the
> > reference to the clock rather than holding on to it while it's in use.

> "This code" refers to the driver's original condition, right?  I
> agree that the driver has been suffering from incomplete clock
> handling since it was born three years ago.  And that this issue
> shall get addressed.  The question is just whether it needs to be
> part of this series which has a different focus.

This is a pretty long e-mail.  It'd probably have taken less time to
fix the issues than to reply to the e-mail...  but anyway.

A big part of the issue with the state of the driver is that there's
obvious clock API abuse going on that isn't corrected here - the main
one is that the sprintf() for the clock name is a fairly clear warning
sign, the driver should be using a fixed value there.  This raises a
warning flag for me about the quality of the common clock API
implementation that's being sent and/or the potential for bugs to be
noticed with the common clock framework.  I'd not expect this code to
actually work, and looking at the rest of the series I don't see how it
does since I can't see what forces the name.

--cW27jhpBl+zg4ncD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5okbAAoJELSic+t+oim9evUP/2rS+5e9GjpDbAqKqX5UVj6x
tS+S3dO91SUhT1mejWfiWAqRZ0k6SOlmpQpa/cFUrRywXRBFLNmdS1S22lKOm36+
cG/aEZ5EszyF1tATdEW4tepYfGB03bTIZb0FSRkdguf+Ru5vLj59WdFjV63W1GRz
IC1C1rfEf49jHDoeI+4qkUGOgwog0saWCoxQWxAYTmbTlR770hS1XUZq0sMgILFC
mz3D5H3+XSswMvK21gMQUtB+y2Vta8U1Nou10kWztNOxnjp9dG4CNCtrdm4GaZ/U
ZElm7DM7bwgEy2C3Cv3+PjisWfZnWh14L9c6zrBEoDwC/VR4fZS7DyxOnpSIxHjg
CKkoFpc/P3h6gStCd1DB+uIgRr8fjajyt33A840kffQAhLzU8H82um9QbCXyWSDa
SWt5B8njiqFdZAakaMqLpKxXPkuIaDXC8Lm33yw1McpXrmyjm/RhPnrAAeqr2ONP
tzvpOe02v4/gXmsXS+IyGV8B9GWoeyuVembDwjjHVmwvVz+I2WyK7pizL1J54Qj1
rG7rg5dKHo9XUy/emN8V8b4L04uGwIYarfnE1XMAB3h3bvVrD4rwLdTSU/ZM9uGH
+nMBrE5FwmRwxcuLb+wJBpJWuONj4nE8hejAsb6swOmxHNWHG0K/bHixVw0969/Y
5wy4vUZvCnwtNZjl6wp0
=tDSA
-----END PGP SIGNATURE-----

--cW27jhpBl+zg4ncD--
