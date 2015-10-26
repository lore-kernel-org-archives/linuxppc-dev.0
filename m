Return-Path: <boqun.feng@gmail.com>
Received: from mail-oi0-x234.google.com (mail-oi0-x234.google.com
 [IPv6:2607:f8b0:4003:c06::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA0EF1A02BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 21:11:41 +1100 (AEDT)
Received: by oies66 with SMTP id s66so97257467oie.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 03:11:39 -0700 (PDT)
Date: Mon, 26 Oct 2015 18:11:16 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v5 1/6] powerpc: atomic: Make _return
 atomics and *{cmp}xchg fully ordered
Message-ID: <20151026101116.GA21685@fixme-laptop.cn.ibm.com>
References: <1445853057-20735-1-git-send-email-boqun.feng@gmail.com>
 <1445853057-20735-2-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
In-Reply-To: <1445853057-20735-2-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2015 at 05:50:52PM +0800, Boqun Feng wrote:
> This patch fixes two problems to make value-returning atomics and
> {cmp}xchg fully ordered on PPC.
>=20
> According to memory-barriers.txt:
>=20
> > Any atomic operation that modifies some state in memory and returns
> > information about the state (old or new) implies an SMP-conditional
> > general memory barrier (smp_mb()) on each side of the actual
> > operation ...
>=20
> which means these operations should be fully ordered. However on PPC,
> PPC_ATOMIC_ENTRY_BARRIER is the barrier before the actual operation,
> which is currently "lwsync" if SMP=3Dy. The leading "lwsync" can not
> guarantee fully ordered atomics, according to Paul Mckenney:
>=20
> https://lkml.org/lkml/2015/10/14/970
>=20
> To fix this, we define PPC_ATOMIC_ENTRY_BARRIER as "sync" to guarantee
> the fully-ordered semantics.
>=20
> This also makes futex atomics fully ordered, which can avoid possible
> memory ordering problems if userspace code relies on futex system call
> for fully ordered semantics.
>=20
> Another thing to fix is that xchg, cmpxchg and their atomic{64}_
> versions are currently RELEASE+ACQUIRE, which are not fully ordered.
>=20
> So also replace PPC_RELEASE_BARRIER and PPC_ACQUIRE_BARRIER with
> PPC_ATOMIC_ENTRY_BARRIER and PPC_ATOMIC_EXIT_BARRIER in
> __{cmp,}xchg_{u32,u64} respectively to guarantee fully ordered semantics
> of atomic{,64}_{cmp,}xchg() and {cmp,}xchg(), as a complement of commit
> b97021f85517 ("powerpc: Fix atomic_xxx_return barrier semantics").
>=20
> Cc: <stable@vger.kernel.org> # 3.4+

Hmm.. I use the same Cc tag as v4, seems my git(2.6.2) send-email has a
weird behavior of composing Cc address?

I will resend this one soon, sorry ;-(

Regards,
Boqun

> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>=20
> Michael, I also change PPC_ATOMIC_ENTRY_BARRIER as "sync" if SMP=3Dy in t=
his
> version , which is different from the previous one, so request for a new =
ack.
> Thank you ;-)
>=20
>  arch/powerpc/include/asm/cmpxchg.h | 16 ++++++++--------
>  arch/powerpc/include/asm/synch.h   |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/as=
m/cmpxchg.h
> index ad6263c..d1a8d93 100644
> --- a/arch/powerpc/include/asm/cmpxchg.h
> +++ b/arch/powerpc/include/asm/cmpxchg.h
> @@ -18,12 +18,12 @@ __xchg_u32(volatile void *p, unsigned long val)
>  	unsigned long prev;
> =20
>  	__asm__ __volatile__(
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	lwarx	%0,0,%2 \n"
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%3,0,%2 \n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	: "=3D&r" (prev), "+m" (*(volatile unsigned int *)p)
>  	: "r" (p), "r" (val)
>  	: "cc", "memory");
> @@ -61,12 +61,12 @@ __xchg_u64(volatile void *p, unsigned long val)
>  	unsigned long prev;
> =20
>  	__asm__ __volatile__(
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	ldarx	%0,0,%2 \n"
>  	PPC405_ERR77(0,%2)
>  "	stdcx.	%3,0,%2 \n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	: "=3D&r" (prev), "+m" (*(volatile unsigned long *)p)
>  	: "r" (p), "r" (val)
>  	: "cc", "memory");
> @@ -151,14 +151,14 @@ __cmpxchg_u32(volatile unsigned int *p, unsigned lo=
ng old, unsigned long new)
>  	unsigned int prev;
> =20
>  	__asm__ __volatile__ (
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	lwarx	%0,0,%2		# __cmpxchg_u32\n\
>  	cmpw	0,%0,%3\n\
>  	bne-	2f\n"
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%4,0,%2\n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	"\n\
>  2:"
>  	: "=3D&r" (prev), "+m" (*p)
> @@ -197,13 +197,13 @@ __cmpxchg_u64(volatile unsigned long *p, unsigned l=
ong old, unsigned long new)
>  	unsigned long prev;
> =20
>  	__asm__ __volatile__ (
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	ldarx	%0,0,%2		# __cmpxchg_u64\n\
>  	cmpd	0,%0,%3\n\
>  	bne-	2f\n\
>  	stdcx.	%4,0,%2\n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	"\n\
>  2:"
>  	: "=3D&r" (prev), "+m" (*p)
> diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/=
synch.h
> index e682a71..c508686 100644
> --- a/arch/powerpc/include/asm/synch.h
> +++ b/arch/powerpc/include/asm/synch.h
> @@ -44,7 +44,7 @@ static inline void isync(void)
>  	MAKE_LWSYNC_SECTION_ENTRY(97, __lwsync_fixup);
>  #define PPC_ACQUIRE_BARRIER	 "\n" stringify_in_c(__PPC_ACQUIRE_BARRIER)
>  #define PPC_RELEASE_BARRIER	 stringify_in_c(LWSYNC) "\n"
> -#define PPC_ATOMIC_ENTRY_BARRIER "\n" stringify_in_c(LWSYNC) "\n"
> +#define PPC_ATOMIC_ENTRY_BARRIER "\n" stringify_in_c(sync) "\n"
>  #define PPC_ATOMIC_EXIT_BARRIER	 "\n" stringify_in_c(sync) "\n"
>  #else
>  #define PPC_ACQUIRE_BARRIER
> --=20
> 2.6.2
>=20

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWLfxAAAoJEEl56MO1B/q4WpoH/3zLd/JHqaY0wEtmrmFVnU2/
ChTXyeVEy8myTVCpH/MrR9kJjopBgSKzgYuM5JvqyoPXzKnK6mJm8xpoYQA7vszk
j8luI+4KY84kn7wyuHnj5toyscrTuEqqvC/+V/UlPJPAFRvJP1AzUUERwIpMQurv
7BF0QLnpCggDkbWVsP0LQtFi+YWyQvcDfHmG6+hWkO09I6ALDrLQaSblDZa7QYsb
mf6YzLQKXqqBiZH5nu/rlhhK1HTDxjee8/WQk198hV4iwosdZrCrWa7lZmDMD7t2
AEdSQU2o/m3vgJOcM2TwY62xDDb8GsBPJJ1xj+bsMFR7NfY1IlSnTXnWFuwfBSE=
=cnOH
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
