Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x22e.google.com (mail-ig0-x22e.google.com
 [IPv6:2607:f8b0:4001:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 658161A0541
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2015 00:16:17 +1000 (AEST)
Received: by igbuu8 with SMTP id uu8so8368264igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 07:16:15 -0700 (PDT)
Date: Fri, 28 Aug 2015 22:16:02 +0800
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
Message-ID: <20150828141602.GA924@fixme-laptop.cn.ibm.com>
References: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
 <1440730099-29133-4-git-send-email-boqun.feng@gmail.com>
 <20150828104854.GB16853@twins.programming.kicks-ass.net>
 <20150828120614.GC29325@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
In-Reply-To: <20150828120614.GC29325@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2015 at 08:06:14PM +0800, Boqun Feng wrote:
> Hi Peter,
>=20
> On Fri, Aug 28, 2015 at 12:48:54PM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 28, 2015 at 10:48:17AM +0800, Boqun Feng wrote:
> > > +/*
> > > + * Since {add,sub}_return_relaxed and xchg_relaxed are implemented w=
ith
> > > + * a "bne-" instruction at the end, so an isync is enough as a acqui=
re barrier
> > > + * on the platform without lwsync.
> > > + */
> > > +#ifdef CONFIG_SMP
> > > +#define smp_acquire_barrier__after_atomic() \
> > > +	__asm__ __volatile__(PPC_ACQUIRE_BARRIER : : : "memory")
> > > +#else
> > > +#define smp_acquire_barrier__after_atomic() barrier()
> > > +#endif
> > > +#define arch_atomic_op_acquire(op, args...)				\
> > > +({									\
> > > +	typeof(op##_relaxed(args)) __ret  =3D op##_relaxed(args);		\
> > > +	smp_acquire_barrier__after_atomic();				\
> > > +	__ret;								\
> > > +})
> > > +
> > > +#define arch_atomic_op_release(op, args...)				\
> > > +({									\
> > > +	smp_lwsync();							\
> > > +	op##_relaxed(args);						\
> > > +})
> >=20
> > Urgh, so this is RCpc. We were trying to get rid of that if possible.
> > Lets wait until that's settled before introducing more of it.
> >=20
> > lkml.kernel.org/r/20150820155604.GB24100@arm.com
>=20
> OK, get it. Thanks.
>=20
> So I'm not going to introduce these arch specific macros, I think what I
> need to implement are just _relaxed variants and cmpxchg_acquire.

Ah.. just read through the thread you mentioned, I might misunderstand
you, probably because I didn't understand RCpc well..

You are saying that in a RELEASE we -might- switch from smp_lwsync() to
smp_mb() semantically, right? I guess this means we -might- switch from
RCpc to RCsc, right?

If so, I think I'd better to wait until we have a conclusion for this.

Thank you for your comments!

Regards,
Boqun


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV4G0aAAoJEEl56MO1B/q4z8gH+wf+2DtwQucFd4TakApcbvS4
JdQEzM+oL61R0Wz68qd2oOHnKbeBHKKfLfcifVStG/31LA4t6y89/+SJsUKhvwIc
TQOjIOSXD1m8TnP7aiaOUKyfC8joYB9BPKWUZl4u9sA3g1ln0gTdwEbefE2/BJZt
TlDTNu3DPplUEdbHgKOIzYHAGgSS84QQ1lFDMuSqj3gbm8zgjNP5JyQsw8uXCpR1
LQJCu5hzmPuhT8hd/SO/x9dJ4UZaIm+cAmwBG//j13c6CmtWMtewaYehrYvtOQkx
DnpS+fyC6OmQIvBtcUDCaBE8WzWsgC/GlRrkcuWxjBHBeZbEHpW0l+hynRUnQt8=
=uGtb
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
