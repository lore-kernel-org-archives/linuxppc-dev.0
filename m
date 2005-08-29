Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 6B07568124
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Aug 2005 08:43:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 29 Aug 2005 17:43:28 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859442@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] rheap.c rh_alloc_fixed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

rh_alloc_fixed() used by cpm_dpalloc_fixed incorrectly returned next
free area=20
if the requested fixed area is not available.
This fixes it to return an error if requested area is not available.

Signed-off-by Rune Torgersen <runet@innovsys.com>

Index: linux-innsys/arch/ppc/lib/rheap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-innsys/arch/ppc/lib/rheap.c	(revision 29)
+++ linux-innsys/arch/ppc/lib/rheap.c	(working copy)
@@ -522,6 +522,10 @@
 	if (blk =3D=3D NULL)
 		return ERR_PTR(-ENOMEM);
=20
+	/* make sure block actually fits */
+	if (bs > s )=20
+		return ERR_PTR(-ENOMEM);
+
 	/* Perfect fit */
 	if (bs =3D=3D s && be =3D=3D e) {
 		/* Move from free list to taken list */
