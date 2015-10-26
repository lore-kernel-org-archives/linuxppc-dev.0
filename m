Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B85881A0900
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 13:07:30 +1100 (AEDT)
Received: by pagq8 with SMTP id q8so18813545pag.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Oct 2015 19:07:27 -0700 (PDT)
Date: Mon, 26 Oct 2015 10:06:58 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151026020658.GA13641@fixme-laptop.cn.ibm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
 <20151020092147.GX17308@twins.programming.kicks-ass.net>
 <20151020212835.GH5105@linux.vnet.ibm.com>
 <20151021081833.GB2881@worktop.programming.kicks-ass.net>
 <20151021193638.GU5105@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
In-Reply-To: <20151021193638.GU5105@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2015 at 12:36:38PM -0700, Paul E. McKenney wrote:
> On Wed, Oct 21, 2015 at 10:18:33AM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 20, 2015 at 02:28:35PM -0700, Paul E. McKenney wrote:
> > > I am not seeing a sync there, but I really have to defer to the
> > > maintainers on this one.  I could easily have missed one.
> >=20
> > So x86 implies a full barrier for everything that changes the CPL; and
> > some form of implied ordering seems a must if you change the privilege
> > level unless you tag every single load/store with the priv level at that
> > time, which seems the more expensive option.
>=20
> And it is entirely possible that there is some similar operation
> somewhere in the powerpc entry/exit code.  I would not trust myself
> to recognize it, though.
>=20
> > So I suspect the typical implementation will flush all load/stores,
> > change the effective priv level and continue.
> >=20
> > This can of course be implemented at a pure per CPU ordering (RCpc),
> > which would be in line with the rest of Power, in which case you do
> > indeed need an explicit sync to make it visible to other CPUs.
> >=20
> > But yes, if Michael or Ben could clarify this it would be good.
> >=20

Michael and Ben, ping for this, thank you ;-)

Regards,
Boqun

> > Back then I talked to Ralf about what MIPS says on this, and MIPS arch
> > spec is entirely quiet on this, it allows implementations full freedom
> > IIRC.
>=20
> :-) ;-) ;-)
>=20
> > </ramble>
>=20
> 							Thanx, Paul
>=20

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWLYq+AAoJEEl56MO1B/q4q3QH/0MCWThU3Mibr1t7KNdlQLJ6
TfLCHBHPl6+FVXJ0KtQc4wwFqOP+l6ZOVfhXmDTwNNNeW7V19wDzaBOui9VZiUKn
8ZxvFWAm6XOI8yTf0TpddZnyIIlIqolOL+QT5vtVf0Tz30vo8VtdJktG90ZxhfRV
FJWbqfqpJ8W4DIsuVSL4FL6fETuKPp7tFA1jdtqSeZ3CK2SgxuObH4Q1aTxVfGhY
DMNXfaNEgMFzy+LGInL7b5RN1ruS+Pb9dx/lSqRMKiOQGP2zX1v5McI4JSyGI5eF
IT6oE+qVZjiC9UjCM49MrRD7XeI8jJcT1z/iavdYS6HNgZrs9wbm2zr9hIy3kgw=
=eXFk
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
