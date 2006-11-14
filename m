Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/16] cell: abstract spu management routines
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4557F5C5.7080604@am.sony.com>
References: <4554DA9C.9040102@am.sony.com>
	<1163391081.7410.65.camel@localhost.localdomain>
	<4557F5C5.7080604@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-cltIFWsIr0+e/WGWlJDx"
Date: Tue, 14 Nov 2006 13:01:54 +1100
Message-Id: <1163469714.8048.54.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-cltIFWsIr0+e/WGWlJDx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-11-12 at 20:34 -0800, Geoff Levand wrote:
> Michael Ellerman wrote:
> > On Fri, 2006-11-10 at 12:01 -0800, Geoff Levand wrote:
> >> This adds a platform specific spu management abstraction and the cores=
ponding
> >> routines to support the IBM Cell Blade.  It also removes the hyperviso=
r only
> >> resources that were included in struct spu.
> >>=20
> >> Three new platform specific routines are introduced, spu_enumerate_spu=
s(),
> >> spu_create_spu() and spu_destroy_spu().  The underlining design uses a=
 new
> >> type, struct spu_management_ops, to hold function pointers that the pl=
atform
> >> setup code is expected to initialize to instances appropriate to that =
platform.
> >>=20
> >> For the IBM Cell Blade support, I put the hypervisor only resources th=
at were
> >> in struct spu into a platform specific data structure struct spu_pdata=
.
> >=20
> > As far as I can see you haven't posted your HV-backed management ops, i=
s
> > that right?
>=20
>=20
> Yes, that is in '[PATCH 15/16] cell: add ps3 platform spu support' posted
> with the other ps3pf patches.

OK, I'll have a look at it.

> > Why can't your PS3 platform code fake-up device nodes for SPUs? It seem=
s
> > that would simplify this quite a lot.
>=20
>=20
> Seems like a hack to me.  My concern is that I just have to keep adding s=
ome
> extra hack for every new spu feature that comes out.  I would prefer to m=
ake
> a proper design from the start, but if anyone can be more convincing I am
> open to suggestions.

Well the whole thrust of the flattened-device-tree model, is that we do
as much platform-specific hackery in a boot-loader/early-init, and
present the hardware in as standard a way as possible to the kernel via
the device tree.

The hope is that this isolates most of the kernel from platform specific
details, as far as is possible - there will always be some things that
need to be abstracted out - for that we have ppc_md and a few other
callbacks.

The priv1_ops serve that purpose, providing callbacks, and there's
really no way around that - you can't tap the priv1 area when you're
running under a HV - fine. But for just finding the spus it strikes me
that it would be _nicer_, perhaps not easier :), to have your
"enumerate_spus" populate the flat device tree early on - which would
leave more of the spu code untouched by the hv/bare-metal issue.

But as I said before, I haven't looked thoroughly at the code, so
perhaps there's some obvious reason why that wouldn't work.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-cltIFWsIr0+e/WGWlJDx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFWSOSdSjSd0sB4dIRApSvAKDJj7HFN4Sd1pTU3Gny3EfAcPb/rQCdFBlF
0gYPTfAbQ2FXrTY2FrTaUdk=
=wFtt
-----END PGP SIGNATURE-----

--=-cltIFWsIr0+e/WGWlJDx--
