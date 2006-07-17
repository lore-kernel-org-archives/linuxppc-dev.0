Return-Path: <michael@ellerman.id.au>
Subject: Re: Kexec initial registers
From: Michael Ellerman <michael@ellerman.id.au>
To: Jimi Xenidis <jimix@watson.ibm.com>
In-Reply-To: <28C15305-BE9F-4EE7-93A2-437EAEA7B886@watson.ibm.com>
References: <4CE0FC89-084F-42E8-8E3B-8D2C41AC06F2@watson.ibm.com>
	<1152911297.23037.109.camel@localhost.localdomain>
	<28C15305-BE9F-4EE7-93A2-437EAEA7B886@watson.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-GwEqRIkA11EtAHOfavM1"
Date: Mon, 17 Jul 2006 11:22:02 +1000
Message-Id: <1153099323.7388.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-GwEqRIkA11EtAHOfavM1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-07-15 at 22:10 -0400, Jimi Xenidis wrote:
> On Jul 14, 2006, at 5:08 PM, Benjamin Herrenschmidt wrote:
>=20
> > On Fri, 2006-07-14 at 12:02 -0400, Jimi Xenidis wrote:
> >> This is what I have so far:
> >>
> >>    r3: address of device tree blob
> >>    r4: address that kernel was loaded
> >>    r5: not OF (=3D0)
> >
> > Correct and that's all that should be needed
> >
> >>    r13: local_paca address (0?)
> >
> > You shouldn't have to care about r13 at all, it should be set by the
> > kernel before it's used. If not, please let us know as that means =20
> > there
> > is a bug :)
>=20
> Not! 99.99% :)
> When loading a kernel under Xen using kexec we set r1-r5 and set all =20
> other GPRS to all 5's (cuz we can) with CONFIG_PPC_EARLY_DEBUG=3Dy and =20
> all hell breaks loose in the first printk()/DBG() from early_setup() =20
> for:
>    kernel/printk.c:506
>    506		spin_lock_irqsave(&logbuf_lock, flags);
>=20
> where is access local_paca.

There should be a call to setup_paca(0) in early_setup() _before_ the
first printk/DBG. That patch is pretty new though, so you might not have
it yet.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-GwEqRIkA11EtAHOfavM1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEuuY6dSjSd0sB4dIRAhzIAKCiMrVHnc4owQhWBQrQVcd5TQJLEACfbXyr
K9tQMXQDwOxxlNCDl/hUlCw=
=jd5m
-----END PGP SIGNATURE-----

--=-GwEqRIkA11EtAHOfavM1--
