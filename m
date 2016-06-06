Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNMqP2rchzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 14:56:33 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id l9so17605538ioe.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jun 2016 21:56:33 -0700 (PDT)
Date: Mon, 6 Jun 2016 12:59:59 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [v2] powerpc: spinlock: Fix spin_unlock_wait()
Message-ID: <20160606045959.GE23133@insomnia>
References: <20160603034948.17589-1-boqun.feng@gmail.com>
 <3rNMkF2Y1sz9t4P@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
In-Reply-To: <3rNMkF2Y1sz9t4P@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2016 at 02:52:05PM +1000, Michael Ellerman wrote:
> On Fri, 2016-03-06 at 03:49:48 UTC, Boqun Feng wrote:
> > There is an ordering issue with spin_unlock_wait() on powerpc, because
> > the spin_lock primitive is an ACQUIRE and an ACQUIRE is only ordering
> > the load part of the operation with memory operations following it.
>=20
> ...
> > diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include=
/asm/spinlock.h
> > index 523673d7583c..2ed893662866 100644
> > --- a/arch/powerpc/include/asm/spinlock.h
> > +++ b/arch/powerpc/include/asm/spinlock.h
> > @@ -162,12 +181,23 @@ static inline void arch_spin_unlock(arch_spinlock=
_t *lock)
> >  	lock->slock =3D 0;
> >  }
> > =20
> > -#ifdef CONFIG_PPC64
> > -extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
> > -#else
> > -#define arch_spin_unlock_wait(lock) \
> > -	do { while (arch_spin_is_locked(lock)) cpu_relax(); } while (0)
> > -#endif
> > +static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
> > +{
> > +	smp_mb();
> > +
> > +	if (!arch_spin_is_locked_sync(lock))
> > +		goto out;
> > +
> > +	while (!arch_spin_value_unlocked(*lock)) {
> > +		HMT_low();
> > +		if (SHARED_PROCESSOR)
> > +			__spin_yield(lock);
> > +	}
> > +	HMT_medium();
> > +
> > +out:
> > +	smp_mb();
> > +}
>=20
> I think this would actually be easier to follow if it was all just in one=
 routine:
>=20
> static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
> {
> 	arch_spinlock_t lock_val;
>=20
> 	smp_mb();
>=20
> 	/*
> 	 * Atomically load and store back the lock value (unchanged). This
> 	 * ensures that our observation of the lock value is ordered with
> 	 * respect to other lock operations.
> 	 */
> 	__asm__ __volatile__(
> "1:	" PPC_LWARX(%0, 0, %2, 1) "\n"
> "	stwcx. %0, 0, %2\n"
> "	bne- 1b\n"
> 	: "=3D&r" (lock_val), "+m" (*lock)
> 	: "r" (lock)
> 	: "cr0", "xer");
>=20
> 	if (arch_spin_value_unlocked(lock_val))
> 		goto out;
>=20
> 	while (!arch_spin_value_unlocked(*lock)) {
> 		HMT_low();
> 		if (SHARED_PROCESSOR)
> 			__spin_yield(lock);
> 	}
> 	HMT_medium();
>=20
> out:
> 	smp_mb();
> }
>=20
>=20
> Thoughts?
>=20

Make sense. I admit that I sort of overdesigned by introducing
arch_spin_is_locked_sync().

This version is better, thank you!

Regards,
Boqun

> cheers

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXVQNLAAoJEEl56MO1B/q4PyUH/38bgJ0sun75VjDYzRZV81dM
ZlkYDUOFBpsQ0AklDYU54JN0fVt8yYdhM4ySZXC9bXW89aLMNodrkbliBepvaLDI
TuqYfM03Owv7Fbqz0M3j2oQD2A44vKROh+qrrKoHtWxbeJ9/pVvKOYp0I5UXL15J
wvkrwLXOWsPm4Lp3p5M36XdkmNrocYDQoA/KK1eA6nfLcxila5YgNMS5Ou4f3dfg
O492odp6ePG26RY+XiTOE0ebUrPbNlfzM6VCHcd4l8TPF4INBeVs9qmh4jfg4GcW
I6OkL1IDpDvvz2l80IiogxITp3Sj1rAkgP39z3n1OVCk33NGt4cIpsZu4cbl1Bw=
=JKMO
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--
