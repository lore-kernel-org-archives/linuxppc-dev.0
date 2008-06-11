Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [PATCH] powerpc/cell: disable ptcal in case of
	kdump reboot
From: Michael Ellerman <michael@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200806111828.59043.arnd@arndb.de>
References: <200806111828.59043.arnd@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-AhvSmqCo1p6ElYZ5UFUl"
Date: Thu, 12 Jun 2008 02:49:16 +1000
Message-Id: <1213202956.28589.4.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
	cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-AhvSmqCo1p6ElYZ5UFUl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-06-11 at 18:28 +0200, Arnd Bergmann wrote:
> The ibm,cbe-start-ptcal rtas call transfers ownership
> of a memory range to the hardware in order to do
> periodic memory interface recalibration.
> When we do a kexec, we need to get this page back,
> so we don't step on the new kernel's toes.
> We used to do this correctly in case of a user triggered
> kexec, but not for kdump.

Used to?

> This patch disables ptcal from the cell specific
> machine_crash_shutdown() callback.=20

I'd rather you used the crash_shutdown_register() infrastructure Mikey
added for EHEA - it's designed for just this sort of thing.

> I also needed to fix the pseries code that tries to install its
> default_machine_crash_shutdown() code independent
> of what machine we're running on.

That's a buglet.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-AhvSmqCo1p6ElYZ5UFUl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIUAIMdSjSd0sB4dIRAsFoAJwMmBqkuRQGPJBhWZ9Q8zbUA/EdpQCgh2M4
sg1xEKNwMuUvSn5J4JUhbcY=
=QxVP
-----END PGP SIGNATURE-----

--=-AhvSmqCo1p6ElYZ5UFUl--
