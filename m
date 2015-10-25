Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95ED41A03D1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 00:14:54 +1100 (AEDT)
Received: by padfb7 with SMTP id fb7so18325471pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Oct 2015 06:14:52 -0700 (PDT)
Date: Sun, 25 Oct 2015 21:14:22 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151025131422.GB8545@fixme-laptop.cn.ibm.com>
References: <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
 <20151020092147.GX17308@twins.programming.kicks-ass.net>
 <20151020212835.GH5105@linux.vnet.ibm.com>
 <20151021084503.GE17714@fixme-laptop.cn.ibm.com>
 <20151021193523.GT5105@linux.vnet.ibm.com>
 <20151021194825.GH2508@worktop.programming.kicks-ass.net>
 <20151022120716.GA1481@fixme-laptop.cn.ibm.com>
 <20151024102627.GH17308@twins.programming.kicks-ass.net>
 <20151024115356.GA8545@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
In-Reply-To: <20151024115356.GA8545@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2015 at 07:53:56PM +0800, Boqun Feng wrote:
> On Sat, Oct 24, 2015 at 12:26:27PM +0200, Peter Zijlstra wrote:
> >=20
> > Right, futexes are a pain; and I think we all agreed we didn't want to
> > go rely on implementation details unless we absolutely _have_ to.
> >=20
>=20
> Agreed.
>=20
> Besides, after I have read why futex_wake_op(the caller of
> futex_atomic_op_inuser()) is introduced, I think your worries are quite
> reasonable. I thought the futex_atomic_op_inuser() only operated on
> futex related variables, but it turns out it can actually operate any
> userspace variable if userspace code likes, therefore we don't have
> control of all memory ordering guarantee of the variable. So if PPC
> doesn't provide a full barrier at user<->kernel boundries, we should
> make futex_atomic_op_inuser() fully ordered.
>=20
>=20
> Still looking into futex_atomic_cmpxchg_inatomic() ...
>=20

I thought that the futex related variables (userspace variables that the
first parameter of futex system call points to) are only accessed by
futex system call in userspace, but it turns out not the fact. So
memordy ordering guarantees of these variables are also out of the
control of kernel. Therefore we should make
futex_atomic_cmpxchg_inatomic() fully ordered, of course, if PPC doesn't
provide a full barrier at user<->kernel boundries..

Regards
Boqun


--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWLNWpAAoJEEl56MO1B/q4UMYIAJOrJzcA78NZqVbJknFP9V8U
yWheUhXRN1NyPdMrcTlsh4KCFDJ7ifOeId5ttSDzb8bP+6dYJgSmu2oqC9rd8mK5
pVRh8Mus6PsTuAZDj4crI1B6gHJG6aXW430VaaU5YNUhr5ONA/o0pdUiZVd/eqUZ
cbeAzmtyr0czn1SnZ9Y8lPbgZVUnbsRIVNe/3cnTA3kqo069QEEZpHbbPggZ44+N
ppPQf8tVYhneC9xkRKVhzT7zETtsb/3iJD1Y87QxrcA+tqi4A3msGarsjB2ik3qp
Sw3BO1tk1SziF1cd8F7cTP1ohhMyBwWPXxHjn7bvEPWamcRnQQBIiX9ZQ1ytipc=
=/na/
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
