Return-Path: <michael@ellerman.id.au>
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
From: Michael Ellerman <michael@ellerman.id.au>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <201012031558.35557.dargaud@lpsc.in2p3.fr>
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012021847.09367.dargaud@lpsc.in2p3.fr>
	<1291321371.32570.415.camel@pasglop>
	<201012031558.35557.dargaud@lpsc.in2p3.fr>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-Urfc8deeQGYbvGODkjUD"
Date: Mon, 06 Dec 2010 16:29:00 +1100
Message-ID: <1291613340.11896.216.camel@concordia>
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


--=-Urfc8deeQGYbvGODkjUD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-12-03 at 15:58 +0100, Guillaume Dargaud wrote:
> > No. of_platform_drivers are more/less obsolete. Normal platform drivers
> > can now be associated with a device-tree node just fine.
>=20
> OK.
>=20
> If my dts definition is thus:
> 		xps_acqui_data_0: xps-acqui-data@c9800000 {
> 			compatible =3D "xlnx,xps-acqui-data-3.00.a";
> 			interrupt-parent =3D <&xps_intc_0>;
> 			interrupts =3D < 0 2 >;
> 			reg =3D < 0xc9800000 0x10000 >;
> 			xlnx,family =3D "virtex4";
> 			xlnx,include-dphase-timer =3D <0x1>;
> 			xlnx,mplb-awidth =3D <0x20>;
> 			xlnx,mplb-clk-period-ps =3D <0x2710>;
> 			xlnx,mplb-dwidth =3D <0x40>;
> 			xlnx,mplb-native-dwidth =3D <0x40>;
> 			xlnx,mplb-p2p =3D <0x0>;
> 			xlnx,mplb-smallest-slave =3D <0x20>;
> 		} ;
>=20
> What are the names I need to pass to platform_driver_register and=20
> platform_device_register_simple ? xps_acqui_data_0, xps-acqui-data or xps=
-
> acqui-data-3.00.a ?

None of the above :)  xps_acqui_data_0 is a label, it is only relevant
within the dts source, ie. other nodes may refer to this node by that
label. But the label string is not useful in Linux. The node name
"xps-acqui-data" is visible in Linux, but is generally not used for
discovery, it's just a name. What you do want to use is the full
compatible value, ie. "xlnx,xps-acqui-data-3.00.a".

> Why is there not a word about the functions platform_*_register in my var=
ious=20
> driver books ? LDD 3rd ed (O'Reilly), Writing LDD (Cooperstein) or LKD=
=20
> (Love)... Is it something specific to powerpc and the books are oriented =
x86 ?=20

Because they're old dead-tree references, that aren't up to date with
the kernel. The LDD website says "LDD3 is current as of the 2.6.10
kernel", that's 25 kernel versions ago! I'm also not aware of any book
that has information on anything other than x86 drivers.

> What's a good source, besides grepping the kernel to no end ?

Nothing really I'm afraid.


So you have a device, it appears in your device tree, and you want to
write a driver for it.

The first issue is that someone needs to create a device for your node,
it doesn't necessarily happen by default. For many platforms this will
all happen "automagically" as long as the device node that describes
your device appears in the right place, but I'll describe it in full
anyway.

In most cases your device will appear below a node that represents a
bus, eg:

	foobus@xyz {
		compatible =3D "vendor,foobus-v1.m.n", "simple-bus";
		...
		yournode@abc {
			...
		}
	}

If that isn't the case you need to arrange for it somehow [1].=20

Somewhere there needs to be code to probe that bus and create devices on
it. That is usually done in platform code with of_platform_bus_probe().=20

If you don't know what platform you're on, you can look at a boot log
for a line saying "Using <blah> machine description", it will be very
early in the log. "blah" is then the name of the platform you're on, and
you should be able to grep for it in arch/powerpc/platforms.

Once you've found the .c file for your platform, there should be a call
somewhere to of_platform_bus_probe(), with a list of ids, and one of
those ids should match the compatible property of your bus node. In a
lot of cases that is just "simple-bus".

To check a device is being created for your device node, you can look
in /sys/devices. The device names don't match 100% with what's in the
device tree, but the name should be there, so in your case:

# find /sys/devices -name '*xps-acqui-data*'


Assuming that is working you can start on the driver side of things. A
rough template is:

static int foo_driver_probe(struct platform_device *device,
			    const struct of_device_id *device_id)
{
	struct device_node *dn =3D device->dev.of_node;
	struct foo_device *foo;

	pr_devel("%s: probing %s\n", __func__, dn->full_name);
=09
	/* Check you really want to probe this device and everything is OK */

	foo =3D kzalloc(sizeof(*foo));
	if (!foo)
		return -ENOMEM;

	foo->regs =3D of_iomap(dn, 0);
	if (!foo->regs)
		goto out;

	foo->irq =3D irq_of_parse_and_map(dn, 0);
	if (foo->irq =3D=3D NO_IRQ)
		goto out;

	etc.

	return 0;
}

static const struct of_device_id foo_device_id[] =3D
{                      =20
        { .compatible     =3D "vendor,foo-device" },
        {}
};

static struct platform_driver foo_driver =3D {
        .probe          =3D foo_driver_probe,
        .driver =3D {
                .name =3D "foo-driver",
                .owner =3D THIS_MODULE,
                .of_match_table =3D foo_device_id,
        },         =20
};

static int __init foo_driver_init(void)
{
        return platform_driver_register(&foo_driver);
}
module_init(foo_driver_init);


I probably missed something there, I haven't compiled it (obviously),
but it's a start. Some of this stuff is in flux, but I think everything
I have above is OK at least for now. Grant might correct me :)

cheers


[1]: One option is to put your device under an existing bus, but only if
that (fairly) accurately represents the hardware topology. You might
need to create a new node representing the bus your device appears on.
You can also manually create the device in C, but that is generally not
the right approach unless the device tree is immutable - ie. comes from
firmware that you don't control.

--=-Urfc8deeQGYbvGODkjUD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkz8dJwACgkQdSjSd0sB4dIvUwCghrAmh/l/x+cyZRDD6xeFrtgg
Of4An3bztHn1qG5h+vYXfsKts1zyR3fx
=qhv2
-----END PGP SIGNATURE-----

--=-Urfc8deeQGYbvGODkjUD--
