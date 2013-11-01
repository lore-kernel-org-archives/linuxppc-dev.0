Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id F2D4D2C0333
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 16:20:13 +1100 (EST)
Date: Fri, 1 Nov 2013 16:20:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robherring2@gmail.com>
Subject: linux-next: manual merge of the dt-rh tree with the powerpc tree
Message-Id: <20131101162002.4dd386299ec42e8d8d032be2@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__1_Nov_2013_16_20_02_+1100_Azk4V4sl5ProHJGI"
Cc: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>,
 linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__1_Nov_2013_16_20_02_+1100_Azk4V4sl5ProHJGI
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Today's linux-next merge of the dt-rh tree got a conflict in
arch/powerpc/include/asm/prom.h between commit a3e31b458844 ("of: Move
definition of of_find_next_cache_node into common code") from the powerpc
tree and commit 0c3f061c195c ("of: implement of_node_to_nid as a weak
function") from the dt-rh tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/powerpc/include/asm/prom.h
index bf09e5a065b8,7687f82a3217..000000000000
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@@ -44,13 -39,9 +39,6 @@@ void of_parse_dma_window(struct device_
 =20
  extern void kdump_move_device_tree(void);
 =20
- #ifdef CONFIG_NUMA
- extern int of_node_to_nid(struct device_node *device);
- #else
- static inline int of_node_to_nid(struct device_node *device) { return 0; }
- #endif
- #define of_node_to_nid of_node_to_nid
 -/* cache lookup */
 -struct device_node *of_find_next_cache_node(struct device_node *np);
--
  extern void of_instantiate_rtc(void);
 =20
  extern int of_get_ibm_chip_id(struct device_node *np);

--Signature=_Fri__1_Nov_2013_16_20_02_+1100_Azk4V4sl5ProHJGI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSczoGAAoJEMDTa8Ir7ZwVQscP/2C098l7rMl4UoyCn0cKgN1V
LZ+FIGzUZeUMwcymyPmrUZ5f0ZlnHW9ls9oOQx/ndjm1V9EXJa54YxB7Htn+Xu/I
2GQTLy461n+OT1glpWx6e4LqtKrWJuNK8e/oXl9fxvp81zvSorNnx700+wanNvM1
F4OjC8KOVg+eIsiOw6MgM27BFphod1MtoDRSHM0ilj1qeVXlTrfjcPgy7VFgd5yu
RUTna1KoSTkWtpAIjELJBxaq4g5H/JjhHGGtNEamLHe/ON45KceMU3FCehKcYvEl
8YBfRE+33ByYeKsuC4rqU8jEsBFJEKajV3y0EqpEaAeT1DTeQ2tPuQ/pZUgzTWj2
X1ii4cc+o265wcAAyEn4TOLR7kP1jwUiyGALZNQ/RDZnwuZ9UJRKgePc+A2F6UuY
VnBKDv+EldK6Ka92kofCrodIklmjQTNu5zE4+Gjdjml4m90a5G0vpeP6fgEnDRTl
hS5jlc/fstW7h9InlmIrlX5jxL4A6XNdQymfU8hV5hmS4Je6NkAnUGupjSwtqg2c
dKJHjSbLXkwXdOXd0IThdq+xm/l6HF7/3u7tMZF8lEcqajQuHM3R+xGDmCyq1xl7
Np70w9R01auNc2p8i8jvQsTrCfwEuLB82ceSAec76bV5RVnJcj0wBWJtgEroDX1K
PaEb3XAB4lValxWhd5MB
=Q0uK
-----END PGP SIGNATURE-----

--Signature=_Fri__1_Nov_2013_16_20_02_+1100_Azk4V4sl5ProHJGI--
