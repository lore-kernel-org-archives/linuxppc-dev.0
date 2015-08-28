Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1D101A0036
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 22:06:32 +1000 (AEST)
Received: by padhm10 with SMTP id hm10so5432663pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 05:06:31 -0700 (PDT)
Date: Fri, 28 Aug 2015 20:06:14 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC 3/5] powerpc: atomic: implement
 atomic{,64}_{add,sub}_return_* variants
Message-ID: <20150828120614.GC29325@fixme-laptop.cn.ibm.com>
References: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
 <1440730099-29133-4-git-send-email-boqun.feng@gmail.com>
 <20150828104854.GB16853@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
In-Reply-To: <20150828104854.GB16853@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Fri, Aug 28, 2015 at 12:48:54PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 28, 2015 at 10:48:17AM +0800, Boqun Feng wrote:
> > +/*
> > + * Since {add,sub}_return_relaxed and xchg_relaxed are implemented with
> > + * a "bne-" instruction at the end, so an isync is enough as a acquire=
 barrier
> > + * on the platform without lwsync.
> > + */
> > +#ifdef CONFIG_SMP
> > +#define smp_acquire_barrier__after_atomic() \
> > +	__asm__ __volatile__(PPC_ACQUIRE_BARRIER : : : "memory")
> > +#else
> > +#define smp_acquire_barrier__after_atomic() barrier()
> > +#endif
> > +#define arch_atomic_op_acquire(op, args...)				\
> > +({									\
> > +	typeof(op##_relaxed(args)) __ret  =3D op##_relaxed(args);		\
> > +	smp_acquire_barrier__after_atomic();				\
> > +	__ret;								\
> > +})
> > +
> > +#define arch_atomic_op_release(op, args...)				\
> > +({									\
> > +	smp_lwsync();							\
> > +	op##_relaxed(args);						\
> > +})
>=20
> Urgh, so this is RCpc. We were trying to get rid of that if possible.
> Lets wait until that's settled before introducing more of it.
>=20
> lkml.kernel.org/r/20150820155604.GB24100@arm.com

OK, get it. Thanks.

So I'm not going to introduce these arch specific macros, I think what I
need to implement are just _relaxed variants and cmpxchg_acquire.

Regards,
Boqun


--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV4E6zAAoJEEl56MO1B/q4xZAH/j/Sd7KsfIdGciWCLnoslmpt
vKQknmN6PoIrAkS4aQqCcG6pXdZB3MNU9IuNRNaziFw/3PrNUzBoGNG+Vr0SRgfd
teJVrIN0gp23f9+Hise0HRd2aZEJJiHEmSDgeiOZxVZXYLy4AfFXw5KCVRXSQYna
Cd/BULOyNp0g+cYGgouRl2ycle6qZZRoayjiLG793EbqoLJjkC0gK/nwaHOHCcJm
51+DKsC+Zh+QgwUKCQ8g2TSUwCMlYNhqSgF54noJ/0eOsMtTYwFVqIm+cDpKXp0E
fGLZubDXU5lMiyk7J/thhCYXXUQ/cRPcUfAK62AEnmR03SV+glm2GKV6B+cphRg=
=0K5I
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
