Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x22f.google.com (mail-io0-x22f.google.com
 [IPv6:2607:f8b0:4001:c06::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrgg02PjxzDqhc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 13:13:16 +1000 (AEST)
Received: by mail-io0-x22f.google.com with SMTP id f89so84477496ioi.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 20:13:16 -0700 (PDT)
Date: Fri, 22 Apr 2016 11:16:24 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, paulmck@linux.vnet.ibm.com,
 tglx@linutronix.de
Subject: Re: [PATCH V3] powerpc: Implement {cmp}xchg for u8 and u16
Message-ID: <20160422031624.GB20657@insomnia>
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com>
 <20160420142408.GF3430@twins.programming.kicks-ass.net>
 <5718F32B.3050409@linux.vnet.ibm.com>
 <20160421155257.GA20657@insomnia>
 <5719857A.5080201@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
In-Reply-To: <5719857A.5080201@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2016 at 09:59:22AM +0800, Pan Xinhui wrote:
> On 2016=E5=B9=B404=E6=9C=8821=E6=97=A5 23:52, Boqun Feng wrote:
> > On Thu, Apr 21, 2016 at 11:35:07PM +0800, Pan Xinhui wrote:
> >> On 2016=E5=B9=B404=E6=9C=8820=E6=97=A5 22:24, Peter Zijlstra wrote:
> >>> On Wed, Apr 20, 2016 at 09:24:00PM +0800, Pan Xinhui wrote:
> >>>
> >>>> +#define __XCHG_GEN(cmp, type, sfx, skip, v)				\
> >>>> +static __always_inline unsigned long					\
> >>>> +__cmpxchg_u32##sfx(v unsigned int *p, unsigned long old,		\
> >>>> +			 unsigned long new);				\
> >>>> +static __always_inline u32						\
> >>>> +__##cmp##xchg_##type##sfx(v void *ptr, u32 old, u32 new)		\
> >>>> +{									\
> >>>> +	int size =3D sizeof (type);					\
> >>>> +	int off =3D (unsigned long)ptr % sizeof(u32);			\
> >>>> +	volatile u32 *p =3D ptr - off;					\
> >>>> +	int bitoff =3D BITOFF_CAL(size, off);				\
> >>>> +	u32 bitmask =3D ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;	\
> >>>> +	u32 oldv, newv, tmp;						\
> >>>> +	u32 ret;							\
> >>>> +	oldv =3D READ_ONCE(*p);						\
> >>>> +	do {								\
> >>>> +		ret =3D (oldv & bitmask) >> bitoff;			\
> >>>> +		if (skip && ret !=3D old)					\
> >>>> +			break;						\
> >>>> +		newv =3D (oldv & ~bitmask) | (new << bitoff);		\
> >>>> +		tmp =3D oldv;						\
> >>>> +		oldv =3D __cmpxchg_u32##sfx((v u32*)p, oldv, newv);	\
> >>>> +	} while (tmp !=3D oldv);						\
> >>>> +	return ret;							\
> >>>> +}
> >>>
> >>> So for an LL/SC based arch using cmpxchg() like that is sub-optimal.
> >>>
> >>> Why did you choose to write it entirely in C?
> >>>
> >> yes, you are right. more load/store will be done in C code.
> >> However such xchg_u8/u16 is just used by qspinlock now. and I did not =
see any performance regression.
> >> So just wrote in C, for simple. :)
> >>
> >> Of course I have done xchg tests.
> >> we run code just like xchg((u8*)&v, j++); in several threads.
> >> and the result is,
> >> [  768.374264] use time[1550072]ns in xchg_u8_asm
> >=20
> > How was xchg_u8_asm() implemented, using lbarx or using a 32bit ll/sc
> > loop with shifting and masking in it?
> >=20
> yes, using 32bit ll/sc loops.
>=20
> looks like:
>         __asm__ __volatile__(
> "1:     lwarx   %0,0,%3\n"
> "       and %1,%0,%5\n"
> "       or %1,%1,%4\n"
>        PPC405_ERR77(0,%2)
> "       stwcx.  %1,0,%3\n"
> "       bne-    1b"
>         : "=3D&r" (_oldv), "=3D&r" (tmp), "+m" (*(volatile unsigned int *=
)_p)
>         : "r" (_p), "r" (_newv), "r" (_oldv_mask)
>         : "cc", "memory");
>=20

Good, so this works for all ppc ISAs too.

Given the performance benefit(maybe caused by the reason Peter
mentioned), I think we should use this as the implementation of u8/u16
{cmp}xchg for now. For Power7 and later, we can always switch to the
lbarx/lharx version if observable performance benefit can be achieved.

But the choice is left to you. After all, as you said, qspinlock is the
only user ;-)

Regards,
Boqun

>=20
> > Regards,
> > Boqun
> >=20
> >> [  768.377102] use time[2826802]ns in xchg_u8_c
> >>
> >> I think this is because there is one more load in C.
> >> If possible, we can move such code in asm-generic/.
> >>
> >> thanks
> >> xinhui
> >>
>=20

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXGZeEAAoJEEl56MO1B/q4hyYIAIFvSoY2xOMqHwIOB8/9ZM56
CCllAFY4jND+x6X6I+lTkxI16qSP9tGG74bsZi06AbXwjH9QFnTvbetvRLWbq2Fl
4wHciP/0GH1c8hjq8xbfUxLPzdNzlrg1tF0c8vjvh8Xec+/UAaP20/+TLB+b9P+7
K7BEEeGoH3nczgZQ2vnDEDusmtyAtkc0tnkxPPEUJiKWGyXhKoAlr68cwbNQYRYa
rbUCyAhNoeXjj98XIvNdmBNCni3wCvUMM+gxqqEoiJhTnMBPSc2Efht3FVBFOT+1
yY3nBotcKcPwSd5bGxSbbri4QVi/WzTv0uF1KH+2wsESqdoyiRFk2ZRqpPceZNM=
=K1Vz
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
