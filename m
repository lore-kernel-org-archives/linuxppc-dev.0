Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (sipsolutions.net [66.160.135.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD6D26888B
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 01:49:58 +1100 (EST)
From: Johannes Berg <johannes@sipsolutions.net>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <66D10776-B8F2-48E4-9B96-CA37323B5799@kernel.crashing.org>
References: <1134569118.3875.9.camel@localhost>
	<66D10776-B8F2-48E4-9B96-CA37323B5799@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1JDDdWty+ZHnNLXkzLUq"
Date: Wed, 14 Dec 2005 15:49:33 +0100
Message-Id: <1134571773.3875.12.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: illegal instructions / irqs disabled warning
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-1JDDdWty+ZHnNLXkzLUq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-12-14 at 08:41 -0600, Kumar Gala wrote:

> Its highly likely, but not guaranteed on all systems.  In truth this =20
> is most likely a bug.

Ok.

> > But here's the actual question:
> > static inline unsigned long __copy_from_user(void *to,
> >                 const void __user *from, unsigned long size)
> > {
> >         might_sleep();
> >         return __copy_from_user_inatomic(to, from, size);
> > }
> >
> > Does that mean __copy_from_user_inatomic isn't actually valid to =20
> > call in
> > atomic context? Or is this only so that kernel developers that use
> > powerpc see the bugs their code would have on other platforms? The =20
> > magic
> > in get_user_asm thoroughly confuses me.
>=20
> What do you mean atomic context?  Not exactly sure what your asking =20
> about.

Well, the above code loading the instruction that faulted is called from
the interrupt context where the kernel tries to fix it up. If that
instruction is not in memory for whatever reason, then it shouldn't try
to fix it up bug kill the program with SIGILL or SIGSEGV or whatever...
This is what I came from, and tried looking into how to implement that.
But then I ran across the code in __copy_from_user which just calls
__copy_from_user_inatomic so I'm wondering if it is actually possible to
safely copy data (the instruction) from user space in an interrupt.

Thanks,
johannes

--=-1JDDdWty+ZHnNLXkzLUq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ6Aw+6Vg1VMiehFYAQJmmw/+NCJ7OUzOUJzqA4C/K8Uc76ehFpn5y0LE
/+WJ+Rr25Osfyh7XFJpjq6XL7IZvsbE5tO3HSacAbaDoxjcLqlZ32t5lsgggFet6
mZCf1X4KtHhHEGQ6o9khLnevU4rvyvs1MAS8e2QjQJc4vFWnHEjZcWmyKdm66u72
RzPU8Eq0Gk5qV5G4eNIr8sqgzf/Iks5LDr0P3kP3+kznMHBKiqVfl4i+v0dQHxM6
BnnMyHXQH8wVwpmYd1hxoNtxz29pkhI+jLZe/imzzS1EXSDY0VcTTQ8aYBmHQUxj
q5FwAQ/NhBLk2SBips9TgUnbVyinCYO8iQHJe23G1zyMUh7OcmVHTGKkUzBvLnKE
+tp1FYfmdQDFx3D4K4a1m3CqAAfx0bLW/C9gfjPNxcVFzpNJuQ4JTHcrddefS4by
87b8EYB1dByA4MW4Kf0SUfV218pa4fkuZJ2CoI4tntZV5vlkAAoW83RQXp3Vmb2d
+iMX11afysyTK+dbMA5atR2uUeE+8ZWAtulP0Z1OdwkDMUo7YM/8t7u6jmGbBHRu
ficpDuvK8jNqTkoXTtTuVs3AppANs/VfM7QZxhZAUNIAwz41oCmd3hNPgB8bM/NC
quBQopa4SFOSVVALmx9mWncq1IQEL/DdGxWMCOHgdhfIZ25NK2rWc/G5hMom6dfM
uXTY9DPaQ4o=
=RrD2
-----END PGP SIGNATURE-----

--=-1JDDdWty+ZHnNLXkzLUq--
