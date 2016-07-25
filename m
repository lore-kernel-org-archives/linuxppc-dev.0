Return-Path: <haokexin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryfFs31KQzDqQ7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 21:30:56 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id h186so11803862pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 04:30:56 -0700 (PDT)
Date: Mon, 25 Jul 2016 19:30:43 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 V2 08/10] powerpc: use the jump label for
 cpu_has_feature
Message-ID: <20160725113043.GA13882@pek-khao-d1>
References: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1469265163-1491-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160725162849.57d9d495@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
In-Reply-To: <20160725162849.57d9d495@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 25, 2016 at 04:28:49PM +1000, Nicholas Piggin wrote:
> On Sat, 23 Jul 2016 14:42:41 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>=20
> > From: Kevin Hao <haokexin@gmail.com>
> >=20
> > The cpu features are fixed once the probe of cpu features are done.
> > And the function cpu_has_feature() does be used in some hot path.
> > The checking of the cpu features for each time of invoking of
> > cpu_has_feature() seems suboptimal. This tries to reduce this
> > overhead of this check by using jump label.
> >=20
> > The generated assemble code of the following c program:
> > 	if (cpu_has_feature(CPU_FTR_XXX))
> > 		xxx()
> >=20
> > Before:
> > 	lis     r9,-16230
> > 	lwz     r9,12324(r9)
> > 	lwz     r9,12(r9)
> > 	andi.   r10,r9,512
> > 	beqlr-
> >=20
> > After:
> > 	nop	if CPU_FTR_XXX is enabled
> > 	b xxx	if CPU_FTR_XXX is not enabled
> >=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/include/asm/cpufeatures.h | 21 +++++++++++++++++++++
> >  arch/powerpc/include/asm/cputable.h    |  8 ++++++++
> >  arch/powerpc/kernel/cputable.c         | 20 ++++++++++++++++++++
> >  arch/powerpc/lib/feature-fixups.c      |  1 +
> >  4 files changed, 50 insertions(+)
> >=20
> > diff --git a/arch/powerpc/include/asm/cpufeatures.h
> > b/arch/powerpc/include/asm/cpufeatures.h index
> > bfa6cb8f5629..4a4a0b898463 100644 ---
> > a/arch/powerpc/include/asm/cpufeatures.h +++
> > b/arch/powerpc/include/asm/cpufeatures.h @@ -13,10 +13,31 @@ static
> > inline bool __cpu_has_feature(unsigned long feature)
> > return !!(CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature); }
> > =20
> > +#ifdef CONFIG_JUMP_LABEL
> > +#include <linux/jump_label.h>
> > +
> > +extern struct static_key_true cpu_feat_keys[MAX_CPU_FEATURES];
> > +
> > +static __always_inline bool cpu_has_feature(unsigned long feature)
> > +{
> > +	int i;
> > +
> > +	if (CPU_FTRS_ALWAYS & feature)
> > +		return true;
> > +
> > +	if (!(CPU_FTRS_POSSIBLE & feature))
> > +		return false;
> > +
> > +	i =3D __builtin_ctzl(feature);
> > +	return static_branch_likely(&cpu_feat_keys[i]);
> > +}
>=20
> Is feature ever not-constant, or could it ever be, I wonder? We could
> do a build time check to ensure it is always constant?

In the current code, all the using of this function are passing a constant
argument. But yes, due to the implementation of jump label, we should add
a check here to ensure that a constant is passed to this function. Something
likes this:

	if (!__builtin_constant_p(feature))
		return __cpu_has_feature(feature);

We need the same change for the mmu_has_feature().

Thanks,
Kevin

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXlfhjAAoJEJNY7TDerrFxtyMH/10pgEtnQHax+ZA5xvILdttI
XC0rVRp/6CfrTL/BT5H9CvzkEFSn4PgZY9ENaOTDOErP4DBu4oj82q5d1LP3MGiB
ohxYHZFicdwPeV1ezmhcpKqfUYzq9PyxIOok9OpaepCovsNzqvgrYCqzmlM+VAlT
MLNbJQYTZIprnhBACF6zUx1rirIoC8hT3ViA0SUXLEBnqWJw1vBL03pJOC6bQ7Lt
FRz2FN9e/6S5GgPIfXj0WerWViTltbN6Rrs+fy2Ca65uIEIVdJgBnQQDc3FIBGNA
A/C6YwuEQbLKUkUi+pvc3V8ZSXnTf1QNaZVDp0+sKGkaiKc7c/NYdOU80ItEbH4=
=0+sG
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
