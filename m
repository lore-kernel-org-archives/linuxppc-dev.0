Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 7CECBB6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2012 14:34:59 +1000 (EST)
Date: Thu, 3 May 2012 14:34:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/windfarm: fix compiler warning
Message-Id: <20120503143452.4231b1cc17101df8e0772b95@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__3_May_2012_14_34_52_+1000_y+siRNjPp__GuYCK"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__3_May_2012_14_34_52_+1000_y+siRNjPp__GuYCK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fixes this warning:

drivers/macintosh/windfarm_pm91.c: In function 'wf_smu_cpu_fans_tick':
drivers/macintosh/windfarm_pm91.c:237:2: warning: passing argument 1 of 'wf=
_sensor_get' from incompatible pointer type
drivers/macintosh/windfarm.h:124:19: note: expected 'struct wf_sensor *' bu=
t argument is of type 'struct wf_sensor **'

Introduced by commit 33e6820b767a ("powerpc/windfarm: Add useful
accessors").

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/macintosh/windfarm_pm91.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_pm91.c b/drivers/macintosh/windfarm=
_pm91.c
index e18002b..7653603 100644
--- a/drivers/macintosh/windfarm_pm91.c
+++ b/drivers/macintosh/windfarm_pm91.c
@@ -234,7 +234,7 @@ static void wf_smu_cpu_fans_tick(struct wf_smu_cpu_fans=
_state *st)
 		return;
 	}
=20
-	rc =3D wf_sensor_get(&sensor_cpu_power, &power);
+	rc =3D wf_sensor_get(sensor_cpu_power, &power);
 	if (rc) {
 		printk(KERN_WARNING "windfarm: CPU power sensor error %d\n",
 		       rc);
--=20
1.7.10.280.gaa39

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__3_May_2012_14_34_52_+1000_y+siRNjPp__GuYCK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPogrsAAoJEECxmPOUX5FEF2kP+wfjpZ0kf4ZidMxhlLcalwHX
jrt6l2e4izw7t2WLSK9YX5SOJdCxI7FRV1EH4zF9rDD6H4zSdFjezPStWVHpiuEE
LXDSOWI6aOATqTP//NF8g9uAoUGESlIkOcXljsK/TAfz/rpw9pzA4r5vtqeuSbvi
sIOEw+w14yYVBPuYA3w+OaYmG7pY2G5tDBz9IC5WWHiGHzAtksY4/LJjS6q8FjfS
g8rOQyn48AMTWTLl+JNv5OdjtBhFVaOfzv3Ou/cpIDPKIr0kTUfDjcyREJweU195
4hZngCEpOdD5n0UVCvf5OsaozZLMuqwaGPFAn/1tcMsEa6d6WQ/Qs4GcYsutTk0Z
gWR8+JfWkdFDqVbE0MNuKuIupZ8u0MHytahC8afIt+1WY3r+uxI1iB2sKJ/DSYUF
35TDqybaB7+VT6iCwv3VLkarUSNqjXapYFt5SrrLhDsYVX/CgxRFZ/Kg2QeE9gP1
LTH0v90GaW3cGe32yifXK9fPHQFgibMxPWfu3H4IHHL/DNKyrw5XdjPrUld7kptg
7YTdWi8X9cjWAC4SfA2mj0XSLucBEJrptCkb+ngecJwomzZyExV5nw+KzA9iw9J/
F51JaMkD2gijjYAUGHz41YQjY0PxV5e5f+o76DWFsuHl6pDzSvs/YFUN8jEKY7eI
HMYHd9wSvPyvFwnjY1y7
=rHJq
-----END PGP SIGNATURE-----

--Signature=_Thu__3_May_2012_14_34_52_+1000_y+siRNjPp__GuYCK--
