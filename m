Return-Path: <michael@ellerman.id.au>
Subject: Re: Question regarding the DTLB Miss exceptions
From: Michael Ellerman <michael@ellerman.id.au>
To: Bruce_Leonard@selinc.com
In-Reply-To: <OF788A7534.456B03AA-ON882576F6.00228BC4-882576F6.00233EC1@selinc.com>
References: <OF788A7534.456B03AA-ON882576F6.00228BC4-882576F6.00233EC1@selinc.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-Q6sNPAkxF+AYdlIGb5Dc"
Date: Thu, 08 Apr 2010 23:59:30 +1000
Message-ID: <1270735170.19546.2.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-Q6sNPAkxF+AYdlIGb5Dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-03-29 at 23:24 -0700, Bruce_Leonard@selinc.com wrote:=20
> I'm tracking a problem that's leading me through DSI and DTLB miss=20
> exceptions on an MPC8347 (e300c1 core), and I've come across an oddity=20
> that I'm hoping someone can explain.
>=20
> When a DTLB Miss exception can't find a PTE for the virtual address being=
=20
> written/read, it dummies up the SPRs for a DSI exception and then calls=20
> directly into the DSI exception code.  Just before the DTLB miss code=20
> stores a value into DSISR it sets bit 2, which for a DSI exception is a=20
> reserved bit and should be cleared.  There's no comment on the code=20
> (.../arch/powerpc/kernel/head_32.S line 619 of the 2.6.33-rc1 kernel). Ca=
n=20
> anyone tell me why this bit is getting set?

You mean:

616 DataAddressInvalid:
 617         mfspr   r3,SPRN_SRR1
 618         rlwinm  r1,r3,9,6,6     /* Get load/store bit */
 619         addis   r1,r1,0x2000                                          =
    =20
 620         mtspr   SPRN_DSISR,r1

Is it trying to set DSISR_ISSTORE?

#define   DSISR_ISSTORE         0x02000000      /* access was a store */   =
=20


cheers=20

--=-Q6sNPAkxF+AYdlIGb5Dc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAku94T4ACgkQdSjSd0sB4dITZACfbk0Rzg5Q5Wg1f9TcwX2DWgzO
9bMAn2bD6zTvc6Muc9Y33sGWtsE0K3kQ
=Je0r
-----END PGP SIGNATURE-----

--=-Q6sNPAkxF+AYdlIGb5Dc--
