Return-Path: <dipankar@in.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C2FDB1007DB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2011 01:38:38 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dipankar@in.ibm.com>;
 Fri, 28 Oct 2011 10:27:25 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9SEPc8d3391504
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 10:25:39 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9SEPbRK014943
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 08:25:37 -0600
Date: Fri, 28 Oct 2011 19:55:32 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: [PATCH] NUMA topology support for powernv
Message-ID: <20111028142532.GF26162@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <pmac@au1.ibm.com>
Reply-To: dipankar@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch adds support for numa topology on powernv platforms running
OPAL formware. It checks for the type of platform at run time and
sets the affinity form correctly so that NUMA topology can be discovered
correctly.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---
 arch/powerpc/mm/numa.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 0bfb90c..58f292f 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -315,7 +315,10 @@ static int __init find_min_common_depth(void)
 	struct device_node *root;
 	const char *vec5;
 
-	root = of_find_node_by_path("/rtas");
+	if (firmware_has_feature(FW_FEATURE_OPAL))
+		root = of_find_node_by_path("/ibm,opal");
+	else
+		root = of_find_node_by_path("/rtas");
 	if (!root)
 		root = of_find_node_by_path("/");
 
@@ -344,12 +347,19 @@ static int __init find_min_common_depth(void)
 
 #define VEC5_AFFINITY_BYTE	5
 #define VEC5_AFFINITY		0x80
-	chosen = of_find_node_by_path("/chosen");
-	if (chosen) {
-		vec5 = of_get_property(chosen, "ibm,architecture-vec-5", NULL);
-		if (vec5 && (vec5[VEC5_AFFINITY_BYTE] & VEC5_AFFINITY)) {
-			dbg("Using form 1 affinity\n");
-			form1_affinity = 1;
+
+	if (firmware_has_feature(FW_FEATURE_OPAL))
+		form1_affinity = 1;
+	else {
+		chosen = of_find_node_by_path("/chosen");
+		if (chosen) {
+			vec5 = of_get_property(chosen, 
+					       "ibm,architecture-vec-5", NULL);
+			if (vec5 && (vec5[VEC5_AFFINITY_BYTE] & 
+							VEC5_AFFINITY)) {
+				dbg("Using form 1 affinity\n");
+				form1_affinity = 1;
+			}
 		}
 	}
 
