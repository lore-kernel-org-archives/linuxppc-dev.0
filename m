Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc: add setmaskedbits macros
From: Michael Ellerman <michael@ellerman.id.au>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <11872134502476-git-send-email-timur@freescale.com>
References: <11872134502476-git-send-email-timur@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-bupPbMWimvurJGrMUwC7"
Date: Thu, 16 Aug 2007 13:55:48 +1000
Message-Id: <1187236548.8375.13.camel@concordia.ozlabs.ibm.com>
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


--=-bupPbMWimvurJGrMUwC7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-08-15 at 16:30 -0500, Timur Tabi wrote:
> This patch adds the setmaskedbits_xxx() macros, which are used to set a
> multiple-bit bit pattern in a register.  The macros include a mask, which
> zeros the respective bits before applying the value via a bitwise-OR.
> There are big-endian and little-endian versions for 8, 16, 32, and 64 bit=
s.
>=20
> These new macros are useful because the setbits macros can only be used=20
> to set single-bit fields.  For example, if you have a 32-bit register=20
> where bits 17-20 need to be set to 0100, you would do =20
> setmaskedbits_be32(p, 4 << 11, 0xF << 11).
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> Updated the changelog to include a reason why you'd want these macros.
> I have a number of new SOC device drivers coming up that will use these
> macros, if this patch is accepted.
>=20
>  include/asm-powerpc/io.h |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
>=20
> diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
> index bb8d965..ac3defb 100644
> --- a/include/asm-powerpc/io.h
> +++ b/include/asm-powerpc/io.h
> @@ -734,6 +734,19 @@ static inline void * bus_to_virt(unsigned long addre=
ss)
>  #define setbits16(_addr, _v) out_be16((_addr), in_be16(_addr) |  (_v))
>  #define clrbits16(_addr, _v) out_be16((_addr), in_be16(_addr) & ~(_v))
> =20
> +#ifdef __powerpc64__
> +#define setmaskedbits_be64(a, v, m) out_be64((a), (in_be64(a) & ~(m)) | =
(v))
> +#define setmaskedbits_le64(a, v, m) out_le64((a), (in_le64(a) & ~(m)) | =
(v))
> +#endif
> +
> +#define setmaskedbits_be32(a, v, m) out_be32((a), (in_be32(a) & ~(m)) | =
(v))
> +#define setmaskedbits_be16(a, v, m) out_be16((a), (in_be16(a) & ~(m)) | =
(v))
> +
> +#define setmaskedbits_le32(a, v, m) out_le32((a), (in_le32(a) & ~(m)) | =
(v))
> +#define setmaskedbits_le16(a, v, m) out_le16((a), (in_le16(a) & ~(m)) | =
(v))
> +
> +#define setmaskedbits_8(a, v, m) out_8((a), (in_8(a) & ~(m)) | (v))

Can you extract the masking logic, rather than repeating it 7 times:

#define maskbits(a, v, m)	((a) & ~(m) | (v))

And if you're going to the trouble of making a macro, why not make it a
bit more useful and have it check that the value and the mask match, ie:

(v & ~m =3D=3D 0)

Final random thought, you could make the size/endian an argument:

#define setmaskedbits(a, v, m, s)  out_##s((a), (in_##s(a) & ~(m) | (v))

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-bupPbMWimvurJGrMUwC7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGw8rEdSjSd0sB4dIRAlp0AKCnszlB9VH8cDBckwXEleV+8BkDAACfdQjp
rVE5br97mP6aeNpzh7R/OQk=
=2oKh
-----END PGP SIGNATURE-----

--=-bupPbMWimvurJGrMUwC7--
