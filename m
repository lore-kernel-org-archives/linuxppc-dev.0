Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC] BOOKE watchdog and kexec
From: Michael Ellerman <michael@ellerman.id.au>
To: Dave Jiang <djiang@mvista.com>
In-Reply-To: <46538264.2050000@mvista.com>
References: <46538264.2050000@mvista.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-asBNgrPAPVcRtC0qrCPy"
Date: Wed, 23 May 2007 13:36:59 +1000
Message-Id: <1179891419.6145.19.camel@concordia.ozlabs.ibm.com>
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


--=-asBNgrPAPVcRtC0qrCPy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-22 at 16:53 -0700, Dave Jiang wrote:
> What would be the appropriate way to deal with the BOOKE watchdog in orde=
r to
> properly kexec? The BOOKE watchdog cannot be disabled. With the current
> implementation, a watchdog daemon in userland is required to poke the
> /dev/watchdog continously in order to keep it from going off. In the kexe=
c
> situation, the watchdog daemon in userland goes away when the new kernel =
is
> executed. It is very possible that the new kernel can potentially timeout=
 on a
> certain hardware device initialization (i.e. SCSI discovery/timeout) and =
causes
> the watchdog to go off and reset the hardware. The reset is of course not
> wanted in this situation.
>=20
> Several solutions comes into mind:
> 1. Have the kernel timer poke the watchdog. This would ensure situation
> described above would never happen. I think x86 does this with NMI watchd=
og.
>=20
> 2. Have the watchdog driver spawn a kernel thread to poke the watchdog at=
 a
> periodic time. Or perhaps use the delayed-work mechanism to do that.
>=20
> 3. Set the highest bit of the watchdog register so that it does not expir=
e for
> 2^32 ticks.

#3 sounds the easiest. You'd set it in machine_kexec_prepare() and then
have the second kernel restore a sane value. I assume 2^32 ticks is long
enough to boot?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-asBNgrPAPVcRtC0qrCPy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGU7bbdSjSd0sB4dIRAmzaAJ9kKI8D7YbrfXL1p0XwPHXm+08X6ACgqrjy
xhxb4Rer4zQb/Qkl+cwN8/Q=
=8WQ3
-----END PGP SIGNATURE-----

--=-asBNgrPAPVcRtC0qrCPy--
