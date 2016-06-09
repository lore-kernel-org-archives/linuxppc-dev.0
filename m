Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x230.google.com (mail-io0-x230.google.com
 [IPv6:2607:f8b0:4001:c06::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQXCk69zlzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 03:21:38 +1000 (AEST)
Received: by mail-io0-x230.google.com with SMTP id o189so43963786ioe.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jun 2016 10:21:38 -0700 (PDT)
Date: Fri, 10 Jun 2016 01:25:03 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3] powerpc: spinlock: Fix spin_unlock_wait()
Message-ID: <20160609172503.GB26274@insomnia>
References: <1465213340.2658.1.camel@ellerman.id.au>
 <20160606115655.GD30909@twins.programming.kicks-ass.net>
 <1465215445.2658.4.camel@ellerman.id.au>
 <20160606144659.GG30909@twins.programming.kicks-ass.net>
 <1465384845.13854.7.camel@ellerman.id.au>
 <20160608123507.GR30154@twins.programming.kicks-ass.net>
 <1465393760.10567.4.camel@ellerman.id.au>
 <20160608135903.GT30154@twins.programming.kicks-ass.net>
 <1465475008.16363.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
In-Reply-To: <1465475008.16363.1.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2016 at 10:23:28PM +1000, Michael Ellerman wrote:
> On Wed, 2016-06-08 at 15:59 +0200, Peter Zijlstra wrote:
> > On Wed, Jun 08, 2016 at 11:49:20PM +1000, Michael Ellerman wrote:
> >
> > > > Ok; what tree does this go in? I have this dependent series which I=
'd
> > > > like to get sorted and merged somewhere.
> > >=20
> > > Ah sorry, I didn't realise. I was going to put it in my next (which d=
oesn't
> > > exist yet but hopefully will early next week).
> > >=20
> > > I'll make a topic branch with just that commit based on rc2 or rc3?
> >=20
> > Works for me; thanks!
> =20
> Unfortunately the patch isn't 100%.
>=20
> It's causing some of my machines to lock up hard, which isn't surprising =
when
> you look at the generated code for the non-atomic spin loop:
>=20
>   c00000000009af48:	7c 21 0b 78 	mr      r1,r1					# HMT_LOW
>   c00000000009af4c:	40 9e ff fc 	bne     cr7,c00000000009af48 <.do_exit+0=
x6d8>
>=20

There is even no code checking for SHARED_PROCESSOR here, so I assume
your config is !PPC_SPLPAR.

> Which is a spin loop waiting for a result in cr7, but with no comparison.
>=20
> The problem seems to be that we did:
>=20
> @@ -184,7 +184,7 @@ static inline void arch_spin_unlock_wait(arch_spinloc=
k_t *lock)
>  	if (arch_spin_value_unlocked(lock_val))
>  		goto out;
> =20
> -	while (lock->slock) {
> +	while (!arch_spin_value_unlocked(*lock)) {
>  		HMT_low();
>  		if (SHARED_PROCESSOR)
>  			__spin_yield(lock);
>=20

And as I also did an consolidation in this patch, we now share the same
piece of arch_spin_unlock_wait(), so if !PPC_SPLPAR, the previous loop
became:

	while (!arch_spin_value_unlocked(*lock)) {
 		HMT_low();
	}

and given HMT_low() is not a compiler barrier. So the compiler may
optimize out the loop..

> Which seems to be hiding the fact that lock->slock is volatile from the
> compiler, even though arch_spin_value_unlocked() is inline. Not sure if t=
hat's
> our bug or gcc's.
>=20

I think arch_spin_value_unlocked() is not volatile because
arch_spin_value_unlocked() takes the value of the lock rather than the
address of the lock as its parameter, which makes it a pure function.

To fix this we can add READ_ONCE() for the read of lock value like the
following:

	while(!arch_spin_value_unlock(READ_ONCE(*lock))) {
		HMT_low();
		...

Or you prefer to simply using lock->slock which is a volatile variable
already?

Or maybe we can refactor the code a little like this:

static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
{
       arch_spinlock_t lock_val;

       smp_mb();

       /*
        * Atomically load and store back the lock value (unchanged).  This
        * ensures that our observation of the lock value is ordered with
        * respect to other lock operations.
        */
       __asm__ __volatile__(
"1:    " PPC_LWARX(%0, 0, %2, 0) "\n"
"      stwcx. %0, 0, %2\n"
"      bne- 1b\n"
       : "=3D&r" (lock_val), "+m" (*lock)
       : "r" (lock)
       : "cr0", "xer");

       while (!arch_spin_value_unlocked(lock_val)) {
               HMT_low();
               if (SHARED_PROCESSOR)
                       __spin_yield(lock);

               lock_val =3D READ_ONCE(*lock);
       }
       HMT_medium();

       smp_mb();
}

> Will sleep on it.
>=20

Bed time for me too, I will run more tests on the three proposals above
tomorrow and see how things are going.

Regards,
Boqun

> cheers
>=20

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXWaZqAAoJEEl56MO1B/q4880H/RKWUYNNgFgMWweJBB5YXgk9
QlU+v7f3tm+/nl/wJKGGWiyAgHbvAs7L/h+HOLmcC2wqkv9CZoKw3bjQfMx/vYYp
knOko0VI0rWQ9piRg9tLrBZlCcOCxb2R9z2nTDhzcP8AGDCLfopVfcNNYxmdTXyH
6JjC+ZaHRaq1Ci0bMQ2+5GjybbqCtIFQ4fKigep94E8YC5sPyZK7wcdJqoYEiCUA
atqIQBTuW1gNWMHh1EufcemrlOLM14gWlwn4U9cgVLu2MxQ/ubnLbmklokOxTBBM
onop75ZKyQJvDWVJlD/+Vn4X08zotu2v2NuwZbaaC6Le74d+f2fomqIHFE/OL4k=
=u5ps
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
