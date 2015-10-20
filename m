Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x233.google.com (mail-io0-x233.google.com
 [IPv6:2607:f8b0:4001:c06::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DFDEA1A0725
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 18:35:46 +1100 (AEDT)
Received: by iodv82 with SMTP id v82so12911677iod.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 00:35:44 -0700 (PDT)
Date: Tue, 20 Oct 2015 15:35:23 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151020073523.GC17714@fixme-laptop.cn.ibm.com>
References: <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008214439.GE3910@linux.vnet.ibm.com>
 <20151009083138.GU3816@twins.programming.kicks-ass.net>
 <20151009094039.GD26278@arm.com>
 <20151019011718.GB924@fixme-laptop.cn.ibm.com>
 <20151019102324.GO3816@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
In-Reply-To: <20151019102324.GO3816@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2015 at 12:23:24PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 19, 2015 at 09:17:18AM +0800, Boqun Feng wrote:
> > This is confusing me right now. ;-)
> >=20
> > Let's use a simple example for only one primitive, as I understand it,
> > if we say a primitive A is "fully ordered", we actually mean:
> >=20
> > 1.	The memory operations preceding(in program order) A can't be
> > 	reordered after the memory operations following(in PO) A.
> >=20
> > and
> >=20
> > 2.	The memory operation(s) in A can't be reordered before the
> > 	memory operations preceding(in PO) A and after the memory
> > 	operations following(in PO) A.
> >=20
> > If we say A is a "full barrier", we actually means:
> >=20
> > 1.	The memory operations preceding(in program order) A can't be
> > 	reordered after the memory operations following(in PO) A.
> >=20
> > and
> >=20
> > 2.	The memory ordering guarantee in #1 is visible globally.
> >=20
> > Is that correct? Or "full barrier" is more strong than I understand,
> > i.e. there is a third property of "full barrier":
> >=20
> > 3.	The memory operation(s) in A can't be reordered before the
> > 	memory operations preceding(in PO) A and after the memory
> > 	operations following(in PO) A.
> >=20
> > IOW, is "full barrier" a more strong version of "fully ordered" or not?
>=20
> Yes, that was how I used it.
>=20
> Now of course; the big question is do we want to promote this usage or
> come up with a different set of words describing this stuff.
>=20
> I think separating the ordering from the transitivity is useful, for we
> can then talk about and specify them independently.
>=20

Great idea!=20

> That is, we can say:
>=20
> 	LOAD-ACQUIRE: orders LOAD->{LOAD,STORE}
> 	              weak transitivity (RCpc)
>=20
> 	MB: orders {LOAD,STORE}->{LOAD,STORE} (fully ordered)
> 	    strong transitivity (RCsc)
>=20

It will be helpful if we have this kind of description for each
primitive mentioned in memory-barriers.txt, which, IMO, is better than
the description like the following:

"""
Any atomic operation that modifies some state in memory and returns informa=
tion
about the state (old or new) implies an SMP-conditional general memory barr=
ier
(smp_mb()) on each side of the actual operation (with the exception of
"""

I'm assuming that the arrow "->" stands for the program order, and word
"orders" means that a primitive guarantees some program order becomes
the memory operation order, so that the description above can be
rewritten as:

value-returning atomics:
	orders {LOAD,STORE}->RmW(atomic operation)->{LOAD,STORE}
	strong transitivity
=09
much simpler and clearer for discussion and reasoning

Regards,
Boqun

> etc..
>=20
> Also, in the above I used weak and strong transitivity, but that too is
> of course up for grabs.

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWJe63AAoJEEl56MO1B/q4IXMIALFiMMtTYpSRYHPMx1/zBJxJ
3AtwxeRMDfXgWCI6Y8IvrWyOjJq12pLn3YnZKPmefFh86y0NaIyUJ3xfX6DPCxDO
oU7KqWuhnAKFkafAxxXsVM8bIIN8DIrp3eMCn/zOk5hLcgiNVTnA9Wl47uKHivps
p9mcI092cPayTcehgzegDCkXdjHAQCdMdugGlZpQ9MNLjnJ6+dFSU43UuHUKYjrA
UQfNQ+PvNuIce2rk2OWNg0iqil3ap+dRqnmZcTb1DLkt1xS131NH4EeYS63DUunG
meUwDFoDBdvHPzHAwtSRmfpMa8clA/7yh52Xn2iIps+LA3bnkfnZ71wE9ZqMIws=
=fIvL
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
