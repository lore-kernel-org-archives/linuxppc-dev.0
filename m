Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsxZf5RxkzF1gs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 15:46:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander.Levin@microsoft.com
Cc: stable@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	npiggin@gmail.com
Subject: [PATCH v4.1 backport 11/15] powerpc/powernv: Check device-tree for
 RFI flush settings
Date: Fri,  2 Mar 2018 15:45:45 +1100
Message-Id: <20180302044549.14930-12-mpe@ellerman.id.au>
In-Reply-To: <20180302044549.14930-1-mpe@ellerman.id.au>
References: <20180302044549.14930-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Oliver O'Halloran <oohall@gmail.com>

commit 6e032b350cd1fdb830f18f8320ef0e13b4e24094 upstream.

New device-tree properties are available which tell the hypervisor
settings related to the RFI flush. Use them to determine the
appropriate flush instruction to use, and whether the flush is
required.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powernv/setup.c | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 20974478f8d0..e3c98361e6e4 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -38,14 +38,63 @@
 #include <asm/cputhreads.h>
 #include <asm/cpuidle.h>
 #include <asm/code-patching.h>
+#include <asm/setup.h>
 
 #include "powernv.h"
 #include "subcore.h"
 
+static void pnv_setup_rfi_flush(void)
+{
+	struct device_node *np, *fw_features;
+	enum l1d_flush_type type;
+	int enable;
+
+	/* Default to fallback in case fw-features are not available */
+	type = L1D_FLUSH_FALLBACK;
+	enable = 1;
+
+	np = of_find_node_by_name(NULL, "ibm,opal");
+	fw_features = of_get_child_by_name(np, "fw-features");
+	of_node_put(np);
+
+	if (fw_features) {
+		np = of_get_child_by_name(fw_features, "inst-l1d-flush-trig2");
+		if (np && of_property_read_bool(np, "enabled"))
+			type = L1D_FLUSH_MTTRIG;
+
+		of_node_put(np);
+
+		np = of_get_child_by_name(fw_features, "inst-l1d-flush-ori30,30,0");
+		if (np && of_property_read_bool(np, "enabled"))
+			type = L1D_FLUSH_ORI;
+
+		of_node_put(np);
+
+		/* Enable unless firmware says NOT to */
+		enable = 2;
+		np = of_get_child_by_name(fw_features, "needs-l1d-flush-msr-hv-1-to-0");
+		if (np && of_property_read_bool(np, "disabled"))
+			enable--;
+
+		of_node_put(np);
+
+		np = of_get_child_by_name(fw_features, "needs-l1d-flush-msr-pr-0-to-1");
+		if (np && of_property_read_bool(np, "disabled"))
+			enable--;
+
+		of_node_put(np);
+		of_node_put(fw_features);
+	}
+
+	setup_rfi_flush(type, enable > 0);
+}
+
 static void __init pnv_setup_arch(void)
 {
 	set_arch_panic_timeout(10, ARCH_PANIC_TIMEOUT);
 
+	pnv_setup_rfi_flush();
+
 	/* Initialize SMP */
 	pnv_smp_init();
 
-- 
2.14.1
