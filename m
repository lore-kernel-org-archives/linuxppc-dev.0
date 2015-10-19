Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C5DA1A065E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 12:17:41 +1100 (AEDT)
Received: by iodz80 with SMTP id z80so15843611iod.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2015 18:17:39 -0700 (PDT)
Date: Mon, 19 Oct 2015 09:17:18 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151019011718.GB924@fixme-laptop.cn.ibm.com>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008214439.GE3910@linux.vnet.ibm.com>
 <20151009083138.GU3816@twins.programming.kicks-ass.net>
 <20151009094039.GD26278@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
In-Reply-To: <20151009094039.GD26278@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2015 at 10:40:39AM +0100, Will Deacon wrote:
> On Fri, Oct 09, 2015 at 10:31:38AM +0200, Peter Zijlstra wrote:
[snip]
> >=20
> > So lots of little confusions added up to complete fail :-{
> >=20
> > Mostly I think it was the UNLOCK x + LOCK x are fully ordered (where I
> > forgot: but not against uninvolved CPUs) and RELEASE/ACQUIRE are
> > transitive (where I forgot: RELEASE/ACQUIRE _chains_ are transitive, but
> > again not against uninvolved CPUs).
> >=20
> > Which leads me to think I would like to suggest alternative rules for
> > RELEASE/ACQUIRE (to replace those Will suggested; as I think those are
> > partly responsible for my confusion).
>=20
> Yeah, sorry. I originally used the phrase "fully ordered" but changed it
> to "full barrier", which has stronger transitivity (newly understood
> definition) requirements that I didn't intend.
>=20
> RELEASE -> ACQUIRE should be used for message passing between two CPUs
> and not have ordering effects on other observers unless they're part of
> the RELEASE -> ACQUIRE chain.
>=20
> >  - RELEASE -> ACQUIRE is fully ordered (but not a full barrier) when
> >    they operate on the same variable and the ACQUIRE reads from the
> >    RELEASE. Notable, RELEASE/ACQUIRE are RCpc and lack transitivity.
>=20
> Are we explicit about the difference between "fully ordered" and "full
> barrier" somewhere else, because this looks like it will confuse people.
>=20

This is confusing me right now. ;-)

Let's use a simple example for only one primitive, as I understand it,
if we say a primitive A is "fully ordered", we actually mean:

1.	The memory operations preceding(in program order) A can't be
	reordered after the memory operations following(in PO) A.

and

2.	The memory operation(s) in A can't be reordered before the
	memory operations preceding(in PO) A and after the memory
	operations following(in PO) A.

If we say A is a "full barrier", we actually means:

1.	The memory operations preceding(in program order) A can't be
	reordered after the memory operations following(in PO) A.

and

2.	The memory ordering guarantee in #1 is visible globally.

Is that correct? Or "full barrier" is more strong than I understand,
i.e. there is a third property of "full barrier":

3.	The memory operation(s) in A can't be reordered before the
	memory operations preceding(in PO) A and after the memory
	operations following(in PO) A.

IOW, is "full barrier" a more strong version of "fully ordered" or not?

Regards,
Boqun

> >  - RELEASE -> ACQUIRE can be upgraded to a full barrier (including
> >    transitivity) using smp_mb__release_acquire(), either before RELEASE
> >    or after ACQUIRE (but consistently [*]).
>=20
> Hmm, but we don't actually need this for RELEASE -> ACQUIRE, afaict. This
> is just needed for UNLOCK -> LOCK, and is exactly what RCU is currently
> using (for PPC only).
>=20
> Stepping back a second, I believe that there are three cases:
>=20
>=20
>  RELEASE X -> ACQUIRE Y (same CPU)
>    * Needs a barrier on TSO architectures for full ordering
>=20
>  UNLOCK X -> LOCK Y (same CPU)
>    * Needs a barrier on PPC for full ordering
>=20
>  RELEASE X -> ACQUIRE X (different CPUs)
>  UNLOCK X -> ACQUIRE X (different CPUs)
>    * Fully ordered everywhere...
>    * ... but needs a barrier on PPC to become a full barrier
>=20
>=20

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWJESaAAoJEEl56MO1B/q4OI0H/3FnMOzqUgNp4XTZkmZTJm7Y
+ioXFNtiZBjqs1tigV7PRXGMgbvUfttapKzh9gd0GSppLzKj4FB0tePKugQawERR
0QVUpDt8HdLzL5qSMKVZwC5yMPUprz5TysbwGFuk+gVZPwOpp1pjTHETSHD2oKfJ
wRWTNq5JSytUaJDqxyCzNW6HJNzYExXTjCRVM97wZr3zh1NXlZ0nLIxGtZBe3lFZ
tTMx734LkzwRcLOyTWOeLiokdy3yZZju46RRMt2qZzGERgqe5R/aqf0aVSXSl4ML
/ChHtJqCIdTP4IisLqQdDbMIxUtF+Zl2lDDVxJcijZ401gzsq7l5p6HQFDf319E=
=4e2l
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
