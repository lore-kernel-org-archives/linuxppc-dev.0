Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 8A94BDE107
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 00:40:23 +1000 (EST)
Date: Fri, 15 May 2009 16:40:15 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH V2] mpc5121/clocks: make debug output more readable
Message-ID: <20090515144015.GD3689@pengutronix.de>
References: <20090508123413.GC3100@pengutronix.de>
	<fa686aa40905080840x308c1addld75b1ec5df386c13@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
In-Reply-To: <fa686aa40905080840x308c1addld75b1ec5df386c13@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


- refactor printk with pr_info/pr_cont
- use '=3D' in output to connect key/value pairs

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: John Rigby <jcrigby@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>

---
 arch/powerpc/platforms/512x/clock.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: arch/powerpc/platforms/512x/clock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/powerpc/platforms/512x/clock.c.orig
+++ arch/powerpc/platforms/512x/clock.c
@@ -83,13 +83,13 @@ static void dump_clocks(void)
 	mutex_lock(&clocks_mutex);
 	printk(KERN_INFO "CLOCKS:\n");
 	list_for_each_entry(p, &clocks, node) {
-		printk(KERN_INFO "  %s %ld", p->name, p->rate);
+		pr_info("  %s=3D%ld", p->name, p->rate);
 		if (p->parent)
-			printk(KERN_INFO " %s %ld", p->parent->name,
+			pr_cont(" %s=3D%ld", p->parent->name,
 			       p->parent->rate);
 		if (p->flags & CLK_HAS_CTRL)
-			printk(KERN_INFO " reg/bit %d/%d", p->reg, p->bit);
-		printk("\n");
+			pr_cont(" reg/bit=3D%d/%d", p->reg, p->bit);
+		pr_cont("\n");
 	}
 	mutex_unlock(&clocks_mutex);
 }

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoNfs8ACgkQD27XaX1/VRtJPwCgkqhNTUXYQNbU8r29iyOAeELg
AZAAoJGMolVIfuEXMg93Lc1QRKG9pL39
=LJ0v
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--
