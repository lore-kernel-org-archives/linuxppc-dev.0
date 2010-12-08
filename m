Return-Path: <michael@ellerman.id.au>
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
From: Michael Ellerman <michael@ellerman.id.au>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <201012061544.40124.dargaud@lpsc.in2p3.fr>
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012061058.37612.dargaud@lpsc.in2p3.fr>
	<1291637228.21242.14.camel@concordia>
	<201012061544.40124.dargaud@lpsc.in2p3.fr>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-AQTYCHhs5TkmFbz1mQ7L"
Date: Wed, 08 Dec 2010 12:03:54 +1100
Message-ID: <1291770234.2041.102.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-AQTYCHhs5TkmFbz1mQ7L
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-12-06 at 15:44 +0100, Guillaume Dargaud wrote:=20
> Hello all,
>=20
> > OK, that should be all pretty straight forward, and covered by the
> > material in LDD and similar references. You just need to get your devic=
e
> > probed.
>=20
> I'm not sure what you mean with that term: simply identifying that the de=
vice=20
> works using device specific code ?

I just mean connecting your driver up to a struct device that represents
your device.

> I've looked at several *_probe functions from other drivers and they are =
all=20
> completely different with no common code...

Yes that's pretty normal, the probe routine usually finds device
specific info about the device and stores it in some sort of structure
for later use.

> Or do you mean calling of_platform_bus_probe() ? What does that function =
do ?

The platform code does that. That function create devices on the
platform bus by examining the device tree. It looks for nodes that are
compatible with the compatible strings you give it, and treats them as
busses, ie. creates devices for all child nodes of those nodes.

> > No it's just that platform_drivers are now able to do all the things an
> > of_platform_driver can do, so new code should just use platform_driver.
> >=20
> > I'm not sure if of_platform_bus_probe() will go away eventually, but fo=
r
> > now it is the only way to achieve what you need.
>=20
> I assume the kernel needs to be compiled with CONFIG_OF.

Yes absolutely.

> ...hmm I had to "git pull" in order for this to compile your snippet. Tha=
t's=20
> really recent! Unfortunately i need to reflash my device with the new ker=
nel=20
> before i can begin testing my module.

It shouldn't be that recent, what kernel version were you using?

> When I try to compile your (adapted) snippet, I got this minor problems:
>=20
>   .probe =3D foo_driver_probe,
> ^ warning: initialization from incompatible pointer type
> Shouldn't foo_driver_probe be:
> static int foo_driver_probe(struct platform_device *pdev)
> instead of:
> static int foo_driver_probe(struct platform_device *device,
>                             const struct of_device_id *device_id)

Yes sorry, that's a cut & paste bug, between the old and new style code.

> Also:
>        struct foo_device *foo;
> That's where I put my own content, right ?

Yep.

> And needs to be kfreed in a foo_driver_remove() function, right ?

If you have a remove then yes.

> > > I still need a platform_device_register() after your sample init, rig=
ht ?
> >=20
> > I had one in there already, in foo_driver_init(), didn't I?
>=20
> You had platform_driver_register(), not that I'm all clear yet on the=20
> distinction...

Oh sorry, I always read those wrong.

platform_device_register() creates a device on the platform bus. You
then write a driver for that device, and register it with
platform_driver_register(), your driver then attaches to the device.

In this case though you don't need to call platform_device_register()
because the device has already been created, using the device tree (by
of_platform_bus_probe()).

In general on powerpc we don't use platform_device_register() much,
instead things are described in the device tree and devices are created
for them.

platform_device_register() tends to be for cases where you can't
discover or probe a device, but you "know" that it exists.

> Another question: I just spent 10 minutes trying to find where "struct de=
vice"=20
> was defined. (ack-)grep was absolutely no use. Isn't there a way to cross=
-
> reference my own kernel, the way I've compiled it ?

Yes, "make tags", then use vim :)

If you're cross-compiling make sure to set ARCH=3Dpowerpc when you make
tags.

cheers

--=-AQTYCHhs5TkmFbz1mQ7L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkz+2XoACgkQdSjSd0sB4dIxBQCgoEWzDaWJsKuBKLNDLXk47Wjz
eqgAoKk1LPrGV1cZYDvawd50Pc/0Bu2z
=o3JF
-----END PGP SIGNATURE-----

--=-AQTYCHhs5TkmFbz1mQ7L--
