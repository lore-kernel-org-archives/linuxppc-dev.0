Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 5EC49DDEB6
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 05:52:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: SPI devices and OF
Date: Thu, 5 Apr 2007 21:52:20 +0200
References: <20070404110916.GA9910@localhost.localdomain>
	<030212e9acd638e71b2f50aa39fb90ed@bga.com>
	<20070405191145.GA20139@himalia.labnet.pengutronix.de>
In-Reply-To: <20070405191145.GA20139@himalia.labnet.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704052152.21082.arnd@arndb.de>
Cc: Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 05 April 2007, Sascha Hauer wrote:
> Not a problem of programming technique but a problem of where to
> actually get the information in the platform from. device tree or
> board setup code?

There should not need to be board specific setup code in many cases,
so it should be in the device tree.

> > You kzalloc the
> > data structure that the device needs, fill it in, and fill out
> > the pointer in the auto _info variable that gets copied by
> > register_new_device.
>=20
> My point is that we have two possibilities to handle spi devices. a) We
> put the information about all devices connected to a spi bus into the
> device tree in which case we must also put the data described in the
> platform_data (e.g. the mentioned page_size for at25 eeproms) into the
> tree. b) would be to put only the spi masters into the tree (well they
> already are).

If all the information you need can be probed through SPI commands, you
don't need to have a device tree layout for it. That is how we deal
with PCI devices as well. However, if there are things you need to know
in the specific driver for an SPI attached device, it should be in
the tree.

> It seems b) is the prefered way. If I understand Ben correctly I can
> then put some proprietary tag into the tree to differentiate between
> different spi controllers so that the board code knows which spi
> controller is which. So my tree could look like:
>=20
> spi@f00 {
> =A0=A0=A0=A0=A0=A0=A0=A0device_type =3D "spi";
> =A0=A0=A0=A0=A0=A0=A0=A0compatible =3D "mpc5200b-spi\0mpc5200-spi";
> =A0=A0=A0=A0=A0=A0=A0=A0reg =3D <f00 20>;
> =A0=A0=A0=A0=A0=A0=A0=A0interrupts =3D <2 d 0 2 e 0>;
> =A0=A0=A0=A0=A0=A0=A0=A0interrupt-parent =3D <500>;
> =A0=A0=A0=A0=A0=A0=A0=A0identifier =3D <0>;
> }
>=20
> spi@xxx {
> =A0=A0=A0=A0=A0=A0=A0=A0device_type =3D "spi";
> =A0=A0=A0=A0=A0=A0=A0=A0...
> =A0=A0=A0=A0=A0=A0=A0=A0identifier =3D <1>;
> }
>=20
> I can then use the board code to populate the spi devices depending on
> the identifier. Perhaps there is a better name instead of 'identifier'?

I think this is backwards. The board code should not need to know
about it, but you identify the chip select based on the "compatible"
property. Your of_platform_driver probe will then look more or less like
this:

struct of_device_id of_spi_ids[] =3D {
	{ .type =3D "spi", .compatible =3D "mpc5200b-spi",
			 .data =3D SPI_PROBE_MPC5200b },
	{ .type =3D "spi", .compatible =3D "mpc52foo-spi",
			 .data =3D SPI_PROBE_MPC52FOO },
	...
};

static int of_spi_probe(struct of_device* dev,
	const struct of_device_id *match)
{
	int ret;

	/* common initialization */
	...

	/* board specific initialition */
	switch (match->data) {
	case SPI_PROBE_MPC5200b:
		ret =3D of_spi_probe_mpc5200b(dev);
		break;
	case SPI_PROBE_MPC5200b:
		ret =3D of_spi_probe_mpc5200b(dev);
		break;
	...
	}
=09
	/* register with spi layer */
	...

	return ret;
}

	Arnd <><
