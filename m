Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 3D6312C0331
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 17:30:23 +1100 (EST)
Date: Fri, 1 Nov 2013 17:30:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bryan Wu <cooloney@gmail.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: manual merge of the leds tree with the powerpc tree
Message-Id: <20131101173003.e0c6ce3749c3b6b1dd0c109e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__1_Nov_2013_17_30_03_+1100_lV_Mhy=AcuA8NU51"
Cc: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>,
 linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__1_Nov_2013_17_30_03_+1100_lV_Mhy=AcuA8NU51
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bryan,

Today's linux-next merge of the leds tree got a conflict in
include/linux/of.h between commit a3e31b458844 ("of: Move definition of
of_find_next_cache_node into common code") from the powerpc tree and
commit 954e04b9491a ("of: introduce of_get_available_child_count") from
the leds tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc include/linux/of.h
index 2567ccd32482,54c25606a997..000000000000
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@@ -228,8 -226,17 +228,19 @@@ static inline int of_get_child_count(co
  	return num;
  }
 =20
+ static inline int of_get_available_child_count(const struct device_node *=
np)
+ {
+ 	struct device_node *child;
+ 	int num =3D 0;
+=20
+ 	for_each_available_child_of_node(np, child)
+ 		num++;
+=20
+ 	return num;
+ }
+=20
 +/* cache lookup */
 +extern struct device_node *of_find_next_cache_node(const struct device_no=
de *);
  extern struct device_node *of_find_node_with_property(
  	struct device_node *from, const char *prop_name);
  #define for_each_node_with_property(dn, prop_name) \

--Signature=_Fri__1_Nov_2013_17_30_03_+1100_lV_Mhy=AcuA8NU51
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSc0p7AAoJEMDTa8Ir7ZwVl/8QAJWtuhVg8uOAN7G7iF1eGduD
ozXSY7MvHBARyJStAQXxh78MdtBFBO+Di1sCz3Jkw/qxQByMv9mMCzk4yt0X18nh
HI+NGztvW1rIhv/GyWyi2KyWzBzn7ohnD5TNLHUPeyn9DU380uaN9jbRD84OBPdq
F253svnKv2ct6O9336uFUN3H1Q53HJQoDOv2aSc/g3WXzSydBqm21g+zIV87QbyG
fNKObJw56yBsluUk5nYo1P5cUGLAkkklafy5PVIKxyulOgro/lIC9ckrNNd8BuD0
0Ir2PSwdCUOxHLDZgide+70LM0uF39DOCFAWBtDp0XY2bBGhkiRLOgHk7wlFC3SG
Iy/7J/6bvrGVNu/QdNsmZi9MK7nslxYCOU14iRYEWRAoNLe9ctATz0hrOj4l037g
Nl/IbzeBvbdb6wuE7uxLUfpbMY+7KxP9vDxDL/2OTiROz/wthHlo4KYi7ga6guen
JoWHKBegPyBzGPclLWEpmfHfmgZ7quZHOtN5Nv8IPbbz4/N9Ci7MsipROyyIoO0m
E7RNmuEr8b9Q7F7hYYoxLlmI3q5lHtdS7sgOkYBZ9KSsXHCCyeW5B4oQ9epeMPO9
c+RQBPAX2vpTWrZa7Sjxr2JOKfVaG4EYyPbjyesysqcYWFCmZc3+yDQap3YuOKTn
u+L9kywvQX7yXyfvDJ33
=0lYh
-----END PGP SIGNATURE-----

--Signature=_Fri__1_Nov_2013_17_30_03_+1100_lV_Mhy=AcuA8NU51--
