Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BBBE1A0697
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 01:49:51 +1100 (AEDT)
Received: by pabrc13 with SMTP id rc13so90030777pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 07:49:49 -0700 (PDT)
Date: Thu, 15 Oct 2015 22:49:23 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151015144923.GE14305@fixme-laptop.cn.ibm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
In-Reply-To: <20151014201916.GB3910@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2015 at 01:19:17PM -0700, Paul E. McKenney wrote:
> On Wed, Oct 14, 2015 at 11:55:56PM +0800, Boqun Feng wrote:
> > According to memory-barriers.txt, xchg, cmpxchg and their atomic{,64}_
> > versions all need to imply a full barrier, however they are now just
> > RELEASE+ACQUIRE, which is not a full barrier.
> >=20
> > So replace PPC_RELEASE_BARRIER and PPC_ACQUIRE_BARRIER with
> > PPC_ATOMIC_ENTRY_BARRIER and PPC_ATOMIC_EXIT_BARRIER in
> > __{cmp,}xchg_{u32,u64} respectively to guarantee a full barrier
> > semantics of atomic{,64}_{cmp,}xchg() and {cmp,}xchg().
> >=20
> > This patch is a complement of commit b97021f85517 ("powerpc: Fix
> > atomic_xxx_return barrier semantics").
> >=20
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: <stable@vger.kernel.org> # 3.4+
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  arch/powerpc/include/asm/cmpxchg.h | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/=
asm/cmpxchg.h
> > index ad6263c..d1a8d93 100644
> > --- a/arch/powerpc/include/asm/cmpxchg.h
> > +++ b/arch/powerpc/include/asm/cmpxchg.h
> > @@ -18,12 +18,12 @@ __xchg_u32(volatile void *p, unsigned long val)
> >  	unsigned long prev;
> >=20
> >  	__asm__ __volatile__(
> > -	PPC_RELEASE_BARRIER
> > +	PPC_ATOMIC_ENTRY_BARRIER
>=20
> This looks to be the lwsync instruction.
>=20
> >  "1:	lwarx	%0,0,%2 \n"
> >  	PPC405_ERR77(0,%2)
> >  "	stwcx.	%3,0,%2 \n\
> >  	bne-	1b"
> > -	PPC_ACQUIRE_BARRIER
> > +	PPC_ATOMIC_EXIT_BARRIER
>=20
> And this looks to be the sync instruction.
>=20
> >  	: "=3D&r" (prev), "+m" (*(volatile unsigned int *)p)
> >  	: "r" (p), "r" (val)
> >  	: "cc", "memory");
>=20
> Hmmm...
>=20
> Suppose we have something like the following, where "a" and "x" are both
> initially zero:
>=20
> 	CPU 0				CPU 1
> 	-----				-----
>=20
> 	WRITE_ONCE(x, 1);		WRITE_ONCE(a, 2);
> 	r3 =3D xchg(&a, 1);		smp_mb();
> 					r3 =3D READ_ONCE(x);
>=20
> If xchg() is fully ordered, we should never observe both CPUs'
> r3 values being zero, correct?
>=20
> And wouldn't this be represented by the following litmus test?
>=20
> 	PPC SB+lwsync-RMW2-lwsync+st-sync-leading
> 	""
> 	{
> 	0:r1=3D1; 0:r2=3Dx; 0:r3=3D3; 0:r10=3D0 ; 0:r11=3D0; 0:r12=3Da;
> 	1:r1=3D2; 1:r2=3Dx; 1:r3=3D3; 1:r10=3D0 ; 1:r11=3D0; 1:r12=3Da;
> 	}
> 	 P0                 | P1                 ;
> 	 stw r1,0(r2)       | stw r1,0(r12)      ;
> 	 lwsync             | sync               ;
> 	 lwarx  r11,r10,r12 | lwz r3,0(r2)       ;
> 	 stwcx. r1,r10,r12  | ;
> 	 bne Fail0          | ;
> 	 mr r3,r11          | ;
> 	 Fail0:             | ;
> 	exists
> 	(0:r3=3D0 /\ a=3D2 /\ 1:r3=3D0)
>=20
> I left off P0's trailing sync because there is nothing for it to order
> against in this particular litmus test.  I tried adding it and verified
> that it has no effect.
>=20
> Am I missing something here?  If not, it seems to me that you need
> the leading lwsync to instead be a sync.
>=20

If so, I will define PPC_ATOMIC_ENTRY_BARRIER as "sync" in the next
version of this patch, any concern?

Of course, I will wait to do that until we all understand this is
nececarry and agree to make the change.

> Of course, if I am not missing something, then this applies also to the
> value-returning RMW atomic operations that you pulled this pattern from.

For the value-returning RMW atomics, if the leading barrier is
necessarily to be "sync", I will just remove my __atomic_op_fence() in
patch 4, but I will remain patch 3 unchanged for the consistency of
__atomic_op_*() macros' definitions. Peter and Will, do that works for
you both?

Regards,
Boqun

> If so, it would seem that I didn't think through all the possibilities
> back when PPC_ATOMIC_EXIT_BARRIER moved to sync...  In fact, I believe
> that I worried about the RMW atomic operation acting as a barrier,
> but not as the load/store itself.  :-/
>=20
> 							Thanx, Paul
>=20

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWH7ztAAoJEEl56MO1B/q48QYH/3iw59+ivD4FVKHFCjb5K+Ac
Dps5mbZ6gE/rM8XQgM4ytwJwQF86AP4k+buLc8HgZEea092DTSohzdjfzZSSDwhg
+LgKAT25s06FjeOp76pJrpsI8eNnsxAwM+XZ+lnJOPXn2PL/wXYA7Lg9ySKMTtvQ
L5YODzMGQWh0WJ/HrDgVsjctozXK5MRqCMHpKhFywekGBWfL3J3lNsVsqbjJMJXE
8Jkrz5MQWT+oe0b3zhOGcz3FgX9ZWEbcnA5H7jHbi5fR1/s2txKZeN4TJrZ8YGEy
rhbb4VnfcbYpk4YFM9cGXeC5zOfPhcZ0x9N7gF/pV4LXFCcSAsfgWwaqZi6SzQk=
=dixC
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
