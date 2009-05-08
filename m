Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id ADA3EDDDA1
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 22:34:20 +1000 (EST)
Date: Fri, 8 May 2009 14:34:13 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] mpc5121/clocks: make debug output more readable
Message-ID: <20090508123413.GC3100@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


- Drop KERN_ levels for printks which print to the same line
- use '=3D' in output to connect key/value pairs

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: John Rigby <jcrigby@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>

---
 arch/powerpc/platforms/512x/clock.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: .kernel/arch/powerpc/platforms/512x/clock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- .kernel.orig/arch/powerpc/platforms/512x/clock.c
+++ .kernel/arch/powerpc/platforms/512x/clock.c
@@ -83,12 +83,11 @@ static void dump_clocks(void)
 	mutex_lock(&clocks_mutex);
 	printk(KERN_INFO "CLOCKS:\n");
 	list_for_each_entry(p, &clocks, node) {
-		printk(KERN_INFO "  %s %ld", p->name, p->rate);
+		printk(KERN_INFO "  %s=3D%ld", p->name, p->rate);
 		if (p->parent)
-			printk(KERN_INFO " %s %ld", p->parent->name,
-			       p->parent->rate);
+			printk(" %s=3D%ld", p->parent->name, p->parent->rate);
 		if (p->flags & CLK_HAS_CTRL)
-			printk(KERN_INFO " reg/bit %d/%d", p->reg, p->bit);
+			printk(" reg/bit=3D%d/%d", p->reg, p->bit);
 		printk("\n");
 	}
 	mutex_unlock(&clocks_mutex);

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoEJsUACgkQD27XaX1/VRuQggCgm7auPJpCpTVleUD30B86X/jW
lZsAnR91XB0YVCBp95aGyEqUU8+LXaHv
=6IcQ
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
