Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2C984B70C5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 16:19:55 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19D9ADDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 16:19:55 +1000 (EST)
Subject: Re: sym scsi driver problem with 2.6.26 or newer debian kernel on
	p610 (fwd)
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1245823019.10356.69.camel@pasglop>
References: <Pine.LNX.4.64.0906141105050.4412@axis700.grange>
	<4A38B883.80507@ktk.bme.hu>  <4A3F4A77.6070704@ktk.bme.hu>
	<1245719890.4017.26.camel@pasglop> <1245724218.4017.35.camel@pasglop>
	<1245794228.10356.31.camel@pasglop> <1245799792.10356.42.camel@pasglop>
	<1245822826.9237.62.camel@concordia>
	<1245823019.10356.69.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-a7xyBQrfbsvugh/rowBF"
Date: Wed, 24 Jun 2009 16:19:52 +1000
Message-Id: <1245824392.9237.85.camel@concordia>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, blackluck@ktk.bme.hu
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-a7xyBQrfbsvugh/rowBF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-06-24 at 15:56 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2009-06-24 at 15:53 +1000, Michael Ellerman wrote:
> > Doesn't fix my machine :/
> >=20
> That doesn't make sense ... What if you remove the bit inside the ifdef
> CONFIG_MPIC_BROKEN_REGREAD in _mpic_read() ?
>=20
> If that makes a difference, then it would be interesting to add a printk
> in there that prints what the original value "val" is and what we have
> in the shadow...

With this patch it boots:

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 2353adc..fc17289 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -231,13 +231,16 @@ static inline u32 _mpic_irq_read(struct mpic *mpic, u=
nsign
        unsigned int    isu =3D src_no >> mpic->isu_shift;
        unsigned int    idx =3D src_no & mpic->isu_mask;
        unsigned int    val;
+       unsigned int    shadow;
=20
        val =3D _mpic_read(mpic->reg_type, &mpic->isus[isu],
                         reg + (idx * MPIC_INFO(IRQ_STRIDE))); =20
 #ifdef CONFIG_MPIC_BROKEN_REGREAD
-       if (reg =3D=3D 0)
-               val =3D (val & (MPIC_VECPRI_MASK | MPIC_VECPRI_ACTIVITY)) |
+       if (reg =3D=3D 0) {
+               shadow =3D (val & (MPIC_VECPRI_MASK | MPIC_VECPRI_ACTIVITY)=
) |
                        mpic->isu_reg0_shadow[idx];
+               printk("%s: val 0x%x shadow 0x%x\n", __func__, val, shadow)=
;
+       }
 #endif
        return val;
 }


And I see:

sym53c8xx 0000:00:0c.0: enabling device (0140 -> 0143)
sym0: <896> rev 0x7 at pci 0000:00:0c.0 irq 17
sym0: No NVRAM, ID 7, Fast-40, SE, parity checking
_mpic_irq_read: val 0x80480004 shadow 0x80080014
_mpic_irq_read: val 0x480004 shadow 0x480004



cheers

--=-a7xyBQrfbsvugh/rowBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpBxYgACgkQdSjSd0sB4dJpDACfSdOBQ/0dIgLcjo6uTi+cIxfF
ld8AoIaV8oSyjFOjp/8xkgjWUZ9qNXyK
=WmLu
-----END PGP SIGNATURE-----

--=-a7xyBQrfbsvugh/rowBF--
