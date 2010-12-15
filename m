Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/5] of/device: Make of_get_next_child() check status
	properties
From: Michael Ellerman <michael@ellerman.id.au>
To: Hollis Blanchard <hollis@penguinppc.org>
In-Reply-To: <AANLkTimPhs4AZ74e4SZfkyboeDJQaoybL+FGmwy_+bLJ@mail.gmail.com>
References: <cover.1291799069.git.deepak_saxena@mentor.com>
	<20101208192944.GE32473@mentor.com>
	<20101208150102.69b8062b@udp111988uds.am.freescale.net>
	<1291858402.2962.2.camel@concordia> <20101209030924.GC11856@yookeroo>
	<AANLkTimPhs4AZ74e4SZfkyboeDJQaoybL+FGmwy_+bLJ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-aKrvDoUBZKow8FjfTxWm"
Date: Thu, 16 Dec 2010 09:40:55 +1100
Message-ID: <1292452855.6133.5.camel@concordia>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, devicetree-discuss@ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-aKrvDoUBZKow8FjfTxWm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-12-15 at 10:35 -0800, Hollis Blanchard wrote:
> On Wed, Dec 8, 2010 at 7:09 PM, David Gibson
> <david@gibson.dropbear.id.au> wrote:
> > On Thu, Dec 09, 2010 at 12:33:22PM +1100, Michael Ellerman wrote:
> >> On Wed, 2010-12-08 at 15:01 -0600, Scott Wood wrote:
> >> > On Wed, 8 Dec 2010 11:29:44 -0800
> >> > Deepak Saxena <deepak_saxena@mentor.com> wrote:
> >> >
> >> > > We only return the next child if the device is available.
> >> > >
> >> > > Signed-off-by: Hollis Blanchard <hollis_blanchard@mentor.com>
> >> > > Signed-off-by: Deepak Saxena <deepak_saxena@mentor.com>
> >> > > ---
> >> > >  drivers/of/base.c |    4 +++-
> >> > >  1 files changed, 3 insertions(+), 1 deletions(-)
> >> > >
> >> > > diff --git a/drivers/of/base.c b/drivers/of/base.c
> >> > > index 5d269a4..81b2601 100644
> >> > > --- a/drivers/of/base.c
> >> > > +++ b/drivers/of/base.c
> >> > > @@ -321,6 +321,8 @@ struct device_node *of_get_next_parent(struct =
device_node *node)
> >> > >   *
> >> > >   *       Returns a node pointer with refcount incremented, use
> >> > >   *       of_node_put() on it when done.
> >> > > + *
> >> > > + *       Does not return nodes marked unavailable by a status pro=
perty.
> >> > >   */
> >> > >  struct device_node *of_get_next_child(const struct device_node *n=
ode,
> >> > >   struct device_node *prev)
> >> > > @@ -330,7 +332,7 @@ struct device_node *of_get_next_child(const st=
ruct device_node *node,
> >> > >   read_lock(&devtree_lock);
> >> > >   next =3D prev ? prev->sibling : node->child;
> >> > >   for (; next; next =3D next->sibling)
> >> > > -         if (of_node_get(next))
> >> > > +         if (of_device_is_available(next) && of_node_get(next))
> >> > >                   break;
> >> > >   of_node_put(prev);
> >> > >   read_unlock(&devtree_lock);
> >> >
> >> > This seems like too low-level a place to put this.  Some code may kn=
ow
> >> > how to un-disable a device in certain situations, or it may be part =
of
> >> > debug code trying to dump the whole device tree, etc.  Looking
> >> > further[1], I see a raw version of this function, but not other thin=
gs
> >> > like of_find_compatible_node.
> >>
> >> Yeah I agree. I think we'll eventually end up with __ versions of all =
or
> >> lots of them. Not to mention there might be cases you've missed where
> >> code expects to see unavailable nodes. The right approach is to add
> >> _new_ routines that don't return unavailable nodes, and convert code
> >> that you know wants to use them.
> >
> > Actually, I don't think we really want these status-skipping
> > iterators at all.  The device tree iterators should give us the device
> > tree, as it is.  Those old-style drivers which seach for a node rather
> > than using the bus probing logic can keep individual checks of the
> > status property until they're converted to the new scheme.
>=20
> So the patch should look something like this?
>=20
> @@ -321,6 +321,8 @@ struct device_node *of_get_next_parent(struct
> device_node *node)
>  *
>  *     Returns a node pointer with refcount incremented, use
>  *     of_node_put() on it when done.
> + *
> + *     Do not use this function.
>  */
>  struct device_node *of_get_next_child(const struct device_node *node,
>        struct device_node *prev)

Haha. No it should say "this function doesn't lie to you".

And the patch should say "this patch _doesn't_ subtly change all callers
of of_get_next_child() without carefully auditing them".

cheers

--=-aKrvDoUBZKow8FjfTxWm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk0JQ/QACgkQdSjSd0sB4dJdKgCdFHXMM4+Qqi7miy2sT8x73z+1
wA4AoMSDKY96vMq9hxZRCHAYjRPsGMrp
=Nmde
-----END PGP SIGNATURE-----

--=-aKrvDoUBZKow8FjfTxWm--
