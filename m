Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9Yqv2zmqzDr6W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 15:49:47 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id vy10so915549pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 22:49:47 -0700 (PDT)
Date: Fri, 12 Aug 2016 13:49:34 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] powerpc: populate the default bus with
 machine_arch_initcall
Message-ID: <20160812054934.GJ17275@pek-khao-d1>
References: <1470913781-9204-1-git-send-email-haokexin@gmail.com>
 <87k2fmtxbv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8tZVdKiiYitVG083"
In-Reply-To: <87k2fmtxbv.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8tZVdKiiYitVG083
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2016 at 02:39:32PM +1000, Michael Ellerman wrote:
> Kevin Hao <haokexin@gmail.com> writes:
>=20
> > With the commit 44a7185c2ae6 ("of/platform: Add common method to
> > populate default bus"), a default function is introduced to populate
> > the default bus and this function is invoked at the arch_initcall_sync
> > level. This will override the arch specific population of default bus
> > which run at a lower level than arch_initcall_sync. Since not all
> > powerpc specific buses are added to the of_default_bus_match_table[],
> > this causes some powerpc specific bus are not probed. Fix this by
> > using a more preceding initcall.
> >
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> > Of course we can adjust the powerpc arch codes to use the
> > of_platform_default_populate_init(), but it has high risk to break
> > other boards given the complicated powerpc specific buses. So I would
> > like just to fix the broken boards in the current release, and cook=20
> > a patch to change to of_platform_default_populate_init() for linux-next.
> >
> > Only boot test on a mpc8315erdb board.
> >
> >  arch/powerpc/platforms/40x/ep405.c               | 2 +-
> >  arch/powerpc/platforms/40x/ppc40x_simple.c       | 2 +-
> >  arch/powerpc/platforms/40x/virtex.c              | 2 +-
> >  arch/powerpc/platforms/40x/walnut.c              | 2 +-
> >  arch/powerpc/platforms/44x/canyonlands.c         | 2 +-
> >  arch/powerpc/platforms/44x/ebony.c               | 2 +-
> >  arch/powerpc/platforms/44x/iss4xx.c              | 2 +-
> >  arch/powerpc/platforms/44x/ppc44x_simple.c       | 2 +-
> >  arch/powerpc/platforms/44x/ppc476.c              | 2 +-
> >  arch/powerpc/platforms/44x/sam440ep.c            | 2 +-
> >  arch/powerpc/platforms/44x/virtex.c              | 2 +-
> >  arch/powerpc/platforms/44x/warp.c                | 2 +-
> >  arch/powerpc/platforms/82xx/ep8248e.c            | 2 +-
> >  arch/powerpc/platforms/82xx/km82xx.c             | 2 +-
> >  arch/powerpc/platforms/82xx/mpc8272_ads.c        | 2 +-
> >  arch/powerpc/platforms/82xx/pq2fads.c            | 2 +-
> >  arch/powerpc/platforms/83xx/mpc831x_rdb.c        | 2 +-
> >  arch/powerpc/platforms/83xx/mpc834x_itx.c        | 2 +-
> >  arch/powerpc/platforms/85xx/ppa8548.c            | 2 +-
> >  arch/powerpc/platforms/8xx/adder875.c            | 2 +-
> >  arch/powerpc/platforms/8xx/ep88xc.c              | 2 +-
> >  arch/powerpc/platforms/8xx/mpc86xads_setup.c     | 2 +-
> >  arch/powerpc/platforms/8xx/mpc885ads_setup.c     | 2 +-
> >  arch/powerpc/platforms/8xx/tqm8xx_setup.c        | 2 +-
> >  arch/powerpc/platforms/cell/setup.c              | 2 +-
> >  arch/powerpc/platforms/embedded6xx/gamecube.c    | 2 +-
> >  arch/powerpc/platforms/embedded6xx/linkstation.c | 2 +-
> >  arch/powerpc/platforms/embedded6xx/mvme5100.c    | 2 +-
> >  arch/powerpc/platforms/embedded6xx/storcenter.c  | 2 +-
> >  arch/powerpc/platforms/embedded6xx/wii.c         | 2 +-
> >  arch/powerpc/platforms/pasemi/setup.c            | 2 +-
>=20
> That's not a very minimal fix.
>=20
> Every one of those initcall changes could be introducing a bug, by
> changing the order vs other init calls.
>=20
> Can we just go back to the old behaviour on ppc?

Sure. How about this one?

=46rom 4362b4cdd8a6198df4cc46c628473f0d44e03fa8 Mon Sep 17 00:00:00 2001
=46rom: Kevin Hao <haokexin@gmail.com>
Date: Fri, 12 Aug 2016 13:30:03 +0800
Subject: [PATCH v2] of/platform: disable the
 of_platform_default_populate_init() for all the ppc boards

With the commit 44a7185c2ae6 ("of/platform: Add common method to
populate default bus"), a default function is introduced to populate
the default bus and this function is invoked at the arch_initcall_sync
level. But a lot of ppc boards use machine_device_initcall() to
populate the default bus. This means that the default populate function
has higher priority and would override the arch specific population of
the bus. The side effect is that some arch specific bus are not probed,
then cause various malfunction due to the miss of some devices. Since
it is very possible to introduce bugs if we simply change the initcall
level for all these boards(about 30+). This just disable this default
function for all the ppc boards.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/of/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 8aa197691074..f39ccd5aa701 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -497,6 +497,7 @@ int of_platform_default_populate(struct device_node *ro=
ot,
 }
 EXPORT_SYMBOL_GPL(of_platform_default_populate);
=20
+#ifndef CONFIG_PPC
 static int __init of_platform_default_populate_init(void)
 {
 	struct device_node *node;
@@ -521,6 +522,7 @@ static int __init of_platform_default_populate_init(voi=
d)
 	return 0;
 }
 arch_initcall_sync(of_platform_default_populate_init);
+#endif
=20
 static int of_platform_device_destroy(struct device *dev, void *data)
 {
--=20
2.8.1

Thanks,
Kevin

--8tZVdKiiYitVG083
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXrWNuAAoJEJNY7TDerrFxxi0H/0QnPXbbSy2IXvKpZrQjqap4
pjXA3GIVljY3mhNJ11sINdeEHCmK+GQJrA2lTt/q2HCCUL6h01JkGPnloDe3otOh
9yhrKjqErbTn4w7CBVWlWSAsZzq1kTK9p+OYyJTSiuvEdbvSux9QlTWowvsZoR18
yPymWaNA+xj0iGfdwidPcS5+d16Qhdne5jyHCz9E5jc092bBTt1iVPF2cHPgCaDO
kCo7Fm1G53T4YmRKBqjXvLRogsHk8DBw6Fhh5oE6uDDqyJJbuJ9MJDV0IJgWNy0o
CLobBUrYaegfJ+awcoGOIGq6AurXpb+RxZse0f5r/ZkPLUNzz5elubVtW+4/cTw=
=Xvfo
-----END PGP SIGNATURE-----

--8tZVdKiiYitVG083--
