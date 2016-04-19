Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x232.google.com (mail-ig0-x232.google.com
 [IPv6:2607:f8b0:4001:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpzvm5RvpzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 19:18:28 +1000 (AEST)
Received: by mail-ig0-x232.google.com with SMTP id gy3so95098155igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 02:18:28 -0700 (PDT)
Date: Tue, 19 Apr 2016 17:18:18 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH V2] powerpc: Implement {cmp}xchg for u8 and u16
Message-ID: <20160419091818.GA69264@boquns-mbp.cn.ibm.com>
References: <5715D04E.9050009@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5715D04E.9050009@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Xinhui,

On Tue, Apr 19, 2016 at 02:29:34PM +0800, Pan Xinhui wrote:
> From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>=20
> Implement xchg{u8,u16}{local,relaxed}, and
> cmpxchg{u8,u16}{,local,acquire,relaxed}.
>=20
> It works on all ppc.
>=20

Nice work!

AFAICT, your work doesn't depend on anything that ppc-specific, right?
So maybe we can use it as a general approach for a fallback
implementation on the archs without u8/u16 atomics. ;-)

> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
> change from V1:
> 	rework totally.
> ---
>  arch/powerpc/include/asm/cmpxchg.h | 83 ++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 83 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/as=
m/cmpxchg.h
> index 44efe73..79a1f45 100644
> --- a/arch/powerpc/include/asm/cmpxchg.h
> +++ b/arch/powerpc/include/asm/cmpxchg.h
> @@ -7,6 +7,37 @@
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
> +static __always_inline unsigned long
> +__cmpxchg_u32_local(volatile unsigned int *p, unsigned long old,
> +			unsigned long new);
> +
> +#define __XCHG_GEN(cmp, type, sfx, u32sfx, skip, v)			\
> +static __always_inline u32						\
> +__##cmp##xchg_##type##sfx(v void *ptr, u32 old, u32 new)		\
> +{									\
> +	int size =3D sizeof (type);					\
> +	int off =3D (unsigned long)ptr % sizeof(u32);			\
> +	volatile u32 *p =3D ptr - off;					\
> +	int bitoff =3D BITOFF_CAL(size, off);				\
> +	u32 bitmask =3D ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;	\
> +	u32 oldv, newv;							\
> +	u32 ret;							\
> +	do {								\
> +		oldv =3D READ_ONCE(*p);					\
> +		ret =3D (oldv & bitmask) >> bitoff;			\
> +		if (skip && ret !=3D old)					\
> +			break;						\
> +		newv =3D (oldv & ~bitmask) | (new << bitoff);		\
> +	} while (__cmpxchg_u32##u32sfx((v void*)p, oldv, newv) !=3D oldv);\

Forgive me if this is too paranoid, but I think we can save the
READ_ONCE() in the loop if we change the code into the following,
because cmpxchg will return the "new" value, if the cmp part fails.

	newv =3D READ_ONCE(*p);

	do {
		oldv =3D newv;
		ret =3D (oldv & bitmask) >> bitoff;
		if (skip && ret !=3D old)
			break;
		newv =3D (oldv & ~bitmask) | (new << bitoff);
		newv =3D __cmpxchg_u32##u32sfx((void *)p, oldv, newv);
	} while(newv !=3D oldv);

> +	return ret;							\
> +}
> +
>  /*
>   * Atomic exchange
>   *
> @@ -14,6 +45,19 @@
>   * the previous value stored there.
>   */
> =20
> +#define XCHG_GEN(type, sfx, v)						\
> +		__XCHG_GEN(_, type, sfx, _local, 0, v)			\
                                         ^^^^^^^

This should be sfx, right? Otherwise, all the newly added xchg will
call __cmpxchg_u32_local, this will result in wrong ordering guarantees.

> +static __always_inline u32 __xchg_##type##sfx(v void *p, u32 n)	\
> +{									\
> +	return ___xchg_##type##sfx(p, 0, n);				\
> +}
> +
> +XCHG_GEN(u8, _local, volatile);

I don't think we need the "volatile" modifier here, because READ_ONCE()
and __cmpxchg_u32_* all have "volatile" semantics IIUC, so maybe we can
save a paramter for the __XCHG_GEN macro.

Regards,
Boqun

> +XCHG_GEN(u8, _relaxed, );
> +XCHG_GEN(u16, _local, volatile);
> +XCHG_GEN(u16, _relaxed, );
> +#undef XCHG_GEN
> +
>  static __always_inline unsigned long
>  __xchg_u32_local(volatile void *p, unsigned long val)
>  {
> @@ -88,6 +132,10 @@ static __always_inline unsigned long
>  __xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
>  {
>  	switch (size) {
> +	case 1:
> +		return __xchg_u8_local(ptr, x);
> +	case 2:
> +		return __xchg_u16_local(ptr, x);
>  	case 4:
>  		return __xchg_u32_local(ptr, x);
>  #ifdef CONFIG_PPC64
> @@ -103,6 +151,10 @@ static __always_inline unsigned long
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
> @@ -226,6 +278,21 @@ __cmpxchg_u32_acquire(u32 *p, unsigned long old, uns=
igned long new)
>  	return prev;
>  }
> =20
> +
> +#define CMPXCHG_GEN(type, sfx, v)				\
> +	__XCHG_GEN(cmp, type, sfx, sfx, 1, v)
> +
> +CMPXCHG_GEN(u8, , volatile);
> +CMPXCHG_GEN(u8, _local, volatile);
> +CMPXCHG_GEN(u8, _relaxed, );
> +CMPXCHG_GEN(u8, _acquire, );
> +CMPXCHG_GEN(u16, , volatile);
> +CMPXCHG_GEN(u16, _local, volatile);
> +CMPXCHG_GEN(u16, _relaxed, );
> +CMPXCHG_GEN(u16, _acquire, );
> +#undef CMPXCHG_GEN
> +#undef __XCHG_GEN
> +
>  #ifdef CONFIG_PPC64
>  static __always_inline unsigned long
>  __cmpxchg_u64(volatile unsigned long *p, unsigned long old, unsigned lon=
g new)
> @@ -316,6 +383,10 @@ __cmpxchg(volatile void *ptr, unsigned long old, uns=
igned long new,
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
> @@ -332,6 +403,10 @@ __cmpxchg_local(volatile void *ptr, unsigned long ol=
d, unsigned long new,
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
> @@ -348,6 +423,10 @@ __cmpxchg_relaxed(void *ptr, unsigned long old, unsi=
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
> @@ -364,6 +443,10 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsi=
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
