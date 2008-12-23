Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/3] powerpc: Make default kexec/crash_kernel ops implicit
From: Michael Ellerman <michael@ellerman.id.au>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081222001107.GA26630@oksana.dev.rtsoft.ru>
References: <20081216162217.GA3885@oksana.dev.rtsoft.ru>
	<20081216162305.GB21749@oksana.dev.rtsoft.ru>
	<1229900922.8269.15.camel@localhost>
	<20081222001107.GA26630@oksana.dev.rtsoft.ru>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-jyCcD/18Qoml7NEZ587A"
Date: Tue, 23 Dec 2008 11:15:21 +1100
Message-Id: <1229991321.9502.9.camel@localhost>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-jyCcD/18Qoml7NEZ587A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-12-22 at 03:11 +0300, Anton Vorontsov wrote:
> On Mon, Dec 22, 2008 at 10:08:42AM +1100, Michael Ellerman wrote:
> > On Tue, 2008-12-16 at 19:23 +0300, Anton Vorontsov wrote:
> > > This patch removes need for each platform to specify default kexec an=
d
> > > crash kernel ops, thus effectively adds a working kexec support for m=
ost
> > > boards.
> > >=20
> > > Platforms that can't cope with default ops will explode in some weird
> > > way (a hang or reboot is most likely), which means that the board's
> > > kexec support should be fixed or blacklisted via dummy _prepare callb=
ack
> > > returning -ENOSYS.
> >=20
> > But where is the patch to do this?
>=20
> The -ENOSYS dummy callback is a last resort thing to do when nobody
> cares or it's impossible to fix the Kexec on some board. We don't
> have any such boards (yet).

Yes we do, iseries, so at the very least we need a patch for that.

> > The chance of kexec working on some random machine that's never been
> > tested is pretty slim, every driver needs to be aware its hardware migh=
t
> > be in a weird state,
>=20
> The boards setup isn't always static. The Kexec might work perfectly
> well on a standalone board, but might hang with some weird PCI device
> attached to it (think that it might need some PCI fixup on shutdown).
>=20
> I think that a "Kexec tested to work on a particular board" term
> just doesn't exist. It might work, but it might hang with other setup
> on the *same* board.

Sure, nothing is 100%, I'd just rather that someone has at least tried a
kexec on the basic config and had it work.

> But in practice the Kexec work on every 6xx board I have. And I have
> pretty much of Freescale boards (almost all from the 83xx series),
> and I don't think it's practical to add #ifdef CONFIG_KEXEC into the
> every board file...

OK in that case I'm OK with it. The Kconfig restricts it to only PPC64
or 6xx, so it's not enabled on _every_ platform.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-jyCcD/18Qoml7NEZ587A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklQLZkACgkQdSjSd0sB4dIa6wCeIZdV/1b+XxSKz+u3N27hw51h
hZcAnipMJXJUYNX2/J0uVlq3z/cUnWW7
=TOFi
-----END PGP SIGNATURE-----

--=-jyCcD/18Qoml7NEZ587A--
