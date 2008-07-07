Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 Jul 2008 11:28:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Merging seperate FDT-blobs?
Message-ID: <20080707012843.GF6267@yookeroo.seuss>
References: <20080612090433.GA4235@pengutronix.de>
	<20080613042304.GD29451@yookeroo.seuss>
	<20080620161033.GE17701@pengutronix.de>
	<20080623050624.GA23064@yookeroo.seuss>
	<20080627170547.GF3931@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
In-Reply-To: <20080627170547.GF3931@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2008 at 07:05:47PM +0200, Wolfram Sang wrote:
> Hello David,
>=20
> On Mon, Jun 23, 2008 at 03:06:24PM +1000, David Gibson wrote:
>=20
> > Hrm.  I was assuming this would be handled by the code putting things
> > together, rather than being encoded into the fragments.  I envisaged
> > something like:
> >=20
> > 	int fdt_graft(void *fdt, int parentoffset, const char *name,
> > 		      void *fragment);
> >=20
> > This would attach the tree fragment in the blob at 'fragment' into the
> > tree 'fdt', with fragment's root gaining the name 'name' and being a
> > child of the existing node at 'parentoffset'.
>=20
> This function is surely needed in every case I considered so far. I am
> just sceptical if the boot-loader can determine a correct parentoffset
> all alone (which one of the two I2C busses is the correct one?). This is

Hrm.  "all alone".  It's not clear to me what else there could be that
would have more information than the bootloader.

> why I added the property "external-name" as a helping hand. Meanwhile, I
> found your proposal about handling the aliases-node
> (http://ozlabs.org/pipermail/linuxppc-dev/2007-November/045778.html)=20
> and think it will be a better alternative (as mentioned below).
>=20
> > > 2) How to deal with phandles?
> > >    The fragment does not know anything about phandles from the main
> > >    tree, so it cannot use them, although it needs to for a number of
> > >    typical fdt-entries.
> >=20
> > Ah.  This is harder.  And there are two sub-pieces to this problem.
> > First, how to ensure that any phandles for nodes in the fragment don't
> > collide with phandles from the parent tree or other included
> > fragments.  Second, how to fixup phandle references in between
> > initially separate fragments.
>=20
> > As an asside, I think going through the grafted fragment and adjusting
> > phandles to avoid collisions is a no-goer.  Any new binding can
> > potentially introduce a new property in which phandles appear, so we
> > can't really know where to look for phandles and adjust.
>=20
> True. I didn't take into account that phandles may show up anywhere,
> even in a field of cells. Sigh, I wish phandles had some marker tag
> (no, I don't expect this to happen).
>=20
> > So, for the first part, for now, I think the sanest way to handle this
> > for now is simply to require that the fragments have non-overlapping
> > phandles.  For example by specifically allocating different ranges for
> > different fragments when assembling a collection of such things.
> > There are problems with this approach, and we may need something
> > better, but I think it's where we need to start.
>=20
> > At the moment that will require manually assigning all phandles, but
> > we could extend dtc with a directive giving the range in which to
> > assign phandles.
>=20
> So, if dtc has the possibility to specify a range for phandles, every
> fragment gets its own "namespace" for phandles. Handles which are
> clearly not leaving the namespace can still be referenced using the
> convenient <&phandle> syntax. Every phandle which needs to be accessed
> from different namespaces, has to be hardcoded, preferably in their own
> hardcoded namespace (e.g. linux,phandle =3D <0xfffffxyz>). Nice thing is,
> that it still can be assigned a dtc-label, so referencing inside the
> same source is also easy to maintain. Using macro features, one could
> even use #defines for the hardcoded values.

Exactly.  It's not perfect, but I think it's an ok compromise of
convenience of use and simplicity of implementation.  At least as a
first step.

> Still, I sense some practical issues. I guess I need to sketch some
> more possible constellations to get an even bigger picture. Problem is
> as often: if you get generic, you get complexity.
>=20
> > Hrm.  I don't really follow the point of this scheme.  It seems like
> > you're encoding how to assemble the fragments into the master
> > fragment.
>=20
> What I encoded using "external-name" is where possible fragments
> _could_ be added to. Something like a mount-point. The boot-loader
> decides if and what could be mounted there. As an "/aliases" node is
> already in use, I would favour to add such mount-points there.

Hrm.  I'm not convinced that the mount point model is actually a good
one.  I would have thought that one of the most common things to graft
would be extra optional devices onto a bus.  In this case there's no
specific "mountpoint"  the device could be attached at any valid
address on the bus in question.

> > But the whole point of assembling fragments is that the
> > master can encode several different trees depending what's included,
> > which means something else needs to decide whether they're merged or
> > not.  I think just provide fdt_graft() as above, and leave the
> > decisions about where and whether to the assembly code in the wrapper
> > or bootloader.
>=20
> I assume the main tagret for this criticism is the "externals"-node I
> introduced at the very end. I agree that its functionality could be
> transferred to the boot-loader (e.g. give the boot-loader a list of
> addresses to check for potential eeproms). I wouldn't mind dropping the
> "externals" node; sounds in deed a bit cleaner.
>=20
> > This doesn't work for properties which include phandles but are not
> > simply a single phandle; 'interrupt-map' for example.
>=20
> Check mate :(
>=20
> > We'll need property iteration for this, which we don't currently have.
> > But I've been intending to implement that for a while anyway.
>=20
> I am quite sure it will come handy on the way nontheless.
>=20
> >=20
> > > 		propname =3D property without 'phandle-for-';
> > >=20
> > > 		name =3D fdt_getprop(external_fdt, cur_node, property);
> > >=20
> > > 		phandle_offset =3D fdt_node_offset_by_prop_value(main_fdt, "externa=
l-name", name)
> > > 		phandle =3D fdt_get_phandle(main_fdt, phandle_offset);
> > >=20
> > > 		fdt_setprop(external_fdt, propname, phandle);
> > > 		copy_prop_to_main_fdt();
> > > 	}
> >=20
> > Hrm.  This doesn't seem all that useful.  It only handles adjusting
> > phandle references that are in the external tree pointing into one of
> > the fragments.  Since the fragments more-or-less by definition aren't
> > always present, this is an unlikely use case.  What I *can* see
> > happening is things within the fragments wanting to refer to an
> > always-present piece of hardware outside - the main interrupt
> > controller, in particular.
>=20
> Ehrm, most likely my example was not clear enough, I am sorry. The case
> of a fragment wanting to reach the main interrupt controller was exactly
> what I had in mind when writing this. For completeness, I will try to
> clear it up, although it won't work, as stated before: The
> 'phandle-for-*' property is in the fragment. It's value (let's say
> 'pic-0') is taken from the fragment. An apropriate mount-point (set by
> 'external-name =3D "pic-0"' in the main tree) is searched in the main
> tree.  The phandle of the mount point is taked from the main tree. This
> value will become the new phandle inside the fragment pointing to the
> main tree. In the end, the whole fragment will be grafted into the main
> tree, of course.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIcXFLaILKxv3ab8YRAsHZAJwNxTlV+qVr+KZj95hDHeRLJc5XyACfXeuc
HBcfFTvRYa7eYSxSTkblsL0=
=ZPA3
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
