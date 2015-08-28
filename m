Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x22c.google.com (mail-io0-x22c.google.com
 [IPv6:2607:f8b0:4001:c06::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 102121A0541
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2015 02:59:19 +1000 (AEST)
Received: by iofe124 with SMTP id e124so34223142iof.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 09:59:17 -0700 (PDT)
Date: Sat, 29 Aug 2015 00:59:04 +0800
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
Message-ID: <20150828165904.GA26894@fixme-laptop.cn.ibm.com>
References: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
 <1440730099-29133-4-git-send-email-boqun.feng@gmail.com>
 <20150828104854.GB16853@twins.programming.kicks-ass.net>
 <20150828120614.GC29325@fixme-laptop.cn.ibm.com>
 <20150828141602.GA924@fixme-laptop.cn.ibm.com>
 <20150828153921.GF19282@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
In-Reply-To: <20150828153921.GF19282@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2015 at 05:39:21PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 28, 2015 at 10:16:02PM +0800, Boqun Feng wrote:
<snip>
> >=20
> > Ah.. just read through the thread you mentioned, I might misunderstand
> > you, probably because I didn't understand RCpc well..
> >=20
> > You are saying that in a RELEASE we -might- switch from smp_lwsync() to
> > smp_mb() semantically, right? I guess this means we -might- switch from
> > RCpc to RCsc, right?
> >=20
> > If so, I think I'd better to wait until we have a conclusion for this.
>=20
> Yes, the difference between RCpc and RCsc is in the meaning of RELEASE +
> ACQUIRE. With RCsc that implies a full memory barrier, with RCpc it does
> not.
>=20
> Currently PowerPC is the only arch that (can, and) does RCpc and gives a
> weaker RELEASE + ACQUIRE. Only the CPU who did the ACQUIRE is guaranteed
> to see the stores of the CPU which did the RELEASE in order.
>=20
> As it stands, RCU is the only _known_ codebase where this matters, but
> we did in fact write code for a fair number of years 'assuming' RELEASE
> + ACQUIRE was a full barrier, so who knows what else is out there.
>=20
>=20
> RCsc - release consistency sequential consistency
> RCpc - release consistency processor consistency
>=20
> https://en.wikipedia.org/wiki/Processor_consistency (where they have
> s/sequential/causal/)

Thank you for your detailed explanation! Much clear now ;-)

Regards,
Boqun

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV4JNUAAoJEEl56MO1B/q4GOgH/Aqq5geM/6nwkAnQW7BcOgbI
xG1eiKT/0np7Wav0oe3RvezvUlB6DChubzgRdRdDuckGbq0xxpHJgGb1C8jcy9tI
D7TW5xZOZEqGxYhOAmdVyrVWha3IgzQvfYEf50gk+cOw8kDEC+EFXQOJgPIvr3up
hjwI1uAxLXro58hn/jaPQE1+klOweqbpoWux+nGWQrrHoNE9jw7I+fadvzQgsVkB
pt5BXVgZT7Mo3MiuwLeeG8l9bYC1gHxZQ5E2bxurcdtGff7EsN76Krofix9ofuCc
LzhnUD5E3GWGueoo+r2zdTIApYRWaI2ZhYP/INn+8WbFI+7oMe0udh/IekJ/itg=
=r2Ox
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
