Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] powerpc/pseries: Implement arch_get_random_long() based
 on H_RANDOM
Date: Fri, 11 Oct 2013 14:07:59 +1100
Message-Id: <1381460879-2814-3-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1381460879-2814-1-git-send-email-michael@ellerman.id.au>
References: <1381460879-2814-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the arch_get_random_long() hook based on the H_RANDOM
hypervisor call. We trust the hypervisor to provide us with random data,
ie. we don't whiten it in anyway.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/Makefile |  2 +-
 arch/powerpc/platforms/pseries/rng.c    | 44 +++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/pseries/rng.c

diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 6c61ec5..fbccac9 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -3,7 +3,7 @@ ccflags-$(CONFIG_PPC_PSERIES_DEBUG)	+= -DDEBUG
 
 obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   setup.o iommu.o event_sources.o ras.o \
-			   firmware.o power.o dlpar.o mobility.o
+			   firmware.o power.o dlpar.o mobility.o rng.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
 obj-$(CONFIG_EEH)	+= eeh_pseries.o
diff --git a/arch/powerpc/platforms/pseries/rng.c b/arch/powerpc/platforms/pseries/rng.c
new file mode 100644
index 0000000..a702f1c
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/rng.c
@@ -0,0 +1,44 @@
+/*
+ * Copyright 2013, Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt)	"pseries-rng: " fmt
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <asm/archrandom.h>
+#include <asm/machdep.h>
+
+
+static int pseries_get_random_long(unsigned long *v)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	if (plpar_hcall(H_RANDOM, retbuf) == H_SUCCESS) {
+		*v = retbuf[0];
+		return 1;
+	}
+
+	return 0;
+}
+
+static __init int rng_init(void)
+{
+	struct device_node *dn;
+
+	dn = of_find_compatible_node(NULL, NULL, "ibm,random");
+	if (!dn)
+		return -ENODEV;
+
+	pr_info("Registering arch random hook.\n");
+
+	ppc_md.get_random_long = pseries_get_random_long;
+
+	return 0;
+}
+subsys_initcall(rng_init);
-- 
1.8.1.2
