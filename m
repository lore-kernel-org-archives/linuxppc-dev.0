Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8BD6DDDF30
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:08:30 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/22] [POWERPC] fsl_soc.c cleanup
Date: Thu, 13 Sep 2007 16:07:46 -0500
Message-Id: <1189717691261-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1189717690413-git-send-email-galak@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
	<11897176841013-git-send-email-galak@kernel.crashing.org>
	<11897176851400-git-send-email-galak@kernel.crashing.org>
	<1189717687832-git-send-email-galak@kernel.crashing.org>
	<11897176884163-git-send-email-galak@kernel.crashing.org>
	<1189717690413-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

1. Update the way get_brgfreq() finds things in the device tree.

It now uses names that are less namespace polluting.  The old names
are supported until all boards are converted.

2. "size" is changed from unsigned int to int, to match what
of_get_property() expects.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_soc.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index f3abce1..7012e51 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -52,13 +52,13 @@ phys_addr_t get_immrbase(void)
 
 	soc = of_find_node_by_type(NULL, "soc");
 	if (soc) {
-		unsigned int size;
+		int size;
 		const void *prop = of_get_property(soc, "reg", &size);
 
 		if (prop)
 			immrbase = of_translate_address(soc, prop);
 		of_node_put(soc);
-	};
+	}
 
 	return immrbase;
 }
@@ -76,16 +76,23 @@ u32 get_brgfreq(void)
 	if (brgfreq != -1)
 		return brgfreq;
 
-	node = of_find_node_by_type(NULL, "cpm");
+	node = of_find_compatible_node(NULL, NULL, "fsl,cpm1");
+	if (!node)
+		node = of_find_compatible_node(NULL, NULL, "fsl,cpm2");
+	if (!node)
+		node = of_find_node_by_type(NULL, "cpm");
 	if (node) {
-		unsigned int size;
-		const unsigned int *prop = of_get_property(node,
-					"brg-frequency", &size);
+		int size;
+		const unsigned int *prop;
 
-		if (prop)
+		prop = of_get_property(node, "fsl,brg-frequency", &size);
+		if (!prop)
+			prop = of_get_property(node, "brg-frequency", &size);
+		if (prop && size == 4)
 			brgfreq = *prop;
+
 		of_node_put(node);
-	};
+	}
 
 	return brgfreq;
 }
@@ -103,14 +110,14 @@ u32 get_baudrate(void)
 
 	node = of_find_node_by_type(NULL, "serial");
 	if (node) {
-		unsigned int size;
+		int size;
 		const unsigned int *prop = of_get_property(node,
 				"current-speed", &size);
 
 		if (prop)
 			fs_baudrate = *prop;
 		of_node_put(node);
-	};
+	}
 
 	return fs_baudrate;
 }
-- 
1.5.2.4
