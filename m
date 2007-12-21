Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 690D7DDDEB
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 03:31:45 +1100 (EST)
Date: Fri, 21 Dec 2007 19:24:02 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] PowerPC: update 440EP(x)/440GR(x) identical PVR issue
	workaround
Message-ID: <20071221162402.GA1673@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221160723.GA1430@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 3ee133269861dc449ad5be761aa8570b1b05571f introduced
a CPU "model" property and thus broke PowerPC 440EP(x)/440GR(x)
identical PVR workaround. The patch updates it to use the new
model property for CPU identification.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/kernel/prom.c |   37 +++++++++++++++++++++++++------------
 1 files changed, 25 insertions(+), 12 deletions(-)

diff -pruN linux-2.6.orig/arch/powerpc/kernel/prom.c linux-2.6/arch/powerpc/kernel/prom.c
--- linux-2.6.orig/arch/powerpc/kernel/prom.c	2007-12-21 17:14:17.000000000 +0300
+++ linux-2.6/arch/powerpc/kernel/prom.c	2007-12-21 18:42:09.000000000 +0300
@@ -614,6 +614,29 @@ static struct feature_property {
 #endif /* CONFIG_PPC64 */
 };
 
+#if defined(CONFIG_44x) && defined(CONFIG_PPC_FPU)
+static inline void identical_pvr_fixup(unsigned long node)
+{
+	unsigned int pvr;
+	char *model = of_get_flat_dt_prop(node, "model", NULL);
+
+	/*
+	 * Since 440GR(x)/440EP(x) processors have the same pvr,
+	 * we check the node path and set bit 28 in the cur_cpu_spec
+	 * pvr for EP(x) processor version. This bit is always 0 in
+	 * the "real" pvr. Then we call identify_cpu again with
+	 * the new logical pvr to enable FPU support.
+	 */
+	if (model && strstr(model, "440EP")) {
+		pvr = cur_cpu_spec->pvr_value | 0x8;
+		identify_cpu(0, pvr);
+		DBG("Using logical pvr %x for %s\n", pvr, model);
+	}
+}
+#else
+#define identical_pvr_fixup(node) do { } while(0)
+#endif
+
 static void __init check_cpu_feature_properties(unsigned long node)
 {
 	unsigned long i;
@@ -711,18 +734,8 @@ static int __init early_init_dt_scan_cpu
 		prop = of_get_flat_dt_prop(node, "cpu-version", NULL);
 		if (prop && (*prop & 0xff000000) == 0x0f000000)
 			identify_cpu(0, *prop);
-#if defined(CONFIG_44x) && defined(CONFIG_PPC_FPU)
-		/*
-		 * Since 440GR(x)/440EP(x) processors have the same pvr,
-		 * we check the node path and set bit 28 in the cur_cpu_spec
-		 * pvr for EP(x) processor version. This bit is always 0 in
-		 * the "real" pvr. Then we call identify_cpu again with
-		 * the new logical pvr to enable FPU support.
-		 */
-		if (strstr(uname, "440EP")) {
-			identify_cpu(0, cur_cpu_spec->pvr_value | 0x8);
-		}
-#endif
+
+		identical_pvr_fixup(node);
 	}
 
 	check_cpu_feature_properties(node);
