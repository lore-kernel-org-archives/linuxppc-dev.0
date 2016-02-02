Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 123E01A006B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 12:08:31 +1100 (AEDT)
Date: Tue, 2 Feb 2016 11:58:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 6/9] pseries: Add hypercall wrappers for hash page table
 resizing
Message-ID: <20160202005820.GB15080@voom.fritz.box>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-7-git-send-email-david@gibson.dropbear.id.au>
 <56AF0523.60902@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
In-Reply-To: <56AF0523.60902@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2016 at 12:41:31PM +0530, Anshuman Khandual wrote:
> On 01/29/2016 10:54 AM, David Gibson wrote:
> > This adds the hypercall numbers and wrapper functions for the hash page
> > table resizing hypercalls.
> >=20
> > These are experimental "platform specific" values for now, until we hav=
e a
> > formal PAPR update.
> >=20
> > It also adds a new firmware feature flat to track the presence of the
> > HPT resizing calls.
>=20
> Its a flag   ....................... ^^^^^^^ here.

Oops, thanks.

>=20
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  arch/powerpc/include/asm/firmware.h       |  5 +++--
> >  arch/powerpc/include/asm/hvcall.h         |  2 ++
> >  arch/powerpc/include/asm/plpar_wrappers.h | 12 ++++++++++++
> >  arch/powerpc/platforms/pseries/firmware.c |  1 +
> >  4 files changed, 18 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include=
/asm/firmware.h
> > index b062924..32435d2 100644
> > --- a/arch/powerpc/include/asm/firmware.h
> > +++ b/arch/powerpc/include/asm/firmware.h
> > @@ -42,7 +42,7 @@
> >  #define FW_FEATURE_SPLPAR	ASM_CONST(0x0000000000100000)
> >  #define FW_FEATURE_LPAR		ASM_CONST(0x0000000000400000)
> >  #define FW_FEATURE_PS3_LV1	ASM_CONST(0x0000000000800000)
> > -/* Free				ASM_CONST(0x0000000001000000) */
> > +#define FW_FEATURE_HPT_RESIZE	ASM_CONST(0x0000000001000000)
> >  #define FW_FEATURE_CMO		ASM_CONST(0x0000000002000000)
> >  #define FW_FEATURE_VPHN		ASM_CONST(0x0000000004000000)
> >  #define FW_FEATURE_XCMO		ASM_CONST(0x0000000008000000)
> > @@ -66,7 +66,8 @@ enum {
> >  		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
> >  		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
> >  		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
> > -		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
> > +		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
> > +		FW_FEATURE_HPT_RESIZE,
> >  	FW_FEATURE_PSERIES_ALWAYS =3D 0,
> >  	FW_FEATURE_POWERNV_POSSIBLE =3D FW_FEATURE_OPAL,
> >  	FW_FEATURE_POWERNV_ALWAYS =3D 0,
> > diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/a=
sm/hvcall.h
> > index e3b54dd..195e080 100644
> > --- a/arch/powerpc/include/asm/hvcall.h
> > +++ b/arch/powerpc/include/asm/hvcall.h
> > @@ -293,6 +293,8 @@
> > =20
> >  /* Platform specific hcalls, used by KVM */
> >  #define H_RTAS			0xf000
> > +#define H_RESIZE_HPT_PREPARE	0xf003
> > +#define H_RESIZE_HPT_COMMIT	0xf004
>=20
> This sound better and matches FW_FEATURE_HPT_RESIZE ?

I'm not quite sure what you're suggesting here.

> #define H_HPT_RESIZE_PREPARE	0xf003
> #define H_HPT_RESIZE_COMMIT	0xf004
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWr/8sAAoJEGw4ysog2bOSsO0P/0hKQG2iZMdS/5dHL20bh7Cd
ryiP3oeQ2aXVeu06xTvgWjyVmZf+KlVkPvAfmDZcUM5F5BqLSFUAl8uACzjIQZpb
4l1Z5Y/mweQftEIDshwOBO/+qckP3uV7/oipwZQZqKcUeP6MycoEaJzG8ly0T5CY
VwjBiCnRX0+Pn7/4uSta9GU0R6pmnzu15VMpr37l8hCqXYInjT+F2+ljNST1EjKz
1grVOznfD+j5L24RROcN4vFCdZU3O8mhKXmdQJwgNaLweiWiaVeU6tbMiKfY4ykw
7JHy8VdYVo6EmTyaP4tzmtxcprkzoYmCoHgyJUZ2RqMf3Sd+Ri4e8c9Qg74nhgCL
mMsDI1q0nEcb090B07hqc2L9cwdvhd2XVdoldKisHER2lqfXgXjFc9bM0tDPO0Nk
XBYC93eqUdSLF+HqwXrQuMpTm0ixZ8cMFwAEupEUee/a6bTs5I2sy+iUgSAg4kA3
QYK7CrBebgX9cQ6sEUmDSGJc0vkunzwQ4iPhrnFZize7PZCo/pz7MC4KqHJ/YM28
IMkR18eg3FAQAEJbsaTpAk+e3IAiND9S6xXv7ye+trWwNkA89LyCpXTgqNtqyfg0
Opz6p6ypPotWHcQrzZcREnvjPoBJdqEhUEyGTDSRcpp9KlPkDA6vHv7n9CjTWtn3
yc5eKRRKq0x98yzdOYsM
=V07r
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
