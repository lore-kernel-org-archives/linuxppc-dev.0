Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id AC374B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2012 16:19:51 +1000 (EST)
Date: Thu, 3 May 2012 16:19:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/windfarm: don't pass const strings to snprintf
Message-Id: <20120503161943.7d71d02e7d0aae6b9c0306bf@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__3_May_2012_16_19_43_+1000_dUfjXYtQ1ATA1OJA"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__3_May_2012_16_19_43_+1000_dUfjXYtQ1ATA1OJA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fixes these build warnings:

drivers/macintosh/windfarm_smu_sat.c: In function 'wf_sat_probe':
drivers/macintosh/windfarm_smu_sat.c:290:3: warning: passing argument 1 of =
'snprintf' discards qualifiers from pointer target type
include/linux/kernel.h:323:5: note: expected 'char *' but argument is of ty=
pe 'const char *'
drivers/macintosh/windfarm_smu_sat.c:317:3: warning: passing argument 1 of =
'snprintf' discards qualifiers from pointer target type
include/linux/kernel.h:323:5: note: expected 'char *' but argument is of ty=
pe 'const char *'

Introduced by commit e074d08e2b98 ("powerpc/windfarm: const'ify and add
"priv" field to controls & sensors").

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/macintosh/windfarm_smu_sat.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windf=
arm_smu_sat.c
index 72dfe19..e2989ce 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -287,7 +287,7 @@ static int wf_sat_probe(struct i2c_client *client,
 		sens->sat =3D sat;
 		sens->sens.ops =3D &wf_sat_ops;
 		sens->sens.name =3D (char *) (sens + 1);
-		snprintf(sens->sens.name, 16, "%s-%d", name, cpu);
+		snprintf((char *)sens->sens.name, 16, "%s-%d", name, cpu);
=20
 		if (wf_register_sensor(&sens->sens))
 			kfree(sens);
@@ -314,7 +314,7 @@ static int wf_sat_probe(struct i2c_client *client,
 		sens->sat =3D sat;
 		sens->sens.ops =3D &wf_sat_ops;
 		sens->sens.name =3D (char *) (sens + 1);
-		snprintf(sens->sens.name, 16, "cpu-power-%d", cpu);
+		snprintf((char *)sens->sens.name, 16, "cpu-power-%d", cpu);
=20
 		if (wf_register_sensor(&sens->sens))
 			kfree(sens);
--=20
1.7.10.280.gaa39

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__3_May_2012_16_19_43_+1000_dUfjXYtQ1ATA1OJA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPoiN/AAoJEECxmPOUX5FEZnsP/38gdtCQVtGRBBIh4tdQEfqL
FdkHCq2pdBONWYxd5031CwmBVP1+Oc1jkOYK4EDTvYmaLWNpWy6HzCAO/+5t1H9T
Cf9KXxo9yKPWA2GRkSsjcA/s41JyO1zUa3LyH0gz4kbdQ+dkIdrBaEurC6fSh4wJ
tgtOOYfHp9sRMOfKnyy/2BcIsgzVHye2a1A4P5fq8RKTIkuFwUGaJpsTuccQhEV2
5yz9/fOWD9Vgu6MF063bMR9tbqCojPKaNAXY6kJl1zq0zWMtDu2rRZoREB+pL/DD
++fB5F5x/ZRWmfMawDZgg0tsf57as47cJNUyUbm3VrfOZF4K2tf2yViPH+q1RAWd
ceIMD4vPZ7+jmVnSE0rGq8zs8KkrIV9bE6G1aApHyIgNPwFXXMGhsZUSAAjVbCvL
EuscOxUDXaMTmxjpY0uhE+mlTmBU5zXGbJSgVbGxJp+e8u0yMbFh1/8EdX+ht827
AkOhuIIG8croDzQQy0BGsOJK1mxihFexdgMD3yre2JHC5+5rgMaGtj6kNZ14Iv0D
utzgkxVgyquVHfO/4ioMRuInlFYdoMGmLz/xKOILmr/jfVFhw8wZslk8AAf+Cd2k
ldG9XgjRFmx/W3bDibdx/Nhr8pzCW0F2eT/5+AmhSTV1b9Ex4YjdJiXWKw/8ZvN+
QaLyj6OUoIHv36Mz6Kj9
=ceUc
-----END PGP SIGNATURE-----

--Signature=_Thu__3_May_2012_16_19_43_+1000_dUfjXYtQ1ATA1OJA--
