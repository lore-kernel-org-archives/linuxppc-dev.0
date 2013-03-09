Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8AA62C036D
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Mar 2013 15:03:39 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 8 Mar 2013 21:03:37 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id CBF903E4003E
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 21:03:23 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2943X0X122036
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:03:33 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2943XA4018962
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:03:33 -0700
Received: from [9.76.31.13] (sig-9-76-31-13.mts.ibm.com [9.76.31.13])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2943W93018924
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:03:33 -0700
Message-ID: <513AB494.5020701@linux.vnet.ibm.com>
Date: Fri, 08 Mar 2013 22:03:32 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/11] Update numa.c to use platform_has_feature()
References: <513AB2E3.6090209@linux.vnet.ibm.com>
In-Reply-To: <513AB2E3.6090209@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the numa code to use the new platform_has_feature() when checking
for type 1 affinity.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

Index: powerpc/arch/powerpc/mm/numa.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-03-08 19:23:06.000000000 -0600
+++ powerpc/arch/powerpc/mm/numa.c	2013-03-08 19:57:27.000000000 -0600
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
+	    platform_has_feature(OV5_TYPE1_AFFINITY)) {
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
