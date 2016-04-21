Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x232.google.com (mail-ig0-x232.google.com
 [IPv6:2607:f8b0:4001:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrNVN4719zDqM1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 01:49:48 +1000 (AEST)
Received: by mail-ig0-x232.google.com with SMTP id gy3so160897963igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 08:49:48 -0700 (PDT)
Date: Thu, 21 Apr 2016 23:52:57 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, paulmck@linux.vnet.ibm.com,
 tglx@linutronix.de
Subject: Re: [PATCH V3] powerpc: Implement {cmp}xchg for u8 and u16
Message-ID: <20160421155257.GA20657@insomnia>
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com>
 <20160420142408.GF3430@twins.programming.kicks-ass.net>
 <5718F32B.3050409@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
In-Reply-To: <5718F32B.3050409@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 21, 2016 at 11:35:07PM +0800, Pan Xinhui wrote:
> On 2016=E5=B9=B404=E6=9C=8820=E6=97=A5 22:24, Peter Zijlstra wrote:
> > On Wed, Apr 20, 2016 at 09:24:00PM +0800, Pan Xinhui wrote:
> >=20
> >> +#define __XCHG_GEN(cmp, type, sfx, skip, v)				\
> >> +static __always_inline unsigned long					\
> >> +__cmpxchg_u32##sfx(v unsigned int *p, unsigned long old,		\
> >> +			 unsigned long new);				\
> >> +static __always_inline u32						\
> >> +__##cmp##xchg_##type##sfx(v void *ptr, u32 old, u32 new)		\
> >> +{									\
> >> +	int size =3D sizeof (type);					\
> >> +	int off =3D (unsigned long)ptr % sizeof(u32);			\
> >> +	volatile u32 *p =3D ptr - off;					\
> >> +	int bitoff =3D BITOFF_CAL(size, off);				\
> >> +	u32 bitmask =3D ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;	\
> >> +	u32 oldv, newv, tmp;						\
> >> +	u32 ret;							\
> >> +	oldv =3D READ_ONCE(*p);						\
> >> +	do {								\
> >> +		ret =3D (oldv & bitmask) >> bitoff;			\
> >> +		if (skip && ret !=3D old)					\
> >> +			break;						\
> >> +		newv =3D (oldv & ~bitmask) | (new << bitoff);		\
> >> +		tmp =3D oldv;						\
> >> +		oldv =3D __cmpxchg_u32##sfx((v u32*)p, oldv, newv);	\
> >> +	} while (tmp !=3D oldv);						\
> >> +	return ret;							\
> >> +}
> >=20
> > So for an LL/SC based arch using cmpxchg() like that is sub-optimal.
> >=20
> > Why did you choose to write it entirely in C?
> >=20
> yes, you are right. more load/store will be done in C code.
> However such xchg_u8/u16 is just used by qspinlock now. and I did not see=
 any performance regression.
> So just wrote in C, for simple. :)
>=20
> Of course I have done xchg tests.
> we run code just like xchg((u8*)&v, j++); in several threads.
> and the result is,
> [  768.374264] use time[1550072]ns in xchg_u8_asm

How was xchg_u8_asm() implemented, using lbarx or using a 32bit ll/sc
loop with shifting and masking in it?

Regards,
Boqun

> [  768.377102] use time[2826802]ns in xchg_u8_c
>=20
> I think this is because there is one more load in C.
> If possible, we can move such code in asm-generic/.
>=20
> thanks
> xinhui
>=20

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXGPdVAAoJEEl56MO1B/q4ZqUH/3X8Y0OXb6fg7TH2Sc9LG0pF
9TPQIwBKl3dWdEFUsKCCltxFNGPXGVtoByUb+8/HNJK3HH0MxFCBAYavnNBFLqVk
x3LWvGYKjlXcJSUpqhP3irPUQ9qw22t+cWIrgYQiHGUbAPuU6X1Jete8pafjO7Dc
9wTkvLF7NywKh3nF8dEK3hk5LcbHSVSMKTryVH6Yf4vbLayIeKea/XgdtSx1ss+b
hkmCkrAiBxUrpqq30W6kZ0KQtcRv0AZ379+EoU2u7ZSlOKevI1ebV/ATKq4a83tI
o8NtFLdjT8NBRSdgSSPo99GdHT7GvWTHoH2SBlEAE1rTT4Vu+fh+/9QzorfrBIk=
=ubdr
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
