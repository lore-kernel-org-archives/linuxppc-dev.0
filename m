Date: Mon, 12 Aug 2002 10:42:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Beech LCD patch
Message-ID: <20020812004204.GN23642@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Could somebody please commit the following patch to
linuxppc_2_4_devel.  It fixes a bug in the Beech/405LP LCD driver.
I'd commit it myself, except me doing a push seems to break the tree
at the moment.

diff -ruN linux.orig/drivers/video/ibmlcdfb.c linux/drivers/video/ibmlcdfb.c
--- linux.orig/drivers/video/ibmlcdfb.c	Fri Aug  9 19:16:04 2002
+++ linux/drivers/video/ibmlcdfb.c	Fri Aug  9 19:15:51 2002
@@ -1218,7 +1218,8 @@
 	int ncolors;
 	const struct ibmlcdfb_info *info = (struct ibmlcdfb_info *) inf;

-	ncolors = 1 << bpp_from_par(info->gen.info.par);
+	ncolors = bpp_from_par(info->gen.info.par);
+
 	if (regno >= ncolors)
 		return -EINVAL;

@@ -1249,7 +1250,8 @@
 	int ncolors;
 	struct ibmlcdfb_info *info = (struct ibmlcdfb_info *) inf;

-	ncolors = 1 << bpp_from_par(info->gen.info.par);
+	ncolors = bpp_from_par(info->gen.info.par);
+
 	if (regno >= ncolors)
 		return -EINVAL;



--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
