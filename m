Return-Path: <hkallweit1@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t5jgQ06SHzDvT4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Oct 2016 01:29:22 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id 68so4715480wmz.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2016 07:29:21 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 3/3] powerpc/fsl_soc: improve and simplify get_baudrate
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Message-ID: <ffb03bdf-91a3-a2f0-b969-7167d3a8b6cd@gmail.com>
Date: Sat, 29 Oct 2016 16:29:04 +0200
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
simplify the code. In addition move the declaration of fs_baudrate
into get_baudrate because it's private to this function.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/powerpc/sysdev/fsl_soc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index d418424..0c542f1 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -136,10 +136,9 @@ u32 get_brgfreq(void)
 
 EXPORT_SYMBOL(get_brgfreq);
 
-static u32 fs_baudrate = -1;
-
 u32 get_baudrate(void)
 {
+	static u32 fs_baudrate = -1;
 	struct device_node *node;
 
 	if (fs_baudrate != -1)
@@ -147,12 +146,7 @@ u32 get_baudrate(void)
 
 	node = of_find_node_by_type(NULL, "serial");
 	if (node) {
-		int size;
-		const unsigned int *prop = of_get_property(node,
-				"current-speed", &size);
-
-		if (prop)
-			fs_baudrate = *prop;
+		of_property_read_u32(node, "current-speed", &fs_baudrate);
 		of_node_put(node);
 	}
 
-- 
2.10.1
