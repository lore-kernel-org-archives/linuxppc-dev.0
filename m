Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHr1c4s0FzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 00:51:16 +1100 (AEDT)
Date: Thu, 19 Oct 2017 15:51:11 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, SF
 Markus Elfring <elfring@users.sourceforge.net>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] powerpc-pseries: Delete an unnecessary variable
 initialisation in iommu_pseries_alloc_group()
Message-ID: <20171019155111.1f1ac1d6@kitsune.suse.cz>
In-Reply-To: <20171019125558.itidc4ejr6goadci@mwanda>
References: <0d221be4-1402-0499-d95e-afa4a30e1f33@users.sourceforge.net>
 <9c71e3e0-8998-fd02-e3a3-ef219d82ee32@users.sourceforge.net>
 <20171019133718.5bdab33c@kitsune.suse.cz>
 <20171019125558.itidc4ejr6goadci@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 19 Oct 2017 15:55:59 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Thu, Oct 19, 2017 at 01:37:18PM +0200, Michal Such=C3=A1nek wrote:
> > Hello,
> >=20
> > On Wed, 18 Oct 2017 21:24:25 +0200
> > SF Markus Elfring <elfring@users.sourceforge.net> wrote:
> >  =20
> > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > Date: Wed, 18 Oct 2017 19:14:39 +0200
> > >=20
> > > The variable "table_group" will be set to an appropriate pointer.
> > > Thus omit the explicit initialisation at the beginning.
> > >=20
> > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > > ---
> > >  arch/powerpc/platforms/pseries/iommu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/powerpc/platforms/pseries/iommu.c
> > > b/arch/powerpc/platforms/pseries/iommu.c index
> > > b37d4fb20d1c..b6c12b8e3ace 100644 ---
> > > a/arch/powerpc/platforms/pseries/iommu.c +++
> > > b/arch/powerpc/platforms/pseries/iommu.c @@ -55,7 +55,7 @@
> > > =20
> > >  static struct iommu_table_group *iommu_pseries_alloc_group(int
> > > node) {
> > > -	struct iommu_table_group *table_group =3D NULL;
> > > +	struct iommu_table_group *table_group;
> > >  	struct iommu_table *tbl =3D NULL;
> > >  	struct iommu_table_group_link *tgl =3D NULL;
> > >   =20
> >=20
> > I think initializing pointers to NULL is generally a good idea.
> >=20
> > If there is no use of the variable before it is reinitialized by
> > allocation gcc is free to optimize out the variable and its initial
> > value.
> >=20
> > On the other hand, if the code is changed later and use of the
> > variable becomes possible you may crash (and get a gcc warning,
> > too). =20
>=20
> No, it's the opposite. GCC doesn't warn about potential NULL
> dereferences,=20

However, kernel produces runtime errors on actual NULL dereference. So
you will learn about the issue quite fast.

> it warns about uninitialized variables.  By initializing
> it to a bogus value, you're deliberately disabling static analysis.
> We do see bugs where, if only people didn't initialize stuff to bogus
> values, then the bug would have been caught before it was merged.

There are recently merged changes that cause new warnings as well.

How that can be? Perhaps #ifdefs depending on kernel configuration and
0-day not testing all possible combinations? Perhaps the compiler
getting confused by the code and only later compiler update finding the
issue?

Whatever the reason you cannot rely on compiler warnings to correct
your code. They may help you to point out issues but writing the code
in such a way that the issues are less likely to happen in the first
place is better than fixing warnings after the fact.

>=20
> You might imagine that static analysis tools would catch NULL
> dereferences but it's actually really really hard.  We used to have
> an __uninitialized_var() macro which was used to silence GCC false
> positives, but now we initialize the pointers to NULL instead.  So
> most of the code that you're dealing with is stuff that was marked as
> too hard for GCC to understand.  It's tricky.
>=20

Then it should be made easy to understand and maintain for humans since
the compilers have failed at maintaining it for us.

Thanks

Michal
