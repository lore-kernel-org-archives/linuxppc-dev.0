Return-Path: <michael@ellerman.id.au>
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
From: Michael Ellerman <michael@ellerman.id.au>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <201012061058.37612.dargaud@lpsc.in2p3.fr>
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012031558.35557.dargaud@lpsc.in2p3.fr>
	<1291613340.11896.216.camel@concordia>
	<201012061058.37612.dargaud@lpsc.in2p3.fr>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-1diK6iH5L2nXJ1VLpzqj"
Date: Mon, 06 Dec 2010 23:07:08 +1100
Message-ID: <1291637228.21242.14.camel@concordia>
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


--=-1diK6iH5L2nXJ1VLpzqj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-12-06 at 10:58 +0100, Guillaume Dargaud wrote:
> Thank you for the detailed answer. I'm trying to digest it...
>=20
> > > What's a good source, besides grepping the kernel to no end ?
> >=20
> > Nothing really I'm afraid.
> 8-|
>=20
> > So you have a device, it appears in your device tree, and you want to
> > write a driver for it.

> That's the idea. Communication between usermode and the driver is limited=
 to=20
> simple ioctl calls and the driver receives an interrupt when certain data=
 has=20
> been placed in memory blocks by the hardware (like a DMA). Then the user =
prog=20
> figures out where that latest data buffer is (mmap) and saves it.=20

OK, that should be all pretty straight forward, and covered by the
material in LDD and similar references. You just need to get your device
probed.

> > The first issue is that someone needs to create a device for your node,
> > it doesn't necessarily happen by default. For many platforms this will
> > all happen "automagically" as long as the device node that describes
> > your device appears in the right place, but I'll describe it in full
> > anyway.
>=20
> I'm on a minimalist embedded system (buildroot+busybox+uclibc), so I'm pr=
etty=20
> sure I have to do the whole thing. No udev/HAL here.

That's another problem. The device I'm talking about here is just the
minimal struct in the kernel that you need in order for your driver to
probe against it. Once your driver has matched against a device then you
(might) need to worry about exposing a device to userspace in /dev.

> > In most cases your device will appear below a node that represents a
> > bus, eg:
> >=20
> > 	foobus@xyz {
> > 		compatible =3D "vendor,foobus-v1.m.n", "simple-bus";
> > 		...
> > 		yournode@abc {
> > 			...
> > 		}
> > 	}
> >=20
> > If that isn't the case you need to arrange for it somehow [1].
>=20
> Commenting on your [1] here. So should I just add "simple-bus" or does th=
e=20
> VHDL needs to be modified so as to generate this additional bus info ?

Doesn't look like it:

> I indeed have:
>=20
> /dts-v1/;
> / {
> 	#address-cells =3D <1>;
> 	#size-cells =3D <1>;
> 	compatible =3D "xlnx,virtex405", "xlnx,virtex";
> 	model =3D "testing";
> 	...
> 	plb: plb@0 {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		compatible =3D "xlnx,plb-v46-1.05.a", "xlnx,plb-v46-1.00.a", "simple-bu=
s";
> 		ranges ;
> 		...
> 		xps_acqui_data_0: xps-acqui-data@c9800000 {
> 			compatible =3D "xlnx,xps-acqui-data-3.00.a";
> 			...
> 		}
> 		...
> 	}
> 	...
> }

That looks good.

> > Somewhere there needs to be code to probe that bus and create devices o=
n
> > it. That is usually done in platform code with of_platform_bus_probe().
>=20
> Isn't the of_* code outdated (just been told that on a previous message) =
?
> Or was it just for of_register_platform_driver ?

No it's just that platform_drivers are now able to do all the things an
of_platform_driver can do, so new code should just use platform_driver.

I'm not sure if of_platform_bus_probe() will go away eventually, but for
now it is the only way to achieve what you need.

> > If you don't know what platform you're on, you can look at a boot log
> > for a line saying "Using <blah> machine description", it will be very
> > early in the log. "blah" is then the name of the platform you're on, an=
d
> > you should be able to grep for it in arch/powerpc/platforms.
>=20
> "Using Xilinx Virtex machine description"

Cool.

> > Once you've found the .c file for your platform, there should be a call
> > somewhere to of_platform_bus_probe(), with a list of ids, and one of
> > those ids should match the compatible property of your bus node. In a
> > lot of cases that is just "simple-bus".
>=20
> That'd be:
> arch/powerpc/platforms/40x/virtex.c:51: .name =3D "Xilinx Virtex",
> and
> arch/powerpc/platforms/40x/virtex.c:21: { .compatible =3D "simple-bus", }=
,

Perfect.

> No match for simple-bus of acqui-data in dmesg.

That's normal, if the kernel printed out every device it found you'd
drown in messages. If you want to you can put a printk in
of_platform_device_create() and you should see it.

> > To check a device is being created for your device node, you can look
> > in /sys/devices. The device names don't match 100% with what's in the
> > device tree, but the name should be there, so in your case:
> >=20
> > # find /sys/devices -name '*xps-acqui-data*'
>=20
> Indeed:=20
> # ll /sys/devices/plb.0/c9800000.xps-acqui-data
> -r--r--r--    1 root     root        4.0K Dec  6 09:47 devspec
> -r--r--r--    1 root     root        4.0K Dec  6 09:47 modalias
> -r--r--r--    1 root     root        4.0K Dec  6 09:47 name
> lrwxrwxrwx    1 root     root           0 Dec  6 09:47 subsystem -> ../..=
/../bus/of_platform/
> -rw-r--r--    1 root     root        4.0K Dec  6 09:47 uevent
>=20
> So that's created on boot, right ?

Yep, so that is all working fine. You just need to write a driver that
will match against that device.

> > [...code snipped...]
>=20
> I still need a platform_device_register() after your sample init, right ?

I had one in there already, in foo_driver_init(), didn't I?

> I'll get on to adapting your sample code now. Thanks a lot.

No worries.

cheers


--=-1diK6iH5L2nXJ1VLpzqj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkz80ewACgkQdSjSd0sB4dIR3gCgqUktRLs6iDcG6hch00n8v1e3
sDwAoIzXV/IOWwbIihwjI+NyUAt5x28r
=9qcP
-----END PGP SIGNATURE-----

--=-1diK6iH5L2nXJ1VLpzqj--
