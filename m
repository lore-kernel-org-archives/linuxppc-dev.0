Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x236.google.com (mail-io0-x236.google.com
 [IPv6:2607:f8b0:4001:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qw1gQ1zgNzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 23:55:14 +1000 (AEST)
Received: by mail-io0-x236.google.com with SMTP id u185so54181758iod.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 06:55:14 -0700 (PDT)
Date: Wed, 27 Apr 2016 21:58:17 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH V4] powerpc: Implement {cmp}xchg for u8 and u16
Message-ID: <20160427135817.GJ3369@insomnia>
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com>
 <5720837D.6050807@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9aCKuHbn5v2q3RVc"
In-Reply-To: <5720837D.6050807@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9aCKuHbn5v2q3RVc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2016 at 05:16:45PM +0800, Pan Xinhui wrote:
> From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>=20
> Implement xchg{u8,u16}{local,relaxed}, and
> cmpxchg{u8,u16}{,local,acquire,relaxed}.
>=20
> It works on all ppc.
>=20
> remove volatile of first parameter in __cmpxchg_local and __cmpxchg
>=20
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
> change from v3:
> 	rewrite in asm for the LL/SC.
> 	remove volatile in __cmpxchg_local and __cmpxchg.
> change from v2:
> 	in the do{}while(), we save one load and use corresponding cmpxchg suffi=
x.
> 	Also add corresponding __cmpxchg_u32 function declaration in the __XCHG_=
GEN=20
> change from V1:
> 	rework totally.
> ---
>  arch/powerpc/include/asm/cmpxchg.h | 109 +++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 106 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/as=
m/cmpxchg.h
> index 44efe73..8a3735f 100644
> --- a/arch/powerpc/include/asm/cmpxchg.h
> +++ b/arch/powerpc/include/asm/cmpxchg.h
> @@ -7,6 +7,71 @@
>  #include <asm/asm-compat.h>
>  #include <linux/bug.h>
> =20
> +#ifdef __BIG_ENDIAN
> +#define BITOFF_CAL(size, off)	((sizeof(u32) - size - off) * BITS_PER_BYT=
E)
> +#else
> +#define BITOFF_CAL(size, off)	(off * BITS_PER_BYTE)
> +#endif
> +
> +#define XCHG_GEN(type, sfx, cl)				\
> +static inline u32 __xchg_##type##sfx(void *p, u32 val)		\
> +{								\
> +	unsigned int prev, prev_mask, tmp, bitoff, off;		\
> +								\
> +	off =3D (unsigned long)p % sizeof(u32);			\
> +	bitoff =3D BITOFF_CAL(sizeof(type), off);			\
> +	p -=3D off;						\
> +	val <<=3D bitoff;						\
> +	prev_mask =3D (u32)(type)-1 << bitoff;			\
> +								\
> +	__asm__ __volatile__(					\
> +"1:	lwarx   %0,0,%3\n"					\
> +"	andc	%1,%0,%5\n"					\
> +"	or	%1,%1,%4\n"					\
> +	PPC405_ERR77(0,%3)					\
> +"	stwcx.	%1,0,%3\n"					\
> +"	bne-	1b\n"						\
> +	: "=3D&r" (prev), "=3D&r" (tmp), "+m" (*(u32*)p)		\

I think we can save the "tmp" here by:

	__asm__ volatile__(
"1:	lwarx	%0,0,%2\n"
"	andc	%0,%0,%4\n"
"	or	%0,%0,%3\n"
	PPC405_ERR77(0,%2)
"	stwcx.	%0,0,%2\n"
"	bne-	1b\n"
	: "=3D&r" (prev), "+m" (*(u32*)p)
	: "r" (p), "r" (val), "r" (prev_mask)
	: "cc", cl);

right?

> +	: "r" (p), "r" (val), "r" (prev_mask)			\
> +	: "cc", cl);						\
> +								\
> +	return prev >> bitoff;					\
> +}
> +
> +#define CMPXCHG_GEN(type, sfx, br, br2, cl)			\
> +static inline							\
> +u32 __cmpxchg_##type##sfx(void *p, u32 old, u32 new)		\
> +{								\
> +	unsigned int prev, prev_mask, tmp, bitoff, off;		\
> +								\
> +	off =3D (unsigned long)p % sizeof(u32);			\
> +	bitoff =3D BITOFF_CAL(sizeof(type), off);			\
> +	p -=3D off;						\
> +	old <<=3D bitoff;						\
> +	new <<=3D bitoff;						\
> +	prev_mask =3D (u32)(type)-1 << bitoff;			\
> +								\
> +	__asm__ __volatile__(					\
> +	br							\
> +"1:	lwarx   %0,0,%3\n"					\
> +"	and	%1,%0,%6\n"					\
> +"	cmpw	0,%1,%4\n"					\
> +"	bne-	2f\n"						\
> +"	andc	%1,%0,%6\n"					\
> +"	or	%1,%1,%5\n"					\
> +	PPC405_ERR77(0,%3)					\
> +"	stwcx.  %1,0,%3\n"					\
> +"	bne-    1b\n"						\
> +	br2							\
> +	"\n"							\
> +"2:"								\
> +	: "=3D&r" (prev), "=3D&r" (tmp), "+m" (*(u32*)p)		\

And "tmp" here could also be saved by:

"1:	lwarx   %0,0,%2\n"					\
"	xor	%3,%0,%3\n"					\
"	and.	%3,%3,%5\n"					\
"	bne-	2f\n"						\
"	andc	%0,%0,%5\n"					\
"	or	%0,%0,%4\n"					\
	PPC405_ERR77(0,%2)					\
"	stwcx.  %0,0,%2\n"					\
"	bne-    1b\n"						\
	br2							\
	"\n"							\
"2:"								\
	: "=3D&r" (prev), "+m" (*(u32*)p)		\
	: "r" (p), "r" (old), "r" (new), "r" (prev_mask)	\
	: "cc", cl);						\

right?

IIUC, saving the local variable "tmp" will result in saving a general
register for the compilers to use for other variables.

So thoughts?

Regards,
Boqun

> +	: "r" (p), "r" (old), "r" (new), "r" (prev_mask)	\
> +	: "cc", cl);						\
> +								\
> +	return prev >> bitoff;					\
> +}
> +
>  /*
>   * Atomic exchange
>   *
> @@ -14,6 +79,11 @@
>   * the previous value stored there.
>   */
> =20
> +XCHG_GEN(u8, _local, "memory");
> +XCHG_GEN(u8, _relaxed, "cc");
> +XCHG_GEN(u16, _local, "memory");
> +XCHG_GEN(u16, _relaxed, "cc");
> +
>  static __always_inline unsigned long
>  __xchg_u32_local(volatile void *p, unsigned long val)
>  {
> @@ -85,9 +155,13 @@ __xchg_u64_relaxed(u64 *p, unsigned long val)
>  #endif
> =20
>  static __always_inline unsigned long
> -__xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
> +__xchg_local(void *ptr, unsigned long x, unsigned int size)
>  {
>  	switch (size) {
> +	case 1:
> +		return __xchg_u8_local(ptr, x);
> +	case 2:
> +		return __xchg_u16_local(ptr, x);
>  	case 4:
>  		return __xchg_u32_local(ptr, x);
>  #ifdef CONFIG_PPC64
> @@ -103,6 +177,10 @@ static __always_inline unsigned long
>  __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
>  {
>  	switch (size) {
> +	case 1:
> +		return __xchg_u8_relaxed(ptr, x);
> +	case 2:
> +		return __xchg_u16_relaxed(ptr, x);
>  	case 4:
>  		return __xchg_u32_relaxed(ptr, x);
>  #ifdef CONFIG_PPC64
> @@ -131,6 +209,15 @@ __xchg_relaxed(void *ptr, unsigned long x, unsigned =
int size)
>   * and return the old value of *p.
>   */
> =20
> +CMPXCHG_GEN(u8, , PPC_ATOMIC_ENTRY_BARRIER, PPC_ATOMIC_EXIT_BARRIER, "me=
mory");
> +CMPXCHG_GEN(u8, _local, , , "memory");
> +CMPXCHG_GEN(u8, _acquire, , PPC_ACQUIRE_BARRIER, "memory");
> +CMPXCHG_GEN(u8, _relaxed, , , "cc");
> +CMPXCHG_GEN(u16, , PPC_ATOMIC_ENTRY_BARRIER, PPC_ATOMIC_EXIT_BARRIER, "m=
emory");
> +CMPXCHG_GEN(u16, _local, , , "memory");
> +CMPXCHG_GEN(u16, _acquire, , PPC_ACQUIRE_BARRIER, "memory");
> +CMPXCHG_GEN(u16, _relaxed, , , "cc");
> +
>  static __always_inline unsigned long
>  __cmpxchg_u32(volatile unsigned int *p, unsigned long old, unsigned long=
 new)
>  {
> @@ -312,10 +399,14 @@ __cmpxchg_u64_acquire(u64 *p, unsigned long old, un=
signed long new)
>  #endif
> =20
>  static __always_inline unsigned long
> -__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
> +__cmpxchg(void *ptr, unsigned long old, unsigned long new,
>  	  unsigned int size)
>  {
>  	switch (size) {
> +	case 1:
> +		return __cmpxchg_u8(ptr, old, new);
> +	case 2:
> +		return __cmpxchg_u16(ptr, old, new);
>  	case 4:
>  		return __cmpxchg_u32(ptr, old, new);
>  #ifdef CONFIG_PPC64
> @@ -328,10 +419,14 @@ __cmpxchg(volatile void *ptr, unsigned long old, un=
signed long new,
>  }
> =20
>  static __always_inline unsigned long
> -__cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
> +__cmpxchg_local(void *ptr, unsigned long old, unsigned long new,
>  	  unsigned int size)
>  {
>  	switch (size) {
> +	case 1:
> +		return __cmpxchg_u8_local(ptr, old, new);
> +	case 2:
> +		return __cmpxchg_u16_local(ptr, old, new);
>  	case 4:
>  		return __cmpxchg_u32_local(ptr, old, new);
>  #ifdef CONFIG_PPC64
> @@ -348,6 +443,10 @@ __cmpxchg_relaxed(void *ptr, unsigned long old, unsi=
gned long new,
>  		  unsigned int size)
>  {
>  	switch (size) {
> +	case 1:
> +		return __cmpxchg_u8_relaxed(ptr, old, new);
> +	case 2:
> +		return __cmpxchg_u16_relaxed(ptr, old, new);
>  	case 4:
>  		return __cmpxchg_u32_relaxed(ptr, old, new);
>  #ifdef CONFIG_PPC64
> @@ -364,6 +463,10 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsi=
gned long new,
>  		  unsigned int size)
>  {
>  	switch (size) {
> +	case 1:
> +		return __cmpxchg_u8_acquire(ptr, old, new);
> +	case 2:
> +		return __cmpxchg_u16_acquire(ptr, old, new);
>  	case 4:
>  		return __cmpxchg_u32_acquire(ptr, old, new);
>  #ifdef CONFIG_PPC64
> --=20
> 2.4.3
>=20

--9aCKuHbn5v2q3RVc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXIMVyAAoJEEl56MO1B/q4vPgH/i2Z/REWhANyGqpXK8OBFpn3
kSEkWwsftlizQmT7XIbvBqR14iiB2AY0kef85DjpWPdX52zexncXMaj4k1RdjtPZ
Ht1urpajGeswkVYQfTFsnv28g0zOJgINRRPD6CkJKst/z2E0zY+MQeYxmTNw3bQK
dXXIWh/bMP1T7an42J7hQoScleXsHRpZgdWWTly/LkJT/1ESj7qoqBta45/2cRj1
y1/ot+Uqb39pkedng9dYqrG1MeLO/upMIPPS1B3bJiuURkVaj9pP9Q9aemN4bYz6
gAxWCoSdaH2gNIORIXLLS9P3J9IeMjBp6BCaYZFYq3KHX3V+oMYvetY0Di+carY=
=mVg3
-----END PGP SIGNATURE-----

--9aCKuHbn5v2q3RVc--
