Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x22a.google.com (mail-ob0-x22a.google.com
 [IPv6:2607:f8b0:4003:c01::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27B4D1A03DB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 14:07:21 +1100 (AEDT)
Received: by obcqt19 with SMTP id qt19so159478708obc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 20:07:18 -0700 (PDT)
Date: Tue, 27 Oct 2015 11:06:52 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Peter Zijlstra <peterz@infradead.org>,
 Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
Subject: Re: [RESEND, tip/locking/core, v5, 1/6] powerpc: atomic: Make
 _return atomics and *{cmp}xchg fully ordered
Message-ID: <20151027030652.GB26372@fixme-laptop.cn.ibm.com>
References: <1445854536-22645-1-git-send-email-boqun.feng@gmail.com>
 <20151027023347.6178D140E31@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
In-Reply-To: <20151027023347.6178D140E31@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2015 at 01:33:47PM +1100, Michael Ellerman wrote:
> On Mon, 2015-26-10 at 10:15:36 UTC, Boqun Feng wrote:
> > This patch fixes two problems to make value-returning atomics and
> > {cmp}xchg fully ordered on PPC.
>=20
> Hi Boqun,
>=20
> Can you please split this into two patches. One that does the cmpxchg cha=
nge
> and one that changes PPC_ATOMIC_ENTRY_BARRIER.
>=20

OK, make sense ;-)

> Also given how pervasive this change is I'd like to take it via the power=
pc
> next tree, so can you please send this patch (which will be two after you=
 split
> it) as powerpc patches. And the rest can go via tip?
>=20

One problem is that patch 5 will remove __xchg_u32 and __xchg_64
entirely, which are modified in this patch(patch 1), so there will be
some conflicts if two branch get merged, I think.

Alternative way is that all this series go to powerpc next tree as most
of the dependent patches are already there. I just need to remove
inc/dec related code and resend them when appropriate. Besides, I can
pull patch 2 out and send it as a tip patch because it's general code
and no one depends on this in this series.

To summerize:

patch 1(split to two), 3, 4(remove inc/dec implementation), 5, 6 sent as
powerpc patches for powerpc next, patch 2(unmodified) sent as tip patch
for locking/core.

Peter and Michael, this works for you both?

Regards,

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWLupJAAoJEEl56MO1B/q4g14IAJvo1BWopEVRbpgKTzlDSXNL
tPj4Xpe7663v0IIMBnKPhqRKH4dfGda9g6EC/gp2frSr3xZN0wp19abJiuxIO6S0
Z7+pRCmVlx2rQ25cfb29jgD2M4rgPZpSfKc0XoU2egFFblh3K8L1FDSkA490bXhL
/5deB7dZ6vVX2aAjBtJYOaiTTlmniG4V1Wqrh94Ty6z7+qZwt53G52RRms3O/l7u
H3dGPxA3FeFy0mVGqD0+kKh63CnNUUrEvB5RWcoDHrMvlyHPFVhlBkOQryi7YVNd
2DP053fHKivKCv6nuNR85HECwbTmbo0jUCXF4aKRJw1d+nxYZEHv9crs6Qcvp48=
=jVtf
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
