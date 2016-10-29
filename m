Return-Path: <hkallweit1@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t5jgP55JkzDvT1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Oct 2016 01:29:21 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id 68so4715411wmz.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2016 07:29:21 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/3] powerpc/fsl_soc: improve and simplify get_brgfreq
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Message-ID: <ed65e9a4-771b-2825-d94b-1e104d835da6@gmail.com>
Date: Sat, 29 Oct 2016 16:28:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use of_property_read_u32 instead of the generic of_get_property to
simplify the code. In addition move the declaration of brgfreq
into get_brgfreq because it's private to this function.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/powerpc/sysdev/fsl_soc.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 48fc36b..d418424 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -100,23 +100,17 @@ EXPORT_SYMBOL(fsl_get_sys_freq);
 
 #if defined(CONFIG_CPM2) || defined(CONFIG_QUICC_ENGINE) || defined(CONFIG_8xx)
 
-static u32 brgfreq = -1;
-
 u32 get_brgfreq(void)
 {
+	static u32 brgfreq = -1;
 	struct device_node *node;
-	const unsigned int *prop;
-	int size;
 
 	if (brgfreq != -1)
 		return brgfreq;
 
 	node = of_find_compatible_node(NULL, NULL, "fsl,cpm-brg");
 	if (node) {
-		prop = of_get_property(node, "clock-frequency", &size);
-		if (prop && size == 4)
-			brgfreq = *prop;
-
+		of_property_read_u32(node, "clock-frequency", &brgfreq);
 		of_node_put(node);
 		return brgfreq;
 	}
@@ -129,15 +123,11 @@ u32 get_brgfreq(void)
 		node = of_find_node_by_type(NULL, "qe");
 
 	if (node) {
-		prop = of_get_property(node, "brg-frequency", &size);
-		if (prop && size == 4)
-			brgfreq = *prop;
-
-		if (brgfreq == -1 || brgfreq == 0) {
-			prop = of_get_property(node, "bus-frequency", &size);
-			if (prop && size == 4)
-				brgfreq = *prop / 2;
-		}
+		of_property_read_u32(node, "brg-frequency", &brgfreq);
+		if (brgfreq == -1 || !brgfreq)
+			if(!of_property_read_u32(node, "bus-frequency",
+			   &brgfreq))
+				brgfreq /= 2;
 		of_node_put(node);
 	}
 
-- 
2.10.1
