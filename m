Return-Path: <boqun.feng@gmail.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQn731R7dzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 13:03:27 +1000 (AEST)
Received: by mail-it0-x241.google.com with SMTP id e5so230641ith.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jun 2016 20:03:27 -0700 (PDT)
Date: Fri, 10 Jun 2016 11:06:52 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3] powerpc: spinlock: Fix spin_unlock_wait()
Message-ID: <20160610030652.GC26274@insomnia>
References: <1465213340.2658.1.camel@ellerman.id.au>
 <20160606115655.GD30909@twins.programming.kicks-ass.net>
 <1465215445.2658.4.camel@ellerman.id.au>
 <20160606144659.GG30909@twins.programming.kicks-ass.net>
 <1465384845.13854.7.camel@ellerman.id.au>
 <20160608123507.GR30154@twins.programming.kicks-ass.net>
 <1465393760.10567.4.camel@ellerman.id.au>
 <20160608135903.GT30154@twins.programming.kicks-ass.net>
 <1465475008.16363.1.camel@ellerman.id.au>
 <20160609172503.GB26274@insomnia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
In-Reply-To: <20160609172503.GB26274@insomnia>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2016 at 01:25:03AM +0800, Boqun Feng wrote:
> On Thu, Jun 09, 2016 at 10:23:28PM +1000, Michael Ellerman wrote:
> > On Wed, 2016-06-08 at 15:59 +0200, Peter Zijlstra wrote:
> > > On Wed, Jun 08, 2016 at 11:49:20PM +1000, Michael Ellerman wrote:
> > >
> > > > > Ok; what tree does this go in? I have this dependent series which=
 I'd
> > > > > like to get sorted and merged somewhere.
> > > >=20
> > > > Ah sorry, I didn't realise. I was going to put it in my next (which=
 doesn't
> > > > exist yet but hopefully will early next week).
> > > >=20
> > > > I'll make a topic branch with just that commit based on rc2 or rc3?
> > >=20
> > > Works for me; thanks!
> > =20
> > Unfortunately the patch isn't 100%.
> >=20
> > It's causing some of my machines to lock up hard, which isn't surprisin=
g when
> > you look at the generated code for the non-atomic spin loop:
> >=20
> >   c00000000009af48:	7c 21 0b 78 	mr      r1,r1					# HMT_LOW
> >   c00000000009af4c:	40 9e ff fc 	bne     cr7,c00000000009af48 <.do_exit=
+0x6d8>
> >=20
>=20
> There is even no code checking for SHARED_PROCESSOR here, so I assume
> your config is !PPC_SPLPAR.
>=20
> > Which is a spin loop waiting for a result in cr7, but with no compariso=
n.
> >=20
> > The problem seems to be that we did:
> >=20
> > @@ -184,7 +184,7 @@ static inline void arch_spin_unlock_wait(arch_spinl=
ock_t *lock)
> >  	if (arch_spin_value_unlocked(lock_val))
> >  		goto out;
> > =20
> > -	while (lock->slock) {
> > +	while (!arch_spin_value_unlocked(*lock)) {
> >  		HMT_low();
> >  		if (SHARED_PROCESSOR)
> >  			__spin_yield(lock);
> >=20
>=20
> And as I also did an consolidation in this patch, we now share the same
> piece of arch_spin_unlock_wait(), so if !PPC_SPLPAR, the previous loop
> became:
>=20
> 	while (!arch_spin_value_unlocked(*lock)) {
>  		HMT_low();
> 	}
>=20
> and given HMT_low() is not a compiler barrier. So the compiler may
> optimize out the loop..
>=20
> > Which seems to be hiding the fact that lock->slock is volatile from the
> > compiler, even though arch_spin_value_unlocked() is inline. Not sure if=
 that's
> > our bug or gcc's.
> >=20
>=20
> I think arch_spin_value_unlocked() is not volatile because
> arch_spin_value_unlocked() takes the value of the lock rather than the
> address of the lock as its parameter, which makes it a pure function.
>=20
> To fix this we can add READ_ONCE() for the read of lock value like the
> following:
>=20
> 	while(!arch_spin_value_unlock(READ_ONCE(*lock))) {
> 		HMT_low();
> 		...
>=20
> Or you prefer to simply using lock->slock which is a volatile variable
> already?
>=20
> Or maybe we can refactor the code a little like this:
>=20
> static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
> {
>        arch_spinlock_t lock_val;
>=20
>        smp_mb();
>=20
>        /*
>         * Atomically load and store back the lock value (unchanged).  This
>         * ensures that our observation of the lock value is ordered with
>         * respect to other lock operations.
>         */
>        __asm__ __volatile__(
> "1:    " PPC_LWARX(%0, 0, %2, 0) "\n"
> "      stwcx. %0, 0, %2\n"
> "      bne- 1b\n"
>        : "=3D&r" (lock_val), "+m" (*lock)
>        : "r" (lock)
>        : "cr0", "xer");
>=20
>        while (!arch_spin_value_unlocked(lock_val)) {
>                HMT_low();
>                if (SHARED_PROCESSOR)
>                        __spin_yield(lock);
>=20
>                lock_val =3D READ_ONCE(*lock);
>        }
>        HMT_medium();
>=20
>        smp_mb();
> }
>=20

This version will generate the correct code for the loop if !PPC_SPLPAR:

c00000000009fa70:       78 0b 21 7c     mr      r1,r1
c00000000009fa74:       ec 06 37 81     lwz     r9,1772(r23)
c00000000009fa78:       00 00 a9 2f     cmpdi   cr7,r9,0
c00000000009fa7c:       f4 ff 9e 40     bne     cr7,c00000000009fa70 <do_ex=
it+0xf0>
c00000000009fa80:       78 13 42 7c     mr      r2,r2

The reason I used arch_spin_value_unlocked() was trying to be consistent
with arch_spin_is_locked(), but most of our all lock primitives use
->slock directly. So I don't see a strong reason for us to use
arch_spin_value_unlocked() here. That said, this version does save a few
lines of code and make the logic a little more clear, I think.

Thoughts?

Regards,
Boqun

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXWi7FAAoJEEl56MO1B/q4XsQH/1Y+1huMMM3Ly0+biCvBPfoW
AB6x+XNZUsinkGOaOhTzufIYNNJxwjY3b9JyAc6Ua5xBcAZ0ixPJ26TzO+OG6fI5
T1uy62Ndkbk5PMkRvXe4kNJdeSxc3ksbcHh9dsJuc5z517Qk2fnLQweO/pauDADc
62SZM9Dfv6MQNmMUTUNSjHmVj9lLPiDidhQcRqee4YwG7ih1Hko/ocykH+h64TZg
NCDv/diNnqoKcRHZ5mD/4wLvjNo0nhe49rIFb2KXhOQM05Zf5K8WPr00kqXy2LMc
/l9sGrbAD8dx5gt83VySTPCACpW9Zo8JVK6ZuxBXyIQPlLrKBUTSJ7voou9pFik=
=srKS
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
