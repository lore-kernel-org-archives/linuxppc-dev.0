Return-Path: <wsa@pengutronix.de>
Date: Fri, 20 Jun 2008 18:10:33 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Merging seperate FDT-blobs?
Message-ID: <20080620161033.GE17701@pengutronix.de>
References: <20080612090433.GA4235@pengutronix.de>
	<20080613042304.GD29451@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
In-Reply-To: <20080613042304.GD29451@yookeroo.seuss>
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2008 at 02:23:04PM +1000, David Gibson wrote:

> > a project I am working on consists of different hardware modules, which
> > can be combined in a lot of variations (not at runtime, though). As each
> > module shall contain an I2C-eeprom, the idea is now to put a fragment of
> > a FDT-blob into that EEPROM and let the bootloader combine these
> > fragments. Such an approach was also sketched by David Gibson recently.
[...]
> > My question: Is there already an effort towards such an approach to
> > which I could contribute, or do I have to start from scratch?
>=20
> I don't know of anyone who's implemented this specifically, but if you
> do get there first, please do it on top of libfdt.

Yes, I would surely put this on top of libfdt.

Similar to what Stephen Neuendorffer wrote recently
(http://ozlabs.org/pipermail/linuxppc-dev/2008-June/058074.html), I'd
like to develop a solution which makes the fragments compilable
independently from a main tree. This would allow to store a fragment
on an extension board once and connect it to different kinds of baseboards
without any reconfiguration necessary.

So far, main problems I faced for such an approach are:

1) How do you know where a node from the fragment should be added to
   in the main tree?
   Imagine your extension board carries an I2C device, then you need to
   find the correct I2C bus which may have a different name on different
   baseboards (and there may be more than one bus).

2) How to deal with phandles?
   The fragment does not know anything about phandles from the main
   tree, so it cannot use them, although it needs to for a number of
   typical fdt-entries.

My proposal looks like the following (this is all still brainstorming
phase, so please feel free to join):

Create a property "external-name". This defines the name of the current
node regarding access from external fragments and must be unique.
Example for an i2c bus in the main tree:

	i2c@3d00 {
		#address-cells =3D <1>;
		#size-cells =3D <0>;
		compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
		[...]
		external-name =3D "i2c-0";
	};

If you are strict on keeping consistent names for equal busses on
different baseboards, then this should ensure hardware independency.
Now a fragment, or an external, could look like this:

/ {
	// Using the external-name now.
	i2c-0 {
		eeprom@52 {
			device_type =3D "i2c";
			compatible =3D "linux,24c32";
			reg =3D <0x52>;
		};
	};
};

A boot-loader could add this node with an algorithm like the
following pseudo-code:

foreach node from external_fdt with depth =3D=3D 1 {

	name =3D fdt_get_name(external_fdt, node);

	offset =3D fdt_node_offset_by_prop_value(main_fdt, "external-name", name);
	if (offset =3D=3D -FDT_ERR_NOTFOUND)
		offset =3D fdt_add_subnode(main_fdt, 0 /* root level*/, name);

	copy_properties_and_subnodes(...);
}

So, it will take the name of each node with depth =3D=3D 1 from the
external, look if there is an "external-name" set to the same name in
the main tree and add the node to the place found. If not found, it will
be put below the root-node. (Note that copy_properties_and_subnotes is
still an obstacle and has to be implemented)

The property "external-name" could also be used to deal with phandles.
In an external, fragment, or however you call it, properties requiring a
phandle from the main-fdt could be prefixed. Instead of:

	interrupt-parent =3D <&mpic>

we would write

	phandle-for-interrupt-parent =3D "mpic-0";

(maybe the prefix 'phandle-for-' could be replaced by a token?),
assuming there is a pic which has the property
'external-name =3D "mpic-0"'.

Then we have the following pseudocode for the bootloader, which would
find out the phandle for mpic-0 and set 'interrupt-parent' accordingly:

	if (property starts with "phandle-for-") {
		propname =3D property without 'phandle-for-';

		name =3D fdt_getprop(external_fdt, cur_node, property);

		phandle_offset =3D fdt_node_offset_by_prop_value(main_fdt, "external-name=
", name)
		phandle =3D fdt_get_phandle(main_fdt, phandle_offset);

		fdt_setprop(external_fdt, propname, phandle);
		copy_prop_to_main_fdt();
	}

Finally, the main tree needs to know where to look for externals.
Something like this should do:

	externals {
		blob0 {
			device-handle =3D <&eeprom>;
			offset =3D <0xf00>;
		};
	};

This can easily be parsed by a bootloader and should be flexible enough
to allow different kinds of memory.


This is what I have come up with so far. Still, my proposal is very
likely far from complete, so I am really looking forward to comments,
crticism or improvements.

Kind regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIW9Z5D27XaX1/VRsRAukLAKCtOklc78zFhOotT7CuxFC22PlxewCfewVY
bLU97wDCV4Hy40+wtYdSaTg=
=NZaS
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
