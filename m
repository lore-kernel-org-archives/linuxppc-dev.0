Return-Path: <dgibson@ozlabs.org>
Date: Thu, 9 Dec 2010 14:09:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/5] of/device: Make of_get_next_child() check status
	properties
Message-ID: <20101209030924.GC11856@yookeroo>
References: <cover.1291799069.git.deepak_saxena@mentor.com>
	<20101208192944.GE32473@mentor.com>
	<20101208150102.69b8062b@udp111988uds.am.freescale.net>
	<1291858402.2962.2.camel@concordia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
In-Reply-To: <1291858402.2962.2.camel@concordia>
Cc: Scott Wood <scottwood@freescale.com>, devicetree-discuss@ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 09, 2010 at 12:33:22PM +1100, Michael Ellerman wrote:
> On Wed, 2010-12-08 at 15:01 -0600, Scott Wood wrote:
> > On Wed, 8 Dec 2010 11:29:44 -0800
> > Deepak Saxena <deepak_saxena@mentor.com> wrote:
> >=20
> > > We only return the next child if the device is available.
> > >=20
> > > Signed-off-by: Hollis Blanchard <hollis_blanchard@mentor.com>
> > > Signed-off-by: Deepak Saxena <deepak_saxena@mentor.com>
> > > ---
> > >  drivers/of/base.c |    4 +++-
> > >  1 files changed, 3 insertions(+), 1 deletions(-)
> > >=20
> > > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > > index 5d269a4..81b2601 100644
> > > --- a/drivers/of/base.c
> > > +++ b/drivers/of/base.c
> > > @@ -321,6 +321,8 @@ struct device_node *of_get_next_parent(struct dev=
ice_node *node)
> > >   *
> > >   *	Returns a node pointer with refcount incremented, use
> > >   *	of_node_put() on it when done.
> > > + *
> > > + *	Does not return nodes marked unavailable by a status property.
> > >   */
> > >  struct device_node *of_get_next_child(const struct device_node *node,
> > >  	struct device_node *prev)
> > > @@ -330,7 +332,7 @@ struct device_node *of_get_next_child(const struc=
t device_node *node,
> > >  	read_lock(&devtree_lock);
> > >  	next =3D prev ? prev->sibling : node->child;
> > >  	for (; next; next =3D next->sibling)
> > > -		if (of_node_get(next))
> > > +		if (of_device_is_available(next) && of_node_get(next))
> > >  			break;
> > >  	of_node_put(prev);
> > >  	read_unlock(&devtree_lock);
> >=20
> > This seems like too low-level a place to put this.  Some code may know
> > how to un-disable a device in certain situations, or it may be part of
> > debug code trying to dump the whole device tree, etc.  Looking
> > further[1], I see a raw version of this function, but not other things
> > like of_find_compatible_node.
>=20
> Yeah I agree. I think we'll eventually end up with __ versions of all or
> lots of them. Not to mention there might be cases you've missed where
> code expects to see unavailable nodes. The right approach is to add
> _new_ routines that don't return unavailable nodes, and convert code
> that you know wants to use them.

Actually, I don't think we really want these status-skipping
iterators at all.  The device tree iterators should give us the device
tree, as it is.  Those old-style drivers which seach for a node rather
than using the bus probing logic can keep individual checks of the
status property until they're converted to the new scheme.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0ASGQACgkQaILKxv3ab8ay4ACfVgFG07+PBXRMUzt9qEceCEK+
A5kAn1v90EKf6K9Gyj13MBwPU5OQEeIc
=6k3z
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
