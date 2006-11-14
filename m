Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/16] cell: abstract spu management routines
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45593060.10602@am.sony.com>
References: <4554DA9C.9040102@am.sony.com>
	<1163391081.7410.65.camel@localhost.localdomain>
	<4557F5C5.7080604@am.sony.com>
	<1163469714.8048.54.camel@localhost.localdomain>
	<45593060.10602@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-3IRv4FZxhGxCJfcUqMkJ"
Date: Tue, 14 Nov 2006 14:13:08 +1100
Message-Id: <1163473988.8048.70.camel@localhost.localdomain>
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


--=-3IRv4FZxhGxCJfcUqMkJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-11-13 at 18:56 -0800, Geoff Levand wrote:
> Michael Ellerman wrote:
> >> > Why can't your PS3 platform code fake-up device nodes for SPUs? It s=
eems
> >> > that would simplify this quite a lot.
> >>=20
> >>=20
> >> Seems like a hack to me.  My concern is that I just have to keep addin=
g some
> >> extra hack for every new spu feature that comes out.  I would prefer t=
o make
> >> a proper design from the start, but if anyone can be more convincing I=
 am
> >> open to suggestions.
> >=20
> > Well the whole thrust of the flattened-device-tree model, is that we do
> > as much platform-specific hackery in a boot-loader/early-init, and
> > present the hardware in as standard a way as possible to the kernel via
>=20
>=20
> The thing is that the spus are visualized, so to create one takes up
> HV resources, mainly HV memory.  Creating spus in the bootloader has
> several problems.  One is that you could be allocating HV memory that wou=
ld
> never be used if the kernel is not configured for spu support, and this
> is memory could be used for other HV support.  Another problem is the
> management of those HV resources across kernel reloads, with kexec for
> example.  If the management is split then both entities need to have
> knowledge of the other, which complicates things.

Yeah I knew you were going to say that :)  How much memory does it take
in the HV to create a "logical spu"?

Kexec might complicate things, is it really high on your feature list?

> > The hope is that this isolates most of the kernel from platform specifi=
c
> > details, as far as is possible - there will always be some things that
> > need to be abstracted out - for that we have ppc_md and a few other
> > callbacks.
> >=20
> > The priv1_ops serve that purpose, providing callbacks, and there's
> > really no way around that - you can't tap the priv1 area when you're
> > running under a HV - fine. But for just finding the spus it strikes me
> > that it would be _nicer_, perhaps not easier :), to have your
> > "enumerate_spus" populate the flat device tree early on - which would
> > leave more of the spu code untouched by the hv/bare-metal issue.
>=20
>=20
> And how many would you like to find? 1? 5? 400? Although there is
> a current limitation in the HV implementation, these are logical
> spus.  It would seem the kernel could create spus based on the need,
> and thus better balance resource usage, but this is not at all how
> the current spu code works though.  I don't plan to do any work on
> this, but it would be nice to keep it open.

Actually I'd like 8, or is it 7. I don't see why having more "logical
spus" than "physical spus" is useful - the kernel can already schedule
many spu contexts over a smaller number of physical spus. As far as
giving unused spus back to the HV .. I'll believe it when I see it :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-3IRv4FZxhGxCJfcUqMkJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFWTREdSjSd0sB4dIRAvr6AJ4uQS2RxnRFflJquOdaM1IhHdCmzgCeNiDD
5hi1sKC3GG4uvC69GB8gtWA=
=se0R
-----END PGP SIGNATURE-----

--=-3IRv4FZxhGxCJfcUqMkJ--
