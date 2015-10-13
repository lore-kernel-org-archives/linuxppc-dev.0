Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C7C81A0399
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 00:36:28 +1100 (AEDT)
Received: by pabve7 with SMTP id ve7so22200290pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 06:36:26 -0700 (PDT)
Date: Tue, 13 Oct 2015 21:35:54 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 4/6] powerpc: atomic: Implement atomic{, 64}_*_return_*
 variants
Message-ID: <20151013133554.GA23991@fixme-laptop.cn.ibm.com>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444659246-24769-5-git-send-email-boqun.feng@gmail.com>
 <20151013132132.GH21550@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
In-Reply-To: <20151013132132.GH21550@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2015 at 02:21:32PM +0100, Will Deacon wrote:
> On Mon, Oct 12, 2015 at 10:14:04PM +0800, Boqun Feng wrote:
[snip]
> > +/*
> > + * Since {add,sub}_return_relaxed and xchg_relaxed are implemented with
> > + * a "bne-" instruction at the end, so an isync is enough as a acquire=
 barrier
> > + * on the platform without lwsync.
> > + */
> > +#ifdef CONFIG_SMP
> > +#define smp_acquire_barrier__after_atomic() \
> > +	__asm__ __volatile__(PPC_ACQUIRE_BARRIER : : : "memory")
>=20
> I'm not keen on this barrier, as it sounds like it's part of the kernel
> memory model, as opposed to an implementation detail on PowerPC (and
> we've already got enough of that in the generic code ;).
>=20

Indeed, but we still have smp_lwsync() ;-)

> Can you name it something different please (and maybe #undef it when
> you're done)?
>=20

I've considered #undef it after used, but now I think open code this
into __atomic_op_acquire() of PPC is a better idea?


#define __atomic_op_acquire(op, args...)				\
({									\
	typeof(op##_relaxed(args)) __ret  =3D op##_relaxed(args);		\
	__asm__ __volatile__(PPC_ACQUIRE_BARRIER : : : "memory");	\
	__ret;								\
})

PPC_ACQUIRE_BARRIER will be empty if !SMP, so that will become a pure
compiler barrier and just what we need.

Regards,
Boqun

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWHQi0AAoJEEl56MO1B/q4tq4H/RuczGe+A915BLj0+HoUZ+pA
5p8lHfa23qpmT9GCn19HKuXlC1SRt8JkgYfn3++t3a1ZYyymtlUCMQTb7UrgiTHm
cZ/JPu22FdnS6V6llCdFWg4mEqrMgGofb8z7v1YN2SnVvnxcyppEqmx9oYxWjVi3
ezgLtyT1ttoUPYgQFWaRImn5odm1WUWMsdSYQRuhpdnaVNa3JCogsMg+vc/R+CYT
S+JyQlWE9PFMQf//glLF9dM0qi/jC7aZn400TWXWMAIiMtluGiQjWFhT+chluFf/
ED5JC7gaaiQJIHScw6uooBuqpauQ99X86DKaN5EZAwyhndJ0a0ElEjAJBmIXXD4=
=WSd4
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
