Return-Path: <dgibson@ozlabs.org>
Date: Mon, 23 Jun 2008 15:06:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Merging seperate FDT-blobs?
Message-ID: <20080623050624.GA23064@yookeroo.seuss>
References: <20080612090433.GA4235@pengutronix.de>
	<20080613042304.GD29451@yookeroo.seuss>
	<20080620161033.GE17701@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
In-Reply-To: <20080620161033.GE17701@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2008 at 06:10:33PM +0200, Wolfram Sang wrote:
> On Fri, Jun 13, 2008 at 02:23:04PM +1000, David Gibson wrote:
>=20
> > > a project I am working on consists of different hardware modules, whi=
ch
> > > can be combined in a lot of variations (not at runtime, though). As e=
ach
> > > module shall contain an I2C-eeprom, the idea is now to put a fragment=
 of
> > > a FDT-blob into that EEPROM and let the bootloader combine these
> > > fragments. Such an approach was also sketched by David Gibson recentl=
y.
> [...]
> > > My question: Is there already an effort towards such an approach to
> > > which I could contribute, or do I have to start from scratch?
> >=20
> > I don't know of anyone who's implemented this specifically, but if you
> > do get there first, please do it on top of libfdt.
>=20
> Yes, I would surely put this on top of libfdt.
>=20
> Similar to what Stephen Neuendorffer wrote recently
> (http://ozlabs.org/pipermail/linuxppc-dev/2008-June/058074.html), I'd
> like to develop a solution which makes the fragments compilable
> independently from a main tree. This would allow to store a fragment
> on an extension board once and connect it to different kinds of baseboards
> without any reconfiguration necessary.
>=20
> So far, main problems I faced for such an approach are:
>=20
> 1) How do you know where a node from the fragment should be added to
>    in the main tree?
>    Imagine your extension board carries an I2C device, then you need to
>    find the correct I2C bus which may have a different name on different
>    baseboards (and there may be more than one bus).

Hrm.  I was assuming this would be handled by the code putting things
together, rather than being encoded into the fragments.  I envisaged
something like:

	int fdt_graft(void *fdt, int parentoffset, const char *name,
		      void *fragment);

This would attach the tree fragment in the blob at 'fragment' into the
tree 'fdt', with fragment's root gaining the name 'name' and being a
child of the existing node at 'parentoffset'.

> 2) How to deal with phandles?
>    The fragment does not know anything about phandles from the main
>    tree, so it cannot use them, although it needs to for a number of
>    typical fdt-entries.

Ah.  This is harder.  And there are two sub-pieces to this problem.
First, how to ensure that any phandles for nodes in the fragment don't
collide with phandles from the parent tree or other included
fragments.  Second, how to fixup phandle references in between
initially separate fragments.

As an asside, I think going through the grafted fragment and adjusting
phandles to avoid collisions is a no-goer.  Any new binding can
potentially introduce a new property in which phandles appear, so we
can't really know where to look for phandles and adjust.

So, for the first part, for now, I think the sanest way to handle this
for now is simply to require that the fragments have non-overlapping
phandles.  For example by specifically allocating different ranges for
different fragments when assembling a collection of such things.
There are problems with this approach, and we may need something
better, but I think it's where we need to start.

At the moment that will require manually assigning all phandles, but
we could extend dtc with a directive giving the range in which to
assign phandles.

> My proposal looks like the following (this is all still brainstorming
> phase, so please feel free to join):
>=20
> Create a property "external-name". This defines the name of the current
> node regarding access from external fragments and must be unique.
> Example for an i2c bus in the main tree:

Yeah, I don't really think this is a good idea.  Better to have the
assembly code handle this as suggested above.

>=20
> 	i2c@3d00 {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
> 		compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> 		[...]
> 		external-name =3D "i2c-0";
> 	};
>=20
> If you are strict on keeping consistent names for equal busses on
> different baseboards, then this should ensure hardware independency.
> Now a fragment, or an external, could look like this:
>=20
> / {
> 	// Using the external-name now.
> 	i2c-0 {
> 		eeprom@52 {
> 			device_type =3D "i2c";
> 			compatible =3D "linux,24c32";
> 			reg =3D <0x52>;
> 		};
> 	};
> };
>=20
> A boot-loader could add this node with an algorithm like the
> following pseudo-code:
>=20
> foreach node from external_fdt with depth =3D=3D 1 {
>=20
> 	name =3D fdt_get_name(external_fdt, node);
>=20
> 	offset =3D fdt_node_offset_by_prop_value(main_fdt, "external-name", name=
);
> 	if (offset =3D=3D -FDT_ERR_NOTFOUND)
> 		offset =3D fdt_add_subnode(main_fdt, 0 /* root level*/, name);
>=20
> 	copy_properties_and_subnodes(...);
> }
>=20
> So, it will take the name of each node with depth =3D=3D 1 from the
> external, look if there is an "external-name" set to the same name in
> the main tree and add the node to the place found. If not found, it will
> be put below the root-node. (Note that copy_properties_and_subnotes is
> still an obstacle and has to be implemented)

Hrm.  I don't really follow the point of this scheme.  It seems like
you're encoding how to assemble the fragments into the master
fragment.  But the whole point of assembling fragments is that the
master can encode several different trees depending what's included,
which means something else needs to decide whether they're merged or
not.  I think just provide fdt_graft() as above, and leave the
decisions about where and whether to the assembly code in the wrapper
or bootloader.

> The property "external-name" could also be used to deal with phandles.
> In an external, fragment, or however you call it, properties requiring a
> phandle from the main-fdt could be prefixed. Instead of:
>=20
> 	interrupt-parent =3D <&mpic>
>=20
> we would write
>=20
> 	phandle-for-interrupt-parent =3D "mpic-0";
>=20
> (maybe the prefix 'phandle-for-' could be replaced by a token?),
> assuming there is a pic which has the property
> 'external-name =3D "mpic-0"'.

This doesn't work for properties which include phandles but are not
simply a single phandle; 'interrupt-map' for example.

> Then we have the following pseudocode for the bootloader, which would
> find out the phandle for mpic-0 and set 'interrupt-parent' accordingly:
>=20
> 	if (property starts with "phandle-for-") {

We'll need property iteration for this, which we don't currently have.
But I've been intending to implement that for a while anyway.

> 		propname =3D property without 'phandle-for-';
>=20
> 		name =3D fdt_getprop(external_fdt, cur_node, property);
>=20
> 		phandle_offset =3D fdt_node_offset_by_prop_value(main_fdt, "external-na=
me", name)
> 		phandle =3D fdt_get_phandle(main_fdt, phandle_offset);
>=20
> 		fdt_setprop(external_fdt, propname, phandle);
> 		copy_prop_to_main_fdt();
> 	}

Hrm.  This doesn't seem all that useful.  It only handles adjusting
phandle references that are in the external tree pointing into one of
the fragments.  Since the fragments more-or-less by definition aren't
always present, this is an unlikely use case.  What I *can* see
happening is things within the fragments wanting to refer to an
always-present piece of hardware outside - the main interrupt
controller, in particular.

> Finally, the main tree needs to know where to look for externals.
> Something like this should do:
>=20
> 	externals {
> 		blob0 {
> 			device-handle =3D <&eeprom>;
> 			offset =3D <0xf00>;
> 		};
> 	};
>=20
> This can easily be parsed by a bootloader and should be flexible enough
> to allow different kinds of memory.
>=20
>=20
> This is what I have come up with so far. Still, my proposal is very
> likely far from complete, so I am really looking forward to comments,
> crticism or improvements.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIXy9QaILKxv3ab8YRAvnAAJ44HC9LNHV6mf/Q99wCaR0ipTNZpgCfSYGg
Yx57KyjSyV+ngBoaIxH/v40=
=Ggfz
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
