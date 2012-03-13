Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id F1418B6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2012 16:01:10 +1100 (EST)
Date: Tue, 13 Mar 2012 16:01:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: linux-next: manual merge of the devicetree tree with the powerpc tree
Message-Id: <20120313160100.c8cc3fd2b3d1f485ef7e7954@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__13_Mar_2012_16_01_00_+1100_zyfs5ewjJ2IaWld+"
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__13_Mar_2012_16_01_00_+1100_zyfs5ewjJ2IaWld+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

Today's linux-next merge of the devicetree tree got a conflict in
include/linux/of.h between commit eb740b5f3e65 ("powerpc/eeh: Introduce
EEH device") from the powerpc tree and commit 0f22dd395fc4 ("of: Only
compile OF_DYNAMIC on PowerPC pseries and iseries") from the devicetree
tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc include/linux/of.h
index bdb1c07,533603e..0000000
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@@ -75,14 -72,10 +75,17 @@@ struct of_phandle_args=20
  	uint32_t args[MAX_PHANDLE_ARGS];
  };
 =20
 +#if defined(CONFIG_EEH)
 +static inline struct eeh_dev *of_node_to_eeh_dev(struct device_node *dn)
 +{
 +	return dn->edev;
 +}
 +#endif
 +
- #if defined(CONFIG_SPARC) || !defined(CONFIG_OF)
+ #ifdef CONFIG_OF_DYNAMIC
+ extern struct device_node *of_node_get(struct device_node *node);
+ extern void of_node_put(struct device_node *node);
+ #else /* CONFIG_OF_DYNAMIC */
  /* Dummy ref counting routines - to be implemented later */
  static inline struct device_node *of_node_get(struct device_node *node)
  {

--Signature=_Tue__13_Mar_2012_16_01_00_+1100_zyfs5ewjJ2IaWld+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPXtSMAAoJEECxmPOUX5FElNgP/0FT0pYxw7Y7rDxKxfjXPeWz
3zJ7xzzoUk9tzbIeCVlHaKjtXu1aUiHk3zGEAEYSyu7mKru7BW7SQa4SVXJy1oU5
NxzzAtqa5cbqmNoM/KvV0E5/4AUnK42WaG3lUCVjUaN0b206RDzLTdOJ4mSzt/TN
LBZ/eIuV9OhSPNLcIWwnIbdtrwtcNmGcch8Ut56lWnuQpStCFJWj1Z+lL1Fo4x4v
oJjfG0hYadWuuWZpqT8nJDOW3uvJlGDYcOMbXpu4/luXm/jHqnYc0ZrHf4/48+Gw
zpl1Hi7lptRAiYYMTEQXvqQC76GJ0V8UUK7yMS3Jmj/Gg6VhAZD9popB6ePnbir0
TrzjnCxjAA/69cCEN5/bR7jTly1UfbgsbF8CDczpZQBHNRoAsXepKgfdI43VL478
KlqrUJ+Iw+OxJ6/wT2MazdRNpvyURwlutvfWvqwzI4+heNcS/rnFnFrRho1uM4BP
gPcqTy+dQZ5V7iywfJrD7NHkrTeED1jIjo8Shh/G3XwZnLkZUu+t+8YBTzhPkyT1
PyjisHHqBWuzO4M3LVqyloduFRgs6kjAnJMqFaVO+KIEP4Fhx5UvkiPQt2BcxucU
JIHAXv+FFBHOys0N4W+NhuRp9oEkb+QTTTeR5EUsFYgndcV/rj/gvE5/UrfsvYLR
0DulTl2+GYR00vx/+lnP
=is3p
-----END PGP SIGNATURE-----

--Signature=_Tue__13_Mar_2012_16_01_00_+1100_zyfs5ewjJ2IaWld+--
