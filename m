Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x233.google.com (mail-ig0-x233.google.com
 [IPv6:2607:f8b0:4001:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E3051A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 21:50:50 +1000 (AEST)
Received: by igyq3 with SMTP id q3so10711038igy.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 04:50:48 -0700 (PDT)
Date: Fri, 28 Aug 2015 19:50:31 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC 2/5] atomics: introduce
 arch_atomic_op_{acquire,release,fence} helpers
Message-ID: <20150828115031.GB29325@fixme-laptop.cn.ibm.com>
References: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
 <1440730099-29133-3-git-send-email-boqun.feng@gmail.com>
 <20150828113614.GC16853@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
In-Reply-To: <20150828113614.GC16853@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Fri, Aug 28, 2015 at 01:36:14PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 28, 2015 at 10:48:16AM +0800, Boqun Feng wrote:
> > Some architectures may have their special barriers for acquire, release
> > and fence semantics, general memory barriers(smp_mb__*_atomic()) in
> > __atomic_op_*() may be too strong, so arch_atomic_op_*() helpers are
> > introduced for architectures to provide their own version helpers to
> > build different variants based on _relaxed variants.
> >=20
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  include/linux/atomic.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >=20
> > diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> > index 00a5763..622255b 100644
> > --- a/include/linux/atomic.h
> > +++ b/include/linux/atomic.h
> > @@ -34,20 +34,33 @@
> >   * The idea here is to build acquire/release variants by adding explic=
it
> >   * barriers on top of the relaxed variant. In the case where the relax=
ed
> >   * variant is already fully ordered, no additional barriers are needed.
> > + *
> > + * Besides, if an arch has a special barrier for acquire/release, it c=
ould
> > + * implement its own arch_atomic_op_* and use the same framework for b=
uilding
> > + * variants
> >   */
> > +#ifndef arch_atomic_op_acquire
> >  #define __atomic_op_acquire(op, args...)				\
> >  ({									\
> >  	typeof(op##_relaxed(args)) __ret  =3D op##_relaxed(args);		\
> >  	smp_mb__after_atomic();						\
> >  	__ret;								\
> >  })
> > +#else
> > +#define __atomic_op_acquire arch_atomic_op_acquire
> > +#endif
>=20
> Not really a fan of this, its not consistent with the existing #ifndef
> guard style.

You suggestion is that I should:

#ifndef __atomic_op_acquire=20
#define __atomic_op_acquire(op, args...)
({
	...
})
#endif

=2E.. and define powerpc specific __atomic_op_acquire in asm/atomic.h?

Regards,
Boqun

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV4EsDAAoJEEl56MO1B/q4vuAH/0iMQ3dqipl5PMwqYea5a3wo
f2CLTGoQybHpN1J7JBWtR+Dxj9GM0oFtBnbLOldCTfySAsw42nSWkOE26H+xG51t
I/UsqRWgO6zI06jHLW3Unlck37bFCoBset+XSgObI6RIo9B9d7WRO1fmBL1fuOd8
xS0YkUj2kJMdlN9nKuHoTH+5CicYe+sN9MMFYFoW3az0asgX9qy9wLar+ej/K+3N
4YSqqlyYs4u1/hLubewmqKv9GmHSD9NotlGeeKKuMpR3rscKOrY2U+rzEosIJkHU
8d06YzChFf0tL2sUOo5JBk7fTv9IGj4l+EF4Khe2N9GstrezAEGWTa8VB/VUAUQ=
=mw5k
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
