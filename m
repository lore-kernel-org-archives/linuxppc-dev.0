Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x231.google.com (mail-ig0-x231.google.com
 [IPv6:2607:f8b0:4001:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A7A31A060A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 12:00:52 +1100 (AEDT)
Received: by igsu6 with SMTP id u6so6132963igs.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 18:00:50 -0700 (PDT)
Date: Wed, 14 Oct 2015 09:00:29 +0800
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
Message-ID: <20151014010029.GB14305@fixme-laptop.cn.ibm.com>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444659246-24769-5-git-send-email-boqun.feng@gmail.com>
 <20151013132132.GH21550@arm.com>
 <20151013133554.GA23991@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
In-Reply-To: <20151013133554.GA23991@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2015 at 09:35:54PM +0800, Boqun Feng wrote:
> On Tue, Oct 13, 2015 at 02:21:32PM +0100, Will Deacon wrote:
> > On Mon, Oct 12, 2015 at 10:14:04PM +0800, Boqun Feng wrote:
> [snip]
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
> >=20
> > I'm not keen on this barrier, as it sounds like it's part of the kernel
> > memory model, as opposed to an implementation detail on PowerPC (and
> > we've already got enough of that in the generic code ;).
> >=20
>=20
> Indeed, but we still have smp_lwsync() ;-)
>=20
> > Can you name it something different please (and maybe #undef it when
> > you're done)?
> >=20
>=20
> I've considered #undef it after used, but now I think open code this
> into __atomic_op_acquire() of PPC is a better idea?
>=20
>=20
> #define __atomic_op_acquire(op, args...)				\
> ({									\
> 	typeof(op##_relaxed(args)) __ret  =3D op##_relaxed(args);		\
> 	__asm__ __volatile__(PPC_ACQUIRE_BARRIER : : : "memory");	\

Should be:
	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory");

> 	__ret;								\
> })
>=20
> PPC_ACQUIRE_BARRIER will be empty if !SMP, so that will become a pure
> compiler barrier and just what we need.
>=20
> Regards,
> Boqun

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWHakpAAoJEEl56MO1B/q4V84H/ivZAy1Ro3m2BdDvDLLbOzOl
gEJrDi/RB7EpKAJFv+/yRg8+gBZxpf3/BXHPrtSrS/XOVhFLZph5wzoLFVHogu8J
TYJw31TgIoggROtNlO9Der5NOX+pHbcCzZqgiNcGgg7voX0WO7wcdOuaJrjfiTdF
dS8j8xIIox04a3UGUhFLp2+3pHgNRcOGrkE1S91bVaSh5ZQ2KLZJwenAy/I02TJy
L1tDaQ32EOyi5jAb+Phl7Ebf/TbHHFU4vrwCxFj+xYVWR1vn2VDLoPjql0zybN37
TPcdpVJ7RH8HYjub158ak8LMYZA2Ov7rzrKADxc/1OXT756O87Ik7O60LRXxWZA=
=mcRu
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
