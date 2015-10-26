Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F27C1A040E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 19:58:38 +1100 (AEDT)
Received: by pacik9 with SMTP id ik9so20730627pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 01:58:36 -0700 (PDT)
Date: Mon, 26 Oct 2015 16:58:10 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151026085810.GC13641@fixme-laptop.cn.ibm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
 <20151020092147.GX17308@twins.programming.kicks-ass.net>
 <20151020212835.GH5105@linux.vnet.ibm.com>
 <20151021081833.GB2881@worktop.programming.kicks-ass.net>
 <20151026032021.GA5420@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
In-Reply-To: <20151026032021.GA5420@iris.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2015 at 02:20:21PM +1100, Paul Mackerras wrote:
> On Wed, Oct 21, 2015 at 10:18:33AM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 20, 2015 at 02:28:35PM -0700, Paul E. McKenney wrote:
> > > I am not seeing a sync there, but I really have to defer to the
> > > maintainers on this one.  I could easily have missed one.
> >=20
> > So x86 implies a full barrier for everything that changes the CPL; and
> > some form of implied ordering seems a must if you change the privilege
> > level unless you tag every single load/store with the priv level at that
> > time, which seems the more expensive option.
> >=20
> > So I suspect the typical implementation will flush all load/stores,
> > change the effective priv level and continue.
> >=20
> > This can of course be implemented at a pure per CPU ordering (RCpc),
> > which would be in line with the rest of Power, in which case you do
> > indeed need an explicit sync to make it visible to other CPUs.
>=20
> Right - interrupts and returns from interrupt are context
> synchronizing operations, which means they wait until all outstanding
> instructions have got to the point where they have reported any
> exceptions they're going to report, which means in turn that loads and
> stores have completed address translation.  But all of that doesn't
> imply anything about the visibility of the loads and stores.
>=20
> There is a full barrier in the context switch path, but not in the
> system call entry/exit path.
>=20

Thank you, Paul. That's much clear now ;-)

Regards,
Boqun

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWLeseAAoJEEl56MO1B/q4D10H/RE1XzJo877CPu4Gnuug0rCk
1+VjkOMfht55Ox+W6AWBADkPn+7zCEU2kynZ4dyvrpBWj7F771sbJ6jzQ2B+MuRS
SlhJhuiLVwG8A4Rng+oKOVKRDH6zvbM48Ffgg1WgNgBHB1Smz+1SwBsxva/dX/RG
HeAyIFNpCVlcVEdhn44zJtsk5xDY+hr/us2KNjrvmXlECU1+G7v6sAK8HWFiYuaX
fKMg9/TCHNF2xlgQcDGJ/Bml1tgkczJhjkDDZ0RhftcmUsiEolDGWEB3dIQC1VB0
LM+rPWXYpIPiaBI1tIYi3e1/cmljO6fzdlImuSQpBKnohPthttBUg+xFqyULRro=
=Knjc
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
