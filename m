Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26A981A066A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 21:12:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/6] powerpc: Add device-tree model to dump stack arch
 description
Date: Tue,  5 May 2015 21:12:14 +1000
Message-Id: <1430824337-15339-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1430824337-15339-1-git-send-email-mpe@ellerman.id.au>
References: <1430824337-15339-1-git-send-email-mpe@ellerman.id.au>
Cc: tj@kernel.org, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As soon as we know the model of the machine we're on, add it to the dump
stack arch description, which is printed in case of an oops.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 308c5e15676b..a8ac55f7bd7b 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -34,6 +34,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <linux/printk.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -642,6 +643,23 @@ static void __init early_reserve_mem(void)
 #endif
 }
 
+static int __init
+early_init_dt_scan_model(unsigned long node, const char *uname,
+			 int depth, void *data)
+{
+	const char *prop;
+
+	if (depth != 0)
+		return 0;
+
+	prop = of_get_flat_dt_prop(node, "model", NULL);
+	if (prop)
+		dump_stack_add_arch_desc(prop);
+
+	/* break now */
+	return 1;
+}
+
 void __init early_init_devtree(void *params)
 {
 	phys_addr_t limit;
@@ -652,6 +670,8 @@ void __init early_init_devtree(void *params)
 	if (!early_init_dt_verify(params))
 		panic("BUG: Failed verifying flat device tree, bad version?");
 
+	of_scan_flat_dt(early_init_dt_scan_model, NULL);
+
 #ifdef CONFIG_PPC_RTAS
 	/* Some machines might need RTAS info for debugging, grab it now. */
 	of_scan_flat_dt(early_init_dt_scan_rtas, NULL);
-- 
2.1.0
