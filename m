Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x22a.google.com (mail-io0-x22a.google.com
 [IPv6:2607:f8b0:4001:c06::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30ED51A0676
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 11:52:01 +1100 (AEDT)
Received: by iofl186 with SMTP id l186so39893584iof.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 17:51:59 -0700 (PDT)
Date: Wed, 14 Oct 2015 08:51:34 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v3 1/6] powerpc: atomic: Make *xchg and *cmpxchg a
 full barrier
Message-ID: <20151014005134.GE23991@fixme-laptop.cn.ibm.com>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444660220-25559-1-git-send-email-boqun.feng@gmail.com>
 <1444781400.12197.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
In-Reply-To: <1444781400.12197.4.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2015 at 11:10:00AM +1100, Michael Ellerman wrote:
> On Mon, 2015-10-12 at 22:30 +0800, Boqun Feng wrote:
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
> > Cc: <stable@vger.kernel.org> # 3.4.y-
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  arch/powerpc/include/asm/cmpxchg.h | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> Hi Boqun,
>=20

Hello, Michael

> Thanks for fixing this. In future you should send a patch like this as a
> separate patch. I've not been paying attention to it because I assumed it=
 was

Got it. However, here is the thing, in previous version, this fix
depends on some of other patches in this patchset. So to make this fix
applied cleanly, I reorder my patchset to put this patch first, and the
result is that some of other patches in this patchset depends on
this(they need to remove code modified by this patch).

So I guess I'd better to stop Cc stable for this one, and wait until
this patchset merged and send a separate patch for -stable tree. Does
that work for you? I think this is what Peter want to suggests me to do
when he asked me about this, right, Peter?

> part of your full series and was still under discussion like the other pa=
tches.
>=20
> I don't think we've seen any crashes caused by this have we? So I guess I=
'll

No, we haven't seen any.

> put it in next to let it get some wider testing rather than sending it st=
raight
> to Linus.
>=20

Good idea, thank you ;-)

> To be clear you're doing:
>=20
> > -	PPC_RELEASE_BARRIER
> > +	PPC_ATOMIC_ENTRY_BARRIER
>=20
> Which is correct but doesn't actually change anything at the moment, beca=
use
> both macros turn into LWSYNC.
>=20
> On the other hand:
>=20
> > -	PPC_ACQUIRE_BARRIER
> > +	PPC_ATOMIC_EXIT_BARRIER
>=20
> Is changing an isync (which is then patched to lwsync on some cpus), with=
 a sync.
>=20

These macros are introduced by commit b97021f85517 ("powerpc: Fix
atomic_xxx_return barrier semantics") to fix a similar problem, so I use
them to keep code similar.

>=20
> Also I'm not clear what your stable line means:
>=20
> > Cc: <stable@vger.kernel.org> # 3.4.y-
>=20
> Do you mean 3.4 and anything after? I usually write that as 3.4+, but I'm=
 not
> sure if that's the correct syntax either.
>=20

Quote from Documentation/stable_kernel_rules.txt:

"""
Also, some patches may have kernel version prerequisites.  This can be
specified in the following format in the sign-off area:

     Cc:  <stable@vger.kernel.org> # 3.3.x-

   The tag has the meaning of:
     git cherry-pick <this commit>

   For each "-stable" tree starting with the specified version.
"""

But yes, I have seen several people use like "3.4+", I'm not sure either

Regards,
Boqun

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWHacQAAoJEEl56MO1B/q4bagH/AnkrPTzIgF2xOoPrRGsbnD8
DItdA+MTEV/01SEP/QVRudEReCuMUaoYzfukyvZlf3LaGpP3LZ4mcuj1WqqYXkjD
cNKwg3IfKtWLnF5+AYWWymT5UVy3rqDJT4/ScUa/emwjDpB7liZqSGZVhSLtRIzN
6zOwAW+X3pSl8MjEkWDRN7Oa4MKVUAo1BBaOjLO41F0avxd0G0KLViabxE+hhpIG
P96cMWmUAnIYt3ZCNvTzuvvF+QgfbNqDd1VOTfpdcMtqxfhMdaolTY6iouAXzuN0
XmzE4iPqLvzofMpW84UbjGMJZYEQQ4dCNgO6JkIEmktdktqXlNo8hjvn+QXSBW0=
=RNtW
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
