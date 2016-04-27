Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x233.google.com (mail-io0-x233.google.com
 [IPv6:2607:f8b0:4001:c06::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qw2qk3VQDzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 00:47:30 +1000 (AEST)
Received: by mail-io0-x233.google.com with SMTP id u185so56020470iod.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 07:47:30 -0700 (PDT)
Date: Wed, 27 Apr 2016 22:50:34 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH V4] powerpc: Implement {cmp}xchg for u8 and u16
Message-ID: <20160427145034.GL3369@insomnia>
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com>
 <5720837D.6050807@linux.vnet.ibm.com>
 <20160427135817.GJ3369@insomnia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5VuzLDXibKSJvVYD"
In-Reply-To: <20160427135817.GJ3369@insomnia>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5VuzLDXibKSJvVYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2016 at 09:58:17PM +0800, Boqun Feng wrote:
> On Wed, Apr 27, 2016 at 05:16:45PM +0800, Pan Xinhui wrote:
> > From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> >=20
> > Implement xchg{u8,u16}{local,relaxed}, and
> > cmpxchg{u8,u16}{,local,acquire,relaxed}.
> >=20
> > It works on all ppc.
> >=20
> > remove volatile of first parameter in __cmpxchg_local and __cmpxchg
> >=20
> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> > ---
> > change from v3:
> > 	rewrite in asm for the LL/SC.
> > 	remove volatile in __cmpxchg_local and __cmpxchg.
> > change from v2:
> > 	in the do{}while(), we save one load and use corresponding cmpxchg suf=
fix.
> > 	Also add corresponding __cmpxchg_u32 function declaration in the __XCH=
G_GEN=20
> > change from V1:
> > 	rework totally.
> > ---
> >  arch/powerpc/include/asm/cmpxchg.h | 109 +++++++++++++++++++++++++++++=
+++++++-
> >  1 file changed, 106 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/=
asm/cmpxchg.h
> > index 44efe73..8a3735f 100644
> > --- a/arch/powerpc/include/asm/cmpxchg.h
> > +++ b/arch/powerpc/include/asm/cmpxchg.h
> > @@ -7,6 +7,71 @@
> >  #include <asm/asm-compat.h>
> >  #include <linux/bug.h>
> > =20
> > +#ifdef __BIG_ENDIAN
> > +#define BITOFF_CAL(size, off)	((sizeof(u32) - size - off) * BITS_PER_B=
YTE)
> > +#else
> > +#define BITOFF_CAL(size, off)	(off * BITS_PER_BYTE)
> > +#endif
> > +
> > +#define XCHG_GEN(type, sfx, cl)				\
> > +static inline u32 __xchg_##type##sfx(void *p, u32 val)		\
> > +{								\
> > +	unsigned int prev, prev_mask, tmp, bitoff, off;		\
> > +								\
> > +	off =3D (unsigned long)p % sizeof(u32);			\
> > +	bitoff =3D BITOFF_CAL(sizeof(type), off);			\
> > +	p -=3D off;						\
> > +	val <<=3D bitoff;						\
> > +	prev_mask =3D (u32)(type)-1 << bitoff;			\
> > +								\
> > +	__asm__ __volatile__(					\
> > +"1:	lwarx   %0,0,%3\n"					\
> > +"	andc	%1,%0,%5\n"					\
> > +"	or	%1,%1,%4\n"					\
> > +	PPC405_ERR77(0,%3)					\
> > +"	stwcx.	%1,0,%3\n"					\
> > +"	bne-	1b\n"						\
> > +	: "=3D&r" (prev), "=3D&r" (tmp), "+m" (*(u32*)p)		\
>=20
> I think we can save the "tmp" here by:
>=20
> 	__asm__ volatile__(
> "1:	lwarx	%0,0,%2\n"
> "	andc	%0,%0,%4\n"
> "	or	%0,%0,%3\n"
> 	PPC405_ERR77(0,%2)
> "	stwcx.	%0,0,%2\n"
> "	bne-	1b\n"
> 	: "=3D&r" (prev), "+m" (*(u32*)p)
> 	: "r" (p), "r" (val), "r" (prev_mask)
> 	: "cc", cl);
>=20
> right?
>=20
> > +	: "r" (p), "r" (val), "r" (prev_mask)			\
> > +	: "cc", cl);						\
> > +								\
> > +	return prev >> bitoff;					\
> > +}
> > +
> > +#define CMPXCHG_GEN(type, sfx, br, br2, cl)			\
> > +static inline							\
> > +u32 __cmpxchg_##type##sfx(void *p, u32 old, u32 new)		\
> > +{								\
> > +	unsigned int prev, prev_mask, tmp, bitoff, off;		\
> > +								\
> > +	off =3D (unsigned long)p % sizeof(u32);			\
> > +	bitoff =3D BITOFF_CAL(sizeof(type), off);			\
> > +	p -=3D off;						\
> > +	old <<=3D bitoff;						\
> > +	new <<=3D bitoff;						\
> > +	prev_mask =3D (u32)(type)-1 << bitoff;			\
> > +								\
> > +	__asm__ __volatile__(					\
> > +	br							\
> > +"1:	lwarx   %0,0,%3\n"					\
> > +"	and	%1,%0,%6\n"					\
> > +"	cmpw	0,%1,%4\n"					\
> > +"	bne-	2f\n"						\
> > +"	andc	%1,%0,%6\n"					\
> > +"	or	%1,%1,%5\n"					\
> > +	PPC405_ERR77(0,%3)					\
> > +"	stwcx.  %1,0,%3\n"					\
> > +"	bne-    1b\n"						\
> > +	br2							\
> > +	"\n"							\
> > +"2:"								\
> > +	: "=3D&r" (prev), "=3D&r" (tmp), "+m" (*(u32*)p)		\
>=20
> And "tmp" here could also be saved by:
>=20
> "1:	lwarx   %0,0,%2\n"					\
> "	xor	%3,%0,%3\n"					\
> "	and.	%3,%3,%5\n"					\
> "	bne-	2f\n"						\
> "	andc	%0,%0,%5\n"					\
> "	or	%0,%0,%4\n"					\
> 	PPC405_ERR77(0,%2)					\
> "	stwcx.  %0,0,%2\n"					\
> "	bne-    1b\n"						\
> 	br2							\
> 	"\n"							\
> "2:"								\
> 	: "=3D&r" (prev), "+m" (*(u32*)p)		\
> 	: "r" (p), "r" (old), "r" (new), "r" (prev_mask)	\
> 	: "cc", cl);						\
>=20
> right?
>=20

Sorry, my bad, we can't implement cmpxchg like this.. please ignore
this, I should really go to bed soon...

But still, we can save the "tmp" for xchg() I think.

Regards,
Boqun

> IIUC, saving the local variable "tmp" will result in saving a general
> register for the compilers to use for other variables.
>=20
> So thoughts?
>=20
> Regards,
> Boqun
>=20

--5VuzLDXibKSJvVYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXING2AAoJEEl56MO1B/q4b0oIAKu769O+bgzi3deE8VTZba5v
K4HQzCcG+7tqBiCzfwyC/RbE8MjeILjYf+SCgYJlJ4aPVJ9p8de1BfwFHo+Pa9sd
WPjPoRvrX1SXlrCYQSWolBKWtX8dJKdfovjz3kkrnZRrL+Ft/ojJdhXkwkbjmFd6
fTmDr5F85Gd352tdwGk+hzzBem2CYVCpHUOk0B+iXtZoVff/5IQab42fArg1Vt6P
TK8HCI981gsmuX7oLx4Ecy7tZiZhnFlx4z/osoQmgxPfWoovKi8sFWBzWcITwsl4
XWtX0oEgSsQ6j/oStyEx9N78cGq8bq+ceWKEIvdwXDFLdgibcZMmUAAJlT9veuU=
=Pea6
-----END PGP SIGNATURE-----

--5VuzLDXibKSJvVYD--
