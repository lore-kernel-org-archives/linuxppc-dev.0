Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58E4A2C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 05:56:12 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 25 Mar 2013 14:56:08 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D164F38C8042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 14:56:06 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2PIu6Q0319136
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 14:56:06 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2PIu6b9012678
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 15:56:06 -0300
Received: from [9.41.105.123] ([9.41.105.123])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2PIu62w012654
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 15:56:06 -0300
Message-ID: <51509DC5.3020007@linux.vnet.ibm.com>
Date: Mon, 25 Mar 2013 13:56:05 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/11] Update numa.c to use updated firmware_has_feature()
References: <51509AE8.8070803@linux.vnet.ibm.com>
In-Reply-To: <51509AE8.8070803@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the numa code to use the updated firmware_has_feature() when checking
for type 1 affinity.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

Index: powerpc/arch/powerpc/mm/numa.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-03-20 12:25:42.000000000 -0500
+++ powerpc/arch/powerpc/mm/numa.c	2013-03-20 12:26:29.000000000 -0500
@@ -291,9 +291,7 @@
 static int __init find_min_common_depth(void)
 {
 	int depth;
-	struct device_node *chosen;
 	struct device_node *root;
-	const char *vec5;
 
 	if (firmware_has_feature(FW_FEATURE_OPAL))
 		root = of_find_node_by_path("/ibm,opal");
@@ -325,24 +323,10 @@
 
 	distance_ref_points_depth /= sizeof(int);
 
-#define VEC5_AFFINITY_BYTE	5
-#define VEC5_AFFINITY		0x80
-
-	if (firmware_has_feature(FW_FEATURE_OPAL))
+	if (firmware_has_feature(FW_FEATURE_OPAL) ||
+	    firmware_has_feature(FW_FEATURE_TYPE1_AFFINITY)) {
+		dbg("Using form 1 affinity\n");
 		form1_affinity = 1;
-	else {
-		chosen = of_find_node_by_path("/chosen");
-		if (chosen) {
-			vec5 = of_get_property(chosen,
-					       "ibm,architecture-vec-5", NULL);
-			if (vec5 && (vec5[VEC5_AFFINITY_BYTE] &
-							VEC5_AFFINITY)) {
-				dbg("Using form 1 affinity\n");
-				form1_affinity = 1;
-			}
-
-			of_node_put(chosen);
-		}
 	}
 
 	if (form1_affinity) {
