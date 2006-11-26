Return-Path: <michael@ellerman.id.au>
Subject: Re: powerpc.git build error
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@tux.tmfweb.nl
In-Reply-To: <20061125225807.GA10510@nospam.com>
References: <20061125225807.GA10510@nospam.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-bpjYdgv8fg9tBv3YAmTY"
Date: Sun, 26 Nov 2006 17:39:43 +1100
Message-Id: <1164523183.10222.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-bpjYdgv8fg9tBv3YAmTY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-11-25 at 23:58 +0100, Rutger Nijlunsing wrote:
> Hi,
>=20
> While respinning my previous patch, I'm trying to (cross)compile the
> PowerPC git kernel (branch master) for a UP G3 (PowerBook) which
> results in compile errors:
>=20
> ...
>   CC      arch/powerpc/kernel/crash.o
> arch/powerpc/kernel/crash.c: In function 'default_machine_crash_shutdown'=
:
> arch/powerpc/kernel/crash.c:292: warning: implicit declaration of functio=
n 'hard_irq_disable'
> ...
> arch/powerpc/kernel/built-in.o: In function `default_machine_crash_shutdo=
wn':
> arch/powerpc/kernel/crash.c:292: undefined reference to `hard_irq_disable=
'
> make: *** [.tmp_vmlinux1] Error 1
>=20
> ...which can be traced back to commit
> d04c56f73c30a5e593202ecfcf25ed43d42363a2.
>=20
> This has undoubtly to do with my config (CONFIG_PPC64=3Dn,
> CONFIG_PPC32=3Dy); .config attached for full inspection.

And CONFIG_KEXEC=3Dy, which is not in any 32-bit defconfigs. Do you
actually want it enabled?

See my patch just posted which should fix this for you.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-bpjYdgv8fg9tBv3YAmTY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFaTaudSjSd0sB4dIRAlBTAJ9ua4vPdZIiSB9zx2WrcZy9DCwSzQCeI03x
nfNQXW0SiYiSCQpAgO7FHww=
=PoKt
-----END PGP SIGNATURE-----

--=-bpjYdgv8fg9tBv3YAmTY--
