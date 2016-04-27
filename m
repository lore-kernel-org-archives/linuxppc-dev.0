Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x22b.google.com (mail-ig0-x22b.google.com
 [IPv6:2607:f8b0:4001:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qw24307wmzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 00:13:07 +1000 (AEST)
Received: by mail-ig0-x22b.google.com with SMTP id g8so45885701igr.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 07:13:06 -0700 (PDT)
Date: Wed, 27 Apr 2016 22:16:07 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH V4] powerpc: Implement {cmp}xchg for u8 and u16
Message-ID: <20160427141607.GK3369@insomnia>
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com>
 <5720837D.6050807@linux.vnet.ibm.com>
 <20160427135817.GJ3369@insomnia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M0YLxmUXciMpOLPE"
In-Reply-To: <20160427135817.GJ3369@insomnia>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--M0YLxmUXciMpOLPE
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

Oops, this should be:

"1:	lwarx   %0,0,%3\n"					\
"	xor	%2,%0,%2\n"					\
"	and.	%2,%2,%5\n"					\
"	bne-	2f\n"						\
"	andc	%0,%0,%5\n"					\
"	or	%0,%0,%4\n"					\
	PPC405_ERR77(0,%3)					\
"	stwcx.  %0,0,%3\n"					\
"	bne-    1b\n"						\
	br2							\
	"\n"							\
"2:"								\
	: "=3D&r" (prev), "+m" (*(u32*)p), "+&r" (old)		\
	: "r" (p), "r" (new), "r" (prev_mask)			\
	: "cc", cl);						\

Regards,
Boqun

--M0YLxmUXciMpOLPE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXIMmjAAoJEEl56MO1B/q4BgUH/iTMj8E21BQilJr+/58C5vZB
iL5IgjSQ8aCxUl/axPj7J4cqhxY5onXUY2LX64epLxbdRBTCa0AnjuKj0joEGzEu
gFlwIUvvvka5sAta0yTraEri0PC1t6BAFCCutRhbLFqfE7CCQeu6YK3CjYDpCdXo
o7r5PmAzZszvYkDf8dIsvSpa/4vinid4G2da2IZMprFBv/LpH4449be5KaePt2hq
57MginkZlLQ1+TBV20Nhs1VzEoVUTsnKJ7y8BtIeRxT6NmDEllmKm8VlmFRDjgJ9
PJjAOhnFpZN9bW6ZAVxEDRwSHDy1doXeoVPAxKmLvYF+2fVDt1IN0PVN1gJMNqk=
=DAIL
-----END PGP SIGNATURE-----

--M0YLxmUXciMpOLPE--
